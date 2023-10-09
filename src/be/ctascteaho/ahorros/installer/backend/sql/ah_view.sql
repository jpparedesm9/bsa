/************************************************************************/
/*      Archivo:            ah_view.sql                                 */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de vistas                     */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
USE cob_ahorros
GO
/****************** View ah_apertura_caja     ******************/

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create view ah_apertura_caja (
    secuencial, oficina, usuario,
    terminal, moneda, fecha, efectivo,
    nodo, tipo, tipo_tran, alterno, hora,
    prod_banc, categoria,
    tipocta_super, turno, canal
) as 
select  tm_secuencial, tm_oficina, tm_usuario,
    tm_terminal, tm_moneda, tm_fecha, tm_efectivo,
    tm_nodo, tm_origen, tm_tipo_tran, tm_cod_alterno, tm_hora,
    tm_prod_banc, tm_categoria,
    tm_tipocta_super, tm_turno, tm_canal
from    ah_tran_monet
where   tm_tipo_tran = 215

GO
/****************** View ah_cierre     ******************/

create view ah_cierre (
    secuencial,          tipo_tran,             oficina,
    usuario,             terminal,              correccion,
    sec_correccion,      reentry,               origen,
    nodo,                fecha,                 cta_banco,
    ret_efe,             ret_chq,               remoto_ssn,
    moneda,              control,               saldo_lib,
    signo,               alterno,               saldocont,
    saldodisp,           saldoint,              impuesto,
    multa,               oficina_cta,           hora,
    estado,              prod_banc,             categoria,
    monto_imp,           tipo_exoneracion,      ssn_branch,
    tipocta_super,       turno,                 forma_pago,  
    cheque,              ctadestino,            serial, 
    canal,               cliente,               indicador,
    base_gmf,            clase_clte,            causa
) as
select  
    tm_secuencial,       tm_tipo_tran,          tm_oficina,
    tm_usuario,          tm_terminal,           tm_correccion,
    tm_sec_correccion,   tm_reentry,            tm_origen,
    tm_nodo,             tm_fecha,              tm_cta_banco,
    tm_valor,            tm_chq_propios,        tm_remoto_ssn,
    tm_moneda,           tm_control,            tm_saldo_lib,
    tm_signo,            tm_cod_alterno,        tm_saldo_contable,
    tm_saldo_disponible, tm_saldo_interes,      tm_interes,
    tm_valor_comision,   tm_oficina_cta,        tm_hora,
    tm_estado,           tm_prod_banc,          tm_categoria,
    tm_monto_imp,        tm_tipo_exonerado_imp, tm_ssn_branch,
    tm_tipocta_super,    tm_turno,              tm_forma_pg, 
    tm_cheque,           tm_ctadestino,         tm_serial, 
    tm_canal,            tm_cliente,            tm_indicador,
    tm_base_gmf,         tm_clase_clte,         tm_causa
from    ah_tran_monet
where   tm_tipo_tran = 213

GO
/****************** View ah_deposito     ******************/

create view ah_deposito (
    secuencial,          ssn_branch,       tipo_tran,        oficina, 
    usuario,             terminal,         correccion,       sec_correccion, 
    reentry,             origen,           nodo,             fecha,               cta_banco, 
    efectivo,            propios,          locales,          ot_plazas,           remoto_ssn, 
    moneda,              saldo_lib,        control,          interes,             fecha_efec,       
    signo,               alterno,          saldocont,        saldodisp,           saldoint,         
    oficina_cta,         hora,             estado,                                                     
    prod_banc,           categoria,        tipocta_super,    turno,               
    canal,               cliente,          clase_clte,       origen_efectivo
) as                                                                              
select tm_secuencial,    tm_ssn_branch,    tm_tipo_tran,     tm_oficina,          
    tm_usuario,          tm_terminal,      tm_correccion,    tm_sec_correccion,   
    tm_reentry,          tm_origen,        tm_nodo,          tm_fecha,            tm_cta_banco, 
    tm_valor,            tm_chq_propios,   tm_chq_locales,   tm_chq_ot_plazas,    tm_remoto_ssn, 
    tm_moneda,           tm_saldo_lib,     tm_control,       tm_interes,          tm_fecha_efec,       
    tm_signo,            tm_cod_alterno,   tm_saldo_contable,tm_saldo_disponible, 
    tm_saldo_interes,    tm_oficina_cta,   tm_hora,          tm_estado,
    tm_prod_banc,        tm_categoria,     tm_tipocta_super, tm_turno,
    tm_canal,            tm_cliente,       tm_clase_clte,    tm_stand_in 
  from  ah_tran_monet
 where  tm_tipo_tran in (246, 248,251, 252, 254)

