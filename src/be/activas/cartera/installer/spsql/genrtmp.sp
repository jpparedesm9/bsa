/************************************************************************/
/*   Archivo:             genrtmp.sp                                    */
/*   Stored procedure:    sp_gen_rubtmp                                 */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        R Garces                                      */
/*   Fecha de escritura:  Feb 95                                        */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Crea los registros de la tabla ca_rubro_op_tmp para una            */
/*      operacion a partir de ca_rubro                                  */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*   FECHA       AUTOR         RAZON                                    */
/*   13/May/99   XSA(CONTEXT)   Manejo de los campos Saldo de           */
/*                     operacion y Saldo por desembol-                  */
/*                     sar para los rubros tipo calcu-                  */
/*                     lados.                                           */
/* 16/07/2001      Elcira Pelaez  se crea cursor rubros_asociados       */
/*                     para calculo de los rubros                       */
/*                     tipo porcentaje sobre un rubro                   */
/*                     asociado                                         */
/* 05/12/2002    Luis Mayorga   Cobra un porcentaje (Timbre) al         */
/*               usuario, el resto lo asume banco                       */
/* 10/nov/2005   Elcira Pelaez  Cambios para Documentos descontado BAC  */
/* 06/Jul/2006   Elcira Pelaez  Cambios para Credito Rotativo           */
/* NOV-02-20006  E.Pelaez       NR-126 Docmentos Descontados            */
/* 2008-03-25    M.Roa          Comentar @i_porcentaje_cobrar en        */
/*                              llamado sp_rubro_calculado              */
/* MAR-05-2011   Elcira Pelaez  Inc.17942 Busqueda de tasa para FNG     */
/* MAR-22-2017   Jorge Salazar  CGS-S112643                             */
/* MAR-09-2021   Sonia Rojas    REQ 147999 V2                           */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_gen_rubtmp')
   drop proc sp_gen_rubtmp
GO

create proc sp_gen_rubtmp (
   @s_user                         login       = null,
   @s_date                         datetime    = null,
   @s_term                         varchar(30) = null,
   @s_ofi                          smallint    = null,
   @t_debug                        char(1)     = 'N',
   @t_file                         varchar(14) = null,
   @t_from                         varchar(30) = null,
   @i_crear_pasiva                 char(1)     = 'N',
   @i_toperacion_pasiva            varchar(10)    = null,
   @i_operacion_activa             int         = null,
   @i_operacionca                  int         = null,
   @i_tramite_hijo                 int         = null,
   @i_tasa                         float       = null,  --JSA Santander
   @i_promocion                    char(1)     = 'N'
)
as declare
@w_sp_name                      descripcion,
@w_msg                          descripcion,
@w_operacionca                  int,
@w_cliente                      int,
@w_toperacion                   varchar(10),
@w_moneda                       tinyint,
@w_fecha_ini                    datetime,
@w_monto                        money,
@w_ref_reajuste                 varchar(10),
@w_dias_anio                    smallint,
@w_concepto                     varchar(10),
@w_porcentaje                   float,
@w_prioridad                    tinyint,
@w_paga_mora                    char(1),
@w_fpago                        char(1),
@w_tipo_rubro                   char(1),
@w_provisiona                   char(1),
@w_periodo                      tinyint,
@w_referencial                  varchar(10), --varchar(10),
@w_pit                          varchar(10),
@w_signo                        char(1),
@w_factor                       float,
@w_factor_reaj                  float,
@w_signo_reaj                   char(1),
@w_clase                        char(1),
@w_valor_rubro                  money,
@w_tipo_val                     varchar(10),
@w_signo_default                char(1),
@w_tipo_puntos                  char(1),
@w_valor_default                float,
@w_decimales                    char(1),
@w_num_dec                      tinyint,
@w_sector                       catalogo, --varchar(10),
@w_error                        int,
@w_cap_principal                varchar(10),
@w_vr_valor                     float,  --money,
@w_vr_valor_a                   float,  --money,
@w_secuencial_ref               int,
@w_concepto_asociado            varchar(10),
@w_principal                    char(1),
@w_tcero                        varchar(10),
@w_timbre                       varchar(10),
@w_redescuento                  float,
@w_tipo                         char(1),
@w_capital_financiado           varchar(10),
@w_saldo_operacion              char(1),
@w_saldo_por_desem              char(1),
@w_signo_pit                    char(1),
@w_spread_pit                   float,
@w_tasa_pit                     varchar(10),
@w_clase_pit                    char(1),
@w_porcentaje_pit               float,
@w_num_dec_tapl                 tinyint,
@w_rango_min                    money,
@w_rango_max                    money,
@w_limite                       char(1),
@w_categoria_rubro              varchar(10),
@w_categoria_cliente            varchar(10),
@w_porcentaje_categoria         tinyint,
@w_simulacion                   char(1),
@w_spread_pit_a                 float,
@w_num_dec_tapl_a               tinyint,
@w_signo_reaj_a                 char(1),
@w_concepto_a                   varchar(10),
@w_prioridad_a                  tinyint,
@w_tipo_rubro_a                 char(1),
@w_tipo_val_a                   varchar(10),
@w_paga_mora_a                  char(1),
@w_tipo_puntos_a                char(1),
@w_provisiona_a                 char(1),
@w_fpago_a                      char(1),
@w_periodo_a                    tinyint,
@w_referencial_a                varchar(10), --varchar(10),
@w_ref_reajuste_a               varchar(10), --varchar(10),
@w_concepto_asociado_a          varchar(10),
@w_principal_a                  char(1),
@w_redescuento_a                float,
@w_saldo_operacion_a            char(1),
@w_saldo_por_desem_a            char(1),
@w_pit_a                        varchar(10),
@w_limite_a                     char(1),
@w_valor_rubro_asociado         money,
@w_porcentaje_a                 float,
@w_signo_a                      char(1),
@w_tperiodo_a                   varchar(10),
@w_valor_rubro_a                money,
@w_signo_pit_a                  char(1),
@w_tasa_pit_a                   varchar(10),
@w_factor_a                     float,
@w_clase_pit_a                  char(1),
@w_factor_reaj_a                float,
@w_clase_a                      char(1),
@w_porcentaje_pit_a             float,
@w_tramite                      int,
@w_tipo_linea                   varchar(10),
@w_porcentaje_efa               float,
@w_ciudad                       int,
@w_iva_siempre                  char(1),
@w_ciudad_iva                   int,
@w_op_monto_aprobado            money,
@w_monto_aprobado               char(1),
@w_porcentaje_cobrar            float,
@w_valor_cliente                float,
@w_parametro_timbac             varchar(30),
@w_rubro_timbac                 varchar(10),
@w_valor_banco                  float,
@w_parametro_fag                varchar(10),
@w_mensaje                      int,
@w_tperiodo                     varchar(10),
@w_tipo_garantia                varchar(64),
@w_valor_garantia               char(1),
@w_porcentaje_cobertura         char(1),
@w_nro_garantia                 varchar(64),
@w_op_tdividendo                varchar(10),
@w_tabla_tasa                   varchar(30),
@w_base_calculo                 money,
@w_saldo_insoluto               char(1),
@w_porcentaje_cobrarc           float,
@w_tasa_fija                    varchar(10),
@w_regimen_fiscal               varchar(10),
@w_cobra_timbre                 char(1),
@w_calcular_devolucion          char(1),
@w_fecha                        datetime,
@w_exento                       char(1),
@w_concepto_conta_iva           varchar(10),
@w_op_oficina                   int,
@w_tipogar_hipo                 varchar(10),
@w_garhipo                      char(1),
@w_cotizacion                   float,
@w_moneda_local                 smallint,
@w_fecha_ult_proceso            datetime,
@w_rango                        tinyint,
@w_dias_div                     int,
@w_periodo_int                   smallint,
@w_plazo_en_meses               int,
@w_gracia_cap                   int,
@w_gracia_cap_meses             int,
@w_dias_plazo                   int,
@w_plazo                        int,
@w_op_tramite                   int,
@w_tplazo                       varchar(10),
@w_rowcount                     int,
@w_clase_cartera                char(1),
@w_parametro_fng                catalogo,
@w_rubro_fng                    char(1),
@w_cod_gar_fng                  catalogo,
@w_pmipymes                     catalogo,
@w_ivamipymes                   catalogo,
@w_ivafng                       catalogo,
@w_SMV                          money,
@w_nro_creditos                 int,
@w_cliente_nuevo                char(1),
@w_monto_parametro              float,
@w_factor_mipymes               float,
@w_parametro_fng_des            catalogo,
@w_parametro_fag_uni            catalogo,
@w_parametro_fga_uni            catalogo,  --req343
@w_parametro_fgu_uni            catalogo,
@w_cod_gar_fgu                  catalogo,
   --REQ 402
