use cobis
go 

truncate table cl_oficina
GO

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 1, 'CASA MATRIZ', 'DIRECCION GENERAL', 11001, 0, 'R', NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 19, 'OPERACIONES', 'CARRERA 9 N∞ 66- 25', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 28, 'TESORERIA', 'CRA 9 N) 66-25', 11001, 0, 'O', NULL, NULL, '2006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 107, 'BIENESTAR SOCIAL EMPLEADOS', 'CARRERA 9A # 66-25', 11001, 0, 'O', NULL, NULL, '2006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2001, 'REGIONAL NORTE', 'MEDELLIN', 5001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2002, 'REGIONAL CENTRO', 'CRA 9 N 66-25', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2003, 'T ELIMINAR', 'CRA 9 N 66-25', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2004, 'PEQUE—A EMPRESA', 'BOGOTA', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2005, 'BANCA RURAL', 'CARRERA 9A # 66 - 25', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2006, 'AREAS CENTRALES', 'CARRERA 9A # 66-25', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2007, 'REGIONAL CANALES', 'PENDIENTE', 11001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 2008, 'REGIONAL SUR', 'CALLE 13 No 23 c 32', 76001, 0, 'R', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3001, 'ZONA BOGOTA NORTE', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3002, 'ZONA BOGOTA SUR', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3003, 'ZONA CUNDINAMARCA', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3004, 'ZONA ORIENTE', 'PENDIENTE', 20001, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3005, 'ZONA URABA / BAJO SINU', 'PENDIENTE', 23001, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3006, 'ZONA TERRITORIOS NACIONALES', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3007, 'ZONA BAJO CAUCA ANT', 'MONTERIA', 23001, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3008, 'ZONA SUR OCCIDENTE', 'CALI', 76001, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3009, 'ZONA MEDELLÕN NORTE', 'MEDELLIN', 5001, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3010, 'ZONA MEDELLÕN SUR', 'MEDELLIN', 5001, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3011, 'ZONA EJE CAFETERO', 'MANIZALES', 17001, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3012, 'ZONA BOYACA-CASANARE', 'TUNJA', 15001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3013, 'ZONA COSTA NORTE', 'CARTAGENA', 13001, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3014, 'ZONA CANALES CUNDINAMARCA', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3015, 'ZONA CANALES BAJO CAUCA ANT', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3016, 'ZONA CANALES ORIENTE', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3017, 'ZONA CANALES SANTANDERES', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3018, 'ZONA CANALES MEDELLIN NORTE', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3019, 'ZONA CANALES BOGOTA SUR', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3020, 'ZONA CANALES BOGOTA NORTE', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3021, 'ZONA CANALES URABA/BAJO SINU', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3022, 'ZONA CANALES COSTA NORTE', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3023, 'ZONA BOLIVAR', 'PENDIENTE', 13001, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3024, 'ZONA SUR', 'PENDIENTE', 76001, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3025, 'ZONA CANALES SUR OCCIDENTE', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3026, 'ZONA CANALES BOLIVAR', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3027, 'ZONA CANALES EJE CAFETERO', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3028, 'ZONA CANALES TERRITORIOS NACIONALES', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3029, 'ZONA CANALES MEDELLIN SUR', 'PENDIENTE', 11001, 0, 'Z', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3031, 'ZONA SANTANDERES', 'IBAGUE', 73001, 0, 'Z', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3032, 'ZONA HUILA-TOLIMA', 'FLORIDABLANCA', 68276, 0, 'Z', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 3033, 'ZONA SUCRE', 'SUCRE', 19785, 0, 'Z', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4003, 'AV CARACAS', 'AVENIDA CARACAS N 74 - 51/55', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4005, 'BOSA', 'TRANSVERSAL 78 L  N 69 C - 02 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4006, 'BARRANCABERMEJA', 'CALLE 49 N∞ 14 - 51', 68081, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4007, 'FLORENCIA', 'CARRERA 14 N∫ 15-47', 18001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4008, 'GARZON', 'CARRERA 9 N∫ 7-18', 41298, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4009, 'PUERTO ASIS', 'CRR 20 NO. 11-35', 86568, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4010, 'CHIA', 'CALLE 10 N 9 - 13', 25175, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4011, 'CHIQUINQUIRA', 'CARRERA 10 N 11 - 23', 15176, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4012, 'FLORIDABLANCA', 'PENDIENTE', 68081, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4014, 'DUITAMA', 'CARRERA 14 N 15 - 09', 15238, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4015, 'EL TEJAR', 'CALLE 27 SUR N 52A - 09', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4016, 'FLORIDABLANCA', 'CALLE 29 # 31-12', 68276, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4017, 'ENGATIVA', 'CARRERA 113 B N 63 I - 39 L. 100 - 101', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4018, 'FACATATIVA', 'CALLE 6 N 4-82', 25269, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4019, 'SAN FERNANDO', 'AVENIDA CALLE 68 N 60 - 08', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4021, 'SAN JOSE DEL GUAVIARE', 'CARRERA 23 # 8-74', 95001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4022, 'FONTIBON', 'CALLE 17 N 100 - 16', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4024, 'FUNZA', 'CARRERA 14 N 13-85', 25286, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4025, 'FUSAGASUGA', 'CRA 6 Nß 5-54/58', 25290, 3, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4027, 'GIRARDOT', 'CARRERA 10 N 18 - 50', 25307, 2, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4030, 'KENNEDY', 'CALLE 36 SUR N 78 A - 28', 11001, NULL, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4031, 'PRIMERO DE MAYO', 'TRANSVERSAL 78H N 44A-05 SUR LOCAL 101/102', 11001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4032, 'LA LIBERTAD', 'CARRERA 88 C N 56 F - 36 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4033, 'LA VICTORIA', 'CALLE 39 SUR N 5 - 08 ESTE', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4034, 'MESITAS', 'CALLE 10 N 6 - 09', 25245, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4035, 'MOLINOS', 'CALLE 50 A SUR N 7 - 21', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4036, 'MONIQUIRA', 'CARRERA 3 N 16 - 163', 15469, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4040, 'PATIO BONITO', 'CRA 86 F N 36-16 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4043, 'QUIRIGUA', 'AVENIDA CALLE 82 N 82A-10', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4044, 'RESTREPO', 'AVENIDA 1ß DE MAYO N 16-54 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4045, 'CENTRO', 'CALLE 12 B # 8-45', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4046, 'SAN FRANCISCO', 'CARRERA 19 D N 61B - 40 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4047, 'PERDOMO', 'CALLE 63 SUR N 70B -58', 11001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4049, 'SANTA HELENITA', 'AVENIDA CALLE 72 N 77A - 56', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4050, 'SOACHA', 'AUTOPISTA SUR ()CRA 4)  N 15 - 34', 25754, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4051, 'PRINCIPAL', 'CARRERA 9 # 66-25', 11001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4053, 'SOGAMOSO', 'CALLE 11 N 12-03', 15759, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4054, 'SUBA', 'CALLE 139 N 112B-27', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4056, 'SUBA RINCON', 'CARERA 93 N 129 C-61', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4057, 'TOBERIN', 'CALLE 166 N 19B-70', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4058, 'BARRANCAS', 'AVENIDA 7 N 155 - 41', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4059, 'TUNJA', 'CARRERA 10 N 26 - 56', 15001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4060, 'UBATE', 'CARRERA 8 N 7-56', 25843, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4061, 'VENECIA', 'TRANSVERSAL 44 N 50 B - 14 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4064, 'VILLETA', 'CALLE 6 N 6-02', 25875, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4065, 'YOMASA', 'CARRERA 1A N 73 D - 83 SUR', 11001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4067, 'ZIPAQUIRA', 'CALLE 4 N 13 - 03 LOCAL A1', 25899, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4068, 'CENTRO DE CANJE BOGOTA', 'CARRERA 9 # 66-25', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4069, 'DIRECCION GENERAL', 'CRA9 # 66-25', 11001, 0, 'C', NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4070, 'YOPAL', 'CALLE 13 # 18 - 04', 85001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4071, 'OCA•A', 'CALLE 13 # 12 - 89', 54498, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4072, 'GARAGOA', 'CRA 9 # 8-58', 15299, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4073, 'PAMPLONA', 'CALLE 6 # 6 - 12', 54518, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4074, 'GALAN', 'CARRERA 56 N 4A-39', 11001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4075, 'CENTRO SUBA', 'AVENIDA SUBA CALLE 145 N 89-22', 11001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4076, 'SAN GIL', 'CALLE 10 # 9-63', 68679, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4077, 'CUCUTA ATALAYA', 'AVENIDA ATALAYA CALLE 5 AN # 26 - 04 BARRIO CLARET MANZANA 9 LOTE 20', 54001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4078, 'CUCUTA CENTRO', 'AVENIDA 7 # 12 - 27', 54001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4079, 'ARAUCA', 'CARRERA 20 # 22 - 44/48', 81001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4080, 'IBAGUE', 'CARRERA 5 N 43 - 125', 73001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4081, 'VILLAVICENCIO', 'CALLE 37 N∫ 28 - 63', 50001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4082, 'NEIVA', 'CRA 7 N∫ 10 - 46', 41001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4086, 'PITALITO', 'CLL 4 # 2 - 81', 41551, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4087, 'CHAPARRAL', 'CALLE 9 # 7 - 42', 73168, 2, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4088, 'GRANADA', 'Cr 13 N∞ 24-29 Centro', 50313, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4089, 'MALAGA', 'Cra 9 no. 13-50', 68432, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4096, 'ORIENTE', 'PENDIENTE', 20001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4097, 'CUNDINAMARCA', 'CUNDINAMARCA', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4098, 'BOGOTA SUR', 'BOGOTA SUR', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4099, 'BOGOTA NORTE', 'BOGOTA NORTE', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4100, 'PUERTO CARRE—O', 'PENDIENTE', 99001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4101, 'LETICIA', 'PENDIENTE', 91001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4102, 'MOCOA', 'Cra 5 No. 7-38', 86001, 2, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4103, 'ACACIAS', 'PENDIENTE', 50006, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4104, 'CIMITARRA', 'Cra 5 4-91 Lc.3', 68190, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4105, 'EL ZULIA', 'PENDIENTE', 54261, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4106, 'GIRaN', 'PENDIENTE', 68307, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4107, 'LA PLATA', 'PENDIENTE', 41396, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4108, 'ORITO', 'PENDIENTE', 86320, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4109, 'PUERTO INIRIDA', 'PENDIENTE', 94001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4110, 'PUERTO WILCHES', 'PENDIENTE', 68575, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4111, 'SOACHA COMPARTIR', 'Cra. 13 No 4-24', 25754, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4112, 'URIBIA', 'PENDIENTE', 44847, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4113, 'VALLEDUPAR II', 'Transversal 18 No20-46', 20001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4114, 'SAN VICENTE DEL CHUCURI', 'PENDIENTE', 68689, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4115, 'MITU', 'PENDIENTE', 97001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4116, 'PURIFICACION', 'PENDIENTE', 73585, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4117, 'TARAZA', 'PENDIENTE', 5790, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4525, 'SAN BERNARDO', 'PENDIENTE', 25649, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4551, 'LA CALERA', 'CARRERA 2 No. 5-45', 25377, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4564, 'GUADUAS', 'Cl 4 N∞ 5-94', 25320, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4570, 'AGUAZUL', 'Cr 18 No 21 51', 85010, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4571, 'ABREGO', 'CR 5 N∫13-27', 54003, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 4670, 'PAZ DE ARIPORO', 'Cra 9 # 9-36', 85250, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 5000, 'CENTRO DE EFECTIVO', 'CARRERA 9 # 66-25', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 5001, 'ZONA PEQUE—A EMPRESA', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 5002, 'ZONA BANCA RURAL', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2005', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 5003, 'TESORERIA', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 5004, 'BIENESTAR SOCIAL EMPLEADOS', 'BOGOTA', 11001, 0, 'Z', NULL, NULL, '2006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 6001, 'PEQUE—A EMPRESA BOGOT¶', 'BOGOTA', 11001, 0, 'O', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 6002, 'PEQUE—A EMPRESA MEDELLIN', 'MEDELLIN', 5001, 0, 'O', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 6003, 'PEQUE—A EMPRESA EJE CAFETERO', 'PEREIRA', 66001, 0, 'O', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 6004, 'PEQUE—A EMPRESA BARRANQUILLA', 'PENDIENTE', 8001, 0, 'O', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 6050, 'DIRECCIaN NACIONAL PEQUE—A EMPRESA', 'CALLE 9A # 66-25', 11001, 0, 'O', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7001, 'SAN JUAN', 'CALLE 44 N 72 - 46', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7002, 'ANDES', 'CALLE 49 N 50 - 60', 5034, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7003, 'APARTADO', 'CARRERA 100 N 99 -11', 5045, 5, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7004, 'PUERTO BERRIO', 'CARRERA 3 #50-25
', 5579, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7005, 'CIENAGA', 'CALLE 10 # 11-44', 47189, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7006, 'BELêEN', 'CALLE 30 A N 74-91', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7007, 'BARRANQUILLA LA CORDIALIDAD', 'PENDIENTE', 8001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7008, 'BELLO', 'CARRERA 48 N 46 - 99', 5088, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7009, 'SABANALARGA', 'CARRERA 23 # 22A-41', 8638, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7010, 'BUENOS AIRES', 'CALLE 49 # 36 - 48', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7011, 'TULUA', 'Calle 27 No. 26-60 local 307- 308- 404', 76834, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7012, 'CALDAS', 'CALLE 129 SUR N 48 - 29', 5129, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7013, 'BUENAVENTURA', 'Calle 8 No. 2B-22 local 102 del Edificio "Puerto Verde"', 76109, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7014, 'SAN JOSE DEL GUAVIARE', 'CARRERA 23 N∞ 8 - 74', 95001, 1, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7015, 'POPAY¡N SUR', 'PENDIENTE', 19001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7016, 'CAREPA', 'CALLE 77 N 76 -74', 5147, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7017, 'CARTAGENA', 'CL 31 # 21 - 71', 13001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7018, 'EL BANCO', 'CLL 11 # 2 A 61', 47245, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7019, 'CASTILLA', 'CARRERA 68 N 96 - 104', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7020, 'CAUCASIA', 'CALLE 20 # 12 - 34', 5154, 2, 'O', NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7021, 'CENTRO MEDELLIN', 'CALLE 57 # 48 - 28', 5001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7022, 'RIOHACHA', 'CALLE 4 N∫ 8-11', 44001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7023, 'CHINCHINA', 'CARRERA 9 # 9 - 75 PISO 1', 17174, 2, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7024, 'PALMIRA', 'CALLE 31 N∫ 28-36', 76520, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7025, 'COPACABANA', 'CARRERA 51 N 49 - 27 INT 201', 5212, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7026, 'POPAY¡N CENTRO', 'PENDIENTE', 19001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7027, 'EL BAGRE', 'CARRERA 46 # 58 - 04', 5250, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7028, 'PARQUE DE LAS LUCES', 'CRA 54 # 44 - 48 LOCAL 109', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7029, 'ENVIGADO', 'CARRERA 40 N 35 - 54 SUR L111', 5266, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7030, 'GUAYABAL', 'CARRERA 52 N 5 - 105', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7031, 'ITAGUI', 'CARRERA 49 N 53 - 27', 5360, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7032, 'LA DORADA', 'CALLE 12 # 3 - 49', 17380, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7033, 'LORICA', 'CARRERA 19 N 4-46 LOCAL 101', 23417, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7034, 'CARMEN DE BOLIVAR', 'calle 22 # 51 - 29', 13244, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7035, 'POPAY¡N NORTE', 'PENDIENTE', 19001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7036, 'VALLEDUPAR CENTRO', 'PENDIENTE', 20001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7037, 'MANIZALES', 'CALLE 24 N 21 - 19', 17001, 3, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7038, 'MANRIQUE', 'CARRERA 45 N 72 - 45', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7039, 'MARINILLA', 'CARRERA 30 N 28- 104', 5440, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7040, 'MONTERIA', 'CALLE 28 N 3-39', 23001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7041, 'NIQUIA', 'DIAGONAL 55 N 42 - 18', 5088, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7042, 'SANTA MARTA  AV.LIBERTADOR', 'PENDIENTE', 47001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7043, 'PEREIRA CUBA', 'PENDIENTE', 66001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7044, 'PEDREGAL', 'CALLE 104 N 74 - 18', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7045, 'IBAGU… CENTRO', 'PENDIENTE', 73001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7046, 'PLANETA RICA', 'CALLE 20 N 9-12', 23555, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7047, 'PLAZA MAYORISTA', 'PLAZA MAYORISTA', 5001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7048, 'BUCARAMANGA CENTRO', 'Carrera 15 N 42 07', 68001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7049, 'PIEDECUESTA', 'Carrera 8 N 7 09', 68547, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7051, 'RIONEGRO', 'CARRERA 51 N 51 - 60', 5615, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7052, 'ROBLEDO', 'CALLE 55 N 79 - 14 LOCAL 112', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7053, 'CALI NORTE', 'PENDIENTE', 76001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7054, 'SAHAGUN', 'CALLE 15 CARRERA 11', 23660, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7055, 'CALI SUR', 'PENDIENTE', 76001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7056, 'LA AMERICA', 'CALLE 44 # 86 - 40', 5001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7057, 'BUCARAMANGA NORTE', 'PENDIENTE', 68001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7059, 'SANTO DOMINGO', 'CALLE 106 N 32 A -07', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7060, 'SINCELEJO', 'CARRERA 25 N 20 A - 28', 70001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7061, 'SINCELEJO 2', 'CARRERA 25 N› 20A - 28', 70001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7062, 'SINCELEJO CENTRO', 'CARRERA 25 N 20 A - 28.', 70001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7064, 'TURBO', 'CARRERA 14 N 99 A - 04', 5837, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7065, 'TUMACO', 'CLL CALDAS CONTIGUO A LA ALCALDIA', 52835, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7066, 'PEQUE•A EMPRESA', 'PEQUE•A EMPRESA', 5001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7067, 'MINORISTA', 'CALLE 55 # 57 - 80', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7068, 'LA CEJA', 'CRA 21  # 21-28', 5376, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7069, 'EL CARMEN DE VIBORAL', 'CARRERA  30 N 29 - 74 LOCAL 103', 5001, 2, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7070, 'CENTRO DE CANJE MEDELLIN', 'CENTRO DE CANJE MEDELLIN', 5001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7071, 'ARMENIA', 'CRA 14 # 17 - 34', 63001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7072, 'CALARCA', 'CRA 25 # 42 - 20', 63130, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7073, 'PEREIRA', 'AVENIDA 30 DE AGOSTO # 28-34', 66001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7074, 'SANTA ROSA DE CABAL', 'CRA 14 # 11 - 05 EDIFICIO LA RESERVA', 66682, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7075, 'EL CABLE', 'CRA 23 # 55 A - 07', 17001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7076, 'SANTA MARTA', 'CRA 5 # 24A - 54 BARRIO LOS ANGELESDEL DISTRITO TURISTICO', 47001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7077, 'MAGANGUE', 'CALLE 15 # 3 - 54', 13430, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7078, 'AGUACHICA', 'CALLE 5 # 21 - 63 LOCAL 1', 20011, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7079, 'BARRANQUILLA', 'CALLE 39 # 41 - 115', 8001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7080, 'MARIQUITA', 'CALLE 7 # 2A - 18', 73443, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7081, 'CARTAGO', 'CALLE 12 # 2-67', 76147, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7082, 'MAICAO', 'CRA 9 # 11-35 MAICAO - GUAJIRA', 44430, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7083, 'VALLEDUPAR', 'TRANSVERSAL 18 # 20-46', 20001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7084, 'AGUSTIN CODAZZI', 'CALLE 18 # 15 - 46', 20013, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7085, 'ITAGUI SANTA MARIA', 'CALLE 86 # 51A 68', 5360, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7086, 'MONTELIBANO', 'CALLE 16 Nß 4-41CENTRO COMERCIAL ATENAS LOCAL 102-104', 23466, 3, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7087, 'MONTERIA CENTRO', 'CALLE 33 N∫ 1 - 71 - CENTRO', 23001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7088, 'QUIBDO', 'AVENIDA ALAMEDA N∫ 7 - 29', 27001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7089, 'FUNDACION', 'CALLE 7 # 7 - 35', 47288, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7090, 'SANTANDER DE QUILICHAO', 'CARRERA 11 # 5- 66', 19698, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7091, 'CALI JUNIN', 'CALLE 13 No 23 c 32', 76001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7092, 'BUGA', 'Carrera 13  No 4  57', 76111, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7093, 'YUMBO', 'CARRERA 4 # 4- 49', 76892, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7094, 'COSTA NORTE', 'COSTA NORTE', 13001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7095, 'BOYACA SANTANDERES', 'BOYACA SANTANDERES', 15001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7096, 'EJE CAFETERO', 'EJE CAFETERO', 17001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7097, 'MEDELLIN SUR', 'MEDELLIN SUR', 5001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7098, 'MEDELLIN NORTE', 'MEDELLIN NORTE', 5001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7099, 'BAJO CAUCA ANT', 'BAJO CAUCA ANT', 23001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7100, 'PUERTO BOYACA', 'CALLE 12 No 2  33', 15572, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7101, 'PASTO', 'Cra. 21 A # 16-15 C comercial Amorel Pasto', 52001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7102, 'PUERTO BOYACA', 'PENDIENTE', 15572, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7103, 'CERETE', 'Calle 13 N∫ 10-205', 23162, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7104, 'IPIALES', 'Carrera 7 No 11 20', 52356, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7105, 'MOMPOS', 'PENDIENTE', 13468, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7106, 'PLATO', 'CRA 15 10 62 LOS GUAYACANES', 47555, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7107, 'RIOSUCIO', 'Carrera 7 No 8 27', 17614, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7108, 'SANTAFE DE ANTIOQUIA', 'CALLE 11 8 82', 5042, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7109, 'YARUMAL', 'Cra. 21 # 18-60', 5887, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7110, 'FREDONIA', 'PENDIENTE', 5282, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7111, 'URRAO', 'Calle 29 No. 29-63', 5847, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7112, 'LIBANO', 'CL 6 12 49', 73411, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7113, 'LA UNION', 'Carrera 1 No 19 44', 52399, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7114, 'CARTAGENA SUR', 'Cr 30c 71 108 C.C. Shopping Center La Plazuela', 13001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7115, 'SANTA MARTA II', 'CALLE 14 # 4-38 CENTRO', 47001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7116, 'SOLEDAD', 'Calle 32 # 26-161 local 6 y 7, centro comercial la arboleda', 8758, 3, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7117, 'COROZAL', 'PENDIENTE', 70215, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7118, 'LA UNION VALLE', 'Cra. 15 16 - 55', 76400, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7119, 'CALI EL POBLADO', 'Carrera 28 F No 72 L 79 local 102', 76001, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7120, 'ARBOLETES', 'CALLE PRINCIPAL SECTOR LA Y', 5051, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7121, 'BOLIVAR', 'PENDIENTE', 19100, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7122, 'CALAMAR', 'PENDIENTE', 13140, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7123, 'EL CERRITO', 'PENDIENTE', 76248, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7124, 'CISNEROS', 'PENDIENTE', 5190, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7125, 'DABEIBA', 'PENDIENTE', 5234, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7126, 'FLORIDA', 'Calle 9 No 15 35', 76275, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7127, 'JAMUND+', 'Carrera 10  No 15 23', 76364, 1, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7128, 'MAJAGUAL', 'PENDIENTE', 70429, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7129, 'PIENDAMO', 'PENDIENET', 19548, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7130, 'SAMANIEGO', 'PENDIENTE', 52678, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7131, 'ISTMINA', 'PENDIENTE', 27361, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7132, 'SAN PEDRO DE URABA', 'PENDIENTE', 5665, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7133, 'SEGOVIA', 'PENDIENTE', 5736, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7134, 'AYAPEL', 'PENDIENTE', 23068, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7190, 'SUR OCCIDENTE', 'PENDIENTE', 76001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7191, 'URABA / BAJO SINU', 'DESCRIPCION', 23001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7192, 'TERRITORIOS NACIONALES', 'PENDIENTE', 11001, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7193, 'BOLIVAR', 'BOLIVAR', 13001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7194, 'SUR', 'PENDIENTE', 76001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7197, 'SUCRE-P', 'PENDIENTE', 19785, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7517, 'CARTAGENA DERIVADA', 'CL 31 # 21 - 71', 13001, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7522, 'FONSECA', 'PENDIENTE', 44279, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7527, 'NECHI', 'Calle 33 N∫30-26', 5495, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7533, 'MO—ITOS', 'CALLE 22B # 43-23', 23500, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7540, 'CERETE', 'PENDIENTE', 23162, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7554, 'SAN ANDRES DE SOTAVENTO', 'Calle 8B 7B-31', 23670, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7560, 'SAN MARCOS', 'Carrera 24 No 15-22', 70708, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7576, 'SANTA MARTA DERIVADA', 'CRA 5 # 24A - 54 BARRIO LOS ANGELESDEL DISTRITO TURISTICO', 47001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7583, 'BOSCONIA', 'Carrera 18 N∫17-30', 20060, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7587, 'TIERRALTA', 'CL 16 # 8-25', 23807, 1, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7617, 'ARJONA', 'Carrera 41 N› 48-51', 13052, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7633, 'CIENAGA DE ORO', 'CIENAGA DE ORO', 23189, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7687, 'PUERTO ESCONDIDO', 'PUERTO ESCONDIDO', 23574, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7733, 'SAN PELAYO', 'SAN PELAYO', 23686, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7917, 'CARTAGENA DERIVADA', 'CL 31 # 21 - 71', 13001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7960, 'SINCELEJO DERIVADA', 'CARRERA 25 N› 20A - 28', 70001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7961, 'SINCELEJO 2 DERIVADA', 'CARRERA 25 N› 20A - 28', 70742, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7962, 'SINCELEJO 3 DERIVADA', 'CARRERA 25 N 20 A - 28.', 70001, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7976, 'SANTA MARTA DERIVADA', 'CRA 5 # 24A - 54 BARRIO LOS ANGELESDEL DISTRITO TURISTICO', 47001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7978, 'AGUACHICA DERIVADA', 'CALLE 5 # 21 - 63 LOCAL 1', 20011, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7979, 'BARRANQUILLA DERIVADA', 'CALLE 39 # 41 - 115', 8001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7982, 'MAICAO DERIVADA', 'CRA 9 # 11-35 MAICAO - GUAJIRA', 44430, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7983, 'VALLEDUPAR DERIVADA', 'TRANSVERSAL 18 # 20-46', 20001, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7984, 'AGUSTIN CODAZZI DERIVADA', 'CALLE 18 # 15 - 46', 20013, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7985, 'SAN ONOFRE', 'PENDIENTE', 70713, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7986, 'PUERTO LIBERTADOR', 'PENDIENTE', 23580, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7987, 'VALENCIA', 'PENDIENTE', 23855, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7988, 'PIVIJAY', 'PENDIENTE', 47551, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7989, 'PAILITAS', 'PENDIENTE', 20517, 0, 'O', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7990, 'MOMPOX', 'PENDIENTE', 13468, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7991, 'AYAPEL', 'PENDIENTE', 23068, 0, 'O', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7993, 'CHINACOTA', 'PENDIENTE', 54172, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7994, 'GIRON', 'PENDIENTE', 68307, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 7995, 'VELEZ', 'PENDIENTE', 68861, 0, 'O', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8000, 'AGROINSUMOS DEL TEQUENDAMA', 'Cra 10 No. 14 - 85', 25878, 1, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8001, 'DROGERIA EL DIVINO SOL', 'CALLE 95 N 95C 23', 5172, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8002, 'DROGUERIA URABA', 'CALLE 50 CRA 50 A FRENTE AL PARQUE PRINCIPAL', 5490, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8003, 'SUPERTIENDA LA GANGUITA', 'CL 1 B ESTE N∫ 18 - 7 B - EL CARMEN (CALLE 2 DRA 18 ESQUINA', 23189, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8004, 'ALMACEN REMATES J.L.', 'CRA 7 N∫ 5 - 47', 23686, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8005, 'ALMACEN DE REPUESTOS DE MOTOS CHAKYMOTOS', 'CR 4 N∫ 5 - 58', 20400, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8006, 'DROGUERIA SALUDMAR', 'CLL 11 N∫ 6 07', 15322, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8007, 'DISTRIBUIDORA FB', 'CRA 16 N∫ 5 A - 10', 5308, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8008, 'ALMACEN DE ROPA NAGHA', 'CRA 4 N∫ 10 - 42', 68861, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8009, 'COMCEL ESTIVEN CEL', 'CRA 4 N 1 A  55', 15686, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8010, 'PAPELERIA Y VARIEDADES UN SOLO LUGAR', 'CR 3 N∫ 17 - 14', 23574, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8011, 'TELEPASCA', 'CALLE 2 N∫ 2 - 14', 25535, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8012, 'DROGUERIA RALDY SALUD', 'CRA 23 N∫ 23 - 48', 15516, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8013, 'GLADYS ARDILA POVEDA', 'PENDIENTE', 25845, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8014, 'AGROGUASCA', 'Calle 6 # 1-24', 25322, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8015, 'EL CENTRO DEL CALZADO Y LA MODA', 'Calle 4 No 5-11  Barrio El Centro', 41306, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8016, 'ENA LUZ ARROLLO MARTINEZ', 'Calle 50  Carrera 59 Esquina', 5665, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8017, 'HOTEL LOS ALMENDROS', 'Carrera 6 # 4-33 barrio centro', 20517, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8018, 'JOSE WILMAR SANCHEZ AGUDELO', 'PENDIENTE', 5895, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8019, 'PAPELERIA NANDOS DAHN', 'Calle 5  # 4- 53', 25183, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8020, 'PANADERIA LA ESPIGA', 'CARRERA 20 # 19 - 64', 70713, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8021, 'DROGUERIA AVENIDA', 'AVENIDA NU—EZ', 70400, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8022, 'DEPOSITO SANTO DOMINGO DE MOMIL', 'CARRERA 10 Nß 10 - 02 BARRIO VENEZUELA', 23464, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8023, 'PANADERIA Y CAFETERIA LA ESPIGA', 'CARRERA 3 Nß 8 - 35', 76243, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8024, 'DROGUERIA ANGELICA', 'CARRERA 9 Nß 7 - 15 BARRIO 20 DE JULIO', 23580, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8025, 'CRISTALERIA Y TIENDA DE ASEO EL CRISTAL', 'CARRERA 26 Nß 37 - 44 BARRIO POBLADO', 68307, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8026, 'CREDI JAPON', 'CARRERA 100 Nß 94B - 89', 5172, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8027, 'MINI MERCADO VIVIANA', 'CARRERA 6 N∫ 2G - 10', 68051, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8028, 'PAPELERIA Y CACHARRERIA SERVITODO', 'CARRERA 15 N∫ 20 - 07', 13442, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8029, 'AGROFERRETERIA LA CAVA', 'CALLE 9 N∫ 3 - 06', 20045, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8030, 'PANADERIA CENTRAL LA VI—A', 'CARRERA 8 N∫ 7 - 63', 20550, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8031, 'GRANERO EL CAMPESINO DE SAN BERNARDO', 'CARRERA 10 N∫ 9 - 3', 23675, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8032, 'AGROPECUARIA LA GRANJA GUARANDA', 'CALLE 3 DEL COMERCIO', 70265, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8033, 'FOTOPUEBLONUEVO', 'CARRERA 11 N∫ 15- 34', 23570, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8034, 'DROGUERIA EL CAFETERO', 'CARRERA 6 N∫ 7 - 65', 17653, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8035, 'FERRETERIA EL COLMADO', 'CARRERA 2 N∫ 16 - 53', 85139, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8036, 'ALMACEN Y VARIEDADES SANTY N∫ 2', 'CALLE 12 # 18 - 14', 23672, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8037, 'BICIMOTOS JUDITH VALENTINA', 'CALLE 6 # 7 - 30', 68229, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8038, 'INDUSTRIA DEPORTIVA PEREZ', 'CALLE 6 N∫ 5 - 44 BARRIO CENTRO', 73124, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8039, 'PANADERIA Y CAFETERIA LA ESPIGA DORADA', 'CALLE EL PALO 26A - 23', 5686, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8040, 'DROGAS LA OPORTUNIDAD', 'CARRERA 11 N∫ 27A - 36', 70418, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8041, 'GANGAS Y GANGAS DE TOLU VIEJO', 'DIAGONAL 2 # 6A - 06', 70823, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8042, 'DROGUERIA MODERNA', 'CALLE 11 0A - 03 ENTRADA EL CARMEN', 54245, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8043, 'VARIEDADES SAN PEDRO', 'CARRERA 9 # 13-25', 70717, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8044, 'SUPER DROGAS LA MAS BARATA', 'CARRERA 10 # 10 - 32 CALLE SUCRE', 70742, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8045, 'VARIEDADES MEDELLIN', 'CARRERA 7 # 16 - 50', 23182, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8046, 'TOBY SUPERDROGUERIA', 'CARRERA 3 # 19 - 07', 70820, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8047, 'PUNTO DE VENTA COLANTA AMAGA', 'CARRERA 50 # 50 - 06 PARQUE PRINCIPAL', 5030, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8048, 'VARIEDADES EL GANGAZO', 'CARRERA 10 # 3 - 168', 20750, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8049, 'DROGUERIA EL COMERCIO', 'CARRERA 7 # 3 - 33', 54174, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8050, 'AUTO SERVICIO LA COSECHA', 'CARRERA 20 N∫ 21 - 26', 76828, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8051, 'FERRETOLEDO', 'AV 5 CALLE 12 ESQUINA', 54820, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8053, 'ALMACEN JM', 'CARRERA BOLIVAR', 5190, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8054, 'ALMACEN SHEKINA KARLA', 'CARRERA 10 N∫ 08 - 05 AL LADO DEL JUZGADO', 5480, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8055, 'ALMAC…N AGRO-LECHERO', 'CALLE 5 # 5 - 76 CENTRO', 18029, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8056, 'MULTIMERKAR', 'CARRERA 9 # 7 - 15 BARRIO EL JARDIN', 18753, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8057, 'CHOPLY BROASTER', 'CARRERA 19 # 4 - 15', 70429, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8058, 'TIENDA NATURISTA FLOR DE LA SALUD', 'CALLE 13 # 3™ - 52 CENTRO', 73001, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8059, 'DROGUERIA PA'' MI VILLANUEVA', 'CALLE 15 # 14 - 55 FRENTE AL HOSPITAL', 68872, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8060, 'ALMACEN Y FERRETERIA ADA SOFIA', 'CALLE 5 N∫ 6 - 72', 47660, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8061, 'SUPER TIENDA LA AVENIDA', 'CRA 11 N∫ 11 - 92', 23068, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8062, 'FERRETERIA SINU VALENCIA', 'Calle 12 # 16 - 57', 23855, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8063, 'SUPERMERCADO EL LICEO', 'Carrera 1 # 17 -05', 76400, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8064, 'DROGUERIA SANTANDER', 'Calle 14 # 12 - 15 La Bonga', 47551, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8065, 'FARMACIA CENTRAL', 'Calle 2 # 2B - 71', 23001, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8066, 'VARIEDADES BAMBU', 'Calle 9 Carrera 4 esquina Barrio Lara Zona bambu', 47318, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8067, 'DE MIS MANOS', 'Calle 49B # 65 - 65', 5001, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8068, 'EPAGO PUERTO ESCONDIDO', 'Cr 3 No.12- 99 Barrio 20 de Julio', 23574, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8069, 'EPAGO SAN PELAYO', 'Carrera 7 No. 4-59', 23686, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8070, 'EPAGO CIENAGA DE ORO', 'Calle 6 No. 16-30', 23189, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8071, 'MOTOS ALVARO VELEZ', 'Calle 2 # 3-33', 54172, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8072, 'VARIEDADES SAN FRANCISCO', 'Calle 20 # 2-30', 13468, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8073, 'EPAGO SAN ONOFRE', 'Carrera 20 No 19-70', 70713, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8074, 'EPAGO PUERTO LIBERTADOR', 'Cr 9 9-96 B/ Las Cruces', 23580, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8075, 'CASA MOTO', 'Carrera 4 N∞ 9 - 75', 76823, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8076, 'EPAGO PIVIJAY', 'Calle 18 #13-77', 47551, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8077, 'Epago VELEZ', 'Carrera 3 # 10 - 84', 68861, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8078, 'EL RINCON DE JORGE', 'Calle 8  # 6 - 65', 76400, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8079, 'Epago Piedecuesta', 'Carrera 8 N∞ 7 - 09', 68547, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8080, 'Epago Pereira', 'Calle 72 N∞ 26 - 31 Local 1', 66001, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8081, 'LUISA G FASHION', 'Carrera 4 N∞ 7 - 76', 20400, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8082, 'VARIEDADES VANNE', 'Carrera 7 †N∞ 14 - 27 Parque', 17388, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8083, 'ALMACEN AGROPECUARIO SUELOS Y GANADOS', 'Calle 51 N∞ 50 - 36', 5665, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8084, 'ALMACEN AGROPECUARIO MOMA', 'CA KDX A 4 260 CL CENTRAL', 54344, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8085, 'EPAGO PAILITAS', 'Carrera 7 # 5 - 13', 20517, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8086, 'EPAGO MOMPOS', 'Calle 20 1-19/25', 13468, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8087, 'EPAGO AYAPEL', 'Calle 9 N∞ 4 -81', 23068, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 8999, 'MovilRed', 'Carrera 21 No. 169 - 45', 11001, 0, 'O', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9001, 'GERENCIA SEGMENTO AGRO', 'BOGOTA', 11001, 0, 'O', NULL, NULL, '2005', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N')
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9007, 'CANALES', 'PENDIENTE', 11001, 0, 'C', NULL, NULL, '2007', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9901, 'OCCIDENTE', 'MEDELLIN', 13001, 0, 'C', NULL, NULL, '2001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9902, 'CENTRO', 'CRA 9 # 66-25', 11001, 0, 'C', NULL, NULL, '2002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9903, 'T. ELIMINAR', 'CRA 9 # 66-25', 11001, 0, 'C', NULL, NULL, '2003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9904, 'PEQUE—A EMPRESA', 'BOGOTA', 11001, 0, 'C', NULL, NULL, '2004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9905, 'BANCA RURAL', 'BOGOTA', 11001, 0, 'C', NULL, NULL, '2005', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9906, 'AREAS CENTRALES', 'CARRERA 9A # 66-25', 11001, 0, 'C', NULL, NULL, '2006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_zona, of_sucursal, of_cob, of_bloqueada) VALUES (1, 9907, 'SUR', 'CALLE 13 No 23 c 32', 76001, 0, 'C', NULL, NULL, '2008', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO


---------------------------------------------------------
--CATALOGO DE OFICINAS---------------------------------------


use cobis
GO

declare @w_tabla_desc catalogo ,
        @w_codigo   int
        
select @w_tabla_desc  = 'cl_oficina'

select @w_codigo = codigo from cobis..cl_tabla 
where tabla = 'cl_oficina'

delete from cobis..cl_catalogo 
where tabla = @w_codigo


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '0', 'DIRECCION GENERAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '1', 'CASA MATRIZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '107', 'BIENESTAR SOCIAL EMPLEADOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '12', 'CONCEPCION', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '13', 'CHANGUINOLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '15', 'CHORRERA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '16', 'BOQUETE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '17', 'PLAZA MIRAGE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '18', 'LAS TABLAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '20', 'CENTRO DE PRESTAMOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2001', 'REGIONAL NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2002', 'REGIONAL CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2003', 'TERRITORIAL OCCIDENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2004', 'PEQUE—A EMPRESA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2005', 'BANCA RURAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2006', 'AREAS CENTRALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2007', 'REGIONAL CANALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2008', 'REGIONAL SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '21', 'PAITILLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '22', 'TORRE GLOBAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '23', 'COLON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '24', 'PARQUE PORRAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '25', 'ALBROOK', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '26', 'LOS ANDES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '27', 'PARQUE LEFEVRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '28', 'BETHANIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '2', 'CAMPO LIMBERG', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3', 'SANTIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '30', 'SAN FRANCISCO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3001', 'ZONA BOTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3002', 'ZONA BOTA SUR  ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3003', 'ZONA CUNDINAMARCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3004', 'ZONA ORIENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3005', 'ZONA URABA / BAJO SINU', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3006', 'ZONA TERRITORIOS NACIONALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3007', 'ZONA BAJO CAUCA ANT', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3008', 'ZONA SUR OCCIDENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3009', 'ZONA MEDELLÕN NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3010', 'ZONA MEDELLÕN SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3011', 'ZONA EJE CAFETERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3012', 'ZONA BOYACA-CASANARE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3013', 'ZONA COSTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3014', 'ZONA CANALES CUNDINAMARCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3015', 'ZONA CANALES BAJO CAUCA ANT', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3016', 'ZONA CANALES ORIENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3017', 'ZONA CANALES SANTANDERES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3018', 'ZONA CANALES MEDELLIN NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3019', 'ZONA CANALES BOTA SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3020', 'ZONA CANALES BOTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3021', 'ZONA CANALES URABA/BAJO SINU', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3022', 'ZONA CANALES COSTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3023', 'ZONA BOLIVAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3024', 'ZONA SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3025', 'ZONA CANALES SUR OCCIDENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3026', 'ZONA CANALES BOLIVAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3027', 'ZONA CANALES EJE CAFETERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3028', 'ZONA CANALES TERRITORIOS NACIONALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3029', 'ZONA CANALES MEDELLIN SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3031', 'ZONA SANTANDERES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3032', 'ZONA HUILA-TOLIMA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '3033', 'ZONA SUCRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4', 'CENTRO DE TARJETAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '40', 'AVANCE GLOBAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4003', 'AV CARACAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4005', 'BOSA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4006', 'BARRANCABERMEJA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4007', 'FLORENCIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4008', 'GARZON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4009', 'PUERTO ASIS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4010', 'CHIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4011', 'CHIQUINQUIRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4012', 'FLORIDABLANCA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4014', 'DUITAMA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4015', 'EL TEJAR ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4016', 'FLORIDABLANCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4017', 'ENGATIVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4018', 'FACATATIVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4019', 'SAN FERNANDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4021', 'SAN JOSE DEL GUAVIARE', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4022', 'FONTIBON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4024', 'FUNZA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4025', 'FUSAGASUGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4027', 'GIRARDOT', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4030', 'KENNEDY', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4031', 'PRIMERO DE MAYO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4032', 'LA LIBERTAD ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4033', 'LA VICTORIA ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4034', 'MESITAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4035', 'MOLINOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4036', 'MONIQUIRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4040', 'PATIO BONITO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4043', 'QUIRIGUA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4044', 'RESTREPO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4045', 'CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4046', 'SAN FRANCISCO ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4047', 'PERDOMO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '404@w_codigo', 'SANTA HELENITA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4050', 'SOACHA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4051', 'PRINCIPAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4053', 'SOGAMOSO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4054', 'SUBA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4056', 'SUBA RINCON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4057', 'TOBERIN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4058', 'BARRANCAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4059', 'TUNJA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4060', 'UBATE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4061', 'VENECIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4064', 'VILLETA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4065', 'YOMASA ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4067', 'ZIPAQUIRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4068', 'CENTRO DE CANJE BOTA ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4069', 'DIRECCION GENERAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4070', 'YOPAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4071', 'OCA•A', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4072', 'GARAA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4073', 'PAMPLONA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4074', 'GALAN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4075', 'CENTRO SUBA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4076', 'SAN GIL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4077', 'CUCUTA ATALAYA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4078', 'CUCUTA CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4079', 'ARAUCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4080', 'IBAGUE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4081', 'VILLAVICENCIO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4082', 'NEIVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4086', 'PITALITO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4087', 'CHAPARRAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4088', 'GRANADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4089', 'MALAGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4096', 'ORIENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4097', 'CUNDINAMARCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4098', 'BOTA SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4099', 'BOTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4100', 'PUERTO CARRE—O', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4101', 'LETICIA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4102', 'MOCOA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4103', 'ACACIAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4104', 'CIMITARRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4105', 'EL ZULIA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4106', 'GIRaN', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4107', 'LA PLATA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4108', 'ORITO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4109', 'PUERTO INIRIDA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4110', 'PUERTO WILCHES', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4111', 'SOACHA COMPARTIR', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4112', 'URIBIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4113', 'VALLEDUPAR II', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4114', 'SAN VICENTE DEL CHUCURI', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4115', 'MITU', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4116', 'PURIFICACION', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4117', 'TARAZA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '45', 'BANCA CORPORATIVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4525', 'SAN BERNARDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4551', 'LA CALERA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4564', 'GUADUAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4570', 'AGUAZUL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4571', 'ABRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '4670', 'PAZ DE ARIPORO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '47', 'FACTOR GLOBAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '48', 'CAJA CENTRO DE COBROS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5', 'CORONADO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '50', 'BANCA PRIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5000', 'CENTRO DE EFECTIVO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5001', 'ZONA PEQUE—A EMPRESA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5002', 'ZONA BANCA RURAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5003', 'TESORERIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '5004', 'BIENESTAR SOCIAL EMPLEADOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '51', 'OFICINA PRUEBAS PER-AHO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6', 'PENONOME', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6001', 'PEQUE—A EMPRESA BOT¶', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6002', 'PEQUE—A EMPRESA MEDELLIN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6003', 'PEQUE—A EMPRESA EJE CAFETERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6004', 'PEQUE—A EMPRESA BARRANQUILLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '6050', 'DIRECCIaN NACIONAL PEQUE—A EMPRESA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7', 'SAN FERNANDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7001', 'SAN JUAN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7002', 'ANDES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7003', 'APARTADO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7004', 'PUERTO BERRIO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7005', 'CIENAGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7006', 'BEL_EN ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7007', 'BARRANQUILLA LA CORDIALIDAD', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7008', 'BELLO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7009', 'SABANALARGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7010', 'BUENOS AIRES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7011', 'TULUA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7012', 'CALDAS ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7013', 'BUENAVENTURA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7014', 'SAN JOSE DEL GUAVIARE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7015', 'POPAY¡N SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7016', 'CAREPA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7017', 'CARTAGENA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7018', 'EL BANCO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7019', 'CASTILLA ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7020', 'CAUCASIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7021', 'CENTRO MEDELLIN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7022', 'RIOHACHA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7023', 'CHINCHINA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7024', 'PALMIRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7025', 'COPACABANA  ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7026', 'POPAY¡N CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7027', 'EL BAGRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7028', 'PARQUE DE LAS LUCES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7029', 'ENVIGADO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7030', 'GUAYABAL ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7031', 'ITAGUI ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7032', 'LA DORADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7033', 'LORICA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7034', 'CARMEN DE BOLIVAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7035', 'POPAY¡N NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7036', 'VALLEDUPAR CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7037', 'MANIZALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7038', 'MANRIQUE ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7039', 'MARINILLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7040', 'MONTERIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7041', 'NIQUIA ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7042', 'SANTA MARTA  AV.LIBERTADOR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7043', 'PEREIRA CUBA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7044', 'PEDREGAL ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7045', 'IBAGU… CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7046', 'PLANETA RICA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7047', 'PLAZA MAYORISTA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7048', 'BUCARAMANGA CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7049', 'PIEDECUESTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7051', 'RIONEGRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7052', 'ROBLEDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7053', 'CALI NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7054', 'SAHAGUN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7055', 'CALI SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7056', 'LA AMERICA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7057', 'BUCARAMANGA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7059', 'SANTO DOMIN ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7060', 'SINCELEJO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7061', 'SINCELEJO 2', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7062', 'SINCELEJO CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7064', 'TURBO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7065', 'TUMACO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7066', 'PEQUE•A EMPRESA  ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7067', 'MINORISTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7068', 'LA CEJA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7069', 'EL CARMEN DE VIBORAL ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7070', 'CENTRO DE CANJE MEDELLIN  ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7071', 'ARMENIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7072', 'CALARCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7073', 'PEREIRA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7074', 'SANTA ROSA DE CABAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7075', 'EL CABLE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7076', 'SANTA MARTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7077', 'MAGANGUE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7078', 'AGUACHICA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7079', 'BARRANQUILLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7080', 'MARIQUITA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7081', 'CARTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7082', 'MAICAO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7083', 'VALLEDUPAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7084', 'AGUSTIN CODAZZI', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7085', 'ITAGUI SANTA MARIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7086', 'MONTELIBANO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7087', 'MONTERIA CENTRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7088', 'QUIBDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7089', 'FUNDACION', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7090', 'SANTANDER DE QUILICHAO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7091', 'CALI JUNIN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7092', 'BUGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7093', 'YUMBO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7094', 'COSTA NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7095', 'BOYACA SANTANDERES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7096', 'EJE CAFETERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7097', 'MEDELLIN SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7098', 'MEDELLIN NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7099', 'BAJO CAUCA ANT', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7100', 'PUERTO BOYACA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7101', 'PASTO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7102', 'PUERTO BOYACA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7103', 'CERETE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7104', 'IPIALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7105', 'MOMPOS', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7106', 'PLATO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7107', 'RIOSUCIO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7108', 'SANTAFE DE ANTIOQUIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7109', 'YARUMAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7110', 'FREDONIA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7111', 'URRAO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7112', 'LIBANO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7113', 'LA UNION', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7114', 'CARTAGENA SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7115', 'SANTA MARTA II', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7116', 'SOLEDAD', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7117', 'COROZAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7118', 'LA UNION VALLE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7119', 'CALI EL POBLADO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7120', 'ARBOLETES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7121', 'BOLIVAR', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7122', 'CALAMAR', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7123', 'EL CERRITO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7124', 'CISNEROS', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7125', 'DABEIBA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7126', 'FLORIDA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7127', 'JAMUND+', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7128', 'MAJAGUAL', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7129', 'PIENDAMO', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7130', 'SAMANIE', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7131', 'ISTMINA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7132', 'SAN PEDRO DE URABA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7133', 'SEVIA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7134', 'AYAPEL', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7190', 'SUR OCCIDENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7191', 'URABA / BAJO SINU', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7192', 'TERRITORIOS NACIONALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7193', 'BOLIVAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7194', 'SUR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7197', 'SUCRE-P', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7517', 'CARTAGENA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7522', 'FONSECA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7527', 'NECHI', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7533', 'MO—ITOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7540', 'CERETE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7554', 'SAN ANDRES DE SOTAVENTO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7560', 'SAN MARCOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7576', 'SANTA MARTA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7583', 'BOSCONIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7587', 'TIERRALTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7617', 'ARJONA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7633', 'CIENAGA DE ORO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7687', 'PUERTO ESCONDIDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7733', 'SAN PELAYO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7917', 'CARTAGENA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7960', 'SINCELEJO DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7961', 'SINCELEJO 2 DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7962', 'SINCELEJO 3 DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7976', 'SANTA MARTA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7978', 'AGUACHICA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7979', 'BARRANQUILLA DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7982', 'MAICAO DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7983', 'VALLEDUPAR DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7984', 'AGUSTIN CODAZZI DERIVADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7985', 'SAN ONOFRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7986', 'PUERTO LIBERTADOR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7987', 'VALENCIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7988', 'PIVIJAY', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7989', 'PAILITAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7990', 'MOMPOX', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7991', 'AYAPEL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7993', 'CHINACOTA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7994', 'GIRON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '7995', 'VELEZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8', 'AGUADULCE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8000', 'AGROINSUMOS DEL TEQUENDAMA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8001', 'DROGERIA EL DIVINO SOL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8002', 'DROGUERIA URABA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8003', 'SUPERTIENDA LA GANGUITA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8004', 'ALMACEN REMATES J.L.', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8005', 'ALMACEN DE REPUESTOS DE MOTOS CHAKYMOTOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8006', 'DROGUERIA SALUDMAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8007', 'DISTRIBUIDORA FB', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8008', 'ALMACEN DE ROPA NAGHA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8009', 'COMCEL ESTIVEN CEL', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8010', 'PAPELERIA Y VARIEDADES UN SOLO LUGAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8011', 'TELEPASCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8012', 'DROGUERIA RALDY SALUD', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8013', 'GLADYS ARDILA POVEDA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8014', 'AGROGUASCA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8015', 'EL CENTRO DEL CALZADO Y LA MODA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8016', 'ENA LUZ ARROLLO MARTINEZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8017', 'HOTEL LOS ALMENDROS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8018', 'JOSE WILMAR SANCHEZ AGUDELO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8019', 'PAPELERIA NANDOS DAHN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8020', 'PANADERIA LA ESPIGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8021', 'DROGUERIA AVENIDA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8022', 'DEPOSITO SANTO DOMIN DE MOMIL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8023', 'PANADERIA Y CAFETERIA LA ESPIGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8024', 'DROGUERIA ANGELICA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8025', 'CRISTALERIA Y TIENDA DE ASEO EL CRISTAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8026', 'CREDI JAPON', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8027', 'MINI MERCADO VIVIANA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8028', 'PAPELERIA Y CACHARRERIA SERVITODO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8029', 'AGROFERRETERIA LA CAVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8030', 'PANADERIA CENTRAL LA VI—A', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8031', 'GRANERO EL CAMPESINO DE SAN BERNARDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8032', 'AGROPECUARIA LA GRANJA GUARANDA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8033', 'FOTOPUEBLONUEVO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8034', 'DROGUERIA EL CAFETERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8035', 'FERRETERIA EL COLMADO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8036', 'ALMACEN Y VARIEDADES SANTY N∫ 2', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8037', 'BICIMOTOS JUDITH VALENTINA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8038', 'INDUSTRIA DEPORTIVA PEREZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8039', 'PANADERIA Y CAFETERIA LA ESPIGA DORADA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8040', 'DROGAS LA OPORTUNIDAD', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8041', 'GANGAS Y GANGAS DE TOLU VIEJO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8042', 'DROGUERIA MODERNA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8043', 'VARIEDADES SAN PEDRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8044', 'SUPER DROGAS LA MAS BARATA', 'B', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8045', 'VARIEDADES MEDELLIN', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8046', 'TOBY SUPERDROGUERIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8047', 'PUNTO DE VENTA COLANTA AMAGA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8048', 'VARIEDADES EL GANGAZO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8049', 'DROGUERIA EL COMERCIO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8050', 'AUTO SERVICIO LA COSECHA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8051', 'FERRETOLEDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8053', 'ALMACEN JM', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8054', 'ALMACEN SHEKINA KARLA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8055', 'ALMAC…N AGRO-LECHERO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8056', 'MULTIMERKAR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8057', 'CHOPLY BROASTER', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8058', 'TIENDA NATURISTA FLOR DE LA SALUD', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8059', 'DROGUERIA PA'' MI VILLANUEVA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8060', 'ALMACEN Y FERRETERIA ADA SOFIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8061', 'SUPER TIENDA LA AVENIDA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8062', 'FERRETERIA SINU VALENCIA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8063', 'SUPERMERCADO EL LICEO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8064', 'DROGUERIA SANTANDER', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8065', 'FARMACIA CENTRAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8066', 'VARIEDADES BAMBU', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8067', 'DE MIS MANOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8068', 'EPA PUERTO ESCONDIDO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8069', 'EPA SAN PELAYO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8070', 'EPA CIENAGA DE ORO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8071', 'MOTOS ALVARO VELEZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8072', 'VARIEDADES SAN FRANCISCO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8073', 'EPA SAN ONOFRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8074', 'EPA PUERTO LIBERTADOR', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8075', 'CASA MOTO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8076', 'EPA PIVIJAY', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8077', 'Epa VELEZ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8078', 'EL RINCON DE JORGE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8079', 'Epa Piedecuesta', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8080', 'Epa Pereira', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8081', 'LUISA G FASHION', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8082', 'VARIEDADES VANNE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8083', 'ALMACEN AGROPECUARIO SUELOS Y GANADOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8084', 'ALMACEN AGROPECUARIO MOMA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8085', 'EPA PAILITAS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8086', 'EPA MOMPOS', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8087', 'EPA AYAPEL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '8999', 'MovilRed', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9', 'CHITRE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9001', 'GERENCIA SEGMENTO AGRO', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9007', 'CANALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9901', 'NORTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9902', 'CENTRO ', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9903', 'OCCIDENTE', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9904', 'PEQUE—A EMPRESA', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9905', 'BANCA RURAL', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9906', 'AREAS CENTRALES', 'V', NULL, NULL, NULL)


INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_codigo, '9907', 'SUR', 'V', NULL, NULL, NULL)

GO