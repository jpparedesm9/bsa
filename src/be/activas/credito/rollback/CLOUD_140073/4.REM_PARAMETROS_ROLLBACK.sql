/*Script de remediación para el requerimiento 140073*/

use cobis 
go
 
delete from cl_parametro where pa_nemonico in ( 'RECASG', 'OFEPRO', 'RGASE1', 'RGASE2')

update cl_parametro
set   pa_char     = '14795-439-028351/02-00343-0119'
where pa_nemonico = 'RDRECA'


go