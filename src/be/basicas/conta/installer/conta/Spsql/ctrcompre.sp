/************************************************************************/
/*	Archivo: 		ctrcompre.sp			        */
/*	Stored procedure: 	sp_control_comp_ret   			*/
/*	Base de datos:  	cob_sit  				*/
/*	Producto:               SIT                      		*/
/*	Disenado por:           Olga Rios                             	*/
/*	Fecha de escritura:     Mar-13-2007    				*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Control de ejecuciones proceso de generacion de comprobantes    */
/*      de pago de Declaraciones de Reteica/Estampilla                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_control_comp_ret')
	drop proc sp_control_comp_ret
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_control_comp_ret
(
     @s_ssn		int      	= null,
     @s_date    	datetime 	= null,
     @s_user            login    	= null,
     @s_term            descripcion 	= null,
     @s_corr            char(1)  	= null,
     @s_ssn_corr        int      	= null,
     @s_ofi             smallint  	= null,
     @t_rty             char(1)  	= null,
     @t_trn             int 		= null,
     @t_debug           char(1)  	= 'N',
     @t_file            varchar(14) 	= null,
     @t_from            varchar(30) 	= null,
     @i_modo		tinyint		=0,
     
     @i_operacion       char(1) 	= null,
     @i_empresa 	int		= null,
     @i_cod_declaracion	char(2),	     
     @i_oficina		smallint 	= null,
     @i_fecha_orden	datetime	= null,
     @i_fecha_corte	datetime	= null,
     @i_fecha_comp      datetime 	= null
     )
as
declare
	@w_sp_name      varchar(32),  /* nombre stored proc*/
	@w_existe       char(1),
	@w_fecha_hoy    datetime,
	@w_cod_declaracion char(2),
	@w_fecha_corte  datetime,
	@w_fecha_orden	datetime,
	@w_count	int,
	@w_estado	char(1)
	
select @w_sp_name = 'sp_control_comp_ret'
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

if (@t_trn <> 6318 and @i_operacion = 'Q') or /* Query*/
   (@t_trn <> 6319 and @i_operacion = 'I') or /* Insert */
   (@t_trn <> 6320 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6321 and @i_operacion = 'D')    /* Delete */
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
 
 select @w_cod_declaracion 	= cp_cod_declaracion,
   	@w_fecha_corte		= cp_fecha_corte,
   	@w_fecha_orden		= cp_fecha_orden,
   	@w_estado		= cp_estado
  from  cb_ctrl_proceso_comp_pag_decl
  where cp_oficina = @i_oficina
  and   cp_fecha_orden  = @i_fecha_orden
  and   cp_empresa = @i_empresa

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
  if   	@i_oficina  	is NULL or
 	@i_cod_declaracion	is NULL or
 	@i_fecha_corte 		is NULL or
 	@i_fecha_orden 		is NULL 
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
    
  if @w_estado = 'P'
    begin
     /* Registro ya fue procesado, no se puede eliminar */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 609310
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
	ts_cod_declaracion,	
	ts_fecha_orden,
	ts_fecha_corte	
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
	@w_cod_declaracion,
	@w_fecha_orden,
	@w_fecha_corte)


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
         
    delete cb_ctrl_proceso_comp_pag_decl
    where cp_oficina = @i_oficina
    and   cp_fecha_orden  = @i_fecha_orden   
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

