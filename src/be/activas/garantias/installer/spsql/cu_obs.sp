/***********************************************************************/
/*	Archivo:			cu_obs.sp                      */
/*	Stored procedure:		sp_observa                     */
/*	Base de Datos:			cob_custodia                   */
/*	Producto:			Credito	                       */
/*	Disenado por:			Jennifer Velandia              */
/*	Fecha de Documentacion: 	24/Nov/2002                    */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Este stored procedure permite ingresar registros de las        */
/*      observacionse de las visitas a las garantias  cu_observaciones */
/*								       */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	25/Nov/2002	Jvelandia		Emision Inicial	       */
/*	                                                               */ 
/***********************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_observa')
    drop proc sp_observa
go
create proc sp_observa (
  	@s_ssn			int = null,
  	@s_user			login = null,
  	@s_sesn			int = null,
        @s_term			varchar(30) = null,
        @s_date			datetime = null,
        @s_srv			varchar(30) = null,
        @s_lsrv			varchar(30) = null,
        @s_rol			smallint = NULL,
        @s_ofi			smallint = NULL,
        @s_org_err		char(1) = NULL,
        @s_error		int = NULL,
        @s_sev			tinyint = NULL,
        @s_msg			descripcion = NULL,
        @s_org			char(1) = NULL,
 	@t_debug    		char(1) = 'N',
	@t_file     		varchar(10) = null,
	@t_from     		varchar(32) = null,
	@t_trn	    		smallint = null,   
   	@i_operacion          	char(1)  = null,
	@i_sub_operacion	char(1)	 = null,
   	@i_tramite            	int  = null,
   	@i_numero             	smallint  = null,
   	@i_fecha              	datetime  = null,
   	@i_categoria          	catalogo  = null,
	@i_oficial		char(1) = null,
   	@i_etapa              	tinyint  = null,
   	@i_estacion           	smallint  = null,
   	@i_linea             	smallint  = null, --
	@i_lineas		smallint = null,  --
	@i_texto		varchar(255) = null, --
        @i_rechazo 		char(1)  = null	,	
        @i_codigo_externo       varchar(64) = null
        
)
as


declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite            int,
   @w_numero             smallint,
   @w_fecha              datetime,
   @w_categoria          catalogo,
   @w_oficial		 char(1),
   @w_etapa              tinyint,
   @w_desc_etapa	 descripcion,
   @w_estacion           smallint,
   @w_desc_estacion	 descripcion,
   @w_usuario            login,
   @w_lineas             smallint,
   @w_max_observacion	 int,
   @w_nom_usuario	 varchar(30),
   @w_cont		 int,
   @w_modificar          char(1),
   @w_rechazo		 char(1),
   @w_codigo_externo	 varchar(64) 

select @w_today = @s_date
select @w_sp_name = 'sp_observa'

/********************************************************/
/*	DEBUG						*/


/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19935 and @i_operacion = 'I') or
   (@t_trn <> 19936 and @i_operacion = 'U') or
   (@t_trn <> 19937 and @i_operacion = 'D') or
   (@t_trn <> 19938 and @i_operacion = 'S') or
   (@t_trn <> 19939 and @i_operacion = 'Q')
begin
/* tipo de transaccion no corresponde */

    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
         @w_codigo_externo = on_codigo_externo,
         @w_numero  = on_numero,
         @w_fecha   = on_fecha,
         @w_usuario = on_usuario,
	 @w_nom_usuario = fu_nombre,
         @w_lineas = on_lineas,
         @w_modificar = on_modificar         		
    from cob_custodia..cu_observacion_inspecci,
	  cobis..cl_funcionario
    where 
         on_codigo_externo = @i_codigo_externo and
         on_numero = @i_numero and
	 on_usuario = fu_login 

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_codigo_externo = NULL 
        
         
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901036
        return 1 
    end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'

begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1903002
        return 1 
    end

   /* if (@i_etapa is null) or (@i_estacion is null)
    begin
       select @i_etapa = rt_etapa,
              @i_estacion = rt_estacion
       from cr_ruta_tramite
       where rt_tramite = @i_tramite
       and  rt_secuencia = (select max(rt_secuencia) - 1
                            from cr_ruta_tramite
                            where rt_tramite = @i_tramite)
    end*/

    /* Seleccion del numero secuencial de observacion por tramite */
    /**************************************************************/

    SELECT 
	@w_max_observacion  = max(on_numero)  
    FROM  cu_observacion_inspecci
    WHERE 
          on_codigo_externo = @i_codigo_externo
    
    --cr_observaciones.ob_tramite = @i_tramite

    select @w_max_observacion= isnull( @w_max_observacion,0) 
       
    select @w_max_observacion= @w_max_observacion+ 1
    select @i_numero = @w_max_observacion


    if @i_sub_operacion = "T"
    /* insertar el texto de la observacion en tablas temporales */
    begin
	insert into cu_tmp_obs_inspecci
	(
	  to_usuario,
	  to_sesion,
	  to_codigo_externo,
	  to_condicion,
	  to_linea,
	  to_texto
	  
	  
	)
	values
	(
	  @s_user,
	  @s_sesn,
	  @i_codigo_externo,
	  0,
	  @i_linea,
	  @i_texto
	)
	
	If @@error <> 0 
	begin
        /* Error en insercion de registro */
           exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 1903001
           return 1 
	end
    end
    
    if @i_sub_operacion = "E"
    /* eliminar lineas de las tablas temporales */
    begin

	DELETE 	cu_tmp_obs_inspecci
	WHERE 	to_usuario = @s_user
 	AND	to_sesion  = @s_sesn	
        if @@error <> 0 
        begin
        /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1903001
        end	
    end

    if @i_sub_operacion = "D"
    /* insertar en tablas definitivas */
    begin
       begin tran
	 /* Encontrar el m ximo n£mero de l¡neas */
         
	 select @w_lineas = max(to_linea)
	 from	cu_tmp_obs_inspecci
	 where	to_usuario = @s_user
	 and	to_sesion = @s_sesn
	 
         
         If @@rowcount = 0
	    begin
            /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1903001
            return 1 
	 end
		
	/*Pasar de l¡neas de tablas temporales a definitivas */

	insert into cu_obs_inspecci
	(oi_codigo_externo,  	oi_observacion,	
	 oi_linea,	oi_texto)
	select
	to_codigo_externo,     @i_numero,    
	to_linea,       to_texto
	from 	cu_tmp_obs_inspecci
	where	to_usuario = @s_user
	and	to_sesion  = @s_sesn

	if @@error <> 0
	begin
           /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1903001
           return 1 
	end

	/* Crear el registro en cr_observaciones cu_observacion tra ser*/
        insert into cu_observacion_inspecci(
        on_codigo_externo,   on_numero,   on_fecha,
        on_usuario,  on_lineas, on_modificar)
	
        values (
        @i_codigo_externo,   @i_numero,   @w_today, 
        @s_user,     @w_lineas ,"S")
	

        if @@error <> 0 
        begin
           /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1903001
           return 1 
        end

	/* borrar la tabla temporal */
	delete 	cu_tmp_obs_inspecci
	where	to_usuario = @s_user 
	and	to_sesion = @s_sesn

        if @@error <> 0 
        begin
           /* Error en insercion de registro */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1903001
           return 1 
        end

		/* retornar el n£mero de observaci¢n ingresada */
		select @i_numero

      		/* Transaccion de Servicio pendiente*/
      		/***************************/
      		
      		insert into ts_observaciones (
                secuencial,tipo_transaccion,clase,
                fecha,usuario,terminal,
                oficina, tabla,lsrv, 
                srv, codigo_externo,numero,
                fecha_ob, usuario_ob,  lineas)
                 
         	values (@s_ssn,@t_trn,'N',
                        @s_date,@s_user,@s_term,
                        @s_ofi,'cu_observacion_inspecci',@s_lsrv,
                        @s_srv,@i_codigo_externo, @i_numero,
                        @w_today,@s_user,@w_lineas)
		
		
	        if @@error <> 0 
         	begin
         	
         	/* Error en insercion de transaccion de servicio */
             	exec cobis..sp_cerror
             	@t_debug = @t_debug,
             	@t_file  = @t_file, 
             	@t_from  = @w_sp_name,
             	@i_num   = 1903003
             	return 1 
         	end
    	   commit tran 
	end
end


