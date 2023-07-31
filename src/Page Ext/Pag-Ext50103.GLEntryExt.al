pageextension 50103 "G/L Entry Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Sales Header Agile No."; Rec."Sales Header Agile No.")
            {
                ApplicationArea = All;
            }

        }
    }
}