GO
/****************** View ah_notcredeb     ******************/

create view ah_notcredeb (
    secuencial, ssn_branch, tipo_tran, oficina, filial,
    usuario, terminal, correccion, sec_correccion, 
    reentry, origen, nodo, fecha, cta_banco, 
    valor, remoto_ssn, moneda, interes, val_cheque, 
    indicador, saldo_lib, control, causa, fecha_efec,
    signo, alterno, saldocont, saldodisp, saldoint, departamento,
    oficina_cta, banco, hora, concepto, estado,
    prod_banc, categoria, monto_imp, tipo_exonerado, serial, tipocta_super,
    turno, ctabanco_dep, cheque, stand_in, canal, clase_clte, oficial,monto_iva,
    cliente, base_imp, base_gmf, chq_locales
) as
select  tm_secuencial, tm_ssn_branch, tm_tipo_tran, tm_oficina, tm_filial,
    tm_usuario, tm_terminal, tm_correccion, tm_sec_correccion,
    tm_reentry, tm_origen, tm_nodo, tm_fecha, tm_cta_banco, 
    tm_valor, tm_remoto_ssn, tm_moneda, tm_interes, tm_efectivo ,  
    tm_indicador, tm_saldo_lib, tm_control, tm_causa, tm_fecha_efec,
    tm_signo, tm_cod_alterno, tm_saldo_contable, tm_saldo_disponible,
    tm_saldo_interes, tm_departamento, tm_oficina_cta, tm_banco, tm_hora,
    tm_concepto, tm_estado,
    tm_prod_banc, tm_categoria, tm_monto_imp, tm_tipo_exonerado_imp, tm_serial, tm_tipocta_super,
    tm_turno, tm_ctadestino, tm_cheque, tm_stand_in, tm_canal, tm_clase_clte,tm_oficial,tm_valor_comision,
    tm_cliente, tm_chq_ot_plazas, tm_base_gmf, tm_chq_locales
  from  ah_tran_monet
 where  tm_tipo_tran in (221, 240, 253, 255, 257, 262, 264, 265, 266, 304, 308, 309)

GO
/****************** View ah_retiro     ******************/

create view ah_retiro (
    secuencial,        ssn_branch,    tipo_tran,     oficina, 
    usuario,           terminal,      correccion,    sec_correccion, 
    reentry,           origen,        nodo,          fecha,     cta_banco, interes, 
    valor,             moneda,        remoto_ssn,    saldo_lib,
    control,           fecha_efec,    signo,         alterno,   saldocont, saldodisp,
    saldoint,          oficina_cta,   hora,          estado,
    prod_banc,         categoria,     clase_clte,               
    tipocta_super,     turno,         canal,         cliente
) as
select  tm_secuencial, tm_ssn_branch, tm_tipo_tran,  tm_oficina, 
    tm_usuario,        tm_terminal,   tm_correccion, tm_sec_correccion,
    tm_reentry,        tm_origen,     tm_nodo,       tm_fecha, tm_cta_banco, tm_interes,
    tm_valor,          tm_moneda,     tm_remoto_ssn, tm_saldo_lib, 
    tm_control,        tm_fecha_efec, tm_signo,      tm_cod_alterno,
    tm_saldo_contable, tm_saldo_disponible,          tm_saldo_interes,
    tm_oficina_cta,    tm_hora,       tm_estado,     
    tm_prod_banc,      tm_categoria,  tm_clase_clte,               
    tm_tipocta_super,  tm_turno,      tm_canal,      tm_cliente
  from  ah_tran_monet
 where  tm_tipo_tran in ( 261, 263)

