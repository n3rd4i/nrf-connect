﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir helper.ps1)"

$ahkProc = Start-Ahk('chocolateyuninstall.ahk')
$Uninstaller = [IO.Path]::Combine($ENV:LOCALAPPDATA, 'Programs', "nrfconnect", 'Uninstall nRF Connect.exe')
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'nrf-connect*'
  fileType      = 'EXE'
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}
$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key.Count -eq 1) {
  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)"
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    } else {
    }
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
Start-ChocolateyProcessAsAdmin "/C `"$Uninstaller`" $silentArgs" "$ENV:COMSPEC"

# minimum delay to ensure the autohotkey takes efect
& Start-Sleep 1
if (Get-Process -id $ahkProc.Id -ErrorAction SilentlyContinue) {Stop-Process -id $ahkProc.Id}
