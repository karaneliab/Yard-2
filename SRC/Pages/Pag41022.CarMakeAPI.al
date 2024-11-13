page 41022 "Car Make API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carMakeAPI';
    DelayedInsert = true;
    EntityName = 'MakeApi';
    EntitySetName = 'MakeApis';
    PageType = API;
    SourceTable = Make;
    ODataKeyFields = "No.";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(makeName; Rec." Make Name")
                {
                    Caption = 'Name';
                }
                field(no; Rec."No.")
                {
                    Caption = 'ID';
                }
            }
        }
    }
}
