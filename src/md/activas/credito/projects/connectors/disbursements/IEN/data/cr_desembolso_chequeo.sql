use cob_credito
go

if not exists (select * from   sys.sysobjects where  name = 'cr_desembolso_chequeo')
begin
create table cr_desembolso_chequeo
 (
    dc_nombre_documento			char(28) not null,
	dc_tipo_registro    		char(2) not null,
    dc_num_secuencia     	   	char(7) not null,
    dc_cod_operacion  		   	char(2) not null,
    dc_num_banco   				char(3) not null,
    dc_sentido  				char(1) not null,
    dc_servicio     			char(2) not null,
	dc_num_bloque				char(7) not null,
	dc_fecha_presentacion		char(8) not null,
	dc_cod_divisa				char(2) not null,
	dc_causa_rechazo			char(2) not null,
	dc_modalidad				char(1) not null
  )

alter table cr_desembolso_chequeo
add constraint PK_DESEMBOLSO_CHEQUEO primary key nonclustered (dc_nombre_documento)

end
go