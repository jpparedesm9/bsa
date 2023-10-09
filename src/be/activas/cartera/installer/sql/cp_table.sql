use cob_palm
go

if object_id ('ca_detalle_dividendos_pda2') is not null
	drop table ca_detalle_dividendos_pda2
go

create table ca_detalle_dividendos_pda2
(
   dd_oficial             smallint      not null,
   dd_banco               char(24)      not null,
   dd_dividendo           smallint      not null,
   dd_estado              varchar(64)   not null,
   dd_cuota_total         money         not null,
   dd_dias_atraso         int           not null,
   dd_valor_mora          money         not null,
   dd_total_dias_mora     int           not null,
   dd_estado_sincro       varchar(3)    null,
   dd_secuencial_sincro   int           null
)

create nonclustered index ca_detalle_dividendos_pda2_Key1 
    on ca_detalle_dividendos_pda2(dd_secuencial_sincro)

create nonclustered index dd_oficial_Key2
    on ca_detalle_dividendos_pda2(dd_oficial)
go


if object_id ('ca_detalle_ejecutivo_pda2') is not null
	drop table ca_detalle_ejecutivo_pda2
go

create table ca_detalle_ejecutivo_pda2
(
   de_oficial             smallint      not null,
   de_ente                int           not null,
   de_en_ced_ruc          varchar(30)   not null,
   de_nombre_cliente      varchar(64)   not null,
   de_dias_vencimiento    int           not null,
   de_banco               char(24)      not null,
   de_monto_des           money         not null,
   de_cuotas_total        smallint      not null,
   de_cuotas_vencidas     smallint      not null,
   de_cuotas_por_pagar    smallint      not null,
   de_cuotas_pagadas      smallint      not null,
   de_calif_interna       tinyint       not null,
   de_total_creditos      int           not null,
   de_total_saldo_cap     money         not null,
   de_total_deuda         money         not null,
   de_celular             varchar(16)   not null,
   de_barrio              varchar(40)   not null,
   de_telefono_dom        varchar(16)   not null,
   de_telefono_neg        varchar(16)   not null,
   de_estado_sincro       varchar(3)    null,
   de_secuencial_sincro   int           null,
   de_tramite             int           null
)

create nonclustered index ca_detalle_ejecutivo_pda2_Key1
    on ca_detalle_ejecutivo_pda2(de_secuencial_sincro)
go


if object_id ('ca_resumen_aprobados_pda2') is not null
	drop table ca_resumen_aprobados_pda2
go

create table ca_resumen_aprobados_pda2
(
   ra_oficial             smallint      not null,
   ra_tramite             int           not null,
   ra_nombre_cliente      varchar(64)   not null,
   ra_fecha_aprob         datetime      not null,
   ra_monto_solicitado    money         not null,
   ra_monto_aprobado      money         not null,
   ra_monto_cuota         money         not null,
   ra_plazo               smallint      not null,
   ra_forma_pago          varchar(64)   not null,
   ra_toperacion          varchar(64)   not null,
   ra_tel_neg             varchar(16)   not null,
   ra_estado_sincro       varchar(3)    null,
   ra_secuencial_sincro   int           null
)
go


if object_id ('ca_resumen_cancelados_his_pda2') is not null
	drop table ca_resumen_cancelados_his_pda2
go

create table ca_resumen_cancelados_his_pda2
(
   rch_oficial             smallint     not null,
   rch_banco               char(24)     not null,
   rch_en_ced_ruc          varchar(30)  not null,
   rch_monto_aprobado      money        not null,
   rch_fecha_aprobacion    datetime     not null,
   rch_plazo               smallint     not null,
   rch_calific_interna     smallint     not null,
   rch_valor_cuota         money        not null,
   rch_estado_sincro       varchar(3)   null,
   rch_secuencial_sincro   int          null
)
go

create nonclustered index ca_resumen_cancelados_his_pda2_idx1
    on ca_resumen_cancelados_his_pda2(rch_secuencial_sincro)
include (rch_oficial,
         rch_banco,
         rch_en_ced_ruc,
         rch_monto_aprobado,
         rch_fecha_aprobacion,
         rch_plazo,
         rch_calific_interna,
         rch_valor_cuota)


