table 50105 "Validate Table"
{
    Caption = 'Validate Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Code[20])
        {
            Caption = 'PK';
        }
        field(2; "Validate This"; Text[200])
        {
            Caption = 'Validate This';
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
