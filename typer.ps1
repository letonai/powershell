#Copiar texto de chat do Sametime
Add-Type -AssemblyName System.Windows.Forms
#Start-sleep 10
Add-Type @"
  using System.Runtime.InteropServices;
  using System;
 
  public class Tricks {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Fast Typer"
$objForm.Size = New-Object System.Drawing.Size(500,200) 
$objForm.StartPosition = "CenterScreen"

$infoTextBox = New-Object System.Windows.Forms.Label
$infoTextBox.Location = New-Object System.Drawing.Size(50,30) 
$infoTextBox.Size = New-Object System.Drawing.Size(360,40) 
$infoTextBox.Text = "Digite o texto e clique no botão, você terá 2 segundos para selecionar a janela onde o texto deve ser inserido"


$resultTextBox = New-Object System.Windows.Forms.TextBox
$resultTextBox.Location = New-Object System.Drawing.Size(50,70) 
$resultTextBox.Size = New-Object System.Drawing.Size(360,20) 
$resultTextBox.Text = ""

$button = New-Object System.Windows.Forms.button
$button.Location = New-Object System.Drawing.Size(50,120) 
$button.Size = New-Object System.Drawing.Size(60,20) 
$button.Text = "Type"
$button.Add_Click({
    Sleep 2
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.SendKeys($resultTextBox.Text)
})
$objForm.Controls.Add($infoTextBox)
$objForm.Controls.Add($button)
$objForm.Controls.Add($resultTextBox)

[void] $objForm.ShowDialog()
