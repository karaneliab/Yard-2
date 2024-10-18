page 51003 "Car Model"
{
    ApplicationArea = All;
    Caption = 'Car Model';
    PageType = List;
    SourceTable = "Model";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the Model ID field.', Comment = '%';
                    ApplicationArea = All;
                }

                field(Make; Rec.Make)
                {
                    ToolTip = 'Specifies the value of the  Make field.', Comment = '%';
                    ApplicationArea = All;

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
