----------------- <CREANDO TABLAS> -------------------
 
use cob_conta
go
 
set nocount on
go
 
print '-->Tabla: cb_paramterceros'
create table cb_paramterceros(
                                                              
------------------------------------------ ------------------ ---------
[pt_secuencial]                            numeric(10,0)      not null,
[pt_empresa]                               tinyint            not null,
[pt_oficina]                               smallint           not null,
[pt_ente]                                  int                not null,
[pt_cuenta]                                cuenta             null

)
go
 
print '-->Tabla: cb_periodo'
create table cb_periodo(
                                                              
------------------------------------------ ------------------ ---------
[pe_periodo]                               int                not null,
[pe_empresa]                               tinyint            not null,
[pe_fecha_inicio]                          datetime           not null,
[pe_fecha_fin]                             datetime           not null,
[pe_estado]                                char(1)            not null,
[pe_tipo_periodo]                          char(10)           not null

)
go
 
print '-->Tabla: cb_area'
create table cb_area(
                                                              
------------------------------------------ ------------------ ---------
[ar_empresa]                               tinyint            not null,
[ar_area]                                  smallint           not null,
[ar_descripcion]                           descripcion        not null,
[ar_area_padre]                            smallint           null,
[ar_estado]                                char(1)            not null,
[ar_fecha_estado]                          datetime           null,
[ar_nivel_area]                            tinyint            not null,
[ar_consolida]                             char(1)            not null,
[ar_movimiento]                            char(1)            not null

)
go
 
print '-->Tabla: cb_plan_general'
create table cb_plan_general(
                                                              
------------------------------------------ ------------------ ---------
[pg_empresa]                               tinyint            not null,
[pg_cuenta]                                cuenta_contable    not null,
[pg_oficina]                               smallint           not null,
[pg_area]                                  smallint           not null,
[pg_clave]                                 varchar(30)        null

)
go
 
print '-->Tabla: cb_plan_general_presupuesto'
create table cb_plan_general_presupuesto(
                                                              
------------------------------------------ ------------------ ---------
[pgp_empresa]                              tinyint            not null,
[pgp_cuenta]                               cuenta_contable    not null,
[pgp_oficina]                              smallint           not null,
[pgp_area]                                 smallint           not null

)
go
 
print '-->Tabla: cb_regimen_fiscal'
create table cb_regimen_fiscal(
                                                              
------------------------------------------ ------------------ ---------
[rf_codigo]                                catalogo           not null,
[rf_descripcion]                           descripcion        not null,
[rf_iva]                                   char(1)            not null,
[rf_timbre]                                char(1)            not null,
[rf_renta]                                 char(1)            not null,
[rf_ica]                                   char(1)            not null,
[rf_iva_des]                               char(1)            not null,
[rf_iva_cobrado]                           char(1)            not null,
[rf_estampillas]                           char(1)            not null,
[rf_3xm]                                   char(1)            not null,
[rf_estado]                                char(1)            not null,
[rf_retencion_iva]                         char(1)            not null,
[rf_naturaleza]                            char(1)            not null,
[rf_grancontribuyente]                     char(1)            not null,
[rf_autorretenedor]                        char(1)            not null

)
go
 
print '-->Tabla: cb_relofi'
create table cb_relofi(
                                                              
------------------------------------------ ------------------ ---------
[re_filial]                                tinyint            not null,
[re_empresa]                               tinyint            not null,
[re_ofadmin]                               smallint           not null,
[re_ofconta]                               smallint           not null

)
go
 
print '-->Tabla: cb_banco'
create table cb_banco(
                                                              
------------------------------------------ ------------------ ---------
[ba_empresa]                               tinyint            not null,
[ba_banco]                                 varchar(3)         not null,
[ba_nombre]                                descripcion        not null,
[ba_cuenta]                                char(20)           not null,
[ba_ctacte]                                varchar(20)        not null,
[ba_operacion]                             char(4)            null

)
go
 
print '-->Tabla: cb_categoria'
create table cb_categoria(
                                                              
------------------------------------------ ------------------ ---------
[ca_categoria]                             char(1)            not null,
[ca_nombre]                                descripcion        not null,
[ca_signo]                                 char(1)            not null

)
go
 
