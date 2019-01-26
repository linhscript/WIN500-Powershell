
<#

.SYNOPSIS
  Powershell script to get system information from remote computers.
  
.DESCRIPTION
  This PowerShell script reads a list of computer names (or IP Addresses)
  from a CSV file and remotely gets the system information related to its
  Operating System, Disk and network. The output is written to a another
  CSV file in table format. 
  
.PARAMETER <infile>
   File name and path of the input CSV file to read.

.PARAMETER <outfile>
   File name and path of the outout CSV file.
 
.NOTES
  Version:        1.0
  Author:         Open Tech Guides
  Creation Date:  16-Jan-2017
 
.LINK
    www.opentechguides.com
    
.EXAMPLE
  Get-SysInfo c:\IPaddressList.csv c:\SysInfo.csv
   
#>

Param(
  [Parameter(Mandatory=$true, position=0)][string]$infile,
  [Parameter(Mandatory=$true, position=1)][string]$outfile
)

#Column header in input CSV file that contains the host name 
$ColumnHeader = "ComputerName"
$HostList = import-csv $infile | select-object $ColumnHeader
$out = @()

foreach($object in $HostList) {
    
    $os = Get-WmiObject -computername $object.("ComputerName") -class win32_operatingsystem
    $vol = Get-WmiObject -computername $object.("ComputerName") -class Win32_Volume
    $net = Get-WmiObject -computername $object.("ComputerName") -class Win32_NetworkAdapterConfiguration | where-object { $_.IPAddress -ne $null }

    $DeviceInfo= @{}
    $DeviceInfo.add("Operating System", $os.name.split("|")[0])
    $DeviceInfo.add("Version", $os.Version)
    $DeviceInfo.add("Architecture", $os.OSArchitecture)
    $DeviceInfo.add("Serial Number", $os.SerialNumber)
    $DeviceInfo.add("Organization", $os.Organization)
    $DeviceInfo.add("Disk Capacity", "$([math]::floor($vol.Capacity/ (1024 * 1024 * 1024 )) )" + " GB" )
    $DeviceInfo.add("Free Capacity", "$([math]::floor($vol.FreeSpace/ (1024 * 1024 * 1024 )))" + " GB" )
    $DeviceInfo.add("System Name", $vol.SystemName)
    $DeviceInfo.add("File System", $vol.FileSystem)
    $DeviceInfo.add("IP Address", ($net.IPAddress -join (", ")))
    $DeviceInfo.add("Subnet", ($net.IPSubnet  -join (", ")))
    $DeviceInfo.add("MAC Address", $net.MACAddress )

    $out += New-Object PSObject -Property $DeviceInfo | Select-Object `
              "System Name", "Organization", "Serial Number","Operating System", `
              "Version","Architecture","File System","Disk Capacity", `
              "Free Capacity","MAC Address","IP Address","Subnet"

    Write-Verbose ($out | Out-String) -Verbose             
    $out | Export-CSV $outfile -NoTypeInformation
 }