$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Set-ComputerState" {
    Mock Restart-Computer {Return 1}
    Mock Stop-Computer {Return 1}

    It "Accepts one computer name" {
        Set-ComputerState -computername SERVER1 -Action restart
        Assert-MockCalled Restart-Computer -Exactly 1 -Scope It}

    It "access and restart many names" {
        $Names = @('Server1','Server2','Server3')
        Set-ComputerState -Computername $Names -Action Restart
        Assert-MockCalled Restart-Computer -Exactly 3 -Scope It
    }

    It "Accepts and restart from the pipeline" {
        $Names = @('Server1','Server2','Server3')
        $Names | Set-ComputerState -Action Restart
        Assert-MockCalled Restart-Computer -computername -Exactly 3 -Scope It
    }

    It "Accepts and force-restarts one computer name" {
        Set-ComputerState -computername SERVER1 -Action restart -Force
        Assert-MockCalled Restart-Computer -Exactly 1 -Scope It}

        It "Accepts and shut down one computer name" {
            Set-ComputerState -computername SERVER1 -Action Shutdown
            Assert-MockCalled Stop-Computer -Exactly 1 -Scope It}
    

}
