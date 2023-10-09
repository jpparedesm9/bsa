USE cob_credito
GO

IF OBJECT_ID ('dbo.vw_reno_provi') IS NOT NULL
	DROP VIEW dbo.vw_reno_provi
GO

create view vw_reno_provi
as
select rp_tramite,
       rp_banco,
       rp_saldo_cap        rp_saldo_cap_antes,
       rp_saldo_int        rp_saldo_int_antes,
       rp_saldo_otros      rp_saldo_otros_antes,
       rp_xprov_cban       rp_descubierto_cap_antes,
       rp_xprov_iban       rp_descubierto_int_antes,
       rp_xprov_oban       rp_descubierto_otros_antes,
       rp_prov_cban        rp_norma_cap_antes,
       rp_prov_iban        rp_norma_int_antes,
       rp_prov_oban        rp_norma_otros_antes,
       rp_prov_cbaa        rp_adicional_cap_antes,
       rp_prov_ibaa        rp_adicional_int_antes,
       rp_prov_obaa        rp_adicional_otros_antes,
       rp_prov_ccaj        rp_caja_cap_antes,
       rp_prov_icaj        rp_caja_int_antes,
       rp_prov_ocaj        rp_caja_otros_antes,
       rp_prov_cant        rp_anios_ant_cap_antes,
       rp_prov_iant        rp_anios_ant_int_antes,
       rp_prov_oant        rp_anios_ant_otros_antes,
       rp_calificacion     rp_calificacion_antes,
       rp_provn_cban       rp_norma_cap_desp,
       rp_provn_iban       rp_norma_int_desp,
       rp_provn_oban       rp_norma_otros_desp,
       rp_provn_cbaa       rp_adicional_cap_desp,
       rp_provn_ibaa       rp_adicional_int_desp,
       rp_provn_obaa       rp_adicional_otros_desp,
       rp_provn_ccaj       rp_caja_cap_desp,
       rp_provn_icaj       rp_caja_int_desp,
       rp_provn_ocaj       rp_caja_otros_desp,
       rp_provn_cant       rp_anios_ant_cap_desp,
       rp_provn_iant       rp_anios_ant_int_desp,
       rp_provn_oant       rp_anios_ant_otros_desp,
       rp_ncalificacion    rp_calificacion_desp,
       rp_saldo_cdr        rp_saldo_cap_desp,
       rp_saldo_idr        rp_saldo_int_desp,
       rp_saldo_odr        rp_saldo_otros_desp,
       rp_xprovn_cban      rp_descubierto_cap_desp,
       rp_xprovn_iban      rp_descubierto_int_desp,
       rp_xprovn_oban      rp_descubierto_otros_desp,
       rp_fecha
from   cr_reno_provi

GO

IF OBJECT_ID ('dbo.vw_planes') IS NOT NULL
	DROP VIEW dbo.vw_planes
GO

create view vw_planes
as
select * from cob_credito..cr_planes
GO

IF OBJECT_ID ('dbo.vw_fogacafe_rep') IS NOT NULL
	DROP VIEW dbo.vw_fogacafe_rep
GO

create view vw_fogacafe_rep as 
select 
fr_regional_des,        
fr_regional,            
fr_oficina_des,         
fr_oficina,             
fr_pagare_cobis,
fr_banco,
fr_nombre,
fr_identificacion,
fr_actividad,
fr_monto,
fr_plazo,
fr_gracia_cap,
fr_periodo_cap,
fr_fecha_liq,
fr_porcentaje,
fr_fogacafe,
fr_tasa_comis,
fr_valor_comis,
fr_val_iva_comis,
fr_total_iva,
fr_cuenta,
fr_llave_redescuento,
fr_fecha_ven,
fr_tasa_int,
fr_saldo ,
fr_fecha_mora,          
fr_dias_mora,         
fr_fecha_demanda       
from cob_credito..cr_fogacafe_rep
GO

IF OBJECT_ID ('dbo.vw_consolidador_tramite') IS NOT NULL
	DROP VIEW dbo.vw_consolidador_tramite
GO

------------------------------------------------------------------------
/*INSERTO LOS DATOS COMO PROCESADOS*/
/* CALCULA LOS TRAMITES SIN DUPLICADOS*/
create view vw_consolidador_tramite (
ct_fecha,       ct_tramite,     ct_estado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), tr_tramite, 'P'
from   cr_tramite

GO

IF OBJECT_ID ('dbo.vs_pendte_desembolso') IS NOT NULL
	DROP VIEW dbo.vs_pendte_desembolso
GO

CREATE VIEW vs_pendte_desembolso   --SRA: Reporte de creditos pendientes de desembolso
    (    oficina,    
         zona,
         regional,
         tramite,
         cliente,
         tipo,
         estado, 
         fecha_aprobacion,
         monto_aprobado, 
         monto_utilizado,  
         tipo_garantia,
         inversion,
         tipo_productor,
         linea

) AS   
 SELECT  rt_oficina,    
         rt_zona,
         rt_regional,
         rt_tramite,
         rt_cliente,
         rt_tipo,
         rt_estado, 
         rt_fecha_aprobacion,
         rt_monto_aprobado, 
         rt_monto_utilizado,  
         rt_tipo_garantia,
         rt_inversion,
         rt_tipo_productor,
         rt_linea
FROM cr_pendte_desembolso 

GO

IF OBJECT_ID ('dbo.ts_variables_filtros') IS NOT NULL
	DROP VIEW dbo.ts_variables_filtros
GO

CREATE VIEW ts_variables_filtros  (
  secuencial,   	tipo_transaccion,   	clase,
  fecha,   		    usuario,   				terminal,
  oficina,   		tabla,   				lsrv,
  srv,   		    filtro,   			    variable,
  condicion,   		operador,   			referencial,
  puntaje) AS
  SELECT cr_tran_servicio.ts_secuencial,
         cr_tran_servicio.ts_tipo_transaccion,
         cr_tran_servicio.ts_clase,
         cr_tran_servicio.ts_fecha,
         cr_tran_servicio.ts_usuario,
         cr_tran_servicio.ts_terminal,
         cr_tran_servicio.ts_oficina,
         cr_tran_servicio.ts_tabla,
         cr_tran_servicio.ts_lsrv,
         cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_int01,
         cr_tran_servicio.ts_int02,
         cr_tran_servicio.ts_int03,
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_descripcion01,
         cr_tran_servicio.ts_catalogo01
  FROM cr_tran_servicio 
  WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22256) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22257) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22258)

GO

IF OBJECT_ID ('dbo.ts_truta') IS NOT NULL
	DROP VIEW dbo.ts_truta
GO

CREATE VIEW ts_truta
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      truta,   
      descripcion,   
      tipo,         
      sobrepasa, 
      asociativo ) AS                          /* DBA: 21/JUN/99 */
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint02,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_char121,               /* DBA : 21/JUN/99 */
         cr_tran_servicio.ts_char122               /* DBA : 21/JUN/99 */
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21004 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21104 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21204 )

GO

IF OBJECT_ID ('dbo.ts_tramite_garantia') IS NOT NULL
	DROP VIEW dbo.ts_tramite_garantia
GO

create view ts_tramite_garantia
(     secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      tipo_gar,
      cobertura,
      idoneidad,
      estado,
      val_avaluo,
      val_aceptado,
      descripcion,
      cubrimiento,
      tipo_predio,
      vereda,
      matricula,
      municipio,
      depatamento,
      extencion,
      fecha_avaluo,
      avaluador,
      fecha_estit,
      abogado,
      concepto) AS   
select cr_tran_servicio.ts_secuencial, 
      cr_tran_servicio.ts_tipo_transaccion, 
      cr_tran_servicio.ts_clase, 
      cr_tran_servicio.ts_fecha, 
      cr_tran_servicio.ts_usuario, 
      cr_tran_servicio.ts_terminal, 
      cr_tran_servicio.ts_oficina, 
      cr_tran_servicio.ts_tabla, 
      cr_tran_servicio.ts_lsrv, 
      cr_tran_servicio.ts_srv,
      cr_tran_servicio.ts_int01,
      cr_tran_servicio.ts_catalogo01,
      cr_tran_servicio.ts_float01,
      cr_tran_servicio.ts_vchar2401,
      cr_tran_servicio.ts_catalogo02,
      cr_tran_servicio.ts_money01,
      cr_tran_servicio.ts_money02,
      cr_tran_servicio.ts_descripcion01,
      cr_tran_servicio.ts_float02,
      cr_tran_servicio.ts_vchar4001,
      cr_tran_servicio.ts_cuenta01,
      cr_tran_servicio.ts_cuenta02,
      cr_tran_servicio.ts_cuenta03,
      cr_tran_servicio.ts_cuenta04,
      cr_tran_servicio.ts_float03,
      cr_tran_servicio.ts_fecha01,
      cr_tran_servicio.ts_vchar4002,
      cr_tran_servicio.ts_fecha02,
      cr_tran_servicio.ts_catalogo03,
      cr_tran_servicio.ts_catalogo04
   FROM cob_credito..cr_tran_servicio 
   WHERE  cr_tran_servicio.ts_tipo_transaccion in (21547,21548,21549,21550)

GO

IF OBJECT_ID ('dbo.ts_tramite') IS NOT NULL
	DROP VIEW dbo.ts_tramite
GO

CREATE view [dbo].[ts_tramite]
as
select     ts_secuencial AS secuencial, ts_tipo_transaccion AS tipo_transaccion, ts_clase AS clase, ts_fecha AS fecha, ts_usuario AS usuario, 
                      ts_terminal AS terminal, ts_oficina AS oficina, ts_tabla AS tabla, ts_lsrv AS lsrv, ts_srv AS srv, ts_int01 AS tramite, ts_char101 AS tipo, 
                      ts_smallint02 AS oficina_tr, ts_login01 AS usuario_tr, ts_fecha01 AS fecha_crea, ts_smallint01 AS oficial, ts_char102 AS sector, ts_int07 AS ciudad, 
                      ts_char103 AS estado, ts_tinyint01 AS nivel_ap, ts_fecha02 AS fecha_apr, ts_login02 AS usuario_apr, ts_tinyint02 AS truta, ts_smallint04 AS secuencia,
                      ts_int04 AS numero_op, ts_cuenta01 AS numero_op_banco, ts_catalogo01 AS proposito, ts_catalogo02 AS razon, ts_texto2 AS txt_razon, 
                      ts_catalogo03 AS efecto, ts_int02 AS cliente, ts_int03 AS grupo, ts_fecha03 AS fecha_inicio, ts_smallint05 AS num_dias, ts_catalogo04 AS per_revision,
                      ts_texto AS condicion_especial, ts_int05 AS linea_credito, ts_catalogo05 AS toperacion, ts_catalogo06 AS producto, ts_money01 AS monto, 
                      ts_tinyint03 AS moneda, ts_catalogo07 AS periodo, ts_smallint06 AS num_periodos, ts_catalogo08 AS destino, ts_int08 AS ciudad_destino, 
                      ts_cuenta02 AS cuenta_corriente, ts_smallint08 AS renovacion, ts_char107 AS precancelacion, ts_catalogo09 AS comite, ts_cuenta03 AS acta, 
                      ts_float01 AS rent_actual, ts_float02 AS rent_solicitud, ts_float03 AS rent_recomend, ts_money02 AS prod_actual, ts_money03 AS prod_solicitud, 
                      ts_money04 AS prod_recomend, ts_catalogo10 AS clasecca, ts_money05 AS admisible, ts_money06 AS noadmis, ts_int06 AS relacionado, 
                      ts_float04 AS pondera, ts_char117 AS subtipo, ts_catalogo13 AS tipo_producto, ts_catalogo14 AS origen_bienes, ts_catalogo15 AS localizacion, 
                      ts_catalogo16 AS plan_inversion, ts_catalogo17 AS naturaleza, ts_catalogo18 AS tipo_financia, ts_char118 AS sobrepasa, ts_char119 AS forward, 
                      ts_char120 AS elegible, ts_int09 AS emp_emisora, ts_smallint09 AS num_acciones, ts_int10 AS responsable, ts_cuenta04 AS negocio, 
                      ts_char124 AS reestructuracion, ts_catalogo19 AS concepto_credito, ts_catalogo20 AS aprob_gar, ts_char127 AS cont_admisible, 
                      ts_catalogo21 AS mercado_objetivo, ts_vchar2401 AS tipo_productor, ts_money07 AS valor_proyecto, ts_char121 AS sindicado, 
                      ts_float05 AS margen_redescuento, ts_fecha16 AS fecha_ap_anti, ts_char143 AS asociativo, ts_char104 AS incentivo, ts_fecha04 AS fecha_eleg, 
                      ts_int11 AS op_redescuento, ts_fecha15 AS fecha_redes, ts_cuenta01 AS llave_redes, ts_int23 AS solicitud, ts_money08 AS montop, 
                      ts_money09 AS montodesembolsop, ts_catalogo22 AS mercado, ts_catalogo23 AS cod_actividad, ts_int12 AS num_desemb, 
                      ts_vchar6401 AS carta_apr, ts_fecha06 AS fecha_aprov, ts_fecha07 AS fmax_redes, ts_fecha08 AS f_prorroga, ts_catalogo24 AS sujcred, 
                      ts_catalogo25 AS fabrica, ts_catalogo26 AS callcenter, ts_catalogo27 AS apr_fabrica, ts_money10 AS monto_solicitado, ts_char132 AS tipo_plazo, 
                      ts_char133 AS tipo_cuota, ts_smallint13 AS plazo, ts_money20 AS cuota_aproximada, ts_int13 AS fuente_recurso, ts_char134 AS tipo_credito, 
                      ts_smallint14 AS nivel_por, ts_int14 AS campana, ts_cod_alterno AS alterno, ts_int15 as alianza, ts_char135 as exp_cliente,  ts_money21 as monto_max_tr
FROM         dbo.cr_tran_servicio
WHERE     (ts_tipo_transaccion = 21020) OR
          (ts_tipo_transaccion = 21120) OR
          (ts_tipo_transaccion = 21220)




GO

