#---------------------------------------------------------------------------------------------------------
# Se muestran las máquinas que están ejecutándose
function mostrar_vm_activas {
    Get-VM | Select-Object -Property Name,State | Where-Object {$_.State -eq 'Running'} | Format-Table
}


#---------------------------------------------------------------------------------------------------------
# Petición de nombre de máquina virtual
function pedir_nombre_maquina_apagar {
    $script:nombre_maquina = Read-Host 'Introduzca el nombre completo de la maquina que quiere detener'
}


#---------------------------------------------------------------------------------------------------------
# Parada de la máquina virtual mediante confirmación
function detener_vm_activa {
    Stop-VM -Name $nombre_maquina -Confirm
}


#---------------------------------------------------------------------------------------------------------
# Función principal
function main_detener {
    mostrar_vm_activas

    pedir_nombre_maquina_apagar

    detener_vm_activa
}


#---------------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&') {
    main_detener
}