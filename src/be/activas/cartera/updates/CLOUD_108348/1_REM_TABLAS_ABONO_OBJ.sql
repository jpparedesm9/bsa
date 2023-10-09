
use cob_cartera 
go 


if object_id ('dbo.ca_abono_objetado') is not null
	drop table dbo.ca_abono_objetado
go


create table ca_abono_objetado ( 
ao_operacion   int        not null, 
ao_id_pago     int        null,
ao_sec_ing     int        null, 
ao_sec_rpa     int        null, 
ao_toperacion  catalogo   null,
ao_monto_pago  money      null,
ao_fecha_valor datetime   null,
ao_usuario     login      null
) 

CREATE CLUSTERED INDEX ca_abono_objetado_1
	ON dbo.ca_abono_objetado (ao_operacion,ao_usuario)
GO

 
if object_id ('dbo.ca_qry_abono_objetado') is not null
	drop table dbo.ca_qry_abono_objetado
go


create table ca_qry_abono_objetado ( 
ao_id          int identity   not null, 
ao_operacion   int        not null, 
ao_id_pago     int        null,
ao_id_ing      int        null,
ao_toperacion  catalogo   null,
ao_monto_pago  money      null,
ao_fecha_valor datetime   null,
ao_usuario     login      null
) 

CREATE CLUSTERED INDEX ca_qry_abono_objetado_1
	ON dbo.ca_qry_abono_objetado (ao_id ,ao_operacion,ao_usuario)
GO
