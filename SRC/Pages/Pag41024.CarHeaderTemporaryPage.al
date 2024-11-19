page 41024 "Car Header Temporary Page"
{
    ApplicationArea = All;
    Caption = 'Car Header Temporary Page';
    PageType = List;
    SourceTable = "Car Header Temporary";
    // SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec.no)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(status; Rec.status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(yardbranch; Rec.yardbranch)
                {
                    ToolTip = 'Specifies the value of the Yard Branch field.', Comment = '%';
                }
                field("buyingprice"; Rec."buyingprice")
                {
                    ToolTip = 'Specifies the value of the Buying Price field.', Comment = '%';
                }
                field("date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(description; Rec.description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Last Released Date"; Rec."Last Released Date")
                {
                    ToolTip = 'Specifies the value of the Last Released Date field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetHeaderData)
            {
                Caption = 'Get Header Data';
                Image = DataEntry;
                trigger OnAction()
                var
                    Apis: Codeunit "Car Header API Handling mgmt.";
                    TempCarRec: Record "Car Header Temporary";
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
                    Apis: Codeunit "Car Header API Handling mgmt.";
                begin
                    Apis.PostRecords();
                end;
            }
            action(UpdateRecords)
            {
                Caption = 'Update Car Header Data';
                Image = UpdateDescription;
                trigger onAction()
                var
                    Apis: Codeunit "Car Header API Handling mgmt.";
                begin
                    Apis.PatchRecords(Rec);
                end;
            }
            action(DeleteRecords)
            {
                Caption = 'Delete Car Header  Data';
                Image = Delete;
                trigger onAction()
                var
                    Apis: Codeunit "Car Header API Handling mgmt.";
                begin
                    Apis.DeleteRecords(Rec);
                end;
            }
        }
        area(promoted)
        {
            actionref(get_ref; GetHeaderData) { }
            actionref(post_ref; PostRecords) { }
            actionref(update_ref; UpdateRecords) { }
            actionref(delete_ref; DeleteRecords) { }
        }
    }
    // trigger OnOpenPage()

    // var
    //     Apis: Codeunit "Car Header API Handling mgmt.";
    //     TempCarRec: Record "Car Header Temporary";
    // begin
    //     Apis.GetRecords(TempCarRec);

    //     CurrPage.Update();
    // end;
}
