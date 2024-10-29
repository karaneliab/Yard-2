xmlport 41001 "Import Car Details"
{
    Caption = 'Import Car Details';
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement(CarLine; "Car Line")
            {
                XmlName = 'CarLine';
                AutoReplace = false;



                fieldelement(RegNo; CarLine.RegNo)
                {

                }

                fieldelement(YardBranch; CarLine.YardBranch)
                {

                }
                fieldelement(Checked_in_By; CarLine."Checked In By")
                {

                }
                fieldelement(Car_Make; CarLine."Car Make")
                {

                }
                fieldelement(Car_Model; CarLine."Car Model")
                {

                }
                fieldelement(Buying_Price; CarLine."Buying Price")
                {

                }
                fieldelement(ChasisNo; CarLine."Chassis Number")
                {

                }
                fieldelement(Rereceived_From; CarLine."Received From")
                {

                }
                fieldelement(Year_of_Make; CarLine."Year of Make")
                {

                }
                fieldelement(Origin; CarLine."Country Of Registration")
                {

                }


                trigger OnAfterInitRecord()
                begin
                    if CaptionRow then begin
                        CaptionRow := false;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    // CarLine."Document No." := DocumentNo;
                    if CarLine.Get(CarLine.RegNo, DocumentNo, CarLine.YardBranch, CarLine."Chassis Number") then begin

                        CurrXMLPort.Skip();
                    end else begin
                        CarLine."Document No." := DocumentNo;
                    end;

                end;


            }
        }
    }

    var
        CaptionRow: Boolean;
        DocumentNo: Code[20];


    trigger OnInitXmlPort()
    begin
        CaptionRow := true;
    end;


    procedure GetDocNo(DocNo: Code[20])
    begin
        DocumentNo := DocNo;
    end;

}
