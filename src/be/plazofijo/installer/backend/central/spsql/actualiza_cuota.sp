/*sp_actualiza_cuota*/
/************************************************************************/
/*      Archivo:                a_cuota.sp                              */
/*      Stored procedure:       sp_actualiza_cuota                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 21-Feb-2004                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script realiza la actualizaci¢n de una cuota una vez graba-*/
/*      dos la nueva tasa y el nuevo valor de la operacion, en incre-   */
/*      mentos/reducciones/cambio de tasa.                              */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      21-Feb-2004  N. Silva           Emision Inicial.                */
/*      21-Mar-2007  Clotilde Vargas    Agregar en recalculo de cuotas  */
/*                                      la amortizaci¢n de los bonos    */
/*      10-Ene-2017  Jorge Salazar      DPF-H94952 MANEJO RETENCIONES MX*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_cuota' and type = 'P')
   drop proc sp_actualiza_cuota
go

create proc sp_actualiza_cuota (
   @s_ssn                   int             = NULL,
   @s_user                  login           = NULL,
   @s_term                  varchar(30)     = NULL,
   @s_date                  datetime        = NULL,
   @s_sesn                  int             = NULL,
   @s_srv                   varchar(30)     = NULL,
   @s_lsrv                  varchar(30)     = NULL,
   @s_ofi                   smallint        = NULL,
   @s_rol                   smallint        = NULL,
   @t_debug                 char(1)         = 'N',
   @t_file                  varchar(10)     = NULL,
   @t_from                  varchar(32)     = NULL,
   @t_trn                   smallint        = NULL,

   @i_fecha_proceso         datetime        = NULL,
   @i_monto                 money           = NULL,
   @i_op_operacion          int             = NULL,
   @i_modifica              char(1)         = 'N' --CVA Jun-29-06 solo para escalonados tendr  'S'
)
with encryption
as
declare
   @w_sp_name               descripcion,
   @w_return                int,
   @w_error                 int,
   @w_secuencial            int,
   @w_fecha_hoy             datetime,
   /* Variables de Cuotas */
   @w_op_tasa               float,
   @w_op_int_estimado       money,
   @w_op_monto              money,
   @w_op_tcapitalizacion    char(1),
   @w_op_base_calculo       int,
   @w_op_num_banco          cuenta,
   /* Variables de Operacion */
   @w_cu_cuota              int,
   @w_cu_valor_cuota        money,
   @w_cu_capital            money,
   @w_cu_num_dias           int,
   @w_contador              int,
   @w_fecha_ven             datetime, --+-+
   @w_fecha_cuota           datetime, --+-+
   @w_sub_total             money,         --+-+
   @w_total_int_estimado    money,
   @w_tipo_plazo            catalogo,
   @w_escalonado            char(1),
   @w_dias_trans            int,
   @w_op_fecha_valor        datetime,
   @w_plazo_max             int,
   @w_plazo_min             int,
   @w_fecha_cambio          datetime,
   @w_mnemonico_tasa        catalogo,
   @w_op_moneda             smallint,
   @w_op_toperacion         catalogo,
   @w_operador              char(1),
   @w_spread                float,
   @w_tasa_max              float,
   @w_tasa_min              float,
   @w_periodo_tasa          smallint,
   @w_descr_tasa            descripcion,
   @w_op_fpago              catalogo,
   @w_pp_factor_en_meses    tinyint,
   @w_op_ppago              catalogo,
   @w_tasa_sgte             float,
   @w_fecha_ult_pago        datetime,
   @w_dias_tasa_ant         int,
   @w_op_dia_pago           smallint,
   @w_int_estimado_ant      money,
   @w_num_dias_sgte         smallint,
   @w_pos                   int,
   @w_valor_tasa_var        float,
   @w_modalidad_tasa        char(1),
   @w_td_dias_reales        char(1),
   @w_op_amortiza_periodo   money,   /*CVA Mar-21-07*/
   @w_usadeci               char(1),
   @w_numdeci               tinyint,
   /* INICIO - GAL 21/SEP/2009 - RVVUNICA */
   @w_op_ente               int,
   @w_op_oficina            smallint,
   @w_op_num_dias           smallint,
   @w_retienimp             char(1),
   @w_ret_ica               char(1),
   @w_tasa_ret              float,
   @w_tasa_ica              float,
   @w_imp_renta             money,
   @w_imp_ica               money,
   @w_int_estimado_neto     money,
   /* FIN - GAL 21/SEP/2009 - RVVUNICA */
   @w_valor_retenido        money

