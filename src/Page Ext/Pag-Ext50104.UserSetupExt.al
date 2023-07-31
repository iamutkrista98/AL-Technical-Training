pageextension 50104 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Allow Posting"; Rec."Allow Posting")
            {
                ApplicationArea = All;

            }
        }
    }
}
