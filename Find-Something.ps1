    
$Data = Import-CSV C:\temp\test2.csv -Delimiter ';'

$Group = $Data | Group-Object -Property Company,Value | Select Name

$Group.Name | ConvertFrom-String -Delimiter ',' | group -Property P1 | Where { $_.Count -eq 1 -and $_.Group -like "*P2=0*" }
  

    