if object_id ('ca_resumen_cancelados_pda2') is not null
	drop table ca_resumen_cancelados_pda2
go

create table ca_resumen_cancelados_pda2
(
   rc_oficial             smallint      not null,
   rc_ente                int           not null,
   rc_dir_neg             varchar(64)   not null,
   rc_en_ced_ruc          varchar(30)   not null,
   rc_nombre_cliente      varchar(64)   not null,
   rc_apellido_cliente    varchar(64)   not null,
   rc_telefono            varchar(16)   not null,
   rc_barrio              varchar(40)   not null,
   rc_estado_sincro       varchar(3)    null,
   rc_secuencial_sincro   int           null
)
go


if object_id ('ca_resumen_ejecutivo_pda2') is not null
	drop table ca_resumen_ejecutivo_pda2
go

create table ca_resumen_ejecutivo_pda2
(
   re_oficial                    smallint     not null,
   re_nro_total_creditos         int          not null,
   re_saldo_total_cartera        money        not null,
   re_tot_cred_rango_30          int          not null,
   re_saldo_cap_rango_30         money        not null,
   re_porc_rango_30              float        not null,
   re_tot_cred_rango_mayor_30    int          not null,
   re_saldo_cap_rango_mayor_30   money        not null,
   re_porc_rango_mayor_30        float        not null,
   re_estado_sincro              varchar(3)   null,
   re_secuencial_sincro          int          null
)
go


if object_id ('ca_resumen_renovaciones_his_pda2') is not null
	drop table ca_resumen_renovaciones_his_pda2
go

create table ca_resumen_renovaciones_his_pda2
(
   rrh_oficial             smallint      not null,
   rrh_ente                int           not null,
   rrh_banco               char(24)      not null,
   rrh_en_ced_ruc          varchar(30)   not null,
   rrh_monto_aprobado      money         not null,
   rrh_fecha_aprobacion    datetime      not null,
   rrh_plazo               smallint      not null,
   rrh_calific_interna     tinyint       not null,
   rrh_valor_cuota         money         not null,
   rrh_estado_sincro       varchar(3)    null,
   rrh_secuencial_sincro   int           null
)
go


if object_id ('ca_resumen_renovaciones_pda2') is not null
	drop table ca_resumen_renovaciones_pda2
go

create table ca_resumen_renovaciones_pda2
(
   rr_oficial                 smallint      not null,
   rr_ente                    int           not null,
   rr_dir_neg                 varchar(64)   not null,
   rr_banco                   char(24)      not null,
   rr_nombre_cliente          varchar(64)   not null,
   rr_fecha_vencimiento       datetime      not null,
   rr_porcentaje_cuotas_pag   float         not null,
   rr_telefono_neg            varchar(16)   not null,
   rr_telefono_dom            varchar(16)   not null,
   rr_en_ced_ruc              varchar(30)   not null,
   rr_barrio                  varchar(40)   not null,
   rr_estado_sincro           varchar(3)    null,
   rr_secuencial_sincro       int           null
)
go


if object_id ('pda_control') is not null
	drop table pda_control
go

create table pda_control
(
   pc_secuencial     int           not null,
   pc_fecha_sincro   datetime      not null,
   pc_estado         smallint      not null,
   pc_hora_inicio    datetime      not null,
   pc_hora_estado    datetime      not null,
   pc_usuario        varchar(14)   not null,
   pc_terminal       varchar(30)   null,
   pc_oficina        smallint      null,
   pc_carga          char(1)       null
)

create nonclustered index pda_control_Key1
    ON pda_control(pc_secuencial)

create nonclustered index pda_control_Key2
    on pda_control(pc_fecha_sincro,pc_usuario)
go

if object_id ('pda_rechazos') is not null
	drop table pda_rechazos
go

create table pda_rechazos
(
   re_secuencial   int            null,
   re_ejecutivo    varchar(14)    null,
   re_tabla        varchar(50)    null,
   re_ente         int            null,
   re_mensaje      varchar(255)   null,
   re_fecha        datetime       null
)
go
