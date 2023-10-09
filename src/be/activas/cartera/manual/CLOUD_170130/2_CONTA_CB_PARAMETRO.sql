


---

use cob_conta 
go 



alter table cb_parametro alter column pa_parametro varchar(11)
go 




alter table cb_relparam alter column re_parametro varchar(11)
go 



delete cb_parametro where pa_parametro in (

'CAP_1311NE2',
'CAP_1311EX2',
'INT_1311NE2',
'INT_1311EX2',
'INT_5105NE2',
'INT_5105EX2'
)

delete cb_relparam where re_substring in( 

'139150619022',
'139150619023',
'139150619024',
'139150619025',
'139150619026',
'139150619027',
'139150619028',
'139150619029',
'139150619030')



delete cb_relparam where re_parametro 
in (

'CAP_1311NE2',
'CAP_1311EX2',
'INT_1311NE2',
'INT_1311EX2',
'INT_5105NE2',
'INT_5105EX2')
go


--ACTUALIZAR LAS DESCRIPCIONES DE LOS PARAMETROS EXISTENTES EN CAP, INT


update cb_parametro set pa_descripcion = 'CAPITAL VIGENTE ETAPA1' where pa_parametro ='CAP_1311EX'
update cb_parametro set pa_descripcion = 'CAPITAL VIGENTE ETAPA1' where pa_parametro ='CAP_1311NE'
go
update cb_parametro set pa_descripcion = 'CAPITAL VENCIDO ETAPA3' where pa_parametro ='CAP_1361EX'
update cb_parametro set pa_descripcion = 'CAPITAL VENCIDO ETAPA3' where pa_parametro ='CAP_1361NE'
go


update cb_parametro set pa_descripcion = 'INTERES VIGENTE ETAPA1' where pa_parametro ='INT_1311EX'
update cb_parametro set pa_descripcion = 'INTERES VIGENTE ETAPA1' where pa_parametro ='INT_1311NE'
go
update cb_parametro set pa_descripcion = 'INTERESES VENCIDOS ETAPA3' where pa_parametro ='INT_1361'
update cb_parametro set pa_descripcion = 'INTERESES VENCIDOS ETAPA3' where pa_parametro ='INT_5102'
go

update cb_parametro set pa_descripcion = 'INTERES VIGENTE ETAPA1' where pa_parametro ='INT_5105EX'
update cb_parametro set pa_descripcion = 'INTERES VIGENTE ETAPA1' where pa_parametro ='INT_5105NE'
go


--ABRIMOS NUEVO PARAMETRO CONTABLE 



insert into dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'CAP_1311NE2', 'CAPITAL NO EXIGIBLE ETAPA2 ', 'sp_ca01_pf', 7)
go
insert into dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'CAP_1311EX2', 'CAPITAL EXIGLE ETAPA2 ', 'sp_ca01_pf', 7)
go


insert into dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'INT_1311NE2', 'INTERES NO EXIGIBLE ETAPA 2', 'sp_ca01_pf', 7)
go

insert into dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'INT_1311EX2', 'INTERES EXIGIBLE ETAPA 2', 'sp_ca01_pf', 7)
go



insert into  dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'INT_5105NE2', 'INTERESES NO EXIGIBLES ETAPA2', 'sp_ca01_pf', 7)
go

insert into  dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
values (1, 'INT_5105EX2', 'INTERESES EXIGIBLES ETAPA2', 'sp_ca01_pf', 7)
go





---ASOCIAMOS LOS PARAMETROS CREADOS 


/************************************************************************/
/********-****************-CAPITAL **************************************/
/************************************************************************/




--131190060101	MICROCRÉDITOS CAPITAL GRUPALES ETAPA 2	CAP_1311NE2
--131190060201	MICROCRÉDITOS CAPITAL GRUPALES ETAPA 2	CAP_1311EX2

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311NE2', '2.9.99.GRUPAL',    '131190060101', 7, 'CTB_OF', 'D')
go

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311EX2', '2.9.99.GRUPAL',    '131190060201', 7, 'CTB_OF', 'D')
go


