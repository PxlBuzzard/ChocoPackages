$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '548A013D40E209A4F87A4CD17EBB90617623A5C66C4F4BE43BA46A3B2EF1E98B'
  checksumType   = 'sha256'
  url            = 'https://downloads.dlang.org/releases/2023/dmd-2.101.2.exe'

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
