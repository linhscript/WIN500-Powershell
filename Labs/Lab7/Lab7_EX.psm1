function Get-HDInfo{
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Format-List -Property DeviceID, @{name = 'Size'; expression = {[math]::truncate($_.Size / 1GB)}}, @{name = 'Freespace'; expression = {[math]::truncate($_.freespace / 1GB)}}
}

function Get-PartitionInfo{

$Disk = Get-WmiObject -Class Win32_logicaldisk -Filter "DeviceID = 'C:'"
$diskRelate = $Disk.GetRelationships() | Select-Object -Property __RELPATH
$diskpart = $DiskPartition = $Disk.GetRelated('Win32_DiskPartition')
$DiskPartition | Format-List -Property Name, PrimaryPartition, @{name = 'Size'; expression = {[math]::truncate($_.Size / 1GB)}}


}
New-Alias -name "ghd" -Value "Get-HDInfo"
New-Alias -Name "gpi" -Value "Get-PartitionInfo"

Export-ModuleMember -Function * -Alias *