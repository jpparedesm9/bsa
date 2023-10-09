use cob_cuentas
go

if exists(select 1 from sysobjects
           where name = 'cc_cheque')
   drop table cc_cheque
go

create table cc_cheque
(
   cq_cuenta            int           not null,
   cq_cheque            int           not null,
   cq_estado_actual     char(1)       not null,
   cq_estado_anterior   char(1)       null,
   cq_fecha_reg         datetime      not null,
   cq_valor             money         null,
   cq_origen            char(1)       null,
   cq_transferido       char(1)       null,
   cq_hora              datetime      not null,
   cq_usuario           login         null,
   np_causa             char(3)       null,
   np_clase             char(1)       null,
   np_filial            tinyint       null,
   np_oficina           smallint      null,
   np_fecha_can         datetime      null,
   np_fecha_tope        datetime      null,
   np_acreditado        char(1)       null,
   cf_fecha_pago        datetime      null,
   pt_justificado       char(1)       null,
   pt_fecha_jus         datetime      null,
   pt_comentario        descripcion   null,
   pt_valor_multa       money         null,
   pt_valor_cobrado     money         null,
   pt_num_veces         tinyint       null,
   ge_oficina_pago      smallint      null,
   df_tdeficiencia      char(1)       null,
   ge_tipo_ben          char(1)       null
)

create unique clustered index cc_cheque_Key
    on cc_cheque(cq_cuenta,cq_fecha_reg,cq_cheque)

create unique nonclustered index icq_estado_cheque
    on cc_cheque(cq_cuenta,cq_cheque)

create nonclustered index icq_estado_fecha
    on cc_cheque(cq_estado_actual,cq_estado_anterior,cq_fecha_reg)
go


if exists(select 1 from sysobjects
           where name = 'cc_chequera')
   drop table cc_chequera
go

create table cc_chequera
(
   ch_cuenta             int           not null,
   ch_chequera           int           not null,
   ch_inicial            int           not null,
   ch_numero             int           not null,
   ch_fecha_emision      datetime      null,
   ch_fecha_eimprenta    datetime      null,
   ch_fecha_rimprenta    datetime      null,
   ch_fecha_roficina     datetime      null,
   ch_fecha_entrega      datetime      null,
   ch_tipo_chequera      varchar(5)    not null,
   ch_emisor             char(1)       not null,
   ch_autorizante        login         not null,
   ch_ofi_emision        smallint      not null,
   ch_ofi_entrega        smallint      not null,
   ch_estado             char(1)       not null,
   ch_estado_anterior    char(1)       not null,
   ch_chq_ini_dev        int           null,
   ch_chq_fin_dev        int           null,
   ch_control_chq        int           null,
   ch_estado_eimprenta   char(1)       null,
   ch_ssn                int           null,
   ch_tipo_cobro         char(1)       null,
   ch_etiqueta           varchar(64)   not null,
   ch_domicilio          char(1)       null
)

create unique clustered index cc_chequera_Key
    on cc_chequera(ch_cuenta,ch_chequera)

create nonclustered index cc_cheqestadoKey
    on cc_chequera(ch_cuenta,ch_estado,ch_inicial)

create nonclustered index cc_chqr_imprenta_Key
    on cc_chequera(ch_ofi_emision,ch_estado,ch_cuenta,ch_inicial)

create nonclustered index i_ch_tchequera
    on cc_chequera(ch_tipo_chequera)
go


if exists(select 1 from sysobjects
           where name = 'cc_his_cheque')
   drop table cc_his_cheque
go

create table cc_his_cheque
(
   hc_ssn                 int        not null,
   hc_cuenta              int        not null,
   hc_cheque              int        not null,
   hc_estado_actual       char(1)    null,
   hc_estado_anterior     char(1)    null,
   hc_fecha_anulacion     datetime   null,
   hc_hora                datetime   null,
   hc_origen              char(1)    not null,
   hc_valor               money      null,
   hc_causa               char(1)    null,
   hc_clase               char(1)    null,
   hc_filial              tinyint    null,
   hc_oficina             smallint   null,
   hc_usuario             login      null,
   hc_fecha_levantamiento datetime   null,
   hc_comision            money      null,
   hc_publicacion         money      null,
   hc_clave               int        null
)

