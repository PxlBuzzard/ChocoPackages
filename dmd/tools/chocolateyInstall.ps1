$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '2c219847a2f82b4e0282abaf1208a15b9dac273e610ff3b4ca0c4aa679c50344'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.093.0/dmd-2.093.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
