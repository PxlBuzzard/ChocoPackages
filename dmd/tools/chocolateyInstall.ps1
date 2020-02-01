$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = 'adbc22e0dd79dce6980e93dfbf78abb7661e40d573b2ca18d9969fa1468a3fd2'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.090.0/dmd-2.090.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
