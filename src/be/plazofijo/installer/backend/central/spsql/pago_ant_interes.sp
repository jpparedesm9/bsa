/*sp_pago_ant_interes*/
/************************************************************************/
/*      Archivo:                pagoantinteres.sp                       */
/*      Stored procedure:       sp_pago_ant_interes                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 03/Mar/05                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/************************************************************************/
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/************************************************************************/
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      necesarias para realizar el pago de intereses a una opera-      */
/*      cion antes de que se venza el periodo de interes.               */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA           AUTOR              RAZON                        */
/************************************************************************/
/*    03/Mar/05   Gabriela Estupinan   Emision Inicial                  */
/*    18/Nov/05   Luis Im              Se remplaza nombre banco         */
/*                                     ach por cod. banco ach           */
/*    22-Feb-07   Rolando Linares      Tomar la Codigo del beneficiario */
/*                                     Para enviar a SBA si es clie. MIS*/
/*    12/Jul/2009 Y. Martinez          NYM DPF00015 ICA                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_pago_ant_interes')
   drop proc sp_pago_ant_interes
go

create proc sp_pago_ant_interes (
   @s_ssn                  int          = null,
   @s_user                 login        = null,
   @s_sesn                 int          = null,
   @s_term                 varchar(30)  = null,
   @s_date                 datetime     = null,
   @s_srv                  varchar(30)  = null,
   @s_lsrv                 varchar(30)  = null,
   @s_ofi                  smallint     = null,
   @s_rol                  smallint     = null,
   @t_debug                char(1)      = 'N',
   @t_file                 varchar(10)  = null,
   @t_from                 varchar(32)  = null,
   @t_trn                  smallint,
   @i_num_banco            cuenta,
   @i_fecha                datetime,
   @i_valor                money        =  0,
   @i_retienimp            char(1)      = 'N',
   @i_impuesto             money        = 0,
   @i_comentario           descripcion  = null,
   @i_autoriza_pago_otros  login        = null,
   @i_tipo                 char(1),
   @i_modifica             char(1)      = 'N',
   @i_ica                  char(1)      = 'N',   -- INI NYM DPF00015 ICA
   @i_idlote               int          = 0
)
with encryption
as
declare
   @w_sp_name                  varchar(32),
   @w_moneda                   smallint,
   @w_numdeci                  tinyint,
   @w_usadeci                  char(1),
   @w_return                   int,
   @w_tasa                     float,
   @w_valor                    money,
   @o_comprobante              int,
   @w_total_int_ganado         money,
   @w_total_int_estimado       money,
   @w_ajuste                   money,
   @w_ultima_secuencia         int,
   @w_secuencia_temporal       int,
   @w_disminucion              money,

   ------------------------------------------
   -- Variables para pf_operacion
   ------------------------------------------
   @w_int_pagados              money,
   @w_total_int_pagados        money,
   @w_fecha_ult_pg_int         datetime,
   @w_historia                 smallint,
   @w_mon_sgte                 smallint,
   @w_fecha_mod                datetime,
   @w_operacionpf              int,
   @w_estado                   catalogo,
   @w_producto                 tinyint,
   @w_oficina                  smallint,
   @w_toperacion               catalogo,
   @w_tplazo                   catalogo,
   @w_descripcion              varchar(150),
   @w_retiene_capital          char(1),
   @w_int_estimado             money,
   @w_int_ganado               money,
   @w_fpago                    catalogo,
   @w_impuesto                 float,
   @v_fecha_ant_pago           datetime,
   @w_bloqueo_legal            char(1), --CVA Oct-20-05
   @w_pago_interes             char(1), --CVA Oct-30-06
   @w_fecha_pg_int             datetime,
   @w_valor_cuota              money,
   @w_int_pagados_ant          money,
   @w_capitalizacion           char(1),
   @w_monto_new                money,

   ------------------------------------------
   -- Variables iniciales para pf_operacion
   ------------------------------------------
   @v_fecha_valor              datetime,
   @v_int_pagados              money,
   @v_total_int_pagados        money,
   @v_fecha_ult_pg_int         datetime,
   @v_historia                 smallint,
   @v_mon_sgte                 smallint,
   @v_fecha_mod                datetime,
   @v_int_estimado             money,
   @v_int_ganado               money,

   ------------------------------------------
   -- Variables para mov_monet_tmp
   ------------------------------------------
   @w_mt_tipo                  catalogo,
   @w_mt_beneficiario          int,
   @w_mt_impuesto              money,
   @w_mt_producto              catalogo,
   @w_mt_cuenta                cuenta,
   @w_mt_valor                 money,
   @w_mt_moneda                smallint,
   @w_mt_valor_ext             money,
   @w_mt_fecha_crea            datetime,
   @w_mt_fecha_mod             datetime,
   @w_mt_sub_secuencia         tinyint,
   @w_mt_cotizacion            money,
   @w_mt_tipo_cotiza           char(1),
   @w_mt_tipo_cliente          char(1),
   @w_mt_fecha_valor           datetime,
   @w_cod_clte                 int,
   @w_mt_tipo_cuenta_ach       char(1),
   --@w_mt_banco_ach            descripcion,    --LIM 19/NOV/2005 Comentado se remplaza por cod. banco ach
   @w_mt_oficina               int,              --LIM 17/NOV/2005
   @w_mt_cod_banco_ach         smallint,         --LIM 19/NOV/2005
   @w_benef_chq                varchar(255),

   ------------------------------------------
   --  Variables para pf_cuotas
   ------------------------------------------
   @w_cu_ente                  int,
   @w_cu_cuota                 tinyint,
   @w_cu_fecha_pago            datetime,
   @w_cu_valor_cuota           money,
   @w_cu_valor_cuota_np        money,    --*-*
   @w_cu_retencion             money,
   @w_cu_capital               money,
   @w_cu_moneda                tinyint,
   @w_cu_oficina               int,
   @w_cu_num_dias              int,
   @w_cu_tasa                  float,
   @w_cu_ppago                 catalogo,
   @w_cu_base_calculo          smallint,
   @w_cu_valor_neto            money,
   @w_cu_fecha_ult_pago        datetime,
   -----------------------------------------------
   -- Variables para la forma de pago temporal
   -----------------------------------------------
   @w_pt_beneficiario          int,
   @w_sec1                     smallint,
   @w_pt_tipo                  catalogo,
   @w_pt_forma_pago            catalogo,
   @w_pt_cuenta                cuenta,
   @w_pt_monto                 money,
   @w_pt_porcentaje            float,
   @w_pt_fecha_crea            datetime,
   @w_pt_fecha_mod             datetime,
   @w_pt_moneda_pago           smallint,
   @w_pt_descripcion           descripcion,
   @w_pt_oficina               int,
   @w_pt_tipo_cliente          char(1),
   @w_pt_tipo_cuenta_ach       char(1),
   @w_pt_banco_ach             descripcion,
   @w_monto_capitalizar        money,
   @w_monto                    money,
   @w_monto_var                varchar(30),
   @w_tasa_var                 varchar(20),

   --------------------------------------
   -- Variables para Servicios Bancarios
   --------------------------------------
   @w_conceptosb               tinyint,
   @w_concepto                 varchar(100),
   @w_secuencial_cheque        int,
   @w_ofi_org                  int,
   @w_producto_fpago           tinyint,
   @w_area_contable            int,
   @w_numero                   int,
   @w_campo1                   varchar(20),
   @w_campo47                  descripcion,
   @w_campo48                  descripcion,
   @w_cheque_ger               catalogo,
   @w_campo40                  char(1),
   @w_idlote                   int,
   @w_descripbenef             varchar(250),
   @w_rowcount                 int,
   @w_cod_ben                  varchar(250),     /*  RLINARES 02222007 */
   @w_origen_ben               varchar(1),       /*  RLINARES 02222007 */
   @v_fecha_ven                datetime,
   @w_money                    money,
   @w_count                    int,
   @w_monto_pg_int             money,
   @w_base_calculo             smallint,
   @w_dia_pago                 tinyint,
   @w_ppago                    catalogo,
   @v_total_int_estimado       money,
   @v_dias_reales              char(1),
   @w_mensaje                  descripcion,
   @v_total_int_ganados        money,
   @w_cuotas_a_la_fecha        money,
   @w_valor_a_pagar            money,
   @w_valor_solicitado_pago    money,
   @w_ult_fecha_calculo        datetime,
   -- INI NYM DPF00015 ICA
   @w_porcen_int               money,
   @w_imp                      money,
   @w_ica                      money,
   @w_mt_ica                   money,
   @w_total_mt_valor           money,
   @w_total_imp                money,
   @w_total_ica                money,
   @w_contador                 int,
   -- INI NYM DPF00015 ICA
   @w_total_gmf                money,  --MVG 25/09/2009
   @w_commit                   char(1), --MVG 25/09/2009
        @w_campo2                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_campo3                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_campo4                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_campo5                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_campo6                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_campo7                       varchar(20),    -- INTERFAZ - CHQCOM
        @w_tipo_benef                   catalogo,       -- INTERFAZ - CHQCOM
        @w_desc_conc_emision            descripcion,    -- INTERFAZ - CHQCOM
        @w_mpago_chqcom                 varchar(30),    -- INTERFAZ - CHQCOM
        @w_mm_producto                  catalogo,       -- INTERFAZ - CHQCOM
        @w_mt_subtipo_ins               int,            -- INTERFAZ - CHQCOM
        @w_cod_conc_emision             varchar(30),    -- INTERFAZ - CHQCOM
        @w_instr_chqcom                 tinyint,        -- INTERFAZ - CHQCOM
        @w_instrumento                  tinyint,        -- INTERFAZ - CHQCOM
        @w_subtipo_ins                  int,            -- INTERFAZ - CHQCOM
        @w_subtipo_ins_chcom            int,            -- INTERFAZ - CHQCOM
	@w_beneficiario                 varchar(255),   -- INTERFAZ - CHQCOM
        @w_referencia                   cuenta,         -- INTERFAZ - CHQCOM
        @w_area_origen                  smallint,
        @w_instrumento_chger            tinyint,        
        @w_subtipo_ins_chger            int,             
        @w_op_ente                      int,
        @w_parametro			varchar(30),
        @w_fecha_inicial                varchar(10),
        @w_fecha_final                varchar(10)    


