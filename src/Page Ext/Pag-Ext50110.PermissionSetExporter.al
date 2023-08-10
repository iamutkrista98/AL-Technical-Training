pageextension 50110 PermissionSetExporter extends "Permission Sets"
{
    actions
    {
        addafter(Permissions)
        {
            action(ExportPermissionSet)
            {
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction();
                begin
                    Xmlport.Run(50100, false, false);
                end;
            }
        }
    }
}