create nonclustered index cc_his_cheque_Clave
    on cc_his_cheque(hc_cuenta,hc_cheque,hc_estado_actual)
go


if exists(select 1 from sysobjects
           where name = 'cc_rango_anulados')
   drop table cc_rango_anulados
go

create table cc_rango_anulados
(
   ra_ctacte            int           not null,
   ra_rango             smallint      not null,
   ra_estado            char(1)       not null,
   ra_cheque_inicial    int           not null,
   ra_cheque_final      int           not null,
   ra_fecha_anulacion   datetime      not null,
   ra_autorizante       varchar(20)   not null,
   ra_cobro             char(1)       not null
)

create unique clustered index cc_rango_anulados_Key
    on cc_rango_anulados(ra_ctacte,ra_rango)

go


if exists(select 1 from sysobjects
           where name = 'cc_ctabloqueada')
   drop table cc_ctabloqueada
go

create table cc_ctabloqueada
(
   cb_cuenta           int           not null,
   cb_secuencial       smallint      not null,
   cb_tipo_bloqueo     char(3)       not null,
   cb_fecha            datetime      not null,
   cb_hora             datetime      not null,
   cb_autorizante      login         not null,
   cb_solicitante      descripcion   not null,
   cb_oficina          smallint      not null,
   cb_causa            varchar(3)    not null,
   cb_estado           estado        null,
   cb_sec_asoc         smallint      null,
   cb_oficio_crea      varchar(8)    null,
   cb_demanda          char(30)      null,
   cb_oficio_levanta   varchar(8)    null,
   cb_fecha_ven        datetime      null,
   cb_liberacion       datetime      null
)

create unique clustered index cc_ctabloqueada_Key
    on cc_ctabloqueada(cb_cuenta,cb_secuencial)
go


if exists(select 1 from sysobjects
           where name = 'cc_his_bloqueo')
   drop table cc_his_bloqueo
go

create table cc_his_bloqueo
(
   hb_ctacte           int           not null,
   hb_secuencial       int           not null,
   hb_valor            money         not null,
   hb_monto_blq        money         not null,
   hb_fecha            datetime      not null,
   hb_fecha_ven        datetime      null,
   hb_hora             datetime      null,
   hb_autorizante      login         not null,
   hb_solicitante      descripcion   null,
   hb_oficina          smallint      not null,
   hb_causa            char(2)       not null,
   hb_saldo            money         not null,
   hb_accion           char(1)       not null,
   hb_levantado        char(2)       null,
   hb_sec_asoc         int           null,
   hb_oficio_crea      varchar(8)    null,
   hb_demanda          char(30)      null,
   hb_oficio_levanta   varchar(8)    null
)

create unique clustered index cc_his_bloqueo_Key
    on cc_his_bloqueo(hb_ctacte,hb_secuencial)

create nonclustered index cc_his_bloqueo_alt
    on cc_his_bloqueo(hb_ctacte,hb_accion,hb_fecha)
go


if exists(select 1 from sysobjects
           where name = 'cc_uso_sobregiro')
   drop table cc_uso_sobregiro
go

create table cc_uso_sobregiro
(
   us_cuenta             int        not null,
   us_fecha_reg          datetime   not null,
   us_tipo_sobregiro     char(1)    not null,
   us_util_ayer          money      null,
   us_util_hoy           money      null,
   us_interes            money      not null,
   us_mora               money      not null,
   us_num_dias           smallint   not null,
   us_dias_acum          smallint   not null,
   us_estado             char(1)    not null,
   us_tasa_mora          float      null,
   us_fecha_liq          datetime   null,
   us_interes_acum       money      null,
   us_int_causados       money      null,
   us_int_contingentes   money      null,
   us_tasa_int           float      null,
   us_util_real_hoy      money      null
)

create unique clustered index cc_uso_sobregiro_Key
    on cc_uso_sobregiro(us_cuenta,us_fecha_reg,us_tipo_sobregiro)

create nonclustered index i_cta_estado
    on cc_uso_sobregiro(us_cuenta,us_tipo_sobregiro,us_estado)
go


if exists(select 1 from sysobjects
           where name = 'cc_ciudad_deposito')
   drop table cc_ciudad_deposito
go

create table cc_ciudad_deposito
(
   cd_cuenta       int        not null,
   cd_ciudad       int        not null,
   cd_fecha_depo   datetime   not null,
   cd_fecha_efe    datetime   not null,
   cd_valor        money      not null
)

