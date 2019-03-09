################ MODULE MYCMDLETS ##############

function Get-Computerinfo
{

    <#
    .Synopsis
       Short description
    .DESCRIPTION
       Long description
    .EXAMPLE
       Example of how to use this cmdlet
    .EXAMPLE
       Another example of how to use this cmdlet
    #>


    Get-CimInstance Win32_OperatingSystem -ComputerName $computer | Select-Object CSName, Caption, LastBootUpTime

}


function Add-NEWUSER
{

    <#
    .Synopsis
       Short description
    .DESCRIPTION
       Long description
    .EXAMPLE
       Example of how to use this cmdlet
    .EXAMPLE
       Another example of how to use this cmdlet
    #>

    $first_name = Read-Host "Enter First Name "
    $last_name = Read-Host "Enter last Name "
    $department = Read-Host "Enter Department "
    
     New-ADUser -SamAccountName $username `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd" -Force)`
    -Name $username

}


function Get-UserInfo
{

    <#
    .Synopsis
       Short description
    .DESCRIPTION
       Long description
    .EXAMPLE
       Example of how to use this cmdlet
    .EXAMPLE
       Another example of how to use this cmdlet
    #>

    $first_name = Read-Host "Enter First Name "
    $last_name = Read-Host "Enter last Name "
    $department = Read-Host "Enter Department "
    
     New-ADUser -SamAccountName $username `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd" -Force)`
    -Name $username

}
