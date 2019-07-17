$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '9589d717f11361b335d7ba8aaf2b285baefe62f13ffab3c1ea6c7eaa5f53f1f6'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.087.0/dmd-2.087.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
