table 41008 "Car Header Temporary"
{
    Caption = 'Carheader';
    //TableType = Temporary;
    
    fields
    {
       field(1; no; Code[20])
        {
            Caption = 'No';      

        }

        field(3; "date"; Date)
        {
            Caption = 'Date';

        }
        field(7; description; Text[250])
        {
            Caption = 'Description';
            
        }
      
        field(5; "status"; Text[250])
        {
            Caption = 'Status';
           
        }
       
        field(6; "Last Released Date"; DateTime)
        {
            Caption = 'Last Released Date';
        }
        
            
        field(4; yardbranch; Text[250])
        {
            
            Caption = 'Yard Branch';
        }
        field(31; "buyingprice"; Decimal)
        {
            Caption = 'Buying Price';
            

        }
    }
    keys
    {
       key(PK;No)
       {
        clustered = true;
       }
    }
}
