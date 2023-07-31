table 50101 "Posted Sales Header Agile"
{
    Caption = 'Posted Sales Header Agile';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(3; "Customer Name"; Text[200])
        {
            Caption = 'Customer Name';
        }
        field(4; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; saleno; Code[20])
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
