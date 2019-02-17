Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $true # Multiple files can be chosen
	Filter = 'Images (*.jpg, *.png)|*.jpg;*.png' # Specified file types
}
 
[void]$FileBrowser.ShowDialog()

$path = $FileBrowser.FileNames;

If($FileBrowser.FileNames -like "*\*") {

	# Do something before work on individual files commences
	$FileBrowser.FileNames #Lists selected files (optional)
	
	foreach($file in Get-ChildItem $path){
	Get-ChildItem ($file) |
		ForEach-Object {
		# Do something to each file
		}
	}
	# Do something when work on individual files is complete
}

else {
    Write-Host "Cancelled by user"
}