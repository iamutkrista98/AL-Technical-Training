codeunit 50100 PurchaseManagement
{
    procedure PostPurchToPostedPurch(Purchno: Code[20])
    var
        SaleHdr: Record "Sales Header Agile";
        SaleLine: Record "Sales Line Agile";
        PostedSaleHdr: Record "Posted Sales Header Agile";
        PostedSaleLine: Record "Posted Sales Line Agile";
        totalAmount: Decimal;
        Line: Record "Gen. Journal Line";
        Gen: Codeunit "Gen. Jnl.-Post Line";
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
                    Line.Init();
                    Line."Journal Batch Name" := 'DEFAULT';
                    Line."Journal Template Name" := 'GENERAL';
                    Line."Posting Date" := PostedSaleHdr."Posting Date";
                    Line."Document No." := SaleHdr."No.";
                    Line."Document Type" := Line."Document Type"::Payment;
                    Line."Account Type" := Line."Account Type"::"G/L Account";
                    Line."Sales Header Agile No." := SaleHdr."No.";
                    // Line."Line No." := 60000;
                    Line."Account No." := '2910';
                    Line.Description := PostedSaleHdr."Customer Name";
                    Line."Debit Amount" := 1000;
                    Line."Bal. Account Type" := Line."Bal. Account Type"::Customer;
                    Line."Credit Amount" := 1000;
                    Line."Bal. Account No." := PostedSaleHdr."Customer No.";
                    Line.Amount := 69;
                    Line.Insert(true);
                    Gen.RunWithCheck(Line);
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

    procedure SendAnEmail()
    var
        myInt: Integer;
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        Instr: InStream;
        FileName: Text;
        EmailBody: Label 'Dear <b>%1</b>,<p>Please find attached document below</p><hr>';

    begin
        EmailMsg.Create('iamutkrista98@gmail.com', 'Sending an Email in AL', '', true);
        EmailMsg.AppendToBody(StrSubstNo(EmailBody, UserId));
        if UploadIntoStream('Select the file', '', 'This files|*.jpg;*.pdf', FileName, Instr) then
            EmailMsg.AddAttachment(FileName, '', Instr)
        else
            Message('There was an error uploading, %1', GetLastErrorText());
        if Email.Send(EmailMsg) then
            Message('The email was sent successfully')
        else
            Message('There was an error sending the mail, %1', GetLastErrorText());


    end;






}
