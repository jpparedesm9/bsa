/************************************************************************/
/*	Archivo: 		nicompret.sp			                            */
/*	Stored procedure: 	sp_nits_comp	   			                    */
/*	Base de datos:  	cob_sit  				                        */
/*	Producto:               SIT                      		            */
/*	Disenado por:           Olga Rios                             	    */
/*	Fecha de escritura:     Mar-13-2007    				                */
/************************************************************************/
/*				PROPOSITO				                                */
/*	Nits por oficinas pagadoras Declaraciones de Reteica/Timbre         */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR			RAZON			                        */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_nits_comp')
	drop proc sp_nits_comp
go

create proc sp_nits_comp
(
     @s_ssn		        int      	= null,
     @s_date    	    datetime 	= null,
     @s_user            login    	= null,
     @s_term            descripcion	= null,
     @s_corr            char(1)  	= null,
     @s_ssn_corr        int      	= null,
     @s_ofi             smallint  	= null,
     @t_rty             char(1)  	= null,
     @t_trn             int 		= null,
     @t_debug           char(1)  	= 'N',
     @t_file            varchar(14)	= null,
     @t_from            varchar(30)	= null,
     @i_modo		    tinyint		=0,
     
     @i_operacion       char(1) 	= null,
     @i_empresa 	    int,
     @i_oficina		    smallint 	= null,
     @i_ente		    int 		= null
     )
as
declare
	@w_sp_name      varchar(32),  /* nombre stored proc*/
	@w_existe       char(1),
	@w_oficina	    smallint,		
	@w_fecha_hoy    datetime,
	@w_estado       char(1),
	@w_reportado    char(1),
	@w_empresa	    int,
	@w_ente 	    int,
	@w_count	    int
	
select @w_sp_name = 'sp_nits_comp'
select @w_fecha_hoy = getdate()

/*  Modo de debug  */
if @t_debug = 'S'
begin
     exec cobis..sp_begin_debug @t_file = @t_file
     select  '/**  Stored Procedure  **/ ' = @w_sp_name,
     s_ssn		= @s_ssn,		
     s_date    	        = @s_date,
     s_user             = @s_user,
     s_term             = @s_term,
     s_corr             = @s_corr,
     s_ssn_corr         = @s_ssn_corr,
     s_ofi              = @s_ofi,
     t_rty              = @t_rty,
     t_trn              = @t_trn,
     t_debug            = @t_debug,
     t_file             = @t_file,
     t_from             = @t_from,
     i_operacion        = @i_operacion,
     i_modo		= @i_modo,
     i_empresa 	        = @i_empresa

     exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */
/***********************************************************/

if (@t_trn <> 6314 and @i_operacion = 'Q') or /* Query*/
   (@t_trn <> 6315 and @i_operacion = 'I') or /* Insert */
   (@t_trn <> 6316 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6317 and @i_operacion = 'D')    /* Delete */
begin              
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end	


if @i_operacion <> 'Q'
begin

--print 'Verifica existencia'
 
  select @w_ente	 	= no_ente
  from  cb_nits_ofi_pag_decl
  where no_oficina = @i_oficina

	select @w_count = @@rowcount
	if @w_count != 0
	   select @w_existe = 'S'
	else
	   select @w_existe = 'N'
end



/******************************/
/* VALIDACION DE CAMPOS NULOS */
/******************************/

--print 'Operacion %1!', @i_operacion

if @i_operacion = 'I' or @i_operacion = 'U'
begin
  if   	@i_ente  		is NULL 
  begin

    /* Campos NOT NULL con vales nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1
  end     
  
end  

/****************************/
/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 'N'
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 605082
        return 1
    end

      
      /* Transaccion de Servicio */
      /***************************/
    begin tran
  	insert into ts_tran_serv_pag_decl (
 	ts_secuencial,	
	ts_tipo_tran,		
	ts_clase,		
	ts_fecha, 		
	ts_usuario,		
	ts_terminal,		
	ts_empresa,		
	ts_oficina_tran,	
	ts_oficina,		
	ts_cod_declaracion
	)
	values (
	@s_ssn,
	@t_trn,	
	'B',	
	@w_fecha_hoy,	
	@s_user,
	@s_term,
	@i_empresa,
	@s_ofi, 	
	@i_oficina,	
	@w_ente)


         if @@error <> 0             
         begin                       
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror   
             @t_debug = @t_debug,    
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1
         end
         
   delete  cb_nits_ofi_pag_decl
   where no_oficina = @i_oficina    

   commit tran