@w_parametro_fgu                varchar(10),
@w_colateral                    catalogo,
@w_garantia_sup                 varchar(10),
@w_garantia                     varchar(10),
@w_cod_garantia                 varchar(10),
@w_rubro                        char(1),
@w_tabla_rubro                  varchar(30),
@w_concepto_des                 varchar(10),
@w_concepto_per                 varchar(10),
@w_iva_des                      varchar(10),
@w_iva_per                      varchar(10),
@w_cont                         int,
@w_cod_gar_usaid                catalogo,
@w_cod_gar_fag                  catalogo,
@w_cod_gar_fga                  catalogo,
@w_garantia_genr                varchar(10),
@w_grupal                       char(1),
@w_id_inst_proc                 int,
@w_return                       int,
@w_es_partner                   varchar(255),
@w_atraso_ind                   varchar(255),
@w_valor_variable               varchar(255),
@w_num_ciclo_ente               int,
@w_promocion                    char(2),
@o_tasa_grp                     varchar(10),
@o_tasa_ind                     varchar(10),
@w_reduccion_tasa_grupal        float,
@w_min_porc_tasa_grupal         float,
@w_nem_solicitud                varchar(10),
@w_porcentaje_aux               float,
@w_operacion_ant                int,
@w_grupo                        int,
@w_referencia_ren_ant           varchar(30)

select  
@w_sp_name         = 'sp_gen_rubtmp',
@w_rango_min       = 0,
@w_rango_max       = 0,
@w_simulacion      = 'N',
@w_porcentaje_efa  = 0

create table #conceptos_gen (
codigo    varchar(10),
tipo_gar  varchar(64)
)

create table #rubros_gen (
garantia      varchar(10),
rre_concepto  varchar(64),
tipo_concepto varchar(10),
iva           varchar(5),
)

create table #colateral_genr(
tipo_sub   varchar(64) null
)

create table #garantias_operacion_genr(
w_tipo_garantia   varchar(64) null,
w_tipo            varchar(64) null,
estado            char(1),
w_garantia        varchar(64) null
)

--- LECTURA DE LOS DATOS DE LA OPERACION
select
@w_operacionca          = opt_operacion,
@w_cliente              = opt_cliente,
@w_toperacion           = opt_toperacion,
@w_moneda               = opt_moneda,
@w_fecha_ini            = opt_fecha_ini,
@w_monto                = opt_monto,
@w_sector               = opt_sector,
@w_dias_anio            = opt_dias_anio,
@w_tipo                 = opt_tipo,
@w_tipo_linea           = opt_tipo_linea,
@w_tramite              = opt_tramite,
@w_ciudad               = opt_ciudad,
@w_op_monto_aprobado    = opt_monto_aprobado,
@w_op_tdividendo        = opt_tdividendo,
@w_op_oficina           = opt_oficina,
@w_fecha_ult_proceso    = opt_fecha_ult_proceso,
@w_tplazo               = opt_tplazo,
@w_plazo                = opt_plazo,
@w_periodo_int          = opt_periodo_int,
@w_op_tramite           = opt_tramite,
@w_gracia_cap           = opt_gracia_cap,
@w_clase_cartera        = opt_clase
from  ca_operacion_tmp
where opt_operacion = @i_operacionca

if @w_rowcount = 0
   return 708153


/*CODIGO PADRE GARANTIA DE FNG*/
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION FNG
select @w_parametro_fng_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COFNGD'
set transaction isolation level read uncommitted

/*PARAMETRO DE LA GARANTIA DE FGA*/
select @w_parametro_fga_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFGA'

/*PARAMETRO DE LA GARANTIA DE FNG*/
select @w_parametro_fng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'
set transaction isolation level read uncommitted

/*PARAMETRO IVA DE LA GARANTIA DE FNG*/
select @w_ivafng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAFNG'
set transaction isolation level read uncommitted

/*PARAMETRO COMISION MIPYMES */
select @w_pmipymes = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MIPYME'
set transaction isolation level read uncommitted


/*PARAMETRO IVA COMISION MIPYMES */
select @w_ivamipymes = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAMIP'
set transaction isolation level read uncommitted

/*PARAMETRO COMISION FAG UNI*/
select @w_parametro_fag_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMUNI'

select @w_SMV      = pa_money
from   cobis..cl_parametro
where  pa_producto  = 'ADM'
and    pa_nemonico  = 'SMV'

/*PARAMETRO COMISION FGU UNI*/--REQ379

select @w_cod_gar_fgu = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODGAR'

select @w_parametro_fgu_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMGAR'

/*PARAMETRO DE LA GARANTIA DE FGU REQ 379*/
select @w_parametro_fgu = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'COMGRP'
set transaction isolation level read uncommitted

select @w_cod_gar_fga = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODFGA'

select @w_cod_gar_usaid = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODUSA'

select @w_cod_gar_fag = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODfag'

select @w_monto_parametro  = @w_monto/@w_SMV

-- SRO. PARAMETRO REDUCCION DE TASA GRUPAL
select @w_reduccion_tasa_grupal = isnull( pa_float, 3.0 )
from cobis..cl_parametro
where pa_nemonico               = 'RDTGRP'
and   pa_producto               = 'CRE'

-- SRO. PARAMETRO MINIMO TASA GRUPAL
select @w_min_porc_tasa_grupal = isnull( pa_float, 70.0 )
from cobis..cl_parametro
where pa_nemonico               = 'MNPRTG'
and   pa_producto               = 'CRE'

IF @w_clase_cartera <> 1
begin

   select @w_nro_creditos = count(1)
   from ca_operacion_tmp
   where opt_cliente = @w_cliente
   and opt_estado  in (0,1,2,3,4,5,9,99)

   if @w_nro_creditos = 1
      select @w_cliente_nuevo = 'N'     --N: new
   else
      select @w_cliente_nuevo = 'R'     --R: Renovado


   /*CALCULO DE LA TASA MIPYMES*/

   /*CALCULO DE LA TASA */
   exec  cob_cartera..sp_retona_valor_en_smlv
         @i_matriz       = @w_pmipymes,
         @i_monto        = @w_monto,
         @i_smv          = @w_SMV,
         @o_MontoEnSMLV  = @w_monto_parametro out

   if @w_monto_parametro  = -1
      select @w_monto_parametro = @w_monto / @w_SMV

   select @w_factor_mipymes = 0
   if @w_monto_parametro > 0
   begin
      exec @w_error     = sp_matriz_valor
           @i_matriz    = @w_pmipymes,
           @i_fecha_vig = @w_fecha_ult_proceso,
           @i_eje1      = @w_op_oficina,
           @i_eje2      = @w_monto_parametro,
           @i_eje3      = @w_cliente_nuevo,
           @o_valor     = @w_factor_mipymes out,
           @o_msg       = @w_msg    out

      if @w_error <> 0  return @w_error
   end

   select @w_factor_mipymes = isnull(@w_factor_mipymes,0)/100

