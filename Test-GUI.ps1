<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    ProcessManager
#>

function test1 {  # Get-Process

    #step1 : Clear Page
    $ListView.Items.Clear()
    $ListView.Columns.Clear()
    
    $infor = Get-Process | Select-Object Id,ProcessName,CPU,Handles, NPM,WS

    #--- Create column

    $infor_properties = $infor[0].psobject.Properties 
    
    $infor_properties | ForEach-Object {
        $ListView.Columns.Add("$($_.Name)") | Out-Null
    }

    #----------- Done creating columns --------

    foreach ($item in $infor) # ------ show data into the column
    {
        $data = New-Object System.Windows.Forms.ListViewItem($item.Id)

        $data.SubItems.Add($item.ProcessName) | Out-Null
        $data.SubItems.Add("$($item.CPU)") | Out-Null
        $data.SubItems.Add($item.Handles) | Out-Null
        $data.SubItems.Add($item.NPM)| Out-Null
        $data.SubItems.Add($item.WS) | Out-Null
        $ListView.Items.Add($data) | Out-Null
    }

    $ListView.AutoResizeColumns("HeaderSize")

} 


function test2 {  # Kill Process

    $selected_process = @($ListView.SelectedIndices)
        
    #$idcolumn = ($ListView.Columns | where {$_.Text -eq "Id"}).Index

    $selected_process | ForEach-Object {
    
    
        $processid = $ListView.Items[$_].Text

        Stop-Process -Id $processid -Force

    }

    test1
    
} 

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles() 

$ProcessManager                  = New-Object system.Windows.Forms.Form
$ProcessManager.Size             = New-Object System.Drawing.Size (528,528)
$ProcessManager.text             = "Process Manager"
$ProcessManager.FormBorderStyle  = "FixedDialog"

$ListView                        = New-Object system.Windows.Forms.ListView
$ListView.location               = New-Object System.Drawing.size(8,40)
$ListView.Size                   = New-Object System.Drawing.Size(480,402)
$ListView.GridLines = $true
$ListView.AllowColumnReorder = $true
$ListView.MultiSelect = $true
$ListView.FullRowSelect = $true
$ListView.View = "Details"
$ListView.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor
[System.Windows.Forms.AnchorStyles]::Right -bor
[System.Windows.Forms.AnchorStyles]::Left -bor
[System.Windows.Forms.AnchorStyles]::Top
$ProcessManager.Controls.Add($ListView)



$refresh                         = New-Object system.Windows.Forms.Button
$refresh.text                    = "Get Process"
$refresh.width                   = 114
$refresh.height                  = 30
$refresh.location                = New-Object System.Drawing.Point(8,450)
$refresh.Font                    = 'Microsoft Sans Serif,10'
$refresh.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor
[System.Windows.Forms.AnchorStyles]::Left -bor
$refresh.Add_Click({test1})

$Kill                            = New-Object system.Windows.Forms.Button
$Kill.text                       = "End Process"
$Kill.width                      = 128
$Kill.height                     = 30
$Kill.location                   = New-Object System.Drawing.Point(350,450)
$Kill.Font                       = 'Microsoft Sans Serif,10'
$Kill.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor
[System.Windows.Forms.AnchorStyles]::Right -bor
$Kill.Add_Click({test2})

$ProcessManager.controls.AddRange(@($refresh,$Kill))

[void]$ProcessManager.ShowDialog()