print '-->Tabla: cb_comp_tipo'
create table cb_comp_tipo(
                                                              
------------------------------------------ ------------------ ---------
[ct_comp_tipo]                             int                not null,
[ct_empresa]                               tinyint            not null,
[ct_modificable]                           char(1)            not null,
[ct_concepto]                              varchar(255)       null,
[ct_oficina_orig]                          smallint           not null,
[ct_area_orig]                             smallint           not null,
[ct_porcentual]                            char(1)            null,
[ct_referencia]                            varchar(10)        null,
[ct_detalles]                              int                not null

)
go
 
print '-->Tabla: cb_saldo'
create table cb_saldo(
                                                              
------------------------------------------ ------------------ ---------
[sa_empresa]                               tinyint            not null,
[sa_cuenta]                                cuenta_contable    not null,
[sa_oficina]                               smallint           not null,
[sa_area]                                  smallint           not null,
[sa_corte]                                 int                not null,
[sa_periodo]                               int                not null,
[sa_saldo]                                 money              null,
[sa_saldo_me]                              money              null,
[sa_debito]                                money              null,
[sa_credito]                               money              null,
[sa_debito_me]                             money              null,
[sa_credito_me]                            money              null

)
go
 
print '-->Tabla: cb_cuenta_niif'
create table cb_cuenta_niif(
                                                              
------------------------------------------ ------------------ ---------
[cu_fecha_ing]                             datetime           not null,
[cu_cuenta]                                cuenta_contable    not null,
[cu_cuenta_padre]                          cuenta_contable    null,
[cu_nivel_cuenta]                          tinyint            not null,
[cu_categoria]                             char(1)            not null,
[cu_moneda]                                tinyint            null

)
go
 
print '-->Tabla: cb_saldo_presupuesto'
create table cb_saldo_presupuesto(
                                                              
------------------------------------------ ------------------ ---------
[sap_empresa]                              tinyint            not null,
[sap_cuenta]                               cuenta_contable    not null,
[sap_oficina]                              smallint           not null,
[sap_area]                                 smallint           not null,
[sap_fecha]                                datetime           not null,
[sap_presupuesto]                          money              null,
[sap_real]                                 money              null

)
go
 
print '-->Tabla: cb_control'
create table cb_control(
                                                              
------------------------------------------ ------------------ ---------
[cn_empresa]                               tinyint            not null,
[cn_login]                                 varchar(14)        not null,
[cn_oficina]                               smallint           not null,
[cn_area]                                  smallint           not null,
[cn_tipo]                                  char(1)            not null

)
go
 
print '-->Tabla: cb_corte'
create table cb_corte(
                                                              
------------------------------------------ ------------------ ---------
[co_corte]                                 int                not null,
[co_periodo]                               int                not null,
[co_empresa]                               tinyint            not null,
[co_fecha_ini]                             datetime           not null,
[co_fecha_fin]                             datetime           not null,
[co_estado]                                char(1)            not null,
[co_tipo_corte]                            tinyint            null

)
go
 
print '-->Tabla: cb_cotizacion'
create table cb_cotizacion(
                                                              
------------------------------------------ ------------------ ---------
[ct_moneda]                                tinyint            not null,
[ct_fecha]                                 datetime           not null,
[ct_valor]                                 money              null,
[ct_compra]                                money              not null,
[ct_venta]                                 money              not null,
[ct_factor1]                               float              null,
[ct_factor2]                               float              null

)
go
 
print '-->Tabla: cb_cuenta'
create table cb_cuenta(
                                                              
------------------------------------------ ------------------ ---------
[cu_empresa]                               tinyint            not null,
[cu_cuenta]                                cuenta_contable    not null,
[cu_cuenta_padre]                          cuenta_contable    null,
[cu_nombre]                                char(80)           not null,
[cu_descripcion]                           char(255)          null,
[cu_estado]                                char(1)            not null,
[cu_movimiento]                            char(1)            not null,
[cu_nivel_cuenta]                          tinyint            not null,
[cu_categoria]                             char(1)            not null,
[cu_fecha_estado]                          datetime           null,
[cu_moneda]                                tinyint            not null,
[cu_sinonimo]                              char(20)           null,
[cu_acceso]                                char(1)            null,
[cu_presupuesto]                           char(1)            null

)
go
 
