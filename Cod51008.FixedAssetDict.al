codeunit 41008 FixedAssetDict
{
    local procedure GetFixedDict(): Dictionary of [Code[20], Dictionary of [Integer, Text]]
    var
        FixedAssetDict: Dictionary of [Code[20], Dictionary of [Integer, Text]];
        Fa: Record "Fixed Asset";
        DetailedFixedDict: Dictionary of [Integer, Text];
    // DetailedFixedDicts: Dictionary of [Text, Decimal];
    begin
        if Fa.FindSet() then
            repeat
                DetailedFixedDict.Add(1, Fa.Description);
                DetailedFixedDict.Add(2, Fa.ChassisNo);
                DetailedFixedDict.Add(3, Fa."Car Make");
                DetailedFixedDict.Add(4, Fa.Model);
                DetailedFixedDict.Add(5, Format(Fa."Buying Price"));
                DetailedFixedDict.Add(6, Fa."FA Location Code");
                FixedAssetDict.Add(Fa."No.", DetailedFixedDict);
                Clear(DetailedFixedDict);

            until Fa.Next() = 0;
        exit(FixedAssetDict);
    end;

    procedure GetDictValues()
    var
        FixedDict: Dictionary of [Code[20], Dictionary of [Integer, Text]];
        Detail: Text;
        Dict: Dictionary of [Integer, Text];
        i: Integer;
        FANo: Code[20];
    begin
        FixedDict := GetFixedDict();
        i := 1;
        foreach Dict in FixedDict.Values do begin
            foreach Detail in Dict.Values do begin
                FixedDict.Keys.Get(i, FANo);
                Message(Format(FANo) + ':' + Detail);
            end;
            i += 1;
        end;
    end;
}
codeunit 41009 WordSplitting
{
    trigger OnRun()
    var
        words: List of [Text];
        Lines: List of [Text];
        WordPointer: Integer;
        LinePointer: Integer;
        Builder: TextBuilder;
        
    begin
        words := GetText().Split(' ');
         
        LinePointer := 1;
        for WordPointer := 1 to words.count do begin
            //it checks if it exists and if exists it append the space to seperate words then appends the currect word(wordpointer)
            if Builder.Length() > 0 then
                Builder.Append(' ');
            Builder.Append(words.Get(WordPointer));
            if Builder.Length() > 20 then begin
                Lines.Add(Builder.ToText());
                Clear(Builder);
            end;

        end;
        if Builder.Length() > 0 then
            Lines.Add(Builder.ToText());
        Message('%1\%2\%3\%4\%5\%6\%7\%8', Lines.Get(1),Lines.Get(2),Lines.Get(3),Lines.Get(4),Lines.Get(5),Lines.Get(6),Lines.Get(7),Lines.Get(8));
        // Message(Lines);
    end;

    procedure GetText(): Text
    begin
        exit('Effective communication is a cornerstone of success in any organization, influencing everything from teamwork to employee engagement. It plays a pivotal role in building strong relationships among team members, enhancing collaboration, and fostering a sense of belonging within the workplace. When communication is clear and consistent, it minimizes misunderstandings and reduces conflict, leading to a more harmonious work environment. Key elements of effective communication include active listening, where individuals not only hear but also understand and process the information being shared. Additionally, the ability to convey messages clearly is vital; this means using simple language, avoiding jargon, and ensuring that the intended message is delivered effectively. Timely feedback is another crucial aspect, as it allows for continuous improvement and adaptation. Furthermore, non-verbal cues, such as body language and facial expressions, can significantly impact interpersonal interactions and should not be overlooked. Organizations that prioritize effective communication can create a culture of openness and transparency, empowering employees to share their ideas and concerns without fear of retribution. Ultimately, fostering an environment that values communication leads to higher employee satisfaction and retention, driving the organization toward its goals more efficiently.')
    end;

    var
        myInt: Integer;
}