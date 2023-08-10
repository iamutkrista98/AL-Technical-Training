table 50102 "Sales Line Agile"
{
    Caption = 'Sales Line Agile';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,Item,GLAccount;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item."No."
            else
            if (Type = const(GLAccount)) "G/L Account"."No.";

            trigger OnValidate()
            var
                Itm: Record Item;
                GL: Record "G/L Account";
                BillLine: Record "Sales Line Agile";
            begin
                if Itm.Get("No.") then
                    Validate(Amount, Itm."Unit Price")
                else
                    if GL.Get("No.") then
                        Validate(Amount, GL."Debit Amount");
                BillLine.Reset();
                BillLine.SetRange("Document No.", Rec."Document No.");
                if BillLine.FindSet() then begin
                    repeat
                        if (Type = Type::Item) and (BillLine."No." = "No.") then
                            Error('Item already exists, no duplicate entry allowed');
                        if (Type = Type::GLAccount) and (BillLine."No." = "No.") then
                            Error('GL Entry already exist, no duplicate entry allowed');
                    until BillLine.Next() = 0;


                end

            end;

        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            trigger OnValidate()
            begin
                "Total Amount" := Quantity * Amount;
            end;

        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                "Total Amount" := Quantity * Amount;
            end;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;

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
