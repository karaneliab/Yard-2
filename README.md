  {'''
  requestpage

    {
        layout
        {
            area(Content)
            {
                group(GroupName) { }
            }
        }
        actions
        {
            area(Processing)
            {
                action(ExportToExcel)
                {
                    Caption = 'Export to Excel';
                    Image = Export;
                    // Promoted = true;
                    // PromotedCategory = Process;

                    // trigger OnAction()
                    // begin
                    //     ExportToExcel();
                    // end;
                }
            }
        }
    }
    procedure ExportToExcel()
    var
        ExcelBuffer: Record "Excel Buffer";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        TempFilePath: Text;
        FileName: Text;
        OutStream: OutStream;
        InStream: InStream;
        CarLineRec: Record "Car Line";
        ColumnNo: Integer;
        RowNo: Integer;
    begin
        // Ensure the file name has the correct Excel extension
        FileName := 'CarDetails.xlsx';  // Set the extension to .xlsx
        ExcelBuffer.DeleteAll();

        RowNo := 1;

        // Adding headers to Excel file using AddColumn
        ColumnNo := 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Car Insured', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Car Make', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Car Model', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Document No.', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Received From', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Chassis Number', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Yard Branch', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Year of Make', false, false, false, '', 0);
        ColumnNo := ColumnNo + 1;
        ExcelBuffer.AddColumn(ColumnNo, false, 'Reg No.', false, false, false, '', 0);

        // Adding data rows from CarLine
        if CarLineRec.FindSet() then
            repeat
                RowNo := RowNo + 1;
                ColumnNo := 1;
                ExcelBuffer.AddColumn(ColumnNo, false, Format(CarLineRec."Car Insured"), false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec."Car Make", false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec."Car Model", false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec."Document No.", false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec."Received From", false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec."Chassis Number", false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec.YardBranch, false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, Format(CarLineRec."Year of Make"), false, false, false, '', 0);
                ColumnNo := ColumnNo + 1;
                ExcelBuffer.AddColumn(ColumnNo, false, CarLineRec.RegNo, false, false, false, '', 0);
            until CarLineRec.Next() = 0;

        // Create an output stream for the blob
        TempBlob.CreateOutStream(OutStream);
        ExcelBuffer.SaveToStream(OutStream, false);  // Save to the stream (EraseFileAfterCompletion set to false)

        // Create a server-side temporary file
        TempFilePath := FileManagement.ServerTempFileName(FileName);

        // Export the blob to the temporary Excel file (.xlsx)
        TempBlob.CreateInStream(InStream);
        FileManagement.BLOBExport(TempBlob, TempFilePath, true); // No need for a boolean check

        // Now download the file to the user
        FileManagement.DownloadTempFile(TempFilePath);

        // Download the temporary file
        FileManagement.DownloadTempFile(TempFilePath);
    end;
     // trigger OnAction()
                // var
                //     CarLine: Record "Car Line";
                // begin
                //     // Check if the document is approved first
                //     if Rec.Status <> Rec.Status::Approved then begin
                //         Message('Status must be set to Approved before posting.');
                //         exit;
                //     end;

                //     // Confirm if user wants to proceed with posting
                //     if not Confirm('Do you want to post the car receipt?', true) then begin
                //         Message('Posting cancelled.');
                //         exit;
                //     end;

                //     // Call the posting logic
                //     Message('Attempting to post car details for Document No. %1', Rec."No");
                //     Rec.PostCarDetails(Rec);
                //     Message('Post successful for Document No. %1', Rec."No");

                //     // Optionally open Purchase Invoices after successful posting
                //     if Confirm('Do you want to open Purchase Invoice?', false) then
                //         Page.Run(Page::"Purchase Invoices");
                // end;
  }
      procedure AssignCarReceivingNo(var CarReceivingHeader: Record "Car Recieving Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriees: codeunit "No. Series";
    begin
        // Get the Purchases & Payables Setup record to find the No. Series
         if CarReceivingHeader."No" = '' then
            PurchSetup.Get();
        PurchSetup.TestField("Car Receiving Nos.");
        if CarReceivingHeader.No = '' then
           CarReceivingHeader.No:=NoSeriees.GetNextNo(PurchSetup."Car Receiving Nos.", Today);
    end;