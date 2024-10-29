table 41006 "Commission Ledger Entries"
{
    Caption = 'Commission Ledger Entries';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Commission Ledger Entries";
    LookupPageID = "Commission Ledger Entries";

    fields
    {
        field(1; "EntryNo."; Integer)
        {
            Caption = 'EntryNo.';
            AutoIncrement = true;
        }
        field(16; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnLookup()
            var
                IncomingDocument: Record "Incoming Document";
            begin
                IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
            end;
        }
        field(2; EntryType; Option)
        {
            Caption = 'EntryType';
            OptionCaption = ',Payment,Booking';
            OptionMembers = " ",Payment,"Booking";
        }
        field(14; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; "EmployeeNo."; Code[20])
        {
            Caption = 'EmployeeNo.';
            TableRelation = Employee;
        }
        field(4; CarMake; Text[250])
        {
            Caption = 'CarMake';

            TableRelation = "Sales Line" where(Make = field("FA No."));
        }
        field(5; "ChasisNo."; Code[20])
        {
            Caption = 'ChasisNo.';
            TableRelation = "Car Line";
        }
        field(6; SalesPrice; Decimal)
        {

            AutoFormatType = 1;

            Caption = 'Sales Price';
            Editable = false;

        }
        field(7; PurchasePrice; Decimal)
        {
            Caption = 'PurchasePrice';
            Editable = false;



        }
        field(8; "FA No."; Code[20])
        {
            Caption = 'FANo.';
            Editable = false;
            TableRelation = "Fixed Asset";
        }
        field(9; "CommissionPac"; Decimal)
        {
            Caption = 'Commission Pac';
            Editable = false;

        }
        field(10; CommissionAmount; Decimal)
        {
            Caption = 'Commission Amount';
            Editable = false;



        }
        field(11; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(12; Branch; Text[250])
        {
            Caption = 'Branch';
            Editable = false;
            TableRelation = "Sales Line";
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }

    }
    keys
    {
        key(PK; "EntryNo.")
        {
            Clustered = true;
        }
        key(key2; "EmployeeNo.")
        {

        }
    }

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("EntryNo.")))
    end;


}
