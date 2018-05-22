function Upgrade-DB {
    [CmdletBinding()]

    param (
        [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
        [String] $Path,

        [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
        [String] $Username,

        [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
        [String] $ComputerName,

        [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
        [String] $DBName ,

        [Parameter(Mandatory = $true,ValueFromPipeline=$true)]
        [String] $DBPassword
    )

    BEGIN {

        Try {
            Import-Module -Name SQLPS -ErrorAction Stop
        }
        CATCH {
            Throw "No SQL modules installed"
        }

    } #BEGIN
    
    Process { 

        Write-Verbose "Getting list of files"
        $Files = Get-ChildItem -Path c:\temp -file | Where-Object {$_.Name -like "???.createtable.sql" -or $_.Name -like "???createtable.sql"} | Sort-Object -Property Name
    
        [int]$Highest = $Files.name[-1] -replace '\D|^0+', ''
        Write-Verbose -Message "Highest version is: $Highest"
            
        $DBconnection_params = @{
            'Username' = $Username
            'Password' = $DBPassword
            'Host'     = $ComputerName
            'DBName'   = $DBName
        }

        #$Connection = ConnectTo-DB @DBConnection_params
        #$DBVersion = $Connection | Get-DatabaseValue from -Table versionTable -Row version

        [int]$DBVersion = 001 #I've hardcoded the DB version as I never used SQL 

        IF ($Highest -eq $DBVersion) {
            Write-Information "Database is up-to-date"
        }
        ELSE {
            
            ForEach ($File in $Files) { 

                [int]$FileVersion = $File.name -replace '\D|^0+', '' #Using REGEX to remove leading zeros, and non-digits from the file names
                
                IF ($FileVersion -ge $DBVersion) {
                    Write-Verbose "Upgrading databe from Version $DBVersion to Version $FileVersion "
                    & $Path\$File
                    
                    #Set-DBVersion $FileVersion
                    #DBVersion = $Connection | Get-DatabaseVersion -Table 'versionTable' -Row 'version'

                    $DBVersion = $FileVersion
                } #IF

                ELSEIF ($DBVersion -ge $FileVersion) {
                    Throw "Database is newer than the upgrade script"
                } #ELSEIF

            }#ForEach ($File in $Files)

        } #IF/ELSE $Highest -eq $DBVersion

    } #process

    END {}

}#function

Upgrade-DB -Verbose