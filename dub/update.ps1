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
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $RepoUrl '-windows-x86_64\.zip$'
    Write-Host "URL: " $url
    $version = $url -split '/' | Select-Object -Last 1 -Skip 1
    Write-Host "VERSION: " $version

    return @{
        Version      = $version.Substring(1)
        URL32        = $url
        ReleaseNotes = "$RepoUrl/releases/tag/$version"
    }
}

update -ChecksumFor none -NoCheckChocoVersion

choco push dub.$($Latest.Version).nupkg --source https://push.chocolatey.org/
