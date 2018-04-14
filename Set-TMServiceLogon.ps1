function Set-TMServiceLogon {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$ServiceName,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$NewPassword,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$NewUser,
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]]$ComputerName,

        [string]$ErrorLogFilePath
    )

    BEGIN {}

    Process {

        foreach ($computer in $COmputerName) {
            $option = New-CimSessionOption -Protocol Wsman
            $Session = New-CimSession -SessionOption $option -ComputerName $COmputerName

            If ($PSBoundParameters.ContainsKey('NewUser')) {$args} = @{'StartName' = $NewUser; 'StartPassword' = $NewPassword
            } ELSE {
                $args = @{'StartPassword' = $NewPassword}
            }

            Invoke-CimMethod -Query "SELECT * FROM Win32_Service WHERE Name='$ServiceName'" `
                -MethodName Change `
                -ComputerName $computer `
                -Arguments $args | Select-Object -Property @{n = 'ComputerName'; e = {$computer}}, @{n = 'Result'; e = {$_.ReturnValue}}
        
            $Session | Remove-CimSession
        }#foreach
    }#process

    END {}

}#function