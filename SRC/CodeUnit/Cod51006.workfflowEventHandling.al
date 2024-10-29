// codeunit 51006 workfflowEventHandling
// {
//     procedure RunWorkflowOnSendCarForApprovalCode(): Code[128]
//     begin
//         Message('it processes this');
//         exit(StrSubstNo(UpperCase('RunWorkflowOnSendCarForApprovalRequest')));
//         // Message('it processes this there after');
//     end;

//     procedure RunWorkflowOnCancelCarForApprovalCode(): Code[128]
//     begin
//         exit(StrSubstNo(UpperCase('RunWorkflowOnCancelCarForApprovalRequest')))
//     end;



//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval workflow", OnSendCarWorkflowForApproval, '', false, false)]
//     local procedure RunWorkflowOnSendCarForApprovalRequest(var CarReceivingHeader: Record "Car Recieving Header")
//     var
//         eventHandled: Boolean;
//     begin

//         // WorkflowManagement.HandleEvent(RunWorkflowOnSendCarForApprovalCode(), CarReceivingHeader);
//         Message('Handle event is not reached for Car Receiving Header: %1', CarReceivingHeader."No");
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendCarForApprovalCode(), CarReceivingHeader);
//         Message('Handle event is reached for Car Receiving Header: %1', CarReceivingHeader."No");
//     end;




//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval workflow", OnCancelCarWorkflowForApproval, '', false, false)]
//     local procedure RunWorkflowOnCancelCarForApprovalRequest(var CarReceivingHeader: Record "Car Recieving Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelCarForApprovalCode(), CarReceivingHeader);

//     end;



//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
//     local procedure OnAddCarWorkflowEventsToLibrary()
//     var
//         workflowEventHandling: Codeunit "Workflow Event Handling";
//         CarReceivingHeader: Record "Car Recieving Header";

//     begin
//         workflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCarForApprovalCode(), Database::"Car Recieving Header", WorkflowSendForCarApprovalEventDescTxt, 0, false);
//         workflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCarForApprovalCode(), Database::"Car Recieving Header", WorkflowCancelForCarApprovalEventDescTxt, 0, false);
//     end;



//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
//     local procedure OnAddCarWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
//     var
//         workflowEventHandling: Codeunit "Workflow Event Handling";
//         CarReceivingHeader: Record "Car Recieving Header";

//     begin
//         case EventFunctionName of
//             RunWorkflowOnCancelCarForApprovalCode():
//                 workflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCarForApprovalCode, RunWorkflowOnSendCarForApprovalCode);
//             RunWorkflowOnSendCarForApprovalCode():
//                 workflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCarForApprovalCode, RunWorkflowOnSendCarForApprovalCode);
//         end;
//     end;



//     var
//          
//         WorkflowSendForCarApprovalEventDescTxt: Label 'Approval for %1 of Car Receiving Header is Requested.';
//         WorkflowCancelForCarApprovalEventDescTxt: Label 'Approval for  %2  of Car Receiving Header  cancelled.';
// }
