# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Obtener la máquina virtual
$vm = Get-VM -Name AlpineMain

# Establecer el nombre de usuario y la contraseña para SSH
$username = "troll"
$password = "Patata123"

# Conectar por SSH a la máquina virtual
$session = New-SSHSession -ComputerName $vm.Name -Credential (New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force)))

# Ejecutar un comando para verificar el estado del servicio de Apache
$result = Invoke-SSHCommand -SessionId $session.SessionId -Command "service apache2 status"

