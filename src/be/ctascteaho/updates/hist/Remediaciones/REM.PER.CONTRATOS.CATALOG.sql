USE cobis
GO


declare @i_producto         char(3),
        @w_tabla            smallint,  
        @i_tabla            VARCHAR(35)
        
        
SELECT  @i_tabla = 're_plantillas', @i_producto = 'ADM' 
	  
if exists ( select 1  from cobis..cl_tabla  where tabla = @i_tabla)
BEGIN
	
	select @w_tabla = codigo
    from cl_tabla
    where tabla = @i_tabla
	
	select @w_tabla	
	  
     /* verificar que no exista la tabla previamente */
     if exists (select 1  from cobis..cl_catalogo_pro where cp_tabla = @w_tabla and cp_producto = @i_producto)
     begin
        PRINT 'Ya xiste el catalogo asociado en la tabla cobis..cl_catalogo_pro'
     end
     ELSE
     begin
       insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
        values (@i_producto, @w_tabla)
    end  
END

use cobis
go


delete cobis..cl_errores where numero in (351134)

INSERT INTO cobis..cl_errores VALUES (351134, 0, 'El registro no tuvo modificacciones')

go