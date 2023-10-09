/************************************************************************/
/*	Archivo:		         consatx.sp        			                */
/*	Stored procedure:	   sp_consulta_atx                              */
/*	Base de datos:		   cob_cartera				                    */
/*	Producto: 		      Cartera					                    */
/*	Disenado por:  		Z.BEDON                 	                    */
/*	Fecha de escritura:	Ene. 1998 				                        */
/************************************************************************/
/*				               IMPORTANTE				                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA".							                                */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier alteracion o agregado hecho por alguno de sus	            */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				                 PROPOSITO				                */
/*	Ingreso de abonos                                                   */ 
/*	S: Seleccion de negociacion de abonos automaticos		            */
/*	Q: Consulta de negociacion de abonos automaticos		            */
/*	I: Insercion de abonos                                              */
/*	U: Actualizacion de negociacion de abonos automaticos		        */
/*	D: Eliminacion de negociacion de abonos automaticos		            */
/************************************************************************/
/*				                 MODIFICACIONES				            */
/*	FECHA		AUTOR		RAZON				                        */
/*	Enero 1998      Z.Bedon          Emision Inicial                    */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_consulta_atx')
	drop proc sp_consulta_atx
go

create proc sp_consulta_atx
       	@s_user			login 		= null,
       	@s_term			varchar(30) = null,
       	@s_date			datetime 	= null,
       	@s_sesn			int 		= null,
       	@s_ofi 			smallint 	= null,
        @t_debug        char(1) 	= 'N',
        @t_file         varchar(20)	= null,
        @t_corr         char(1)     = null,
       	@i_accion		char(1),
        @i_ced_ruc              numero 		= null,
        @i_banco                cuenta 		= null,
        @i_cod_cliente          int 		= null,
        @o_nom_cliente          varchar(64)	= null out,
        @o_monto                money  		= null out,
        @o_monto_max            money  		= null out,
        @o_moneda               tinyint 	= null out,
        @o_fecha_vig            varchar(20) = null out,
        @o_nombre_moneda        varchar(64) = null out,
        @o_tipo                 char(1) 	= null out,
        @o_valor_vencido        money       = null out
as
declare @w_sp_name		descripcion,
	@w_return		int,
	@w_fecha_hoy		datetime,
        @w_error                int,
        @w_producto             tinyint,
        @w_operacionca          int,
        @w_moneda_local         smallint,
        @w_estado               tinyint,
        @w_fecha_max            datetime

select	@w_sp_name = 'sp_consulta_atx',
        @w_fecha_hoy = convert(varchar,@s_date,101)

select @w_operacionca = op_operacion,
       @w_estado      = op_estado
from   ca_operacion
where  op_banco = @i_banco

if @w_estado = 3 and @t_corr <> 'S'      --@t_corr = 'S'  es para reversos, y aqui se valida que no se realicen pagos a op. canceladas
begin
   select @w_error = 708158
   goto ERROR
end


if @i_accion = 'Q' 
begin
   select @w_fecha_max = max(ct_fecha)
   from   cob_conta..cb_cotizacion

   select ct_moneda, ct_valor
   from   cob_conta..cb_cotizacion
   where  ct_fecha = @w_fecha_max
   set transaction isolation level read uncommitted


   if @i_banco is not null begin
      select 
      @o_nom_cliente    = vx_nombre,
      @o_monto          = vx_monto,
      @o_monto_max      = vx_monto_max,
      @o_moneda         = vx_moneda,
      @o_valor_vencido  = vx_valor_vencido
      from ca_valor_atx
      where vx_banco = @i_banco

       if @@rowcount = 0
       begin

          select 
          @o_nom_cliente    = op_nombre,
          @o_monto          = 0,
          @o_monto_max      = 0,
          @o_moneda         = op_moneda,
          @o_valor_vencido  = 0
          from  ca_operacion
          where op_banco = @i_banco
          ---select @w_error = 710524
          ---goto ERROR
       end

	select @w_producto = pd_producto
        from cobis..cl_producto
	where pd_abreviatura = 'CCA'
	set transaction isolation level read uncommitted

	select  @o_fecha_vig = convert(varchar(10),fc_fecha_cierre,101)
	from cobis..ba_fecha_cierre
	where fc_producto = @w_producto


      select @o_nombre_moneda = mo_descripcion
      from cobis..cl_moneda
      where mo_moneda = @o_moneda


      select @o_nombre_moneda = mo_descripcion      
      from cobis..cl_moneda
      where mo_moneda = @o_moneda


      select @o_tipo = op_tipo
      from ca_operacion
      where op_banco = @i_banco
   end
end

if @i_accion = 'A' begin

   if @i_ced_ruc is null

      select @i_ced_ruc = en_ced_ruc
      from cobis..cl_ente
      where en_ente = @i_cod_cliente
      set transaction isolation level read uncommitted

   select @o_nom_cliente = vx_nombre
   from ca_valor_atx
   where vx_ced_ruc = @i_ced_ruc

   if @@rowcount = 0 begin
      select @w_error = 701025
      goto ERROR
   end  

   select 
   'OPERACION'         = vx_banco,
   'MONEDA'            = vx_moneda,           -- SIEMPRE EN PESOSvx_moneda, 
   'MONTO VENCIDO'     = vx_valor_vencido,
   'MONTO PAGO'        = vx_monto,  ----Incluye lo vencido
   'MONTO CANCELACION' = vx_monto_max
   
   from ca_valor_atx
   where vx_ced_ruc = @i_ced_ruc
    and   vx_monto_max  > 0

   if @@rowcount = 0 begin
      select @w_error = 701025
      goto ERROR
   end 
end

return 0

ERROR:
   exec cobis..sp_cerror
   @t_debug = 'N',    
   @t_file  = null,
   @t_from  = @w_sp_name,   
   @i_num   = @w_error
   return @w_error

go
