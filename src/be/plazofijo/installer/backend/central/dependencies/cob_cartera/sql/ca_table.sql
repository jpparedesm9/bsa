/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cartera
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE TABLAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tabla: ca_desembolso'
if not exists (select 1 from sysobjects where name = 'ca_desembolso' and type = 'U') begin
   create table ca_desembolso(
   dm_secuencial                            int                not null,
   dm_operacion                             int                not null,
   dm_desembolso                            tinyint            not null,
   dm_producto                              catalogo           not null,
   dm_cuenta                                cuenta             null,
   dm_beneficiario                          descripcion        null,
   dm_oficina_chg                           smallint           null,
   dm_usuario                               login              not null,
   dm_oficina                               smallint           not null,
   dm_terminal                              descripcion        not null,
   dm_dividendo                             smallint           not null,
   dm_moneda                                tinyint            not null,
   dm_monto_mds                             money              not null,
   dm_monto_mop                             money              not null,
   dm_monto_mn                              money              not null,
   dm_cotizacion_mds                        float              not null,
   dm_cotizacion_mop                        float              not null,
   dm_tcotizacion_mds                       char(1)            not null,
   dm_tcotizacion_mop                       char(1)            not null,
   dm_estado                                char(3)            not null,
   dm_cod_banco                             int                null,
   dm_cheque                                int                null,
   dm_fecha                                 datetime           null,
   dm_prenotificacion                       int                null,
   dm_carga                                 int                null,
   dm_concepto                              varchar(255)       null,
   dm_valor                                 money              null,
   dm_ente_benef                            int                null,
   dm_idlote                                int                null,
   dm_pagado                                char(1)            null,
   dm_orden_caja                            int                null,
   dm_cruce_restrictivo                     char(1)            null,
   dm_destino_economico                     char(1)            null,
   dm_carta_autorizacion                    char(1)            null)
end
go

