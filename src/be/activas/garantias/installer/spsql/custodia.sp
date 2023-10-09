/************************************************************************/
/*  Archivo:            custodia.sp                                     */
/*  Stored procedure:   sp_custodia                                     */
/*  Base de datos:      cob_custodia                                    */
/*  Producto:           Custodia                                        */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA".                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Procedimiento que genera el secuenciales para transacciones de      */
/*      servicio tomando como parametro la garantia.                    */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_custodia')
    drop proc sp_custodia
go

create proc sp_custodia (
   @s_ssn                       int          = null,
   @s_date                      datetime     = null,
   @s_user                      login        = null,
   @s_term                      varchar(64)  = null,
   @s_corr                      char(1)      = null,
   @s_ssn_corr                  int          = null,
   @s_ofi                       smallint     = null,
   @s_srv                       varchar(30)  = null,
   @s_lsrv                      varchar(30)  = null,
   @t_rty                       char(1)      = null,
   @t_from                      varchar(30)  = null,
   @t_trn                       smallint     = null,
   @i_operacion                 char(1)      = null,
   @i_filial                    tinyint      = null,
   @i_sucursal                  int          = null,
   @i_tipo                      varchar(64)  = null,
   @i_custodia                  int          = null,
   @i_propuesta                 int          = null,
   @i_estado                    catalogo     = null,
   @i_fecha_ingreso             datetime     = null,
   @i_valor_inicial             float        = null,
   @i_valor_actual              float        = null,
   @i_moneda                    tinyint      = null,
   @i_garante                   int          = null,
   @i_instruccion               varchar(255) = null,
   @i_descripcion               varchar(255) = null,
   @i_poliza                    varchar( 20) = null,
   @i_inspeccionar              char(  1)    = null,
   @i_motivo_noinsp             catalogo     = null,
   @i_suficiencia_legal         char(1)      = null,
   @i_fuente_valor              catalogo     = null,
   @i_situacion                 char(  1)    = null,
   @i_almacenera                smallint     = null,
   @i_aseguradora               varchar(20)  = null,
   @i_tipo_cta                  varchar(8)   = null,
   @i_cta_inspeccion            ctacliente   = null,
   @i_direccion_prenda          varchar(255) = null,
   @i_ciudad_prenda             int          = null,
   @i_telefono_prenda           varchar( 20) = null,
   @i_mex_prx_inspec            tinyint      = null,
   @i_fecha_modif               datetime     = null,
   @i_fecha_const               datetime     = null,
   @i_porcentaje_valor          float        = null,
   @i_formato_fecha             int          = null,
   @i_periodicidad              catalogo     = null,
   @i_depositario               varchar(255) = null,
   @i_posee_poliza              char(1)      = null,
   @i_parte                     tinyint      = null,
   @i_cobranza_judicial         char(1)      = null,
   @i_fecha_retiro              datetime     = null,
   @i_fecha_devolucion          datetime     = null,
   @i_estado_poliza             catalogo     = null,
   @i_cobrar_comision           char(1)      = null,
   @i_codigo_compuesto          varchar(64)  = null,
   @i_compuesto                 varchar(64)  = null,
   @i_cuenta_dpf                varchar(30)  = null,
   @i_cliente                   int          = null,
   @i_ente                      int          = null,
   @i_abierta_cerrada           char(1)      = null,
   @i_adecuada_noadec           char(1)      = null,
   @i_propietario               varchar(64)  = null,
   @i_fsalida_colateral         datetime     = null,
   @i_fretorno_colateral        datetime     = null,
   @i_eliminarcliente           char(1)      = null,
   @i_login                     login        = null,
   @i_plazo_fijo                varchar(30)  = null,
   @i_monto_pfijo               money        = null,
   @i_det_cliente               char(1)      = null,
   @i_oficina_contabiliza       smallint     = null,
   @i_compartida                char(1)      = null,
   @i_valor_compartida          money        = null,
   @i_valor_cobertura           float        = null,
   @i_num_acciones              int          = null,
   @i_valor_accion              money        = null,
   @i_cdt                       char(1)      = null,
   @i_num_banco                 cuenta       = null,
   @i_producto                  varchar(40)  = null,
   @i_valor                     money        = null,
   @i_vlr_cuantia               money        = null,
   @i_tasa                      float        = null,
   @i_spread                    float        = 0,
   @i_observacion               descripcion  = null,
   @i_fecha_pignora             datetime     = null,
   @i_ubicacion                 catalogo     = null,
   @i_entidad                   int          = null,
   @i_fecha_comp                datetime     = null,
   @i_grado_comp                tinyint      = null,
   @i_porcentaje_comp           float        = null,
   @i_cuantia                   char(1)      = null,
   @i_num_dcto                  varchar(14)  = null,
   @i_valor_refer_comis         money        = null,
   @i_entidad_esp               catalogo     = null,
   @i_fecha_sol_rec             datetime     = null,
   @i_fecha_sol_ren             datetime     = null,
   @i_fec_impred                datetime     = null,
   @i_directo                   char(1)      = null,
   @i_licencia                  varchar(20)  = null,
   @i_fecha_vcto                datetime     = null,
   @i_fecha_aval                datetime     = null,
   @i_fec_venci                 datetime     = null,
   @i_porcentaje_cobertura      float        = null,
   @i_valor_cuantia             money        = null,
   @i_entidad_emisora           int          = null,
   @i_fuente_valor_accion       catalogo     = null,
   @i_fecha_accion              datetime     = null,
   @i_valor_comision            money        = null,
   @i_tipo_superior             varchar(64)  = null,
   @o_num_banco                 varchar(30)  = null out,
   @o_cuenta_dpf                varchar(30)  = null out,
   @o_codigo_externo            varchar(64)  = null out,
   @i_grado_gar                 catalogo     = null,
   @i_provisiona                char         = null,
   @i_fnro_documento            varchar(16)  = null,
   @i_fvalor_bruto              money        = null,
   @i_fanticipos                money        = null,
   @i_fpor_impuestos            float        = null,
   @i_fpor_retencion            float        = null,
   @i_fvalor_neto               money        = null,
   @i_ffecha_emision            datetime     = null,
   @i_ffecha_vtodoc             datetime     = null,
   @i_ffecha_inineg             datetime     = null,
   @i_ffecha_vtoneg             datetime     = null,
   @i_ffecha_pago               datetime     = null,
   @i_fbase_calculo             catalogo     = null,
   @i_fdias_negocio             int          = null,
   @i_fnum_dex                  varchar(16)  = null,
   @i_ffecha_dex                datetime     = null,
   @i_fproveedor                int          = null,
   @i_fcomprador                int          = null,
   @i_fresp_pago                int          = null,
   @i_fresp_dscto               int          = null,
   @i_ftasa                     float        = null,
   @i_disponible                float        = null,
   @i_codigo_externo            varchar(64)  = null,
   @i_siniestro                 char(1)      = null,
   @i_castigo                   char(1)      = null,
   @i_agotada                   char(1)      = null,
   @i_clase_custodia            char(1)      = null,
   @i_origen                    char(3)      = null,
   @i_fecha_sol_exp             datetime     = null,
   @i_fecha_apr_pre             datetime     = null,
   @i_fecha_apr                 datetime     = null,
   @i_fecha_pro                 datetime     = null,
   @i_num_acta_apr_pre          varchar(64)  = null,
   @i_num_acta_apr              varchar(64)  = null,
   @i_clase_vehiculo            varchar(10)  = null,
   @i_oficial                   smallint     = null,
   @i_ofi_ing                   smallint     = null,
   @i_cuenta                    varchar(15)  = null,
   @i_carta_instruccion         char(1)      = null,
   @i_nomcliente                varchar(64)  = null,
   @i_principal                 char(1)      = null,
   @i_tipo_garante              catalogo     = null,
   @i_opcion                    char(1)      = 'C',
   @i_expedido                  char(1)      = null,
   @i_causa_nexp                catalogo     = null,
   @i_ciudad_gar                int          = null,
   @i_valor_original            float        = null,
   @i_tramite                   int          = null,
   @o_cod_custodia              varchar(254) = null out,
   @i_grupal                    char(1)      = 'N')


