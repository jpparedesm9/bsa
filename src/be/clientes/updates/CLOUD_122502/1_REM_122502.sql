use cobis
go
--- para un campo nuevo ------
if not exists( select 1 from INFORMATION_SCHEMA.COLUMNS
               where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_oficina_origen')
    begin
        print 'Se inserta'
        alter table cobis..cl_ente_aux ADD ea_oficina_origen smallint null

    end
else
    print 'ya existe'
go

--Crear tabla
use cobis
go

IF OBJECT_ID ('dbo.cl_modificacion_curp_rfc') IS NOT NULL
	DROP table dbo.cl_modificacion_curp_rfc
go

create table dbo.cl_modificacion_curp_rfc
	(
	mcr_ente        int,
	mcr_ssn_user    login,
	mcr_ssn_oficina smallint,
	mcr_fecha       datetime,
	mcr_oficial     smallint,
	mcr_oficina     smallint,
	mcr_curp_ant    varchar(30),
	mcr_rfc_ant     varchar(30),
	mcr_curp        varchar(30),
	mcr_rfc         varchar(30),	
	mcr_operacion   varchar(10),
	mcr_sp          varchar(100)
	
	)
go

    
