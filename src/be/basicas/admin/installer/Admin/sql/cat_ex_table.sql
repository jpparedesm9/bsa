/************************************************************************/
/*      Archivo           :  cat_ex_table.sql                           */
/*      Base de datos     :  cobis                                      */
/*      Producto          :  COBIS                                      */
/*      Disenado por      :                                             */
/*      Fecha de escritura:  23/Ago/2011                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP S.A'.                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP S.A o su representante.      */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Generar el catálogo de tablas 'ex' para la extración de datos   */
/*      Nota: Se debe modificar el path de acuerdo a la estructura de   */
/*            directorios definida a Nivel del Servidor Central por     */
/*            m¢dulo [@w_path].                                         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*       FECHA           AUTOR                     RAZON                */
/*       23/Ago/2011     B. Ron           Emision Inicial               */    
/*       30/Ago/2011     A. Benavides     Registros Activas             */
/*       14/Dic/2012     G. Balon         Path [@w_path]                */
/*       06/May/2013     T. Cruz          Inci_21718                    */
/*       06/Ago/2013     P. Quezada       Incluir nuevas tablas         */      
/*       12/ABR/2016     BBO              Migracion SYBASE-SQLServer FAL*/
/************************************************************************/
use cobis
go

print 'Inicia cat_ex_table.sql ...'
go

truncate table cat_ex_table
go

print 'Inserta registros en cat_ex_table ...'
go

-- Inserta registros en catalogo

declare @w_path varchar(255)

------------------------------------------------
--PATH GENERAL
------------------------------------------------
select @w_path = 'C:\proc_E\ADM\'


/* ----- CUADRE ----- */
--'
insert into cat_ex_table values(0, @w_path, 'cobis','etl_cuadre_extraccion_cobis')

/* ----- ADMIN ----- */
--'
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_funcionario')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cc_ex_oficial')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_catalogo')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_moneda')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_oficina')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_tabla')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_ttransaccion')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_parametro')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_pais')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_departamento')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_provincia')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_municipio')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_canton')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_ciudad')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_dias_feriados')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_producto')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_tipo_documento')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_sector_economico')
insert into cat_ex_table values(1, @w_path, 'cobis', 'cl_ex_subsector_ec')
insert into cat_ex_table values(1, @w_path, 'cob_custodia', 'cu_ex_tipo_custodia')
insert into cat_ex_table values(1, @w_path, 'cob_remesas', 'pe_ex_pro_bancario')
insert into cat_ex_table values(1, @w_path, 'cob_remesas', 'pe_ex_mercado')
insert into cat_ex_table values(1, @w_path, 'cob_remesas', 'pe_ex_pro_final')
insert into cat_ex_table values(1, @w_path, 'cob_remesas', 're_ex_tran_contable')
insert into cat_ex_table values(1, @w_path, 'cob_remesas', 're_ex_forma_firma')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_banco')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_concepto_transferencias')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_contacto')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_cuenta_bancaria')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_linea_credito')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_oficina')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_parametro_contable')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_tpago')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_oficina_rol')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_uso_lc')
insert into cat_ex_table values(1, @w_path, 'cob_comext', 'ce_ex_plazo')
insert into cat_ex_table values(1, @w_path, 'cob_pfijo', 'pf_ex_tipo_deposito')
insert into cat_ex_table values(1, @w_path, 'cob_pfijo', 'pf_ex_fpago')
insert into cat_ex_table values(1, @w_path, 'cob_pfijo', 'pf_ex_ppago')
insert into cat_ex_table values(1, @w_path, 'cob_sbancarios', 'sb_ex_rubros')
insert into cat_ex_table values(1, @w_path, 'cob_sbancarios', 'sb_ex_instrumentos')
insert into cat_ex_table values(1, @w_path, 'cob_sbancarios', 'sb_ex_productos')
insert into cat_ex_table values(1, @w_path, 'cob_sbancarios', 'sb_ex_subtipos_ins')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_area')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_banco')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_cuenta')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_perfil')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_relofi')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_empresa')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_oficina')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_relparam')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_parametro')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_cotizacion')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_det_perfil')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_bal_comprob')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_codigo_valor')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_codval_rubro')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_plan_general')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_cuenta_asociada')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_tipo_trn_perfil')
insert into cat_ex_table values(1, @w_path, 'cob_conta', 'cb_ex_conciliacion_operaciones')
 


