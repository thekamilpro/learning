Describe 'Podcast-NoAgenda Module Test' {
    
    It "Has the root module Podcast-NoAgenda.psm1" {
        ".\Podcast-NoAgenda.psm1" | Should Exist
    }

    It "has the a manifiest file of Podcast-NoAgenda.ps1" {
        ".\Podcast-NoAgenda.psd1" | Should Exist
    

    ".\Podcast-NoAgenda.psd1" | Should Contain 'Podcast-NoAgenda.psm1'
    }
}