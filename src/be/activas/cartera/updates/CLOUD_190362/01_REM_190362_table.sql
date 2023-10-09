--Requerimiento #190362 Impresion de Ficha PI
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_cartera
go

if object_id ('dbo.ca_gen_ficha_pago_ind_det') is not null
	drop table dbo.ca_gen_ficha_pago_ind_det
go

if object_id ('dbo.ca_gen_ficha_pago_ind') is not null
	drop table dbo.ca_gen_ficha_pago_ind
go

create table ca_gen_ficha_pago_ind
    (
    fpi_operacion      int           not null,
	fpi_cliente        int           not null,
	fpi_fecha_proceso  datetime      not null,
	fpi_cliente_name   varchar (100) not null,
	fpi_op_fecha_liq   datetime      not null,
	fpi_op_moneda      tinyint       not null,
	fpi_op_oficina     smallint      not null,
	fpi_di_fecha_vig   datetime      not null,
	fpi_di_dividendo   int           not null,
	fpi_di_monto       money         not null,
	fpi_email          varchar (255) null,
	fpi_banco          cuenta        not null
    )
go

create nonclustered index fpi_cliente_key
    on ca_gen_ficha_pago_ind(fpi_cliente)
go
create nonclustered index fpi_banco_key
    on ca_gen_ficha_pago_ind(fpi_banco)
go

create table dbo.ca_gen_ficha_pago_ind_det(
   fpid_operacion      int           not null,
   fpid_cliente        int           not null,
   fpid_corresponsal   varchar(10)   not null,
   fpid_institucion    varchar(20)   not null,
   fpid_referencia     varchar(40)   not null,
   fpid_convenio       varchar(30)   null,
   fpid_banco          cuenta        not null
   )
go

create nonclustered index fpid_cliente_key
    on ca_gen_ficha_pago_ind_det(fpid_cliente)
go
create nonclustered index fpid_banco_key
    on ca_gen_ficha_pago_ind_det(fpid_banco)
go

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

