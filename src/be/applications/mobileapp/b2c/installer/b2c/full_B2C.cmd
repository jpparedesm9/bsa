echo OFF
cls
echo **********************************************************
echo              INSTALACION DEL BACKEND B2C
echo **********************************************************
echo.
echo Por favor ingrese los datos de la base de Datos Local 
echo.
:lblDirFuentes
set /p directorioFuentes=Directorio de Fuentes:
if !%directorioFuentes%!==!! goto lblDirFuentes

:lblUsuario
set /p usuario=Usuario del Local: 
if !%usuario%!==!! goto lblUsuario

:lblClave
set /p password=Clave Local: 
if !%password%!==!! goto lblClave

:lblServidor
set /p servidor=Servidor Local: 
if !%servidor%!==!! goto lblServidor

:lblLog
set /p directorioLog=Directorio de Log:
if !%directorioLog%!==!! goto lblLog



:INSTALACION
IF NOT EXIST connection\test_connection.sql GOTO noexiste2
echo comprobando conexion...
echo .
sqlcmd -U%usuario% -P%password% -S%servidor% -iconnection\test_connection.sql > connection\test_connection.out
if %ERRORLEVEL% NEQ 0 (
	goto fin_conexion
)

echo creando directorios...
echo .
if not exist %directorioLog% (
  mkdir %directorioLog%
)
if exist %directorioLog%\full_B2C.log (
  del %directorioLog%\full_B2C.log
)
cd %directorioFuentes%

echo instalando desde \full_B2C.ini...
echo .
for /F "tokens=1,2,3" %%i in (.\full_B2C.ini) do (
  echo %DATE% - %TIME%
  echo SCRIPT: .\%%i\%%j
  if not exist %directorioLog%\%%i (
    mkdir %directorioLog%\%%i
  )
  
  echo -------------------------------------------------------- >> %directorioLog%\full_B2C.log
  if %%k==SI (
    echo SCRIPT: %directorioFuentes%\%%i\fuentes\%%j >> %directorioLog%\full_B2C.log
  ) else (	
    echo SCRIPT: .\%%i\%%j >> %directorioLog%\full_B2C.log
  )
  
  echo %DATE% - %TIME% >> %directorioLog%\full_B2C.log
  echo -------------------------------------------------------- >> %directorioLog%\full_B2C.log
  if %%k==SI (
   call %directorioFuentes%\%%i\fuentes\%%j %usuario% %password% %servidor% %servidor% %directorioFuentes%\%%i\fuentes %directorioLog%\%%i %%i\objetos >> %directorioLog%\full_B2C.log
  ) else (
   call .\%%i\%%j %usuario% %password% %servidor% %servidor% .\%%i %directorioLog%\%%i >> %directorioLog%\full_B2C.log
  )
)

echo ----------------------------------------
echo FIN DEL PROCESO:
echo %DATE% - %TIME%
echo ----------------------------------------
echo -------------------------------------------------------- >> %directorioLog%\full_B2C.log
echo FIN DE LA INSTALACION GENERAL DE COBIS B2C >> %directorioLog%\full_B2C.log
echo Revise los archivos del log de la instalacion >> %directorioLog%\full_B2C.log
echo %DATE% - %TIME% >> %directorioLog%\full_B2C.log
echo -------------------------------------------------------- >> %directorioLog%\full_B2C.log
goto fin

:noexiste2
echo *** Archivo connection\test_connection.sql no existe
GOTO fin

:fin_conexion
echo ********************************************************************
echo POR FAVOR VERIFIQUE LOS DATOS DE CONEXION AL SERVIDOR: %servidor%.
echo ********************************************************************
pause
exit

:fin
pause