as
declare
   @w_today                     datetime,
   @w_return                    int,
   @w_retorno                   int,
   @w_sp_name                   varchar(32),
   @w_existe                    tinyint,
   @w_filial                    tinyint,
   @w_sucursal                  smallint,
   @w_tipo                      varchar(64),
   @w_custodia                  int,
   @w_propuesta                 int,
   @w_num_inspecc               tinyint,
   @w_estado                    catalogo,
   @w_fecha_ingreso             datetime,
   @w_valor_inicial             money,
   @w_valor_actual              money,
   @w_moneda                    tinyint,
   @w_garante                   int,
   @w_codoficial                int,
   @w_instruccion               varchar(255),
   @w_descripcion               varchar(255),
   @w_poliza                    varchar( 20),
   @w_inspeccionar              char(  1),
   @w_fuente_valor              catalogo,
   @w_situacion                 char(  1),
   @w_almacenera                smallint,
   @w_aseguradora               varchar( 20),
   @w_cta_inspeccion            ctacliente,
   @w_direccion_prenda          varchar(255),
   @w_ciudad_prenda             int,
   @w_telefono_prenda           varchar( 20),
   @w_mex_prx_inspec            tinyint,
   @w_fecha_modif               datetime,
   @w_fecha_const               datetime,
   @w_porcentaje_valor          float,
   @w_suficiencia_legal         char(1),
   @w_motivo_noinsp             catalogo,
   @w_des_est_custodia          varchar(64),
   @w_des_fuente_valor          varchar(64),
   @w_des_motivo_noinsp         varchar(20),
   @w_des_inspeccionar          varchar(64),
   @w_des_tipo                  varchar(64),
   @w_des_moneda                varchar(30),
   @w_periodicidad              catalogo,
   @w_des_periodicidad          catalogo,
   @w_depositario               varchar(255),
   @w_estado_aux                catalogo,
   @w_posee_poliza              char(1),
   @w_des_garante               varchar(64),
   @w_des_almacenera            varchar(64),
   @w_des_aseguradora           varchar(64),
   @w_valor_intervalo           smallint,
   @w_error                     int,
   @w_cobranza_judicial         char(1),
   @w_contabilizar              char(1),
   @w_fecha_retiro              datetime,
   @w_fecha_devolucion          datetime,
   @w_fecha_modificacion        datetime,
   @w_usuario_crea              login,
   @w_usuario_modifica          login,
   @w_estado_poliza             catalogo,
   @w_des_estado_poliza         varchar(64),
   @w_cobrar_comision           char(1),
   @w_abr_cer                   char(1),
   @w_status                    int,
   @w_perfil                    varchar(10),
   @w_tipo_cta                  varchar(8),
   @w_abierta_aux               char(1),
   @w_valor_conta               money,
   @w_cuenta_dpf                varchar(30),
   @w_cliente                   int,
   @w_des_cliente               varchar(64),
   @w_nro_cliente               tinyint,
   @w_ente                      int,
   @w_codigo_externo            varchar(64),
   @w_codigo_ext                varchar(64),
   @w_abierta_cerrada           char(1),
   @w_riesgos                   char(1),
   @w_adecuada_noadec           char(1),
   @w_oficial                   varchar(64),
   @w_propietario               varchar(64),
   @w_fsalida_colateral         datetime,
   @w_fretorno_colateral        datetime,
   @w_plazo_fijo                varchar(30),
   @w_monto_pfijo               money,
   @w_oficina                   int,
   @w_oficina_contabiliza       int,
   @w_des_oficina               varchar(64),
   @w_compartida                char(1),
   @w_valor_compartida          money,
   @w_fecha_avaluo              datetime,
   @w_fecha_reg                 datetime,
   @w_fecha_prox_insp           datetime,
   @w_contabiliza               char(1) ,
   @w_perfil1                   char(1) ,
   @w_sector                    char(1),
   @w_valor_cobertura           float,
   @w_num_acciones              int,
   @w_valor_accion              money,
   @w_aux                       char(30) ,
   @w_des_adecuada              descripcion,
   @w_des_grado                 descripcion,
   @w_cuenta_inspeccion         ctacliente ,
   @w_ubicacion                 catalogo,
   @w_des_ubicacion             varchar(64),
   @w_tipogarante               catalogo,
   @w_des_tipogarante           varchar(64),
   @w_des_entidad               varchar(64),
   @w_des_entidad_esp           varchar(64),
   @w_entidad                   int,
   @w_fecha_comp                datetime,
   @w_grado_comp                tinyint,
   @w_grado_gar                 catalogo,
   @w_porcentaje_comp           float,
   @w_cuantia                   char(1),
   @w_vlr_cuantia               money,
   @w_num_dcto                  varchar(13),
   @w_valor_refer_comis         money,
   @w_entidad_esp               varchar(10),
   @w_fecha_sol_rec             datetime,
   @w_fecha_sol_ren             datetime,
   @w_fec_impred                datetime,
   @w_secservicio               int,
   @w_directo                   char(1),
   @w_des_ciudad_prenda         varchar(64),
   @w_licencia                  varchar(20),
   @w_fecha_vcto                datetime,
   @w_fec_venci                 datetime,
   @w_fecha_aval                datetime,
   @w_porcentaje_cobertura      float,
   @w_entidad_emisora           int,
   @w_fuente_valor_emisora      catalogo,
   @w_desc_entidad_emisora      descripcion,
   @w_desc_fuente_emisora       descripcion,
   @w_fecha_accion              datetime,
   @w_gquir                     varchar(64),
   @w_valor_comision            money,
   @w_recupera                  float,
   @w_dif_valor                 money,
   @w_debcred                   char(1),
   @w_nuevo_comercial           money,
   @w_jre                       char(2),
   @w_t_garante                 char(1),
   @w_n_garante                 descripcion,
   @w_provisiona                char,
   @w_fnro_documento            varchar(16),
   @w_fvalor_bruto              money,
   @w_fanticipos                money,
   @w_fpor_impuestos            float,
   @w_fpor_retencion            float,
   @w_fvalor_neto               money,
   @w_ffecha_emision            datetime,
   @w_ffecha_vtodoc             datetime,
   @w_ffecha_inineg             datetime,
   @w_ffecha_vtoneg             datetime,
   @w_ffecha_pago               datetime,
   @w_fbase_calculo             catalogo,
   @w_fdias_negocio             int,
   @w_fnum_dex                  varchar(16),
   @w_ffecha_dex                datetime,
   @w_fproveedor                int,
   @w_fcomprador                int,
   @w_fresp_pago                int,
   @w_fresp_dscto               int,
   @w_ftasa                     float,
   @w_des_base_calculo          catalogo,
   @w_nom_proveedor             varchar(64),
   @w_nom_comprador             varchar(64),
   @w_nom_pago                  varchar(64),
   @w_nom_descuento             varchar(64),
   @w_tipo_superior             varchar(64),
   @w_siniestro                 char(1),
   @w_castigo                   char(1),
   @w_agotada                   char(1),
   @w_clase_custodia            char(1),
   @w_des_clase                 descripcion,
   @w_fecha_sol_exp             datetime,
   @w_fecha_apr_pre             datetime,
   @w_fecha_apr                datetime,
   @w_fecha_pro                 datetime,
   @w_num_acta_apr_pre          varchar(64),
   @w_num_acta_apr              varchar(64),
   @w_clase_vehiculo            varchar(10),
   @w_des_clase_vehiculo        varchar(64),
   @w_acum_ajuste               money,
   @w_maximo                    smallint,
   @w_secuencial                int,
   @w_hora                      varchar(8),
   @w_pid_cus                   int,
   @w_expedido                  char(1),
   @w_causa_nexp                catalogo,
   @w_des_nexpedido             descripcion,
   @w_ciudad_gar                int,
   @w_des_ciudad_gar            descripcion,
   @w_stanby                    catalogo,
   @w_existe_tc_tipo_superior   int,
   @w_existe_tc_tipo            int,
   @w_existe1                   int,
   @w_valor_original            float,
   @w_conta                     tinyint,
   @w_itemcust                  smallint,
   @w_es_cobreg                 char(1),
   @w_fag                       varchar(10),
   @w_tipo_tr                   char(1),
   @w_cod_gar_fng_banca         catalogo,
   @w_pro_ciudad                varchar(10),
   @w_num_banco                 cuenta


select  @w_today   = convert(varchar(10),@s_date,101),@w_hora    = convert(varchar(8),getdate(),108),
        @w_sp_name = 'sp_custodia',@s_ofi     = isnull(@i_ofi_ing,@s_ofi),
        @i_ofi_ing = isnull(@i_ofi_ing,@s_ofi), @w_pid_cus = @@spid * 100
        
-- Parametro FAG        
select @w_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CODFAG'        

select tipo = tc_tipo
into #fag
from cu_tipo_custodia
where tc_tipo_superior = @w_fag

/* PARA EVITAR ERRORES DE FORMATO O SINCRONIZACION
LA FECHA DE INGRESO SERA SIEMPRE LA DEL SISTEMA */


-- Ubicar garantia BANCA NUEVAS OPORTUNIDADES 036
select @w_cod_gar_fng_banca = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODOPO'

select @w_tipo_tr = tr_tipo
from	cob_credito..cr_tramite
where   tr_tramite = @i_tramite


if  @i_tipo = @w_cod_gar_fng_banca and @w_tipo_tr in (select codigo_sib from cob_credito..cr_corresp_sib where tabla = 'T147')
begin
  print ' Tipo de Ruta no permite la creacion de Garantia Automatica '
  exec cobis..sp_cerror
  @t_from  = @w_sp_name,
  @i_num   = 143051
  return     143051
end

if @i_operacion = 'I' select  @i_fecha_ingreso = @s_date

