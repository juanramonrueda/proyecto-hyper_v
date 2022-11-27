#---------------------------------------------------------------------------------------------------------
# Se muestran las máquinas que están ejecutándose
function mostrar_vm_apagadas {
    Get-VM | Select-Object -Property Name,State | Where-Object {$_.State -eq 'Off'} | Format-Table
}


#---------------------------------------------------------------------------------------------------------
# Petición de detención de máquina virtual
function confirmar_inicio_maquina {
  $confirmacion_inicio = Read-Host '¿Quiere iniciar alguna de las maquinas que estan detenidas? (S/N)'

  if ($confirmacion_inicio -notmatch "S") {
      exit
  }
}


#---------------------------------------------------------------------------------------------------------
# Petición de nombre de máquina virtual
function pedir_nombre_maquina_encender {
    $script:nombre_maquina = Read-Host 'Introduzca el nombre completo de la maquina que quiere iniciar'
}


#---------------------------------------------------------------------------------------------------------
# Creación de función para conectar con la máquina virtual
function Connect-VM
{
  [CmdletBinding(DefaultParameterSetName='name')]

  param(
    [Parameter(ParameterSetName='name')]
    [Alias('cn')]
    [System.String[]]$ComputerName=$env:COMPUTERNAME,

    [Parameter(Position=0,
        Mandatory,ValueFromPipelineByPropertyName,
        ValueFromPipeline,ParameterSetName='name')]
    [Alias('VMName')]
    [System.String]$Name,

    [Parameter(Position=0,
        Mandatory,ValueFromPipelineByPropertyName,
        ValueFromPipeline,ParameterSetName='id')]
    [Alias('VMId','Guid')]
    [System.Guid]$Id,

    [Parameter(Position=0,Mandatory,
        ValueFromPipeline,ParameterSetName='inputObject')]
    [Microsoft.HyperV.PowerShell.VirtualMachine]$InputObject,

    [switch]$StartVM
  )

  begin
  {
    Write-Verbose "Initializing InstanceCount, InstanceCount = 0"
    $InstanceCount=0
  }

  process
  {
    try
    {
      foreach($computer in $ComputerName)
      {
        Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"

        if($PSCmdlet.ParameterSetName -eq 'name')
        {
              # Get the VM by Id if Name can convert to a guid
              if($Name -as [guid])
              {
			Write-Verbose "Incoming value can cast to guid"
			$vm = Get-VM -Id $Name -ErrorAction SilentlyContinue
              }
              else
              {
			$vm = Get-VM -Name $Name -ErrorAction SilentlyContinue
              }
        }
        elseif($PSCmdlet.ParameterSetName -eq 'id')
        {
              $vm = Get-VM -Id $Id -ErrorAction SilentlyContinue
        }
        else
        {
          $vm = $InputObject
        }

        if($vm)
        {
          Write-Verbose "Executing 'vmconnect.exe $computer $($vm.Name) -G $($vm.Id) -C $InstanceCount'"
          vmconnect.exe $computer $vm.Name -G $vm.Id -C $InstanceCount
        }
        else
        {
          Write-Verbose "Cannot find vm: '$Name'"
        }

        if($StartVM -and $vm)
        {
          if($vm.State -eq 'off')
          {
            Write-Verbose "StartVM was specified and VM state is 'off'. Starting VM '$($vm.Name)'"
            Start-VM -VM $vm
          }
          else
          {
            Write-Verbose "Starting VM '$($vm.Name)'. Skipping, VM is not in 'off' state."
          }
        }

        $InstanceCount+=1
        Write-Verbose "InstanceCount = $InstanceCount"
      }
    }
    catch
    {
      Write-Error $_
    }
  }

}


#---------------------------------------------------------------------------------------------------------
# Iniciar la máquina virtual y conectar a ella
function iniciar_vm_apagada {
    Connect-VM -VMName $nombre_maquina -StartVM
}

#---------------------------------------------------------------------------------------------------------
# Función principal
function main_encender {
    Invoke-Expression .\clear_display.ps1

    mostrar_vm_apagadas

    confirmar_inicio_maquina

    pedir_nombre_maquina_encender

    iniciar_vm_apagada
}


#---------------------------------------------------------------------------------------------------------
# Ejecución de la función principal
if ($MyInvocation.InvocationName -ne '&') {
    main_encender
}