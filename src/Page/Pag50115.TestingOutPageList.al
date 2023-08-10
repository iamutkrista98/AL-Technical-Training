page 50115 TestingOutPageList
{
    ApplicationArea = All;
    Caption = 'TestingOutPageList';
    PageType = List;
    SourceTable = TestingOutTable;
    UsageCategory = Lists;
    CardPageId = TestingOutPageCard;

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
                field("Text"; Rec."Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Text field.';
                }
            }
        }
    }
}
