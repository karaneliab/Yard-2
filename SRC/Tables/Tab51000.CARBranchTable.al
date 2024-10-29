table 41000 "Car Branch Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;

        }
        field(2; "Branch Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';

        }
        field(3; "Car Make"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Make';
            TableRelation = "Make";

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