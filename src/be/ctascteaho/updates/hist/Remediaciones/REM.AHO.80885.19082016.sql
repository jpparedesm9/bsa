/***********************************************************************************************************/

---Fecha					: 19/08/2016 
--Descripción               : script para la Historia 80885 
--Descripción de la Solución: se crea script de remediación
--Autor						: Karen Meza
/***********************************************************************************************************/

--PARAMETRO VALIDACION MAXIMA DE TM

delete cobis..cl_parametro where pa_nemonico = 'MAXVM' 
and pa_producto = 'AHO'
go
INSERT INTO cobis..cl_parametro (pa_parametro,                pa_nemonico, pa_tipo,  pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VALIDACION MAXIMO TRANSACCIONES MONETARIAS', 'MAXVM',        'M',     NULL,        NULL,       NULL,   NULL,      10000,     NULL,       NULL,      'AHO')
GO

INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (2, getdate(), 1, 1, 1, 18.1488203, 1)
GO