------------------------------------
-- Busqueda de parametros iniciales
------------------------------------
select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'


-- MEDIO DE PAGO CHEQUE COMERCIAL - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'

-- CODIGO DE CONCEPTO DE EMISION DE PAGO PENDIENTE - INTERFAZ - CHQCOM
select @w_cod_conc_emision = pa_char
from cobis..cl_parametro
where pa_nemonico = 'EMPAPE'
and   pa_producto = 'PFI'

-- INSTRUMENTO CHEQUES COMERCIALES - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'


-- SUBTIPO INSTRUMENTO CHEQUES COMERCIALES - INTERFAZ - CHQCOM
select @w_mt_subtipo_ins = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'SINCHC'
and   pa_producto = 'PFI'


-- INSTRUMENTO CHEQUES DE GERENCIA 
select @w_instrumento_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'ICHDG'
and   pa_producto = 'PFI'

-- SUBTIPO INSTRUMENTO CHEQUES DE GERENCIA 
select @w_subtipo_ins_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'SICHDG'
and   pa_producto = 'PFI'



select
@w_commit           = 'N', --MVG 25/09/2009
@w_sp_name          = 'sp_pago_ant_interes',
@w_mt_sub_secuencia = 0

if @t_trn <> 14155
begin
     exec cobis..sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 141018
     /*  'Error en codigo de transaccion' */
     return 1
end


select @v_fecha_ult_pg_int   = op_fecha_ult_pg_int,
       @v_fecha_valor        = op_fecha_valor,
       @v_historia           = op_historia,
       @v_mon_sgte           = op_mon_sgte,
       @v_fecha_mod          = op_fecha_mod,

       @v_int_estimado       = op_int_estimado,
       @v_int_pagados        = op_int_pagados,
       @v_int_ganado         = op_int_ganado,
       @v_total_int_pagados  = op_total_int_pagados,
       @v_fecha_ven          = op_fecha_ven,
       @w_monto_pg_int       = op_monto_pg_int,
       @w_base_calculo       = op_base_calculo,   --**
       @w_dia_pago           = op_dia_pago,     --**
       @w_ppago              = op_ppago,      --**
       @v_total_int_estimado = op_total_int_estimado, --*-*
       @v_dias_reales        = op_dias_reales,   --*-*
       @v_total_int_ganados  = op_total_int_ganados,  --*-*
       @w_ult_fecha_calculo  = op_ult_fecha_calculo,  --*-*

       @w_operacionpf        = op_operacion,
       @w_estado             = op_estado,
       @w_producto           = op_producto,
       @w_oficina            = op_oficina,
       @w_toperacion         = op_toperacion,
       @w_tplazo             = op_tipo_plazo,
       @w_moneda             = op_moneda,
       @w_retiene_capital    = op_retiene_imp_capital,
       @w_fpago              = op_fpago,
       @w_impuesto           = op_impuesto,
       @w_monto              = op_monto,
       @w_tasa               = op_tasa,
       @w_bloqueo_legal      = op_bloqueo_legal, --CVA Oct-20-05
       @w_pago_interes       = isnull(op_pago_interes,'S'),   --CVA Oct-30-06
       @w_fecha_pg_int       = op_fecha_pg_int,
       @w_int_pagados_ant    = op_int_pagados,
       @w_capitalizacion     = op_tcapitalizacion,
       @w_op_ente            = op_ente 
from pf_operacion
where op_num_banco = @i_num_banco
if @@rowcount = 0
begin
     exec cobis..sp_cerror
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 141051
     return 1
end

select @w_monto_var = convert(varchar(30),@w_monto)
select @w_tasa_var  = convert(varchar(20),@w_tasa)


