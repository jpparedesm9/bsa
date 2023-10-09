use cob_cartera
go

IF OBJECT_ID ('dbo.ca_param_seguro_externo') IS NOT NULL
	DROP table dbo.ca_param_seguro_externo
go

use cob_cartera
go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'se_tramite' AND TABLE_NAME = 'ca_seguro_externo')
BEGIN

ALTER TABLE cob_cartera..ca_seguro_externo
DROP COLUMN se_tramite

END

use cob_cartera
go
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'se_grupo' AND TABLE_NAME = 'ca_seguro_externo')
BEGIN

ALTER TABLE cob_cartera..ca_seguro_externo
DROP COLUMN se_grupo

END

use cobis
go
declare 
@w_id_tabla int

select @w_id_tabla=codigo from cobis..cl_tabla
where tabla='cl_institution_barcodes'
select @w_id_tabla
delete from cobis..cl_catalogo
where tabla= @w_id_tabla
and codigo in ('2','3','4')
go