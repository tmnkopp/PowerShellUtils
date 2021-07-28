$collection  = New-Object System.Collections.ArrayList
$item = New-Object PsObject -Property @{        
    P1 = '1111';        
    P2 = '2222';  
}
[VOID] $collection.Add($item)
$item = New-Object PsObject -Property @{        
    P1 = '1111';        
    P2 = '2222';  
}
[VOID] $collection.Add($item)
$collection | foreach {
    Write-Host $item.P1
}