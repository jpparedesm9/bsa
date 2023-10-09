@echo off
rem ********************************************************
rem *    ARCHIVO:         full.cmd			
rem *    NOMBRE LOGICO:   full.cmd			
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
rem *   Instalacion general de COBIS BackEnd Central   
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
if "%9"=="" goto ayuda

cls
echo ----------------------------------------
echo INSTALACION DE BACK END CENTRAL COBIS
echo ----------------------------------------

if not exist %6 (
    mkdir %6
)

if exist %6\full.log (
    del %6\full.log
)

for /F "tokens=1,2,3,4,5,6" %%h in (.\full.ini) do (
    echo !DATE! - !TIME!

    rem Creacion archivo para dump en las bases de datos respectivas
    if exist creardump.sql (
      del creardump.sql
    )
    echo delete bd_cobis_actual > creardump.sql
    echo go >> creardump.sql
    echo insert into bd_cobis_actual values ^(''^) >> creardump.sql
    echo go >> creardump.sql
    echo insert into bd_cobis_actual values ^('%%h'^) >> .reardump.sql
    echo go >> creardump.sql

    sqlcmd -U%2 -P%3 -S%4 -i creardump.sql -o creardump.out
    sqlcmd -U%2 -P%3 -S%4 -i dump.sql -o dump2
    sqlcmd -U%2 -P%3 -S%4 -i dump2.sql -o dump2.out
    del dump
    for /F "tokens=1,2" %%f in (dump2) do (
      if %%f == S (
        echo dump tran %%g with truncate_only >> dump
        echo go >> dump
      )
    )
    del dump2
    
    if %9 == T (
        echo TODO
         
        echo SCRIPT: %1\%%i\%%j
        if not exist %6\%%i (
            mkdir %6\%%i
        )
        rem Directorio para objetos de programas batch
        if %%k==SQR (
            if %%m==SG (
              if not exist %7\objetos (
                mkdir %7\objetos
              )
              if not exist %6\%%i\objetos (
                  mkdir %6\%%i\objetos
              )
            )
            if %%m==VB (
              if not exist %7\objetosVB (
                mkdir %7\objetosVB
              )
              if not exist %6\%%i\objetosVB (
                  mkdir %6\%%i\objetosVB
              )
            )
        ) else (
            if not exist %6\%%i (
                mkdir %6\%%i
            )
        )
        echo -------------------------------------------------------- >> %6\full.log
        echo SCRIPT: %1\%%i\%%j >> %6\full.log
        echo SCRIPT: %1\%%i\%%j >> %6\full%%h.log
        echo !DATE! - !TIME! >> %6\full.log
        echo -------------------------------------------------------- >> %6\full.log
        if %%k==SQR (
            if %%m==SG (
              call fullsqtw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i\objetos %7\objetos %%m %%h >> %6\full%%h.log
            )
            if %%m==VB (
              call fullsqtw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i\objetosVB %7\objetosVB %%m %%h >> %6\full%%h.log
            )
        ) else (
            if %%k==SQL (
                call %1\%%i\%%j %2 %3 %4 %5 %1\%%i %6\%%i %%h >> %6\full%%h.log
            ) else (
                if %%k==SP (
                    call fullspw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %%h %%l >> %6\full%%h.log
                ) else (
                    call fulltgw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %%h %%l >> %6\full%%h.log
                )
            )
        )
    )

    if %9 == %%h (
        echo ESPECIFICO

        echo SCRIPT: %1\%%i\%%j
        if not exist %6\%%i (
            mkdir %6\%%i
        )
        rem Directorio para objetos de programas batch
        if %%k==SQR (
            if %%m==SG (
              if not exist %7\objetos (
                mkdir %7\objetos
              )
            )
            if %%m==VB (
              if not exist %7\objetosVB (
                mkdir %7\objetosVB
              )
            )
        )
        echo -------------------------------------------------------- >> %6\full.log
        if %%k==SQR (
            echo SCRIPT: %1\%%i\fuentes\%%j >> %6\full.log
            echo SCRIPT: %1\%%i\fuentes\%%j >> %6\full%%h.log
        ) else (
            echo SCRIPT: %1\%%i\%%j >> %6\full.log
            echo SCRIPT: %1\%%i\%%j >> %6\full%%h.log
        )
        echo !DATE! - !TIME! >> %6\full.log
        echo -------------------------------------------------------- >> %6\full.log
        if %%k==SQR (
            if %%m==SG (
              call fullsqtw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %7\objetos %%m %%h >> %6\full%%h.log
            )
            if %%m==VB (
              call fullsqtw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %7\objetosVB %%m %%h >> %6\full%%h.log
            )
        ) else (
            if %%k==SQL (
                call %1\%%i\%%j %2 %3 %4 %5 %1\%%i %6\%%i %%h >> %6\full%%h.log
            ) else (
                if %%k==SP (
                    call fullspw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %%h %%l >> %6\full%%h.log
                ) else (
                    call fulltgw_master.cmd %2 %3 %4 %5 %1\%%i %6\%%i %%h %%l >> %6\full%%h.log
                )
            )
        )
    )
)


echo ----------------------------------------
echo FIN DEL PROCESO:
echo !DATE! - !TIME!
echo ----------------------------------------
echo -------------------------------------------------------- >> %6\full.log
echo FIN DE LA INSTALACION GENERAL DE COBIS >> %6\full.log
echo Revise los archivos del log de la instalacion >> %6\full.log
echo !DATE! - !TIME! >> %6\full.log
echo -------------------------------------------------------- >> %6\full.log

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6] [parametro 7]
echo donde:
echo [parametro 1]: directorio raiz con los fuentes de instalacion
echo [parametro 2]: usuario de Sybase
echo [parametro 3]: password del usuario de Sybase
echo [parametro 4]: nombre del servidor Sybase
echo [parametro 5]: nombre del servidor COBIS Central
echo [parametro 6]: directorio raiz con el log de instalacion
echo [parametro 7]: directorio raiz con los objetos batch compilados (archivos .SQT)
echo [parametro 8]: numero de applications server
echo [parametro 9]: Nemonico de Producto a Instalar (Use T para Instalar Todos)
:fin