if @v_fecha_ult_pg_int = @v_fecha_valor
     select @v_fecha_ant_pago = ''
else
     select @v_fecha_ant_pago = @v_fecha_ult_pg_int


--I. CVA Oct-20-05
if @w_bloqueo_legal = 'S'
   print 'Depósito bloqueado legalmente, favor verificar'
--F. CVA Oct-20-05

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
     and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0


if @w_estado not in ('ACT' ,'VEN') --I.CVA May-11-07 Agregar el estado Vencido
begin
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141031
     return 141031
end

select @w_ultima_secuencia   = isnull(max(isnull(dp_secuencia, 0)), 0)
from pf_det_pago
where dp_operacion = @w_operacionpf

select    @w_mt_sub_secuencia      = 0,
          @w_mon_sgte              = @v_mon_sgte,
          @w_historia              = @v_historia,
          @w_int_estimado          = @v_int_estimado,
          @w_int_ganado            = @v_int_ganado,
          @w_monto_capitalizar     = 0

--Proceso para DPF que no se pagaron sus intereses en batch por error
if @w_pago_interes =  'N'
begin
   --print 'A:%1! o B:%2! y C:%3! o D:%4!, E:%5! y F:%6!',@w_total_intereses, @w_total_int_pagados, @v_total_int_ganados, @w_cu_valor, @w_int_estimado, @w_int_ganado

   if @w_fpago = 'PER'
   begin
        select @w_cu_valor_cuota_np = cu_valor_cuota
        from cob_pfijo..pf_cuotas
        where cu_operacion       = @w_operacionpf
             and cu_fecha_pago   = @w_fecha_pg_int
             and cu_estado       = 'V'
        if @@rowcount = 0
        begin
             select @w_mensaje = 'paga_int.sp No hay cuota vigente para fecha de pago:' + convert(varchar(10),@w_fecha_pg_int,101)
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_mensaje,
            @i_num   = 141218
         return 141218
        end
   end

   -- VERIFICA QUE LAS INCONSISTENCIAS (DE EXISTIR) HAYAN SIDO AJUSTADAS, CASO CONTRARIO NO PERMITIR HACER NINGUN PAGO
   if      round(@v_int_ganado,@w_numdeci)        <  round(@v_int_pagados,@w_numdeci)
        or round(@v_total_int_pagados,@w_numdeci) >  round(@v_total_int_ganados,@w_numdeci)
        or ( round(@w_cu_valor_cuota_np,@w_numdeci)  <> round(@v_int_estimado,@w_numdeci) and @w_fpago = 'PER' )
   begin

--print 'int_ganado:%1!,int_pagados:%2!,total_int_pagados:%3!,totint_ganados:%4!,valor_cuota:%5!,intestim:%6!',@v_int_ganado,@v_int_pagados,@v_total_int_pagados,@v_total_int_ganados,@w_cu_valor_cuota_np,@v_int_estimado

      select @w_mensaje = 'Data inconsistente para operacion:' + @i_num_banco
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 149100
      return 149100
   end

   -- VALIDAR SI VALOR A PAGAR NO CORRESPONDE A CUOTA VIGENTE
   ----------------------------------------------------------
   select @w_valor_a_pagar          = @w_cu_valor_cuota_np - @v_int_pagados,     -- valor a pagar
        @w_valor_solicitado_pago = @i_valor + @i_impuesto                  -- valor solicitado

   if @w_valor_a_pagar <> @w_valor_solicitado_pago
   begin
      select @w_mensaje = 'Monto a Pagar no corresponde al pendiente de pago...' + convert(varchar,@w_valor_a_pagar)
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg   = @w_mensaje,
         @i_num   = 149100
      return 149100
   end
   -- Si el error no fue por data inconsistente => procesar el pago correspondiente deacuerdo a las condiciones originales
   -- Si debia capitalizar => capitalizar y recalcular intereses fecha valor y reajustar plan de pagos
   -- Si no capitaliza solo generar el pago correspondiente y actualizar fechas de proximos pagos
end

--print 'HACE RETURN 1'
--return 1

--  NYM DPF00015 ICA
select @w_total_mt_valor = 0
select @w_total_imp = 0
select @w_total_ica = 0
select @w_contador = 0

if @@trancount = 0 begin  --MVG 25/09/2009
   begin tran     --***********************************************************************************************
   select @w_commit = 'S' --MVG 25/09/2009
end

---------------------++++++++++++++++++++++++---------------------++++++++++++++++++++++++---------------------++++++++++++++++++++++++