GO
/****************** View ah_transferencia     ******************/

create view ah_transferencia (
    secuencial,        ssn_branch,            tipo_tran,         oficina,    usuario,
    terminal,          correccion,            sec_correccion,    filial,
    reentry,           origen,                nodo,              fecha,      ctaorigen,    ctadestino,
    valor,             tipo_xfer,             remoto_ssn,        moneda,                   
    control,           saldo_lib,             signo,             alterno,    saldocont,    saldodisp, saldoint,
    intgan,            oficina_cta,           hora,              estado,
    prod_banc,         categoria,             
    monto_imp,         tipo_exonerado_imp,    referencia,
    tipocta_super,     turno,                 traslado, canal, 
    cliente,           base_gmf,              clase_clte               
) as                                          
select                                        
    tm_secuencial,     tm_ssn_branch,         tm_tipo_tran,      tm_oficina, tm_usuario,
    tm_terminal,       tm_correccion,         tm_sec_correccion, tm_filial,
    tm_reentry,        tm_origen ,            tm_nodo,           tm_fecha,   tm_cta_banco, tm_ctadestino,
    tm_valor,          tm_tipo_xfer,          tm_remoto_ssn,     tm_moneda,
    tm_control,        tm_saldo_lib,          tm_signo,          tm_cod_alterno,
    tm_saldo_contable, tm_saldo_disponible,   tm_saldo_interes,
    tm_interes,        tm_oficina_cta,        tm_hora,           tm_estado,
    tm_prod_banc,      tm_categoria,
    tm_monto_imp,      tm_tipo_exonerado_imp, tm_concepto,
    tm_tipocta_super,  tm_turno,              tm_serial,         tm_canal, 
    tm_cliente,        tm_base_gmf,           tm_clase_clte
from    ah_tran_monet
where   tm_tipo_tran in (237,239, 294, 300)

GO
/****************** View ah_tsanulalib     ******************/

create view ah_tsanulalib (
       filial,
       secuencial,       ssn_branch,    tipo_transaccion,    tsfecha,
       usuario,          terminal,      oficina,             reentry,    origen,
       ctacte,           num_bloqueos,  tipo_bloqueo,        fecha,
       valor,            accion,        autorizante,         estado,     cta_banco,
       alterno,          moneda,        causa,               numlib ,    saldo, 
       oficina_cta,      hora,             
       prod_banc,        categoria,
       tipocta_super,    turno
) as                     
select ts_filial,        
       ts_secuencial,    ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
       ts_usuario,       ts_terminal,   ts_oficina,          ts_reentry, ts_origen,
       ts_ctacte,        ts_numero,     ts_tipo,             ts_fecha,
       ts_valor,         ts_accion,     ts_autorizante,      ts_estado,  ts_cta_banco,
       ts_cod_alterno,   ts_moneda,     ts_causa,            ts_numlib,  ts_saldo,
       ts_oficina_cta,   ts_hora,          
       ts_prod_banc,     ts_categoria,
       ts_tipocta_super, ts_turno
    
from    ah_tran_servicio
where   ts_tipo_transaccion in (280)

GO
/****************** View ah_tsapertura     ******************/

