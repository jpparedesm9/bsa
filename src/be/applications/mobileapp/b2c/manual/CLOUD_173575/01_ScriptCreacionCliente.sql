
use cobis
go

declare @w_ente int 

if not exists(select 1 from cobis..cl_ente where en_ced_ruc = 'USUARIOB2C')
begin
   exec cobis..sp_cseqnos
        @t_debug     = 'N',
        @t_file      = 'sp_crea_persona',
        @t_from      = 'sp_crea_persona',
        @i_tabla     = 'cl_ente',
        @o_siguiente = @w_ente out
end
else 
   select @w_ente = en_ente from cobis..cl_ente where en_ced_ruc = 'USUARIOB2C'


if not exists (select 1 from cobis..cl_ente where en_ente = @w_ente)
begin
   insert into cl_ente (en_ente, en_nombre, en_subtipo, en_filial, en_oficina, en_ced_ruc, en_fecha_crea, en_fecha_mod, en_direccion, en_referencia, en_casilla, en_casilla_def, en_tipo_dp, en_balance, en_grupo, en_pais, en_oficial, en_actividad, en_retencion, en_mala_referencia, en_comentario, en_cont_malas, s_tipo_soc_hecho, en_tipo_ced, en_sector, en_referido, en_nit, en_doc_validado, en_rep_superban, p_p_apellido, p_s_apellido, p_sexo, p_fecha_nac, p_ciudad_nac, p_lugar_doc, p_profesion, p_pasaporte, p_estado_civil, p_num_cargas, p_num_hijos, p_nivel_ing, p_nivel_egr, p_nivel_estudio, p_tipo_persona, p_tipo_vivienda, p_calif_cliente, p_personal, p_propiedad, p_trabajo, p_soc_hecho, p_fecha_emision, p_fecha_expira, c_cap_suscrito, en_asosciada, c_posicion, c_tipo_compania, c_rep_legal, c_activo, c_pasivo, c_es_grupo, c_capital_social, c_reserva_legal, c_fecha_const, en_nomlar, c_plazo, c_direccion_domicilio, c_fecha_inscrp, c_fecha_aum_capital, c_cap_pagado, c_tipo_nit, c_tipo_soc, c_total_activos, c_num_empleados, c_sigla, c_escritura, c_notaria, c_ciudad, c_fecha_exp, c_fecha_vcto, c_camara, c_registro, c_grado_soc, c_fecha_registro, c_fecha_modif, c_fecha_verif, c_vigencia, c_verificado, c_funcionario, en_situacion_cliente, en_patrimonio_tec, en_fecha_patri_bruto, en_gran_contribuyente, en_calificacion, en_reestructurado, en_concurso_acreedores, en_concordato, en_vinculacion, en_tipo_vinculacion, en_oficial_sup, en_cliente, en_preferen, c_edad_laboral_promedio, c_empleados_ley_50, en_exc_sipla, en_exc_por2, en_digito, p_depa_nac, p_pais_emi, p_depa_emi, en_categoria, en_emala_referencia, en_banca, c_total_pasivos, en_pensionado, en_rep_sib, en_max_riesgo, en_riesgo, en_mries_ant, en_fmod_ries, en_user_ries, en_reservado, en_pas_finan, en_fpas_finan, en_fbalance, en_relacint, en_otringr, en_exento_cobro, en_doctos_carpeta, en_oficina_prod, en_accion, en_procedencia, en_fecha_negocio, en_estrato, en_recurso_pub, en_influencia, en_persona_pub, en_victima, en_bancarizado, en_alto_riesgo, en_fecha_riesgo, en_estado, p_c_apellido, p_s_nombre, en_calif_cartera, en_cod_otro_pais, en_ingre, en_nacionalidad, p_dep_doc, p_numord, c_razon_social, c_segmento, en_cem, en_promotor, en_inss, en_licencia, en_id_tutor, en_nom_tutor, en_referidor_ecu, p_carg_pub, p_rel_carg_pub, p_situacion_laboral, p_bienes, en_otros_ingresos, en_origen_ingresos, c_codsuper, en_nro_ciclo, en_emproblemado, en_dinero_transac, en_manejo_doc, en_persona_pep, en_rfc, en_ing_SN, en_nac_aux, en_banco)
                values (@w_ente, 'USUARIO GOOGLE', 'P'       , 1        , 1053      , 'USUARIOB2C', '2021-11-03', '2021-11-04', 3, 0, 0, NULL, NULL, 0, NULL, NULL, 1743, NULL, 'S', 'N', NULL, NULL, NULL, 'CURP', NULL, NULL, 'USUARIOB2C', 'N', 'N', ' B2C', ' B2C', 'F', '1976-09-09', 484, NULL, '002', NULL, 'SO', 2, NULL, 0, 0, '003', '1', NULL, 'VERDE', 0, 0, 0, NULL, NULL, '2023-09-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 'USUARIO  B2C', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-11-04', NULL, 'N', 'carocampo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 484, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10', 484, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 20000, NULL, NULL, NULL, 'N', NULL, NULL, 'N', 'JIPL760909529', 'N', '1', '12345678')
