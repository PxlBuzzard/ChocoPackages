$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName    = 'dub'
  FileFullPath = Get-Item $toolsPath\*windows-i686.zip
  FileFullPath64 = Get-Item $toolsPath\*windows-x86_64.zip
  Destination    = $toolsPath

  Checksum32       = ''
  ChecksumType32   = ''
  Checksum64       = ''
  ChecksumType64   = ''
  Url32            = 'https://github.com//dlang/dub/releases/download/v1.20.0/dub-v1.20.0-windows-i686.zip'
  Url64            = 'https://github.com//dlang/dub/releases/download/v1.20.0/dub-v1.20.0-windows-x86_64.zip'
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0 -Force