create view ah_tsapertura (
       secuencial,    ssn_branch,        tipo_transaccion, oficina,
       usuario,       terminal,          reentry,
       clase,         tsfecha,           origen,
       cuenta,        cta_banco,         filial, 
       oficial,       fecha_aper,        cliente,        ced_ruc,    estado,
       direccion_ec,  ciclo,             categoria,      producto,   tipo,
       moneda,        def,               tipo_def,       rol_ente,   microficha, 
       tipo_promedio, alterno,           descripcion_ec, cliente_ec,
       tipo_interes,  capitalizacion,    ctafun,         mercantil,
       tipocta,       producto_bancario, origen_cta,     numlib,     accion,
       monto,         oficina_cta,       hora,
       prod_banc,     nombre1,           cedula1,
       promotor,      tipocta_super,     direccion_dv,   descripcion_dv,
       tipodir_dv,    turno,             estado_cta,     permite_sldcero, fideicomiso,
       clase_clte,    nxmil,             observacion,    marca_gmf, fec_marca_gmf,
	   valor,         dias_plazo,        cta_relacionada
) as
select ts_secuencial,   ts_ssn_branch,     ts_tipo_transaccion, ts_oficina, 
       ts_usuario,      ts_terminal,       ts_reentry,
       ts_clase,        ts_tsfecha,        ts_origen,
       ts_ctacte,       ts_cta_banco,      ts_filial, 
       ts_oficial,      ts_fecha_aper,     ts_cliente,     ts_ced_ruc,   ts_estado,
       ts_direccion_ec, ts_ciclo,          ts_categoria,   ts_producto,  ts_tipo,
       ts_moneda,       ts_default,        ts_tipo_def,    ts_rol_ente,  ts_endoso, 
       ts_tipo_promedio,ts_cod_alterno,    ts_descripcion_ec, ts_cheque,
       ts_tipo_interes, ts_capitalizacion, ts_cta_funcionario, ts_mercantil,
       ts_tipocta,      ts_departamento,   ts_causa,       ts_numlib,    ts_accion, ts_monto,
       ts_oficina_cta,  ts_hora,
       ts_prod_banc,    ts_nombre1,        ts_cedruc1,
       ts_ofi_aut,      ts_tipocta_super,  ts_ofi_anula,   ts_autoriz_aut,
       ts_clase_np,     ts_turno,          ts_causa_np,    ts_orden,     ts_cta_banco_dep,
       ts_clase_clte,   ts_nxmil,          ts_observacion, ts_marca_gmf, ts_fec_marca_gmf,
	   ts_valor,        ts_secuencia,      ts_cta_gir
from    ah_tran_servicio
where   ts_tipo_transaccion in (201, 202, 205)

GO
/****************** View ah_tsbloqueo     ******************/

create view ah_tsbloqueo (
       secuencial, ssn_branch, tipo_transaccion, tsfecha,
       usuario, terminal,  oficina, reentry, origen,
       ctacte, num_bloqueos, tipo_bloqueo, fecha,
       valor, accion, autorizante, estado, cta_banco,
       alterno, moneda, causa, hora, solicitante,
       fecha_vencim, oficina_cta,
       prod_banc, categoria, observacion,
       tipocta_super, turno
) as
select ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
       ts_usuario, ts_terminal, ts_oficina, ts_reentry, ts_origen,
       ts_ctacte, ts_numero, ts_tipo, ts_fecha,
       ts_valor, ts_accion, ts_autorizante, ts_estado,  ts_cta_banco,
       ts_cod_alterno, ts_moneda, ts_causa, ts_fecha_uso, ts_autoriz_aut,
       ts_fecha_ven, ts_oficina_cta,
       ts_prod_banc, ts_categoria, ts_observacion,
       ts_tipocta_super, ts_turno
 
from   ah_tran_servicio
where  ts_tipo_transaccion in (211, 212, 217, 218,327,328)

GO
/****************** View ah_tscalcul_inter     ******************/

create view ah_tscalcul_inter (
        secuencial, tipo_transaccion, tsfecha,
        usuario, terminal,  oficina, reentry, origen,
        cta_banco, fecha, valor, moneda, hora,
        tasa, oficina_cta, filial, saldo,
        prod_banc, categoria,ssn_branch,
        tipocta_super, turno, cliente
) as
select  ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
        ts_usuario, ts_terminal, ts_oficina, ts_reentry, ts_origen,
        ts_cta_banco, ts_fecha, ts_valor, ts_moneda, ts_fecha_uso,
        ts_tasa, ts_oficina_cta, ts_filial , ts_saldo,
        ts_prod_banc, ts_categoria, ts_ssn_branch,
        ts_tipocta_super, ts_turno, ts_cliente
from    ah_tran_servicio
where   ts_tipo_transaccion in (271)

GO
/****************** View ah_tscambia_estado     ******************/

