use cobis
go


declare 
@w_tabla           int,
@w_ente            int,
@w_ente_str        varchar(8)  

select @w_ente = en_ente from cobis..cl_ente where en_ced_ruc = 'USUARIOB2C'

select @w_ente_str = ltrim(rtrim(convert(varchar,@w_ente)))

delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'cl_usuario_google')
delete cl_tabla where tabla = 'cl_usuario_google'

select @w_tabla = isnull(max(codigo),0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cl_usuario_google', 'USUARIO GOOGLE')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'usrb2c', @w_ente_str, 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'usrb2b', 'testgmail', 'V', NULL, NULL, NULL)


update cobis..cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'

select * from cl_catalogo where tabla = @w_tabla