if @i_operacion is not null or @i_operacion <> ''
begin
   if @i_periodicidad is not null
   begin
      select @w_valor_intervalo = td_factor
      from   cob_cartera..ca_tdividendo
      where  td_tdividendo      = @i_periodicidad
      if @@rowcount =0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return     1901003
      end
   end
   if @i_codigo_compuesto is not null
   begin
      exec sp_compuesto
      @t_trn = 19245,
      @i_operacion = 'Q',
      @i_compuesto = @i_codigo_compuesto,
      @o_filial    = @i_filial out,
      @o_sucursal  = @i_sucursal out,
      @o_tipo      = @i_tipo out,
      @o_custodia  = @i_custodia out
   end
   select
      @w_filial                 = cu_filial,
      @w_sucursal               = cu_sucursal,
      @w_tipo                   = cu_tipo,
      @w_custodia               = cu_custodia,
      @w_oficina                = cu_oficina,
      @w_propuesta              = cu_propuesta,
      @w_estado                 = cu_estado,
      @w_motivo_noinsp          = cu_motivo_noinsp,
      @w_fecha_ingreso          = convert(char(10),cu_fecha_ingreso,101),
      @w_valor_inicial          = cu_valor_inicial,
      @w_valor_actual           = cu_valor_actual,
      @w_moneda                 = cu_moneda,
      @w_garante                = cu_garante,
      @w_instruccion            = cu_instruccion,
      @w_descripcion            = cu_descripcion,
      @w_poliza                 = cu_poliza,
      @w_inspeccionar           = cu_inspeccionar,
      @w_motivo_noinsp          = cu_motivo_noinsp,
      @w_suficiencia_legal      = cu_suficiencia_legal,
      @w_fuente_valor           = cu_fuente_valor,
      @w_situacion              = cu_situacion,
      @w_almacenera             = cu_almacenera,
      @w_aseguradora            = cu_aseguradora,
      @w_cta_inspeccion         = cu_cta_inspeccion,
      @w_tipo_cta               = cu_tipo_cta ,
      @w_direccion_prenda       = cu_direccion_prenda,
      @w_ciudad_prenda          = cu_ciudad_prenda,
      @w_telefono_prenda        = cu_telefono_prenda,
      @w_mex_prx_inspec         = cu_mex_prx_inspec,
      @w_fecha_modif            = cu_fecha_modif,
      @w_fecha_const            = cu_fecha_const,
      @w_porcentaje_valor       = cu_porcentaje_valor,
      @w_periodicidad           = cu_periodicidad,
      @w_depositario            = cu_depositario,
      @w_posee_poliza           = cu_posee_poliza,
      @w_cobranza_judicial      = cu_cobranza_judicial,
      @w_fecha_retiro           = cu_fecha_retiro,
      @w_fecha_devolucion       = cu_fecha_devolucion,
      @w_fecha_modificacion     = cu_fecha_modificacion,
      @w_usuario_crea           = cu_usuario_crea,
      @w_usuario_modifica       = cu_usuario_modifica,
      @w_estado_poliza          = cu_estado_poliza,
      @w_cobrar_comision        = cu_cobrar_comision,
      @w_cuenta_dpf             = cu_cuenta_dpf,
      @w_abierta_cerrada        = cu_abierta_cerrada,
      @w_adecuada_noadec        = cu_adecuada_noadec,
      @w_codigo_externo         = cu_codigo_externo,
      @w_propietario            = cu_propietario,
      @w_plazo_fijo             = cu_plazo_fijo,
      @w_monto_pfijo            = cu_monto_pfijo,
      @w_oficina_contabiliza    = cu_oficina_contabiliza,
      @w_compartida             = cu_compartida,
      @w_valor_compartida       = cu_valor_compartida,
      @w_fecha_avaluo           = cu_fecha_insp,
      @w_fecha_reg              = cu_fecha_reg,
      @w_fecha_prox_insp        = cu_fecha_prox_insp,
      @w_valor_cobertura        = cu_valor_cobertura,
      @w_num_acciones           = cu_num_acciones,
      @w_valor_accion           = cu_valor_accion,
      @w_ubicacion              = cu_ubicacion,
      @w_porcentaje_comp        = cu_porcentaje_comp,
      @w_cuantia                = cu_cuantia,
      @w_vlr_cuantia            = cu_vlr_cuantia,
      @w_num_dcto               = cu_num_dcto,
      @w_valor_refer_comis      = cu_valor_refer_comis,
      @w_entidad_esp            = cu_entidad_esp,
      @w_fecha_sol_rec          = cu_fecha_desde,
      @w_fecha_sol_ren          = cu_fecha_hasta,
      @w_fec_impred             = cu_fecha_impred,
      @w_directo                = cu_clase_cartera,
      @w_licencia               = cu_licencia,
      @w_fecha_vcto             = cu_fecha_vcto,
      @w_fecha_aval             = cu_fecha_avaluo,
      @w_fec_venci              = cu_fecha_vencimiento,
      @w_porcentaje_cobertura   = cu_porcentaje_cobertura,
      @w_entidad_emisora        = cu_entidad_emisora,
      @w_fuente_valor_emisora   = cu_fuente_valor_accion,
      @w_fecha_accion           = cu_fecha_accion,
      @w_valor_comision         = cu_valor_comision,
      @w_grado_gar              = cu_grado_gar,
      @w_provisiona             = cu_provisiona,
      @w_fnro_documento         = cu_fnro_documento,
      @w_fvalor_bruto           = cu_fvalor_bruto,
      @w_fanticipos             = cu_fanticipos,
      @w_fpor_impuestos         = cu_fpor_impuestos,
      @w_fpor_retencion         = cu_fpor_retencion,
      @w_fvalor_neto            = cu_fvalor_neto,
      @w_ffecha_emision         = cu_ffecha_emision,
      @w_ffecha_vtodoc          = cu_ffecha_vtodoc,
      @w_ffecha_inineg          = cu_ffecha_inineg,
      @w_ffecha_vtoneg          = cu_ffecha_vtoneg,
      @w_ffecha_pago            = cu_ffecha_pago,
      @w_fbase_calculo          = cu_fbase_calculo,
      @w_fdias_negocio          = cu_fdias_negocio,
      @w_fnum_dex               = cu_fnum_dex,
      @w_ffecha_dex   = cu_ffecha_dex,
      @w_fproveedor             = cu_fproveedor,
      @w_fcomprador             = cu_fcomprador,
      @w_fresp_pago             = cu_fresp_pago,
      @w_fresp_dscto            = cu_fresp_dscto,
      @w_ftasa                  = cu_ftasa,
      @w_siniestro              = cu_siniestro,
      @w_castigo                = cu_castigo ,
      @w_agotada                = cu_agotada,
      @w_clase_custodia         = cu_clase_custodia,
      @w_fecha_sol_exp          = cu_fecha_sol_exp,
      @w_fecha_apr_pre          = cu_fecha_apr_pre,
      @w_fecha_apr              = cu_fecha_apr,
      @w_fecha_sol_rec          = cu_fecha_sol_rec,
      @w_fecha_sol_ren          = cu_fecha_sol_ren,
      @w_fecha_pro              = cu_fecha_pro,
      @w_num_acta_apr_pre       = cu_num_acta_apr_pre,
      @w_num_acta_apr           = cu_num_acta_apr,
      @w_clase_vehiculo         = cu_clase_vehiculo,
      @w_acum_ajuste            = cu_acum_ajuste,
      @w_expedido               = cu_expedido,
      @w_causa_nexp             = cu_causa_nexp,
      @w_ciudad_gar             = cu_ciudad_gar,
      @w_des_est_custodia = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_est_custodia'
      and    A.codigo = C.cu_estado),

      @w_des_fuente_valor = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_fuente_valor'
      and    A.codigo = C.cu_fuente_valor),

      @w_des_estado_poliza = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    A.codigo = C.cu_estado_poliza
      and    B.tabla = 'cu_estado_poliza'),

      @w_des_ubicacion = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_ubicacion_doc'
      and    A.codigo = C.cu_ubicacion),

      @w_des_aseguradora = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_aseguradora'
      and    A.codigo = C.cu_aseguradora),

      @w_des_entidad_esp = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_entidad_garantias'
      and    A.codigo = C.cu_entidad_esp),

      @w_des_base_calculo = (select A.valor
      from   cobis..cl_catalogo A,
             cobis..cl_tabla B
      where  B.codigo = A.tabla
      and    B.tabla  = 'cu_base_calculo'
      and    A.codigo = C.cu_fbase_calculo),

      @w_des_grado = (select A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_grado_gtia'
      and A.codigo = C.cu_grado_gar),

      @w_desc_fuente_emisora = (select A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_fuente_valor'
      and A.codigo = C.cu_fuente_valor_accion),

      @w_des_clase = (select A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_clase_custodia'
      and A.codigo = C.cu_clase_custodia),

      @w_des_nexpedido = (select A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_causal_nexp'
      and A.codigo = C.cu_causa_nexp),
      @w_valor_original      = cu_valor_original,
      @w_num_banco           = cu_cuenta_hold
   from   cob_custodia..cu_custodia C
   where  cu_filial       = @i_filial
   and    cu_sucursal     = @i_sucursal
   and    cu_tipo         = @i_tipo
   and    cu_custodia     = @i_custodia
   
   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
      
      
end

if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'P')
begin
   if (@i_filial is NULL or @i_sucursal is NULL or @i_tipo is NULL)
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1901001
   end
end

