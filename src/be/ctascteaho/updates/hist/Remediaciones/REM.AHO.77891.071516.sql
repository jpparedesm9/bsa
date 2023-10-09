
/***********************************************************************************************************/
---No Bug					: 77919
---Título del Bug			: Consulta de Totales por Oficina
---Fecha					: 15/07/2016 
--Descripción del Problema	: Producto no existe
--Descripción de la Solución: se crea script de remediación
--Autor						: Tania Baidal
/***********************************************************************************************************/

--$/COB/Desarrollos/DEV_SaaSMX/CtasCteAho/Dependencias/sql/cc_param.sql

use cobis
go

delete from cl_producto where pd_producto = 3 and pd_descripcion='CUENTA CORRIENTE' and pd_abreviatura = 'CTE'

insert into cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
values (3, 'R', 'CUENTA CORRIENTE', 'CTE', getdate(), 'V', 0, 0)
go
