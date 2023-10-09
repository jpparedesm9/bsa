use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_estcta_cab_tmp ')
    drop table sb_estcta_cab_tmp
go

CREATE TABLE sb_estcta_cab_tmp (
    ec_secuencial               int         ,
    ec_cod_sucursal             int         ,
    ec_sucursal                 varchar(100),
    ec_producto                 varchar(100),
    ec_nombre_cliente           varchar(100),
    ec_cod_grupo                int         ,
    ec_nom_grupo                varchar(100),
    ec_rfc                      varchar(30) ,
    ec_operacion                varchar(30) ,
    ec_calle                    varchar(70)  null,
    ec_numero                   int          null,
    ec_parroquia                varchar(100) null,
    ec_delegacion               varchar(100) null,
    ec_codigo_postal            varchar(64)  null,
    ec_estado                   varchar(64)  null,
    ec_fecha_inicio             varchar(10)  null,
    ec_fecha_reporte            varchar(10)  null,
    ec_dia_habil                varchar(10)  null,
    ec_importes                 varchar(40)  null,
    ec_folio_fiscal             varchar(1500)  null,
    ec_certificado              varchar(1500)  null,
    ec_sello_digital            varchar(1500) null,
    ec_sello_sat                varchar(1500) null,
    ec_no_de_serie_certificado  varchar(1500) null,
    ec_fecha_certificacion      varchar(20)  null,
    ec_cadena_origial_sat       varchar(1500) null
)
GO
CREATE CLUSTERED INDEX idx_1 ON sb_estcta_cab_tmp(ec_secuencial)
GO

if exists(select 1 from sysobjects where name = 'sb_info_cre_tmp ')
    drop table sb_info_cre_tmp
go

create table sb_info_cre_tmp (
    ic_secuencial         int             ,
    ic_limite_credito     money       null,
    ic_saldo_inicial      money       null,
    ic_interes_ordinario  money       null,
    ic_total_credito      money       null,
    ic_capital            money       null,
    ic_interes_par        money       null,
    ic_iva_interes        money       null,
    ic_total_parcial      money       null,
    ic_base_calculo       money       null,
    ic_saldo_final_cap    money       null,
    ic_estado             varchar(64) null,
    ic_fecha_inicio       varchar(10) null,
    ic_fecha_fin          varchar(10) null,
    ic_frecuencia_pago    varchar(64) null,
    ic_plazo              int         null,
    ic_dia_pago           varchar(30) null,
    ic_tasa_ordinaria     float       null,
    ic_tasa_mensual       float       null,
    ic_dep_garantias      money       null,
    ic_fec_dep_garantias  varchar(10) null,
    ic_cat                float       null,
    ic_comisiones         money       null
)
go
CREATE CLUSTERED INDEX idx_1 ON sb_info_cre_tmp(ic_secuencial)
GO

if exists(select 1 from sysobjects where name = 'sb_movimientos_tmp ')
    drop table sb_movimientos_tmp
go

create table sb_movimientos_tmp(
    mov_secuencial     int               ,
    mov_numero         int           null,
    mov_fecha          datetime      null,
    mov_fecha_pactada  datetime      null,
    mov_numero_pago    int           null,
    mov_dias_atraso    int           null,
    mov_detalle_mov    varchar(100)  null,
    mov_total          money         null,
    mov_capital        money         null,
    mov_interes_ordina money         null,
    mov_interes_mora   money         null,
    mov_iva_int_pag    money         null,
    mov_iva_imo_pag    money         null,
    mov_iva_pre_pag    money         null,
    mov_comision_cob   money         null,
    mov_otros          money         null,
    mov_saldo_capital  money         null,
    mov_dividendo      int           null
)
go
CREATE CLUSTERED INDEX idx_1 ON sb_movimientos_tmp(mov_secuencial)
GO

if exists(select 1 from sysobjects where name = 'sb_amortizacion_tmp ')
    drop table sb_amortizacion_tmp
go
create table sb_amortizacion_tmp(
    am_secuencial     int               ,
    am_numero         int           null,
    am_fecha          datetime      null,
    am_capital        money         null,
    am_interes_ordina money         null,
    am_iva_int        money         null,
    am_comision_cob   money         null,
    am_iva_comision   money         null,
    am_monto_pago     money         null,
    am_saldo_capital  money         null,
    am_pago_total     money         null
)
go

CREATE CLUSTERED INDEX idx_1 ON sb_amortizacion_tmp(am_secuencial)
GO



