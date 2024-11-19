page 41101 CarTransactionCard
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Car Transaction Card';
    UsageCategory = Administration;
    SourceTable = "Car Details";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset No.';
                }
                field("Chassis No."; Rec."Chassis No.")
                {
                    ApplicationArea = All;
                }
                field("Make"; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Model"; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ApplicationArea = All;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    ApplicationArea = All;
                }
                field("Sales Date"; Rec."Sales Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Transaction)
    //         {
    //             caption = 'Transaction';
    //             trigger OnAction()
    //             var
    //                 CarTransaction: Codeunit "CarTransaction";
    //                 CarFA: Code[20];
    //                 FixedAsset: Record "Fixed Asset"; // Declare the Fixed Asset record variable
    //             begin
    //                 CarFA := car."FA No."; // Get the FA No. from the current car record

    //                 // Check if FA No. is valid
    //                 if CarFA = '' then
    //                     Error('Please enter a valid Fixed Asset No.');

    //                 // Check if the FA No. exists in the Fixed Asset table
    //                 if not FixedAsset.Get(CarFA) then
    //                     Error('The Fixed Asset No. %1 does not exist.', CarFA);

    //                 // Proceed with transaction if the FA No. is valid
    //                 // CarTransaction.AddTransactionRecord(CarFA, 'Purchase', 0, 0D); // Example call
    //                 CarTransaction.PopulateCarModelList(); // Populate model list if needed
    //                 CarTransaction.PopulateCarPriceDict(); // Populate price dictionary if needed
    //                 // CarTransaction.DisplaySummary(); // Show the cumulative financial summary
    //             end;
    //         }
    //     }
    // }
    actions
    {

        area(Processing)
        {
            action(GetCarDetails)
            {
                ApplicationArea = All;
                Caption = 'Get Car Details';

                trigger OnAction()
                var
                    CarFA: Code[20];
                    CarMake: Text[40];
                    CarModel: Text[40];
                begin
                    // Assuming CarFA is available on the page
                     CarFA := Rec."FA No.";
                    transact.GetCarDetails(CarFA);
                    // CarMake := transact.GetMakeByFA(CarFA);
                    // CarModel := transact.GetModelByFA(CarFA);

                    Message('Car Make: %1, Car Model: %2', CarMake, CarModel);
                end;
            }

        }
    }

    var
        myInt: Integer;
        transact: Codeunit CarTransaction;
        car: Record "Car Details";
        FixedAsset: Record "Fixed Asset";
}