Configuration DSC101Simple {

    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName PolicyFileEditor

    xFirewall AllowPingIPv4 {
        'Name' = 'FPS-ICMP4-ERQ-In' ;
        'Direction' = 'Inbound' ;
        'Action' = 'Allow' ;
        'Profile' = 'Any' ;
        'Enabled' = 'True' ;
    } #    xFirewall AllowPingIPv4 

    xFirewall AllowPingIpv6 {
        'Name' = 'FPS-ICMP-ERQ-In' ;
        'Direction' = 'Inbound' ;
        'Action' = 'Allow' ;
        'Profile' = 'Any' ;
        'Enabled' = 'True' ;
    } #xFirewall AllowPingIpv6

    Registry BlockServerManagerAutostart {
        'Key' = 'HKLM:\\Software\Microsoft\ServerManager\'
        'ValueName' = 'DoNotOpenServerManagerAtLogon' 
        'ValueType' = 'Dword'
        'ValueData' = '1'
    } # Registry BlockServerManagerAutostart

    cAdministrativeTemplateSetting EnablePsTranscription {

        'PolicyType' = 'Machine'
        'KeyValueName' = 'HKLM:\Software\Policies\Microsoft\Windows\Powershell\Transcription\EnableTranscripting'
        'Type' = 'Dword'
        'Data' = '1'
        'Ensure' = 'Present'
    } #cAdministrativeTemplateSetting EnablePsTranscription

} #configuration


DSC101Simple -OutputPath C:\DSC  #generates the MOF file

Start-DscConfiguration -Path c:\DSC -Verbose -Wait #run the configuration