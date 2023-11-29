page 50117 PracticeDocumentation
{
    Caption = 'PracticeDocumentation';
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(PracticeContent)
            {
                Caption = 'Practice Content';

                field(currDateTime; currDateTime)
                {
                    ApplicationArea = All;

                }
                field(anotherDate; anotherDate)
                {
                    ApplicationArea = All;

                }
                field(textinput; textinput)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Cust: Record Customer;

                    begin
                        Cust.Reset();
                        if Page.RunModal(Page::"Customer List", Cust) = Action::LookupOK then
                            textinput := Cust.GetFilters()
                        else
                            Message('You chose to cancel');
                    end;
                }

            }
            group(LocationDetails)
            {
                field(Longitude; Longitude)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2;


                }
                field(Latitude; Latitude)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2;


                }

            }
            cuegroup(GetLocationInformation)
            {
                actions
                {
                    action(GetLocation)
                    {
                        Caption = 'Get Location';
                        ApplicationArea = All;
                        Image = TilePeople;
                        trigger OnAction()
                        var
                            GeoLocate: Codeunit Geolocation;
                        begin
                            GeoLocate.SetHighAccuracy(true);
                            GeoLocate.RequestGeolocation();
                            GeoLocate.GetGeolocation(Longitude, Latitude);

                        end;

                    }

                }
            }
        }


    }
    actions
    {
        area(Processing)
        {
            action(ViewDateAndTime)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Image = DateRange;


                trigger OnAction()
                begin
                    Message('Today is : %1', currDateTime);
                    Message(DateMsg, Day, Month, Year);
                    if (anotherDate >= WorkDate()) then
                        Message('The workdate time are in synchronization');
                    if Format(anotherDate) = '' then
                        Message('%1', Evaluate(anotherDate, '<1W>'));
                    if Confirm('Are you sure', false) then
                        Message('hello there!');
                end;
            }
            action(ProcedureOverloadTest)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;
                Image = Process;

                trigger OnAction()
                var
                    overloadTest: Codeunit StringifierWithOverloads;
                begin
                    Message('%1', overloadTest.ToString(anotherDate));
                    Message('%1', overloadTest.ToString(33));
                    Message('%1', overloadTest.ToString('hello there'));

                end;
            }
            action(LookUpTesting)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Image = Find;


            }
            action(GeoLocate)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Image = Map;

                trigger OnAction()
                var
                    GeoLocate: Codeunit Geolocation;
                    Long: Decimal;
                    Lat: Decimal;
                begin
                    GeoLocate.SetHighAccuracy(true);
                    GeoLocate.RequestGeolocation();
                    GeoLocate.GetGeolocation(Long, Lat);
                    //Message('Longitude: %1 and Latitude: %2', Long, Lat);
                    Longitude := Long;
                    Latitude := Lat;


                end;
            }
            action(SendEmail)
            {
                ApplicationArea = All;
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    EmCU: Codeunit PurchaseManagement;
                begin
                    if Confirm('Are you sure you want to execute this action?', true) then
                        EmCU.SendAnEmail();

                end;





            }

        }
    }



    var
        currDateTime: DateTime;
        anotherDate: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        DateMsg: Label 'Today is %1 of day, %2 of month and the year being %3.';
        textinput: Text;
        Longitude: Decimal;
        Latitude: Decimal;


    trigger OnOpenPage()
    begin
        currDateTime := CurrentDateTime;
        anotherDate := WorkDate();
        Day := Date2DMY(anotherDate, 1);
        Month := Date2DMY(anotherDate, 2);
        Year := Date2DMY(anotherDate, 3);
    end;



}
