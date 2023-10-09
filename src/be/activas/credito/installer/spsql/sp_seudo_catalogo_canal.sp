/*************************************************************************/
/*   Archivo:            sp_seudo_catalogo_canal.sp                      */
/*   Stored procedure:   sp_seudo_catalogo_canal                         */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           CWF                                             */
/*   Disenado por:       KVI                                             */
/*   Fecha de escritura: Marzo 2023                                      */
/*************************************************************************/
/*                       IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*  Procedimiento para consultas del canal                               */
/*************************************************************************/
/*                       MODIFICACIONES                                  */
/*  FECHA        AUTOR              RAZON                                */
/*  20/03/2023   KVI     Emision Inicial - Caso203112                    */
/*************************************************************************/
use cob_workflow
go

if exists(select 1 from sysobjects where name = 'sp_seudo_catalogo_canal' and type = 'P')
begin
    drop proc sp_seudo_catalogo_canal
end
go

create proc sp_seudo_catalogo_canal (
    @t_show_version    bit          = 0,
    @i_tipo            char(1)      = null,
    @i_tabla           varchar(30)  = null,
    @i_codigo          varchar(150) = null,
    @i_oficina         int          = 1,
    @i_filas           int          = 80,
	@i_descripcion     varchar(150) = ''
)
as
declare 
@w_sp_name    varchar(32) ,
@w_mensaje    varchar(255),
@w_error      int

select @w_sp_name = 'sp_seudo_catalogo_canal'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
   print 'Stored procedure '+ @w_sp_name +' Version 1.0.0.0'
   return 0
end
-------------------------------------

if @i_tipo = 'B' begin
    set rowcount @i_filas
	
	select convert(varchar, ca_canal),
	       ca_nombre 
	from cobis..cl_canal 
	where ca_estado = 'V'
	and ca_nombre > isnull(@i_codigo, '')
	order by ca_nombre asc
    set rowcount 0
    return 0
end

if @i_tipo = 'V'
begin
	select ca_nombre 
	from cobis..cl_canal 
	where ca_estado = 'V'
	and ca_canal = @i_codigo

    if @@rowcount =  0 
	begin
		select	@w_error	= 101001,
				@w_mensaje	= 'No existe dato solicitado'
		goto ERROR
	end    
   return 0
end

if @i_tipo = 'S'
begin
    set rowcount @i_filas
	   
	select convert(varchar, ca_canal),
	       ca_nombre 
	from cobis..cl_canal 
    where ca_estado = 'V'
	and ca_nombre > isnull(@i_codigo, '')
	and upper(ca_nombre) like '%' + upper(@i_descripcion) + '%' 
	order by ca_nombre asc
	  
    set rowcount 0
    return 0
end

if @i_tipo = 'C'
begin
    if (@i_descripcion <> null and @i_descripcion <> '')
	begin	  
	    select count( ca_canal)
		from cobis..cl_canal 
		where ca_estado = 'V'
		and ca_nombre > isnull(@i_codigo, '')
		and upper(ca_nombre) like '%' + upper(@i_descripcion) + '%' 	  
	end
	else
	begin	  
		select count(ca_canal)
		from cobis..cl_canal 
		where ca_estado = 'V'
		and ca_nombre > isnull(@i_codigo, '')
	end
	
	return 0
end

return 0

ERROR: 
	exec cobis..sp_cerror
		@t_debug	= 'N',
		@t_file 	= null,
		@t_from 	= @w_sp_name,
		@i_msg		= @w_mensaje,
		@i_num  	= @w_error
	return @w_error
go