IF OBJECT_ID ('dbo.ts_toperacion') IS NOT NULL
	DROP VIEW dbo.ts_toperacion
GO

CREATE VIEW ts_toperacion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      toperacion,
      producto,   
      descripcion,
      estado,
      riesgo,
      codigo_sib) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_catalogo01,   
       cr_tran_servicio.ts_catalogo02,   
       cr_tran_servicio.ts_descripcion01,
       cr_tran_servicio.ts_char101,
       cr_tran_servicio.ts_char301,
       cr_tran_servicio.ts_char201
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21010 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21110 )

GO

IF OBJECT_ID ('dbo.ts_tipocob_estado') IS NOT NULL
	DROP VIEW dbo.ts_tipocob_estado
GO

CREATE VIEW ts_tipocob_estado
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tipo_cob,
      estado) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv, 
  	cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_catalogo02
FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21142) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21148)

GO

IF OBJECT_ID ('dbo.ts_tipo_oficina') IS NOT NULL
	DROP VIEW dbo.ts_tipo_oficina
GO

CREATE VIEW ts_tipo_oficina
    ( secuencial, 
      tipo_transaccion,
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv,
      srv, 
      oficina_marcada,
      to_opi) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion,
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_smallint09,   
         cr_tran_servicio.ts_char128
   FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22911 )


GO

IF OBJECT_ID ('dbo.ts_tinstruccion') IS NOT NULL
	DROP VIEW dbo.ts_tinstruccion
GO

CREATE VIEW ts_tinstruccion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo,   
      descripcion,   
      nivel_ap,
      aprobacion ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_char102
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21008 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21108 ) OR 
         ( cr_tran_servicio.ts_tipo_transaccion = 21208 )

GO

IF OBJECT_ID ('dbo.ts_texcepcion') IS NOT NULL
	DROP VIEW dbo.ts_texcepcion
GO

CREATE VIEW ts_texcepcion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo,   
      tipo,   
      descripcion,   
      nivelap,
      aprobacion ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_char101,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_catalogo02,  
         cr_tran_servicio.ts_char102
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21007 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21107 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21207 )

GO

IF OBJECT_ID ('dbo.ts_tel_abogado') IS NOT NULL
	DROP VIEW dbo.ts_tel_abogado
GO

CREATE VIEW ts_tel_abogado
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      abogado, 
      telefono,
      numero,
      tipo ) AS
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_tinyint01,
        cr_tran_servicio.ts_vchar6401,
        cr_tran_servicio.ts_catalogo02
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21072) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21172) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21272)

GO

IF OBJECT_ID ('dbo.ts_tcalificacion') IS NOT NULL
	DROP VIEW dbo.ts_tcalificacion
GO

CREATE VIEW ts_tcalificacion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tcalificacion, 
      descripcion, 
      tipo,
      para,          
      estado)
 AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_catalogo01,   
	cr_tran_servicio.ts_descripcion01,
  	cr_tran_servicio.ts_char101,   
  	cr_tran_servicio.ts_char102,   
	cr_tran_servicio.ts_catalogo02
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21968 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21069 )

GO

IF OBJECT_ID ('dbo.ts_secuencia') IS NOT NULL
	DROP VIEW dbo.ts_secuencia
GO

CREATE	VIEW ts_secuencia
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,  
      etapa,    
      estacion, 
      estado,  
      secuencia,
      tipo,
      superior,
      miembro,
      cod_alterno  
      ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_tinyint01,
         cr_tran_servicio.ts_smallint01,
	 cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_tinyint02,
         cr_tran_servicio.ts_char102,
	 cr_tran_servicio.ts_smallint02,
         cr_tran_servicio.ts_catalogo01,
	 cr_tran_servicio.ts_cod_alterno
    FROM cr_tran_servicio  
   WHERE (cr_tran_servicio.ts_tipo_transaccion = 21928)

GO

IF OBJECT_ID ('dbo.ts_ruta_tramite') IS NOT NULL
	DROP VIEW dbo.ts_ruta_tramite
GO

CREATE VIEW ts_ruta_tramite 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,   
      secuencia,   
      etapa,   
      estacion,   
      truta,   
      paso,   
      llegada,   
      salida,   
      estadot,   
      paralelo,   
      prioridad,   
      abierto,
      etapa_sus,
      estacion_sus,
      comite ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_smallint02,   
         cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_smallint06,   
         cr_tran_servicio.ts_smallint05,   
         cr_tran_servicio.ts_fecha01,   
         cr_tran_servicio.ts_fecha02,   
         cr_tran_servicio.ts_int02,   
         cr_tran_servicio.ts_smallint03,   
         cr_tran_servicio.ts_tinyint04,   
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_smallint14,
         cr_tran_servicio.ts_smallint04,
	 cr_tran_servicio.ts_char102
    FROM cr_tran_servicio   
    WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21006 ) OR
	  ( cr_tran_servicio.ts_tipo_transaccion = 21106 )

GO

IF OBJECT_ID ('dbo.ts_rub_renovar') IS NOT NULL
	DROP VIEW dbo.ts_rub_renovar
GO

CREATE VIEW ts_rub_renovar
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      concepto,
      renovar,
      tramite_re) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int22,
        cr_tran_servicio.ts_catalogo40,
        cr_tran_servicio.ts_char144,
        cr_tran_servicio.ts_int23
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21771) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21772) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21773) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21774)

GO

IF OBJECT_ID ('dbo.ts_req_tramite') IS NOT NULL
	DROP VIEW dbo.ts_req_tramite
GO

CREATE VIEW ts_req_tramite
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      tipo,
      etapa,
      requisito,
      observacion,
      fecha_modif,
      tipo_cliente) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_char101,     
        cr_tran_servicio.ts_tinyint01,   
        cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_descripcion01,   
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_char102
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21051 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21151 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21251 )

GO

IF OBJECT_ID ('dbo.ts_req_etapa') IS NOT NULL
	DROP VIEW dbo.ts_req_etapa
GO

CREATE VIEW ts_req_etapa
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      etapa,
      tramite,   
      requisito,   
      mandatorio,
      tipo_cliente,
      tipo_per_com ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_char101,   
         cr_tran_servicio.ts_catalogo01,
	 cr_tran_servicio.ts_char102,
	 cr_tran_servicio.ts_char103,
         cr_tran_servicio.ts_catalogo02
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21009 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21109 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21209 )

GO

IF OBJECT_ID ('dbo.ts_req_estado') IS NOT NULL
	DROP VIEW dbo.ts_req_estado
GO

CREATE VIEW ts_req_estado
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      estado,
      requisito,   
      tipo_cliente,
      descripcion,
      obligatorio,
      observacion,
      estado_dato ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_catalogo02,
         cr_tran_servicio.ts_char101,   
         cr_tran_servicio.ts_descripcion01,   
	 cr_tran_servicio.ts_char102,
         cr_tran_servicio.ts_texto,   
         cr_tran_servicio.ts_catalogo03
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21962 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21191 )

GO

IF OBJECT_ID ('dbo.ts_req_cobranza') IS NOT NULL
	DROP VIEW dbo.ts_req_cobranza
GO

CREATE VIEW ts_req_cobranza
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cobranza,
      estado,   
      requisito,
      cumplido,   
      observacion) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_char301,   
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_descripcion01
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21958 )

GO

IF OBJECT_ID ('dbo.ts_regula') IS NOT NULL
	DROP VIEW dbo.ts_regula
GO

CREATE VIEW ts_regula
    ( secuencial, 
      alterno,
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      excepcion,
      codigo,
      estado,
      fecha_regula,
      login_regula,
      razon) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_cod_alterno,
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_tinyint01,     
        cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_char101,   
        cr_tran_servicio.ts_fecha01,   
        cr_tran_servicio.ts_login01,   
        cr_tran_servicio.ts_texto
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21144 )

GO

IF OBJECT_ID ('dbo.ts_regla') IS NOT NULL
	DROP VIEW dbo.ts_regla
GO

/*   ALTER VIEW ts_regla   */
/**********************/
CREATE VIEW ts_regla
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      truta,
      paso,
      etapa,
      regla,
      prioridad,
      paso_siguiente,
      etapa_siguiente,
      descripcion,
      programa,
      banca			
     ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint01,
  	 cr_tran_servicio.ts_tinyint02,
  	 cr_tran_servicio.ts_tinyint03,
  	 cr_tran_servicio.ts_smallint04,
  	 cr_tran_servicio.ts_tinyint05,
  	 cr_tran_servicio.ts_tinyint06,
  	 cr_tran_servicio.ts_tinyint07,
     cr_tran_servicio.ts_descripcion01,
  	 cr_tran_servicio.ts_vchar4001,
     cr_tran_servicio.ts_catalogo01
    FROM cr_tran_servicio 
 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21900 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21901 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21902 )


GO

IF OBJECT_ID ('dbo.ts_problemas') IS NOT NULL
	DROP VIEW dbo.ts_problemas
GO

CREATE VIEW ts_problemas
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      oficial,
      ente,
      visita,
      problema) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
	cr_tran_servicio.ts_int01,     
        cr_tran_servicio.ts_int02,   
	cr_tran_servicio.ts_catalogo01
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21042 )

GO

IF OBJECT_ID ('dbo.ts_periodo_gracia') IS NOT NULL
	DROP VIEW dbo.ts_periodo_gracia
GO

CREATE VIEW [dbo].[ts_periodo_gracia]
    (secuencial,          tipo_transaccion,     clase, 
     fecha,               usuario,              terminal,       
     oficina,             tabla,                lsrv,
     srv,                 codigo_per,           campana,
     tipo_normalizacion,  tipo_mercado,         tipo_periodo,
     periodo) 
  AS   
  SELECT 
     ts_secuencial, ts_tipo_transaccion,  ts_clase, 
	 ts_fecha,      ts_usuario,           ts_terminal, 
     ts_oficina,    ts_tabla,             ts_lsrv, 
	 ts_srv,        ts_smallint01,        ts_vchar1001,   
     ts_vchar1002,  ts_vchar1003,         ts_vchar1004,
     ts_smallint02
   FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22958 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 22959 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 22960 )



GO

IF OBJECT_ID ('dbo.ts_periodo') IS NOT NULL
	DROP VIEW dbo.ts_periodo
GO

CREATE VIEW ts_periodo
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      periodo,
      descripcion,
      factor,
      estado ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_catalogo02   
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21017 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21117 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21217 )

GO

IF OBJECT_ID ('dbo.ts_pasos') IS NOT NULL
	DROP VIEW dbo.ts_pasos
GO

CREATE VIEW ts_pasos
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      truta,   
      paso,   
      etapa,   
      descripcion,   
      tiempo_estandar,
      tipo,
      truta_asoc,
      paso_asoc,
      etapa_asoc,
      picture ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_tinyint02,   
         cr_tran_servicio.ts_tinyint03,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_float01,
	 cr_tran_servicio.ts_char101,
	 cr_tran_servicio.ts_tinyint04,
	 cr_tran_servicio.ts_tinyint05,
	 cr_tran_servicio.ts_tinyint06,
	 cr_tran_servicio.ts_char102
   
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21005 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21105 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21205 )

GO

IF OBJECT_ID ('dbo.ts_param_suspension') IS NOT NULL
	DROP VIEW dbo.ts_param_suspension
GO

CREATE VIEW ts_param_suspension
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      clase_car,
      arrastre,
      suspension,
      situacion1,
      situacion2) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_char130,
	cr_tran_servicio.ts_catalogo23,
	cr_tran_servicio.ts_catalogo24,
	cr_tran_servicio.ts_catalogo25,
	cr_tran_servicio.ts_catalogo26
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21092 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21093 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21094 )

GO

IF OBJECT_ID ('dbo.ts_param_normalizacion') IS NOT NULL
	DROP VIEW dbo.ts_param_normalizacion
GO

create view ts_param_normalizacion as
select ts_tipo_transaccion as transaccion, ts_secuencial as secuencial_tran, ts_clase      as clase,
       ts_usuario          as usuario,     ts_terminal   as terminal,        ts_fecha      as fecha,
       ts_int01            as sec_nomaliz, ts_texto      as descripcion_nor, ts_catalogo01 as estado,
       ts_vchar1001        as tipo_norm,   ts_vchar1401  as momento,         ts_vchar6401  as programa
from cr_tran_servicio
where (ts_tipo_transaccion = 21314) OR
      (ts_tipo_transaccion = 21315)



GO

IF OBJECT_ID ('dbo.ts_param_gar') IS NOT NULL
	DROP VIEW dbo.ts_param_gar
GO

CREATE VIEW ts_param_gar
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tipo, 
      desde, 
      hasta,
      porc_normal,          
      porc_estcon,
      porc_concor)
 AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_char101,   
  	cr_tran_servicio.ts_int01,
  	cr_tran_servicio.ts_int02,
	cr_tran_servicio.ts_float01,
  	cr_tran_servicio.ts_float02,   
	cr_tran_servicio.ts_float03
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21055 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21056 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21057 )

GO

IF OBJECT_ID ('dbo.ts_param_cont_temp') IS NOT NULL
	DROP VIEW dbo.ts_param_cont_temp
GO

CREATE VIEW ts_param_cont_temp
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      codigo,
      clasep,    
      desde,   
      hasta ) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_catalogo01,
        cr_tran_servicio.ts_int02,
        cr_tran_servicio.ts_int03
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21628) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21629) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21630) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21631) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21632)

GO

IF OBJECT_ID ('dbo.ts_param_cob_gar') IS NOT NULL
	DROP VIEW dbo.ts_param_cob_gar
GO

CREATE VIEW [dbo].[ts_param_cob_gar]
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tipo,
      productor, 
      monto_desde, 
      monto_hasta,
      porc_desde,          
      porc_hasta)
 AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_char101,   
        cr_tran_servicio.ts_char102,
  	cr_tran_servicio.ts_int01,
  	cr_tran_servicio.ts_int02,
	cr_tran_servicio.ts_float01,
  	cr_tran_servicio.ts_float02
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22278 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 22279 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 22280 )


GO

