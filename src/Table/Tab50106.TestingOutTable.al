table 50106 TestingOutTable
{
    Caption = 'TestingOutTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSerMgt: Codeunit NoSeriesManagement;
            begin
                if Rec."No." <> xRec."No." then
                    SalesSetup.GET();
                SalesSetup.TestField(SalesSetup.testnoseries);
                NoSerMgt.SetSeries("No.");
            end;
        }
        field(2; "Text"; Text[200])
        {
            Caption = 'Text';
        }
        field(3; testno; Code[20])
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSerMgt: Codeunit NoSeriesManagement;
    begin
        SalesSetup.Get();
        SalesSetup.TestField(SalesSetup.testnoseries);
        Clear(NoSerMgt);
        NoSerMgt.InitSeries(SalesSetup.testnoseries, xRec.testno, 0D, "No.", Rec.testno);
    end;
}
