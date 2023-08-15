codeunit 50105 StringifierWithOverloads
{
    procedure ToString(value: Text): Text
    begin
        Exit(value);

    end;

    procedure ToString(value: Date): Text
    begin
        exit(Format(value));

    end;

    procedure ToString(value: Integer): Text
    begin

        exit(Format(value));
    end;

}
