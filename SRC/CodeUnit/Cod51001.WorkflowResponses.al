
// codeunit 51001 WorkflowResponses
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
//     local procedure OnOpenCarDocument(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         Message('This is OnOpenCarDocument');
//         case
//             RecRef.Number of
//             DATABASE::"Car Recieving Header":
//                 begin
//                     RecRef.SetTable(CarReceivingHeader);
//                     CarReceivingHeader.Validate(Status, CarReceivingHeader.Status::Created);
//                     CarReceivingHeader.Modify(true);
//                     Handled := true;
//                      Message('This is OnOpenCarDocument');
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
//     local procedure OnReleaseCarDocument(RecRef: RecordRef;var Handled: Boolean)
//     var
//     CarReceivingHeader: Record "Car Recieving Header";
//     begin
//         case 
//             RecRef.Number of
//             Database::"Car Recieving Header":
//             begin
//                 RecRef.SetTable(CarReceivingHeader);
//                 CarReceivingHeader.Validate(Status,CarReceivingHeader.Status::Approved);
//                 CarReceivingHeader.Modify(true);
//                 Handled := true;
//             end;
//         end;
//     end;
// }
