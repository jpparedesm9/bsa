use cob_conta_super
go
-- -------------------------------------------------------------------------------------------------
-- --------------------------------------FRECUENCIA DE PAGOS----------------------------------------
-- -------------------------------------------------------------------------------------------------
delete from sb_equivalencias where eq_catalogo = 'FREC_PAGOS'
go
insert into sb_equivalencias values('FREC_PAGOS','B','B','Bimestral','V')
insert into sb_equivalencias values('FREC_PAGOS','D','D','Diario','V')
insert into sb_equivalencias values('FREC_PAGOS','S','H','Semestral','V')
insert into sb_equivalencias values('FREC_PAGOS','M','M','Mensual','V')
insert into sb_equivalencias values('FREC_PAGOS','T','Q','Trimestral','V')
insert into sb_equivalencias values('FREC_PAGOS','Q','S','Quincenal','V')
insert into sb_equivalencias values('FREC_PAGOS','W','W','Semanal','V')
insert into sb_equivalencias values('FREC_PAGOS','A','Y','Anual','V')
go

-- -------------------------------------------------------------------------------------------------
-- ------------------------------------------CREATE TABLES------------------------------------------
-- -------------------------------------------------------------------------------------------------

if object_id ('sb_reporte_buro_cuentas') is not null
    drop table sb_reporte_buro_cuentas
go
CREATE TABLE sb_reporte_buro_cuentas
(	
	rb_fecha_report datetime NOT NULL,
	rb_operacion	int NOT NULL,
	rb_ente			int NOT NULL,
    [04] varchar(255)  NOT NULL,
    [05] varchar(255)  NULL,
    [06] varchar(255)  NULL,
    [07] varchar(255)  NULL,
    [08] varchar(255)  NULL,
    [09] bigint		   NULL,
    [10] varchar(255)  NULL,
    [11] varchar(255)  NULL,
    [12] varchar(255)  NULL,
    [13] varchar(255)  NULL,
    [14] varchar(255)  NULL,
    [15] varchar(255)  NULL,
    [16] varchar(255)  NULL,
    [17] varchar(255)  NULL,
    [20] varchar(1)    NULL,
    [21] varchar(255)  NULL,
    [22] bigint  		   NULL,
    [23] varchar(2)    NULL,
    [24] bigint           NULL,
    [25] varchar(255)  NULL,
    [26] varchar(255)  NULL,
    [30] varchar(1)    NULL,
    [39] varchar(1)    NULL,
    [40] varchar(1)    NULL,
    [41] varchar(1)    NULL,
    [43] varchar(255)  NULL,
    [44] varchar(255)  NULL,
    [45] varchar(255)  NULL,
    [46] varchar(1)    NULL,
    [47] varchar(255)  NULL,
    [48] varchar(255)  NULL,
    [49] varchar(255)  NULL,
    [50] varchar(255)  NULL,
    [51] varchar(255)  NULL,
    [52] varchar(255)  NULL
)
go
CREATE CLUSTERED INDEX sb_reporte_buro_cuentas_fk
	ON sb_reporte_buro_cuentas (rb_fecha_report,rb_operacion,rb_ente)
GO
-- ----------------------------------------------
if object_id ('sb_buro_empleo') is not null
    drop table sb_buro_empleo
go
create table sb_buro_empleo(
   be_ente           int ,
   be_raz_social     varchar(104),
   be_pri_linea      varchar(45),
   be_seg_linea      varchar(45),
   be_colonia        varchar(45),
   be_delegacion     varchar(45),
   be_ciudad         varchar(45),
   be_estado         varchar(9),
   be_cod_postal     varchar(10),
   be_num_telf       varchar(16),
   be_ext_telf       varchar(13),
   be_num_fax        varchar(16),
   be_ocupacion      varchar(35),
   be_fecha_contra   varchar(13),
   be_moneda         varchar(7),
   be_sueldo         varchar(14),
   be_frec_pago      varchar(6),
   be_num_empl       varchar(20),
   be_ult_dia_empl   varchar(13),
   be_verif_empl     varchar(13),
   be_origen         varchar(7) 
)
CREATE CLUSTERED INDEX sb_buro_direccion_fk
	ON sb_buro_empleo (be_ente)
GO

-- -------------------------------------------------------------------------------------------------
-- -------------------------------------------ERRORES-----------------------------------------------
-- -------------------------------------------------------------------------------------------------
use cobis
go
delete from cl_errores where numero in (70011010,70011011,70011012,70011014)
insert into cl_errores values(70011010, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_REPORTE_BURO_CUENTAS')
insert into cl_errores values(70011011, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_CLIENTE')
insert into cl_errores values(70011012, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_DIRECCION')
insert into cl_errores values(70011014, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_EMPLEO')
go
-- -------------------------------------------------------------------------------------------------
-- ------------------------------------------PARAMETROS---------------------------------------------
-- -------------------------------------------------------------------------------------------------
delete from cl_parametro where pa_nemonico = 'MNBRCD' and pa_producto = 'REC'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - MEMBER CODE','MNBRCD','C','ZZ99990001','REC')

go
