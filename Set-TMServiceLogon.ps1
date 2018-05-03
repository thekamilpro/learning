function Set-TMServiceLogon {
    <#
   .SYNOPSIS
   Tool to change username and password of given service.
   
   .DESCRIPTION
    Use this tool to change one service on multiple computers. It uses WSMAN therefore must be opened on firewall.

    .PARAMETER ServiceName
    Name of the service required. Mandatory.

    .PARAMETER NewPassword
    New password for the service. Mandatory.

    .PARAMETER NewUser
    New user under which the service will run

    .PARAMETER ComputerName
    Name of computer(s)

    .PARAMETER EorrLogFilePath
    Path to the error file

    .EXAMPLE
    Set-TMServiceLogon -ServiceName 'BITS' -ComputerName file1 -NewUsername tm.local\admin1 -NewPassword SecretOne
    This function will change the service "BITS" on Computer "File1", running it as "tm.local\admin1" with Password "SecretOne"

   #>
   
   
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
            Do {
                Write-Verbose "Connecting to $Computer on WS-MAN"
                $Protocol = 'Wsman'
            
                Try {
                    $option = New-CimSessionOption -Protocol $Protocol
                    #Connect session
            
                    $Session = New-CimSession -SessionOption $option -ComputerName $Computer -ErrorAction Stop

                    If ($PSBoundParameters.ContainsKey('NewUser')) {
                        $args = @{
                            'StartName'     = $NewUser
                            'StartPassword' = $NewPassword
                        }
                    }
                    ELSE {
                        $args = @{'StartPassword' = $NewPassword}
                        Write-Warning "Not setting a new user name"
                    }
                    #Change service
                    Write-Verbose "Setting $servicename on $computer"
                    $params = @{
                        'Query'        = "SELECT * FROM Win32_Service WHERE Name='$ServiceName'"
                        'MethodName'   = 'Change'
                        'ComputerName' = $computer
                        'Arguments'    = $args
                    }
                    $ret = Invoke-CimMethod @params
           
                    Switch ($ret.ReturnValue) {
                        "0" {$Status = "Success"}
                        "22" {$Status = 'Wrong user account'}
                        default {$Status = "Failed: $($ret.ReturnValue)"}
                    }
            
                    $props = @{
                        'ComputerName' = $computer
                        'Status'       = $Status
                    }
                    $obj = New-Object -TypeName psobject -Property $props
                    Write-Output $obj

                    #Close session
                    Write-Verbose "Clossing session"
                    $Session | Remove-CimSession
            
                }
                Catch {
                    # Change protocol - if we've tried both and logging was specified, log the computer
                    Switch ($Protocol) {
                        'Wsman' {$Protocol = 'Dcom'}
                        'Dcom' {
                            $Protocol = 'Stop' 
                            if ($PSBoundParameters.ContainsKey('ErrorLogFilePath')) {
                                Write-Warning "$computer failed: logged to $errorlogfilepath"
                                $computer | Out-File $ErrorLogFilePath -Append
                            } #if logging
                        }
                    } #switch

                }# try/catch
            } until ($Protocol -eq 'Stop')
        }#foreach
    }#process

    END {}

}#function

