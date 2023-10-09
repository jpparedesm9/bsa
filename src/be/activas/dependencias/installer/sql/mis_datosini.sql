use cobis
go

declare @w_ente int

delete cl_ente
where en_ced_ruc = '9002150711'

exec cobis..sp_cseqnos
@i_tabla     = 'cl_ente',
@o_siguiente = @w_ente out

insert into cl_ente 
(en_ente,              en_nombre,             en_subtipo,          en_filial,         en_oficina,             en_ced_ruc,
 en_fecha_crea,        en_fecha_mod,          en_direccion,        en_referencia,     en_casilla,             en_casilla_def,
 en_tipo_dp,           en_balance,            en_grupo,            en_pais,           en_oficial,             en_actividad,
 en_retencion,         en_mala_referencia,    en_comentario,       en_cont_malas,     s_tipo_soc_hecho,       en_tipo_ced,
 en_sector,            en_referido,           en_nit,              en_doc_validado,   en_rep_superban,        p_p_apellido,
 p_s_apellido,         p_sexo,                p_fecha_nac,         p_ciudad_nac,      p_lugar_doc,            p_profesion,
 p_pasaporte,          p_estado_civil,        p_num_cargas,        p_num_hijos,       p_nivel_ing,            p_nivel_egr,
 p_nivel_estudio,      p_tipo_persona,        p_tipo_vivienda,     p_calif_cliente,   p_personal,             p_propiedad,
 p_trabajo,            p_soc_hecho,           p_fecha_emision,     p_fecha_expira,    c_cap_suscrito,         en_asosciada,
 c_posicion,           c_tipo_compania,       c_rep_legal,         c_activo,          c_pasivo,               c_es_grupo,
 c_capital_social,     c_reserva_legal,       c_fecha_const,       en_nomlar,         c_plazo,                c_direccion_domicilio,
 c_fecha_inscrp,       c_fecha_aum_capital,   c_cap_pagado,        c_tipo_nit,        c_tipo_soc,             c_total_activos,
 c_num_empleados,      c_sigla,               c_escritura,         c_notaria,         c_ciudad,               c_fecha_exp,
 c_fecha_vcto,         c_camara,              c_registro,          c_grado_soc,       c_fecha_registro,       c_fecha_modif,
 c_fecha_verif,        c_vigencia,            c_verificado,        c_funcionario,     en_situacion_cliente,   en_patrimonio_tec,
 en_fecha_patri_bruto, en_gran_contribuyente, en_calificacion,     en_reestructurado, en_concurso_acreedores, en_concordato,
 en_vinculacion,       en_tipo_vinculacion,   en_oficial_sup,      en_cliente,        en_preferen,            c_edad_laboral_promedio,
 c_empleados_ley_50,   en_exc_sipla,          en_exc_por2,         en_digito,         p_depa_nac,             p_pais_emi,
 p_depa_emi,           en_categoria,          en_emala_referencia, en_banca,          c_total_pasivos,        en_pensionado,
 en_rep_sib,           en_max_riesgo,         en_riesgo,           en_mries_ant,      en_fmod_ries,           en_user_ries,
 en_reservado,         en_pas_finan,          en_fpas_finan,       en_fbalance,       en_relacint,            en_otringr,
 en_exento_cobro,      en_doctos_carpeta,     en_oficina_prod,     en_accion,         en_procedencia,         en_fecha_negocio,
 en_estrato,           en_recurso_pub,        en_influencia,       en_persona_pub,    en_victima,             en_bancarizado,
 en_alto_riesgo,       en_fecha_riesgo,       p_c_apellido,        p_s_nombre,        en_estado,              en_calif_cartera,
 en_nacionalidad)
values
(@w_ente,              'BANCAMIA SA',         'C',                 1,                 1,                      '9002150711',
 '10/10/2008',         '08/19/2016',          1,                   NULL,              NULL,                   '001',
 'S',                  NULL,                  NULL,                1,                 1,                      '702003',
 'S',                  'N',                   '-',                 NULL,              'N'                   , 'N',
 '700000',             NULL,                  NULL,                NULL,              NULL,                    NULL,
 NULL,                 NULL,                  '05/29/1962',        11001,             11001,                   NULL,
 NULL,                 NULL,                  0,                   0,                 0.0000,                  0.0000,
 '012',                '001',                 '001',               NULL,              NULL,                    NULL,
 NULL,                 NULL,                  NULL,                NULL,              NULL,                    '0021',
 NULL,                 'PA',                  NULL,                NULL,              NULL,                    'N',
 NULL,                 NULL,                  '09/08/2008',        'BANCAMIA SA',     NULL,                    NULL,
 '09/10/2008',         '10/10/2007',          10000000.0000,       NULL,             '001',                    0.0000,
 0,                    NULL,                  3678,                2,                 11001,                   '10/07/2008',
 '01/25/1998',         '1',                   418469,              '003',            '10/03/2008',             NULL,
 '10/03/2008',         'S',                   'N',                 NULL,             'NOR',                    0.0000,
 NULL,                 NULL,                  NULL,                NULL,              NULL,                    '003',
 'S',                 '006',                  NULL,                'S',              'N',                      NULL,
 NULL,                'N',                    'N',                 NULL,              NULL,                    1,
 11,                   NULL,                  NULL,                '1',               0.0000,                  NULL,
 'N',                  0.0000,                NULL,                NULL,              NULL,                    NULL,
 NULL,                 NULL,                  NULL,                NULL,              'N',                     'N',
 'N',                 'N',                    1,                   'NIN',             'OTR',                   '10/20/2008',
 '03',                'N',                    'N',                 'N',               'N',                     NULL,
 NULL,                 NULL,                  NULL,                NULL,              NULL,                    NULL,
 NULL)
go

