# proyecto-aso-primer-trimestre

# Hyper-V

Es un software nativo de Microsoft que permite la creación de máquinas virtuales en los sistemas operativos Windows que permitan la virtualización.

## Virtualización

La virtualización es la **creación de máquinas con sistemas operativos virtuales** que imitan las características de la máquina anfitrión en la que se aloja, nos permite usar distintos sistemas operativos sin tener que instalarlo en la máquina física y quitar el sistema operativo que tuviese en su momento. También sirven para hacer pruebas, realizar configuración en el sistema operativo y comprobar los efectos de dicha configuración, etc.

### Tipos de hipervisores

Tenemos dos tipos de hipervisores, los tipo 1 y los tipo 2.

+ **Hipervisor tipo 1:** También son llamados **hipervisores bare metal**, son los que se ejecutan directamente en el hardware de la máquina que aloja a la máquina virtual y son más rápidos que los hipervisores de tipo 2.

+ **Hipervisor tipo 2:** También son llamados **alojados**, simulan el hardware mediante el software, como si fuesen un programa más.

## Requisitos para usar Hyper-V u otro programa de virtualización

Para poder usar Hyper-V tenemos que disponer de un procesador que tenga virtualización, en el caso de que sea un procesador de Intel deberá tener la característica **VT-x** y en el caso de AMD deberá tener AMD-V, en el caso de que no dispusiera, no se podría realizar virtualización con ningún programa destinado a ello.

En el caso de que el procesador disponga de alguna de las dos características anteriores, **deberemos activar en la BIOS o en UEFI la característica de virtualización**, dependiendo del tipo de BIOS y del fabricante puede variar el nombre y localización.

## Activación de Hyper-V

Una vez tengamos la virtualización activada, en el menú de Inicio de Windows buscaremos **Activar o desactivar las características de Windows** y abriremos el resultado marcado en la imagen.

![Activación de Hyper-V](img/1_activacion_hyper-v/screenshot_1.png)

Esperaremos a que se cargue toda la información y en cuanto tengamos las características, marcaremos para activar **Hyper-V**, **Plataforma de máquina virtual** y **Plataforma del hipervisor de Windows** y pulsaremos en el botón de Aceptar.

![Características de Windows](img/1_activacion_hyper-v/screenshot_2.png)

Se harán cambios en el equipo y esperaremos a que finalicen, una vez finalizados, nos pedirá reiniciar el equipo para que se apliquen los cambios.

![Reinicio Windows](img/1_activacion_hyper-v/screenshot_3.png)

## Uso del Administrador de Hyper-V

Tras que se complete el reinicio del equipo, buscaremos en el menú de Inicio **Administrador de Hyper-V** y abriremos la aplicación.

![Administrador de Hyper-V](img/2_administrador_hyper-v/screenshot_1.png)

### Creación de máquinas virtuales

Dentro del Administrador de Hyper-V, tenemos dos formas de crear máquinas virtuales, mediante **Creación rápida...** o mediante **Nuevo**, empezaremos con la opción **Creación rápida...**

![Creación VM](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_1.png)

Disponemos de varias "máquinas virtuales", estas máquinas tienen un lado bueno y otro malo, el bueno es que vienen con la mayoría de la instalación realizada y el malo es que hay que descargarlas (el lado malo depende de la conectividad principalmente). De momento hay estas 5, la máquina virtual **Windows 10 MSIX Packaging Environment** es una máquina personalizada para trabajar con con tareas de configuración limitadas. La máquina **Entorno de desarrollo de Windows 11** viene con programas como **Visual Studio 2022 Community Edition**, **NET Desktop**, **Azure** y **SDK**, también tiene **WSL 2 con una máquina Ubuntu** y el **modo desarrollador habilitado**.

![Maquinas de descarga](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_2.png)

Probaremos una de las máquinas, en concreto con **Ubuntu 18.04 LTS**, **la marcaremos** y pulsaremos el botón de **Crear máquina virtual** y vemos diferentes fases por las que pasa hasta que se crea la máquina virtual.

![Descarga Ubuntu 18.04 LTS](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_3.png)

![Extracción del disco de la imagen](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_4.png)

Una vez termina la descarga y extracción, nos sale una notificación indicando que la máquina se creó y que podemos editar la configuración o conectarnos con la máquina, continuaremos con la conexión.

![Creación correcta](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_5.png)

Se nos abrirá la ventana de la máquina virtual y vemos que hay diferentes opciones, podemos pulsar en el **botón verde** para iniciarla o directamente en **Iniciar**.

![Inicio de la máquina](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_6.png)

