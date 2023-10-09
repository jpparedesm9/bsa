

use cob_cartera
go


IF OBJECT_ID ('dbo.ca_garantia_liquida_98029') IS NOT NULL
	DROP TABLE dbo.ca_garantia_liquida_98029
GO

CREATE TABLE dbo.ca_garantia_liquida_98029
	(
	gl_id                INT NULL,
	gl_grupo             INT NULL,
	gl_cliente           INT NULL,
	gl_tramite           INT NULL,
	gl_monto_individual  MONEY NULL,
	gl_monto_garantia    MONEY NULL,
	gl_fecha_vencimiento DATETIME NULL,
	gl_pag_estado        CHAR (2) NULL,
	gl_pag_fecha         DATETIME NULL,
	gl_pag_valor         MONEY NULL,
	gl_dev_estado        CHAR (2) NULL,
	gl_dev_fecha         DATETIME NULL,
	gl_dev_valor         MONEY NULL
	)
GO

insert into ca_garantia_liquida_98029 
select * from ca_garantia_liquida where gl_grupo = 4

update ca_garantia_liquida set gl_monto_garantia = 600.00 , gl_pag_valor = 600.00 where gl_id  =1705 and gl_grupo = 4  and  gl_cliente = 28    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 700.00 , gl_pag_valor = 700.00 where gl_id  =1706 and gl_grupo = 4  and  gl_cliente = 31    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 0.00   , gl_pag_valor = 0.00   where gl_id  =1707 and gl_grupo = 4  and  gl_cliente = 32    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 400.00 , gl_pag_valor = 400.00 where gl_id  =1708 and gl_grupo = 4  and  gl_cliente = 33    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 300.00 , gl_pag_valor = 300.00 where gl_id  =1709 and gl_grupo = 4  and  gl_cliente = 34    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 450.00 , gl_pag_valor = 450.00 where gl_id  =1710 and gl_grupo = 4  and  gl_cliente = 36    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 450.00 , gl_pag_valor = 450.00 where gl_id  =1711 and gl_grupo = 4  and  gl_cliente = 42    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 450.00 , gl_pag_valor = 450.00 where gl_id  =1712 and gl_grupo = 4  and  gl_cliente = 43    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 0.00   , gl_pag_valor = 0.00   where gl_id  =1713 and gl_grupo = 4  and  gl_cliente = 47    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 0.00   , gl_pag_valor = 0.00   where gl_id  =1714 and gl_grupo = 4  and  gl_cliente = 51    and  gl_tramite =1509 go
update ca_garantia_liquida set gl_monto_garantia = 400.00 , gl_pag_valor = 400.00 where gl_id  =1715 and gl_grupo = 4  and  gl_cliente = 5910  and  gl_tramite =1509 go
go