end 

select *  from cobis..cl_ente where en_ente = @w_ente

if not exists(select 1 from cobis..cl_ente_aux where ea_ente = @w_ente)
begin
   insert into dbo.cl_ente_aux (ea_ente, ea_estado, ea_observacion_aut, ea_contrato_firmado, ea_menor_edad, ea_conocido_como, ea_cliente_planilla, ea_cod_risk, ea_sector_eco, ea_actividad, ea_lin_neg, ea_seg_neg, ea_ejecutivo_con, ea_suc_gestion, ea_constitucion, ea_remp_legal, ea_apoderado_legal, ea_no_req_kyc_comp, ea_fuente_ing, ea_act_prin, ea_detalle, ea_act_dol, ea_cat_aml, ea_fecha_vincula, ea_observacion_vincula, ea_ced_ruc, ea_discapacidad, ea_tipo_discapacidad, ea_ced_discapacidad, ea_id_prefijo, ea_id_sufijo, ea_duplicado, ea_nivel_egresos, ea_ifi, ea_asfi, ea_path_foto, ea_nit, ea_nit_venc, ea_num_testimonio, ea_indefinido, ea_fecha_vigencia, ea_nombre_notaria, ea_nombre_notario, ea_safie, ea_sigaf, ea_tipo_creacion, ea_ventas, ea_ot_ingresos, ea_ct_ventas, ea_ct_operativo, ea_ant_nego, ea_cta_banco, ea_nro_ciclo_oi, ea_partner, ea_lista_negra, ea_tecnologico, ea_fiel, ea_estado_std, ea_experiencia, ea_fecha_report, ea_fecha_report_resp, ea_numero_ife, ea_num_serie_firma, ea_telef_recados, ea_persona_recados, ea_antecedente_buro, ea_nivel_riesgo_cg, ea_puntaje_riesgo_cg, ea_fecha_evaluacion, ea_sum_vencido, ea_num_vencido, ea_nivel_riesgo, ea_negative_file, ea_puntaje_riesgo, ea_oficina_origen, ea_ingreso_negocio, ea_colectivo, ea_nivel_colectivo, ea_asesor_ext, ea_consulto_renapo)
   values (@w_ente, 'A', NULL, NULL, NULL, NULL, 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JIPL760909MASMLR07', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, 'JIPL760909529', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 10000, 7000, 0, '12345678901', 0, 'N', 'N', NULL, 'No Aplica', 'CLI', 'N', '2021-11-03', NULL, NULL, NULL, NULL, NULL, 'N', 'C', '0', '2021-11-03', NULL, NULL, NULL, 'N', NULL, NULL, 0, 'I', 'O', NULL, 'N')
end 


select *  from cobis..cl_ente_aux where ea_ente = @w_ente



if not exists (select 1 from cobis..cl_telefono where te_ente = @w_ente)
begin
   insert into dbo.cl_telefono (te_ente, te_direccion, te_secuencial, te_valor, te_tipo_telefono, te_prefijo, te_fecha_registro, te_fecha_mod, te_tipo_operador, te_area, te_telf_cobro, te_funcionario, te_verificado, te_fecha_ver, te_fecha_modificacion)
   values (@w_ente, 1, 1, '3456789087', 'D', NULL, '2021-11-03', '2021-11-18 11:04:25.393', NULL, '22', 'N', 'carocampo', 'N', NULL, NULL)
   
   
   insert into dbo.cl_telefono (te_ente, te_direccion, te_secuencial, te_valor, te_tipo_telefono, te_prefijo, te_fecha_registro, te_fecha_mod, te_tipo_operador, te_area, te_telf_cobro, te_funcionario, te_verificado, te_fecha_ver, te_fecha_modificacion)
   values (@w_ente, 3, 1, '7876543234', 'C', NULL, '2021-11-03', '2021-11-18 11:08:45.667', NULL, '99', 'N', 'carocampo', 'N', NULL, NULL)
end 

select * from cobis..cl_telefono where te_ente = @w_ente


if not exists(select 1 from cobis..cl_direccion where di_ente = @w_ente)
begin
   insert into dbo.cl_direccion (di_ente, di_direccion, di_descripcion, di_parroquia, di_ciudad, di_tipo, di_telefono, di_sector, di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion, di_vigencia, di_verificado, di_funcionario, di_fecha_ver, di_principal, di_barrio, di_provincia, di_tienetel, di_rural_urb, di_observacion, di_obs_verificado, di_extfin, di_pais, di_departamento, di_tipo_prop, di_rural_urbano, di_codpostal, di_casa, di_calle, di_codbarrio, di_correspondencia, di_alquilada, di_cobro, di_otrasenas, di_canton, di_distrito, di_montoalquiler, di_edificio, di_so_igu_co, di_fact_serv_pu, di_nombre_agencia, di_fuente_verif, di_tiempo_reside, di_nro, di_nro_residentes, di_nro_interno, di_negocio, di_poblacion, di_referencia)
   values (@w_ente, 1, NULL, 28266, 271, 'RE', 1, NULL, NULL, 1053, '2021-11-03', '2021-11-03', 'S', 'N', 'carocampo', NULL, 'S', NULL, 9, NULL, NULL, NULL, NULL, NULL, 484, NULL, 'PRO', 'N', '09700', NULL, 'CALL 13', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 0, 0, 0, 0, NULL, 'CDMX', 'FARMACIA')

   
   insert into dbo.cl_direccion (di_ente, di_direccion, di_descripcion, di_parroquia, di_ciudad, di_tipo, di_telefono, di_sector, di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion, di_vigencia, di_verificado, di_funcionario, di_fecha_ver, di_principal, di_barrio, di_provincia, di_tienetel, di_rural_urb, di_observacion, di_obs_verificado, di_extfin, di_pais, di_departamento, di_tipo_prop, di_rural_urbano, di_codpostal, di_casa, di_calle, di_codbarrio, di_correspondencia, di_alquilada, di_cobro, di_otrasenas, di_canton, di_distrito, di_montoalquiler, di_edificio, di_so_igu_co, di_fact_serv_pu, di_nombre_agencia, di_fuente_verif, di_tiempo_reside, di_nro, di_nro_residentes, di_nro_interno, di_negocio, di_poblacion, di_referencia)
   values (@w_ente, 2, 'santander@gmail.com', 0, 0, 'CE', 0, NULL, NULL, 1053, '2021-11-03', '2021-11-03', 'S', 'N', 'carocampo', NULL, 'N', NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL)


   insert into dbo.cl_direccion (di_ente, di_direccion, di_descripcion, di_parroquia, di_ciudad, di_tipo, di_telefono, di_sector, di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion, di_vigencia, di_verificado, di_funcionario, di_fecha_ver, di_principal, di_barrio, di_provincia, di_tienetel, di_rural_urb, di_observacion, di_obs_verificado, di_extfin, di_pais, di_departamento, di_tipo_prop, di_rural_urbano, di_codpostal, di_casa, di_calle, di_codbarrio, di_correspondencia, di_alquilada, di_cobro, di_otrasenas, di_canton, di_distrito, di_montoalquiler, di_edificio, di_so_igu_co, di_fact_serv_pu, di_nombre_agencia, di_fuente_verif, di_tiempo_reside, di_nro, di_nro_residentes, di_nro_interno, di_negocio, di_poblacion, di_referencia)
   values (@w_ente, 3, NULL, 28266, 271, 'AE', 1, NULL, NULL, 1053, '2021-11-03', '2021-11-03', 'S', 'N', 'carocampo', NULL, 'N', NULL, 9, NULL, NULL, NULL, NULL, NULL, 484, NULL, 'PRO', 'N', '09700', NULL, 'CALL 13', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 0, 0, 0, 0, NULL, 'CDMX', 'FARMACIA') 
end 



select * from cobis..cl_direccion where di_ente = @w_ente


