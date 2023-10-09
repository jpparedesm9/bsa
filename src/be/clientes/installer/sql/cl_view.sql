/*  Creacion de vistas del clientes   */

use cobis
go

print '=====> cl_tarjeta'
go
IF OBJECT_ID ('dbo.cl_tarjeta') IS NOT NULL
	DROP VIEW dbo.cl_tarjeta
GO

CREATE VIEW cl_tarjeta (
    ente,                  referencia,        tipo,
    tipo_cifras,           numero_cifras,     fecha_registro,
    calificacion,          verificacion,      fecha_ver,
    fecha_modificacion,    vigencia,          observacion,
    banco,                 cuenta,            funcionario,
    fecha_apertura,        monto,             clase_tarjeta,
    nacional,              estado,            telefono,
    sucursal,              ciudad,            fec_exp_ref,
    resul_verif
) AS SELECT                
    re_ente,               re_referencia,     re_tipo,
    re_tipo_cifras,        re_numero_cifras,  re_fecha_registro,
    re_calificacion,       re_verificacion,   re_fecha_ver,
    re_fecha_modificacion, re_vigencia,       re_observacion,
    ta_banco,              ta_cuenta,         re_funcionario,
    ec_fec_apertura,       monto,             ec_tipo_cta,
    re_nacional,           re_estado,         re_telefono,
    re_sucursal,           re_ciudad,         ec_fec_exp_ref,
    re_obs_verificado
FROM  cl_referencia
WHERE re_tipo = 'T'

go

print '=====> cl_persona'
GO
IF OBJECT_ID ('dbo.cl_persona') IS NOT NULL
	DROP VIEW dbo.cl_persona
GO

create view cl_persona (
            persona,
            nombre,
            p_apellido,
            s_apellido,
            oficial,
            sexo,
            fecha_nac,
            cedula,
            pasaporte,      
            pais,
            profesion, 
            actividad,
            estado_civil, 
            subtipo,
            filial,
            oficina,
            fecha_crea,
            fecha_mod,
            tipo,
            personal,
            direccion,
            propiedad,
            ref_economica,
            trabajo,
            casilla,
            casilla_def,
            tipo_dp,
            balance,
            grupo,
            retencion,                    
            mala_referencia,              
            comentario,
            cont_malas,
            soc_hecho,
            fecha_emision,
            fecha_expira,
            referido,
            sector,
            nivel_estudio,
            tipo_vivienda,
            calif_cliente,
            tipo_doc,
            recurso_pub,
            influencia, 
            persona_pub,
            victima
) as select 
        en_ente,
        en_nombre,
        p_p_apellido,
        p_s_apellido,
        en_oficial,
        p_sexo,
        p_fecha_nac,
        en_ced_ruc,
        p_pasaporte,      
        en_pais,
        p_profesion, 
        en_actividad,
        p_estado_civil,
        en_subtipo,
        en_filial,
        en_oficina,
        en_fecha_crea,
        en_fecha_mod,
        p_tipo_persona,
        p_personal,
        en_direccion,
        p_propiedad,
        en_referencia,
        p_trabajo,
        en_casilla,
        en_casilla_def,
        en_tipo_dp,
        en_balance,
        en_grupo,
        en_retencion,                    
        en_mala_referencia,              
        en_comentario,
        en_cont_malas,
        p_soc_hecho,
        p_fecha_emision,
        p_fecha_expira,
        en_referido,
        en_sector,
        p_nivel_estudio,
        p_tipo_vivienda,
        p_calif_cliente,
        en_tipo_ced,
        en_recurso_pub,
        en_influencia,
        en_persona_pub,
        en_victima
FROM    cl_ente
WHERE   en_subtipo ='P'

go


print '=====> cl_financiera'
go

IF OBJECT_ID ('dbo.cl_financiera') IS NOT NULL
	DROP VIEW dbo.cl_financiera
GO
CREATE VIEW cl_financiera (
  cliente,        referencia,        treferencia,          institucion,
  toperacion,     tclase,            tipo_cifras,          numero_cifras,
  fec_inicio,     fec_vencimiento,   calificacion,         vigencia,
  verificacion,   fecha_ver,         fecha_modificacion,   observacion,
  estatus,        fecha_registro,    funcionario,          monto,
  garantia,       cupo_usado,        monto_vencido,        fec_exp_ref,
  resul_verif
) AS SELECT
  re_ente,          re_referencia,       re_tipo,                fi_banco,
  fi_toperacion,    fi_clase,            re_tipo_cifras,         re_numero_cifras,
  ec_fec_apertura,  fi_fec_vencimiento,  re_calificacion,        re_vigencia,
  re_verificacion,  re_fecha_ver,        re_fecha_modificacion,  re_observacion,
  fi_estatus,       re_fecha_registro,   re_funcionario,         monto,
  fi_garantia,      fi_cupo_usado,       fi_monto_vencido,       ec_fec_exp_ref,
  re_obs_verificado
FROM       cl_referencia 
WHERE      re_tipo = 'F'

go

print '=====> cl_economica'
go

IF OBJECT_ID ('dbo.cl_economica') IS NOT NULL
	DROP VIEW dbo.cl_economica
