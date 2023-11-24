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
            OptionMembers = Item,"GL Account";
            Caption = 'Type';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const("GL Account")) "G/L Account";

            trigger OnValidate()
            var
                Itm: Record Item;
                GL: Record "G/L Account";
            begin
                if (Type = Type::Item) then begin
                    if Itm.Get("No.") then
                        Amount := Itm."Amount Agile";
                end;
                if (Type = Type::"GL Account") then begin
                    if GL.Get("No.") then
                        Amount := GL."Amount Agile";
                end;
            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            trigger OnValidate()
            begin
                "Total Amount" := Amount * Quantity;
            end;
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                "Total Amount" := Amount * Quantity;
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
