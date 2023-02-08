
<CS:EinsteinDataImporter ID="EinsteinDataImporter" TableName="EinsteinPublicIP" UseUploader="True" SprocName="EinsteinPublicIP_CRUD"  OnOnRowValidating="DataImporter_RowValidating"  runat="server">  
<DataFields>
    <CS:DataField  ImportColumnName="ASN_or_IP_Address" DBColumnName="IPAddress" SprocParamName="IPAddress" ValidationCodes="IPADDRESS,IPv4CIDR,ASN" ErrorMessage="Enter a valid value for IPAddress Row # {0}" runat="server"/>  
    <CS:DataField  ImportColumnName="Name_Purpose"  DBColumnName="Name" SprocParamName="Name"  ErrorMessage="Enter a valid Value for Name/Purpose. Failed to insert Row # {0}" runat="server"/>  
    <CS:DataField  ImportColumnName="ISP"  DBColumnName="ISP" SprocParamName="ISP" PickListUsageField="CSP"  ErrorMessage="Enter a valid Value for ISP field. Failed to insert Row # {0}" runat="server"/>  
    <CS:DataField  ImportColumnName="Other_ISP"  DBColumnName="OtherISP" SprocParamName="OtherISP" Require="false"  ErrorMessage="Enter a valid Value for Other_ISP field. Failed to insert Row # {0}" runat="server"/>  
    <CS:DataField  ImportColumnName="Visible_to_EINSTEIN"  DBColumnName="Visible" SprocParamName="Visible" PickListUsageField="YESNOUNK"  ErrorMessage="Enter a valid Value for Visible field. Failed to insert Row # {0}" runat="server"/>  
    <CS:DataField  ImportColumnName="External_Organization"  DBColumnName="ExternalOrg" SprocParamName="ExternalOrganization"  ErrorMessage="Enter a valid Value for External_Organization field. Failed to insert Row # {0}" runat="server"/>  
</DataFields>
<ItemTemplate>  
</ItemTemplate> 
</CS:EinsteinDataImporter> 

<!-- 


'BEGIN DataImporter
Protected Sub DataImporter_RowValidating(ByVal sender As Object, ByVal e As SpreadsheetImporter.RowValidatingEventArgs) Handles EinsteinDataImporter.OnRowValidating
    If e.DataRow("ISP").ToUpper() = "OTHER" And String.IsNullOrEmpty(e.DataRow("Other_ISP").Trim()) Then
        EinsteinDataImporter.ImportErrorLog.Add(New ImportError($"Enter a valid value for Other ISP as you have selected 'Other' for ISP field. Failed to insert Row # {e.RowNumber}"))
    End If
End Sub
Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    EinsteinDataImporter.SpreadsheetUploader.DestPath = Server.MapPath("~/TempUp/")
End Sub
'END DataImporter



-->
