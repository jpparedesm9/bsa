use cobis
go
--- NOMBRE REPORTE
print '---NOMBRE REPORTE'
DELETE  cobis..cl_parametro where pa_nemonico = 'ODS02B' AND pa_producto = 'CCA'
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('REPORTE BALANCE ACTIVOS ODS', 'ODS02B', 'C', 'COB_ODS_02', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

--- CREACION TABLA
print '---CREACION TABLA rpt_ca_balance_archivo'
use cob_cartera
go
IF OBJECT_ID ('dbo.rpt_ca_balance_archivo') IS NOT NULL
    DROP TABLE dbo.rpt_ca_balance_archivo
GO
CREATE TABLE dbo.rpt_ca_balance_archivo
    (
    ba_num_cuenta      int not null,
    ba_cod_cta_cont    varchar(24),
    ba_cod_divisa      varchar(3),
    ba_fec_data        varchar(10),
	ba_cod_pais	       int,
    ba_cod_centro_cont int,
    ba_cod_entidad     int,
    ba_imp_sdo_cont_mo money,
    ba_imp_sdo_cont_ml money
    )
GO

--- CREACION TABLA
print '---CREACION TABLA rpt_ca_balance_archivo_final'
use cob_cartera
go
-- rpt_ca_balance_archivo_final
if exists (select 1 from sysobjects where name = 'rpt_ca_balance_archivo_final' and type = 'U')
   drop table rpt_ca_balance_archivo_final
 go
CREATE TABLE rpt_ca_balance_archivo_final
(  
   rb_id int IDENTITY (1, 1) NOT NULL,
   rb_cadena varchar(max)
)
go