print '-->Tabla: cb_cuenta6004'
create table cb_cuenta6004(
                                                              
------------------------------------------ ------------------ ---------
[proceso]                                  int                not null,
[cuenta]                                   cuenta_contable    not null,
[oficina]                                  char(4)            not null,
[area]                                     char(4)            not null,
[condicion]                                char(4)            null,
[imprima]                                  char(1)            null,
[descripcion]                              descripcion        null,
[texto]                                    descripcion        null

)
go
 
print '-->Tabla: cb_cuenta_asociada'
create table cb_cuenta_asociada(
                                                              
------------------------------------------ ------------------ ---------
[ca_empresa]                               tinyint            not null,
[ca_cuenta]                                cuenta_contable    not null,
[ca_oficina]                               smallint           null,
[ca_area]                                  smallint           null,
[ca_proceso]                               smallint           not null,
[ca_secuencial]                            smallint           not null,
[ca_condicion]                             smallint           not null,
[ca_cta_asoc]                              cuenta_contable    null,
[ca_oficina_destino]                       smallint           null,
[ca_area_destino]                          smallint           null,
[ca_debcred]                               char(1)            null

)
go
 
print '-->Tabla: cb_seqnos'
create table cb_seqnos(
                                                              
------------------------------------------ ------------------ ---------
[bdatos]                                   varchar(30)        null,
[tabla]                                    varchar(30)        not null,
[siguiente]                                int                null,
[pkey]                                     varchar(30)        null,
[empresa]                                  tinyint            null

)
go
 
print '-->Tabla: cb_cuenta_presupuesto'
create table cb_cuenta_presupuesto(
                                                              
------------------------------------------ ------------------ ---------
[cup_empresa]                              tinyint            not null,
[cup_cuenta]                               cuenta_contable    not null,
[cup_cuenta_padre]                         cuenta_contable    null,
[cup_nombre]                               descripcion        not null,
[cup_descripcion]                          varchar(255)       null,
[cup_nivel_cuenta]                         tinyint            not null,
[cup_categoria]                            char(1)            not null,
[cup_movimiento]                           char(1)            not null,
[cup_estado]                               char(1)            not null

)
go
 
print '-->Tabla: cb_cuenta_proceso'
create table cb_cuenta_proceso(
                                                              
------------------------------------------ ------------------ ---------
[cp_proceso]                               int                not null,
[cp_empresa]                               tinyint            not null,
[cp_cuenta]                                cuenta_contable    not null,
[cp_oficina]                               smallint           null,
[cp_area]                                  smallint           null,
[cp_imprima]                               char(1)            null,
[cp_condicion]                             char(4)            null,
[cp_texto]                                 descripcion        null,
[cp_quiebre]                               char(10)           null

)
go
 
print '-->Tabla: cargue_niif_errores_tmp'
create table cargue_niif_errores_tmp(
                                                              
------------------------------------------ ------------------ ---------
[ARCHIVO]                                  varchar(30)        null,
[FECHACARGA]                               datetime           null,
[CUENTA]                                   varchar(14)        null,
[NATURALEZA]                               char(1)            null,
[MONEDA]                                   char(1)            null,
[INDICADOR]                                char(1)            null,
[DESCRIPCION]                              varchar(100)       null

)
go
 
print '-->Tabla: cb_det_comptipo'
create table cb_det_comptipo(
                                                              
------------------------------------------ ------------------ ---------
[dct_empresa]                              tinyint            not null,
[dct_comp_tipo]                            int                not null,
[dct_asiento]                              smallint           not null,
[dct_cuenta]                               cuenta_contable    not null,
[dct_oficina_dest]                         smallint           not null,
[dct_area_dest]                            smallint           not null,
[dct_debe]                                 money              null,
[dct_haber]                                money              null,
[dct_debe_me]                              money              null,
[dct_haber_me]                             money              null,
[dct_cotizacion]                           money              null,
[dct_concepto]                             varchar(255)       null,
[dct_tipo_doc]                             char(1)            not null,
[dct_tipo_tran]                            char(1)            null

)
go
 
