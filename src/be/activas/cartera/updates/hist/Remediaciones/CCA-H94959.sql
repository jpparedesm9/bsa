use cob_cartera
go

if exists(select * from cob_cartera..sysobjects where name = 'ca_valor_referencial' and xtype = 'U')
 drop table ca_valor_referencial
go


if exists(select * from cob_cartera..sysobjects where name = 'ca_tasa_valor' and xtype = 'U')
 drop table ca_tasa_valor
go


if object_id ('dbo.ca_valor_referencial') is not null
    drop view dbo.ca_valor_referencial
go

create view ca_valor_referencial
as
    select pi_referencia as vr_tipo, 
           pi_valor      as vr_valor,
           pi_fecha_inicio  as vr_fecha_vig,
           pi_cod_pizarra as vr_secuencial
    from   cobis..te_tpizarra, cobis..te_tasas_referenciales
    where  pi_cod_pizarra > 0
    and    pi_referencia  = tr_tasa
    and    tr_estado      = 'V'
go


if object_id ('dbo.ca_tasa_valor') is not null
    drop view dbo.ca_tasa_valor
go

create view ca_tasa_valor
as
    select tr_tasa as tv_nombre_tasa, 
           tr_descripcion      as tv_descripcion,
           case pi_caracteristica when 'E' then 'V' else pi_modalidad end  as tv_modalidad,
           case (select ca_periodo from cobis..te_caracteristicas_tasa  where ca_tasa = a.tr_tasa) 
                when '1' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 360)
                when '2' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 60)
                when '3' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 90)
                when '4' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 120)
                when '5' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 150)
                when '6' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 180)
                when '7' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 210)
                when '8' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 240)
                when '9' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 270)
                when '10' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 300)
                when '11' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 330)
                when '12' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 30)
                else 'A'
           end as tv_periodicidad,
           tr_estado     as tv_estado,
           pi_caracteristica as tv_tipo_tasa
    FROM   cobis..te_tasas_referenciales a, cobis..te_tpizarra c   -- cobis..te_caracteristicas_tasa
    WHERE  tr_tasa = pi_referencia
    and    tr_estado = 'V'
    and    pi_cod_pizarra = (select max (pi_cod_pizarra) from cobis..te_tpizarra 
    where pi_referencia = a.tr_tasa)
    go