GO
create view cl_economica (
   ente,                   referencia,             tipo,
   tipo_cifras,            numero_cifras,          fecha_registro,
   calificacion,           verificacion,           fecha_ver,
   fecha_modificacion,     vigencia,               observacion,
   banco,                  cuenta,                 funcionario,
   tipo_cta,               nacional,               moneda,
   fec_apertura,           monto,                  fec_exp_ref,
   ciudad,                 sucursal,               telefono,
   estado,                 nit,                    dpto,
   resul_verif
)as
select
   re_ente,                re_referencia,          re_tipo,
   re_tipo_cifras,         re_numero_cifras,       re_fecha_registro,
   re_calificacion,        re_verificacion,        re_fecha_ver,
   re_fecha_modificacion,  re_vigencia,            re_observacion,
   ec_banco,               ec_cuenta,              re_funcionario,
   ec_tipo_cta,            re_nacional,            ec_moneda,
   ec_fec_apertura,        monto,                  ec_fec_exp_ref,
   re_ciudad,              re_sucursal,            re_telefono,
   re_estado,              fi_clase,               ta_cuenta,
   re_obs_verificado
from cl_referencia
where re_tipo = 'B'

go

print '=====> cl_compania'
go
IF OBJECT_ID ('dbo.cl_compania') IS NOT NULL
	DROP VIEW dbo.cl_compania
GO

CREATE VIEW cl_compania (
             compania,
             tipo,
             actividad,
             posicion,
             nombre,
             ruc,
             oficial,
             pais,
             grupo,
             rep_legal,
             activo,
             pasivo,
             subtipo,
             filial,
             oficina,
             fecha_crea,
             fecha_mod,
             direccion,
             referencia,
             casilla,
             casilla_def,
             tipo_dp,
             balance,
             es_grupo,
             retencion,                    
             mala_referencia,              
             comentario,
             capital_social,
             reserva_legal,         
             fecha_const,           
             nombre_completo,       
             plazo,
             direccion_domicilio,   
             fecha_inscrp,          
             fecha_aumento_capital,
             cap_suscrito,
            referido,
            sector,
            tip_soc,
            fecha_emision,
            lugar_doc,
            asosciada,
            total_activos,
            num_empleados,
            sigla,
            rep_superban,
            doc_validado,
            escritura,
            notaria,
            ciudad,
            fecha_exp,
            fecha_vcto,
            camara, 
            registro,
            grado_soc,
            tipo_doc
) AS SELECT
            en_ente,
            c_tipo_compania,
            en_actividad,
            c_posicion,
            en_nombre,
            en_ced_ruc,
            en_oficial,
            en_pais,
            en_grupo,
            c_rep_legal,
            c_activo,
            c_pasivo,
            en_subtipo,
            en_filial,
            en_oficina,
            en_fecha_crea,
            en_fecha_mod,
            en_direccion,
            en_referencia,
            en_casilla,
            en_casilla_def,
            en_tipo_dp,
            en_balance,
            c_es_grupo,
            en_retencion,                    
            en_mala_referencia,              
            en_comentario,
            c_capital_social,
            c_reserva_legal,         
            c_fecha_const,           
            en_nomlar,       
            c_plazo,
            c_direccion_domicilio,   
            c_fecha_inscrp,          
            c_fecha_aum_capital,
            c_cap_suscrito,
            en_referido,
            en_sector,
            c_tipo_soc,
            p_fecha_emision,
            p_lugar_doc,
            en_asosciada,
            c_total_activos,
            c_num_empleados,
            c_sigla,
            en_rep_superban,
            en_doc_validado,
            c_escritura,
            c_notaria,
            c_ciudad,
            c_fecha_exp,
            c_fecha_vcto,
            c_camara,   
            c_registro,
            c_grado_soc,
            en_tipo_ced
FROM  cl_ente
WHERE en_subtipo = 'C'

go

print '=====> cl_comercial'
go
IF OBJECT_ID ('dbo.cl_comercial') IS NOT NULL
	DROP VIEW dbo.cl_comercial
GO

CREATE VIEW cl_comercial (
   ente,                referencia,             tipo,              tipo_cifras,
   numero_cifras,       fecha_registro,         calificacion,      verificacion,
   fecha_ver,           fecha_modificacion,     vigencia,          observacion,
   institucion,         fecha_ingr_en_inst,     funcionario,       monto,
   nacional,            estado,                 telefono,          sucursal,
   ciudad,              fec_exp_ref,            nit,               dpto,
   ciudadeco,           resul_verif
) AS SELECT
   re_ente,             re_referencia,          re_tipo,           re_tipo_cifras,
   re_numero_cifras,    re_fecha_registro,      re_calificacion,   re_verificacion,
   re_fecha_ver,        re_fecha_modificacion,  re_vigencia,       re_observacion,
   co_institucion,      ec_fec_apertura,        re_funcionario,    monto,
   re_nacional,         re_estado,              re_telefono,       re_sucursal,
   re_ciudad,           ec_fec_exp_ref,         fi_clase,          ta_cuenta,
   ec_tipo_cta,         re_obs_verificado
FROM       cl_referencia
WHERE      re_tipo = 'C'

go

----------------- Script Loand Group ----------------------

------------------------------------------------------------------
print ('CREACION VISTA - ts_grupo')
------------------------------------------------------------------
use cobis
go

if exists (select * from sysobjects where name = 'ts_grupo')
drop view ts_grupo
go