Tras realizar la configuración del idioma, la distribución de teclado, la zona horaria y la creación del usuario, vemos que realiza configuración posterior que apenas lleva tiempo y nos permite usar la máquina poco después de terminar de configurarla.

![Preparación del sistema](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_7.png)

Podemos elegir otras opciones de creación de máquinas virtuales que las que hay por defecto, volveremos de nuevo a la ventana principal de creación rápida y pulsaremos sobre **Origen de instalación local**, según la máquina que vayamos a instalar, Windows o Linux, marcaremos (si es Windows) o desmarcaremos (si es Linux) la opción **Esta máquina ejecutará Windows** y pulsaremos sobre el botón **Cambiar el origen de instalación** y poder instalar mediante un archivo de imagen (ISO) o desde un disco duro virtual (VHD o VHDX). Iré al directorio de mi disco duro externo en el que tengo los archivos **.ISO** para realizar la comprobación.

![Cambio de tipo de instalación](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_8.png)

Volveremos al menú principal del **Administrador de Hyper-V** y veremos la otra opción **Nuevo**, nos dará tres posibilidades, crear una **máquina virtual**, un **disco duro** o un **disquete**.

![Menú creación máquinas virtuales](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_9.png)

#### Creación de máquina virtual

Empezaremos con la opción **Máquina virtual**, mediante el asistente de creación de máquinas virtuales crearemos una máquina, primero pondremos el nombre para la máquina y también nos permite especificar la ruta de la máquina virtual.

![Nombre máquina virtual](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_10.png)

A continuación, nos permite seleccionar la generación, **la primera generación está basada en BIOS legacy y en los sistemas operativos de 32 y 64 bits**, luego tenemos **la segunda generación que está basada en UEFI, en máquinas de 64 bits y tiene características de virtualización** dentro de la propia máquina.

![Generaciones](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_11.png)

El siguiente paso es indicar la cantidad de memoria RAM que vamos a destinar a la máquina, también podemos marcar o desmarcar la opción **Usar memoria dinámica para esta máquina virtual** que permite a la máquina coger más memoria RAM si la necesitara durante el transcurso de su ejecución.

![Memoria RAM](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_12.png)

El siguiente apartado nos permite seleccionar el conmutador de red para nuestra máquina, hay dos opciones por defecto, **No conectado** y **Default Switch**, ambas opciones no disponen de conectividad fuera de la máquina anfitrión, por lo que para que una máquina disponga de conectividad tendríamos que crear un conmutador.

![Conmutadores de red](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_13.png)

Antes de terminar, tendremos varias opciones relacionadas con el disco duro de la máquina, podemos crear un disco duro y cambiar su ubicación, cambiarle el nombre y el tamaño o usar un disco virtual existente o no poner un disco duro en este momento.

![Discos duros](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_14.png)

Para finalizar, podremos escoger la opción de instalación del sistema operativo que queramos, mediante **CD/DVD-ROM**, **disquete de arranque**, **instalación mediante red** y **no establecer todavía la instalación**.

![Instalación](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_15.png)

#### Creación de disco duro

Tenemos la posibilidad de crear discos duros virtuales en caso de necesitarlos, como agregar un segundo disco duro a una máquina o añadir un disco a una máquina que no tiene disco en el que almacenar el sistema operativo.

![Discos duros](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_16.png)

Empezaremos seleccionando el tipo de disco duro, tenemos varias posibilidades, **VHD** para un **tamaño máximo de 2TB y cualquier tipo de sistema operativo**, **VHDX** para un **tamaño máximo de 64TB y sistemas operativos posteriores a Windows 8**, y por último, **Conjunto de VHD**, que permite **realizar copias de seguridad de grupos de máquinas** y es **para máquinas con Windows 10 y Windows 11**.

![Tipos de formato de disco duro](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_17.png)

Disponemos de tres opciones de tipo de disco duro, de tamaño fijo, expansión dinámica y diferenciación.

+ **Expansión dinámica**: Se asigna una cantidad de espacio en disco y va aumentando según se vaya llenando el disco duro.
+ **Diferenciación**: Permite usar un disco para revertir los cambios realizados en el otro disco, es necesario que ambos tengan el mismo tipo de formato.

![Tipo de disco](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_18.png)

Podemos asignar un nombre al disco duro y cambiar su ubicación en el sistema anfitrión.

![Nombre y ubicación](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_19.png)

Por último, podemos crear el disco duro con un tamaño, usar un dispositivo real o copiar un disco duro al nuevo, como si se hiciese una clonación del disco.

![Configuración del disco](img/2_administrador_hyper-v/1_creacion_maquinas_virtuales/screenshot_20.png)



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()



![]()