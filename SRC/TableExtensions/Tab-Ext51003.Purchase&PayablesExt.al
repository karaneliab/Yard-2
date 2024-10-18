tableextension 51003 "Purchase&PayablesExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(521923; "Car Receiving Nos."; Code[10])
        {
            Caption = 'Car Receiving Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(51000; "Car Make Nos."; code[10])
        {
            Caption = 'Car Make Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(510001; "Car Model Nos."; code[10])
        {
            Caption = 'Car Model Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }


    }
}