-- GENERA PAGO DE ACUERDO A VALOR ENVIADO DESDE FRONTEND
----------------------------------------------------------
while 1=1
begin
     set rowcount 1
     select    @w_mt_producto   = mt_producto,
          @w_mt_sub_secuencia   = mt_sub_secuencia,
          @w_mt_tipo            = mt_tipo,
          @w_mt_beneficiario    = mt_beneficiario,
          @w_mt_impuesto        = mt_impuesto,
          @w_mt_cuenta          = mt_cuenta,
          @w_mt_valor           = mt_valor,
          @w_mt_valor_ext       = mt_valor_ext,
          @w_mt_moneda          = mt_moneda,
          @w_mt_fecha_crea      = mt_fecha_crea,
          @w_mt_fecha_mod       = mt_fecha_mod,
          @w_mt_tipo_cliente    = mt_tipo_cliente,
          @w_mt_cotizacion      = mt_cotizacion,
          @w_mt_tipo_cotiza     = mt_tipo_cotiza,
          @w_mt_fecha_valor     = mt_fecha_valor,
          @w_mt_tipo_cuenta_ach = mt_tipo_cuenta_ach,
          @w_mt_tipo_cliente    = mt_tipo_cliente,   --CVA Oct-19-05
          @w_mt_oficina         = mt_oficina,        --LIM 17/NOV/2005
          @w_mt_cod_banco_ach   = mt_cod_banco_ach,  --LIM 19/NOV/2005
          @w_benef_chq          = mt_benef_corresp,
          @w_mt_ica             = mt_ica             -- NYM DPF00015 ICA
     from pf_mov_monet_tmp
     where mt_usuario    = @s_user
          and mt_sesion     = @s_sesn
          and mt_operacion  = @w_operacionpf
          and mt_sub_secuencia >= @w_mt_sub_secuencia
     order by mt_sub_secuencia
     if @@rowcount = 1
     begin
          select @w_mt_valor     = round(@w_mt_valor, @w_numdeci)
          select @w_mt_impuesto  = round(@w_mt_impuesto, @w_numdeci)
          select @w_mt_ica       = round(@w_mt_ica, @w_numdeci) -- NYM DPF00015 ICA
          select @w_mt_valor_ext = round(@w_mt_valor_ext, @w_numdeci)

          if @w_mt_tipo_cliente = 'E'
          begin

               if EXISTS(select 1
                             from pf_cliente_externo_tmp
                            where ct_secuencial = @w_mt_beneficiario
                              and ct_usuario = @s_user
                              and ct_sesion  = @s_sesn)
               begin
                    exec @w_return = cobis..sp_cseqnos
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_tabla = 'pf_cliente_externo',
                         @o_siguiente = @w_cod_clte out
                    if @w_return <> 0
                         return 1

                    insert pf_cliente_externo
                         (ce_secuencial,      ce_nombre,    ce_cedula,    ce_direccion)
                    select @w_cod_clte,        ct_nombre,    ct_cedula,    ct_direccion
                         from pf_cliente_externo_tmp
                         where ct_secuencial = @w_mt_beneficiario
                         and ct_usuario = @s_user
                         and ct_sesion = @s_sesn


                    delete pf_cliente_externo_tmp
                    where ct_secuencial = @w_mt_beneficiario
                         and ct_usuario = @s_user
                         and ct_sesion  = @s_sesn

                    select @w_mt_beneficiario = @w_cod_clte
               end
               else
               begin
                    select @w_mt_beneficiario = dp_ente
                    from pf_det_pago
                    where dp_operacion    = @w_operacionpf
                         and dp_forma_pago   = @w_mt_producto
                         and dp_estado       = 'I'
                         and dp_tipo_cliente = 'E'
                         and dp_secuencia    > @w_ultima_secuencia
               end
          end

          -- INI NYM DPF00015 ICA

          select   @w_porcen_int  = @w_mt_valor / @i_valor
          select   @w_mt_valor    = @i_valor  * @w_porcen_int

          if @i_retienimp = 'S'
             select @w_imp = round(@w_mt_impuesto * @w_porcen_int , @w_numdeci)     -- NYM DPF00015 ICA
          if @i_ica = 'S'
             select @w_ica = round(@w_mt_ica * @w_porcen_int , @w_numdeci)       -- NYM DPF00015 ICA

          --print 'pagoantint @w_porcen_int %1! , @w_mt_valor %2! , @i_valor %3! ', @w_porcen_int, @w_mt_valor, @i_valor
          --print 'pagoantint @w_mt_valor %1! , @i_valor %2! , @w_porcen_int %3! ', @w_mt_valor, @i_valor, @w_porcen_int
          --print 'pagoantint @i_retienimp %1! , @w_imp %2! , @w_mt_impuesto %3! ,  @w_porcen_int %4! ' , @i_retienimp, @w_imp, @w_mt_impuesto, @w_porcen_int
          --print 'pagoantint @i_ica %1! , @w_ica %2! , @w_mt_ica %3! ,  @w_porcen_int %4! ' , @i_ica, @w_ica, @w_mt_ica, @w_porcen_int

          select @w_contador = isnull(count(1),0)
          from  pf_mov_monet_tmp
          where mt_usuario       = @s_user
          and   mt_sesion        = @s_sesn
          and   mt_operacion     = @w_operacionpf
          and   mt_sub_secuencia > @w_mt_sub_secuencia

          --print ' @w_contador %1! ', @w_contador

          if @w_contador = 0
          begin
             select @w_mt_valor = @i_valor - @w_total_mt_valor
             select @w_imp      = @w_mt_impuesto - @w_total_imp
             select @w_ica      = @w_mt_ica  -@w_total_ica
          end
          -- FIN NYM DPF00015 ICA

          --print 'pagoantint @w_mt_valor %1! , @w_imp %2! , @w_ica %3! ' , @w_mt_valor, @w_imp, @w_ica


          /* Traslada los datos a la tabla definitiva - Actualiza pf_mov_monet */
          insert into  pf_mov_monet (
               mm_operacion,        mm_tran,               mm_secuencia,           mm_secuencial,         mm_sub_secuencia,
               mm_producto,         mm_cuenta,             mm_valor,               mm_tipo,               mm_beneficiario,
               mm_impuesto,         mm_moneda,             mm_valor_ext,           mm_fecha_crea,         mm_fecha_mod,
               mm_user,             mm_tipo_cliente,       mm_cotizacion,          mm_tipo_cotiza,        mm_fecha_valor,
               mm_usuario,          mm_tipo_cuenta_ach,    mm_cod_banco_ach,       mm_oficina,            mm_benef_corresp,      --LIM 19/NOV/2005 Se remplaza banco ach por cod. banco ach
               mm_ica)  -- NYM DPF00015 ICA
          values(
               @w_operacionpf,      @t_trn,                @w_mon_sgte,            0,                     @w_mt_sub_secuencia,
               @w_mt_producto,      @w_mt_cuenta,          @w_mt_valor,            @w_mt_tipo,            @w_mt_beneficiario,
               @w_imp,              @w_mt_moneda,          @w_mt_valor_ext,        @s_date,               @s_date,
               @s_user,             @w_mt_tipo_cliente,    @w_mt_cotizacion,       @w_mt_tipo_cotiza,     @s_date,
               @s_user,             @w_mt_tipo_cuenta_ach, @w_mt_cod_banco_ach,    @w_mt_oficina,         @w_benef_chq,
               @w_ica)  -- NYM DPF00015 ICA
          /* Si no se puede insertar, error */
          if @@error <> 0
          begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_from  = @w_sp_name,
                    @t_file  = @t_file,
                    @i_num   = 143022
               return 1
          end

          select @w_origen_ben = @w_mt_tipo_cliente        /*  RLINARES 02222007 */

          /************************************************************************/
          /* Verificar si el beneficiario es del MIS O EXTERNO rlinares 02222007  */
          /************************************************************************/
          if @w_origen_ben <> 'M' /* Si es diferente de MIS NO ENVIO  DATOS A SBANCARIOS */
          begin
               select @w_cod_ben = null
               select @w_origen_ben = null
          end
          else
          begin
               select @w_cod_ben = convert(varchar(255),@w_mt_beneficiario)
          end

          insert into ts_mov_monet (
               secuencial,          tipo_transaccion,    clase,                  fecha,                  usuario,
               terminal,            srv,                 lsrv,                   operacion,              transaccion,
               secuencia,           sub_secuencia,       producto,               cuenta,                 valor,
               tipo,                beneficiario,        impuesto,               moneda,                 valor_ext,
               fecha_crea,          fecha_mod,           estado,                 fecha_valor,            ica)
          values  (
               @s_ssn,              @t_trn,              'N',                    @s_date,                @s_user,
               @s_term,             @s_srv,              @s_lsrv,                @w_operacionpf,         @t_trn,
               @w_mon_sgte,         @w_mt_sub_secuencia, @w_mt_producto,         @w_mt_cuenta,           @w_mt_valor,
               @w_mt_tipo,          @w_mt_beneficiario,  @w_imp,                 @w_mt_moneda,           @w_mt_valor_ext,
               @s_date,             @s_date,             null,                   @w_mt_fecha_valor,      @w_ica)
          if @@error <> 0
          begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = 143005
               return 1
          end

          select @w_total_mt_valor = @w_total_mt_valor + @w_mt_valor
          select @w_total_imp      = @w_total_imp + @w_imp
          select @w_total_ica      = @w_total_ica + @w_ica

          --print 'pagoantint @w_total_mt_valor %1! , @w_total_imp %2! , @w_total_ica %3! ' , @w_total_mt_valor, @w_total_imp, @w_total_ica

          /** Borra el registro de la tabla temporal **/
          delete from pf_mov_monet_tmp
          where mt_usuario = @s_user
               and   mt_sesion = @s_sesn
               and   mt_operacion = @w_operacionpf
               and   mt_sub_secuencia = @w_mt_sub_secuencia
          if @@error <> 0
          begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 147022
               return 1
          end

          exec @w_return = sp_aplica_mov
               @s_ssn             = @s_ssn,
               @s_user            = @s_user,
               @s_ofi             = @s_ofi,
               @s_date            = @s_date,
               @s_srv             = @s_srv,
               @s_term            = @s_term,
               @t_file            = @t_file,
               @t_from            = @w_sp_name,
               @t_debug           = @t_debug,
               @t_trn             = @t_trn,
               @i_operacionpf     = @w_operacionpf,
               @i_fecha_proceso   = @s_date,
               @i_secuencia       = @w_mon_sgte,
               @i_en_linea        = 'S',
               @i_tipo            = 'N',
               @i_emite_orden     = 'S', --CVA Dic-20-2005
               @i_sub_secuencia   = @w_mt_sub_secuencia,
               @i_retiene_capital = @w_retiene_capital,
               @i_benefi          = @w_benef_chq

          if @w_return <> 0
          begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = @w_return --141155
               return @w_return
          end

          -------------------------------------------------------------------------
          -- Interface para emision de cheque de gerencia con Servicios bancarios
          -- Se envia a SBA de acuerdo al producto de la forma de pago
          -------------------------------------------------------------------------
          select @w_producto_fpago = fp_producto,
          @w_area_contable  = fp_area_contable
          from   pf_fpago
          where  fp_mnemonico = @w_mt_producto
          if @@error <> 0
          begin
               exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 141111
               return 141111
          end

         if @w_producto_fpago = 42 
         begin
               ----------------------------------------------------
               -- Tomar la descripcion del beneficiario del cheque
               ----------------------------------------------------
               select @w_descripbenef     = ec_descripcion
               from   pf_emision_cheque
               where  ec_operacion        = @w_operacionpf
                    and  ec_tran             = @t_trn
                    and  ec_secuencia        = @w_mon_sgte
                    and  ec_sub_secuencia    = @w_mt_sub_secuencia

               if @w_area_contable is null
               begin
                    select @w_area_contable = td_area_contable
                    from   pf_tipo_deposito
                    where  td_mnemonico = @w_toperacion
                    if @@error <> 0
                    begin
                         exec cobis..sp_cerror
                              @t_debug        = @t_debug,
                              @t_file         = @t_file,
                              @t_from         = @w_sp_name,
                              @i_num          = 141115
                         return 141115
                    end
               end


            if @i_idlote = 0
            begin
               exec   @w_idlote    = cob_interfase..sp_isba_cseqnos 
                      @i_tabla     = 'sb_identificador_lotes',
                      @o_siguiente = @w_numero out

               select @i_idlote    = @w_numero --xca

            end
            else
            begin
               select @w_idlote = @i_idlote
            end

            ----------------------------------
            -- Informacion de parametrizacion
            ----------------------------------
