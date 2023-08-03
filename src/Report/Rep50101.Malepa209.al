report 50101 Malepa209
{
    ApplicationArea = All;
    Caption = 'Malepa209';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report/RDLC/MalepaBankNagadi.rdl';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }

        }
        dataitem("General Ledger Entries"; "G/L Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date");

            column(GL_Posting_Date; "General Ledger Entries"."Posting Date")
            {

            }
            column(GL_Document_No_; "General Ledger Entries"."Document No.")
            {

            }
            column(GL_Description; "General Ledger Entries".Description)
            {

            }
            column(GLDebitAmount; "General Ledger Entries"."Debit Amount")
            {
                AutoFormatType = 1;
                DecimalPlaces = 0 : 0;

            }
            column(GLCreditAmount; "General Ledger Entries"."Credit Amount")
            {
                AutoFormatType = 1;
                DecimalPlaces = 0 : 0;

            }
            trigger OnPreDataItem()
            begin
                if CashGL = '' then
                    CurrReport.Break()
                else begin
                    "General Ledger Entries".SetFilter("G/L Account No.", CashGL);
                    "General Ledger Entries".SetRange("General Ledger Entries"."Posting Date", StartDate, EndDate);
                    if not "General Ledger Entries".FindSet() then
                        CurrReport.Skip();
                end;


                // Clear(EvalDeb);
                // Clear(EvalCred);

            end;


            // trigger OnAfterGetRecord()
            // var

            // begin
            //     // "General Ledger Entries".SetRange("Posting Date", StartDate, StartDate + 30);
            //     // EvalDeb := CalculateGLMonthlyAmount("General Ledger Entries"."Debit Amount");
            //     // EvalCred := CalculateGLMonthlyAmount("General Ledger Entries"."Credit Amount");
            //     // SumMonthlyGLDebit += EvalDeb;
            //     // SumMonthlyGLCredit += EvalCred;

            //     NewStartDate := CalcDate('<-1D>', StartDate);
            //     GenLedEntry.Reset();
            //     "General Ledger Entries".SetRange("Posting Date", 0D, NewStartDate);
            //     GenLedEntry.SetRange("Document No.", "General Ledger Entries"."Document No.");
            //     if "General Ledger Entries".FindFirst() then begin
            //         EvalDeb += "General Ledger Entries"."Debit Amount";
            //         EvalCred += "General Ledger Entries"."Credit Amount";
            //     end;

            // end;


        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date") where(Reversed = const(false));
            column(Bank_Debit_Amount; "Bank Account Ledger Entry"."Debit Amount")
            {
                AutoFormatType = 1;
                DecimalPlaces = 0 : 0;

            }
            column(Bank_Credit_Amount; "Bank Account Ledger Entry"."Credit Amount")
            {
                AutoFormatType = 1;
                DecimalPlaces = 0 : 0;

            }
            column(Bank_Document_No; "Bank Account Ledger Entry"."Document No.")
            {

            }
            column(Bank_Posting_Date; "Bank Account Ledger Entry"."Posting Date")
            {

            }
            column(Bank_Description; "Bank Account Ledger Entry".Description)
            {

            }
            trigger OnPreDataItem()
            begin
                if BankGL = '' then
                    CurrReport.Break()
                else begin
                    "Bank Account Ledger Entry".SetFilter("Bank Account Ledger Entry"."Bank Account No.", BankGL);
                    "Bank Account Ledger Entry".SetRange("Bank Account Ledger Entry"."Posting Date", StartDate, EndDate);
                    if not "Bank Account Ledger Entry".FindSet() then
                        CurrReport.Skip();

                end;

            end;

        }


    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Malepa209)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                    field(BankGL; BankGL)
                    {
                        ApplicationArea = All;
                        TableRelation = "Bank Account";
                        trigger OnValidate()
                        begin
                            CashGL := '';
                        end;

                    }
                    field(CashGL; CashGL)
                    {
                        ApplicationArea = All;
                        TableRelation = "G/L Account";
                        trigger OnValidate()
                        begin
                            BankGL := '';
                        end;

                    }



                }
            }



        }




    }

    procedure CalculateBankMonthlyAmount()
    begin



    end;


    var
        StartDate: Date;
        EndDate: Date;
        BankGL: Code[20];
        CashGL: Code[20];
    // SumMonthlyGLDebit: Decimal;
    // SumMonthlyBankDebit: Decimal;
    // SumMonthlyGLCredit: Decimal;
    // SumMonthlyBankCredit: Decimal;
    // SumPrevMonthlyGLDebit: Decimal;
    // SumPrevMonthlyBankDebit: Decimal;
    // SumPrevMonthlyGLCredit: Decimal;
    // SumPrevMonthlyBankCredit: Decimal;
    // EvalDeb: Decimal;
    // EvalCred: Decimal;
    // NewStartDate: Date;
    // GenLedEntry: Record "G/L Entry";



}
