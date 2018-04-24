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

        foreach ($computer in $ComputerName) {
            
           
            $option = New-CimSessionOption -Protocol Wsman
            #Connect session
            Write-Verbose "Connecting to $ComputerName on WS-MAN"
            $Session = New-CimSession -SessionOption $option -ComputerName $COmputerName

            If ($PSBoundParameters.ContainsKey('NewUser')) {
                $args = @{
                    'StartName' = $NewUser
                    'StartPassword' = $NewPassword
                }
            }
            ELSE {
                $args = @{'StartPassword' = $NewPassword}
            }
            #Change service
            Write-Verbose "Setting $servicename on $computer"
            $params = @{
                'Query' = "SELECT * FROM Win32_Service WHERE Name='$ServiceName'"
                'MethodName' = 'Change'
                'ComputerName' = $computer
                'Arguments' = $args
            }
            $ret = Invoke-CimMethod @params
           
            Switch ($ret.ReturnValue) {
                "0" {$Status = "Success"}
                "22" {$Status = 'Wrong user account'}
                default {$Status = "Failed: $($ret.ReturnValue)"}
            }
           
            #Close session
            Write-Verbose "Clossing session"
            $Session | Remove-CimSession
            #Output data
            Write-Verbose "Outputing data" 
            $props = @{
                'ComputerName' = $computer
                'Statis' = $Status
            }
            New-Object -TypeName psobject -Property $props
            Write-Output $props

        }#foreach
    }#process

    END {}

}#function

