pageextension 50100 SalesReceivablesExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Customer Nos.")
        {
            field("salenoseries"; Rec.salenoseries)
            {
                ApplicationArea = All;
                TableRelation = "No. Series";


            }
            field("testnoseries"; Rec.testnoseries)
            {
                ApplicationArea = All;

            }


        }
        modify("Customer Nos.")
        {
            Visible = false;

        }
    }

}
