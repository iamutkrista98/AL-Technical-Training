report 50102 GroupByDemo
{
    ApplicationArea = All;
    Caption = 'GroupByDemo';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report/RDLC/GroupByDemo.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(GroupByFieldNo; GroupByFieldNo) { }
            column(ItemNo; "Item No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(SourceType; "Source Type")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(GroupBy; FieldRecord."No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Group By';
                        ToolTip = 'Specifies the value of the Group By field.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            FieldRecord.SetRange(TableNo, Database::"Item Ledger Entry");
                            if Page.RunModal(Page::"Fields Lookup", FieldRecord) = Action::LookupOK then
                                GroupByFieldNo := FieldRecord."No.";


                        end;
                    }
                }
            }
        }

    }

    var
        GroupByFieldNo: Integer;
        FieldRecord: Record Field;
        FieldPage: Page "Fields Lookup";
}