end

---ACTUALIZACION DE TIPO DE DIVIDFENDO SEGUN LO DEFINIDO PARA LA OPERACION
---ESTO PARA LOS RUBROS CON PERIODICIDAD DIFERENTE A LA DE INTERES

---CODIGO DEL RUBRO TIMBRE
select @w_timbre = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'TIMBRE'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
   return 710120

select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro
WHERE  pa_nemonico = 'MLO'
AND    pa_producto = 'ADM'
set transaction isolation level read uncommitted


---NUMERO DE DECIMALES
exec @w_error = sp_decimales
@i_moneda    = @w_moneda,
@o_decimales = @w_num_dec out

if @w_error <> 0
   return @w_error


-- DETERMINAR EL VALOR DE COTIZACION DEL DIA
if @w_moneda = @w_moneda_local
   select @w_cotizacion = 1.0
else
begin
   exec sp_buscar_cotizacion
   @i_moneda     = @w_moneda,
   @i_fecha      = @w_fecha_ult_proceso,
   @o_cotizacion = @w_cotizacion output
end

update ca_rubro
set ru_tperiodo = @w_op_tdividendo
from ca_rubro
where ru_toperacion = @w_toperacion
and ru_tperiodo is not null


---LEO EL CODIGO DE CAPITAL PRINCIPAL
select @w_cap_principal = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAP'
set transaction isolation level read uncommitted

select @w_capital_financiado = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAPF'
set transaction isolation level read uncommitted


---CODIGO DEL RUBRO COMISION FAG
select @w_parametro_fag = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'COMFAG'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
   return  710370

   exec @w_error        = cob_cartera..sp_matriz_garantias
        @s_date         = @w_fecha_ult_proceso,
        @i_tramite      = @w_tramite,
        @i_tipo_periodo = 'P',
        @i_plazo        = @w_plazo,
        @i_tplazo       = @w_tplazo,
        @o_valor        = @w_factor out,
        @o_msg          = @w_msg out

   if @w_error <> 0  return @w_error

--- INSERCION DE LOS RUBROS DE LA OPERACION PARA RUBROS QUE NO TIENEN (RUBRO_ASOCIADO = NULL)
declare rubros cursor for
select  ru_concepto,            ru_prioridad,          ru_tipo_rubro,           ru_paga_mora,
        ru_provisiona,          ru_fpago,              ru_periodo,              ru_referencial,
        ru_reajuste,            ru_concepto_asociado,  ru_principal,            ru_redescuento,
        ru_saldo_op,            ru_saldo_por_desem,    ru_pit,                  ru_limite,
        ru_iva_siempre,         ru_monto_aprobado,     ru_porcentaje_cobrar,    ru_tperiodo,
        ru_tipo_garantia,       ru_valor_garantia,     ru_porcentaje_cobertura, ru_tabla,
        ru_saldo_insoluto,      ru_calcular_devolucion
from ca_rubro
where ru_toperacion      = @w_toperacion
and ru_moneda            = @w_moneda
and ru_estado            = 'V'
and ru_crear_siempre     = 'S'
and ru_concepto_asociado is null

union

select  ru_concepto,            ru_prioridad,          ru_tipo_rubro,           ru_paga_mora,
        ru_provisiona,          ru_fpago,              ru_periodo,              ru_referencial,
        ru_reajuste,            ru_concepto_asociado,  ru_principal,            ru_redescuento,
        ru_saldo_op,            ru_saldo_por_desem,    ru_pit,                  ru_limite,
        ru_iva_siempre,         ru_monto_aprobado,     ru_porcentaje_cobrar,    ru_tperiodo,
        ru_tipo_garantia,       ru_valor_garantia,     ru_porcentaje_cobertura, ru_tabla,
        ru_saldo_insoluto,      ru_calcular_devolucion
from ca_rubro, ca_rubro_colateral
where ru_toperacion      = @w_toperacion
and ru_moneda            = @w_moneda
and ru_estado            = 'V'
and ru_crear_siempre     = 'N'
and @i_operacionca       = ruc_operacion
and ru_concepto          = ruc_concepto
and ru_concepto_asociado is null
for read only

open rubros

fetch rubros into
         @w_concepto,         @w_prioridad,         @w_tipo_rubro,           @w_paga_mora,
         @w_provisiona,       @w_fpago,             @w_periodo,              @w_referencial,
         @w_ref_reajuste,     @w_concepto_asociado, @w_principal,            @w_redescuento,
         @w_saldo_operacion,  @w_saldo_por_desem,   @w_pit,                  @w_limite,
         @w_iva_siempre,      @w_monto_aprobado,    @w_porcentaje_cobrar,    @w_tperiodo,
         @w_tipo_garantia,    @w_valor_garantia,    @w_porcentaje_cobertura, @w_tabla_tasa,
         @w_saldo_insoluto,   @w_calcular_devolucion

