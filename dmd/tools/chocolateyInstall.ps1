$packageName = 'dmd'
$version = '2.066.1'
$url = 'http://downloads.dlang.org/releases/{0}/dmd.{0}.windows.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
