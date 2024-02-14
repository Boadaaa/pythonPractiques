# Importa el módulo VMware PowerCLI
Import-Module VMware.PowerCLI

# Conecta al servidor ESXi
Connect-VIServer -Server 172.24.69.102 -User root -Password Patata123*

# Nombre de la máquina virtual que deseas crear
$VMName = "MiVM"

# Nombre del datastore donde deseas almacenar la máquina virtual
$DatastoreName = "LOCAL"

# Ruta completa al datastore
$DatastorePath = "/vmfs/volumes/$DatastoreName/"

# Crea una nueva máquina virtual
New-VM -Name $VMName -Datastore $DatastoreName -VMFilePath $DatastorePath -MemoryGB 2 -DiskGB 20

