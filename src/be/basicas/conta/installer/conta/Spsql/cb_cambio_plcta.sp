/************************************************************************/
/*  Archivo:                         cb_cambio_plcta.sp                 */
/*  Stored procedure:                sp_cambio_plan_cta                 */
/*  Base de datos:                   cob_conta                          */
/*  Producto:                        Contabilidad                       */
/*  Disenado por:                    Doris Lozano                       */
/*  Fecha de escritura:              16-Feb-2015                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Desasociar cuenta origen y colocar la cuenta destino                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  02/16/2015  Doris Lozano           Emision Inicial                  */
/************************************************************************/

use cob_conta
go


if exists (SELECT * from sysobjects WHERE name = 'sp_cambio_plan_cta')
   drop proc sp_cambio_plan_cta
go

create proc sp_cambio_plan_cta(
@i_param1            varchar(14),  --Cuenta Origen
@i_param2            varchar(14),  --Cuenta Destino
@i_param3            char(1)       --Tercero
)

as
declare
@w_sp_name           varchar(30),
@w_cuenta_origen     varchar(14),
@w_cuenta_destino    varchar(14),
@w_tercero           char(1),
@w_ssn               int,
@w_param			 varchar(10),
@w_clave			 varchar(20)



select 
	@w_cuenta_origen  = @i_param1,
	@w_cuenta_destino = @i_param2,
	@w_tercero        = @i_param3,
	@w_sp_name        = 'sp_cambio_plan_cta'
	
	BEGIN TRAN
    if exists(select 1 from cob_conta..cb_cuenta_proceso
       where cp_cuenta = @w_cuenta_origen)
     begin
        if @w_tercero = 'S'
        begin 
          update cob_conta..cb_cuenta_proceso
		  set  cp_cuenta = @w_cuenta_destino
		  from cob_conta..cb_cuenta_proceso
		  where cp_proceso in (6003, 6004, 6095)
		  and cp_cuenta = @w_cuenta_origen
		  
		  if @@error <> 0
		  begin
		     print 'Error en actualizacion cuenta proceso'
		     ROLLBACK TRAN
		  end
		  
		  exec @w_ssn = ADMIN...rp_ssn
		  	   
		  insert into ts_cuenta_proceso
		  values (@w_ssn,6221,'N',getdate(),'opbatch','consola',1,
		        	1,6003,@w_cuenta_destino,1,@w_cuenta_origen,
                    null,'0')
                    
          if @@error <> 0
		  begin
		     print 'Error en insercion de transaccion de servicio cuenta proceso'
		     ROLLBACK TRAN
		  end
	    end	
	    else
	    begin
	      update cob_conta..cb_cuenta_proceso
		  set  cp_cuenta = @w_cuenta_destino
		  from cob_conta..cb_cuenta_proceso
		  where cp_proceso not in (6003, 6004, 6095)
		  and cp_cuenta = @w_cuenta_origen
		  
		  if @@error <> 0
		  begin
		     print 'Error en actualizacion cuenta proceso'
		     ROLLBACK TRAN
		  end
		  
		  exec @w_ssn = ADMIN...rp_ssn
		  		  
		  insert into ts_cuenta_proceso
		  values (@w_ssn,6221,'N',getdate(),'opbatch','consola',1,
		        	1,6001,@w_cuenta_destino,1,@w_cuenta_origen,
                    null,'0')
                    
          if @@error <> 0
		  begin
		     print 'Error en insercion de transaccion de servicio cuenta proceso'
		     ROLLBACK TRAN
		  end
		  
	    end  
    end   
    
    if exists(select 1 from cob_conta..cb_plan_general
        where pg_cuenta = @w_cuenta_origen)
    begin
          update cob_conta..cb_plan_general
          set pg_clave  = replace(pg_clave, @w_cuenta_origen, @w_cuenta_destino)
          from cob_conta..cb_plan_general
          where pg_cuenta = @w_cuenta_origen
          
          if @@error <> 0
		  begin
		     print 'Error en actualizacion clave plan general'
		     ROLLBACK TRAN
		  end
		  
		  exec @w_ssn = ADMIN...rp_ssn
		  		  
		  insert into ts_plan_general
           values (@w_ssn,6071,'B',getdate(),'opbatch','consola',1,
           1,@w_cuenta_destino,1,1)
           
          if @@error <> 0
		  begin
		     print 'Error en insercion transaccion de servicio plan general'
		     ROLLBACK TRAN
		  end
		  
		  delete cob_conta..cb_plan_general
           where pg_cuenta = @w_cuenta_destino
             and pg_oficina in (select pg_oficina from cob_conta..cb_plan_general
                                where pg_cuenta = @w_cuenta_origen)
             and pg_area in (select pg_area from cob_conta..cb_plan_general
                                where pg_cuenta = @w_cuenta_origen)
             
           if @@error <> 0
		   begin
		     print 'Error en eliminacion cuenta plan general cd'
		     ROLLBACK TRAN
		   end
		      
          insert into cob_conta..cb_plan_general
          select pg_empresa, @w_cuenta_destino,  pg_oficina, pg_area, pg_clave                         
	        from cob_conta..cb_plan_general
	        where pg_cuenta = @w_cuenta_origen
	          
	       if @@error <> 0
		   begin
		     print 'Error en actualizacion cuenta plan general'
		     ROLLBACK TRAN
		   end
		   
		   delete cob_conta..cb_plan_general
           where pg_cuenta = @w_cuenta_origen
           
           if @@error <> 0
		   begin
		     print 'Error en eliminacion cuenta plan general co'
		     ROLLBACK TRAN
		   end
           
	end	      --exists pg
	
	if exists(select 1 from cob_conta..cb_cuenta_asociada 
       where ca_cuenta = @w_cuenta_origen)
    begin
        if @w_tercero = 'S'
        begin 
	     	update cob_conta..cb_cuenta_asociada 
	     	set ca_cuenta =  @w_cuenta_destino 
	     	where ca_proceso  in (6003, 6004, 6095)
	          and ca_cuenta = @w_cuenta_origen
	    
	        if @@error <> 0
			begin
			    print 'Error en actualizacion cob_conta..cb_cuenta_asociada 1-1'
			    ROLLBACK TRAN
			end
			
			exec @w_ssn = ADMIN...rp_ssn
					  
			insert into ts_cuenta_asociada
			values (@w_ssn,6231,'N',getdate(),'opbatch','consola',1,
				1,6003,@w_cuenta_destino,1,
				0,' ',1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
				
						exec @w_ssn = ADMIN...rp_ssn
					  
			insert into ts_cuenta_asociada
			values (@w_ssn,6233,'N',getdate(),'opbatch','consola',1,
				1,6003,@w_cuenta_origen,1,
				0,' ',1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
			
		end
		else
		begin 
	     	update cob_conta..cb_cuenta_asociada 
	     	set ca_cuenta =  @w_cuenta_destino 
	     	where ca_proceso  not in (6003, 6004, 6095)
	          and ca_cuenta = @w_cuenta_origen
	    
	        if @@error <> 0
			begin
			    print 'Error en actualizacion cob_conta..cb_cuenta_asociada 1-2'
			    ROLLBACK TRAN
			end
			
			exec @w_ssn = ADMIN...rp_ssn
						
			insert into ts_cuenta_asociada
			values (@w_ssn,6231,'N',getdate(),'opbatch','consola',1,
				1,6001,@w_cuenta_destino,1,
				0,' ',1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
			
			exec @w_ssn = ADMIN...rp_ssn
						
			insert into ts_cuenta_asociada
			values (@w_ssn,6233,'N',getdate(),'opbatch','consola',1,
				1,6001,@w_cuenta_origen,1,
				0,' ',1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
			
		end
	end
	
    if exists(select 1 from cob_conta..cb_cuenta_asociada 
       where  ca_cta_asoc = @w_cuenta_origen)	
    begin 
        if @w_tercero = 'S'
        begin 
 			update cob_conta..cb_cuenta_asociada 
	     	set ca_cta_asoc =  @w_cuenta_destino 
	     	where ca_proceso  in (6003, 6004, 6095)
	          and ca_cta_asoc = @w_cuenta_origen
	    
	        if @@error <> 0
			begin
			    print 'Error en actualizacion cob_conta..cb_cuenta_asociada 2-1'
			    ROLLBACK TRAN
			end
			
			exec @w_ssn = ADMIN...rp_ssn
						
			insert into ts_cuenta_asociada
			values (@w_ssn,6231,'N',getdate(),'opbatch','consola',1,
				1,6003,' ',1,
				0,@w_cuenta_destino,1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
		end
		else
		begin 
 			update cob_conta..cb_cuenta_asociada 
	     	set ca_cta_asoc =  @w_cuenta_destino 
	     	where ca_proceso  not in (6003, 6004, 6095)
	          and ca_cta_asoc = @w_cuenta_origen
	    
	        if @@error <> 0
			begin
			    print 'Error en actualizacion cob_conta..cb_cuenta_asociada 2-2'
			    ROLLBACK TRAN
			end
			
			exec @w_ssn = ADMIN...rp_ssn
						
			insert into ts_cuenta_asociada
			values (@w_ssn,6231,'N',getdate(),'opbatch','consola',1,
				1,6001,' ',1,
				0,@w_cuenta_destino,1,'C')
				
		    if @@error <> 0
			begin
			    print 'Error en insercion tran servicio  cuenta asociada'
			    ROLLBACK TRAN
			end
			
		end
    end
    
    if exists (select 1 from cob_conta..cb_relparam
				where  re_substring  = @w_cuenta_origen)
	begin
		select @w_param =  re_parametro,
		       @w_clave =  re_clave
		  from cob_conta..cb_relparam
				where  re_substring  = @w_cuenta_origen  
				
	    update cob_conta..cb_relparam
	    set re_substring  = @w_cuenta_destino
	    where  re_substring  = @w_cuenta_origen
	    
	    if @@error <> 0
		begin
		    print 'Error en actualizacion cob_conta..cb_relparam'
		    ROLLBACK TRAN
		end
				
		exec @w_ssn = ADMIN...rp_ssn
		
   		insert into ts_relparam
   		values (@w_ssn,6932,'N',getdate(),'opbatch','consola',1,
        	   1,@w_param,@w_clave,substring(@w_cuenta_origen,1,10))
        
        if @@error <> 0
		begin
		    print 'Error en insercion  transaccion de servicio cob_conta..ts_relparam'
		    ROLLBACK TRAN
		end	   
        	   
	end			
    
    if @@trancount > 0  
       COMMIT TRAN
      
return 0
go
