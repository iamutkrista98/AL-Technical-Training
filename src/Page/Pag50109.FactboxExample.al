page 50109 FactboxExample
{
    Caption = 'FactboxExample';
    PageType = Card;

    layout
    {
        area(FactBoxes)
        {
            part(Mypart1; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';

            }
            part(KPI; "Acc. Sched. KPI Web Srv. Lines")
            {
                ApplicationArea = All;
                SubPageView = sorting("Acc. Schedule Name");
            }
            systempart(Link; Links)
            {
                ApplicationArea = All;

            }
            systempart(Notes; MyNotes)
            {
                ApplicationArea = All;


            }

        }
    }
}
