$credPath = Join-Path (Split-Path $profile)  MyCredential_L5.ps1.credential
$password = Get-Content $credPath | ConvertTo-SecureString

$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'administrator',$password

$script = {Remove-Computer -ComputerName WIN7-WS -UnjoinDomainCredential $using:credential -Verbose -Restart -Force}
Invoke-Command -ComputerName WIN7-WS -ScriptBlock $script