/*
            if @w_mt_producto = @w_mpago_chqcom             
               select @w_parametro = 'CHQCOM'

            if @w_parametro IS NULL
            begin
               exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 141169

               return 141169
            end
*/
            select @w_campo47 = tn_descripcion
            from   cobis..cl_ttransaccion
            where  tn_trn_code = @t_trn 

            select @w_campo48 = 'DEPOSITO A PLAZO ' + convert(varchar,@i_num_banco)

            select @w_campo1 = 'PFI'

            if @w_mt_producto = @w_cheque_ger
               select @w_campo40 = 'E'

            ------------------------------------------------------------------
            -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
            ------------------------------------------------------------------

            select @w_conceptosb = convert(tinyint,codigo)
            from   cobis..cl_catalogo
            where  tabla in (select codigo
                             from   cobis..cl_tabla
                             where  tabla = 'sb_conceptos_implot')
            and    valor = 'DPF'


            select @w_descripbenef =  @w_benef_chq

            -- INTERFAZ - CHQCOM

            if @w_mt_producto in (@w_mpago_chqcom , @w_cheque_ger)
            begin
               -- OBTENER DATOS DEL TITULAR DEL CREDITO
               select @w_campo1 = en_tipo_ced + '-' + convert(varchar,en_ced_ruc),             -- TIPO Y NUMERO DEL TITULAR EJ. CC-79876543
                      @w_campo2 = en_nomlar                                   -- NOMBRE TITULAR
               from   cobis..cl_ente
               where  en_ente = @w_op_ente

               -- OBTENER DATOS DEL BENEFICIARIO
               if @w_mt_tipo_cliente = 'M' begin                              	-- ESTA EN COBIS..CL_ENTE
                  select @w_campo3     		= en_tipo_ced + '-' + convert(varchar,en_ced_ruc),         -- TIPO Y NUMERO DEL BENEFICIARIO EJ. CC-79876545
                         @w_beneficiario     	= en_nomlar,                              -- NOMBRE BENEFICIARIO
                         @w_tipo_benef = c_tipo_compania
                  from   cobis..cl_ente
                  where  en_ente = @w_mt_beneficiario
               end else begin
                  select @w_campo3     		= ce_cedula,                              -- NUMERO DEL BENEFICIARIO 
                         @w_beneficiario 	= ce_nombre                               -- NOMBRE BENEFICIARIO
                  from   pf_cliente_externo
                  where  ce_secuencial = @w_mt_beneficiario
               end
   
               select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')

               select @w_desc_conc_emision = valor
               from cobis..cl_tabla T, cobis..cl_catalogo C
               where T.tabla  = 'cc_concepto_emision'
               and   C.tabla  = T.codigo
               and   C.codigo = @w_cod_conc_emision

print '@w_mt_producto = ' + cast(@w_mt_producto as varchar)
print '@w_mpago_chqcom = ' + cast(@w_mpago_chqcom as varchar)

              if @w_mt_producto = @w_mpago_chqcom
              begin
                  select
                     @w_instrumento  = @w_instr_chqcom,
                     @w_subtipo_ins  = @w_mt_subtipo_ins 
              end

