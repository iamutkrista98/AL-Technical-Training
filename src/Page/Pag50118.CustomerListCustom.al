page 50118 "Customer List Custom"
{
    ApplicationArea = All;
    Caption = 'Customer List Custom';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s city.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which transactions with the customer that cannot be processed, for example, because the customer is insolvent.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s email address.';
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Change field.';
                }
            }
        }
    }
    views
    {
        view("Blocked Customers")
        {
            Caption = 'Blocked Customers';
            Filters = where(Blocked = filter('true'));
            SharedLayout = false;
            layout
            {
                modify("E-Mail")
                {
                    Visible = false;

                }
            }

        }
        view("Top Customers With Netchange")
        {
            Filters = where("Net Change" = filter('>2000'));
            SharedLayout = false;
            layout
            {
                modify("E-Mail")
                {
                    Visible = true;
                }
                modify("Phone No.")
                {
                    Visible = false;
                }
            }
        }
    }
}
