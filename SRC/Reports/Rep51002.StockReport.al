
report 41002 "Stock Report"
{
    ApplicationArea = All;
    Caption = 'Stock Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Reports/Rep51002.StockReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "Responsible Employee", Acquired, "Global Dimension 1 Code";
            column(RegNo; RegNo)
            {
            }

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Logo; CompanyInformation.Picture)
            {

            }
            Column(Address; CompanyInformation.Address)
            {
                IncludeCaption = true;
            }
#pragma warning disable AL0432
            Column(Home_Page; CompanyInformation."Home Page")
#pragma warning restore AL0432
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
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(YearofManufacture; Format("Year of Manufacture", 0, 4))
            {
            }
            column(Country_Of_First_Registration; "Country Of First Registration")
            {

            }
            column(InsuaranceCompany; "Insurance Company")
            {
            }
            column(CarInsured; "Car Insured")
            {
            }
            column(ChassisNo; ChassisNo)
            {
            }
            column("Branch"; "FA Location Code")
            {

            }
            column(Acquisition_cost; "AcquisitionCost")
            {

            }

            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLink = "FA No." = Field("FA No.");
                DataItemLinkReference = "FA Ledger Entry";
                column(FA_Posting_Category; "FA Posting Category")
                {

                }
                column(Part_of_Book_Value; "Part of Book Value")
                {

                }
            }
        }

    }

    labels
    {
        Title = 'Yard Management Stock Report';
    }
    var
        Title: Label 'Stock Report';

        CompanyInformation: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);


    end;
}

