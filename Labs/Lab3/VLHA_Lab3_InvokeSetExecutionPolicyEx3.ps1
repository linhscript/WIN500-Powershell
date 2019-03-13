$result = Invoke-Command -ComputerName (gc $home\ADcomputers.txt) -FilePath $home\Desktop\Lab3_SetRestrictedPolicy.ps1 -Credential Administrator

$result | ConvertFrom-StringData | Format-Table  -Property Name,Value,@{Label="Date Changed";Expression={get-date -Format D}} -AutoSize