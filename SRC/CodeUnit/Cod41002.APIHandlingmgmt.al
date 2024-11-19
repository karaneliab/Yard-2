codeunit 41002 "Car Header API Handling mgmt."
{

    procedure SetHeaders(var Content: HttpContent)
    var
        ContentHeaders: HttpHeaders;
    begin
        content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');


    end;

    procedure GetRecords(var TempCarRec: Record "Car Header Temporary")
    var
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/ODataV4/Company(''Deft%20Yard'')/carheader';
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
                ParseCarRecords(OutputString, TempCarRec);

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
        //http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/
        TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carheads';
    begin

        GetContentwithHeader(client);
        Content.WriteFrom(GeneratePostPayload());
        SetHeaders(Content);
        request.Content(Content);

        request.SetRequestUri(TargetUrl);
        request.Method := 'POST';

        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('%1', outputString);

            end else
                Error('Error %1', response.ReasonPhrase);

    end;



    procedure GeneratePostPayload() Payload: Text
    var
        JsonPayload: JsonObject;
        CarReceivingHeader: Record "Car Recieving Header";
    begin
        // JsonPayload.Add(AssignCarReceivingNo());
        jsonpayload.add('No', 'crn-0002');
        // jsonpayload.add('YardBranch', '');
        jsonPayload.add('Description', 'eliab tunoiii');
        JsonPayload.Add('BuyingPrice', 13201);
        JsonPayload.Add('Status', 'Created');
        JsonPayload.Add('Date', '2024-12-12');
        JsonPayload.WriteTo(Payload);
        Message(Payload)

    end;

    procedure PatchRecords(CarTable: Record "Car Header Temporary")
    var
        Content: HttpContent;
        client: HttpClient;
        outputString: Text;
        Payload: Text;
        Header: HttpHeaders;
        targetUrl: label 'http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carheads(%1)';
    //TargetUrl: Label 'http://desktop-vji7f4v:7048/BC240/ODataV4/Company(''Deft%20Yard'')/carheaderspost(%1)';

    begin
        GetContentwithHeader(client);
        Content.WriteFrom(GeneratePutPayload());
        SetHeaders(Content);
        request.Content(Content);
        request.GetHeaders(Header);
        Header.Clear();
        Header.Add('If-Match', '*');
        request.SetRequestUri(StrSubstNo(TargetUrl, delchr(Format(CarTable.SystemId), '<>', '{}')));
        request.Method := 'PUT';
        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('%1', outputString);

            end else
                Error('Error %1', response.ReasonPhrase);

    end;

    local procedure GeneratePutPayload() Payload: Text
    var
        JsonPayload: JsonObject;
    begin
        //JsonPayload.add('No', 'crn-0001');
        jsonPayload.add('description', 'Tunoii Karanja');
        JsonPayload.Add('buyingprice', 13120);
        JsonPayload.Add('date', '2024-12-12');
        JsonPayload.Add('status', 'Created');
        JsonPayload.WriteTo(Payload);
        Message(Payload)

    end;

    procedure DeleteRecords(CarTable: Record "Car Header Temporary")
    var
        Content: HttpContent;
        client: HttpClient;
        outputString: Text;
        Payload: Text;
        Header: HttpHeaders;
        //http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carHeaders?$expand=carLines
        TargetUrl: label 'http://desktop-vji7f4v:7048/BC240/api/publisherName/apiGroup/v2.0/companies(160d44f3-009d-ef11-be11-8c1645648b83)/carheads(%1)';
    begin
        GetContentwithHeader(client);
        SetHeaders(Content);
        request.Content(Content);
        request.GetHeaders(Header);
        Header.Clear();
        Header.Add('If-Match', '*');
        request.SetRequestUri(StrSubstNo(TargetUrl, delchr(Format(CarTable.SystemId), '<>', '{}')));
        request.Method := 'DELETE';
        if client.Send(request, response) then
            if response.IsSuccessStatusCode() then begin
                response.Content.ReadAs(outputString);
                Message('Deleted successfully %1', CarTable.description);

            end else
                Error('Error %1', response.ReasonPhrase);


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
        ContentHeaders.ADD('Accept', 'application/json');

    end;

    Procedure SetUsernameandPassword(Username: Text; Password: Text)
    begin
        Username := 'Karanell';
        // Password := 'r3p94LHsAJAvq8cahFtufpmLO2XiofS0o/Zt7aD7R';
        Password := 'Karan7884.';
    end;

    local procedure ParseCarRecords(OutputString: Text; TempCarTable: Record "Car Header Temporary")
    var
        OdataV4JsonToken: JsonToken;
        ResultToken: JsonToken;
        CarsJson: JsonObject;
        CarsObject: JsonObject;
        CarsArray: JsonArray;
        CarrsToken: JsonToken;
        CarrToken: JsonToken;
        buyingPrice: Decimal;
        no: Code[20];
        description: Text[250];
        date: Date;
        YardBranch: Text[250];
        status: Text[250];
    begin
        CarsJson.ReadFrom(OutputString);
        if CarsJson.Get('@odata.context', OdataV4JsonToken) then
            if OdataV4JsonToken.AsValue().AsText() <> 'http://desktop-vji7f4v:7048/BC240/ODataV4/$metadata#Company(''Deft%20Yard'')/carheader' then
                exit;
        if CarsJson.Get('value', CarrsToken) then
            if CarrsToken.IsArray() then
                CarsArray := CarrsToken.AsArray();
        foreach carrToken in CarsArray do begin
            Clear(buyingPrice);
            Clear(no);
            Clear(description);
            Clear(date);
            // Clear(YardBranch);
            Clear(status);
            CarsObject := CarrToken.AsObject();
            Message('ALL IS UPTO Conversion');

            // CarsObject.Get('yardBranch', ResultToken);
            // YardBranch := ResultToken.AsValue().AsText();

            CarsObject.Get('status', ResultToken);
            status := ResultToken.AsValue().AsText();
            Message('ALL IS UPTO status');


            CarsObject.Get('date', ResultToken);
            date := ResultToken.AsValue().AsDate();
            Message('ALL IS UPTO Date');

            CarsObject.Get('description', ResultToken);
            description := ResultToken.AsValue().AsText();

            CarsObject.Get('buyingPrice', ResultToken);
            buyingPrice := ResultToken.AsValue().AsDecimal();

            CarsObject.Get('no', ResultToken);
            no := ResultToken.AsValue().AsCode();

            WriteInDb(no, date, status, buyingPrice, description, TempCarTable);
            Message('ALL IS UPTO HERE')
        end;



    end;

    local Procedure WriteInDb(no: Code[20]; date: Date; status: Text[250]; buyingPrice: Decimal; var description: Text[250]; var TempCarTable: Record "Car Header Temporary")
    var
    // CarTable: Record "Car Header Temporary" temporary;

    begin

        // if CarTable.Get(No) then
        //     exit;

        TempCarTable.Init();
        TempCarTable.Validate(no, no);
        // TempCarTable.Validate(yardbranch, YardBranch);
        TempCarTable.Validate(date, date);
        TempCarTable.Validate(status, status);
        TempCarTable.Validate("buyingPrice", buyingPrice);
        TempCarTable.Validate(description, description);
        if TempCarTable.Insert(True) then
            Message('Header Details inserted suceesfully')
        // Clear(No);
        // Clear(YardBranch);
        // Clear(Date);
        // Clear(Status);
        // Clear(BuyingPrice);
        // Clear(Description);

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
