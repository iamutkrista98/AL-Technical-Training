codeunit 50100 PurchaseManagement
{
    procedure PostPurchToPostedPurch(Purchno: Code[20])
    var
        SaleHdr: Record "Sales Header Agile";
        SaleLine: Record "Sales Line Agile";
        PostedSaleHdr: Record "Posted Sales Header Agile";
        PostedSaleLine: Record "Posted Sales Line Agile";
        totalAmount: Decimal;
    begin
        if not ValidateUserBeforePosting() then
            Error('Access Denied!');
        if SaleHdr.Get(Purchno) then begin
            PostedSaleHdr.Init();
            PostedSaleHdr.TransferFields(SaleHdr);
            PostedSaleHdr.Insert(true);
            PostedSaleHdr.Modify();

            SaleLine.Reset();
            SaleLine.SetRange("Document No.", SaleHdr."No.");
            if SaleLine.FindSet() then
                repeat
                    PostedSaleLine.Init();
                    PostedSaleLine.TransferFields(SaleLine);
                    totalAmount += SaleLine."Total Amount";
                    PostedSaleLine.Insert();
                    InsertIntoSalesLedger(SaleLine);
                until SaleLine.Next() = 0;
            PostedSaleHdr."Total Amount" := totalAmount;
            PostedSaleHdr.Modify();
            SaleLine.DeleteAll();
            SaleHdr.Delete();
        end;
    end;


    procedure InsertIntoSalesLedger(SaleLine: Record "Sales Line Agile")
    var
        SaleLedger: Record "Sales Ledger Entry Agile";
        SaleHdr: Record "Sales Header Agile";
        cusNo: Code[20];

    begin
        SaleLedger.Init();
        if SaleLedger.FindLast() then
            SaleLedger."Entry No." += 1
        else
            SaleLedger."Entry No." := 1;
        SaleLedger."Document No." := SaleLine."Document No.";
        SaleLedger."No." := SaleLine."No.";
        getCustomerNoFromSaleHeader(SaleLine."Document No.", cusNo);
        SaleLedger."Customer No." := cusNo;
        SaleLedger."Total Quantity" := SaleLine.Quantity;
        SaleLedger.Amount := SaleLine."Total Amount";
        SaleLedger.Insert();



    end;

    // procedure InsertIntoSalesLedger(SaleLine: Record "Sales Line Agile")
    // var
    //     SaleLedger: Record "Sales Ledger Entry Agile";
    //     SaleHdr: Record "Sales Header Agile";
    //     cusNo: Code[20];
    //     GLPost: Codeunit "Gen. Jnl.-Post Line";
    //     Line: Record "Gen. Journal Line";

    // begin
    //     SaleLedger.Init();
    //     if SaleLedger.FindLast() then
    //         SaleLedger."Entry No." += 1
    //     else
    //         SaleLedger."Entry No." := 1;
    //     SaleLedger."Document No." := SaleLine."Document No.";
    //     SaleLedger."No." := SaleLine."No.";
    //     getCustomerNoFromSaleHeader(SaleLine."Document No.", cusNo);
    //     SaleLedger."Customer No." := cusNo;
    //     SaleLedger."Total Quantity" := SaleLine.Quantity;
    //     SaleLedger.Amount := SaleLine."Total Amount";
    //     SaleLedger.Insert();

    //     Line.Init();
    //     Line."Posting Date" := SaleHdr."Posting Date";
    //     Line."Document Type" := Line."Document Type"::" ";
    //     Line."Document No." := Line."Document No.";
    //     Line."Account Type" := Line."Account Type"::"G/L Account";
    //     Line."Account No." := Line."Account No.";
    //     Line.Description := 'Testing Out';
    //     Line."Debit Amount" := SaleHdr."Total Amount";
    //     Line."Credit Amount" := SaleLine."Total Amount";
    //     Line."Bal. Account Type" := Line."Bal. Account Type"::Customer;
    //     Line."Sales Header Agile No." := SaleHdr."No.";
    //     Line.Insert();



    // end;




    local procedure getCustomerNoFromSaleHeader(DocumentNo: Code[20]; var cusNo: Code[20])
    var
        SaleHdr: Record "Sales Header Agile";
    begin
        if SaleHdr.Get(DocumentNo) then
            cusNo := SaleHdr."Customer No.";

    end;

    procedure ValidateUserBeforePosting(): Boolean
    var
        Val: Record "User Setup";
    begin
        Val.Get(UserId);
        if Val."Allow Posting" then
            exit(true)
        else
            exit(false);

    end;






}
