pageextension 51001 "Fixed Assets" extends "Fixed Asset Card"
{
    layout
    {


        addafter(General)

        {
            group("Car Details")
            {
                field("Car Make"; Rec."Car Make")
                {
                    Tooltip = 'Specifies the Car Make .', Comment = '%';
                    ApplicationArea = All;
                }
                field("Model"; Rec."Model")
                {
                    ToolTip = 'Specifies the Car Model.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Insuarance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the Insuarance Company.', Comment = '%';


                }
                field("RegNo"; Rec.RegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RegNo.', Comment = '%';
                }
                field("ChassisNo"; Rec.ChassisNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies chassis number', Comment = '%';
                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Year of Manufacture.', Comment = '%';
                }
                FIELD("Buying Price"; Rec."Buying Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Speifies price';
                }
                field("Car Insured"; Rec."Car Insured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the insuarance  company', Comment = '%';

                    trigger OnValidate()
                    begin

                        CurrPage.Update();
                    end;

                }
                field("Country Of First Registration"; Rec."Country Of First Registration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Country Of First Registration.', Comment = '%';
                }
                field(AcquisitionCost; Rec.AcquisitionCost)
                {
                    ToolTip = 'Specifies the cost of the acquisition cost';
                    trigger OnDrillDown()
                    begin
                        FADepreciationBook.DrillDownOnBookValue();
                    end;

                }


            }

        }

        addafter(FixedAssetPicture)
        {
            part("specific car"; "Specific car details")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part("Right"; "Right Side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part("Left"; "Left side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }
            part(Back; "Back Side")
            {
                ApplicationArea = All;
                Visible = true;
                SubPageLink = "No." = field("No.");
            }


        }

    }


}
