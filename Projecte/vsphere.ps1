# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Define los detalles de la plantilla y del host
$templateName = 'AlpineClonar'  
$newVMName = "AlpineMain"
$folderName = "Templates"

# Obtener la plantilla
$template = Get-Template -Name $templateName -Location (Get-Folder -Name $folderName)

# Crea la nueva máquina virtual a partir de la plantilla
$vm = New-VM -Template $template -Name 'AlpineMain' -VMHost $esx -Datastore $ds -DiskStorageFormat Thin

# Configura la CPU y la memoria de la nueva máquina virtual
$vm | Set-VM -NumCpu 2 -MemoryGB 4 -Confirm:$false

# Inicia la nueva máquina virtual
$vm | Start-VM -Confirm:$false

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false