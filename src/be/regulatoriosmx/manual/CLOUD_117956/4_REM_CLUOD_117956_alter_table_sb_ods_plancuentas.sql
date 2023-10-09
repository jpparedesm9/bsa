use cob_conta_super
go
 
IF NOT EXISTS (SELECT 1  FROM   INFORMATION_SCHEMA.COLUMNS WHERE  TABLE_NAME = 'sb_ods_plancuentas' AND COLUMN_NAME = 'op_cod_cargabal')
BEGIN
	alter table sb_ods_plancuentas add op_cod_cargabal varchar(20) 
END
GO