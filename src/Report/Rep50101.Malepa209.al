report 50101 Malepa209
{
    ApplicationArea = All;
    Caption = 'Malepa2091';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report/RDLC/MalepaBankNagadi.rdlc';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");

            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            column(SumMonthlyGLDebit; SumMonthlyGLDebit)
            {


            }
            column(SumMonthlyGLCredit; SumMonthlyGLCredit)
            {


            }
            column(SumMonthlyBankDebit; SumMonthlyBankDebit)
            {


            }
            column(SumMonthlyBankCredit; SumMonthlyBankCredit)
            {


            }
            column(SumPrevMonthlyGLDebit; SumPrevMonthlyGLDebit)
            {


            }
            column(SumPrevMonthlyGLCredit; SumPrevMonthlyGLCredit)
            {


            }
            column(SumPrevMonthlyBankDebit; SumPrevMonthlyBankDebit)
            {


            }
            column(SumPrevMonthlyBankCredit; SumPrevMonthlyBankCredit)
            {

            }
            column(DocType; DocType)
            {

            }


            dataitem("General Ledger Entries"; "G/L Entry")
            {
                DataItemTableView = sorting("Posting Date", "Document No.");

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


                }
                column(GLCreditAmount; "General Ledger Entries"."Credit Amount")
                {


                }


                trigger OnPreDataItem()
                begin
                    if CashGL = '' then
                        CurrReport.Break()
                    else begin
                        "General Ledger Entries".SetFilter("G/L Account No.", CashGL);
                        "General Ledger Entries".SetRange("General Ledger Entries"."Posting Date", StartDate, EndDate);
                        if not "General Ledger Entries".FindSet() then
                            Error('No Data Found! Check filters and try again!');
                    end;
                end;

            }

            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = sorting("Posting Date", "Document No.") where(Reversed = const(false));
                column(Bank_Debit_Amount; "Bank Account Ledger Entry"."Debit Amount")
                {


                }
                column(Bank_Credit_Amount; "Bank Account Ledger Entry"."Credit Amount")
                {


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
                            Error('No Data Found! Check filters and try again!');

                    end;

                end;

            }

            //For company information
            trigger OnPreDataItem()
            begin
                NewStartDate := CalcDate('<-1D>', StartDate);
                GenLedEntry.Reset();
                GenLedEntry.SetRange(GenLedEntry."Posting Date", 0D, NewStartDate);
                GenLedEntry.SetRange("G/L Account No.", CashGL);
                if GenLedEntry.Findset() then
                    repeat
                        SumPrevMonthlyGLDebit += GenLedEntry."Debit Amount";
                        SumPrevMonthlyGLCredit += GenLedEntry."Credit Amount";
                    until GenLedEntry.Next() = 0;
                BankLedEntry.Reset();
                BankLedEntry.SetRange(BankLedEntry."Posting Date", 0D, NewStartDate);
                BankLedEntry.SetRange("Bank Account No.", BankGL);
                if BankLedEntry.FindSet() then
                    repeat
                        SumPrevMonthlyBankDebit += BankLedEntry."Debit Amount";
                        SumPrevMonthlyBankCredit += BankLedEntry."Credit Amount";
                    until BankLedEntry.Next() = 0;
                GenLedEntry.Reset();
                GenLedEntry.SetRange(GenLedEntry."Posting Date", StartDate, EndDate);
                GenLedEntry.SetRange(GenLedEntry."G/L Account No.", CashGL);
                if GenLedEntry.FindSet() then
                    repeat
                        SumMonthlyGLDebit += GenLedEntry."Debit Amount";
                        SumMonthlyGLCredit += GenLedEntry."Credit Amount";
                    until GenLedEntry.Next() = 0;
                BankLedEntry.Reset();
                BankLedEntry.SetRange(BankLedEntry."Posting Date", StartDate, EndDate);
                BankLedEntry.SetRange("Bank Account No.", BankGL);
                if BankLedEntry.FindSet() then
                    repeat
                        SumMonthlyBankDebit += BankLedEntry."Debit Amount";
                        SumMonthlyBankCredit += BankLedEntry."Credit Amount";
                    until BankLedEntry.Next() = 0;

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
                        ToolTip = 'Start Date of Transaction';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date of Transaction';


                    }
                    field(BankGL; BankGL)
                    {
                        ApplicationArea = All;
                        TableRelation = "Bank Account";
                        ToolTip = 'Bank Account';

                        trigger OnValidate()
                        begin
                            CashGL := '';
                        end;

                    }
                    field(CashGL; CashGL)
                    {
                        ApplicationArea = All;
                        TableRelation = "G/L Account";
                        // TableRelation = "G/L Account" where("Account Type" = const(Posting), "No." = filter(11001 .. 11004));

                        ToolTip = 'G/L Account';
                        trigger OnValidate()
                        begin
                            BankGL := '';
                        end;

                    }

                }
            }



        }

    }

    var
        StartDate: Date;
        EndDate: Date;
        BankGL: Code[20];
        CashGL: Code[20];
        SumMonthlyGLDebit: Decimal;
        SumMonthlyBankDebit: Decimal;
        SumMonthlyGLCredit: Decimal;
        SumMonthlyBankCredit: Decimal;
        SumPrevMonthlyGLDebit: Decimal;
        SumPrevMonthlyBankDebit: Decimal;
        SumPrevMonthlyGLCredit: Decimal;
        SumPrevMonthlyBankCredit: Decimal;
        NewStartDate: Date;
        GenLedEntry: Record "G/L Entry";
        BankLedEntry: Record "Bank Account Ledger Entry";
        DocType: Text[20];
        GLAccount: Record "G/L Account";

    trigger OnPreReport()
    begin
        if (StartDate = 0D) or (EndDate = 0D) then begin
            Error('Start Date and End Date are mandatory!');
        end;
        if (CashGL = '') and (BankGL = '') then
            Error('One of CashGL or BankGL must be selected!');
        if (BankGL <> '') then
            DocType := BankGL
        else begin
            if GLAccount.Get(CashGL) then
                DocType := GLAccount.Name;
        end;



    end;


}