create view ah_tscambia_estado (
       secuencial,    ssn_branch,    tipo_transaccion,    oficina,
       usuario,       terminal,      reentry,             
       clase,         tsfecha,       origen,              
       cta_banco,     moneda,        estado,              causa,            oficina_cta,    hora,
       valor,         prod_banc,     categoria,           tipocta_super,    turno,          alterno,
       clase_clte,    cliente,       interes,             cuenta 
) as
select ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_oficina, 
       ts_usuario,    ts_terminal,   ts_reentry,
       ts_clase,      ts_tsfecha,    ts_origen,
       ts_cta_banco,  ts_moneda,     ts_estado,           ts_causa,         ts_oficina_cta, ts_hora,
       ts_valor,      ts_prod_banc,  ts_categoria,        ts_tipocta_super, ts_turno,       ts_cod_alterno,
       ts_clase_clte, ts_cliente,    ts_interes,          ts_ctacte
from   ah_tran_servicio
where  ts_tipo_transaccion in (203, 204)

GO
/****************** View ah_tscierre_cta     ******************/

CREATE view ah_tscierre_cta(
secuencial,  ssn_branch,    tipo_transaccion, tsfecha, 
usuario,     terminal,      oficina,          reentry,            origen,
secuencia,   ctacte,        causa,            saldo,              fecha,
autorizante, cta_banco,     alterno,          moneda,             orden,
intgnd,      impuesto,      oficina_cta,      hora,               prod_banc,
categoria,   tipocta_super, turno,            no_cobra_multa_ant, multa_ant, 
cliente,     numorden 
) as
select    
ts_secuencial, ts_ssn_branch,    ts_tipo_transaccion, ts_tsfecha, 
ts_usuario,    ts_terminal,      ts_oficina,          ts_reentry, ts_origen,
ts_secuencia,  ts_ctacte,        ts_causa,            ts_saldo,   ts_fecha,
ts_autorizante,ts_cta_banco,     ts_cod_alterno,      ts_moneda,  ts_orden,
ts_interes,    ts_monto,         ts_oficina_cta,      ts_hora,    ts_prod_banc,  
ts_categoria,  ts_tipocta_super, ts_turno,            ts_accion,  ts_valor, 
ts_cliente,    ts_numlib
from    ah_tran_servicio
where   ts_tipo_transaccion = 213


GO
/****************** View ah_tscliente_ctahorro     ******************/

create view ah_tscliente_ctahorro (
       secuencial,       ssn_branch,    tipo_transaccion,    tsfecha,     clase,
       usuario,          terminal,      oficina,             reentry,     origen,
       cta_banco,        moneda,        cliente,             det_producto,
       rol_cliente,      cedula_ruc,    oficina_cta,         hora,
       prod_banc,        categoria,
       tipocta_super,    turno
) as
select ts_secuencial,    ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,  ts_clase,
       ts_usuario,       ts_terminal,   ts_oficina,          ts_reentry,  ts_origen,
       ts_cta_banco,     ts_moneda,     ts_cliente,          ts_default, 
       ts_tipo,          ts_ced_ruc,    ts_oficina_cta,      ts_hora,
       ts_prod_banc,     ts_categoria,
       ts_tipocta_super, ts_turno
from   ah_tran_servicio
where  ts_tipo_transaccion in (206, 207, 295, 296)

GO
/****************** View ah_tsconsumo     ******************/

create view ah_tsconsumo (
        secuencial,       ssn_branch,    tipo_transaccion,    tsfecha,
        usuario,          terminal,      oficina,             reentry,   origen,
        correccion,       ssn_corr,      remoto_ssn,          
        cta_banco,        fecha,         valor,               moneda,    hora,
        tarjeta,          estado,        estado_consumo,      clave,
        oficina_cta,      comision,      comision_imp,        
        causa,            monto_imp,     prod_banc,           categoria,
        tipocta_super,    turno,         cliente
) as
select  ts_secuencial,    ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
        ts_usuario,       ts_terminal,   ts_oficina,          ts_reentry, ts_origen,
        ts_correccion,    ts_ssn_corr,   ts_remoto_ssn,
        ts_cta_banco,     ts_fecha,      ts_valor,            ts_moneda,  ts_fecha_uso,
        ts_cta_gir,       ts_estado ,    ts_tipo,             ts_contrato,
        ts_oficina_cta,   ts_saldo,      ts_interes,          
        ts_propietario,   ts_monto,      ts_prod_banc,        ts_categoria,
        ts_tipocta_super, ts_turno,      ts_cliente
