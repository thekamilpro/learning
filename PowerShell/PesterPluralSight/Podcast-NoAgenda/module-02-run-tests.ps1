$host.ui.RawUI.WindowTitle = 'Pester Course Module 2'

$naPath = 'C:\code\learning\PowerShell\PesterPluralSight\Podcast-NoAgenda'
Set-Location $naPath

Import-Module Pester

Invoke-Pester "$naPath\Podcast-NoAgenda.Module.Ver09.Tests.ps1"

Invoke-Pester "$naPath\function-Get-PodcastData.tests.ps1"

Invoke-Pester "$naPath\function-Get-PodcastImage.Tests.ps1" -tag 'Unit'
Invoke-Pester "$naPath\function-Get-PodcastImage.Tests.ps1" -tag 'Acceptance'
Invoke-Pester "$naPath\function-Get-PodcastImage.Tests.ps1"