IF OBJECT_ID ('dbo.ts_param_calif_mir') IS NOT NULL
	DROP VIEW dbo.ts_param_calif_mir
GO

create view ts_param_calif_mir( 
secuencial,             tipo_transaccion,          clase, 
fecha,                  usuario,                   terminal, 
oficina,                tabla,                     lsrv, 
srv,                    tipo_banca,                calificacion,
tipo_calif,             modelo,                    nivel,
limite_inf,             limite_sup,                fecha_ing )
as
select  
ts_secuencial,          ts_tipo_transaccion,       ts_clase,
ts_fecha,               ts_usuario,                ts_terminal,
ts_oficina,             ts_tabla,                  ts_lsrv,            
ts_srv,                 ts_catalogo01,             ts_catalogo02,    
ts_catalogo03,          ts_catalogo04,             ts_catalogo05,
ts_float01,             ts_float02,                ts_fecha01
from cr_tran_servicio 
where ts_tipo_transaccion = 22878
or    ts_tipo_transaccion = 22879
or    ts_tipo_transaccion = 22880

GO

IF OBJECT_ID ('dbo.ts_param_calif_aso') IS NOT NULL
	DROP VIEW dbo.ts_param_calif_aso
GO

CREATE VIEW ts_param_calif_aso 
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      calificacion,
      desde,
      hasta) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_catalogo37,
        cr_tran_servicio.ts_int21,
        cr_tran_servicio.ts_int22
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21750) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21751) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21752) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21753) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21754)

GO

IF OBJECT_ID ('dbo.ts_param_calif') IS NOT NULL
	DROP VIEW dbo.ts_param_calif
GO

CREATE VIEW ts_param_calif
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      clase_car,
      calificacion,
      desde,
      hasta,
      porcentaje,
      porc_intcxc,
      porc_cubier,      --SBU 04/ene/2002
      porc_sidac) AS    --28/sep/2005 dupegui 
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_char101,
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_smallint01,
	cr_tran_servicio.ts_smallint02,
	cr_tran_servicio.ts_float01,
	cr_tran_servicio.ts_float02,
	cr_tran_servicio.ts_float03,
        cr_tran_servicio.ts_float04
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21037 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21038 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21039 )

GO

IF OBJECT_ID ('dbo.ts_otras_reciprocidades') IS NOT NULL
	DROP VIEW dbo.ts_otras_reciprocidades
GO

CREATE VIEW ts_otras_reciprocidades
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      codigo,
      monto
) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_money01
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21935 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21936 ) OR
         ( cr_tran_servicio.ts_tipo_transaccion = 21937 )

GO

IF OBJECT_ID ('dbo.ts_operacion_cobranza') IS NOT NULL
	DROP VIEW dbo.ts_operacion_cobranza
GO

CREATE VIEW ts_operacion_cobranza 
(
secuencial, 
tipo_transaccion, 
clase, 
fecha,
usuario, 
terminal, 
oficina,
tabla,
lsrv, 
srv,
cobranza,
num_operacion,
producto,
estado,
codprod,
alterno) AS   	
SELECT 
cr_tran_servicio.ts_secuencial, 
cr_tran_servicio.ts_tipo_transaccion, 
cr_tran_servicio.ts_clase, 
cr_tran_servicio.ts_fecha,
cr_tran_servicio.ts_usuario, 
cr_tran_servicio.ts_terminal, 
cr_tran_servicio.ts_oficina, 
cr_tran_servicio.ts_tabla, 
cr_tran_servicio.ts_lsrv, 
cr_tran_servicio.ts_srv,
cr_tran_servicio.ts_char301,   
cr_tran_servicio.ts_cuenta01,
cr_tran_servicio.ts_catalogo01,
cr_tran_servicio.ts_tinyint08, 
cr_tran_servicio.ts_tinyint05,
cr_tran_servicio.ts_cod_alterno
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21956 ) or
      ( cr_tran_servicio.ts_tipo_transaccion = 21211 )

GO

IF OBJECT_ID ('dbo.ts_op_renovar') IS NOT NULL
	DROP VIEW dbo.ts_op_renovar
GO

CREATE VIEW ts_op_renovar
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      num_operacion,   
      producto,
      abono,
      moneda_abono,
      monto_original,
      saldo_original,
      fecha_concesion,
      toperacion,
      moneda_original,
      aplicar,
      capitaliza) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_cuenta01,     
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_money01,
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_money02,
	cr_tran_servicio.ts_money03,
	cr_tran_servicio.ts_fecha01,
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_tinyint02,
	cr_tran_servicio.ts_char122,
	cr_tran_servicio.ts_char123
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21030 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21130 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21230 )

GO

IF OBJECT_ID ('dbo.ts_observaciones') IS NOT NULL
	DROP VIEW dbo.ts_observaciones
GO

CREATE VIEW ts_observaciones
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      numero,
      fecha_ob,
      categoria,
      etapa,
      estacion,
      usuario_ob,
      lineas,
      oficial,
      modificar,
      rechazo ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_fecha01,   
         cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_smallint02,   
         cr_tran_servicio.ts_login01,   
         cr_tran_servicio.ts_smallint03,
	 cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_char102,
	 cr_tran_servicio.ts_char125
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21016 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21116 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21216 )

GO

IF OBJECT_ID ('dbo.ts_normalizacion') IS NOT NULL
	DROP VIEW dbo.ts_normalizacion
GO

create view ts_normalizacion as
select ts_tipo_transaccion as transaccion, ts_secuencial as secuencial_tran, ts_clase    as clase,
       ts_usuario          as usuario,     ts_terminal   as terminal,        ts_fecha    as fecha,
       ts_int01            as tramite,     ts_int02      as cliente,         ts_cuenta01 as operacion,
       ts_catalogo01       as tipo_norm,   ts_int03      as cuota_prorroga,  ts_fecha01 as fecha_proroga
from cr_tran_servicio
where (ts_tipo_transaccion = 21030) OR
      (ts_tipo_transaccion = 21230)



GO

IF OBJECT_ID ('dbo.ts_modelo_eval') IS NOT NULL
	DROP VIEW dbo.ts_modelo_eval
GO

create view ts_modelo_eval(
secuencial,     tipo_transaccion,       clase,          fecha,              usuario,          terminal,          
oficina,        tabla,                  lsrv,           srv,                tramite,          nivel_por )
as
select 
ts_secuencial,  ts_tipo_transaccion,    ts_clase,       ts_fecha,           ts_usuario,       ts_terminal,     
ts_oficina,     ts_tabla,               ts_lsrv,        ts_srv,             ts_int01,         ts_tinyint01
from cr_tran_servicio                                                                                                    
where ts_tipo_transaccion = 22293

GO

IF OBJECT_ID ('dbo.ts_miembros') IS NOT NULL
	DROP VIEW dbo.ts_miembros
GO

CREATE VIEW ts_miembros
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      comite,
      miembro,
      cabecera) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_login01,
	cr_tran_servicio.ts_char101
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21046 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21146 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21246 )

GO

IF OBJECT_ID ('dbo.ts_micro_seguro') IS NOT NULL
	DROP VIEW dbo.ts_micro_seguro
GO

create view ts_micro_seguro (
ms_secuencial_ts,       ms_cod_alterno_ts,      ms_tipo_transaccion_ts,
ms_clase_ts,            ms_fecha_ts,            ms_usuario_ts,
ms_terminal_ts,         ms_oficina_ts,          ms_tabla_ts,
ms_fecha_real_ts,
ms_secuencial,          ms_tramite,             ms_plazo,
ms_director_ofic,       ms_vendedor,            ms_estado,
ms_fecha_ini,           ms_fecha_fin,           ms_fecha_envio,
ms_cliente_aseg,        ms_valor,               ms_pagado         ) as
select
ts_secuencial,          ts_cod_alterno,         ts_tipo_transaccion,
ts_clase,               ts_fecha,               ts_usuario,
ts_terminal,            ts_oficina,             ts_tabla,
ts_fecha_real,
ts_int01,               ts_int02,               ts_smallint01,
ts_smallint02,          ts_smallint03,          ts_vchar1001,
ts_fecha01,             ts_fecha02,             ts_fecha03,
ts_char101,             ts_money01,             ts_char102
from   cr_tran_servicio
where  ts_tipo_transaccion = 22108
and    ts_cod_alterno = 0


GO

IF OBJECT_ID ('dbo.ts_mercado_sujeto') IS NOT NULL
	DROP VIEW dbo.ts_mercado_sujeto
GO

create view ts_mercado_sujeto
(
secuencial,
tipo_transaccion,
clase,
fecha,
usuario,
terminal,
oficina,
tabla,
lsrv,
srv,
banca,
mercado,
mobjetivo,
sujeto)
as

select ts_secuencial,
ts_tipo_transaccion,
ts_clase,
ts_fecha,
ts_usuario,
ts_terminal,
ts_oficina,
ts_tabla,
ts_lsrv,
ts_srv,
ts_catalogo01,
ts_catalogo02,
ts_catalogo03,
ts_catalogo04
from cob_credito..cr_tran_servicio
where ts_tipo_transaccion in (21483, 21484, 21485, 21486, 21487)

GO

IF OBJECT_ID ('dbo.ts_medidas_prec') IS NOT NULL
	DROP VIEW dbo.ts_medidas_prec
GO

CREATE VIEW ts_medidas_prec
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cobranza,
      numero,
      tipo,    
      codificacion,
      descripcion,
      depositario,
      direccion,
      valor,
      moneda,
      fecha_mp ) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_char301,
  	cr_tran_servicio.ts_smallint01,
	cr_tran_servicio.ts_char101,     
        cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_descripcion01,
        cr_tran_servicio.ts_descripcion02,
        cr_tran_servicio.ts_descripcion03,
        cr_tran_servicio.ts_money01,
        cr_tran_servicio.ts_tinyint01,
        cr_tran_servicio.ts_fecha01
    FROM cr_tran_servicio 
   WHERE  cr_tran_servicio.ts_tipo_transaccion = 21073 or 
	  cr_tran_servicio.ts_tipo_transaccion = 21173 or 
	  cr_tran_servicio.ts_tipo_transaccion = 21273

GO

IF OBJECT_ID ('dbo.ts_maestro_tramite') IS NOT NULL
	DROP VIEW dbo.ts_maestro_tramite
GO

create view ts_maestro_tramite
AS
select   TRAMITE  = tr_tramite,
         TIPO	 = tr_tipo,
         ETAPA	 = rt_etapa,
         ESTACION = isnull(rt_estacion_sus,rt_estacion),
         FECHA_LLEGADA = convert(varchar(10),rt_llegada,103),
         HORA_LLEGADA  = datepart(hh,rt_llegada),
         MIN_LLEGADA   = datepart(mi,rt_llegada),
         FECHA_SALIDA = convert(varchar(10),rt_salida,103),
         HORA_SALIDA = datepart(hh,rt_salida),
         MIN_SALIDA = datepart(mi,rt_salida) 
from 	   cr_tramite,
         cr_ruta_tramite
where    tr_tramite = rt_tramite
UNION
select   TRAMITE  = tr_tramite,
         TIPO	 = tr_tipo,
         ETAPA	 = rt_etapa,
         ESTACION = isnull(rt_estacion_sus,rt_estacion),
         FECHA_LLEGADA = convert(varchar(10),rt_llegada,103),
         HORA_LLEGADA  = datepart(hh,rt_llegada),
         MIN_LLEGADA   = datepart(mi,rt_llegada),
         FECHA_SALIDA = convert(varchar(10),rt_salida,103),
         HORA_SALIDA = datepart(hh,rt_salida),
         MIN_SALIDA = datepart(mi,rt_salida) 
from 	   cr_tramite,
         cob_credito_his..cr_ruta_tramite
where    tr_tramite = rt_tramite

GO

IF OBJECT_ID ('dbo.ts_linea') IS NOT NULL
	DROP VIEW dbo.ts_linea
GO

CREATE VIEW ts_linea
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      srv, 
      lsrv,
      numero,
      num_banco,
      ofic,
      tramite,
      cliente,
      grupo,
      original,
      fecha_aprob,
      fecha_inicio,
      per_revision,
      fecha_vto,
      dias,
      condicion_especial,
      ultima_rev,
      prox_rev,
      usuario_rev,
      monto,
      moneda,
      utilizado,
      rotativa,
      clase_cca,
      admisible,
      noadmis,
      estado,
      reservado,       --SBU   CD00054
      tipo		--SBU  CD00006
       ) AS   
SELECT cr_tran_servicio.ts_secuencial,   
         cr_tran_servicio.ts_tipo_transaccion,   
         cr_tran_servicio.ts_clase,   
         cr_tran_servicio.ts_fecha,   
         cr_tran_servicio.ts_usuario,   
         cr_tran_servicio.ts_terminal,   
         cr_tran_servicio.ts_oficina,   
         cr_tran_servicio.ts_tabla,   
         cr_tran_servicio.ts_lsrv,   
         cr_tran_servicio.ts_srv,   
	 cr_tran_servicio.ts_int01,
	 cr_tran_servicio.ts_cuenta01,
      	 cr_tran_servicio.ts_smallint01,
	 cr_tran_servicio.ts_int02,
	 cr_tran_servicio.ts_int03,
       	 cr_tran_servicio.ts_int04,
      	 cr_tran_servicio.ts_int05,
      	 cr_tran_servicio.ts_fecha01,
      	 cr_tran_servicio.ts_fecha02,
      	 cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_fecha03,
         cr_tran_servicio.ts_smallint02,
         cr_tran_servicio.ts_texto,
         cr_tran_servicio.ts_fecha04,
      	 cr_tran_servicio.ts_fecha05,
         cr_tran_servicio.ts_login01,
	 cr_tran_servicio.ts_money01,
	 cr_tran_servicio.ts_tinyint01,
	 cr_tran_servicio.ts_money02,
         cr_tran_servicio.ts_char101,
      	 cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_money03,
         cr_tran_servicio.ts_money04,
         cr_tran_servicio.ts_char102,
   	 cr_tran_servicio.ts_money15,	--SBU  CD00054
   	 cr_tran_servicio.ts_char128	--SBU  CD00006
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21026 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21126 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21226 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21826 )

