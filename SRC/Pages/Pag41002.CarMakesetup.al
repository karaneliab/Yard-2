page 41002 "Car Make setup"
{
    ApplicationArea = All;
    Caption = 'Car Make setup';
    PageType = List;
    SourceTable = "Make";
    UsageCategory = Lists;
    CardPageId = "Car Make Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Make ID field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(" Name"; Rec." Make Name")
                {
                    ToolTip = 'Specifies the value of the  Make Name field.', Comment = '%';
                    ApplicationArea = All;
                }
            
            }
        }
    }
}
