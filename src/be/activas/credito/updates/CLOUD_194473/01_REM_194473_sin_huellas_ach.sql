
 -- caso#194473
declare @w_tabla int 
select @w_tabla = codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind'

select 'antes', * from cobis..cl_catalogo where tabla = @w_tabla

if exists (select 1 from cobis..cl_catalogo where tabla = @w_tabla and ltrim(rtrim(valor)) = 'DOCUMENTO PROBATORIO') begin
    update cobis..cl_catalogo set valor = 'DOCUMENTO PROBATORIO ANVERSO' where tabla = @w_tabla and ltrim(rtrim(valor)) = 'DOCUMENTO PROBATORIO'
end else 
    print 'Ya fue actualizado'

if not exists (select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = '011') begin
    insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
    values (@w_tabla, '011', 'DOCUMENTO PROBATORIO REVERSO', 'V', NULL, NULL, NULL)
end else 
    print 'Ya existe'

select 'antes', * from cobis..cl_catalogo where tabla = @w_tabla
go
