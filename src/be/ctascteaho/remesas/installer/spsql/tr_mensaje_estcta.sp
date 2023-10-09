/************************************************************************/
/*  Archivo:            tr_mensaje_estcta.sp                            */
/*  Stored procedure:   sp_tr_mensaje_estcta                            */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR           RAZON                                */
/*  23/Junio/2016  Walther Toledo  Ajuste para aplicar a cuentas CTE    */
/************************************************************************/

use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_mensaje_estcta')
  drop proc sp_tr_mensaje_estcta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc [sp_tr_mensaje_estcta] (
        @s_ssn                int,
        @s_srv		      varchar(30),
        @s_lsrv		      varchar(30),
        @s_user               varchar(30),
        @s_sesn               int,
        @s_term               varchar(10),
        @s_date               datetime,
        @s_ofi                smallint,  /* Localidad origen transaccion */
        @s_rol                smallint = 1,
        @s_org_err            char(1)  = null,  /* Origen de error: [A], [S] */
        @s_error              int      = null,
        @s_sev                tinyint  = null,
        @s_msg                mensaje  = null,
        @s_org                char(1),
	@t_trn		      smallint,
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(32) = null,
	@i_oper		      char(1),
	@i_ofi		      smallint = NULL,
	@i_fecha              smalldatetime,
	@i_linea1	      varchar(80),
	@i_linea2	      varchar(80),
	@i_linea3	      varchar(80),
	@i_linea4	      varchar(80),
	@i_linea5	      varchar(80),
	@i_linea6	      varchar(80),
	@i_prodban	      smallint,
	@i_tipo		      smallint,
	@i_fecha_fin	      smalldatetime=NULL,
	@i_fecha_ini_ant      smalldatetime=null,
	@i_fecha_fin_ant      smalldatetime=null,
        @i_formato_fecha      int=101,
        @i_producto     INT = 3

)
as
declare	@w_return	      int,
	@w_sp_name	      varchar(30),
	@w_rpc		      descripcion,
	@w_filial	      tinyint,
	@w_oficina	      smallint,
	@w_producto	      tinyint,
	@w_fecha	      datetime,
	@w_srv_rem	      descripcion,
	@w_srv_local	      descripcion,
	@w_tipo		      char(1),
	@w_mensaje	      cuenta,
	@w_bandera1	      tinyint,
	@w_bandera2	      TINYINT,
	@w_nom_producto	      VARCHAR(20)

/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_tr_mensaje_estcta'

	if @t_debug = 'S'
	begin
		exec cobis..sp_begin_debug @t_file=@t_file
		select	'/**  Stored Procedure  **/ ' = @w_sp_name,
			t_debug 	= @t_debug,
		        t_file          = @t_file,
			t_from		= @t_from,
			i_oper		= @i_oper,
			i_ofi		= @i_ofi,
			i_fecha		= @i_fecha,
			i_linea1	= @i_linea1,
			i_linea2	= @i_linea2,
			i_linea3	= @i_linea3,
			i_linea4	= @i_linea4,
			i_linea5	= @i_linea5,
			i_linea6	= @i_linea6,
		        i_prodban 	= @i_prodban

		exec cobis..sp_end_debug
	end



