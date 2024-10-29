// codeunit 51007 CarTransaction
// {

//     var
//         CarFANoArray: array[10] of Code[20];
//         CarModelList: List of [Text[40]];
//         CarPriceDict: Dictionary of [Code[20], Decimal];
//         TransactionList: List of [Code[20]];
//         CarMakeList: List of [Text[40]];
//         PurchasePriceDict: Dictionary of [Code[20], Decimal]; // For storing purchase prices by FA No.
//         PurchaseDateDict: Dictionary of [Code[20], Date];


//     procedure InitializeTransactions()
//     begin

//         PopulateCarModelList();
//         PopulateCarPriceDict()
//     end;

//     procedure PopulateCarArray()
//     var
//         CarDetails: Record "Car Details";
//         i: Integer;
//     begin
//         i := 1;
//         if CarDetails.FindSet() then
//             repeat
//                 if i <= ArrayLen(CarFANoArray) then
//                     CarFANoArray[i] := CarDetails."FA No.";
//                 i += 1;
//             until (CarDetails.Next() = 0) or (i > ArrayLen(CarFANoArray))
//     end;

//     procedure PopulateCarModelList()
//     var
//         CarDetails: Record "Car Details";
//     begin
//         if CarDetails.FindSet() then
//             repeat
//                 CarModelList.Add(CarDetails.Model);
//             until CarDetails.Next() = 0;
//     end;


//     // Populate Sales Price and Date

//     procedure PopulateCarPriceDict()
//     var
//         CarDetails: Record "Car Details";
//     begin
//         if CarDetails.FindSet() then
//             repeat
//                 CarPriceDict.Add(CarDetails."FA No.", CarDetails."Sales Price");
//             until CarDetails.Next() = 0;
//     end;


//     procedure AddTransactionRecord(CarFA: Code[20]; TransactionType: Text[10]; PurchasePrice: Decimal; PurchaseDate: Date)
//     var

//     begin

//         if TransactionType = 'Purchase' then begin
//                PurchasePriceDict.Add(CarFA, PurchasePrice); 
//             PurchaseDateDict.Add(CarFA, PurchaseDate);

//         end;

//     end;


//     procedure CalculateCumulativeFinancialSummary(): Decimal
//     var
//         TotalAmount: Decimal;
//         CarFA: Code[20];
//     begin
//         TotalAmount := 0;

//         foreach CarFA in TransactionList do begin
//             // Use the price dictionary to calculate total amount based on FA No.
//             if CarPriceDict.ContainsKey(CarFA) then
//                 TotalAmount += CarPriceDict.Get(CarFA);
//         end;

//         exit(TotalAmount);
//     end;


//     procedure DisplaySummary()
//     var
//         TotalPurchaseAmount: Decimal;
//         CarFA: Code[20];
//         Price: Decimal;
//     begin
//         TotalPurchaseAmount := 0;

//         foreach CarFA in PurchasePriceDict.Keys() do begin
//             // Use TryGetValue to retrieve the price for the given FA No.
//             if PurchasePriceDict.Get(CarFA, Price) then
//                 TotalPurchaseAmount += Price;
//         end;

//         Message('Cumulative Financial Summary: %1', TotalPurchaseAmount);
//     end;

//     var
//         myInt: Integer;
// }

