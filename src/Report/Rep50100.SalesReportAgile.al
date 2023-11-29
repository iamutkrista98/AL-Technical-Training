report 50100 "Sales Report Agile"
{
    ApplicationArea = All;
    Caption = 'Sales Report Agile';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Report/RDLC/SalesBillAgile.rdl';
    dataset
    {
        dataitem("Posted Sales Header Agile"; "Posted Sales Header Agile")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Filters; Filters)
            {

            }
            column(CompName; CompInfo.Name)
            {

            }
            column(CompAddr; CompInfo.Address)
            {

            }
            column(CompPhone; CompInfo."Phone No.")
            {

            }
            column(CompLogo; CompInfo.Picture)
            {

            }
            column(No_; "No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }

            dataitem("Posted Sales Line Agile"; "Posted Sales Line Agile")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Type; Type)
                {

                }
                column(ItemNo; "No.")
                {

                }
                column(ItmName; Itm.Description)
                {

                }
                column(ItmAmount; Itm."Unit Price")
                {

                }
                column(GLDesc; GL.Name)
                {

                }
                column(GLAmount; GL."Debit Amount")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Total_Amount; "Total Amount")
                {

                }

                //for line details
                trigger OnAfterGetRecord()
                begin
                    Clear(Itm);
                    Clear(GL);
                    if Type = Type::Item then
                        Itm.Get("No.")
                    else
                        if Type = Type::"GL Account" then
                            GL.Get("No.");
                end;

            }

            //for posted sale header
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

    trigger OnPreReport()
    begin

        Filters := "Posted Sales Header Agile".GetFilters();
    end;


    var
        CompInfo: Record "Company Information";
        Itm: Record Item;
        GL: Record "G/L Account";
        Filters: Text;
}
