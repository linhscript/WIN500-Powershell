$time = Get-Date
$info = Get-CimInstance Win32_operatingsystem 
$boottime = [datetime]$info.LastBootUpTime
$hour = New-TimeSpan $boottime $time
$info | Select-Object `
@{Label="Computer";Expression="CSName"}, 
@{Label="Uptime";Expression={$hour.Hours}},
@{Label="DayLightSaving";Expression={(get-date).IsDaylightSavingTime()}} | ft -AutoSize

