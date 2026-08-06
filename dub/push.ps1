$packages = Get-ChildItem -Path $PSScriptRoot -Filter 'dub.*.nupkg' -File

foreach ($package in $packages) {
  choco push $package.FullName --source https://push.chocolatey.org/
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to push $($package.Name)."
  }
}
