report 50100 "Sales Report"
{
    ApplicationArea = All;
    Caption = 'Sales Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    //RDLCLayout = 'src/Report/RDLC/SalesReport.rdl';
    RDLCLayout = 'src/Report/RDLC/BankNagadi.rdl';

    dataset
    {
        dataitem("Posted Sales Header Agile"; "Posted Sales Header Agile")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {

            }
        }

    }

    var
        CompInfo: Record "Company Information";
        Item: Record Item;
        Customer: Record Customer;

}
