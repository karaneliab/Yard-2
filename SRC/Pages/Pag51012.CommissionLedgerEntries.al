page 51012 "Commission Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Commission Ledger Entries';
    PageType = List;
    SourceTable = "Commission Ledger Entries";
    UsageCategory = History;
    Editable = false;
    SourceTableView = sorting("EntryNo.");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("EntryNo."; Rec."EntryNo.")
                {
                    ToolTip = 'Specifies the value of the EntryNo. field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Document No.";Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the document no .', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(CarMake; Rec.CarMake)
                {
                    ToolTip = 'Specifies the value of the CarMake field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ChasisNo."; Rec."ChasisNo.")
                {
                    ToolTip = 'Specifies the value of the ChasisNo. field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(CommissionAmount; Rec.CommissionAmount)
                {
                    ToolTip = 'Specifies the value of the CommissionAmount field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("CommissionPac"; Rec."CommissionPac")
                {
                    ToolTip = 'Specifies the value of the %Commission field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("EmployeeNo."; Rec."EmployeeNo.")
                {
                    ToolTip = 'Specifies the value of the EmployeeNo. field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(EntryType; Rec.EntryType)
                {
                    ToolTip = 'Specifies the value of the EntryType field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("FA No."; Rec."FA No.")
                {
                    ToolTip = 'Specifies the value of the FANo. field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(PurchasePrice; Rec.PurchasePrice)
                {
                    ToolTip = 'Specifies the value of the PurchasePrice field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(SalesPrice; Rec.SalesPrice)
                {
                    ToolTip = 'Specifies the value of the SalesPrice field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }


    }
    actions
    {
        area(Processing)
        {
             action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                Scope = Repeater;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
            
        }
    }
    var
    Navigate: Page Navigate;
    
}
