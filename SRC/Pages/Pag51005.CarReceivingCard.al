page 51005 "Car Receiving Card"
{
    ApplicationArea = All;
    Caption = 'Car Receiving Card';
    PageType = Card;
    SourceTable = "Car Recieving Header";
    // UsageCategory = Documents;
    PromotedActionCategories = 'Approval';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the  Date field.', Comment = '%';
                }

                field("Last Released Date"; Rec."Last Released Date")
                {
                    ToolTip = 'Specifies the value of the Last Released Date field.', Comment = '%';
                }
             
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Buying Price"; Rec."Buying Price")
                {
                    ToolTip = 'Specifies the value of the Buying Price field.', Comment = '%';
                    Editable = false;
                }
            }
            part(Lines; "Car Subform")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No");
                UpdatePropagation = Both;

            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }

            part(Statistics; "Customer Statis&tics")
            {
                SubPageLink = "No" = field("No"),"Buying Price" = field("Buying Price");
                
                 
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }

        }
    }
    actions
    {

        area(processing)
        {


            action("Po&st")
            {
                Caption = 'P&ost';
                Image = PostOrder;
                trigger OnAction()
                var
                    CarLine: Record "Car Line";
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseInvoiceNo: Code[20];
                    // CustomWorkflowMgmt: Codeunit "Custom Workflow Mgmt";
                    RecRef: RecordRef;
                    VendorNo: Code[20];
                begin

                    if not Confirm('Do you want to post the car receipt?', true) then
                        Message('Posting cancelled.')
                    else begin

                        Rec.PostCarDetails(Rec);
                        Message('Car details posted successfully.');
                        if Confirm('Do you want to open Purchase Invoice', FALSE) then
                            Page.Run(Page::"Purchase Invoices");



                        // CarLine.SetRange("Document No.", Rec.No);
                        // if CarLine.FindFirst() then begin
                        //     VendorNo := CarLine."Received From";

                        //     // Find the latest purchase invoice for the vendor
                        //     PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
                        //     PurchaseHeader.SetRange("Posting Date", Rec."Date");

                        //     if PurchaseHeader.FindFirst() then begin
                        //         PurchaseInvoiceNo := PurchaseHeader."No.";


                        //         Page.Run(Page::"Purchase Invoice", PurchaseHeader);
                        //     end else
                        //         Message('No purchase invoice was found for vendor: %1', VendorNo);
                        // end else
                        //     Message('No car line record found for the current receiving header.');
                    end;
                end;
            }


            action(ImportCarDetails)
            {
                Caption = 'Import Car Details';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ImportCars: XmlPort "Import Car Details";
                begin
                    Clear(ImportCars);
                    ImportCars.GetDocNo(Rec.No);
                    ImportCars.Run();
                end;
            }
            action(ExportCarDetails)
            {
                Caption = 'Export Car Details';
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ExportCars: XmlPort "Export Car Details";
                begin
                    Clear(ExportCars);
                    ExportCars.Run();

                end;
            }
            // action(ExpzortToExcel)
            // {
            //     Caption = 'Export to Excel';
            //     Image = Export;
            //     // Promoted = true;
            //     // PromotedCategory = Process;

            //     trigger OnAction()
            //      var
            //         ExportCars: XmlPort "Export Car Details";
            //     begin
            //        ExportCars.ExportToExcel();
            //     end;
            // }

        }
    }

    var
        NoFieldVisible: Boolean;
        PostCarDetails: Record "Car Line";
        CarRecivHead: Record "Car Recieving Header";
        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
}