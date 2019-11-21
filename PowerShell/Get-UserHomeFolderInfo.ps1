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
   
   
   ForEach ( $Folder in Get-ChildItem @params ) {
   Write-Verbose "Checking $folder"
   $params = @{
       'Identity' = $folder.Name
       'ErrorAction' = 'SilentlyContinue'
   }
   $user = Get-ADUser @params

   if ($User) {
    Write-Verbose "+ $User exists"
    $Result = Get-FolderSize -Path $folder.fullname
    [[PSCustomObject]@{
        'User' = $User.Name
        'Path' = $folder.FullPath
        'Files' = $result.Files
        'Size(B)' = $result.'Size(B)'
        'Status' = 'OK'
    }]

} ELSE {
    Write-Verbose " - User does not exist"
    [[PSCustomObject]@{
        'User' = $User.Name
        'Path' = $folder.FullPath
        'Path' = $folder.FullPath
        'Files' = $result.Files
        'Status' = 'Orphan'
    }]
} 


   }#if $user


   } #ForEach ( $Folder in Get-ChildItem @params )




} #process


END {}





} #function