$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://www.nordicsemi.com//-/media/Software-and-other-downloads/Desktop-software/nRF-Connect-for-Desktop/3-4-1/nrfconnectsetup341ia32.exe'
  softwareName  = 'nrf-connect*'
  checksum      = '90b90637ca76990de097269fae47a147e8a6b878cc081f0d95f4f04a29294ba8'
  checksumType  = 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyPackage @packageArgs
