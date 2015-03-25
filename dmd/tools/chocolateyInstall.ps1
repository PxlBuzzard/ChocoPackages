$packageName = 'dmd'
$version = '2.067.0'
$url = 'http://downloads.dlang.org/releases/2.x/{0}/dmd.{0}.windows.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
