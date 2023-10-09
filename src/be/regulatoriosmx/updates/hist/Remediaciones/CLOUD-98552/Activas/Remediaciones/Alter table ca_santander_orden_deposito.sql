use cob_cartera
go

if not exists(select 1
              from sysobjects o, syscolumns c
              where o.name =  'ca_santander_orden_deposito'
              and   o.id   = c.id
              and   c.name = 'sod_fecha_valor')              
begin
   alter table ca_santander_orden_deposito
   add  sod_fecha_valor  datetime null
end




IF OBJECT_ID ('dbo.ca_santander_orden_deposito_resp') IS NOT NULL
	DROP table dbo.ca_santander_orden_deposito_resp
go

create table dbo.ca_santander_orden_deposito_resp
	(
	sod_fecha       datetime,
	sod_fecha_real  datetime,
	sod_consecutivo int,
	sod_linea       int,
	sod_banco       cuenta,
	sod_operacion   int,
	sod_secuencial  int,
	sod_linea_dato  varchar (1000),
	sod_tipo        varchar (10),
	sod_monto       money,
	sod_cliente     int,
	sod_cuenta      cuenta,
	sod_fecha_valor datetime,
	sod_enviado     char(1) null
	)
go

create clustered index ca_santander_orden_deposito_resp1
	on dbo.ca_santander_orden_deposito_resp (sod_fecha, sod_consecutivo, sod_linea)
go

create index ca_santander_orden_deposito_resp2
	on dbo.ca_santander_orden_deposito_resp (sod_operacion, sod_secuencial)
go