--131190060102	MICROCRÉDITOS CAPITAL INDIVIDUAL SIMPLE ETAPA 2	CAP_1311NE2
--131190060202	MICROCRÉDITOS CAPITAL INDIVIDUAL SIMPLE ETAPA 2	CAP_1311EX2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311NE2', '2.9.99.INDIVIDUAL', '131190060102', 7, 'CTB_OF', 'D')
go
insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311EX2', '2.9.99.INDIVIDUAL', '131190060202', 7, 'CTB_OF', 'D')
go





--131190060103	MICROCRÉDITOS CAPITAL INDIVIDUALES ETAPA 2	CAP_1311NE2
--131190060203	MICROCRÉDITOS CAPITAL INDIVIDUALES ETAPA 2	CAP_1311EX2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311NE2', '2.9.99.REVOLVENTE', '131190060103', 7, 'CTB_OF', 'D')
go

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'CAP_1311EX2', '2.9.99.REVOLVENTE', '131190060203', 7, 'CTB_OF', 'D')
go



/************************************************************************/
/********-****************-INTERES **************************************/
/************************************************************************/


--131190070101	MICROCRÉDITOS INTERESES GRUPALES ETAPA 2	INT_1311NE2
--131190070201	MICROCRÉDITOS INTERESES GRUPALES ETAPA 2	INT_1311EX2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311NE2', '2.9.99.GRUPAL',    '131190070101', 7, 'CTB_OF', 'D')
go

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311EX2', '2.9.99.GRUPAL',    '131190070201', 7, 'CTB_OF', 'D')
go



--510511900301	MICROCRÉDITOS GRUPAL INT. ETAPA 2	INT_5105EX2
--510511900401	MICROCRÉDITOS GRUPAL INT. ETAPA 2	INT_5105NE2

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105EX2', '2.9.99.GRUPAL',    '510511900301', 7, 'CTB_OF', 'D')
go

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105NE2', '2.9.99.GRUPAL',    '510511900401', 7, 'CTB_OF', 'D')
go





--131190070102	MICROCRÉDITOS INTERESES INDIVIDUAL SIMPLE ETAPA 2	INT_1311NE2
--131190070202	MICROCRÉDITOS INTERESES INDIVIDUAL SIMPLE ETAPA 2	INT_1311EX2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311NE2', '2.9.99.INDIVIDUAL', '131190070102', 7, 'CTB_OF', 'D')
go

insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311EX2', '2.9.99.INDIVIDUAL', '131190070202', 7, 'CTB_OF', 'D')
go



--510511900302	MICROCRÉDITOS INDIVIDUAL SIMPLE INT. ETAPA 2	INT_5105EX2
--510511900402	MICROCRÉDITOS INDIVIDUAL SIMPLE INT. ETAPA 2	INT_5105NE2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105EX2', '2.9.99.INDIVIDUAL', '510511900302', 7, 'CTB_OF', 'D')
go
insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105NE2', '2.9.99.INDIVIDUAL', '510511900402', 7, 'CTB_OF', 'D')
go



--131190070103	MICROCRÉDITOS INTERESES INDIVIDUALES ETAPA 2	INT_1311NE2
--131190070203	MICROCRÉDITOS INTERESES INDIVIDUALES ETAPA 2	INT_1311EX2



insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311NE2', '2.9.99.REVOLVENTE', '131190070103', 7, 'CTB_OF', 'D')
go
insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_1311EX2', '2.9.99.REVOLVENTE', '131190070203', 7, 'CTB_OF', 'D')
go



--510511900303	MICROCRÉDITOS INDIVIDUAL INT. ETAPA 2	INT_5105EX2
--510511900403	MICROCRÉDITOS INDIVIDUAL INT. ETAPA 2	INT_5105NE2


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105EX2', '2.9.99.REVOLVENTE', '510511900303', 7, 'CTB_OF', 'D')
go
insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'INT_5105NE2', '2.9.99.REVOLVENTE', '510511900403', 7, 'CTB_OF', 'D')
go




/************************************************************************************************/
/********-****************-PROVISIONES (CARTERA EN RIESGO) **************************************/
/************************************************************************************************/

---CUENTAS BORRADAS POR NO SER PARTE DEL PROCESO 