GO

IF OBJECT_ID ('dbo.ts_lin_ope_moneda') IS NOT NULL
	DROP VIEW dbo.ts_lin_ope_moneda
GO

CREATE VIEW ts_lin_ope_moneda
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      linea,
      toperacion,   
      producto,
      moneda,
      monto,
      utilizado,
      tplazo,
      plazos,
      reservado,
      moneda_ope
      ) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_catalogo01,     
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_money01,
	cr_tran_servicio.ts_money02,
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_smallint01,
      	cr_tran_servicio.ts_money17,
  	cr_tran_servicio.ts_int02 

    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21023 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21123 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21223 )

GO

IF OBJECT_ID ('dbo.ts_lin_grupo') IS NOT NULL
	DROP VIEW dbo.ts_lin_grupo
GO

CREATE VIEW ts_lin_grupo
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      srv, 
      lsrv,
      linea,
      cliente,
      monto,
      utilizado,
      moneda,
      reservado		--SBU  CD00054
       ) AS   
SELECT   cr_tran_servicio.ts_secuencial,   
         cr_tran_servicio.ts_tipo_transaccion,   
         cr_tran_servicio.ts_clase,   
         cr_tran_servicio.ts_fecha,   
         cr_tran_servicio.ts_usuario,   
         cr_tran_servicio.ts_terminal,   
         cr_tran_servicio.ts_oficina,   
         cr_tran_servicio.ts_tabla,   
         cr_tran_servicio.ts_srv,   
         cr_tran_servicio.ts_lsrv,   
	 cr_tran_servicio.ts_int01,
	 cr_tran_servicio.ts_int02,
	 cr_tran_servicio.ts_money01,
	 cr_tran_servicio.ts_money02,
         cr_tran_servicio.ts_moneda,
         cr_tran_servicio.ts_money16	--SBU  CD0005
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21946 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21947 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21948 )

GO

IF OBJECT_ID ('dbo.ts_instrucciones') IS NOT NULL
	DROP VIEW dbo.ts_instrucciones
GO

CREATE VIEW ts_instrucciones
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,   
      numero,   
      codigo,   
      estado,   
      texto,   
      parametro,   
      valor_ins,   
      signo,   
      spread,   
      fecha_aprob,   
      login_aprob,   
      fecha_reg,   
      login_reg,   
      fecha_eje,   
      login_eje,
      comite,
      acta,
      respuesta ) AS   		--ZR: 15/ENE/2001  CD00074 TEQ.
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_char101,   
         cr_tran_servicio.ts_texto,   
         cr_tran_servicio.ts_catalogo02,   
         cr_tran_servicio.ts_money01,   
         cr_tran_servicio.ts_char201,   
         cr_tran_servicio.ts_float01,   
         cr_tran_servicio.ts_fecha02,   
         cr_tran_servicio.ts_login02,   
         cr_tran_servicio.ts_fecha01,   
         cr_tran_servicio.ts_login01,   
         cr_tran_servicio.ts_fecha03,   
         cr_tran_servicio.ts_login03,
	 cr_tran_servicio.ts_catalogo03,
	 cr_tran_servicio.ts_cuenta01,
	 cr_tran_servicio.ts_texto3		--ZR: 15/ENE/2001  CD00074 TEQ.
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21014 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21114 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21214 )

GO

IF OBJECT_ID ('dbo.ts_informe') IS NOT NULL
	DROP VIEW dbo.ts_informe
GO

CREATE VIEW ts_informe
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cobranza, 
      informe,
      fecha_inf,
      concepto,
      porcentaje_cump,
      Concepto_Recuperabilidad ) AS
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_char301,
  	cr_tran_servicio.ts_int02,
    cr_tran_servicio.ts_fecha01,
    cr_tran_servicio.ts_catalogo01,   
	cr_tran_servicio.ts_float01,
    cr_tran_servicio.ts_catalogo02
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21878) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21195)

GO

IF OBJECT_ID ('dbo.ts_imp_documento') IS NOT NULL
	DROP VIEW dbo.ts_imp_documento
GO

CREATE VIEW ts_imp_documento 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      documento,
      toperacion,	
      producto,
      moneda,
      descripcion,
      template,
      mnemonico,
	  tipo) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
	cr_tran_servicio.ts_catalogo01,     
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_descripcion01,
	cr_tran_servicio.ts_descripcion02,
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_char101
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21033 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21133 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21233 )

GO

IF OBJECT_ID ('dbo.ts_gar_propuesta') IS NOT NULL
	DROP VIEW dbo.ts_gar_propuesta
GO

CREATE VIEW ts_gar_propuesta
    ( secuencial, 
      tipo_transaccion, 
      accion, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      garantia,   
      clasificacion,
      exceso,
      monto_exceso,
      clase,
      deudor,
      estado,
      porcentaje,	-- SBU: 04/abr/2000
      valor_resp_garantia,
      fecha_mod,	-- ZR: CD00064 2/FEB/2001
      proceso		-- ZR: CD00064 2/FEB/2001
 ) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_vchar6401,     
	cr_tran_servicio.ts_char101,
	cr_tran_servicio.ts_char102,
	cr_tran_servicio.ts_money01,
	cr_tran_servicio.ts_char103,
  	cr_tran_servicio.ts_int02,
	cr_tran_servicio.ts_char104,
	cr_tran_servicio.ts_float05,	-- SBU: 04/abr/2000
	cr_tran_servicio.ts_money13,
        cr_tran_servicio.ts_fecha10,	-- ZR: CD00064 2/FEB/2001
	cr_tran_servicio.ts_char126 	-- ZR: CD00064 2/FEB/2001
   
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21028 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21128 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21228 )

GO

IF OBJECT_ID ('dbo.ts_gar_anteriores') IS NOT NULL
	DROP VIEW dbo.ts_gar_anteriores
GO

CREATE VIEW ts_gar_anteriores
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      gar_nueva,
      gar_anterior,   
--      descripcion,
--      estado,
--      valor,
--      efecto,
      operacion,
      porcentaje,			-- ZR : 02/FEB/01 CD00064
      valor_resp_garantia ) AS   	-- ZR : 02/FEB/01 CD00064
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_vchar4001,     
	cr_tran_servicio.ts_vchar4002,     
--	  cr_tran_servicio.ts_descripcion01,
--        cr_tran_servicio.ts_char101,
--	  cr_tran_servicio.ts_money01,
--        cr_tran_servicio.ts_char101,
        cr_tran_servicio.ts_cuenta01,
        cr_tran_servicio.ts_float06,
        cr_tran_servicio.ts_money14
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21029 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21129 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21229 )

GO

IF OBJECT_ID ('dbo.ts_fuente_recurso') IS NOT NULL
	DROP VIEW dbo.ts_fuente_recurso
GO

CREATE VIEW ts_fuente_recurso
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo_fuente,
      fuente,
      monto,
      saldo,
      utilizado,
      estado,
      tipo_fuente
       )
 AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
    cr_tran_servicio.ts_int01,
    cr_tran_servicio.ts_catalogo01,
    cr_tran_servicio.ts_money01,
    cr_tran_servicio.ts_money02,
    cr_tran_servicio.ts_money03,
    cr_tran_servicio.ts_catalogo02,
    cr_tran_servicio.ts_char101
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22062 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 22063 )

GO

IF OBJECT_ID ('dbo.ts_firmora') IS NOT NULL
	DROP VIEW dbo.ts_firmora
GO

CREATE VIEW ts_firmora
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo,
      ofi,
      cargo,
      funcionario,
      carta) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_int01,
	cr_tran_servicio.ts_int02,
  	cr_tran_servicio.ts_descripcion01,
	cr_tran_servicio.ts_int03,
	cr_tran_servicio.ts_int04
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22234 )

GO

IF OBJECT_ID ('dbo.ts_filtros') IS NOT NULL
	DROP VIEW dbo.ts_filtros
GO

CREATE VIEW ts_filtros  (
  secuencial,   	tipo_transaccion,   	clase,
  fecha,   		    usuario,   				terminal,
  oficina,   		tabla,   				lsrv,
  srv,   			filtro,      			descripcion,
  tipo_persona,		etapa) AS
  SELECT cr_tran_servicio.ts_secuencial,
         cr_tran_servicio.ts_tipo_transaccion,
         cr_tran_servicio.ts_clase,
         cr_tran_servicio.ts_fecha,
         cr_tran_servicio.ts_usuario,
         cr_tran_servicio.ts_terminal,
         cr_tran_servicio.ts_oficina,
         cr_tran_servicio.ts_tabla,
         cr_tran_servicio.ts_lsrv,
         cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_int01,
         cr_tran_servicio.ts_descripcion01,
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_int02
  FROM cr_tran_servicio 
  WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22256) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22257) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22258)

GO

IF OBJECT_ID ('dbo.ts_ficha') IS NOT NULL
	DROP VIEW dbo.ts_ficha
GO

CREATE VIEW ts_ficha
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tipo,
      cliente,
      numero,
      fecha_crea) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv, 
  	cr_tran_servicio.ts_char129,   
        cr_tran_servicio.ts_int11,   
	cr_tran_servicio.ts_int12,     
	cr_tran_servicio.ts_fecha12
FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21616)

GO

IF OBJECT_ID ('dbo.ts_facturas') IS NOT NULL
	DROP VIEW dbo.ts_facturas
GO

CREATE VIEW ts_facturas
    ( secuencial,
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      grupo,    
      valor,      
      moneda,      
      fecini_neg,
      fecfin_neg, 
      usada,
      dividendo,
      referencia,
      porcentaje,
      num_negocio,
      proveedor,
      fecha_bl,  
      fecha_dex,
      con_respon,
      tram_prov, 
      div_hijo,  
      colchon_re  
      ) AS   
          SELECT cr_tran_servicio.ts_secuencial, 
        	 cr_tran_servicio.ts_tipo_transaccion, 
        	 cr_tran_servicio.ts_clase, 
        	 cr_tran_servicio.ts_fecha,
        	 cr_tran_servicio.ts_usuario, 
        	 cr_tran_servicio.ts_terminal, 
        	 cr_tran_servicio.ts_oficina, 
        	 cr_tran_servicio.ts_tabla, 
        	 cr_tran_servicio.ts_lsrv, 
        	 cr_tran_servicio.ts_srv,
          	 cr_tran_servicio.ts_int01,   
                 cr_tran_servicio.ts_int02,
                 cr_tran_servicio.ts_money01,
        	 cr_tran_servicio.ts_tinyint01,
                 cr_tran_servicio.ts_fecha01,
                 cr_tran_servicio.ts_fecha02,
        	 cr_tran_servicio.ts_char101,
                 cr_tran_servicio.ts_smallint01,
                 cr_tran_servicio.ts_vchar2401,   
                 cr_tran_servicio.ts_money02,
                 cr_tran_servicio.ts_vchar6401,
        	 cr_tran_servicio.ts_int03,
                 cr_tran_servicio.ts_fecha03,
                 cr_tran_servicio.ts_fecha04,
        	 cr_tran_servicio.ts_char102,
                 cr_tran_servicio.ts_int04,
                 cr_tran_servicio.ts_smallint02,
                 cr_tran_servicio.ts_money03
            FROM cr_tran_servicio  
           WHERE (cr_tran_servicio.ts_tipo_transaccion = 21997 
		 )

GO

IF OBJECT_ID ('dbo.ts_extraccion_xml_det') IS NOT NULL
	DROP VIEW dbo.ts_extraccion_xml_det
GO

CREATE view ts_extraccion_xml_det (
  secuencial,       tipo_transaccion,       clase,          fecha,          usuario,       terminal,          
  oficina,          tabla,                  lsrv,           srv,            codigo,        estado,
  tipo_dato,        valor,                  mostrar,        fecha_ing
)AS
select
 ts_secuencial,     ts_tipo_transaccion,    ts_clase,       ts_fecha,       ts_usuario,    ts_terminal,     
 ts_oficina,        ts_tabla,               ts_lsrv,        ts_srv,         ts_int01,      ts_catalogo01, 
 ts_catalogo02,     ts_texto,               ts_char101,     ts_fecha02
FROM cr_tran_servicio  
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22289 ) OR                                                                 
      ( cr_tran_servicio.ts_tipo_transaccion = 22290 ) OR                                                                 
      ( cr_tran_servicio.ts_tipo_transaccion = 22291 )

GO

IF OBJECT_ID ('dbo.ts_extraccion_xml') IS NOT NULL
	DROP VIEW dbo.ts_extraccion_xml
GO

CREATE view ts_extraccion_xml (
  secuencial,       tipo_transaccion,       clase,          fecha,          usuario,     terminal,          
  oficina,          tabla,                  lsrv,           srv,            codigo,      funcionalidad,
  tipo_consulta,    mostrar,                validacion,     condicion,      nodo,        filtro,
  consulta,         usuario1,               fecha_mod,      fecha_ing
)AS
select
 ts_secuencial,     ts_tipo_transaccion,    ts_clase,       ts_fecha,       ts_usuario,  ts_terminal,     
 ts_oficina,        ts_tabla,               ts_lsrv,        ts_srv,         ts_int01,    ts_smallint01,
 ts_catalogo01,     ts_char101,             ts_smallint02,  ts_tinyint01,   ts_texto,    ts_texto2,
 ts_texto3,         ts_login01,             ts_fecha01,     ts_fecha02
FROM cr_tran_servicio  
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22285 ) OR                                                                 
      ( cr_tran_servicio.ts_tipo_transaccion = 22286 ) OR                                                                 
      ( cr_tran_servicio.ts_tipo_transaccion = 22287 )
GO

IF OBJECT_ID ('dbo.ts_excepciones') IS NOT NULL
	DROP VIEW dbo.ts_excepciones
GO

