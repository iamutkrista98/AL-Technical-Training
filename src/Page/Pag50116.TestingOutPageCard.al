page 50116 TestingOutPageCard
{
    Caption = 'TestingOutPageCard';
    PageType = Card;
    SourceTable = TestingOutTable;

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
                field("Text"; Rec."Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Text field.';
                }
            }
        }
    }
}
