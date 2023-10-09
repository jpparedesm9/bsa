/************************************************************************/
/*      Archivo:		embargo_cap.sp                          */
/*      Stored procedure:	sp_embargo_cap  	                */
/*      Base de datos:		cob_pfijo                               */
/*      Producto:		Plazo_fijo                              */
/*      Disenado por:           Mario Andres Algarin 			*/
/*      Fecha de documentacion: 05/Dic/2009                             */
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
/*	Este programa permite generar las ordenes de pago, y la         */
/*	Cancelacion de capital a los diferentes entes legales,          */
/*	que hagan parte de un titulo embargado, que se encuentre 	*/
/*      vencido o proximo a vecerse la fecha proceso.	  		*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      	AUTOR                RAZON                      */
/*      05/Dic/2009	Mario Algarin	     Emision Inical	        */
/*									*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_embargo_cap')
   drop proc sp_embargo_cap
go

create proc sp_embargo_cap (
   @s_ssn                   int         = NULL,
   @s_ssn_branch            int         = NULL,
   @s_user                  login       = NULL,
   @s_sesn                  int         = NULL,
   @s_term                  varchar(30) = NULL,
   @s_date                  datetime    = NULL,
   @s_srv                   varchar(30) = NULL,
   @s_lsrv                  varchar(30) = NULL,
   @s_ofi                   smallint    = NULL,
   @s_rol                   smallint    = NULL,
   @s_org                   char(1)     = null,  
   @t_debug                 char(1)     = 'N',
   @t_file                  varchar(10) = NULL,
   @t_from                  varchar(32) = NULL,
   @i_fecha_proceso 	    datetime 
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_error                int,
        @w_ofi_dest		int,
        @w_ofi_ant              int,
        @w_user			login,
        @w_operacion   		int,
        @w_toperacion_ant 	catalogo,
        @w_moneda               tinyint, 
        @w_tplazo_ant           catalogo, 
        @w_estado               catalogo, 
        @w_monto                money,
        @w_op_monto_pgdo        money,
        @w_producto             tinyint, 
        @w_num_banco            cuenta,
        @w_toperacion		catalogo,
	@w_fecha_ven            datetime,
	@w_accion_sgt		catalogo,
	@w_oficina		smallint,  
        @w_pignorado            char(1),
	@w_plazo_orig           int,  
        @w_bl_secuencial        int,
        @w_valor		money,
        @w_beneficiario		int,
        @w_tipo_cliente         char(1),
        @w_cod_clte             int,
        @w_monto_disp           money,
        @w_ente                 int,
        @w_monto_blqlegal       money,
        @w_autoridad            varchar(255),
	@w_inicia_transac	int,
        @w_nombre		varchar(255),
        @w_pg_juz           	catalogo,
	@w_paramvxp		catalogo



                           
---------------------------------------
----| Inicializacion de Variables |----
---------------------------------------
select 	@w_sp_name     		= 'sp_embargo_cap',
	@w_inicia_transac 	= 1

--CAPTURA DE PARAMETRO DE FORMA DE PAGO DE INTERESES A JUZGADOS 
select @w_pg_juz = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'FPITE'

select  @w_paramvxp = pa_char
from 	cobis..cl_parametro
where 	pa_nemonico = 'NVXP'
and		pa_producto = 'PFI'

	
exec @s_ssn = ADMIN...rp_ssn

declare cursor_operacion cursor
for 	select 	op_operacion, op_num_banco, op_producto   , op_fecha_ven,
           	op_estado   , op_oficial  , isnull(op_accion_sgte,'NULL'), op_tipo_plazo,
           	op_oficina  , op_moneda   , op_toperacion , op_pignorado, 
           	op_monto_pgdo,op_plazo_orig, op_oficina, op_monto, op_ente, op_monto_blqlegal
      from 	pf_operacion
     where  	datediff(dd, op_fecha_ven, @i_fecha_proceso) >= 0 
	and 	op_estado 	  in( 'ACT','VEN')
	and 	op_monto_blqlegal > 0
        and     op_bloqueo_legal  = 'S'

open cursor_operacion
fetch 	cursor_operacion into 
           @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
           @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant, 
           @w_ofi_ant  , @w_moneda, @w_toperacion_ant, @w_pignorado,
           @w_op_monto_pgdo, @w_plazo_orig, @w_oficina, @w_monto, @w_ente, @w_monto_blqlegal

while @@fetch_status = 0
begin

	if @t_debug = 'S' print ' @w_operacion ' +  cast(@w_operacion as varchar)


   	select 	@w_bl_secuencial = 0,
          	@w_monto_disp = isnull(@w_monto,0)


	while (1=1)
	begin

		if @w_inicia_transac = 1
		begin 
			begin tran
			select @w_inicia_transac = 0
		end

		set rowcount 1

		if @t_debug = 'S' print ' @w_operacion ' +  cast(@w_operacion as varchar)
		if @t_debug = 'S' print ' @w_bl_secuencial ' +  cast(@w_bl_secuencial as varchar)

		select	@w_bl_secuencial  = bl_secuencial,
                	@w_valor 	  = isnull(bl_valor_embgdo_banco,0),
                	@w_autoridad      = bl_autoridad,
                	@w_ofi_dest       = bl_oficina
		from 	pf_bloqueo_legal  
		where 	bl_operacion = @w_operacion
        	and     bl_estado = 'I'
		and	bl_valor_embgdo_banco > 0
		and	bl_secuencial > @w_bl_secuencial  
        	order by bl_operacion , bl_secuencial 

   		if @@rowcount = 0 
			break

		select @w_monto_disp = @w_monto_disp - @w_valor

		if @t_debug = 'S' print ' new @w_bl_secuencial ' +  cast(@w_bl_secuencial as varchar)


   		/* Carga de Codigo Externo */
                                                                                                                                                                                                    
   		exec @w_error = cobis..sp_cseqnos                                                                                                                                                                                                                   
   			@i_tabla = 'pf_cliente_externo',                                                                                                                                                                                                                      
   			@o_siguiente = @w_cod_clte out
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
   		if @w_error <> 0 goto ERROR
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
   		select @w_cod_clte = isnull(@w_cod_clte, 1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
   		insert into pf_cliente_externo (ce_secuencial, ce_nombre, ce_cedula, ce_direccion)
   			values (@w_cod_clte, @w_autoridad,'','*JUZ*')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

   		if @@error <> 0 
   		begin
      			select @w_error = 143055
      			goto ERROR
   		end





    		exec 	@w_error = sp_mov_monet_tmp
      		@s_ssn 		= @s_ssn,
      		@s_user 	= 'sa',
      		@s_term 	= 'batch',
      		@s_date 	= @i_fecha_proceso,
      		@s_srv 		= @s_srv,
      		@s_lsrv 	= @s_lsrv,
      		@s_rol 		= @s_rol,
      		@s_ofi 		= @w_ofi_dest,
      		@s_sesn 	= @s_ssn,         
      		@t_trn 		= 14127,
      		@t_debug 	= 'N',
      		@i_operacion 	= 'I',
      		@i_valor 	= @w_valor,
      		@i_valor_ext 	= @w_valor,
      		@i_producto 	= @w_pg_juz,
      		@i_num_banco 	= @w_num_banco,
      		@i_sub_secuencia= @w_bl_secuencial,
      		@i_tipo 	= 'C',
      		@i_beneficiario = @w_cod_clte,
                @i_benef_corresp = @w_autoridad,
                @i_tipo_cliente = 'E',
      		@i_cotizacion 	= 1,
      		@i_moneda 	= @w_moneda

    		if @w_error <> 0     
    		begin
      			select @w_error = 143022
	        	goto ERROR
    		end
	

    /*       /* Actualizacion del estado del Embargo */  /*OJO TENER EN CUENTAESTLE BLOQUE*/
		update pf_bloqueo_legal
                   set bl_estado = 'C'
		where bl_operacion = @w_operacion
		  and bl_secuencial = @w_bl_secuencial

   		if @@error <> 0 
   		begin
      			select @w_error = 141239
      			goto ERROR
   		end   
    */
	end  /*while 1=1*/

	set rowcount 0

	--Se Crea Valor por pagar Con el Sobrante --
	if @w_monto_disp > 0
	begin

		select @w_nombre =  en_nomlar
		from cobis..cl_ente	
		where en_ente = @w_ente	

		if @@rowcount = 0
   		begin
      			select @w_error = 141044
      			goto ERROR
   		end  

		select @w_bl_secuencial = @w_bl_secuencial + 1


    		exec 	@w_error = sp_mov_monet_tmp
      		@s_ssn 		= @s_ssn,
      		@s_user 	= 'sa',
      		@s_term 	= 'batch',
      		@s_date 	= @i_fecha_proceso,
      		@s_srv 		= @s_srv,
      		@s_lsrv 	= @s_lsrv,
      		@s_rol 		= @s_rol,
      		@s_ofi 		= @w_oficina,
      		@s_sesn 	= @s_ssn,         
      		@t_trn 		= 14127,
      		@t_debug 	= 'N',
      		@i_operacion 	= 'I',
      		@i_valor 	= @w_monto_disp,
      		@i_valor_ext 	= @w_monto_disp,
      		@i_producto 	= @w_paramvxp,
      		@i_num_banco 	= @w_num_banco,
      		@i_sub_secuencia= @w_bl_secuencial,
      		@i_tipo 	= 'C',
      		@i_beneficiario = @w_ente,
                @i_benef_corresp = @w_nombre,
                @i_tipo_cliente = 'M',
      		@i_cotizacion 	= 1,
      		@i_moneda 	= @w_moneda

    		if @w_error <> 0     
    		begin
      			select @w_error = 143022
	        	goto ERROR

    		end

	 end

if @t_debug = 'S' print 'CANCELA @i_fecha_proceso,' +  cast(@i_fecha_proceso as varchar)


	exec 	@w_error = sp_cancela
      		@s_ssn 		= @s_ssn,
      		@s_user 	= 'sa',
      		@s_term 	= 'batch',
      		@s_date 	= @i_fecha_proceso,
      		@s_srv 		= @s_srv,
      		@s_lsrv 	= @s_lsrv,
      		@s_rol 		= @s_rol,
      		@s_ofi 		= @w_oficina,
      		@s_sesn 	= @s_ssn,         
      		@t_debug 	= 'N',
		@t_trn		= 14903,
		@i_operacion    = 'N',      
		@i_num_banco	= @w_num_banco,
		@i_solicitante  = @w_ente

    	if @w_error <> 0     
    	begin
      		select @w_error = 149016
	        goto ERROR
    	end

if @t_debug = 'S' print 'CANCELA FIN @i_fecha_proceso,' +  cast(@i_fecha_proceso as varchar)


	commit tran

	select 	@w_inicia_transac = 1

	SIGUIENTES:
	fetch 	cursor_operacion into 
           @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
           @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant, 
           @w_ofi_ant  , @w_moneda, @w_toperacion_ant, @w_pignorado,
           @w_op_monto_pgdo, @w_plazo_orig, @w_oficina, @w_monto, @w_ente, @w_monto_blqlegal

end /*while cursor*/


if @@fetch_status = -2
begin
  select @w_error = 200001
  GOTO ERROR_CURSOR
end

return 0


ERROR:
rollback tran
      /*Se almancena el Error*/
     exec sp_errorlog @i_fecha   = @i_fecha_proceso,
                      @i_error   = @w_error,
                      @i_usuario = 'sa',
                      @i_tran    = 14905,
                      @i_descripcion = 'sp_embargo_cap',
                      @i_cuenta  = @w_num_banco


select @w_inicia_transac = 1
GOTO SIGUIENTES


ERROR_CURSOR:
close cursor_operacion
deallocate cursor_operacion
       /*Se almancena el Error*/
     exec sp_errorlog @i_fecha   = @i_fecha_proceso,
                      @i_error   = @w_error,
                      @i_usuario = 'sa',
                      @i_tran    = 14905,
                      @i_descripcion = 'sp_embargo_cap',
                      @i_cuenta  = @w_num_banco

return @w_error
go