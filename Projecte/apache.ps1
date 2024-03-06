
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
    Write-Host "El servei Apache si funca en la maquina virtual."
} else {
    Write-Host "El servei Apache no funca en la maquina virtual.Eliminant aquesta merda..."
    # Obtener la máquina virtual y eliminarla
    $vm = Get-VM -Name AlpineMain
    Remove-VM -VM $vm -Confirm:$false
}

# Desconectarse del servidor vSphere
Disconnect-VIServer -Server 172.24.69.12 -Confirm:$false
