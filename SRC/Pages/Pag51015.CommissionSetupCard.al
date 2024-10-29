page 41015 "Commission Setup Card"
{
    ApplicationArea = All;
    Caption = 'Commission Setup Card';
    PageType = Card;
    SourceTable = "Commission Rate";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Car Make No"; Rec."Car Make No")
                {
                    ToolTip = 'Specifies the value of the Car Make No field.', Comment = '%';
                }
                field("Commission Rate"; Rec."Commission Rate")
                {
                    ToolTip = 'Specifies the value of the Commission percentage field.', Comment = '%';
                }
            }
        }
    }
}
