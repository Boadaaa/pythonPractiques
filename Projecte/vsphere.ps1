# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Obtener la máquina virtual que deseas clonar
$sourceVM = Get-VM -Name "Alpine"

# Clonar la máquina virtual y convertirla en una plantilla
$destinationTemplate = "Alpune"
New-VM -VM $sourceVM -Name $destinationTemplate -Location (Get-Folder -Name "Templates")

# Obtener la nueva máquina virtual clonada
$templateVM = Get-VM -Name $destinationTemplate

# Convertir la máquina virtual clonada en una plantilla
Set-VM -VM $templateVM -ToTemplate -Confirm:$false

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false
