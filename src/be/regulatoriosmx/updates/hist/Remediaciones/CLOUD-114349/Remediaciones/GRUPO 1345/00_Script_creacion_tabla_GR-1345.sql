use cob_cartera
go

IF OBJECT_ID ('tmp_114349_dcu') IS NOT NULL
	DROP TABLE tmp_114349_dcu
GO

create table tmp_114349_dcu
(
  secuencial           int        identity,
  codigo_interno       int        null,
  secuencial_corresp   int        null,
  operacion_hija       int        null,
  secuencial_pago      int        null,
  secuencial_ing       int        null,
  fecha_pago           datetime   null,
  estado_pago          varchar(4) null,
  estado_proc_reverso  varchar(2) null,
  estado_proc_pago     varchar(2) null
)