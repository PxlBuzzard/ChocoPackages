$packageName = 'dmd'
$version = '2.066.0'
$url = 'ftp://ftp.dlang.org/dmd.{0}.windows.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
