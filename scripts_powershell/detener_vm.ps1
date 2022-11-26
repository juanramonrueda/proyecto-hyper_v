#--------------------------------------------------------------------------------------------------------------
# Se muestran las máquinas que están ejecutándose
function mostrar_vm_activas {
    Get-VM | Select-Object -Property Name,State | Where-Object {$_.State -eq 'Running'} | Format-Table
}


#--------------------------------------------------------------------------------------------------------------
# Petición de detención de máquina virtual
function confirmar_detencion_maquina {
    $confirmacion_detencion = Read-Host '¿Quiere detener alguna de las maquinas que estan ejecutandose? (S/N)'

    if ($confirmacion_detencion -notmatch "S") {
        exit
    }
}


#--------------------------------------------------------------------------------------------------------------
# Petición de nombre de máquina virtual
function pedir_nombre_maquina_apagar {
    $script:nombre_maquina = Read-Host 'Introduzca el nombre completo de la maquina que quiere detener'
}


#--------------------------------------------------------------------------------------------------------------
# Parada de la máquina virtual mediante confirmación
function detener_vm_activa {
    Stop-VM -Name $nombre_maquina -Confirm
}


#--------------------------------------------------------------------------------------------------------------
# Función principal
function main_detener {
    Invoke-Expression .\clear_display.ps1

    mostrar_vm_activas

    confirmar_detencion_maquina

    pedir_nombre_maquina_apagar

    detener_vm_activa
}


#--------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&') {
    main_detener
}