print '@w_instrumento = ' + cast(@w_instrumento as varchar)
print '@w_subtipo_ins = ' + cast(@w_subtipo_ins as varchar)

              if @w_mt_producto = @w_cheque_ger
              begin
                  select
                     @w_instrumento  = @w_instrumento_chger,
                     @w_subtipo_ins  = @w_subtipo_ins_chger
              end

               select
                  @w_campo5       = @i_num_banco,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
                  @w_campo6       = @w_cod_conc_emision,                        -- CÓDIGO CONCEPTO DE EMISION
                  @w_campo7       = @w_desc_conc_emision,                       -- DESCRIPCION CONCEPTO DE EMISION
                  @w_campo4	  = @w_beneficiario,
                  @w_referencia   = cast(@w_operacionpf as varchar),
                  @w_area_origen  = 99

            end
            else
            begin
               select
                  @w_beneficiario = @w_descripbenef,
                  @w_referencia   = @i_num_banco,
                  @w_campo2       = @w_concepto,          
                  @w_campo4       = @w_fecha_inicial,     
                  @w_campo5       = @w_fecha_final,       
                  @w_campo6       = @w_tasa_var,          
                  @w_campo7       = @w_monto_var,         
                  @w_area_origen  = 90
            end

            exec @w_return = cob_interfase..sp_isba_imprimir_lotes     
                 @s_ssn              = @s_ssn,
                 @s_user             = @s_user,
                 @s_term             = @s_term,
                 @s_date             = @s_date,
                 @s_srv              = @s_srv,
                 @s_lsrv             = @s_lsrv,
                 @s_ofi              = @s_ofi,
                 @t_debug            = @t_debug,
                 @t_trn              = 29334,
                 @i_oficina_origen   = @s_ofi,  
                 @i_ofi_destino      = @w_mt_oficina,       
                 @i_area_origen      = @w_area_origen,
                 @i_func_solicitante = 0,
                 @i_fecha_solicitud  = @s_date,
                 @i_producto         = 4,
                 @i_instrumento      = @w_instrumento,
                 @i_subtipo          = @w_subtipo_ins,
                 @i_valor            = @w_mt_valor,
                 @i_beneficiario     = @w_descripbenef,
                 @i_referencia       = @w_referencia, --@i_num_banco,
                 @i_tipo_benef       = @w_tipo_benef,
                 @i_campo1           = @w_campo1,
                 @i_campo2           = @w_concepto,
                 @i_campo3           = @w_campo3,
                 @i_campo4           = @w_campo4,
                 @i_campo5           = @w_campo5,
                 @i_campo6           = @w_tasa_var,
                 @i_campo7           = @w_monto_var,
                 @i_campo8           = @w_campo48,          -- 'DEPOSITO A PLAZO ' + @i_num_banco
                 @i_observaciones    = @w_concepto,         -- PAGO DE INTERESES PERIODICOS
                 @i_llamada_ext      = 'S',
                 @i_concepto         = @w_conceptosb,       -- CATALOGO DE SERVICIOS BANCARIOS (3)
                 @i_fpago            = @w_mt_producto,      -- NUEVO REQUERIMIENTO SBA (NEMONICO DE LA FORMA DE PAGO)
                 @i_moneda           = @w_mt_moneda,
                 @i_origen_ing       = '3',
                 @i_idlote           = @w_numero,           -- SECUENCIAL DEL SEQNOS DE SERVICIOS BANCARIOS
                 @i_estado           = 'D',
                 @i_campo21          = 'PFI',
                 @i_campo22          = 'D',
                 @i_campo40          = @w_campo40,
                 @o_idlote           = @w_idlote out,
                 @o_secuencial       = @w_secuencial_cheque out

               if @w_return <>0
               begin
                    exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                         @i_num          = 141095
                    return 141095
               end

               ----------------------------------------------------------
               -- Actualizar registro en pf_emision_cheque para que
               -- no pueda ser cargado en pantalla de emision de ordenes
               ----------------------------------------------------------
               update pf_emision_cheque
               set  ec_fecha_emision    = @s_date,
                    ec_numero           = @w_numero,
                    ec_estado           = 'A',
                    ec_caja             = 'S',
                    ec_secuencial_lote  = @w_secuencial_cheque        --LIM 12/OCT/2005
               where ec_operacion        = @w_operacionpf
               and   ec_tran             = @t_trn
               and   ec_secuencia        = @w_mon_sgte
               and   ec_sub_secuencia    = @w_mt_sub_secuencia
               if @@rowcount = 0
               begin
                    exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                         @i_num          = 141095
                    return 141095
               end

               -------------------------------------------------------------
               -- Actualizar mm_num_cheque para reverso Servicios Bancarios
               -------------------------------------------------------------
               update pf_mov_monet
               set    mm_num_cheque     = @w_numero
               where mm_operacion      = @w_operacionpf
               and   mm_tran           = @t_trn
               and   mm_secuencia      = @w_mon_sgte
               and   mm_sub_secuencia  = @w_mt_sub_secuencia
               if @@error <> 0
               begin
                    exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                         @i_num          = 145020
                    return 145020
               end
          end  --if (@w_producto_fpago = 42)
     end   /* if @@rowcount = 1 */
     else
     begin
          set rowcount 0
          break
     end
end   /** End del while **/

/** Borra el registro de la tabla temporal **/
delete from pf_det_pago_tmp
where dt_usuario    = @s_user
     and   dt_sesion     = @s_sesn
     and   dt_operacion  = @w_operacionpf
if @@error <> 0
begin
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 147022
     return 1
end

/* CALCULO EL VALOR A CONTABILIZAR POR EMERGENCIA ECONOMICA GMF */
exec @w_return = sp_valor_gmf
@s_date         = @s_date,
@i_tran         = @t_trn,
@i_operacionpf  = @w_operacionpf,
@i_secuencia    = @w_mon_sgte,
@o_valor_iee    = @w_total_gmf out

if @w_return <> 0 goto ERROR

--------------------------
--*-* CONTABILIZA PAGO ---
--------------------------
select @w_valor = @i_valor +  @w_total_imp + @w_total_ica

--print 'CONTABILIZA...'
exec @w_return = cob_pfijo..sp_aplica_conta
@s_date               = @s_date,
@s_user               = @s_user,
@s_term               = @s_term,
@s_ofi                = @s_ofi,
@i_fecha              = @s_date,
@i_tran               = 14155,
@i_oficina_oper       = @w_oficina,
@i_operacionpf        = @w_operacionpf,
@i_afectacion         = 'N',
@i_valor              = @w_valor,
@i_impuesto           = @w_mt_impuesto,
@i_ica                = @w_mt_ica,      -- NYM DPF00015 ICA
@i_impuesto_emerg_eco = @w_total_gmf,
@i_secuencia          = @w_mon_sgte,
@o_comprobante        = @o_comprobante out

if @w_return <> 0 goto ERROR

/* Insercion en pf_historia */
insert pf_historia (
     hi_operacion,           hi_secuencial,              hi_fecha,
     hi_trn_code,            hi_valor,                   hi_funcionario,
     hi_oficina,             hi_fecha_crea,              hi_fecha_mod,
     hi_observacion,         hi_fecha_anterior,          hi_saldo_capital,
     hi_secuencia)
values (
     @w_operacionpf,         @w_historia,                @s_date,
     14155,                  @i_valor,                   @s_user,
     @s_ofi,                 @s_date,                    @s_date,
     @i_comentario,          @v_fecha_ant_pago,          @w_monto,
     @w_mon_sgte)
if @@error <> 0
begin
     exec cobis..sp_cerror
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 143006
     return 1
