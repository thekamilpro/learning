function Upgrade-DB {
    <#
   .SYNOPSIS
   Tool to upgrade databases.

   .DESCRIPTION
   Use this tools to invoke SQL files against provided DB. It will search for files in format: 000.createtable.sql and 000createtable.sql.
   The tool will check  the current version of database and execute only files with higher number in ascending version, updating the Database version.

    .PARAMETER Path
    Location where upgrade files are. Mandatory.

    .PARAMETER Usernmae
    User account which will login to database.

    .PARAMETER DBPassword
    Password to the DB.

    .PARAMETER ComputerName
    Name of the computer which runs the database. It can accept multiple computers.

    .PARAMETER DBName
    Database name.

    .EXAMPLE
    Upgrade-DB -Path C:\Files -Username Bob -DBPassword Passw0rd -DBName Dev - Computername SQL1
    This function will connect to Database Called "Dev" running on server "DQL1" using "Bob" as the username and "Passw0rd" as the password, executing files from "C:\Files" folder. 

   #>

    [CmdletBinding()]

    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String] $Path,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String] $Username,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]] $ComputerName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String] $DBName ,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
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

        foreach ($Computer in $ComputerName) {

            Write-Verbose "Getting list of files"
            $Files = Get-ChildItem -Path $Path -file | Where-Object {$_.Name -like "???.createtable.sql" -or $_.Name -like "???createtable.sql"} | Sort-Object -Property Name
    
            [int]$Highest = $Files.name[-1] -replace '\D|^0+', ''
            Write-Verbose -Message "Highest version is: $Highest"
            
            $DBconnection_params = @{
                'Username' = $Username
                'Password' = $DBPassword
                'Host'     = $Computer
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
                        Write-Verbose "Upgrading databe on $Computer from Version $DBVersion to Version $FileVersion "
                        & $Path\$File
                    
                        #Set-DBVersion $FileVersion
                        #DBVersion = $Connection | Get-DatabaseVersion -Table 'versionTable' -Row 'version'

                        $DBVersion = $FileVersion
                    } #IF

                    ELSEIF ($DBVersion -ge $FileVersion) {
                        Throw "Database is newer than the upgrade script on"
                    } #ELSEIF

                }#ForEach ($File in $Files)

            } #IF/ELSE $Highest -eq $DBVersion

        } #foreach #computer

    } #process

    END {}

}#function

Upgrade-DB -Verbose