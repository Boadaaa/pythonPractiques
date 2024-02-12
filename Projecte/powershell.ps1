$User = "root"
$Password = ConvertTo-SecureString "Patata123*" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)
Connect-VIServer -Server 172.24.69.102 -Credential $Credential

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

Get-VM | Select-Object Name, PowerState, NumCpu, MemoryMB, Version, Guest

