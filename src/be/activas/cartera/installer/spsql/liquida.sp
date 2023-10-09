/************************************************************************/
/*   Stored procedure:     sp_liquida                                   */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                            CAMBIOS                                   */
/************************************************************************/
/*   23/abr/2010   Fdo Carvajal  MANEJO NOTAS DEBITO                    */
/*   08/Jun/2010   Elcira Pelaez MANEJO ORIGEN FONDOS REDESCUENTO       */
/*                               FORMA PAGO AUTOMATICA PARA PASIVA Y    */
/*                               QUITAR CODIGO CAUSACION PASIVAS        */
/*   25/Feb/2011   Elcira Pelaez Inc. 16589  partiendo de la version 56 */
/*   26/Jul/2013   Luis Guzman   Req. 366 Seguros                       */
/*   14/Nov/2013   Elcira Pelaez Inc. 114076  PArte version 109         */
/*   16/Oct/2014   Luis Moreno   Req. 436 Normalizacion de Cartera      */
/*   03/Oct/2017   LGU           No generar OP_BANCO xq ya nacen con el */
/*   04/Dic/2017   P. Ortiz      Control de cambios Santander(S147562)  */
/*   22/Ago/2019   MTA           Control deshabilitar productos         */
/*   21/Abr/2020   DCU           Caso 137397 ajuste desplazamientos     */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_liquida')
   drop proc sp_liquida
go

create proc sp_liquida
(  @s_ssn              int          = null,
   @s_sesn             int          = null,
   @s_srv              varchar (30) = null,
   @s_lsrv             varchar (30) = null,
   @s_user             login        = null,
   @s_date             datetime     = null,
   @s_ofi              int          = null,
   @s_rol              tinyint      = null,
   @s_org              char(1)      = null,
   @s_term             varchar (30) = null,
   @i_banco_ficticio   cuenta       = null,
   @i_banco_real       cuenta       = null,
   @i_fecha_liq        datetime     = null,
   @i_externo          char(1)      = 'S',
   @i_capitalizacion   char(1)      = 'N',
   @i_afecta_credito   char(1)      = 'S',
   @i_operacion_ach    char(1)      = null,
   @i_nom_producto     char(3)      = null,
   @i_tramite_batc     char(1)      = 'N',
   @i_tramite_hijo     int          = 0,
   @i_prenotificacion  int          = null,
   @i_carga            int          = null,
   @i_reestructura     char(1)      = null,
   @i_banderafe        char(1)      = 'S',  @i_cca_sobregiro    char(1)      = 'N',
   @i_renovacion       char(1)      = 'N',
   @i_crea_ext         char(1)      = null,
   @i_tasa             float		= null, --SRO Santander
   @i_dias_desplazados   int          = 0,
   @i_cuotas_a_desplazar int          = 0,
   @i_dia_inicio         int          = null,
   @i_ejecuta_dia_pago   char(1)      = 'N',
   @o_banco_generado   cuenta       = null out,
   @o_respuesta        char(1)      = null out,
   @o_rotativo         char(1)      = null out, --Contrato cupo rotativo
   @o_msg              varchar(255) = null out
)
as declare
   @w_return               int,
   @w_sp_name              varchar(32),
   @w_error                int,
   @w_monto_gastos         money,
   @w_monto_op             money,
   @w_monto_des            money,
   @w_afectacion           char(1),
   @w_operacionca_ficticio int,
   @w_operacionca_real     int,
   @w_toperacion           catalogo,
   @w_oficina              int,
   @w_moneda               smallint,
   @w_fecha_ini            datetime,
   @w_fecha_fin            datetime,
   @w_est_vigente          tinyint,
   @w_est_cancelado        tinyint,
   @w_dm_producto          catalogo,
   @w_dm_cuenta            cuenta,
   @w_dm_beneficiario      descripcion,
   @w_moneda_n             tinyint,
   @w_dm_moneda            tinyint,
   @w_dm_desembolso        int,
   @w_dm_monto_mds         money,
   @w_dm_cotizacion_mds    float,
   @w_dm_tcotizacion_mds   char(1),
   @w_dm_cotizacion_mop    float,
   @w_dm_tcotizacion_mop   char(1),
   @w_dm_monto_mn          money,
   @w_dm_monto_mop         money,
   @w_ro_concepto          catalogo,
   @w_ro_valor_mn          money,
   @w_ro_tipo_rubro        char(1),
   @w_estado_op            tinyint,
   @w_codvalor             int,
   @w_num_dec              tinyint,
   @w_num_dec_mn           tinyint,
   @w_tramite              int,
   @w_lin_credito          varchar(24),
   @w_monto                money,
   @w_op_tipo              char(1),
   @w_secuencial           int,
   @w_sec_liq              int,
   @w_sector               catalogo,
   @w_ro_porcentaje        float,
   @w_fecha_ult_proceso    datetime,
   @w_oficial              smallint,
   @w_tplazo               catalogo,
   @w_plazo                int,
   @w_plazo_meses          int,
   @w_destino              catalogo,
   @w_ciudad               int,
   @w_num_renovacion       int,
   @w_di_fecha_ven         datetime,
   @w_int_ant              money,
   @w_int_ant_total        money,
   @w_min_dividendo        int,
   @w_operacionca          int,
   @w_operacion_real       int,
   @w_banco                cuenta,
   @w_cliente              int,
   @w_clase                catalogo,
   @w_opcion               char(1),
   @w_gar_admisible        char(1),
   @w_admisible            char(1),
   @w_tipo_garantia        tinyint,
   @w_grupo                int,
   @w_num_negocio          varchar(64),
   @w_num_doc              varchar(16),
   @w_proveedor            int,
   @w_producto             tinyint,
   @w_op_activa            int,
   @w_tasa_equivalente     char(1),
   @w_prod_cobis_ach       smallint,
   @w_categoria            catalogo,
   @w_fecha_ini_activa     datetime,
   @w_fecha_fin_activa     datetime,
   @w_fecha_ini_pasiva     datetime,
   @w_fecha_fin_pasiva     datetime,
   @w_fecha_liq_pasiva     datetime,
   @w_est_pasiva           tinyint,
   @w_op_pasiva            int,
   @w_banco_pasivo         cuenta,
   @w_op_monto_pasiva      money,
   @w_op_monto_activa      money,
   @w_porcentaje_redes     float,
   @w_dias_anio            smallint,
   @w_monto_cex            money,
   @w_num_oper_cex         cuenta,
   @w_moneda_local         smallint,
   @w_concepto_can         catalogo,
   @w_monto_mn             money,
   @w_cot_mn               money,
   @w_saldo_real_pasiva    money,
   @w_valor_activas        money,
   @w_reestructuracion     char(1),
   @w_calificacion         char(1),
   @w_valor_credito        money,
   @w_moneda_uvr           tinyint,
   @w_est_suspenso         tinyint,
   @w_tr_tipo              char(1),
   @w_op_anterior          cuenta,
   @w_monto_aprobado_cr    money,
   @w_op_numero_reest      int,
   @w_monto_desem_cca      money,
   @w_ro_valor             money,
   @w_rubro_timbac         catalogo, --- PILAS CON EL USO DE ESTA VARIABLE
   @w_parametro_timbac     varchar(30),
   @w_valor_timbac         money,
   @w_ro_fpago             catalogo,
   @w_tipo_amortizacion    catalogo,
   @w_dias_div             int,
   @w_tdividendo           catalogo,
   @w_fecha_a_causar       datetime,
   @w_fecha_liq            datetime,
   @w_clausula             catalogo,
   @w_base_calculo         catalogo,
   @w_causacion            catalogo,
   @w_valor_primera        money,
   @w_max_dividendo        int,
   @w_monto_validacion     money,
   @w_op_lin_credito       cuenta,
   @w_li_tramite           int,
   @w_minimo_sec           int,
   @w_monto_credito        money,
   @w_total_adicionales    money,
   @w_capitaliza           money,
   @w_codvalor_diferido    int,
   @w_est_diferido         tinyint,
   @w_cod_capital          catalogo,
   @w_cotizacion           money,
   @w_naturaleza           char(1),
   @w_tr_contabilizado     char(1),
   @w_tipo_oficina_ifase   char(1),
   @w_oficina_ifase        int,
   @w_tipo_empresa         catalogo,
   @w_op_naturaleza        char(1),
   @w_concepto_intant      catalogo,
   @w_monto_total_mn       money,
   @w_cotizacion_des       float,
   @w_dtr_C                money,
   @w_dtr_D                money,
   @w_limite_ajuste        money,
   @w_diff                 money,
   @w_valor_tf             float,
   @w_tasa_ref             catalogo,
   @w_ts_fecha_referencial datetime,
   @w_ts_valor_referencial float,
   @w_fecha_liq_val        datetime,
   @w_valor_colchon        money,
   @w_codvalor_col         int,
   @w_can_deu              int,
   @w_parametro_col        catalogo,
   @w_concepto_col         catalogo,
   @w_rowcount             int,
   @w_pa_cheger            varchar(30),
   @w_pa_cheotr            varchar(30),
   @w_fecha_pro_k          datetime,
   @w_fecha_car_k          datetime,
   @w_dia                  int,    --jos
   @w_banco_ya             cuenta,  --jos
   @w_parametro_apecr      catalogo,
   @w_valor_rubro          money,
   @w_instrumento          int,
   @w_subtipo              int,
   @w_num_orden            int,
   @w_pagado               char(1),
   @w_num_secuencial       int,
   @w_fpago_pasiva         catalogo,
   @w_parametro_fppasiva   catalogo,
   @w_origen_recursos      catalogo,
   @w_toperacion_pas       catalogo,
   @w_parametro_fng        catalogo,
   @w_parametro_fgu        catalogo,
   @w_parametro_usaid      catalogo,
   @w_parametro_fag        catalogo,
   @w_segdeven             catalogo,
   @w_cod_gar_fng          catalogo,
   @w_gar_op               catalogo,
   @w_tipos_gar            int,
   @w_cobros_amortiza      int,
   @w_cobros               float,
   @w_tramite_new          int,
   @w_oper_ant             cuenta,
   @w_existe               tinyint,
   @w_fdesembolso          catalogo,
   @w_operacionca_ant      int,
   @w_sec_ing_hoy          int,
   @w_num_div              smallint,
   @w_num_amor             smallint,
   @w_mipymes              varchar(10),
   @w_valor_mipyme         money,
   @w_op_clase             catalogo,
   @w_rotativo             varchar(64), --Ceh Req 00278 Contrato cupo rotativo
   @w_abd_concepto         catalogo,
   @w_codvalor_hi          int,
   @w_pa_DESFVA            catalogo,
   @w_seguro_asociado      char(1),
   @w_fecha_inicio         datetime,
   @w_error_sis            int,
   @w_op_monto             money,
   @w_op_monto_aprobado    money,
   @w_edad_cliente         int,
   @w_variables        	   varchar(255),
   @w_result_values        varchar(255),
   @w_parent               int,
   @w_tflexible            catalogo,
   @w_op_tipo_amortizacion catalogo



select @w_sp_name = 'sp_liquida'

--inicio MTA Valida que no este ejecutandose el batch
-- VALIDAR QUE EL PRODUCTO ESTE HABILITADO 

if exists (select 1
from   cobis..cl_pro_moneda,  cobis..cl_producto
where  pm_producto = pd_producto 
and    pd_abreviatura = 'CCA'
and    pm_moneda = 0
and    pm_tipo = 'R'
and    pm_estado <> 'V') begin 

   exec cobis..sp_cerror
        @t_debug  = 'N',    
        @t_file   =  null,
        @t_from   =  @w_sp_name,   
        @i_num    =  6900070,
        @i_msg 	 =  'No se pudo establecer el producto bancario seleccionado como disponible a la venta'
   return @w_error    
end

--fin MTA
   
select @w_tflexible = ''

select @w_tflexible = pa_char
from   cobis..cl_parametro
where  pa_producto  = 'CCA'
and    pa_nemonico  = 'TFLEXI'
set transaction isolation level read uncommitted

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_vigente    = @w_est_vigente   out

select @w_fecha_pro_k = @i_fecha_liq
if @i_fecha_liq is null
begin
    if @i_crea_ext is null
       PRINT 'Por favor actualizar primero la fecha de desembolso de la operacion antes de desembolsar'
    else
       select @o_msg = 'Por favor actualizar primero la fecha de desembolso de la operacion antes de desembolsar'

    select @w_fecha_pro_k = fp_fecha from cobis..ba_fecha_proceso
end

-- VARIABLES INICIALES
select @w_sp_name       = 'sp_liquida',
       @w_dtr_C         = 0,
       @w_dtr_D         = 0,
       @w_seguro_asociado = 'N'

--- LECTURA DEL PARAMETRO DESEMBOLSO FECHA VALOR
select @w_pa_DESFVA = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto    = 'CCA'
and    pa_nemonico    = 'DESFVA'


/* LECTURA DEL PARAMETRO CHEQUE DE GERENCIA */
select @w_pa_cheger = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto    = 'CCA'
and    pa_nemonico    = 'CHEGER'
select @w_rowcount    = @@rowcount

if @w_rowcount = 0 begin
   select @w_error = 701012 --No existe parametro cheque de gerencia
   goto ERROR
end

/* LECTURA DEL PARAMETRO CHEQUE LOCAL (Otros Bancos) */
select @w_pa_cheotr = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto    = 'CCA'
and    pa_nemonico    = 'CHELOC'
select @w_rowcount    = @@rowcount

if @w_rowcount = 0 begin
   select @w_error = 701012 --No existe parametro cheque de Otros Bancos
   goto ERROR
end

select @w_cod_gar_fng = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'

-- CONSULTA CODIGO DE MONEDA LOCAL
select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'MLO'
and    pa_producto = 'ADM'

-- CODIGO DEL MONEDA UVR
select @w_moneda_uvr = pa_tinyint
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR'
select @w_rowcount= @@rowcount

if @w_rowcount = 0 begin
   select @w_error = 711069
   goto ERROR
end

--LECTURA DEL PARAMETRO CODIGO APERTURA DE CREDITO
select @w_parametro_apecr = pa_char
from cobis..cl_parametro  with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'APECR'

-- CODIGO DE CAPITAL
select @w_cod_capital = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CAP'
select @w_rowcount = @@rowcount

if @w_rowcount = 0 begin
   select @w_error = 710429
   goto ERROR
end

/*PARAMETRO DE LA GARANTIA DE FNG*/
select @w_parametro_fng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'

---CODIGO DEL RUBRO COMISION GAR UNIFICADA
select @w_parametro_fgu = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'COMGRP'
set transaction isolation level read uncommitted

/*PARAMETRO DE LA GARANTIA DE USAID*/
select @w_parametro_usaid = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMUSAP'
set transaction isolation level read uncommitted

/*PARAMETRO DE LA GARANTIA DE FAG*/
select @w_parametro_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMFAGP'
set transaction isolation level read uncommitted

/* PARAMETRO DE FORMA DE PAGO PRESTAMOS HIJA*/
select @w_abd_concepto = pa_char
  from cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'DESREE'

select @s_date = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

select tc_tipo into #tipo_garantia
from cob_custodia..cu_tipo_custodia
where  tc_tipo_superior  = @w_cod_gar_fng

select @w_tipos_gar = count(1) from #tipo_garantia

