

codeunit 41005 ImageManagement
{
    procedure ImportPicture("Fixed Asset": Record "Fixed Asset")
    var
        PicInstream: InStream;
        FromFileName: Text;
        OverrideImageQst: Label 'The existing image will be replaced. Do you want to continue?', Locked = false, MaxLength = 250;
    begin
        if "Fixed Asset".Image.HasValue then
            if not Confirm(OverrideImageQst) then
                exit;

        if UploadIntoStream('Import','','All Files (*.*)|*.*', FromFileName, PicInstream) then begin
            Clear("Fixed Asset".Image);
            "Fixed Asset".Image.ImportStream(PicInstream, FromFileName);
            "Fixed Asset".Modify(true);
        end;
    end;


}