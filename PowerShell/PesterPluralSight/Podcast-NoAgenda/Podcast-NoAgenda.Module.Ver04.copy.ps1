$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$module = 'Podcast-NoAgenda'

Describe "$Module Module Test" {
    
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
}