print '-->Tabla: cb_dinamica'
create table cb_dinamica(
                                                              
------------------------------------------ ------------------ ---------
[di_empresa]                               tinyint            not null,
[di_cuenta]                                char(20)           not null,
[di_secuencial]                            smallint           not null,
[di_tipo_dinamica]                         char(1)            not null,
[di_texto]                                 text               not null,
[di_disp_legal]                            varchar(64)        null

)
go
 
print '-->Tabla: cb_empresa'
create table cb_empresa(
                                                              
------------------------------------------ ------------------ ---------
[em_empresa]                               tinyint            not null,
[em_ruc]                                   varchar(13)        not null,
[em_descripcion]                           varchar(64)        not null,
[em_replegal]                              varchar(64)        null,
[em_contgen]                               varchar(64)        null,
[em_moneda_base]                           tinyint            not null,
[em_abreviatura]                           char(16)           null,
[em_direccion]                             varchar(64)        not null,
[em_matcontgen]                            char(10)           not null,
[em_revisor]                               varchar(64)        not null,
[em_matrevisor]                            char(10)           not null,
[em_emp_revisor]                           descripcion        null,
[em_nit_emprev]                            varchar(13)        null,
[em_mat_revisor]                           char(10)           null

)
go
 
print '-->Tabla: cb_exencion_ciudad'
create table cb_exencion_ciudad(
                                                              
------------------------------------------ ------------------ ---------
[ec_empresa]                               tinyint            not null,
[ec_impuesto]                              char(1)            not null,
[ec_concepto]                              char(4)            not null,
[ec_debcred]                               char(1)            not null,
[ec_ciudad]                                int                not null,
[ec_ofi_orig]                              char(1)            null,
[ec_ofi_dest]                              char(1)            null

)
go
 
print '-->Tabla: cb_cuentas_ord_tmp'
create table cb_cuentas_ord_tmp(
                                                              
------------------------------------------ ------------------ ---------
[cuenta]                                   int                null,
[monto]                                    money              null,
[sec]                                      int                null

)
go
 
print '-->Tabla: cb_general_presupuesto'
create table cb_general_presupuesto(
                                                              
------------------------------------------ ------------------ ---------
[gp_empresa]                               tinyint            not null,
[gp_oficina_presupuesto]                   smallint           not null,
[gp_area_presupuesto]                      int                not null,
[gp_cuenta_presupuesto]                    cuenta_contable    not null,
[gp_oficina]                               smallint           not null,
[gp_area]                                  int                not null,
[gp_cuenta]                                cuenta_contable    not null

)
go
 
print '-->Tabla: cb_cuentas_ord_tmp_mv'
create table cb_cuentas_ord_tmp_mv(
                                                              
------------------------------------------ ------------------ ---------
[cuenta]                                   varchar(30)        null,
[monto]                                    money              null,
[sec]                                      int                null

)
go
 
print '-->Tabla: cb_ica'
create table cb_ica(
                                                              
------------------------------------------ ------------------ ---------
[ic_empresa]                               tinyint            not null,
[ic_codigo]                                char(4)            not null,
[ic_descripcion]                           varchar(255)       not null,
[ic_base]                                  money              null,
[ic_porcentaje]                            float              null,
[ic_ciudad]                                int                null,
[ic_debcred]                               char(1)            not null

)
go
 
print '-->Tabla: cb_iva'
create table cb_iva(
                                                              
------------------------------------------ ------------------ ---------
[iva_empresa]                              tinyint            not null,
[iva_codigo]                               char(4)            not null,
[iva_descripcion]                          varchar(150)       not null,
[iva_base]                                 money              null,
[iva_porcentaje]                           float              null,
[iva_descontado]                           char(1)            null,
[iva_des_porcen]                           float              null,
[iva_debcred]                              char(1)            not null,
[iva_porc_espec]                           float              not null

)
go
 
print '-->Tabla: cb_iva_pagado'
create table cb_iva_pagado(
                                                              
------------------------------------------ ------------------ ---------
[ip_empresa]                               tinyint            not null,
[ip_codigo]                                char(4)            not null,
[ip_descripcion]                           varchar(150)       not null,
[ip_porcentaje]                            float              null,
[ip_debcred]                               char(1)            not null,
[ip_base]                                  money              null

)
go
 
