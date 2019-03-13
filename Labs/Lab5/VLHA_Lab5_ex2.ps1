$credential = Get-Credential -Credential Administrator
Clear-Host
$computer_name = Read-Host "Enter computername "
Write-Host "============"

$list = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

if ($list -notcontains $computer_name){
    Write-Warning "Computer not in the domain"\
    break
}else{
    Write-Host "$computer_name in domain"
}


if (!(Test-Connection $computer_name -Count 1)){
    Write-Warning "Computer is not active"
    break
}else{
    Write-Host "$computer_name active"
}

if (-not([System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole] "Administrator")){
    Write-Warning "Not login with administrator"
    break
}else{
    Write-Host "Admin rights OK"
}

Write-Host "======="

New-PSSession -ComputerName $computer_name -Credential $credential
function Computer_info ($computer_name,$classname,$proper1,$proper2,$proper3)
{
   Get-CimInstance $classname | Select-Object $proper1, $proper2, $proper3, @{Label="Date and Time";Expression={date -Format D}} | fl
}


Invoke-Command -ComputerName $computer_name -ScriptBlock ${function:Computer_info} -ArgumentList $computer_name,Win32_operatingsystem,Caption,OSArchitecture,Version -Credential $credential

