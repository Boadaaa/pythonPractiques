# Importa el módulo VMware PowerCLI
Import-Module VMware.PowerCLI

# Conecta al servidor ESXi
Connect-VIServer -Server 172.24.69.102 -User root -Password Patata123*

# Nombre de la máquina virtual original
$VMName = "AlpineMaquina"
$DatastorePath = "/vmfs/volumes/659eda0e-7a5a0587-c1a7-9c7bef2a7d69/ISOS/alpine-standard-3.19.1-x86_64.iso"
$DatastoreName = "DATASTORE_GRAN"
$VLAN = "LAN24"

# Nombre de la nueva máquina virtual (réplica)
$ReplicaVMName = "Alpine"

# Crea la máquina virtual original y muestra las propiedades seleccionadas
$VM = New-VM -Name $VMName -Datastore (Get-Datastore -Name $DatastoreName) -MemoryGB 1 -CD -GuestId "other5xLinux64Guest" -NumCpu 1 -DiskStorageFormat Thin | Select-Object -Property PowerState, Guest, NumCpu, CoresPerSocket, MemoryMB, VMHost, Name

# Montar archivo ISO si la ruta es válida
if (Test-Path $DatastorePath) {
    Set-CDDrive -CD (Get-CDDrive -VM $VM) -IsoPath $DatastorePath -StartConnected:$true -Confirm:$false
}

# Crear una nueva carpeta para la réplica
$ReplicaFolderName = "Replicas"
$ReplicaFolder = New-Folder -Name $ReplicaFolderName -Location (Get-Folder -NoRecursion)

# Obtén la máquina virtual original
$OriginalVM = Get-VM -Name $VMName

# Crea una réplica de la máquina virtual
$ReplicaVM = New-VM -VM $OriginalVM -Name $ReplicaVMName -Location $ReplicaFolder -RunAsync

# Desconecta del servidor ESXi
Disconnect-VIServer -Server 172.24.69.102 -Confirm:$false