while (@@fetch_status  = 0)
begin

   if (@@fetch_status <> 0)
   begin
       close rubros
       deallocate rubros
       return 710124
   end

   ---INICIAR VARIABLES
   select
   @w_porcentaje     = 0,
   @w_valor_rubro    = 0,
   @w_vr_valor       = 0,
   @w_signo          = null,
   @w_factor         = 0,
   @w_signo_reaj     = null,
   @w_factor_reaj    = 0,
   @w_tipo_val       = null,
   @w_clase          = null,
   @w_signo_pit      = null,
   @w_spread_pit     = 0,
   @w_tasa_pit       = null,
   @w_clase_pit      = null,
   @w_porcentaje_pit = 0,
   @w_num_dec_tapl   = null,
   @w_porcentaje_efa = 0

   if @w_clase_cartera = 1 and (@w_concepto = @w_pmipymes or @w_concepto = @w_ivamipymes)  begin
      goto NEXT
   end

   select @w_categoria_rubro = co_categoria
   from ca_concepto
   where co_concepto = @w_concepto

      --PARA LAS OBLIGACIONES CON GARANTIA HIPOTECARIA EL VALOR DEL TIMBRE ES 0
   if @w_concepto = @w_timbre
   begin
      select @w_limite = 'S',
             @w_garhipo = 'N'

      select @w_tipogar_hipo = pa_char
      from cobis..cl_parametro
      where pa_producto = 'CCA'
      and   pa_nemonico = 'GARHIP'
      set transaction isolation level read uncommitted

      if exists (select 1
                   from cob_credito..cr_gar_propuesta,cob_custodia..cu_custodia,cob_custodia..cu_tipo_custodia
                  where cu_codigo_externo = gp_garantia
                    and gp_tramite = @w_tramite
                    and tc_tipo = cu_tipo
                    and tc_tipo_superior = @w_tipogar_hipo )
      select @w_garhipo = 'S'
   end


   if not @w_pit is null and @w_pit <> ''
   begin
      select
      @w_signo_pit    = isnull(vd_signo_default,' '),
      @w_spread_pit   = isnull(vd_valor_default,0),
      @w_tasa_pit     = vd_referencia,
      @w_clase_pit    = va_clase
      from    ca_valor,ca_valor_det
      where   va_tipo   = @w_pit
      and     vd_tipo   = @w_pit
      and     vd_sector = @w_sector

      if @@rowcount = 0 and @w_tipo_rubro in('I')
      begin
         print 'primer..err'
		 close rubros
         deallocate rubros
         return 721401
      end

      ---DETERMINACION DEL MAXIMO SECUENCIAL PARA LA TASA ENCONTRADA
      select @w_fecha = max(vr_fecha_vig)
      from   ca_valor_referencial
      where  vr_tipo = @w_tasa_pit
      and    vr_fecha_vig <= @w_fecha_ini

      select @w_secuencial_ref = max(vr_secuencial)
      from   ca_valor_referencial
      where  vr_tipo = @w_tasa_pit
      and    vr_fecha_vig = @w_fecha

      --- DETERMINACION DEL VALOR DE TASA A APLICAR
      select @w_vr_valor = vr_valor
      from   ca_valor_referencial
      where  vr_tipo       = @w_tasa_pit
      and    vr_secuencial = @w_secuencial_ref

      if @w_clase_pit = 'V'
      begin
         if @w_tipo_rubro in ('I')
            select  @w_porcentaje_pit = @w_spread_pit,
               @w_spread_pit = 0
      end
      else
      begin
         if @w_tipo_rubro in ('I')
         begin
            if @w_signo_pit = '+'
               select  @w_porcentaje_pit =  @w_vr_valor + @w_spread_pit
            if @w_signo_pit = '-'
               select  @w_porcentaje_pit =  @w_vr_valor - @w_spread_pit
            if @w_signo_pit = '/'
               select  @w_porcentaje_pit =  @w_vr_valor / @w_spread_pit
            if @w_signo_pit = '*'
               select  @w_porcentaje_pit =  @w_vr_valor * @w_spread_pit
         end
      end
   end  --fin de pit
   else
   begin
      select
      @w_signo        = isnull(vd_signo_default,' '),
      @w_factor       = isnull(vd_valor_default,0),
      @w_tipo_val     = vd_referencia,
      @w_tipo_puntos  = vd_tipo_puntos,
      @w_clase        = va_clase,
      @w_num_dec_tapl = vd_num_dec
      from    ca_valor,ca_valor_det
      where   va_tipo   =  @w_referencial     --'T-IMO-COM'
      and     vd_tipo   =  @w_referencial     --'T-IMO-COM'
      and     vd_sector =  @w_sector          --'1'

      if @@rowcount = 0 and @w_tipo_rubro in('I','M')
      begin
	     print '(genrtmp.sp) 1. Parametrizar Tasas para rubro.. @w_sector' + cast(@w_referencial as varchar) + @w_sector
	      print '@w_referencial..' + convert(VARCHAR(50),@w_referencial)
	      print '@w_sector..' + convert(VARCHAR(50),@w_sector)
         close rubros
         deallocate rubros
         return 721401
      end

 --REQ 402
   select @w_colateral = pa_char
   from cobis..cl_parametro with (nolock)
   where pa_producto = 'GAR'
   and   pa_nemonico = 'GARESP'

   insert into #colateral_genr
   select tc_tipo
   --into #colateral_genr
   from cob_custodia..cu_tipo_custodia
   where tc_tipo_superior = @w_colateral


   insert into #garantias_operacion_genr
   select tc_tipo_superior,
          tc_tipo,
          'I',
          cu_codigo_externo
   from cob_custodia..cu_custodia, #colateral_genr, cob_credito..cr_gar_propuesta, cob_custodia..cu_tipo_custodia
   Where cu_tipo = tc_tipo
   and   tc_tipo_superior = tipo_sub
   and   gp_tramite  = @w_tramite
   and   gp_garantia = cu_codigo_externo
   and   cu_estado  in ('V','F','P')

   select @w_garantia       = w_tipo,
          @w_garantia_sup   = w_tipo_garantia
   from #garantias_operacion_genr

   select @w_rubro = valor
   from  cobis..cl_tabla t, cobis..cl_catalogo c
   where t.tabla  = 'ca_conceptos_rubros'
   and   c.tabla  = t.codigo
   and   c.codigo = convert(bigint, @w_garantia)


   if @w_rubro = 'S' begin

      select @w_tabla_rubro = 'ca_conceptos_rubros_' + cast(@w_garantia as varchar)

      insert into #conceptos_gen
      select
      codigo = c.codigo,
      tipo_gar = @w_garantia
      from cobis..cl_tabla t, cobis..cl_catalogo c
      where t.tabla  = @w_tabla_rubro
      and   c.tabla  = t.codigo

   end

   /*COMICION DESEMBOLSO*/
   insert into #rubros_gen
   select tipo_gar, ru_concepto, 'DES', 'N'
   from cob_cartera..ca_rubro, #conceptos_gen
   where ru_fpago = 'L'
   and   codigo   = ru_concepto
   and   ru_concepto_asociado is null

   /*COMICION PERIODICO*/
   insert into #rubros_gen
   select tipo_gar, ru_concepto, 'PER', 'N'
   from cob_cartera..ca_rubro, #conceptos_gen
   where ru_fpago = 'P'
   and   codigo   = ru_concepto
   and   ru_concepto_asociado is null

   /*IVA DESEMBOLSO*/
   insert into #rubros_gen
   select tipo_gar, ru_concepto, 'DES', 'S'
   from cob_cartera..ca_rubro, #conceptos_gen
   where ru_fpago = 'L'
   and   codigo   = ru_concepto
   and   ru_concepto_asociado is not null

   /*IVA PERIODICO*/
   insert into #rubros_gen
   select tipo_gar, ru_concepto, 'PER', 'S'
   from cob_cartera..ca_rubro, #conceptos_gen
   where ru_fpago = 'P'
   and   codigo   = ru_concepto
   and   ru_concepto_asociado is not null

   --CAPTURA DE CONCEPTOS
   select @w_concepto_des = rre_concepto
   from #rubros_gen
   where tipo_concepto = 'DES'
   and iva = 'N'


   select @w_concepto_per = rre_concepto
   from #rubros_gen
   where tipo_concepto = 'PER'
   and iva = 'N'

   select @w_iva_des = rre_concepto
   from #rubros_gen
   where tipo_concepto = 'DES'
   and iva = 'S'

   select @w_iva_per = rre_concepto
   from #rubros_gen
   where tipo_concepto = 'PER'
   and iva = 'S'

   select @w_garantia_genr = garantia
   from   #rubros_gen
   where tipo_concepto = 'DES'
   and iva = 'N'


   ---DETERMINACION DEL MAXIMO SECUENCIAL PARA LA TASA ENCONTRADA
   if @w_clase <> 'V'
   begin
   
      select @w_fecha = max(vr_fecha_vig)
      from   ca_valor_referencial
      where  vr_tipo = @w_tipo_val
      and    vr_fecha_vig <= @w_fecha_ini
   
      select @w_secuencial_ref = max(vr_secuencial)
      from   ca_valor_referencial
      where  vr_tipo = @w_tipo_val
      and    vr_fecha_vig = @w_fecha
   
   
      --- DETERMINACION DEL VALOR DE TASA A APLICAR
      select @w_vr_valor = vr_valor
      from   ca_valor_referencial
      where  vr_tipo       = @w_tipo_val
      and    vr_secuencial = @w_secuencial_ref
   end
   else
      select @w_vr_valor =  @w_factor

      if @w_concepto in (@w_parametro_fng,@w_parametro_fng_des, @w_concepto_des, @w_concepto_per) and @w_cod_gar_fng = @w_garantia_sup
      begin

         --CALCULO DE LA TASA  PARA LOS FNG ANUALES O DEL DESEMBOLSO
         exec cob_cartera..sp_retona_valor_en_smlv
              @i_matriz         = @w_parametro_fng,
              @i_monto          = @w_monto,
              @i_smv            = @w_SMV,
              @o_MontoEnSMLV    = @w_monto_parametro out

         if @w_monto_parametro  = -1
              select @w_monto_parametro = @w_monto / @w_SMV

         select @w_porcentaje = 0

         if @w_monto_parametro > 0
         begin
            exec @w_error     = sp_matriz_valor
                 @i_matriz    = @w_parametro_fng,
                 @i_fecha_vig = @w_fecha_ult_proceso,
                 @i_eje1      = @w_monto_parametro,
                 @o_valor     = @w_porcentaje out,
                 @o_msg       = @w_msg    out

            if @w_error <> 0  
			begin 
			   close rubros
               deallocate rubros
			   return @w_error
            end
		 end

         select @w_vr_valor =   @w_porcentaje,
                @w_factor   =   @w_porcentaje

      end

      if @w_concepto in (@w_parametro_fag_uni, @w_concepto_des, @w_concepto_per) and @w_cod_gar_fag = @w_garantia_sup
      begin

         --CALCULO DE LA TASA PARA LAS FAG UNICAS
         exec @w_error        = cob_cartera..sp_matriz_garantias
              @s_date         = @w_fecha_ult_proceso,
              @i_tramite      = @w_tramite,
              @i_tipo_periodo = 'P',
              @i_plazo        = @w_plazo,
              @i_tplazo       = @w_tplazo,
              @o_valor        = @w_factor out,
              @o_msg          = @w_msg out

         select @w_vr_valor =   @w_factor,
                @w_factor   =   @w_factor

      end

     if @w_concepto in (@w_parametro_fga_uni, @w_concepto_des, @w_concepto_per) and @w_cod_gar_fga = @w_garantia_sup
     begin

        --CALCULO DE LA TASA PARA LAS FGA ANTIOQUIA
        exec @w_error   = cob_cartera..sp_matriz_garantias
             @s_date    = @w_fecha_ult_proceso,
             @i_tramite = @w_tramite,
             @o_valor   = @w_porcentaje out,
             @o_msg     = @w_msg out

        select @w_vr_valor =   @w_porcentaje,
               @w_factor   =   @w_porcentaje

     end

     if @w_concepto in (@w_parametro_fgu_uni, @w_parametro_fgu) and @w_cod_gar_fgu = @w_garantia_sup
     begin

        --CALCULO DE LA TASA PARA LAS FGU UNIFICADA REQ379
        exec @w_error   = cob_cartera..sp_matriz_garantias
             @s_date    = @w_fecha_ult_proceso,
             @i_tramite = @w_tramite,
             @o_valor   = @w_porcentaje out,
             @o_msg     = @w_msg out


        select @w_vr_valor =   @w_porcentaje,
               @w_factor   =   @w_porcentaje

     end

     ---VALORES PARA RUBRO CALCULADOS  CON  TABLAS DE  RANGOS
     if @w_tipo_rubro = 'Q' and @w_limite = 'S'
     begin ---(4)
        ---NR 293
        ---CUANTOS DIAS TIENE UNA CUOTA DE INTERES
        select @w_dias_div = td_factor *  @w_periodo_int
        from   ca_tdividendo
        where  td_tdividendo = @w_op_tdividendo

        select @w_dias_plazo = td_factor
        from   ca_tdividendo
        where  td_tdividendo = @w_tplazo

        select @w_plazo_en_meses = isnull((@w_plazo * @w_dias_plazo)/30,0)

        select @w_gracia_cap_meses = 0
        if  @w_gracia_cap > 0
            select @w_gracia_cap_meses = isnull((@w_dias_div * @w_gracia_cap) / 30,0)

        exec @w_error                 = sp_rubros_limites_de_rangos
             @i_monto_desembolsado    = @w_monto,
             @i_concepto              = @w_concepto,
             @i_tramite               = @w_op_tramite,
             @i_dias_div              = @w_dias_div,
             @i_plazo_en_meses        = @w_plazo_en_meses,
             @i_porcentaje_cobertura  = @w_porcentaje_cobertura,
             @i_valor_garantia        = @w_valor_garantia,
             @i_gracia_cap_meses      = @w_gracia_cap_meses,
             @i_tipo_garantia         = @w_tipo_garantia,
             @i_num_dec               = @w_num_dec,
             @i_op_monto_aprobado     = @w_op_monto_aprobado,
             @i_cotizacion            = @w_cotizacion,
             @i_tasa                  = @w_vr_valor,
             @i_parametro_timbre      = @w_timbre,
             @i_fecha_ini             = @w_fecha_ini,
             @o_tasa_calculo          = @w_porcentaje out,
             @o_nro_garantia          = @w_nro_garantia out,
             @o_base_calculo          = @w_base_calculo out,
             @o_valor_rubro           = @w_valor_rubro out

        if @w_error <> 0
		begin
           close rubros
           deallocate rubros
		   return @w_error
		end

        select @w_valor_rubro = round(@w_valor_rubro,@w_num_dec)

        --Generacion del rubro TIMBAC
        if @w_porcentaje_cobrar <> 100  and @w_concepto = @w_timbre
        begin  --(1)

           select @w_porcentaje_cobrarc = 100 - @w_porcentaje_cobrar
           select @w_valor_cliente      = (@w_valor_rubro * @w_porcentaje_cobrar)/100
           select @w_valor_banco        = (@w_valor_rubro - @w_valor_cliente)
           select @w_valor_rubro        = @w_valor_cliente   -- Lo que realmente se le cobra al cliente

           select @w_parametro_timbac = pa_char
           from cobis..cl_parametro
           where pa_producto = 'CCA'
           and   pa_nemonico = 'TIMBAC'
           if @@rowcount =  0
		   begin
              close rubros
              deallocate rubros
			  return 710363
		   end

           select @w_rubro_timbac = co_concepto
           from ca_concepto
           where co_concepto = @w_parametro_timbac
           if @@rowcount =  0
		   begin
              close rubros
              deallocate rubros
			  return  710364
		   end

           if @w_valor_banco = null
              select @w_valor_banco = 0

           insert into ca_rubro_op_tmp(
           rot_operacion,            rot_concepto,          rot_tipo_rubro,
           rot_fpago,                rot_prioridad,         rot_paga_mora,
           rot_provisiona,           rot_signo,             rot_factor,
           rot_referencial,          rot_signo_reajuste,    rot_factor_reajuste,
           rot_referencial_reajuste, rot_valor,             rot_porcentaje,

           rot_porcentaje_aux,       rot_gracia,            rot_concepto_asociado,
           rot_principal,            rot_porcentaje_efa,    rot_garantia,

           rot_tipo_puntos,          rot_saldo_op,          rot_saldo_por_desem,
           rot_num_dec,              rot_limite,            rot_monto_aprobado,
           rot_porcentaje_cobrar,    rot_base_calculo,      rot_tabla)
           values(
           @w_operacionca,           @w_rubro_timbac,       @w_tipo_rubro,
           'B',                      @w_prioridad,          @w_paga_mora,
           @w_provisiona,            @w_signo,              @w_factor,
           @w_referencial,           @w_signo_reaj,         @w_factor_reaj,
           @w_ref_reajuste,          @w_valor_banco,        @w_porcentaje,
           -- LGU-ini: colocar el valor correcto de gracia y porcentaje
         --@w_porcentaje,            @w_porcentaje_efa,     @w_concepto_asociado,
         --@w_principal,             0,                     0,
           @w_porcentaje,            0,                     @w_concepto_asociado,
           @w_principal,             @w_porcentaje_efa,     0,
           -- LGU-fin: colocar el valor correcto de gracia y porcentaje
           @w_tipo_puntos,           @w_saldo_operacion,    @w_saldo_por_desem,
           @w_num_dec_tapl,          @w_limite,             @w_monto_aprobado,
           @w_porcentaje_cobrarc,    @w_base_calculo,       @w_tabla_tasa)

           if @@error <> 0
           begin
              close rubros
              deallocate rubros
              return 721406
           end

           --SI EL BANCO ASUME EL TIMBRE, EL CLIENTE NO PAGA NADA
           select @w_valor_rubro = 0.0
        end   -----(1) Generacion del TIMBAC
     end  --  (4)FIN VALORES PARA RUBRO CALCULADOS  CON  TABLAS DE  RANGOS
     else
     begin  ---CALCULADOS SIN LIMITE
        if @w_tipo_rubro = 'Q' and @w_limite <> 'S'
        begin
           exec @w_error                 = sp_rubro_calculado
                @i_tipo                  = 'Q',
                @i_monto                 = 0,
                @i_concepto              = @w_concepto,
                @i_operacion             = @w_operacionca,
                @i_saldo_op              = @w_saldo_operacion,
                @i_saldo_por_desem       = @w_saldo_por_desem,
                @i_porcentaje            = @w_porcentaje,
                @i_monto_aprobado        = @w_monto_aprobado,
                @i_op_monto_aprobado     = @w_op_monto_aprobado,
                @i_porcentaje_cobertura  = @w_porcentaje_cobertura,
                @i_valor_garantia        = @w_valor_garantia,
                @i_tipo_garantia         = @w_tipo_garantia,
                @i_parametro_fag         = @w_parametro_fag,
                @i_tabla_tasa            = @w_tabla_tasa,
                @i_categoria_rubro       = @w_categoria_rubro,
                @i_fpago                 = @w_fpago,
                @i_saldo_insoluto        = @w_saldo_insoluto,
                @o_tasa_calculo          = @w_porcentaje out,
                @o_nro_garantia          = @w_nro_garantia out,
                @o_base_calculo          = @w_base_calculo out,
                @o_valor_rubro           = @w_valor_rubro out

           if @w_error <> 0
		   begin
              close rubros
              deallocate rubros
			  return @w_error
           end
           select @w_valor_rubro = round(@w_valor_rubro,@w_num_dec)
        end
     end ---CALCULADOS SIN LIMITE

     if @w_tipo_rubro <> 'Q' and @w_limite = 'S'
     begin
        PRINT 'genrtmp.sp rubro no calculado  y parametrizado con limite, debe ser programado' + cast(@w_concepto as varchar)
		close rubros
        deallocate rubros
        return 721405
     end

     if @w_tipo_rubro = 'I'
     begin
        select
        @w_signo_reaj    = isnull(vd_signo_default,' '),
        @w_factor_reaj   = isnull(vd_valor_default,0)
        from    ca_valor,ca_valor_det
        where   va_tipo   = @w_ref_reajuste
        and     vd_tipo   = @w_ref_reajuste
        and     vd_sector = @w_sector
     end

     if @w_clase = 'V'  --TASA VALOR
     begin

        if @w_tipo_rubro in ('O','I','M','Q')
           select  @w_porcentaje     = @w_factor ,
                   @w_factor         = 0,
                   @w_porcentaje_efa = @w_factor
        else
           select  @w_valor_rubro = round(@w_factor,@w_num_dec) ,
                   @w_factor = 0
     end
     else                --TASA REFERENCIAL
     begin
        if @w_tipo_rubro in ('O','I','M','Q')
        begin

			if @w_signo = '+'
			  select  @w_porcentaje =  @w_vr_valor + @w_factor
			if @w_signo = '-'
			  select  @w_porcentaje =  @w_vr_valor - @w_factor
			if @w_signo = '/'
			  select  @w_porcentaje =  @w_vr_valor / @w_factor
			if @w_signo = '*'
			  select  @w_porcentaje =  @w_vr_valor * @w_factor

			if @w_tipo_rubro = 'I' and @w_toperacion = 'GRUPAL' begin
			   
			   select @w_tramite  = op_tramite 
			   from cob_cartera..ca_operacion 
			   where op_operacion =  @i_operacionca	

               if @w_tramite <> 0 begin 
			   
                  select 
                  @w_nem_solicitud        = pr_nemonico,
			      @w_grupo                = io_campo_1
                  from   cob_workflow..wf_inst_proceso, cob_workflow..wf_proceso
                  where  io_codigo_proc   = pr_codigo_proceso
                  and    io_campo_3       = @w_tramite
			      and    io_campo_7       = 'S'
			      			   
			      if @@rowcount = 0 begin
			   
			         select distinct @w_tramite  = tg_tramite 
				     from cob_credito..cr_tramite_grupal 
				     where tg_operacion = @i_operacionca
				     
				     select 
                     @w_nem_solicitud        = pr_nemonico,
			         @w_grupo                = io_campo_1
                     from   cob_workflow..wf_inst_proceso, cob_workflow..wf_proceso
                     where  io_codigo_proc   = pr_codigo_proceso
                     and    io_campo_3       = @w_tramite
			         and    io_campo_7       = 'S'
				  
				     if @@rowcount = 0 return 2108035
			      
			      end			   			   
			   
			      if @w_nem_solicitud = 'CRRENGR' begin 
			   
			         select @w_porcentaje_aux = or_tasa_ciclo_ant
	                 from cob_credito..cr_op_renovar
	                 where or_tramite      = @w_tramite	
	                 
                     select @w_porcentaje = @w_porcentaje_aux - @w_reduccion_tasa_grupal 
	                 if @w_porcentaje < @w_min_porc_tasa_grupal select @w_porcentaje = convert(float, @w_porcentaje_aux)
			   
			      end else begin
			   
			         if exists (select 1 from cob_credito..cr_op_renovar where or_grupo = @w_grupo ) begin 
				     
                        select @w_referencia_ren_ant = max(or_referencia_grupal) 
                        from  cob_credito..cr_op_renovar 
                        where or_grupo               = @w_grupo
                        
                        select @w_operacion_ant = op_operacion
                        from  cob_cartera..ca_operacion
                        where op_banco          = @w_referencia_ren_ant
                        
                        select @w_porcentaje  = ro_porcentaje 
                        from cob_cartera..ca_rubro_op
                        where ro_operacion    = @w_operacion_ant
                        and   ro_concepto     = 'INT'
				     
	                 end else begin
				     
			            if @i_promocion = 'S' begin
				        
				           print 'sp_gen_rubtmp SMO RECALCULA PARA EL PROMO!!!'				   
				           
				           exec @w_return = cob_credito..sp_grupal_reglas
				           @s_ofi         = @s_ofi ,
				           @t_trn         = 1111    ,
				           @s_user        = @s_user ,
				           @s_term        = @s_term ,
				           @s_date        = @s_date ,
				           @i_tramite     = @w_tramite,
				           @i_valida_part = 'N',
				           @i_id_rule     = 'TASA_GRP',  -- encontral la tasa grupal
				           @o_resultado   = @o_tasa_grp out
				            
				           if @w_return <> 0 begin
				           	exec cobis..sp_cerror
				           	@t_debug = @t_debug,
				           	@t_file  = @t_file,
				           	@t_from  = @w_sp_name,
				           	@i_num   = 21008,
				           	@i_msg   = 'Error al determinar la tasa grupal'
				           end
				           			        
				           select @w_porcentaje = convert(float, @o_tasa_grp)
                         end
				      
				     end				   
				   end				
				end 
			    print 'SMO PORCENTAJE PARA EL PROMO @w_porcentaje '+ convert(varchar, @w_porcentaje)
			end
			
			if @w_tipo_rubro = 'I' and @w_toperacion = 'INDIVIDUAL'
			begin
				print 'sp_gen_rubtmp POV Tasa Regla Individual!!!'
				
				exec @w_return = cob_credito..sp_var_es_partner_int
					@i_ente   = @w_cliente,
					@o_resultado = @w_es_partner output
				if @w_return <> 0 begin
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_num   = 21008,
					@i_msg   = 'Error al determinar si el cliente es Partner'
				end
				
				/* CICLO INDIVIDUAL */
				select @w_num_ciclo_ente = isnull(en_nro_ciclo,0) 
				from cobis..cl_ente where en_ente=@w_cliente
				
				if @w_num_ciclo_ente = 0
				   select @w_num_ciclo_ente = 1
				else 
				   select @w_num_ciclo_ente = @w_num_ciclo_ente + 1
				
				/* ATRASO IND */
				exec @w_return = cob_credito..sp_var_porc_atra_ind_int
					@i_ente         = @w_cliente,    
					@o_resultado    = @w_atraso_ind output
				if @w_return <> 0 begin
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_num   = 21008,
					@i_msg   = 'Error al determinar el procentaje de atraso individual anterior'
				end
				
				if @i_promocion = 'S'
					select @w_promocion = 'SI'
				else if @i_promocion = 'N'
					select @w_promocion = 'NO'
				
				select @w_valor_variable = @w_es_partner + '|' + @w_promocion + '|' + convert(varchar, @w_num_ciclo_ente) + '|' + @w_atraso_ind 
				
				print 'El resultado de las variables es: ' + @w_valor_variable
				
				exec @w_error           = cob_cartera..sp_ejecutar_regla
					--@s_ssn                  = @s_ssn,
					@s_ofi                  = @s_ofi,
					@s_user                 = @s_user,
					@s_date                 = @s_date,
					--@s_srv                  = @s_srv,
					@s_term                 = @s_term,
					--@s_rol                  = @s_rol,
					--@s_lsrv                 = @s_lsrv,
					--@s_sesn                 = @s_sesn,
					@i_regla                = 'TASA_IND', 	 
					@i_valor_variable_regla = @w_valor_variable,
					@i_tipo_ejecucion       = 'REGLA',
					@o_resultado1           = @o_tasa_ind out
				
				if @w_return <> 0 begin
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_num   = 21008,
					@i_msg   = 'Error al determinar la tasa individual'
				end
				
				print 'POV Tasa individual: '+@o_tasa_grp
				select @w_porcentaje = convert(float, @o_tasa_ind)
			end
              
           ---Esta tasa es la misma  nominal ya que no hay conversion de tasa
           select @w_porcentaje_efa = @w_porcentaje
        end
        else
        if @w_tipo_rubro in ('C','V')
        begin
           if @w_signo = '+'
              select  @w_valor_rubro = round(@w_vr_valor+@w_factor,@w_num_dec)
           if @w_signo = '-'
              select  @w_valor_rubro = round(@w_vr_valor-@w_factor, @w_num_dec)
           if @w_signo = '/'
              select  @w_valor_rubro = round(@w_vr_valor/@w_factor, @w_num_dec)
           if @w_signo = '*'
              select  @w_valor_rubro = round(@w_vr_valor*@w_factor, @w_num_dec)
        end
     end

     select @w_redescuento = 0
     
     --JSA Santander
     if @w_tipo_rubro = 'I'
        select @w_porcentaje = isnull(@i_tasa, @w_porcentaje)

     --- CAPITAL PRINCIPAL
     if @w_tipo_rubro = 'C' and @w_concepto = @w_cap_principal
        select @w_valor_rubro = round(@w_monto,@w_num_dec)

     if @w_tipo_rubro = 'C' and @w_tipo = 'C' and @w_redescuento > 0
        select @w_valor_rubro = @w_monto*@w_redescuento/100.0

     --- CAPITAL FINACIADO
     if @w_tipo_rubro = 'C' and @w_concepto = @w_capital_financiado and @w_redescuento > 0
        select @w_valor_rubro = @w_monto*@w_redescuento/100.0

     if @w_fpago = 'L' or @w_fpago = 'A' or @w_fpago = 'P' or @w_fpago = 'T'
     begin
        if @w_tipo_rubro in ('O','I')
        begin
           select @w_valor_rubro = round(@w_porcentaje * @w_monto/100.0 + isnull(@w_valor_rubro,0), @w_num_dec)
        end
     end
   end  --DETERMINACION DE LA TASA A APLICAR


   if @w_valor_rubro is null or @w_tipo_rubro = 'M'
      select @w_valor_rubro = 0


   if @w_pmipymes = @w_concepto   --El calculo de la tasa se realiza basado en la matriz de parametrizacion
      select @w_porcentaje     = @w_factor_mipymes,
             @w_porcentaje_efa = @w_factor_mipymes


   insert into ca_rubro_op_tmp
   (
   rot_operacion,           rot_concepto,        rot_tipo_rubro,
   rot_fpago,               rot_prioridad,       rot_paga_mora,
   rot_provisiona,          rot_signo,           rot_factor,
   rot_referencial,         rot_signo_reajuste,  rot_factor_reajuste,
   rot_referencial_reajuste,rot_valor,           rot_porcentaje,
   rot_porcentaje_aux,      rot_gracia,          rot_concepto_asociado,
   rot_principal,           rot_porcentaje_efa,  rot_garantia,
   rot_tipo_puntos,         rot_saldo_op,        rot_saldo_por_desem,
   rot_num_dec,             rot_limite,          rot_tipo_garantia,
   rot_nro_garantia,        rot_porcentaje_cobertura,   rot_valor_garantia,
   rot_tperiodo,            rot_periodo,         rot_base_calculo,
   rot_tabla,               rot_porcentaje_cobrar,   rot_calcular_devolucion,
   rot_saldo_insoluto
   )
   values
   (
   @w_operacionca,          @w_concepto,               @w_tipo_rubro,
   @w_fpago,                @w_prioridad,              @w_paga_mora,
   @w_provisiona,           @w_signo,                  @w_factor,
   @w_referencial,          @w_signo_reaj,             @w_factor_reaj,
   @w_ref_reajuste,         @w_valor_rubro,            @w_porcentaje,
   -- LGU-ini: colocar el valor correcto de gracia y porcentaje para INT
-- @w_porcentaje,           @w_porcentaje_efa,         @w_concepto_asociado,
-- @w_principal,            0,                         0,
   @w_porcentaje,           0,                         @w_concepto_asociado,
   @w_principal,            @w_porcentaje_efa,                         0,
   -- LGU-fin: colocar el valor correcto de gracia y porcentaje para INT
   @w_tipo_puntos,          @w_saldo_operacion,        @w_saldo_por_desem,
   @w_num_dec_tapl,         @w_limite,                 @w_tipo_garantia,
   @w_nro_garantia,         @w_porcentaje_cobertura,   @w_valor_garantia,
   @w_tperiodo,             @w_periodo,                @w_base_calculo,
   @w_tabla_tasa,           @w_porcentaje_cobrar,      @w_calcular_devolucion,
   @w_saldo_insoluto
   )

   if @@error <> 0
   begin
     close rubros
     deallocate rubros
     return 721407
   end
   NEXT:
   fetch rubros into
         @w_concepto,         @w_prioridad,         @w_tipo_rubro,           @w_paga_mora,
         @w_provisiona,       @w_fpago,             @w_periodo,              @w_referencial,
         @w_ref_reajuste,     @w_concepto_asociado, @w_principal,            @w_redescuento,
         @w_saldo_operacion,  @w_saldo_por_desem,   @w_pit,                  @w_limite,
         @w_iva_siempre,      @w_monto_aprobado,    @w_porcentaje_cobrar,    @w_tperiodo,
         @w_tipo_garantia,    @w_valor_garantia,    @w_porcentaje_cobertura, @w_tabla_tasa,
         @w_saldo_insoluto,   @w_calcular_devolucion
