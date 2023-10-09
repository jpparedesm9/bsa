/***********************************************************************************************************/

---Fecha					: 23/08/2016 
--Descripción               : script para la Historia 80490 
--Descripción de la Solución: Remediacion para la Historia 80490
--Autor						: Jorge Baque
/***********************************************************************************************************/

/***************************************************************** COLUMNAS************************************************************ */
use cob_cuentas
go

print 'Agrega Columna tabla ------> cc_ctacte - cc_tipocta_super'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_ctacte' 
                                          AND COLUMN_NAME = 'cc_tipocta_super') 
begin
	alter table cc_ctacte 
		add cc_tipocta_super  CHAR(1) NULL
end 

print 'Agrega Columna tabla ------> cc_ctacte - cc_descripcion_dv'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_ctacte' 
                                          AND COLUMN_NAME = 'cc_descripcion_dv') 
begin
	alter table cc_ctacte 
		add cc_descripcion_dv descripcion NULL
end


print 'Agrega Columna tabla ------> cc_tran_servicio - ts_tipocta_super'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_tipocta_super') 
begin
	alter table cc_tran_servicio
		add ts_tipocta_super char(1) NULL
			
end 

print 'Agrega Columna tabla ------> cc_tran_servicio - ts_turno'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_turno') 
begin
	alter table cc_tran_servicio
		add ts_turno smallint NULL
end

print 'Agrega Columna tabla ------> cc_tran_monet - tm_categoria'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_tran_monet' 
                                          AND COLUMN_NAME = 'tm_categoria') 
begin
	alter table cc_tran_monet
	add tm_categoria char(1) NULL
end
print 'Agrega Columna tabla ------> cc_tran_monet - tm_tipocta_super'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cc_tran_monet' 
                                          AND COLUMN_NAME = 'tm_tipocta_super') 
begin
	alter table cc_tran_monet
	add tm_tipocta_super char(1) NULL
end
go