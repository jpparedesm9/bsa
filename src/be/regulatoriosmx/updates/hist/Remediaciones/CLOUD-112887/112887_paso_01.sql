USE cob_cartera
GO

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'lgu_112887_borrar')
	DROP TABLE lgu_112887_borrar
GO
CREATE TABLE lgu_112887_borrar(
bo_estado     VARCHAR(10),
bo_grupo      INT,
bo_secuencial INT,
bo_procesado  VARCHAR(10),
bo_fecha_valor DATETIME ,
bo_error       INT,
bo_mensaje     VARCHAR(64)
) 
go	



IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'lgu_112887_det_borrar')
	DROP TABLE lgu_112887_det_borrar
GO

create table lgu_112887_det_borrar (
bod_banco     VARCHAR(32), 
bod_operacion int, 
bod_sec_ing   INT, 
bod_fult_pro  DATETIME NULL,
bod_fvalor    DATETIME NULL,
bod_error     INT , 
bod_procesado VARCHAR(10) ,
bod_mensaje   VARCHAR(64) ,
bod_grupo     INT  
)
go


DECLARE @w_fecha DATETIME

/* FECHA DE PAGO H2H */
/*******************************************************************************/
SELECT @w_fecha = '02/05/2019'
/*******************************************************************************/

INSERT INTO lgu_112887_borrar
select 
'estado' = co_estado, 
'grupo'  = convert(int, substring( co_referencia , 3,12)), 
co_secuencial,
'N',
co_fecha_valor,
0,
''
from ca_corresponsal_trn
where co_fecha_proceso = @w_fecha
and co_fecha_valor = @w_fecha
and substring(co_referencia,1,2) in ('01','PG')
AND co_estado = 'P'
AND co_accion = 'I'


SELECT 'Total PAGOS' = count(1) FROM lgu_112887_borrar

SELECT * FROM lgu_112887_borrar
