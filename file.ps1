function Get-CimHashTable {
    [CmdletBinding()]

    Param (
        [String] $Computername = localhost
    )


    $Cimparams = @{Computername = $Computername}
    $props = @{'PSComputerName'}

    Switch ($Value) {
        'OS' {
            $Cimparams.Add('classname', 'win32_operatingsystem')
            $Props += 'Version', 'Caption'
        }
        'CS' {
            $Cimparams.Add('classname', 'win32_operatingsystem')
            $Props += 'Model', 'Manufacturer'
        }
        'CPU' {
            $Cimparams.Add('Classname', 'win32_Processor')
            $Props += 'CPUID', 'Name', 'MacClockSpeed'
        }
        'Memory' {
            $Cimparams.Add('Classname', 'Win32_physicalMemory')
            $props += 'Banklabel', 'Capacity', 'Speed'
        }
    }

    $Data = Get-CimInstance @Cimparams
    $Data
}