if @i_operacion = 'I'
begin

   if exists (  select  1
   from    cob_custodia..cu_tipo_custodia
   where   tc_tipo     = @i_tipo
   and     tc_clase    = 'O')
   begin
      select    
      @i_valor_inicial    = 1,
      @i_valor_actual     = 1,
      @i_valor_original   = 1
   end 

   select
   @i_porcentaje_cobertura = isnull(@i_porcentaje_cobertura, 0),
   @i_valor_inicial        = isnull(@i_valor_inicial , 0),
   @i_valor_actual         = isnull(@i_valor_actual  , 0),
   @i_valor_original       = isnull(@i_valor_original, 0)
         
   if @w_existe = 1
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1901002
   end


   select @w_secservicio = @@spid


   select @w_custodia  = null

   select @w_contabilizar = tc_contabilizar
   from   cu_tipo_custodia
   where  tc_tipo       = @i_tipo
   set transaction isolation level read uncommitted


   select @w_stanby = pa_char
   from   cobis..cl_parametro
   where  pa_producto = 'GAR'
   and    pa_nemonico = 'GSTABY'
   set transaction isolation level read uncommitted

   if @i_periodicidad is not null
      select @w_fecha_prox_insp = dateadd(dd,@w_valor_intervalo,@s_date)

   select @w_existe_tc_tipo = 0
   select @w_existe_tc_tipo = 1
     from cob_custodia..cu_tipo_custodia
    where tc_tipo =  @i_tipo
   set transaction isolation level read uncommitted

   select @w_existe_tc_tipo_superior = 0
   select @w_existe_tc_tipo_superior = 1
     from cob_custodia..cu_tipo_custodia
    where tc_tipo_superior =  @i_tipo
   set transaction isolation level read uncommitted

   begin tran

      select @w_custodia  = se_actual + 1
      from   cu_seqnos
      where  se_filial    = @i_filial
      and    se_sucursal  = @i_sucursal
      and    se_tipo_cust = @i_tipo


      if @w_custodia is null
      begin
         insert into cu_seqnos values
         (@i_filial,@i_sucursal,@i_tipo,1)

         if @@error <> 0 begin
            select @w_error = 1903001
            goto error
         end

          select @w_custodia = 1

      end
      else
      begin
          update cu_seqnos
          set    se_actual    = se_actual + 1
          where  se_filial    = @i_filial
          and    se_sucursal  = @i_sucursal
          and    se_tipo_cust = @i_tipo

          if @@error <> 0 begin
             select @w_error = 1905001
             goto error
          end
      end

      if @i_estado = 'C'
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903011
         rollback tran
         return 1903011
      end
      if @i_estado = 'A'
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903012
         rollback tran
         return 1903012
      end

      if @i_estado <> 'P'
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903013
         rollback tran
         return 1
      end

      exec @w_retorno = sp_externo
           @i_filial,
           @i_sucursal,
           @i_tipo,
           @w_custodia,
           @w_codigo_externo out

      if @w_retorno = 1
      begin
         rollback tran
         return 1
      end

      select @o_codigo_externo = @w_codigo_externo
      
      if @w_contabilizar = 'N' and @i_estado = 'C'
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901002
         rollback tran
         return 1901002
      end

      if @w_existe_tc_tipo = 1
      begin
           if @w_existe_tc_tipo_superior = 1
           begin
                 exec cobis..sp_cerror
                 @t_from  = @w_sp_name,
                 @i_num   = 1912054
                 return 1912054
           end
      end
      else
      begin
                 exec cobis..sp_cerror
                 @t_from  = @w_sp_name,
           @i_num   = 1912054
                 return 1912054
      end

   if @i_tipo <> @w_stanby and @i_moneda <> 0
   begin
                 exec cobis..sp_cerror
                 @t_from  = @w_sp_name,
                 @i_num   = 1912054
                 return 1912115
   end

   if @i_ofi_ing is null
      select @i_ofi_ing  = @i_oficina_contabiliza

   /*Cambios RSA  */   
   if @i_provisiona is null
      select @i_provisiona  = 'N'   
     
      
   --defec8670 fecha_ingreso null
   if @i_fecha_ingreso is null
      select @i_fecha_ingreso = getdate()

   insert into cu_custodia(
   cu_filial,                cu_sucursal,            cu_tipo,                cu_custodia,
   cu_propuesta,             cu_estado,              cu_fecha_ingreso,       cu_valor_inicial,
   cu_valor_actual,          cu_moneda,              cu_garante,             cu_instruccion,
   cu_descripcion,           cu_poliza,              cu_inspeccionar,        cu_motivo_noinsp,
   cu_suficiencia_legal,     cu_fuente_valor,        cu_situacion,           cu_almacenera,
   cu_aseguradora,           cu_cta_inspeccion,      cu_direccion_prenda,    cu_ciudad_prenda,
   cu_telefono_prenda,       cu_mex_prx_inspec,      cu_fecha_const,         cu_porcentaje_valor,
   cu_periodicidad,          cu_depositario,         cu_posee_poliza,        cu_nro_inspecciones,
   cu_intervalo,             cu_cobranza_judicial,   cu_fecha_retiro,        cu_fecha_devolucion,
   cu_fecha_modificacion,    cu_usuario_crea,        cu_usuario_modifica,    cu_estado_poliza,
   cu_cobrar_comision,       cu_cuenta_dpf,          cu_codigo_externo,      cu_fecha_insp,
   cu_abierta_cerrada,       cu_adecuada_noadec,     cu_propietario,         cu_plazo_fijo,
   cu_monto_pfijo,           cu_oficina,             cu_oficina_contabiliza, cu_compartida,
   cu_valor_compartida,      cu_fecha_reg,           cu_fecha_prox_insp,     cu_valor_cobertura,
   cu_num_acciones,          cu_valor_accion,        cu_ubicacion,           cu_porcentaje_comp,
   cu_cuantia,               cu_vlr_cuantia,         cu_num_dcto,            cu_valor_refer_comis,
   cu_entidad_esp,           cu_fecha_desde,         cu_fecha_hasta,         cu_fecha_impred,
   cu_clase_cartera,         cu_tipo_cta,            cu_licencia,            cu_fecha_vcto,
   cu_fecha_vencimiento,     cu_porcentaje_cobertura,cu_fecha_avaluo,        cu_entidad_emisora,
   cu_fuente_valor_accion,   cu_fecha_accion,        cu_valor_comision,      cu_grado_gar,
   cu_provisiona,            cu_fnro_documento,      cu_fvalor_bruto,        cu_fanticipos,
   cu_fpor_impuestos,        cu_fpor_retencion,      cu_fvalor_neto,         cu_ffecha_emision,
   cu_ffecha_vtodoc,         cu_ffecha_inineg,       cu_ffecha_vtoneg,       cu_ffecha_pago,
   cu_fbase_calculo,         cu_fdias_negocio,       cu_fnum_dex,            cu_ffecha_dex,
   cu_fproveedor,            cu_fcomprador,          cu_fresp_pago,          cu_fresp_dscto,
   cu_ftasa,                 cu_disponible,          cu_siniestro,           cu_castigo,
   cu_agotada,               cu_clase_custodia,      cu_fecha_sol_exp,       cu_fecha_apr_pre,
   cu_fecha_apr,             cu_fecha_sol_rec,       cu_fecha_sol_ren,       cu_fecha_pro,
   cu_num_acta_apr_pre,      cu_num_acta_apr,        cu_clase_vehiculo,      cu_acum_ajuste,
   cu_expedido,              cu_causa_nexp,          cu_ciudad_gar,          cu_valor_original,
   cu_cuenta_hold)
   values (
   @i_filial,                @i_sucursal,            @i_tipo,                @w_custodia,
   @i_propuesta,             @i_estado,              @i_fecha_ingreso,       @i_valor_inicial,
   @i_valor_actual,          isnull(@i_moneda,0),    @i_garante,             @i_instruccion,
   @i_descripcion,           @i_poliza,              @i_inspeccionar,        @i_motivo_noinsp,
   @i_suficiencia_legal,     @i_fuente_valor,        @i_situacion,           @i_almacenera,
   @i_aseguradora,           @i_cta_inspeccion,      @i_direccion_prenda,    @i_ciudad_prenda,
   @i_telefono_prenda,       @i_mex_prx_inspec,      @i_fecha_const,         @i_porcentaje_valor,
   @i_periodicidad,          @i_depositario,         @i_posee_poliza,        0,
   @w_valor_intervalo,       @i_cobranza_judicial,   @i_fecha_retiro,        @i_fecha_devolucion,
   NULL,                     @s_user,                NULL,                   @i_estado_poliza,
   @i_cobrar_comision,       @i_cuenta_dpf,          @w_codigo_externo,      null,
   @i_abierta_cerrada,       @i_adecuada_noadec,     @i_propietario,         @i_plazo_fijo,
   @i_monto_pfijo,           @i_ofi_ing,             @i_oficina_contabiliza, @i_compartida,
   @i_valor_compartida,      @s_date,                @w_fecha_prox_insp,     @i_valor_cobertura,
   @i_num_acciones,          @i_valor_accion,        @i_ubicacion,           @i_porcentaje_comp,
   @i_cuantia,               @i_vlr_cuantia,         @i_num_dcto,            @i_valor_refer_comis,
   @i_entidad_esp,           @i_fecha_sol_rec,       @i_fecha_sol_ren,       @i_fec_impred,
   @i_directo,               @i_tipo_cta,            @i_licencia,            @i_fecha_vcto,
   @i_fec_venci,             @i_porcentaje_cobertura,@i_fecha_aval,          @i_entidad_emisora,
   @i_fuente_valor_accion,   @i_fecha_accion,        @i_valor_comision,      @i_grado_gar,
   @i_provisiona,            @i_fnro_documento,      @i_fvalor_bruto,        @i_fanticipos,
   @i_fpor_impuestos,        @i_fpor_retencion,      @i_fvalor_neto,         @i_ffecha_emision,
   @i_ffecha_vtodoc,         @i_ffecha_inineg,       @i_ffecha_vtoneg,       @i_ffecha_pago,
   @i_fbase_calculo,         @i_fdias_negocio,       @i_fnum_dex,            @i_ffecha_dex,
   @i_fproveedor,            @i_fcomprador,          @i_fresp_pago,          @i_fresp_dscto,
   @i_ftasa,                 @i_disponible,          @i_siniestro,           @i_castigo,
   @i_agotada,               @i_clase_custodia,      @i_fecha_sol_exp,       @i_fecha_apr_pre,
   @i_fecha_apr,             @i_fecha_sol_rec,       @i_fecha_sol_ren,       @i_fecha_pro,
   @i_num_acta_apr_pre,      @i_num_acta_apr,        @i_clase_vehiculo,      @i_valor_inicial,
   @i_expedido,              @i_causa_nexp,          @i_ciudad_gar,          @i_valor_original,
   @i_num_banco)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903001
      return 1903001
   end

   insert into ts_custodia values (
   @w_secservicio,           @t_trn,                 'N',                    getdate(),
   @s_user,                  @s_term,                @s_ofi,                 'cu_custodia',
   @i_filial,                @i_sucursal,            @i_tipo,                @w_custodia,
   @i_propuesta,             @i_estado,              @i_fecha_ingreso,       @i_valor_inicial,
   @i_valor_actual,          @i_moneda,              @i_garante,             @i_instruccion,
   @i_descripcion,           @i_poliza,              @i_inspeccionar,        @i_motivo_noinsp,
   @i_suficiencia_legal,     @i_fuente_valor,        @i_situacion,           @i_almacenera,
   @i_aseguradora,           @i_cta_inspeccion,      @i_tipo_cta,            @i_direccion_prenda,
   @i_ciudad_prenda,         @i_telefono_prenda,     @i_mex_prx_inspec,      @i_fecha_modif,
   @i_fecha_const,           @i_porcentaje_valor,    @i_periodicidad,        @i_depositario,
   @i_posee_poliza,          null,                   null,                   @i_cobranza_judicial,
   @i_fecha_retiro,          @i_fecha_devolucion,    null,                   @s_user,
   null,                     @i_estado_poliza,       @i_cobrar_comision,     @i_cuenta_dpf,
   @w_codigo_externo,        null,                   @i_abierta_cerrada,     @i_adecuada_noadec,
   @i_propietario,           @i_plazo_fijo,          @i_monto_pfijo,         @i_oficina_contabiliza,
   @i_compartida,            @i_valor_compartida,    @s_date,                @w_fecha_prox_insp,
   @i_valor_cobertura,       @i_num_acciones,        @i_valor_accion,        @i_num_banco,
   null,                     null,                   @i_vlr_cuantia,         @i_licencia,
   @i_fecha_vcto,            @i_fecha_aval,          @i_fec_venci,           @i_porcentaje_cobertura,
   @i_entidad_emisora,       @i_fuente_valor_accion, @i_fecha_accion,        @i_fnro_documento,
   @i_fvalor_bruto,          @i_fanticipos,          @i_fpor_impuestos,      @i_fpor_retencion,
   @i_fvalor_neto,           @i_ffecha_emision,      @i_ffecha_vtodoc,       @i_ffecha_inineg,
   @i_ffecha_vtoneg,         @i_ffecha_pago,         @i_fbase_calculo,       @i_fdias_negocio,
   @i_fnum_dex,              @i_ffecha_dex,          @i_fproveedor,          @i_fcomprador,
   @i_fresp_pago,            @i_fresp_dscto,         @i_ftasa,               @i_siniestro,
   @i_castigo,               @i_agotada,             @i_clase_custodia,      @i_fecha_sol_exp,
   @i_fecha_apr_pre,         @i_fecha_sol_rec,       @i_fecha_sol_ren,       @i_fecha_pro,
   @i_num_acta_apr_pre,      @i_num_acta_apr,        @i_clase_vehiculo,      @i_expedido,
   @i_causa_nexp)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903003
      return 1
   end

   if @i_grupal = 'S' 
   begin 
      select  @o_cod_custodia =  @w_codigo_externo
   end 
     -- Inicio IFJ REQ 131 10/Oct/2006
   --if @i_origen not in ('CTE', 'TCR')   select @w_custodia

   if @i_origen in ('CTE', 'TCR')
   begin
      exec @w_return = sp_adm_contragarantia
      @s_date                = @s_date,
      @i_operacion           = 'I',
      @i_carta_instruccion   = @i_carta_instruccion,
      @i_cuenta              = @i_cuenta,
      @i_instruccion         = @i_instruccion,
      @i_origen              = @i_origen,
      @i_filial              = @i_filial,
      @i_sucursal            = @i_sucursal,
      @i_tipo                = @i_tipo,
      @i_custodia            = @w_custodia,
      @i_garante             = @i_garante,
      @i_oficial             = @i_oficial,
      @i_nomcliente          = @i_nomcliente

      if @w_return <> 0
      begin
         rollback tran
         return 1
      end
   end
   -- Fin IFJ REQ 131 10/Oct/2006

   commit tran
   select @w_custodia
   select @i_sucursal
   return 0
end

