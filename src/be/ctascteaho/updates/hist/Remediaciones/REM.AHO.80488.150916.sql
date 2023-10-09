use cobis
go

--ah_tran.sql
delete cl_ttransaccion    WHERE tn_trn_code    = 640
INSERT INTO cl_ttransaccion VALUES (640,'CONSULTA DATOS DEL BANCO PARA IMPRESION DE CONTRATOS','CDBCO','CONSULTA DATOS DEL BANCO PARA IMPRESION DE CONTRATOS')

--ah_proc.sql
delete ad_procedure       WHERE pd_procedure   = 483
INSERT INTO ad_procedure VALUES (483,'sp_ah_datos_bco','cob_ahorros', 'V', getdate(), 'ahdatbco.sp')

--ah_protran.sql
delete ad_pro_transaccion WHERE pt_transaccion = 640 AND pt_procedure = 483
INSERT INTO ad_pro_transaccion VALUES (4,'R',0,640, 'V', getdate(), 483, null)

--ah_traut.sql
delete ad_tr_autorizada   WHERE ta_transaccion = 640 
INSERT INTO ad_tr_autorizada VALUES (4,'R',0,640, 3, getdate(), 1, 'V', getdate())
go

--pe_catlgo.sql
declare @w_codigo smallint

select @w_codigo = codigo from cobis..cl_tabla where tabla = 're_plantillas'
delete cobis..cl_catalogo where tabla = @w_codigo

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHO.RPT','CONTRATO AHORROS PERSONA'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHJ.RPT','CONTRATO AHORROS JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASA.RPT','CERTIFICADO APORTACION PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASJ.RPT','CERTIFICADO APORTACION JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROP.RPT','CONTRATO AHORROS CONTRACTUAL PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROJ.RPT','CONTRATO AHORROS CONTRACTUAL JURIDICO','V')
go


DELETE FROM cobis..cl_direccion WHERE di_ente IN (SELECT en_ente FROM cobis..cl_ente WHERE en_nombre = 'BANCO COBIS')
DELETE FROM cobis..cl_telefono  WHERE te_ente IN (SELECT en_ente FROM cobis..cl_ente WHERE en_nombre = 'BANCO COBIS')
DELETE FROM cobis..cl_ente      WHERE en_nombre = 'BANCO COBIS'
DELETE FROM cobis..cl_parametro WHERE pa_nemonico = 'ENCO' AND pa_producto = 'CLI'
DELETE FROM cobis..cl_parametro WHERE pa_nemonico = 'EMCO' AND pa_producto = 'CLI'
DELETE FROM cobis..cl_parametro WHERE pa_nemonico = 'PWCO' AND pa_producto = 'CLI'
GO

--ENTE
declare @w_ente int
SELECT @w_ente = MAX(en_ente) + 1 FROM cl_ente

