table 41004 "Car subform Temporary"
{
    Caption = 'Car subform ';
    DataClassification = ToBeClassified;
    //TableType = Temporary;

    fields
    {
        field(19; "FA No"; code[20])
        {
            Caption = 'fixed asset no';


        }
        field(1; documentNo; code[20])
        {

            Caption = 'Document No';

        }

        field(2; RegNo; code[20])
        {

            Caption = 'RegNo';

        }
        field(3; checkedInBy; Code[20])
        {

            Caption = 'Checked in by.';

        }
        field(4; yardBranch; Text[250])
        {

            Caption = 'Yard Branch';

        }
        field(5; "Year of Make"; Date)
        {
            Caption = 'Year of Make';

        }
        field(6; receivedFrom; Code[20])
        {
            Caption = 'Received From';

        }
        field(7; carMake; Code[20])
        {
            Caption = 'Car Make';


        }
        field(8; carModel; Code[20])
        {
            Caption = 'Car Model';

            ;
        }
        field(9; chassisNumber; Code[20])
        {
            Caption = 'Chasis Number';



        }
        field(10; "Insurance Company"; Text[40])
        {
            Caption = 'Insurance Company';

        }
        field(11; countryOfRegistration; Text[3])
        {
            Caption = 'Country Of Registration';

        }


        field(18; "Depreciation Book"; Code[20])
        {
            Caption = 'Depreciation Book';
          
          
        }


        field(80505; "Year of Manufacture"; Date)
        {
            Caption = 'Year of Manufacture';
            
        }
        field(31; buyingPrice; Decimal)
        {
            Caption = 'Buying Price';
            


        }
            }
            keys
            {
                key(PK; chassisNumber)
                {
                    Clustered = true;
                }
    }
}
