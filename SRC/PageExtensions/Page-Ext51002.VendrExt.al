pageextension 41002 VendrExt extends "Vendor Card"
{
    layout
    {
        addafter("Address & Contact")
        {
            group("Insuarance Details")
            {
                field("CompanyName"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                    Editable = IsEditable;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Company'sMail"; Rec."Company's Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Companys Mail';
                    Editable = IsEditable;
                }

            }
        }
        addlast(General)
        {
            field("VendorType"; Rec."Vendor Types")
            {
                ApplicationArea = All;
                Caption = 'Vendor Type';
                NotBlank = TRUE;
            }
        }
    }
    var
        IsEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsEditable := VendorTypeEditable();
    end;

    local procedure VendorTypeEditable(): Boolean
    begin
        if Rec."Vendor Types" = Rec."Vendor Types"::Supplier then
            exit(false);
        exit(true);
    end;
}
