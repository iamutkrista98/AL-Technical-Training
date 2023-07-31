page 50108 "Sales Header Agile API"
{
    APIGroup = 'custom';
    APIPublisher = 'utkrista';
    APIVersion = 'v1.0';
    Caption = 'salesHeaderAgileAPI';
    DelayedInsert = true;
    EntityName = 'salesheader';
    EntitySetName = 'saleheader';
    PageType = API;
    SourceTable = "Sales Header Agile";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(totalAmount; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field(saleno; Rec.saleno)
                {
                    Caption = 'saleno';
                }
            }
        }
    }
}