CREATE VIEW ts_excepciones
    ( secuencial, 
      tipo_transaccion, 
      clase,
      cod_alterno, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,   
      numero,   
      codigo,   
      clase_ex,   
      texto,   
      fecha_tope,
      estado,   
      fecha_aprob,   
      login_aprob,   
      fecha_regula,   
      login_regula,   
      razon_regula,   
      fecha_reg,   
      login_reg,   
      garantia,
      accion,
      comite,
      acta ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_cod_alterno,
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_char101,   
         cr_tran_servicio.ts_texto,   
	 cr_tran_servicio.ts_fecha04,
         cr_tran_servicio.ts_char102,   
         cr_tran_servicio.ts_fecha02,   
         cr_tran_servicio.ts_login02,   
         cr_tran_servicio.ts_fecha03,   
         cr_tran_servicio.ts_login03,   
         cr_tran_servicio.ts_texto2,   
         cr_tran_servicio.ts_fecha01,   
         cr_tran_servicio.ts_login01,   
         cr_tran_servicio.ts_vchar6401,
	 cr_tran_servicio.ts_char103,
	 cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_cuenta01
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21015 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21115 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21215 )

GO

IF OBJECT_ID ('dbo.ts_etapa_estado') IS NOT NULL
	DROP VIEW dbo.ts_etapa_estado
GO

CREATE VIEW ts_etapa_estado
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      etapa,
      estado,
      defecto) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_catalogo34,
        cr_tran_servicio.ts_catalogo35,
        cr_tran_servicio.ts_char141
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21163) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21164) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21165)

GO

IF OBJECT_ID ('dbo.ts_etapa_estacion') IS NOT NULL
	DROP VIEW dbo.ts_etapa_estacion
GO

/*   ALTER VIEW ts_etapa_estacion   */
/************************************/
CREATE VIEW ts_etapa_estacion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      srv, 
      lsrv,
      etapa,
      estacion,		--SBU 19/ene/2002
      modifica,
      estado,
      ejecutivo,
      estacion_sus,
      fabrica) AS   --Req173.F3
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_tinyint01,   
  	 cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_char101,
	 cr_tran_servicio.ts_char102,
	 cr_tran_servicio.ts_char103,
	 cr_tran_servicio.ts_smallint02,
	 cr_tran_servicio.ts_char104  --Req173.F3
   FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21002 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21102 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21202 )

GO

IF OBJECT_ID ('dbo.ts_etapa') IS NOT NULL
	DROP VIEW dbo.ts_etapa
GO

CREATE VIEW ts_etapa
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      etapa,
      descripcion,   
      tipo,
      asignacion,
      tipo_asignacion
) 
AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint01,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_vchar4001,
         cr_tran_servicio.ts_char105
    FROM cr_tran_servicio 
 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21001 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21101 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21201 )

GO

IF OBJECT_ID ('dbo.ts_estado_his') IS NOT NULL
	DROP VIEW dbo.ts_estado_his
GO

CREATE VIEW ts_estado_his
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      cobranza,
      estado,
      abogado,
      fecha_asignacion) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_vchar4002,
        cr_tran_servicio.ts_catalogo31,
        cr_tran_servicio.ts_catalogo32,
        cr_tran_servicio.ts_fecha16
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21159) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21160) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21161)

GO

IF OBJECT_ID ('dbo.ts_estado_dias') IS NOT NULL
	DROP VIEW dbo.ts_estado_dias
GO

CREATE VIEW ts_estado_dias
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv,
      srv, 
      estado,   
      dias_vto,
      tipo_banca ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
	 cr_tran_servicio.ts_catalogo01,
	 cr_tran_servicio.ts_int01,
         cr_tran_servicio.ts_catalogo22
   FROM  cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21963 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21192 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21193 )

GO

IF OBJECT_ID ('dbo.ts_estacion') IS NOT NULL
	DROP VIEW dbo.ts_estacion
GO

CREATE VIEW ts_estacion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv,
      srv, 
      estacion,   
      descripcion,   
      ofic,   
      funcionario,  
      carga,
      tipo,
      comite,
      estacion_sup,
      tope,
      nivel  ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_descripcion01,   
         cr_tran_servicio.ts_smallint02,   
         cr_tran_servicio.ts_login01,   
         cr_tran_servicio.ts_tinyint01,
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_vchar4001,
         cr_tran_servicio.ts_smallint03,
         cr_tran_servicio.ts_char102,
	 cr_tran_servicio.ts_catalogo01
   FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21003 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21103 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21203 )

GO

IF OBJECT_ID ('dbo.ts_especifica_tramite') IS NOT NULL
	DROP VIEW dbo.ts_especifica_tramite
GO

create view ts_especifica_tramite 
(     secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      sujeto_credito, 
      especificacion, 
      tramite, 
      tipo_dato, 
      valor) AS   
select ts_secuencial, 
      ts_tipo_transaccion, 
      ts_clase, 
      ts_fecha, 
      ts_usuario, 
      ts_terminal, 
      ts_oficina, 
      ts_tabla, 
      ts_lsrv, 
      ts_srv,
      ts_catalogo01,
      ts_vchar1001,
       ts_int01,
      ts_char101,
      ts_texto
   FROM cob_credito..cr_tran_servicio 
   WHERE  ts_tipo_transaccion in (21540, 21541)

GO

IF OBJECT_ID ('dbo.ts_especifica_sujcred') IS NOT NULL
	DROP VIEW dbo.ts_especifica_sujcred
GO

create view ts_especifica_sujcred
(     secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      sujeto_credito, 
      especificacion, 
      descripcion, 
      tipo_dato, 
      catalogo, 
      obligatorio,
      estado )
AS   
select ts_secuencial, 
      ts_tipo_transaccion, 
      ts_clase, 
      ts_fecha, 
      ts_usuario, 
      ts_terminal, 
      ts_oficina, 
      ts_tabla, 
      ts_lsrv, 
      ts_srv,
      ts_catalogo01,
      ts_vchar1001,
      ts_descripcion01,
      ts_char101,
      ts_vchar4001,
      ts_char102,
      ts_catalogo02
   FROM cob_credito..cr_tran_servicio 
   WHERE  cr_tran_servicio.ts_tipo_transaccion in (21534, 21535, 21536)

GO

IF OBJECT_ID ('dbo.ts_enfermedades') IS NOT NULL
	DROP VIEW dbo.ts_enfermedades
GO

create view ts_enfermedades(
en_secuencial_ts,       en_cod_alterno_ts,      en_tipo_transaccion_ts,
en_clase_ts,            en_fecha_ts,            en_usuario_ts,
en_terminal_ts,         en_oficina_ts,          en_tabla_ts,
en_fecha_real_ts,
en_microseg,            en_asegurado,           en_enfermedad) as
select
ts_secuencial,          ts_cod_alterno,         ts_tipo_transaccion,
ts_clase,               ts_fecha,               ts_usuario,
ts_terminal,            ts_oficina,             ts_tabla,
ts_fecha_real,
ts_int01,               ts_int02,               ts_catalogo01
from   cr_tran_servicio
where  ts_tipo_transaccion = 22108
and    ts_cod_alterno = 3

GO

IF OBJECT_ID ('dbo.ts_documento') IS NOT NULL
	DROP VIEW dbo.ts_documento
GO

CREATE VIEW ts_documento 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      documento,	
      numero,
      fecha_impresion,
      usuario_doc ) AS
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_smallint01,     
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_fecha01,
	cr_tran_servicio.ts_login01
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21034 )

GO

IF OBJECT_ID ('dbo.ts_distribucion_desembolso') IS NOT NULL
	DROP VIEW dbo.ts_distribucion_desembolso
GO

CREATE VIEW ts_distribucion_desembolso
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      toperacion,
      fecha_des,
      secuencial_des,
      monto,
      porcentaje,
      tipoplazo,
      plazo,
      numdes,
      estado) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_catalogo01,
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_int02,
        cr_tran_servicio.ts_money01,
        cr_tran_servicio.ts_money02,
        cr_tran_servicio.ts_catalogo02,
        cr_tran_servicio.ts_smallint01,
        cr_tran_servicio.ts_smallint02,
        cr_tran_servicio.ts_char101
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21551) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21552) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21553) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21554) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21555)

GO

IF OBJECT_ID ('dbo.ts_deudores') IS NOT NULL
	DROP VIEW dbo.ts_deudores
GO

CREATE VIEW ts_deudores
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,   
      cliente,   
      rol,
      cobro_cen ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
     cr_tran_servicio.ts_int02,
	 cr_tran_servicio.ts_catalogo01,
     cr_tran_servicio.ts_char106
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21013 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21113 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21213 )

GO

IF OBJECT_ID ('dbo.ts_destino_tramite') IS NOT NULL
	DROP VIEW dbo.ts_destino_tramite
GO

CREATE VIEW ts_destino_tramite
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      cliente,
      destino,
      valor,
      rol,
      unidad,
      costo,
      porcentaje) AS

SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_int02,
        cr_tran_servicio.ts_vchar1005,
        cr_tran_servicio.ts_money32,
        cr_tran_servicio.ts_char142,
        cr_tran_servicio.ts_int03,
        cr_tran_servicio.ts_money33,
    	cr_tran_servicio.ts_float01


FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21020) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21120) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21220)

GO

IF OBJECT_ID ('dbo.ts_destino_economico') IS NOT NULL
	DROP VIEW dbo.ts_destino_economico
GO

CREATE VIEW ts_destino_economico
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      codigo_inversion,
      descripcion,
      ciclo_cultivo,
      unidades_produccion,
      valor_financiacion,
      porcentaje_maximo,
      plazo_maximo,
      clase_cartera,
      finagro,
      incentivo,unidades) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_vchar1004,
        cr_tran_servicio.ts_descripcion05,
        cr_tran_servicio.ts_catalogo29,
        cr_tran_servicio.ts_catalogo30,
        cr_tran_servicio.ts_money31,
        cr_tran_servicio.ts_float12,
        cr_tran_servicio.ts_smallint14,
        cr_tran_servicio.ts_catalogo40,
        cr_tran_servicio.ts_char101,
        ts_char102,
	ts_char103
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21155) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21156) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21157)

GO

IF OBJECT_ID ('dbo.ts_desembolso') IS NOT NULL
	DROP VIEW dbo.ts_desembolso
GO

CREATE VIEW ts_desembolso
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      num_operacion,
      monto,
      fecha_des,
      estado) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_int02,
        cr_tran_servicio.ts_money01,
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_char201
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21683) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21684) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21685)

GO

IF OBJECT_ID ('dbo.ts_def_variables_filtros') IS NOT NULL
	DROP VIEW dbo.ts_def_variables_filtros
GO

CREATE VIEW ts_def_variables_filtros  (
  secuencial,   	tipo_transaccion,   	clase,
  fecha,   		    usuario,   				terminal,
  oficina,   		tabla,   				lsrv,
  srv,   			variable,   			descripcion,
  programa,   		tipo_var,   			tipo_dato,
  estado) AS
  SELECT cr_tran_servicio.ts_secuencial,
         cr_tran_servicio.ts_tipo_transaccion,
         cr_tran_servicio.ts_clase,
         cr_tran_servicio.ts_fecha,
         cr_tran_servicio.ts_usuario,
         cr_tran_servicio.ts_terminal,
         cr_tran_servicio.ts_oficina,
         cr_tran_servicio.ts_tabla,
         cr_tran_servicio.ts_lsrv,
         cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_int01,
         cr_tran_servicio.ts_descripcion01,
         cr_tran_servicio.ts_descripcion02,
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_catalogo02       
  FROM cr_tran_servicio 
  WHERE ( cr_tran_servicio.ts_tipo_transaccion = 22249) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22250) OR
        ( cr_tran_servicio.ts_tipo_transaccion = 22251)

GO

IF OBJECT_ID ('dbo.ts_def_variables') IS NOT NULL
	DROP VIEW dbo.ts_def_variables
GO

create view ts_def_variables (
   secuencial,       tipo_transaccion,       clase, 
   fecha,            usuario,                terminal, 
   oficina,          tabla,                  lsrv, 
   srv,              variable,               descripcion,
   programa,         sp_ayuda,               tipo,
   uso,              banca) 
as   
select 
   ts_secuencial,    ts_tipo_transaccion,    ts_clase, 
   ts_fecha,         ts_usuario,             ts_terminal, 
   ts_oficina,       ts_tabla,               ts_lsrv, 
   ts_srv,           ts_tinyint01,           ts_descripcion01,
   ts_vchar4001,     ts_vchar4002,           ts_char101,
   ts_char102,       ts_catalogo01   
  from cr_tran_servicio 
 where ts_tipo_transaccion = 21907 
    or ts_tipo_transaccion = 21908 
    or ts_tipo_transaccion = 21909 

GO

IF OBJECT_ID ('dbo.ts_datos_tramites') IS NOT NULL
	DROP VIEW dbo.ts_datos_tramites
GO

CREATE VIEW ts_datos_tramites 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      toperacion,	
      producto,
      dato,
      valor ) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_catalogo01,     
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_texto
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21032 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21232 )

GO

IF OBJECT_ID ('dbo.ts_dato_toperacion') IS NOT NULL
	DROP VIEW dbo.ts_dato_toperacion
GO

CREATE VIEW ts_dato_toperacion 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      toperacion,
      producto,	
      dato,
      descripcion,
      tipo_dato,
      mandatorio,
      tabla_catalogo) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_catalogo01,   
	cr_tran_servicio.ts_catalogo02,     
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_descripcion01,
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_char144,
	cr_tran_servicio.ts_char401
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21031 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21131 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21231 )

GO

IF OBJECT_ID ('dbo.ts_cr_tarifa_honorarios_FAG') IS NOT NULL
	DROP VIEW dbo.ts_cr_tarifa_honorarios_FAG
GO

CREATE VIEW ts_cr_tarifa_honorarios_FAG
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      monto_desde_FAG,
      monto_hasta_FAG,
      maximo_FAG) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_money36,
        cr_tran_servicio.ts_money37,
        cr_tran_servicio.ts_float15
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21174) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21175) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21176) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21177) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21178) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21179) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21180)

GO

IF OBJECT_ID ('dbo.ts_cr_tarifa_honorarios') IS NOT NULL
	DROP VIEW dbo.ts_cr_tarifa_honorarios
GO