end    	

/**************************/
/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin

    if @w_existe = 'S'
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601160
        return 1
    end

 begin tran
 
     insert into cb_nits_ofi_pag_decl(
	no_empresa,		
	no_oficina,		
	no_ente
	)
     values (
     @i_empresa, 
     @i_oficina,
     @i_ente
     )
     
     
     if @@error <> 0             
       begin                       
         /* Error en insercion de registro */
             exec cobis..sp_cerror   
             @t_debug = @t_debug,    
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 601161
             return 1
       end
         		
		
      /* Transaccion de Servicio */
      /***************************/

  	insert into ts_tran_serv_pag_decl (
 	ts_secuencial,	
	ts_tipo_tran,		
	ts_clase,		
	ts_fecha, 		
	ts_usuario,		
	ts_terminal,		
	ts_empresa,		
	ts_oficina_tran,	
	ts_oficina,		
	ts_cod_declaracion
	)
	values (
	@s_ssn,
	@t_trn,	
	'N',	
	@w_fecha_hoy,	
	@s_user,
	@s_term,
	@i_empresa,
	@s_ofi, 	
	@i_oficina,	
	@i_ente)


         if @@error <> 0             
         begin                       
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror   
             @t_debug = @t_debug,    
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1
         end
    commit tran

end
  


/******************************/
/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 'N'
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 605082

        return 1
    end

  begin tran
  
  update cb_nits_ofi_pag_decl
  set  	no_ente = @i_ente
  where no_oficina = @i_oficina

         if @@error <> 0
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 601162
             return 1
         end
         
         
         /* Transaccion de Servicio */
         /***************************/   

 	insert into ts_tran_serv_pag_decl (
 	ts_secuencial,	
	ts_tipo_tran,		
	ts_clase,		
	ts_fecha, 		
	ts_usuario,		
	ts_terminal,		
	ts_empresa,		
	ts_oficina_tran,	
	ts_oficina,		
	ts_cod_declaracion
	)
	values (
	@s_ssn,
	@t_trn,	
	'P',	
	@w_fecha_hoy,	
	@s_user,
	@s_term,
	@i_empresa,
	@s_ofi, 	
	@i_oficina,	
	@w_ente)


         if @@error <> 0             
         begin                       
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror   
             @t_debug = @t_debug,    
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1
         end
         
         
 	insert into ts_tran_serv_pag_decl (
 	ts_secuencial,	
	ts_tipo_tran,		
	ts_clase,		
	ts_fecha, 		
	ts_usuario,		
	ts_terminal,		
	ts_empresa,		
	ts_oficina_tran,	
	ts_oficina,		
	ts_cod_declaracion
	)
	values (
	@s_ssn,
	@t_trn,	
	'A',	
	@w_fecha_hoy,	
	@s_user,
	@s_term,
	@i_empresa,
	@s_ofi, 	
	@i_oficina,	
	@i_ente)

         if @@error <> 0             
         begin                       
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror   
             @t_debug = @t_debug,    
             @t_file  = @t_file,	
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1
         end
         
     commit tran    
  end




/***************************/
/* Consulta    ******/
/***************************/  
         
if @i_operacion = 'Q'
begin

    set rowcount 20
   
     if @i_modo = 0
     begin
       select   'OFICINA' = no_oficina,
       		'DESCRIPCION'  =  (select of_nombre from cobis..cl_oficina where of_oficina = a.no_oficina),
       	 	'TIP.ID' = en_tipo_ced,
       	 	'ID'	 = en_ced_ruc,
       	 	'NOMBRE' = en_nomlar,
       	 	'ENTE' =   no_ente
       	from cb_nits_ofi_pag_decl a, cobis..cl_ente
	where en_ente = no_ente
	and (no_oficina = @i_oficina or @i_oficina is null)
	order by no_oficina
       		
     end
     
     
     if @i_modo = 1
     begin
       select   'OFICINA' = no_oficina,
       		'DESCRIPCION'  =  (select of_nombre from cobis..cl_oficina where of_oficina = a.no_oficina),       
       	 	'TIP.ID' = en_tipo_ced,
       	 	'ID'	 = en_ced_ruc,
       	 	'NOMBRE' = en_nomlar,
       	 	'ENTE' =   no_ente
       	from cb_nits_ofi_pag_decl a, cobis..cl_ente
	where en_ente = no_ente
	and (no_oficina >  @i_oficina)
	order by no_oficina
     
     end
    
end
go
