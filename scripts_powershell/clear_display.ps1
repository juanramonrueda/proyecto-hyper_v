#-------------------------------------------------
# Borrado de pantalla
function clear_display {
    Clear-Host
}


#-------------------------------------------------
# Ejecución de la función de limpieza de pantalla
if ($MyInvocation.InvocationName -ne '&') {
    clear_display
}
