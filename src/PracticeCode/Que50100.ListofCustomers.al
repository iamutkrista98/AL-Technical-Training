query 50100 "List of Customers"
{
    Caption = 'List of Customers';
    QueryType = Normal;
    QueryCategory = 'Customer List';

    elements
    {
        dataitem(Customer; Customer)
        {
            column(Address; Address)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Contact; Contact)
            {
            }
            column(City; City)
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(Name; Name)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
