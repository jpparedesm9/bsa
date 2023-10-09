use cobis
go

delete from cl_ttransaccion
 where tn_trn_code in (1574)
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1574,'HELP DE OFICINAS','HOFI','DESCRIPCION')


go

