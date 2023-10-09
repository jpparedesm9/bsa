echo off
rem ********************************************************
rem *    ARCHIVO:         InstallCOBIS.cmd			
rem *    NOMBRE LOGICO:   InstallCOBIS.cmd			
rem *    PRODUCTO:        COBIS		
rem ********************************************************
rem *                     IMPORTANTE			
rem *   Esta aplicacion es parte de los  paquetes bancarios
rem *   propiedad de MACOSA S.A.				
rem *   Su uso no autorizado queda  expresamente  prohibido
rem *   asi como cualquier alteracion o agregado hecho  por
rem *   alguno de sus usuarios sin el debido consentimiento
rem *   por escrito de MACOSA. 				
rem *   Este programa esta protegido por la ley de derechos
rem *   de autor y por las convenciones  internacionales de
rem *   propiedad intelectual.  Su uso  no  autorizado dara
rem *   derecho a MACOSA para obtener ordenes  de secuestro
rem *   o  retencion  y  para  perseguir  penalmente a  los
rem *   autores de cualquier infraccion.			
rem ********************************************************
rem *                     PROPOSITO			
rem *   Instalacion general de COBIS - Solicitud de Parametros   
rem ********************************************************
rem *                     MODIFICACIONES			
rem *   FECHA        AUTOR           RAZON			
rem ********************************************************

rem PARAMETROS SOLICITADOS:
rem    1) LOGIN BASE DATOS
rem    2) PASSWORD BASE DATOS
rem    3) SERVIDOR BASE DE DATOS
rem    4) SERVIDOR COBIS
rem    5) DIRECTORIO DE FUENTES
rem    6) DIRECTORIO DE OBJETOS
rem    7) DIRECTORIO DE LOG
rem    8) NUMERO DE APPLICATION SERVER

SET /a cont=1
CLS

echo.
echo       *********    **********    **********    ****    **********
echo       *********    **********    **********    ****    **********
echo       ****         ***    ***    ***    ***    ****    ***    
echo       ****         ***    ***    **********    ****    **********
echo       ****         ***    ***    **********    ****    **********
echo       ****         ***    ***    ***    ***    ****           ***
echo       *********    **********    **********    ****    **********
echo       *********    **********    **********    ****    **********
echo.
echo.
echo                                             *** *** *** ****
echo                                             *   * * * * *  *
echo                                             *   * * *** ****
echo                                             *   * * * * *    
echo                                             *** *** * * *    *
:INICIA
SET /a cont=cont+1
if not %cont%==500 goto INICIA

CLS
echo _____________________________________________________________
echo                     COBIS CORP ECUADOR
echo           Bienvenido al Menu de Instalacion de COBIS
echo                     BANCO FIE BOLIVIA
echo _____________________________________________________________
echo.
echo Favor Ingrese los parametros solicitados a continuacion...
echo.
SET /P UsuarioBD=      Usuario Base de Datos:  
SET /P ClaveBD=      Clave para Usuario %UsuarioBD%:  
SET /P ServidorBD=      Servidor Base de Datos:  
SET /P ServidorCOBIS=      Servidor COBIS:  
SET /P DirFuentes=      Directorio Fuentes Instalacion:  
SET /P DirObjetos=      Directorio con los Objetos Batch Compilados:  
SET /P DirLog=      Directorio Log Instalacion:  
SET /P NumApps=      Numero de Application Servers:  
echo.
echo.

if exist %DirFuentes% goto VALIDAPATH1
echo Directorio %DirFuentes% no existe, favor verifique e intentelo de nuevo.
goto FIN

:VALIDAPATH1
if exist %DirObjetos% goto VALIDAPATH2
echo Directorio %DirObjetos% no existe, favor verifique e intentelo de nuevo.
goto FIN

:VALIDAPATH2
if exist %DirLog% goto INICIO
echo Directorio %DirLog% no existe, favor verifique e intentelo de nuevo.
goto FIN


:INICIO

cls
echo.
echo Iniciando Proceso de Instalacion de COBIS...
echo.

rem 2015-05-21  SET /P CrearBD=      Desea Crear Bases de Datos (S/N)? 
rem 2015-05-21  if not %CrearBD%==S goto INSTALA

rem 2015-05-21  CALL .\bd_crear.cmd %UsuarioBD% %ClaveBD% %ServidorBD% %DirLog%

:INSTALA
SET /P InstalaTODO=      Desea Instalar Todos los Productos Disponibles (S/N)?  
echo.

if not %InstalaTODO%==S goto InstalaEspecifico
echo Instalado Todos los Productos COBIS disponibles
echo.
set NemonicoPRD=T
goto Instalar

:InstalaEspecifico
echo Instalando un producto Especifico
echo.
SET /P NemonicoPRD=      Ingrese el Nemonico del Producto a Instalar:  
echo.
goto Instalar

:Instalar
CALL .\full.cmd %DirFuentes% %UsuarioBD% %ClaveBD% %ServidorBD% %ServidorCOBIS% %DirLog% %DirObjetos% %NumApps% %NemonicoPRD%
goto RevisarLOG

:RevisarLOG
echo Favor revise los archivos de salida generados en el directorio %DirLog%
echo.

:FIN
rem echo Usuario=%UsuarioBD%  Clave=%ClaveBD%  Servidor=%ServidorBD%   ServidorCOBIS=%ServidorCOBIS%   DirectorioLOGS=%DirLog%
echo Proceso Finalizado