from    ah_tran_servicio
where   ts_tipo_transaccion in (305,306)

GO
/****************** View ah_tsefectivo_caja     ******************/

create view ah_tsefectivo_caja(
        secuencial, ssn_branch, oficina,       usuario, 
        terminal,   moneda,     fecha,         efectivo,
        nodo,       tipo,       tipo_tran,     remoto_ssn, 
        prod_banc,  categoria,  tipocta_super, turno, 
        num_vale,   causa,      cliente
) as
select    
        ts_secuencial, ts_ssn_branch, ts_oficina,          ts_usuario, 
        ts_terminal,   ts_moneda,     ts_tsfecha,          ts_valor,
        ts_nodo,       ts_tipo,       ts_tipo_transaccion, ts_remoto_ssn, 
        ts_prod_banc,  ts_categoria,  ts_tipocta_super,    ts_turno, 
        ts_default,    ts_causa,      ts_cliente
from    ah_tran_servicio
where   ts_tipo_transaccion in (15, 42, 2563)

GO
/****************** View ah_tsgerencia     ******************/

create view ah_tsgerencia (
    secuencial, ssn_branch, tipo_tran, oficina, usuario, terminal,
    correccion, reentry, origen, nodo, fecha,
    cta_banco, valor, 
    nro_cheque, departamento, moneda, ssn_corr,
    alterno, oficina_cta, hora,
    prod_banc, categoria,
    tipocta_super, turno
) as
select  ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_terminal,
    ts_correccion, ts_reentry, ts_origen, ts_nodo, ts_tsfecha,
    ts_cta_banco, ts_saldo,
    ts_cheque_desde, ts_departamento, ts_moneda, ts_ssn_corr,
    ts_cod_alterno, ts_oficina_cta, ts_hora,
    ts_prod_banc, ts_categoria,
    ts_tipocta_super, ts_turno
from    ah_tran_servicio
where   ts_tipo_transaccion = 259

GO
/****************** View ah_tspag_otrobanco     ******************/

create view ah_tspag_otrobanco (
    secuencial, ssn_branch, tipo_tran, oficina, usuario, terminal,
    correccion, reentry, origen, nodo, fecha,
    valor, nro_cheque, moneda, ssn_corr, alterno, oficina_cta, hora,
    prod_banc, categoria,
    tipocta_super, turno
) as
select  ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_terminal,
    ts_correccion, ts_reentry, ts_origen, ts_nodo, ts_tsfecha,
    ts_saldo, ts_cheque, ts_moneda, ts_ssn_corr, ts_cod_alterno,
    ts_oficina_cta, ts_hora,
    ts_prod_banc, ts_categoria,
    ts_tipocta_super, ts_turno
from    ah_tran_servicio
where   ts_tipo_transaccion in (268, 269)

GO
/****************** View ah_tsrem_chequeconf     ******************/

create view ah_tsrem_chequeconf (
    secuencial,     ssn_branch,    alterno,        tipo_tran,           oficina, 
    usuario,        terminal,      correccion,     ssn_corr,            reentry, 
    origen,         nodo,          fecha,          cta_banco_dep,       valor, 
    corresponsal,   propietario,   nro_cheque,     producto,            moneda, 
    carta,          endoso,        oficina_cta,    hora,                causa_contab,
    estado,         prod_banc,     categoria,      tipocta_super,       turno,
    cliente,        ced_ruc,       indicador,      clase_clte
) as
select  
    ts_secuencial,   ts_ssn_branch,  ts_cod_alterno, ts_tipo_transaccion, ts_oficina, 
    ts_usuario,      ts_terminal,    ts_correccion,  ts_sec_correccion,   ts_reentry, 
    ts_origen,       ts_nodo,        ts_tsfecha,     ts_cta_banco_dep,    ts_valor, 
    ts_corresponsal, ts_propietario, ts_cheque,      ts_producto,         ts_moneda, 
    ts_carta,        ts_endoso,      ts_oficina_cta, ts_hora,             ts_causa,
    ts_estado,       ts_prod_banc,   ts_categoria,   ts_tipocta_super,    ts_turno,
    ts_cliente,      ts_ced_ruc,     ts_indicador,   ts_clase_clte
  from  ah_tran_servicio
 where  ts_tipo_transaccion in (402,403,404,406)

