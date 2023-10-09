/*
 *   Actualiza parametros REQ#140485
 *   Johan castro 16/11/2020
 */
use cobis
go

update cl_parametro  
set    pa_char = '14795-440-033778/01-03870-1120'
where  pa_nemonico = 'RDADHS'

go