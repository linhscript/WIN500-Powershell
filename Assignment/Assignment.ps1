<#
 # Made by Linh Van Ha - Assignment
 Before running script, make sure allow ICMP on all VMS

 netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow

#>

Clear-Host

## Input
$option = 0
$choice = 0

$computers = Get-ADcomputer -filter * | Select -ExpandProperty Name
$path_name= "C:\Temp"
## End Input

### Begin Define Function

$menu1 = @(
    "1. Test Connection `n",
    "2. Get Information `n",
    "3. Display Website `n",
    "4. Back to Main Menu")

$menu3 = @(
    "1. Create Sessions `n",
    "2. Enter Sessions `n",
    "3. Disconnect Sessions `n",
    "4. Kill Sessions `n",
    "5. Exit")
$menu5 = @(
    "1. Create User `n",
    "2. Create Group `n",
    "3. Limit user using Powershell `n",
    "4. Exit")
$menu6 = @(
    "1. Get Computer Infor `n",
    "2. Add New User `n",
    "3. Get users infor `n",
    "4. Set Restricted rule for User `n",
    "5. Exit")
$menu8 = @(
    "1. Check Picture Folder `n",
    "2. Copy Picture `n",
    "3. Exit")
$menu9 = @(
    "1. Save computers to file `n",
    "2. Check Firewall Status `n",
    "3. Get Software authorized `n",
    "4. Exit")

function MainMenu ()
{
    
    Do
{
    Clear-Host
    "`n"
    "                  Win500 - Assignment            `n" 
    "------------------------------------------------- `n "
    Write-Host "
    1. Get Servers Informations `n
    2. Restart all the servers `n
    3. Sessions `n
    4. Remote functions `n
    5. Create/Modify/Delete User `n
    6. Cmdlets `n
    7. Create Endpoint `n
    8. Jpeg files `n
    9. Firewall Status `n
    10. Exit `n" 
     
     


    [int]$option = Read-Host "Enter option "

    switch ($option)
    {
       '1' {Clear-Host;Sub_menu1}
       '2' {Clear-Host;Sub_menu2}
       '3' {Clear-Host;Sub_menu3}
       '4' {Clear-Host;Sub_menu4}
       '5' {Clear-Host;Sub_menu5}
       '6' {Clear-Host;Sub_menu6}
       '7' {Clear-Host;Sub_menu7}
       '8' {Clear-Host;Sub_menu8}
       '9' {Clear-Host;Sub_menu9}
       '10' {Clear-Host;exit}
       Default {Write-Host "Wrong Option"}
    }
  
}
until ($option -eq 10)
     
                
}

################ SECTION BREAK ##############

function Sub_menu1()
{

function s1.1(){

Clear-Host
$global:valid_computers = @()
$global:unvalid_computer =@()
foreach ($s11 in $computers)

{
    if  (-Not (Test-Connection -ComputerName $s11 -Count 1 -Quiet)){
        Write-Output "$s11 Not Available `n" | Tee-Object $path_name\test-connection.txt 
        $global:unvalid_computer += $s11
    }else{
        Test-Connection -ComputerName $s11 -Count 1 
        $global:valid_computers += $s11
        "`n" 
    }
}

}

function s1.2 (){

#check if function S1.1 has ran or not
if ($valid_computers.Count -eq 0){s1.1}

$Global:out = @()
foreach ($s12 in $valid_computers)
{
    $comp = @{}
    $diskinfo = Get-CimInstance  -ClassName Win32_LogicalDisk -ComputerName $s12  | ? {$_.DriveType -eq 3}
    $raminfo = Get-CimInstance Win32_computersystem -ComputerName $s12 
    $system = Get-CimInstance Win32_OperatingSystem -ComputerName $s12
    
    $comp.Add("Server",$system.CSName)
    $comp.Add("Type",$system.Caption)
    $comp.Add("Serial Number",$system.SerialNumber)
    $comp.Add("Device",$diskinfo.DeviceID)
    $comp.Add("Disk Size","$([math]::round($diskinfo.Size /1MB))" + " MB" )
    $comp.Add("Free Space","$([math]::round($diskinfo.Freespace /1MB))" + " MB" )
    $comp.Add("RAM","$([math]::round($raminfo.TotalPhysicalMemory /1GB))" + " GB")


    $Global:out += New-Object psobject -Property $comp | Select-Object "Server","Type","Serial Number","Device","Disk Size",`
                                                                "Free Space","RAM" 

    
}

    $Global:out | ft | Out-File $path_name\computer_info.txt
    Write-Host "File has been saved to C:\Temp\computer_info.txt"
}

function s1.3(){
#check if function S1.1 has ran or not
if ($global:out.Count -eq 0){s1.2}

Clear-Host
 
$global:out  | ConvertTo-Html | Out-file $path_name\computer_info.html

    if ($unvalid_computer.Count -ne 0){
        foreach ($unvalid in $global:unvalid_computer)
        {
            Write-Output " Server: $unvalid" | Out-File $path_name\computer_info.html -Append
        }
        
    }
    
start $path_name\computer_info.html

}

do
{
    Clear-Host
    $menu1
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {s1.1;pause}
        '2' {s1.2;Pause}
        '3' {s1.3;Pause}
        '4' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ SECTION BREAK ##############

function Sub_menu2()  ## Action function
{
    $reset_coms = Get-ADComputer -Filter 'Name -notlike "SRV1-AD"' | Select-Object -ExpandProperty Name

    foreach ($item in $reset_coms)
    {
        Restart-Computer -ComputerName $item
        sleep 5
        do {
            Write-Host "Server $item is restarting `n"
        }until (Test-Connection $item -Quiet)
     
        Write-Host "RESTART DONE `n"   
        sleep 3
        $ip = (Test-Connection -ComputerName $item -ErrorAction SilentlyContinue).IPV4Address.IPaddresstostring[0]
        $st = (Get-CimInstance -ComputerName $item -ClassName Win32_operatingsystem).LastBootUpTime

        Write-Host "Server $item "
        Write-Host "Status:  Running"
        Write-Host "IP Address: $ip"
        Write-Host "Startup Time: $st `n"
    
    }
    Pause
}

