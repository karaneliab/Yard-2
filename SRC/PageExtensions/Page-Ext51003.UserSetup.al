pageextension 51003 UserSetup extends "User Setup"
{
     layout
     {
        addafter("User ID")
        {
            field("User Name"; Rec ."Employe Number")
            {
                ApplicationArea = All;

            }
        }
     }
}
