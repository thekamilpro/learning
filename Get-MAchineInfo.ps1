Function Get-MachineInfo {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [Alias('CN','MachineName','Name')]
        [string[]]$Computername,

        [string]$LogFauilurePath,

        [ValidateSet('Wsman','Dcom')]
        [string]$Protocol = "wsman",

        [switch]$ProtocolFallback
    )

    BEGIN{}

    PROCESS{
    foreach ($computer in $Computername){

    #establish session protocol
    if ($Protocol -eq 'Dcom'){
        $option = New-CimSessionOption -Protocol Dcom
    }
    ELSE {
        $option = New-CimSessionOption -Protocol Wsman
    }
    #Connect session
    $session = New-CimSession -ComputerName $computer -SessionOption $option
    
    #query data
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $session

    #CLose session
    $session | Remove-CimSession

    #Output data
    $os | Select-Object -Property @{n='Computername';e={$computer}},Version,ServicePackMajorVersion
    } #foreach
    } #Process
    END {}
} #function

