$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '35ea77ce1c3ab347a61eb58a5b6a5033da0d264391b569f5680a4ff0798d8576'
  checksumType   = 'sha256'
  url            = 'https://downloads.dlang.org/releases/2022/dmd-2.100.2.exe'

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