begin tran
/*  Operaciones para una oficina especifica  */
if @i_tipo = 0
BEGIN
   -- 23/Junio/2016 - WTO - INI
   IF(@i_producto = 3)
   BEGIN
       select @w_nom_producto = 'CUENTA CORRIENTE'   
   END   
   else
   BEGIN
    select @w_nom_producto = 'CUENTA DE AHORROS'
   END
   -- 23/Junio/2016 - WTO - FIN
   
   -- PRINT @w_nom_producto
	/*  Captura de parametros de la oficina  */
	exec @w_return = cobis..sp_parametros 
				@t_debug	= @t_debug,
				@t_file	        = @t_file,
				@t_from	        = @w_sp_name,
				@s_lsrv		= @s_lsrv,
	            --            @i_nom_producto = 'CUENTA CORRIENTE',
                @i_nom_producto =  @w_nom_producto,
				@o_filial 	= @w_filial out, 
				@o_oficina 	= @w_oficina out,
				@o_producto 	= @w_producto out,
				@o_server_local	= @w_srv_local
   --	PRINT @w_return
	if @w_return <> 0
		return @w_return

	if @t_trn <> 99
	begin
	        /*  Error en codigo de transaccion  */
	        exec cobis..sp_cerror
	                @t_debug= @t_debug,
	                @t_file = @t_file,
	                @t_from = @t_from,
	                @i_num  = 201048
	        return 1
	end

	if @i_oper = 'C'
	 begin

		   set rowcount 20
		   select 'SUCURSAL'= me_oficina,
		          'LINEA 1' = me_linea1,
	        	  'LINEA 2' = me_linea2,
		          'LINEA 3' = me_linea3,
		          'LINEA 4' = me_linea4,
		          'LINEA 5' = me_linea5,
		          'LINEA 6' = me_linea6,
			      'FECHA INICIO'=convert(varchar(10),me_fecha,@i_formato_fecha),
			      'FECHA FIN'=convert(varchar(10),me_fecha_fin,@i_formato_fecha)
         	   from cob_remesas..cc_mensaje_estcta
	    	   where me_fecha >= convert (smalldatetime, @i_fecha)
			/*where datepart(mm, me_fecha) = datepart(mm, @i_fecha)*/
			and me_fecha_fin <= convert (smalldatetime, @i_fecha_fin)
		      	and (me_prodban = @i_prodban)
			and me_oficina > @i_ofi
  	           
	           order by me_oficina
   	           set rowcount 0
	 end
	 
	 if @i_oper='I'
	 begin
              
	      select @w_bandera1=0
	      select @w_bandera2=0
    

              if exists (select 1 from cob_remesas..cc_mensaje_estcta
			   where @i_fecha_fin between me_fecha and me_fecha_fin
			   and me_oficina=@i_ofi and me_prodban=@i_prodban)
		 select @w_bandera1=1
			    
	      if exists (select 1 from cob_remesas..cc_mensaje_estcta
        		   where @i_fecha between me_fecha and me_fecha_fin
			   and me_oficina=@i_ofi and me_prodban=@i_prodban)
                 select @w_bandera2=1
	      
              if @w_bandera1=1 or @w_bandera2=1
		begin
		   --print 'badera 1 %1!',@w_bandera1
		   --print 'bandera2 %1!',@w_bandera2
                   /* El mensaje ya estﬂ definido para el rango de fechas */
	           exec cobis..sp_cerror
		   @t_debug= @t_debug,
	           @t_file = @t_file,
	           @t_from = @t_from,
	           @i_num       = 201271
	           
                   return 201271
                end
 	     
	      insert into cob_remesas..cc_mensaje_estcta
	             values (@i_fecha /*@w_fecha*/, @i_prodban, @i_ofi, @i_linea1,
	                     @i_linea2, @i_linea3, @i_linea4,@i_linea5,@i_linea6,@i_fecha_fin)
	
	      if @@error <> 0
	       begin
	        exec cobis..sp_cerror
	             @t_debug= @t_debug,
	             @t_file = @t_file,
	             @t_from = @t_from,
	             @i_num  = 203040
	        return 1
	       end
	   end
	if @i_oper = 'E'
	   begin

	   	delete from cob_remesas..cc_mensaje_estcta
		        where me_fecha = @i_fecha
				/*where datepart(mm, me_fecha) = datepart(mm, @i_fecha)*/
			and me_fecha_fin = @i_fecha_fin
			and me_prodban = @i_prodban
			and me_oficina = @i_ofi
		   if @@error <> 0
		      begin
		      	/* Error al eliminar mensaje de estados de cuenta */
		       	exec cobis..sp_cerror
		       		@t_debug     = @t_debug,
				@t_file      = @t_file,
		        	@t_from      = @w_sp_name,
		       		@i_num       = 207015
		        return 1
	              end
	  end
	  if @i_oper ='U'
	  begin
             if exists (select 1 from cc_mensaje_estcta where 
                       me_fecha=@i_fecha_ini_ant 
                       and me_fecha_fin=@i_fecha_fin_ant
                       and me_prodban=@i_prodban
                       and me_oficina=@i_ofi)
             begin
	     update cob_remesas..cc_mensaje_estcta
	         set me_fecha =@i_fecha,
		     me_linea1 = @i_linea1,
		     me_linea2 = @i_linea2,
	             me_linea3 = @i_linea3,
	             me_linea4 = @i_linea4,
	             me_linea5 = @i_linea5,
	             me_linea6 = @i_linea6,
		     me_fecha_fin=@i_fecha_fin	
	             where
                     me_prodban = @i_prodban
		     and me_oficina = @i_ofi
                     and me_fecha=@i_fecha_ini_ant
                     and me_fecha_fin=@i_fecha_fin_ant
		
                
	      if @@error <> 0
	       begin
	        exec cobis..sp_cerror
	             @t_debug= @t_debug,
	             @t_file = @t_file,
	             @t_from = @t_from,
	             @i_num  = 205033
	        return 1
	       end 		
               end
               else
               begin
                  select @w_bandera1=0
	          select @w_bandera2=0
              

                  if exists (select 1 from cob_remesas..cc_mensaje_estcta
			   where @i_fecha_fin between me_fecha and me_fecha_fin
			   and me_oficina=@i_ofi and me_prodban=@i_prodban)
		      select @w_bandera1=1
			    
	          if exists (select 1 from cob_remesas..cc_mensaje_estcta
        		   where @i_fecha between me_fecha and me_fecha_fin
			   and me_oficina=@i_ofi and me_prodban=@i_prodban)
                     select @w_bandera2=1
	      
                  if @w_bandera1=1 or @w_bandera2=1
		  begin
		   --print 'badera 1 %1!',@w_bandera1
		   --print 'bandera2 %1!',@w_bandera2
     /* El mensaje ya estﬂ definido para el rango de fechas */
	              exec cobis..sp_cerror
		      @t_debug= @t_debug,
	              @t_file = @t_file,
	              @t_from = @t_from,
	              @i_num       = 201271
	           
                      return 201271
                   end
 	     
	         insert into cob_remesas..cc_mensaje_estcta
	             values (@i_fecha /*@w_fecha*/, @i_prodban, @i_ofi, @i_linea1,
	                     @i_linea2, @i_linea3, @i_linea4,@i_linea5,@i_linea6,@i_fecha_fin)
	
	         if @@error <> 0
	         begin
	            exec cobis..sp_cerror
	             @t_debug= @t_debug,
	             @t_file = @t_file,
	             @t_from = @t_from,
	             @i_num  = 203040
	          return 1
	          end
               
               end
	  end

