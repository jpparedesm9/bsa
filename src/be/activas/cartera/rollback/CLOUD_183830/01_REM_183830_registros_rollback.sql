------------->>>>>>>>>>>>> parametro
USE cobis
GO

SELECT * FROM cl_parametro WHERE pa_nemonico = 'CICCJA' AND pa_producto = 'CCA'--pa_char

DELETE cl_parametro WHERE pa_nemonico = 'CICCJA' AND pa_producto = 'CCA'

------------->>>>>>>>>>>>> errores
USE cobis
GO

SELECT * FROM cl_errores WHERE numero = 724687

DELETE cl_errores WHERE numero = 724687

------------->>>>>>>>>>>>> se añade columna
use cob_cartera
go

select top 1 * from ca_corresponsal_trn

if exists (select 1 from sys.columns where Name = N'co_secuencial_rv' and Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn')) begin
  alter table ca_corresponsal_trn DROP COLUMN co_id_secuencial_rv
end

select top 1 * from ca_corresponsal_trn
go
