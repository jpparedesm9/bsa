
/************************************************************************/
/*   Archivo:              conscligr.sp                                 */
/*   Stored procedure:     sp_consulta_cliente_grupo                    */
/*   Base de datos:        cobis                                        */
/*   Producto:             Cartera                                      */
/*   Disenado por:         DFu                                          */
/*   Fecha de escritura:   Julio 2017                                   */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Consulta un cliente o grupo solidario en base a un nombre ingresado*/
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  31/MAY/2019  SRO               Emision inicial                      */
/*  27/AGO/2019  SMO               Paginación Mejora #124843            */
/************************************************************************/
use cobis
go

IF OBJECT_ID ('dbo.sp_consulta_cliente_grupo') IS NOT NULL
	DROP PROCEDURE dbo.sp_consulta_cliente_grupo
GO

CREATE PROCEDURE sp_consulta_cliente_grupo (   
   @i_nombre             varchar(255),
   @i_tipo               char(2),
   @i_siguiente          int     
)
as 

declare
@w_error                    int,
@w_msg                      varchar(255),
@w_sp_name                  varchar(30),
@w_char_spliter             CHAR,
@w_ids                      VARCHAR(255),
@w_number                   VARCHAR(255),
@w_paginacion               int

select @w_sp_name = 'sp_consulta_cliente_grupo'
select @w_paginacion = pa_int from cobis..cl_parametro where pa_nemonico = 'PAGNC'

	
if len(@i_nombre) < 5 begin
   select
   @w_error = 103201,   
   @w_msg = 'El criterio de búsqueda debe tener mínimo 5 caracteres.'
   
   goto ERROR
end

declare @w_cliente_consulta TABLE(
   id int primary key identity(1,1),
      ente          INT,
      nombre        VARCHAR(255))
      
if @i_tipo = 'S' begin --Grupo Solidario
   
  /* select 
   0,
   gr_grupo,
   gr_nombre
   from cl_grupo
   where upper(ltrim(rtrim(gr_nombre))) like '%'+ upper(rtrim(ltrim(@i_nombre))) + '%'
   
   if @@rowcount = 0 begin
      select 
	  @w_error = 103202,
	  @w_msg   = 'No se encontraron coincidencias para el criterio de búsqueda.'	
	  goto ERROR
   end */
   
     insert into @w_cliente_consulta
   SELECT gr_grupo, gr_nombre FROM  cl_grupo 
   WHERE upper(ltrim(rtrim(gr_nombre))) like '%'+ upper(rtrim(ltrim(@i_nombre))) + '%'
   order by gr_nombre
      
    if @@rowcount = 0 begin
      select 
	  @w_error = 103202,
	  @w_msg   = 'No se encontraron coincidencias para el criterio de búsqueda.'	
	  goto ERROR
   end 
   
    set rowcount @w_paginacion
    SELECT id, ente, nombre FROM  @w_cliente_consulta
    where id >  @i_siguiente

end
else if @i_tipo = 'P' begin --Persona

   declare @nombres  table (
      nombre         varchar(60)   
   )
   
   declare @w_cliente TABLE(
      
      ente          INT,
      nombre        VARCHAR(255))
      
  /* declare @w_cliente_consulta TABLE(
   id int primary key identity(1,1),
      ente          INT,
      nombre        VARCHAR(255))*/
      
   
   select @w_char_spliter = ' '
   select @w_ids = @i_nombre + @w_char_spliter
	
   while CHARINDEX(@w_char_spliter, @w_ids) > 0
   begin
    
       select @w_number = SUBSTRING(@w_ids, 0, CHARINDEX(@w_char_spliter, @w_ids))
	   
       select @w_ids = SUBSTRING(@w_ids, CHARINDEX(@w_char_spliter, @w_ids) + 1, LEN(@w_ids))

       IF @w_number IS NOT NULL and @w_number <> '' begin
          insert into @nombres
          select @w_number+'%'
       end
   end    
   
 
   select  @i_nombre = ''
   select @i_nombre =  @i_nombre + nombre from @nombres
	
   
   INSERT INTO @w_cliente 
   select 
   en_ente,
   upper(rtrim(ltrim(isnull(rtrim(ltrim(en_nombre)),'') +(CASE WHEN en_nombre IS NOT NULL then ' ' ELSE ''end)
         + isnull(rtrim(ltrim(p_s_nombre)),'')+(CASE WHEN p_s_nombre IS NOT NULL then ' ' ELSE ''end)
         +isnull(rtrim(ltrim(p_p_apellido)),'')+(CASE WHEN p_p_apellido IS NOT NULL then ' ' ELSE '' end)
         +isnull(rtrim(ltrim(p_s_apellido)),'')+(CASE WHEN p_s_apellido IS NOT NULL then ' ' ELSE '' end))))
   from cl_ente, cl_ente_aux
   where en_ente = ea_ente
   and   ea_estado = 'A'
 
   insert into @w_cliente_consulta
   SELECT ente, nombre FROM  @w_cliente WHERE nombre  
   like '%'+ upper(ltrim(rtrim(@i_nombre)))
   order by nombre
      
    if @@rowcount = 0 begin
      select 
	  @w_error = 103202,
	  @w_msg   = 'No se encontraron coincidencias para el criterio de búsqueda.'	
	  goto ERROR
   end 
   
   
   set rowcount @w_paginacion
    SELECT id, ente, nombre FROM  @w_cliente_consulta
    where id >  @i_siguiente
   
end
else begin
   select 
   @w_error = 103200,
   @w_msg   = 'Tipo no coincide para un Cliente o Grupo.'	
   goto ERROR

end

return 0

ERROR:
begin --Devolver mensaje de Error 
exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file  = '',
     @t_from  = @w_sp_name,
     @i_num   = @w_error
	 
return @w_error
end

GO
