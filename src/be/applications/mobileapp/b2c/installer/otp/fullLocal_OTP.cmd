echo OFF
cls
echo **********************************************************
echo              INSTALACION DEL BACKEND LOCAL OTP
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
if exist %directorioLog%\fullLocal_OTP.log (
  del %directorioLog%\fullLocal_OTP.log
)
cd %directorioFuentes%

echo instalando desde \fullLocal_OTP.ini...
echo .
for /F "tokens=1,2,3" %%i in (.\fullLocal_OTP.ini) do (
  echo %DATE% - %TIME%
  echo SCRIPT: .\%%i\%%j
  if not exist %directorioLog%\%%i (
    mkdir %directorioLog%\%%i
  )
  
  echo -------------------------------------------------------- >> %directorioLog%\fullLocal_OTP.log
  if %%k==SI (
    echo SCRIPT: %directorioFuentes%\%%i\fuentes\%%j >> %directorioLog%\fullLocal_OTP.log
  ) else (	
    echo SCRIPT: .\%%i\%%j >> %directorioLog%\fullLocal_OTP.log
  )
  
  echo %DATE% - %TIME% >> %directorioLog%\fullLocal_OTP.log
  echo -------------------------------------------------------- >> %directorioLog%\fullLocal_OTP.log
  if %%k==SI (
   call %directorioFuentes%\%%i\fuentes\%%j %usuario% %password% %servidor% %servidor% %directorioFuentes%\%%i\fuentes %directorioLog%\%%i %%i\objetos >> %directorioLog%\fullLocal_OTP.log
  ) else (
   call .\%%i\%%j %usuario% %password% %servidor% %servidor% .\%%i %directorioLog%\%%i >> %directorioLog%\fullLocal_OTP.log
  )
)

echo ----------------------------------------
echo FIN DEL PROCESO:
echo %DATE% - %TIME%
echo ----------------------------------------
echo -------------------------------------------------------- >> %directorioLog%\fullLocal_OTP.log
echo FIN DE LA INSTALACION GENERAL DE COBIS EN EL LOCAL >> %directorioLog%\fullLocal_OTP.log
echo Revise los archivos del log de la instalacion >> %directorioLog%\fullLocal_OTP.log
echo %DATE% - %TIME% >> %directorioLog%\fullLocal_OTP.log
echo -------------------------------------------------------- >> %directorioLog%\fullLocal_OTP.log
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
