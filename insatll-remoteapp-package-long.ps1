#$computerList = "Server Name"
#$regVar = "Name of the package "
#$packageName = "Packe name "
$computerList = $args[0]
$regVar = $args[1]
$packageName = $args[2]
foreach ($computer in $computerList)
{
    Write-Host "Connecting to $computer...."
    Invoke-Command -ComputerName $computer -Authentication Kerberos -ScriptBlock {
    param(
        $computer,
        $regVar,
        $packageName
        )

        Write-Host "Connected to $computer"
        if ([IntPtr]::Size -eq 4)
        {
            $registryLocation = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"
            Write-Host "Connected to 32bit Architecture"
        }
        else
        {
            $registryLocation = Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
            Write-Host "Connected to 64bit Architecture"
        }
        Write-Host "Finding previous version of `enter code here`$regVar...."
        foreach ($registryItem in $registryLocation)
        {
            if((Get-itemproperty $registryItem.PSPath).DisplayName -match $regVar)
            {
                Write-Host "Found $regVar" (Get-itemproperty $registryItem.PSPath).DisplayName
                $UninstallString = (Get-itemproperty $registryItem.PSPath).UninstallString
                    $match = [RegEx]::Match($uninstallString, "{.*?}")
                    $args = "/x $($match.Value) /qb"
                    Write-Host "Uninstalling $regVar...."
                    [diagnostics.process]::start("msiexec", $args).WaitForExit() 
                    Write-Host "Uninstalled $regVar"
            }
        }

        $path = "\\$computer\Msi\$packageName"
        Write-Host "Installaing $path...."
        $args = " /i $path /qb"
        [diagnostics.process]::start("msiexec", $args).WaitForExit()
        Write-Host "Installed $path"
    } -ArgumentList $computer, $regVar, $packageName
Write-Host "Deployment Complete"

}