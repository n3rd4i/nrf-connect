import-module au

$domain   = 'https://www.nordicsemi.com'
$releases = "$domain/Software-and-tools/Development-Tools/nRF-Connect-for-desktop/Download#infotabs"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   	= "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing #1
  $regex   = 'ia32.exe$'
  $url_raw     = $download_page.links | ? href -match $regex | select -First 1 -expand href #2
  $url = ($domain, $url_raw) -Join('')

  $token = $url -split 'nRF-Connect-for-Desktop/' | select -First 1 -Skip 1 #3
  $raw_version = $token -split '/nrfconnectsetup' | select -Last 1 -Skip 1 #3
  $version = $raw_version -replace '-','.'
  return @{ Version = $version; URL32 = $url }
}

update -ChecksumFor 32