print '-->Tabla: cb_jerararea'
create table cb_jerararea(
                                                              
------------------------------------------ ------------------ ---------
[ja_empresa]                               tinyint            not null,
[ja_area]                                  smallint           null,
[ja_area_padre]                            smallint           null,
[ja_nivel]                                 tinyint            not null

)
go
 
print '-->Tabla: cb_jerarquia'
create table cb_jerarquia(
                                                              
------------------------------------------ ------------------ ---------
[je_empresa]                               tinyint            not null,
[je_oficina]                               smallint           null,
[je_oficina_padre]                         smallint           null,
[je_nivel]                                 tinyint            not null

)
go
 
print '-->Tabla: cb_tran_servicio'
create table cb_tran_servicio(
                                                              
------------------------------------------ ------------------ ---------
[ts_secuencial]                            int                not null,
[ts_tipo_transaccion]                      smallint           not null,
[ts_clase]                                 char(1)            not null,
[ts_fecha]                                 datetime           null,
[ts_usuario]                               login              null,
[ts_terminal]                              descripcion        null,
[ts_correccion]                            char(1)            null,
[ts_ssn_corr]                              int                null,
[ts_reentry]                               char(1)            null,
[ts_origen]                                char(1)            null,
[ts_nodo]                                  varchar(30)        null,
[ts_remoto_ssn]                            int                null,
[ts_oficina]                               smallint           null,
[ts_descripcion]                           descripcion        null,
[ts_tipo_plan]                             char(2)            null,
[ts_estado]                                char(1)            null,
[ts_cuenta]                                cuenta_contable    null,
[ts_movimiento]                            char(1)            null,
[ts_categoria]                             char(10)           null,
[ts_nivel_cuenta]                          tinyint            null,
[ts_longitud]                              smallint           null,
[ts_empresa]                               tinyint            null,
[ts_ruc]                                   char(13)           null,
[ts_replegal]                              descripcion        null,
[ts_contgen]                               descripcion        null,
[ts_moneda]                                tinyint            null,
[ts_usa_cc]                                char(1)            null,
[ts_direccion]                             char(120)          null,
[ts_centro_costo]                          char(16)           null,
[ts_tipo_doc]                              char(10)           null,
[ts_numero_actual]                         smallint           null,
[ts_periodo]                               int                null,
[ts_fecha_ini]                             datetime           null,
[ts_fecha_fin]                             datetime           null,
[ts_corte]                                 int                null,
[ts_comprobante]                           int                null,
[ts_concepto]                              char(255)          null,
[ts_comp_tipo]                             int                null,
[ts_tot_debito]                            money              null,
[ts_tot_credito]                           money              null,
[ts_tot_debito_me]                         money              null,
[ts_tot_credito_me]                        money              null,
[ts_cod_oficina]                           smallint           null,
[ts_oficina_padre]                         smallint           null,
[ts_area]                                  smallint           null,
[ts_departamento]                          tinyint            null,
[ts_proceso]                               int                null,
[ts_ctaasoc]                               cuenta_contable    null,
[ts_causa]                                 char(3)            null,
[ts_ofic_orig]                             smallint           null,
[ts_ofic_dest]                             smallint           null,
[ts_ctadeb]                                cuenta_contable    null,
[ts_ctacre]                                cuenta_contable    null,
[ts_ctadeb_int]                            cuenta_contable    null,
[ts_ctacre_int]                            cuenta_contable    null,
[ts_ctadeb_des]                            cuenta_contable    null,
[ts_ctacre_des]                            cuenta_contable    null,
[ts_tipo_tran]                             smallint           null,
[ts_login]                                 varchar(10)        null,
[ts_asiento]                               smallint           null,
[ts_cuenta_terc]                           cuenta_contable    null,
[ts_base]                                  money              null,
[ts_retencion]                             money              null,
[ts_codigo_conc]                           char(4)            null,
[ts_descripcion_conc]                      varchar(50)        null,
[ts_base_conc]                             money              null,
[ts_porcentaje_conc]                       float              null,
[ts_presupuesto]                           char(1)            null,
[ts_iva]                                   char(1)            null,
[ts_ret]                                   char(1)            null,
[ts_ica]                                   char(1)            null,
[ts_descontado]                            char(1)            null,
[ts_des_porcen]                            float              null,
[ts_ciudad_ica]                            int                null,
[ts_fecha_reg]                             datetime           null,
[ts_valor_dif]                             money              null,
[ts_amort_acum]                            money              null,
[ts_control]                               char(1)            null,
[ts_porc_espec]                            float              null,
[ts_empresa_subsidiaria]                   tinyint            null,
[ts_regimen]                               catalogo           null,
[ts_producto]                              tinyint            null,
[ts_impuesto]                              char(1)            null,
[ts_apl_ofi_orig]                          char(1)            null,
[ts_apl_ofi_dest]                          char(1)            null,
[ts_banco]                                 char(3)            null,
[ts_oper_ent]                              char(4)            null,
[ts_oper_bco]                              char(6)            null,
[ts_operacion]                             char(1)            null

)
go
 
