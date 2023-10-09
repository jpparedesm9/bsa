/************************************************************************/
/*      Archivo:                detpatmp.sp                             */
/*      Stored procedure:       sp_detallepago_tmp                      */
/*      Base de datos:          cob_pfijo                               */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 17/Ago/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT y DELETE      */
/*      a la tabla temporal de detalles de pagos 'pf_det_pago_tmp'      */
/************************************************************************/
/*      FECHA                 MODIFICACIONES            AUTOR           */
/*      01-Mar-2005           G. Arboleda               Aumenta Oficina */
/*      01-Mar-2005           N. Silva                  Corr. Val porct */
/*      18-Nov-2005           Luis Im                   Aumenta cod.    */
/*                                                      banco     	*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_detallepago_tmp')
   drop proc sp_detallepago_tmp
go

create proc sp_detallepago_tmp (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_sesn                 int             = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_cuenta               cuenta	      = NULL,
      @i_ente                 int             = NULL,
      @i_tipopago             catalogo	      = NULL,
      @i_formapago            catalogo	      = NULL,
      @i_cuentapro            cuenta	      = NULL,  
      @i_monto                money           = NULL,
      @i_porcentaje           float           = NULL,
      @i_moneda_pago          smallint        = NULL,	
      @i_descripcion          varchar(255)    = '',
      @i_tipo_cliente	      char(1)         = NULL,
      @i_secltext             int             = NULL,
      @i_oficina              int             = NULL,
      @i_secuencia            int             = NULL,
      @i_tipo_cuenta_ach      char(1)         = NULL,
      --@i_banco_ach            descripcion     = NULL
      @i_banco_ach            smallint     	= NULL,		--LIM 18/NOV/2005
      @i_op_operacion         int               = NULL,
      @i_benef_cheque         varchar(65)        = NULL
)
with encryption
as
declare
      @i_operacionpf          int,
      @w_sp_name              varchar(32),
      @w_totporc              float,  
      @w_fecha_crea           datetime,
      @w_fecha_mod            datetime,
      @w_usuario              login,
      @w_sesion               int,
      @w_cod_clte             int,
      @w_return		      int,
      @c_por_ciento           float

select @c_por_ciento = 100.00
select @w_sp_name = 'sp_detallepago_tmp'

--I. 1220 CVA Set-02-2005 El FrontEnd envia la oficina para las formas de pago
--                        que necesitan almacenar este valor
--if @i_oficina is null
--   select @i_oficina = @s_ofi

		--------------------------------------
		--  Verificar Codigo de Transaccion --
		--------------------------------------
if ( @i_operacion <> 'I' or @t_trn <> 14137 ) and
   ( @i_operacion <> 'C' or @t_trn <> 14137 ) and
   ( @i_operacion <> 'D' or @t_trn <> 14337 ) 
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 141040
end

select @w_cod_clte = @i_ente

-------------------------------------------------------
--  Verificar existencia de la operacion de Plazo fijo
-------------------------------------------------------
if @i_operacion = 'I' 
begin
   select @i_operacionpf = ot_operacion
     from cob_pfijo..pf_operacion_tmp
    where ot_usuario =  @s_user 
      and ot_sesion =@s_sesn 
      and ot_num_banco =@i_cuenta 

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141051
      return 141051
   end
end

if @i_operacion = 'C'
begin 
   select @i_operacionpf = op_operacion
     from pf_operacion
    where op_num_banco =@i_cuenta 

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141051
      return 141051
   end
end

------------------------------------------------------
-- Insercion de detalle de pagos en la tabla temporal
------------------------------------------------------
If @i_operacion in ('I','C')
begin

   ---------------------------------------------------
   -- Verifica porcentajes de participacion correctos
   ---------------------------------------------------
   if @i_porcentaje IS NOT NULL
   begin
      if @i_porcentaje > @c_por_ciento
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'Distribucion de porcentajes incorrectos',
              @i_num   = 141128
         return 141128
      end 

      select @w_totporc = sum(dt_porcentaje)
        from pf_det_pago_tmp     
       where dt_operacion = @i_operacionpf
         and dt_sesion    = @s_sesn
         and dt_usuario   = @s_user
         and dt_tipo      = @i_tipopago

      if round((@i_porcentaje + @w_totporc),2) > round(@c_por_ciento,2)
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'Total movimientos mayor a 100',
              @i_num   = 141128
         return 141128
      end
   end


   begin tran
      --------------------------------------------------------------
      -- Asignar c½digo para clte. externo desde pf_cliente_externo
      --------------------------------------------------------------
	if @i_tipo_cliente = 'E'
	begin
		-- Busca consecutivo del cliente --

		exec @w_return = cobis..sp_cseqnos
			@t_debug = @t_debug,
               		@t_file  = @t_file,
               		@t_from  = @w_sp_name,
               		@i_tabla = 'pf_cliente_externo',
               		@o_siguiente = @w_cod_clte out

          	if @w_return <> 0
			return @w_return 

                   insert pf_cliente_externo(ce_secuencial, ce_nombre, ce_cedula, ce_direccion)
                          select @w_cod_clte, ct_nombre, ct_cedula, ct_direccion
	                  from	 pf_cliente_externo_tmp
        	          where	 ct_secuencial = @i_secltext 
	                  and	 ct_usuario    = @s_user 
        	          and	 ct_sesion     = @s_sesn

                       
		delete	pf_cliente_externo_tmp
		where	ct_secuencial = @i_secltext
		and	ct_usuario    = @s_user 
		and	ct_sesion     = @s_sesn
	end


      -----------------------------------------------------
      -- Insercion de detalle de pago en tablas temporales
      -----------------------------------------------------
      insert pf_det_pago_tmp     
            (dt_operacion   , dt_usuario   ,	  dt_sesion,    
             dt_beneficiario, dt_tipo      ,	  dt_forma_pago,  
             dt_monto       , dt_porcentaje,	  dt_fecha_crea, 
             dt_fecha_mod   , dt_cuenta    ,	  dt_moneda_pago,
             dt_descripcion , dt_oficina,	  dt_tipo_cliente,
             --dt_secuencia   , dt_tipo_cuenta_ach, dt_banco_ach)
	     dt_secuencia   , dt_tipo_cuenta_ach, dt_cod_banco_ach, 
             dt_benef_chq)		--LIM 18/NOV/2005
     values (@i_operacionpf , @s_user      ,	@s_sesn,      
             @w_cod_clte    , @i_tipopago  ,	@i_formapago,  
             @i_monto       , @i_porcentaje,	@s_date,
             @s_date        , @i_cuentapro ,	@i_moneda_pago,
             @i_descripcion , isnull(@i_oficina,@s_ofi),	@i_tipo_cliente,
             @i_secuencia   , @i_tipo_cuenta_ach, @i_banco_ach,
             @i_benef_cheque)		

      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143037
         return 143037
      end

   commit tran
end

--------------------------------
-- Eliminacion de Beneficiarios
--------------------------------
If @i_operacion = 'D'
begin
   begin tran
      delete from pf_det_pago_tmp 
       where dt_usuario   = @s_user
         and dt_sesion    = @s_sesn
         and dt_operacion = @i_op_operacion
   commit tran
end         
return 0
go
