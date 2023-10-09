PRINT ''
PRINT ''
PRINT '------------------------------------------------'
PRINT 'CREANDO NUEVOS CAMPOS EN TABLAS DE DOMICILIACION'
PRINT '------------------------------------------------'
PRINT ''
PRINT ''
go

--/////////////////////////////////////////////////////////
-- CREACION DEL PARAMETRO TIEMPO ENTRE DESEMSOLSO Y PAGO
--/////////////////////////////////////////////////////////
	
USE cobis
GO
declare 
	@w_nemonico2         VARCHAR(6)

SELECT 
	@w_nemonico2         = 'TESEG'


DELETE FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico2

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO (MIN) ESPERA PARA COBRO SEGURO', @w_nemonico2, 'T', NULL, 60, NULL, NULL, NULL, NULL, NULL, 'CCA')

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico2 AND pa_producto = 'CCA'

---------------------------------------------------------------------------------
----------------------------ca_santander_orden_retiro------------------------------------
---------------------------------------------------------------------------------
USE cob_cartera
GO
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_consecutivo')
begin
	ALTER TABLE ca_santander_orden_retiro ADD sor_consecutivo            FLOAT NULL
end
go

if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_fecha_clave')
begin
	ALTER TABLE ca_santander_orden_retiro ADD sor_fecha_clave          varchar(32) NULL
end
go



if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_error')
begin
	ALTER TABLE ca_santander_orden_retiro ADD sor_error          varchar(10) NULL
end
go


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_orden_retiro'
          and   obj.id = col.id
          and   col.name = 'sor_procesado')
begin
	ALTER TABLE ca_santander_orden_retiro ADD sor_procesado          varchar(10) NULL
end
go


IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'ca_santander_orden_retiro'
          and   obj.id = idx.id
          and   idx.name = 'idx1')
BEGIN
	DROP INDEX ca_santander_orden_retiro.idx1
END

CREATE INDEX idx1 ON ca_santander_orden_retiro  (sor_fecha_clave)
GO


IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'ca_santander_orden_retiro'
          and   obj.id = idx.id
          and   idx.name = 'idx2')
BEGIN
	DROP INDEX ca_santander_orden_retiro.idx2
END

CREATE INDEX idx2 ON ca_santander_orden_retiro  (sor_fecha_real)
GO


update cobis..cl_parametro set 
	pa_char = 'N'
where pa_producto = 'CCA'
  and pa_nemonico = 'GADOPA'

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'GADOPA' AND pa_producto = 'CCA'

go   

--//////////////////////////////////////////////////////////////
USE cob_cartera

GO


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ca_santander_log_pagos'
          and   obj.id = col.id
          and   col.name = 'sl_secpk')
begin
	ALTER TABLE ca_santander_log_pagos ADD sl_secpk  INT IDENTITY 
end
go


IF EXISTS(select idx.name,*
          from sysobjects obj, sysindexes idx
          where obj.name  = 'ca_santander_log_pagos'
          and   obj.id = idx.id
          and   idx.name = 'PK_ca_santander_log_pagos')
BEGIN
	BEGIN TRY
		ALTER TABLE ca_santander_log_pagos DROP CONSTRAINT PK_ca_santander_log_pagos
	END try
	BEGIN CATCH
		PRINT 'no existe PK'
	END catch


	BEGIN TRY
		DROP INDEX ca_santander_log_pagos.PK_ca_santander_log_pagos
	END try
	BEGIN CATCH
		PRINT 'no existe IDX'
	END catch
	
END

CREATE UNIQUE INDEX PK_ca_santander_log_pagos ON ca_santander_log_pagos  (sl_secpk, sl_fecha_gen_orden)
GO

