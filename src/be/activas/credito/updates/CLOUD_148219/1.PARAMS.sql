use cobis
go

delete from cl_parametro where pa_nemonico in ('DATRE','MXILC','RADBL') and pa_producto='CCA'

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('DIAS ATRASO MAXIMO CANDIDATO LCR','DATRE','S',7,'CCA')

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('MAXIMO INTEGRANTES CON LCR','MXILC','S',50,'CCA')

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('ROL AUTORIZA DESBLOQUEO','RADBL','S',32,'CCA')

delete from cl_errores where numero in (724683,724684,724685,724686)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724683, 0, 'El grupo del cliente ha cubierto el porcentaje aceptable de otorgamiento')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724684, 0, 'El desbloqueo debe ser autorizado')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724685, 0, 'Se deben tener al menos 2 pagos')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724686, 0, 'No cumple con las condiciones de pagos para incremento')

go
