$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '27de1eb00de3f9fab6daeebe90a9e61dd9d44663efa7103840d72dca4ba805ba'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.094.0/dmd-2.094.0.exe'

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
