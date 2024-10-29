tableextension 41002 "Fixed Asset Ext" extends "Fixed Asset"
{
    LookupPageId = "Fixed Asset Card";
    DrillDownPageId = "Fixed Asset Card";
    fields
    {
        field(80500; "Car Make"; Text[40])
        {
            Caption = 'Make';
            DataClassification = ToBeClassified;
            TableRelation = "Make";
        }

        field(80501; Model; Text[40])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
            TableRelation = "Model" where(Make = field("Car Make"));
        }
        field(80502; "Insurance Company"; Text[40])
        {
            Caption = 'Insurance Company';
            DataClassification = CustomerContent;
            TableRelation = Vendor where("Vendor Types" = CONST(Insurer));

        }
        field(80503; RegNo; Code[20])
        {
            Caption = 'Registration Number';
            DataClassification = CustomerContent;
        }
        field(80504; ChassisNo; Code[40])
        {
            Caption = 'Chasis Number';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                CarLineRec: Record "Car Line";
                FixedAssetRec: Record "Fixed Asset";
            begin
                if ChassisNo <> xRec.ChassisNo then begin

                    if CarLineRec.Get(CarLineRec."Chassis Number") then
                        Error('A car with the provided chassis number %1 already exists in the Car Line table.', CarLineRec."Chassis Number");

                    // Check if the chassis number exists in the Fixed Asset table
                    FixedAssetRec.SetRange(ChassisNo, CarLineRec."Chassis Number");
                    if FixedAssetRec.FindFirst() then
                        Error('A car with the provided chassis number %1 already exists in the Fixed Asset table.', ChassisNo);
                end;
            end;
        }
        field(80505; "Year of Manufacture"; Date)
        {
            Caption = 'Year of Manufacture';
            DataClassification = ToBeClassified;
        }
        field(80506; "Country Of First Registration"; Text[40])
        {
            Caption = 'Country Of First Registration';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(80507; "Car Insured"; Boolean)
        {
            Caption = 'Car Insured';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Car Insured" then begin
                    "Insurance Company" := '';
                    "Year of Manufacture" := 0D;

                end;

            end;
        }
        field(51000; "Buying Price"; Decimal)
        {
            Caption = 'Buying Price';
            FieldClass = FlowField;

            CalcFormula = sum("Car Line"."Buying Price" where("FA No" = FIELD("No.")));
        }
        field(50000; AcquisitionCost; Decimal)
        {
            Caption = 'AcquisitionCost';
            Editable = false;


            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Line"."Direct Unit Cost" WHERE("No." = field("No.")));

            trigger OnLookup()
            var
                FADepreciationBook: Record "FA Depreciation Book";
            begin
                FADepreciationBook.Reset();
                FADepreciationBook.SetRange("FA No.", "No.");
                if FADepreciationBook.FindFirst() then begin
                    FADepreciationBook.CalcFields("Book Value");
                    AcquisitionCost := FADepreciationBook."Book Value";

                end;
            end;



        }
        field(50001; "Front Pic"; Media)
        {
            Caption = 'Car Front Pic';
            DataClassification = CustomerContent;

        }
        field(50002; "Back Picture"; Media)
        {
            Caption = 'Back Picture';
            DataClassification = CustomerContent;

        }
        field(50003; "Left Side Picture"; Media)
        {
            Caption = 'Left Side Picture';
            DataClassification = CustomerContent;

        }
        field(59003; "Right Side Picture"; Media)
        {
            Caption = 'Right Side Picture';
            DataClassification = CustomerContent;

        }
    }
    keys
    {
        key(PK; "RegNo", "Car Make")
        {


        }

    }

}