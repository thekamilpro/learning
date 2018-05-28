function Add-ADComputerWindowsBuild {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipiline=$true)]
        [object[]]$inputobject
    )
    
    PROCESS {
        ForEach-Object ($comp in $inputobject) {
            $os = Get-CimInstance -ComputerName $comp.name `
                                    -Class Win32_OperatingSystem
            $comp | Add-Member -MemberType NoteProperty
                                -Name - OSBuild
                                -Value - $os.BuildNumber
        } #foreach
    } #process
} #function