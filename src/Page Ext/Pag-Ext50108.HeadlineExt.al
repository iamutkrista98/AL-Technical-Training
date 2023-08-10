pageextension 50108 HeadlineExt extends "Headline RC Business Manager"
{
    layout
    {
        addbefore(Control1)
        {
            field(HeadlineTxt1; HeadlineTxt1)
            {
                ApplicationArea = All;
                Caption = 'Headlines for Today';
                trigger OnDrillDown()
                begin
                    Hyperlink('https://www.google.com');
                end;
            }
            field(HeadlineTxt2; HeadlineTxt2)
            {
                ApplicationArea = All;


            }



        }
    }

    trigger OnOpenPage()
    begin

        HeadlineTxt1 := 'Hello there <emphasize>Im Utkrista</emphasize>';
        HeadlineTxt2 := 'How are you doing!';
    end;

    var
        HeadlineTxt1: Text;
        HeadlineTxt2: Text;

}