CREATE VIEW ts_grupo (
                      secuencial,    tipo_transaccion,    clase,              fecha,    --1
                      terminal,      srv,                 lsrv,                         --2
                      grupo,         nombre,              representante,      compania, --3
                      oficial,       fecha_registro,      fecha_modificacion, ruc,      --4					  
                      vinculacion,   tipo_vinculacion,    max_riesgo,         riesgo,   --5					  
                      usuario,       reservado,           tipo_grupo,         estado,   --6					  
                      dir_reunion,   dia_reunion,         hora_reunion,       comportamiento_pago,--7					  
                      num_ciclo,     gar_liquida                                                         --8
) as
select                ts_secuencial, ts_tipo_transaccion, ts_clase,           ts_fecha,    --1
                      ts_terminal,   ts_srv,              ts_lsrv,                         --2
                      ts_grupo,      ts_nombre,           ts_rep_legal,       ts_ente,     --3
                      ts_jefe_agenc, ts_fecha_emision,    ts_fecha_expira,    ts_cedruc,   --4					  
                      ts_garantia,   ts_tipo,             ts_promedio_ventas, ts_pasivo,   --5					  
                      ts_usuario,    ts_ingresos,         ts_proposito,       ts_grado_soc,--6					  
                      ts_direc,      ts_camara,           ts_fpas_finan,      ts_telefono, --7
                      ts_escritura,   ts_gar_liquida                                        --8
from    cl_tran_servicio
where   ts_tipo_transaccion = 800					  
go

------------------------------------------------------------------
print ('CREACION VISTA - ts_cliente_grupo' )
------------------------------------------------------------------
use cobis
go

if exists (select * from sysobjects where name = 'ts_cliente_grupo')
drop view ts_cliente_grupo
go

CREATE VIEW ts_cliente_grupo (secuencial, tipo_transaccion, clase,  --1
                              srv,        lsrv,             ente,   --2      
                              grupo,      usuario,          terminal,--3
                              oficial,    fecha_reg,        rol,     --4
                              estado,     calif_interna,    fecha_desasociacion--5								 
)as
select                        ts_secuencial, ts_tipo_transaccion, ts_clase,      --1 
                              ts_srv,        ts_lsrv,             ts_ente,       --2
                              ts_grupo,      ts_usuario,          ts_terminal,   --3
                              ts_jefe_agenc, ts_fecha_emision,    ts_profesion,  --4
                              ts_estado,     ts_tipo_huella,      ts_fecha_expira--5
from    cl_tran_servicio
where   ts_tipo_transaccion = 810					  
go


------------------------------------------------------------------
print ('CREACION VISTA - ts_ref_personal' )
------------------------------------------------------------------

if exists (select * from sysobjects where name = 'ts_ref_personal')
   drop view ts_ref_personal
go
/*--- Creacion de transaccion de servicio los campos para tipo de documento ---*/

CREATE VIEW ts_ref_personal (
    secuencial,     tipo_transaccion,   clase,          fecha,
    usuario,        terminal,           srv,            lsrv,
    persona,        referencia,         nombre,         p_apellido, 
    s_apellido,     direccion,          telefono_d,     telefono_e, 
    telefono_o,     parentesco,         vigencia,       descripcion,
    verificacion,   departamento,       ciudad,         barrio,
    calle,          numero,             colonia,        localidad,
    municipio,      estado,             codpostal,      pais,
    tiempo,			correo
)
as
select 
    ts_secuencial,  ts_tipo_transaccion,ts_clase,       ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,         ts_lsrv,
    ts_ente,        ts_tabla,           ts_nombre,      ts_p_apellido, 
    ts_s_apellido,  ts_direc,           ts_telefono_1,  ts_telefono_2,
    ts_telefono_3,  ts_tipo,            ts_posicion,    ts_descrip_ref_per, 
    ts_dinero,      ts_sector,          ts_tipo_soc,    ts_zona,
    ts_calle,       ts_nro,             ts_colonia,     ts_localidad,
    ts_municipio,   ts_estado,          ts_codpostal,   ts_pais1,
    ts_tiempo_conocido, ts_rep
from   cl_tran_servicio
where  ts_tipo_transaccion = 177
or     ts_tipo_transaccion = 178
or     ts_tipo_transaccion = 1130
GO







IF OBJECT_ID ('dbo.ts_actividad_economica') IS NOT NULL
	DROP VIEW dbo.ts_actividad_economica
GO

create view ts_actividad_economica    (
        secuencia,        tipo_transaccion,        clase,                   fecha,              usuario,
        terminal_s,       srv,                     lsrv,                    hora,               ente,
        actividad,        sector,                  subactividad,            subsector,          fuente_ing,
        principal,        dias_atencion,           horario_atencion,        fecha_inicio_act,   antiguedad,
        ambiente,         autorizado,              afiliado,                lugar_afiliacion,   num_empleados,    
        desc_actividad,   ubicacion,               horario_actividad,       estado_ae,          desc_caedec,
        verificado,       fecha_verificacion,      fuente_verificacion,		oficina )
as 
select  ts_secuencial,     ts_tipo_transaccion,     ts_clase,                ts_fecha,           ts_usuario,    
        ts_terminal,       ts_srv,                  ts_lsrv,                 ts_hora,   		 ts_ente,
        ts_escritura,      ts_sector,               ts_actividad,            ts_tipo_soc,        ts_origen_ingresos,
        ts_regional,       ts_tipo,                 ts_licencia,             ts_fec_aut_asf,     ts_provincia,
        ts_cod_fie_asf,    ts_nemon,                ts_nemdef,               ts_obs_horario,     ts_procedure,
        ts_desc_seguro,    ts_descrip_ref_per,      ts_login,                ts_estado,          ts_razon_social,
        ts_verificado,     ts_fecha_verificacion,   ts_fuente_verificacion,		ts_oficina
