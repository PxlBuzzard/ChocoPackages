$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '662558d8b6a383b2f2fda515f68ce886b1d220a00640e04d548971d03d29205b'
  checksumType   = 'sha256'
  url            = 'https://s3.us-west-2.amazonaws.com/downloads.dlang.org/releases/2021/dmd-2.096.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

# Add dmd to PATH
$destDir = "C:/D/dmd2/windows"

$Bin = "bin"
if("$(GET-OSARCHITECTUREWIDTH)" -match "64") {
  $Bin = "bin64"
}

$BinPath = Join-Path -Resolve $destDir $Bin
Install-ChocolateyPath -PathToInstall $BinPath -PathType User