end

close rubros
deallocate rubros

---INSERCION DE LOS RUBROS DE LA OPERACION PARA RUBRO ASOCIADO  <> NULL, POR LO GENERAL RUBRO IVA
declare rubros_asociados cursor for
select  ru_concepto,   ru_prioridad,          ru_tipo_rubro,   ru_paga_mora,
        ru_provisiona, ru_fpago,              ru_periodo,      ru_referencial,
        ru_reajuste,   ru_concepto_asociado,  ru_principal,    ru_redescuento,
        ru_saldo_op,   ru_saldo_por_desem,    ru_pit,          ru_limite,
        ru_iva_siempre, ru_tperiodo,          ru_saldo_insoluto
from ca_rubro
where ru_toperacion  = @w_toperacion
and ru_moneda        = @w_moneda
and ru_estado        = 'V'
and ru_crear_siempre = 'S'
and ru_concepto_asociado is not null

union

select  ru_concepto,   ru_prioridad,          ru_tipo_rubro,   ru_paga_mora,
        ru_provisiona, ru_fpago,              ru_periodo,      ru_referencial,
        ru_reajuste,   ru_concepto_asociado,  ru_principal,    ru_redescuento,
        ru_saldo_op,   ru_saldo_por_desem,    ru_pit,          ru_limite,
        ru_iva_siempre, ru_tperiodo,          ru_saldo_insoluto