-- Verifica si hay otra orden pendiente para la misma oficina

  if exists (select 'x' from  cb_ctrl_proceso_comp_pag_decl
             where cp_oficina = @i_oficina
             and   cp_estado is null)
  begin
    /* Existen ordenes pendientes para esta oficina */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 609311
        return 1
  end           
   
   
  if not exists (select 'x' from cb_nits_ofi_pag_decl 
     where no_oficina = @i_oficina)
     
  begin
     /* La oficina no tiene nit asociado */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 609312
        return 1
  end   
 begin tran
 
     insert into cb_ctrl_proceso_comp_pag_decl(
	cp_empresa,		
	cp_oficina,		
	cp_cod_declaracion,	
	cp_fecha_orden,	
	cp_fecha_corte
	)
     values (
     @i_empresa, 
     @i_oficina,
     @i_cod_declaracion,
     @i_fecha_orden,
     @i_fecha_corte)
     
     
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
	ts_cod_declaracion,	
	ts_fecha_orden,
	ts_fecha_corte	
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
	@i_cod_declaracion,
	@i_fecha_orden,
	@i_fecha_corte)


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
  
  if @w_estado is not null
  begin
     print 'Registro ya fue procesado, no se puede modificar'
     return 1
  end
  
  update cb_ctrl_proceso_comp_pag_decl
  set  	cp_cod_declaracion = @i_cod_declaracion,
  	cp_fecha_corte = @i_fecha_corte
  where cp_oficina = @i_oficina
  and   cp_fecha_orden  = @i_fecha_orden
  and   cp_empresa = @i_empresa

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
	ts_cod_declaracion,	
	ts_fecha_orden,
	ts_fecha_corte	
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
	@w_cod_declaracion,
	@w_fecha_orden,
	@w_fecha_corte)


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
	ts_cod_declaracion,	
	ts_fecha_orden,
	ts_fecha_corte	
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
	@i_cod_declaracion,
	@i_fecha_orden,
	@i_fecha_corte)

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
       select   'COD DECLAR.' = cp_cod_declaracion,
       		'OFICINA'= 	cp_oficina,
      		'NOMBRE'  = of_nombre, 
       		'FECHA CORTE' =   convert(varchar,cp_fecha_corte, 101),
       		'ESTADO' = case cp_estado when 'E' then 'ERROR' when 'P' then 'PPROCESADO' else  cp_estado end,
       		'FECHA COMPROB.' = convert(varchar,cp_fecha_comprob,101),
       		'NRO COMPROB.' = cp_comprobante,
       		'FECHA ORDEN'=  convert(varchar,cp_fecha_orden, 101),       		
       		'FECHA EJEC' = convert(varchar,cp_fecha_ejec, 101)       		
       	from cb_ctrl_proceso_comp_pag_decl, cobis..cl_oficina
	where (cp_cod_declaracion = @i_cod_declaracion or @i_cod_declaracion is null)
	and (cp_oficina = @i_oficina or @i_oficina is null)
        and  of_oficina = cp_oficina
	and cp_empresa = @i_empresa        
        and (cp_fecha_corte = @i_fecha_corte or @i_fecha_corte is null)
        and (cp_fecha_comprob = @i_fecha_comp or @i_fecha_comp is null)
	order by cp_oficina, cp_cod_declaracion, cp_fecha_orden
       		
     end
     
     
     if @i_modo = 1
     begin
       select   'COD DECLAR.' = cp_cod_declaracion,
       		'OFICINA'= 	cp_oficina,
       		'NOMBRE'  = of_nombre,        		
       		'FECHA CORTE' =  convert(varchar,cp_fecha_corte, 101),       		
       		'ESTADO' = case cp_estado when 'E' then 'ERROR' when 'P' then 'PPROCESADO' else  cp_estado end,
       		'FECHA COMPROB.' = convert(varchar,cp_fecha_comprob,101),
       		'NRO COMPROB.' = cp_comprobante,
       		'FECHA ORDEN'=  convert(varchar,cp_fecha_orden, 101),       		       		
       		'FECHA EJEC' = convert(varchar,cp_fecha_ejec, 101)
       	from cb_ctrl_proceso_comp_pag_decl, cobis..cl_oficina  
	where (cp_cod_declaracion = @i_cod_declaracion or @i_cod_declaracion is null)
	and (cp_oficina > @i_oficina or (cp_oficina = @i_oficina and cp_fecha_orden > @i_fecha_orden))
	and of_oficina = cp_oficina
	and cp_empresa = @i_empresa
        and (cp_fecha_corte = @i_fecha_corte or @i_fecha_corte is null)	
        and (cp_fecha_comprob = @i_fecha_comp or @i_fecha_comp is null)        
	order by cp_oficina, cp_cod_declaracion, cp_fecha_orden
     
     end
     
     if @i_modo = 2 -- oficinas pagadoras
     begin
        SELECT distinct 'OFICINA' = of_oficina_consolida, 
               'NOMBRE'  = of_nombre
        FROM cb_ofpagadora, cobis..cl_oficina
        WHERE (of_cod_declaracion = @i_cod_declaracion  or @i_cod_declaracion is null)
        AND  of_oficina = of_oficina_consolida
        order by  of_oficina_consolida
     end
     
     if @i_modo = 3 -- oficinas pagadoras  - siguientes
     begin
        SELECT  distinct 'OFICINA' = of_oficina_consolida, 
               'NOMBRE'  = of_nombre
        FROM  cb_ofpagadora, cobis..cl_oficina
        WHERE (of_cod_declaracion = @i_cod_declaracion  or @i_cod_declaracion is null) 
        AND  of_oficina = of_oficina_consolida
        and of_oficina_consolida > @i_oficina  
        order by  of_oficina_consolida
     
     end
     
     if @i_modo = 4
     begin

        SELECT distinct of_nombre
        FROM  cb_ofpagadora, cobis..cl_oficina
        WHERE (of_cod_declaracion = @i_cod_declaracion  or @i_cod_declaracion is null)
        AND   of_oficina_consolida = @i_oficina
        AND   of_oficina = of_oficina_consolida
        
        if @@rowcount =  0
	raiserror (N'101001 - No existe dato solicitado', 16, 1)
     end
    
end
go
