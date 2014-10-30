$packageName = 'dub'
$version = '0.9.22'
$url = 'http://code.dlang.org/files/dub-{0}-windows-x86.zip' -f $version

try {
  Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
