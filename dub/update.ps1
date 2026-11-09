import-module au

$RepoUrl = "https://github.com/dlang/dub"

function Get-GitHubReleaseUrl( $GitHubRepositoryUrl, $Pattern='\.exe$') {
  $latestReleases = "$GitHubRepositoryUrl/releases/latest"
  Write-Host "LATEST RELEASE: $latestReleases"
  $latestPage = Invoke-WebRequest -Uri $latestReleases -UseBasicParsing
  $latestPage.Content -match '(?<=src=")[^"]+expanded_assets[^"]+' | Out-Null
  $assetsUrl = $Matches[0]
  Write-Host "ASSETS URL: $assetsUrl"
  if (!$assetsUrl) { throw "Can't find assets URL" }

  $domain  = $GitHubRepositoryUrl -split '(?<=//.+)/' | Select-Object -First 1
  $assetsPage = Invoke-WebRequest -Uri $assetsUrl -UseBasicParsing
  Write-Host "ASSETS Links: " $assetsPage.Links.Href
  $output = $assetsPage.Links | Where-Object href -match $Pattern | Select-Object -expand href | % { $domain + $_ }
  return $output
}

function global:au_SearchReplace {
  @{
    ".\dub.nuspec" = @{
      "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
      "\<iconUrl\>.+\</iconUrl\>" = "<iconUrl>$($Latest.IconUrl)</iconUrl>"
    }
    ".\tools\VERIFICATION.txt" = @{
      "(?m)^https://github\.com/dlang/dub/releases/download/.+windows-x86_64\.zip$" = $Latest.URL64
      "(?m)^[a-f0-9]{64}$" = $Latest.Checksum64
      "(?m)^Get-FileHash \.\\dub-.+windows-x86_64\.zip -Algorithm SHA256$" = "Get-FileHash .\$(Split-Path $Latest.URL64 -Leaf) -Algorithm SHA256"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $RepoUrl '-windows-x86_64\.zip$'
    Write-Host "URL: " $url
    $version = $url -split '/' | Select-Object -Last 1 -Skip 1
    Write-Host "VERSION: " $version

    $iconCommits = Invoke-RestMethod -Uri "https://api.github.com/repos/dlang/dub-registry/commits?path=public%2Fimages%2Flogo-small.png&per_page=1" -Headers @{
        Accept = "application/vnd.github+json"
        "User-Agent" = "ChocoPackages-Dub-AU"
    }
    $iconCommit = $iconCommits | Select-Object -First 1
    if (-not $iconCommit -or $iconCommit.sha -notmatch '^[a-f0-9]{40}$') {
        throw "Could not determine a valid commit for the dub-registry icon."
    }

    return @{
        Version      = $version.Substring(1)
        URL64        = $url
        ReleaseNotes = "$RepoUrl/releases/tag/$version"
        IconUrl      = "https://cdn.jsdelivr.net/gh/dlang/dub-registry@$($iconCommit.sha)/public/images/logo-small.png"
    }
}

update -ChecksumFor none
