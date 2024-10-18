table 51006 "Commission Ledger Entries"
{
    Caption = 'Commission Ledger Entries';
    DataClassification = ToBeClassified;
    DrillDownPageID ="Commission Ledger Entries";
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
            // TableRelation = "CAR Make";
            TableRelation = "Sales Line" where(Make = field("FA No."));
        }
        field(5; "ChasisNo."; Code[20])
        {
            Caption = 'ChasisNo.';
            TableRelation = "Car Line";
        }
        field(6; SalesPrice; Decimal)
        {
            // Caption = 'SalesPrice';
            // FieldClass = FlowField;
            // CalcFormula = lookup("Sales Invoice Line"."Unit Price" WHERE("No." = field("FA No.")));
            
            AutoFormatType = 1;
            // CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Ledger Entry Amount" = const(true),
            //                                                               "Vendor Ledger Entry No." = field("EntryNo."),
            //                                                                "Posting Date" = FIELD("Date Filter")));
            Caption = 'Sales Price';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(7; PurchasePrice; Decimal)
        {
            Caption = 'PurchasePrice';
            // AutoFormatType = 1;
            // CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Ledger Entry Amount" = const(true),
            //                                                              "Cust. Ledger Entry No." = field("EntryNo."),
            //                                                              "Posting Date" = FIELD("Date Filter")));
           
            Editable = false;
            // FieldClass = FlowField;
            
            // CalcFormula = lookup("Purch. Inv. Line"."Direct Unit Cost" WHERE("No." = field("FA No.")));
                                                                  

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
            //  TableRelation = "Sales Line" where("No." = field("ChasisNo."));
            //  trigger OnLookup()
            //  begin
                
            //  end;
        }
        field(10; CommissionAmount; Decimal)
        {
            Caption = 'Commission Amount';
            Editable = false;
            // TableRelation = "Sales Line" where("No." = field("ChasisNo."));
       

        }
        field(11; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(12; Branch; Text[250])
        {
            Caption = 'Branch';
            // TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
            //                                               Blocked = const(false)); 
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
