Configuration DSC101Simple {

param (
    [Parameter()]
    [Boolean] $ICMP = $false,

    [Parameter(Mandatory=$true)]
    [Switch] $DisableServerManager
)

    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName PolicyFileEditor

    xFirewall AllowPingIPv4 {
        'Name' = 'FPS-ICMP4-ERQ-In'
        'Direction' = 'Inbound'
        'Action' = 'Allow'
        'Profile' = 'Any'
        'Enabled' = $ICMP.ToString()
    } #    xFirewall AllowPingIPv4 

    xFirewall AllowPingIpv6 {
        'Name' = 'FPS-ICMP6-ERQ-In'
        'Direction' = 'Inbound'
        'Action' = 'Allow'
        'Profile' = 'Any'
        'Enabled' = $ICMP.ToString()
    } #xFirewall AllowPingIpv6

    Registry BlockServerManagerAutostart {
        'Key' = 'HKLM:\Software\Microsoft\ServerManager\'
        'ValueName' = 'DoNotOpenServerManagerAtLogon' 
        'ValueType' = 'Dword'
        'ValueData' =  $DisableServerManager.ToBool() -as [System.Int32]
    } # Registry BlockServerManagerAutostart

    cAdministrativeTemplateSetting EnablePsTranscription {
            #Applies after gpupdate
        'PolicyType' = 'Machine'
        'KeyValueName' = 'Software\Policies\Microsoft\Windows\Powershell\Transcription\EnableTranscripting'
        'Type' = 'Dword'
        'Data' = '1'
        'Ensure' = 'Present'
    } #cAdministrativeTemplateSetting EnablePsTranscription

} #configuration


DSC101Simple -OutputPath C:\DSC  -DisableServerManager $true -ICMP $true #generates the MOF file

Start-DscConfiguration -Path c:\DSC -Verbose -Wait #run the configuration