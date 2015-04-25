$packageName = 'dub'
$version = '0.9.23'
$url = 'http://code.dlang.org/files/dub-{0}-windows-x86.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
