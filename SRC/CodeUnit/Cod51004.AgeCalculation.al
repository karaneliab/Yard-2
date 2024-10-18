

codeunit 51004 AgeCalculation
{
    // trigger OnRun()
    // begin
    //     // CalculateAge(Today, Employee."Birth Date"); // Example invocation can be done here
    // end;

    var
        Employee: Record Employee;

    procedure CalculateAge(Today: Date; BirthDate: Date): Decimal
    var
        Age: Decimal; 
    begin
        if (BirthDate <> 0D) and (Today <> 0D) then begin
            Age := (Today - BirthDate) / 365;
            Age := ROUND(Age, 1); 
            Message('The employee''s age is %.2f years.Age:%1 Today: %2, Birth Date: %3', Age, Today, BirthDate);
        end;
            
        
        exit(Age); 
    end;
}