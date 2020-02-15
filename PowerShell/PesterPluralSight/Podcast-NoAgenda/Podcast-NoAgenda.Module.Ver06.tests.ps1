$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$module = 'Podcast-NoAgenda'

Describe "$Module Module Test" {
    
    Context 'Module Setup' { 
        It "Has the root module $Module.psm1" {
            "$Here\$Module.psm1" | Should Exist
        }

        It "has the a manifiest file of $Module.psm1" {
            "$Here\$Module.psd1" | Should Exist
            "$Here\$Module.psd1" | Should Contain "$Module.psm1"
        }

        it "$Module folder has functions" {
            "$here\function-*.ps1" | Should Exist
        }

        it "$Module is valid Powershell code" {
            $psFile = Get-Content -Path "$here\$module.psm1" -ErrorAction Stop

            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors) #checks if powershell code is valid [ref] creates a reference to the error
            $errors.Count | Should Be 0
        }
    } #Context module setup

    Context 'Test Functions' {
        It "Get-NoAgenda.ps1 should exist" {
            "$here\function-get-PodcastData.ps1" | Should exist
        }

        It "Get-PodcastMedia.ps1 should exist" {
            "$here\function-get-PodcastMedia.ps1" | Should exist
        }

        It "Get-PodcastImage.ps1 should exist" {
            "$here\function-get-PodcastImage.ps1" | Should exist
        }

        It "ConvertTo-PodcastHtml.ps1 should exist" {
            "$here\function-ConvertTo-PodcastHtml.ps1" | Should exist
        }

        It "ConvertTo-PodcastXML.ps1 should exist" {
            "$here\function-ConvertTo-PodcastXML.ps1" | Should exist
        }

        It "Write-PodcastHTML.ps1 should exist" {
            "$here\function-Write-PodcastHTML.ps1" | Should exist
        }
    
        It "Write-PodcastXML.ps1 should exist" {
            "$here\function-Write-PodcastXML.ps1" | Should exist
        }
    }#context test functions
}