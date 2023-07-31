page 50101 "Sales Header Agile Card"
{
    Caption = 'Sales Header Agile Card';
    PageType = Card;
    SourceTable = "Sales Header Agile";

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
                    ShowMandatory = true;
                    NotBlank = true;
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
                part("Sales Line Agile"; SalesLineAgile)
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
            action("Post")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    PurchMgmt: Codeunit PurchaseManagement;
                begin
                    if not (Confirm('Do you want to post?', false)) then
                        exit;
                    PurchMgmt.PostPurchToPostedPurch(Rec."No.");


                    Message('Document has been posted');

                end;


            }


        }
    }
}
