if ($env:COMPUTERNAME -eq "SRV1-AD"){
    Set-ExecutionPolicy Unrestricted -Force

}elseif((Get-ExecutionPolicy) -ne "Restricted"){
    Set-ExecutionPolicy Restricted -Force
    
}

$status="$env:COMPUTERNAME=$(Get-ExecutionPolicy)"
return $status