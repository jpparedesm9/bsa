/****************************************************/
/* ACTUALIZAR VISTA: ca_valor_referencial           */
/****************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_valor_referencial') IS NOT NULL
	DROP VIEW dbo.ca_valor_referencial
GO

create view ca_valor_referencial
as
select pi_referencia    as vr_tipo, 
       pi_valor         as vr_valor,
       pi_fecha_inicio  as vr_fecha_vig,
       pi_cod_pizarra   as vr_secuencial,
       tr_estado        AS vr_estado,
       tr_descripcion   AS vr_descripcion,
       pi_modalidad     AS vr_modalidad,
       pi_referencia    AS vr_tasa,
       pi_periodo       AS vr_periodicidad,
       'U'              AS vr_rango_unico
from   cobis..te_tpizarra, cobis..te_tasas_referenciales
where  pi_cod_pizarra > 0
and    pi_referencia = tr_tasa
and    tr_estado = 'V'

GO