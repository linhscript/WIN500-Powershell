Import-Module ActiveDirectory

$aResults = @()
$List = Get-Content "C:\Temp\List.txt"
            
ForEach ($Item in $List) {
  $Item = $Item.Trim()
  $User = Get-ADUser -Filter { displayName -like $Item -and SamAccountName -notlike "a-*" -and Enabled -eq $True } -Properties SamAccountName, GivenName, Surname, telephoneNumber
  $sEmail = $User.GivenName + "." + $User.Surname + "@test.com"

  $hItemDetails = [PSCustomObject]@ {    
    FullName = $Item
    UserName = $User.SamAccountName
    Email = $sEmail
    Tel = $User.telephoneNumber
  }

  #Add data to array
  $aResults += $hItemDetails
}

$aResults | Export-CSV "C:\Temp\Results.csv"
