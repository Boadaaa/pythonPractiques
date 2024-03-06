# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Obtener la máquina virtual
$vm = Get-VM -Name AlpineMain

# Establecer la dirección IP y el puerto SSH de la máquina virtual
$sshAddress = "172.24.69.222"
$sshPort = 22

# Establecer el nombre de usuario y la contraseña para SSH
$username = "troll"
$password = "Patata123"

# Crear un objeto PSCredential para la autenticación SSH
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Conectar por SSH a la máquina virtual
$session = New-SSHSession -ComputerName $sshAddress -Credential $credential -Port $sshPort

# Ejecutar un comando para verificar el estado del servicio de Apache
$result = Invoke-SSHCommand -SessionId $session.SessionId -Command "service apache2 status"

# Mostrar el resultado
if ($result.Output -match "active") {
    Write-Host "El servicio Apache está funcionando en la máquina virtual."
} else {
    Write-Host "El servicio Apache no está funcionando en la máquina virtual."
}

# Cerrar la sesión SSH
Remove-SSHSession -SessionId $session.SessionId

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false


