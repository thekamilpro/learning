Function TryMe {
    [CmdletBinding()]
    Param(
        [string]$computername
    )

BEGIN {
    Write-Verbose "[$((get-date).TimeOfDay.ToString()) BEGIN ] Starting: $($Myinvocation.Mycommand)"
    Write-Verbose "[$((Get-Date).TimeOfDay.ToString())  BEGIN ] Initializing array"
    $a = @()
} #begin
    Process {
        Write-Verbose "[PROCESS] Processing $Computername"
        #codegoes here
    } #process
    END {
        Write-Verbose "[END    ] Ending $($MyInvocation.Mycommand)"
    } #end
}#function