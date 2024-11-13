page 41021 "Car Model Api"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carModelApi';
    DelayedInsert = true;
    EntityName = 'modelApi';
    EntitySetName = 'ModelApis';
    PageType = API;
    SourceTable = Model;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(modelName; Rec." Model Name")
                {
                    Caption = 'Name';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(make; Rec.Make)
                {
                    Caption = 'Make';
                }
            }
        }
    }
}
