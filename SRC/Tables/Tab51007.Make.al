
table 51007 "Make"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Car Make Card";
    LookupPageId = "Car Make Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;

        }
        field(2; " Make Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }

    }

    keys
    {
        key(Key1; "No.")
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
}