################ SECTION BREAK ##############

function Sub_menu3()
{
function s3.1(){
    Clear-Host
    $session_name = Read-Host "Enter a Session Name "
    $session_computer = Read-Host "Enter computer want to connect "
    New-PSSession -ComputerName $session_computer -Name $session_name
    Get-PSSession

}

function s3.3(){

    Clear-Host
    Get-PSSession
       
}

function s3.4(){

    Clear-Host
    Remove-PSSession *
        
}

do
{
    Clear-Host
    $menu3
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {s3.1; pause}
        '2' {s3.2;Pause}
        '3' {s3.3;Pause}
        '4' {s3.4;Pause}
        '5' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}


################ User ##############

function Sub_menu4()
{

    Clear-Host
    $user_check = Read-Host "Enter user you want to check "
    if (dsquery user -samid $user_check) {

        if ((Get-ADUser -Identity $user_check ).Enabled){

             Write-Host "`nUser $user_check is ACTIVE `n"

             $logon=(Get-ADUser -Identity $user_check -Properties "LastLogonDate" ).LastLogonDate
             if ($logon){

                Write-Host "User $user_check has last Login at: $logon"
              }else{
                 Write-Host "User $user_check never loged on the system"   
                }
         }else{
             Write-Host "`nUser $user_check is NOT ACTIVE `n"
         }
    }else{
         Write-Host "User $user_check is not available"
    }
    
}

################ GROUP ##############
function Sub_menu5()
{

function s5.1{

    Clear-Host
    $global:username = Read-Host "Enter the username "

    ##Check if user exists or not
    if (-not (dsquery user -samid $username)){
    New-ADUser -SamAccountName $username `
    -Enabled $true `
    -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd" -Force)`
    -Name $username

    }else{
        Write-Host "Username already exists"
    }
}

function s5.2{

    Clear-Host
    $global:groupname = Read-Host "Enter Group Name "
    if (-not(dsquery group -samid $global:groupname)){
        New-ADGroup -name $global:groupname -GroupScope Global -SamAccountName $global:groupname
    
        Add-ADGroupMember -Identity $global:groupname -Members $username
        Add-ADGroupMember -Identity $global:groupname -Members Administrator

        Write-Host "`n Users have been added to the group`n"
    }else{
        Write-Host "`nGroup already exists`n"     
    }
}

function s5.3{
    
    Clear-Host

    Write-Host "Group $global:groupname  has been restricted to use Powershell"
    Set-GPPermission -Name "Limit Use Powershell" -PermissionLevel GpoApply -TargetName $global:groupname -TargetType Group
    gpupdate /force

}

do
{
    Clear-Host
    $menu5
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {s5.1;Pause}
        '2' {s5.2;Pause}
        '3' {s5.3;Pause}
        '4' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ MODULE ##############

function Sub_menu6()
{

if (-not (Get-Module mycmdlets)){
    Import-Module mycmdlets -Force
}

Write-Host "Imported Module MYCMDLETS Successfully" -ForegroundColor Green; Pause

do
{
    Clear-Host
    $menu6
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {gcif; pause}
        '2' {anu;Pause}
        '3' {gui;Pause}
        '4' {slt;Pause}
        '5' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ ENDPOINT ##############

function Sub_menu7()   ## Action Function
{

     Register-PSSessionConfiguration -Path "$HOME\Assignment.pssc" -name Assignment -ShowSecurityDescriptorUI -Force

     Write-Host "Constrained Endpoint has been registed sucessfully"

     
     
}

################ JPEG FILE ##############

function Sub_menu8()
{

function s8.1(){

    foreach ($com in $computers)
    {
        $path = "\\$com\c$\Temp\Picture"

        if (-not(Test-Path $path)){
            Write-Host "Picture folder is not exist on server $com. Creating Picture Folder"

            Invoke-Command -ComputerName $com -ScriptBlock {New-Item -Path C:\Temp\Picture -ItemType directory -Force}

        }else{
            Write-Host "Server $com already has Picture folder"
        }
    }

}


function s8.2(){
    
    $script_8 = 

    {
        $pic = Get-ChildItem -Path C:\Temp\Picture
        $allfiles = Get-ChildItem -Recurse -Include *jpg -path C:\Users | Where Directory -NotLike "*Picture*" 

        foreach ($item in $allfiles)
        {
            if ($item.Name -notin $pic.Name)
            {
                Copy-Item $item.FullName -Destination "C:\Temp\Picture" -Force
                Write-Output $item.Name
            }
        }

    }

    $display = @()

    foreach ($com in $computers)
    {
    $a = Invoke-Command -ComputerName $com -ScriptBlock $script_8 

        foreach ($file in $a)
        {
            $display += New-Object psobject -Property @{
            Server = $com
            Files = $file
            Status = "Copied Successfully"

            }  | select Server, Files, Status
        }


    }
     $display

}


do
{
    Clear-Host
    $menu8
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {s8.1; pause}
        '2' {s8.2; Pause}
        '3' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ SECTION BREAK ##############

function Sub_menu9()
{
function s9.1(){
   $computers | Out-File "$path_name\mysystems.txt"
   Write-Host "Computer name has been saved to mysystemss.txt file"
}


function s9.2(){

$fw_result =@()
$global:fw_rule_list = @()
$fwscript ={(netsh advfirewall show allprofiles state)[3] -replace 'State' -replace '\s'}
$fw_rule_script = {netsh advfirewall firewall show rule name=all status=enabled profile=domain }

foreach ($sv in $computers)
{

    $hash_computer = @{}
    $fw_program = @{}
    
    
    if (Test-Connection -ComputerName $sv -Count 1 -Quiet){
        try
        {
            $check = Invoke-Command -ComputerName $sv -ScriptBlock $fwscript
            if ($check -eq "OFF"){
               Invoke-Command -ComputerName (gc $path_name\mysystems.txt ) -ScriptBlock {netsh advfirewall set allprofiles state on} 
               Write-Host "Turning ON firewall on Server $sv"
            }    

            $status = Invoke-Command -ComputerName $sv -ScriptBlock $fwscript
            ##############################################################

            $fw_rule = Invoke-Command -ComputerName $sv -ScriptBlock $fw_rule_script



        }
        catch 
        {
            $status =  "Can not get Firewall Status"
        }

    }else{
    
            $status =  "Can not connect to server"
    
    }
        $hash_computer.Add("Server",$sv)
        $hash_computer.Add("Status",$status)
        
        $fw_result += New-Object psobject -Property $hash_computer | Select-Object "Server","Status" 

        $j = @()
        foreach ($rule in $fw_rule)
        {
            if ( $rule -like "Rule name*"){
    
                
                $j += $rule.Split(":")[1].trim()
                
                
            }
        }
        $fw_program.Add("Server",$sv)
        $fw_program.Add("Rule",$j)

        $global:fw_rule_list += New-Object psobject -Property $fw_program | Select-Object "Server","Rule" 


       
}

$fw_result | ft -AutoSize 

}

function s9.3(){


$fw_rule_list | ft -AutoSize 


}


do
{
    Clear-Host
    $menu9
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {s9.1; Pause}
        '2' {s9.2;Pause}
        '3' {s9.3;Pause}
        '4' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}


## End Define Function




# Script START


 MainMenu





