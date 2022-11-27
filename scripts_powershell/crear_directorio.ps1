#--------------------------------------------------------------------------------------------------------------
# Definición de variable para la ruta de creación del directorio
$global:vm_path = "C:\Maquinas Virtuales"
$global:hd_path = "C:\Discos duros MV"


#--------------------------------------------------------------------------------------------------------------
# Función que realiza el chequeo del directorio para máquinas virtuales y lo crea si no existe
function crear_directorio_MV {
    if (Test-Path $vm_path) {
        Write-Host 'El directorio' $vm_path 'esta creado'
    }
    
    else {
        New-Item -Path $vm_path -ItemType Directory
        Write-Host 'Se ha creado el directorio' $vm_path
    }
}


#--------------------------------------------------------------------------------------------------------------
# Función que realiza el chequeo del directorio para discos duros de máquinas virtuales y lo crea si no existe
function crear_directorio_HD {
    if (Test-Path $hd_path) {
        Write-Host 'El directorio' $hd_path 'esta creado'
    }

    else {
        New-Item -Path $hd_path -ItemType Directory
        Write-Host 'Se ha creado el directorio' $hd_path
    }
}


#--------------------------------------------------------------------------------------------------------------
# Función principal
function main_create_directories {
    crear_directorio_MV

    crear_directorio_HD
}


#--------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal "main"
if ($MyInvocation.InvocationName -ne '&') {
    main_create_directories
}