INSERT INTO cobis..cl_ente (en_ente,                 en_nombre,               en_subtipo,        en_filial,              en_oficina,             en_ced_ruc,             en_fecha_crea,      en_fecha_mod,         en_direccion,         en_referencia,      
                            en_casilla,              en_casilla_def,          en_tipo_dp,        en_balance,             en_grupo,               en_pais,                en_oficial,         en_actividad,         en_retencion,         en_mala_referencia, 
                            en_comentario,           en_cont_malas,           s_tipo_soc_hecho,  en_tipo_ced,            en_sector,              en_referido,            en_nit,             en_doc_validado,      en_rep_superban,      p_p_apellido,       
                            p_s_apellido,            p_sexo,                  p_fecha_nac,       p_ciudad_nac,           p_lugar_doc,            p_profesion,            p_pasaporte,        p_estado_civil,       p_num_cargas,         p_num_hijos,        
                            p_nivel_ing,             p_nivel_egr,             p_nivel_estudio,   p_tipo_persona,         p_tipo_vivienda,        p_calif_cliente,        p_personal,         p_propiedad,          p_trabajo,            p_soc_hecho,        
                            p_fecha_emision,         p_fecha_expira,          c_cap_suscrito,    en_asosciada,           c_posicion,             c_tipo_compania,        c_rep_legal,        c_activo,             c_pasivo,             c_es_grupo,     
                            c_capital_social,        c_reserva_legal,         c_fecha_const,     en_nomlar,              c_plazo,                c_direccion_domicilio,  c_fecha_inscrp,     c_fecha_aum_capital,  c_cap_pagado,         c_tipo_nit,       
                            c_tipo_soc,              c_total_activos,         c_num_empleados,   c_sigla,                c_escritura,            c_notaria,              c_ciudad,           c_fecha_exp,          c_fecha_vcto,         c_camara,  
                            c_registro,              c_grado_soc,             c_fecha_registro,  c_fecha_modif,          c_fecha_verif,          c_vigencia,             c_verificado,       c_funcionario,        en_situacion_cliente, en_patrimonio_tec,  
                            en_fecha_patri_bruto,    en_gran_contribuyente,   en_calificacion,   en_reestructurado,      en_concurso_acreedores, en_concordato,          en_vinculacion,     en_tipo_vinculacion,  en_oficial_sup,       en_cliente,     
                            en_preferen,             c_edad_laboral_promedio, c_empleados_ley_50,en_exc_sipla,           en_exc_por2,            en_digito,              p_depa_nac,         p_pais_emi,           p_depa_emi,           en_categoria,   
                            en_emala_referencia,     en_banca,                c_total_pasivos,   en_pensionado,          en_rep_sib,             en_max_riesgo,          en_riesgo,          en_mries_ant,         en_fmod_ries,         en_user_ries,       
                            en_reservado,            en_pas_finan,            en_fpas_finan,     en_fbalance,            en_relacint,            en_otringr,             en_exento_cobro,    en_doctos_carpeta,    en_oficina_prod,      en_accion,          
                            en_procedencia,          en_fecha_negocio,        en_estrato,        en_recurso_pub,         en_influencia,          en_persona_pub,         en_victima,         en_bancarizado,       en_alto_riesgo,       en_fecha_riesgo)
                    VALUES (@w_ente,                'BANCO COBIS',     'C',       1,             1,          '9999999999999', getdate(), getdate(), 1,          2,
                            NULL,                   '001',             'S',       32,            1,          1,               87,        '454201',  'S',        'N',
                            'BANCO COBIS',           NULL,              NULL,      'CC',          '470000',   149,             '006',     'S',       NULL,       '9999999999999', 
                            'MANRIQUE',             'M',               getdate(), 17001,         66001,      '000',           NULL,      'CS',      3,          1, 
                            8142857,                6291428,           '005',     '001',         '002',      NULL,            10,        0,         0,          NULL, 
                            getdate(),              NULL,              NULL,      '0003',        NULL,       'PA',            NULL,      NULL,      NULL,       NULL, 
                            NULL,                   NULL,              NULL,      'BANCO COBIS', NULL,       NULL,            NULL,      NULL,      NULL,       NULL, 
                            ' ',                    37550000,          0,         ' ',           NULL,       NULL,            NULL,      NULL,      NULL,       NULL, 
                            NULL,                   NULL,              NULL,      NULL,          NULL,       'S',             'N',       NULL,      'NOR',      37550000, 
                            getdate(),              'N',               NULL,      'N',           NULL,       '004',           'S',       '001',     NULL,       'S', 
                            'N',                    NULL,              NULL,      'N',           'N',        'N',             17,        1,         66,         '001', 
                            NULL,                   '1',               0,         'N',           'N',        50000000,        NULL,      15000000,  getdate(),  'admuser', 
                            NULL,                   0,                 getdate(), getdate(),     'N',        ' ',             'N',       'N',       7020,       'NIN', 
                            'RENO',                 getdate(),         '02',      'N',           'N',        'N',             'N',       'N',       NULL,       NULL)

update cl_seqnos
set siguiente=@w_ente
where tabla='cl_ente'


---DIRECCIONES-------------------------------------------------------------------------------------------------------------------
INSERT INTO cobis..cl_direccion (di_ente, di_direccion, di_descripcion, di_parroquia, di_ciudad, di_tipo, di_telefono, di_sector, di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion, di_vigencia, di_verificado, di_funcionario, di_fecha_ver, di_principal, di_barrio, di_provincia, di_tienetel, di_rural_urb, di_observacion, di_obs_verificado, di_extfin)
VALUES (@w_ente, 1, 'Site Center, Calle del Establo N. 50 y Calle C, Torre 1. Santa Luc¡a Alta, Cumbaya Quito', 2699, 5154, '011', 1, NULL, '7020', 7020, getdate(), getdate(), 'S', 'N', 'admuser', NULL, 'S', ' ', 5, 'S', 'U', 'PRUEBAS', NULL, NULL)

---TELEFONOS---------------------------------------------------------------------------------------------------------------------------
INSERT INTO cobis..cl_telefono (te_ente, te_direccion, te_secuencial, te_valor, te_tipo_telefono, te_prefijo, te_fecha_registro, te_fecha_mod, te_tipo_operador)
VALUES (@w_ente, 1, 1, '01 (443) 3226300', 'D', NULL, getdate(), getdate(), NULL)

INSERT INTO cobis..cl_telefono (te_ente, te_direccion, te_secuencial, te_valor, te_tipo_telefono, te_prefijo, te_fecha_registro, te_fecha_mod, te_tipo_operador)
VALUES (@w_ente, 1, 2, '01 800 3000268', 'D', NULL, getdate(), getdate(), NULL)


--ah_param.sql
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENTE BANCO COBIS', 'ENCO', 'I', NULL, NULL, NULL, @w_ente, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EMAIL BANCO COBIS', 'EMCO', 'C', 'aclaracionescmv@cobiscorp.com', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PAGINA WEB BANCO COBIS', 'PWCO', 'C', 'www.cobis.com.ec', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
GO
