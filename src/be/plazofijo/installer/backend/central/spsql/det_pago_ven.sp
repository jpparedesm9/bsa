/************************************************************************/
/*      Archivo:                i_detpagv.sp                            */
/*      Stored procedure:       sp_det_pago_ven                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 19-Feb-2004                             */
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
/*      Este stored crea las diferentes formas de pago en un deposito   */
/*      que tiene forma de pago al vencimiento y renovacion automatica. */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR              RAZON                          */
/*      19-Feb-2004   N. Silva           Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_det_pago_ven' and type = 'P')
   drop proc sp_det_pago_ven
go
create proc sp_det_pago_ven (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@i_dp_monto             money,
@i_op_operacion         int,
@i_op_ente              int,
@i_op_moneda            tinyint,
@i_op_impuesto          money,
@i_op_num_banco         cuenta,
@i_secuencia            int,
@i_ec_subsec            int,
@i_alt                  int,
@i_fecha_hoy            datetime,
@i_int_estim_new        money,
@o_secuencia            int out,
@o_ec_subsec            int out
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_descripcion          descripcion,
        @w_return               int,
        @w_numdeci              tinyint,
        @w_usadeci              char(1),
	@w_empresa		tinyint,
	@w_filial		int,
        @w_secuencia            int,
        @w_ec_subsec            int,
        @w_error                int,
        @w_cc_cta_banco         cuenta,
        @w_fpago_ctacte         catalogo,
        @w_dp_int_estimado      money,
/* VARIABLES PARA EL DETALLE DE PAGO */
        @w_dp_porcentaje        float,
        @w_dp_secuencia         int,
        @w_dp_forma_pago        catalogo,
        @w_dp_cuenta            cuenta,
        @w_dp_monto             money,
        @w_flag                 int

------------------------------------------------------------------------------
-- Asignacion nombre de stored procedure e inicializacion de nuevas variables
------------------------------------------------------------------------------
select @w_sp_name = 'sp_det_pago_ven',
       @w_empresa= 1,
       @w_filial = 1
select @w_secuencia = @i_secuencia
select @w_ec_subsec = @i_ec_subsec
select @o_secuencia = @i_secuencia
select @o_ec_subsec = @i_ec_subsec
select @w_flag      = 0

------------------------------------
-- Encuentra parametro de decimales  
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_op_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

------------------------------------------------------------------------------
-- Verifica si la operacion tiene almacenado el detalle de pagos de intereses
------------------------------------------------------------------------------
if not exists ( select 1  from cob_pfijo..pf_det_pago where dp_operacion = @i_op_operacion         
               and dp_tipo = 'INTV' and dp_estado = 'I' and dp_estado_xren = 'N')
begin
  select @w_dp_monto = @i_dp_monto
   ------------------------------------------------------------------- 
   -- Proceso para selecccionar cta. CTE/AHO si la tuviese el cliente
   -------------------------------------------------------------------
   select @w_fpago_ctacte = fp_mnemonico
     from pf_fpago
    where fp_producto = 3

   set rowcount 1
   -----------------------------------------------------------------------------
   -- Proceso para tomar el codigo del producto de la ctahorros si cambian los
   -- codigos del producto en ahorros cambia la estructura del IF
   -----------------------------------------------------------------------------
   exec @w_error = cob_interfase..sp_icuentas
        @i_operacion    = 'AF',
        @i_op_ente      = @i_op_ente,
		@i_moneda       = @i_op_moneda,
        @o_cc_cta_banco = @w_cc_cta_banco out
 
   if @w_cc_cta_banco is null
      select @w_dp_forma_pago = 'EFEC',
             @w_dp_cuenta = NULL
   else
   begin
      select @w_dp_forma_pago = @w_fpago_ctacte,
             @w_dp_cuenta = @w_cc_cta_banco
   end
   set rowcount 0

   GOTO MOVIMIENTO
