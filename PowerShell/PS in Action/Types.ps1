#Must be run on Windows

#Finding current AppDomain
[System.AppDomain]::CurrentDomain

#Finding Assemblies
[System.AppDomain]::CurrentDomain.GetAssemblies()

#Listing all types
[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes()

#Count all types
[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes().Count

#Searching for specific type
[System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | Select-String datetime

#Function for searching types
function Find-Type {
    param 
    (
        [regex]$Pattern
    )
    [System.AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | Select-String $Pattern
}

Find-Type -Pattern datetime

#Looking where Powershell types are coming from
[powershell].Assembly

[powershell].Assembly.Location

#Checking when assemblies have been modified
[powershell].Assembly.Location | Get-ChildItem | foreach LastWriteTime