create unique clustered index cc_ciudad_deposito_Key
    on cc_ciudad_deposito(cd_cuenta,cd_ciudad,cd_fecha_depo,cd_fecha_efe)

create nonclustered index cc_ciudad_deposito_Alt
    on cc_ciudad_deposito(cd_cuenta,cd_fecha_efe)

create nonclustered index cc_ciudad_deposito_Alt1
    on cc_ciudad_deposito(cd_fecha_depo,cd_cuenta)
go


if exists(select 1 from sysobjects
           where name = 'cc_fecha_promedio')
   drop table cc_fecha_promedio
go

create table cc_fecha_promedio
(
   fp_tipo_promedio     char(1)          not null,
   fp_numero_promedio   smallint         not null,
   fp_fecha_inicio      datetime         not null,
   fp_alicuota          numeric(18, 0)   null
)
go


if exists(select 1 from sysobjects
           where name = 'cc_fecha_valor')
   drop table cc_fecha_valor
go

create table cc_fecha_valor
(
   fv_transaccion   smallint      not null,
   fv_cuenta        int           not null,
   fv_referencia    varchar(24)   not null,
   fv_rubro         varchar(10)   not null,
   fv_costo         money         not null,
   fv_causa         varchar(3)    null,
   fv_ssn_sus       int           null
)

create unique nonclustered index cc_fecha_valor_Key
    on cc_fecha_valor(fv_transaccion,fv_cuenta,fv_referencia,fv_rubro)
go


if exists(select 1 from sysobjects
           where name = 'cc_val_suspenso')
   drop table cc_val_suspenso
go

create table cc_val_suspenso
(
   vs_secuencial      int        not null,
   vs_cuenta          int        not null,
   vs_servicio        char(3)    not null,
   vs_valor           money      not null,
   vs_oficina         smallint   not null,
   vs_fecha           datetime   not null,
   vs_hora            datetime   not null,
   vs_ssn             int        not null,
   vs_clave           int        not null,
   vs_estado          char(1)    not null,
   vs_procesada       char(1)    not null,
   vs_cobrado         money      null,
   vs_ult_fec_cobro   datetime   null
)

create unique clustered index cc_val_suspenso_Key
    on cc_val_suspenso(vs_cuenta,vs_secuencial)

create nonclustered index i_vs_ssn
    on cc_val_suspenso(vs_fecha,vs_ssn)
go


if exists(select 1 from sysobjects
           where name = 'cc_notcredeb')
   drop table cc_notcredeb
go

create table cc_notcredeb
(
   secuencial       int           not null, 
   tipo_tran        smallint      not null, 
   oficina          smallint      not null, 
   usuario          varchar(30)   not null, 
   terminal         varchar(10)   not null, 
   correccion       char(1)       null,
   sec_correccion   int           null,
   reentry          char(1)       null,
   origen           char(1)       null,
   nodo             descripcion   null,
   fecha            datetime      null,
   cta_banco        cuenta        null,
   valor            money         null,
   remoto_ssn       int           null,
   moneda           tinyint       null,
   sld_contable     money         null,
   indicador        tinyint       null,
   nro_cheque       int           null,
   val_cheque       money         null,
   causa            varchar(3)    null,
   alterno          int           null,
   signo            char(1)       null,
   sld_disponible   money         null,
   departamento     smallint      null,
   banco            smallint      null,
   tinteres         real          null,
   timpuesto        real          null,
   tsolca           real          null,
   tcomision        real          null,
   tmora            real          null,
   vinteres         money         null,
   vimpuesto        money         null,
   vsolca           money         null,
   vcomision        money         null,
   vmora            money         null,
   nombre_sol       varchar(30)   null,
   identifi_sol     varchar(13)   null,
   estado           char(1)       null,
   filial           tinyint       null,
   oficina_cta      smallint      null,
   hora             datetime      null,
   concepto         varchar(30)   null,
   ssn_branch       int           null,
   marca_inu        char(1)       null,
   fecha_efec       datetime      null,
   clase_clte       char(1)       null,
   tipo             char(1)       null,
   prod_banc        tinyint       null,
   oficial          smallint      null,
   canal            tinyint       null,
   cliente          int           null
)
go

