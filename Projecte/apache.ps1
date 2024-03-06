# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Obtener la máquina virtual
$vm = Get-VM -Name AlpineMain

# Establecer el nombre de usuario y la contraseña para SSH
$username = "troll"
$password = "Patata123"