if @i_operacion = 'U'
begin

   if exists (  select  1
   from    cob_custodia..cu_tipo_custodia
   where   tc_tipo     = @i_tipo
   and     tc_clase    = 'O')
   begin
      select    
      @i_valor_inicial    = 1,
      @i_valor_actual     = 1,
      @i_valor_original   = 1
   end 

   select
   @i_porcentaje_cobertura = isnull(@i_porcentaje_cobertura, 0),
   @i_valor_inicial        = isnull(@i_valor_inicial , 0),
   @i_valor_actual         = isnull(@i_valor_actual  , 0),
   @i_valor_original       = isnull(@i_valor_original, 0)

   if @w_existe = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905002
      return 1905002
   end
   if @i_estado = 'C'
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905016
      return 1905016
   end
   if @i_estado = 'A'
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905017
      return 1905017
   end

   select @w_secservicio = @@spid

   begin tran
   if @i_eliminarcliente = 'S' begin
      delete cob_custodia..cu_cliente_garantia
      where  cg_codigo_externo = @w_codigo_externo

      if @@error <> 0 begin
         select @w_error = 1907001
         goto error
      end
   end

   exec @w_retorno = sp_externo
   @i_filial,        @i_sucursal,    @i_tipo,
   @w_custodia,      @w_codigo_externo out

   if @w_retorno <> 0
   begin
      rollback tran
      return 1
   end

   select @w_contabilizar = tc_contabilizar
   from   cu_tipo_custodia
   where  tc_tipo         = @i_tipo
   set transaction isolation level read uncommitted

   if @i_parte = 1
   begin