from    cl_tran_servicio
where    ts_tipo_transaccion    =    2436
or       ts_tipo_transaccion    =    2437
or       ts_tipo_transaccion    =    2438
or       ts_tipo_transaccion    =    2439
go



---------------------------------------
--ts_telefono
---------------------------------------

IF OBJECT_ID ('dbo.ts_telefono') IS NOT NULL
	DROP VIEW dbo.ts_telefono
GO

create view ts_telefono(
    secuencial,      alterno,         tipo_transaccion,       clase,          fecha,	   hora,
    usuario,         terminal,        srv,                    lsrv,           ente,       direccion,
    telefono,        valor,           tipo,                   cobro,          codarea,    oficina
)    as select    
   ts_secuencial,    ts_cod_alterno,  ts_tipo_transaccion,    ts_clase,       ts_fecha,	ts_hora,
   ts_usuario,       ts_terminal,     ts_srv,                 ts_lsrv,        ts_ente,    ts_direccion,
   ts_codigo,        ts_valor,        ts_tipo,                ts_doc_validado,ts_promotor,ts_oficina
from    cl_tran_servicio
where    ts_tipo_transaccion    =    111
or        ts_tipo_transaccion    =    112
or        ts_tipo_transaccion    =    148
GO



if exists (select * from sysobjects where name = 'cl_asfi_vcc')
   drop view cl_asfi_vcc
go
CREATE VIEW dbo.cl_asfi_vcc as
select  en_ente,
        1 af_cod_obligado, 
        1 af_cod_entidad,
        1 af_num_correlativo, 
        1 af_cod_depart_sucur,  
        'Directa' as 'tipo_deuda',
        1 as 'saldo_deuda_vigente', 
        1 as 'saldo_deuda_vencida', 
        1 as 'saldo_deuda_ejecucion',
        1 as 'saldo_deuda_castigada', 
        1 as 'saldo_total',
        1 as 'saldo_deuda_contingente', 
        1 as 'calificacion'
from    cl_ente b
GO


IF OBJECT_ID ('dbo.ts_persona_prin') IS NOT NULL
	DROP VIEW dbo.ts_persona_prin
GO

CREATE VIEW ts_persona_prin(secuencia,            tipo_transaccion,        clase,                    fecha,      hora,             usuario,
terminal,                srv,                    lsrv,                    persona,                nombre,
p_apellido,                s_apellido,                sexo,                    cedula,                    tipo_ced,
pais,                    profesion,                estado_civil,            actividad,                num_cargas,
nivel_ing,                nivel_egr,                tipo,                    filial,                    oficina,
fecha_nac,                grupo,                    oficial,                comentario,                retencion,
fecha_mod,                fecha_expira,            sector,                    ciudad_nac,                nivel_estudio,
tipo_vivienda,            calif_cliente,            tipo_vinculacion,        s_nombre,                c_apellido, secuen_alterno,
nit,					  otro_profesion/*,
promotor,                nacionalidad,            ingre,                    id_tutor,                nombre_tutor,
bloquear,                bienes,                    verificado,                fecha_verif,            estado_ea,
menor_edad,                conocido_como,            cliente_planilla,        cod_risk,                sector_eco,
actividad_ea,            lin_neg,                seg_neg,                remp_legal,                apoderado_legal,
fuente_ing,                act_prin,                detalle,                cat_aml,                discapacidad,
tipo_discapacidad,        ced_discapacidad,        nivel_egresos,            ifi,                    asfi,
path_foto,                nit,                    nit_vencimiento*/)
as    --GAP    CLI-0175    116
select    ts_secuencial,            ts_tipo_transaccion,    ts_clase,                ts_fecha,              ts_hora,  ts_usuario,
ts_terminal,            ts_srv,                    ts_lsrv,                ts_ente,                ts_nombre,
ts_p_apellido,            ts_s_apellido,            ts_sexo,                ts_cedruc,                ts_tipo_ced,
ts_pais,                ts_profesion,            ts_estado_civil,        ts_actividad,            ts_num_cargas,
ts_ingresos,            ts_egresos,                ts_tipo,                ts_filial,                ts_oficina,
ts_fecha_nac,            ts_grupo,                ts_funcionario,            ts_observacion,            ts_posicion,
ts_fecha_modificacion,    ts_fecha_expira,        ts_sector,                ts_ciudad_nac,            ts_nivel_estudio,
ts_tipo_vivienda,        ts_calif_cliente,        ts_tipo_vinculacion,    ts_nacionalidad,        ts_descripcion,  ts_cod_alterno,
ts_nit,                  ts_otro_profesion/*,
ts_promotor,            ts_naciona,                ts_ingre,                ts_num_poliza,            ts_desc_seguro,
ts_nacional,            ts_bienes,                ts_garantia,            ts_estado,                ts_codigocat,
ts_toperacion,            ts_observaciones,        ts_estatus,                ts_sigla,                ts_abreviatura,
ts_reg_nat,                ts_reg_ope,                ts_grado_soc,            ts_codigo_mr,            ts_documento,
ts_tipo_soc,            ts_zona,                ts_nombre_completo,        ts_proposito,            ts_discapacidad,
ts_tipo_discapacidad,    ts_ced_discapacidad,    ts_nivel_egresos,        ts_ifi,                    ts_asfi,
ts_path_foto,            ts_nit,                    ts_nit_venc*/
from    cobis..cl_tran_servicio
where    ts_tipo_transaccion    =    103
or    ts_tipo_transaccion    =    104
or    ts_tipo_transaccion    =    192
or    ts_tipo_transaccion    =    1288

