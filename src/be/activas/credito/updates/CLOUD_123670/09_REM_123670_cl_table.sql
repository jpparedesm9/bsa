use cobis
go

if not exists(select 1
              from INFORMATION_SCHEMA.COLUMNS as c1
              where c1.column_name = 'ea_fecha_activacion'
              and  c1.table_name = 'cl_ente_aux')
begin 
  alter table cl_ente_aux
  add ea_fecha_activacion datetime null
end 
go
