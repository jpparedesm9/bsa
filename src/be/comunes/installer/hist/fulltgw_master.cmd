echo off
rem ********************************************************
rem *    ARCHIVO:         fulltgw_master.cmd			
rem *    NOMBRE LOGICO:   fulltgw_master.cmd			
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
rem *   Maestro de Compilacion de trigers   
rem ********************************************************
rem *                     MODIFICACIONES			
rem *   FECHA        AUTOR           RAZON			
rem ********************************************************

if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda
if "%7"=="" goto ayuda
if "%8"=="" goto ayuda

if %8==T (
  if exist %6\*.error (
    del %6\*.error
  )

  for %%i in (%5\*.tg) do (
    echo hola > %6\%%~ni.error
  )
)

SET /a ii=0
for %%j in (1 2 3) do (
	for %%k in (%6\*.error) do (
                if !ii!==5 (
		  echo Ejecutando el dump   
                  SET /a ii=0
                  sqlcmd -U%1 -P%2 -S%3 -n -i dump -o dump.out
                )		    
                SET /a ii+=1
		echo Ejecutando %%~nk.tg
		del %6\%%~nk.error
		sqlcmd -U%1 -P%2 -S%3 -n -i %5\%%~nk.tg -o %6\%%~nk.error
		for /F %%l in (%6\%%~nk.error) do (
			echo ERROR ... > %6\%%~nk.error2
		)
		if not exist %6\%%~nk.error2 (
			del %6\%%~nk.error
		) else (
			echo ----- %%~nk.tg tiene errores
			del %6\%%~nk.error2
		)
	)
)

goto fin

:ayuda
echo fulltgw_master.cmd [parametro 1] [parametro 2] [parametro 3]
echo parametro 1: Login del usuario de la base de datos                        
echo parametro 2: Password del usuario
echo parametro 3: Servidor Sybase
echo [parametro 4]: nombre del servidor COBIS Central
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
echo [parametro 7]: POR REVISAR
echo [parametro 8]: T - todos los sps, E - solo los sps con error

:fin