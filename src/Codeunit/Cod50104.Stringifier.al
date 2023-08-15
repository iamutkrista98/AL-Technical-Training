codeunit 50104 Stringifier
{
    local procedure TexttoString(value: Text): Text
    begin
        Exit(value);

    end;

    local procedure DatetoString(value: Date): Text
    begin
        Exit(Format(value));

    end;

    local procedure IntegertoString(value: Integer): Text
    begin
        Exit(Format(value));

    end;

    local procedure ToString(value: Variant): Text
    begin
        if value.IsInteger then
            Exit(IntegertoString(value))
        else
            if value.IsDate then
                Exit(DatetoString(value))
            else
                if value.IsText then
                    exit(TexttoString(value))
                else
                    exit('');

    end;





}