GO
/****************** View ah_tsrem_chequedev     ******************/

create view ah_tsrem_chequedev (
    secuencial,    ssn_branch, alterno,       tipo_tran,     oficina, 
    usuario,       terminal,   correccion,    reentry,       origen, 
    nodo,          fecha,      cta_banco_dep, valor,         corresponsal, 
    propietario,   nro_cheque, moneda,        producto,      ssn_corr, 
    carta,         cta_banco,  cod_banco,     oficina_cta,   hora,
    causa_contab,  prod_banc,  categoria,     tipocta_super, turno,
    cliente,       clase_clte
) as
select  
    ts_secuencial,  ts_ssn_branch, ts_cod_alterno,   ts_tipo_transaccion, ts_oficina, 
    ts_usuario,     ts_terminal,   ts_correccion,    ts_reentry,          ts_origen, 
    ts_nodo,        ts_tsfecha,    ts_cta_banco_dep, ts_saldo,            ts_corresponsal, 
    ts_propietario, ts_nro_cheque, ts_moneda,        ts_producto,         ts_ssn_corr, 
    ts_carta,       ts_cta_banco,  ts_cod_banco,     ts_oficina_cta,      ts_hora,
    ts_causa,       ts_prod_banc,  ts_categoria,     ts_tipocta_super,    ts_turno,
    ts_cliente,     ts_clase_clte
from    ah_tran_servicio
where   ts_tipo_transaccion in (402, 416)

GO
/****************** View ah_tsrem_ingresochq     ******************/

create view ah_tsrem_ingresochq (
    secuencial,    ssn_branch,    tipo_tran, 
    oficina,       usuario,       terminal,
    correccion,    reentry,       origen, 
    nodo,          fecha,         cta_banco_dep, 
    valor,         cta_gir,       endoso, 
    nro_cheque,    cod_banco,     moneda, 
    producto,      ssn_corr,      cheque_rec,
    alterno,       oficina_cta,   hora, 
    causa_contab,  prod_banc,     categoria,
    estado,        causa,         referencia,
    tipocta_super, turno,         monto,
    indicador,     bco_corr,      carta,
    suc_destino,   cod_corres,    cliente,
    clase_clte,    estado_trn
) as
select  
    ts_secuencial,    ts_ssn_branch,  ts_tipo_transaccion, 
    ts_oficina,       ts_usuario,     ts_terminal,
    ts_correccion,    ts_reentry,     ts_origen, 
    ts_nodo,          ts_tsfecha,     ts_cta_banco, 
    ts_valor,         ts_cta_gir,     ts_endoso, 
    ts_nro_cheque,    ts_cod_banco,   ts_moneda, 
    ts_producto,      ts_ssn_corr,    ts_cheque_rec,
    ts_cod_alterno,   ts_oficina_cta, ts_hora, 
    ts_causa,         ts_prod_banc,   ts_categoria,
    ts_rol_ente,      ts_servicio,    ts_autorizante,
    ts_tipocta_super, ts_turno,       ts_monto, 
    ts_indicador,     ts_numero,      ts_numlib,
    ts_endoso,        ts_corresponsal, ts_cliente,
    ts_clase_clte,    ts_estado
from    ah_tran_servicio
where   ts_tipo_transaccion in (401, 486)

GO
/****************** View ah_tssobregiro     ******************/

