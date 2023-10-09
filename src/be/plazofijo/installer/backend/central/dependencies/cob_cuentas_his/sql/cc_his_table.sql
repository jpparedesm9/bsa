/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cuentas_his
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

print '-->Tabla: cc_his_servicio'
if not exists (select 1 from sysobjects where name = 'cc_his_servicio' and type = 'U') begin
   create table cc_his_servicio(
   hs_secuencial                            int                NOT NULL,
   hs_ssn_branch                            int                NULL,
   hs_cod_alterno                           int                NULL,
   hs_tipo_transaccion                      smallint           NOT NULL,
   hs_clase                                 char(3)            NULL,
   hs_tsfecha                               smalldatetime      NOT NULL,
   hs_tabla                                 tinyint            NULL,
   hs_usuario                               descripcion        NULL,
   hs_terminal                              descripcion        NULL,
   hs_correccion                            char(1)            NULL,
   hs_ssn_corr                              int                NULL,
   hs_reentry                               char(1)            NULL,
   hs_origen                                char(1)            NULL,
   hs_nodo                                  varchar(30)        NULL,
   hs_referencia                            varchar(15)        NULL,
   hs_remoto_ssn                            int                NULL,
   hs_cheque_rec                            int                NULL,
   hs_ctacte                                int                NULL,
   hs_cta_banco                             cuenta             NULL,
   hs_filial                                tinyint            NULL,
   hs_oficina                               smallint           NULL,
   hs_oficial                               smallint           NULL,
   hs_fecha_aper                            smalldatetime      NULL,
   hs_cliente                               int                NULL,
   hs_ced_ruc                               numero             NULL,
   hs_estado                                char(1)            NULL,
   hs_direccion_ec                          tinyint            NULL,
   hs_descripcion_ec                        direccion          NULL,
   hs_ciclo                                 char(1)            NULL,
   hs_categoria                             char(1)            NULL,
   hs_producto                              tinyint            NULL,
   hs_tipo                                  char(1)            NULL,
   hs_indicador                             tinyint            NULL,
   hs_moneda                                tinyint            NULL,
   hs_default                               int                NULL,
   hs_tipo_def                              char(1)            NULL,
   hs_rol_ente                              char(1)            NULL,
   hs_tipo_promedio                         char(1)            NULL,
   hs_numero                                smallint           NULL,
   hs_fecha                                 smalldatetime      NULL,
   hs_autorizante                           descripcion        NULL,
   hs_causa                                 varchar(5)         NULL,
   hs_servicio                              varchar(3)         NULL,
   hs_saldo                                 money              NULL,
   hs_fecha_uso                             smalldatetime      NULL,
   hs_monto                                 money              NULL,
   hs_fecha_ven                             smalldatetime      NULL,
   hs_filial_aut                            tinyint            NULL,
   hs_ofi_aut                               smallint           NULL,
   hs_autoriz_aut                           descripcion        NULL,
   hs_filial_anula                          tinyint            NULL,
   hs_ofi_anula                             smallint           NULL,
   hs_autoriz_anula                         descripcion        NULL,
   hs_cheque_desde                          int                NULL,
   hs_cheque_hasta                          int                NULL,
   hs_chequera                              smallint           NULL,
   hs_num_cheques                           smallint           NULL,
   hs_departamento                          smallint           NULL,
   hs_cta_gir                               cuenta             NULL,
   hs_endoso                                int                NULL,
   hs_cod_banco                             char(8)            NULL,
   hs_corresponsal                          char(8)            NULL,
   hs_propietario                           char(8)            NULL,
   hs_carta                                 int                NULL,
   hs_sec_correccion                        int                NULL,
   hs_cheque                                int                NULL,
   hs_cta_banco_dep                         cuenta             NULL,
   hs_oficina_pago                          smallint           NULL,
   hs_contratado                            money              NULL,
   hs_valor                                 money              NULL,
   hs_ocasional                             money              NULL,
   hs_banco                                 smallint           NULL,
   hs_ccontable                             varchar(20)        NULL,
   hs_cta_funcionario                       char(1)            NULL,
   hs_mercantil                             char(1)            NULL,
   hs_cta_asociada                          cuenta             NULL,
   hs_tipocta                               char(1)            NULL,
   hs_fecha_eimp                            smalldatetime      NULL,
   hs_fecha_rimp                            smalldatetime      NULL,
   hs_fecha_rofi                            smalldatetime      NULL,
   hs_tipo_chequera                         varchar(5)         NULL,
   hs_stick_imp                             char(15)           NULL,
   hs_tipo_imp                              char(1)            NULL,
   hs_tarjcred                              varchar(20)        NULL,
   hs_aporte_iess                           money              NULL,
   hs_descuento_iess                        money              NULL,
   hs_fonres_iess                           money              NULL,
   hs_agente                                varchar(30)        NULL,
   hs_nombre                                direccion          NULL,
   hs_vale                                  char(8)            NULL,
   hs_autorizacion                          char(10)           NULL,
   hs_tasa                                  float              NULL,
   hs_estado_eimprenta                      char(1)            NULL,
   hs_oficina_cta                           smallint           NULL,
   hs_hora                                  datetime           NULL,
   hs_estado_corr                           char(1)            NULL,
   hs_contragarantia                        char(12)           NULL,
   hs_tipo_embargo                          char(1)            NULL,
   hs_causa1                                varchar(100)       NULL,
   hs_fondos                                char(1)            NULL,
   hs_liberacion                            datetime           NULL,
   hs_nombre1                               varchar(64)        NULL,
   hs_fecha_vigencia                        datetime           NULL,
   hs_prx_fecha_proc                        datetime           NULL,
   hs_error                                 varchar(64)        NULL,
   hs_producto1                             char(3)            NULL,
   hs_convenio                              int                NULL,
   hs_codigo_cta                            char(5)            NULL,
   hs_credito                               varchar(16)        NULL,
   hs_deposito                              money              NULL,
   hs_clase_clte                            char(1)            NULL,
   hs_prod_banc                             tinyint            NULL,
   hs_tarj_debito                           varchar(24)        NULL,
   hs_negociada                             char(1)            NULL,
   hs_oficio                                varchar(8)         NULL,
   hs_oficio_lev                            varchar(8)         NULL,
   hs_lim_sobregiro                         tinyint            NULL,
   hs_tgarantia                             char(1)            NULL,
   hs_tipo_sobregiro                        char(1)            NULL,
   hs_tipo_dias_sob                         char(2)            NULL,
   hs_nxmil                                 char(1)            NULL,
   hs_efectivo                              money              NULL,
   hs_canal                                 smallint           NULL,
   hs_calificacion                          char(1)            NULL,
   hs_tctahabiente                          char(2)            NULL)
end
go

print ''
print 'Fin Ejecucion Creacion de Tablas de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''