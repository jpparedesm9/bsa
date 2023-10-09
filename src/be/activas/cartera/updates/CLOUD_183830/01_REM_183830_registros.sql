------------->>>>>>>>>>>>> parametro
USE cobis
GO

SELECT * FROM cl_parametro WHERE pa_nemonico = 'CICCJA' AND pa_producto = 'CCA'--pa_char

DELETE cl_parametro WHERE pa_nemonico = 'CICCJA' AND pa_producto = 'CCA'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO ID CORRESPONSAL CAJEROS', 'CICCJA', 'C', '00000000', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

SELECT * FROM cl_parametro WHERE pa_nemonico = 'CICCJA' AND pa_producto = 'CCA'
GO

------------->>>>>>>>>>>>> errores
USE cobis
GO

SELECT * FROM cl_errores WHERE numero = 724687

DELETE cl_errores WHERE numero = 724687

INSERT INTO dbo.cl_errores (numero, severidad, mensaje) VALUES (724687, 0, 'No hay folio asociado')

SELECT * FROM cl_errores WHERE numero = 724687

------------->>>>>>>>>>>>> se añade columna
use cob_cartera
go

select top 1 * from ca_corresponsal_trn

if not exists (select 1 from sys.columns where Name = N'co_secuencial_rv' and Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn')) begin
  alter table ca_corresponsal_trn add co_secuencial_rv INT
end

select top 1 * from ca_corresponsal_trn
go
