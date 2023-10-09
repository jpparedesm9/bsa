
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 96425: Mejoras al kit de crédito
--Fecha                      : 04/05/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- CREAR TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

IF OBJECT_ID ('dbo.cl_clientes_calif') IS NOT null
	DROP TABLE dbo.cl_clientes_calif
GO

create table cl_clientes_calif (
	cc_ente		int not null,
	cc_calif    char(1)
)
CREATE NONCLUSTERED INDEX cl_clientes_calif
	ON dbo.cl_clientes_calif (cc_ente)
GO


--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_parametros.sql

delete cobis..cl_parametro where pa_nemonico  in ('DIAREX', /*'SVEREX', 'CNFREX',*/ 'DIACRE', 'DIACAE', 'DIACME', 'POCOGR')

insert into cobis..cl_parametro values ('DIAS EVALUACION RIESGO EXTERNO', 'DIAREX', 'S', null, null, 365, null, null, null, null, 'CLI')
--insert into cobis..cl_parametro values ('SALDO VENCIDO RIESGO EXTERNO', 'SVEREX', 'M', null, null, null, null, 500, null, null, 'CLI')
--insert into cobis..cl_parametro values ('SALDO CUENTAS NO FINANCIERAS RIESGO EXTERNO', 'CNFREX', 'M', null, null, null, null, 2000, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA RECIENTE RIESGO EXTERNO', 'DIACRE', 'S', null, null, 90, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA ANTIGUA RIESGO EXTERNO', 'DIACAE', 'S', null, null, 365, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA MITIGADORA RIESGO EXTERNO', 'DIACME', 'S', null, null, 90, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('POLITICA CONFORMACION GRUPAL', 'POCOGR', 'C', 'NO', null, null, null, null, null, null, 'CLI')
go


--------------------------------------------------------------------------------------------
-- INSERTAR ERRORES
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql

delete cobis..cl_errores where numero in (103178, 103179, 103180, 103157)

insert into cobis..cl_errores values (103178, 0, 'Prospecto rechazado por deterioro crediticio')
insert into cobis..cl_errores values (103179, 0, 'El grupo excede los CONDICIONADOS, se recomienda eliminar X personas con esta prioridad <lista>')
insert into cobis..cl_errores values (103180, 0, 'El grupo excede los CONDICIONADOS, se debe revisar X personas con esta prioridad <lista>')
insert into cobis..cl_errores values (103157, 0, 'Existe un cliente casado sin datos de cónyugue')
go


--------------------------------------------------------------------------------------------
-- AGREGAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

--CAMBIAR TIPO DE DATO DE PUNTAJE
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_puntaje_riesgo_cg ' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_puntaje_riesgo_cg  char(3) null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_puntaje_riesgo_cg  char(3) null
end

--FECHA EVALUACION RIESGO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_fecha_evaluacion' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_fecha_evaluacion datetime null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_fecha_evaluacion datetime null
end

--SUMA RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_sum_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_sum_vencido money null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_sum_vencido money null
end
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_num_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_num_vencido int null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_num_vencido int null
end

use cob_sincroniza
go
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'sid_observacion' and TABLE_NAME = 'si_sincroniza_det')
begin
    alter table cob_sincroniza..si_sincroniza_det add sid_observacion varchar(5000) null
end
else
begin
	alter table cob_sincroniza..si_sincroniza_det alter column sid_observacion varchar(5000) null
end

--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ -
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go