select @w_operacion_real         = op_operacion,
       @w_oficina                = op_oficina,
       @w_moneda                 = op_moneda,
       @w_op_tipo_amortizacion   = op_tipo_amortizacion,
       @w_op_monto               = op_monto,
       @w_op_monto_aprobado      = op_monto_aprobado,
       @w_tramite                = op_tramite,
       @w_rotativo               = op_lin_credito, 
       @w_toperacion             = op_toperacion, --LGU 2017-09-03
       @w_cliente                = op_cliente
from   ca_operacion
where  op_banco = @i_banco_real

-- no usa lineas de credito
update ca_operacion set op_lin_credito = null where  op_banco = @i_banco_real

---Una Oblicagion solo puede tener una transaccion DES desembolso
---a no ser que sea una operacion con desembolso parciales
if  exists (select 1
               from   ca_transaccion
               where  tr_operacion = @w_operacion_real
               and    tr_tran = 'DES'
               and    tr_estado    = 'ING'
               and    tr_secuencial > 0
               and    tr_fecha_mov = @s_date)
               and    @w_op_monto = @w_op_monto_aprobado
begin
    if @i_crea_ext is null
       PRINT 'liquida.sp LA OPERACION YA TIENE TRANSACCION DE DESEMBOLSO POR FAVOR VERIFICAR'

   select @w_error = 703063
   goto ERROR

end

-- MANEJO DE DECIMALES
exec @w_return = sp_decimales
     @i_moneda       = @w_moneda,
     @o_decimales    = @w_num_dec out,
     @o_mon_nacional = @w_moneda_n out,
     @o_dec_nacional = @w_num_dec_mn out

if @w_return <> 0 begin
   select @w_error = @w_return
   goto ERROR
end

-- DETERMINAR EL SECUENCIAL DE DESEMBOLSO A APLICAR
select @w_secuencial  = min(dm_secuencial)
from   ca_desembolso
where  dm_operacion  = @w_operacion_real
and    dm_estado     = 'NA'

if @w_secuencial <= 0 or @w_secuencial is null begin
  select @w_error = 701121
  goto ERROR
end

-- EN EL PRIMER DESEMBOLSO(LIQUIDACION)SE GENERA EL NUMERO BANCO

if not exists (select 1
               from   ca_transaccion
               where  tr_operacion = @w_operacion_real
               and    tr_estado    <> 'NCO')
begin

   select @w_operacionca = convert(int, @i_banco_ficticio)

    if @i_externo = 'S'
    begin
        begin tran
    end
    --LGU-ini 2017-09-03
        select @w_banco       = @i_banco_real
       /**********************************
       exec @w_return = sp_numero_oper
            @s_date        = @s_date,
            @i_oficina     = @w_oficina,
            @i_operacionca = @w_operacionca,
            @o_operacion   = @w_operacionca out,
            @o_num_banco   = @w_banco out

       if @w_return <> 0 begin
          select @w_error = @w_return
          goto ERROR
       end

       update ca_operacion with (rowlock)
       set    op_banco = @w_banco
       where  op_banco = @i_banco_real

       if @@error <> 0 begin
          select @w_error = 7100021
          goto ERROR
       end

       update ca_operacion_tmp with (rowlock)
       set    opt_banco = @w_banco
       where  opt_banco = @i_banco_real

       if @@error <> 0 begin
          select @w_error = 7100022
          goto ERROR
       end
       ******************************************/

    --LGU-fin 2017-09-03
end
else
begin
   select @w_banco = @i_banco_real
end

-- GENERACION DE RESPALDO PARA REVERSAS
exec @w_return = sp_historial
     @i_operacionca = @w_operacion_real,
     @i_secuencial  = @w_secuencial

if @w_return <> 0 begin
  select @w_error = @w_return
  goto ERROR
end

--436: OBTIENE EL TIPO DE TRAMITE
select @w_tr_tipo = tr_tipo
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

-- GENERACION DEL NUMERO OP_BANCO
--LGU-ini 2017-09-03
-- si son iguales, significa que es el primer desembolso.
--if (@i_banco_real = @i_banco_ficticio )r
   -- EL CAMBIO ES QUE AHORA YA NACE CON EL OP_BANCO
if   (not exists (select 1
               from   ca_transaccion
               where  tr_operacion = @w_operacion_real
               and    tr_estado    <> 'NCO')  )

begin

   select @w_operacion_real    = op_operacion,
          @w_op_anterior       = op_anterior,
          @w_oficina           = op_oficina,
          @w_tramite           = op_tramite,
          @w_op_tipo           = op_tipo,
          @w_monto_validacion  = op_monto,
          @w_gar_admisible     = op_gar_admisible,
          @w_reestructuracion  = op_reestructuracion,
          @w_calificacion      = op_calificacion,
          @w_naturaleza        = op_naturaleza,
          @w_op_naturaleza     = op_naturaleza,
          @w_tipo_amortizacion = ltrim(rtrim(op_tipo_amortizacion)),
          @w_banco_ya          = op_banco,
          @w_dia               = op_dia_fijo,
          @w_toperacion        = op_toperacion,
          @w_rotativo          = op_lin_credito, --Contrato Cupo Rotativo
          @w_fecha_inicio      = op_fecha_ini
   from   ca_operacion
   where  op_banco = isnull(@w_banco,@i_banco_real)

   if @w_rotativo is null --Contrato Cupo Rotativo
      select @w_rotativo = 'S'
   else
      select @w_rotativo = 'R'

   select @o_rotativo = @w_rotativo

   select @w_seguro_asociado = 'N'

   if exists (select 1 from cob_credito..cr_seguros_tramite        -- Req. 366 Seguros
              where st_tramite = @w_tramite)
      select @w_seguro_asociado = 'S'

   if datediff(dd,@w_fecha_inicio,@s_date) <> 0 or @w_seguro_asociado = 'S' or @w_tr_tipo = 'M'
   begin
      if exists (select 1 from ca_amortizacion_tmp
                 where amt_operacion = @w_operacion_real)
      and ltrim(rtrim(@w_tipo_amortizacion))  <> 'MANUAL'
      and ltrim(rtrim(@w_tipo_amortizacion))  <> @w_tflexible
      begin
         delete ca_amortizacion_tmp
         where amt_operacion = @w_operacion_real

         ---@w_pa_DESFVA esta variable es para desembolso confecha valor o se a que la fecha de inicio
         ---pueda ser <> a la fecha del sistema sobre todo en casos especiales que se requiera.

         if @w_op_tipo <> 'R' and @w_op_tipo <> 'C'  and @w_pa_DESFVA = 'N'
         begin
            ----La fecha de Inicio de la operacion debe ser la fecha del sistema caso contrario es por que se desembolsa
            ---con fecha valor
            select @w_fecha_pro_k = @s_date
         end

         exec @w_return = sp_modificar_operacion_int
             @s_user              = @s_user,
             @s_sesn              = @s_sesn,
             @s_date              = @s_date,
             @s_ofi               = @s_ofi,
             @s_term              = @s_term,
             @i_tipo_amortizacion = @w_tipo_amortizacion,
             @i_calcular_tabla    = 'S',
             @i_tabla_nueva       = 'S',        --Mroa: Se cambia de 'D' a 'S' para recalcular la tabla de ca_dividendo
             @i_salida            = 'N',
             @i_operacionca       = @w_operacion_real,
             @i_banco             = @i_banco_real,
             @i_fecha_ini         = @w_fecha_pro_k, --jos
             @i_dia_fijo          = @w_dia,         --jos
             @i_cuota             = 0,
			 @i_tasa           	  = @i_tasa, 		--SRO Santander
             @i_desplazamiento    = @i_cuotas_a_desplazar
         if @w_return <> 0
         begin
            select @w_error = @w_return
            goto ERROR
         end

         if @w_seguro_asociado = 'S'  -- Req. 366 Seguros
         and @w_op_tipo_amortizacion != @w_tflexible
         begin
            exec @w_error      = sp_seguros
                 @i_opcion          = 'G'       ,
                 @i_tramite         = @w_tramite,
                 @i_liquida         = 'S'

            if @w_error <> 0 return @w_error

            if @i_renovacion = 'S'
            begin
               exec @w_error      = sp_seguros
                    @i_opcion          = 'R'       ,
                    @i_tramite         = @w_tramite

               if @w_error <> 0 return @w_error
            end
         end       -- Fin Req. 366 Seguros

         if @w_seguro_asociado = 'S'
         begin
            update ca_operacion_tmp
            set    opt_monto_aprobado = opt_monto
            where  opt_operacion = @w_operacion_real

            /* CALCULO COMFNGANU */
            if exists (select 1
                       from   ca_rubro_op_tmp
                       where  rot_operacion = @w_operacion_real
                       and    rot_concepto  = @w_parametro_fng)
            begin

               exec @w_error = sp_calculo_fng
               @i_operacion      = @w_operacion_real,
               @i_desde_abnextra = 'N'

               if @w_error <> 0 return @w_error

            end

            /* CALCULO COMFGU */
            if exists (select 1
                       from   ca_rubro_op_tmp
                       where  rot_operacion = @w_operacion_real
                       and    rot_concepto  = @w_parametro_fgu)
            begin

               exec @w_error = sp_calculo_uni
               @i_operacion      = @w_operacion_real,
               @i_desde_abnextra = 'N'

               if @w_error <> 0 return @w_error

            end

            /* CALCULO USAID */
            if exists (select 1
                       from   ca_rubro_op_tmp
                       where  rot_operacion = @w_operacion_real
                       and    rot_concepto  = @w_parametro_usaid)
            begin

               exec @w_error = sp_calculo_usaid
               @i_operacion      = @w_operacion_real,
               @i_desde_abnextra = 'N'

               if @w_error <> 0 return @w_error

            end

            /* CALCULO FAG */
            if exists (select 1
                       from   ca_rubro_op_tmp
                       where  rot_operacion = @w_operacion_real
                       and    rot_concepto  = @w_parametro_fag)
            begin

               exec @w_error = sp_calculo_fag
               @i_operacion      = @w_operacion_real,
               @i_desde_abnextra = 'N'

               if @w_error <> 0 return @w_error

            end
         end --Req. 366 Seguros
         
         -------------------------------------------------------------
         -------------------------------------------------------------
         
         if @i_ejecuta_dia_pago = 'S' begin
         exec @w_return = cob_cartera..sp_dia_pago
              @i_banco            = @w_banco,
              @i_fecha_inicio     = @i_fecha_liq,
              @i_num_dias         = @i_dia_inicio
              
             select  @i_fecha_liq = opt_fecha_liq
             from cob_cartera..ca_operacion_tmp
             where opt_banco = @w_banco
             
             print '@i_fecha_liq: ' + convert(varchar,@i_fecha_liq)
         end 
         
         -------------------------------------------------------------
         --SRO. DESPLAZAMIENTO	
        select @i_cuotas_a_desplazar = isnull(@i_cuotas_a_desplazar,0)	
		if @i_cuotas_a_desplazar > 0 begin
		   print 'DESPLAZAMIENTO --- @w_banco' + @w_banco
		   print 'DESPLAZAMIENTO --- @w_toperacion' + @w_toperacion
		   print 'DESPLAZAMIENTO --- @w_operacion' + convert(varchar,@w_operacion_real)
           print 'DESPLAZAMIENTO --- @w_cliente' + convert(varchar,@w_cliente)
           print 'DESPLAZAMIENTO --- @i_fecha_ini' + convert(varchar,@i_fecha_liq)
		   		   
		   if (select datediff(dd, dit_fecha_ini, dit_fecha_ven) from ca_dividendo_tmp where dit_operacion = @w_operacion_real and dit_dividendo = 1) < @i_dias_desplazados begin
              exec @w_error      = sp_desplazamiento
              @i_banco           = @i_banco_real,
              @i_cliente         = @w_cliente,
              @i_fecha_valor     = @i_fecha_liq,
              @i_cuotas          = @i_cuotas_a_desplazar,
              @i_archivo         = 'WORKFLOW',
		      @i_oper_nueva      = 'S'
		      
			  if @w_error <> 0 
			     if @w_error <> 0 return @w_error
		   end	     
         end
         -- CAMBIO DE LUGAR
         if @i_externo = 'S'
            begin tran

         exec @w_return = sp_pasodef
              @i_banco        = @w_banco,
              @i_operacionca  = 'S',
              @i_dividendo    = 'S',
              @i_amortizacion = 'S',
              @i_cuota_adicional = 'S',
              @i_rubro_op     = 'S',
              @i_relacion_ptmo = 'S',
              @i_nomina       = 'S',
              @i_acciones     = 'S',
              @i_valores      = 'S'

         if @w_return <> 0
         begin
            rollback tran
            select @w_error = @w_return
            goto ERROR
         end

         if  @w_seguro_asociado = 'S'
         and @w_op_tipo_amortizacion != @w_tflexible
         begin
            exec @w_return = sp_recalc_int_Tasa_Ponderada
                @i_operacionca       = @w_operacion_real,
                @i_concepto_cap      = @w_cod_capital,
                @i_num_dec           = @w_num_dec

            if @w_return <> 0
            begin
               select @w_error = @w_return
               goto ERROR
            end
         end
      end
      ELSE
      begin
         if @i_externo = 'S'
           begin tran
      end
   end
   else
   begin
      if @i_externo = 'S'
         begin tran
   end

   if ltrim(rtrim(@w_tipo_amortizacion))  = 'MANUAL'   and @w_op_tipo <> 'D'
   begin
      exec @w_return      = sp_actualiza_tabla_manual
           @s_user              = @s_user,
           @s_sesn              = @s_sesn,
           @s_date              = @s_date,
           @s_ofi               = @s_ofi,
           @s_term              = @s_term,
           @i_operacionca       = @w_operacion_real,
           @i_crear_op          = 'S',
           @i_control_tasa      = 'S'

      if @w_return <> 0
      begin
         rollback tran
         select @w_error = @w_return
         goto ERROR
      end
   end

   -- PARA OPERACIONES PASIVAS, AUMENTADO PARA INTERFACES CON COMEXT
   if @w_naturaleza = 'P'
   begin
      select @i_afecta_credito = 'N'

      ---LA PASIVA DEBE LLEVAR LA FORMA DE PAGO PARA PAGO AUTOMATICO EL DIA DE SU  VENCIMIENTO
      select @w_parametro_fppasiva = pa_char
      from   cobis..cl_parametro with (nolock)
      where  pa_producto    = 'CCA'
      and    pa_nemonico    = 'PAGPAS'
      select @w_rowcount    = @@rowcount

      if @w_rowcount = 0
      begin
         select @w_error = 701193
         goto ERROR
      end

      ---OBTENER LA FORMA DE PAGO PARAMETRIZADA POR EL USUARIO
      select @w_fpago_pasiva = cp_producto
      from  ca_producto
      where cp_producto = @w_parametro_fppasiva
      and   cp_pago  = 'S'
      and   cp_act_pas = 'P'

      if @w_rowcount = 0
      begin
         select @w_error = 701194
         goto ERROR
      end

      --- ORIGEN DE FONDOS
      select @w_origen_recursos = dt_categoria
      from   ca_default_toperacion
      where  dt_toperacion =  @w_toperacion

      update ca_operacion with (rowlock)
      set    op_forma_pago    = @w_fpago_pasiva,
             op_origen_fondos = @w_origen_recursos
      where  op_banco = @i_banco_real

      if @@error <> 0
      begin
         select @w_error = 701195
         goto ERROR
      end

      update ca_operacion_his with (rowlock)
      set    oph_forma_pago    = @w_fpago_pasiva,
             oph_origen_fondos = @w_origen_recursos
      where  oph_banco = @i_banco_real
      and    oph_secuencial = @w_secuencial

      if @@error <> 0 begin
         select @w_error = 701195
         goto ERROR
      end

      update ca_operacion_tmp with (rowlock)
      set    opt_forma_pago    = @w_fpago_pasiva,
             opt_origen_fondos = @w_origen_recursos
      where  opt_banco = @i_banco_real

      if @@error <> 0
      begin
         select @w_error = 701196
         goto ERROR
      end

   end

   if @w_op_tipo = 'C'
   begin
      --* Si operacion no esta relacionada no se puede desembolsar
      --* sino se ha desembolsado la pasiva
      select @w_fecha_ini_activa  = opt_fecha_ini,
             @w_fecha_fin_activa  = opt_fecha_fin
      from   ca_operacion_tmp
      where  opt_operacion = @w_operacion_real

      select @w_op_pasiva        = rp_pasiva,
             @w_est_pasiva       = isnull(op_estado,0),
             @w_fecha_ini_pasiva = op_fecha_ini,
             @w_fecha_fin_pasiva = op_fecha_fin,
             @w_fecha_liq_pasiva = op_fecha_liq,
             @w_op_monto_pasiva  = isnull(op_monto, 0),
             @w_toperacion_pas   = op_toperacion
      from   ca_relacion_ptmo, ca_operacion
      WHERE  rp_activa = @w_operacion_real
      AND    rp_pasiva = op_operacion
      AND    op_estado <> 6

      if @@rowcount > 0
      begin
         if @w_est_pasiva <> 1  and @w_naturaleza <> 'P' --Vigente
         begin
            select @w_error = 708223
            goto ERROR
         end

         if @w_fecha_ini_pasiva <> @w_fecha_ini_activa
         begin
            select @w_error = 708224
            goto ERROR
         end

         if @w_fecha_fin_pasiva <> @w_fecha_fin_activa
         begin
            select @w_error = 708225
            goto ERROR
         end

         if @w_fecha_liq_pasiva <> @i_fecha_liq
         begin
            select @w_error = 708226
            goto ERROR
         end

         ---LA OPERACION ACTIVA DEBE HEREDAR EL ORIGEN DE FONDOS DE LA OP.PASIVA

         select @w_origen_recursos = dt_categoria
         from ca_default_toperacion
         where dt_toperacion =  @w_toperacion_pas

         update ca_operacion with (rowlock)
         set    op_origen_fondos = @w_origen_recursos
         where  op_banco = @i_banco_real

         if @@error <> 0
         begin
            select @w_error = 701197
            goto ERROR
         end

         update ca_operacion_his with (rowlock)
         set    oph_origen_fondos = @w_origen_recursos
         where  oph_banco = @i_banco_real
         and    oph_secuencial = @w_secuencial

         if @@error <> 0
         begin
            select @w_error = 701197
            goto ERROR
         end

         update ca_operacion_tmp with (rowlock)
         set    opt_origen_fondos = @w_origen_recursos
         where  opt_banco = @i_banco_real

         if @@error <> 0
         begin
            select @w_error = 701198
            goto ERROR
         end
      end
      else
      begin
         select @w_error = 708227
         goto ERROR
      end
   end

   -- EN EL PRIMER DESEMBOLSO(LIQUIDACION)SE GENERA EL NUMERO BANCO
   if not exists (select 1
                  from   ca_transaccion
                  where  tr_operacion = @w_operacion_real
                  and    tr_estado    <> 'NCO')
   begin
      select @w_operacionca = convert(int, @i_banco_ficticio)

      update cobis..cl_det_producto with (rowlock)
      set    dp_cuenta     = @w_banco,
             dp_comentario = 'OPERACION DESEMBOLSADA CARTERA'
      where  dp_producto = 7
      and    dp_cuenta = @i_banco_real

      if @@error <> 0
      begin
         if @i_crea_ext is null
         begin
             print 'Error al actualizar cl_det_producto'
         end
         else
            select @o_msg = '3 - Banco : ' + cast(@w_banco as varchar) + ' - ' + cast(@i_banco_real as varchar) + ' - ' + 'Error al actualizar cl_det_producto'

         select @w_error = 7100023
         goto ERROR
      end

      select @i_banco_real      = @w_banco
      select @i_banco_ficticio  = @w_banco
      select @o_banco_generado  = @w_banco
   end
   else
      select @w_banco = @i_banco_ficticio

   /*CALCULO DEL MARGEN DE REDESCUENTO, CUANDO SE DESEMBOLSA LA ACTIVA*/
   /*LA OP.PASIVA DEBE YA ESTAR DESEMBOLSADA*/

   if @w_op_tipo = 'C'
   begin
      select @w_op_monto_activa = isnull(op_monto, 0)
      from   ca_operacion
      where  op_banco = @w_banco

      select @w_valor_activas = isnull(sum(rp_saldo_act),0)
      from   ca_relacion_ptmo
      where  rp_pasiva = @w_op_pasiva
      and   rp_activa  <> @w_operacion_real

      select @w_saldo_real_pasiva = isnull(@w_op_monto_pasiva  - @w_valor_activas,0)

      if @w_saldo_real_pasiva  >=  @w_op_monto_activa
         select @w_porcentaje_redes = 100
      else
         select @w_porcentaje_redes = round(isnull((@w_saldo_real_pasiva / convert(float, @w_op_monto_activa)), 0)  * 100,0)

      update ca_operacion  with (rowlock)
      set    op_margen_redescuento  = @w_porcentaje_redes
      where  op_banco = @w_banco

      update ca_operacion  with (rowlock)
      set    op_margen_redescuento  = @w_porcentaje_redes
      where  op_operacion = @w_op_pasiva

      update ca_operacion_his with (rowlock)
      set    oph_margen_redescuento  = @w_porcentaje_redes
      where  oph_operacion = @w_op_pasiva
      and    oph_secuencial = @w_secuencial
   end
