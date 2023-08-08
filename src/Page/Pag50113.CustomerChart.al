page 50113 "Customer Chart"
{
    Caption = 'Customer Chart';
    PageType = CardPart;
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;
                trigger AddInReady()
                var
                    Buffer: Record "Business Chart Buffer" temporary;
                    Customer: Record Customer;
                    i: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('Profit', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Pie);

                    Buffer.SetXAxis('Customer', Buffer."Data Type"::String);
                    if Customer.FindSet(false, false) then
                        repeat
                            Customer.CalcFields("Sales (LCY)", "Profit (LCY)");
                            if Customer."Sales (LCY)" <> 0 then begin
                                Buffer.AddColumn(Customer.Name);
                                Buffer.SetValueByIndex(0, i, Customer."Sales (LCY)");
                                Buffer.SetValueByIndex(1, i, Customer."Profit (LCY)");

                                i += 1;
                            end
                        until Customer.Next() = 0;

                    Buffer.Update(CurrPage.Chart);

                end;

            }
        }
    }
}
