/*SCRIP DE REMEDIACION DE */

use cobis
go
if exists (select * from an_page where pa_name = 'PP.Parametrizacižn de Productos')
	update an_page 
	set pa_name = 'PP.Parametrizacion de Productos'
	where pa_name = 'PP.Parametrizacižn de Productos'
go
