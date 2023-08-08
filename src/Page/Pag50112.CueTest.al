page 50112 "Cue Test"
{
    Caption = 'Cue Test';
    PageType = CardPart;
    SourceTable = Customer;
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(g1)
            {
                Caption = 'My Cue Group';
                field(Number; Number)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Message('Hello this is cue test');
                    end;

                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    StyleExpr = 'Unfavorable';

                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = All;
                    StyleExpr = 'Attention';
                }
            }
            cuegroup(g2)
            {
                Caption = 'Even More actions';
                actions
                {
                    action(HelloWorld)
                    {
                        Caption = 'Render Report';
                        ApplicationArea = All;
                        Image = TileReport;
                        trigger OnAction()
                        begin
                            Report.Run(Report::Malepa209);
                        end;

                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Number := 10;
    end;

    var
        Number: Integer;
}
