use cob_cartera
go

delete from ca_estado
go

insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (0, 'NO VIGENTE', 'N', 'N')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (1, 'VIGENTE', 'S', 'S')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (2, 'VENCIDO', 'S', 'S')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (3, 'CANCELADO', 'N', 'N')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (4, 'CASTIGADO', 'S', 'S')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (6, 'ANULADO', 'N', 'N')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (7, 'CONDONADO', 'N', 'N')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (8, 'DIFERIDO', 'S', 'S')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (9, 'SUSPENSO', 'S', 'S')
insert into ca_estado (es_codigo, es_descripcion, es_procesa, es_acepta_pago) values (99, 'CREDITO', 'N', 'N')
go
