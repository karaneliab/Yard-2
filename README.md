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
  }