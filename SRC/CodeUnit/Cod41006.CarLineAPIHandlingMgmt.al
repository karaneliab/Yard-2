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

    begin
        Username := 'Karanell';
        Password := 'Karan7884.';
        Authstring := StrSubstNo('%1:%2', Username, Password);
        Authstring := Base64Convert.ToBase64(Authstring);
        Authstring := StrSubstNo('Basic %1', Authstring);
    end;

    procedure GetContentwithHeader(var client: HttpClient) content: HttpContent
    var
        ContentHeaders: HttpHeaders;
    begin
        ContentHeaders := client.DefaultRequestHeaders();
        ContentHeaders.Add('Authorization', GetAuthorization(Username, Password));
        ContentHeaders.ADD('Accept', 'Application/json');

    end;

    Procedure SetUsernameandPassword(Username: Text; Password: Text)
    begin
        Username := 'Karanell';
        Password := 'Karan7884.';
    end;

    procedure GetRecords(var TempCarRec: Record "Car subform Temporary")
    var
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carLines';
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
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/api/defttech/karan/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carLineCustoms';
    begin
        GetContentwithHeader(client);
        Content.WriteFrom(GeneratePostPayload());
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
        JsonPayload.Add('buyingPrice', 142111);
        JsonPayload.Add('receivedFrom', 'VEN-002');
        JsonPayload.Add('carMake', 'MAZDA');
        JsonPayload.Add('documentNo', 'CRN-0012');
        JsonPayload.Add('carModel', 'AXELA');
        JsonPayload.Add('countryOfRegistration', 'UG');
        JsonPayload.WriteTo(Payload);
        Message(Payload)

    end;

    procedure PatchRecords(TempCarTable: Record "Car subform Temporary")
    var
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/api/defttech/karan/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carLineCustoms(%1)';
        Content: HttpContent;
        client: HttpClient;
        outputString: Text;
        Payload: Text;
        Header: HttpHeaders;
    begin
        GetContentwithHeader(client);
        Content.WriteFrom(GeneratePutPayload());
        SetHeaders(Content);
        request.Content(Content);
        request.GetHeaders(Header);
        Header.Clear();
        Header.Add('If-Match', '*');
        request.SetRequestUri(StrSubstNo(TargetUrl, delchr(Format(TempCarTable.SystemId), '<>', '{}')));
        request.Method := 'PUT';
        if client.send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(OutputString);
                Message('%1',outputString);
            end else
               Error('Error %1', response.ReasonPhrase);

            end;

    local procedure GeneratePutPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        jsonpayload.add('checkedInBy', 'EMP-01002');
        jsonpayload.add('yardBranch', 'LANGATA RD');
        JsonPayload.Add('buyingPrice', 1010101);
        JsonPayload.Add('receivedFrom', 'VEN-002');
        JsonPayload.Add('carMake', 'HYUNDAI');
        JsonPayload.Add('documentNo', 'CRN-0012');
        JsonPayload.Add('carModel', 'SANTA FE');
        JsonPayload.Add('countryOfRegistration', 'KE');
        JsonPayload.WriteTo(Payload);
        Message(Payload)
    end;

    procedure DeleteRecords(TempCarTable: Record "Car subform Temporary")
    var
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/api/defttech/karan/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carLineCustoms(%1)';
        Content: HttpContent;
        client: HttpClient;
        outputString: Text;
        Payload: Text;
        Header: HttpHeaders;
    begin
        GetContentwithHeader(client);
        SetHeaders(Content);
         request.Content(Content);
        request.GetHeaders(Header);
        Header.Clear();
        Header.Add('If-Match', '*');
        request.SetRequestUri(StrSubstNo(TargetUrl, delchr(Format(TempCarTable.SystemId), '<>', '{}')));
        request.Method := 'DELETE';
        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('Deleted successfully %1', TempCarTable.chassisNumber);

            end else
                Error('Error %1', response.ReasonPhrase);
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
        yardBranch: Code[20];
        chassisNumber: Code[20];
        checkedInBy: Code[20];
        receivedFrom: Code[20];
    begin
        CarsJson.ReadFrom(OutputString);
        if CarsJson.Get('@odata.context', OdataV4JsonToken) then
            if OdataV4JsonToken.AsValue().AsText() <> 'http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/$metadata#companies(160d44f3-009d-ef11-be11-8c1645648b83)/carLines' then
                exit;
        if CarsJson.Get('value', CarrsToken) then
            if CarrsToken.IsArray() then
                CarsArray := CarrsToken.AsArray();
        foreach carrToken in CarsArray do begin
            Clear(buyingPrice);
            Clear(documentNo);
            Clear(carMake);
            Clear(carModel);
            Clear(yardBranch);
            Clear(countryOfRegistration);
            Clear(chassisNumber);
            Clear(checkedInBy);

            CarsObject := CarrToken.AsObject();

            CarsObject.Get('yardBranch', ResultToken);
            yardBranch := ResultToken.AsValue().AsText();
            Message('ALL IS UPTO branch');

            CarsObject.Get('carModel', ResultToken);
            carModel := ResultToken.AsValue().AsCode();
            Message('ALL IS UPTO Model');

            CarsObject.Get('chassisNumber', ResultToken);
            chassisNumber := ResultToken.AsValue().AsCode();


            CarsObject.Get('carMake', ResultToken);
            carMake := ResultToken.AsValue().AsCode();

            CarsObject.Get('countryOfRegistration', ResultToken);
            countryOfRegistration := ResultToken.AsValue().AsText();

            CarsObject.Get('buyingPrice', ResultToken);
            buyingPrice := ResultToken.AsValue().AsDecimal();
            Message('ALL IS UPTO Price');

            CarsObject.Get('documentNo', ResultToken);
            documentNo := ResultToken.AsValue().AsCode();

            CarsObject.Get('receivedFrom', ResultToken);
            receivedFrom := ResultToken.AsValue().AsCode();
            WriteInDb(checkedInBy, chassisNumber, receivedFrom, yardBranch, documentNo, carMake, carModel, buyingPrice, countryOfRegistration,
                     TempCarTable);
            Message('ALL IS UPTO HERE')
        end;
    end;

    local Procedure WriteInDb(var checkedInBy: Code[20]; var chassisNumber: Code[20]; var receivedFrom: Code[20]; var yardBranch: Code[20];
                              var documentNo: Code[20]; var carMake: Code[20]; var carModel: Code[20]; var buyingPrice: Decimal;
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
