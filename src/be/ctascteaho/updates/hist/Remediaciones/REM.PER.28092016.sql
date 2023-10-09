/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 28/09/2016 
--Descripción del Problema	: Actualización de Descripcion Productos Disponibles
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

-- cc_param.sql

use cob_remesas
go

-- pe_parametria.sql
if exists(select 1 from pe_servicio_dis where sd_servicio_dis = 50)
begin
	update pe_servicio_dis
	set sd_descripcion = 'SALDO MINIMO/MAXIMO'
	where sd_servicio_dis = 50
	print 'Modif - pe_servicio_dis ' + 'SALDO MINIMO/MAXIMO'
end

if exists(select 1 from pe_var_servicio where vs_servicio_dis = 1 and vs_rubro = '18')
begin
	update pe_var_servicio
	set vs_descripcion = 'PAGO INT. SOBRE DISPONIBLE'
	where vs_servicio_dis = 1 and vs_rubro = '18'
	print 'Modif - pe_var_servicio ' + 'PAGO INT. SOBRE DISPONIBLE'
end

if exists(select 1 from pe_var_servicio where vs_servicio_dis = 1 and vs_rubro = '23')
begin
	update pe_var_servicio
	set vs_descripcion = 'PAGO INT. POR CIERRE'
	where vs_servicio_dis = 1 and vs_rubro = '23'
	print 'Modif - pe_var_servicio ' + 'PAGO INT. POR CIERRE'
end


DECLARE @w_codigo INT
select @w_codigo = codigo FROM cobis..cl_tabla WHERE tabla = 'pe_rubro'

if exists (select 1 from cobis..cl_catalogo where tabla = @w_codigo and codigo = '23')
begin
	update cobis..cl_catalogo
	set valor = 'INTERES POR CIERRE'
	where tabla = @w_codigo and codigo = '23'
	print 'Modif - Rubro 23 - Interes por Cierre'
end

go