GO

if exists (select * from sysobjects where name = 'ts_persona_sec')
   drop view ts_persona_sec
go
CREATE VIEW ts_persona_sec(secuencia,            tipo_transaccion,        clase,                    fecha,       hora,             usuario,
                        terminal,                srv,                    lsrv,                    persona,                nombre,
                        p_apellido,                s_apellido,                /*sexo,                    cedula,                    tipo_ced,
                        pais,                    profesion,                estado_civil,            actividad,                num_cargas,
                        nivel_ing,                nivel_egr,                tipo,                    filial,                    oficina,
                        fecha_nac,                grupo,                    oficial,                comentario,                retencion,
                        fecha_mod,                fecha_expira,            sector,                    ciudad_nac,                nivel_estudio,
                        tipo_vivienda,            calif_cliente,            tipo_vinculacion,        s_nombre,                c_apellido,
                        promotor,                nacionalidad,*/            ingre,                    id_tutor,                nombre_tutor,
                        bloquear,                bienes,                    verificado,                fecha_verif,            estado_ea,
                        menor_edad,                conocido_como,            cliente_planilla,        cod_risk,                sector_eco,
                        actividad_ea,            lin_neg,                seg_neg,                remp_legal,                apoderado_legal,
                        fuente_ing,                act_prin,                detalle,                cat_aml,                discapacidad,
                        tipo_discapacidad,        ced_discapacidad,        nivel_egresos,            ifi,                    asfi,
                        path_foto,                nit,                    nit_vencimiento , secuen_alterno2,	            oficina,
                        colectivo,               nivel_colectivo)
                as    --GAP    CLI-0175    116
                select    ts_secuencial,            ts_tipo_transaccion,    ts_clase,                ts_fecha,     ts_hora,           ts_usuario,
                        ts_terminal,            ts_srv,                    ts_lsrv,                ts_ente,                ts_nombre,
                        ts_p_apellido,            ts_s_apellido,            /*ts_sexo,                ts_cedruc,                ts_tipo_ced,
                        ts_pais,                ts_profesion,            ts_estado_civil,        ts_actividad,            ts_num_cargas,
                        ts_ingresos,            ts_egresos,                ts_tipo,                ts_filial,                ts_oficina,
                        ts_fecha_nac,            ts_grupo,                ts_funcionario,            ts_observacion,            ts_posicion,
                        ts_fecha_modificacion,    ts_fecha_expira,        ts_sector,                ts_ciudad_nac,            ts_nivel_estudio,
                        ts_tipo_vivienda,        ts_calif_cliente,        ts_tipo_vinculacion,    ts_nacionalidad,        ts_descripcion,
                        ts_promotor,            ts_naciona,*/            ts_ingre,                ts_num_poliza,            ts_desc_seguro,
                        ts_nacional,            ts_bienes,                ts_garantia,            ts_estado,                ts_codigocat,
                        ts_toperacion,            ts_observaciones,        ts_estatus,                ts_sigla,                ts_abreviatura,
                        ts_reg_nat,                ts_reg_ope,                ts_grado_soc,            ts_codigo_mr,            ts_documento,
                        ts_tipo_soc,            ts_zona,                ts_nombre_completo,        ts_proposito,            ts_discapacidad,
                        ts_tipo_discapacidad,    ts_ced_discapacidad,    ts_nivel_egresos,        ts_ifi,                    ts_asfi,
                        ts_path_foto,            ts_nit,                    ts_nit_venc ,  ts_cod_alterno,	                 ts_oficina,
                        ts_categoria,            ts_depart_pais
                    from    cobis..cl_tran_servicio
                    where    ts_tipo_transaccion    =    103
                        or    ts_tipo_transaccion    =    104
                        or    ts_tipo_transaccion    =    192
                        or    ts_tipo_transaccion    =    1288
go


------------------------------------------------------------------
print ('CREACION VISTA - ts_direccion_geo' )
------------------------------------------------------------------

USE 
cobis

IF OBJECT_ID ('dbo.ts_direccion_geo') IS NOT NULL
	DROP VIEW dbo.ts_direccion_geo
GO

create view dbo.ts_direccion_geo (
   secuencia,          tipo_transaccion,       clase,              fecha,
   oficina_s,          usuario,                terminal_s,         srv,    
   lsrv,               hora,                   ente,               direccion,
   latitud_coord,      latitud_grados,         latitud_minutos,    latitud_segundos,
   longitud_coord,     longitud_grados,        longitud_minutos,   longitud_segundos,
   path_croquis)
as select    
   ts_secuencial,      ts_tipo_transaccion,    ts_clase,            ts_fecha,
   ts_oficina,         ts_usuario,             ts_terminal,         ts_srv,
   ts_lsrv,            ts_fecha_modifi,        ts_empresa,          ts_moneda,    
   ts_garantia,        ts_num_cargas,          ts_filial,           ts_segundos_lat,
   ts_rep_superban,    ts_notaria,             ts_cod_atr,          ts_segundos_long,
   ts_path_croquis
from    cl_tran_servicio
where   ts_tipo_transaccion    =    1608
or      ts_tipo_transaccion    =    1606
GO