--      if (convert(money,@i_valor_inicial) <> convert(money,@w_valor_inicial)
--          and @w_cuantia = 'I')
--      begin
--         select @i_valor_inicial = @w_valor_inicial
--      end

      select  @w_estado_aux  = @w_estado,
              @w_abierta_aux = @w_abierta_cerrada

       /*Cambios RSA  */   
     if @i_provisiona is null
      select @i_provisiona  = 'N'   
      
      if @i_periodicidad is not null
         select @w_fecha_prox_insp = dateadd(dd,@w_valor_intervalo,isnull(@w_fecha_avaluo,@w_fecha_ingreso))

      if (@i_clase_custodia   != @w_clase_custodia
          and @w_estado = 'V'
          and @w_contabilizar = 'S')
      begin
         exec @w_return = sp_cambio_clase
         @i_codigo_externo  = @w_codigo_externo,
         @i_adecuada_noadec = @i_clase_custodia,
         @s_date            = @s_date,
         @s_user            = @s_user,
         @s_ofi             = @s_ofi,
         @s_term            = @s_term

         if @w_return != 0
            if @i_clase_custodia is null
               select @i_clase_custodia = @w_clase_custodia
      end

      if @i_estado = 'F'
      begin
         update cob_credito..cr_gar_propuesta
         set    gp_abierta  = @i_abierta_cerrada
         where  gp_garantia = @w_codigo_externo

         if @@error <> 0 begin
            select @w_error = 1905001
            goto error
         end
      end

      --defec8670 fecha_ingreso null
      if @i_fecha_ingreso is null
         select @i_fecha_ingreso = getdate()

      update cob_custodia..cu_custodia
      set    cu_propuesta            = @i_propuesta,
             cu_estado               = @i_estado,
             cu_valor_inicial        = @i_valor_inicial,
             cu_moneda               = @i_moneda,
             cu_garante              = @i_garante,
             cu_instruccion          = @i_instruccion,
             cu_descripcion          = @i_descripcion,
             cu_inspeccionar         = @i_inspeccionar,
             cu_motivo_noinsp        = @i_motivo_noinsp,
             cu_suficiencia_legal    = @i_suficiencia_legal,
             cu_fuente_valor         = @i_fuente_valor,
             cu_situacion            = @i_situacion,
             cu_cta_inspeccion       = @i_cta_inspeccion,
             cu_mex_prx_inspec       = @i_mex_prx_inspec,
             cu_fecha_const          = @i_fecha_const,
             cu_porcentaje_valor     = @i_porcentaje_valor,
             cu_periodicidad         = @i_periodicidad,
             cu_depositario          = @i_depositario,
             cu_intervalo            = @w_valor_intervalo,
             cu_cobranza_judicial    = @i_cobranza_judicial,
             cu_fecha_retiro         = @i_fecha_retiro,
             cu_fecha_devolucion     = @i_fecha_devolucion,
             cu_fecha_modificacion   = @s_date,
             cu_usuario_modifica     = @s_user,
             cu_cobrar_comision      = @i_cobrar_comision,
             cu_cuenta_dpf           = @i_cuenta_dpf,
             cu_abierta_cerrada      = @i_abierta_cerrada,
             cu_adecuada_noadec      = @i_adecuada_noadec,
             cu_propietario          = @i_propietario,
             cu_almacenera           = @i_almacenera,
             cu_direccion_prenda     = @i_direccion_prenda,
             cu_ciudad_prenda        = @i_ciudad_prenda,
             cu_telefono_prenda      = @i_telefono_prenda,
             cu_oficina_contabiliza  = @i_oficina_contabiliza,
             cu_plazo_fijo           = @i_plazo_fijo,
             cu_monto_pfijo          = @i_monto_pfijo,
             cu_compartida           = @i_compartida,
             cu_valor_compartida     = @i_valor_compartida,
             cu_fecha_prox_insp      = @w_fecha_prox_insp,
             cu_valor_cobertura      = @i_valor_cobertura,
             cu_num_acciones         = @i_num_acciones,
             cu_valor_accion         = @i_valor_accion,
             cu_ubicacion            = @i_ubicacion,
             cu_porcentaje_comp      = @i_porcentaje_comp,
             cu_cuantia              = @i_cuantia,
             cu_vlr_cuantia          = @i_vlr_cuantia,
             cu_num_dcto             = @i_num_dcto,
             cu_valor_refer_comis    = @i_valor_refer_comis,
             cu_entidad_esp          = @i_entidad_esp,
             cu_fecha_desde          = @i_fecha_sol_rec,
             cu_fecha_hasta          = @i_fecha_sol_ren,
             cu_fecha_impred         = @i_fec_impred,
             cu_tipo_cta             = @i_tipo_cta,
             cu_clase_cartera        = @i_directo,
             cu_licencia             = @i_licencia,
             cu_fecha_vcto           = @i_fecha_vcto,
             cu_fecha_avaluo         = @i_fecha_aval,
             cu_fecha_vencimiento    = @i_fec_venci,
             cu_porcentaje_cobertura = @i_porcentaje_cobertura,
             cu_entidad_emisora      = @i_entidad_emisora,
             cu_fuente_valor_accion  = @i_fuente_valor_accion,
             cu_fecha_accion         = @i_fecha_accion ,
             cu_valor_comision       = @i_valor_comision,
             cu_grado_gar            = @i_grado_gar,
             cu_provisiona           = @i_provisiona,
             cu_fnro_documento       = @i_fnro_documento,
             cu_fvalor_bruto         = @i_fvalor_bruto,
             cu_fanticipos           = @i_fanticipos,
             cu_fpor_impuestos       = @i_fpor_impuestos,
             cu_fpor_retencion       = @i_fpor_retencion,
             cu_fvalor_neto          = @i_fvalor_neto,
             cu_ffecha_emision       = @i_ffecha_emision,
             cu_ffecha_vtodoc        = @i_ffecha_vtodoc,
             cu_ffecha_inineg        = @i_ffecha_inineg,
             cu_ffecha_vtoneg        = @i_ffecha_vtoneg,
             cu_ffecha_pago          = @i_ffecha_pago,
             cu_fbase_calculo        = @i_fbase_calculo,
             cu_fdias_negocio        = @i_fdias_negocio,
             cu_fnum_dex             = @i_fnum_dex,
             cu_ffecha_dex           = @i_ffecha_dex,
             cu_fproveedor           = @i_fproveedor,
             cu_fcomprador           = @i_fcomprador,
             cu_fresp_pago           = @i_fresp_pago,
             cu_fresp_dscto          = @i_fresp_dscto,
             cu_ftasa                = @i_ftasa,
             cu_disponible           = @i_disponible,
             cu_siniestro            = @i_siniestro,
             cu_castigo              = isnull(@i_castigo,@w_castigo),
             cu_agotada              = @i_agotada,
             cu_clase_custodia       = @i_clase_custodia,
             cu_fecha_sol_exp        = @i_fecha_sol_exp,
             cu_fecha_apr_pre        = @i_fecha_apr_pre,
             cu_fecha_apr            = @i_fecha_apr,
             cu_fecha_sol_rec        = @i_fecha_sol_rec,
             cu_fecha_sol_ren        = @i_fecha_sol_ren,
             cu_fecha_pro            = @i_fecha_pro,
             cu_num_acta_apr_pre     = @i_num_acta_apr_pre,
             cu_num_acta_apr         = @i_num_acta_apr,
             cu_clase_vehiculo       = @i_clase_vehiculo,
             cu_expedido             = @i_expedido,
             cu_causa_nexp           = @i_causa_nexp,
             cu_ciudad_gar           = @i_ciudad_gar,
             cu_valor_original       = @i_valor_original,
             cu_cuenta_hold          = @i_num_banco
      where  cu_filial               = @i_filial and
             cu_sucursal             = @i_sucursal and
             cu_tipo                 = @i_tipo and
             cu_custodia             = @i_custodia

      if @@error <> 0 begin
         select @w_error = 1905001
         goto error
      end

      if @i_estado = 'P'
      begin
         update cob_custodia..cu_custodia
         set    cu_valor_inicial     = @i_valor_inicial,
                cu_acum_ajuste       = @i_valor_inicial
         where  cu_filial            = @i_filial and
                cu_sucursal          = @i_sucursal and
                cu_tipo              = @i_tipo and
                cu_custodia          = @i_custodia

         if @@error <> 0 begin
            select @w_error = 1905001
            goto error
         end

      end

      if (@w_abierta_aux <> @i_abierta_cerrada or @w_estado_aux  <> @i_estado) begin
       update cob_credito..cr_gar_propuesta
         set    gp_est_garantia = @i_estado,
                gp_abierta      = @i_abierta_cerrada
         where  gp_garantia     = @w_codigo_externo

         if @@error <> 0 begin
            select @w_error = 1905001
            goto error
         end
      end

      delete cu_compartida
      where  co_codigo_externo = @w_codigo_externo

      if @@error <> 0 begin
         select @w_error = 1907001
         goto error
      end

      select @w_dif_valor = abs(@w_valor_actual - @i_valor_actual)

      if (@i_estado <> 'P' and @w_estado <> 'C' and @w_estado <> 'A' and @w_estado <> 'X' and @w_dif_valor <> 0)
      begin
         if @i_valor_actual > @w_valor_actual
            select @w_debcred = 'C'
         else
            select @w_debcred = 'D'

         select @w_cuantia        = cu_cuantia
         from   cu_custodia
         where  cu_codigo_externo = @w_codigo_externo

         if @w_cuantia = 'I'
         begin
            select @w_nuevo_comercial = isnull(cu_valor_refer_comis,isnull(cu_valor_inicial,0))
            from   cu_custodia
            where  cu_codigo_externo  = @w_codigo_externo
         end
         else
         begin
            select @w_nuevo_comercial = isnull(cu_valor_refer_comis,isnull(cu_vlr_cuantia,0))
            from   cu_custodia
            where  cu_codigo_externo  = @w_codigo_externo
         end

         exec @w_return         = sp_modvalor
         @s_date           = @s_date,
         @i_operacion      = 'I',
         @i_filial         = @i_filial ,
         @i_sucursal       = @i_sucursal ,
         @i_tipo_cust      = @i_tipo,
         @i_custodia       = @i_custodia ,
         @i_fecha_tran     = @s_date,
         @i_debcred        = @w_debcred ,
         @i_valor          = @w_dif_valor ,
         @i_num_acciones   = @i_num_acciones ,
         @i_valor_accion   = @i_valor_accion ,
         @i_valor_cobertura= @i_valor_cobertura ,
         @i_descripcion    = 'CAMBIO DE VALOR (MOD. GARANTIA)',
         @i_usuario        = @s_user,
         @i_terminal       = @s_term,
         @i_nuevo_comercial= @w_nuevo_comercial,
         @i_tipo_superior  = @i_tipo_superior
      end
      else
      if @i_estado = 'P'
      begin
         update cob_custodia..cu_custodia
         set    cu_valor_actual  = @i_valor_actual,
                cu_acum_ajuste   = @i_valor_inicial
         where  cu_filial        = @i_filial
         and    cu_sucursal      = @i_sucursal
         and    cu_tipo          = @i_tipo
         and    cu_custodia      = @i_custodia

         if @@error <> 0 begin
            select @w_error = 1905001
            goto error
         end

      end
   end
   else begin
      update  cob_custodia..cu_custodia
      set     cu_posee_poliza       = @i_posee_poliza,
              cu_fecha_modificacion = @w_today,
              cu_usuario_modifica   = @s_user,
              cu_estado_poliza      = @i_estado_poliza
      where   cu_filial          = @i_filial
      and     cu_sucursal        = @i_sucursal
      and     cu_tipo            = @i_tipo
      and     cu_custodia        = @i_custodia

      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1905001
      end
   end --@i_parte <> 1

   insert into ts_custodia values (
   @w_secservicio,             @t_trn,                 'P',                    getdate(),
   @s_user,                    @s_term,                @s_ofi,                 'cu_custodia',
   @w_filial,                  @w_sucursal,            @w_tipo,                @w_custodia,
   @w_propuesta,               @w_estado,              @w_fecha_ingreso,       @w_valor_inicial,
   @w_valor_actual,            @w_moneda,              @w_garante,             @w_instruccion,
   @w_descripcion,             @w_poliza,              @w_inspeccionar,        @w_motivo_noinsp,
   @w_suficiencia_legal,       @w_fuente_valor,        @w_situacion,           @w_almacenera,
   @w_aseguradora,             @w_cta_inspeccion,      @w_tipo_cta,            @w_direccion_prenda,
   @w_ciudad_prenda,           @w_telefono_prenda,     @w_mex_prx_inspec,      @w_fecha_modif,
   @w_fecha_const,             @w_porcentaje_valor,    @w_periodicidad,        @w_depositario,
   @w_posee_poliza,            null,                   null,                   @w_cobranza_judicial,
   @w_fecha_retiro,            @w_fecha_devolucion,    @w_fecha_modificacion,  @w_usuario_crea,
   @w_usuario_modifica,        @w_estado_poliza,       @w_cobrar_comision,     @w_cuenta_dpf,
   @w_codigo_externo,          null,                   @w_abierta_cerrada,     @w_adecuada_noadec,
   @w_propietario,             @w_plazo_fijo,          @w_monto_pfijo,         @w_oficina_contabiliza,
   @w_compartida,              @w_valor_compartida,    @w_fecha_reg,           @w_fecha_prox_insp,
   @w_valor_cobertura,         @w_num_acciones,        @w_valor_accion,        @i_num_banco,
   null,                       null,                   @w_vlr_cuantia,         @i_licencia,
   @i_fecha_vcto,              @i_fecha_aval,          @i_fec_venci,           @i_porcentaje_cobertura,
   @i_entidad_emisora,         @i_fuente_valor_accion, @i_fecha_accion,        @i_fnro_documento,
   @i_fvalor_bruto,            @i_fanticipos,          @i_fpor_impuestos,      @i_fpor_retencion,
   @i_fvalor_neto,             @i_ffecha_emision,      @i_ffecha_vtodoc,       @i_ffecha_inineg,
   @i_ffecha_vtoneg,           @i_ffecha_pago,         @i_fbase_calculo,       @i_fdias_negocio,
   @i_fnum_dex,                @i_ffecha_dex,          @i_fproveedor,          @i_fcomprador,
   @i_fresp_pago,              @i_fresp_dscto,         @i_ftasa,               @w_siniestro,
   @w_castigo,                 @w_agotada,             @w_clase_custodia,      @w_fecha_sol_exp,
   @w_fecha_apr_pre,           @w_fecha_sol_rec,       @w_fecha_sol_ren,       @w_fecha_pro,
   @w_num_acta_apr_pre,        @w_num_acta_apr,        @w_clase_vehiculo,      @w_expedido,
   @w_causa_nexp)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903003
      return 1903003
   end

   insert into ts_custodia values (
   @w_secservicio,             @t_trn,                 'A',                    getdate(),
   @s_user,                    @s_term,                @s_ofi,                 'cu_custodia',
   @i_filial,                  @i_sucursal,            @i_tipo,                @i_custodia,
   @i_propuesta,               @i_estado,              @i_fecha_ingreso,       @i_valor_inicial,
   @i_valor_actual,            @i_moneda,              @i_garante,             @i_instruccion,
   @i_descripcion,             @i_poliza,              @i_inspeccionar,        @i_motivo_noinsp,
   @i_suficiencia_legal,       @i_fuente_valor,        @i_situacion,           @i_almacenera,
   @i_aseguradora,             @i_cta_inspeccion,      @i_tipo_cta,            @i_direccion_prenda,
   @i_ciudad_prenda,           @i_telefono_prenda,     @i_mex_prx_inspec,      @i_fecha_modif,
   @i_fecha_const,             @i_porcentaje_valor,    @i_periodicidad,        @i_depositario,
   @i_posee_poliza,            null,                   null,                   @i_cobranza_judicial,
   @i_fecha_retiro,            @i_fecha_devolucion,    @w_today,               @w_usuario_crea,
   @s_user,                    @w_estado_poliza,       @i_cobrar_comision,     @i_cuenta_dpf,
   @w_codigo_externo,          null,                   @i_abierta_cerrada,     @i_adecuada_noadec,
   @i_propietario,             @i_plazo_fijo,          @i_monto_pfijo,         @i_oficina_contabiliza,
   @i_compartida,              @i_valor_compartida,    @w_fecha_reg,           @w_fecha_prox_insp,
   @i_valor_cobertura,         @i_num_acciones,        @i_valor_accion,        @i_num_banco,
   null,                       null,                   @i_vlr_cuantia,         @i_licencia,
   @i_fecha_vcto,              @i_fecha_aval,          @i_fec_venci,           @i_porcentaje_cobertura,
   @i_entidad_emisora,         @i_fuente_valor_accion, @i_fecha_accion,        @i_fnro_documento,
   @i_fvalor_bruto,            @i_fanticipos,          @i_fpor_impuestos,      @i_fpor_retencion,
   @i_fvalor_neto,             @i_ffecha_emision,      @i_ffecha_vtodoc,       @i_ffecha_inineg,
   @i_ffecha_vtoneg,           @i_ffecha_pago,         @i_fbase_calculo,       @i_fdias_negocio,
   @i_fnum_dex,                @i_ffecha_dex,          @i_fproveedor,          @i_fcomprador,
   @i_fresp_pago,              @i_fresp_dscto,         @i_ftasa,               @i_siniestro,
   @w_castigo,                 @i_agotada,             @i_clase_custodia,      @i_fecha_sol_exp,
   @i_fecha_apr_pre,           @i_fecha_sol_rec,       @i_fecha_sol_ren,       @i_fecha_pro,
   @i_num_acta_apr_pre,        @i_num_acta_apr,        @i_clase_vehiculo,      @i_expedido,
   @i_causa_nexp)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903003
      return 1903003
   end
 if  @i_opcion  <>  'W'  begin
   if @i_eliminarcliente = 'S' begin
      exec @w_retorno = sp_cliente_garantia
      @t_trn = 19040,
      @i_operacion = 'I',
      @i_filial = @i_filial,
      @i_sucursal = @i_sucursal,
      @i_tipo_cust = @i_tipo,
      @i_custodia = @i_custodia,
      @i_ente = @i_ente,
      @i_nomcliente = @i_nomcliente,
      @i_oficial = @i_oficial,
      @i_principal = @i_principal,
      @i_tipo_garante = @i_tipo_garante

      if @w_retorno = 1
      begin
         rollback tran
         return 1
      end

   end
   end

   commit tran
   return 0
