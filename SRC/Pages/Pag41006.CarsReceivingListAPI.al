page 41006 CarsReceivingListAPI
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'carsReceivingListAPI';
    DelayedInsert = true;
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    PageType = API;
    SourceTable = "Car Line";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(buyingPrice; Rec."Buying Price")
                {
                    Caption = 'Buying Price';
                }
                field(carMake; Rec."Car Make")
                {
                    Caption = 'Car Make';
                }
                field(carModel; Rec."Car Model")
                {
                    Caption = 'Car Model';
                }
                field(chassisNumber; Rec."Chassis Number")
                {
                    Caption = 'Chasis Number';
                }
                field(checkedInBy; Rec."Checked In By")
                {
                    Caption = 'Checked in by.';
                }
                field(countryOfRegistration; Rec."Country Of Registration")
                {
                    Caption = 'Country Of Registration';
                }
            }
        }
    }
}
