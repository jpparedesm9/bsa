use cobis
go

delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld')

go
