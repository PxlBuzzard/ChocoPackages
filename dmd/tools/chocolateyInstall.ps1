$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = 'e02d6aff4b59b2f66ed21fb74e7d5688ec0a552df6a156df78937140a08f6293'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.082.1/dmd-2.082.1.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
