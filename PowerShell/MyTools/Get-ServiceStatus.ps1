function Restart-RemoteService {
    [CMDLETBINDING()]
    param (
        [Parameter(Mandatory)]
        [String] $ServiceName,

        [String] $ComputerName = 'localhost'
    )

    BEGIN {} #BEGIN

    PROCESS {

        $params = @{
            'Name'         = $ServiceName
            'ComputerName' = $ComputerName
        }
        
        Write-Verbose "Testing status of service"
        $Status = Get-Service @params

        if ($status.Status -eq 'Running') {
            Write-Host "Service $ServiceName has already been running"
        }
        ELSE {
            Write-Host "Starting Service $SeviceName"
            Get-Service @params | Start-Service
        }


    } #PROCESS

    END {} #END
        
} #function

