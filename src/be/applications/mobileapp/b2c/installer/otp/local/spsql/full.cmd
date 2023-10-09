echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda
echo Parametro 1: %1
echo Parametro 2: %2
echo Parametro 3: %3
echo Parametro 4: %4
echo Parametro 5: %5
echo Parametro 6: %6

if exist %6\*.error (
  del %6\*.error
)

set contador=0
for %%i in (%5\*.sp) do (
  echo PENDIENTE > %6\%%~ni.error
  set /a contador+=1
)

for %%j in (1 2 3) do (
	for %%k in (%6\*.error) do (
		echo Ejecutando ......... %%~nk.sp
		del %6\%%~nk.error
		osql -U%1 -P%2 -S%3 -n -i%5\%%~nk.sp -o%6\%%~nk.error
		for /F %%l in (%6\%%~nk.error) do (
			echo ERROR ... >%6\%%~nk.error2
		)
		if not exist %6\%%~nk.error2 (
			del %6\%%~nk.error
		) else (
			echo ----- %%~nk.sp tiene errores
			del %6\%%~nk.error2
		)
	)
)

echo FINAL DEL PROCESO

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de SQLServer
echo [parametro 2]: password del usuario de SQLServer
echo [parametro 3]: nombre del servidor SQLServer
echo [parametro 4]: nombre del servidor COBIS Local
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
:fin
