$host.ui.RawUI.WindowTitle = 'Pester Course Module 2'

$naPath = 'C:\code\learning\PowerShell\PesterPluralSight\Podcast-NoAgenda'
Set-Location $naPath

Import-Module Pester

Invoke-Pester "$naPath\Podcast-NoAgenda.Module.Ver02.Tests.ps1"