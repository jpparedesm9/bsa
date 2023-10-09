use cobis 
go 

--Antes
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_tplazo_ind')

declare @w_tabla smallint 
select @w_tabla = codigo from cobis..cl_tabla where tabla like 'cr_tplazo_ind'

update dbo.cl_catalogo
set estado = 'V'
where tabla = @w_tabla 
and codigo = 'W' 

--Despues
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_tplazo_ind')

go
