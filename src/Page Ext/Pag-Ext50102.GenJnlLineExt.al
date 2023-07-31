pageextension 50102 "Gen Jnl Line Ext" extends "General Journal"
{
    layout
    {
        addafter(amount)
        {
            field("Sales Header Agile No."; Rec."Sales Header Agile No.")
            {
                ApplicationArea = All;
            }

        }
    }
}
