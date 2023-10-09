echo OFF

cls
echo **********************************************************
echo              INSTALACION DEL BACKEND CENTRAL OTP
echo **********************************************************
echo.
echo Por favor ingrese los datos de la base de Datos Central 
echo.
:lblDirFuentes
set /p directorioFuentes=Directorio de Fuentes:
if !%directorioFuentes%!==!! goto lblDirFuentes

:lblUsuario
set /p usuario=Usuario del Central: 
if !%usuario%!==!! goto lblUsuario

:lblClave
set /p password=Clave Central: 
if !%password%!==!! goto lblClave

:lblServidor
set /p servidor=Servidor Central: 
if !%servidor%!==!! goto lblServidor

:lblLog
set /p directorioLog=Directorio de Log:
if !%directorioLog%!==!! goto lblLog

IF NOT EXIST connection\test_connection.sql GOTO noexiste2
echo comprobando conexion...
echo .
isql -U%usuario% -P%password% -S%servidor% -iconnection\test_connection.sql > connection\test_connection.out
if %ERRORLEVEL% NEQ 0 (
	goto fin_conexion
)

echo creando directorios...
echo .
if not exist %directorioLog% (
  mkdir %directorioLog%
)
if exist %directorioLog%\fullCentral_OTP.log (
  del %directorioLog%\fullCentral_OTP.log
)
cd %directorioFuentes%

echo instalando desde \fullCentral_OTP.ini...
echo .
for /F "tokens=1,2,3" %%i in (.\fullCentral_OTP.ini) do (
  echo %DATE% - %TIME%
  echo SCRIPT: .\%%i\%%j
  if not exist %directorioLog%\%%i (
    mkdir %directorioLog%\%%i
  )
  
  echo -------------------------------------------------------- >> %directorioLog%\fullCentral_OTP.log
  if %%k==SI (
    echo SCRIPT: %directorioFuentes%\%%i\fuentes\%%j >> %directorioLog%\fullCentral_OTP.log
  ) else (	
    echo SCRIPT: .\%%i\%%j >> %directorioLog%\fullCentral_OTP.log
  )
  
  echo %DATE% - %TIME% >> %directorioLog%\fullCentral_OTP.log
  echo -------------------------------------------------------- >> %directorioLog%\fullCentral_OTP.log
  if %%k==SI (
   call %directorioFuentes%\%%i\fuentes\%%j %usuario% %password% %servidor% %servidor% %directorioFuentes%\%%i\fuentes %directorioLog%\%%i %%i\objetos >> %directorioLog%\fullCentral_OTP.log
  ) else (
   call .\%%i\%%j %usuario% %password% %servidor% %servidor% .\%%i %directorioLog%\%%i >> %directorioLog%\fullCentral_OTP.log
  )
)

echo ----------------------------------------
echo FIN DEL PROCESO:
echo %DATE% - %TIME%
echo ----------------------------------------
echo -------------------------------------------------------- >> %directorioLog%\fullCentral_OTP.log
echo FIN DE LA INSTALACION GENERAL DE COBIS OTP EN EL CENTRAL >> %directorioLog%\fullCentral_OTP.log
echo Revise los archivos del log de la instalacion >> %directorioLog%\fullCentral_OTP.log
echo %DATE% - %TIME% >> %directorioLog%\fullCentral_OTP.log
echo -------------------------------------------------------- >> %directorioLog%\fullCentral_OTP.log
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
