[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
Add-Type -AssemblyName System.Windows.Forms
[reflection.assembly]::loadwithpartialname("system.windows.forms") | Out-Null
#[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[System.Threading.Thread]::CurrentThread.GetApartmentState()



function md5hash($path)
{
    $fullPath = Resolve-Path $path
    $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
    $file = [System.IO.File]::Open($fullPath,[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read)
    [System.BitConverter]::ToString($md5.ComputeHash($file)).replace('-','').toLower()
    $file.Dispose()
}

$f=""



$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "MD5 Checker"
$objForm.Size = New-Object System.Drawing.Size(500,200) 
$objForm.StartPosition = "CenterScreen"

$resultTextBox = New-Object System.Windows.Forms.TextBox
$resultTextBox.Location = New-Object System.Drawing.Size(80,100) 
$resultTextBox.Size = New-Object System.Drawing.Size(360,20) 
$resultTextBox.Text = ""
$objForm.Controls.Add($resultTextBox)

$md5Label = New-Object System.Windows.Forms.Label
$md5Label.Location = New-Object System.Drawing.Size(20,103) 
$md5Label.Size = New-Object System.Drawing.Size(160,20) 
$md5Label.Text = "MD5: "
$objForm.Controls.Add($md5Label) 

$selectedFileLabel = New-Object System.Windows.Forms.Label
$selectedFileLabel.Location = New-Object System.Drawing.Size(20,73) 
$selectedFileLabel.Size = New-Object System.Drawing.Size(80,20) 
$selectedFileLabel.Text = "Selected file: "
$objForm.Controls.Add($selectedFileLabel)  

$selectedFile = New-Object System.Windows.Forms.Label
$selectedFile.Location = New-Object System.Drawing.Size(140,73) 
$selectedFile.Size = New-Object System.Drawing.Size(100000,15) 
$objForm.Controls.Add($selectedFile)  

$objLabelPartner = New-Object System.Windows.Forms.Label
$objLabelPartner.Location = New-Object System.Drawing.Size(20,50) 
$objLabelPartner.Size = New-Object System.Drawing.Size(160,20) 
$objLabelPartner.Text = "File: "
$objForm.Controls.Add($objLabelPartner) 


$objTextBox = New-Object System.Windows.Forms.OpenFileDialog
$objTextBox.InitialDirectory = 'c:\letonai'
$objTextBox.MultiSelect = $false


$FilePicker = New-Object System.Windows.Forms.Button
$FilePicker.Location = New-Object System.Drawing.Size(200,50) 
$FilePicker.Size = New-Object System.Drawing.Size(160,20) 
$FilePicker.Text = "Select file"
$FilePicker.Add_Click({
    $objTextBox.ShowHelp = $true
    $objTextBox.ShowDialog() | Out-Null
    $f=$objTextBox.filename
    $selectedFile.Text = [System.IO.Path]::GetFileName($f)
    $resultTextBox.Text = md5hash $f
})
$objForm.Controls.Add($FilePicker)


[void] $objForm.ShowDialog()