print '-->Tabla: cb_asiento'
create table cb_asiento(
                                                              
------------------------------------------ ------------------ ---------
[as_fecha_tran]                            datetime           not null,
[as_comprobante]                           int                not null,
[as_empresa]                               tinyint            not null,
[as_asiento]                               int                not null,
[as_cuenta]                                cuenta_contable    not null,
[as_oficina_dest]                          smallint           not null,
[as_area_dest]                             smallint           not null,
[as_credito]                               money              null,
[as_debito]                                money              null,
[as_concepto]                              descripcion        null,
[as_credito_me]                            money              null,
[as_debito_me]                             money              null,
[as_cotizacion]                            money              null,
[as_mayorizado]                            char(1)            not null,
[as_tipo_doc]                              char(1)            not null,
[as_tipo_tran]                             char(1)            not null,
[as_moneda]                                tinyint            null,
[as_opcion]                                tinyint            null,
[as_fecha_est]                             datetime           null,
[as_detalle]                               smallint           null,
[as_consolidado]                           char(1)            null,
[as_oficina_orig]                          smallint           not null,
[as_mes_fecha_tran]                        tinyint            null

)
go
 
print '-->Tabla: cb_nivel_area'
create table cb_nivel_area(
                                                              
------------------------------------------ ------------------ ---------
[na_empresa]                               tinyint            not null,
[na_nivel_area]                            tinyint            not null,
[na_descripcion]                           descripcion        not null

)
go
 
print '-->Tabla: cb_comprobante'
create table cb_comprobante(
                                                              
------------------------------------------ ------------------ ---------
[co_comprobante]                           int                not null,
[co_empresa]                               tinyint            not null,
[co_fecha_tran]                            datetime           not null,
[co_oficina_orig]                          smallint           not null,
[co_area_orig]                             smallint           not null,
[co_fecha_dig]                             datetime           not null,
[co_fecha_mod]                             datetime           not null,
[co_digitador]                             descripcion        not null,
[co_descripcion]                           descripcion        null,
[co_mayorizado]                            char(1)            not null,
[co_comp_tipo]                             int                null,
[co_detalles]                              int                not null,
[co_tot_debito]                            money              not null,
[co_tot_credito]                           money              not null,
[co_tot_debito_me]                         money              not null,
[co_tot_credito_me]                        money              not null,
[co_automatico]                            int                null,
[co_reversado]                             char(1)            not null,
[co_autorizado]                            char(1)            not null,
[co_autorizante]                           descripcion        null,
[co_referencia]                            varchar(10)        null,
[co_causa_anula]                           char(2)            null,
[co_tipo_compro]                           char(1)            null,
[co_estado]                                char(1)            null,
[co_traslado]                              char(1)            null,
[co_mes_fecha_tran]                        tinyint            null

)
go
 
print '-->Tabla: cb_nivel_cuenta'
create table cb_nivel_cuenta(
                                                              
------------------------------------------ ------------------ ---------
[nc_empresa]                               tinyint            not null,
[nc_nivel_cuenta]                          tinyint            not null,
[nc_longitud]                              tinyint            not null,
[nc_descripcion]                           descripcion        not null

)
go
 
