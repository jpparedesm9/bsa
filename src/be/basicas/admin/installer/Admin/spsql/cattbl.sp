use cobis
go

if exists (select * from sysobjects where name = 'sp_catalogo_tbl')

    drop proc sp_catalogo_tbl



go

create proc sp_catalogo_tbl

(

    @i_server    varchar(10),

    @i_oficina    smallint

)

as

    select tabla=cl_tabla.codigo, 

           nombre=rtrim(cl_tabla.tabla),

           valor_default=rtrim(cl_default.codigo)

    from cl_tabla

         LEFT OUTER JOIN cl_default ON cl_tabla.codigo = cl_default.tabla and cl_default.srv = @i_server and cl_default.oficina = @i_oficina

    order by convert(varchar(5), cl_tabla.codigo)



return 0

go

