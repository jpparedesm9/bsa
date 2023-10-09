use cobis 
go 

--Antes
select 'cr_exclusion_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_exclusion_score_buro')
select 'cr_razon_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_razon_score_buro')
select 'cr_error_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_error_score_buro')
select 'cr_calif_riesgo_2_score'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_calif_riesgo_2_score')
select 'cr_tipo_calif_cliente'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_tipo_calif_cliente')
select 'cr_color_calif_final'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_color_calif_final')
select 'cr_letra_calif_final'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_letra_calif_final')

-----------------------------------------------------------------------------------
-- CATALOGO DE EXCLUSIÓN SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_exclusion_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE EXCLUSION SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-001','Consumidor Fallecido','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-005','Expediente con todas las cuentas cerradas','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-006','Cuentas antiguas menor a 6 meses y al menos una tiene MOP >= 03','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-007','Cuentas antiguas menor a 6 meses y al menos una tiene MOP >= 02','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-008','Sin cuenta actualizada y/o  incluida en el cálculo del BC-Score','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-009','Expediente sin cuentas para cálculo de BC-Score','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO DE RAZÓN SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_razon_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE RAZON SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'700','Cliente con antecedente de mora.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'701','Cliente con poco historial de crédito.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'702','Alto número de cuentas.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'703','Alta utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'704','Cuentas con saldo vencido.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'705','Alto número de consultas.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'706','Alto número de cuentas con saldo mayor a cero.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'707','Porcentaje alto de cuentas sin información de utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'708','Alta utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'709','Sin créditos activos.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'710','Alta morosidad reportada.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'711','Capacidad de enfrentar una deuda volátil.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'712','Montos a pagar crecientes.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'713','Saldo vencido creciente.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'714','Aceleración en saldo actual.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'715','Aceleración en utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'716','Altas y fluctuosas variaciones en motos a pagar.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'717','Altas y fluctuosas variaciones en exposición.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'718','Alta variabilidad en saldos.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'719','Alta variabilidad en montos a pagar.','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO DE ERROR SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_error_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE ERROR SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'01','Solicitud No Autorizada','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'02','Solicitud de Score inválida','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'03','Score No Disponible','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 


-----------------------------------------------------------------------------------
-- CATALOGO RIESGO 2 - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_calif_riesgo_2_score'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CALIFICACION DE RIESGO 2 (SCORE)')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'MB','Muy Bajo','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'B','Bajo','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'M','Medio','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'A','Alto','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'MA','Muy Alto','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'CE','Rechazo Código Exclusión','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'SE','Sin experiencia, sin cálculo Score','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'LN','Listas Negras','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO TIPO DE CALIFICACION - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_tipo_calif_cliente'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'TIPOS DE CALIFICACION PARA EVALUACION DEL CLIENTE')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'EA009','Evaluación Antigua','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'EN017','Evaluación Nueva','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--------------------------------------------------------------------------------------
-- CATALOGO COLORES CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_color_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'COLORES CALIFICACION FINAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'VERDE','VERDE','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AMARILLO','AMARILLO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'ROJO','ROJO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--------------------------------------------------------------------------------------
-- CATALOGO LETRAS CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_letra_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'LETRAS CALIFICACION FINAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'A','A','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'D','D','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'F','F','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--Despues
select 'cr_exclusion_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_exclusion_score_buro')
select 'cr_razon_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_razon_score_buro')
select 'cr_error_score_buro'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_error_score_buro')
select 'cr_calif_riesgo_2_score'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_calif_riesgo_2_score')
select 'cr_tipo_calif_cliente'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_tipo_calif_cliente')
select 'cr_color_calif_final'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_color_calif_final')
select 'cr_letra_calif_final'
select * from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_letra_calif_final')

go