CREATE VIEW ts_cr_tarifa_honorarios
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      monto_desde,
      monto_hasta,
      tarifa,
      maximo,
      etapa,
      subetapa) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
          cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_money33,
        cr_tran_servicio.ts_money34,
        cr_tran_servicio.ts_float14,
        cr_tran_servicio.ts_money35,
        cr_tran_servicio.ts_char303,
	cr_tran_servicio.ts_char304
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21167) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21168) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21169) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21170) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21171) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21172) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21173) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21175)

GO

IF OBJECT_ID ('dbo.ts_cr_ctrl_cupo_asoc') IS NOT NULL
	DROP VIEW dbo.ts_cr_ctrl_cupo_asoc
GO

CREATE VIEW ts_cr_ctrl_cupo_asoc
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      num_cupo,
      secuencial_cupo,
      porcentaje,
      plazo,
      acta,
      fecha_desembolso,
      estado) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int17,
        cr_tran_servicio.ts_int18,
        cr_tran_servicio.ts_float13,
        cr_tran_servicio.ts_int19,
        cr_tran_servicio.ts_vchar2401,
	cr_tran_servicio.ts_fecha16,
	cr_tran_servicio.ts_catalogo36
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21020) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21120) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21220)

GO

IF OBJECT_ID ('dbo.ts_cr_costos_produccion') IS NOT NULL
	DROP VIEW dbo.ts_cr_costos_produccion
GO

CREATE VIEW ts_cr_costos_produccion
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      actividad,
      departamento,
      tipo_costo,
      inversion,
      unidad,
      cantidad,
      presio_unidad,
      porc_part,
      total,
      observacion) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_catalogo40,
        cr_tran_servicio.ts_catalogo39,
        cr_tran_servicio.ts_catalogo38,
        cr_tran_servicio.ts_catalogo37,
        cr_tran_servicio.ts_catalogo36,
        cr_tran_servicio.ts_int23,
        cr_tran_servicio.ts_money36,
        cr_tran_servicio.ts_float15,
        cr_tran_servicio.ts_money37,
	cr_tran_servicio.ts_texto4
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21767) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21768) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21769) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21770)

GO

IF OBJECT_ID ('dbo.ts_cotizacion') IS NOT NULL
	DROP VIEW dbo.ts_cotizacion
GO

CREATE VIEW ts_cotizacion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      moneda,
      fecha_cot,
      valor,
      fecha_modif,
      usuario_modif) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_tinyint01,
	cr_tran_servicio.ts_fecha01,
	cr_tran_servicio.ts_money01,
	cr_tran_servicio.ts_fecha02,
	cr_tran_servicio.ts_login01
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21076 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21176 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21276 )

GO

IF OBJECT_ID ('dbo.ts_costos') IS NOT NULL
	DROP VIEW dbo.ts_costos
GO

CREATE VIEW ts_costos
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      costo,
      cobranza,
      codigo,
      valor,
      moneda,
      fecha_registro,
      fecha_confirmacion,
      usuario_confirmacion,
      valor_pagado,
      fecha_pago) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
	cr_tran_servicio.ts_char301,     
        cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_money01,
        cr_tran_servicio.ts_tinyint01,
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_fecha02,
        cr_tran_servicio.ts_login01,
        cr_tran_servicio.ts_money02,
        cr_tran_servicio.ts_fecha03
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21071 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21206 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21194 )

GO

IF OBJECT_ID ('dbo.ts_corresp_sib') IS NOT NULL
	DROP VIEW dbo.ts_corresp_sib
GO

CREATE VIEW ts_corresp_sib
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      codigo,
      tabla_sib,        
      codigo_sib,
      descripcion_sib,
      limite_inf,
      limite_sup,    
      monto_inf,    
      monto_sup     
      ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_catalogo01,   
         cr_tran_servicio.ts_vchar2401,
         cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_texto,
         cr_tran_servicio.ts_int01,
         cr_tran_servicio.ts_int02,
	 cr_tran_servicio.ts_money01,
         cr_tran_servicio.ts_money02
    FROM cr_tran_servicio  
   WHERE (cr_tran_servicio.ts_tipo_transaccion = 21025 
       or cr_tran_servicio.ts_tipo_transaccion = 21027
       or cr_tran_servicio.ts_tipo_transaccion = 21035)

GO

IF OBJECT_ID ('dbo.ts_condicion_linea') IS NOT NULL
	DROP VIEW dbo.ts_condicion_linea
GO

CREATE VIEW ts_condicion_linea
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      numero,
      fecha_ob,
      usuario_ob,
      lineas) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_smallint01,   
         cr_tran_servicio.ts_fecha01,      
         cr_tran_servicio.ts_login01,   
         cr_tran_servicio.ts_smallint03
    FROM cr_tran_servicio  
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21085 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21186 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21087 )

GO

IF OBJECT_ID ('dbo.ts_condicion') IS NOT NULL
	DROP VIEW dbo.ts_condicion
GO

CREATE VIEW ts_condicion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      atribucion,
      etapa,
      estacion,
      condicion,
      operador,
      variable,
      valor ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint01,
  	 cr_tran_servicio.ts_tinyint02,
    	 cr_tran_servicio.ts_smallint01,
  	 cr_tran_servicio.ts_tinyint03,
    	 cr_tran_servicio.ts_char201,
  	 cr_tran_servicio.ts_tinyint04,
         cr_tran_servicio.ts_vchar4001
    FROM cr_tran_servicio 
 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21081 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21181 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21281 )

GO

IF OBJECT_ID ('dbo.ts_concordato') IS NOT NULL
	DROP VIEW dbo.ts_concordato
GO

CREATE VIEW ts_concordato
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cliente,
      situacion,
      estado,   
      fecha_ini,      
      fecha_fin,
      cumplimiento,
      situacion_ant,
      fecha_modif,
      acta_cas, 
      fecha_cas,    
      causal   
      ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_int01,   
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_catalogo02,
	 cr_tran_servicio.ts_fecha01,
         cr_tran_servicio.ts_fecha02,
         cr_tran_servicio.ts_char101,
	 cr_tran_servicio.ts_catalogo03,
         cr_tran_servicio.ts_fecha03,
         cr_tran_servicio.ts_catalogo04,
	 cr_tran_servicio.ts_fecha04,
         cr_tran_servicio.ts_catalogo05
    FROM cr_tran_servicio  
   WHERE (cr_tran_servicio.ts_tipo_transaccion = 21966)

GO

IF OBJECT_ID ('dbo.ts_conclusiones') IS NOT NULL
	DROP VIEW dbo.ts_conclusiones
GO

CREATE VIEW ts_conclusiones
    ( secuencial, 
      alterno,
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      oficial,
      ente,
      visita,
      linea,
      texto) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_cod_alterno,
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
	cr_tran_servicio.ts_int01,     
        cr_tran_servicio.ts_int02,   
        cr_tran_servicio.ts_smallint02,   
        cr_tran_servicio.ts_texto   
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21042 )

GO

IF OBJECT_ID ('dbo.ts_comision') IS NOT NULL
	DROP VIEW dbo.ts_comision
GO

CREATE VIEW ts_comision
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tipo_cobrador, 
      porc_min_recu, 
      porc_max_recu,
      comision)
 AS   
 SELECT  cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_char302,
        cr_tran_servicio.ts_float07,   
	cr_tran_servicio.ts_float08,
        cr_tran_servicio.ts_money17
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21078 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21079 ) OR 
         ( cr_tran_servicio.ts_tipo_transaccion = 21082 )

GO

IF OBJECT_ID ('dbo.ts_comentarios') IS NOT NULL
	DROP VIEW dbo.ts_comentarios
GO

CREATE VIEW ts_comentarios
    ( secuencial, 
      alterno,
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      oficial,
      ente,
      visita,
      linea,
      texto) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_cod_alterno,
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
	cr_tran_servicio.ts_int01,     
        cr_tran_servicio.ts_int02,   
        cr_tran_servicio.ts_smallint02,   
        cr_tran_servicio.ts_texto   
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21042 )

GO

IF OBJECT_ID ('dbo.ts_cobranza') IS NOT NULL
	DROP VIEW dbo.ts_cobranza
GO

CREATE VIEW ts_cobranza
	( secuencial, 
	alterno,
	tipo_transaccion, 
	clase, 
	fecha,
	usuario, 
	terminal, 
	oficina,
	tabla,
	lsrv, 
	srv,
	cobranza,
	cliente,
	estado,
	proceso,
	etapa,
	ab_interno,
	fecha_ab_interno,
	abogado,
	fecha_abogado,
	fecha_documentos,
	fecha_demanda,
	juzgado,
	num_juicio,
	informe,
	fecha_ingr,
	usuario_ingr,
	fecha_mod,
	usuario_mod,
	cob_externo,
	fecha_cobext,observa) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_cod_alterno, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_char301,   
	cr_tran_servicio.ts_int02,     
	cr_tran_servicio.ts_catalogo01,   
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_login01,
	cr_tran_servicio.ts_fecha01,
	cr_tran_servicio.ts_catalogo04,
	cr_tran_servicio.ts_fecha02,
	cr_tran_servicio.ts_fecha03,
	cr_tran_servicio.ts_fecha04,
	cr_tran_servicio.ts_catalogo05,
	cr_tran_servicio.ts_cuenta01,
	cr_tran_servicio.ts_smallint01,
	cr_tran_servicio.ts_fecha05,
	cr_tran_servicio.ts_login02,
	cr_tran_servicio.ts_fecha06,
	cr_tran_servicio.ts_login03,
	cr_tran_servicio.ts_login04,
	cr_tran_servicio.ts_fecha11,
    cr_tran_servicio.ts_texto
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21067 ) or
	 ( cr_tran_servicio.ts_tipo_transaccion = 21167 ) or
	 ( cr_tran_servicio.ts_tipo_transaccion = 21075 ) or
	 ( cr_tran_servicio.ts_tipo_transaccion = 21061 )

GO

IF OBJECT_ID ('dbo.ts_cliente_campana') IS NOT NULL
	DROP VIEW dbo.ts_cliente_campana
GO

create view ts_cliente_campana
as select  
ts_secuencial as secuencial, ts_tipo_transaccion as tipo_transaccion, 
ts_clase      as clase     , ts_fecha            as fecha, 
ts_usuario    as usuario   , ts_terminal         as terminal, 
ts_oficina    as oficina   , ts_tabla            as tabla,
ts_lsrv       as lsrv      , ts_srv              as srv,  
ts_int01      as cliente   , ts_int02            as campana,
ts_catalogo01 as tipo_pref , ts_fecha01          as fecha_ing,
ts_int03      as ofi_asigna, ts_char101          as estado,
ts_int04      as tramite   , ts_char102          as acepta_contraof,
ts_char103    as encuesta  , ts_fecha02          as fecha_ini,
ts_fecha03    as fecha_fin , ts_login01          as asignado_a,
ts_login02    as asignado_por                   
from cr_tran_servicio 
where ts_tipo_transaccion = 22889                                 


GO

IF OBJECT_ID ('dbo.ts_cau_tramite') IS NOT NULL
	DROP VIEW dbo.ts_cau_tramite
GO

CREATE VIEW ts_cau_tramite   
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      etapa,
      requisito) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int23,
        cr_tran_servicio.ts_tinyint12,
        cr_tran_servicio.ts_catalogo40
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21750) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21751) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21752) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21753) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21754)

GO

IF OBJECT_ID ('dbo.ts_cau_etapa') IS NOT NULL
	DROP VIEW dbo.ts_cau_etapa
GO

CREATE VIEW ts_cau_etapa  
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      etapa,
      tipo_tramite,
      causal,
      tipo) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_tinyint11,
        cr_tran_servicio.ts_char144,
        cr_tran_servicio.ts_catalogo38,
        cr_tran_servicio.ts_catalogo39
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21750) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21751) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21752) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21753) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21754)

GO

IF OBJECT_ID ('dbo.ts_categoria_comentario') IS NOT NULL
	DROP VIEW dbo.ts_categoria_comentario
GO

create view ts_categoria_comentario
(
secuencial,
tipo_transaccion,
clase,
fecha,
usuario,
terminal,
oficina,
tabla,
lsrv,
srv,
categoria,
tipo_dato,
catalogo,
obligatorio)
as
select ts_secuencial,
ts_tipo_transaccion,
ts_clase,
ts_fecha,
ts_usuario,
ts_terminal,
ts_oficina,
ts_tabla,
ts_lsrv,
ts_srv,
ts_catalogo01,
ts_char101,
ts_vchar4001,
ts_char102
from cob_credito..cr_tran_servicio
where ts_tipo_transaccion in (21459, 21460, 21462, 21463)

GO

IF OBJECT_ID ('dbo.ts_campana') IS NOT NULL
	DROP VIEW dbo.ts_campana
GO

CREATE view ts_campana
as 
select     ts_secuencial        as secuencial, 
           ts_tipo_transaccion  as tipo_transaccion, 
           ts_clase             as clase, 
           ts_fecha             as fecha_sistema, 
           ts_usuario           as usuario, 
           ts_terminal          as terminal, 
           ts_oficina           as oficina, 
           ts_tabla             as tabla, 
           ts_int01             as codigo_camp, 
           ts_texto             as nombre_camp, 
           ts_texto2            as descripcion_camp, 
           ts_catalogo01        as modalidad, 
           ts_catalogo02        as clientesc, 
           ts_char101           as estado, 
           ts_fecha01           as fecha_vig_ini, 
           ts_fecha02           as fecha_vig_fin, 
           ts_texto3            as detalle, 
           ts_int20             as dias_vigencia, 
           ts_catalogo03        as tipo_campana, 
           ts_int21             as altura_mora, 
           ts_fecha_real        as fecha_real
from         dbo.cr_tran_servicio
where     (ts_tipo_transaccion = 22246)


GO

IF OBJECT_ID ('dbo.ts_calificaciones_op') IS NOT NULL
	DROP VIEW dbo.ts_calificaciones_op
GO

