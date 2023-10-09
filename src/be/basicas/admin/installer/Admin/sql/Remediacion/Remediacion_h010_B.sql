

use cobis
go


-----------------------------------------------------------------------------------------------------------------------------------------------
/* cl_det_oficina */
print '=====> cl_det_oficina'
go

if exists (select 1 from sysobjects where name='cl_det_oficina')
drop table cl_det_oficina 
go

CREATE TABLE cl_det_oficina(
		do_regional				varchar(100) NULL,
		do_cod_fie_asfi			varchar(10) NULL,
		do_cod_oficina			smallint NULL,
		do_dpto_pais			varchar(64) NULL,
		do_provincia			varchar(64) NULL,
		do_municipio    		varchar(64) NULL,
		do_ciudad				varchar(64) NULL,
		do_localidad			varchar(64) NULL,
		do_direccion			varchar(255) NULL,
		do_dependencia			varchar(64) NULL,
		do_tipo_oficina			varchar(10) NULL,
		do_clasificacion		varchar(64) NULL,
		do_nombre_of			varchar(64) NULL,
		do_jefe_agencia			varchar(64) NULL,
		do_ci_enc_pto_reclamo	varchar(15) NULL,
		do_enc_pto_reclamo		varchar(64) NULL,
		do_tel_1				varchar(12) NULL,
		do_tel_2				varchar(12) NULL,
		do_tel_3				varchar(12) NULL,
		do_celular				varchar(12) NULL,
		do_cordenadas_lat		varchar(20) NULL,
		do_cordenadas_lon		varchar(20) NULL,
		do_tipo_horario			varchar(64) NULL,
		do_obs_horario			varchar(120) NULL,
		do_horario_lunes		varchar(63) NULL,
		do_horario_sabado		varchar(63) NULL,
		do_horario_domingo		varchar(63) NULL,
		do_servicios			varchar(200) NULL,
		do_circular_com_asfi	varchar(20) NULL,
		do_fecha_asfi			datetime NULL,
		do_sec					integer  identity
)
go


