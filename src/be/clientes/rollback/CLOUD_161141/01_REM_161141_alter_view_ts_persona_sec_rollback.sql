use cobis
go

--Vista Persona Sec
ALTER VIEW ts_persona_sec
(secuencia,            tipo_transaccion,       clase,                  fecha,               hora,             usuario,
terminal,              srv,                    lsrv,                   persona,             nombre,
p_apellido,            s_apellido,             /*sexo,                 cedula,              tipo_ced,
pais,                  profesion,              estado_civil,           actividad,           num_cargas,
nivel_ing,             nivel_egr,              tipo,                   filial,              oficina,
fecha_nac,             grupo,                  oficial,                comentario,          retencion,
fecha_mod,             fecha_expira,           sector,                 ciudad_nac,          nivel_estudio,
tipo_vivienda,         calif_cliente,          tipo_vinculacion,       s_nombre,            c_apellido,
promotor,              nacionalidad,*/         ingre,                  id_tutor,            nombre_tutor,
bloquear,              bienes,                 verificado,             fecha_verif,         estado_ea,
menor_edad,            conocido_como,          cliente_planilla,       cod_risk,            sector_eco,
actividad_ea,          lin_neg,                seg_neg,                remp_legal,          apoderado_legal,
fuente_ing,            act_prin,               detalle,                cat_aml,             discapacidad,
tipo_discapacidad,     ced_discapacidad,       nivel_egresos,          ifi,                 asfi,
path_foto,             nit,                    nit_vencimiento ,       secuen_alterno2,	    oficina)
as 
select    
ts_secuencial,          ts_tipo_transaccion,   ts_clase,               ts_fecha,            ts_hora,           ts_usuario,
ts_terminal,            ts_srv,                ts_lsrv,                ts_ente,             ts_nombre,
ts_p_apellido,          ts_s_apellido,         /*ts_sexo,              ts_cedruc,           ts_tipo_ced,
ts_pais,                ts_profesion,          ts_estado_civil,        ts_actividad,        ts_num_cargas,
ts_ingresos,            ts_egresos,            ts_tipo,                ts_filial,           ts_oficina,
ts_fecha_nac,           ts_grupo,              ts_funcionario,         ts_observacion,      ts_posicion,
ts_fecha_modificacion,  ts_fecha_expira,       ts_sector,              ts_ciudad_nac,       ts_nivel_estudio,
ts_tipo_vivienda,       ts_calif_cliente,      ts_tipo_vinculacion,    ts_nacionalidad,     ts_descripcion,
ts_promotor,            ts_naciona,*/          ts_ingre,               ts_num_poliza,       ts_desc_seguro,
ts_nacional,            ts_bienes,             ts_garantia,            ts_estado,           ts_codigocat,
ts_toperacion,          ts_observaciones,      ts_estatus,             ts_sigla,            ts_abreviatura,
ts_reg_nat,             ts_reg_ope,            ts_grado_soc,           ts_codigo_mr,        ts_documento,
ts_tipo_soc,            ts_zona,               ts_nombre_completo,     ts_proposito,        ts_discapacidad,
ts_tipo_discapacidad,   ts_ced_discapacidad,   ts_nivel_egresos,       ts_ifi,              ts_asfi,
ts_path_foto,           ts_nit,                ts_nit_venc ,           ts_cod_alterno,	    ts_oficina
from    cobis..cl_tran_servicio
where    ts_tipo_transaccion     =    103
    or    ts_tipo_transaccion    =    104
    or    ts_tipo_transaccion    =    192
    or    ts_tipo_transaccion    =    1288

go