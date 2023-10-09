use cobis
go

if exists (select * from sysobjects where name = 'sp_catalogo_dat')

    drop proc sp_catalogo_dat

go

create proc sp_catalogo_dat

as

    select tabla=cl_catalogo.tabla, codigo=rtrim(cl_catalogo.codigo), 

           valor=rtrim(cl_catalogo.valor)

    from cl_tabla, cl_catalogo

    where cl_tabla.codigo = cl_catalogo.tabla and

          cl_catalogo.estado = 'V'

    order by 1, 2

return 0

go

