page 41007 "Car Subform"
{
    ApplicationArea = All;
    Caption = 'Car Subform';
    PageType = ListPart;
    SourceTable = "Car Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Chassis Number"; Rec."Chassis Number")
                {
                    ToolTip = 'Specifies The Car Chasis Number', Comment = '%1';
                }
                field("Make"; Rec."Car Make")
                {
                    ToolTip = 'Specifies the value of the Car Make field.', Comment = '%';
                }

                field("Model"; Rec."Car Model")
                {
                    ToolTip = 'Specifies the value of the Car Model field.', Comment = '%';
                }
                field(YardBranch; Rec.YardBranch)
                {
                    ToolTip = 'Specifies the value of the Yard Branch field.', Comment = '%';
                }
                field("Depreciation Book"; Rec."Depreciation Book")
                {
                    ToolTip = 'Specifies the Depreciation book code';
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the vendor the car was received from', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Buying Price"; Rec."Buying Price")
                {
                    ToolTip = 'Specifies the value of the Buying Price field.', Comment = '%';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ToolTip = 'Specifies the value of the FA Posting Group field.', Comment = '%';
                }
                field("Checked In By"; Rec."Checked In By")
                {
                    ToolTip = 'Specifies the value of the Checked in by. field.', Comment = '%';
                }


                field("Car Insured"; Rec."Car Insured")
                {
                    ToolTip = 'Specifies if the car is insured';
                    trigger OnValidate()
                    begin
                        UpdateInsuranceCompanyEditable();
                    end;
                }
                field("Insuarance Company"; Rec."Insurance Company")
                {
                    ToolTip = 'Specifies the Insurance company';
                    Editable = IsInsuranceCompanyEditable;
                }


                field("Depreciation Starting Date"; Rec."Depreciation Starting Date")

                {
                    ToolTip = 'Specifies the Start of Depreciation Date', Comment = '%';

                }
                field("Depreciation Ending Date"; Rec."Depreciation Ending Date")
                {
                    ToolTip = 'Specifies Depreciation Ending Date';
                    ApplicationArea = All;
                }

                field("Country Of First Reg"; Rec."Country Of Registration")
                {
                    Tooltip = 'Specifies the Country of first registration';

                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.', Comment = '%';
                }
                field("VAT Bussuness Posting Group"; Rec."VAT Bussuness Posting Group")
                {
                    ToolTip = 'Specifies the value of VAT Bussuness Posting Group', Comment = '%';
                }

                field("FA Class Code"; Rec."FA Class Code")
                {
                    ToolTip = 'Specifies the Fa clas code';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ToolTip = 'Fa subclass Code';
                }
                field(RegNo; Rec.RegNo)
                {
                    ToolTip = 'Specifies the value of the RegNo field.', Comment = '%';
                }
            
            }
        }
    }
    actions
    {

        area(Processing)
        {



        }
    }

    var
        IsInsuranceCompanyEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateInsuranceCompanyEditable();
    end;

    procedure UpdateInsuranceCompanyEditable()
    begin
        IsInsuranceCompanyEditable := Rec."Car Insured";
    end;


}



