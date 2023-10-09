delete cobis..cl_oficina
go

INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 1000, 'Divisional Metro', '', 'R', 'BCO', 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 1100, 'Regional Toluca', '', 'R', 'BCO', 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 3354, 'Oficina Toluca', '', 'O', 'BCO', 1100, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 2377, 'Oficina Santiago Tianguistenco', '', 'O', 'BCO', 1100, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 2379, 'Oficina Atizapán', '', 'O', 'BCO', 1100, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 1200, 'Regional Chalco', '', 'R', 'BCO', NULL, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 3348, 'Oficina Chalco', '', 'O', 'BCO', 1200, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 3345, 'Oficina Valle de Chalco', '', 'O', 'BCO', 1200, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 2381, 'Oficina Ixtapaluca', '', 'O', 'BCO', 1200, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 3351, 'Oficina Chimalhuacan', '', 'O', 'BCO', 1200, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 9000, 'Centralizadora', '', 'R', 'BCO', 1300, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 9001, 'Oficina Virtual', '', 'O', 'BCO', 9000, 1, 'C', 'U', 0, 'N', 1)
GO
INSERT INTO [cobis].[dbo].[cl_oficina]([of_filial], [of_oficina], [of_nombre], [of_direccion], [of_subtipo], [of_area], [of_regional], [of_horario], [of_tipo_horar], [of_sector], [of_sucursal], [of_bloqueada],[of_ciudad])
VALUES(1, 9002, 'Centralizadora Inclusion financiera', '', 'O', 'BCO', 9000, 1, 'C', 'U', 0, 'N', 1)
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 9100, 'REGION COLECTIVO', 'REGION VIRTUAL', 271, NULL, 'R', 'BCO', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, NULL, NULL, 9, 28340, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 9101, 'AVON', 'OFICINA VIRTUAL', 271, NULL, 'O', 'BCO', NULL, 8000, NULL, NULL, NULL, NULL, NULL, 'C', NULL, NULL, NULL, NULL, NULL, 9, 28340, NULL, 'N', 16, 54, 18, 'O', 99, 49, 32, NULL, NULL, 1, 132, NULL, 'N')
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 9102, 'INDEPENDIENTE', 'OFICINA VIRTUAL', 271, NULL, 'O', 'BCO', NULL, 8000, NULL, NULL, NULL, NULL, NULL, 'C', NULL, NULL, NULL, NULL, NULL, 9, 28340, NULL, 'N', 16, 54, 18, 'O', 99, 49, 32, NULL, NULL, 1, 132, NULL, 'N')
GO


delete cobis..cl_catalogo where tabla = 9
go


INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1000', 'Divisional Metro', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1100', 'Regional Toluca', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '3354', 'Oficina Toluca', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2377', 'Oficina Santiago Tianguistenco', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2379', 'Oficina Atizapán', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1200', 'Regional Chalco', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '3348', 'Oficina Chalco', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '3345', 'Oficina Valle de Chalco', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2381', 'Oficina Ixtapaluca', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '3351', 'Oficina Chimalhuacan', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '9000', 'Centralizadora', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '9001', 'Oficina Virtual', 'V')
GO
INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '9002', 'Centralizadora Inclusion financiera', 'V')
GO

delete cobis..cl_departamento
go

INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(1, 1, 9002, 'SISTEMAS', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(2, 1, 9002, 'OPERACIONES', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(3, 1, 9002, 'BACKOFFICE', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(4, 1, 9002, 'COMERCIAL', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(5, 1, 9002, 'CONTABILIDAD', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(2, 1, 3351, 'OPERACIONES', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(2, 1, 3348, 'OPERACIONES', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(2, 1, 3345, 'OPERACIONES', 0)
GO
INSERT INTO [cobis].[dbo].[cl_departamento]([de_departamento], [de_filial], [de_oficina], [de_descripcion], [de_nivel])
VALUES(2, 1, 3354, 'OPERACIONES', 0)
GO
