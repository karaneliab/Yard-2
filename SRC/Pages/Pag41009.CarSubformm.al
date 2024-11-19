page 41009 "Car Subformm"
{

    ApplicationArea = All;
    Caption = 'Car Lines List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Car subform Temporary";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(buyingPrice; Rec.buyingPrice)
                {
                    Caption = 'Buying Price';
                }
                field(carMake; Rec.carMake)
                {
                    Caption = 'Car Make';
                }
                field(carModel; Rec.carModel)
                {
                    Caption = 'Car Model';
                }
                field(chassisNumber; Rec.chassisNumber)
                {
                    Caption = 'Chasis Number';
                }
                field(checkedInBy; Rec.checkedInBy)
                {
                    Caption = 'Checked in by.';
                }
                field(countryOfRegistration; Rec.countryOfRegistration)
                {
                    Caption = 'Country Of Registration';
                }
                field(depreciationBook; Rec."Depreciation Book")
                {
                    Caption = 'Depreciation Book';
                }
                field(documentNo; Rec.documentNo)
                {
                    Caption = 'Document No';
                }

                field(receivedFrom; Rec.receivedFrom)
                {
                    Caption = 'Received From';
                }
                field(yardBranch; Rec.yardBranch)
                {
                    Caption = 'Yard Branch';
                }
                field(yearOfMake; Rec."Year of Make")
                {
                    Caption = 'Year of Make';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetLinesData)
            {
                Caption = 'Get Lines Data';
                Image = DataEntry;
                trigger OnAction()
                var
                    Apis: Codeunit "Car Line API Handling Mgmt.";
                    TempCarRec: Record "Car subform Temporary";
                begin
                    Apis.GetRecords(TempCarRec);

                    CurrPage.Update();
                end;
            }
            action(PostRecords)
            {
                Caption = 'Post Car Header Data';
                Image = DataEntry;
                trigger onAction()
                var
                    Apis: Codeunit "Car Line API Handling Mgmt.";
                begin
                    Apis.PostRecords();
                end;
            }
            action(UpdateRecords)
            {
                Caption = 'Update Car Lines Data';
                Image = UpdateDescription;
                trigger onAction()
                var
                    Apis: Codeunit "Car Line API Handling Mgmt.";
                begin
                    Apis.PatchRecords(Rec);
                end;
            }
            action(DeleteRecords)
            {
                Caption = 'Delete Car Lines  Data';
                Image = Delete;
                trigger onAction()
                var
                    Apis: Codeunit "Car Line API Handling Mgmt.";
                begin
                    Apis.DeleteRecords(Rec);
                end;
            }
        }
        area(promoted)
        {
            actionref(get_ref; GetLinesData) { }
            actionref(post_ref; PostRecords) { }
            actionref(update_ref; UpdateRecords) { }
            actionref(delete_ref; DeleteRecords) { }
        }
    }
    // trigger OnOpenPage()

    // var
    //     Apis: Codeunit "Car Line API Handling Mgmt.";
    //     TempCarRec: Record "Car subform Temporary";
    // begin
    //     Apis.GetRecords(TempCarRec);

    //     CurrPage.Update();
    // end;
}