/* ----- CLIENTES ----- */
--'
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_ente')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_cliente_tipo_doc')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_direccion')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_telefono')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_instancia')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_at_instancia')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_at_relacion')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_relacion')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_grupo')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_cliente_grupo')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_grupos_cli')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_desenlace')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_formulario_roe')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_clientes_ocasionales')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_tran_casual')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_mod_estados')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_rel_maestro')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_producto')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_actividad_ec')
insert into cat_ex_table values(2, @w_path, 'cobis','cl_ex_ocupacion')
insert into cat_ex_table values(2, @w_path, 'cobis', 'cl_ex_det_producto')
insert into cat_ex_table values(2, @w_path, 'cobis', 'cl_ex_cliente')
insert into cat_ex_table values(2, @w_path, 'cobis', 'cl_ex_actividad_principal')
insert into cat_ex_table values(2, @w_path, 'cobis', 'cl_ex_referencias_cliente')
insert into cat_ex_table values(2, @w_path, 'cobis', 'cl_ex_cliente_identificacion')

go


/* ----- CTACTE ----- */

declare @w_path varchar(255)
select @w_path = 'C:\proc_E\CTE\'
--'
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_ctacte')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_tran_monet')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_tran_servicio')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_uso_sobregiro')
--insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_uso_nodisponible')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_sobregiro')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_reversos_sobregiro')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_formas_de_pago')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_his_cierre')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_val_suspenso')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_embargo')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_cheque')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_chequera')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_chq_beneficiario')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_cta_gerencia')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_estado_cta')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_mensaje_estcta')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_ciudad_deposito')
--insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_saldo_por_rubro')
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_actividad_economica')  --PQU
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_naturaleza_gasto')     --PQU
insert into cat_ex_table values(3, @w_path, 'cob_cuentas', 'cc_ex_origen_recursos')     --PQU

go

