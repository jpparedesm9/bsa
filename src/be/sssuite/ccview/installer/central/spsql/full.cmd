echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

isql -U%1 -P%2 -S%3 -i %5\dump

if exist %6\*.error (
  del %6\*.error
)

set contador=0
for %%i in (%5\*.sp) do (
  echo hola > %6\%%~ni.error
  set /a contador+=1
)

for %%j in (1 2 3) do (
	for %%k in (%6\*.error) do (
		isql -U%1 -P%2 -S%3 -n -i %5\dump
		echo Ejecutando %%~nk.sp
		del %6\%%~nk.error
		isql -U%1 -P%2 -S%3 -n -i %5\%%~nk.sp -o %6\%%~nk.error
		for /F %%l in (%6\%%~nk.error) do (
			echo ERROR ... > %6\%%~nk.error2
		)
		if not exist %6\%%~nk.error2 (
			del %6\%%~nk.error
		) else (
			echo ----- %%~nk.sp tiene errores
			del %6\%%~nk.error2
		)
	)
)

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6]
echo donde:
echo [parametro 1]: usuario de Sybase
echo [parametro 2]: password del usuario de Sybase
echo [parametro 3]: nombre del servidor Sybase
echo [parametro 4]: nombre del servidor COBIS Central
echo [parametro 5]: directorio de los fuentes
echo [parametro 6]: directorio del log de instalacion
:fin
