table 50100 "Sales Header Agile"
{
    Caption = 'Sales Header Agile';
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
                    SalesSetup.Get();
                SalesSetup.TestField(SalesSetup.salenoseries);
                NoSerMgt.SetSeries("No.");
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Cus: Record Customer;
            begin
                if Cus.Get("Customer No.") then
                    "Customer Name" := Cus.Name;
            end;
        }
        field(3; "Customer Name"; Text[200])
        {
            Caption = 'Customer Name';
        }
        field(4; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line Agile"."Total Amount" where("Document No." = field("No.")));
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; saleno; Code[20])
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
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup.salenoseries);
            Clear(NoSerMgt);
            NoSerMgt.InitSeries(SalesSetup.salenoseries, xRec.saleno, 0D, "No.", Rec.saleno);
        end;
    end;
}
