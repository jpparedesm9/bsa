use cobis
go
-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------CONTABILIDAD------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete from cl_ttransaccion
 where tn_trn_code in (6907)
go

insert into cl_ttransaccion values (6907,'SEARCH DE PERFIL CONTABLE','6907','SEARCH DE PERFIL CONTABLE')
go