end
else
   if @i_externo = 'S'
      begin tran

select @w_operacionca_ficticio = opt_operacion,
       @w_banco                = opt_banco,
       @w_toperacion           = opt_toperacion,
       @w_oficina              = opt_oficina,
       @w_oficial              = opt_oficial,
       @w_tplazo               = opt_tplazo,
       @w_plazo                = opt_plazo,
       @w_destino              = opt_destino,
       @w_ciudad               = opt_ciudad,
       @w_num_renovacion       = opt_num_renovacion,
       @w_fecha_ini            = opt_fecha_ini,
       @w_fecha_fin            = opt_fecha_fin,
       @w_moneda               = opt_moneda,
       @w_monto                = opt_monto,
       @w_tramite              = opt_tramite,
       @w_lin_credito          = opt_lin_credito,
       @w_estado_op            = opt_estado,
       @w_sector               = opt_sector,
       @w_op_tipo              = opt_tipo,
       @w_fecha_ult_proceso    = opt_fecha_ult_proceso,
       @w_cliente              = opt_cliente,
       @w_clase                = opt_clase,
       @w_tasa_equivalente     = opt_usar_tequivalente,
       @w_dias_anio            = opt_dias_anio,
       @w_gar_admisible        = opt_gar_admisible,
       @w_reestructuracion     = opt_reestructuracion,
       @w_calificacion         = opt_calificacion,
       @w_tipo_amortizacion    = opt_tipo_amortizacion,
       @w_tdividendo           = opt_tdividendo,
       @w_fecha_liq            = opt_fecha_liq,
       @w_clausula             = opt_clausula_aplicada,
       @w_base_calculo         = opt_base_calculo,
       @w_causacion            = opt_causacion,
       @w_dias_div             = opt_periodo_int,
       @w_naturaleza           = opt_naturaleza,
       @w_op_numero_reest      = opt_numero_reest
from   ca_operacion_tmp
where  opt_banco = @i_banco_ficticio

---Independiente de la fecha de desembolso, la fecha de liquidacion debe ser siempre la del sistema
---No aplica para Redescuento
-- XMA CIRCULAR 11
-- SI LA OPERACION ES RENOVADA MANTIENE LA CALIFICACION DE LA OPERACION ORIGINAL
-- POR TRAMITE DE REESTRUCTURACION
if @w_tramite is not null begin
   select @w_tr_tipo = tr_tipo
   from   cob_credito..cr_tramite
   where  tr_tramite = @w_tramite

   if @@rowcount = 0    begin
     select @w_error = 701187
     goto ERROR
   end
end


if exists (select 1 from   ca_operacion,  cob_credito..cr_op_renovar
           where  op_banco   = or_num_operacion
           and    or_tramite = @w_tramite
           and    op_estado in (3,4,2) and @w_tr_tipo <> 'M')
begin
   if @i_crea_ext is null
      print 'EL ESTADO DE LA OPERACION ' + @i_banco_ficticio + ' NO ADMITE RENOVACION'
   else
      select @o_msg = 'EL ESTADO DE LA OPERACION ' + @i_banco_ficticio + ' NO ADMITE RENOVACION'
   select @w_error = 720303
   goto ERROR
end

---Validar Igualdad cuotas antes  de liquidar la operacion
select @w_num_div = max(di_dividendo)
from ca_dividendo
where di_operacion = @w_operacion_real

select @w_num_amor = max(am_dividendo)
from ca_amortizacion
where am_operacion = @w_operacion_real

if @w_num_div <> @w_num_amor
begin
   if @i_crea_ext is null
      PRINT 'liquida.sp  @w_num_div ' + CAST (@w_num_div as varchar) +  '@w_num_amor ' + CAST (@w_num_amor as varchar)
   else
      select @o_msg = 'liquida.sp  @w_num_div ' + CAST (@w_num_div as varchar) +  '@w_num_amor ' + CAST (@w_num_amor as varchar)
   select @w_error = 708153
   goto ERROR
end

if (@w_op_tipo <> 'R'  and  @w_op_tipo <> 'C' and @w_tr_tipo <> 'R')  and  @w_pa_DESFVA = 'N'
    select @i_fecha_liq = @s_date

--SI YA EXISTE UN DESEMBOLSO, SE VUELVE A ACTUALIZAR
--EL NUMERO DE BANCO EN cl_det_producto


if  exists (select 1
              from   ca_transaccion
              where  tr_operacion = @w_operacion_real
              and    tr_estado    <> 'NCO')
begin
   update cobis..cl_det_producto  with (rowlock)
   set    dp_cuenta     = @w_banco,
          dp_comentario =  'OPERACION DESEMBOLSADA CARTERA ACT'
   where  dp_producto = 7
   and    dp_cuenta = convert(char(16),@w_operacionca_ficticio)
end


/* DETERMINAR EL VALOR DE COTIZACION DEL DIA */
if @w_moneda = @w_moneda_local
   select @w_cotizacion = 1.0
else begin
   exec sp_buscar_cotizacion
        @i_moneda     = @w_moneda,
        @i_fecha      = @w_fecha_ult_proceso,
        @o_cotizacion = @w_cotizacion output
end

-- CONTROLAR RANGO VALIDO DE FECHA DE LIQUIDACION
if @w_estado_op = 0 and (@i_fecha_liq < @w_fecha_ini or @i_fecha_liq > @s_date) begin
   if @i_crea_ext is null
      PRINT '1-->liquida.sp error = @i_fecha_liq' + cast(@i_fecha_liq as varchar) +  '@w_fecha_ini'+ cast(@w_fecha_ini as varchar) + '@s_date' + cast(@s_date as varchar)
   else
      select @o_msg = '1-->liquida.sp error = @i_fecha_liq' + cast(@i_fecha_liq as varchar) +  '@w_fecha_ini'+ cast(@w_fecha_ini as varchar) + '@s_date' + cast(@s_date as varchar)
   select @w_error = 710073
   goto ERROR
end

select @w_di_fecha_ven = dit_fecha_ven
from   ca_dividendo_tmp
where  dit_operacion = @w_operacionca_ficticio
and    dit_dividendo = 1


-- CONTROLAR RANGO VALIDO DE FECHA DE LIQUIDACION
if @w_estado_op = 0 and @i_fecha_liq > @w_di_fecha_ven begin
   if @i_crea_ext is null
      PRINT '2-->liquida.sp = @i_fecha_liq' + cast (@i_fecha_liq as varchar) + '@w_di_fecha_ven' + cast (@w_di_fecha_ven as varchar)
   else
      select @o_msg = '2-->liquida.sp = @i_fecha_liq' + cast (@i_fecha_liq as varchar) + '@w_di_fecha_ven' + cast (@w_di_fecha_ven as varchar)

   select @w_error = 710073
   goto ERROR
end

if @w_estado_op > 0
   select @i_fecha_liq = @w_fecha_ult_proceso

select @w_operacionca_real = opt_operacion
from   ca_operacion_tmp
where  opt_banco = @i_banco_real

if @@rowcount = 0 begin
   select @w_operacionca_real = op_operacion
   from   ca_operacion
   where  op_banco = @i_banco_real
end

select @w_min_dividendo = min(dit_dividendo)
from   ca_dividendo_tmp
where  dit_operacion    = @w_operacionca_real
and    dit_estado      in (0, 1)

if @w_min_dividendo is null begin --PARA ROTATIVOS CON DIVIDENDOS CANCELADOS
   select @w_min_dividendo = max(dit_dividendo)
   from   ca_dividendo_tmp
   where  dit_operacion    = @w_operacionca_real
end

select @w_gar_admisible = isnull(@w_gar_admisible, 'N')

if @w_tramite is not null begin
   exec @w_return = cob_custodia..sp_gar_admisible
        @s_date      = @s_date,
        @i_tramite   = @w_tramite,
        @o_admisible = @w_admisible out

   if @w_return <> 0 begin
      if @i_crea_ext is not null
         select @o_msg = 'Error desde cob_custodia..sp_gar_admisible Err:' + CONVERT(varchar(10),@w_return)
      select @w_error = 710522
      goto ERROR
   end

   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end

   if @w_gar_admisible <> @w_admisible
   begin
      update ca_operacion_tmp with (rowlock)
      set    opt_gar_admisible = @w_admisible
      where  opt_operacion     = @w_operacionca_real

      if @@error <> 0 begin
         if @i_crea_ext is null begin
            print 'Error en actualizacion de ca_operacion_tmp por @w_gar_admisible'
         end
         else
            select @o_msg = 'Error en actualizacion de ca_operacion_tmp por @w_gar_admisible'

         select @w_error = 7100024
         goto ERROR
      end

      update ca_operacion with (rowlock)
      set    op_gar_admisible = @w_admisible
      where  op_operacion     = @w_operacionca_real

      if @@error <> 0 begin
         if @i_crea_ext is null begin
             print 'Error en actualizacion de ca_operacion por @w_gar_admisible'
          end
          else
             select @o_msg = '5 - Gar_Admisible : ' + cast(@w_admisible as varchar) + ' - ' + cast(@i_banco_real as varchar) + ' - ' + 'Error en actualizacion de ca_operacion por @w_gar_admisible'
         select @w_error = 7100025
         goto ERROR
      end

      update ca_operacion_his with (rowlock)
      set    oph_gar_admisible = @w_admisible
      where  oph_operacion     = @w_operacionca_real
      and oph_secuencial = @w_secuencial

      if @@error <> 0 begin
         select @w_error = 7100025
         goto ERROR
      end

      select @w_gar_admisible = @w_admisible
   end
end

/* CALCULO COMFNGANU */
if exists (select 1 from ca_rubro_op_tmp where rot_operacion = @w_operacionca_ficticio and rot_concepto = @w_parametro_fng and rot_valor > 0) begin
   exec @w_error     = sp_calculo_fng
   @i_operacion      = @w_operacionca_ficticio,
   @i_desde_abnextra = 'N'

   if @w_error <> 0
      return @w_error
