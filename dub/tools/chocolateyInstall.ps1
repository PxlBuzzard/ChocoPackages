$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'dub'
  fileType       = 'exe'
  softwareName   = 'dub'

  checksum       = 'ea5176a9ad0c5c512375650a7fe773a40c8c6f4551d8b38764dbea83e9dcd850'
  checksumType   = 'sha256'
  url            = 'https://code.dlang.org/files/dub-1.11.0-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
