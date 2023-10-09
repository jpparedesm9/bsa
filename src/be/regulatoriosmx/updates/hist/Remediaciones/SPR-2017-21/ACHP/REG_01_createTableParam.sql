print '---->>>INICIO'
use cobis
go
print '---->>>Registro de Error - 70011017'
delete cl_errores where numero in (70011017)
insert into cl_errores values(70011017, 0, 'ERROR NO HAY REGISTRO EN TABLA SB_BURO_FC_FECHA_ULT_PROC')


use cob_conta_super
go
print '---->>>creacion Tabla sb_buro_fc_fecha_ult_proc'

if object_id ('sb_buro_direccion') is not null
    drop table sb_buro_direccion
go
create table sb_buro_direccion(
   bd_di_ente     int null,
   bd_pri_linea   varchar(60) null,
   bd_seg_linea   varchar(60) null,
   bd_colonia     varchar(60) null,
   bd_delegacion  varchar(60) null,
   bd_ciudad      varchar(60) null,
   bd_estado      varchar(20) null, 
   bd_cod_postal  varchar(20) null,
   bd_fec_reside  varchar(23) null,
   bd_num_telf    varchar(30) null,
   bd_ext_telf    varchar(30) null,
   bd_num_fax     varchar(30) null,
   --
   bd_tdomicilio  varchar(10) null, 
   bd_ind_esp_dom varchar(10) null, 
   bd_org_dom     varchar(10) null  
)
CREATE CLUSTERED INDEX sb_buro_direccion_fk
	ON sb_buro_direccion (bd_di_ente)
GO

print '---->>>creacion Tabla sb_rpt_buro_frmt_act_parc'
if exists (select 1 from sysobjects where name = 'sb_rpt_buro_frmt_act_parc' and type = 'U')
   drop table sb_rpt_buro_frmt_act_parc
 go
CREATE TABLE sb_rpt_buro_frmt_act_parc
(  
   rf_fecha_report datetime NOT NULL,
	rf_operacion	int NOT NULL,
	rf_ente			int NOT NULL,
   rf_num_cta     varchar(255) NOT NULL,
   rf_tipo_re_cta varchar(255) NULL,
   rf_tipo_cta    varchar(255) NULL,
   rf_tipo_prod   varchar(255) NULL,
   rf_mon_cred    varchar(255) NULL,
   rf_num_pagos   varchar(255) NULL,
   rf_frec_pagos  varchar(255) NULL,
   rf_monto_pagar varchar(255) NULL,
   rf_fecha_apert varchar(255) NULL,
   rf_fec_ult_pag varchar(255) NULL,
   rf_fec_ult_cmp varchar(255) NULL,
   rf_fec_cierre  varchar(255) NULL,
   rf_fec_rep_inf varchar(255) NULL,   
   rf_cre_max_aut varchar(255) NULL,
   rf_saldo_act   bigint  		 NULL,
   rf_limit_cred  varchar(2)   NULL,
   rf_saldo_venc  bigint       NULL,
   rf_num_pa_venc varchar(255) NULL,
   rf_for_pag_act varchar(255) NULL,
   rf_clave_obsr  varchar(2)   NULL   
)

go

CREATE CLUSTERED INDEX sb_rpt_buro_frmt_act_parc_fk
	ON dbo.sb_rpt_buro_frmt_act_parc (rf_fecha_report,rf_operacion,rf_ente)
GO
print '---->>>FIN'