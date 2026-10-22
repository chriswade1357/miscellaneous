# Define your list of devices (IP addresses or hostnames)
$devices = @(
    "192.168.0.3",
    "192.168.20.26",
    "192.168.50.12"
)

# Test connectivity and collect results into a variable
$results = foreach ($device in $devices) {
    $test = Test-NetConnection -ComputerName $device -Port 80 -WarningAction SilentlyContinue
    
    [PSCustomObject]@{
        Device      = $device
        Port22Open  = $test.TcpTestSucceeded
        PingSuccess = $test.PingSucceeded
    }
}

# Export the collected results to a CSV file on your Desktop
$csvPath = "$HOME\Desktop\Port22TestResults.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding utf8

Write-Host "Results successfully exported to: $csvPath" -ForegroundColor Green
