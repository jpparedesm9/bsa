/* SCRIPT DE CREACION DE ENLACES DE PROCESOS DE GARANTIAS */
/* AUTOR: GABRIEL ALVIS */
/* FECHA: 05/MAY/2009   */

use cobis
go

delete ba_enlace
where en_sarta = 19201
and en_batch_inicio in (19058,19059,19057,19060)
go

insert into ba_enlace values(19201, 19058, 1, 19059, 2, 'S', null, 'N')
insert into ba_enlace values(19201, 19059, 2, 19057, 3, 'S', null, 'N')
insert into ba_enlace values(19201, 19057, 3, 19060, 4, 'S', null, 'N')
insert into ba_enlace values(19201, 19060, 4,     0, 0, 'S', NULL, 'N')
go
