/************************************************************************/
/*    ARCHIVO:         carga_oficinas_mex.sql                           */
/*    NOMBRE LOGICO:   carga_oficinas_mex.sql                           */
/*    PRODUCTO:        COBIS                                            */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de carga Oficinas para México.                              */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/


use cobis
go

truncate table cl_oficina
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1, 'DISTRITO GENERAL', 'CENTRO BANCOMER, AV. UNIVERSIDAD 1200', 1548, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 2, 'CASA-MATRIZ', 'ISABEL LA CATOLICA #44', 1548, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 3, 'CENTRO 1', 'CALLE RUBEN DARIO Y 9° AVE. SUR. ESQUINA OPUESTA A EX. SIMAN CENTRO', 1550, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 4, 'CHALCGUAPA', '3° AV. NORTE Y CALLE RAMON FLORES 11-12 CHALCHUAPA', 974, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 7020, 'MEJICANOS', '1ª CALLE ORIENTE NO.5 BARRIO SAN ANGEL ATRAS DE ALCALDÍA MUNICIPAL', 1853, 0, 'O', NULL, NULL, 1, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO



---insera en el catálogo de oficina

DECLARE @w_codigo INT

SELECT @w_codigo = codigo FROM cl_tabla 
WHERE tabla ='cl_oficina'


DELETE cl_catalogo WHERE tabla = @w_codigo


INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '1',' DISTRITO GENERAL', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2',' CASA-MATRIZ', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3',' CENTRO 1', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4','CHALCGUAPA', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7020','MEJICANOS', 'V', NULL, NULL, NULL)
GO

--inserta filial

declare @w_cod int 

select @w_cod = codigo from cobis..cl_tabla where tabla='cl_filial'

if exists (select 1 from cobis..cl_catalogo where tabla=@w_cod and codigo in('0','1'))

delete cobis..cl_catalogo where tabla=@w_cod and codigo in('0','1') 
 
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '0', 'No existe Filial', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1', 'COBIS', 'V', NULL, NULL, NULL)
GO

if exists (select 1 from cobis..cl_filial where fi_filial in (0,1)) 
delete cobis..cl_filial where fi_filial in (0,1)

INSERT INTO cobis..cl_filial (fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
VALUES (0, 'No existe filial', ' ', '0', 'V', 'NEF', NULL, NULL, NULL, NULL)
GO

INSERT INTO cobis..cl_filial (fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
VALUES (1, 'BANCO', 'Calle 50 y 56 Victoriano Lorenzo', '1', 'V', 'GBC', 'OTTO WOLFSCHOON', NULL, '4097925281810', NULL)
GO

