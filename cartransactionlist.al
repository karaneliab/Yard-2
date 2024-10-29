page 41100 "Car Details List"
{
    PageType = List;
    SourceTable = "Car Details";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Car Details list';
    CardPageId= CarTransactionCard;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset No.';
                }
                field("Chassis No."; Rec."Chassis No.")
                {
                    ApplicationArea = All;
                }
                field("Make"; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Model"; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ApplicationArea = All;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    ApplicationArea = All;
                }
                field("Sales Date"; Rec."Sales Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
