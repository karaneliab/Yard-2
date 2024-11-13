page 41025 "car geader temp."
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'carGeaderTemp';
    DelayedInsert = true;
    EntityName = 'carhead';
    EntitySetName = 'carheads';
    PageType = API;
    SourceTable = "Car Header Temporary";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'System Id';
                }
                field(status; Rec.status)
                {
                    Caption = 'Status';
                }
                field(yardbranch; Rec.yardbranch)
                {
                    Caption = 'Yard Branch';
                }
                field(description; Rec.description)
                {
                    Caption = 'Description';
                }
                field(no; Rec.no)
                {
                    Caption = 'No';
                }
                field("date"; Rec."date")
                {
                    Caption = 'Date';
                }
                field(buyingprice; Rec.buyingprice)
                {
                    Caption = 'Buying Price';
                }
            }
        }
    }
}
