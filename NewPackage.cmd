@echo off

:: NewPackage.cmd NameOfPackage

setlocal enableextensions
set OLDDIR=%CD%
:: Change to the directory containing the script
cd /d %0\..

md %1
md %1\tools
copy nuspec.template.xml %1\%1.nuspec
copy chocolateyInstall.template.ps1 %1\tools\chocolateyInstall.ps1

:: Return to the original directory
cd /d %OLDDIR%
