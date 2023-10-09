/* CARGA PARAMETROS CARTERA */

use cob_cartera
go


/* CAMBIO DE ESTADO */

truncate table cob_cartera..ca_estados_man
go

insert into cob_cartera..ca_estados_man values('CREDSEMI', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('CREDSEMI', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('CREDSEMI', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('CAMPO', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('CAMPO', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('CAMPO', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('CLIENT1A', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('CLIENT1A', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('CLIENT1A', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('CREDVEHI', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('CREDVEHI', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('CREDVEHI', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('MEJOLOCA', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('MEJOLOCA', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('MEJOLOCA', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('PARALELO', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('PARALELO', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('PARALELO', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('PRESTGAS', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('PRESTGAS', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('PRESTGAS', 'M', 2, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('SINCO', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('SINCO', 'M', 1, 2, 0, 99999)
insert into cob_cartera..ca_estados_man values('SINCO', 'M', 2, 4, 0, 99999)
go