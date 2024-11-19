page 41023 "Car Line Custom API"
{
    APIGroup = 'karan';
    APIPublisher = 'defttech';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carLineCustomAPI';
    DelayedInsert = true;
    EntityName = 'carLineCustom';
    EntitySetName = 'carLineCustoms';
    PageType = API;
    SourceTable = "Car subform Temporary";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentNo; Rec.documentNo)
                {
                    Caption = 'Document No';
                }
                field(chassisNumber; Rec.chassisNumber)
                {
                    Caption = 'Chasis Number';
                }
                field(carMake; Rec.carMake)
                {
                    Caption = 'Car Make';
                }
                field(carModel; Rec.carModel)
                {
                    Caption = 'Car Model';
                }
                field(buyingPrice; Rec.buyingPrice)
                {
                    Caption = 'Buying Price';
                }
                field(checkedInBy; Rec.checkedInBy)
                {
                    Caption = 'Checked in by.';
                }
                field(receivedFrom; Rec.receivedFrom)
                {
                    Caption = 'Received From';
                }
                field(yardBranch; Rec.yardBranch)
                {
                    Caption = 'Yard Branch';
                }
                field(countryOfRegistration; Rec.countryOfRegistration)
                {
                    Caption = 'Country Of Registration';
                }
                field(yearOfMake; Rec."Year of Make")
                {
                    Caption = 'Year of Make';
                }
                field(yearOfManufacture; Rec."Year of Manufacture")
                {
                    Caption = 'Year of Manufacture';
                }
                field(regNo; Rec.RegNo)
                {
                    Caption = 'RegNo';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
