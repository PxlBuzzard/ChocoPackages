$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '58dc803eee7d2b19ca5d03a1f06a6c64e6873ae97446a025bae2ed75cc89795a'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.095.0/dmd-2.095.0.exe'

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
