table 41003 "Car Recieving Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Recieving List";
    LookupPageId = "Recieving List";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                
                if "No" <> xRec."No" THEN begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Car Receiving Nos.");
                    "No. Series" := '';
                end;

            end;

        }

        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
            
            DataClassification = CustomerContent;


        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }


        field(5; "Status"; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                TestOnRelease();
            end;
        }
        field(9; "Customer Nos."; Code[20])
        {
            Caption = 'Customer Nos.';
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }
        field(6; "Last Released Date"; DateTime)
        {
            Caption = 'Last Released Date';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(11; "FA No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            TableRelation = "Fixed Asset";
        }
        field(4; YardBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Yard Branch';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
            CaptionClass = '1,1,3';

        }
        field(31; "Buying Price"; Decimal)
        {
            Caption = 'Buying Price';
            FieldClass = FlowField;
            // CalcFormula = lookup("Car Line"."Buying Price" where("Document No." =FIELD(No)));
            CalcFormula = sum("Car Line"."Buying Price" where("Document No." = FIELD(No)));


        }
    }

    // local procedure TestStatus()
    // begin
    //     if Status <> Status::"Approved" then
    //         exit;

    //     "Last Released Date" := CurrentDateTime;
    // end;

    local procedure TestOnRelease()
    begin
        if Status <> Status::Approved then
            exit;

        "Last Released Date" := CurrentDateTime;
    end;



    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestNoSeries(var Customer: Record "Car Recieving Header"; xCustomer: Record "Car Recieving Header"; var IsHandled: Boolean)
    begin
    end;


    var

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";


    trigger OnInsert()
    begin
        if "No" = '' then
            PurchSetup.Get();
        PurchSetup.TestField("Car Receiving Nos.");
        NoSeriesMgt.InitSeries(PurchSetup."Car Receiving Nos.", xRec."No. Series", 0D, "No", "No. Series");


    end;

    var
        PurchSetup: Record Microsoft.Purchases.Setup."Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    procedure PostCarDetails(var Header: Record "Car Recieving Header")
    var
        CarHeader: Record "Car Recieving Header";
        FixedAsset: Record "Fixed Asset";
        CarLine: Record "Car Line";
        FADepreciationBook: Record "FA Depreciation Book";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FASetup: Record "FA Setup";
        NextFANo: Code[20];
        VendorList: List of [Code[20]];
        VendorNo: Code[20];


    begin
        // Get FA Setup
        FASetup.Get();
        CarLine.Reset();
        CarLine.SetRange("Document No.", Header.No);

        if CarLine.FindSet() then begin
            repeat
               
                if CarLine."Car Make" = '' then
                    Error('Enter the car make details');
                if CarLine."Car Model" = '' then
                    Error('Enter the car model details');
                if CarLine."Chassis Number" = '' then
                    Error('Enter the chassis number');
                if CarLine."Country Of Registration" = '' then
                    Error('Enter the country of registration');
                if CarLine."Checked In By" = '' then
                    Error('Enter the checked-in by field');
                if CarLine."FA Class Code" = '' then
                    Error('Enter the FA class code to get the correct subclass with default posting group');

                if not VendorList.Contains(CarLine."Received From") then
                    VendorList.Add(CarLine."Received From");

                if ChassisNumberExists(CarLine."Chassis Number", CarLine."Document No.") then
                    Error('The chassis number %1 already exists in another Car.', CarLine."Chassis Number");


                NextFANo := NoSeriesMgt.GetNextNo(FASetup."Fixed Asset Nos.", Header."Date", true);
                CarLine."FA No" := NextFANo;

                FixedAsset.Init();
                FixedAsset."No." := CarLine."FA No";
                FixedAsset.ChassisNo := CarLine."Chassis Number";
                FixedAsset."Car Make" := CarLine."Car Make";
                FixedAsset."Description" := CarLine."Chassis Number";
                FixedAsset."Model" := CarLine."Car Model";
                FixedAsset."RegNo" := CarLine.RegNo;
                FixedAsset."Buying Price" := CarLine."Buying Price";
                FixedAsset."Responsible Employee" := CarLine."Checked In By";
                FixedAsset."Year of Manufacture" := CarLine."Year of Make";
                FixedAsset."Country Of First Registration" := CarLine."Country Of Registration";
                FixedAsset."FA Location Code" := CarLine.YardBranch;
                FixedAsset."Insurance Company" := CarLine."Insurance Company";
                FixedAsset."FA Class Code" := CarLine."FA Class Code";
                FixedAsset."Vendor No." := CarLine."Received From";
                FixedAsset."FA Subclass Code" := CarLine."FA Subclass Code";
                FixedAsset.Validate("Car Insured", CarLine."Car Insured");



                FixedAsset.Insert();

                CarLine.Modify(true);

                FADepreciationBook.Init();
                // FADepreciationBook.Validate("Depreciation Book Code", CarLine."Depreciation Book");
                // FADepreciationBook.Validate("Depreciation Starting Date", CarLine."Depreciation Starting Date");
                // FADepreciationBook.Validate("Depreciation Ending Date", CarLine."Depreciation Ending Date");
                // FADepreciationBook.Validate("No. of Depreciation Years", CarLine."No of Depreciation Years");
                // FADepreciationBook.Validate("FA Posting Group", CarLine."FA Posting Group");
                // FADepreciationBook.Validate("FA No.", CarLine."FA No");
                FADepreciationBook."Depreciation Book Code" := CarLine."Depreciation Book";
                FADepreciationBook."Depreciation Starting Date" := CarLine."Depreciation Starting Date";
                FADepreciationBook."Depreciation Ending Date" := CarLine."Depreciation Ending Date";
                FADepreciationBook."No. of Depreciation Years" := CarLine."No of Depreciation Years";
                FADepreciationBook."FA Posting Group" := CarLine."FA Posting Group";
                FADepreciationBook."FA No." := CarLine."FA No";
                FADepreciationBook.Insert(true);


            until CarLine.Next() = 0;
        end;

        foreach VendorNo in VendorList do
            RaisePurchaseInv(Header, VendorNo);
        // RaisePurchaseInv(Header, FixedAsset."Vendor No.");


    end;


    procedure ChassisNumberExists(ChassisNumber: Code[20]; DocumentNo: Code[20]): Boolean
    var
        TempCarLine: Record "Car Line";
    begin
        TempCarLine.Reset();
        TempCarLine.SetRange("Chassis Number", ChassisNumber);
        TempCarLine.SetFilter("Document No.", '<>%1', DocumentNo);

        if TempCarLine.FindFirst() then
            exit(true);
        exit(false);
    end;




    procedure RaisePurchaseInv(var Header: Record "Car Recieving Header"; VendorNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        CarLine: Record "Car Line";
        LineNo: Integer;
        Vendor: Record Vendor;
        DirectUnitCost: Decimal;
        DirectUnitCostText: Text;


    begin


        PurchaseHeader.Init();
        PurchaseHeader."Buy-from Vendor No." := VendorNo;

        //* PurchaseHeader."Buy-from Vendor Name" := Vendor.Name;
        PurchaseHeader."Posting Date" := Header."Date";
        PurchaseHeader."Document Date" := Header."Date";
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;

        PurchaseHeader."Currency Code" := 'USD';
        if PurchaseHeader.Insert(true) then begin
            PurchaseHeader.Validate("Buy-from Vendor No.");
            PurchaseHeader.Validate("Currency Code");
            PurchaseHeader.VALIDATE("Vendor Invoice No.", Header.No);
            PurchaseHeader.Modify();
        end;

        CarLine.Reset();
        CarLine.SetRange("Document No.", Header.No);
        CarLine.SetRange("Received From", VendorNo);
        if CarLine.FindSet() then begin
            LineNo := 0;
            repeat
                Message(PurchaseHeader."No.");

                PurchaseLine.Init();
                PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
                PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                PurchaseLine."Document No." := PurchaseHeader."No.";
                PurchaseLine.Validate("Document No.", PurchaseHeader."No.");

                //*add posting group
                PurchaseLine."Posting Group" := CarLine."FA Posting Group";


                LineNo += 1200;
                PurchaseLine."Line No." := LineNo;

                PurchaseLine."No." := CarLine."FA No";
                // PurchaseLine."Document No." := "FA No.";
                // PurchaseLine.Validate("No.",CarLine."FA No");
                PurchaseLine."Quantity" := 1;
                PurchaseLine."Direct Unit Cost" := CarLine."Buying Price";
                PurchaseLine."Description" := CarLine."Chassis Number";
                PurchaseLine."Shortcut Dimension 1 Code" := CarLine.YardBranch;
                // DirectUnitCost := PurchaseLine."Direct Unit Cost"; 
                // DirectUnitCostText := Format(DirectUnitCost);

                if PurchaseLine.Insert(true) then begin
                    PurchaseLine.Validate("No.");
                    PurchaseLine.Validate("Direct Unit Cost", CarLine."Buying Price");
                    PurchaseLine.Validate("Shortcut Dimension 1 Code", CarLine.YardBranch);
                    // PurchaseLine.Modify();

                    PurchaseLine.Modify(true);

                end else
                    Error('Error');

            until CarLine.Next() = 0;

        end;
    end;


}