function Get-HDInfo {

    [CmdletBinding()]
    Param()

    Begin
    {}

    Process
    {
    
    $script:report = Get-CimInstance Win32_LogicalDisk -ComputerName $computer | select PSComputerName,Device,
        @{Label='Size';Expression={[math]::Round($_.Size/1GB)}}
        @{Label='FreeSpace';Expression={[math]::Round($_.FreeSpace/1GB)}}
        
    }

}