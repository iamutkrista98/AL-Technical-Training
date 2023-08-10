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
        addafter(Name)
        {
            field(ItemDescription; ItemDescription)
            {
                //ApplicationArea = All;

                //Through Lookup Populating field

                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     ItemRec: Record Item;
                // begin
                //     ItemRec.Reset();
                //     if Page.RunModal(Page::"Item List", ItemRec) = Action::LookupOK then
                //         ItemDescription := ItemRec.Description;
                // end;

                //Lookup list multi select

            }
            field(ItemFilter; ItemFilter)
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemList: Page "Item List";
                begin
                    Clear(ItemFilter);
                    ItemList.LookupMode(true);
                    if ItemList.RunModal() = Action::LookupOK then begin
                        Text += ItemList.GetSelectionFilter();
                        exit(true);

                    end else
                        exit(false);

                end;
            }
            field(CustRank; CustRank)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    case CustRank
                    of
                        CustRank::Bronze:
                            Message('You are a bronze member');
                        CustRank::Gold:
                            Message('You are a gold member');
                        CustRank::Platinum:
                            Message('You are a platinum member');
                        CustRank::Silver:
                            Message('You are a silver member');
                    end;
                end;
            }

        }
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
        addafter("&Jobs")
        {
            action(NumberOfCustomers)
            {
                ApplicationArea = All;
                Image = Totals;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Cust: Record Customer;
                    count: Integer;
                begin
                    Cust.FindFirst();
                    count := 0;
                    if Cust.FindSet() then
                        repeat
                            count += 1;
                        until Cust.Next() = 0;
                    Message('The number of customers in the list are: %1', count);

                end;



            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        ItemDescription: Text[200];
        ItemFilter: Text[200];
        CustRank: Enum CustRank;
}
