use cobis
go

declare @w_tabla smallint

select @w_tabla = codigo from cl_tabla where tabla like 'cl_parentesco'

--Antes
select * from cl_catalogo 
where tabla = (select codigo from cl_tabla where tabla like 'cl_parentesco')

delete from cl_catalogo where tabla = @w_tabla and codigo in ('ES','PH','CU')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'ES', 'ESPOSO(A)', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'PH', 'PAREJA DE HECHO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CU', 'CUÑADO','V')


--Despues
select *from cl_catalogo 
where tabla = (select codigo from cl_tabla where tabla like 'cl_parentesco')



go
