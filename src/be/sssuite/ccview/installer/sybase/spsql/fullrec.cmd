clear
clear
echo '  ------------------------------------------------------------'
echo '                   RECOMPILACION DE STORED PROCEDURES         '
echo '                           COBIS WORKFLOW                     '
echo '  ------------------------------------------------------------'
echo '  Login           : \c' ; read login
echo '  Password 	: \c' ;
old=`stty -g`
stty -echo
read pwd
stty $old
echo ''
echo '  Servidor Sybase : \c' ; read syb

#Genero el archivo dump para limpiar el log
if test -f dump.tmp ; then
   rm dump.tmp
fi
echo dump tran cob_cartera with no_log   > dump.tmp
echo go               >> dump.tmp

echo Limpiando log de la base de datos 
isql -U$login -P$pwd -S$syb  < dump.tmp


for j in 1 2 3 
do
   clear
   cuantos=0
   limpia=0
   for i in *.sp
   do
	cuantos=`expr $cuantos + 1`
	archivo=`echo $i|cut -f1 -d.`
	if [   -s $archivo.error ]; then
	        echo "$cuantos) Ejecutando $i \c"
                echo
	        isql -U$login -P$pwd -S$syb < $i >$archivo.error
	        limpia=`expr $limpia + 1`
	fi

	if [   -s $archivo.error ]; then
		echo "	$i tiene errores "
                echo
	else
		rm $archivo.error 2> trash
        fi
#   Cada cuantos sp limpia el log, se pone 1 para bases pequenias
	if [ $limpia -eq 3 ]; then
               echo Limpiando log de la base de datos 
               isql -U$login -P$pwd -S$syb  < dump.tmp
	       limpia=0
	fi
   done
done
rm trash
clear
echo ' '
echo  Fin de la compilacion
echo 'NO OLVIDE REVISAR ARCHIVOS *.error...  - Presione  <Enter> para finalizar- \c'; read enter

