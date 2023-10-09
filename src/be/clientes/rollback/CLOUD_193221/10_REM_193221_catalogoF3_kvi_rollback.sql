use cobis
go

declare @w_tabla smallint

select @w_tabla = codigo from cobis..cl_tabla where tabla like 'cl_parentesco'

--Antes
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_parentesco')

delete from cobis..cl_catalogo where tabla = @w_tabla and codigo in ('ES','PH')

--Despues
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_parentesco')

go
