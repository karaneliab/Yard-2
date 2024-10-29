// codeunit 51002 "Approval workflow"
// {

//     procedure CheckCarApprovalsWorkflowEnabled(var CarReceivingHeader: Record "Car Recieving Header"): Boolean
//     begin
//         if not IsCarWorkflowEnabled(CarReceivingHeader) then
//             Error(NoWorkflowEnabledErr);
//              Message('Workflow can proceed for Car Receiving Header %1', CarReceivingHeader."No");

//         exit(true)
//     end;

//     // procedure IsCarWorkflowEnabled(var CarReceivingHeader: Record "Car Recieving Header"): Boolean
//     // begin
//     //     Message('This is reached');
//     //     exit(WorkFlowManagement.CanExecuteWorkflow(CarReceivingHeader, WorkflowEventHandling.RunWorkflowOnSendCarForApprovalCode()));
//     //     Message('This is reached after execution');
//     // end;
// !    procedure IsCarWorkflowEnabled(var CarReceivingHeader: Record "Car Recieving Header"): Boolean
//     var
//         canExecute: Boolean;
//     begin
//         Message('Checking if workflow can be executed');

//         canExecute := WorkFlowManagement.CanExecuteWorkflow(CarReceivingHeader, WorkflowEventHandling.RunWorkflowOnSendCarForApprovalCode());
//         Message('Can Execute Workflow: %1', Format(canExecute));
//         if not canExecute then
//             Error('The workflow for sending Car Receiving Header approval cannot be executed.');

//         exit(canExecute);
//     end;

// !    [IntegrationEvent(false, false)]
//     procedure OnSendCarWorkflowForApproval(var CarReceivingHeader: Record "Car Recieving Header")
//     begin

//     end;

// !    [IntegrationEvent(false, false)]
//     procedure OnCancelCarWorkflowForApproval(var CarReceivingHeader: Record "Car Recieving Header")
//     begin
//     end;

// !    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
//     local procedure OnSetCarStatusToPendingApprovale(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             DATABASE::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::"Pending Approval");
//                     CarReceivingHeader.Modify(true);
//                     IsHandled := true;
//                     Message('This is OnSetCarStatusToPendingApprovale');
//                 end;
//         end;
//     end;

// !    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
//     local procedure OnPopulateCarApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case RecRef.Number of
//             DATABASE::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     ApprovalEntryArgument."Document No." := CarReceivingHeader.No

//                 end;
//         end;
//     end;

// !    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
//     local procedure OnRejectCarApprovalRequest(var ApprovalEntry: Record "Approval Entry")
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//          
//     begin
//         Recref.Get(ApprovalEntry."Record ID to Approve");
//         case
//           Recref.Number of
//             DATABASE::"Car Recieving Header":
//                 begin
//                     Recref.SetTable(CarReceivingHeader);
//                     if CarReceivingHeader.Get(ApprovalEntry."Document No.") then begin
//                         CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::Rejected);
//                         CarReceivingHeader.Modify(true);

//                     end;
//                 end;
//         end;
//     end;






//     var
//         WorkFlowManagement: Codeunit "Workflow Management";
//         WorkflowEventHandling: Codeunit workfflowEventHandling;
//         NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
// }
