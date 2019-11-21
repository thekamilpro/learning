$Memory = Get-Counter -Counter "\memory\Cache Faults/sec" -SampleInterval 1 -MaxSamples 1 

$Memory.CounterSamples.Path

[PSCustomObject]@{
    DateTime = $Memory.Timestamp
    ComputerName = $env:COMPUTERNAME
    CounterSet = "NA"
    Counter = "NA"
    Value = $Memory.CounterSamples.CookedValue
}