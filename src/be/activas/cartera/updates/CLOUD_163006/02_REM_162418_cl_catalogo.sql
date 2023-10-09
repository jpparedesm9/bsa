use cobis
go

declare @w_catalog_id int

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld')

---------------------------------------------------------------
-- RIESGOS CRED. EXTER. PERMITIDOS EN GENERACION CANDIDATOS LCR
---------------------------------------------------------------

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'ca_lcr_riesgo_cred_ext','RIESGOS CRED. EXTER. PERMITIDOS EN GENERACION CANDIDATOS LCR')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'1','A','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'2','B','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'3','C','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'4','D','V')


---------------------------------------------------------
-- RIESGOS PLD NO PERMITIDOS EN GENERACION CANDIDATOS LCR
---------------------------------------------------------

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'ca_lcr_riesgo_pld','RIESGOS PLD NO PERMITIDOS EN GENERACION CANDIDATOS LCR')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'1','A2','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'2','A3','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'3','CCC','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'4','A3 Bloqueante','V')
go