------------------------------------------------------------------
print ('CREACION VISTA - ts_negocio_cliente' )
------------------------------------------------------------------

IF OBJECT_ID ('dbo.ts_negocio_cliente') IS NOT NULL
	DROP TABLE dbo.ts_negocio_cliente
GO

create table ts_negocio_cliente (
        ts_secuencial       int         not null,
        ts_codigo           int         not null,
        ts_ente             int         not null,
        ts_nombre           varchar(60) null,
        ts_giro             varchar(10) null,
        ts_fecha_apertura   datetime    null,
        ts_calle            varchar(80) null,
        ts_nro              int         null,
        ts_colonia          varchar(10) null,
        ts_localidad        varchar(10) null,
        ts_municipio        varchar(10) null,
        ts_estado           varchar(10) null,
        ts_codpostal        varchar(30) null,
        ts_pais             varchar(10) null,
        ts_telefono         varchar(20) null,
        ts_actividad_ec     varchar(10) null,
        ts_tiempo_actividad int         null,
        ts_tiempo_dom_neg   int         null,
        ts_emprendedor      char(1)     null,
        ts_recurso          varchar(10) null,
        ts_ingreso_mensual  money       null,
        ts_tipo_local       varchar(10) null,
        ts_usuario          login,
        ts_oficina          int,
        ts_fecha_proceso    datetime,
        ts_operacion        varchar(1),
        ts_estado_reg       varchar(10) null,
		ts_destino_credito  varchar(10) null,
		ts_hora             datetime null,
		ts_canal            varchar(30) null,
        ts_otro_recurso     varchar(30) null
)
go


print '=====> ix_ts_negocio_cliente'
go
create nonclustered index ix_ts_negocio_cliente on ts_negocio_cliente
(
    ts_codigo,
    ts_ente,
    ts_usuario
) on indexgroup




if not exists (select 1 FROM sys.indexes WHERE name = 'ix_fecha_neg_cli' AND object_id = OBJECT_ID('ts_negocio_cliente'))
   create nonclustered index ix_fecha_neg_cli on ts_negocio_cliente (ts_fecha_proceso)
if not exists (select 1 FROM sys.indexes WHERE name = 'ix_usuario_neg_cli' AND object_id = OBJECT_ID('ts_negocio_cliente'))
   create nonclustered index ix_usuario_neg_cli on ts_negocio_cliente (ts_usuario)
if not exists (select 1 FROM sys.indexes WHERE name = 'ix_fecha_usuario_neg_cli' AND object_id = OBJECT_ID('ts_negocio_cliente'))
   create nonclustered index ix_fecha_usuario_neg_cli on ts_negocio_cliente (ts_fecha_proceso, ts_usuario)
   
go

--///////////////////////////////////////////////////////////////////////////

use cobis
go
--ts_direccion_geo
if not object_id('ts_direccion_geo') is null
   drop view ts_direccion_geo
go
create view ts_direccion_geo  (
   secuencia,          tipo_transaccion,       clase,              fecha,
   oficina_s,          usuario,                terminal_s,         srv,    
   lsrv,               hora,                   ente,               direccion,
   latitud_coord,      latitud_grados,         latitud_minutos,    latitud_segundos,
   longitud_coord,     longitud_grados,        longitud_minutos,   longitud_segundos,
   path_croquis,       canal,                  rol)
as select    
   ts_secuencial,      ts_tipo_transaccion,    ts_clase,            ts_fecha,
   ts_oficina,         ts_usuario,             ts_terminal,         ts_srv,
   ts_lsrv,            ts_fecha_modifi,        ts_empresa,          ts_moneda,    
   ts_garantia,        ts_num_cargas,          ts_filial,           ts_segundos_lat,
   ts_rep_superban,    ts_notaria,             ts_cod_atr,          ts_segundos_long,
   ts_path_croquis,    ts_term,                ts_cargo
from    cl_tran_servicio
where   ts_tipo_transaccion    =    1608
or      ts_tipo_transaccion    =    1609
or      ts_tipo_transaccion    =    1606
go

--ts_direccion
if not object_id('ts_direccion') is null
   drop view ts_direccion
go
/*create view ts_direccion    (
  secuencial,          tipo_transaccion,          clase,                     fecha,	hora,
  usuario,             terminal,                  srv,                       lsrv,    
  ente,                direccion,                 descripcion,               vigencia,
  sector,              zona,                      parroquia,                 ciudad,    
  tipo,                oficina,                   verificado,                barrio,
  provincia,           codpostal,                 casa,                      calle,
  pais,                correspondencia,           alquilada,                 cobro,
  edificio,            departamento,              rural_urbano,              fact_serv_pu,
  tipo_prop,           nombre_agencia,            fuente_verif,              fecha_ver,
  reside
)    as
select
  ts_secuencial,       ts_tipo_transaccion,       ts_clase,                  ts_fecha,	ts_hora,
  ts_usuario,          ts_terminal,               ts_srv,                    ts_lsrv,
  ts_ente,             ts_direccion,              ts_descripcion,            ts_posicion,
  ts_sector,           ts_zona,                   ts_parroquia,              ts_ciudad,    
  ts_tipo,             ts_oficina,                ts_tipo_dp,                ts_barrio,
  ts_provincia,        ts_emp_postal,             ts_pasaporte,              ts_sucursal_ref,
  ts_pais,             ts_estatus,                ts_garantia,               ts_mandat,
  ts_razon_social,     ts_ingre,                  ts_dinero,                 ts_toperacion,
  ts_fecha_ref,        ts_clase_bienes_e,         ts_valor,                  ts_fecha_valuo,
  ts_tiempo_reside
from    cl_tran_servicio
where    ts_tipo_transaccion    =    109
or        ts_tipo_transaccion    =    110
or        ts_tipo_transaccion    =    1226

go*/

