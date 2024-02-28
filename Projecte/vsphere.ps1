# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Define los detalles de la plantilla y del host
$templateName = 'AlpineClonar'  
$esxName = '172.24.69.12'  
$dsName = 'LOCAL'  

# Obtiene la plantilla, el datastore y el host
$template = Get-Template -Name $templateName
$ds = Get-Datastore -Name $dsName


# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false