end


if @w_pago_interes =  'N'  -- Si el pago no pudo darse en batch => actualiza ultima cuota vigente a pagada
begin                      -- y disminuye el valor del pago en el monto
   if @w_fpago = 'PER'
   begin
      update pf_cuotas                        --*-* ACTUALIZA CUOTA ACTUAL COMO PAGADA
      set cu_estado = 'P'
      where cu_operacion    = @w_operacionpf
      and   cu_fecha_pago   = @w_fecha_pg_int
      and   cu_estado       = 'V'
      if @@error <> 0 or @@rowcount <> 1
      begin
         select @w_mensaje = 'Pago Anticipado Error al actualizar cuota'
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_mensaje,
            @i_num   = 145054

         return 145054
      end

   if @w_fecha_pg_int < @v_fecha_ven        --*-* SI NO ES EL ULTIMO PAGO DE INTERES OBTIENE VALOR DE SIGUIENTE CUOTA
   begin
      -- Busca siguiente cuota de pago
      set rowcount 1
      select @w_cu_valor_cuota = cu_valor_cuota,
             @w_cu_fecha_pago  = cu_fecha_pago
      from pf_cuotas
      where cu_operacion  = @w_operacionpf
      and   cu_fecha_pago > @w_fecha_pg_int
      and   cu_estado     = 'V'

      if @@rowcount <> 1
      begin
         select @w_mensaje = 'Pago Anticipado No existe cuota para siguiente periodo'
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_mensaje,
            @i_num   = 145054
         return 145054
      end

      if @w_capitalizacion = 'N' --*-* SI NO ES CAPITALIZABLE
      begin
         -- Actualizacion de detalle de pagos
         -------------------------------------
         update pf_det_pago
         set dp_monto = round( (@w_cu_valor_cuota * dp_porcentaje / 100.00) ,@w_numdeci)
         where dp_operacion   = @w_operacionpf
         and   dp_tipo       in('INT','INTV')
         and   dp_estado_xren = 'N'
         and   dp_estado      = 'I'

         select @w_count = count(1)
         from pf_det_pago
         where dp_operacion   = @w_operacionpf
         and   dp_tipo       in ('INT','INTV')
         and   dp_estado      = 'I'
         and   dp_estado_xren = 'N'

         if @w_count > 1     -- Si hay mas de un detalle de pago
         begin
            select @w_money = sum(dp_monto)
            from pf_det_pago
            where dp_operacion   = @w_operacionpf
            and   dp_tipo       in('INT','INTV')
            and   dp_estado_xren = 'N'
            and   dp_estado      = 'I'
            and   dp_secuencia   < @w_count

            update pf_det_pago
            set  dp_monto = @w_cu_valor_cuota - @w_money
            where dp_operacion   = @w_operacionpf
            and   dp_tipo       in('INT','INTV')
            and   dp_estado_xren = 'N'
            and   dp_estado      = 'I'
            and   dp_secuencia   = @w_count
         end

         select @w_total_int_estimado = @v_total_int_estimado
      end
      else     -- SI ES CAPITALIZABLE => CALCULA TOT INT ESTIMADO DESDE ULTIMA FECHA DE PAGO DE INTERES
      begin
         -- Recalcula interes estimado desde proxima fecha de pago
         --------------------------------------------------------
         select @w_monto_pg_int = @w_monto_pg_int + @i_valor

         -- Calcula valor de total interes estimado desde ultima fecha de pago
         exec @w_return = sp_estima_int
            @s_ofi             = @s_ofi,
            @s_date            = @w_fecha_pg_int,
            @i_fecha_inicio    = @w_fecha_pg_int,
            @i_cambia_dia_pago = 'S',
            @i_fecha_final     = @v_fecha_ven,
            @i_monto           = @w_monto_pg_int,
            @i_tasa            = @w_tasa,
            @i_tcapitalizacion = 'S',
            @i_fpago           = @w_fpago,
            @i_ppago           = @w_ppago,
            @i_dias_anio       = @w_base_calculo,
            @i_dia_pago        = @w_dia_pago,
            @i_moneda          = @w_moneda,
            @i_dias_reales     = @v_dias_reales,
            @o_int_pg_ve       = @w_total_int_estimado out
         if @w_return <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141051
            return 141051
         end

         --Obtiene sumatoria de cuotas hasta este pago vigente
         select @w_cuotas_a_la_fecha = sum(cu_valor_cuota)
         from  pf_cuotas
         where cu_operacion   = @w_operacionpf
         and   cu_fecha_pago  > @v_fecha_valor
         and   cu_fecha_pago <= @w_fecha_pg_int

--print 'w_cuotas_a_la_fecha:%1!,@v_fecha_valor:%2!,@w_fecha_pg_int:%3!',@w_cuotas_a_la_fecha,@v_fecha_valor,@w_fecha_pg_int

         select @w_total_int_estimado = @w_total_int_estimado + @w_cuotas_a_la_fecha
      end
   end
   else -- Si es la ultima cuota o ya esta vencido => deja los valores originales de interes estimado y proximo pago de interes
   begin
      select @w_cu_valor_cuota     = @v_int_estimado,
             @w_cu_fecha_pago      = @w_fecha_pg_int,
             @w_total_int_estimado = @v_total_int_estimado

--print 'AAA @w_capitalizacion:%1!,@w_monto_pg_int:%2!,@v_int_estimado:%3!,@i_valor:%4!',@w_capitalizacion,@w_monto_pg_int,@v_int_estimado,@i_valor

      if @w_capitalizacion = 'S'
      begin
         select @w_monto_pg_int = @w_monto_pg_int +  @i_valor
      end
--print 'TOTAL MONTO NEW:%1!',@w_monto_pg_int
   end


   -- Actualiza datos de la operacion
   ---------------------------------------------
 --print '** ACTUALIZA 1 @w_total_int_estimado:%1!,@i_valor:%2!,@i_impuesto:%3!, FINAL @w_monto_pg_int:%4!',@w_total_int_estimado , @i_valor , @i_impuesto, @w_monto_pg_int

   if @w_fecha_pg_int > @w_ult_fecha_calculo
      select @w_pago_interes = 'S'

      update pf_operacion
      set  op_total_int_estimado  = @w_total_int_estimado,
           op_total_int_pagados   = op_total_int_pagados + @i_valor + @i_impuesto,
           op_fecha_ult_pg_int    = @w_fecha_pg_int,
           op_fecha_pg_int        = @w_cu_fecha_pago,
           op_monto_pg_int        = @w_monto_pg_int,
           op_monto               = @w_monto_pg_int,         --*-*
           op_int_ganado          = op_int_ganado - @w_cu_valor_cuota_np,
           op_int_pagados         = 0,
           op_fecha_mod           = @s_date,
           op_historia            = @v_historia + 1,
           op_mon_sgte            = @v_mon_sgte + 1,
           ---------------------------------------------
           op_fecha_total         = @w_cu_fecha_pago,        --*-*
           op_int_estimado        = @w_cu_valor_cuota,       -- actualiza interes estimado                ==> OK
           op_pago_interes        = @w_pago_interes,
           op_total_int_retenido  = op_total_int_retenido + @w_total_imp + @w_total_ica
      where op_operacion = @w_operacionpf
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 145001
         return 145001
      end

      --Actualizacion de cuotas para siguientes pagos
      if @w_capitalizacion = 'S' --*-* SI ES CAPITALIZABLE
      begin
         exec @w_return = sp_actualiza_cuota
            @s_ssn                   = @s_ssn,
            @s_user                  = @s_user,
            @s_sesn                  = @s_sesn,
            @s_ofi                   = @s_ofi,
            @s_date                  = @s_date,
            @t_trn                   = 14146,
            @s_srv                   = @s_srv,
            @s_term                  = @s_term,
            @t_file                  = @t_file,
            @t_from                  = @w_sp_name,
            @t_debug                 = @t_debug,

            @i_monto                 = @w_monto_pg_int,
            @i_fecha_proceso         = @w_fecha_pg_int,
            @i_op_operacion          = @w_operacionpf
         if @w_return <> 0
         begin
            exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = @w_return
            return @w_return
         end
      end

