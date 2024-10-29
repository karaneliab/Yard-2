page 41008 "Customer Statis&tics"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Car Recieving Header";
    Editable = false;
    Caption = 'Statistics';

    layout
    {
        area(Content)
        {
            field("No."; Rec."No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies customer number.';
            }
            field("Buying Price"; Rec."Buying Price")
            {
                ToolTip = 'Specifies the Buying Price.';
            }

        }

    }
}


