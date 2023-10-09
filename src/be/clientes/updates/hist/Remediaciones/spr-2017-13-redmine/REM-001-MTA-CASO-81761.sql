/**********************************************************************************************************************/
--No Bug                     : REDMINE 81761
--Título de la Historia      : N/A
--Fecha                      : 28/06/2017
--Descripción del Problema   : Resolver los errores reportados por el banco con el caso redmine
--Descripción de la Solución : Corregir lo reportado en el caso 81761
--Autor                      : Maria Jose Taco
--Instalador                 : cl_insnv.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go

declare @w_codigo  int 
select @w_codigo = isnull(max(codigo),0) + 1
from cl_tabla


select @w_codigo = @w_codigo + 1
if not exists (select * from cobis..cl_tabla where tabla = 'cl_tdireccion')
begin
	insert into cl_tabla values (@w_codigo, 'cl_tdireccion', 'Tipo de Direccion')
END
ELSE
BEGIN
    delete cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_tdireccion') 
    SELECT @w_codigo = (select codigo from cobis..cl_tabla where tabla = 'cl_tdireccion')
END

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo ,'AE','NEGOCIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo ,'RE','DOMICILIO','V')
go


