page 41010 "Carlines API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Car Lines API';
    DelayedInsert = true;
    EntityName = 'carLine';
    EntitySetName = 'carLines';
    PageType = API;
    SourceTable = "Car Line";
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                }
                field(headerId;Rec."Header Id"){

                }
                field(buyingPrice; Rec."Buying Price")
                {
                    Caption = 'Buying Price';
                }
                field(carInsured; Rec."Car Insured")
                {
                    Caption = 'Car Insured';
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
                field(depreciationBook; Rec."Depreciation Book")
                {
                    Caption = 'Depreciation Book';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No';
                }
                field(receivedFrom; Rec."Received From")
                {
                    Caption = 'Received From';
                }
                field(yardBranch; Rec.YardBranch)
                {
                    Caption = 'Yard Branch';
                }
                field(yearOfMake; Rec."Year of Make")
                {
                    Caption = 'Year of Make';
                }
                field(yearOfManufacture; Rec."Year of Manufacture")
                {
                    Caption = 'Year of Manufacture';
                }
                // part(CarHeader; "Car Header Api")
                // {
                //     Caption = 'Header details';
                //     EntityName = 'headerApi';
                //     EntitySetName = 'Headers';
                //     SubPageLink = No = field("Document No.");
                // }
            }
        }
    }
}
