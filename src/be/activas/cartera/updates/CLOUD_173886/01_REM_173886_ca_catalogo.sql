use cobis
go

declare @w_catalog_id int

--catalogo antes de ser modificado
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla = 'ca_lcr_riesgo_cred_ext')

select @w_catalog_id = (select codigo from cobis..cl_tabla where tabla = 'ca_lcr_riesgo_cred_ext')

if exists(Select 1 from cobis..cl_catalogo where tabla = @w_catalog_id and valor = 'E')
begin
  delete from cobis..cl_catalogo where tabla = @w_catalog_id and valor = 'E'
  
  insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
  values(@w_catalog_id,'5','E','V')
end
else
begin
  insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
  values(@w_catalog_id,'5','E','V')
end

--catalogo despues de ser modificado
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla = 'ca_lcr_riesgo_cred_ext')

go 

