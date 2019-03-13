<#
.Synopsis
   GET PC INFORMATION USING CIM
.DESCRIPTION
   SERVER_INFO Function to get Server basic information

   ACCOUNT_INFO FUNCTION is to get account in given Server

   APPLICATION_INFO FUNCTION is to get server Installed Application
.EXAMPLE
   

.Notes
 NAME:      GETPCINFO
 AUTHOR:    VAN LINH HA
			DATELASTMODIFIED:  February 8th ,2019


#>
function Server_info
{
    [CmdletBinding()]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false)]
        $computer_name = "localhost"


    )


    Process
    {
       $Script:a = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer_name

       $result = New-Object psobject -Property @{
            ServerName = $a.CSName
            Version = $a.Caption
            StartupTime = $a.LastBootUpTime
            Manufacturer = $a.Manufacturer
       }      
       
       $result | ConvertTo-Html | out-file $home\Desktop\Test.html
       return $a
    }

}

function Account_info
{

        [CmdletBinding()]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false)]
        $computer_name = "localhost"


    )
    Process
    {

    $Script:b = Get-CimInstance Win32_UserAccount -ComputerName $computer_name

    Write-Output "##################### Server $computer_name ###################" | Out-File $home\Desktop\Test.html
   
    $b | select Name, Caption,SID | ConvertTo-Html | out-file $home\Desktop\Test.html -Append

    return $b



    }
}



function Application_info
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false)]
        $computer_name = "localhost"
        )
    Process
    {
    
    $Script:c = Get-CimInstance Win32_PRODUCT -ComputerName $computer_name

    Write-Output "##################### Server $computer_name ###################" | Out-File $home\Desktop\Test.html
   
    $c | select Name,Vendor,Version | ConvertTo-Html | out-file $home\Desktop\Test.html -Append

    return $c
    
    }



}

Export-ModuleMember -Function * -Alias *