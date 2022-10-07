import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*Url\s*=\s*)('.*')"        = "`$1'$($Latest.URL)'"
      "(?i)(^\s*Checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri "https://github.com/dlang/dub/releases" -UseBasicParsing
  $regex = '.zip$'
  $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
  $url = "https://github.com" + $url
  $version = $url -split 'tags/v' | Select-Object -Index 1
  $version =  $version -split '.zip' | Select-Object -Index 0
  @{
    Version = $version
    URL     = $url
  }
}

update -ChecksumFor 64

choco push dub.$($Latest.Version).nupkg --source https://push.chocolatey.org/