codeunit 41007 CarTransaction
{
    var
        CarFANoArray: array[10] of Code[20]; 
        CarModelList: List of [Text[40]]; 
        CarPriceDict: Dictionary of [Code[20], Decimal]; 
        CarMakeList: List of [Text[40]]; 
        PurchasePriceDict: Dictionary of [Code[20], Decimal]; 
        PurchaseDateDict: Dictionary of [Code[20], Date]; 
        ChassisDict: Dictionary of [Code[20], Code[40]]; 

    procedure InitializeTransactions()
    begin
        PopulateCarArray();
        PopulateCarModelList();
        PopulateCarPriceDict();
        PopulateCarMakeList();
        PopulatePurchasePriceDict();
        PopulateChassisDict();
    end;

    procedure PopulateCarArray()
    var
        CarDetails: Record "Car Details";
        i: Integer;
    begin
        i := 1;
        if CarDetails.FindSet() then
            repeat
                if i <= ArrayLen(CarFANoArray) then
                    CarFANoArray[i] := CarDetails."FA No.";
                i += 1;
            until (CarDetails.Next() = 0) or (i > ArrayLen(CarFANoArray));
    end;

    procedure PopulateCarModelList()
    var
        CarDetails: Record "Car Details";
    begin
        if CarDetails.FindSet() then
            repeat
                CarModelList.Add(CarDetails.Model);
            until CarDetails.Next() = 0;
    end;

   

    procedure PopulateCarMakeList()
    var
        CarDetails: Record "Car Details";
    begin
        if CarDetails.FindSet() then
            repeat
                CarMakeList.Add(CarDetails.Make);
            until CarDetails.Next() = 0;
    end;

    procedure PopulateCarPriceDict()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        if SalesInvoiceLine.FindSet() then
            repeat
                CarPriceDict.Add(SalesInvoiceLine."No.", SalesInvoiceLine."Unit Price");
            until SalesInvoiceLine.Next() = 0;
    end;

    procedure PopulatePurchasePriceDict()
    var
        FixedAssetRec: Record "Fixed Asset";
    begin
        if FixedAssetRec.FindSet() then
            repeat
                PurchasePriceDict.Add(FixedAssetRec."No.", FixedAssetRec."Buying Price"); 
            until FixedAssetRec.Next() = 0;
    end;

    procedure PopulateChassisDict()
    var
        FixedAssetRec: Record "Fixed Asset";
    begin
        if FixedAssetRec.FindSet() then
            repeat
                ChassisDict.Add(FixedAssetRec."No.", FixedAssetRec."ChassisNo");
            until FixedAssetRec.Next() = 0;
    end;

    procedure GetChassisNoByFANo(FA_No: Code[20]): Code[40]
    var
        ChassisNo: Code[40];
    begin
        if ChassisDict.Get(FA_No, ChassisNo) then
            exit(ChassisNo)
        else
            exit(''); 
    end;
    procedure GetCarDetails(CarFA: Code[20])
    var
        Model: Text[40];
        Make: Text[40];
        ChassisNo: Code[40];
        PurchasePrice: Decimal;
        SalesPrice: Decimal;
    begin
        if CarPriceDict.Get(CarFA, SalesPrice) then
            Message('Sales Price found: %1', SalesPrice)
        else
            Error('Sales Price for FA No. %1 not found in CarPriceDict', CarFA);

        if PurchasePriceDict.Get(CarFA, PurchasePrice) then
            Message('Purchase Price found: %1', PurchasePrice)
        else
            Error('Purchase Price for FA No. %1 not found in PurchasePriceDict', CarFA);

        if ChassisDict.Get(CarFA, ChassisNo) then
            Message('Chassis No. found: %1', ChassisNo)
        else
            Error('Chassis No. for FA No. %1 not found in ChassisDict', CarFA);

        Model := GetModelByFA(CarFA);
        Make := GetMakeByFA(CarFA);

        Message('Car Details:\nFA No.: %1\nModel: %2\nMake: %3\nChassis No.: %4\nPurchase Price: %5\nSales Price: %6',
                CarFA, Model, Make, ChassisNo, PurchasePrice, SalesPrice);


    end;
  

    procedure GetModelByFA(FANo: Code[20]): Text[40]
    var
        FixedAssetRec: Record "Fixed Asset";
    begin
        if FixedAssetRec.Get(FANo) then
            exit(FixedAssetRec.Model)
        else
            Error('Car details for FA No. %1 not found.', FANo);
    end;

    procedure GetMakeByFA(FANo: Code[20]): Text[40]
    var
        FixedAssetRec: Record "Fixed Asset";
    begin
        if FixedAssetRec.Get(FANo) then
            exit(FixedAssetRec."Car Make")
        else
            Error('Car details for FA No. %1 not found.', FANo);
    end;



    procedure IndexOfFA(CarFA: Code[20]): Integer
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(CarFANoArray) do
            if CarFANoArray[i] = CarFA then
                exit(i);

        exit(0);
    end;
}
