/************************************************************************/
/*      Archivo:                Consvc.sp                               */
/*      Stored procedure:       sp_consulta_valor_cancela               */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 17/Oct/2001                             */
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
/*      Este procedimiento almacenado realiza la actualizacion de datos */
/*      de clientes en Plazo Fijo cuando se han modificado.             */
/*                                                                      */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_valor_cancela')
   drop proc sp_consulta_valor_cancela 
go

create proc sp_consulta_valor_cancela (
@s_ssn                  int = null,
@s_user                 login = null,
@s_sesn					int = null,
@s_term                 varchar(30) = null,
@s_date                 datetime = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint = null,
@s_rol                  smallint = NULL,
@t_debug                char(1) = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint,
@i_tipo                	char(1) = 'D', -- C-Cupon, D-Deposito
@i_num_banco		    cuenta,	 -- Numero de deposito
@i_valor		        money,   -- Monto a cancelar por usuario
@i_moneda               tinyint,
@o_respuesta		    char(1) output)
with encryption
as
declare         
	@w_sp_name              varchar(32),
  @w_secuencial           int,
	@w_operacionpf          int,
	/***** Variables para depositos *****/
	@w_estado 	        varchar(3),
	@w_pignorado 		char(1),
	@w_retenido	        char(1),
	@w_custodia		char(1),
	@w_monto_cup		money,
	@w_monto_sincup	        money,
	@w_impuesto		money,
	@w_retieneimp		char(1),
	@w_con_cupon		char(1),
	@w_fpago	        catalogo,
  @w_moneda               tinyint,
  @w_ddif_fechas					int,
  @w_fecha_ven            datetime
    
select @w_sp_name = 'sp_consulta_valor_cancela',
       @w_secuencial = @s_ssn

if @t_trn <> 14815 
begin
   exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 141112
   /*  'Error en codigo de transaccion' */
   return 1
end

if @s_ssn is null
begin
  exec @w_secuencial=sp_gen_sec 
  select @s_ssn = @w_secuencial
end 

/**********************************************
*** COMIENZA LA TRANSACCION PARA VERIFICAR  ***
*** DATOS DEL DEPOSITO.                     ***
***********************************************/
select @o_respuesta = 'N'

if @i_tipo = 'D'
begin
   select @w_estado  = op_estado, 
   @w_pignorado = op_pignorado, 
   @w_retenido = op_retenido, 
   @w_custodia = isnull(op_custodia,'N'), 
   @w_monto_sincup = op_monto + isnull(op_total_int_ganados,0) 
         - isnull(op_total_int_pagados,0),
   @w_monto_cup = op_monto, 
   @w_impuesto = isnull(op_impuesto, 0),
   @w_retieneimp = op_retienimp, 
   @w_con_cupon = isnull(op_cupon, 'N'),
   @w_fpago = op_fpago,
   @w_moneda = op_moneda,
   @w_fecha_ven = op_fecha_ven
   from pf_operacion
   where op_num_banco = @i_num_banco
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror 
      @t_debug = @t_debug, 
      @t_file  = @t_file,
      @t_from  = @w_sp_name, 
      @i_num   = 141004
      return 1
   end 
           
   select @w_ddif_fechas = datediff(dd, @s_date, @w_fecha_ven)

   if @w_moneda <> @i_moneda
   begin
      select @o_respuesta = 'N'
      return 0
   end  
   
   if @w_retieneimp = 'S'
      select @w_monto_sincup = @w_monto_sincup - 
       (@w_monto_cup * (@w_impuesto / 100))

   if @w_con_cupon <> 'S' and @w_fpago = 'VEN'
   begin
      if (@w_estado = 'VEN' or (@w_estado = 'ACT' and @w_ddif_fechas = 0))
        and @w_pignorado = 'N' 
        and @w_retenido = 'N' and @w_custodia = 'N' 
        and @w_monto_sincup = @i_valor 
      begin
         select @o_respuesta = 'S'
      end
   end
 
   if @w_con_cupon = 'S' and @w_fpago = 'VEN'	
   begin
      if (@w_estado = 'VEN' or (@w_estado = 'ACT' and @w_ddif_fechas = 0))
       and @w_pignorado = 'N' and @w_retenido = 'N' 
       and @w_custodia = 'N' and @w_monto_cup = @i_valor
      begin
         select @o_respuesta = 'S'
      end
   end

   if @w_fpago = 'PER'	
   begin
      if (@w_estado = 'VEN' or (@w_estado = 'ACT' and @w_ddif_fechas = 0))
        and @w_pignorado = 'N' 
        and @w_retenido = 'N' and @w_custodia = 'N' 
        and @w_monto_cup = @i_valor
      begin
         select @o_respuesta = 'S'
      end
   end
end

if @i_tipo = 'C'
begin
   select @o_respuesta = 'N'

   select @w_estado = cu_estado,  
   @w_retenido = cu_retenido, @w_custodia = cu_custodia, 
   @w_monto_sincup = cu_valor_neto,
   @w_monto_cup = cu_valor_neto,
   @w_moneda = op_moneda
   from pf_cuotas, pf_operacion
   where cu_num_cupon = @i_num_banco
   and cu_operacion = op_operacion
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror 
      @t_debug = @t_debug, 
      @t_file  = @t_file,
      @t_from  = @w_sp_name, 
      @i_num   = 141161
      return 1
   end 

   if @w_moneda <> @i_moneda
   begin
      select @o_respuesta = 'N'
      return 0
   end

   if @w_estado = 'VEN' and @w_retenido = 'N' 
   and @w_custodia = 'N' and @w_monto_sincup = @i_valor 
   begin
      select @o_respuesta = 'S'
   end
end
--commit tran  
/**************** fin de la transaccion *****************/
return 0
go
