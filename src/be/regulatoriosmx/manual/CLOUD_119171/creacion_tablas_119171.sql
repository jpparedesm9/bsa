
use cob_externos
go


IF OBJECT_ID ('ex_cuota_minima') IS NOT NULL
	DROP table ex_cuota_minima
go

create table ex_cuota_minima
	(
	cm_fecha         datetime,
	cm_aplicativo    smallint,
    cm_banco         varchar(24),
    cm_monto         money  null,
    cm_capital       money  null,
    cm_interes       money  null,
    cm_iva_interes   money  null,
    cm_comision      money  null,
    cm_iva_comision  money  null
	)
go

IF OBJECT_ID ('ex_datos_lcr') IS NOT NULL
     DROP table ex_datos_lcr
go

create table ex_datos_lcr 
    ( 
	dl_fecha                     datetime,
	dl_aplicativo                smallint,
    dl_banco                     varchar(24),
	dl_dias_de_atraso_6_meses    int null,
    dl_dias_de_atraso_3_meses    int null,
    dl_num_de_atraso_6_meses     int null,
    dl_num_de_atraso_3_meses     int null,
    dl_num_incrementos           int null,
    dl_num_estrellas             int null,
    dl_fecha_prox_aumento        datetime null,
    dl_fecha_ult_aumento         datetime null,
    dl_bloqueado                 char(2) null,
    dl_usuario_ult_modifica      varchar(14),
    dl_num_renovacion            int        ,
    dl_credito_anterior          varchar(24)
	)

use cob_conta_super
go

IF OBJECT_ID ('sb_cuota_minima') IS NOT NULL
	DROP table sb_cuota_minima
go

create table sb_cuota_minima
	(
	cm_fecha         datetime,
	cm_aplicativo    smallint,
    cm_banco         varchar(24),
    cm_monto         money  null,
    cm_capital       money  null,
    cm_interes       money  null,
    cm_iva_interes   money  null,
    cm_comision      money  null,
    cm_iva_comision  money  null
	)
go

create index idx0 on sb_cuota_minima(cm_fecha,cm_banco)

IF OBJECT_ID ('sb_datos_lcr') IS NOT NULL
     DROP table sb_datos_lcr
go

create table sb_datos_lcr 
    ( 
	dl_fecha                     datetime,
	dl_aplicativo                smallint,
    dl_banco                     varchar(24),
	dl_dias_de_atraso_6_meses    int null,
    dl_dias_de_atraso_3_meses    int null,
    dl_num_de_atraso_6_meses     int null,
    dl_num_de_atraso_3_meses     int null,
    dl_num_incrementos           int null,
    dl_num_estrellas             int null,
    dl_fecha_prox_aumento        datetime null,
    dl_fecha_ult_aumento         datetime null,
    dl_bloqueado                 char(2) null,
    dl_usuario_ult_modifica      varchar(14),
    dl_num_renovacion            int,
    dl_credito_anterior          varchar(24) 
	)

create index idx0 on sb_datos_lcr(dl_fecha,dl_banco)
