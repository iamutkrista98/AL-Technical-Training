page 50107 AgileSales
{
    APIGroup = 'custom';
    APIPublisher = 'utkrista';
    APIVersion = 'v2.0';
    Caption = 'agileSales';
    DelayedInsert = true;
    EntityName = 'agilesales';
    EntitySetName = 'agilesale';
    PageType = API;
    SourceTable = "Sales Ledger Entry Agile";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(totalQuantity; Rec."Total Quantity")
                {
                    Caption = 'Total Quantity';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(SystemId; Rec.SystemId)
                {

                }
            }
        }
    }
}
