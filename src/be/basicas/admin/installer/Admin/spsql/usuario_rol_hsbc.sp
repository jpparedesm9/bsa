/* ***********************************************************************/
/*  Archivo:            usuario_rol_hsbc.sp                             */
/*  Stored procedure:   sp_usuario_rol_hsbc                             */
/*  Base de datos:      cobis                                     	    */      
/*  Producto: 			Admin                            	            */
/*  Disenado por:  		Javier Calderon      			                */
/*  Fecha de escritura: 06-Jun-2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/* Este programa realiza la actualizacion masiva de fechas de caducidad */
/* a roles de funcionario HSBC Costa Rica				                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR          RAZON                                    */
/* 06-Jun-2012  J. Calderon     Inicial                                 */
/* 14/09/2012   Mario Velez     Se aplica Validaciones para M&C         */
/* 13/01/2014   Juan Tagle      Se agregan modos de consulta 6          */
/* 18-04-2016   BBO             Migracion Sybase-Sqlserver FAL          */
/* 22-04-2016   ELO             Migracion Sybase-Sqlserver FAL          */
/************************************************************************/

use cobis
GO

if exists (select 1 from sysobjects where name = 'sp_usuario_rol_hsbc')
   drop proc sp_usuario_rol_hsbc
GO

create proc sp_usuario_rol_hsbc (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime =NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_show_version         bit  = 0,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint = NULL,
    @mc_validacion          int = 0,                -- Mario Velez, 14/Sep/2012, Para Validaciones de M&C
	@i_operacion            varchar(1),
	@i_modo                 smallint = NULL,
	@i_login                varchar(30) = null,
	@i_rol                  tinyint = NULL,
	@i_autorizante          smallint = NULL,
	@i_fecha_aut            datetime = null,
	@i_tipoh                tinyint = null,
    @i_central_transmit     varchar(1) = null,
	@i_formato_fecha	    int= NULL,
	@i_fec_cad_rol			DATETIME = NULL,
	@i_fecha_ini_rol		DATETIME = NULL,
	@o_mc_authorizationId 	int = 0 out  	
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@w_fecha_aut            datetime,
	@w_login                varchar(30),
	@w_rol                  tinyint,
	@w_autorizante          smallint,
	@w_tipo_horario         tinyint,
	@v_fecha_aut            datetime,
	@v_login                varchar(30),
	@v_rol                  tinyint,
	@v_autorizante          smallint,
	@v_tipo_horario         tinyint,
	@o_fecha_aut            datetime,
	@o_nombre_r             descripcion,
	@o_nombre_h             descripcion,
	@o_login                varchar(30),
	@o_rol                  tinyint,
	@o_autorizante          smallint,
	@o_tipo_horario         tinyint,
	@o_descripcion_tipo     varchar(30),    
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_aut           descripcion,
	@w_comando              descripcion,
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_cmdtransrv		    varchar(60),
	@w_clave	        	int,
	@w_nt_nombre		    varchar(32),
	@w_return	        	int,
   	@o_fec_cad_rol			DATETIME,
	@o_fecha_ini_rol		DATETIME, --JCA GAP008
	@w_fecha_ini_rol        datetime,
    @w_fecha_cad_rol        datetime,
	@v_fecha_ini_rol        datetime,
    @v_fecha_cad_rol        DATETIME
      
DECLARE               @w_fecha_aut_ant DATETIME,
                      @w_autorizante_ant DATETIME,
                      @w_fecha_ult_mod_ant DATETIME,
                 	  @w_tipo_horario_ant  DATETIME,
	                  @w_fecha_cad_rol_ant  DATETIME,
                      @w_fecha_ini_rol_ant  DATETIME      
	

/*****MC Mario Velez, 14/Sep/2012*****/
if @mc_validacion = 1
  begin 
      return 0
  end
/*****MC*****/

select @w_today = @s_date
select @w_sp_name = 'sp_usuario_rol_hsbc'

------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_usuario_rol_hsbc, version 4.0.0.2'
      return 0
END

if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 delete from ad_nodo_reentry_tmp
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
  
	/* chequeo de que la fecha de inicial sea inferior a la fecha actual*/
	if (@i_fecha_ini_rol <> NULL)
	begin
	   if ((
		   datepart(yy,@i_fecha_ini_rol) > datepart(yy,getdate())
	       ) or
	
	       (
		   datepart(yy,@i_fecha_ini_rol) = datepart(yy,getdate()) 
		   and 
		   datepart(mm,@i_fecha_ini_rol) > datepart(mm,getdate())
	       ) or
	 
	      (
		   datepart(yy,@i_fecha_ini_rol) = datepart(yy,getdate()) 
		   and 
		   datepart(mm,@i_fecha_ini_rol) = datepart(mm,getdate())
		   and 
		   datepart(dd,@i_fecha_ini_rol) > datepart(dd,getdate())
	       )
	       ) 
	begin
	 /* 'La fecha de inicio de rol no puede ser mayor a la actual' */
		exec sp_cerror
		     @t_debug     = @t_debug,
		     @t_file      = @t_file,
		     @t_from      = @w_sp_name,
		     @i_num       = 189002
		return 1
	 end
	end

    begin tran
	    --Inicio JCA GAP008-4
		UPDATE  ad_usuario_rol 
		SET ur_fecha_ini_rol = @i_fecha_ini_rol,        --JCA GAP008-4
		    ur_fec_cad_rol   = @i_fec_cad_rol
		WHERE  ur_login   = @i_login 
		   AND ur_rol     = @i_rol 
		
	    if @@error != 0
	    begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 153006
		   /*  'Error en insercion de usuario rol' */
		return 1
	    end
	    --Fin JCA GAP008-4
	    
	   /* transaccion de servicio */
	   /* Actualizamos el registro ingresado por el sp original */
	   
	   Update ts_usuario_rol 
	      set fecha_ini_rol = @i_fecha_ini_rol ,    --JCA GAP008-4
	          fecha_cad_rol = @i_fec_cad_rol
	          WHERE tipo_transaccion = 570
	            and fecha = @s_date
	            and login = @i_login
	            and clase = 'N'
	     
	   if @@error != 0
	   begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 153023
		   /*  'Error en creacion de transaccion de servicio' */
		return 1
	   end
    commit tran

	return 0
end     


/* ** Update ** */
if @i_operacion = 'U'
begin
/* **************** TOMA LOS DATOS ANTERIORES   -*************  */
    
	select @w_fecha_aut = ur_fecha_aut,
	 @w_autorizante = ur_autorizante,
	 @w_fecha_ult_mod = ur_fecha_ult_mod,
	 @w_tipo_horario = ur_tipo_horario,
	 @w_fecha_cad_rol = ur_fec_cad_rol,
     @w_fecha_ini_rol = ur_fecha_ini_rol
  from ad_usuario_rol
  where ur_login = @i_login
    and ur_rol = @i_rol
    and ur_estado = 'V'
	
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe usuario rol' */
	return 1
  end

	  
/* ** verificacion de campos a actualizar ** */

				select @v_fecha_aut = @w_fecha_aut,
				 @v_autorizante = @w_autorizante,
				 @v_fecha_ult_mod = @w_fecha_ult_mod,
				 @v_tipo_horario = @w_tipo_horario,
				 @v_fecha_cad_rol = @w_fecha_cad_rol,
				 @v_fecha_ini_rol = @w_fecha_ini_rol	 

			 if @w_fecha_aut = @i_fecha_aut
			   select @w_fecha_aut = null, @v_fecha_aut = null
			  else
			   select @w_fecha_aut = @i_fecha_aut

			  if @w_autorizante = @i_autorizante
			   select @w_autorizante = null, @v_autorizante = null
			  else
			   select @w_autorizante = @i_autorizante

			  if @w_tipo_horario = @i_tipoh
			   select @w_tipo_horario = null, @v_tipo_horario = null
			  else
			   select @w_tipo_horario = @i_tipoh

				/* *****   Nuevos campos    ***** */ 
				 
			  if @w_fecha_cad_rol = @i_fec_cad_rol
			   select @w_fecha_cad_rol = null,
					  @v_fecha_cad_rol = null
			  else
			   select @w_fecha_cad_rol = @i_fec_cad_rol

			  if @w_fecha_ini_rol = @i_fecha_ini_rol
			   select @w_fecha_ini_rol = null,
					  @v_fecha_ini_rol = null
			  else
			   select @w_fecha_ini_rol = @i_fecha_ini_rol
   
			  
	/* chequeo de que la fecha de inicial sea inferior a la fecha actual*/
	if (@i_fecha_ini_rol <> NULL)
	begin
	   if ((
		   datepart(yy,@i_fecha_ini_rol) > datepart(yy,getdate())
	       ) or
	
	       (
		   datepart(yy,@i_fecha_ini_rol) = datepart(yy,getdate()) 
		   and 
		   datepart(mm,@i_fecha_ini_rol) > datepart(mm,getdate())
	       ) or
	 
	      (
		   datepart(yy,@i_fecha_ini_rol) = datepart(yy,getdate()) 
		   and 
		   datepart(mm,@i_fecha_ini_rol) = datepart(mm,getdate())
		   and 
		   datepart(dd,@i_fecha_ini_rol) > datepart(dd,getdate())
	       )
	       ) 
	   begin
	   /* 'La fecha de inicio de rol no puede ser mayor a la actual' */
		  exec sp_cerror
		      @t_debug     = @t_debug,
		      @t_file      = @t_file,
		      @t_from      = @w_sp_name,
		      @i_num       = 189002
		     return 1
	      end
	  end    
  /*   fin de verificacion     ****************************/ 
  	
     	    ---------------- Actualizar ad_usuario_rol ------------------ 
		 if exists( select * from ts_usuario_rol where  secuencia= @s_ssn and tipo_transaccion = 571 and clase = 'P' and fecha = @s_date
              and oficina_s = @s_ofi and usuario = @s_user and terminal_s = @s_term and srv = @s_srv and lsrv = @s_lsrv
			   and login = @i_login and  rol = @i_rol and  fecha_aut = @v_fecha_aut)
			   
				
	     	BEGIN
	     	
	     	begin TRAN
	     	 
	     	   select @w_fecha_cad_rol_ant  = ur_fec_cad_rol,
                      @w_fecha_ini_rol_ant  = ur_fecha_ini_rol
               from ad_usuario_rol
               where ur_login = @i_login
               and ur_rol = @i_rol
               and ur_estado = 'V'
               
               
                Update ad_usuario_rol
                        set ur_fecha_ini_rol=    @i_fecha_ini_rol
                       where ur_login =     @i_login
                       and ur_rol =       @i_rol
               if @@error != 0
                  begin
                 	exec sp_cerror
           			   @t_debug      = @t_debug,
   					   @t_file       = @t_file,
   					   @t_from       = @w_sp_name,
   					   @i_num        = 155007
   				   /*  'Error en actualizacion de usuario rol' */
   					return 1
   				end
	     	              
                    
				---------------- Transaccion de servicio P = Previo al cambio ------------------ 
					Update ts_usuario_rol 
					   set fecha_ini_rol = @w_fecha_ini_rol_ant, --,    --JCA GAP008-4
						   fecha_cad_rol = @w_fecha_cad_rol_ant
					WHERE secuencia = @s_ssn
                       and tipo_transaccion = 571
					   and fecha = @s_date
					   and login = @i_login
					   and clase = 'P'
					 
					if @@error != 0
					begin
					exec sp_cerror
						 @t_debug      = @t_debug,
						 @t_file       = @t_file,
						 @t_from       = @w_sp_name,
						 @i_num        = 153023
						 /*  'Error en creacion de transaccion de servicio' */
						 return 1
					end
					---------------- Transaccion de servicio A = Actual (Despues del cambio) --------------
					Update ts_usuario_rol 
					   set fecha_ini_rol = @i_fecha_ini_rol,    --JCA GAP008-4
						   fecha_cad_rol = @i_fec_cad_rol
					WHERE secuencia = @s_ssn
 					   and tipo_transaccion = 571
					   and fecha   = @s_date
					   and login = @i_login
					   and clase = 'A'
					 
					if @@error != 0
					begin
					exec sp_cerror
						 @t_debug      = @t_debug,
						 @t_file       = @t_file,
						 @t_from       = @w_sp_name,
						 @i_num        = 153023
						 /*  'Error en creacion de transaccion de servicio' */
						 return 1
					END
					
			      COMMIT TRAN
		
		       END
		 
		 if exists( select * from ts_usuario_rol where  tipo_transaccion = 570 and clase = 'N' and fecha = @s_date
              and oficina_s = @s_ofi and usuario = @s_user and terminal_s = @s_term and srv = @s_srv and lsrv = @s_lsrv
			   and login = @i_login and  rol = @i_rol and  fecha_aut = @v_fecha_aut)	
		
       	     BEGIN
       	 
       	         BEGIN TRAN
       	      
			    
			   /* transaccion de servicio */
			   insert into ts_usuario_rol (secuencia, tipo_transaccion, clase, fecha,
							   oficina_s, usuario, terminal_s, srv, lsrv,
							   login, rol, fecha_aut, autorizante, estado,
							   fecha_ult_mod, tipo_horario,fecha_ini_rol,fecha_cad_rol)
						 values    (@s_ssn, 571, 'P', @s_date,
							@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
							@i_login, @i_rol,  @v_fecha_aut,
							@v_autorizante, null, @v_fecha_ult_mod,
							@v_tipo_horario,@w_fecha_ini_rol,@w_fecha_cad_rol)
			   if @@error != 0
			   begin
				exec sp_cerror
				   @t_debug      = @t_debug,
				   @t_file       = @t_file,
				   @t_from       = @w_sp_name,
				   @i_num        = 153023
				   /*  'Error en creacion de transaccion de servicio' */
				return 1
			   end

			   insert into ts_usuario_rol (secuencia, tipo_transaccion, clase, fecha,
							   oficina_s, usuario, terminal_s, srv, lsrv,
							   login, rol, fecha_aut, autorizante,
							   estado, fecha_ult_mod, tipo_horario,fecha_ini_rol,fecha_cad_rol)
						 values    (@s_ssn, 571, 'A', @s_date,
							@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
							@i_login, @i_rol, @w_fecha_aut,
							@w_autorizante, null, @w_today, @w_tipo_horario,@i_fecha_ini_rol,@i_fec_cad_rol)
			   if @@error != 0
			   begin
				exec sp_cerror
				   @t_debug      = @t_debug,
				   @t_file       = @t_file,
				   @t_from       = @w_sp_name,
				   @i_num        = 153023
				   /*  'Error en creacion de transaccion de servicio' */
				return 1
			   end
		 		
             commit TRAN
       
	    end
     
    return 0
  end

/* ** Delete ** */
if @i_operacion = 'D'
begin
	begin tran  	

	    /* Actualizar transaccion de servicio */
		Update ts_usuario_rol 
	       set fecha_ini_rol = @i_fecha_ini_rol ,    --JCA GAP008-4
	           fecha_cad_rol = @i_fec_cad_rol
	    WHERE tipo_transaccion = 572
	       and fecha = @s_date
	       and login = @i_login
	       and clase = 'B'
	     
	    if @@error != 0
	    begin
		exec sp_cerror
		     @t_debug      = @t_debug,
		     @t_file       = @t_file,
		     @t_from       = @w_sp_name,
		     @i_num        = 153023
		     /*  'Error en creacion de transaccion de servicio' */
		     return 1
	    end    
	 
	commit TRAN

 	return 0
   end


/* ** search ** */
if @i_operacion = 'S'
	begin        
		if @i_modo = 0
			begin
				set rowcount 20
				select  'Login' = ur_login,
                        'Cod. Rol' = ur_rol,
                        'Rol' =  substring(ro_descripcion, 1, 20),
                        'Autorizante' = ur_autorizante,
                        'Nombre Aut.' = fu_nombre,
                        'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha)
                --inicio mig syb-sql 18042016   
                 from   ad_usuario_rol
                        inner join ad_rol on ur_rol = ro_rol
                        left outer join cl_funcionario on ur_autorizante = fu_funcionario
                where   ur_estado = 'V'
                order   by ur_login, ur_rol
                --fin  mig syb-sql 18042016   
                
                /****** MIGRACION SYB-SQL 
				from    ad_usuario_rol, ad_rol, cl_funcionario
				where   --isnull(ur_autorizante, 0) = fu_funcionario
					ur_autorizante *= fu_funcionario
				and   ur_rol = ro_rol
				and    ur_estado = 'V'
				order   by ur_login, ur_rol
                ******/

				set rowcount 0
				return 0
			end

		if @i_modo = 1
			begin
				set rowcount 20
				select  'Login' = ur_login,
					'Cod. Rol' = ur_rol,
					'Rol' =  substring(ro_descripcion, 1, 20),
					'Autorizante' = ur_autorizante,
					'Nombre Aut.' = fu_nombre,
					'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha)
                --inicio mig syb-sql 18042016   
                 from   ad_usuario_rol
                        inner join ad_rol on ur_rol = ro_rol
                        left outer join cl_funcionario on ur_autorizante = fu_funcionario
                where   ur_estado = 'V'
				  and  ((ur_login > @i_login)
				   or  ((ur_login = @i_login) and (ur_rol > @i_rol)))
                order   by ur_login, ur_rol
                --fin  mig syb-sql 18042016   
                
                /****** MIGRACION SYB-SQL 
				from    ad_usuario_rol, ad_rol, cl_funcionario
				where   --isnull(ur_autorizante, 0) = fu_funcionario
					ur_autorizante *= fu_funcionario
				and   ur_rol = ro_rol
				and  ((ur_login > @i_login)
						or
					 ((ur_login = @i_login) and (ur_rol > @i_rol)))
				and   ur_estado = 'V'
				order   by ur_login, ur_rol
                *******/

				set rowcount 0
				return 0
			end

		if @i_modo = 2
			begin
				set rowcount 20
				select 'Cod. Rol'  = ur_rol,
                        'Rol'          =  substring(ro_descripcion, 1, 20),
                        'Cod. Horario' = ur_tipo_horario,
                        'Fecha Cadu'   = convert(varchar(10),ur_fec_cad_rol,@i_formato_fecha),			
                        'Horario'      = th_descripcion,
                        'Filial'       = fi_abreviatura,
                        'Fecha_aut'    = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
                        'Autorizante'  = ur_autorizante,
                        'Nombre Aut.'  = fu_nombre,
                        'Fecha Inicio' = convert(varchar(10),ur_fecha_ini_rol,@i_formato_fecha)
                --inicio mig syb-sql 18042016   
                from    ad_usuario_rol
				        inner join ad_rol on ur_rol = ro_rol
                        inner join cl_filial on ro_filial = fi_filial              

                        left outer join cl_funcionario on ur_autorizante = fu_funcionario
                        left outer join ad_tipo_horario on ur_tipo_horario = th_tipo
               where    ur_estado = 'V'
                 and    ur_login = @i_login
                order   by ur_login, ur_rol
                --fin  mig syb-sql 18042016
                
                /****** MIGRACION SYB-SQL 
				from   ad_usuario_rol, cl_filial, ad_rol, cl_funcionario, 
					ad_tipo_horario
				where ur_autorizante *= fu_funcionario
				and   ur_rol = ro_rol
				and   ro_filial = fi_filial              
				and   ur_login = @i_login
				and   ur_tipo_horario *= th_tipo
				and   ur_estado = 'V'
				order by ur_login, ur_rol
                *********/

				set rowcount 0
				return 0
			end

		--USUARIO ESPECIFICO
		if @i_modo = 3
			begin
				select  'Cod. Rol' = ur_rol,
					'Rol' =  substring(ro_descripcion, 1, 20),
					'Cod. Horario' = ur_tipo_horario,
					'Fecha Cadu' = convert(varchar(10),ur_fec_cad_rol,@i_formato_fecha),
					'Horario' = th_descripcion,
					'Filial' = fi_abreviatura,
					'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
					'Autorizante' = ur_autorizante,
					'Nombre Aut.' = fu_nombre               
                --inicio mig syb-sql 18042016   
                from    ad_usuario_rol
                        inner join ad_rol on ur_rol = ro_rol
                        inner join cl_filial on ro_filial = fi_filial              
                        
                        left outer join cl_funcionario on ur_autorizante = fu_funcionario
                        left outer join ad_tipo_horario on ur_tipo_horario = th_tipo
               where    ur_estado = 'V'
                 and    ur_login = @i_login
                 and    ur_rol > @i_rol
                order   by ur_login, ur_rol
                --fin  mig syb-sql 18042016
                
                /****** MIGRACION SYB-SQL 
				from   ad_usuario_rol, cl_filial, ad_rol, cl_funcionario,
					ad_tipo_horario
				where   ur_autorizante *= fu_funcionario
				and   ur_rol = ro_rol
				and   ro_filial = fi_filial              
				and   ur_login = @i_login
				and   ur_tipo_horario *= th_tipo
				and   ur_rol > @i_rol
				and   ur_estado = 'V'
				order   by ur_login, ur_rol
                ******/

				if @@rowcount = 0
					begin
						exec sp_cerror
							@t_debug      = @t_debug,
							@t_file       = @t_file,
							@t_from       = @w_sp_name,
							@i_num        = 151172
						--NO EXISTEN REGISTROS
						return 1
					end

				set rowcount 0
				return 0
			end

		if @i_modo = 4
			begin
				set rowcount 20
				select  'Codigo' = X.fu_funcionario,
					'Login' = ur_login,
					'Nombre Trabajador' = X.fu_nombre,
					'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
					'Autorizante' = ur_autorizante,
					'Nombre Aut.' = Y.fu_nombre
                --inicio mig syb-sql 18042016   
                from    ad_usuario_rol                
                        inner join cl_funcionario X on ur_login = X.fu_login
                        left outer join cl_funcionario Y on ur_autorizante = Y.fu_funcionario
               where    ur_estado = 'V'
                 and    ur_rol = @i_rol
                order   by ur_login
                --fin  mig syb-sql 18042016
                
                /****** MIGRACION SYB-SQL 
				from    ad_usuario_rol, cl_funcionario X, cl_funcionario Y
				where   --isnull(ur_autorizante, 0)= Y.fu_funcionario
					ur_autorizante *= Y.fu_funcionario
				and   ur_login = X.fu_login
				and   ur_rol = @i_rol
				and    ur_estado = 'V'
				order   by ur_login
                ******/

				set rowcount 0
				return 0
			end

		--TODOS
		if @i_modo = 5
			begin
				set rowcount 20
				select  'Codigo' = X.fu_funcionario,
					'Login' = ur_login,
					'Nombre Trabajador' = X.fu_nombre,
					'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
					'Autorizante' = ur_autorizante,
					'Nombre Aut.' = Y.fu_nombre
                --inicio mig syb-sql 18042016   
                from    ad_usuario_rol                
                        inner join cl_funcionario X on ur_login = X.fu_login
                        left outer join cl_funcionario Y on ur_autorizante = Y.fu_funcionario
               where    ur_estado = 'V'
                 and    ur_rol = @i_rol
                 and    ur_login > @i_login
                order   by ur_login
                --fin  mig syb-sql 18042016
                
                /****** MIGRACION SYB-SQL 
				from    ad_usuario_rol, cl_funcionario X, cl_funcionario Y
				where   ur_autorizante *= Y.fu_funcionario
				and   ur_login = X.fu_login
				and   ur_rol = @i_rol
				and   ur_login > @i_login
				and   ur_estado = 'V'
				order   by ur_login
                ********/

				set rowcount 0
				return 0
			end

		if @i_modo = 6
			begin
				set rowcount 20
				select  'Login' = ur_login,
					'Trabajador' = fu_funcionario,
					'Nombre' = fu_nombre,
					'Cod. Rol' = ur_rol,
					'Rol' =  substring(ro_descripcion, 1, 20)
                --inicio mig syb-sql 18042016   
                from    ad_usuario_rol
                        inner join ad_rol on ur_rol = ro_rol
                        left outer join cl_funcionario on ur_autorizante = fu_funcionario
               where    ur_estado = 'V'
				and    ((ur_login > isnull(@i_login,ur_login))
				or     ((ur_login = isnull(@i_login,ur_login)) and (ur_rol > @i_rol)))
                order   by ur_login, ur_rol
                --fin  mig syb-sql 18042016
                
                /****** MIGRACION SYB-SQL 
				from    ad_usuario_rol, ad_rol, cl_funcionario
				where   ur_login *= fu_login
				and   ur_rol = ro_rol
				and  ((ur_login > isnull(@i_login,ur_login))
				or   ((ur_login = isnull(@i_login,ur_login)) and (ur_rol > @i_rol)))
				and    ur_estado = 'V'
				order   by ur_login, ur_rol
                *******/

				set rowcount 0
				return 0
			end
	end

/* ** Query ** */
if @i_operacion = 'Q'
begin
      select distinct  
            @o_nombre_r         = substring(ro_descripcion, 1, 20),
            @o_autorizante      = ur_autorizante,
            @o_fecha_aut        = ur_fecha_aut,
            @o_tipo_horario     = ur_tipo_horario,
            @o_descripcion_tipo = substring(th_descripcion, 1, 30),
            @o_fec_cad_rol	    = ur_fec_cad_rol,
            @o_fecha_ini_rol	= ur_fecha_ini_rol
        --inicio mig syb-sql 18042016   
        from    ad_usuario_rol
                inner join ad_rol on ur_rol = ro_rol
                inner join cl_filial on ro_filial = fi_filial              
                
                left outer join ad_tipo_horario on ur_tipo_horario = th_tipo
       where    ur_estado = 'V'
         and    ur_login = @i_login
         and    ur_rol > @i_rol
        --order   by ur_login, ur_rol
        --fin  mig syb-sql 18042016
        
        /****** MIGRACION SYB-SQL         
	 from   ad_usuario_rol, ad_rol, ad_tipo_horario, cl_funcionario
	 where  ur_rol = ro_rol
	  and   ur_login = @i_login
	  and   ur_tipo_horario *= th_tipo
	  and   ur_rol = @i_rol
	  and   ur_estado = 'V'
        ******/
	  
	if @@rowcount = 0
	begin
	  exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe Usuario Rol' */
	  return 1
	end

	select @o_nombre_aut = fu_nombre
	from cl_funcionario
	where fu_funcionario = @o_autorizante
	if @@rowcount = 0
	begin
		exec sp_cerror
		     @t_debug     = @t_debug,
		     @t_file  = @t_file,
		     @t_from      = @w_sp_name,
		     @i_num       = 101036
		     /* 'No existe funcionario' */
	end

	select @i_login,            @i_rol,      
	       @o_nombre_r,         @o_tipo_horario,
	       @o_descripcion_tipo, @o_autorizante,
	       @o_nombre_aut,       
	       convert(char(10), @o_fecha_aut, @i_formato_fecha),
	       convert(char(10),@o_fec_cad_rol, @i_formato_fecha),
	       convert(char(10),@o_fecha_ini_rol, @i_formato_fecha)
		       
	return 0
   end
 
GO


