table 51005 "Commission Rate"
{
    Caption = 'Commission Rate';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Car Make No"; Code[20])
        {
            Caption = 'Car Make No';
            TableRelation = "Make";
            DataClassification = CustomerContent;
        }
        field(2; "Commission Rate"; decimal)
        {
            Caption = 'Commission percentage';
            
            DecimalPlaces = 2 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
    }
    keys
    {
        key(PK; "Car Make No")
        {
            Clustered = true;
        }
    }
}
