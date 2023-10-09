select * from cobis..cl_parametro
where pa_nemonico = 'SIMSAN'

UPDATE cobis..cl_parametro
SET pa_int = 0  -- SIN SIMULACIÓN
where pa_nemonico = 'SIMSAN'

select en_ente, en_banco, en_ced_ruc, en_rfc, * from cobis..cl_ente
where en_nomlar like '%CLAVIJO%'

select TOP 10 ea_cta_banco, ea_estado_std, * from cobis..cl_ente_aux
where ea_ente IN (select en_ente from cobis..cl_ente
where en_nomlar like '%CLAVIJO%')


