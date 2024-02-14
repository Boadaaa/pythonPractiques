# Importa el módulo VMware PowerCLI
Import-Module VMware.PowerCLI

# Conecta al servidor ESXi
Connect-VIServer -Server 172.24.69.102 -User root -Password Patata123*

# Nombre de la máquina virtual que deseas crear
$VMName = "AlpineMaquina"
$DatastorePath = "/vmfs/volumes/659eda0e-7a5a0587-c1a7-9c7bef2a7d69/ISOS/alpine-standard-3.19.1-aarch64.iso"
$DatastoreName = "DATASTORE_GRAN"
$VLAN = "LAN24"

# Crea la máquina virtual
$Datastore = Get-Datastore -Name $DatastoreName
New-VM -Name $VMName -Datastore $Datastore -MemoryGB 1 -CD -GuestId "other3xLinux64Guest" -NumCpu 1 -DiskStorageFormat Thin

# Montar archivo ISO
$VM = Get-VM -Name $VMName
Set-CDDrive -CD (Get-CDDrive -VM $VM) -IsoPath $DatastorePath -StartConnected:$true -Confirm:$false

# Desconecta del servidor ESXi
Disconnect-VIServer -Server 172.24.69.102 -Confirm:$false
