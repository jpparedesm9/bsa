
use cobis
go

delete cobis..cl_parametro where  pa_producto = 'PFI' and pa_nemonico in ('ISCAP', 'ISINT', 'IMPREN')
go

insert into cobis..cl_parametro (pa_parametro,                         pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
                         values ('COBRO IMPUESTO RENTA SOBRE CAPITAL', 'ISCAP',     'C',     'S',     null,       null,        null,   null,     null,        null ,    'PFI')

insert into cobis..cl_parametro (pa_parametro,                         pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
                         values ('COBRO IMPUESTO RENTA SOBRE INTERES', 'ISINT',     'C',     'N',     null,       null,        null,   null,     null,        null ,    'PFI')

insert into cobis..cl_parametro (pa_parametro,                         pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
                         values ('PORCENTAJE IMPUESTO RENTA',          'IMPREN',    'F',     null,     null,       null,        null,   null,     null,        0.5,    'PFI')
go