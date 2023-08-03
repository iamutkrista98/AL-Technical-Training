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

    procedure TestProcedure(var num1: Integer): Integer
    begin
        num1 := 30;
        exit(num1);

    end;
}