query 50102 "Customer Sales By Quantity"
{
    Caption = 'Customer Sales By Quantity';
    QueryType = Normal;
    QueryCategory = 'Customer List';
    OrderBy = descending(Quantity);

    elements
    {
        dataitem("Customer"; Customer)
        {
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                SqlJoinType = InnerJoin;
                column(Quantity; Quantity)
                {
                    Method = Sum;

                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
