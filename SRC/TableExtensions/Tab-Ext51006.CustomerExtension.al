
tableextension 51006 "Customer Extension" extends Customer
{
    fields
    {
        field(90100; "Kra Pin Certificate"; Media)
        {
            Caption = 'Kra Pin Certificate';
            DataClassification = CustomerContent;
        }
        field(90101; "ID Copy"; Media)
        {
            Caption = 'ID Copy';
            DataClassification = CustomerContent;
        }
       
    }
}
