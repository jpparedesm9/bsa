use cob_cartera
go

if object_id ('ca_dia_pago') is not null
	drop table ca_dia_pago
go

create table ca_dia_pago(
dp_banco                 varchar(15)  not null,
dp_ini_operacion_tmp  datetime not null,
dp_fecha_dispercion      datetime     null,
dp_fecha_dia_pag         datetime     null,
dp_dias_calc_int         int          null,
dp_dias_regla            int          null,
dp_valor_int             money        null
)

create nonclustered index ca_dia_pago_Key
    on ca_dia_pago(dp_banco)
go