from ca_rubro, ca_rubro_colateral
where ru_toperacion      = @w_toperacion
and ru_moneda            = @w_moneda
and ru_estado            = 'V'
and ru_crear_siempre     = 'N'
and @i_operacionca       = ruc_operacion
and ru_concepto          = ruc_concepto
and ru_concepto_asociado is not null
for read only

open rubros_asociados

fetch rubros_asociados into
        @w_concepto_a,         @w_prioridad_a,         @w_tipo_rubro_a, @w_paga_mora_a,
        @w_provisiona_a,       @w_fpago_a,             @w_periodo_a,    @w_referencial_a,
        @w_ref_reajuste_a,     @w_concepto_asociado_a, @w_principal_a,  @w_redescuento_a,
        @w_saldo_operacion_a,  @w_saldo_por_desem_a,   @w_pit_a,        @w_limite_a,
        @w_iva_siempre,        @w_tperiodo_a,          @w_saldo_insoluto

while @@fetch_status = 0
begin

   ---INICIAR VARIABLES
   select
   @w_porcentaje_a     = 0,
   @w_valor_rubro_a    = 0,
   @w_vr_valor_a       = 0,
   @w_signo_a          = null,
   @w_factor_a         = 0,
   @w_signo_reaj_a     = null,
   @w_factor_reaj_a    = 0,
   @w_tipo_val_a       = null,
   @w_clase_a          = null,
   @w_signo_pit_a      = null,
   @w_spread_pit_a     = 0,
   @w_tasa_pit_a       = null,
   @w_clase_pit_a      = null,
   @w_porcentaje_pit_a = 0,
   @w_num_dec_tapl_a   = null,
   @w_porcentaje_efa   = 0

   if @w_clase_cartera = 1 and (@w_concepto_a = @w_pmipymes or @w_concepto_a = @w_ivamipymes)  begin
      goto NEXT2
   end

   select @w_valor_rubro_asociado = rot_valor
   from ca_rubro_op_tmp
   where rot_operacion  = @w_operacionca
   and rot_concepto = @w_concepto_asociado_a

   --- DETERMINACION DE LA TASA A APLICAR
   select
   @w_signo_a       = isnull(vd_signo_default,' '),
   @w_factor_a      = isnull(vd_valor_default,0),
   @w_tipo_val_a    = vd_referencia,
   @w_tipo_puntos_a = vd_tipo_puntos,
   @w_clase_a       = va_clase,
   @w_num_dec_tapl_a  = vd_num_dec
   from    ca_valor,ca_valor_det
   where   va_tipo   = @w_referencial_a
   and     vd_tipo   = @w_referencial_a
   and     vd_sector = @w_sector

   if @@rowcount = 0
   begin
     close rubros_asociados
     deallocate rubros_asociados
     print '(genrtmp.sp) concepto asociado. Parametrizar Tasa para rubro' + cast(@w_referencial_a as varchar)
     return 721404
   end

   select @w_valor_rubro_a = round(@w_factor_a * @w_valor_rubro_asociado / 100.0, @w_num_dec)

   if @w_tipo_rubro_a = 'O' and  @w_iva_siempre = 'S'  ---Paraemtro por LINEA y Modificable por operacion
   begin
     ---CONCEPTO CONTABLE QUE IDENTIFICA EL IVA PARA CONSULTAR SI EL CLIENTE ES EXENTO O NO
      select @w_concepto_conta_iva = pa_char
      from cobis..cl_parametro
      where pa_producto = 'CCA'
      and pa_nemonico  =  'CONIVA'
      and  pa_producto = 'CCA'

      if @@rowcount = 0
      begin
          close rubros_asociados
          deallocate rubros_asociados
          return 710449
      end
  
      select @w_grupal = isnull(tr_grupal,'N'),
             @w_exento = 'S' 
	    from cob_credito..cr_tramite
       where tr_tramite = @w_tramite
      
      if (@w_grupal = 'N')
      begin
         exec @w_error        = cob_conta..sp_exenciu
              @s_date         = @s_date,
              @s_user         = @s_user,
              @s_term         = @s_term,
              @s_ofi          = @s_ofi,
              @t_trn          = 6251,
              @t_debug        = 'N',
              @i_operacion    = 'F',
              @i_empresa      = 1,
              @i_impuesto     = 'V',             ---Iva   T timbre
              @i_concepto     = @w_concepto_conta_iva,
              @i_debcred      = 'C',            ---Valor D'bito o Cr'dito
              @i_ente         = @w_cliente,     ---C½digo  COBIS del cliente
              @i_oforig_admin = @s_ofi,         ---C½digo COBIS de la oficina origen Admin
              @i_ofdest_admin = @w_op_oficina,  ---C½digo COBIS de la oficina destino Admin
              @i_producto     = 7,              ---Codigo del producto CARTERA
              @o_exento       = @w_exento  out
         
         if @w_error <> 0
         begin
            close rubros_asociados
            deallocate rubros_asociados
            return 710457
         end
      end
      if @w_exento = 'S'
         select @w_valor_rubro_a = 0
   end  ---Validaciones  Iva

   if @w_valor_rubro_a is null
      select @w_valor_rubro_a = 0

   insert into ca_rubro_op_tmp (
   rot_operacion,           rot_concepto,         rot_tipo_rubro,
   rot_fpago,               rot_prioridad,        rot_paga_mora,
   rot_provisiona,          rot_signo,            rot_factor,
   rot_referencial,         rot_signo_reajuste,   rot_factor_reajuste,
   rot_referencial_reajuste,rot_valor,            rot_porcentaje,
   rot_porcentaje_aux,      rot_gracia,           rot_concepto_asociado,
   rot_principal,           rot_porcentaje_efa,   rot_garantia,
   rot_tipo_puntos,         rot_saldo_op,         rot_saldo_por_desem,
   rot_base_calculo,        rot_num_dec,          rot_limite,
   rot_tperiodo,            rot_periodo,     rot_saldo_insoluto)
   values (
   @w_operacionca,          @w_concepto_a,        @w_tipo_rubro_a,
   @w_fpago_a,              @w_prioridad_a,       @w_paga_mora_a,
   @w_provisiona_a,         @w_signo_a,           0,
   @w_referencial_a,        @w_signo_reaj_a,      @w_factor_reaj_a,
   @w_ref_reajuste_a,       @w_valor_rubro_a,     @w_factor_a,
   @w_factor_a,             @w_factor_a,          @w_concepto_asociado_a,
   @w_principal_a,          0,                    0,
   @w_tipo_puntos_a,        @w_saldo_operacion_a, @w_saldo_por_desem_a,
   @w_valor_rubro_asociado, @w_num_dec_tapl_a,    @w_limite_a,
   @w_tperiodo_a,           @w_periodo_a,         @w_saldo_insoluto)

   if @@error <> 0
   begin
    close rubros_asociados
    deallocate rubros_asociados
    return  721408
   end
   NEXT2:
  fetch rubros_asociados into    @w_concepto_a,       @w_prioridad_a,    @w_tipo_rubro_a,  @w_paga_mora_a,
          @w_provisiona_a,       @w_fpago_a,          @w_periodo_a,
          @w_referencial_a,      @w_ref_reajuste_a,   @w_concepto_asociado_a,
          @w_principal_a,        @w_redescuento_a,
          @w_saldo_operacion_a,  @w_saldo_por_desem_a,@w_pit_a,@w_limite_a,
          @w_iva_siempre,        @w_tperiodo_a,       @w_saldo_insoluto
end

close rubros_asociados
deallocate rubros_asociados

return 0
go