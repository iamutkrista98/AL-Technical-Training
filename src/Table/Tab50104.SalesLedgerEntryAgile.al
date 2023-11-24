table 50104 "Sales Ledger Entry Agile"
{
    Caption = 'Sales Ledger Entry Agile';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(6; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