end

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1907002
      return 1907002
   end
   if exists (select 1
              from   cu_inspeccion
              where  in_tipo_cust      = @i_tipo
              and    in_custodia       = @i_custodia
              and    in_codigo_externo > '')
   begin
      select @w_error = 1907006
      goto error
   end
   select @w_existe1 = 0
   select @w_existe1 = 1
              from  cu_item_custodia
              where ic_tipo_cust  = @i_tipo
              and   ic_custodia   = @i_custodia
              and   ic_valor_item <> ''
              and   ic_sucursal   > 0
   if @w_existe1 = 1
   begin
      select @w_error = 1907007
      goto error
   end
   if exists (select 1
              from   cu_recuperacion
              where  re_tipo_cust = @i_tipo
              and    re_custodia  = @i_custodia)
   begin
      select @w_error = 1907008
      goto error
   end
   if exists (select 1
              from   cu_transaccion
              where  tr_codigo_externo  = @w_codigo_externo)
   begin
      select @w_error = 1907009
      goto error
   end
   if exists (select 1
              from   cu_vencimiento
              where  ve_tipo_cust = @i_tipo
              and    ve_custodia  = @i_custodia)
   begin
      select @w_error = 1907010
      goto error
   end
   if exists (select 1
              from   cu_por_inspeccionar
              where  pi_tipo      = @i_tipo
              and    pi_custodia  = @i_custodia)
   begin
      select @w_error = 1907011
      goto error
   end

   begin tran

   update cob_custodia..cu_custodia
   set    cu_estado   = @i_estado
   where  cu_filial   = @i_filial
   and    cu_sucursal = @i_sucursal
   and    cu_tipo     = @i_tipo
   and    cu_custodia = @i_custodia

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1907001
      return 1907001
   end

   insert into ts_custodia values (
   @w_secservicio,                @t_trn,                 'B',                    getdate(),
   @s_user,                       @s_term,                @s_ofi,                 'cu_custodia',
   @w_filial,                     @w_sucursal,            @w_tipo,                @w_custodia,
   @w_propuesta,                  @w_estado,              @w_fecha_ingreso,       @w_valor_inicial,
   @w_valor_actual,               @w_moneda,              @w_garante,             @w_instruccion,
   @w_descripcion,                @w_poliza,              @w_inspeccionar,        @w_motivo_noinsp,
   @w_suficiencia_legal,          @w_fuente_valor,        @w_situacion,           @w_almacenera,
   @w_aseguradora,                @w_cta_inspeccion,      @w_tipo_cta,            @w_direccion_prenda,
   @w_ciudad_prenda,              @w_telefono_prenda,     @w_mex_prx_inspec,      @w_fecha_modif,
   @w_fecha_const,                @w_porcentaje_valor,    @w_periodicidad,        @w_depositario,
   @w_posee_poliza,               null,                   null,                   @w_cobranza_judicial,
   @w_fecha_retiro,               @w_fecha_devolucion,    @w_fecha_modificacion,  @w_usuario_crea,
   @w_usuario_modifica,           @w_estado_poliza,       @w_cobrar_comision,     @w_cuenta_dpf,
   @w_codigo_externo,             null,                   @w_abierta_cerrada,     @w_adecuada_noadec,
   @w_propietario,                @w_plazo_fijo,          @w_monto_pfijo,         @w_oficina_contabiliza,
   @w_compartida,                 @w_valor_compartida,    @w_fecha_reg,           @w_fecha_prox_insp,
   @w_valor_cobertura,            @w_num_acciones,        @w_valor_accion,        @w_num_banco,
   null,                          null,                   null,                   @i_licencia,
   @i_fecha_vcto,                 @i_fecha_aval,          @i_fec_venci,           @i_porcentaje_cobertura,
   @i_entidad_emisora,            @i_fuente_valor_accion, @i_fecha_accion,        @i_fnro_documento,
   @i_fvalor_bruto,               @i_fanticipos,          @i_fpor_impuestos,      @i_fpor_retencion,
   @i_fvalor_neto,                @i_ffecha_emision,      @i_ffecha_vtodoc,       @i_ffecha_inineg,
   @i_ffecha_vtoneg,              @i_ffecha_pago,         @i_fbase_calculo,       @i_fdias_negocio,
   @i_fnum_dex,                   @i_ffecha_dex,          @i_fproveedor,          @i_fcomprador,
   @i_fresp_pago,                 @i_fresp_dscto,         @i_ftasa,               @w_siniestro,
   @w_castigo,                    @w_agotada,             @w_clase_custodia,      @w_fecha_sol_exp,
   @w_fecha_apr_pre,              @w_fecha_sol_rec,       @w_fecha_sol_ren,       @w_fecha_pro,
   @w_num_acta_apr_pre,           @w_num_acta_apr,        @w_clase_vehiculo,      @w_expedido,
   @w_causa_nexp)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903003
      return 1903003
   end

   delete cu_compartida
   where  co_codigo_externo = @w_codigo_externo

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end

   delete cu_cliente_garantia
   where  cg_filial    = @i_filial
   and    cg_sucursal  = @i_sucursal
   and    cg_tipo_cust = @i_tipo
   and    cg_custodia  = @i_custodia

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end

   delete cob_credito..cr_gar_propuesta
   where  gp_garantia = @w_codigo_externo

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end

   delete cu_por_inspeccionar
   where  pi_filial         = @i_filial
   and    pi_sucursal       = @i_sucursal
   and    pi_tipo           = @i_tipo
   and    pi_custodia       = @i_custodia
   and    pi_codigo_externo > ''
   and    pi_fecha_insp     is not null

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end

   delete cu_inspeccion
   where  in_codigo_externo = @w_codigo_externo

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end

   delete cu_seqnos
   where  se_filial    = @i_filial
   and    se_sucursal  = @i_sucursal
   and    se_tipo_cust = @i_tipo
   and    se_actual    = @i_custodia

   if @@error <> 0 begin
      select @w_error = 1907001
      goto error
   end
   commit tran
   return 0
end

if @i_operacion = 'Q'
begin
   if @w_existe = 1
   begin

      select @w_tipogarante = cg_tipo_garante
      from cu_cliente_garantia, cobis..cl_ente, cu_custodia
      where cg_codigo_externo = @w_codigo_externo
         and cg_codigo_externo = cu_codigo_externo
         and cg_ente           = en_ente

      select @w_des_tipogarante = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_tipo_garante'
      and A.codigo = @w_tipogarante
      and B.codigo = A.tabla
      set transaction isolation level read uncommitted


      if @w_inspeccionar = 'N'
      begin
         select @w_des_inspeccionar = 'N'
         select @w_des_motivo_noinsp = A.valor
         from   cobis..cl_catalogo A,
                cobis..cl_tabla B
         where  B.codigo = A.tabla
         and    B.tabla  = 'cu_motivo_noinspeccion'
         and    A.codigo = @w_motivo_noinsp
         set transaction isolation level read uncommitted
      end
      else
         select @w_des_periodicidad = td_descripcion
         from   cob_cartera..ca_tdividendo
         where  td_tdividendo = @w_periodicidad
         set transaction isolation level read uncommitted

      select @w_des_ciudad_prenda = ci_descripcion, @w_pro_ciudad =(convert(varchar,ci_provincia) +';'+ convert(varchar,ci_ciudad))
      from   cobis..cl_ciudad
      where  ci_ciudad = @w_ciudad_prenda
      and    ci_estado = 'V'
      set transaction isolation level read uncommitted

      select @w_des_tipo = tc_descripcion
      from   cu_tipo_custodia
      where  tc_tipo     = @w_tipo
      set transaction isolation level read uncommitted

      select @w_des_moneda = mo_descripcion
      from   cobis..cl_moneda
      where  mo_moneda     = @w_moneda
      set transaction isolation level read uncommitted

      select @w_des_garante = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
      from   cobis..cl_ente
      where  en_ente = @w_garante
      set transaction isolation level read uncommitted

      set rowcount 1
      select @w_cliente   = cg_ente,
             @w_codoficial= cg_oficial
      from   cu_cliente_garantia
      where  cg_filial    = @w_filial
      and    cg_sucursal  = @w_sucursal
      and    cg_tipo_cust = @w_tipo
      and    cg_custodia  = @w_custodia
      and    cg_principal = 'D'
      set rowcount 0

      select @w_des_cliente=p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
      from cobis..cl_ente
      where en_ente = @w_cliente
      set transaction isolation level read uncommitted

      select @w_oficial     = fu_nombre
      from   cobis..cc_oficial,cobis..cl_funcionario
      where  oc_oficial     = convert(smallint,isnull(@w_codoficial,0))
      and    oc_funcionario = fu_funcionario
      set transaction isolation level read uncommitted

      select @w_des_almacenera = al_nombre
      from   cu_almacenera
      where  al_almacenera = @w_almacenera

      select @w_des_clase_vehiculo = cv_descripcion
      from   cu_clase_vehiculo
      where  cv_tipo    = @w_tipo
      and    cv_clase   = @w_clase_vehiculo

      select @w_des_oficina = of_nombre
      from   cobis..cl_oficina
      where  of_oficina     = convert(smallint,@w_oficina_contabiliza)
      and    of_filial      = @i_filial
      set transaction isolation level read uncommitted

      select @w_nom_proveedor = en_nombre
      from   cobis..cl_ente
      where  en_ente = @w_fproveedor
      set transaction isolation level read uncommitted

      select @w_nom_comprador = en_nombre
      from   cobis..cl_ente
      where  en_ente = @w_fcomprador
      set transaction isolation level read uncommitted

      select @w_nom_pago = en_nombre
      from   cobis..cl_ente
      where  en_ente = @w_fresp_pago
      set transaction isolation level read uncommitted

      select @w_nom_descuento = en_nombre
      from   cobis..cl_ente
      where  en_ente = @w_fresp_dscto
      set transaction isolation level read uncommitted

      select @w_des_ciudad_gar = ci_descripcion
      from   cobis..cl_ciudad
      where  ci_ciudad = @w_ciudad_gar
      and    ci_estado = 'V'
      set transaction isolation level read uncommitted

      /*Para formatear en un Grid*/
      /****************************/
      /*NVR-BE******/
      if @i_det_cliente is not null
         select @w_jre = 'S'
      set rowcount 20
      select cg_ente,
         nombre = substring(p_p_apellido+' '+p_s_apellido+' '+en_nombre,1,25),
         cg_oficial,
         fu_nombre = (select substring(fu_nombre ,1,25)
                      from cobis..cl_funcionario
                      where OC.oc_funcionario = fu_funcionario),
         cg_principal,
         cg_tipo_garante,
         garante = substring(A.valor,1,15),
         en_vinculacion,
         valor_cat = (select valor
                      from cobis..cl_catalogo A,
                         cobis..cl_tabla B
                      where B.tabla  = 'cl_relacion_banco'
                         and B.codigo = A.tabla
                         and A.codigo = E.en_tipo_vinculacion),
         en_ced_ruc,
         tipo_ced = (select valor
                      from cobis..cl_catalogo A,
                         cobis..cl_tabla B
                      where B.tabla  = 'cl_tipo_documento'
                         and B.codigo = A.tabla
                         and A.codigo = E.en_tipo_ced)
      from cobis..cl_ente E, cobis..cc_oficial OC,
         cu_cliente_garantia, cobis..cl_catalogo A,cobis..cl_tabla B
      where cg_codigo_externo = @w_codigo_externo
         and cg_ente          = en_ente
         and cg_oficial        = oc_oficial
         and B.tabla = 'cu_tipo_garante'
         and A.tabla = B.codigo
         and A.codigo = cg_tipo_garante
      set rowcount 0

   /***********************************************/

         /*****************************/

      --emg feb-16-02

