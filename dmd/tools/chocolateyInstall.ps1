$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dmd'
  fileType       = 'exe'
  softwareName   = 'dmd'

  checksum       = '18cb8273614636b89423ec591b0848876d7645561fcc6122a739c257c7748910'
  checksumType   = 'sha256'
  url            = 'http://downloads.dlang.org/releases/2.x/2.083.0/dmd-2.083.0.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
