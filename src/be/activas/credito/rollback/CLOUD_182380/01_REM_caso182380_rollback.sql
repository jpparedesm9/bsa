use cobis
go

declare @w_tabla varchar(256), @w_tabla_cod int
select @w_tabla = 'cr_txt_documento'

if exists (select 1 from cobis..cl_tabla where tabla = @w_tabla)
begin    
    select @w_tabla_cod = codigo from cobis..cl_tabla where tabla = @w_tabla

	select * from cobis..cl_catalogo_pro where cp_tabla = @w_tabla_cod
	select * from cobis..cl_catalogo WHERE tabla = @w_tabla_cod    
    select * from cl_tabla where codigo = @w_tabla_cod
    
	delete cobis..cl_catalogo_pro where cp_tabla = @w_tabla_cod
	delete cobis..cl_catalogo WHERE tabla = @w_tabla_cod    
    delete cl_tabla where codigo = @w_tabla_cod
end
go

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'RGASE1'
SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'RGASE2'

---rOLLBACK
UPDATE cobis..cl_parametro SET pa_char = 'ZURICH SANTANDER SEGUROS' WHERE pa_nemonico = 'RGASE1'
UPDATE cobis..cl_parametro SET pa_char = ' MEXICO, S.A.' WHERE pa_nemonico = 'RGASE2'
go
