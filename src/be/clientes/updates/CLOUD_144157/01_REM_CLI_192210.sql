
/*Script 02 VERSION 1*/

/*Script para llenar la tabla, se debe enviar cada vez que */
/*se desee ingresar info para procesar, ademas de este archivo */
/*tambien se debe enviar 02_REM_XX_eje_sp_08_eject_sp*/
/*no enviar clientes duplicados en el listado*/
--  nombre       varchar(64)
--	p_s_nombre   varchar(20)
--  p_p_apellido varchar(16)
--	p_s_apellido varchar(16)

--Clienta: MARIA DE LOS ANGELES JUDITH GONZALEZ MORALES (CAMBIAR PRIMER Y SEGUNDO NOMBRE)
--ID:192210


use cob_externos
go
--                                   ente,nombre, p_s_nombre, p_p_apellido, p_s_apellido, fecha, procesado
------------
insert into cambio_nombre_tmp values(192210,'MARIA','DE LA LOS ANGELES JUDITH','GONZALEZ','MORALES',getdate(), '', 'S')

SELECT ente, '#repeticiones' = count(*) FROM cambio_nombre_tmp
WHERE procesado = ''
GROUP BY ente
HAVING count(*) > 1

SELECT 'eliminar de la lista los repetidos'

go