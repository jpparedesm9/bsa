/************************************************************************/
/*      Archivo:                actdatos.sp                             */
/*      Stored procedure:       sp_act_datos                            */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 24/Ago/2001                             */
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
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_act_datos')
   drop proc sp_act_datos 
go

create proc sp_act_datos 
(
		@s_ssn                  int 		= null,
		@s_user                 login 		= null,
		@s_sesn			int 		= null,
		@s_term                 varchar(30) 	= null,
		@s_date                 datetime 	= null,
		@s_srv                  varchar(30) 	= null,
		@s_lsrv                 varchar(30) 	= null,
		@s_ofi                  smallint 	= null,
		@s_rol                  smallint 	= NULL,
	        @i_fecha		datetime 	= null,        
	        @o_contador_proc	int      	= 0 output
)
with encryption
as

  declare 
    @w_sp_name 		varchar(32),
    @w_error 		int,
    @w_valor_nue 	descripcion,
    @w_valor_grte 	smallint,  --Act. campo en_oficial cambio Gerente
    @w_campo 		descripcion,
    @w_ente 		int,
    @w_fecha 		datetime,
    @w_op_operacion 	int,
    @w_op_fpago 	varchar(10),
    @w_op_retienimp 	char(1),
    @w_op_estado 	varchar(10),
    @w_op_int_estimado 	money,
    @w_total_monto 	money,
    @w_valor_distribuir money,    
    @w_tasa1 		float,
    @w_numdeci 		tinyint,
    @w_usadeci 		char(1),
    @w_numdeci_base 	tinyint,
    @w_usadeci_base 	char(1),
    @w_moneda 		smallint,    
    @w_max_sec 		int,            
    @w_cod_ret		char(4),	--NYM 25/Jul/2003
    @w_base_ica		money,		--NYM 25/Jul/2003
    @w_tasa_ica		money,		--NYM 25/Jul/2003
    @w_cod_ica  	char(10),	--NYM 25/Jul/2003
    @w_retefuente 	char(10),	--NYM 25/Jul/2003
    @w_reteica	 	char(10),	--NYM 25/Jul/2003
    @w_ofi		int,		--NYM 25/Jul/2003
    @w_contador_proc	int,
    @w_moneda_base 	smallint,    
    @w_fechai 		datetime,
    @w_fechaf 		datetime,
    @w_vlr_cuadre 	money,
    @w_historia 	int,
    @w_estado  		catalogo,
    @w_cuenta  		varchar(15), 
    @v_descripcion 	descripcion,    --ITO05102005
    @v_ced_ruc 		numero,             --ITO05102005
    @v_telefono 	descripcion,        --ITO06102005
    @w_secuencial       int


select @w_sp_name = 'sp_act_datos'
select @w_contador_proc = 0

select @w_fechai = convert(varchar(10),@i_fecha,101)+' 00:00AM'
select @w_fechaf = convert(varchar(10),@i_fecha,101)+' 11:59PM'

--I. CVA May-04-06 Obtener secuencial
exec @w_secuencial = sp_gen_sec 
     @i_inicio_fin = 'F'
--F. CVA May-04-06 Obtener secuencial

select @s_date = fp_fecha
from cobis..ba_fecha_proceso

select @s_ssn =  @w_secuencial

select 	@s_user = 'sa',
	@s_term = 'consola'

declare actualiza cursor for
	select  ac_ente, 
                ac_fecha, 
                ac_campo, 
                ac_valor_nue
	from	cobis..cl_actualiza
	where	ac_tabla in ('cl_ente','cl_telefono')
	and	ac_transaccion = 'U'
	and	ac_valor_nue is not null
	and	ac_fecha >= @w_fechai and ac_fecha <= @w_fechaf
	for read only

open actualiza
fetch actualiza into
	@w_ente,@w_fecha,@w_campo,@w_valor_nue

while (@@fetch_status <> -1 ) 
begin                                     
	if (@@fetch_status = -2)
	begin
		select @w_error = 703006
		print 'ERROR EN CURSOR'
		goto ERROR
	end

        begin tran

SIGUIENTE:


/*     COMENTADO - POSIBLE UTILIZACION LUEGO
        
	/* ACTUALIZACION CAMBIO DE GERENTE A LA OPERACION */
	/* Gap DP00039 20-Feb-2001 xca                    */
	if @w_campo = 'en_oficial'
	begin
		select @w_valor_grte = convert(smallint,@w_valor_nue)

		update pf_operacion
		set op_gerente = @w_valor_grte
		from pf_operacion
		where op_ente = @w_ente
		if @@error <> 0
		begin
			select @w_error = 145001
			goto ERROR
		end
		select @w_contador_proc=@w_contador_proc+isnull(count(*),0)
		from    pf_operacion 
		where   op_ente = @w_ente			
	end


    /* FIN ACTUALIZACION CAMBIO DE GERENTE A LA OPERACION */

*/

