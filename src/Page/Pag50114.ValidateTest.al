page 50114 "Validate Test"
{
    Caption = 'Validate Test';
    PageType = Card;
    SourceTable = "Validate Table";
    UsageCategory = Documents;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(PK; Rec.PK)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PK field.';
                }
                field("Validate This"; Rec."Validate This")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Validate This field.';
                }
            }
        }
    }
}
