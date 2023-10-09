--------------------------------------------------------------------------------------------------------------------------------
-- CREACION DE INDEX PARA FILTRAR POR CAMPO sc_fecha_gra TABLA cob_conta_tercero..ct_scomprobante CONCILIADOR CONTABLE REQ.172199
--------------------------------------------------------------------------------------------------------------------------------
use cob_conta_tercero
go

CREATE NONCLUSTERED INDEX id_sc_fecha_gra
ON ct_scomprobante (sc_fecha_gra)
go