# Importa el módulo VMware PowerCLI
Import-Module VMware.PowerCLI

# Conecta al servidor ESXi
Connect-VIServer -Server 172.24.69.102 -User root -Password Patata123*

# Nombre de la máquina virtual que deseas crear
$VMName = "AlpineMaquina"
$path = /vmfs/volumes/659eda0e-7a5a0587-c1a7-9c7bef2a7d69/ISOS/alpine-standard-3.19.1-aarch64.iso