end
else
begin

if @i_oper = 'I'
begin

   declare curofi cursor
   for select 
       of_oficina
       from cobis..cl_oficina
       for read only 
	
	open curofi
	fetch curofi into
		@w_oficina


	if  @@fetch_status = -2
	begin
	     close curofi
	     deallocate curofi
	     exec cobis..sp_cerror
	         @i_num       = 201157
	   --select @o_procesadas = @w_contador
	     return 201157
	end
	else
	if @@fetch_status = -1
	begin
	     close curofi
	     deallocate curofi
	   --select @o_procesadas = @w_contador
	     return 0
	end


	while @@fetch_status = 0
	begin 	

                select @w_mensaje = convert(varchar(5), @w_oficina)
		
		select @w_bandera1=0
		select @w_bandera2=0

		if exists (select 1 from cob_remesas..cc_mensaje_estcta
			   where @i_fecha_fin between me_fecha and me_fecha_fin)
		   select @w_bandera1=1
			    
		if exists (select 1 from cob_remesas..cc_mensaje_estcta
        		   where @i_fecha between me_fecha and me_fecha_fin)
                   select @w_bandera2=1

		if @w_bandera1=1 or @w_bandera2=1
		begin
                   /* El mensaje ya estﬂ definido para el rango de fechas */
	           exec cobis..sp_cerror
	       	   @i_num       = 201271
	           /* Cerrar y liberar cursor */
                   close curofi
                   deallocate curofi
            	   return 201271
                end



		if exists (select 1 from cob_remesas..cc_mensaje_estcta
		           where me_fecha = @i_fecha
				/*where datepart(mm, me_fecha) = datepart(mm, @i_fecha)*/
		             and me_prodban = @i_prodban
			     and me_oficina = @w_oficina)




		begin
		  	update cob_remesas..cc_mensaje_estcta
		           set me_linea1 = @i_linea1,
		               me_linea2 = @i_linea2,
		               me_linea3 = @i_linea3,
		               me_linea4 = @i_linea4,
		               me_linea5 = @i_linea5,
		               me_linea6 = @i_linea6
		      	 where me_fecha = @i_fecha
				/*where datepart(mm, me_fecha) = datepart(mm, @i_fecha)*/
		           and me_prodban = @i_prodban 
            		   and me_oficina = @w_oficina	

			if @@error <> 0
                	begin

	                    /* Grabar en la tabla de errores */
	                    insert cob_remesas..re_error_batch
        	            values (@w_mensaje,'ERROR AL ACTUALIZAR LA TABLA DE MENSAJES')
	
        	            if @@error <> 0
                	    begin
                       		/* Error en grabacion de archivo de errores */
	                       exec cobis..sp_cerror
	       	                    @i_num       = 203056
	                           /* Cerrar y liberar cursor */
            		           close curofi
                       		   deallocate curofi
		                   return 203040
                	    end
		            goto LEER
		    	end
		end
		else
		begin
	      		select @w_fecha = dateadd (dd, -1,
	                          dateadd(mm, 1,
	                            convert(datetime, 
	                             substring (convert(char(10), @i_fecha, 101), 1, 2) 
	                        + '/01/' + 
	                             substring (convert(char(10), @i_fecha, 101), 7, 4)
	                        ) ) )

		        insert into cob_remesas..cc_mensaje_estcta
			   values (@i_fecha /*@w_fecha*/, @i_prodban, @w_oficina, @i_linea1,
		                @i_linea2, @i_linea3, @i_linea4,@i_linea5,@i_linea6,@i_fecha_fin)
		
		         if @@error <> 0
         	            begin
                               /* Grabar en la tabla de errores */
                               insert cob_remesas..re_error_batch
       	                       values (@w_mensaje,'ERROR AL INSERTAR EN LA TABLA DE MENSAJES')
	
       	                       if @@error <> 0
               	               begin
           		       /* Error en grabacion de archivo de errores */
                                  exec cobis..sp_cerror
       	                          @i_num       = 203056
                                 /* Cerrar y liberar cursor */
       		                 close curofi
               		         deallocate curofi
	                         return 203056
               	               end
	                       goto LEER
	    	            end
		end


