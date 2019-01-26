<#
 # Made by Linh Van Ha - Assignment
#>

Clear-Host

## Input
$option = 0
$choice = 0
## End Input

### Begin Define Function

function MainMenu ()
{
    Clear-Host
    "`n"
    "                  Win500 - Assignment            `n" 
    "-------------------------------------------------
    "
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
                
}


function Sub_menu1 ()
{
    
    Clear-Host
    "`n"
    "                  Get Servers Informations            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}

function Sub_menu3 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}

function Sub_menu4 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}

function Sub_menu5 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}

function Sub_menu6 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}
function Sub_menu8 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}
function Sub_menu9 ()
{
    
    Clear-Host
    "`n"
    "                 Sessions            `n" 
    "-------------------------------------------------
    "
    
    switch ($option)
    {
        '1' {$menu_1}
        '2' {$menu_2}
        '3' {"c"}
        '4' {MainMenu}

        Default {}
    }
           
}
$menu_1 = "
    1. Get Servers Informations `n
    2. Restart all the servers `n
    3. menu1 `n
    10. Exit"

$menu_2 = "
    1. Get Servers Informations `n
    2. Restart all the servers `n
    3. menu2 `n
    10. Exit"



## End Define Function



# Script START

MainMenu
[int]$option = Read-Host "Enter option "

switch ($option)
{
   '1' {Clear-Host;Sub_menu(1)}
   '2' {Clear-Host;Sub_menu(2)}
   Default {Write-Host "Wrong Option"}
}
  




