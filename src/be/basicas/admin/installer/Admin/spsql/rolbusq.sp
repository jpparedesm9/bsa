/************************************************************************/
/*	Archivo:		rolbusq.sp				*/
/*	Stored procedure:	sp_rolbusq				*/
/*	Base de datos:		cobis					*/
/*	Producto:		Administracion				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 31-Ene-1994					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de busqueda de roles	*/
/*	conforme a los sigientes criterios  de busqueda :		*/
/*	Codigo								*/
/*	Nombre								*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	31/Ene/1994	F.Espinosa	Emision inicial			*/
/*	05/May/94	F.Espinosa	Parametros tipo "S"		*/
/*	09/Jun/95	Bco.Prestamos 	Considerar estado del Rol	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_rolbusq')
   drop proc sp_rolbusq
go

create proc sp_rolbusq (
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
	@i_tipo			char(1) = null,
	@i_modo			smallint = null,
        @i_rol                  tinyint = null,
        @i_descripcion          varchar(30) = null,
	@i_valor		varchar(30) = '%'
)
as
declare
	@w_sp_name		varchar(32)

select @w_sp_name = 'sp_rolbusq'


If @t_trn = 15044
begin
if @i_tipo = '1'
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Rol' = ro_rol,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre
	 from	ad_rol, cl_filial, cl_funcionario
	where	convert(varchar,ro_rol) like @i_valor
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
        /*and   ro_estado = 'V'*/
        order   by ro_rol, ro_filial

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
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
        /* Fin ARO */

        
       set rowcount 0
     end


     if @i_modo = 1
     begin
	select	'Cod. Rol' = ro_rol,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre
	 from	ad_rol, cl_filial, cl_funcionario
	where	convert(varchar,ro_rol) like @i_valor
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
	  and	ro_rol > @i_rol
        /*and   ro_estado = 'V'*/
        order   by ro_rol, ro_filial

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
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
        /* Fin ARO */


       set rowcount 0
     end
 return 0
end 


if @i_tipo = '2'
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Rol' = ro_rol,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre
	 from	ad_rol, cl_filial, cl_funcionario
	where	substring(ro_descripcion, 1, 20) like @i_valor
	  and   ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
       /* and   ro_estado = 'V'*/
        order   by ro_descripcion

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
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
        /* Fin ARO */


       set rowcount 0
     end


     if @i_modo = 1
     begin
	select	'Cod. Rol' = ro_rol,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre
	 from	ad_rol, cl_filial, cl_funcionario
	where	substring(ro_descripcion, 1, 20) like @i_valor
	  and	ro_filial = fi_filial
	  and	ro_creador = fu_funcionario
	  and	ro_rol > @i_rol
       /* and   ro_estado = 'V'*/
	  and   ro_descripcion < @i_descripcion
        order   by ro_descripcion

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
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
        /* Fin ARO */


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
