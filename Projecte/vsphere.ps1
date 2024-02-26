#Entrar al Vsphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Clonar la máquina virtual
$sourceVM = Get-VM -Name "Alpine"
$destinationTemplate = "Alpune"
New-VM -VM $sourceVM -Name $destinationTemplate -ResourcePool (Get-ResourcePool) -Location (Get-Folder -Name "Templates")

# Convertir la máquina virtual clonada en una plantilla
$templateVM = Get-VM -Name $destinationTemplate
Set-VM -VM $templateVM -Template $true