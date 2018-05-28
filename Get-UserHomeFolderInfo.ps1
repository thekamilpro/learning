Function Get-UserHomeFolderInfo {
[CmdletBinding()]

param (
    [Parameter(Mandatory=$true)]
    [String] $HomeRootPath
) #param

BEGIN {}

Process { 
    Write-Verbose -Message "Enumarting folders in $HomeRootPath"
    $params = @{
        'Path' = $HomeRootPath
        'Directory' = $true
    }


   ForEach ( $Folder in (Get-ChildItem @params) ) {
   Write-Verbose "Checking $($folder.name)"
   $params = @{
       'Identity' = $folder.Name
       'ErrorAction' = 'SilentlyContinue'
   }
   
   $user = Get-ADUser @params

   if ($User.samAccountName -eq $folder.Name) {
    Write-Verbose " + User exists in AD"
    $Result = Get-FolderSize -Path $folder.fullname
    [PSCustomObject]@{
        'User' = $User.Name
        'Path' = $folder.FullName
        'Files' = $result.Files
        'Size(B)' = $result.'Size(B)'
        'Status' = 'OK'
    }

    } ELSE {
    Write-Verbose " - User does not exist in AD"
    [PSCustomObject]@{
        'User' = $folder.name
        'Path' = $folder.FullName
        'Files' = $result.Files
        'Status' = 'Orphan'
    }
} 

 } #ForEach ( $Folder in Get-ChildItem @params )

} #process


END {}

} #function

Get-UserHomeFolderInfo -HomeRootPath C:\Users