/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    begin tran

	/* Encontrar el m ximo n£mero de l¡neas */
	select 	@w_lineas = max(to_linea)
	from	cu_tmp_obs_inspecci
	where	to_usuario = @s_user
	and	to_sesion = @s_sesn
        If @@rowcount = 0
	begin
       	/* Error en insercion de registro */
		exec cobis..sp_cerror
       		@t_debug = @t_debug,
       		@t_file  = @t_file, 
       		@t_from  = @w_sp_name,
             	@i_num   = 1903001
             	return 1 
	end

	/*Borrar las l¡neas anteriores cr_ob_lineas  cr_ob_inspecci*/
	delete	cu_obs_inspecci
	where	oi_codigo_externo = @i_codigo_externo
	and	oi_observacion    = @i_numero
			
	/*Pasar de l¡neas de tablas temporales a definitivas */
	insert into cu_obs_inspecci
	(oi_codigo_externo,
	 oi_observacion,
	 oi_linea,
	 oi_texto
	)
	select
	 to_codigo_externo,
	 @i_numero,
	 to_linea,
	 to_texto
	from 	cu_tmp_obs_inspecci
	where	to_usuario = @s_user
	and	to_sesion = @s_sesn
	if @@error <> 0
	begin
       	/* Error en insercion de registro */
        	exec cobis..sp_cerror
             	@t_debug = @t_debug,
        	@t_file  = @t_file, 
             	@t_from  = @w_sp_name,
             	@i_num   = 1903001
             	return 1 
	end

         update cob_custodia..cu_observacion_inspecci
         set 
              on_fecha = @w_today,
              on_usuario = @s_user,
              on_lineas = @w_lineas
              
         where 
         on_codigo_externo = @i_codigo_externo and
         on_numero = @i_numero

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/


         insert into ts_observaciones (
                secuencial,tipo_transaccion,clase,
                fecha,usuario,terminal,
                oficina, tabla,lsrv, 
                srv, codigo_externo,numero,
                fecha_ob, usuario_ob,  lineas)
                 
         	values (@s_ssn,@t_trn,'P',
                        @s_date,@s_user,@s_term,
                        @s_ofi,'cu_observacion_inspecci',@s_lsrv,
                        @s_srv,@w_codigo_externo, @w_numero,
                        @w_today,@s_user,@w_lineas)
                        

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_observaciones (
                secuencial,tipo_transaccion,clase,
                fecha,usuario,terminal,
                oficina, tabla,lsrv, 
                srv, codigo_externo,numero,
                fecha_ob, usuario_ob,  lineas)
                 
         	values (@s_ssn,@t_trn,'A',
                        @s_date,@s_user,@s_term,
                        @s_ofi,'cu_observacion_inspecci',@s_lsrv,
                        @s_srv,@i_codigo_externo, @i_numero,
                        @w_today,@s_user,@w_lineas)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 

        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end

   begin tran
	 DELETE cob_custodia..cu_obs_inspecci
	 where	oi_codigo_externo = @i_codigo_externo
	 and	oi_observacion = @i_numero

         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

         DELETE cob_custodia..cu_observacion_inspecci
    	 where 
         on_codigo_externo = @i_codigo_externo and
         on_numero = @i_numero
                              
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1907001
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_observaciones (
                secuencial,tipo_transaccion,clase,
                fecha,usuario,terminal,
                oficina, tabla,lsrv, 
                srv, codigo_externo,numero,
                fecha_ob, usuario_ob,  lineas)
                 
         	values (@s_ssn,@t_trn,'N',
                        @s_date,@s_user,@s_term,
                        @s_ofi,'cu_observacion_inspecci',@s_lsrv,
                        @s_srv,@i_codigo_externo, @i_numero,
                        @w_today,@s_user,@w_lineas)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	if @i_sub_operacion = "O"
	begin
		set rowcount 20
		select @i_numero = isnull(@i_numero , 0)
	    	SELECT 
	         	"Numero" = on_numero,
		 	"Fecha" = convert(char(10),on_fecha,103),
		 	"Usuario" = fu_nombre,
		 	"Lineas" = on_lineas,
		 	"Modificar" = on_modificar			
	    	FROM cu_observacion_inspecci, 
	    	--(INDEX cu_observacion_inspecci_Key), 
	    	cobis..cl_funcionario
	   	WHERE 	on_codigo_externo = @i_codigo_externo and
	         	on_numero > @i_numero	and
	  		on_usuario = fu_login
                ORDER BY  on_numero


		set rowcount 0
	end

	if @i_sub_operacion = "L"
	begin
		set rowcount 10
		SELECT 	@i_linea = isnull(@i_linea, 0)
		SELECT	oi_linea,
			oi_texto
		FROM	cu_obs_inspecci
		WHERE	oi_codigo_externo = @i_codigo_externo
		and	oi_observacion = @i_numero
		and	oi_linea > @i_linea
		set rowcount 0
	end
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
	
         select 
              @w_codigo_externo,
              @w_numero,
              convert(char(10),@w_fecha,103),
              @w_usuario,
	      @w_nom_usuario,
              @w_lineas
	     
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1 
    end
end
return 0
go