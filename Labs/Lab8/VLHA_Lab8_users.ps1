Import-Csv "ADUsersCSV.csv" | ForEach-Object { New-ADUser -SamAccountName $_.SamAccountName `
-Name $_.Name `
-Surname $_.Surname `
-GivenName $_.GivenName `
-AccountPassword (ConvertTo-SecureString –AsPlainText "Itisgood2Bbad!" –force ) `
-Confirm

}