end
else
begin
   begin tran
   select @w_flag = 1

   -----------------------------------------------------
   -- Acceso y declaracion de cursor sobre pf_operacion 
   -----------------------------------------------------
   declare cursor_pf_det_pagov cursor
   for select dp_porcentaje,
              dp_secuencia,
              dp_forma_pago,
              dp_cuenta
         from cob_pfijo..pf_det_pago
        where dp_operacion = @i_op_operacion
          and dp_estado_xren = 'N'
          and dp_tipo = 'INTV'
          and dp_estado = 'I'
   order by dp_secuencia

   open cursor_pf_det_pagov
   fetch cursor_pf_det_pagov into 
         @w_dp_porcentaje,
         @w_dp_secuencia,
         @w_dp_forma_pago,
         @w_dp_cuenta

   while @@fetch_status <>-1
   begin
      if @@fetch_status = -2 
      begin
         close cursor_pf_det_pagov
         deallocate cursor_pf_det_pagov
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end 

      select @w_dp_monto = @i_dp_monto*(@w_dp_porcentaje/100)
      select @w_dp_int_estimado = @i_int_estim_new*(@w_dp_porcentaje/100)
      select @o_secuencia = @w_secuencia
      select @o_ec_subsec = @w_ec_subsec
      
      goto MOVIMIENTO
      
      -------------------------------------------------------------------
      -- Actualizacion del detalle de pago con el nuevo interes estimado
      -------------------------------------------------------------------
      update cob_pfijo..pf_det_pago
         set dp_monto = @w_dp_int_estimado
       where dp_operacion = @i_op_operacion
         and dp_secuencia = @w_dp_secuencia
         and dp_estado_xren = 'N'
         and dp_tipo = 'INTV'
         and dp_estado = 'I'

      if @@error <> 0
      begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143038
         select @w_return = 1
         select @w_error =  143038
         goto ERROR
      end  

      select @w_secuencia = @w_secuencia + 1
      select @w_ec_subsec = @i_ec_subsec + 1
    
      fetch cursor_pf_det_pagov into 
            @w_dp_porcentaje,
            @w_dp_secuencia,
            @w_dp_forma_pago,
            @w_dp_cuenta
   end /*while cursor_operacion*/

   commit tran 
   close cursor_pf_det_pagov
   deallocate cursor_pf_det_pagov  
end
return 0

----------------------------
-- Insercion de Movimientos 
----------------------------
MOVIMIENTO:
      -----------------------------------------------
      -- Grabar los datos en el movimiento monetario
      -----------------------------------------------
      insert pf_mov_monet ( mm_operacion       , mm_tran        , mm_secuencia, mm_sub_secuencia,
                            mm_producto        , mm_cuenta      , mm_valor    , mm_valor_ext,
                            mm_impuesto        , mm_fecha_crea  , mm_fecha_mod, mm_tipo,
                            mm_secuencial      , mm_beneficiario, mm_moneda   , mm_estado,
                            mm_fecha_aplicacion, mm_usuario)
                   values ( @i_op_operacion    , 14919          , @w_secuencia, @w_ec_subsec,
                            @w_dp_forma_pago   , @w_dp_cuenta   , @w_dp_monto , @w_dp_monto,
                            @i_op_impuesto     , @s_date        , @s_date     , 'C',
                            0                  , @i_op_ente     , @i_op_moneda, null,
                            null               , @s_user)
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143020
         select @w_error =  143020
         goto ERROR
      end  
      -----------------------------------
      -- Aplicacion de pago de intereses
      -----------------------------------  
      exec @w_return=sp_aplica_mov
           @s_ssn           = @s_ssn, 
           @s_user          = @s_user,
           @s_ofi           = @s_ofi,
           @s_date          = @s_date,
           @s_srv           = @s_srv,
           @s_term          = @s_term,
           @t_file          = @t_file,
           @t_from          = @w_sp_name,
           @t_debug         = @t_debug,
           @t_trn           = 14919, 
           @i_operacionpf   = @i_op_operacion,
           @i_fecha_proceso = @i_fecha_hoy,
           @i_secuencia     = @w_secuencia,
           @i_tipo          = 'N',
           @i_sub_secuencia = @w_ec_subsec,
           @i_op_num_banco  = @i_op_num_banco,
           @i_alt           = @i_alt

      if @w_return <> 0
      begin                     
         exec cobis..sp_cerror 
              @t_debug   = @t_debug,
              @t_file    = @t_file,
              @t_from    = @w_sp_name,   
              @i_num     = @w_return
         select @w_error =  @w_return
         goto ERROR
      end
      if @w_flag = 0 
      begin
         return 0
        -- commit tran
      end

------------------
-- Manejo de Error
------------------
ERROR:
      select @w_descripcion = @i_op_num_banco + '(' + convert(varchar,@i_op_operacion) + ')'
      rollback tran --calc_diario_int
      exec sp_errorlog 
           @i_sdate     = @s_date, 
           @i_error     = @w_error,
           @i_usuario   = @s_user,
           @i_tran      = 14919,
           @i_operacion = @i_op_num_banco,
           @i_fecha     = @s_date
      return @w_return
go

