pageextension 41000 "Employee card" extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field("KRA PIN"; Rec."KRA PIN")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the Employee Kra Pin.', Comment = '%';

            }
            field("NHIF NO"; Rec."NHIF NO")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the Employee NHIF No.', Comment = '%';

            }

            field("NSSF NO"; Rec."NSSF NO")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the employee NSSF.NO', Comment = '%';
            }
            field("Yard Branch"; Rec."Yard Branch")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Yard Branch field.', Comment = '%';
            }
            field("ID Number"; Rec."ID Number")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the Employee ID Number.', Comment = '%';

                trigger OnValidate()
                begin

                    if Rec."ID Number" <> '' then
                        Rec.Passport := '';
                    CurrPage.Update();
                end;
            }
            field(Passport; Rec.Passport)
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the Employee Passport.', Comment = '%';
                trigger OnValidate()
                begin

                    if Rec.Passport <> '' then
                        Rec."ID Number" := '';
                    CurrPage.Update();
                end;
            }
        }
        addlast(Payments)
        {
            // field("Basic Pay"; Rec."Basic Pay")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the employee basic pay field.', Comment = '%';
            // }
        }
        addlast("Address & Contact")
        {
            field("Personal Email"; Rec."Personal Email")
            {
                ApplicationArea = All;
                Visible = true;
                ToolTip = 'Specifies the Employee Personal Email.', Comment = '%';

            }
            field("Phone No"; Rec."Phone No.")
            {
                ApplicationArea = All;

                ToolTip = 'Specifies the employee''s telephone number.';
                ExtendedDatatype = PhoneNo;

                trigger OnValidate()
                var
                    TyperHelper: Codeunit "Type Helper";
                begin
                    if not TyperHelper.IsPhoneNumber(Rec."Phone No.") then
                        Error(Rec."Phone No.", PhoneNoCannotContainLettersErr);
                end;

            }


            field("Outstanding Commission"; Rec."Outstanding Commission")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Outstanding Commission.', Comment = '%';
            }
            field("Comision Paid"; Rec."Comision Paid")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the Commission amount paid';
            }

        }


    }

    actions
    {
        addafter(Dimensions)
        {
            separator(Action87)
            {
            }
            action("Employee Details")
            {
                // RunObject = report "Employee Details" ;

                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  Employee details ', Comment = ' %1';
                RunPageMode = View;


            }
        }
    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."ID Number" <> '' then
            Rec.VALIDATE(Passport, '');

        if Rec.Passport <> '' then
            Rec.VALIDATE("ID Number", '');
    end;



    var
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';

}

