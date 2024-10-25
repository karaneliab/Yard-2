page 51111 "Recieving List"
{
    ApplicationArea = All;
    Caption = 'Cars Receiving List';
    PageType = List;
    SourceTable = "Car Recieving Header";
    
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Car Receiving Card";
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Date field.', Comment = '%';
                }
                field("Description";Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    
                }
            
            }
        }
    }
}