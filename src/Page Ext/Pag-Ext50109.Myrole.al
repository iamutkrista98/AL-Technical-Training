pageextension 50109 Myrole extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(My; "Cue Test")
            {
                ApplicationArea = All;

            }

        }

        addafter("Favorite Accounts")
        {
            part(chart; "Customer Chart")
            {
                ApplicationArea = All;

            }

        }
        addbefore("User Tasks Activities")
        {
            part(My1; PostedSalesLineAgile)
            {
                Caption = 'Sales Line Agile';
                ApplicationArea = All;

            }
        }
    }
}
