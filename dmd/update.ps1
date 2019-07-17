import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
    ".\dmd.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri "https://dlang.org/download.html"

  $re    = '\.exe$'
  $url   = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href

  $version  = ($url -split '/' | Select-Object -Last 1 -Skip 1)

  $releaseNotesUrl = "https://dlang.org/changelog/" + $version + ".html"

  @{
    URL32 = "http://downloads.dlang.org/releases/2.x/$version/dmd-$version.exe"
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor 32