-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name          = 'sp_actualiza_cuota',
       @s_user             = isnull(@s_user,'SYSTEM'),
       @s_term             = isnull(@s_term,'CONSOLA'),
       @i_fecha_proceso    = isnull(@i_fecha_proceso,@s_date),
       @s_date             = @i_fecha_proceso,
       @s_srv              = isnull(@s_srv,@@servername),
       @s_lsrv             = isnull(@s_lsrv,@@servername),
       @t_debug            = 'N',
       @t_file             = 'SQR',
       @w_int_estimado_ant = 0

--------------------------------------------------------------
-- Acceso a operacion para obtener el nuevo valor de la cuota
--------------------------------------------------------------
select @w_op_num_banco        = op_num_banco,
       @w_op_tasa             = op_tasa,
       @w_op_int_estimado     = op_int_estimado,
       @w_total_int_estimado  = op_total_int_estimado, --+-+
       @w_op_monto            = op_monto,
       @w_op_tcapitalizacion  = op_tcapitalizacion,
       @w_fecha_ven           = op_fecha_ven,               --+-+
       @w_op_base_calculo     = op_base_calculo,
       @w_tipo_plazo          = op_tipo_plazo,
       @w_op_fecha_valor      = op_fecha_valor,
       @w_mnemonico_tasa      = op_mnemonico_tasa,
       @w_periodo_tasa        = op_periodo_tasa,
       @w_op_moneda           = op_moneda,
       @w_op_toperacion       = op_toperacion,
       @w_op_fpago            = op_fpago,
       @w_descr_tasa          = op_descr_tasa,
       @w_op_ppago            = op_ppago,
       @w_op_dia_pago         = op_dia_pago,
       @w_td_dias_reales      = op_dias_reales,
       @w_op_toperacion       = op_toperacion,        /*CVA Mar-21-07*/
       @w_op_amortiza_periodo = op_amortiza_periodo,  /*CVA Mar-21-07*/
       @w_op_ente             = op_ente,              -- GAL 21/SEP/2009 - RVVUNICA
       @w_op_oficina          = op_oficina,           -- GAL 21/SEP/2009 - RVVUNICA
       @w_op_num_dias         = op_num_dias           -- GAL 21/SEP/2009 - RVVUNICA
from cob_pfijo..pf_operacion
where op_operacion = @i_op_operacion

if @i_monto is not null           --+-+ Para el caso de que se desee actualizar cuotas desde INCREDEF.SP
   select @w_op_monto = @i_monto

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_op_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and   pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

-------------------------------------------------------------
-- Grabar las cuotas en un archivo historico para el reverso
-------------------------------------------------------------
insert into cob_pfijo..pf_cuotas_his(
       ch_ente          , ch_operacion, ch_cuota   , ch_fecha_pago,
       ch_valor_cuota   , ch_retencion, ch_capital , ch_fecha_crea,
       ch_moneda        , ch_oficina  , ch_num_dias, ch_estado,
       ch_fecha_ult_pago, ch_tasa     , ch_ppago   , ch_base_calculo,
       ch_fecha_grab)
select cu_ente          , cu_operacion, cu_cuota   , cu_fecha_pago,
       cu_valor_cuota   , cu_retencion, cu_capital , cu_fecha_crea,
       cu_moneda        , cu_oficina  , cu_num_dias, cu_estado,
       cu_fecha_ult_pago, cu_tasa     , cu_ppago   , cu_base_calculo,
       @s_date
from cob_pfijo..pf_cuotas
where cu_operacion =  @i_op_operacion

-------------------------------------------
-- Obtener el Factor de Conversion en Meses
-------------------------------------------
select @w_pp_factor_en_meses = pp_factor_en_meses
from cob_pfijo..pf_ppago
where pp_codigo = @w_op_ppago
and   pp_estado = 'A'

------------------------------------------
-- Acceso a la tabla de detalle de cuotas
------------------------------------------
select @w_contador = 1

declare cursor_actualiza_cuota cursor for
select
   cu_cuota,
   cu_valor_cuota,
   cu_capital,
   cu_num_dias,
   cu_fecha_pago,
   cu_fecha_ult_pago
from cob_pfijo..pf_cuotas
where cu_fecha_pago  > @i_fecha_proceso
and   cu_estado      = 'V'
and   cu_operacion   = @i_op_operacion
order by cu_cuota

