use cobis
go


delete
from cobis..cl_parametro
where pa_nemonico = 'CAAPSO'


declare @w_codigo_tabla int

select @w_codigo_tabla = codigo
from cobis..cl_tabla
where tabla = 'cl_tipo_medio'

select  * from cobis..cl_catalogo where tabla = @w_codigo_tabla


if exists(select  1 from cobis..cl_catalogo where tabla = @w_codigo_tabla and   codigo = 3)
begin 
   delete from cobis..cl_catalogo where tabla = @w_codigo_tabla and codigo = 3
end    

select  * from cobis..cl_catalogo where tabla = @w_codigo_tabla

