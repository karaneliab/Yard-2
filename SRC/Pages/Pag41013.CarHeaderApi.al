page 41013 "Car Header Api"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carHeaderApi';
    DelayedInsert = true;
    EntityName = 'carHeader';
    EntitySetName = 'carHeaders';
    PageType = API;
    SourceTable = "Car Recieving Header";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId) { }
                field(buyingPrice; Rec."Buying Price")
                {
                    Caption = 'Buying Price';
                }
                field(customerNos; Rec."Customer Nos.")
                {
                    Caption = 'Customer Nos.';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(faNo; Rec."FA No.")
                {
                    Caption = 'Fixed Asset No.';
                }
                field(lastReleasedDate; Rec."Last Released Date")
                {
                    Caption = 'Last Released Date';
                }
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(yardBranch; Rec.YardBranch)
                {
                    Caption = 'Yard Branch';
                }
                part(carLines; "Carlines API")
                {
                    Caption = 'Header details';
                    EntityName = 'carLine';
                    EntitySetName = 'carLines';
                    SubPageLink = "Header Id" = field(SystemId);
                }
            }
        }
    }
}
