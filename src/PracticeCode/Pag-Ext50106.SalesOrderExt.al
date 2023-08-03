pageextension 50106 SalesOrderExt extends "Sales Order"
{
    layout
    {

    }

    actions
    {
        addafter(AssemblyOrders)
        {
            action(CustomerSalesQuantity)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    queryCodeUnit: Codeunit querybasedcodeunit;
                begin
                    Clear(queryCodeUnit);
                    queryCodeUnit.Run();
                end;

            }
        }
    }
}
