#-------------------------------------------------------------------------------------------------
# Se muestran los switchs de Hyper-V
function mostrar_switch {
    Get-VMSwitch | Format-Table
}


#-------------------------------------------------------------------------------------------------
# Se pide si quiere borrar un switch
function nombre_switch_borrar {
    Write-Host "Recuerde que no puede borrar el conmutador Default Switch"
    Write-Host ""
    $script:nombre_switch = Read-Host 'Ponga el nombre completo del conmutador que quiere borrar'
}


#-------------------------------------------------------------------------------------------------
# Borrado del switch
function borrado_switch {
    Remove-VMSwitch -Name $nombre_switch -Confirm
}


#-------------------------------------------------------------------------------------------------
# Función principal
function main_borrado_switch {
    mostrar_switch

    nombre_switch_borrar

    borrado_switch
}


#-------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&'){
    main_borrado_switch
}