if @w_campo = 'te_valor'
begin	
        select @w_op_operacion = 0                      --ITO06102005

        while 1=1
        begin
	        select @w_cuenta = convert (varchar,@w_ente)
	
	        set rowcount 1
	           select @w_op_operacion = op_operacion,
	                  @v_telefono     = op_telefono
	           from pf_operacion
	           where  op_operacion > @w_op_operacion
	             and  op_ente      = @w_ente
	        if @@rowcount = 0
	        break
	
			update pf_operacion
			set op_telefono = @w_valor_nue
			from pf_operacion 
			where op_operacion = @w_op_operacion
			  and op_ente      = @w_ente		
			if @@error <> 0 
			begin
				select @w_error = 145001
				goto ERROR
			end
			
			select 	@w_contador_proc = @w_contador_proc+isnull(count(*),0)
			from    pf_operacion 
			where   op_ente      = @w_ente			
			
			
			/**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/        --ITO06102005      
		        insert ts_operacion (tipo_transaccion, secuencial,clase,operacion,fecha,usuario,terminal,srv, descripcion)
		        values (14201,@s_ssn,'P',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@v_telefono)
		
		        if @@error <> 0 
			begin
					select @w_error = 145001
					goto ERROR
			end
		
		        /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/      --ITO06102005
		
		       insert ts_operacion (tipo_transaccion,secuencial,clase,operacion,fecha,usuario,terminal,srv, descripcion)
		        values (14201,@s_ssn,'A',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@w_valor_nue)
		
		        if @@error <> 0 
			begin
					select @w_error = 145001
					goto ERROR
			end
        end       

end


if @w_campo = 'en_ced_ruc'
begin
        select @w_op_operacion = 0

        while 1=1
        begin
	        select @w_cuenta = convert (varchar,@w_ente)
	
	        set rowcount 1
	           select @w_op_operacion = op_operacion,
	                  @v_ced_ruc      = op_ced_ruc
	           from pf_operacion
	           where  op_operacion > @w_op_operacion
	             and  op_ente      = @w_ente
	
	        if @@rowcount = 0
	        	break

                update pf_operacion
		set op_ced_ruc = @w_valor_nue
		from pf_operacion 
		where op_operacion = @w_op_operacion
             	  and op_ente      = @w_ente		 
		if @@error <> 0 
		begin
			select @w_error = 145001
			goto ERROR
		end

		select @w_contador_proc=@w_contador_proc+isnull(count(*),0)
		from    pf_operacion 
		where   op_ente = @w_ente			
		
		/**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/        --ITO05102005	      
	        insert ts_operacion (tipo_transaccion, secuencial,clase,operacion,fecha,usuario,terminal,srv, ced_ruc)
	        values (14201,@s_ssn,'P',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@v_ced_ruc)	
	        if @@error <> 0 
		begin
			select @w_error = 145001
			goto ERROR
		end
	
	        /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/      --ITO05102005	
	        insert ts_operacion (tipo_transaccion,secuencial,clase,operacion,fecha,usuario,terminal,srv, ced_ruc)
	        values (14201,@s_ssn,'A',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@w_valor_nue)	
	        if @@error <> 0 
		begin
			select @w_error = 145001
			goto ERROR
		end
	end   
        
end

if @w_campo = 'en_nomlar'
begin
	select @w_op_operacion = 0

        while 1=1
        begin
	        select @w_cuenta = convert (varchar,@w_ente)
	
	        set rowcount 1
	        select @w_op_operacion = op_operacion,
	               @v_telefono  = op_telefono
	          from pf_operacion
	         where  op_operacion > @w_op_operacion
	           and  op_ente      = @w_ente
	        if @@rowcount = 0
	        	break

		update pf_operacion
		set op_descripcion = @w_valor_nue
		from pf_operacion 
		where op_ente      = @w_ente
             	  and op_operacion = @w_op_operacion
		if @@error <> 0
		begin
			select @w_error = 145001
			goto ERROR
		end
		
		select @w_contador_proc=@w_contador_proc+isnull(count(*),0)
		from    pf_operacion 
		where   op_ente = @w_ente		
		
		/**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/             --ITO05102005
	        insert ts_operacion (tipo_transaccion,secuencial,clase,operacion,fecha,usuario,terminal,srv, descripcion)
	        values (14201, @s_ssn,'P',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@v_telefono)	
	        if @@error <> 0 
		begin
			select @w_error = 145001
			goto ERROR
		end
	
	        /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/            --ITO05102005
	        insert ts_operacion (tipo_transaccion,secuencial,clase,operacion,fecha,usuario,terminal,srv, descripcion)
	        values (14201,@s_ssn, 'A',@w_op_operacion,@s_date,@s_user, @s_term, @s_srv,@w_valor_nue)	
	        if @@error <> 0 
		begin
			select @w_error = 145001
			goto ERROR
		end
	
	end      

end

	-- NYM 25-Jul-03

        commit tran

	select @w_contador_proc = @w_contador_proc + 1

	fetch actualiza into
		@w_ente,@w_fecha,@w_campo,@w_valor_nue
end

close actualiza
deallocate actualiza
select @o_contador_proc=@w_contador_proc 
return 0

ERROR:
	exec sp_errorlog 	@i_fecha 	= @w_fechai,                     
	                 	@i_error 	= @w_error, 
	                 	@i_usuario 	= 'PFIBATCH',
	                 	@i_tran		= 14900,
	                 	@i_cuenta	= @w_cuenta,
				@t_from  	= @w_sp_name,
				@i_num   	= @w_error,
				@i_descripcion	= 'ERROR proceso actualizacion clientes / plazo fijo'
				
	GOTO SIGUIENTE
          
go
