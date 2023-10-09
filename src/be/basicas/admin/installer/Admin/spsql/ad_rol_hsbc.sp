/************************************************************************/
/*      Archivo:                ad_rol_hsbc.sp                          */
/*      Stored procedure:       sp_ad_rol_hsbc                          */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:           Javier García López                     */
/*      Fecha de escritura: 	01-Jun-2012                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                                                                      */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de rol                                                */
/*      Actualizacion del rol                                           */
/*      Borrado del rol                                                 */
/*      Busqueda del rol                                                */
/*      Query del rol                                                   */
/*      Ayuda del rol                                                   */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      17/07/2012   J. Salazar      Incidencia HSBC-ADM-INC-548        */
/*      24/07/2012   Miguel.Aldaz    Incidencia HSBC-ADM-INC-598        */
/*      14/09/2012   Mario Velez     Se aplica Validaciones para M&C    */
/*		01/Feb/13	P.Montenegro     Añadir campo ofi INC-REDMINE-17559 */
/*      11-Abr-16    BBO             Migracion Sybase-Sqlserver FAL     */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ad_rol_hsbc')
   drop proc sp_ad_rol_hsbc
go


create proc sp_ad_rol_hsbc 
(
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint =NULL,
	@t_show_version         bit  = 0,
	@mc_validacion          int = 0,                -- Mario Velez, 14/Sep/2012, Para Validaciones de M&C
	@i_operacion            varchar(1),
	@i_tipo                 varchar(1) = null,
	@i_modo                 smallint = null,
	@i_rol                  tinyint = null,
	@i_filial               tinyint = null,
	@i_oficina              tinyint = null,
	@i_descripcion          descripcion = NULL,
	@i_creador              smallint = NULL,
	@i_fecha_crea           datetime = null,
	@i_time_out             smallint = null,
	@i_central_transmit     varchar (1) = NULL,
	@i_estado				estado = NULL,
	@i_formato_fecha		int=NULL,                                                      
	@i_admin_seg            varchar(1) = NULL,
	@i_departamento     	smallint = NULL,
	@i_funcionario          smallint = null,   --JSA 17072012 HSBC-ADM-INC-548
	@o_admin_seg     		varchar(1) = NULL,
	@o_departamento   		smallint = NULL,
	@o_detalle              varchar(70) = null,
	@o_oficina   			smallint = NULL,
	@o_des_oficina          varchar(70) = null,
	@o_mc_authorizationId 	int = 0 out                                              
	  
)
as
declare
	@w_today                datetime,
	@w_return               int,
	@w_sp_name              varchar(32),
	@w_fecha_crea           datetime,
	@w_filial               tinyint,
	@w_descripcion          descripcion,
	@w_creador              smallint,                                 
	@w_time_out             smallint,
	@w_estado				estado,
	@v_fecha_crea           datetime,                  
	@v_filial               tinyint,
	@v_descripcion          descripcion,
	@v_creador              smallint,
	@v_time_out             smallint,
	@v_estado				estado,
	@o_rol                  tinyint,
	@o_fecha_crea           datetime,
	@o_time_out             smallint,
	@o_filial               tinyint,
	@o_nombre_f             descripcion,
	@o_descripcion          descripcion,
	@o_creador              smallint,
	@o_estado				estado,
	@w_siguiente            int,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_crea          descripcion,
	@w_comando              descripcion,
    @w_cmdtransrv           varchar(64),
	@w_nt_nombre            varchar(32),
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_clave				int,
	@w_admin_seg       	 	varchar(1),
	@w_departamento     	smallint,
	@w_rol					tinyint,
	@w_oficina     			smallint,
	@v_oficina		     	smallint
	
	
	
/*****MC Mario Velez, 14/Sep/2012*****/
if @mc_validacion = 1
  begin 
      return 0
  end
/*****MC*****/



select @w_today = @s_date
select @w_sp_name = 'sp_ad_rol_hsbc'
------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_ad_rol_hsbc, version 4.0.0.2'
      return 0
end

/* ** help ** */
if @i_operacion = 'I'
begin
	select @w_rol = max(ro_rol) from ad_rol 
		 			   
	update ad_rol set 	ro_admin_seg = @i_admin_seg--,
						--ro_departamento = @i_departamento,
						--ro_oficina = @i_oficina
	where ro_rol = @w_rol
	 

	update ts_ad_rol set admin_seg = @i_admin_seg--,
						 --departamento = @i_departamento,
						 --oficina = @i_oficina
		where fecha = @i_fecha_crea
		and rol = @w_rol
		and usuario = @s_user
		and terminal_s = @s_term
		and oficina_s = @s_ofi
		and clase = 'N'

end
	
if @i_operacion = 'U'
begin
	select 	@w_admin_seg = ro_admin_seg--,
			--@w_departamento = ro_departamento,
			--@w_oficina = ro_oficina
	from ad_rol 
	where ro_rol = @i_rol

	update ad_rol set ro_admin_seg = @i_admin_seg--,
		  --ro_departamento = @i_departamento,
		  --ro_oficina = @i_oficina
	where ro_rol = @i_rol


	update ts_ad_rol set 	admin_seg = @i_admin_seg--,
							--departamento = @i_departamento,
							--oficina = @i_oficina
	where fecha = @s_date
	and rol = @i_rol
	and usuario = @s_user
	and terminal_s = @s_term
	and oficina_s = @s_ofi
	and clase in('P','A')
