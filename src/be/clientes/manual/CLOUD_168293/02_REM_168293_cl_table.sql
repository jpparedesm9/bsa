/****************************************************/
-- CREACION TABLA FORMULARIO KYC - AUTO-ONBOARDING --
/****************************************************/
use cobis
go

if object_id ('dbo.cl_auto_onboard_form_kyc') is not null
	drop table dbo.cl_auto_onboard_form_kyc
go

create table cl_auto_onboard_form_kyc(
  ko_ente                     int           not null,
  ko_act_eco_generica         varchar (10)  null,
  ko_firma_electronica        char (1)      null,
  ko_funciones_publicas       char (1)      null,
  ko_serv_transf_inter        char (1)      null,
  ko_transac_divisas          char (1)      null,
  ko_tran_nac_env_num         varchar (30)  null,
  ko_tran_nac_env_monto       varchar (30)  null,
  ko_tran_nac_rec_num         varchar (30)  null,
  ko_tran_nac_rec_monto       varchar (30)  null,
  ko_depo_efectivo_num        varchar (30)  null,
  ko_depo_efectivo_monto      varchar (30)  null,
  ko_depo_no_efectivo_num     varchar (30)  null,
  ko_depo_no_efectivo_monto   varchar (30)  null,
  ko_aceptar                  char (1)      null,
  ko_fecha_proceso            datetime      not null,
  ko_fecha_real               datetime      not null
)
go

if exists (select name from sysindexes where name='iko_ente')
    drop index cl_auto_onboard_form_kyc.iko_ente    
go
    create nonclustered index iko_ente on cl_auto_onboard_form_kyc (ko_ente)
go
