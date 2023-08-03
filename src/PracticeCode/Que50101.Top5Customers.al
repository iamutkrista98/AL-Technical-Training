query 50101 "Top 5 Customers"
{
    Caption = 'Top 5 Customers';
    QueryType = Normal;
    TopNumberOfRows = 5;
    QueryCategory = 'Customer List';
    OrderBy = descending(Sales__LCY_Sum);
    elements
    {
        dataitem(Cust__Ledger_Entry;
        "Cust. Ledger Entry")
        {
            filter(Posting_Date; "Posting Date")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Sales__LCY_Sum; "Sales (LCY)")
            {
                Method = Sum;

            }


        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