--print 'SE VA...'
--return 1

   end --Si el producto es PER

   if @w_fpago  = 'VEN'
   begin
      if @w_capitalizacion = 'S' --*-* SI ES CAPITALIZABLE y no hizo el pago al vencimiento
         select @w_monto_pg_int = @w_monto_pg_int + @i_valor

      update pf_operacion
      set  op_total_int_pagados   = op_total_int_pagados + @i_valor + @i_impuesto,
           op_fecha_ult_pg_int    = op_fecha_pg_int,
           op_monto_pg_int        = @w_monto_pg_int,
           op_monto               = @w_monto_pg_int,         --*-*
           op_int_ganado          = 0,
           op_int_pagados         = 0,
           op_fecha_mod           = @s_date,
           op_historia            = @v_historia + 1,
           op_mon_sgte            = @v_mon_sgte + 1,
           op_pago_interes        = 'S'
      where op_operacion = @w_operacionpf

      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 145001
         return 145001
      end
   end
end
else   -- SI EL PAGO DE INTERES ES ANTICIPADO Y NO POR ERROR EN BATCH      ///////////////////////////////////////////////////////////////////////
begin
   --Reajustar las siguientes cuotas para estos tipos de dpfs
   if @w_fpago = 'PER'
   begin
      if @w_capitalizacion = 'S'
      begin
         -- Recalcula interes estimado desde proxima fecha de pago
         --------------------------------------------------------
         select @w_monto_pg_int = @w_monto_pg_int + (@v_int_estimado - @i_valor - @i_impuesto - @v_int_pagados)

         -- print 'RECALCULA PAGO monto_pg_int:%1!',@w_monto_pg_int

         -- Calcula valor de total interes estimado desde ultima fecha de pago
         exec @w_return = sp_estima_int
         @s_ofi             = @s_ofi,
         @s_date            = @w_fecha_pg_int,
         @i_fecha_inicio    = @w_fecha_pg_int,
         @i_cambia_dia_pago = 'S',
         @i_fecha_final     = @v_fecha_ven,
         @i_monto           = @w_monto_pg_int,
         @i_tasa            = @w_tasa,
         @i_tcapitalizacion = 'S',
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_moneda          = @w_moneda,
         @i_dias_reales     = @v_dias_reales,
         @o_int_pg_ve       = @w_total_int_estimado out
         if @w_return <> 0
         begin
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141051
            return 141051
         end

         --Obtiene sumatoria de cuotas hasta este pago vigente
         select @w_cuotas_a_la_fecha = sum(cu_valor_cuota)
         from  pf_cuotas
         where cu_operacion   = @w_operacionpf
         and   cu_fecha_pago  >  @v_fecha_valor
         and   cu_fecha_pago <= @w_fecha_pg_int


         select @w_total_int_estimado = @w_total_int_estimado + @w_cuotas_a_la_fecha
         
      end
      else  --SIN CAPITALIZACION     
         select @w_total_int_estimado = @v_total_int_estimado
   end else begin 
      select @w_total_int_estimado = @v_total_int_estimado
   end
   
   
   -- Actualiza datos de operacion
   update pf_operacion set
      op_total_int_estimado     = @w_total_int_estimado,
      op_total_int_pagados      = op_total_int_pagados + @i_valor + @i_impuesto,
      op_int_pagados            = op_int_pagados + @i_valor + @i_impuesto,
      op_fecha_ult_pago_int_ant = @s_date,
      op_fecha_mod              = @s_date,
      op_historia               = @v_historia + 1,
      op_mon_sgte               = @v_mon_sgte + 1,
	op_total_int_retenido  = op_total_int_retenido + @w_total_imp + @w_total_ica
   where op_operacion = @w_operacionpf
   if @@error <> 0
   begin
   
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 145001
        return 145001
   end

   if @w_fpago = 'PER' and @w_capitalizacion = 'S'
   begin
      exec @w_return = sp_actualiza_cuota
         @s_ssn                   = @s_ssn,
         @s_user                  = @s_user,
         @s_sesn                  = @s_sesn,
         @s_ofi                   = @s_ofi,
         @s_date                  = @s_date,
         @t_trn                   = 14146,
         @s_srv                   = @s_srv,
         @s_term                  = @s_term,
         @t_file                  = @t_file,
         @t_from                  = @w_sp_name,
         @t_debug                 = @t_debug,

         @i_monto                 = @w_monto_pg_int,
         @i_fecha_proceso         = @w_fecha_pg_int,
         @i_op_operacion          = @w_operacionpf
      if @w_return <> 0
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = @w_return
         return @w_return
      end
   end
end

/* transaccion de Servicio - pf_operacion  */
insert into ts_operacion (
     secuencial,          tipo_transaccion,             clase,               fecha,               usuario,
     terminal,            srv,                          lsrv,                int_pagados,         total_int_pagados,
     fecha_ult_pg_int,    historia,                     mon_sgte,            fecha_mod,           int_ganado,
     int_estimado,       total_int_estimado)
values (
     @s_ssn,              @t_trn,                       'P',                 @s_date,             @s_user,
     @s_term,             @s_srv,                       @s_lsrv,             @v_int_pagados,      @v_total_int_pagados,
     @v_fecha_ult_pg_int, @v_historia,                  @v_mon_sgte,         @v_fecha_mod,        @v_int_ganado,
     @v_int_estimado,    @v_total_int_estimado)
if @@error <> 0
begin
     exec cobis..sp_cerror
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 143005
   return 1
end

--print 'HACE ROLLBACK...por pruebas ...'
--rollback tran
--return 1

if @w_commit = 'S' commit tran    --******************************************************************************************++

return 0

ERROR:
   if @w_commit = 'S' rollback tran
  
   exec cobis..sp_cerror
   @t_from        = @w_sp_name,
   @i_num         = @w_return
  
  return @w_return
go