/*
      select @w_tipogarante = cg_tipo_garante
      from cu_cliente_garantia, cobis..cl_ente, cu_custodia
      where cg_codigo_externo = @w_codigo_externo
         and cg_codigo_externo = cu_codigo_externo
         and cg_ente           = en_ente
*/
      select @w_desc_entidad_emisora = en_nomlar
      from cobis..cl_ente
      where en_ente = @w_entidad_emisora
      set transaction isolation level read uncommitted

      select @w_valor_actual   = isnull(@w_valor_actual,isnull(@w_valor_refer_comis,0))

      select @w_recupera = sum(isnull(re_valor,0))
      from cu_recuperacion
      where re_codigo_externo = @w_codigo_externo
      
      --LPO REQ. 215 Paquete 2 Alertas de Vencimientos de Cupo INICIO
      exec @w_return    = cob_credito..sp_alertas
           @i_cliente   = @w_cliente
      
      if @w_return <> 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = @w_return
         return @w_return
      end
      --LPO REQ. 215 Paquete 2 Alertas de Vencimientos de Cupo FIN
      
      if exists (select 1 from #fag where tipo = @w_tipo)
         select @w_fag = 'S'
      else
         select @w_fag = 'N'
	
      select
         @w_custodia,                   --1
         @w_tipo,
         @w_des_tipo,
         convert(char(10),@w_fecha_ingreso,@i_formato_fecha),
         @w_estado,                     --5
         @w_des_est_custodia,
         @w_descripcion,
         isnull(convert(varchar(20),@w_garante),''),
         @w_des_garante,
         @w_cta_inspeccion,             --10
         @w_fuente_valor,
         @w_des_fuente_valor,
         isnull(convert(varchar(20),@w_moneda),''),
         @w_des_moneda,
         @w_valor_inicial,         --15
         @w_valor_actual,
         convert(char(10),@w_fecha_const,@i_formato_fecha),
         @w_instruccion,
         @w_inspeccionar,
         @w_suficiencia_legal,          --20
         @w_motivo_noinsp,
         @w_des_motivo_noinsp,
         @w_pro_ciudad,
         @w_direccion_prenda,
         @w_telefono_prenda,            --25
         isnull(convert(varchar(10),@w_almacenera),''),
         @w_des_almacenera,
         convert(varchar(10),@w_fecha_aval,@i_formato_fecha),
         @w_poliza,
         @w_aseguradora,                --30
         @w_des_aseguradora,
         @w_cobranza_judicial,
         convert(varchar(10),@w_fecha_retiro,@i_formato_fecha),
         convert(varchar(10),@w_fecha_devolucion,@i_formato_fecha),
         @w_estado_poliza,              --35
         @w_des_estado_poliza,
         @w_cobrar_comision,
         @w_periodicidad,
         @w_des_periodicidad,
         @w_abr_cer,                    --40
         @w_cuenta_dpf,
         isnull(convert(varchar(10),@w_cliente),''),
         @w_des_cliente,
         @w_abierta_cerrada,
         @w_adecuada_noadec,            --45
         @w_oficial,
         @w_propietario,
         @w_plazo_fijo,
         @w_monto_pfijo,
         @w_depositario,                --50
         @w_oficina_contabiliza,
         @w_des_oficina,
         @w_compartida,
         @w_valor_compartida,
         @w_posee_poliza,               --55
         @w_valor_comision,
         @w_num_dcto,
         @w_valor_accion,
         @w_grado_gar,
         @w_ubicacion,   --60
         @w_fag,
         @w_num_banco,
         @w_fvalor_neto
         
      -- Resto
      select
         @w_cuenta_inspeccion,
         @w_ubicacion,                  --NVR-BE
         @w_des_ubicacion,              --NVR-BE
         @w_tipogarante,                --NVR-BE
         @w_des_tipogarante,            --NVR-BE
         @w_cuantia,                    --NVR-BE    65
         @w_vlr_cuantia,                --NVR-BE
         @w_num_dcto,                   --NVR-BE
         @w_valor_refer_comis,          --NVR-BE
         @w_entidad_esp,                --NVR-BE
         convert(char(10),@w_fecha_sol_rec,@i_formato_fecha), --NVR-BE 70
         convert(char(10),@w_fecha_sol_ren,@i_formato_fecha), --NVR-BE
         @w_des_entidad_esp,            --NVR-BE
         @w_des_ciudad_prenda,          --NVR-BE
         convert(char(10),@w_fec_impred,@i_formato_fecha),
         '', --@w_directo,
         @w_cta_inspeccion,
         @w_tipo_cta,
         @w_codoficial,
         @w_licencia,                   --NVR1
         convert(char(10),@w_fecha_vcto,@i_formato_fecha),      --NVR1  80
         convert(char(10),@w_fec_venci,@i_formato_fecha),       /*XVE*/
         convert(char(10),@w_fecha_avaluo,@i_formato_fecha),    /*XVE*/
         @w_porcentaje_cobertura,                                /*XVE*/
         @w_entidad_emisora,
         @w_fuente_valor_emisora,
         convert(char(10),@w_fecha_accion,@i_formato_fecha),    /*XVE*/--86
         @w_desc_entidad_emisora,                                /*XVE*/ --87
         @w_desc_fuente_emisora,                                  /*XVE*/ --88
         @w_porcentaje_comp,
         @w_valor_compartida,                   --90
         @w_valor_comision,      --XTA
         @w_recupera,
         @w_des_adecuada,                  --93
         @w_des_grado,                  --94
         @w_provisiona,
         @w_fnro_documento,    --96
         @w_fvalor_bruto,
         @w_fanticipos,
         @w_fpor_impuestos,
         @w_fpor_retencion,         --100
         @w_fvalor_neto,
         convert(char(10),@w_ffecha_emision,@i_formato_fecha),
         convert(char(10),@w_ffecha_vtodoc,@i_formato_fecha),
         convert(char(10),@w_ffecha_inineg,@i_formato_fecha),
         convert(char(10),@w_ffecha_vtoneg,@i_formato_fecha),         --105
         convert(char(10),@w_ffecha_pago,@i_formato_fecha),
         @w_fbase_calculo,
         @w_fdias_negocio,
         @w_fnum_dex,
         convert(char(10),@w_ffecha_dex,@i_formato_fecha),           --110
         @w_fproveedor,
         @w_fcomprador,
         @w_fresp_pago,
         @w_fresp_dscto,
         @w_ftasa,                                                   --115
         @w_des_base_calculo,
         @w_nom_proveedor,
         @w_nom_comprador,
         @w_nom_pago,
         @w_nom_descuento,                                            --120
         @w_siniestro,                                           --121
         @w_castigo,
         @w_agotada,
         @w_clase_custodia, --emg
         @w_des_clase,
         convert(char(10),@w_fecha_sol_exp ,@i_formato_fecha),           --126
         convert(char(10),@w_fecha_sol_rec ,@i_formato_fecha),           --127
         convert(char(10),@w_fecha_apr_pre ,@i_formato_fecha),           --128
         convert(char(10),@w_fecha_pro  ,@i_formato_fecha),           --129
         convert(char(10),@w_fecha_sol_ren  ,@i_formato_fecha),           --130
         @w_num_acta_apr_pre,
         @w_num_acta_apr,
         @w_clase_vehiculo,
         @w_des_clase_vehiculo,
         @w_propuesta,  --135
         @w_acum_ajuste,
         convert(varchar(10),@w_fecha_apr,@i_formato_fecha),
         @w_valor_original,
         @w_usuario_crea

      select @w_ciudad_gar,
         @w_des_ciudad_gar,
         @w_expedido,
         @w_causa_nexp,
         @w_des_nexpedido

      if @i_cdt = 'L'
      begin
         select @o_num_banco = @w_plazo_fijo
      end


--DATOS ADICIONALES GARANTIA

      return 0
   end
   else
      return 1
end


if @i_operacion = 'F'
begin
   select @w_gquir = pa_char
   from cobis..cl_parametro
   where pa_producto = 'GAR' and pa_nemonico = 'GQUIR'
   set transaction isolation level read uncommitted

   select
   convert(char(10),@w_today,@i_formato_fecha), --@w_today,
   convert(char(10),@s_date,@i_formato_fecha), --   @s_date,
   mo_descripcion,
   @w_gquir
   from cobis..cl_moneda
   where mo_moneda = 0
   set transaction isolation level read uncommitted
end



/*Consulta el cliente de la Garantia     */
/*****************************************/

if @i_operacion = 'C'
begin

   if @i_opcion = 'C'
      select cu_propietario
      from cob_custodia..cu_custodia
      where cu_tipo = @i_tipo
      and cu_custodia = @i_custodia
      and cu_sucursal >= 0
      and cu_filial  >=  convert(tinyint,0)

   if @i_opcion = 'D'
   begin
      begin tran
      delete cu_custodia
      where cu_filial = @i_filial
      and cu_sucursal = @i_sucursal
      and cu_tipo     = @i_tipo
      and cu_custodia = @i_custodia


      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1907001
            rollback tran
            return 1
      end
      commit tran
   end

end


/*Validar si la oficina es cob o regional */
if @i_operacion = 'V'
begin

  set rowcount 1
  select @w_conta = 0
  select @w_es_cobreg = 'N'

  select @w_conta = 1
  from   cobis..cl_oficina
  where  of_subtipo = 'C'
  and    of_oficina = @s_ofi


  if @w_conta = 1
    select @w_es_cobreg = 'S'


  select @w_conta = 1
  from cob_credito..cr_corresp_sib
  where tabla = 'T21'
  and   codigo = convert(varchar(10),@s_ofi)

  if @w_conta = 1
    select @w_es_cobreg = 'S'


  select @w_conta = 1
  from cob_credito..cr_corresp_sib
  where tabla = 'T21'
  and   codigo_sib = convert(varchar(10),@s_ofi)

  if @w_conta = 1
    select @w_es_cobreg = 'S'


  set rowcount 0

  select @w_es_cobreg
end


if @i_operacion = 'E'
begin

   --Validacion Especificaciones Mandatorias

    select @w_conta = 0
    set rowcount 1

    select @w_conta = 1
    from   cu_item i
    where  it_tipo_custodia = @i_tipo
    and    it_mandatorio = 'S'
    and    not exists (select 1
                       from   cu_item_custodia
                       where  ic_tipo_cust = i.it_tipo_custodia
                       and    ic_item = i.it_item
                       and    ic_codigo_externo = @i_codigo_externo)

    set rowcount 0

    if @w_conta = 1
    begin
      exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1901043
      return 1901043
    end

end


return 0
error:
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error
        return 1
GO
