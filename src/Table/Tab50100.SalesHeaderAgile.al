table 50100 "Sales Header Agile"
{
    Caption = 'Sales Header Agile';
    DataClassification = ToBeClassified;
    LookupPageId = "Item Card";
    DrillDownPageId = "Item Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            var
                SaleSetup: Record "Sales & Receivables Setup";
                NoSerMgt: Codeunit NoSeriesManagement;
            begin
                if Rec."No." <> xRec."No." then
                    SaleSetup.Get();
                SaleSetup.TestField(SaleSetup."salenoseries");
                NoSerMgt.SetSeries("No.");
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';


            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Customer No.") then
                    Validate("Customer Name", Cust.Name);

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
            Editable = false;
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.") { }
        fieldgroup(Brick; "Customer No.", "Customer Name", "Posting Date") { }
    }

    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSerMgt: Codeunit "NoSeriesManagement";
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."salenoseries");
            Clear(NoSerMgt);
            NoSerMgt.InitSeries(SalesSetup.salenoseries, xRec.saleno, 0D, "No.", Rec.saleno);

        end;
        "Posting Date" := Today;

    end;
}
