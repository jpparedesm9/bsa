use cobis 
go 

declare 
@w_nom_tabla varchar(30)

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
select @w_nom_tabla = 'cr_exclusion_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


-----------------------------------------------------------------------------------
-- CATALOGO DE RAZÓN SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_razon_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


-----------------------------------------------------------------------------------
-- CATALOGO DE ERROR SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_error_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


-----------------------------------------------------------------------------------
-- CATALOGO RIESGO 2 - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_calif_riesgo_2_score'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


-----------------------------------------------------------------------------------
-- CATALOGO TIPO DE CALIFICACION - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_tipo_calif_cliente'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


--------------------------------------------------------------------------------------
-- CATALOGO COLORES CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_color_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


--------------------------------------------------------------------------------------
-- CATALOGO LETRAS CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
select @w_nom_tabla = 'cr_letra_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


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
