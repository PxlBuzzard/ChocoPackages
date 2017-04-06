$packageName = 'dmd'
$version = '2.073.2'
$checksum = 'F3B9AD363463775223561B2D9A2EF8D83CC1585020107C7DF8F3D3EB4132BAFB'
$url = 'http://downloads.dlang.org/releases/2.x/{0}/dmd.{0}.windows.zip' -f $version
$installDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage -PackageName "$packageName" -Url "$url" -UnzipLocation "$installDir" -Checksum "$checksum" -ChecksumType "sha256"
