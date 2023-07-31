pageextension 50101 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Agile Journal Template"; Rec."Agile Journal Template")
            {
                ApplicationArea = All;
            }
            field("Agile Journal Batch"; Rec."Agile Journal Batch")
            {
                ApplicationArea = All;
            }
            field("Agile GL Account"; Rec."Agile GL Account")
            {
                ApplicationArea = All;
            }

        }
    }
}
