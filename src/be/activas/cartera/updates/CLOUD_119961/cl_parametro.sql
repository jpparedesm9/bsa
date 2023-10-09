use cob_cartera

go

delete from cob_cartera..ca_tipo_trn where tt_codigo='CLC'

delete from cobis..cl_parametro where  pa_nemonico = 'DIASCA' and    pa_producto   = 'CCA'

insert into cob_cartera..ca_tipo_trn values('CLC', 'CANCELACION ANTICIPADA LCR', 'S','N')

insert into cobis..cl_parametro(pa_parametro,pa_nemonico,pa_tipo,pa_int,pa_producto)
values('DIAS CANCELACION ANTICIPADA','DIASCA','I',364,'CCA')

go