--ts_telefono
if not object_id('ts_telefono') is null
   drop view ts_telefono
go
create view ts_telefono(
   secuencial,      alterno,         tipo_transaccion,       clase,          fecha,	   hora,
   usuario,         terminal,        srv,                    lsrv,           ente,       direccion,
   telefono,        valor,           tipo,                   cobro,          codarea,    oficina,
   canal,           rol
) as select    
   ts_secuencial,    ts_cod_alterno,  ts_tipo_transaccion,    ts_clase,        ts_fecha,	ts_hora,
   ts_usuario,       ts_terminal,     ts_srv,                 ts_lsrv,         ts_ente,     ts_direccion,
   ts_codigo,        ts_valor,        ts_tipo,                ts_doc_validado, ts_promotor, ts_oficina,
   ts_term,          ts_cargo
from    cl_tran_servicio
where   ts_tipo_transaccion    =    111
or      ts_tipo_transaccion    =    112
or      ts_tipo_transaccion    =    148

go

--ts_tipo_documento
if not object_id('ts_tipo_documento') is null
   drop view ts_tipo_documento
go
create view ts_tipo_documento
    (   secuencia,       tipo_transaccion,    clase,             fecha,	         hora,
        oficina_s,       usuario,             terminal_s,        srv,    
        lsrv,            codigo,              descripcion,       mascara,
        tipooper,        aperrapida,          nacionalidad,      digito,
        estado,          desc_corta,          compuesto,         nro_compuesto,
        adicional,       creacion,            habilitado_mis,    habilitado_usu,
        prefijo,         subfijo    
    )
as
select  ts_secuencial,   ts_tipo_transaccion, ts_clase,           ts_fecha,	   ts_hora,
        ts_oficina,      ts_usuario,          ts_terminal,        ts_srv,    
        ts_lsrv,         ts_codigocat,        ts_descripcion,     ts_camara,
        ts_tipo,         ts_rep_superban,     ts_nacionalidad,    ts_doc_validado,
        ts_estado,       ts_escritura,        ts_dinero,          ts_num_cargas,
        ts_nivel,        ts_garantia,         ts_mandat,          ts_tipo_dp,
        ts_ingre,        ts_ntrandeb
        
from    cl_tran_servicio
where    ts_tipo_transaccion    =    1429
or        ts_tipo_transaccion    =    1430
GO

--ts_persona_prin
if not object_id('ts_persona_prin') is null
   drop view ts_persona_prin
go
create view ts_persona_prin(secuencia,            tipo_transaccion,        clase,                   fecha,              hora,             usuario,
                           terminal,              srv,                     lsrv,                    persona,            nombre,
                           p_apellido,            s_apellido,              sexo,                    cedula,             tipo_ced,
                           pais,                  profesion,               estado_civil,            actividad,          num_cargas,
                           nivel_ing,             nivel_egr,               tipo,                    filial,             oficina,
                           fecha_nac,             grupo,                   oficial,                 comentario,         retencion,
                           fecha_mod,             fecha_expira,            sector,                  ciudad_nac,         nivel_estudio,
                           tipo_vivienda,         calif_cliente,           tipo_vinculacion,        s_nombre,           c_apellido, secuen_alterno/*,
                           promotor,              nacionalidad,            ingre,                   id_tutor,           nombre_tutor,
                           bloquear,              bienes,                  verificado,              fecha_verif,        estado_ea,
                           menor_edad,            conocido_como,           cliente_planilla,        cod_risk,           sector_eco,
                           actividad_ea,          lin_neg,                 seg_neg,                 remp_legal,         apoderado_legal,
                           fuente_ing,            act_prin,                detalle,                 cat_aml,            discapacidad,
                           tipo_discapacidad,     ced_discapacidad,        nivel_egresos,           ifi,                asfi,
                           path_foto,             nit,                     nit_vencimiento*/)

                as    --GAP    CLI-0175    116
                select     ts_secuencial,         ts_tipo_transaccion,     ts_clase,                ts_fecha,           ts_hora,          ts_usuario,
                           ts_terminal,           ts_srv,                  ts_lsrv,                 ts_ente,            ts_nombre,
                           ts_p_apellido,         ts_s_apellido,           ts_sexo,                 ts_cedruc,          ts_tipo_ced,
                           ts_pais,               ts_profesion,            ts_estado_civil,         ts_actividad,       ts_num_cargas,
                           ts_ingresos,           ts_egresos,              ts_tipo,                 ts_filial,          ts_oficina,
                           ts_fecha_nac,          ts_grupo,                ts_funcionario,          ts_observacion,     ts_posicion,
                           ts_fecha_modificacion, ts_fecha_expira,         ts_sector,               ts_ciudad_nac,      ts_nivel_estudio,
                           ts_tipo_vivienda,      ts_calif_cliente,        ts_tipo_vinculacion,     ts_nacionalidad,    ts_descripcion,  ts_cod_alterno/*,
                           ts_promotor,           ts_naciona,              ts_ingre,                ts_num_poliza,      ts_desc_seguro,
                           ts_nacional,           ts_bienes,               ts_garantia,             ts_estado,          ts_codigocat,
                           ts_toperacion,         ts_observaciones,        ts_estatus,              ts_sigla,           ts_abreviatura,
                           ts_reg_nat,            ts_reg_ope,              ts_grado_soc,            ts_codigo_mr,       ts_documento,
                           ts_tipo_soc,           ts_zona,                 ts_nombre_completo,      ts_proposito,       ts_discapacidad,
                           ts_tipo_discapacidad,  ts_ced_discapacidad,     ts_nivel_egresos,        ts_ifi,             ts_asfi,
                           ts_path_foto,          ts_nit,                  ts_nit_venc*/
                    from    cobis..cl_tran_servicio
                    where    ts_tipo_transaccion    =    103
                        or   ts_tipo_transaccion    =    104
                        or   ts_tipo_transaccion    =    192
                        or   ts_tipo_transaccion    =    1288
