<#
 # Made by Linh Van Ha - Assignment
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
    "4. Set Restricted rule for User",
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
    
Invoke-Item $path_name\computer_info.html

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

    
}

################ SESSIONS ##############

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


################ REMOTE FUNCTIONS ##############

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

################ USERS AND COMPUTERS ##############
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
    $groupname = Read-Host "Enter Group Name "
    if (-not(dsquery group -samid $groupname)){
        New-ADGroup -name $groupname -GroupScope Global -SamAccountName $groupname
    
        Add-ADGroupMember -Identity $groupname -Members $username
        Add-ADGroupMember -Identity $groupname -Members Administrator

        Write-Host "`n Users have been added to the group`n"
    }else{
        Write-Host "`nGroup already exists`n"     
    }
}

function s5.3{

    Clear-Host

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

################ SECTION BREAK ##############

function Sub_menu6()
{
do
{
    Clear-Host
    $menu6
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {Get-EventLog -Newest 5 -LogName Application; pause}
        '2' {"Test2"}
        '3' {}
        '4' {}
        '5' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ SECTION BREAK ##############

function Sub_menu7()   ## Action Function
{

     
}

################ JPEG FILES ##############

function Sub_menu8()
{
do
{
    Clear-Host
    $menu8
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {Get-EventLog -Newest 5 -LogName Application; pause}
        '2' {"Test2"}
        '3' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}

################ FIREWALL STATUS ##############

function Sub_menu9()
{
function 9.1(){
   $computers | Out-File $path_name\mysystems.txt
   Invoke-Command -ComputerName (gc $path_name\mysystems.txt ) -ScriptBlock {netsh advfirewall set allprofiles state on}
}

do
{
    Clear-Host
    $menu9
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {Get-EventLog -Newest 5 -LogName Application; pause}
        '2' {"Test2"}
        '3' {}
        '4' {MainMenu}
        Default {"Wrong Choice"}
    }    
}
until ($choice -eq 4)
     
}


## End Define Function




# Script START


 MainMenu





