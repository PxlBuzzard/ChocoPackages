import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*Url32\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*Url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri "https://github.com/dlang/dub/releases" -UseBasicParsing
  $regex = 'windows-x86_64.zip$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
  $url = "https://github.com/" + $url
  $url = $url -split "-windows-" | Select-Object -Index 0
  $url = $url + "-windows-x86_64.zip"
  $version = $url -split 'dub-v' | Select-Object -Last 1
  $version =  $version -split '-windows' | Select-Object -Index 0
  @{
    Version = $version
    URL32   = $url
    URL64   = $url
  }
}

update -ChecksumFor none

choco push dub.$($Latest.Version).nupkg --source https://push.chocolatey.org/
