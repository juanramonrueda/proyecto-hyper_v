#------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables



#------------------------------------------------------------------------------------------------------------------------------------------------------
# Petición del nombre de máquina
function nombre_maquina {
    $script:nombre_maquina = Read-Host 'Introduzca el nombre para la maquina'
    Write-Host ''
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Cantidad de memoria RAM
function memoria_ram_vm {
    $memoria_ram = Read-Host 'Introduzca la cantidad de memoria RAM en bytes o en Gigabytes como por ejemplo 1073741824 (bytes) o 1GB'
    Write-Host ''
    
    if ($memoria_ram -match 'GB') {
        $script:memoria_ram_bytes = ($memoria_ram / 1GB) * 1GB
    }

    else {
        $script:memoria_ram_bytes = $memoria_ram
    }
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Generación de la máquina
function generacion_maquina {
    $script:generacion_maquina = Read-Host 'Introduzca la generacion, 1 o 2'
    Write-Host ''
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Tamaño de disco duro
function disco_vm {
    Write-Host 'Para un nuevo disco --> nuevo'
    Write-Host ''
    Write-Host 'Para usar el disco de otra maquina --> disco maquina'
    Write-Host ''
    Write-Host 'Para no introducir ningun disco --> ninguno'
    Write-Host ''
    $script:disco_duro = Read-Host 'Elija una de las opciones anteriores'

    if ($disco_duro -match 'nuevo') {
        $cantidad_disco = Read-Host 'Introduzca la cantidad de espacio para el disco en Bytes o en Gigabytes como por ejemplo 10737418240 (bytes) o 10GB'

        if ($cantidad_disco -match 'GB') {
            $script:cantidad_disco_bytes = ($cantidad_disco / 1GB) * 1GB
        }

        else {
            $script:cantidad_disco_bytes = $cantidad_disco
        }
    }

    elseif ($disco_duro -match 'disco maquina') {
        Get-ChildItem -Path $hd_path

        $script:disco_path = Read-Host 'Introduzca el nombre de la maquina virtual'

        $script:disco_otra_maquina = $hd_path + '\' + $disco_path + '\' + $disco_path.vhdx

        Write-Host $disco_otra_maquina
    }
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Creación del directorio con el nombre de la máquina para la configuración de la máquina
function crear_directorio_vm {
    if (Test-Path $vm_path\$nombre_maquina) {

    }

    else {
        New-Item -Path $vm_path\$nombre_maquina -ItemType Directory
    }
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Selección del tipo de arranque para la máquina virtual
function arranque_vm {
    Write-Host 'Arranque mediante CD --> CD'
    Write-Host ''
    Write-Host 'Arranque mediante red --> Red'
    Write-Host ''

    $pregunta_arranque = Read-Host 'Indique el tipo de arranque inicial para la máquina'

    if ($pregunta_arranque -match 'CD') {
        $script:tipo_arranque = 'CD'
    }

    elseif ($pregunta_arranque -match 'Red') {
        $script:tipo_arranque = 'NetworkAdapter'
    }

    else {
        Write-Host 'No existe esa opcion'

        Exit-PSHostProcess
    }
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Creación de la máquina virtual
function crear_maquina {
    if ()
        New-VM -Name $nombre_maquina -MemoryStartupBytes $memoria_ram_bytes -NewVHDPath $hd_path\$nombre_maquina\$nombre_maquina.vhdx `
        -NewVHDSizeBytes $cantidad_disco_bytes -Path $vm_path\$nombre_maquina -BootDevice $tipo_arranque -SwitchName $
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Función principal
function main_crear_vm {
    Invoke-Expression .\clear_display.ps1

    nombre_maquina

    memoria_ram_vm

    generacion_maquina

    disco_vm

    crear_directorio_vm

    arranque_vm
}


#------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&') {
    main_crear_vm
}
