# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Define los detalles de la plantilla y del host
$templateName = "AlpineClonar"  
$newVMName = "AlpineMain"
$folderName = "Templates"

# Obtener la plantilla
$template = Get-Template -Name $templateName -Location (Get-Folder -Name $folderName)

# Obtener el host donde se debe alojar la nueva máquina virtual
# En este caso, estoy obteniendo el primer host disponible. Puedes ajustarlo según tus necesidades.
$vmHost = Get-VMHost | Select-Object -First 1

# Crear la nueva máquina virtual
$vm = New-VM -Name $newVMName -VMHost $vmHost -Location (Get-Folder -Name $folderName) -Template $template

# Configurar la nueva máquina virtual
$vm | Set-VM -NumCpu 2 -MemoryGB 4 -Confirm:$false

# Iniciar la nueva máquina virtual
$vm | Start-VM -Confirm:$false

# Mostrar los campos específicos
$vm | Select-Object Guest, NumCpu, MemoryMB, VMHost, GuestId, Name, PowerState

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false
