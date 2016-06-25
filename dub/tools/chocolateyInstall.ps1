$packageName = 'dub'
$version = '1.0.0'
$url = 'http://code.dlang.org/files/dub-{0}-windows-x86.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
