import-module au

$domain   = 'https://www.nordicsemi.com'
$releases = "$domain/Products/Development-Tools/nRF-Connect-for-desktop/Download"

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
  $regex   = '.exe$'
  $url_raw     = $download_page.links | ? href -match $regex | select -First 1 -expand href #2
  $url = ($domain, $url_raw) -Join('')

  $token = $url -split 'nRF-Connect-for-Desktop/' | select -First 1 -Skip 1
  $raw_version = [regex]::split($token, '(?:\d+-\d+-\d+)/nrfconnect-setup-') | select -Last 1
  $version = $raw_version -split '.exe' | select -First 1
  return @{ Version = $version; URL32 = $url }
}

update -ChecksumFor 32
