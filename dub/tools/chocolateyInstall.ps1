$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName    = 'dub'
  Url            = 'https://github.com//dlang/dub/releases/download/v1.23.0/dub-v1.23.0-windows-x86_64.zip'
  Checksum       = '53e51ad3ab62f493abfb2314a6b957c8166a2f7239100b0e7ae518340353a969'
  ChecksumType   = 'SHA256'
  unzipLocation  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
