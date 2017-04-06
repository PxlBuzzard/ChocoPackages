$packageName = 'dub'
$version = '1.2.1'
$url = 'https://code.dlang.org/files/dub-{0}-windows-x86.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
