page 51004 "Car Model card"
{
    ApplicationArea = All;
    Caption = 'Model card';
    PageType = Card;
    SourceTable = "Model";
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the Model ID  field.', Comment = '%';
                }

                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the  Make name field.', Comment = '%';
                }
                field(" Model Name"; Rec." Model Name")
                {
                    ToolTip = 'Specifies the value of the Model Name field.', Comment = '%';
                    ApplicationArea = All;
                }

            }
        }
    }
}
