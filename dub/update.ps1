import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*Url32\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*Checksum32\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*ChecksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*Url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*Checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri "https://github.com/dlang/dub/releases" -UseBasicParsing
  $regex = 'windows-x86_64.zip$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
  $url = "https://github.com/" + $url
  $url32 = $url -split "-windows-" | Select-Object -Index 0
  $url32 = $url32 + "-windows-i686.zip"
  $url64 = $url -split "-windows-" | Select-Object -Index 0
  $url64 = $url64 + "-windows-x86_64.zip"
  $version = $url -split 'dub-v' | Select-Object -Last 1
  $version =  $version -split '-windows' | Select-Object -Index 0
  @{
    Version = $version
    URL32   = $url32
    URL64   = $url64
  }
}

update -ChecksumFor none

choco push dub.$version.nupkg --source https://push.chocolatey.org/
