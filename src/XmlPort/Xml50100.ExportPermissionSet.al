xmlport 50100 ExportPermissionSet
{
    Caption = 'ExportPermissionSet';
    Format = xml;

    schema
    {
        textelement(PermissionSets)
        {
            tableelement(PSet; "Aggregate Permission Set")
            {
                SourceTableView = where("App Name" = filter(<> ''));
                XmlName = 'PermissionSet';
                fieldattribute(RoleID; pset."Role ID") { }
                fieldattribute(RoleName; PSet.Name) { }
                tableelement(P; "Tenant Permission")
                {
                    XmlName = 'Permission';
                    LinkTable = pset;
                    LinkFields = "Role ID" = field("Role ID");
                    textelement(ObjectType)
                    {

                    }

                }

            }
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
}
