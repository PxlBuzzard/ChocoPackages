import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri "https://code.dlang.org/download"

  $re = '\.exe$'
  $url = $download_page.links | ? href -match $re | Select-Object -First 1 -expand href
  $url = "https://code.dlang.org/" + $url

  $version  = ($url -split '-' | Select-Object -Last 1 -Skip 1)

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