open cursor_actualiza_cuota
fetch cursor_actualiza_cuota into
   @w_cu_cuota,
   @w_cu_valor_cuota,
   @w_cu_capital,
   @w_cu_num_dias,
   @w_fecha_cuota,
   @w_fecha_ult_pago

while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
      close cursor_actualiza_cuota
      deallocate cursor_actualiza_cuota
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
   end

   --print '@w_cu_cuota %1!', @w_cu_cuota

   ----------------------------------
   -- Calculo de intereses por cuota
   ----------------------------------
   --+-+ if @w_contador > 1
   --print '@w_fecha_cuota:%1!,@w_fecha_ven:%2!',@w_fecha_cuota,@w_fecha_ven
   if @w_fecha_cuota = @w_fecha_ven
   begin
      select @w_sub_total = isnull(sum(cu_valor_cuota),0)
      from pf_cuotas
      where cu_operacion   = @i_op_operacion
      and   cu_fecha_pago  < @w_fecha_ven
      and   cu_estado     in ('P','V')

      select @w_op_int_estimado = @w_total_int_estimado - @w_sub_total

      --print 'ultima cuota ->tot_int_estim:%1!,@w_op_int_estimado:%2!,@w_sub_total:%3!',@w_total_int_estimado,@w_op_int_estimado,@w_sub_total
   end
   else
   begin
      select @w_op_int_estimado = round((@w_op_monto*@w_op_tasa*@w_cu_num_dias)/(@w_op_base_calculo*100),@w_numdeci)
   end

   if @w_op_int_estimado < 0
      select @w_op_int_estimado = 0

   -- INICIO - GAL 21/SEP/2009 - RVVUNICA
   select
      @w_imp_renta = 0,
      @w_imp_ica   = 0

   exec @w_return = sp_aplica_impuestos
        @s_ofi              = @s_ofi,
        @t_debug            = @t_debug,
        @i_ente             = @w_op_ente,
        @i_plazo            = @w_cu_num_dias,
        @i_capital          = @i_monto,
        @i_interes          = @w_op_int_estimado,
        @i_base_calculo     = @w_op_base_calculo,
        @o_retienimp        = @w_retienimp      out,
        @o_tasa_retencion   = @w_tasa_ret       out,
        @o_valor_retencion  = @w_valor_retenido out
   
   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_return
      return @w_return
   end


   if @w_retienimp = 'S'
      select @w_imp_renta = round(@w_op_int_estimado*@w_tasa_ret/100, @w_numdeci)

   select @w_int_estimado_neto = @w_op_int_estimado - @w_imp_renta - @w_imp_ica
   -- FIN - GAL 21/SEP/2009 - RVVUNICA

   ------------------------------
   -- Actualizacion de la cuota
   ------------------------------
   update cob_pfijo..pf_cuotas
   set cu_valor_cuota = @w_op_int_estimado,
       cu_capital     = @w_op_monto,
       cu_tasa        = @w_op_tasa,
       cu_valor_neto  = @w_int_estimado_neto       -- GAL 21/SEP/2009 - RVVUNICA
   where cu_cuota       = @w_cu_cuota
   and   cu_operacion   = @i_op_operacion

   if @@error <> 0
   begin
      close cursor_actualiza_cuota
      deallocate cursor_actualiza_cuota
      select @w_error = 145053
      goto ERROR
   end

   -----------------------------------------
   -- Analizar si capitaliza o no intereses
   -----------------------------------------
   if @w_op_tcapitalizacion = 'S'
      select @w_op_monto = @w_op_monto + @w_int_estimado_neto        -- GAL 21/SEP/2009 - RVVUNICA

   select @w_contador = @w_contador + 1

   fetch cursor_actualiza_cuota into
      @w_cu_cuota,
      @w_cu_valor_cuota,
      @w_cu_capital,
      @w_cu_num_dias,
      @w_fecha_cuota,
      @w_fecha_ult_pago

end /* while cursor_actualiza_cuota */

close cursor_actualiza_cuota
deallocate cursor_actualiza_cuota

return 0

-------------------
-- Manejo de Error
-------------------
ERROR:

   exec sp_errorlog
      @i_fecha      = @s_date,
      @i_error      = @w_error,
      @i_usuario    = @s_user,
      @i_tran       = @t_trn,
      @i_cta_pagrec = @w_sp_name,
      @i_cuenta     = @w_op_num_banco
   return @w_error
go
