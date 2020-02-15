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

    $functions = ('Get-NoAgenda',
        'Get-PodcastData',
        'Get-PodcastMedia',
        'Get-PodcastImage',
        'ConvertTo-PodcastHtml',
        'ConvertTo-PodcastXML',
        'Write-PodcastHTML',
        'Write-PodcastXML')

    foreach ($function in $functions) {

        Context "Test Function $function" {
            It "$Function.ps1 should exist" {
                "$here\function-$function.ps1" | Should exist
            }

            It "$function.ps1 should a help block" {
                "$here\function-$Function.ps1" | Should Contain '<#'
                "$here\function-$Function.ps1" | Should Contain '#>'
            }

            It "$function.ps1 should have a SYNOPSIS section in the help block" {
                "$here\function-$function.ps1" | Should contain '.SYNOPSIS'
            }
            
            It "$function.ps1 should have a DESCRIPTION section in the help block" {
                "$here\function-$function.ps1" | Should contain '.DESCRIPTION'
            }
                        
            It "$function.ps1 should have a EXAMPLE section in the help block" {
                "$here\function-$function.ps1" | Should contain '.EXAMPLE'
            }
                            
            It "$function.ps1 should be an advances function" {
                "$here\function-$function.ps1" | Should contain 'function'
                "$here\function-$function.ps1" | Should contain 'cmdletbinding'
                "$here\function-$function.ps1" | Should contain 'param'
            }

            It "$function.ps1 should contain Write-Verbose blocks" {
                "$here\function-$function.ps1" | Should contain 'Write-Verbose'
               
            }

            it "$function.ps1 is valid Powershell code" {
                $psFile = Get-Content -Path "$here\function-$function.ps1" -ErrorAction Stop
    
                $errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors) #checks if powershell code is valid [ref] creates a reference to the error
                $errors.Count | Should Be 0
            }
        } #context
        Context "$function has tests" {
            It "function-$($function).tests.ps1 should exist" {
                "function-$($function).tests.ps1" | should exist
            }
        }

    }#for each function
}