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
}