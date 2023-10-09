-- Se envían a crear por que en el sp ingresan truncando las tablas -- se aumenta la petición 2
use cob_conta_super
GO

IF OBJECT_ID ('sb_ods_saldos_cont_ttj') IS NOT NULL
	DROP table sb_ods_saldos_cont_ttj
go

create table sb_ods_saldos_cont_ttj
	(
	os_cod_cta_cont    varchar (24),
	os_cod_centro_cont varchar (20),
	os_cod_divisa      varchar (3),
	os_cod_entidad     varchar (20),
	os_tip_divisa      varchar (20),
	os_sdo_mo          varchar (20),
	os_sdo_ml          varchar (20),
	os_sdo_med_mo      varchar (20),
	os_sdo_med_ml      varchar (20),
	os_sdo_mes_mo      varchar (20),
	os_sdo_mes_ml      varchar (20),
	os_fec_data        varchar (10),
	os_cod_area_cont   varchar (20),
	os_des_area_cont   varchar (50)
	)
GO
-- FEC_DATA

IF OBJECT_ID ('sb_ods_plancuentas_ttj') IS NOT NULL
	drop table sb_ods_plancuentas_ttj
go

create table dbo.sb_ods_plancuentas_ttj
	(
	op_cod_cta_cont   varchar (25),
	op_cod_entidad    varchar (50),
	op_des_cta_cont   varchar (64),
	op_tip_cta_cont   varchar (2),
	op_tip_divisa     varchar (50),
	op_cls_sdo        varchar (50),
	op_cod_est_sdo    varchar (50),
	op_tip_acceso     varchar (50),
	op_cod_est_cuenta varchar (50),
	op_fec_alta       varchar (10),
	op_fec_baja       varchar (10),
	op_fec_data       varchar (10),
	op_cod_cargabal   varchar (64)
	)
go
print 'Fin create tablas'