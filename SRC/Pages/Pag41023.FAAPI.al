page 41023 "FA  API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'faAPI';
    DelayedInsert = true;
    EntityName = 'fixedAsset';
    EntitySetName = 'FixedAssets';
    PageType = API;
    SourceTable = "Fixed Asset";
    ODataKeyFields = "No.";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(acquired; Rec.Acquired)
                {
                    Caption = 'Acquired';
                }
                field(carMake; Rec."Car Make")
                {
                    Caption = 'Make';
                }
                field(buyingPrice; Rec."Buying Price")
                {
                    Caption = 'Buying Price';
                }
                field(faLocationCode; Rec."FA Location Code")
                {
                    Caption = 'FA Location Code';
                }
                field(yearOfManufacture; Rec."Year of Manufacture")
                {
                    Caption = 'Year of Manufacture';
                }
                field(chassisNo; Rec.ChassisNo)
                {
                    Caption = 'Chasis Number';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(model; Rec.Model)
                {
                    Caption = 'Model';
                }
                field(inactive; Rec.Inactive)
                {
                    Caption = 'Inactive';
                }
                field(countryOfFirstRegistration; Rec."Country Of First Registration")
                {
                    Caption = 'Country Of First Registration';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }
}
