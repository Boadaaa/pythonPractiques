# Importa el módulo VMware PowerCLI
Import-Module VMware.PowerCLI

# Conecta al servidor ESXi
Connect-VIServer -Server 172.24.69.102 -User root -Password Patata123*

# Nombre de la máquina virtual que deseas crear
$VMName = "AlpineMaquina"
$DatastorePath = /vmfs/volumes/659eda0e-7a5a0587-c1a7-9c7bef2a7d69/ISOS/alpine-standard-3.19.1-aarch64.iso
$DatastoreName = "DATASTORE_GRAN"
$VLAN = "LAN_24"

# Crea la máquina virtual
New-VM -Name $VMName -Datastore $DatastoreName -DiskGB 10 -MemoryGB 1 -NetworkName $VLAN -CD -ISOPath $DatastorePath
GuestId "other3xLinux64Guest" -NumCpu 1 -NetworkName $VLAN -DiskStorageFormat Thin