end

-- VERIFICACION DE QUE LOS MONTOS DESEMBOLSADOS + DESCUENTOS = CAPITAL
select @w_monto_op    = isnull(sum(rot_valor),0)
from   ca_rubro_op_tmp
where  rot_operacion  = @w_operacionca_ficticio
and    rot_tipo_rubro = 'C'

select @w_monto_gastos = isnull(sum(rot_valor),0)
from   ca_rubro_op_tmp,
       ca_rubro
where  rot_operacion   = @w_operacionca_ficticio
and    rot_fpago       = 'L'
and    rot_concepto    = ru_concepto
and    ru_banco        = 'S'
and    ru_toperacion   = @w_toperacion
and    ru_moneda       = @w_moneda
select @w_monto_gastos = isnull(@w_monto_gastos,0)

if @w_estado_op = 0 begin --SOLO SE COBRAND ANTICIPADOS EN LA LIQUIDACION
   if @w_op_tipo not in ('D','F') begin
      select @w_int_ant = round(isnull(sum(amt_cuota),0), @w_num_dec)
      from   ca_amortizacion_tmp,ca_rubro_op_tmp
      where  amt_operacion    = @w_operacionca_ficticio
      and    amt_dividendo    = 1
      and    rot_operacion    = @w_operacionca_ficticio
      and    rot_concepto     = amt_concepto
      and    rot_fpago        = 'A'
   end
   else begin
      select @w_int_ant = round(isnull(sum(amt_cuota),0), @w_num_dec)
      from   ca_amortizacion_tmp,ca_rubro_op_tmp
      where  amt_operacion    = @w_operacionca_ficticio
      and    rot_operacion    = @w_operacionca_ficticio
      and    rot_concepto     = amt_concepto
      and    rot_fpago        = 'A'
   end

   select @w_monto_gastos = @w_monto_gastos + isnull(@w_int_ant,0)

   -- SELECT PARA DETERMINAR EL INTERES TOTAL DE LA OPERACION
   select @w_int_ant_total = round(isnull(sum(amt_cuota + amt_gracia),0), @w_num_dec)
   from   ca_amortizacion_tmp,ca_rubro_op_tmp
   where  amt_operacion  = @w_operacionca_ficticio
   and    rot_operacion  = @w_operacionca_ficticio
   and    rot_concepto   = amt_concepto
   and    rot_tipo_rubro = 'I'
   and    rot_fpago      = 'T'

   select @w_monto_gastos = @w_monto_gastos + isnull(@w_int_ant_total,0)
   select @w_monto_gastos = round(@w_monto_gastos, @w_num_dec)
end

-- SI SE TRATA DE CAPITALIZACION, NO GENERAR GASTOS ANTICIPADOS
if @i_capitalizacion = 'S'
   select @w_monto_gastos = 0.00

select @w_monto_des      = isnull(sum(dm_monto_mop),0),
       @w_cotizacion_des = isnull(avg(dm_cotizacion_mop),0)
from   ca_desembolso
where  dm_operacion    = @w_operacionca_real
and    dm_secuencial   = @w_secuencial

if @w_monto_op - round(@w_monto_gastos + @w_monto_des,@w_num_dec) > 0.01 begin
   if @i_crea_ext is null
      PRINT 'liquida.sp @w_monto_gastos @w_monto_des @w_monto_op ' + cast(@w_monto_gastos as varchar) + ' ' + cast(@w_monto_des as varchar) + ' ' + cast(@w_monto_op as varchar)
   else
      select @o_msg = 'liquida.sp @w_monto_gastos @w_monto_des ' + cast(@w_monto_gastos as varchar) + ' ' + cast(@w_monto_des as varchar)

   select @w_error = 710017
   goto ERROR
end

if @w_monto_op - round(@w_monto_gastos ,@w_num_dec) <= 0 begin
   if @i_crea_ext is null
      PRINT 'liquida.sp @w_monto_gastos @w_monto_des ' + cast(@w_monto_gastos as varchar) + ' ' + cast(@w_monto_op as varchar)
   else
      select @o_msg = 'liquida.sp @w_monto_gastos @w_monto_des ' + cast(@w_monto_gastos as varchar) + ' ' + cast(@w_monto_op as varchar)   select @w_error = 710556

   select @w_error = 710556
   goto ERROR
end

-- GENERACION DEL NUMERO DE RECIBO DE LIQUIDACION

exec @w_return = sp_numero_recibo
     @i_tipo    = 'L',
     @i_oficina = @s_ofi,
     @o_numero  = @w_sec_liq out

if @w_return <> 0 begin
   select @w_error = @w_return
   goto ERROR
end


if @w_tr_tipo in ('R','E') begin ---PARA LAS RENOVACIONES(R) YA SE ESTA CONTROLANDO EN RENOVAC.SP
   select @w_calificacion = max(isnull(op_calificacion,'A'))
   from   cob_cartera..ca_operacion, cob_credito..cr_op_renovar
   where  op_banco   = or_num_operacion
   and    or_tramite = @w_tramite

   if exists (select    1
              from      cob_cartera..ca_operacion,
                        cob_credito..cr_op_renovar
              where     op_banco        = or_num_operacion
              and       op_tipo_empresa = 'C'
              and       or_tramite      = @w_tramite)
   begin
      update cob_cartera..ca_operacion with (rowlock)
      set    op_tipo_empresa = 'C',
             op_calificacion = @w_calificacion
      where  op_tramite  = @w_tramite

      update cob_cartera..ca_operacion_his with (rowlock)
      set    oph_tipo_empresa = 'C',
             oph_calificacion = @w_calificacion
      where  oph_tramite  = @w_tramite
      and oph_secuencial = @w_secuencial

   end
   else begin
      update ca_operacion with (rowlock)
      set    op_calificacion = @w_calificacion,
             op_tipo_empresa = 'B'
      where  op_operacion    = @w_operacionca_real

      if @@error <> 0 begin
        select @w_error = 705076
        goto ERROR
      end

      update ca_operacion_his with (rowlock)
      set    oph_calificacion = @w_calificacion,
             oph_tipo_empresa = 'B'
      where  oph_operacion    = @w_operacionca_real
      and oph_secuencial = @w_secuencial

      if @@error <> 0 begin
        select @w_error = 705076
        goto ERROR
      end

   end
end

--LGAR

-- Si la operacion Tiene FNG pero no calculo valores

