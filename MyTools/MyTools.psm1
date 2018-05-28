function Get-TMIPInfo {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
        [string[]]$ComputerName
    )
    
    BEGIN {}

    PROCESS {

        foreach ($comp in $ComputerName) {
            Write-Verbose "Connecting to $Comp"
            $s = New-CimSession -ComputerName $comp
            $adapters = Get-NetAdapter -CimSession $s |
                Where Status -ne 'Disconnected'

            ForEach ($adapter in $adapters) {
                Write-Verbose "   Interface $($adapter.interfaceindex)"
                $addresses = Get-NetIPAddress -InterfaceIndex $adapter.interfaceindex -CimSession $s

                foreach ($address in $addresses) {
                    
                    $props = @{
                        'ComputerName' = $comp
                        'Index'        = $adapter.interfaceindex
                        'Name'         = $adapter.interfacealias
                        'MAC'          = $adapter.macaddress
                        'IPAddress'    = $address.IPAddress
                    }

                    New-Object -TypeName -Property $props

                }#foreach address

            } #foreach adapter
            $s | Remove-CimSession
        } #foreach computer

    } #process
    END {}
} #FUNCTION