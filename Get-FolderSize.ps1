function Get-FolderSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string[]]$Path
    )

    BEGIN {}

    Process {

        ForEach ($fldr in $path) {
Write-Verbose -Message "Checking $fldr"
            if (Test-Path -Path $fldr) {

                $params = @{
                    'Path'    = $fldr
                    'Recurse' = $true
                    'File'    = $true
                }

                $Measure = Get-ChildItem @params | Measure-Object -Property Length -Sum

                [PSCustomObject]@{
                    'Path'    = $fldr
                    'Files'   = $Measure.Count
                    'Size(B)' = $Measure.Sum
                }
            }#if test path
            ELSE {
                Write-Warning -Message "Path $fldr doesn't exist"
                [PSCustomObject]@{
                    'Path'    = $fldr
                    'Files'   = 0
                    'Size(B)' = 0
                }
            } #else
        } #ForEach ($fldr in $path)

    }#process

    END {}

} #function