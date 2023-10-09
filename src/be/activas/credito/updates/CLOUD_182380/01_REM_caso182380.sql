use cobis
go

declare @w_tabla varchar(256), @w_tabla_cod smallint
select @w_tabla = 'cr_txt_documento'

if not exists (select 1 from cobis..cl_tabla where tabla = @w_tabla)
begin
    print 'Ingresar informacion'
	select @w_tabla_cod = max(codigo) + 1 from cl_tabla
	
	insert into cl_tabla values (@w_tabla_cod, @w_tabla, 'Texto Para Documentos')
	insert into cl_catalogo_pro values ('CRE', @w_tabla_cod)

    insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla_cod, 'GPNCT01','TU CR…DITO GRUPAL','V')
    insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla_cod, 'GPSCT01','TU CR…DIITO AN√çMATE','V')
    insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla_cod, 'RIXCT01','TU CR…DIITO AL CLIC','V')

    -- Actualizacion secuencial tabla de catalogos
    update cobis..cl_seqnos
    set siguiente = @w_tabla_cod
    where tabla  = 'cl_tabla'
    
end
go


SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'RGASE1'
SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'RGASE2'

-- ACTUAL
UPDATE cobis..cl_parametro SET pa_char = 'Z˙rich Santander Seguros' WHERE pa_nemonico = 'RGASE1'
UPDATE cobis..cl_parametro SET pa_char = ' MÈxico, S.A.' WHERE pa_nemonico = 'RGASE2'
go
