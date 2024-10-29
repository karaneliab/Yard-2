table 41100 "Car Details"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Car Details List";
    DrillDownPageId = "Car Details List";


    fields
    {
        field(1; "FA No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fixed Asset No.';
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";

            begin
                if "FA No." <> '' then begin
                    if not FixedAsset.Get("FA No.") then
                        Error('The Fixed Asset No. %1 does not exist.', "FA No.");
                    ChassisNo := transact.GetChassisNoByFANo("FA No.");
                    // if ChassisNo = '' then
                    //     Error('No Chassis Number found for Fixed Asset No. %1.', "FA No.")
                    // else
                    //     "Chassis No." := ChassisNo;


                end;
            end;
        }

        field(2; "Make"; Text[40])
        {

            Caption = 'Make';

        }

        field(3; "Model"; Text[50])
        {

            Caption = 'Model';

        }

        field(4; "Chassis No."; Code[40])
        {

            Caption = 'Chassis Number';



            trigger OnValidate()
            begin
                if ChassisNumberExists("Chassis No.") then
                    Error('A car with Chassis Number %1 already exists.', "Chassis No.");
            end;
        }


        field(5; "Purchase Price"; Decimal)
        {

            Caption = 'Purchase Price';
            TableRelation = "Purchase Line";

        }


        field(6; "Purchase Date"; Date)
        {

            Caption = 'Purchase Date';
            TableRelation = "Purchase Header";

        }


        field(7; "Sales Price"; Decimal)
        {

            Caption = 'Sales Price';
            TableRelation = "Sales Invoice Line";

        }


        field(8; "Sales Date"; Date)
        {

            Caption = 'Sales Date';
            TableRelation = "Sales Header";

        }
    }

    keys
    {
        key(PK; "FA No.") { Clustered = true; }

    }

    trigger OnInsert()
    begin

    end;

    procedure ChassisNumberExists(ChassisNo: Code[40]): Boolean
    var
        CarDetails: Record "Car Details";
    begin
        exit(CarDetails.Get(ChassisNo));
    end;

    var
        transact: Codeunit CarTransaction;
        ChassisNo: Code[40];

}
