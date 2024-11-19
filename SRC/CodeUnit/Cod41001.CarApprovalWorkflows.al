codeunit 41001 "Car Approval Workflows"
{
    procedure CheckCarReceivingApprovalsWorkflowEnabled(var Recref: RecordRef): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(Recref, RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, Recref)) then
            Error(NoWorkflowEnabledErr);
        exit(true)
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendCarReceivingWorkflowForApproval(var RecRef: RecordRef)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelCarReceivingWorkflowForApproval(var RecRef: RecordRef)
    begin

    end;


    procedure RunWorkflowOnCarReceivingForApprovalCode(WorkflowCode: code[128]; TableName: Text): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, TableName, '=', ' ')))
    end;

    procedure RunWorkflowOnCarReceivingForApprovalCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name, '=', ' ')))
    end;

    //* EVENT DESCRIPTION
    procedure GetCarReceivingWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));

    end;

    procedure GetCarReceivingWorkflowEventDesc(WorkflowEventDesc: Text; TableName: Text): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, TableName));

    end;

    //* Handle Event
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Car Approval Workflows", OnSendCarReceivingWorkflowForApproval, '', false, false)]
    local procedure RunOnSendCarReceivingWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Car Approval Workflows", OnCancelCarReceivingWorkflowForApproval, '', false, false)]
    local procedure RunOnCancelCarReceivingWorkflowForApprovall(var RecRef: RecordRef)
    begin
        WorkflowMgt.HandleEvent(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
    end;

    //* OnOpenDocument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure RunCarReceivingOnOpenDocument(var Handled: Boolean; RecRef: RecordRef)
    var
        CarReciv: Record "Car Recieving Header";
    begin
        case RecRef.Number of
            Database::"Car Recieving Header":
                begin
                    RecRef.SetTable(CarReciv);
                    CarReciv.Validate(Status, CarReciv.Status::Created);
                    CarReciv.Modify(true);
                    Handled := true
                end;
        end;
    end;

    //* OnReleaseDocument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure RunCarReceivingOnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CarReciv: Record "Car Recieving Header";
    begin
        case RecRef.Number of
            Database::"Car Recieving Header":
                begin
                    RecRef.SetTable(CarReciv);
                    // RecRef.GetTable(CarReciv);
                    CarReciv.Validate(Status, CarReciv.Status::Approved);
                    CarReciv.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    //* OnSetStatusToPendingApproval
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', FALSE, false)]
    local procedure RunCarReceivingOnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var
        CarReciv: Record "Car Recieving Header";
    begin
        case RecRef.Number of
            Database::"Car Recieving Header":
                begin
                    RecRef.SetTable(CarReciv);
                    CarReciv.Validate(Status, CarReciv.Status::"Approved");
                    CarReciv.Modify(true);
                    IsHandled := true;
                    Variant := CarReciv
                end;
        end;
    end;

    //*OnPopulate Approval Entry argument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure RunCarReceivingOnPopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        CarReciv: Record "Car Recieving Header";
    begin
        case
            RecRef.Number of
            Database::"Car Recieving Header":
                begin
                    RecRef.SetTable(CarReciv);
                    ApprovalEntryArgument."Document No." := CarReciv.No;
                end;
        end;
    end;


    //*OnrejectApproval Request
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure RunCarReceivingOnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        CarReceivingHeader: Record "Car Recieving Header";
    begin
        case
         RecRef.Number of
            Database::"Car Recieving Header":
                begin
                    RecRef.SetTable(CarReceivingHeader);
                    if CarReceivingHeader.Get(ApprovalEntry."Document No.") then
                        CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::Rejected);
                    CarReceivingHeader.Modify(true);
                end;
        end;
    end;

    //* OnAddEventsToLibrary

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        CarReceivHeader: Record "Car Recieving Header";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName), Database::"Car Recieving Header",
        GetCarReceivingWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, CarReceivHeader.TableName), 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), Database::"Car Recieving Header",
        GetCarReceivingWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, CarReceivHeader.TableName), 0, false);
    end;


    //*OnAddWorkflowEventPredecessorsToLibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        RecRef: RecordRef;
        CarReceivHeader: Record "Car Recieving Header";
    begin
        case EventFunctionName of
            RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName):
                begin
                    WorkflowEventhandling.AddEventPredecessor(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName));
                end;
            RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName):
                begin
                    WorkflowEventhandling.AddEventPredecessor(RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), RunWorkflowOnCarReceivingForApprovalCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName));
                end;
        end;
    end;










    var
        WorkflowMgt: Codeunit "Workflow Management";
        WorkflowEventhandling: Codeunit "Workflow Event Handling";
        RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of Car Receiving Header is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of a  Car Receiving Header is cancelled.';

}