LEER:        	
		fetch curofi into
			@w_oficina

	        if @@fetch_status = -2
        	begin
             		close curofi
             		deallocate curofi

             		exec cobis..sp_cerror
		     		@i_num = 201157

             		return 201157
        	end
	end

	close curofi
	deallocate curofi
end

if @i_oper = 'E'
begin
	delete from cob_remesas..cc_mensaje_estcta
		where me_fecha = @i_fecha
		  and me_fecha_fin=@i_fecha_fin
			/*where datepart (mm, me_fecha) = datepart(mm, @i_fecha)*/
		and me_prodban = @i_prodban


 	if @@error <> 0
       	begin
        	/* Error al eliminar mensaje de estados de cuenta */
	       	exec cobis..sp_cerror
               		@t_debug     = @t_debug,
			@t_file      = @t_file,
	        	@t_from      = @w_sp_name,
        		@i_num       = 207015
	        return 1
       	end


end 


if @i_oper = 'C'
	 begin
		   set rowcount 10
		   select 'SUCURSAL'= me_oficina,
		          'LINEA 1' = me_linea1,
	        	  'LINEA 2' = me_linea2,
		          'LINEA 3' = me_linea3,
		          'LINEA 4' = me_linea4--,
			  --'FECHA INICIO'=convert(varchar(10),me_fecha,@i_formato_fecha),
			  --'FECHA FIN'=convert(varchar(10),me_fecha_fin,@i_formato_fecha)	
		   from cob_remesas..cc_mensaje_estcta
	    	   where me_fecha >= convert (smalldatetime, @i_fecha)
		   and me_fecha_fin <= convert (smalldatetime, @i_fecha_fin)
			/*where datepart(mm, me_fecha) = datepart(mm, @i_fecha)*/
	      	   and (me_prodban = @i_prodban or @i_prodban=-1)
		   and me_oficina > @i_ofi
  	           order by me_oficina
   	           set rowcount 0
	 end


if @i_oper ='U'
	  begin
	     update cob_remesas..cc_mensaje_estcta
	         set me_fecha =@i_fecha,
		     me_linea1 = @i_linea1,
		     me_linea2 = @i_linea2,
	             me_linea3 = @i_linea3,
	             me_linea4 = @i_linea4,
	             me_linea5 = @i_linea5,
	             me_linea6 = @i_linea6,
		     me_fecha_fin=@i_fecha_fin	
	             where
                     me_prodban = @i_prodban
		     and me_oficina = @i_ofi
		  
	      if @@error <> 0
	       begin
	        exec cobis..sp_cerror
	             @t_debug= @t_debug,
	             @t_file = @t_file,
	             @t_from = @t_from,
	             @i_num  = 205033
	        return 1
	       end 		
	  end
end
commit tran
return 0




GO

