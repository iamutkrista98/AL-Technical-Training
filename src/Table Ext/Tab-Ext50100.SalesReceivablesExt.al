tableextension 50100 "Sales&ReceivablesExt" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; salenoseries; Code[20])
        {
            Caption = 'salenoseries';
            DataClassification = ToBeClassified;
        }
        field(50101; testnoseries; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
}
