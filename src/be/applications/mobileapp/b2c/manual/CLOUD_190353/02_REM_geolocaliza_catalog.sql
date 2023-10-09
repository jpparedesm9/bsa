use cob_bvirtual
go

if (OBJECT_ID('bv_trans_api_detalles')) IS NOT NULL
    drop table bv_trans_api_detalles
go


CREATE TABLE bv_trans_api_detalles (
	ad_codigo varchar(20) NULL,
	ad_valor varchar(50) NULL,
	ad_ruta varchar(100) NULL,
	ad_tipo varchar(20) NULL
)

go