end	
	
if @i_operacion = 'D'  
begin	
		select 	@w_admin_seg = ro_admin_seg--,
				--@w_departamento = ro_departamento,
				--@w_oficina = ro_oficina
			from ad_rol 
			where ro_rol = @i_rol
		 
		update ts_ad_rol set 	admin_seg = @w_admin_seg--,
								--departamento = @w_departamento,
								--oficina = @i_oficina
			where fecha = @s_date
			and rol = @i_rol
			and usuario = @s_user
			and terminal_s = @s_term
			and oficina_s = @s_ofi
			and clase = 'B'
	end
  	

if @i_operacion = 'Q'	
begin
			select  @o_rol 				= @i_rol,        
					@o_nombre_f 		= fi_nombre,
					@o_descripcion 		= ro_descripcion,
					@o_filial 			= ro_filial,
					@o_creador 			= ro_creador,
					@o_nombre_crea 		= fu_nombre,
					@o_fecha_crea 		= ro_fecha_crea,
					@o_time_out   		= ro_time_out,
					@o_estado 			= ro_estado,
					@o_admin_seg 		= ro_admin_seg--,
					--@o_departamento 	= ro_departamento,
					--@o_detalle      	= de_descripcion,
					--@o_oficina   		= of_oficina,
					--@o_des_oficina      = of_nombre
				 from   ad_rol d, 
						--left join cobis..cl_oficina on ro_oficina = of_oficina
						--left join cobis..cl_departamento on ro_departamento = de_departamento and ro_oficina = de_oficina, 
						cl_filial, cl_funcionario
				where   ro_filial = fi_filial
				  and   ro_creador = fu_funcionario
				  and   ro_rol = @i_rol


				if @@rowcount = 0
				begin
				 exec sp_cerror
				   @t_debug      = @t_debug,
				   @t_file       = @t_file,
				   @t_from       = @w_sp_name,
				   @i_num        = 151026

				  	return 1
				end
				

				select @i_rol, @o_descripcion, @o_filial, @o_nombre_f, @o_creador,
				       @o_nombre_crea, convert(char(10), @o_fecha_crea, @i_formato_fecha),
				       @o_time_out, @o_estado,@o_admin_seg--,@o_departamento,@o_detalle, @o_oficina, @o_des_oficina
	end	

if @i_operacion = 'H'
begin
   /* JSA 17072012 HSBC-ADM-INC-548 */
   /* OBTENER CODIGO DEPARATAMENTO FUNCIONARIO */
   if @i_funcionario is not null
   begin
   select @w_departamento = fu_departamento
   from cl_funcionario
   where fu_funcionario = @i_funcionario
	
   if @@rowcount = 0
   begin
      exec sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 151026
      return 1
   end
   end
   /* FIN JSA 17072012 HSBC-ADM-INC-548 */
	
 if @i_tipo = 'A'
 begin 
    set rowcount 20
    if @i_modo = 0
        select   'Codigo' = ro_rol,
		  'Rol'    = ro_descripcion, --'Rol'    = substring(ro_descripcion, 1, 20) --MAP HSBC-INC-598
		  'Filial' = substring(fi_nombre, 1, 20),
		  'Protector Pantalla' = ro_time_out,
		  'Estado' = ro_estado,
		  'Adm.Seguridad'= ro_admin_seg--,
		  --'Departamento' = ro_departamento
	   from   ad_rol, cl_filial
	  where   ro_filial = fi_filial
	   --and   (ro_departamento = @w_departamento or @w_departamento is null) --JSA 17072012 HSBC-ADM-INC-548
	   order  by ro_rol
	   
    else
	    select   'Codigo' = ro_rol,
		  'Rol'    = ro_descripcion, --'Rol'    = substring(ro_descripcion, 1, 20),  --MAP HSBC-INC-598
		  'Filial' = substring(fi_nombre, 1, 20),
		  'Protector Pantalla' = ro_time_out,
		  'Estado' = ro_estado,
		  'Adm.Seguridad'= ro_admin_seg--,
		  --'Departamento' = ro_departamento
	   from   ad_rol, cl_filial
	  where   ro_filial = fi_filial
	    --and   (ro_departamento = @w_departamento or @w_departamento is null) --JSA 17072012 HSBC-ADM-INC-548
           and   ro_rol    > @i_rol
	   order  by ro_rol
         set rowcount 0  
 end
 
if @i_tipo = 'V'
 begin
   select   ro_descripcion, --substring(ro_descripcion, 1, 20), --MAP HSBC-INC-598
		  substring(fi_nombre, 1, 20),
		  ro_time_out,
		  ro_estado,
		  ro_admin_seg--,
		  --ro_departamento
	   from   ad_rol, cl_filial
	  where   ro_rol = @i_rol
	    and   ro_filial = fi_filial
	    --and   (ro_departamento = @w_departamento or @w_departamento is null) --JSA 17072012 HSBC-ADM-INC-548
	
	 if @@rowcount = 0
	 begin
		 exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 151026
			/*  'No existe Rol' */
		 return 1
	 end
 end
end
 
return 0
  		

go

