// // naardManagement.YardManagement;
// // using System.Automation;
// // using Microsoft.Sales.Customer;mespace Y

// codeunit 51000 "Custom Workflow Mgmt"
// {
//     var
//     procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
//     begin
//         if not WorkflowMgt.CanExecuteWorkflow(RecRef, GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef)) then
//             Error(NoWorkflowEnabledErr);
//         exit(true);
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
//     begin
//     end;

//     procedure GetWorkflowCode(WorkflowCode: code[128]; TableName: Text): Code[128]
//     begin
//         exit(DelChr(StrSubstNo(WorkflowCode, TableName, '=', ' ')));
//     end;

//     procedure GetWorkflowCode(WorkflowCode: code[128]; RecRef: RecordRef): Code[128]
//     begin
//         exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name, '=', ' ')));
//     end;
   

//     // !add events to library
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
//     local procedure OnAddWorkflowEventsToLibrary()
//     var
//         WorkflowEventHandling: Codeunit "Workflow Event Handling";
//         CarReceivHeader: Record "Car Recieving Header";
//     begin
//         WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName), DATABASE::"Car Recieving Header",
//         //? WorkflowS,endForApprovalEventDescTxt,0,FALSE);

//          GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, CarReceivHeader.TableName), 0, FALSE);
//         WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), DATABASE::"Car Recieving Header",
//           GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt,CarReceivHeader.TableName), 0, FALSE);
//     end;

//     //! subscribe

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", OnSendWorkflowForApproval, '', false, false)]
//     local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
//     begin
//         WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, RecRef), RecRef);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Workflow Mgmt", OnCancelWorkflowForApproval, '', false, false)]
//     local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
//     begin
//         WorkflowMgt.HandleEvent(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, RecRef), RecRef);
//     end;


//     procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
//     begin
//         exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));

//     end;    
//     procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; TableName: Text): Text
//     begin
//         exit(StrSubstNo(WorkflowEventDesc, TableName));

//     end;

//     //!  handle document
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
//     local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             Database::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::Created);
//                     CarReceivingHeader.Modify(true);
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
//     local procedure OnSetStatusToPendingApproval( RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             Database::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::"Pending Approval");
//                     CarReceivingHeader.Modify(true);
//                     Variant := CarReceivingHeader;
//                     IsHandled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
//     local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             Database::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     ApprovalEntryArgument."Document No." := CarReceivingHeader."No";
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
//     local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             Database::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::Approved);
//                     CarReceivingHeader.Modify(true);
//                     Handled := true;
//                 end;
//         end;

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
//     local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
//     var
//         RecRef: RecordRef;
//         CarReceivingHeader: Record "Car Recieving Header";
//     // v: Codeunit "Record Restriction Mgt.";
//     begin
//         RecRef.Get(ApprovalEntry."Record ID to Approve");
//         case RecRef.Number of
//             Database::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     if CarReceivingHeader.Get(ApprovalEntry."Document No.") then begin
//                         CarReceivingHeader.Validate(CarReceivingHeader.Status, CarReceivingHeader.Status::Rejected);
//                         CarReceivingHeader.Modify(true)
//                     end;
//                 end;
//         end;

//     end;

//     //! subscriibe to event predecessor

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
//     local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
//     var
//         RecRef: RecordRef;
//         CarReceivHeader: Record "Car Recieving Header";
  
//     begin
//         case EventFunctionName of
//             GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName):
//                 begin
//                     WorkflowEventHandling.AddEventPredecessor(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName));
//                 END;
//             GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName):
//                 begin
//                     WorkflowEventhandling.AddEventPredecessor(GetWorkflowCode(RUNWORKFLOWONCANCELFORAPPROVALCODE, CarReceivHeader.TableName), GetWorkflowCode(RUNWORKFLOWONSENDFORAPPROVALCODE, CarReceivHeader.TableName));

//                 end;
//         end;
//     end;
    

//     var
//         WorkflowMgt: Codeunit "Workflow Management";
//         WorkflowEventhandling: Codeunit "Workflow Event Handling";
//         RUNWORKFLOWONSENDFORAPPROVALCODE: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
//         RUNWORKFLOWONCANCELFORAPPROVALCODE: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
//         NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
//         WorkflowSendForApprovalEventDescTxt: Label 'Approval of Car Receiving Header is requested.';
//         WorkflowCancelForApprovalEventDescTxt: Label 'Approval of a  Car Receiving Header is cancelled.';



// }
