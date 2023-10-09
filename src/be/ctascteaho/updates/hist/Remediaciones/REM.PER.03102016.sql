/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 03/10/2016 
--Descripción del Problema	: Actualización de Descripcion Productos Disponibles
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cob_remesas
go

-- pe_parametria.sql

if exists(select 1 from pe_var_servicio where vs_servicio_dis = 1 and vs_rubro = '23')
begin
	update pe_var_servicio
	set vs_descripcion = 'PAGO INT. POR CIERRE',
	vs_estado = 'B'
	where vs_servicio_dis = 1 and vs_rubro = '23'
	print 'Modif - pe_var_servicio ' + 'PAGO INT. POR CIERRE'
end


-- borrado de rubro '23'
declare @w_rubro varchar(2)
select @w_rubro = '23'

if exists (select 1 from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
begin
	print 'borrando costos rubro: ' + cast(@w_rubro as varchar)
	if exists(select 1 from cob_remesas..pe_costo where co_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro))
		delete from cob_remesas..pe_costo where co_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
	if exists(select 1 from cob_remesas..pe_cambio_costo where cc_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro))
		delete from cob_remesas..pe_cambio_costo where cc_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
	delete from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro
end
go 
-- borrado de rubro '2'
declare @w_rubro varchar(2)
select @w_rubro = '2'

if exists (select 1 from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
begin
	print 'borrando costos rubro: ' + cast(@w_rubro as varchar)
	if exists(select 1 from cob_remesas..pe_costo where co_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro))
		delete from cob_remesas..pe_costo where co_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
	if exists(select 1 from cob_remesas..pe_cambio_costo where cc_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro))
		delete from cob_remesas..pe_cambio_costo where cc_servicio_per in (select sp_servicio_per from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro)
	delete from cob_remesas..pe_servicio_per where sp_servicio_dis = 1 and sp_rubro = @w_rubro
end

go
