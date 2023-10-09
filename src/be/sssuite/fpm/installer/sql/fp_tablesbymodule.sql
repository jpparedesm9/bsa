use cob_fpm
go

delete from fp_tablesbymodule
where tm_table in ('ca_default_toperacion', 'ca_rubro')

insert into fp_tablesbymodule(tm_table_id, mod_module_fk, mog_modulegroup_fk, tm_table, tm_database, tm_description) values (1,1,1,'ca_default_toperacion','cob_cartera','Tabla Parametros generales para cartera','PGR')
insert into fp_tablesbymodule(tm_table_id, mod_module_fk, mog_modulegroup_fk, tm_table, tm_database, tm_description) values (2,1,1,'ca_rubro','cob_cartera','Tabla de Rubros para cartera','RR')
go

