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
  $release = Invoke-RestMethod -Uri "https://api.github.com/repos/dlang/dmd/releases/latest" -Headers @{
    Accept = "application/vnd.github+json"
    "User-Agent" = "ChocoPackages-DMD-AU"
  }

  if ($release.tag_name -notmatch '^v?(\d+\.\d+\.\d+)$') {
    throw "Latest DMD release has an unexpected tag: $($release.tag_name)"
  }
  $version = $Matches[1]

  $installerName = "dmd-$version.exe"
  $installer = $release.assets | Where-Object name -eq $installerName | Select-Object -First 1
  if (-not $installer) {
    throw "Could not find $installerName in the latest DMD release ($($release.tag_name))."
  }

  $releaseNotesUrl = "https://dlang.org/changelog/$version.html"

  @{
    URL32 = $installer.browser_download_url
    Version = $version
    ReleaseNotes = $releaseNotesUrl
  }
}

update -ChecksumFor 32
