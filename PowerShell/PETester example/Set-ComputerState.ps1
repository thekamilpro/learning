function Set-ComputerState {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true,ValueFromPipeline = $true ,ValueFromPipelineByPropertyName = $true)]
        [String[]] $Computername,

        [Parameter(Mandatory)]
        [ValidateSet('Restart','Shutdown')]
        [String] $Action,

        [Switch] $Force
    )

    BEGIN {}

    Process {
        ForEach ($Comp in $Computername) {
            $params = @{'ComputerName' = $comp}

            #Force ?
            if ($Force) {
                $params.add('Force',$true)
            }

            #Which Action?
            If ($Action -eq 'Restart') {
                Write-Verbose "Restarting $comp (Force: $force)"
                Restart-Computer @params
            } ELSE {
                Write-Verbose "Stopping $comp (Force: $force)"
                Stop-Computer @params
            }

        }
    } #PROCESS
 END{}
}