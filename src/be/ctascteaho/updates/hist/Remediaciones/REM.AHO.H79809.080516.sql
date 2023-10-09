/*************************************************/
---No Bug: AHO-H79809
---Título de la Historia: Mantenimiento de UDIS
---Fecha: 03/08/2016
--Descripción del la Historia:  Agregar la logica de Cotizacion para soporte de 
--                              la conversion de la Unidad de Conversion UDI
--Descripción de la Solución: Se crea el parametro UDI
--Autor: Walther Toledo
/*************************************************/

UPDATE cob_conta..cb_cotizacion
SET ct_valor=1, ct_factor1=5.429634
WHERE ct_moneda = (SELECT mo_moneda FROM cobis..cl_moneda 
 				    WHERE mo_nemonico = (SELECT pa_char 
 				                           FROM cobis..cl_parametro 
                                          WHERE pa_nemonico='IUDI'))
  AND ct_fecha = (SELECT max(ct_fecha) 
                    FROM cob_conta..cb_cotizacion
                   WHERE ct_moneda = 5)