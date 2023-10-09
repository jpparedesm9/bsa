USE cob_cartera
GO
/*
UPDATE ca_corresponsal_trn 
   SET co_estado    = 'I'
 where co_codigo_interno  IN ( 34840,42241, 45996, 50156, 60044, 61786, 83347, 124391, 126989, 134084, 143713,150281,152263,  182909 )
   AND co_estado = 'X'
   AND co_accion = 'I'
   AND co_tipo   = 'PG'

go

UPDATE cob_cartera..ca_corresponsal_trn
SET co_fecha_real  = convert(datetime, substring(co_archivo_ref,18, 2) + '/' + substring(co_archivo_ref,20, 2) +'/'+substring(co_archivo_ref,14, 4))
where co_codigo_interno IN ( 34840,42241, 45996, 50156, 60044, 61786, 83347, 124391, 126989, 134084, 143713,150281,152263,  182909 )
and co_fecha_real is null
and co_estado ='I'
AND co_accion = 'I'
AND co_tipo   = 'PG'  
and co_archivo_ref  is not null

go
*/

SELECT * FROM  mta_112580_total
 WHERE to_sec_corresponsal =72119 
   AND to_operacion_padre = 152263
 
UPDATE mta_112580_total
   SET to_procesado = 'X'
 WHERE to_sec_corresponsal <>72119 
   AND to_operacion_padre <> 152263


UPDATE mta_112580_total
   SET to_procesado = 'N'
 WHERE to_sec_corresponsal =72119 
   AND to_operacion_padre = 152263

select  * from mta_112580_total	  
/*   
SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 34840,42241, 45996, 50156, 60044, 61786, 83347, 124391, 126989, 134084, 143713,150281,152263,  182909 )
*/
go





