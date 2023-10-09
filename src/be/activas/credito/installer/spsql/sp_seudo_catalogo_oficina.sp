/*******************************************************************/
/*   ARCHIVO:         seudo_catalogo_oficina.sp                    */
/*   NOMBRE LOGICO:   sp_seudo_catalogo_oficina                    */
/*   PRODUCTO:        CWF                                          */
/*******************************************************************/
/*   IMPORTANTE                                                    */
/*   Esta aplicacion es parte de los  paquetes bancarios           */
/*   propiedad de MACOSA S.A.                                      */
/*   Su uso no autorizado queda  expresamente  prohibido           */
/*   asi como cualquier alteracion o agregado hecho  por           */
/*   alguno de sus usuarios sin el debido consentimiento           */
/*   por escrito de MACOSA.                                        */
/*   Este programa esta protegido por la ley de derechos           */
/*   de autor y por las convenciones  internacionales de           */
/*   propiedad intelectual.  Su uso  no  autorizado dara           */
/*   derecho a MACOSA para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los           */
/*   autores de cualquier infraccion.                              */
/*******************************************************************/
/*                          PROPOSITO                              */
/*  Procedimiento para consultas de usuario                        */
/*******************************************************************/
/*                     MODIFICACIONES                              */
/*   FECHA        AUTOR              RAZON                         */
/*   06/Sep/2022  Sonia Rojas   Emision Inicial                    */
/*******************************************************************/
use cob_workflow
go

if exists(select 1 from sysobjects where name = 'sp_seudo_catalogo_oficina' and type = 'P')
begin
    drop proc sp_seudo_catalogo_oficina
end
go

create proc sp_seudo_catalogo_oficina (

    @t_show_version    BIT = 0,
    @i_tipo            char(1) = null,
    @i_tabla           varchar(30) = null,
    @i_codigo          varchar(150) = null,
    @i_oficina         int = 1,
    @i_filas           int = 80,
	@i_descripcion     varchar(150) = ''
)

as

declare 
@w_sp_name    varchar(32) ,
@w_mensaje            varchar(255),
@w_error              int

select @w_sp_name = 'sp_seudo_catalogo_oficina'

---- VERSIONAMIENTO DEL PROGRAMA ----
IF @t_show_version = 1
BEGIN
   PRINT 'Stored procedure '+ @w_sp_name +' Version 1.0.0.0'
   RETURN 0
END
-------------------------------------

if @i_tipo = 'B' begin
    set rowcount @i_filas
	
	select convert(varchar, of_oficina),
	       of_nombre 
	  from cobis..cl_oficina 
	 where of_subtipo = 'O'
	  and of_nombre > isnull(@i_codigo, '')
	order by of_nombre asc
    set rowcount 0
    return 0
end

if @i_tipo = 'V'
begin
	select of_nombre 
	  from cobis..cl_oficina 
	 where of_subtipo = 'O'
	   and of_oficina = @i_codigo

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
	   
	   select convert(varchar, of_oficina),
	       of_nombre 
	  from cobis..cl_oficina 
	 where of_subtipo = 'O'
	  and of_nombre > isnull(@i_codigo, '')
	  and UPPER(of_nombre) like '%' + UPPER(@i_descripcion) + '%' 
	order by of_nombre asc

	  
    set rowcount 0
    return 0
end

if @i_tipo = 'C'
begin
    if (@i_descripcion <> null and @i_descripcion <> '')
	  begin	  
	     select count( of_oficina)
		  from cobis..cl_oficina 
		 where of_subtipo = 'O'
		  and of_nombre > isnull(@i_codigo, '')
		  and UPPER(of_nombre) like '%' + UPPER(@i_descripcion) + '%' 
	  
	  end
	else
	  begin
	  
		  select count(of_oficina)
		  from cobis..cl_oficina 
		 where of_subtipo = 'O'
		  and of_nombre > isnull(@i_codigo, '')
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