create view ts_calificaciones_op( 
   secuencial, 
   tipo_transaccion, 
   clase, 
   fecha,
   usuario, 
   terminal, 
   oficina,
   tabla,
   lsrv, 
   srv,
   operacion,
   producto,
   tcalificacion,
   calif,
   usuario_cl,
   fecha_cl)
as
select 
   cr_tran_servicio.ts_secuencial, 
   cr_tran_servicio.ts_tipo_transaccion, 
   cr_tran_servicio.ts_clase, 
   cr_tran_servicio.ts_fecha,
   cr_tran_servicio.ts_usuario, 
   cr_tran_servicio.ts_terminal, 
   cr_tran_servicio.ts_oficina, 
   cr_tran_servicio.ts_tabla, 
   cr_tran_servicio.ts_lsrv, 
   cr_tran_servicio.ts_srv, 
   cr_tran_servicio.ts_int16,   
   cr_tran_servicio.ts_tinyint10,
   cr_tran_servicio.ts_vchar1003,
   cr_tran_servicio.ts_char140,
   cr_tran_servicio.ts_login06,
   cr_tran_servicio.ts_fecha16
from cr_tran_servicio 
where cr_tran_servicio.ts_tipo_transaccion = 21199

GO

IF OBJECT_ID ('dbo.ts_calificaciones_cl') IS NOT NULL
	DROP VIEW dbo.ts_calificaciones_cl
GO

CREATE VIEW ts_calificaciones_cl
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cod_cliente,
      tcalificacion,
      calif,
      clase_cl,
      usuario_cl,
      fecha_cl,
      observacion) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv, 
  	cr_tran_servicio.ts_int14,   
        cr_tran_servicio.ts_vchar1001,
        cr_tran_servicio.ts_char133,
        cr_tran_servicio.ts_catalogo27,
        cr_tran_servicio.ts_login05,
        cr_tran_servicio.ts_fecha14,
	cr_tran_servicio.ts_texto
FROM cr_tran_servicio 
   WHERE cr_tran_servicio.ts_tipo_transaccion = 21012

GO

IF OBJECT_ID ('dbo.ts_calificacion_op') IS NOT NULL
	DROP VIEW dbo.ts_calificacion_op
GO

CREATE VIEW ts_calificacion_op
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      producto,
      toperacion,
      moneda,
      cod_cliente,
      operacion,
      num_op_banco,
      clase_cl,
      tgarantia,
      cobertura,
      oficina_cl,
      calif_ant,
      mes_vto,
      calif_sug,
      calif_final,
      saldo_cap,
      saldo_int,     
      saldo_ctasxcob,
      xprov_cap,     
      xprov_int,     
      xprov_ctasxcob,
      prov_cap,      
      prov_int,      
      prov_ctasxcob, 
      prova_cap,     
      prova_int,     
      prova_ctasxcob,
      usuario_cl,    
      fecha_cl,      
      observacion,
      reproceso,  
      calificado, 
      oficina_ant,
      mes_vto_ant,
      procad,     
      gerente,    
      gerente_ant) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv, 
  	cr_tran_servicio.ts_tinyint09,   
        cr_tran_servicio.ts_catalogo28,
        cr_tran_servicio.ts_tinyint10,
        cr_tran_servicio.ts_int14,
        cr_tran_servicio.ts_int15,
        cr_tran_servicio.ts_vchar2401,
        cr_tran_servicio.ts_vchar1002,
        cr_tran_servicio.ts_vchar1003,
        cr_tran_servicio.ts_float09,
        cr_tran_servicio.ts_smallint10,
        cr_tran_servicio.ts_char134,
        cr_tran_servicio.ts_float10,
        cr_tran_servicio.ts_char135,
        cr_tran_servicio.ts_char136,
        cr_tran_servicio.ts_money19,
        cr_tran_servicio.ts_money20,
        cr_tran_servicio.ts_money21,
        cr_tran_servicio.ts_money22,
        cr_tran_servicio.ts_money23,
        cr_tran_servicio.ts_money24,
        cr_tran_servicio.ts_money25,
        cr_tran_servicio.ts_money26,
        cr_tran_servicio.ts_money27,
        cr_tran_servicio.ts_money28,
        cr_tran_servicio.ts_money29,
        cr_tran_servicio.ts_money30,
        cr_tran_servicio.ts_vchar1402,
        cr_tran_servicio.ts_fecha15,
        cr_tran_servicio.ts_descripcion04,
        cr_tran_servicio.ts_char137,
        cr_tran_servicio.ts_char138,
        cr_tran_servicio.ts_smallint11,
        cr_tran_servicio.ts_float11,
        cr_tran_servicio.ts_char139,
        cr_tran_servicio.ts_smallint12,
        cr_tran_servicio.ts_smallint13 
FROM cr_tran_servicio 
   WHERE cr_tran_servicio.ts_tipo_transaccion = 21803

GO

IF OBJECT_ID ('dbo.ts_calificacion_cl') IS NOT NULL
	DROP VIEW dbo.ts_calificacion_cl
GO

CREATE VIEW ts_calificacion_cl
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cod_cliente,
      id_cliente,
      calif_ant,
      calif_mayor,
      usuario_cl,
      fecha_cl,
      observacion) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv, 
  	cr_tran_servicio.ts_int13,   
        cr_tran_servicio.ts_vchar1301,
        cr_tran_servicio.ts_char131,
        cr_tran_servicio.ts_char132,
        cr_tran_servicio.ts_vchar1401,
        cr_tran_servicio.ts_fecha13,
        cr_tran_servicio.ts_texto4
FROM cr_tran_servicio 
   WHERE cr_tran_servicio.ts_tipo_transaccion = 21050

GO

IF OBJECT_ID ('dbo.ts_benefic_micro_aseg') IS NOT NULL
	DROP VIEW dbo.ts_benefic_micro_aseg
GO

create view ts_benefic_micro_aseg(
bm_secuencial_ts,       bm_cod_alterno_ts,      bm_tipo_transaccion_ts,
bm_clase_ts,            bm_fecha_ts,            bm_usuario_ts,
bm_terminal_ts,         bm_oficina_ts,          bm_tabla_ts,
bm_fecha_real_ts,
bm_microseg,            bm_asegurado,           bm_secuencial,
bm_tipo_iden,           bm_identificacion,      bm_nombre_comp,
bm_fecha_nac,           bm_genero,              bm_lugar_nac,
bm_estado_civ,          bm_ocupacion,           bm_parentesco,
bm_direccion,           bm_telefono,            bm_porcentaje) as
select
ts_secuencial,          ts_cod_alterno,         ts_tipo_transaccion,
ts_clase,               ts_fecha,               ts_usuario,
ts_terminal,            ts_oficina,             ts_tabla,
ts_fecha_real,
ts_int01,               ts_int02,               ts_int03,
ts_vchar1001,           ts_vchar4001,           ts_descripcion01,
ts_fecha01,             ts_vchar1002,           ts_int04,
ts_vchar1003,           ts_vchar1004,           ts_vchar1005,
ts_descripcion02,       ts_vchar4002,           ts_float01
from   cr_tran_servicio
where  ts_tipo_transaccion = 22108
and    ts_cod_alterno = 2


GO

IF OBJECT_ID ('dbo.ts_autorizacion_cobranza') IS NOT NULL
	DROP VIEW dbo.ts_autorizacion_cobranza
GO

CREATE VIEW ts_autorizacion_cobranza
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      estado,
      funcionario,
      autorizacion) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
         cr_tran_servicio.ts_catalogo01,
         cr_tran_servicio.ts_login01,
    	 cr_tran_servicio.ts_char101
   FROM  cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21961 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21189 ) OR
	 ( cr_tran_servicio.ts_tipo_transaccion = 21190 )

GO

IF OBJECT_ID ('dbo.ts_atribucion') IS NOT NULL
	DROP VIEW dbo.ts_atribucion
GO

CREATE VIEW ts_atribucion
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      atribucion,
      etapa,
      estacion,
      tipo,
      codigo ) AS   
  SELECT cr_tran_servicio.ts_secuencial, 
	 cr_tran_servicio.ts_tipo_transaccion, 
	 cr_tran_servicio.ts_clase, 
	 cr_tran_servicio.ts_fecha,
	 cr_tran_servicio.ts_usuario, 
	 cr_tran_servicio.ts_terminal, 
	 cr_tran_servicio.ts_oficina, 
	 cr_tran_servicio.ts_tabla, 
	 cr_tran_servicio.ts_lsrv, 
	 cr_tran_servicio.ts_srv,
  	 cr_tran_servicio.ts_tinyint01,
  	 cr_tran_servicio.ts_tinyint02,
    	 cr_tran_servicio.ts_smallint01,
    	 cr_tran_servicio.ts_char101,
         cr_tran_servicio.ts_catalogo01
    FROM cr_tran_servicio 
 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21080 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21180 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21280 )

GO

IF OBJECT_ID ('dbo.ts_aseg_microseguro') IS NOT NULL
	DROP VIEW dbo.ts_aseg_microseguro
GO

create view ts_aseg_microseguro(
am_secuencial_ts,       am_cod_alterno_ts,      am_tipo_transaccion_ts,
am_clase_ts,            am_fecha_ts,            am_usuario_ts,
am_terminal_ts,         am_oficina_ts,          am_tabla_ts,
am_fecha_real_ts,
am_microseg,            am_secuencial,          am_tipo_iden,
am_tipo_aseg,           am_lugar_exp,           am_identificacion,
am_nombre_comp,         am_fecha_exp,           am_fecha_nac,
am_genero,              am_lugar_nac,           am_estado_civ,
am_ocupacion,           am_parentesco,          am_direccion,
am_derecho_acrec,       am_plan,                am_valor_plan,
am_telefono,            am_observaciones,       am_principal) as
select
ts_secuencial,          ts_cod_alterno,         ts_tipo_transaccion,
ts_clase,               ts_fecha,               ts_usuario,
ts_terminal,            ts_oficina,             ts_tabla,
ts_fecha_real,
ts_int01,               ts_int02,               ts_vchar1001,
ts_vchar1002,           ts_int03,               ts_vchar4001,
ts_descripcion01,       ts_fecha01,             ts_fecha02,
ts_vchar1003,           ts_int04,               ts_vchar1004,
ts_vchar1005,           ts_vchar1301,           ts_descripcion02,
ts_char101,             ts_int05,               ts_money01,
ts_vchar4002,           ts_descripcion03,       ts_char102
from   cr_tran_servicio
where  ts_tipo_transaccion = 22108
and    ts_cod_alterno = 1



GO

IF OBJECT_ID ('dbo.ts_archivo_redescuento') IS NOT NULL
	DROP VIEW dbo.ts_archivo_redescuento
GO

CREATE VIEW ts_archivo_redescuento
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      tramite,
      operacion,
      fecha_envio,
      cliente,
      fecha_activos,
      pasivos,
      fecha_pasivos,
      num_desemb,
      tnum_desemb,
      com_fag,
      fag    

) AS
SELECT cr_tran_servicio.ts_secuencial,
        cr_tran_servicio.ts_tipo_transaccion,
        cr_tran_servicio.ts_clase,
        cr_tran_servicio.ts_fecha,
        cr_tran_servicio.ts_usuario,
        cr_tran_servicio.ts_terminal,
        cr_tran_servicio.ts_oficina,
        cr_tran_servicio.ts_tabla,
        cr_tran_servicio.ts_lsrv,
        cr_tran_servicio.ts_srv,
        cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_vchar2401,
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_int02,
        ts_fecha02,
        ts_money01,
        ts_fecha03,
        ts_int03,
        ts_int04,
        ts_char101,
        ts_char102
FROM cr_tran_servicio 
WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21778) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21779) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21780) OR
      ( cr_tran_servicio.ts_tipo_transaccion = 21781)

GO

IF OBJECT_ID ('dbo.ts_agenda') IS NOT NULL
	DROP VIEW dbo.ts_agenda
GO

CREATE VIEW [dbo].[ts_agenda]
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      oficial,
      ente,
      visita,
      fecha_desde,
      fecha_hasta,
      fecha_visita,
      fecha_conf,
      usuario_conf,
      categoria,
      planificador,
      tramite,
      fecha_proyecto,
      valor_visita ,
      op_operacion ,
      op_banco 	,
      en_ced_ruc ,	
      descripcion_negocio 	,
      dir_barrio_negocio 	,
      telef_negocio	,
      telef_valor_residencia	,
      fecha_solic_cancel 

) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_smallint01,   
    cr_tran_servicio.ts_int01,   
	cr_tran_servicio.ts_int02,     
	cr_tran_servicio.ts_fecha01,     
	cr_tran_servicio.ts_fecha02,   
	cr_tran_servicio.ts_fecha03,
    cr_tran_servicio.ts_fecha04,
	cr_tran_servicio.ts_login01,
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_catalogo40,
	cr_tran_servicio.ts_int23,
	cr_tran_servicio.ts_fecha16,
	cr_tran_servicio.ts_money37,
	cr_tran_servicio.ts_int03,
	cr_tran_servicio.ts_vchar1001,
	cr_tran_servicio.ts_vchar1002,
	cr_tran_servicio.ts_vchar1003,
	cr_tran_servicio.ts_vchar1004,
	cr_tran_servicio.ts_vchar1005,
	cr_tran_servicio.ts_vchar1301,
	cr_tran_servicio.ts_fecha04
      

FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21040 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21140 ) OR   
         ( cr_tran_servicio.ts_tipo_transaccion = 21240 ) OR
         ( cr_tran_servicio.ts_tipo_transaccion = 21042 )

GO

IF OBJECT_ID ('dbo.ts_acciones') IS NOT NULL
	DROP VIEW dbo.ts_acciones
GO

CREATE VIEW ts_acciones
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      cobranza,
      numero,  
      taccion,
      proceso,
      etapa,
      estado,
      descripcion, 
      fecha_acc,
      funcionario,
      fecha_rev,
      abogado) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
  	cr_tran_servicio.ts_char301,
	cr_tran_servicio.ts_int01,
        cr_tran_servicio.ts_catalogo01,   
        cr_tran_servicio.ts_catalogo02,   
        cr_tran_servicio.ts_catalogo03,   
        cr_tran_servicio.ts_catalogo21,   
        cr_tran_servicio.ts_texto,
        cr_tran_servicio.ts_fecha01,
        cr_tran_servicio.ts_login01,
        cr_tran_servicio.ts_fecha02,
        cr_tran_servicio.ts_login02
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21074 )

