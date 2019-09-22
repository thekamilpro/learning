Function Get-DiskInfo {
    foreach ($domain in (Get-ADForest).domains) {
        $params = @{
            'Filter' = "*"
            'Server' = $domain
        }
        
        foreach ($computer in Get-ADDomainController @params) {
                      
            $params = @{
                'ClassName'    = 'Win32_ComputerSystem' 
                'ComputerName' = "$computer"
            }
            
            $props = Get-CimInstance @params 
            [PSCustomObject]@{
                'DomainController' = $computer
                'Manufacturer' = $props.Manufacturer
                'Model' = $props.Model
                'RAM' = $props.TotalPhysicalMemory
            }  
            
            
        } #foreach computer
            
    } #foreach domain
}#function