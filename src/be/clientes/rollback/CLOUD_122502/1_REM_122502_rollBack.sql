--- para un campo nuevo ------
use cobis
go

if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'ea_oficina_origen' and  c1.table_name = 'cl_ente_aux')
    begin
        print 'Se borra'
        alter table cl_ente_aux drop column ea_oficina_origen
    end
else
    print 'No hay que borrar'
go

--borrar tabla creada
use cobis
go

IF OBJECT_ID ('dbo.cl_modificacion_curp_rfc') IS NOT NULL
	DROP table dbo.cl_modificacion_curp_rfc
go