GO

IF OBJECT_ID ('dbo.ts_abogado') IS NOT NULL
	DROP VIEW dbo.ts_abogado
GO

CREATE VIEW ts_abogado
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      abogado,
      cliente,
      tipo,
      nombre,  
      direccion,
      ciudad,
      login,
      cuenta,
      tipo_cuenta,
      tarjeta,
      especialidad,
      clase_interno,
      calificacion,
      porcentaje) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
	cr_tran_servicio.ts_tipo_transaccion, 
	cr_tran_servicio.ts_clase, 
	cr_tran_servicio.ts_fecha,
	cr_tran_servicio.ts_usuario, 
	cr_tran_servicio.ts_terminal, 
	cr_tran_servicio.ts_oficina, 
	cr_tran_servicio.ts_tabla, 
	cr_tran_servicio.ts_lsrv, 
	cr_tran_servicio.ts_srv,
	cr_tran_servicio.ts_catalogo01,
	cr_tran_servicio.ts_int01,
	cr_tran_servicio.ts_char101,
	cr_tran_servicio.ts_descripcion01,     
	cr_tran_servicio.ts_texto,   
	cr_tran_servicio.ts_int02,
	cr_tran_servicio.ts_login01,
	cr_tran_servicio.ts_cuenta01,
	cr_tran_servicio.ts_char301,
	cr_tran_servicio.ts_vchar6401,
	cr_tran_servicio.ts_catalogo02,
	cr_tran_servicio.ts_catalogo03,
	cr_tran_servicio.ts_char102,
	cr_tran_servicio.ts_float01
   FROM cr_tran_servicio 
   WHERE  cr_tran_servicio.ts_tipo_transaccion = 21068 or 
	  cr_tran_servicio.ts_tipo_transaccion = 21168 or 
	  cr_tran_servicio.ts_tipo_transaccion = 21268

GO

IF OBJECT_ID ('dbo.igr_fng_masivo') IS NOT NULL
	DROP VIEW dbo.igr_fng_masivo
GO

create view igr_fng_masivo(
   fecha,                                                                                                                                                                                                                                  
   nit_inter,
   cod_sucur,      
   nomlar,         
   tipo_id,        
   num_id,         
   munic_deudor,   
   valor_monto,    
   cod_moneda,     
   desti_credito,  
   cod_prod_gar,   
   porcentaje,
   cod_ciiu,
   total_activos,
   modalidad_cartera,
   calif_riesgo
)
as
select  
       fm_fecha,
       fm_nit_inter,
       fm_cod_sucur,
       fm_nomlar,
       fm_tipo_id,
       fm_num_id ,
       fm_munic_deudor,
       fm_valor_monto,
       fm_cod_moneda,
       fm_desti_credito,
       fm_cod_prod_gar,
       fm_porcentaje,
       fm_cod_ciiu,
       fm_total_activos,
       fm_modalidad_cartera,
       fm_calif_riesgo
from  cob_credito..cr_fng_masivo
where fm_procesado = 'N'


GO

IF OBJECT_ID ('dbo.cr_vista_archger') IS NOT NULL
	DROP VIEW dbo.cr_vista_archger
GO

create view cr_vista_archger as select * from cob_credito..cr_rep_archger
GO

IF OBJECT_ID ('dbo.cr_tsadicmir') IS NOT NULL
	DROP VIEW dbo.cr_tsadicmir
GO

create view cr_tsadicmir (
     obligacion,    cedula,        activos,       patrimonio,
     ingresos,      gastfamilia,   tiemponeg,     nota
) as
select 
     da_banco,      da_cedula,     da_activos,    da_patromonio, 
     da_otrosingre, da_gastosfami, da_tiempo_neg, da_nota
from cr_adicmir_bcp71

GO

IF OBJECT_ID ('dbo.cr_tipo_seguro_vs') IS NOT NULL
	DROP VIEW dbo.cr_tipo_seguro_vs
GO

create view cr_tipo_seguro_vs as
select   se_tipo_seguro,    se_descripcion, se_estado
from     cr_tipo_seguro
where  se_fecha_modif is null
and       se_estado in ('V','C') 


GO

IF OBJECT_ID ('dbo.cr_plan_seguros_vs') IS NOT NULL
	DROP VIEW dbo.cr_plan_seguros_vs
GO

create view cr_plan_seguros_vs as
select   ps_codigo_plan,      ps_tipo_seguro, ps_descripcion,
               ps_valor_mensual,  ps_tasa_efa,       ps_estado,
               ps_fecha_ini,              ps_fecha_fin,      ps_plazo_cobertura_cre,
               ps_plazo_cobertura
from     cr_plan_seguros
where  ps_fecha_modif is null
and        ps_estado in ('V','C') 


GO

IF OBJECT_ID ('dbo.cr_otto04292005') IS NOT NULL
	DROP VIEW dbo.cr_otto04292005
GO

create view cr_otto04292005
as
select 
       do_numero_operacion,
       dc_nombre,
       dc_iden,
       cp_concepto,
       cp_saldo,
       cp_prov,
       cp_prova,
       do_calificacion,
       do_dias_vto_div,
       do_oficina
from cr_calificacion_provision,
     cr_dato_operacion,
     cr_dato_cliente
where do_codigo_producto  = cp_producto
  and do_numero_operacion = cp_operacion
and cp_producto = 48
and do_tipo_reg = 'M'
and do_numero_operacion > 0
and do_codigo_producto = 48
and do_codigo_cliente = dc_cliente
and do_estado_contable in (1,2)

GO

IF OBJECT_ID ('dbo.cr_nuevos_mc_vw') IS NOT NULL
	DROP VIEW dbo.cr_nuevos_mc_vw
GO

create view cr_nuevos_mc_vw(
nm_tramite,
nm_tipo_credito,
nm_mercado_objetivo,
nm_sujcred,
nm_fecha_apr,
nm_numero_op_banco
)
as
select 
tr_tramite,
tr_tipo_credito,
tr_mercado_objetivo,
tr_sujcred,
tr_fecha_apr,
tr_numero_op_banco
from cr_tramite

GO

IF OBJECT_ID ('dbo.cr_cobertura_planes_vs') IS NOT NULL
	DROP VIEW dbo.cr_cobertura_planes_vs
GO

create view cr_cobertura_planes_vs as

select ps_tipo_seguro as cp_tipo_seguro, cp_estado,cp_codigo_plan,   cp_codigo_cobertura,   cp_descripcion_amparo,
       cp_valor_cobertura
from   cr_cobertura_planes,cr_plan_seguros
where  cp_fecha_modif is null
and    cp_estado in ('V','C') 
and    cp_plan_historia = ps_plan_historia
and    ps_fecha_modif is null
and    ps_estado in ('V','C') 


GO

IF OBJECT_ID ('dbo.cl_tabla_cre') IS NOT NULL
	DROP VIEW dbo.cl_tabla_cre
GO

create view cl_tabla_cre as
select * 
from cobis..cl_tabla 
where tabla like 'cr_%'

GO

IF OBJECT_ID ('dbo.cl_parametro_cre') IS NOT NULL
	DROP VIEW dbo.cl_parametro_cre
GO

create view cl_parametro_cre as
select * 
from cobis..cl_parametro 
where pa_producto   = 'CRE'
and   pa_nemonico not in ('ACTCIR',    'ACTCIS',   'AVALNA',   'CALIF',    'CAP',      'CCCJ',   -- GAL 12/MAY/2009  PARAMETROS QUE USA EL CONSOLIDADOR NO SE MODIFICAN
                          'CON',       'CVIV',     'DEF',      'ESTA',     'ESTH',     'FCCAL',
                          'FDO',       'INE',      'INT',      'LOB',      'MATC',     'MATINV',
                          'MATINVANT', 'MATTOT',   'MLOCR',    'MOMRC',    'PGACM',    'PGANT',
                          'PGFINI',    'PGMES',    'PGPCT',    'PROV',     'RES',      'RESPG',
                          'SITC',      'SITCS',    'SITF',     'SITIC',    'SITIN',    'SITL',
                          'TCCJ',      'TEMPDF',   'VALSAL',   'VTO'
                          )

GO

IF OBJECT_ID ('dbo.cl_catalogo_pro_cre') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_pro_cre
GO

create view cl_catalogo_pro_cre as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo_pro c 
where t.codigo = c.cp_tabla 
and t.tabla like 'cr_%'

GO

IF OBJECT_ID ('dbo.cl_catalogo_cre') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_cre
GO

create view cl_catalogo_cre as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo c 
where t.codigo = c.tabla 
and t.tabla like 'cr_%'

GO


USE cob_externos
GO

IF OBJECT_ID ('dbo.ex_dato_microempresa_tmp') IS NOT NULL
	DROP VIEW dbo.ex_dato_microempresa_tmp
GO

/* DATO MICROEMPRESA */
create view ex_dato_microempresa_tmp (
dm_fecha,            dm_aplicativo,                  dm_id_microempresa,     
dm_nombre,           dm_descripcion)
as SELECT 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull(mi_identificacion, (select max(en_ced_ruc) from cobis..cl_ente, cob_credito..cr_deudores where de_tramite = T.tr_tramite and en_ente = de_cliente and de_rol = 'D')),
isnull(mi_nombre,'SIN NOMBRE'), mi_descripcion
from  cob_credito..cr_microempresa, cob_credito..cr_tramite T
where mi_tramite = tr_tramite

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero6') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero6
GO

/* DATO INFORMACION FINANCIERA  - tramites del 750mil en adelente */
create view ex_dato_bal_fnciero6 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite  = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite >= 750000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero5') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero5
GO

/* DATO INFORMACION FINANCIERA  - tramites del 600mil al 750mil */
create view ex_dato_bal_fnciero5 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite  = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite >= 600000
and   tr_tramite  < 750000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero4') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero4
GO

/* DATO INFORMACION FINANCIERA  - tramites del 450mil al 600mil */
create view ex_dato_bal_fnciero4 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite  = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite >= 450000
and   tr_tramite  < 600000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero3') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero3
GO

/* DATO INFORMACION FINANCIERA  - tramites del 300mil al 450mil */
create view ex_dato_bal_fnciero3 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite  = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite >= 300000
and   tr_tramite  < 450000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero2') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero2
GO

/* DATO INFORMACION FINANCIERA  - tramites del 150mil al 300mil */
create view ex_dato_bal_fnciero2 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite  = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite >= 150000
and   tr_tramite  < 300000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero1') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero1
GO

------------------------------------------------------------------------------------------------------
/* DATO INFORMACION FINANCIERA  - tramites del 1 al 150mil */
create view ex_dato_bal_fnciero1 (
bf_fecha,               bf_aplicativo,          bf_id_microempresa, 	bf_microempresa, 
bf_tramite,             bf_sec_balance,         bf_nivel1,              bf_nivel2,              
bf_nivel3,              bf_nivel4,              bf_sumatoria,           bf_total,               
bf_descripcion,         bf_nivel,               bf_actualizado)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')), 
(select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'), 
isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite), ''), if_microempresa,
if_tramite,             if_codigo,              if_nivel1,              if_nivel2,
if_nivel3,              if_nivel4,              if_sumatoria,           if_total,
if_descripcion,         if_nivel,               if_actualizado
from  cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite = if_tramite
and   tr_estado in ('Z', 'A')
and   tr_tramite < 150000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det6') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det6
GO

/* DATO DETALLE INFORMACION FINANCIERA - tramites del 750mil en adelante */
create view ex_dato_bal_fnciero_det6 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite     >= 750000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det5') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det5
GO

/* DATO DETALLE INFORMACION FINANCIERA - tramites del 600mil al 750mil */
create view ex_dato_bal_fnciero_det5 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite     >= 600000
and   tr_tramite      < 750000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det4') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det4
GO

/* DATO DETALLE INFORMACION FINANCIERA - tramites del 450mil al 600mil */
create view ex_dato_bal_fnciero_det4 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite     >= 450000
and   tr_tramite      < 600000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det3') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det3
GO

/* DATO DETALLE INFORMACION FINANCIERA - tramites del 300mil al 450mil */
create view ex_dato_bal_fnciero_det3 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite     >= 300000
and   tr_tramite      < 450000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det2') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det2
GO

/* DATO DETALLE INFORMACION FINANCIERA - tramites del 150mil al 300mil */
create view ex_dato_bal_fnciero_det2 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite     >= 150000
and   tr_tramite      < 300000

GO

IF OBJECT_ID ('dbo.ex_dato_bal_fnciero_det1') IS NOT NULL
	DROP VIEW dbo.ex_dato_bal_fnciero_det1
GO

------------------------------------------------------------------------------------------------------
/* DATO DETALLE INFORMACION FINANCIERA - tramites del 1 al 150mil */
create view ex_dato_bal_fnciero_det1 (
bd_fecha,               bd_aplicativo,          bd_id_microempresa,     bd_microempresa,
bd_tramite,             bd_sec_balance,         bd_codigo_var,          bd_secuencial,          
bd_tipo,                bd_valor,               bd_decl_jur)
as select 
(select fc_fecha_cierre from  cobis..ba_fecha_cierre where fc_producto in (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE')),               (select pd_producto from cobis..cl_producto where  pd_abreviatura = 'CRE'),          isnull((select min(mi_identificacion) from cob_credito..cr_microempresa where mi_tramite = I.if_tramite),''),   dif_microempresa,
if_tramite,             dif_inf_fin,        dif_codigo_var,         dif_secuencial,
dif_tipo,               
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
dif_decl_jur
from  cob_credito..cr_det_inf_financiera, cob_credito..cr_tramite, cob_credito..cr_inf_financiera I
where tr_tramite      = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   tr_estado in ('Z', 'A')
and   tr_tramite      < 150000

GO

