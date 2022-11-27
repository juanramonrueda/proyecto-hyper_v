#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variable
$script:contador = 1


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Lista los switchs que hay creados
function listado_switchs_creados {
    Get-VMSwitch
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Confirmación para saber si quiere crear un switch nuevo
function confirmar_creacion_switch {
    $confirmacion_creacion_switch = Read-Host '¿Quiere crear algún conmutador de red? (S/N)'

  if ($confirmacion_creacion_switch -notmatch "S") {
      exit
  }
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pregunta por el tipo de adaptador y se añade un contador de intentos para detener la ejecución 
function tipo_adaptador_red {
    Write-Host ""
    Write-Host "Adaptador de Red Interna --> RI"
    Write-Host ""
    Write-Host "Adaptador de Red Privada --> RP"
    Write-Host ""
    Write-Host "Adaptador de Red Externa --> RE"
    Write-Host ""
    $script:tipo_adaptador_red = Read-Host "Indique el tipo de adaptador mediante RI, RP o RE"

    while (($tipo_adaptador_red -notmatch "RI") -and ($tipo_adaptador_red -notmatch "RP") -and ($tipo_adaptador_red -notmatch "RE")) {
        Write-Host ""
        Write-Host "Adaptador de Red Interna --> RI"
        Write-Host ""
        Write-Host "Adaptador de Red Privada --> RP"
        Write-Host ""
        Write-Host "Adaptador de Red Externa --> RE"
        Write-Host ""
        $script:tipo_adaptador_red = Read-Host "Indique de nuevo el tipo de adaptador mediante RI, RP o RE"

        $contador = $contador + 1

        if ($contador -eq 5) {
            Write-Host "Se detendra la ejecucion del programa por no leer correctamente las instrucciones"
            exit
        }
    }
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Nombre del adaptador de red
function nombre_nuevo_adaptador {
    $script:nombre_adaptador = Read-Host "Escriba el nombre del nuevo adaptador"
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Mostrar en forma de tabla el listado de los adaptadores de red del equipo y se filtra únicamente por los adaptadores que no son creados para las máquinas de Hyper-V
function mostrar_adaptadores_red {
    Get-NetAdapter | Select-Object -Property Name,InterfaceDescription,Status,MacAddress,LinkSpeed | Where-Object {$_.InterfaceDescription -notmatch "Hyper-V Virtual Ethernet Adapter"} | Format-Table
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Pregunta por el adaptador de red externa a usar
function adaptador_externo {
    $script:nombre_adaptador_externo = Read-Host "Ponga el nombre completo del adaptador de red que quiere usar para la maquina virtual"    
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Creación del adaptador
function creacion_adaptador {
    if ($tipo_adaptador_red -match "RI") {
        New-VMSwitch -Name $nombre_adaptador -MinimumBandwidthMode Default -SwitchType Internal
    }

    elseif ($tipo_adaptador_red -match "RP") {
        New-VMSwitch -Name $nombre_adaptador -MinimumBandwidthMode Default -SwitchType Private
    }

    elseif ($tipo_adaptador_red -match "RE") {
        mostrar_adaptadores_red

        adaptador_externo

        New-VMSwitch -Name $nombre_adaptador -MinimumBandwidthMode Default -NetAdapterName $nombre_adaptador_externo
    }
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Definición de la función principal
function main_nuevo_switch {
    Invoke-Expression .\clear_display.ps1

    listado_switchs_creados

    confirmar_creacion_switch

    tipo_adaptador_red

    nombre_nuevo_adaptador

    creacion_adaptador
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&') {
    main_nuevo_switch
}
