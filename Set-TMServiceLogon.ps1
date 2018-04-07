function Set-TMServiceLogon{
    param(
        [string]$ServiceName,
        [string]$NewPassword,
        [string]$NewUser,
        [string[]]$ComputerName,
        [string]$ErrorLogFilePath
    )
    foreach ($computer in $COmputerName){
        $option = New-CimSessionOption -Protocol Wsman
        $Session = New-CimSession -SessionOption $option -ComputerName $COmputerName

        If ($PSBoundParameters.ContainsKey('NewUser')) {$args} = @{'StartName' =$NewUser;'StartPassword'=$NewPassword
    } ELSE {
        $args = @{'StartPassword'=$NewPassword}
    }

    Invoke-CimMethod -Query "SELECT * FROM Win32_Service WHERE Name='$ServiceName'" `
                     -MethodName Change `
                     -ComputerName $computer `
                     -Arguments $args | Select-Object -Property @{n='ComputerName';e={$computer}},@{n='Result';e={$_.ReturnValue}}
        
        $Session | Remove-CimSession
    }#foreach
}#function