<#
 # Made by Linh Van Ha - Assignment
#>

Clear-Host

## Input
$option = 0
$choice = 0

$computers = Get-ADcomputer -filter * | Select -ExpandProperty Name
$path_name= C:\Temp
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
$menu4 = @(
    "1. Check Active Accounts `n",
    "2. ?? `n",
    "3. Exit")
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

function s1.2 (){
    $diskinfo = Get-CimInstance -ComputerName $computers -ClassName Win32_LogicalDisk | Select-Object DeviceID,@{Label="Total Size (MB)";Expression={$_.Size /1MB -as [int]}},@{Label="Freespace (MB)";Expression={$_.freespace /1MB -as [int]}}
    $raminfo = Get-CimInstance Win32_computersystem -ComputerName $computers | Select-Object @{Label="Ram (GB)";Expression={$_.TotalPhysicalMemory /1GB -as [int]}}

}


do
{
    Clear-Host
    $menu1
    "`n"
    [int]$choice = Read-Host "Enter choice "
    
    switch ($choice)
    {
        '1' {}
        '2' {"Test2"}
        '3' {}
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

################ SECTION BREAK ##############

function Sub_menu3()
{
do
{
    Clear-Host
    $menu3
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

function Sub_menu4()
{
do
{
    Clear-Host
    $menu4
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

################ SECTION BREAK ##############
function Sub_menu5()
{
do
{
    Clear-Host
    $menu5
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

################ SECTION BREAK ##############

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

################ SECTION BREAK ##############

function Sub_menu9()
{
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





