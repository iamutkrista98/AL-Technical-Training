codeunit 50101 EventSubs
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GenJournalLine.TestField("Sales Header Agile No.");
        GLEntry."Sales Header Agile No." := GenJournalLine."Sales Header Agile No.";

    end;

    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    // local procedure OnAfterCopyGenJnlLineFromSalesHeader(var GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    // begin

    // end;


    [IntegrationEvent(false, false)]
    procedure OnAddressLineChanged(line: Text[100]);
    begin

    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::EventSubs, 'OnAddressLineChanged', '', true, true)]
    // procedure OnChangedAddressLine(line: Text[100])
    // begin
    //     if (StrPos(line, '+') > 0) then begin
    //         Error('Not valid for address in line : %1', line);
    //     end;

    // end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnBeforeValidateEvent', 'Address', true, true)]
    procedure OnBeforeValidateEvent(var Rec: Record Customer)
    begin
        if (StrPos(Rec.Address, '+') > 0) then
            Error('Address can not contain + in line %1', Rec.Address);

    end;

    // procedure GenJouPosting()
    // var
    // GenJournal : Record "Gen. Journal Line";
    // template : Record "Gen. Journal Template";
    // begin

    //     GenJournal.Init();
    //     GenJournal."Journal Template Name" := ;
    //     Genjournal."Journal Batch Name" := ;
    // end;

}

pageextension 50105 CustomerExt extends "Customer Card"
{
    layout
    {
        modify(Address)
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit EventSubs;
            begin
                Publisher.OnAddressLineChanged(Rec.Address);
            end;

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
