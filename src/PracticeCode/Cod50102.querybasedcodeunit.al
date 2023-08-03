codeunit 50102 querybasedcodeunit
{
    trigger OnRun()
    begin
        CustQuery.SetFilter(Quantity, '>10');
        CustQuery.Open();
        while CustQuery.Read() do begin
            Message(Textbox, CustQuery.Name, CustQuery.Quantity);

        end;

    end;



    var
        CustQuery: Query "Customer Sales By Quantity";
        Textbox: TextConst ENU = 'Customer Name=%1, Quantity=%2';

}
