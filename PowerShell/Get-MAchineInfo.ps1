Function Get-MachineInfo {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [Alias('CN', 'MachineName', 'Name')]
        [string[]]$Computername,

        [string]$LogFauilurePath,

        [ValidateSet('Wsman', 'Dcom')]
        [string]$Protocol = "wsman",

        [switch]$ProtocolFallback
    )

    BEGIN {}

    PROCESS {
        foreach ($computer in $Computername) {

            # Establish session protocol
            if ($Protocol -eq 'Dcom') {
                $option = New-CimSessionOption -Protocol Dcom
            }
            ELSE {
                $option = New-CimSessionOption -Protocol Wsman
            }
            
            Try {
                #Connect session
                Write-Verbose "Connecting to $Computer over $protocol"
                $params = @{
                    'ComputerName' = $computer
                    'SessionOption' = $option
                    'ErrorAction' = 'Stop'
                }
                $session = New-CimSession @params
    
                # Query data
                Write-Verbose "Querying from $Computer"
                $os_params = @{'ClassName' = 'Win32_OperatingSystem'
                    'CimSession' = $Session
                }
                $os = Get-CimInstance @os_params

                $cs_params = @{'ClassName' = 'Win32_ComputerSystem'
                    'CimSession' = $session
                }
                $cs = Get-CimInstance @cs_params

                $sysdrive = $os.SystemDrive
                $drive_params = @{'ClassName' = 'Win32_LogicalDisk'
                    'Filter' = "DeviceId='$sysdrive'"
                    'CimSession' = $session
                }
                $drive = Get-CimInstance @drive_params

                $proc_params = @{'ClassName' = 'Win32_Processor'
                    'CimSession' = $session
                }
                $proc = Get-CimInstance @proc_params |
                    Select-Object -First 1

                #CLose session
                Write-Verbose "Closing session to $Computer"
                $session | Remove-CimSession

                #Output data
                Write-Verbose "Outputing from $computer"
                $obj = [pscustomobject]@{
                    'ComputerName' = $computer
                    'OSVersion' = $os.Version
                    'SPVersion' = $os.ServicePackMajorVersion
                    'OSBuild' = $os.OSBuild
                    'Manufacturer' = $cs.Manufacturer
                    'Model' = $cs.Model
                    'Procs' = $cs.numberofprocessors
                    'Cores' = $cs.numberoflogicalprocessors
                    'RAM' = ($cs.totalphysicalmemory / 1GB)
                    'Arch' = $proc.addresswidth
                    'SysdriveFreeSpace' = $drive.FreeSpace
                }
            
                Write-Output $obj
            }
            Catch {
                Write-Warning -Message "FAILED $computer on $protocol"

                #Did we specify protocol fallback?
                #If so, try again. If we specified logging,
                #we won't log a problem here - we'll let
                #the logging occur if this fallback also
                #fails
                If ($Protocol -eq 'Dcom') {
                    $newprotocol = 'Wsman'
                }
                ELSE {
                    $newprotocol = 'Dcom'
                } #if protocol

                Write-Verbose -Message "Trying again with $newprocol"
                $params = @{
                    'ComputerName' = $computer
                    'Protocol' = $newprotocol
                    'ProtocolFallback' = $false
                }

                If ($PSBoundParameters.ContainsKey('LogFailurePath')) {
                    $params += @{'LogFailurePath' = $LogFauilurePath}
                } #if logging
                Get-MachineInfo @params

            } #if protocolfallback

            #if we didn't specify fallback,
            #but we did specify logging, then log the error
            #because we won't be trying again

            if (-not $ProtocolFallback -and
                $PSBoundParameters.ContainsKey('LogFailurePath')) {
                Write-Verbose "Logging to $LogFailurePath"
                $computer | Out-File $LogFauilurePath -Append
            } #if write to log

            #} #try/catch
        
        } #foreach
    } #Process
    END {}
} #function

Get-MachineInfo

