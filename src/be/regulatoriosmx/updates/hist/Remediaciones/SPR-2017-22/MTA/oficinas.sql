/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 06/11/2017
--Descripción del Problema   : Script para corregir las oficinas de Mantenimiento de Grupos en Sustaining
--Descripción de la Solución : N/A
--Autor                      : MARIA JOSE TACO
--SQL                        : N/A
/**********************************************************************************************************************/

use cobis
go

SELECT * INTO grupo_tmp
FROM cobis..cl_grupo

UPDATE cobis..cl_grupo
   SET gr_sucursal = fu_oficina
  FROM cobis..cc_oficial, cobis..cl_funcionario 
 WHERE oc_funcionario= fu_funcionario
   AND gr_oficial =  oc_oficial

 go
 
 