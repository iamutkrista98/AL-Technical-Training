tableextension 50101 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50100; "Agile Journal Template"; Text[100])
        {
            Caption = 'Agile Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50101; "Agile Journal Batch"; Text[100])
        {
            Caption = 'Agile Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch" where("Journal Template Name" = field("Agile Journal Template"));
        }
        field(50102; "Agile GL Account"; Text[100])
        {
            Caption = 'Agile GL Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
