page 50110 consumers
{
    APIGroup = 'Custom';
    APIPublisher = 'utkrista';
    APIVersion = 'v1.0';
    Caption = 'consumers';
    DelayedInsert = true;
    EntityName = 'consumers';
    EntitySetName = 'consumer';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
            }
        }
    }
}