print '-->Tabla: cb_retencion'
create table cb_retencion(
                                                              
------------------------------------------ ------------------ ---------
[re_comprobante]                           int                not null,
[re_empresa]                               tinyint            not null,
[re_asiento]                               int                not null,
[re_identifica]                            char(13)           null,
[re_tipo]                                  char(2)            null,
[re_ente]                                  int                null,
[re_fecha]                                 datetime           not null,
[re_cuenta]                                cuenta_contable    not null,
[re_concepto]                              char(4)            null,
[re_base]                                  money              null,
[re_valret]                                money              null,
[re_valor_asiento]                         money              null,
[re_valor_iva]                             money              null,
[re_valor_ica]                             money              null,
[re_iva_retenido]                          money              null,
[re_con_iva]                               char(4)            null,
[re_con_iva_reten]                         char(4)            null,
[re_con_timbre]                            char(4)            null,
[re_valor_timbre]                          money              null,
[re_retencion_calculado]                   money              null,
[re_iva_calculado]                         money              null,
[re_ica_calculado]                         money              null,
[re_timbre_calculado]                      money              null,
[re_codigo_regimen]                        char(4)            null,
[re_con_ica]                               char(4)            null,
[re_con_ivapagado]                         char(4)            null,
[re_valor_ivapagado]                       money              null,
[re_ivapagado_calculado]                   money              null,
[re_documento]                             char(24)           null,
[re_oficina_orig]                          smallint           not null,
[re_con_dptales]                           char(4)            null,
[re_valor_dptales]                         money              null

)
go
 
print '-->Tabla: cb_oficina'
create table cb_oficina(
                                                              
------------------------------------------ ------------------ ---------
[of_empresa]                               tinyint            not null,
[of_oficina]                               smallint           not null,
[of_descripcion]                           descripcion        not null,
[of_oficina_padre]                         smallint           null,
[of_estado]                                char(1)            not null,
[of_fecha_estado]                          datetime           null,
[of_organizacion]                          tinyint            not null,
[of_consolida]                             char(1)            not null,
[of_movimiento]                            char(1)            not null,
[of_codigo]                                descripcion        null

)
go
 
print '-->Tabla: cb_organizacion'
create table cb_organizacion(
                                                              
------------------------------------------ ------------------ ---------
[or_empresa]                               tinyint            not null,
[or_organizacion]                          tinyint            not null,
[or_descripcion]                           descripcion        not null

)
go
 
print '-->Tabla: cb_ofi_org'
create table cb_ofi_org(
                                                              
------------------------------------------ ------------------ ---------
[nivel]                                    tinyint            null,
[oficina]                                  smallint           null

)
go

print '-->Tabla: cb_cuentas_tmp'
 
create table cb_cuentas_tmp (    
tmp_secuencia         int         NULL,
tmp_cuenta            varchar(20) NULL,
tmp_estado            char(1)     NULL,
tmp_multiplicador     tinyint     NULL
)
go

print '-->Tabla: cb_depurar'
create table cb_depurar (
cbd_empresa            tinyint        null,
cbd_fecha_tran         datetime       null,
cbd_corte              int            null,
cbd_periodo            int            null,
cbd_term               descripcion    null,
cbd_user               login          null,
cbd_fecha_depura       datetime       null,
cbd_cantidad           int            null,
cbd_comentario         varchar(150)   null 
)
go

print '-->Tabla: cb_parametro'
create table cb_parametro (
pa_empresa                tinyint      not null, 
pa_parametro              varchar(10)  not null,
pa_descripcion            descripcion  not null,
pa_stored                 varchar(20)  not null,
pa_transaccion            int          not null 
)
go

print '-->Tabla: cb_nits_ofi_pag_decl'
if not exists (select 1 from sysobjects where type = 'U' and name = 'cb_nits_ofi_pag_decl') begin
   create table cb_nits_ofi_pag_decl (
   no_ente              int          null,
   no_empresa           tinyint      null,
   no_oficina           smallint     null
   )
end
go

print '-->Tabla: cb_codigo_valor'
CREATE TABLE [dbo].[cb_codigo_valor](
	[cv_empresa] [tinyint] NOT NULL,
	[cv_producto] [tinyint] NOT NULL,
	[cv_codval] [int] NOT NULL,
	[cv_descripcion] [dbo].[descripcion] NULL
) ON [PRIMARY]
GO

