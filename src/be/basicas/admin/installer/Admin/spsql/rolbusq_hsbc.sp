/************************************************************************/
/*	Archivo:			rolbusq_hsbc.sp									*/
/*	Stored procedure:	sp_rolbusq_hsbc									*/
/*	Base de datos:		cobis											*/
/*	Producto:			Administracion									*/
/*	Disenado por:  		Javier García López								*/
/*	Fecha de escritura: 01-Jun-2012										*/
/************************************************************************/
/*				IMPORTANTE												*/
/*	Este programa es parte de los paquetes bancarios propiedad de		*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la		 	*/
/*	"NCR CORPORATION".													*/
/*	Su uso no autorizado queda expresamente prohibido asi como			*/
/*	cualquier alteracion o agregado hecho por alguno de sus				*/
/*	usuarios sin el debido consentimiento por escrito de la			 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.					*/
/*				PROPOSITO												*/
/*	Este programa procesa las transacciones de busqueda de roles		*/
/*	conforme a los sigientes criterios  de busqueda :					*/
/*	Codigo																*/
/*	Nombre																*/
/*				MODIFICACIONES											*/
/*	FECHA		AUTOR		RAZON										*/
/*	24-Jul-2012	Miguel Aldaz	HSBC INC-598 QUITE SUBSTRING DE 30 A ro_descripcion	*/
/*	6-Abr-2015	JTA  	FIE - Se cambia Dpto x Oicina en Select de salida	*/
/************************************************************************/

use cobis
go


if exists (select * from sysobjects where name = 'sp_rolbusq_hsbc')
   drop proc sp_rolbusq_hsbc
go


create proc sp_rolbusq_hsbc (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint = null,
	@t_show_version         bit  = 0,
	@i_tipo			char(1) = null,
	@i_modo			smallint = null,
    @i_rol          tinyint = null,
    @i_descripcion  varchar(30) = null,
	@i_valor		varchar(30) = '%',
	@o_mc_authorizationId 	int = 0 out      
)
as
declare
	@w_sp_name		varchar(32)
	

select @w_sp_name = 'sp_rolbusq_hsbc'
------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_rolbusq_hsbc, version 4.0.0.3'
      return 0
end

/* ** help ** */   

begin
if @i_tipo = '1'
begin
     set rowcount 20
     if @i_modo = 0
     begin

	select	'Cod. Rol' 		 = ro_rol,
			'Descripcion' 	 = ro_descripcion, --substring(ro_descripcion, 1, 30),
			'Cod. Filial' 	 = ro_filial,
			'Filial' 		 = fi_abreviatura,
			'Creador' 		 = ro_creador,
			'Nombre Creador' = fu_nombre,
			'Admin Seg' 	 = ro_admin_seg--,
			--'Oficina' 	     = ro_oficina
	 from	ad_rol, cl_filial, cl_funcionario
	where	convert(varchar,ro_rol) like '%'+@i_valor+'%'
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
        order   by ro_rol, ro_filial

        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End

        
       set rowcount 0
     end


     if @i_modo = 1
     begin
	select	'Cod. Rol' 	 	 = ro_rol,
			'Descripcion' 	 = ro_descripcion,--substring(ro_descripcion, 1, 30),
			'Cod. Filial' 	 = ro_filial,
			'Filial' 		 = fi_abreviatura,
			'Creador' 		 = ro_creador,
	   		'Nombre Creador' = fu_nombre,
			'Admin Seg' 	 = ro_admin_seg--,
			--'Oficina' 	     = ro_oficina
	 from	ad_rol, cl_filial, cl_funcionario
	where	convert(varchar,ro_rol) like '%'+@i_valor+'%'
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
	  and	ro_rol > @i_rol
        order   by ro_rol, ro_filial

        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End


       set rowcount 0
     end
 return 0
end 


if @i_tipo = '2'
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Rol' 		 = ro_rol,
			'Descripcion' 	 = ro_descripcion,--substring(ro_descripcion, 1, 30),
	   		'Cod. Filial' 	 = ro_filial,
	   		'Filial' 		 = fi_abreviatura,
	   		'Creador' 		 = ro_creador,
	   		'Nombre Creador' = fu_nombre,
	   		'Admin Seg' 	 = ro_admin_seg--,
			--'Oficina' 	     = ro_oficina			
	 from	ad_rol, cl_filial, cl_funcionario
	where	substring(ro_descripcion, 1, 30) like '%'+@i_valor+'%'
	  and   ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
        order   by ro_descripcion

        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End


       set rowcount 0
     end


     if @i_modo = 1
     begin
	select	'Cod. Rol' 		 = ro_rol,
			'Descripcion' 	 = ro_descripcion,--substring(ro_descripcion, 1, 30),
			'Cod. Filial' 	 = ro_filial,
			'Filial' 		 = fi_abreviatura,
			'Creador' 		 = ro_creador,
			'Nombre Creador' = fu_nombre,
			'Admin Seg' 	 = ro_admin_seg--,
			--'Oficina' 	     = ro_oficina
	 from	ad_rol, cl_filial, cl_funcionario
	where	substring(ro_descripcion, 1, 30) like '%'+@i_valor+'%'
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
	  and   substring(ro_descripcion,1,30) > @i_descripcion
        order   by ro_descripcion

        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End


       set rowcount 0
     end
 return 0
end 
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end

go