GO


--ts_persona_sec
if not object_id('ts_persona_sec') is null
   drop view ts_persona_sec
go
CREATE VIEW ts_persona_sec
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
path_foto,             nit,                    nit_vencimiento ,       secuen_alterno2,	  oficina)
as    --GAP    CLI-0175    116
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
ts_path_foto,           ts_nit,                ts_nit_venc ,           ts_cod_alterno,	     ts_oficina
from    cobis..cl_tran_servicio
where    ts_tipo_transaccion    =    103
    or    ts_tipo_transaccion    =    104
    or    ts_tipo_transaccion    =    192
    or    ts_tipo_transaccion    =    1288
go

--ts_actividad_economica
if not object_id('ts_actividad_economica') is null
   drop view ts_actividad_economica
go
create view ts_actividad_economica    (
        secuencia,        tipo_transaccion,        clase,                   fecha,              usuario,
        terminal_s,       srv,                     lsrv,                    hora,               ente,
        actividad,        sector,                  subactividad,            subsector,          fuente_ing,
        principal,        dias_atencion,           horario_atencion,        fecha_inicio_act,   antiguedad,
        ambiente,         autorizado,              afiliado,                lugar_afiliacion,   num_empleados,    
        desc_actividad,   ubicacion,               horario_actividad,       estado_ae,          desc_caedec,
        verificado,       fecha_verificacion,      fuente_verificacion,		oficina )
as 
select  ts_secuencial,     ts_tipo_transaccion,     ts_clase,                ts_fecha,           ts_usuario,    
        ts_terminal,       ts_srv,                  ts_lsrv,                 ts_hora,            ts_ente,
        ts_escritura,      ts_sector,               ts_actividad,            ts_tipo_soc,        ts_origen_ingresos,
        ts_regional,       ts_tipo,                 ts_licencia,             ts_fec_aut_asf,     ts_provincia,
        ts_cod_fie_asf,    ts_nemon,                ts_nemdef,               ts_obs_horario,     ts_procedure,
        ts_desc_seguro,    ts_descrip_ref_per,      ts_login,                ts_estado,          ts_razon_social,
        ts_verificado,     ts_fecha_verificacion,   ts_fuente_verificacion,  ts_oficina
from    cl_tran_servicio
where    ts_tipo_transaccion    =    2436
or       ts_tipo_transaccion    =    2437
or       ts_tipo_transaccion    =    2438
or       ts_tipo_transaccion    =    2439
go


IF OBJECT_ID ('dbo.ts_direccion') IS NOT NULL
	DROP VIEW dbo.ts_direccion
GO

create view ts_direccion    
(
  secuencial,          tipo_transaccion,          clase,                     fecha,	hora,
  usuario,             terminal,                  srv,                       lsrv,    
  ente,                direccion,                 descripcion,               vigencia,
  sector,              zona,                      parroquia,                 ciudad,    
  tipo,                oficina,                   verificado,                barrio,
  provincia,           codpostal,                 casa,                      calle,
  pais,                correspondencia,           alquilada,                 cobro,
  edificio,            departamento,              rural_urbano,              fact_serv_pu,
  tipo_prop,           nombre_agencia,            fuente_verif,              fecha_ver,
  reside,              negocio,                   poblacion,                 nro,                       
  nro_interno,         referencia,                nro_residentes,            canal, 
  principal,           rol)    
as
select
  ts_secuencial,       ts_tipo_transaccion,       ts_clase,                  ts_fecha,	ts_hora,
  ts_usuario,          ts_terminal,               ts_srv,                    ts_lsrv,
  ts_ente,             ts_direccion,              ts_descripcion,            ts_posicion,
  ts_sector,           ts_zona,                   ts_parroquia,              ts_ciudad,    
  ts_tipo,             ts_oficina,                ts_tipo_dp,                ts_barrio,
  ts_provincia,        ts_emp_postal,             ts_pasaporte,              ts_sucursal_ref,
  ts_pais,             ts_estatus,                ts_garantia,               ts_mandat,
  ts_razon_social,     ts_ingre,                  ts_dinero,                 ts_toperacion,
  ts_fecha_ref,        ts_clase_bienes_e,         ts_valor,                  ts_fecha_valuo,
  ts_tiempo_reside,    ts_lugar_doc,              ts_localidad,              ts_secuencial1,                 
  ts_seccuenta,        ts_desc_larga,             ts_naciona,                ts_term, 
  ts_ifi,              ts_cargo
from    cl_tran_servicio
where    ts_tipo_transaccion    =    109
or       ts_tipo_transaccion    =    110
