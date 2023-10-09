use cobis
go

delete cl_parametro
where pa_nemonico = 'SEGMAX'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES MAXIMOS A REEMPLAZAR SEGURO IND', 'SEGMAX', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
GO

select  *
from cl_parametro
where pa_nemonico = 'SEGMAX'

delete cl_parametro
where pa_nemonico = 'SEGDEF'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES DEFAULT A REEMPLAZAR SEGURO IND', 'SEGDEF', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')

select  *
from cl_parametro
where pa_nemonico = 'SEGDEF'
