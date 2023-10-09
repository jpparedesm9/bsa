use cob_cartera
go

if object_id('ca_valor_referencial_view') is not null
    drop view ca_valor_referencial_view
go

create view ca_valor_referencial_view as
select b.codigo as vr_tasa, vr_secuencial, b.valor as vr_descripcion,'R' as vr_modalidad, null as vr_periodicidad, 'U' as vr_rango_unico, b.estado as vr_estado from cobis..cl_tabla a, cobis..cl_catalogo b, cob_cartera..ca_valor_referencial c
where a.tabla like 'fp_procesos' and a.codigo = b.tabla and b.codigo = c.vr_tipo
and b.estado ='V' and vr_fecha_vig >= (select max(fp_fecha) from cobis..ba_fecha_proceso)

go
