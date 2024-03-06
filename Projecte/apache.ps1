# Conectarse al servidor vSphere
Connect-VIServer -Server 172.24.69.12 -User administrator@vsphere.local -Password Patata123*

# Define la dirección IP de la máquina virtual
$ip = "172.24.69.222"

# Comprueba si el servicio Apache está funcionando en la máquina virtual
function CheckApacheStatus {
    try {
        $response = Invoke-WebRequest -Uri "http://$ip" -TimeoutSec 5 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            return $true
        } else {
            return $false
        }
    } catch {
        return $false
    }
}

# Verifica si el servicio Apache está funcionando en la máquina virtual antes de continuar
if (CheckApacheStatus) {
    Write-Host "El servei Apache funca en la maquina virtual."
} else {
    Write-Host "El servei Apache no funca en la maquina virtual. Eliminant aquesta merda..."

    # Obtener la máquina virtual existente si existe
    $vm = Get-VM -Name AlpineMain -ErrorAction SilentlyContinue

    if ($vm -ne $null) {
        # Detener la máquina virtual si está encendida
        if ($vm.PowerState -eq "PoweredOn") {
            Stop-VM -VM $vm -Confirm:$false
        }

        # Eliminar la máquina virtual
        Remove-VM -VM $vm -Confirm:$false
    }

    # Define los detalles de la plantilla y del host para la nueva máquina virtual
    $templateName = "AlpineClonar"  
    $newVMName = "AlpineMain"
    $folderName = "Templates"

    # Obtener la plantilla
    $template = Get-Template -Name $templateName -Location (Get-Folder -Name $folderName)

    # Obtener el host donde se debe alojar la nueva máquina virtual
    $vmHost = Get-VMHost | Select-Object -First 1

    # Crear la nueva máquina virtual
    $newVM = New-VM -Name $newVMName -VMHost $vmHost -Location (Get-Folder -Name $folderName) -Template $template

    # Configurar la nueva máquina virtual
    $newVM | Set-VM -NumCpu 2 -MemoryGB 4 -Confirm:$false

    # Iniciar la nueva máquina virtual
    $newVM | Start-VM -Confirm:$false

    Write-Host "S'ha fet la magia"

    # Desconectar del servidor vSphere
    Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false

    exit 1  # Terminar la ejecución del script
}

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false
