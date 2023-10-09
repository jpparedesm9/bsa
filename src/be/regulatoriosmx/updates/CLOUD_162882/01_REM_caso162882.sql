------------------>>>>>>>>>>>
--Actualizacion de fechas
--Totales: 97140
--Fecha in_fecha_xml null: 95631
--Se avanzo a enviar: 2254

UPDATE cob_conta_super..sb_ns_estado_cuenta 
SET in_fecha_xml = nec_fecha
WHERE in_fecha_xml IS NOT NULL 

UPDATE cob_conta_super..sb_ns_estado_cuenta 
SET in_estado_correo = 'P'
WHERE in_estado_correo = 'T'
GO
