/************************************************************************/
/*      Archivo:                deceval.sp                              */
/*      Stored procedure:       sp_deceval		                */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
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
/*      Establece si un titulo esta en deceval			        */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR               RAZON                          */
/*      07/07/2009  Ericak Rodriguez   Emision Inicial                  */
/************************************************************************/ 
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_deceval') IS  NOT NULL
   drop proc sp_deceval
go

create proc sp_deceval (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL, 
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_operacion            char(1),
@i_num_banco            cuenta          = NULL,
@i_isin                 varchar(20)     = NULL,
@i_fungible             varchar(12)     = NULL)
with encryption
as
declare
@w_sp_name  	        varchar(32),
@w_embargo  	        money,
@w_historia	            int,
@w_estado	            varchar(10),
@w_operacionpf	        int,
@w_monto	            money,
@w_observacion	        varchar(50)

select @w_sp_name = 'sp_deceval'
     
/**  VERIFICAR CODIGO DE TRANSACCION  **/
if ( @i_operacion <> 'U' or @t_trn <> 14769)
begin
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141040
     return 1
end

if @i_operacion = 'U'
begin
	select 	@w_embargo 	= isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0), 
       		@w_operacionpf 	= op_operacion,
       		@w_historia	= op_historia,
       		@w_estado	= op_estado,
       		@w_monto	= op_monto
       	from 	cob_pfijo..pf_operacion
      	where 	op_num_banco = @i_num_banco

	if @w_embargo > 0 
	begin
		exec cobis..sp_cerror 
			@t_from  = @w_sp_name, 
			@i_num   = 141200
	   	return 1
	end

     	begin tran

     
     	update 	cob_pfijo..pf_operacion
     	set  	op_fungible 	= @i_fungible,
     		op_isin		= @i_isin,
     		op_historia 	= op_historia + 1
     	where  	op_num_banco = @i_num_banco

     	if @@rowcount = 0   
     	begin
		exec cobis..sp_cerror
               		@t_debug = @t_debug,
               		@t_file  = @t_file,
               		@t_from  = @w_sp_name,
               		@i_num   = 145048
          	return 1
     	end 

	if exists(select 1 from pf_det_envios_dcv where de_operacion = @w_operacionpf) 
	begin
           update pf_det_envios_dcv 
           set de_estado = 'A', 
               de_isin  =  @i_isin
           where de_operacion = @w_operacionpf
	end


if @t_debug = 'S' print '@i_num_banco ' + cast(@i_num_banco as varchar)
if @t_debug = 'S' print '@i_fungible ' + cast(@i_fungible as varchar)

	select @w_observacion = 'FUNGIBLE : ' + @i_fungible + ' ' + @i_isin
      	
      	----------------------------------------
      	-- Insercion de transaccion de servicio
      	----------------------------------------
      	insert ts_operacion 
      			(secuencial, 	tipo_transaccion, 	clase, 		usuario,
			terminal, 	srv, 			lsrv, 		fecha,
                        num_banco, 	operacion,  		historia, 	estado,
                        fecha_mod, 	imprime,		descripcion)
	values 		(@s_ssn, 	@t_trn, 		'A', 		@s_user,
                        @s_term, 	@s_srv, 		@s_lsrv, 	@s_date,
                        @i_num_banco, 	@w_operacionpf, 	@w_historia, 	@w_estado,
                        @s_date, 	'S',			@w_observacion)

	if @@error <> 0
      	begin
    		exec cobis..sp_cerror 
    			@t_debug=@t_debug,
    			@t_file=@t_file,
       			@t_from=@w_sp_name,   
       			@i_num = 143005
    		return 143005
	end


      	insert pf_historia (hi_operacion  , hi_secuencial , hi_fecha      , hi_trn_code,
                          hi_valor      , hi_funcionario, hi_oficina    , hi_observacion,
                          hi_fecha_crea , hi_fecha_mod)
                  values (@w_operacionpf, @w_historia   , @s_date       , @t_trn,
                          @w_monto      , @s_user       , @s_ofi        , @w_observacion,
                          @s_date       , @s_date)

      	if @@error <> 0
      	begin
         	exec cobis..sp_cerror 
         		@t_debug=@t_debug,
         		@t_file=@t_file,
              		@t_from=@w_sp_name,   
              		@i_num = 143006
    		return 143006
      	end

     	commit tran
end



return 0
go

