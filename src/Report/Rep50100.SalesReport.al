report 50100 "Sales Report"
{
    ApplicationArea = All;
    Caption = 'Sales Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report/RDLC/SalesReport.rdl';

    dataset
    {
        dataitem("Posted Sales Header Agile"; "Posted Sales Header Agile")
        {
            RequestFilterFields = "Customer No.", "No.";
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(CompName; CompInfo.Name)
            {


            }
            column(CompImage; CompInfo.Picture)
            {

            }
            column(CompPhone; CompInfo."Phone No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(No_; "No.")
            {

            }
            column(CompAddress; CompInfo.Address)
            {

            }

            dataitem("Posted Sales Line Agile"; "Posted Sales Line Agile")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Posted Sales Header Agile";


                column(Type; Type)
                {

                }

                column(ItemNo_; "No.")
                {

                }
                column(Item_Desc; Item.Description)
                {

                }
                column(Amount; Amount)
                {

                }
                column(Total_Amount; "Total Amount")
                {

                }
                column(Quantity; Quantity)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    Item.Get("No.");

                end;

            }
            trigger OnPreDataItem()
            begin
                CompInfo.Get();
                CompInfo.CalcFields(Picture);
            end;





        }


    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        CompInfo: Record "Company Information";
        Item: Record Item;
}
