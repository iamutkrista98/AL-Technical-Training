page 50104 PostedSalesHeaderAgileCard
{
    Caption = 'PostedSalesHeaderAgileCard';
    PageType = Card;
    SourceTable = "Posted Sales Header Agile";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

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
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
            }

            group(SalesLineAgile)
            {
                part("Posted Sales Line Agile"; PostedSalesLineAgile)
                {
                    SubPageLink = "Document No." = field("No.");
                    ApplicationArea = All;
                    UpdatePropagation = Both;
                }

            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                Promoted = true;
                Image = Print;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;


                trigger OnAction()
                var
                    PostedSaleHdr: Record "Posted Sales Header Agile";

                begin
                    PostedSaleHdr.Reset();
                    PostedSaleHdr.SetRange("No.", Rec."No.");
                    if PostedSaleHdr.FindSet() then
                        Report.Run(Report::"Sales Report", true, true, PostedSaleHdr);

                end;

            }

        }
    }
}
