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
            #Connect session
            Write-Verbose "Connecting to $Computer over $protocol"
            $session = New-CimSession -ComputerName $computer -SessionOption $option
    
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
        } #foreach
    } #Process
    END {}
} #function

Get-MachineInfo

