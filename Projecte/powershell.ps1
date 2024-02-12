Connect-VIServer -Server 172.24.69.102

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

Get-VMHost

Get-VM | Select-Object Name, PowerState, NumCpu, MemoryMB, Version, Guest