print '-->Tabla: cb_tipo_area'
CREATE TABLE [dbo].[cb_tipo_area](
	[ta_empresa] [tinyint] NOT NULL,
	[ta_producto] [tinyint] NOT NULL,
	[ta_tiparea] [varchar](10) NOT NULL,
	[ta_utiliza_valor] [char](1) NOT NULL,
	[ta_area] [smallint] NULL,
	[ta_descripcion] [dbo].[descripcion] NULL,
	[ta_ofi_central] [smallint] NULL
) ON [PRIMARY]

GO

print '-->Tabla: cb_producto'
CREATE TABLE [dbo].[cb_producto](
	[pr_empresa] [tinyint] NOT NULL,
	[pr_producto] [tinyint] NOT NULL,
	[pr_online] [char](1) NOT NULL,
	[pr_estado] [char](1) NOT NULL,
	[pr_resumen] [char](1) NOT NULL,
	[pr_fecha_mod] [datetime] NOT NULL
) ON [PRIMARY]

GO

print '-->Tabla: cb_ctrl_proceso_comp_pag_decl'
CREATE TABLE [dbo].[cb_ctrl_proceso_comp_pag_decl](
	[cp_empresa] [tinyint] NULL,
	[cp_cod_declaracion] [char](2) NULL,
	[cp_fecha_ejec] [datetime] NULL,
	[cp_estado] [char](1) NULL,
	[cp_fecha_comprob] [datetime] NULL,
	[cp_comprobante] [int] NULL,
	[cp_corte] [int] NULL,
	[cp_periodo] [int] NULL,
	[cp_estado_corte] [char](1) NULL,
	[cp_fecha_corte] [datetime] NULL,
	[cp_oficina] [smallint] NULL,
	[cp_fecha_orden] [datetime] NULL
) ON [PRIMARY]

GO

print '-->Tabla: cb_saldo_tmp'
CREATE TABLE [dbo].[cb_saldo_tmp](
	[sp_id] [int] NOT NULL,
	[s_term] [dbo].[descripcion] NULL,
	[cuenta] [dbo].[cuenta] NULL,
	[nombre_cuenta] [char](80) NULL,
	[saldo_mn] [money] NULL,
	[saldo_me] [money] NULL,
	[naturaleza] [char](1) NULL
) ON [PRIMARY]

go

print '-->Tabla: cb_libromov_dia'
create table cb_libromov_dia(
ld_secuencia    int          null,
ld_fecha_tran   datetime     null,
ld_cuenta       varchar(15)  null,
ld_nombre_cta   varchar(100) null,
ld_debito       money        null,
ld_credito      money        null)

go


print '-->Tabla: cb_saldo_may'
CREATE TABLE cb_saldo_may 
(
    sa_secuencial int         IDENTITY,
    sa_spid       int         NULL,
    sa_usuario    [login]     NULL,
    sa_empresa    tinyint     NULL,
    sa_cuenta     varchar(14) NULL,
    sa_oficina    smallint    NULL,
    sa_area       smallint    NULL,
    sa_debito     money       NULL,
    sa_credito    money       NULL,
    sa_debito_me  money       NULL,
    sa_credito_me money       NULL,
    sa_saldo      money       NULL,
    sa_saldo_me   money       NULL,
    sa_saldonm    money       NULL,
    sa_saldonm_me money       NULL
)
go

print '-->Tabla: cb_retencion_tipo'
CREATE TABLE dbo.cb_retencion_tipo
(
    rt_empresa         tinyint           NOT NULL,
    rt_comprobante     int               NOT NULL,
    rt_asiento         int               NOT NULL,
    rt_ente            int               NOT NULL,
    rt_identifica      char(13)          NULL,
    rt_tipo            char(2)           NULL,
    rt_cuenta          [cuenta_contable] NOT NULL,
    rt_concepto        char(4)           NULL,
    rt_base            money             NULL,
    rt_valret          money             NULL,
    rt_valor_asiento   money             NULL,
    rt_valor_iva       money             NULL,
    rt_valor_ica       money             NULL,
    rt_iva_retenido    money             NULL,
    rt_con_iva         char(4)           NULL,
    rt_con_iva_reten   char(4)           NULL,
    rt_con_timbre      char(4)           NULL,
    rt_valor_timbre    money             NULL,
    rt_codigo_regimen  char(4)           NULL,
    rt_con_ica         char(4)           NULL,
    rt_con_ivapagado   char(4)           NULL,
    rt_valor_ivapagado money             NULL
)
go

