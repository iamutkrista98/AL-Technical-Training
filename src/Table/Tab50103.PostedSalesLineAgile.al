table 50103 "Posted Sales Line Agile"
{
    Caption = 'Posted Sales Line Agile';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Type"; Option)
        {
            OptionMembers = Item,"GL Account";
            Caption = 'Type';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';

        }
        field(7; "Line No."; Integer)
        {

        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
