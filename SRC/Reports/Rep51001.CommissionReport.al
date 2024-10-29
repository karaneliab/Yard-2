
report 41001 "Commission Report"
{
    ApplicationArea = All;
    Caption = 'Commission Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/Rep51001.CommissionReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(department; "Yard Branch")
            {

            }
            // column(Commission; "Comision Paid")
            // {

            // }
            column("OutStanding"; "Outstanding Commission")
            {

            }
            column(Logo; CompanyInformation.Picture)
            {

            }
            Column(Address; CompanyInformation.Address)
            {
                IncludeCaption = true;
            }
            Column(Home_Page; CompanyInformation."Home Page")
            {
                IncludeCaption = true;
            }
            Column(City; CompanyInformation.City)
            {
                IncludeCaption = true;
            }
            Column(Phone_Number; CompanyInformation."Phone No.")
            {
                IncludeCaption = true;
            }
            column(Mailing; CompanyInformation."E-Mail")
            {
                IncludeCaption = true;
            }

            column(Postal_Code; CompanyInformation."Post Code")
            {

            }
            // dataitem(CarLine; "Car Line")
            // {
            //     DataItemLink = "Checked In By" = field("No.");
            //     DataItemLinkReference = Employee;


            //     RequestFilterFields = "Checked In By";
            //     column(Commission_Amount; "Commission Amount")
            //     {

            //     }
            // }
            // dataitem("Sales Invoice";"Sales Line")
            // {
            //     // DataItemLink = "No." = field("Yard Branch");
            //     DataItemLink = "Shortcut Dimension 1 Code" = field("Yard Branch");
            //     // DataItemLinkReference = Employee;
            //     column(Commission;Commission)
            //     {

            //     }

            // }
            dataitem("Commission Ledger Entries"; "Commission Ledger Entries")
            {
                DataItemLink = "Branch" = FIELD("Yard Branch");
                DataItemLinkReference = Employee;
                column(CommissionAmount; CommissionAmount)
                {
                    IncludeCaption = true;
                }

            }

        }

    }
    labels
    {
        Title = 'Commision Report';
    }


    var

        Title: Label 'commission  Report';

        CompanyInformation: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);


    end;

}
