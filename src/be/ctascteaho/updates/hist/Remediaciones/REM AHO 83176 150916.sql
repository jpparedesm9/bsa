/***********************************************************************************************************/
---No Bug					: 83176
---Título de Historia		: Mantenimiento de oficina
---Fecha					: 15/09/2016
--Autor						: Jorge Baque
/***********************************************************************************************************/

------------------------------------------------------------------------
use cobis
go

/**************************************** CATALOGOS ****************************************/
delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser', 
				'cl_oficina', 'cl_filial')
   and codigo = cp_tabla
   
 delete cl_catalogo  
   from cl_tabla a
  where a.tabla in ('cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser', 
				'cl_oficina', 'cl_filial')
    and a.codigo = cl_catalogo.tabla
 
 delete cl_tabla
  where tabla in ('cl_area_oficina', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_estado_ser', 
				'cl_oficina', 'cl_filial')
  
declare @w_maxtabla smallint
select @w_maxtabla = isnull(max(codigo), 0) + 1
  from cl_tabla

update cl_seqnos
   set siguiente = @w_maxtabla
 where tabla = 'cl_tabla'
 
declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

print 'AREA OFICINA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_area_oficina', 'Área Oficina')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'BCO', 'BANCO COBIS', 'V')

select @w_codigo = @w_codigo + 1
print 'Tipo de Horario'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_tipo_horario', 'Tipo de Horario')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'C', 'CONTINUO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'D', 'DISCONTINUO', 'V')

select @w_codigo = @w_codigo + 1
print 'Sector geográfico'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_sector_geografico', 'Sector geográfico')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'R', 'RURAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'U', 'URBANO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'P', 'PERIURBANO', 'V')

select @w_codigo = @w_codigo + 1
print 'Estados de Registros'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_estado_ser', 'Estados de Registros')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'B', 'Bloqueado',	'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'C', 'Cancelado',	'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'E', 'Eliminado',	'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'V', 'Vigente',	'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'X', 'Producto Deshabilitado',	'V')

select @w_codigo = @w_codigo + 1
print 'Oficinas'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_oficina', 'Oficina')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '1','DISTRITO GENERAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '2','CASA-MATRIZ', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '3','CENTRO 1', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '4','CHALCGUAPA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '7020','MEJICANOS', 'V')

select @w_codigo = @w_codigo + 1
print 'Filial'
insert into cl_tabla(codigo, tabla, descripcion) values (@w_codigo, 'cl_filial', 'Filia')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '0', 'No existe Filial', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '1', 'COBIS', 'V')
GO

/******************************************** PARAMETROS *******************************************/
DELETE FROM cobis..cl_parametro
  WHERE pa_nemonico = 'SRV'
    AND pa_producto = 'ADM'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SERVIDOR', 'SRV', 'C', '192.168.64.255:81', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')
GO

DELETE FROM cobis..cl_parametro
  WHERE pa_nemonico = 'CP'
    AND pa_producto = 'MIS'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE PAIS', 'CP', 'S', NULL, NULL, 484, NULL, NULL, NULL, NULL, 'MIS')
GO


/******************************************* OFICINAS **********************************************/
use cobis
go

print 'ELIMINANDO DATOS cl_oficina'

truncate table cl_oficina
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1, 'DISTRITO GENERAL', 'CENTRO BANCOMER, AV. UNIVERSIDAD 12', 212, 0, 'R', 'BCO', NULL, 1, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 2, 'CASA-MATRIZ', 'ISABEL LA CATOLICA #44', 475, 0, 'C', 'BCO', NULL, 1, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 3, 'CENTRO 1', 'CALLE RUBEN DARIO Y 9° AVE. SUR. ESQUINA OPUESTA A EX. SIMAN CENTRO', 220, 0, 'Z', 'BCO', NULL, 1, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 4, 'CHALCGUAPA', '3° AV. NORTE Y CALLE RAMON FLORES 11-12 CHALCHUAPA', 212, 0, 'O', 'BCO', NULL, 1, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 7020, 'MEJICANOS', '1ª CALLE ORIENTE NO.5 BARRIO SAN ANGEL ATRAS DE ALCALDÍA MUNICIPAL', 212, 0, 'O', 'BCO', NULL, 1, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2, 'N')
GO



-- Terminal nodo
truncate table ad_nodo_oficina
go

insert into ad_nodo_oficina(nl_filial, nl_oficina, nl_nodo, nl_sis_operativo, nl_nombre, nl_fecha_reg, 
                            nl_registrador, nl_fecha_habil, nl_habilitante, nl_terminal, nl_estado, nl_secuencial, 
                            nl_fecha_ult_mod, nl_x, nl_y)
                     values(1, 1, 1, 1, 'DISTRITO GENERAL', getdate(),	1,	getdate(), NULL, 0, 'V', 1, getdate(), 0, 0)

insert into ad_nodo_oficina(nl_filial, nl_oficina, nl_nodo, nl_sis_operativo, nl_nombre, nl_fecha_reg, 
                            nl_registrador, nl_fecha_habil, nl_habilitante, nl_terminal, nl_estado, nl_secuencial, 
                            nl_fecha_ult_mod, nl_x, nl_y)
                     values(1, 7020, 2, 1, 'MEJICANOS', getdate(),	1,	getdate(), NULL, 0, 'V', 2, getdate(), 0, 0) 
                     
--Terminal Nodo
truncate table an_office_srv
go

declare @w_ip varchar(60)

  select @w_ip = pa_char from cl_parametro
   WHERE pa_nemonico = 'SRV'
    AND pa_producto = 'ADM'

insert into an_office_srv(os_office_id, os_srv_name)
values (1, @w_ip)

insert into an_office_srv(os_office_id, os_srv_name)
values (7020, @w_ip)

--inserta filial

if exists (select 1 from cobis..cl_filial where fi_filial in (0,1)) 
delete cobis..cl_filial where fi_filial in (0,1)

INSERT INTO cobis..cl_filial (fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
VALUES (0, 'No existe filial', ' ', '0', 'V', 'NEF', NULL, NULL, NULL, NULL)
GO

INSERT INTO cobis..cl_filial (fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
VALUES (1, 'BANCO', 'Calle 50 y 56 Victoriano Lorenzo', '1', 'V', 'GBC', 'OTTO WOLFSCHOON', NULL, '4097925281810', NULL)
GO


DECLARE @w_tabla SMALLINT,
		@w_servidor  varchar(100)
		
select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

SELECT @w_tabla = codigo FROM cobis..cl_tabla where   tabla = 'cl_oficina'

delete from cobis..cl_default where tabla = @w_tabla
                
INSERT INTO cobis..cl_default (tabla, oficina, codigo, valor, srv)
VALUES (@w_tabla, 7020, '1', 'MEJICANOS', @w_servidor)

INSERT INTO cobis..cl_default (tabla, oficina, codigo, valor, srv)
VALUES (@w_tabla, 1, '1', 'DISTRITO GENERAL', @w_servidor)
GO
