# Load Assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

# Create new Objects
$objForm = New-Object System.Windows.Forms.Form
$global:objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$objContextMenu = New-Object System.Windows.Forms.ContextMenu
$ExitMenuItem = New-Object System.Windows.Forms.MenuItem
$objNotifyIcon.Icon = ".\icon1.ico"
$job = $null
$p = $null


$checkCaps = {
$objNotifyIcon = $args[0]
write-host $objNotifyIcon.Text
$CAPS = [console]::NumberLock
    while($true){
        $CAPS = [console]::NumberLock
        if($CAPS){
          $objNotifyIcon.Icon = ".\icon1.ico"
          $objNotifyIcon.Text = "CAPS ON"
        }else{
          $objNotifyIcon.Icon = ".\icon3.ico"
          $objNotifyIcon.Text = "CAPS OFF"
        }
        Start-Sleep -m 100
        
    }
}

function StartTryIcon
{
    $objContextMenu.MenuItems.Clear()
    # Create an Exit Menu Item
    $ExitMenuItem.Index = 0
    $ExitMenuItem.Text = "E&xit"
    $ExitMenuItem.add_Click({
        $objForm.Close()
        $objNotifyIcon.visible = $false
        #$job.BeginStop()
    })

# Add the Exit and Add Content Menu Items to the Context Menu

$objContextMenu.MenuItems.Add($ExitMenuItem) | Out-Null
}

StartTryIcon
#$job = Start-Job -ScriptBlock $checkCaps -ArgumentList $objNotifyIcon
$p = [PowerShell]::Create()
$null = $p.AddScript($checkCaps).AddArgument($global:objNotifyIcon)
$job = $p.BeginInvoke()


# Assign an Icon to the Notify Icon object
$objNotifyIcon.Text = "Context Menu Test"
# Assign the Context Menu
$objNotifyIcon.ContextMenu = $objContextMenu
$objForm.ContextMenu = $objContextMenu

# Control Visibilaty and state of things
$objNotifyIcon.Visible = $true

$objForm.Visible = $false
$objForm.WindowState = "minimized"
$objForm.ShowInTaskbar = $false
$objForm.add_Closing({ $objForm.ShowInTaskBar = $False })
# Show the Form - Keep it open
# This Line must be Last
$objForm.ShowDialog()
