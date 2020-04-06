$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '60fd18e19062979e987a82b667bb6ac666a3de440eaa1e0253498dd518276245'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.091.0/dmd-2.091.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
