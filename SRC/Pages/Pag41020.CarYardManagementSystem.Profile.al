
page 41020 "Car Yard Management "
{
    PageType = RoleCenter;
    Caption = 'Car Yard Management Role Center';
    ApplicationArea = Basic, Suite;


    layout
    {
        area(RoleCenter)
        {
            part(Approvals; "Approvals Activities")
            {
                ApplicationArea = All;
            }


            part("PostedSalesInvoice"; "Posted Sales Invoice Subform")
            {
                ApplicationArea = All;

            }
            part("Car subform"; "Car Subform")
            {
                ApplicationArea = All;
            }


        }
    }

    actions
    {
        area(Embedding)
        {
            action("Car r&eceipt List")
            {
                RunObject = Page "Recieving List";
                ApplicationArea = All;

                Caption = 'Car receipt List';

            }
        }
        area(Creation)
        {
            separator(Action87)
            {
            }
            action("S&ales Order")
            {
                RunObject = Page "Sales Order";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new sales order ', Comment = ' %1';
                RunPageMode = Create;

            }
            action("P&urchase Order")
            {
                RunObject = Page "Purchase Order";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new purchase order ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("car receiving card")
            {
                RunObject = Page "Car Receiving Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new receiving card ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("E&mployees")
            {
                RunObject = Page "Employee Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new employee ', Comment = ' %1';
                RunPageMode = Create;

            }
            separator(Action97)
            {
            }
            action("Cust&omers")
            {
                RunObject = Page "Customer Card";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies  new customer ', Comment = ' %1';
                RunPageMode = Create;
            }
            action("V&endors")
            {
                RunObject = Page "Vendor Card";
                ApplicationArea = All;
                Tooltip = 'Specifies new vendor', Comment = '%1';
                RunPageMode = Create;
            }
            action("Purchase&Invoices")
            {
                RunObject = Page "Purchase Invoice";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies new purchase invoice', Comment = '%1';
                RunPageMode = Create;
            }
            action("SalesInvoice")
            {
                RunObject = Page "Sales Invoice List";
                ApplicationArea = Basic, Suite;
                Tooltip = 'Specifies new purchase invoice', Comment = '%1';
                RunPageMode = Create;
            }
            action("Fixed Assets")
            {
                ApplicationArea = All;
                RunObject = Page "Fixed Asset List";
                RunPageMode = View;
                ToolTip = 'Specifies new fixed assets';
            }
        }
        area(Sections)
        {
            

            group("Assets Management")
            {
                Caption = 'Assets Management';
                action("Fix&ed Assets")
                {
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixed Assets';

                }
            }

            group("Purchase Management")
            {
                action(Vendors)
                {
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                }

                action("Purchase Order")
                {
                    RunObject = Page "Purchase Order";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order';
                    ToolTip = 'Defines a list of all purchase orders made';

                }
                group("Receipts")
                {
                    action("Car receipt List")
                    {
                        RunObject = Page "Recieving List";
                        ApplicationArea = All;

                        Caption = 'Car receipt List';

                    }
                    action("Open Receipt List")
                    {
                        RunObject = Page "Recieving List";
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Receipt List';
                        RunPageLink = Status = const(Open);
                        RunPageMode = View;

                    }
                    action("Car Receipt List Pending Approval")
                    {
                        // RunObject = Page "Posted Purchase Invoices";
                        ApplicationArea = All;
                        RunObject = Page "Recieving List";
                        Caption = 'Car Receipt List Pending Approval';
                        ToolTip = 'Specifes the cars receipt list of Pending Approval';
                        RunPageLink = Status = const("Pending Approval");
                        RunPageMode = View;
                    }
                    action("Approved Receipt List")
                    {
                        RunObject = Page "Recieving List";
                        ApplicationArea = All;
                        RunPageLink = Status = Const(Approved);
                        RunPageMode = View;
                        Caption = 'Approved Receipt List';
                        ToolTip = 'Specifies the Approved Receipt list';
                    }

                    action("Posted Car Receipt List")
                    {
                        RunObject = Page "Posted Purchase Invoice Lines";
                        ApplicationArea = All;
                        RunPageLink = Type = CONST("Fixed Asset");
                        Caption = 'Posted Car Receipt List';
                        ToolTip = 'Specifies the Posted car receipt list';
                    }


                }


                action("Purchase Invoce")
                {
                    RunObject = Page "Purchase Invoices";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice';
                    Image = SalesInvoice;
                    ToolTip = 'View a list of all sales invoices and their status, including the date posted';

                }
                action("Open Purchase Invoices")
                {
                    RunObject = Page "Purchase Invoices";
                    RunPageLink = Status = const(Open);
                    Caption = 'Open Purchase Invoices';
                    ToolTip = 'Specifies the Open Purchase Invoices';
                }
                action("Car Receiving")
                {
                    RunObject = Page "Car Receiving Card";
                    Caption = 'Car Receiving Card';

                }

                action("Posted Purchase Invoices")
                {
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                }

            }
            group("Sales Management")
            {
                action("Sales Invoce")
                {
                    RunObject = Page "Sales Invoice List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice';
                    Image = SalesInvoice;
                    ToolTip = 'View a list of all sales invoices and their status, including the date posted';

                }
                action("Sales Credit Memo")
                {
                    RunObject = Page "Sales Credit Memo";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memo';
                    Image = SalesCreditMemo;
                    ToolTip = 'View a list of all sales credit memos and their status, including thedate posted';
                }
                action("Sales Order")
                {
                    RunObject = Page "Sales Order";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    ToolTip = 'Defines a list of all sales orders made';
                }

                action("Posted Sales invoices")
                {
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                }
                action("Customers")
                {
                    RunObject = Page "Customer List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';

                    ToolTip = 'View a list of all customers and their contact information, including addresses, phone';
                }
                action("Posted Sales")
                {
                    RunObject = Page "Posted Sales Invoice Lines";

                }

            }


            group("S&etup")
            {
                action("Car Make")
                {
                    RunObject = Page "Car Make setup";
                    Caption = 'Car Make';
                    ApplicationArea = All;
                }
                action("Car Model")
                {
                    RunObject = Page "Car Model";
                    ApplicationArea = All;
                    Caption = 'Car Model';
                    Tooltip = 'Setup Car Model';

                }

                // action("Insuarance Company")
                // {
                //     RunObject = Page "Insuarance Company List";
                //     Caption = 'Insuarance company list';
                //     ToolTip = 'Specifies the car Insurance company';
                // }


                action("General &Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                }
                action("&Fixed Asset Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                }


            }
            group("Yard Employees")
            {
                action("Employees")
                {
                    RunObject = Page "Employee List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employees';
                }


            }
            group("Yard Reports")
            {
                // Visible = false;
                action("Employee Report")
                {
                    RunObject = report "Employee Details";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Report';
                }
                action("Commission Report")
                {
                    RunObject = report "Commission Report";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commission Report';
                }
                action("Stock Report")
                {
                    RunObject = report "Stock Report";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Report';
                }
            }

        }

    }
}
profile "Car Yard Management System"
{
    Caption = 'Deft Yard Management';
    RoleCenter = "Car Yard Management ";


}