print '-->Tabla: ca_operacion'
if not exists (select 1 from sysobjects where name = 'ca_operacion' and type = 'U') begin
   create table ca_operacion(
   op_operacion                             int                not null,
   op_banco                                 cuenta             not null,
   op_anterior                              cuenta             null,
   op_migrada                               cuenta             null,
   op_tramite                               int                null,
   op_cliente                               int                null,
   op_nombre                                descripcion        null,
   op_sector                                catalogo           not null,
   op_toperacion                            catalogo           not null,
   op_oficina                               smallint           not null,
   op_moneda                                tinyint            not null,
   op_comentario                            varchar(255)       null,
   op_oficial                               smallint           not null,
   op_fecha_ini                             datetime           not null,
   op_fecha_fin                             datetime           not null,
   op_fecha_ult_proceso                     datetime           not null,
   op_fecha_liq                             datetime           null,
   op_fecha_reajuste                        datetime           null,
   op_monto                                 money              not null,
   op_monto_aprobado                        money              not null,
   op_destino                               catalogo           not null,
   op_lin_credito                           cuenta             null,
   op_ciudad                                int                not null,
   op_estado                                tinyint            not null,
   op_periodo_reajuste                      smallint           null,
   op_reajuste_especial                     char(1)            null,
   op_tipo                                  char(1)            not null,
   op_forma_pago                            catalogo           null,
   op_cuenta                                cuenta             null,
   op_dias_anio                             smallint           not null,
   op_tipo_amortizacion                     varchar(10)        not null,
   op_cuota_completa                        char(1)            not null,
   op_tipo_cobro                            char(1)            not null,
   op_tipo_reduccion                        char(1)            not null,
   op_aceptar_anticipos                     char(1)            not null,
   op_precancelacion                        char(1)            not null,
   op_tipo_aplicacion                       char(1)            not null,
   op_tplazo                                catalogo           null,
   op_plazo                                 smallint           null,
   op_tdividendo                            catalogo           null,
   op_periodo_cap                           smallint           null,
   op_periodo_int                           smallint           null,
   op_dist_gracia                           char(1)            null,
   op_gracia_cap                            smallint           null,
   op_gracia_int                            smallint           null,
   op_dia_fijo                              tinyint            null,
   op_cuota                                 money              null,
   op_evitar_feriados                       char(1)            null,
   op_num_renovacion                        tinyint            null,
   op_renovacion                            char(1)            null,
   op_mes_gracia                            tinyint            not null,
   op_reajustable                           char(1)            not null,
   op_dias_clausula                         int                not null,
   op_divcap_original                       smallint           null,
   op_clausula_aplicada                     char(1)            null,
   op_traslado_ingresos                     char(1)            null,
   op_periodo_crecimiento                   smallint           null,
   op_tasa_crecimiento                      float              null,
   op_direccion                             tinyint            null,
   op_opcion_cap                            char(1)            null,
   op_tasa_cap                              float              null,
   op_dividendo_cap                         smallint           null,
   op_clase                                 catalogo           not null,
   op_origen_fondos                         catalogo           null,
   op_calificacion                          char(1)            null,
   op_estado_cobranza                       catalogo           null,
   op_numero_reest                          int                not null,
   op_edad                                  int                null,
   op_tipo_crecimiento                      char(1)            null,
   op_base_calculo                          char(1)            null,
   op_prd_cobis                             tinyint            null,
   op_ref_exterior                          cuenta             null,
   op_sujeta_nego                           char(1)            null,
   op_dia_habil                             char(1)            null,
   op_recalcular_plazo                      char(1)            null,
   op_usar_tequivalente                     char(1)            null,
   op_fondos_propios                        char(1)            not null,
   op_nro_red                               varchar(24)        null,
   op_tipo_redondeo                         tinyint            null,
   op_sal_pro_pon                           money              null,
   op_tipo_empresa                          catalogo           null,
   op_validacion                            catalogo           null,
   op_fecha_pri_cuot                        datetime           null,
   op_gar_admisible                         char(1)            null,
   op_causacion                             char(1)            null,
   op_convierte_tasa                        char(1)            null,
   op_grupo_fact                            int                null,
   op_tramite_ficticio                      int                null,
   op_tipo_linea                            catalogo           null,
   op_subtipo_linea                         catalogo           null,
   op_bvirtual                              char(1)            null,
   op_extracto                              char(1)            null,
   op_num_deuda_ext                         cuenta             null,
   op_fecha_embarque                        datetime           null,
   op_fecha_dex                             datetime           null,
   op_reestructuracion                      char(1)            null,
   op_tipo_cambio                           char(1)            null,
   op_naturaleza                            char(1)            null,
   op_pago_caja                             char(1)            null,
   op_nace_vencida                          char(1)            null,
   op_num_comex                             cuenta             null,
   op_calcula_devolucion                    char(1)            null,
   op_codigo_externo                        cuenta             null,
   op_margen_redescuento                    float              null,
   op_entidad_convenio                      catalogo           null,
   op_pproductor                            char(1)            null,
   op_fecha_ult_causacion                   datetime           null,
   op_mora_retroactiva                      char(1)            null,
   op_calificacion_ant                      char(1)            null,
   op_cap_susxcor                           money              null,
   op_prepago_desde_lavigente               char(1)            null,
   op_fecha_ult_mov                         datetime           null,
   op_fecha_prox_segven                     datetime           null,
   op_suspendio                             char(1)            null,
   op_fecha_suspenso                        datetime           null,
   op_honorarios_cobranza                   char(1)            null,
   op_banca                                 catalogo           null)
end
go

print '-->Tabla: ca_estado'
if not exists (select 1 from sysobjects where name = 'ca_estado' and type = 'U') begin
   create table ca_estado(
   es_codigo                                tinyint            not null,
   es_descripcion                           descripcion        not null,
   es_procesa                               char(1)            not null,
   es_acepta_pago                           char(1)            null)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''