select @w_gar_op = cu_tipo from cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia , cob_cartera..ca_operacion
where gp_garantia = cu_codigo_externo and   gp_tramite  = op_tramite
and   cu_tipo in (select tc_tipo from #tipo_garantia)
and   op_operacion = @w_operacionca_ficticio
and   cu_estado      <> 'A' and   gp_est_garantia  <> 'A'

select @w_plazo_meses = (@w_plazo * td_factor / 30)
from   ca_tdividendo
where  td_tdividendo = @w_tplazo

if exists ( select 1 from #tipo_garantia
            where tc_tipo  = @w_gar_op
          )
          and  @w_plazo_meses > 12
begin
   -- validar si el plazo es multiplo de 12
   select @w_cobros = (@w_plazo_meses / 12.00)
   if abs(@w_cobros - (@w_plazo_meses / 12)) = 0
      select @w_cobros = @w_cobros - 1

   select @w_cobros_amortiza = count(1)
   from cob_cartera..ca_amortizacion,
        cob_cartera..ca_operacion
   where am_operacion = op_operacion
   and   op_operacion = @w_operacionca_ficticio
   and   am_concepto  = @w_parametro_fng
   and   am_cuota   > 0

   if ((@w_cobros - @w_cobros_amortiza) > 0.99 or @w_cobros_amortiza = 0 )
   and @w_op_tipo_amortizacion != @w_tflexible -- 392
   begin
      exec @w_error = sp_calculo_fng
      @i_operacion      = @w_operacionca_ficticio,
      @i_desde_abnextra = 'N'

      if @w_error <> 0 goto ERROR

      exec sp_pasodef
      @i_banco             = @w_banco,
      @i_amortizacion      = 'S'

   end
end
---ULTIMA VALIDACIÓN

if exists ( select 1 from #tipo_garantia
            where tc_tipo  = @w_gar_op
          )
          and  @w_plazo_meses > 12
begin
   -- validar si el plazo es multiplo de 12
   select @w_cobros = (@w_plazo_meses / 12.00)
   if abs(@w_cobros - (@w_plazo_meses / 12)) = 0
      select @w_cobros = @w_cobros - 1

   select @w_cobros_amortiza = count(1)
   from cob_cartera..ca_amortizacion ,
        cob_cartera..ca_operacion,
        cob_cartera..ca_rubro_op
   where am_operacion = op_operacion
   and   op_operacion = @w_operacionca_ficticio
   and   am_concepto  = @w_parametro_fng
   and   am_cuota   > 0
   and   am_concepto    = ro_concepto
   and   am_operacion   = ro_operacion
   and   ro_porcentaje <> 0

   if (@w_cobros - @w_cobros_amortiza) > 0.99 and @w_cobros_amortiza <> 0
   begin
      print '@w_cobros=' + convert(varchar, @w_cobros) + ', @w_cobros_amortiza='+convert(varchar, @w_cobros_amortiza)
           + ', @w_plazo=' + convert(varchar, @w_plazo)
       if @i_crea_ext is null
          print 'La tabla de Amortizacion no Genero el rubro FNG Anual correctamente, Comuniquese con Operaciones'
       else
          select @o_msg = 'La tabla de Amortizacion no Genero el rubro FNG Anual correctamente, Comuniquese con Operaciones'
       select @w_error = 705050
       goto   ERROR
   end
end


-- REQ 392 Pagos Flexibles
if @w_tipo_amortizacion = @w_tflexible
begin
   declare
      @w_porcentaje_efa float,
      @w_porcentaje     float,
      @w_dias_cuota     smallint

   update ca_rubro_op
   set    ro_porcentaje_efa = isnull(ro_porcentaje_cobrar, ro_porcentaje_efa)
   where  ro_operacion  = @w_operacionca_real
   and    ro_tipo_rubro = 'I'

   select @w_ro_fpago         = ro_fpago,
          @w_porcentaje_efa   = ro_porcentaje_efa
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca_real
   and    ro_tipo_rubro = 'I'

   if @w_ro_fpago in ('P', 'T')
      select @w_ro_fpago = 'V'

   select @w_dias_cuota = di_dias_cuota
   from   ca_dividendo
   where  di_operacion = @w_operacion_real
   and    di_dividendo = 1

   -- CALCULAR LA TASA EQUIVALENTE
   exec @w_error = sp_conversion_tasas_int
         @i_periodo_o       = 'A',
         @i_modalidad_o     = 'V',
         @i_num_periodo_o   = 1,
         @i_tasa_o          = @w_porcentaje_efa,
         @i_periodo_d       = 'D',
         @i_modalidad_d     = @w_ro_fpago,
         @i_num_periodo_d   = @w_dias_cuota,
         @i_dias_anio       = @w_dias_anio,
         @i_num_dec         = 4,
         @o_tasa_d          = @w_porcentaje output

   if @w_error != 0
      return @w_error

   update ca_rubro_op
   set    ro_porcentaje = @w_porcentaje
   where  ro_operacion = @w_operacionca_real
   and    ro_tipo_rubro = 'I'
end

insert into ca_transaccion
      (tr_secuencial,        tr_fecha_mov,        tr_toperacion,
       tr_moneda,            tr_operacion,        tr_tran,
       tr_en_linea,          tr_banco,            tr_dias_calc,
       tr_ofi_oper,          tr_ofi_usu,          tr_usuario,
       tr_terminal,          tr_fecha_ref,        tr_secuencial_ref,
       tr_estado,            tr_gerente,          tr_gar_admisible,
       tr_reestructuracion,  tr_calificacion,
       tr_observacion,       tr_fecha_cont,       tr_comprobante)
values(@w_secuencial,        @s_date,             @w_toperacion,
       @w_moneda,            @w_operacionca_real, 'DES',
       'S',                  @i_banco_real,       isnull(@w_sec_liq,0),
       @w_oficina,           @s_ofi,              @s_user,
       @s_term,              @w_fecha_ini,        0,
       'ING',                @w_oficial,          isnull(@w_gar_admisible,''),
       isnull(@w_reestructuracion,''),      isnull(@w_calificacion,''),
       '',                   @s_date,             0)

if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end

-- INSERCION DEL DETALLE CONTABLE PARA LAS FORMAS DE PAGO
declare cursor_desembolso cursor
for select dm_desembolso,    dm_producto,          dm_cuenta,
           dm_beneficiario,  dm_monto_mds,
           dm_moneda,        dm_cotizacion_mds,    dm_tcotizacion_mds,
           dm_monto_mn,      dm_cotizacion_mop,    dm_tcotizacion_mop,
           dm_monto_mop,     dm_cheque,            dm_cod_banco,
           dm_pagado
    from   ca_desembolso
    where  dm_secuencial = @w_secuencial
    and    dm_operacion  = @w_operacion_real
    order  by dm_desembolso
    for read only

open cursor_desembolso

fetch cursor_desembolso
into  @w_dm_desembolso,   @w_dm_producto,       @w_dm_cuenta,
      @w_dm_beneficiario, @w_dm_monto_mds,
      @w_dm_moneda,       @w_dm_cotizacion_mds, @w_dm_tcotizacion_mds,
      @w_dm_monto_mn,     @w_dm_cotizacion_mop, @w_dm_tcotizacion_mop,
      @w_dm_monto_mop,    @w_instrumento,       @w_subtipo,
      @w_pagado

while @@fetch_status = 0 begin
   if (@@fetch_status = -1) begin
      close cursor_desembolso
      deallocate cursor_desembolso
      select @w_error = 710004
      goto ERROR
   end

   select @w_prod_cobis_ach = isnull(cp_pcobis,0),
          @w_categoria      = cp_categoria,
          @w_codvalor       = cp_codvalor
   from   ca_producto
   where  cp_producto = @w_dm_producto

   if @@rowcount <> 1 begin
       close cursor_desembolso
       deallocate cursor_desembolso
       select @w_error = 701150
       goto ERROR
   end

   if @w_dm_producto = @w_abd_concepto begin
      select @w_dm_beneficiario = @w_dm_beneficiario + ' - ' + 'DESEMBOLSO OPER-HIJA'
   end

   -- INSERCION DEL DETALLE DE LA TRANSACCION
   insert ca_det_trn
         (dtr_secuencial,    dtr_operacion,           dtr_dividendo,        dtr_concepto,
          dtr_estado,        dtr_periodo,             dtr_codvalor,         dtr_monto,
          dtr_monto_mn,      dtr_moneda,              dtr_cotizacion,       dtr_tcotizacion,
          dtr_afectacion,    dtr_cuenta,              dtr_beneficiario,     dtr_monto_cont)
   values(@w_secuencial,     @w_operacionca_real,     @w_dm_desembolso,     @w_dm_producto,
          1,                 0,                       @w_codvalor,          @w_dm_monto_mds,
          @w_dm_monto_mn,    @w_dm_moneda,            @w_dm_cotizacion_mds, @w_dm_tcotizacion_mds,
          'C',               isnull(@w_dm_cuenta,''), isnull(@w_dm_beneficiario,''),   0)

   if @@error <> 0  begin
      close cursor_desembolso
      deallocate cursor_desembolso
      select @w_error = 710001
      goto ERROR
   end

   if  @w_prod_cobis_ach <> 0 begin
      select @w_oficina_ifase = @s_ofi

      select @w_tipo_oficina_ifase = dp_origen_dest
      from   ca_trn_oper, cob_conta..cb_det_perfil
      where  to_tipo_trn = 'DES'
      and    to_toperacion = @w_toperacion
      and    dp_empresa    = 1
      and    dp_producto   = 7
      and    dp_perfil     = to_perfil
      and    dp_codval     = @w_codvalor

      if @@rowcount = 0 begin
         close cursor_desembolso
         deallocate cursor_desembolso
         select @w_error = 710446
         goto ERROR
      end

      if @w_tipo_oficina_ifase = 'C' begin
         select @w_oficina_ifase = pa_int
         from   cobis..cl_parametro with (nolock)
         where  pa_nemonico = 'OFC'
         and    pa_producto = 'CON'
      end

      if @w_tipo_oficina_ifase = 'D' begin
         select @w_oficina_ifase = @w_oficina
      end

      -- AFECTACION A OTROS PRODUCTOS
      if @w_pagado = 'N' or @w_pagado is null begin

         exec @w_return = sp_afect_prod_cobis
              @s_user               = @s_user,
              @s_date               = @s_date,
              @s_ssn                = @s_ssn,
              @s_sesn               = @s_sesn,
              @s_term               = @s_term,
              @s_srv                = @s_srv,
              @s_ofi                = @w_oficina_ifase,
              @i_fecha              = @i_fecha_liq,
              @i_cuenta             = @w_dm_cuenta,
              @i_producto           = @w_dm_producto,
              @i_monto              = @w_dm_monto_mn,
              @i_mon                = @w_dm_moneda,  /* ELA FEB/2002 */
              @i_beneficiario       = @w_dm_beneficiario,
              @i_monto_mpg          = @w_dm_monto_mds,
              @i_monto_mop          = @w_dm_monto_mop,
              @i_monto_mn           = @w_dm_monto_mn,
              @i_cotizacion_mop     = @w_dm_cotizacion_mop,
              @i_tcotizacion_mop    = @w_dm_tcotizacion_mop,
              @i_cotizacion_mpg     = @w_dm_cotizacion_mds,
              @i_tcotizacion_mpg    = @w_dm_tcotizacion_mds,
              @i_operacion_renovada = @w_operacion_real,
              @i_alt                = @w_operacion_real,
              @i_instrumento        = @w_instrumento,
              @i_subtipo            = @w_subtipo,
              @i_pagado             = @w_pagado,
              @i_dm_desembolso      = @w_dm_desembolso,
              @i_sec_tran_cca       = @w_secuencial,         -- FCP Interfaz Ahorros
              @o_num_renovacion     = @w_num_renovacion out,
              @o_secuencial         = @w_num_secuencial out

         if @w_return <> 0 begin
            close cursor_desembolso
            deallocate cursor_desembolso
            select @w_error = @w_return
            goto ERROR
         end

         update ca_desembolso with (rowlock)
         set dm_idlote = @w_num_secuencial
         where dm_desembolso = @w_dm_desembolso
         and   dm_operacion  = @w_operacion_real

         if @@rowcount = 0 begin
               close cursor_desembolso
               deallocate cursor_desembolso
               select @w_error = 701121
               goto ERROR
         end
      end
   end

   -- INTERFAZ PARA SIPLA
   if @w_op_naturaleza = 'A'  begin

      exec @w_return = sp_interfaz_otros_modulos
           @s_user       = @s_user,
           @i_cliente    = @w_cliente,
           @i_modulo     = 'CCA',
           @i_interfaz   = 'S',
           @i_modo       = 'I',
           @i_obligacion = @w_banco,
           @i_moneda     = @w_dm_moneda,
           @i_sec_trn    = @w_secuencial,
           @i_fecha_trn  = @i_fecha_liq,
           @i_desc_trn   = 'DESEMBOLSO DE CARTERA',
           @i_monto_trn  = @w_dm_monto_mop,
           @i_monto_des  = @w_dm_monto_mds,
           @i_gerente    = @s_user,
           @i_oficina    = @s_ofi,
           @i_cotizacion = @w_dm_cotizacion_mop,
           @i_forma_pago = @w_dm_producto,
           @i_categoria  = @w_categoria,
           @i_moneda_uvr = @w_moneda_uvr

      if @w_return <> 0 begin
         close cursor_desembolso
         deallocate cursor_desembolso
         select @w_error = @w_return
         goto ERROR
      end
  end

   if @w_dm_producto = 'EFMN' begin

      exec @w_return  = cob_interfase..sp_genera_orden
      @s_date         = @s_date,             --> Fecha de proceso
      @s_user         = @s_user,             --> Usuario
      @i_ofi          = @s_ofi,
      @i_operacion    = 'I',                 --> Operacion ('I' -> Insercion, 'A' Anulación)
      @i_causa        = '003',               --> Causal de Egreso(cc_causa_oe)
      @i_ente         = @w_cliente,          --> Cod ente,
      @i_valor        = @w_dm_monto_mn,
      @i_tipo         = 'P',
      @i_idorden      = null,                --> Cód Orden cuando operación 'A',
      @i_ref1         = 0,                   --> Ref. Númerica no oblicatoria
      @i_ref2         = 0 ,                  --> Ref. Númerica no oblicatoria
      @i_ref3         = @w_banco,            --> Ref. AlfaNúmerica no oblicatoria
      @i_interfaz     ='N',                  --> 'N' - Invoca sp_cerror, 'S' - Solo devuelve cód error
      @o_idorden      = @w_num_orden out     --> Devuelve cód orden de pago/cobro generada - Operación 'I'
      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end else
      update ca_desembolso with (rowlock)
      set dm_pagado = 'I',
          dm_orden_caja  = @w_num_orden
      where dm_operacion = @w_operacionca_real
      and   dm_producto  = 'EFMN'
      if @@error <> 0 begin
         if @i_crea_ext is null
            print 'liquida.sp Error en actualizacion ca_desembolso '
         else
            select @o_msg = 'liquida.sp Error en actualizacion ca_desembolso '
         select @w_error = 710305
         goto ERROR
      end
   end

   fetch cursor_desembolso
   into  @w_dm_desembolso,   @w_dm_producto,       @w_dm_cuenta,
         @w_dm_beneficiario, @w_dm_monto_mds,
         @w_dm_moneda,       @w_dm_cotizacion_mds, @w_dm_tcotizacion_mds,
         @w_dm_monto_mn,     @w_dm_cotizacion_mop, @w_dm_tcotizacion_mop,
         @w_dm_monto_mop,    @w_instrumento,       @w_subtipo,
         @w_pagado
end

close cursor_desembolso
deallocate cursor_desembolso

--GENERACION DE LA COMISION DIFERIDA
exec @w_error  = sp_comision_diferida
@s_date        = @s_date,
@i_operacion   = 'L',
@i_operacionca = @w_operacion_real

if @w_error <>0 goto ERROR

-- OBTENCION DE LA COTIZACION Y TIPO DE COTIZACION DE LA OPERACION */
select @w_dm_cotizacion_mop  = dm_cotizacion_mop,
       @w_dm_tcotizacion_mop = dm_tcotizacion_mop,
       @w_instrumento = dm_cheque,
       @w_subtipo     = dm_cod_banco
from   ca_desembolso
where  dm_operacion    = @w_operacionca_real
and    dm_secuencial   = @w_secuencial

--VALIDACION PARA EVITAR REGISTRAR EL DETALLE DE LA TRANSACCION INCOMPLETO
--EL SISTEMA GENERARA UN ERROR SI ESTO SE PRESENTA POR CONEXION

if not exists (select 1
       from   ca_rubro_op_tmp
       where  rot_operacion = @w_operacionca_ficticio
       and    ( rot_fpago  in ('L','A') or (rot_tipo_rubro = 'C') )
       and    rot_tipo_rubro <> 'I' )
begin
    select @w_error = 703025
    goto ERROR
end


-- INSERCION DEL DETALLE CONTABLE PARA LOS RUBROS AFECTADOS
declare cursor_rubro cursor
for select rot_concepto,convert(float,rot_valor),rot_tipo_rubro,rot_fpago, rot_porcentaje
    from   ca_rubro_op_tmp
    where  rot_operacion = @w_operacionca_ficticio
    and    ( rot_fpago  in ('L','A') or (rot_tipo_rubro = 'C') )
    and    rot_tipo_rubro <> 'I'  ---Salen en otro select
    and    rot_valor > 0
    order  by rot_concepto
    for read only

open cursor_rubro

fetch cursor_rubro
into  @w_ro_concepto, @w_ro_valor, @w_ro_tipo_rubro, @w_ro_fpago, @w_ro_porcentaje

while @@fetch_status = 0 begin
   if (@@fetch_status = -1) begin
        close cursor_rubro
        deallocate cursor_rubro
        select @w_error = 710004
        goto ERROR
   end

   select @w_tipo_garantia = 0  --NO ADMISIBLE

   if @w_ro_tipo_rubro = 'C' begin
       if @w_gar_admisible = 'S'
          select @w_tipo_garantia = 1  --ADMISIBLE

       update ca_rubro_op with (rowlock)
       set    ro_garantia  = ro_valor * @w_tipo_garantia
       where  ro_operacion = @w_operacionca_real
       and    ro_concepto  = @w_ro_concepto

       if @@error <> 0 begin
           close cursor_rubro
           deallocate cursor_rubro
           if @i_crea_ext is null begin
              print 'Error en actualizacion de ca_rubro_op'
           end
           else
              select @o_msg = '6 - Tipo Gar : ' + cast(@w_tipo_garantia as varchar) + ' -Concepto: ' + cast(@w_ro_concepto as varchar) + ' Ope Real : ' + cast(@w_operacionca_real as varchar) + ' - ' + 'Error en actualizacion de ca_rubro_op'
           select @w_error = 7100026
           goto ERROR
       end

       -- CAMBIO DE LOS CAMPOS AM_CORRECCION_XXX A LA NUEVA TABLA CA_CORRECCION

       if @w_moneda = 2 begin
           update ca_correccion with (rowlock)
           set    co_liquida_mn = round (convert(float, am_cuota) * convert(float, @w_dm_cotizacion_mop), @w_num_dec_mn)
           from   ca_amortizacion,ca_correccion
           where  am_operacion = @w_operacionca_real
           and    am_concepto = @w_ro_concepto
           and    am_operacion = co_operacion
           and    am_concepto  = co_concepto
           and    am_dividendo = co_dividendo

           if @@error <> 0 begin
               close cursor_rubro
               deallocate cursor_rubro
               if @i_crea_ext is null begin
                  print 'Error en actualizacion de ca_correccion'
               end
               else
                  select @o_msg =  '7 -  co_liquida_mn : ' + cast(@w_dm_cotizacion_mop as varchar) + ' -Concepto: ' + cast(@w_ro_concepto as varchar) + ' Ope Real : ' + cast(@w_operacionca_real as varchar) + ' - ' + 'Error en actualizacion de ca_correccion'
               select @w_error = 7100027
               goto ERROR
           end
       end
   end

   -- COLOCAR COMO PAGADOS LOS RUBROS DEL DIVIDENDO 1 QUE SON ANT  <> de INTERESES

   if @w_ro_fpago = 'A' begin
      update ca_amortizacion with (rowlock)
      set    am_pagado = am_cuota,
             am_estado = @w_est_cancelado
      from   ca_rubro_op
      where  am_operacion  = @w_operacionca_real
      and    am_dividendo = 1
      and    ro_operacion  = @w_operacionca_real
      and    am_concepto   = ro_concepto
      and    ro_tipo_rubro <> 'I'
      and    ro_fpago      = 'A'

      if @@error <> 0 begin
          close cursor_rubro
          deallocate cursor_rubro
          if @i_crea_ext is null begin
             print 'Error en actualizacion de ca_amortizacion'
          end
          else
             select @o_msg = '8 -  Estado : ' + cast(@w_est_cancelado as varchar) + ' Ope Real : ' + cast(@w_operacionca_real as varchar) + ' - ' + 'Error en actualizacion de ca_amortizacion'
          select @w_error = 7100028
          goto ERROR
      end


      select @w_ro_valor =  am_cuota
      from   ca_amortizacion
      where  am_operacion  = @w_operacionca_real
      and    am_dividendo = 1
      and    am_concepto     = @w_ro_concepto
   end

   -- SE ASUME QUE UNA OPERACION NUEVA NO TIENE ASIGNADA GARANTIA
   -- OBTENCION DE CODIGO VALOR DEL RUBRO

   select @w_codvalor = co_codigo * 1000  + 10  + 0 --@w_tipo_garantia
   from   ca_concepto
   where  co_concepto = @w_ro_concepto

   if @@rowcount <> 1 begin
       close cursor_rubro
       deallocate cursor_rubro
       select @w_error = 701151
       goto ERROR
   end

   select @w_ro_valor_mn = round(@w_ro_valor*@w_dm_cotizacion_mop,@w_num_dec_mn)
   select @w_ro_valor = round(@w_ro_valor,@w_num_dec)
   if @w_ro_tipo_rubro = 'C'
      select @w_afectacion = 'D'
   else
      select @w_afectacion = 'C'

   -- INSERCION DEL DETALLE DE LA TRANSACCION

   insert ca_det_trn
         (dtr_secuencial,    dtr_operacion,       dtr_dividendo,        dtr_concepto,
          dtr_estado,        dtr_periodo,         dtr_codvalor,         dtr_monto,
          dtr_monto_mn,      dtr_moneda,          dtr_cotizacion,       dtr_tcotizacion,
          dtr_afectacion,    dtr_cuenta,          dtr_beneficiario,     dtr_monto_cont)
   values(@w_secuencial,     @w_operacionca_real, @w_min_dividendo,     @w_ro_concepto,
          1,                 0,                   @w_codvalor,          @w_ro_valor,
          @w_ro_valor_mn,    @w_moneda,           @w_dm_cotizacion_mop, @w_dm_tcotizacion_mop,
          @w_afectacion,     '',                  '',                   0)


   if @@error <> 0 begin
       close cursor_rubro
       deallocate cursor_rubro
       select @w_error = 710001
       goto ERROR
   end

   /*RUBRO CANCELADO APCRE, PARA MOVIMIENTO DE CUENTA CONTABLE*/
   if @w_parametro_apecr = @w_ro_concepto begin ---CODIGO PARA RUBRO APCRE EN ESTADO CANCELADO
      select @w_can_deu = isnull(count(*),0)
      from   cob_credito..cr_deudores
      where  de_tramite     = @w_tramite
      and    de_cobro_cen   = 'N'

      select @w_codvalor = co_codigo * 1000  + 30  + 0 --@w_tipo_garantia
      from   ca_concepto
      where  co_concepto = @w_ro_concepto

      if @w_can_deu <> 0 begin  --PARA RUBROS CANCELADOS

         select @w_valor_rubro = round((@w_can_deu * @w_ro_porcentaje), @w_num_dec)

         insert ca_det_trn (
         dtr_secuencial,       dtr_operacion,       dtr_dividendo,        dtr_concepto,
         dtr_estado,           dtr_periodo,         dtr_codvalor,         dtr_monto,
         dtr_monto_mn,         dtr_moneda,          dtr_cotizacion,       dtr_tcotizacion,
         dtr_afectacion,       dtr_cuenta,          dtr_beneficiario,     dtr_monto_cont)
         values (
         @w_secuencial,        @w_operacionca_real, @w_min_dividendo,     @w_ro_concepto,
         3,                    0,                   @w_codvalor,          @w_valor_rubro,
         @w_valor_rubro,       @w_moneda,           @w_dm_cotizacion_mop, @w_dm_tcotizacion_mop,
         'N',                  '',                  '',                   0
         )

         if @@error <>0 begin
            close cursor_rubro
            deallocate cursor_rubro
            select @w_error = 710001
            goto ERROR
         end
      end
   end

   if @w_op_tipo <> 'R' and @w_tramite is not null begin -- FQ

       select @w_tr_contabilizado = tr_contabilizado
       from   cob_credito..cr_tramite
       where  tr_tramite in (select li_tramite
                             from   cob_credito..cr_tramite, cob_credito..cr_linea
                             where  tr_tramite = @w_tramite
                             and    li_numero  = tr_linea_credito
                             and    li_tipo = 'O')

       if @w_ro_tipo_rubro = 'C' and   @w_tr_contabilizado = 'S' begin
           select @w_codvalor = co_codigo * 1000  + 990
           from   ca_concepto
           where  co_concepto = @w_ro_concepto

           -- INSERCION DEL DETALLE DE LA TRANSACCION
           insert ca_det_trn
                 (dtr_secuencial,    dtr_operacion,       dtr_dividendo,        dtr_concepto,
                  dtr_estado,        dtr_periodo,         dtr_codvalor,         dtr_monto,
                  dtr_monto_mn,      dtr_moneda,          dtr_cotizacion,       dtr_tcotizacion,
                  dtr_afectacion,    dtr_cuenta,          dtr_beneficiario,     dtr_monto_cont)
           values(@w_secuencial,     @w_operacionca_real, @w_min_dividendo,     @w_ro_concepto,
                  1,                 0,                   @w_codvalor,          @w_ro_valor,
                  @w_ro_valor_mn,    @w_moneda,           @w_dm_cotizacion_mop, @w_dm_tcotizacion_mop,
                  @w_afectacion,     '',                  '',                   0)

           if @@error <>0 begin
               close cursor_rubro
               deallocate cursor_rubro
               select @w_error = 710001
               goto ERROR
           end
       end
   end

   fetch cursor_rubro
   into @w_ro_concepto, @w_ro_valor, @w_ro_tipo_rubro, @w_ro_fpago, @w_ro_porcentaje
end

close cursor_rubro
deallocate cursor_rubro

/*PARA INTERES ANTICIPADO*/
if exists (select 1
           from   ca_rubro_op_tmp
           where  rot_operacion = @w_operacionca_ficticio
           and    rot_tipo_rubro = 'I'
           and    rot_fpago = 'A')
begin

   if @w_op_tipo  in ('D' ,'F') begin  -- Documento Descontado

      insert into ca_det_trn (
      dtr_secuencial,                                      dtr_operacion,        dtr_dividendo,         dtr_concepto,
      dtr_estado,                                          dtr_periodo,          dtr_codvalor,          dtr_monto,
      dtr_monto_mn,                                        dtr_moneda,           dtr_cotizacion,        dtr_tcotizacion,
      dtr_afectacion,                                      dtr_cuenta,           dtr_beneficiario,      dtr_monto_cont)
      select
      @w_secuencial,                                       @w_operacionca_real,  @w_min_dividendo,      amt_concepto,
      1,                                                   0,                    co_codigo*1000+10+0,   amt_cuota,
      round(amt_cuota*@w_dm_cotizacion_mop,@w_num_dec_mn), @w_moneda,            @w_dm_cotizacion_mop,  '',
      'C',                                                 '',                   '',                    0
      from  ca_amortizacion_tmp, ca_concepto ,ca_rubro_op_tmp
      where amt_operacion = @w_operacionca_ficticio
      and   amt_concepto  = co_concepto
      and   rot_operacion = @w_operacionca_ficticio
      and   rot_concepto  = amt_concepto
      and   rot_tipo_rubro= 'I'
      and   rot_fpago     = 'A'

      if @@error <> 0 begin
         select @w_error = 710001
         goto ERROR
      end

      update ca_amortizacion with (rowlock) set
      am_pagado    = am_cuota,
      am_estado    =  3,
      am_acumulado = 0
      from ca_rubro_op
      where am_operacion  = @w_operacionca_ficticio
      and   ro_operacion  = @w_operacionca_ficticio
      and   am_concepto   = ro_concepto
      and   ro_tipo_rubro = 'I'
      and   ro_fpago      = 'A'

      if @@error <> 0 begin
         if @i_crea_ext is null begin
             print 'Error en Actualizacion de ca_amortizacion por @w_operacionca_ficticio'
          end
          else
             select @o_msg = '9 - Op Ficticio : ' + cast(@w_operacionca_ficticio as varchar) + ' - ' + 'Error en Actualizacion de ca_amortizacion por @w_operacionca_ficticio'
         select @w_error = 7100029
         goto ERROR
      end
   end
   else begin
      --- INSERCION DE LOS DETALLES CORRESPONDIENTES A LOS INTERESES PERIODICOS ANTICIPADOS
      insert into ca_det_trn
            (dtr_secuencial,        dtr_operacion,        dtr_dividendo,
             dtr_concepto,          dtr_estado,           dtr_periodo,
             dtr_codvalor,          dtr_monto,            dtr_monto_mn,
             dtr_moneda,            dtr_cotizacion,       dtr_tcotizacion,
             dtr_afectacion,        dtr_cuenta,           dtr_beneficiario,
             dtr_monto_cont)
      select @w_secuencial,         @w_operacionca_real,  @w_min_dividendo,
             amt_concepto,          1,                    0,
             co_codigo*1000+10+0,   amt_cuota,            round(amt_cuota*@w_dm_cotizacion_mop,@w_num_dec_mn),
             @w_moneda,             @w_dm_cotizacion_mop, 'C',
            'C',                    '',                   'REGISTRO INTERESES ANTICIPADOS',
             0
      from   ca_amortizacion_tmp, ca_concepto ,ca_rubro_op_tmp
      where  amt_operacion = @w_operacionca_ficticio
      and    amt_dividendo = 1
      and    amt_concepto  = co_concepto
      and    rot_operacion = @w_operacionca_ficticio
      and    rot_concepto  = amt_concepto
      and    rot_tipo_rubro= 'I'
      and    rot_fpago     = 'A'

      if @@error <> 0 begin
         select @w_error = 710001
         goto ERROR
      end

      update ca_amortizacion_tmp with (rowlock)
      set    amt_pagado    = amt_cuota,
             amt_estado    = @w_est_cancelado,
             amt_acumulado = 0 --amt_cuota
      from   ca_rubro_op_tmp
      where  amt_operacion = @w_operacionca_ficticio
      and    amt_dividendo = 1
      and    rot_operacion = @w_operacionca_ficticio
      and    amt_concepto  = rot_concepto
      and    rot_tipo_rubro = 'I'
      and    rot_fpago      = 'A'

      if @@error <> 0 begin
         if @i_crea_ext is null begin
            print 'Error en Actualizacion de ca_amortizacion_tmp por @w_operacionca_ficticio'
         end
         else
            select @o_msg =  '10 - Op Ficticio : ' + cast(@w_operacionca_ficticio as varchar) + ' - ' + 'Error en Actualizacion de ca_amortizacion_tmp por @w_operacionca_ficticio'
         select @w_error = 7100210
         goto ERROR
      end
  end
end

---VALIDACION DE LA GENERACION DEL DETALLE COMPLETO

select @w_limite_ajuste = pa_money
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'LAJUST'

select @w_rowcount = @@rowcount

if @w_rowcount = 0
   select @w_limite_ajuste = 1


select @w_dtr_D = isnull(sum(dtr_monto_mn),0)
from ca_det_trn
where dtr_operacion = @w_operacionca_real
and dtr_secuencial  = @w_secuencial
and dtr_codvalor <> 10990
and dtr_afectacion = 'D'

select @w_dtr_C =  isnull(sum(dtr_monto_mn),0)
from ca_det_trn
where dtr_operacion = @w_operacionca_real
and dtr_secuencial  = @w_secuencial
and dtr_codvalor <> 10990
and dtr_afectacion = 'C'

if @w_dtr_D  <> @w_dtr_C begin
    select @w_diff = (@w_dtr_D  - @w_dtr_C)

   if (@w_moneda <> @w_moneda_local) and (abs(@w_diff) <= @w_limite_ajuste)
      select   @w_diff = @w_diff
   else begin
     select @w_error = 710551
     goto ERROR
  end
end

---VALIDACION CONSISTENCIA VALORES DE SEGUROS
select dtr_operacion,codigo,dtr_monto
into #seg_trn
from cob_credito..cr_corresp_sib with (nolock),
     ca_det_trn with  (nolock)
where dtr_operacion = @w_operacionca_real
and dtr_secuencial  = @w_secuencial
and tabla = 'T155'
and codigo_sib = dtr_concepto

if  (select count(1) from  #seg_trn ) > 0
begin
   select oper_cca = sed_operacion,
          tipo_seg =sed_tipo_seguro,
          sed_sec_seguro,
          se_tramite ,
          valorcca  = isnull(sum(sed_cuota_cap),1)
   into #seg_cca
   from   ca_seguros_det,
          ca_seguros
   where sed_operacion = @w_operacionca_real
   and sed_operacion = se_operacion
   and  sed_sec_seguro = se_sec_seguro
   group by sed_operacion,sed_tipo_seguro,sed_sec_seguro,se_tramite

   if exists (select 1 from #seg_trn,#seg_cca
              where dtr_operacion = oper_cca
              and   codigo = tipo_seg
              and   dtr_monto <> valorcca)
   begin
      PRINT 'liquida.sp Error Diferencia en seguro descontado y seguro detalle'
      select @w_error = 701003
      goto ERROR
   end

   if not exists(select 1 from cob_credito..cr_seguros_tramite
                 where st_tramite  in (select se_tramite from #seg_cca)
                  )
   begin
       select @w_error = 701003
      goto ERROR
   end
end
---FIN vaLIDAR SEGUROS REGISTRADOS y VALORES

---VALIDACION DE LA GENERACION DEL DETALLE COMPLETO

--* PONER VIGENTE LA OPERACION Y AL PRIMER DIVIDENDO
--* SI SE TRATA DE LA PRIMERA LIQUIDACION
if @w_estado_op = 0 begin -- NO VIGENTE

    update ca_amortizacion with (rowlock)
    set    am_pagado    = am_cuota,
           am_acumulado = 0,
           am_estado    = @w_est_cancelado
    from   ca_rubro_op
    where  am_operacion  = @w_operacionca_real
    and    (am_dividendo = 1 and @w_op_tipo <> 'D' and @w_op_tipo <> 'F')
    and    ro_operacion  = @w_operacionca_real
    and    am_concepto   = ro_concepto
    and    ro_tipo_rubro = 'I'
    and    ro_fpago      = 'A'

    if @@error <> 0 begin
       if @i_crea_ext is null begin
          print 'Error en actualizacion de ca_amortizacion por @w_operacionca_real'
       end
       else
          select @o_msg = '11 - Op Real : ' + cast(@w_operacionca_real as varchar) + ' Op tipo : ' + cast(@w_op_tipo as varchar) + ' - ' + 'Error en actualizacion de ca_amortizacion por @w_operacionca_real'
       select @w_error = 7100211
       goto ERROR
    end

    -- INSERTAR TASAS EN CA_TASAS
    declare cursor_rubro cursor
    for select rot_concepto
        from   ca_rubro_op_tmp
        where  rot_operacion   = @w_operacionca_real
        and    rot_tipo_rubro  = 'I'
        for read only

    open cursor_rubro

    fetch cursor_rubro
    into  @w_ro_concepto

    while   @@fetch_status = 0 begin
       if (@@fetch_status = -1) begin
           close cursor_rubro
           deallocate cursor_rubro
           select @w_error = 710004
           goto ERROR
       end

       exec @w_return = sp_consulta_tasas
            @i_operacionca = @w_operacionca_real,
            @i_dividendo   = 1,
            @i_concepto    = @w_ro_concepto,
            @i_sector      = @w_sector,
            @i_fecha       = @i_fecha_liq,
            @i_equivalente = @w_tasa_equivalente,
            @o_tasa        = @w_ro_porcentaje out

       if @w_return <> 0 begin
           close cursor_rubro
           deallocate cursor_rubro
           select @w_error =  @w_return
           goto ERROR
       end

       fetch cursor_rubro
       into @w_ro_concepto
    end

    close cursor_rubro
    deallocate cursor_rubro

    if @w_fecha_ini < @i_fecha_liq begin
       update ca_operacion with (rowlock)
       set    op_estado            = @w_est_vigente,
              op_fecha_ult_proceso = @w_fecha_ini,
              op_fecha_liq         = @i_fecha_liq
       where  op_operacion = @w_operacionca_real

       if @@error <> 0
       begin
           if @i_crea_ext is null begin
                print 'Error en Actualizacion de ca_operacion por @w_operacionca_real'
             end
                select @o_msg = '12 - Fecha Ini : ' + cast(@w_fecha_ini as varchar) + ' Fecha Fin : ' + cast(@i_fecha_liq as varchar) + ' - ' + 'Error en Actualizacion de ca_operacion por @w_operacionca_real'
           select @w_error = 7100212
           goto ERROR
       end
    end
    else begin
       update ca_operacion with (rowlock)
       set    op_estado            = @w_est_vigente,
              op_fecha_ult_proceso = @i_fecha_liq,
              op_fecha_liq         = @i_fecha_liq
       where  op_operacion = @w_operacionca_real

       if @@error <> 0
       begin
          if @i_crea_ext is null begin
               print 'Error en Actualizacion de ca_operacion por @i_fecha_liq'
            end
            else
               select @o_msg = '13 - Fecha Liq: ' + cast(@i_fecha_liq as varchar) + ' - ' + 'Error en Actualizacion de ca_operacion por @i_fecha_liq'

          select @w_error = 7100213
          goto ERROR
       end
    end

    update ca_dividendo with (rowlock)
    set    di_estado = 1
    where  di_operacion = @w_operacionca_real
    and    di_dividendo = 1

    if @@error <> 0 begin
       if @i_crea_ext is null begin
          print 'Error en actualizacion de ca_dividendo'
       end
       else
          select @o_msg = '14 - Op Real: ' + cast(@w_operacionca_real as varchar) + ' - ' + 'Error en actualizacion de ca_dividendo'
       select @w_error = 7100214
       goto ERROR
     end


    update ca_amortizacion with (rowlock)
    set    am_estado = 1
    where  am_operacion  = @w_operacionca_real
    and    am_dividendo  = 1
    and    am_estado <> 3

    if @@error <> 0 begin
       if @i_crea_ext is null begin
          print 'Error en Actualizacion en ca_amortizacion por @w_operacionca_real'
       end
       else
          select @o_msg = '15 - Op Real: ' + cast(@w_operacionca_real as varchar) + ' - ' +  'Error en Actualizacion en ca_amortizacion por @w_operacionca_real'
       select @w_error = 7100215
       goto ERROR
    end

    update ca_amortizacion with (rowlock) set
    am_acumulado = am_cuota,
    am_estado    = 1
    from ca_rubro_op
    where am_operacion = ro_operacion
    and   am_concepto  = ro_concepto
    and   ro_provisiona = 'S'
    and   ro_operacion  = @w_operacionca_real
    and   am_dividendo  = 1
    and   ro_tipo_rubro  not in('C','F','I','M')
    and   (ro_concepto_asociado is null or ro_concepto_asociado = 'INT_ESPERA')

    if @@error <> 0 begin
       select @w_error = 705050
    end

    insert into ca_transaccion_prv with (rowlock)
    select
    tp_fecha_mov       = @s_date,
    tp_operacion       = @w_operacionca_real,
    tp_fecha_ref       = @i_fecha_liq,
    tp_secuencial_ref  = @w_secuencial,
    tp_estado          = 'ING',
    tp_comprobante     = 0,
    tp_fecha_cont      = null,
    tp_dividendo       = am_dividendo,
    tp_concepto        = am_concepto,
    tp_codvalor        =(co_codigo * 1000) + (1 * 10),
    tp_monto           = am_cuota,
    tp_secuencia       = am_secuencia,
    tp_oficina         = @w_oficina
    from ca_amortizacion, ca_rubro_op, ca_concepto
    where am_operacion = ro_operacion
    and   am_concepto  = ro_concepto
    and   am_concepto  = co_concepto
    and   ro_provisiona = 'S'
    and   ro_tipo_rubro  not in('C','F','I','M')
    and   (ro_concepto_asociado is null or ro_concepto_asociado = 'INT_ESPERA')
    and   ro_operacion  = @w_operacionca_real
    and   am_dividendo  = 1
    and   am_cuota     >= 0.01

    if @@error <> 0 begin
       select @w_error = 710001
    end

   if @i_externo = 'S'
      select @i_banco_real -- SALIDA PARA FRONTEND


   if (isnull(@w_tramite,0) = 0 and @i_afecta_credito = 'S') begin
      --GENERAR UN TRAMITE EN CASO DE CREACION DIRECTA DESDE CARTERA

      select @w_monto_total_mn  = round(isnull((@w_monto_op * @w_cotizacion_des),0),@w_num_dec_mn)
      select @w_monto_des  = round(isnull((@w_monto_des * @w_cotizacion_des),0),@w_num_dec_mn)

      exec @w_return = cob_credito..sp_tramite_cca
           @s_ssn            = @s_ssn,
           @s_user           = @s_user,
           @s_sesn           = @s_sesn,
           @s_term           = @s_term,
           @s_date           = @s_date,
           @s_srv            = @s_srv,
           @s_lsrv           = @s_lsrv,
           @s_ofi            = @s_ofi,
           @i_oficina_tr     = @w_oficina,
           @i_fecha_crea     = @i_fecha_liq,
           @i_oficial        = @w_oficial,
           @i_sector         = @w_sector,
           @i_banco          = @i_banco_real,
           @i_linea_credito  = @w_lin_credito,
           @i_toperacion     = @w_toperacion,
           @i_producto       = 'CCA',
           @i_monto          = @w_monto_op,
           @i_monto_mn       = @w_monto_total_mn,
           @i_monto_des      = @w_monto_des,
           @i_moneda         = @w_moneda,
           @i_periodo        = @w_tplazo,
           @i_num_periodos   = @w_plazo,
           @i_destino        = @w_destino,
           @i_ciudad_destino = @w_ciudad,
           @i_renovacion     = @w_num_renovacion,
           @i_clase          = @w_clase,
           @i_cliente        = @w_cliente,
           @o_tramite        = @w_tramite out

           if @@error <> 0 or @@trancount = 0 begin
              if @i_crea_ext is null
                 PRINT 'liquiad.sp error ejecutand cob_credito..sp_tramite_cca '
              else
                 select @o_msg = 'liquiad.sp error ejecutand cob_credito..sp_tramite_cca Err:' + CONVERT(varchar(10),@w_return)
              select @w_error = 710522
              goto ERROR
           end

           if @w_return <> 0 begin
              select @w_error = @w_return
              goto ERROR
           end

      if exists (select 1 from ca_deudores_tmp
                 where dt_operacion = @w_operacion_real)
      update cob_credito..cr_deudores with (rowlock)
      set de_segvida = 'S'
      from ca_deudores_tmp
      where dt_deudor    = de_cliente
      and   dt_operacion = @w_operacion_real

      update ca_operacion  with (rowlock)
      set    op_tramite = @w_tramite  --AUMENTADO
      where  op_banco   = @i_banco_real

      if @@error <> 0 begin
         if @i_crea_ext is null begin
            print 'Error en Actualizacion en ca_operacion por @i_banco_real'
         end
         else
            select @o_msg = '16 - Banco Real: ' + cast(@i_banco_real as varchar) + ' Tramite: ' + cast(@w_tramite as varchar) + ' - ' + 'Error en Actualizacion en ca_operacion por @i_banco_real'
         select @w_error = 7100216
         goto ERROR
      end

      -- ACTUALIZA HISTORICO Y EN CASO REVERSA NO SE PIERDA EL NUMERO DE TRAMITE ASIGNADO
      update ca_operacion_his with (rowlock)
      set    oph_tramite = @w_tramite  --AUMENTADO
      where  oph_operacion = @w_operacion_real

      if @@error <> 0 begin
         if @i_crea_ext is null begin
            print 'Error en Actualizacion en ca_operacion_his por @w_operacion_real'
         end
         else
            select @o_msg = '17 -  Op Real: ' + cast(@w_operacion_real as varchar) + ' Tramite: ' + cast(@w_tramite as varchar) + ' - ' + 'Error en Actualizacion en ca_operacion_his por @w_operacion_real'
         select @w_error = 7100217
         goto ERROR
      end
   end

   -- INDICAR A CREDITO QUE LA OPERACION HA SIDO LIQUIDADA
   if @i_afecta_credito = 'S' begin

      exec @w_return = cob_credito..sp_int_credito1
           @s_ofi              = @s_ofi,
           @s_ssn              = @s_ssn,
           @s_sesn             = @s_sesn,
           @s_user             = @s_user,
           @s_term             = @s_term,
           @s_date             = @s_date,
           @s_srv              = @s_srv,
           @s_lsrv             = @s_lsrv,
           @t_trn     = 21889,
           @i_tramite          = @w_tramite,
           @i_numero_op        = @w_operacionca_real,
           @i_numero_op_banco  = @i_banco_real,
           @i_fecha_concesion  = @s_date,
           @i_fecha_fin        = @w_fecha_fin,
           @i_monto            = @w_monto,
           @i_tabla_temporal   = 'N'

      if @@error <> 0 or @@trancount = 0 begin
         if @i_crea_ext is not null
            select @o_msg = 'Error desde cob_credito..sp_int_credito1 Err:' + CONVERT(varchar(10),@w_return)
         select @w_error = 710522
         goto ERROR
      end

      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end
   end
end
else begin  -- estado <> 0

   select @w_error =703063
   goto ERROR
   -- DESEMBOLSO PARCIAL
end

-- *********************************
-- PRODUCTO COBIS
select @w_producto = dt_prd_cobis
from   cob_cartera..ca_default_toperacion
where  dt_toperacion = @w_toperacion
and    dt_moneda     = @w_moneda

-- AFECTACION A LA LINEA EN CREDITO
if @w_lin_credito is not null begin
   if @w_naturaleza = 'P'
      select @w_opcion = 'P'  -- PASIVA
   else
      select @w_opcion = 'A'  -- ACTIVA

    ---esta validacion aplica solo si la moneda es diferenet de Pesos
   if @w_moneda = 2 begin

      select @w_monto_op = isnull(tr_montop,0)   ---monto en pesos sin descontar valores anticipados
      from   cob_credito..cr_tramite
      where  tr_tramite = @w_tramite

      if @w_monto_op = 0 begin
         select @w_error = 710498
         goto ERROR
      end
   end

   exec @w_return = cob_credito..sp_utilizacion
        @s_ofi         = @s_ofi,
        @s_ssn         = @s_ssn,
        @s_sesn        = @s_sesn,
        @s_user        = @s_user,
        @s_term        = @s_term,
        @s_date        = @s_date,
        @s_srv         = @s_srv,
        @s_lsrv        = @s_lsrv,
        @s_rol         = @s_rol,
        @s_org         = @s_org,
        @t_trn         = 21888,
        @i_linea_banco = @w_lin_credito,
        @i_producto    = 'CCA',
        @i_toperacion  = @w_toperacion,
        @i_tipo        = 'D',
        @i_moneda      = @w_moneda,
        @i_monto       = @w_monto_op,
        @i_cliente     = @w_cliente ,
        @i_secuencial  = @w_secuencial,
        @i_tramite     = @w_tramite,
        @i_opcion      = @w_opcion,
        @i_opecca      = @w_operacionca_ficticio,
        @i_fecha_valor = @i_fecha_liq,
        @i_modo        = 0,
        @i_monto_cex   = @w_monto_cex,
        @i_numoper_cex = @w_num_oper_cex

   select @w_error_sis = @@error

   if @w_error_sis  <> 0 or @@trancount = 0 begin
      if @i_crea_ext is not null begin
         select @o_msg = 'Error desde cob_credito..sp_utilizacion Err:' + CONVERT(varchar(10),@w_return) + @w_opcion + ' trancount=' + convert(varchar(20), @@trancount ) + ' w_error_sis =' + convert(varchar(20), @w_error_sis  )
       end
      select @w_error = 710522

      goto ERROR
   end

   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end

   if @w_banco is null begin
      select @w_banco = op_banco
      from   ca_operacion
      where  op_operacion = @w_operacionca_real
   end
end
else begin
   if @w_naturaleza = 'P' and @i_cca_sobregiro = 'N' begin
      select @w_opcion = 'A'  --   SOLO OPERACIONES REDESCUENTO PARTE ACTIVA

       ---esta validacion aplica solo si la moneda es UVR
      if @w_moneda = 2 begin
         select @w_monto_op = isnull(tr_montop,0)   ---monto en pesos sin descontar valores anticipados
         from   cob_credito..cr_tramite
         where  tr_tramite = @w_tramite

         if @w_monto_op = 0 begin
            select @w_error = 710498
            goto ERROR
         end
      end

      exec @w_return = cob_credito..sp_utilizacion
           @s_ofi         = @s_ofi,
           @s_ssn         = @s_ssn,
           @s_sesn        = @s_sesn,
           @s_user        = @s_user,
           @s_term        = @s_term,
           @s_date        = @s_date,
           @s_srv         = @s_srv,
           @s_lsrv        = @s_lsrv,
           @s_rol         = @s_rol,
           @s_org         = @s_org,
           @t_trn         = 21888,
           @i_linea_banco = @w_lin_credito,
           @i_producto    = 'CCA',
           @i_toperacion  = @w_toperacion,
           @i_tipo        = 'D',
           @i_moneda      = @w_moneda,
           @i_monto       = @w_monto_op,
           @i_cliente     = @w_cliente,
           @i_secuencial  = @w_secuencial,
           @i_tramite     = @w_tramite,
           @i_opcion      = @w_opcion,
           @i_opecca      = @w_operacionca_ficticio,
           @i_fecha_valor = @i_fecha_liq,
           @i_modo        = 1

      if @@error <> 0 or @@trancount = 0 begin
         if @i_crea_ext is not null
            select @o_msg = 'Error desde cob_credito..sp_utilizacion Err:' + CONVERT(varchar(10),@w_return)
         select @w_error = 710522
         goto ERROR
      end


      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end
   end --Tipo <> R
end--Else


--  MARCAR COMO APLICADOS LOS DESEMBOLSOS UTILIZADOS
if @w_prod_cobis_ach in (248, 249) begin
   update ca_desembolso  with (rowlock)
   set    dm_estado = 'I'
   where  dm_secuencial = @w_secuencial
   and    dm_operacion  = @w_operacionca_real
end -- PARA MBS
else begin
   update ca_desembolso with (rowlock)
   set    dm_estado          = 'A',
          dm_prenotificacion = @i_prenotificacion,
          dm_carga           = @i_carga
   where  dm_secuencial = @w_secuencial
   and    dm_operacion  = @w_operacionca_real
end -- ACTUALIZACION NORMAL

if @@error <> 0 begin
   if @i_crea_ext is null begin
      print 'Error en Actualizacion en ca_desembolso por @w_prod_cobis_ach'
   end
   else
      select @o_msg = '18 -  Op Real: ' + cast(@w_operacion_real as varchar) + ' Secuencial: ' + cast(@w_secuencial as varchar) + ' Prenot: ' + cast(@i_prenotificacion as varchar) + '  Carga: ' + cast(@i_carga as varchar) + ' - ' + 'Error en Actualizacion en ca_desembolso por @w_prod_cobis_ach'
   select @w_error = 7100218
   goto ERROR
end

/*SE ACTUALIZA AL CLIENTE COMO CLIENTE*/
update cobis..cl_ente with (rowlock)
set en_cliente  = 'S'
where en_ente  = @w_cliente
if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR
end

/*REQ 0272 VALIDACION BANCARIZACION DE CLIENTE*/

if exists(select 1 from cobis..cl_ente
        where en_ente        = @w_cliente
        and   en_bancarizado <> 'I'
         )
begin
   update cobis..cl_ente
   set en_bancarizado = 'I'
   where en_ente  = @w_cliente

   if @@error <> 0 begin
      select @w_error = 710001
      goto ERROR
   end
end


--ACTUALIZACION DEL SALDO DEL FONDO POR DESEMBOLSO APLICADO
if isnull(@w_error,0) = 0 begin

   exec @w_return = cob_cartera..sp_fuen_recur
   @s_user        = @s_user,
   @s_term        = @s_term,
   @s_ofi         = @s_ofi,
   @s_ssn         = @s_ssn,
   @s_date        = @s_date,
   @i_operacion   = 'F',
   @i_monto       = @w_op_monto,
   @i_opcion      = 'D',
   @i_reverso     = 'N',
   @i_operacionca = @w_operacionca_real,
   @i_secuencial  = @w_secuencial,
   @i_dividendo   = 1,
   @i_fecha_proc  = @i_fecha_liq

   if @w_return <> 0 begin
       select @w_error = @w_return
       goto ERROR
   end
end


/* ACTUALIZACION DE SALDOS INTERFAZ PALM */
execute @w_error = sp_datos_palm
@i_operacionca      = @w_operacionca_real,
@i_operacion        = 'D',
@i_monto_cap        = @w_monto_des,
@i_reversa          = 'N'

if @w_error <> 0
   return @w_error


if @w_op_tipo =  'D' begin --con responsabilidad

    declare facturas
    cursor for
    select fa_grupo,fa_num_negocio,fa_referencia,fa_proveedor
    from cob_credito..cr_facturas
    where fa_tramite = @w_tramite
    order by fa_fecfin_neg

    open facturas
    fetch facturas into
    @w_grupo,@w_num_negocio,@w_num_doc,@w_proveedor

    while @@fetch_status = 0 begin
        exec @w_return  = cob_custodia..sp_cambio_estado_doc
        @i_operacion    = 'I',
        @i_modo         = 1,
        @i_opcion       = 'L',
        @i_tramite      = @w_tramite,
        @i_grupo        = @w_grupo,
        @i_num_negocio  = @w_num_negocio,
        @i_num_doc      = @w_num_doc,
        @i_proveedor    = @w_proveedor,
        @i_banderafe    = @i_banderafe

        if @w_return <> 0 begin
            close facturas
            deallocate facturas
            select @w_error = @w_return
            goto ERROR
        end

        fetch facturas into
        @w_grupo,@w_num_negocio,@w_num_doc,@w_proveedor
    end

close facturas
deallocate facturas

   ---Actualiza el valor pagado tambiente en la tablad e facturas
   update ca_facturas with (rowlock)
   set   fac_pagado = fac_intant
   where fac_operacion = @w_operacionca_real

   --- Generar detalle del colchon si este existe


   ---CODIGO DEL CONCEPTO
     select @w_parametro_col = pa_char
     from cobis..cl_parametro with (nolock)
     where pa_producto = 'CCA'
     and   pa_nemonico = 'COL'
     select @w_rowcount = @@rowcount

     if @w_rowcount = 0 begin
        select @w_error = 710314
        goto ERROR
     end

     select @w_codvalor_col = co_codigo * 1000  + 10  + 0,
            @w_concepto_col = co_concepto
     from   ca_concepto
     where  co_concepto  = @w_parametro_col

     if @@rowcount = 0 begin
        select @w_error = 710314
        goto ERROR
     end

     select @w_valor_colchon = isnull(ro_valor,0)
     from ca_rubro_op
     where ro_operacion  = @w_operacionca_real
     and   ro_concepto = @w_concepto_col

     if @w_valor_colchon > 0 begin

         insert into ca_det_trn (
         dtr_secuencial,       dtr_operacion,        dtr_dividendo,
         dtr_concepto,         dtr_estado,           dtr_periodo,
         dtr_codvalor,         dtr_monto,            dtr_monto_mn,
         dtr_moneda,           dtr_cotizacion,       dtr_tcotizacion,
         dtr_afectacion,       dtr_cuenta,           dtr_beneficiario,
         dtr_monto_cont)
         values (
         @w_secuencial,        @w_operacionca_real,  0,
         @w_concepto_col,       1,      0,
         @w_codvalor_col,      @w_valor_colchon,        round(@w_valor_colchon * convert(float, @w_dm_cotizacion_mop), @w_num_dec_mn),
         @w_moneda,            @w_dm_cotizacion_mop, 'C',
         'C',                  '',                   'RESPALDO DE NEGOCIO FACTORING',
         0)

         if @@error <> 0 begin
            select @w_error = 710001
            goto ERROR
         end
      end
end


if (@w_op_tipo <> 'D'  and  @w_op_tipo <> 'F') and isnull(@w_tramite, 0) > 0  --and @i_cca_sobregiro = 'N' 609
begin
   exec @w_return = cob_custodia..sp_activar_garantia
        @i_opcion    = 'L',
        @i_tramite   = @w_tramite,
        @i_modo      = 1,
        @i_operacion = 'I',
        @s_date      = @s_date,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_ofi       = @s_ofi

   if @@error <> 0 or @@trancount = 0 begin
     if @i_crea_ext is not null
        select @o_msg = 'Error desde cob_custodia..sp_activar_garantia Err:' + CONVERT(varchar(10),@w_return)
      select @w_error = 710522
      goto ERROR
   end

   if @w_return <> 0 begin
      if @i_externo = 'S'
         while @@trancount > 1 rollback
      select @w_error = @w_return
      goto ERROR
   end
   else begin
      if @i_externo = 'S'
         while @@trancount > 1 commit tran
   end
end

if @w_naturaleza <> 'P' and (@w_op_tipo <> 'D'  and  @w_op_tipo <> 'F') begin

  exec @w_return = sp_valor_atx_mas
       @s_user  = @s_user,
       @s_date  = @s_date,
       @i_banco = @i_banco_real

  if @w_return <> 0 begin
     select @w_error = @w_return
     goto ERROR
  end
end

if @w_op_tipo = 'C' begin
   select @w_op_pasiva = rp_pasiva
   FROM   ca_relacion_ptmo, ca_operacion
   WHERE  rp_activa = @w_operacionca_ficticio
   AND    rp_pasiva = op_operacion
   AND    op_estado <> 6

   select @w_banco_pasivo = tr_banco
   from   ca_transaccion
   where  tr_operacion =  @w_op_pasiva
   and    tr_tran = 'DES'

   if @w_banco_pasivo is not null begin
      update ca_operacion with (rowlock)
      set    op_banco = @w_banco_pasivo
      where  op_operacion = @w_op_pasiva
   end
end

if (@w_op_numero_reest >= 2) begin
   -- REALIZAR CAMBIO DE ESTADO DE LA OPERACION A SUSPENSO
   exec @w_return    = sp_cambio_estado_op
        @s_user          = @s_user,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @i_banco         = @i_banco_real,
        @i_fecha_proceso = @i_fecha_liq,
        @i_estado_ini    = @w_estado_op,
        @i_estado_fin    = @w_est_suspenso,
        @i_tipo_cambio   = 'M',
        @i_en_linea      = 'S'
   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end
end

-- **************** Inicio LAM ***************

select @w_parametro_timbac = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'TIMBAC'
select @w_rowcount = @@rowcount

if @w_rowcount =  0
begin
   select @w_error = 710363
   goto ERROR
end

if exists(select 1
         from   ca_rubro_op
         where  ro_operacion = @w_operacionca_ficticio
         and    ro_concepto  = @w_parametro_timbac
         and    ro_fpago     = 'B'
         and    ro_valor     > 0)
begin
   -- OBTENCION DE CODIGO VALOR DEL RUBRO
   select @w_codvalor = co_codigo * 1000  + 10  + 0,
          @w_rubro_timbac = co_concepto
   from   ca_concepto
   where  co_concepto  = @w_parametro_timbac

   if @@rowcount =  0 begin
      select @w_error = 710364
      goto ERROR
   end

   select @w_valor_timbac = ro_valor
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca_ficticio
   and    ro_concepto  = @w_rubro_timbac
   and    ro_fpago     = 'B'

   exec @w_return = sp_conversion_moneda
        @s_date         = @s_date,
        @i_opcion       = 'L',
        @i_moneda_monto = @w_moneda,
        @i_moneda_resul = @w_moneda_local,
        @i_monto        = @w_valor_timbac,
        @i_fecha        = @i_fecha_liq,
        @o_monto_result = @w_monto_mn out,
        @o_tipo_cambio  = @w_cot_mn out

   insert ca_det_trn
         (dtr_secuencial,  dtr_operacion,           dtr_dividendo,
          dtr_concepto,    dtr_estado,              dtr_periodo,
          dtr_codvalor,    dtr_monto,               dtr_monto_mn,
          dtr_moneda,      dtr_cotizacion,          dtr_tcotizacion,
          dtr_afectacion,  dtr_cuenta,              dtr_beneficiario,
          dtr_monto_cont)
   values(@w_secuencial,   @w_operacionca_ficticio, 1,
          @w_rubro_timbac, 1,                       0,
          @w_codvalor,     @w_valor_timbac,         @w_valor_timbac,
          @w_moneda,       @w_cot_mn,               'C',
          'C',             '000000',                'RUBROS QUE ASUME EL BANCO',0)

   if @@error <> 0 begin
      select @w_error = 710001
      goto ERROR
   end
end

-- **************** Fin LAM ******************

select @w_total_adicionales  = isnull(sum ( ca_cuota),0)
from  ca_cuota_adicional
where ca_operacion = @w_operacionca_ficticio
if @w_total_adicionales = 0 begin
      delete ca_cuota_adicional
      where ca_operacion = @w_operacionca_ficticio
end

-- MODIFICACION SOLO DE LA PARTE DE INTERES
if ltrim(rtrim(@w_tipo_amortizacion))  = 'MANUAL'   and (@w_op_tipo <> 'D'  and  @w_op_tipo <> 'F') begin
   exec @w_return = sp_reajuste_interes
        @s_user           = @s_user,
        @s_term           = @s_term,
        @s_date           = @s_date,
        @s_ofi            = @s_ofi,
        @i_operacionca    = @w_operacionca_ficticio,
        @i_fecha_proceso  = @i_fecha_liq,
        @i_banco          = @i_banco_real,
        @i_en_linea       = 'S'

   if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end
end --Reajsute interes tabla manual

--VALIDAR QUE LA TASA ESTE CORRECTA CON LA FECHA DE LIQUIDACION
select @w_fecha_liq_val = op_fecha_liq
from ca_operacion
where op_operacion = @w_operacion_real

select @w_tasa_ref              = ts_tasa_ref,
       @w_ts_fecha_referencial  = ts_fecha_referencial,
       @w_ts_valor_referencial  = ts_valor_referencial
from ca_tasas
where ts_operacion = @w_operacion_real
and   ts_concepto = 'INT'

if @@rowcount > 0 begin

   if exists (select 1 from cobis..te_pizarra
              where pi_referencia = @w_tasa_ref)
   begin

      select @w_valor_tf = pi_valor
      from   cobis..te_pizarra with (nolock)
      where  @w_fecha_liq_val between pi_fecha_inicio and pi_fecha_fin
      and    pi_referencia = @w_tasa_ref

      if @w_valor_tf <> @w_ts_valor_referencial begin
         select @w_error = 710571
         goto ERROR
      end
    end
end

---Inc 16589
 if @i_renovacion = 'S'
 begin
     exec @w_return = sp_renovacion
        @s_ssn            = @s_ssn,
        @s_sesn           = @s_sesn,
        @s_user           = @s_user,
        @s_term           = @s_term,
        @s_date           = @s_date,
        @s_ofi            = @s_ofi,
        @i_banco          = @i_banco_real

     if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end

     ---VALIDAR SI  SE PRSENTO UN PAGO  Y ESTE ESTA EN EL DETALLE DE LA TRANSACCION
     ---DE ESEMBOLSO CON FORMA RENOVACION

     ---CODIGO DEL RUBRO TIMBRE
      select @w_fdesembolso = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'CCA'
      and    pa_nemonico = 'FDESRE'

      select @w_rowcount = @@rowcount

      set transaction isolation level read uncommitted

      if @w_rowcount = 0
      begin
         select @w_error = 711072
         goto ERROR
      end

      select @w_operacionca_ant = op_operacion
      from ca_operacion
      where op_banco = @w_op_anterior

      select @w_sec_ing_hoy = max(ab_secuencial_ing)
      from ca_abono
      where ab_operacion =  @w_operacionca_ant
      and ab_estado = 'A'

      if exists (select 1 from ca_abono_det
                 where abd_operacion = @w_operacionca_ant
                 and abd_secuencial_ing = @w_sec_ing_hoy
                 and abd_concepto = @w_fdesembolso)
       begin
           select @w_existe = isnull(count(1),0)
           from ca_det_trn
           where dtr_operacion = @w_operacionca_ficticio
           and dtr_secuencial  = @w_secuencial
           and dtr_concepto    = @w_fdesembolso

           if @w_existe = 0 or @w_existe is null
            begin
               if @i_crea_ext is null
                  PRINT 'liquida.sp Error por que se pago un valor con RENOVACION y nose registro el detalle'
               else
                  select @o_msg = 'liquida.sp Error por que se pago un valor con RENOVACION y nose registro el detalle'
               select @w_error = 710031
               goto ERROR
            end
       end

    select @w_tramite_new = op_tramite
    from ca_operacion
    where op_operacion = @w_operacionca_ficticio

   select @w_oper_ant = or_num_operacion
   from cob_credito..cr_op_renovar
   where or_tramite = @w_tramite_new


   if not exists(select 1
         from   ca_operacion
         where  op_banco =  @w_oper_ant
         and    op_estado = 3)
   begin

      if @@rowcount =  0 begin
         if @i_crea_ext is null
            PRINT 'liquida.sp LA OPERACION ANTERIOR NO SE CANCELO...LA RENOVACION NO SE EFECTUARA'
         else
            select @o_msg = 'liquida.sp LA OPERACION ANTERIOR NO SE CANCELO...LA RENOVACION NO SE EFECTUARA'
         select @w_error = 701173
         goto ERROR
      end
   end


 end

--Validar que la operacion  nueva quede en estado VIGENTE
--Una Oblicagion no puede tener transaccion de desembolo y estan NO VIGENTE
if  exists (select 1
               from   ca_transaccion
               where  tr_operacion = @w_operacion_real
               and    tr_tran = 'DES'
               and    tr_estado    = 'ING'
               and    tr_secuencial > 0
               and    tr_fecha_mov = @s_date)
begin
           if exists (select 1
                      from ca_operacion
                       where  op_operacion = @w_operacion_real
                       and    op_estado = 0)
                       begin
                           select @w_error = 703063
                           goto ERROR
                        end
end
---INC. 117728

select 1 from   ca_operacion
where  op_operacion = @w_operacion_real
and    op_estado = 1

if @@rowcount =  0
begin
   PRINT 'liquida.sp LA OPERACION  NO SE DESEMBOLSO CORRECTAMENTE REVISAR INF. DE LA OPERACION'
   select @w_error = 705036
   goto ERROR
end

select 1 from   ca_dividendo
where  di_operacion = @w_operacion_real
and    di_estado = 1

if @@rowcount =  0
begin
   PRINT 'liquida.sp LA OPERACION  NO SE DESEMBOLSO CORRECTAMENTE TODOS LOS  DIVIDENDOS NO VIGENTES'
   select @w_error = 705036
   goto ERROR
end
--FIN VALIDAR QUE LA TASA ESTE CORRECTA CON LA FECHA DE LIQUIDACION

if exists (select 1 from ca_pago_planificador
           where  pp_operacion = @w_operacion_real
           and    pp_estado =  'I')
begin
   update ca_pago_planificador with (rowlock)
   set pp_secuencial_des = @w_secuencial
   where    pp_operacion = @w_operacion_real
   and     pp_estado =  'I'
end

select @w_mipymes = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto  = 'CCA'
and   pa_nemonico  = 'MIPYME'
if exists (select 1
           from   ca_rubro_op
           where  ro_operacion = @w_operacion_real
           and    ro_concepto  = @w_mipymes)
begin
  select @w_valor_mipyme = 0
  select @w_valor_mipyme = isnull(sum(am_cuota),0)
  from ca_amortizacion
  where am_operacion = @w_operacion_real
  and   am_concepto  = @w_mipymes

  select @w_op_clase = op_clase
  from ca_operacion
  where op_operacion = @w_operacion_real

  if (@w_valor_mipyme = 0) and (@w_op_clase <> '1') and (@w_op_tipo not in ('G','R'))
  begin
     exec @w_return = sp_calculo_mipymes
     @i_operacion   = @w_operacion_real

      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end
  end
end

---25931

---LLS 93986 Independiente de la fecha de desembolso, la fecha de liquidacion debe ser siempre la del sistema
---No aplica para Redescuento solo para el resto de la cartera que necesita la fecha liq para los  anexos
if (@w_op_tipo <> 'R'  and  @w_op_tipo <> 'C')
begin
   update ca_operacion with (rowlock)
   set    op_fecha_liq  = @s_date
   where  op_operacion = @w_operacionca_real
   if @@error <> 0
    begin
       select @w_error = 7100212
       goto ERROR
    end

end

---  FIN PARA CUOTAS ADICIONALES
if @i_externo = 'S'
   commit tran


--GENERACION ARCHIVO FINAGRO
if exists(select 1 from cob_credito..cr_corresp_sib s, cobis..cl_tabla t, cobis..cl_catalogo c
          where s.descripcion_sib = t.tabla
          and t.codigo            = c.tabla
          and s.tabla             = 'T301'
          and c.codigo            = @w_toperacion
          and c.estado            = 'V')
begin
   exec @w_return = cob_cartera..sp_finagro
   @i_fecha       = @i_fecha_liq,
   @i_banco       = @w_banco,
   @i_operacion   = 'D'

   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end
end

  exec @w_return = sp_borrar_tmp
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_sesn      = @s_sesn,
        @i_desde_cre = 'N',
        @i_banco     = @w_banco

   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end
   
return 0

ERROR:
if @i_externo = 'S' begin
   rollback tran
   exec cobis..sp_cerror
        @t_debug = 'N',
        @t_file  = '',
        @t_from  = @w_sp_name,
        @i_num   = @w_error

   return @w_error
end
else
   return @w_error
go

