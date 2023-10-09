use cob_cartera
go
if object_id ('ca_devolucion_descuento_1') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_1

if object_id ('ca_devolucion_descuento_2') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_2

if object_id ('ca_devolucion_descuento_3') is not null	
	drop index ca_devolucion_descuento.ca_devolucion_descuento_3

if object_id ('ca_devolucion_descuento_4') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_4
go
if object_id ('ca_devolucion_descuento_5') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_5
go

if object_id ('ca_devolucion_descuento') is not null
    drop table ca_devolucion_descuento
go


create table ca_devolucion_descuento
(
	dd_id 				int IDENTITY(1, 1),
	dd_operacion		int,
	dd_operacion_padre	int,
	dd_oficina			int,
	dd_tramite			int,
	dd_monto			money,
	dd_monto_int		money,
	dd_monto_iva		money,
	dd_cuenta			varchar(64),
	dd_fecha_registro	datetime,
	dd_estado_pago		char(1),
	dd_ente				int,
	dd_beneficiario		varchar(64),
	dd_grupo			int,
	dd_estado_notifica  char(1),
	dd_tasa_descuento	float,
	dd_fecha_pago		datetime,
	dd_tipo 			char(1),
)
go

CREATE INDEX ca_devolucion_descuento_1
    ON dbo.ca_devolucion_descuento (dd_id)
GO
CREATE INDEX ca_devolucion_descuento_2
    ON dbo.ca_devolucion_descuento (dd_operacion, dd_estado_pago)
GO
CREATE INDEX ca_devolucion_descuento_3
    ON dbo.ca_devolucion_descuento (dd_operacion_padre)
GO
CREATE INDEX ca_devolucion_descuento_4
    ON dbo.ca_devolucion_descuento (dd_operacion_padre,dd_estado_pago, dd_estado_notifica)
GO
CREATE INDEX ca_devolucion_descuento_5
    ON dbo.ca_devolucion_descuento (dd_operacion_padre,dd_estado_pago, dd_tipo)
GO
