xmlport 41002 "Export Car Details"
{
    Caption = 'Export Car Details';
    Direction = Export;
    Format = VariableText;
    UseRequestPage = true;
    TableSeparator = '';


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(CarLine; "Car Line")
            {
                XmlName = 'CarLine';
                RequestFilterFields = "Chassis Number";


                fieldelement(CarInsured; CarLine."Car Insured")
                {
                }
                fieldelement(CarMake; CarLine."Car Make")
                {
                }
                fieldelement(CarModel; CarLine."Car Model")
                {
                }
                fieldelement(Received_From; CarLine."Received From")
                {

                }
                fieldelement(Chassis_No; CarLine."Chassis Number")
                {

                }
                fieldelement(YardBranch; CarLine.YardBranch)
                {

                }
                fieldelement(Year_of_Make; CarLine."Year of Make")
                {

                }
                fieldelement(RegNo; CarLine.RegNo)
                {

                }
            }
        }
    }
  
}
