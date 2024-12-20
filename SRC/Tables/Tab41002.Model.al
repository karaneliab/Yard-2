table 41002 "Model"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Car Model card";
    LookupPageId = "Car Model Card";


    fields
    {
        field(1; "ID"; Code[20])
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;

        }
        field(3; "Make"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Make';
            TableRelation = "Make";
        }
        field(2; " Model Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = ' Name';

        }



    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        PurchSetup: Record Microsoft.Purchases.Setup."Purchases & Payables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;

}