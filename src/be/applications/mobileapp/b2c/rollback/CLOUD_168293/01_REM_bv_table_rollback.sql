
use cob_bvirtual
go
if (OBJECT_ID('bv_onboard_ocr_sco')) IS NOT NULL
    drop table bv_onboard_ocr_sco

go

if (OBJECT_ID('bv_respuesta_fingerid')) IS NOT NULL
    drop table bv_respuesta_fingerid

go