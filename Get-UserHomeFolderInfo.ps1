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
<<<<<<< HEAD


   ForEach ( $Folder in (Get-ChildItem @params) ) {
   Write-Verbose "Checking $($folder.name)"
=======
   
   
   ForEach ( $Folder in Get-ChildItem @params ) {
   Write-Verbose "Checking $folder"
>>>>>>> 486b5d1aba98e3cb763ff18f778114642de7cef2
   $params = @{
       'Identity' = $folder.Name
       'ErrorAction' = 'SilentlyContinue'
   }
<<<<<<< HEAD
   
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
=======
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



>>>>>>> 486b5d1aba98e3cb763ff18f778114642de7cef2

} #process


END {}

<<<<<<< HEAD
} #function

Get-UserHomeFolderInfo -HomeRootPath C:\Users
=======




} #function
>>>>>>> 486b5d1aba98e3cb763ff18f778114642de7cef2
