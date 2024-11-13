codeunit 41006 "Car Line API Handling Mgmt."
{
    procedure SetHeaders(var Content: HttpContent)
    var
        ContentHeaders: HttpHeaders;
    begin
        content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

    end;

    procedure GetAuthorization(Username: Text; Password: Text) Authstring: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
    // UserName: Text;
    // Password: Text;
    begin
        // SetUsernameandPassword(UserName, Password);
        Username := 'Karanell';
        // Password := 'r3p94LHsAJAvq8cahFtufpmLO2XiofS0o/Zt7aD7R';
        Password := 'Karan7884.';
        Authstring := StrSubstNo('%1:%2', Username, Password);
        Authstring := Base64Convert.ToBase64(Authstring);
        Authstring := StrSubstNo('Basic %1', Authstring);
    end;

    procedure GetContentwithHeader(var client: HttpClient) content: HttpContent
    var
        ContentHeaders: HttpHeaders;
    begin
        // if Payload <> '' then
        //     content.WriteFrom(Payload);

        ContentHeaders := client.DefaultRequestHeaders();
        ContentHeaders.Add('Authorization', GetAuthorization(Username, Password));
        ContentHeaders.ADD('Accept', 'Application/json');

    end;

    Procedure SetUsernameandPassword(Username: Text; Password: Text)
    begin
        Username := 'Karanell';
        // Password := 'r3p94LHsAJAvq8cahFtufpmLO2XiofS0o/Zt7aD7R';
        Password := 'Karan7884.';
    end;

    procedure GetRecords(var TempCarRec: Record "Car subform Temporary")
    var
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/ODataV4/Company(''Deft%20Yard'')/carlines';
        client: HttpClient;
        Payload: Text;
    begin
        SetHeaders(Content);
        GetContentwithHeader(client);
        request.Content(Content);
        request.SetRequestUri(TargetUrl);
        request.Method := 'GET';

        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('%1', outputString);
                ParseCarRecords(OutputString, TempCarRec)
            end else
                Error('Error %1', response.ReasonPhrase);
    end;

    procedure PostRecords()
    var
        Content: HttpContent;
        client: HttpClient;
        outputString: Text;
        Payload: Text;
        //http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carHeaders?$expand=carLineS
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/ODataV4/Company(''Deft%20Yard'')/carlines';
    begin
        GetContentwithHeader(client);
        //Content.WriteFrom(GeneratePostPayload());
        SetHeaders(Content);
        request.Content(Content);
        request.SetRequestUri(TargetUrl);
        request.Method := 'POST';

        If client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('%1', outputString);
            end else
                Error('Error %1', response.ReasonPhrase)


    end;

    procedure GeneratePostPayload() Payload: Text
    var
        JsonPayload: JsonObject;
        CarReceivingHeader: Record "Car Recieving Header";
    begin
        // JsonPayload.Add(AssignCarReceivingNo());
        jsonpayload.add('checkedInBy', 'EMP-01002');
        jsonpayload.add('yardBranch', 'LANGATA RD');
        jsonPayload.add('chassisNumber', 'elabtunii');
        JsonPayload.Add('buyingPrice', 14201);
        JsonPayload.Add('receivedFrom', 'VEN-002');
        JsonPayload.Add('carMake', 'MAZDA');
        JsonPayload.Add('documentNo', 'CRN-0009');
        JsonPayload.Add('carModel', 'AXELA');
        JsonPayload.Add('countryOfRegistration', 'KE');
        JsonPayload.WriteTo(Payload);
        Message(Payload)

    end;

    procedure PatchRecords()
    begin

    end;

    procedure DeleteRecords()
    begin

    end;

    procedure ParseCarRecords(OutputString: Text; TempCarTable: Record "Car subform Temporary")
    var
        OdataV4JsonToken: JsonToken;
        ResultToken: JsonToken;
        CarsJson: JsonObject;
        CarsObject: JsonObject;
        CarsArray: JsonArray;
        CarrsToken: JsonToken;
        CarrToken: JsonToken;
        buyingPrice: Decimal;
        documentNo: Code[20];
        carMake: Code[20];
        carModel: Code[20];
        countryOfRegistration: Text[3];
        yardBranch: Text[250];
        chassisNumber: Code[20];
        checkedInBy: Code[20];
        receivedFrom: Code[20];
    begin
        CarsJson.ReadFrom(OutputString);
        if CarsJson.Get('@odata.context', OdataV4JsonToken) then
            if OdataV4JsonToken.AsValue().AsText() <> 'http://desktop-vji7f4v:7048/BC240/ODataV4/$metadata#Company(''Deft%20Yard'')/carlines' then
                exit;
        if CarsJson.Get('value', CarrsToken) then
            if CarrsToken.IsArray() then
                CarsArray := CarrsToken.AsArray();
        foreach carrToken in CarsArray do begin
            // Clear(buyingPrice);
            // Clear(documentNo);
            // Clear(carMake);
            // Clear(carModel);
            // Clear(yardBranch);
            // Clear(countryOfRegistration);
            // Clear(chassisNumber);
            // Clear(checkedInBy);

            CarsObject := CarrToken.AsObject();

            CarsObject.Get('yardBranch', ResultToken);
            yardBranch := ResultToken.AsValue().AsText();

            CarsObject.Get('carModel', ResultToken);
            carModel := ResultToken.AsValue().AsCode();


            CarsObject.Get('carMake', ResultToken);
            carMake := ResultToken.AsValue().AsCode();

            CarsObject.Get('countryOfRegistration', ResultToken);
            countryOfRegistration := ResultToken.AsValue().AsText();

            CarsObject.Get('buyingPrice', ResultToken);
            buyingPrice := ResultToken.AsValue().AsDecimal();

            CarsObject.Get('documentNo', ResultToken);
            documentNo := ResultToken.AsValue().AsCode();
            CarsObject.Get('receivedFrom', ResultToken);
            receivedFrom := ResultToken.AsValue().AsCode();
            WriteInDb(checkedInBy, chassisNumber, receivedFrom, yardBranch, documentNo, carMake, carModel, buyingPrice, countryOfRegistration,
                     TempCarTable);
             Message('ALL IS UPTO HERE')
        end;
    end;

    local Procedure WriteInDb(var checkedInBy: Code[20]; var chassisNumber: Code[20];var receivedFrom: Code[20]; var yardBranch: Text[250]; 
                              var documentNo: Code[20]; var carMake: Code[20];var carModel: Code[20]; var buyingPrice: Decimal;
                              var countryOfRegistration: Text[3]; var TempCarTable: Record "Car subform Temporary")
    var
    begin
        TempCarTable.Init();
        TempCarTable.Validate(documentNo, documentNo);
        TempCarTable.Validate(yardbranch, yardbranch);
        TempCarTable.Validate(receivedFrom, receivedFrom);
        TempCarTable.Validate(checkedInBy, checkedInBy);
        TempCarTable.Validate("buyingPrice", buyingPrice);
        TempCarTable.Validate(chassisNumber, chassisNumber);
        TempCarTable.Validate(countryOfRegistration, countryOfRegistration);
        TempCarTable.Validate("carMake", carMake);
        TempCarTable.Validate(carModel, carModel);
        if TempCarTable.Insert(True) then
            Message('Header Details inserted suceesfully')


    end;





    var
        client: HttpClient;
        response: HttpResponseMessage;
        request: HttpRequestMessage;
        outputString: Text;
        UserName: Text[100];
        Password: Text[100];
        RequestHeaders: HttpHeaders;
        Base64Convert: Codeunit "Base64 Convert";
        AuthValue: text;
        Content: HttpContent;
}