create view ah_tssobregiro (
       secuencial, ssn_branch, tipo_transaccion, tsfecha,
       usuario, terminal, reentry, oficina, origen,
       cuenta, cta_banco, num_sobregiros, tipo_sobregiro,
       contrato, fecha_aut, monto_aut, fecha_uso,
       monto_uso, fecha_ven, filial_aut, ofi_aut,
       autoriz_aut, filial_anula, ofi_anula, autoriz_anula,
       alterno, moneda, oficina_cta, hora,
       prod_banc, categoria,
       tipocta_super, turno
) as
select ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
       ts_usuario, ts_terminal, ts_reentry, ts_oficina, ts_origen,
       ts_ctacte, ts_cta_banco, ts_numero, ts_tipo,
       ts_contrato, ts_fecha, ts_saldo, ts_fecha_uso,
       ts_monto, ts_fecha_ven, ts_filial_aut, ts_ofi_aut,
       ts_autoriz_aut, ts_filial_anula, ts_ofi_anula, ts_autoriz_anula,
       ts_cod_alterno, ts_moneda, ts_oficina_cta, ts_hora,
       ts_prod_banc, ts_categoria,
       ts_tipocta_super, ts_turno
from   ah_tran_servicio
where  ts_tipo_transaccion in (224, 225, 226, 227)

GO

/****************** View ah_tssolape     ******************/

create view ah_tssolape (
secuencial, ssn_branch, cod_alterno,   clase,         tipo_transaccion,
oficina,    usuario,    terminal,      reentry,       tsfecha, 
origen,     filial,     fecha_aper,    cliente,       estado, 
producto,   tipo,       moneda,        propietario,   autorizante,
hora,       prod_banc,  categoria,     tipocta_super, turno,
observacion
) as
select    
ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_clase,         ts_tipo_transaccion,
ts_oficina,    ts_usuario,    ts_terminal,    ts_reentry,       ts_tsfecha,
ts_origen,     ts_filial,     ts_fecha_aper,  ts_cliente,       ts_causa, 
ts_producto,   ts_servicio,   ts_moneda,      ts_propietario,   ts_autorizante,
ts_hora,       ts_prod_banc,  ts_categoria,   ts_tipocta_super, ts_turno,
ts_observacion
from  ah_tran_servicio 
where ts_tipo_transaccion in (351,352)

GO
/****************** View ah_tssolicita_ec     ******************/

create view ah_tssolicita_ec (
       secuencial, ssn_branch, tipo_transaccion, oficina,
       usuario, terminal, reentry,
       clase, tsfecha, origen,
       cta_banco, moneda, oficina_cta, hora,
       prod_banc, categoria,
       tipocta_super, turno
) as
select ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_oficina, 
       ts_usuario, ts_terminal, ts_reentry,
       ts_clase, ts_tsfecha, ts_origen,
       ts_cta_banco, ts_moneda, ts_oficina_cta, ts_hora,
       ts_prod_banc, ts_categoria,
       ts_tipocta_super, ts_turno
from   ah_tran_servicio
where  ts_tipo_transaccion = 234

GO

/****************** View ah_tsval_suspenso     ******************/
CREATE view ah_tsval_suspenso (
   secuencial, ssn_branch, tipo_tran, oficina, usuario, terminal,
   correccion, reentry, origen, nodo, fecha,
   cta_banco, valor, interes, indicador, servicio,
   remoto_ssn, moneda, ssn_corr, alterno, oficina_cta, hora,
   prod_banc, categoria, accion,
   tipocta_super, turno, serial, cliente, tipo_cliente,
   estado
) as
select ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_terminal,
       ts_correccion, ts_reentry, ts_origen, ts_nodo, ts_tsfecha,
       ts_cta_banco, ts_valor, ts_interes, ts_indicador, ts_causa,
       ts_remoto_ssn, ts_moneda, ts_ssn_corr, ts_cod_alterno, ts_oficina_cta,
       ts_hora,
       ts_prod_banc, ts_categoria, ts_accion,
       ts_tipocta_super, ts_turno, ts_autoriz_aut, ts_cliente, ts_clase_clte,
       ts_estado
from   ah_tran_servicio
where  ts_tipo_transaccion in (249, 250, 256, 257, 258, 264, 303)


GO
