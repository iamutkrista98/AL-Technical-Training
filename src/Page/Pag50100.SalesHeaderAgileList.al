page 50100 "Sales  Header Agile List"
{
    ApplicationArea = All;
    Caption = 'Sales  Header Agile List';
    PageType = List;
    SourceTable = "Sales Header Agile";
    UsageCategory = Lists;
    CardPageId = "Sales Header Agile Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    AutoFormatType = 11;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("No.", '=%1', 'AGILE-0050');
        Rec.FilterGroup(0);
        Rec.SetFilter("Customer No.", '<>%1', '10000');


    end;
}
