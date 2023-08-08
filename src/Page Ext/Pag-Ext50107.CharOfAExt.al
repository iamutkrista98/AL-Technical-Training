pageextension 50107 CharOfAExt extends "Chart of Accounts"
{
    actions
    {
        addfirst(processing)
        {
            action(Test)
            {
                Caption = 'Post Something';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GLPost: Codeunit "Gen. Jnl.-Post Line";
                    Line: Record "Gen. Journal Line";
                begin
                    Line.Init();
                    Line."Posting Date" := Today();
                    Line."Document Type" := Line."Document Type"::" ";
                    Line."Sales Header Agile No." := '1001';
                    Line."Document No." := 'X0000001';
                    Line."Account Type" := Line."Account Type"::"G/L Account";
                    Line."Account No." := '6610';
                    Line.Description := 'Testing Out 1';
                    Line.Amount := 100;
                    Line."Bal. Account Type" := Line."Bal. Account Type"::"G/L Account";
                    Line."Bal. Account No." := '6620';
                    GLPost.RunWithCheck(Line);







                end;



            }

        }

    }
}
