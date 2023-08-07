page 50139 MyPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(Content)
        {
            group(Inputs)
            {
                Caption = 'Input Section';
                field(Number; Number)
                {
                    ApplicationArea = All;
                }
                field(InputText; txt)
                {
                    ApplicationArea = All;

                }

            }

            group(Output)
            {
                Caption = 'Output Section';
                field(Factorial; Factorial)
                {
                    ApplicationArea = All;
                    Editable = false;

                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(setautocalc)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    cus."No." := '01454545';
                    cus.SetAutoCalcFields(Balance, "Net Change");
                    if (cus.Find('=') = true) then
                        repeat

                        until cus.Next() = 0;
                    Message('The balance is: %1', cus.Balance);
                end;
            }
            action(calcfields)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    cus."No." := '01454545';

                    if (cus.Find('=') = true) then
                        repeat
                            cus.CalcFields(Balance, "Net Change");
                        until cus.Next() = 0;
                    Message('The balance is: %1', cus.Balance, cus.Name, cus.Address);
                end;

            }
            action(calcFactorial)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Fact := 1;
                    for I := 1 to Number do
                        Fact := Fact * I;
                    Factorial := Fact;
                    Message('The factorial for the number %1 is %2', Number, Fact);
                end;
            }
            action(CheckOddEven)
            {
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Number MOD 2 = 0 then
                        Message('The number %1 is even', Number)
                    else
                        Message('The number %1 is odd', Number);


                end;
            }

            action("Procedure Passing Test")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendConfirmation;

                trigger OnAction()
                var
                    num1: Integer;
                    num2: Integer;
                begin
                    num1 := Number;
                    num2 := TestProcedure(num2);
                    Message('num1 is %1', num1);
                    Message('num2 is %1', num2);

                end;

            }
            action(DateOperations)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Calendar;

                trigger OnAction()

                begin

                    Message('Today is %1\ 1 Week from now is %2 \1 Month From Now is %3\ 1 Year from now is %4\ Custom Date Operation: %5 \%6 ', Today(), CalcDate('1W', Today()), CalcDate('1M', Today()), CalcDate('1Y', Today()), CalcDate('1Y+1M+3D', Today()), Date2DWY(Today(), 1));

                end;

            }
            action(NameOperation)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Image = Process;
                trigger OnAction()
                var
                    CustomerNames: Text;
                begin
                    Customers.Add('Ram');
                    Customers.Add('Sita');
                    Customers.Add('Hari');

                    //Message('The name in 3rd index is %1', Customers.Get(3));
                    foreach CustomerNames in Customers do begin
                        Message(CustomerNames);
                    end;

                end;

            }
            action("CRUD Operations")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SaleHdr: Record "Sales Header Agile";
                    count: Integer;
                begin
                    SaleHdr.SetRange("Customer No.", '10000');
                    count := 0;
                    if SaleHdr.FindSet() then
                        repeat
                            count += 1;
                        until SaleHdr.Next() = 0;
                    SaleHdr.DeleteAll(true);
                    Message('Total of %1 entries deleted', count);
                end;


            }
            action("Total Evaluation")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Totals;
                trigger OnAction()
                var
                    Cust: Record Customer;
                begin
                    Cust.SetCurrentKey("Bill-to Customer No.");
                    Cust.SetRange("Bill-to Customer No.", '10000', '50000');
                    Cust.CalcSums("Balance (LCY)");
                    Message('The total is %1', Cust.CalcSums("Balance (LCY)"));
                end;

            }
            action(ControlStatementsEval)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendConfirmation;
                trigger OnAction()
                begin
                    case Number of
                        1, 2, 20:
                            Message('The number %1 is one of 1,2 or 20', Number);
                        10, 11, 12:
                            Message('The number %1 is one of 10,11,12', Number);
                        else
                            Message('Neither 1,2,20,10,11,12');
                    end;

                    case txt of
                        'abc':
                            Message('Too Simple Password');
                        '123':
                            Message('Too Simple Password');
                        else
                            if StrLen(txt) > 8 then
                                Message('The password is valid length')
                            else
                                Message('The password is not of valid length');

                    end;


                end;


            }
            action(Find)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Find;

                trigger OnAction()
                var
                    Cust: Record Customer;
                begin
                    // Cust.SetFilter(Cust."Location Code", 'BLUE');
                    // if Cust.FindSet() then
                    //     repeat
                    //         Message('Customer Name: %1\Customer Address: Cust.Name, Cust.Address', Cust.Name, Cust.Address);
                    //     until Cust.Next() = 0;

                    Cust.SetFilter(Cust.Name, '@S*');
                    if Cust.FindSet() then
                        repeat
                            Message('Customer Name: %1\Customer Address: Cust.Name, Cust.Address', Cust.Name, Cust.Address);
                        until Cust.Next() = 0;
                end;

            }
        }

        area(Navigation)
        {
            group("Detail Information")
            {
                action("CustomerDetails")
                {
                    ApplicationArea = All;
                    Image = Info;
                    //make the action open the customer card page
                    RunObject = page "Customer Card";

                }

            }

        }
        area(Reporting)
        {
            action("Report")
            {
                ApplicationArea = All;
                Image = Report;
                RunObject = report "Sales Report";
            }

        }
    }

    var
        myInt: Integer;
        cus: Record Customer;
        Number: Integer;
        Fact: Integer;
        I: Integer;
        Factorial: Integer;
        txt: Text;
        NewDate: Date;

        Customers: List of [Text];

    procedure TestProcedure(var num1: Integer): Integer
    begin
        num1 := 30;
        exit(num1);

    end;
}