/* ----- AHORROS ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\AHO\'
--'
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_cuenta')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_tran_monet')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_tran_servicio')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_formas_de_pago')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_flujo_encaje')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_his_cierre')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_val_suspenso')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_embargo')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_ciudad_deposito')
--insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_saldo_por_rubro')
insert into cat_ex_table values(4, @w_path, 'cob_ahorros', 'ah_ex_tasas')
go

/* ----- CONTABILIDAD ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\CONT\'
--'
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_boc')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_corte')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_saldo')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_detest')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_estcta')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_asiento')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_boc_det')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_hist_saldo')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_comprobante')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'ct_ex_conciliacion')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_saldo_presupuesto')
insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_hist_saldo_alterno') -- JSA 09192012 
--insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_sasiento')
--insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_scomprobante')
--insert into cat_ex_table values(6, @w_path, 'cob_conta', 'cb_ex_producto')
go

/* ----- REMESAS ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\REM\'
--'
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_cheque_rec')
--insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_banco') TCA inc_21718
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_camara')
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_categoria_cliente')
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_trans_no_contables')
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 'rm_ex_remesas_rec')
insert into cat_ex_table values(10, @w_path, 'cob_remesas', 're_ex_remesadora')
go

/* ----- CARTERA ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\CCA\'
--'
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_amortizacion')       
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_amortizacion_cca')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_concepto')           
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_cuota_adicional')    
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_det_trn')            
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_operacion')          
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_producto')           
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_ptmosmora')          
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_devolucion')         
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_tdividendo')         
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_transaccion')        
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_relacion_ptmo')      
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_venta_relacion')     
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_abono')              
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_abono_det')          
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_dato_cartera')                 
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_pago_automatico')    
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_rubro')              
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_rubro_op')           
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_saldo_cartera')      
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_saldo_dividendo')    
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_tasas')              
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_fecha_cierre')       
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_default_toperacion') 
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_trn_oper')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_actividad_economica')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_bien_realizable_canc')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_naturaleza_gasto')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_operacion_cancelada')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_operacion_sindicada')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_origen_recursos')
insert into cat_ex_table values(7, @w_path, 'cob_cartera', 'ca_ex_saldo_por_rubro')
go                                                                                                               


/* ----- CREDITO ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\CRE\'
--'                                                                                                               
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_deudores')          
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_gar_propuesta')     
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_linea')             
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_op_renovar')        
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_tramite')           
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_excepciones')       
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_estacion')          
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_facturas')          
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_instrucciones')     
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_gar_anteriores')    
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_lin_ope_moneda')    
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_pasos')             
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_ruta_tramite')
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_saldo_por_rubro')
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_transaccion_linea')
insert into cat_ex_table values(21, @w_path, 'cob_credito', 'cr_ex_datos_estado_lc')

go


/* ----- GARANTIAS ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\GAR\'
--'                                                                                                           
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_custodia')        
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_poliza')          
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_regdoc')          
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_cliente_garantia')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_cambios_estado')  
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_det_trn')         
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_doctos')          
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_inspeccion')      
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_poliza_asociada') 
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_por_inspeccionar')   
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_tipo_seguro')     
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_transaccion')     
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_bienes')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_rel_bien')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_gravamen')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_bien_realizable')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_saldo_por_rubro')
insert into cat_ex_table values(19, @w_path, 'cob_custodia', 'cu_ex_item')  

go  

/* ----- SIDAC ----- */

declare @w_path varchar(255)
select @w_path = 'C:\proc_E\SID\'
--'
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'af_ex_activo')             
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_bien_recibido')     
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_conceptos_facturas')
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_condiciones')       
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_facturas')          
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_formas_pago')       
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_info_activo')       
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_mensual_activo')    
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_meses_depr')        
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_proveedores')       
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_registros_hijos')   
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_registros_padre')   
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_reporte_pagos')     
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_tipos_mvto')        
insert into cat_ex_table values(48, @w_path, 'cob_sidac', 'sid_ex_conc_movtos')       
go

/* ----- COMEXT ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\CEX\'
--'
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_operacion')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_transaccion')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_detalle_trn')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_fp_negociacion')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_abono')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_pago')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_detalle_pgo')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_negociacion')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_letra')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_valor')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_operacion_rol')
-- INC 21287 Extracción Comercio Exterior: Productos de Comercio Exterior (Verónica Chiliquinga)
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_datos_transf')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_naturaleza_gasto')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_origen_recursos')
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_actividad_economica') 
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_relacion_cca_cex_act') 
insert into cat_ex_table values(9, @w_path, 'cob_comext', 'ce_ex_motivo_op_noreportada')
go


/* ----- SERVICIOS BANCARIOS ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\SBA\'
--'
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_operacion')     
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_productos_neg')
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_rubros_productos')
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_aplica_pagcob')  
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_clientes')
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_impresion_lotes')
insert into cat_ex_table values(42, @w_path, 'cob_sbancarios', 'sb_ex_series_neg')
go


/* ----- PLAZO FIJO ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\PFI\'
--'
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_operacion')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_beneficiario')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_cuotas')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_det_pago')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_cancelacion')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_mov_monet')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_cliente_externo')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_pignoracion')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_plazo')
insert into cat_ex_table values(14, @w_path, 'cob_pfijo', 'pf_ex_tasas')

go


/* ----- TESORERIA ----- */
declare @w_path varchar(255)
select @w_path = 'C:\proc_E\TES\'
--'
insert into cat_ex_table values(12, @w_path, 'cob_tesoreria', 'te_ex_instituto_emisor')

print 'Finaliza cat_ex_table.sql'
go
