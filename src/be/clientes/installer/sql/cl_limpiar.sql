/*	Script para LIMPIEZA de tablas del	*/
/*	modulo de CLIENTES */

use cobis
go

truncate table cl_actbalance_conv
go
truncate table cl_actdir_conv
go
truncate table cl_actdirpro_conv
go
truncate table cl_actente_conv
go
truncate table cl_actlegal_conv
go
truncate table cl_actualiza
go
truncate table cl_alerta
go
truncate table cl_aplica_tipo_persona
go
truncate table cl_aplica_tipo_persona2
go
truncate table cl_archivos_cargados_mig
go
truncate table cl_area_influencia
go
truncate table cl_asoc_clte_serv
go
truncate table cl_asociacion_actividad
go
truncate table cl_at_instancia
go
truncate table cl_at_relacion
go
truncate table cl_atr_tbl_inf
go
truncate table cl_atr_valores
go
truncate table cl_atributo
go
truncate table cl_balance
go
truncate table cl_balance_tmp
go
truncate table cl_banco_rem
go
truncate table cl_bandom
go
truncate table cl_cab_embargo
go
truncate table cl_casilla
go
truncate table cl_categoria
go
truncate table cl_cifin
go
truncate table cl_cli_masiva
go
truncate table cl_cliente
go
truncate table cl_cliente_grupo
go
truncate table cl_cliente_no_cobis
go
truncate table cl_com_liquidacion
go
truncate table cl_consulta_masiva
go
truncate table cl_contacto
go
truncate table cl_cov_error
go
truncate table cl_covinco
go
truncate table cl_cuenta
go
truncate table cl_dat_merc_ente
go
truncate table cl_def_grupo
go
truncate table cl_det_embargo
go
truncate table cl_det_producto
go
truncate table cl_det_producto_no_cobis
go
truncate table cl_det_producto_no_cobis_tmp
go
truncate table cl_detalle_maestro
go
truncate table cl_dgarantia
go
truncate table cl_dgeobanca
go
truncate table cl_dgeografica
go
truncate table cl_direccion
go
truncate table cl_direccion_mig
go
truncate table cl_ejecutivo
go
truncate table cl_elimina_ente_log
go
truncate table cl_ente
go
truncate table cl_ente_masivo_mig
go
truncate table cl_ente_mig
go
truncate table cl_equivalencia_ws
go
truncate table cl_error_datosente
go
truncate table cl_error_elimente_log
go
truncate table cl_error_log
go
truncate table cl_error_mig
go
truncate table cl_errores_mig
go
truncate table cl_errores_migracion
go
truncate table cl_est_convivencia
go
truncate table cl_estatuto_com
go
truncate table cl_estatuto_tmp
go
truncate table cl_estructura_tabla
go
truncate table cl_forma_homologa
go
truncate table cl_func_correo
go
truncate table cl_garantia
go
truncate table cl_grupo
go
truncate table cl_hijos
go
truncate table cl_his_ejecutivo
go
truncate table cl_his_relacion
go
truncate table cl_historico_vinculos
go
truncate table cl_inh_error
go
truncate table cl_instancia
go
truncate table cl_interfaz_tarjeta
go
truncate table cl_lista_clinton
go
truncate table cl_log_errores_mig
go
truncate table cl_log_fiscal
go
truncate table cl_log_homdir
go
truncate table cl_maestro_cliente
go
truncate table cl_mala_ref
go
truncate table cl_mercado
go
truncate table cl_mercado_error
go
truncate table cl_mercado_objetivo_cliente
go
truncate table cl_mercado_objetivo_mig
go
truncate table cl_mercado_tmp
go
truncate table cl_mobj_subtipo
go
truncate table cl_mod_central_riesgo
go
truncate table cl_narcos_error
go
truncate table cl_nat_jur
go
truncate table cl_notaria_ciudad
go
truncate table cl_nov_cli
go
truncate table cl_objeto_com
go
truncate table cl_objeto_tmp
go
truncate table cl_oficial_funcionario
go
truncate table cl_origen_fondos
go
truncate table cl_otros_ingresos
go
truncate table cl_perfil
go
truncate table cl_plan
go
truncate table cl_plan_tmp
go
truncate table cl_plano_consulta
go
truncate table cl_plano_ente_tmp
go
truncate table cl_propiedad
go
truncate table cl_rango_actividad
go
truncate table cl_rango_empleo
go
truncate table cl_ref_personal
go
truncate table cl_referencia
go
truncate table cl_refinh
go
truncate table cl_refinh_tmp
go
truncate table cl_relacion
go
truncate table cl_relacion_inter
go
truncate table cl_rep_faltan_datos
go
truncate table cl_sectoreco
go
truncate table cl_servicio
go
truncate table cl_servicio_bandom
go
truncate table cl_soc_hecho
go
truncate table cl_tbalance
go
truncate table cl_tbl_inf
go
truncate table cl_telefono
go
truncate table cl_telefono_mig
go
truncate table cl_tiempo_mig
go
truncate table cl_tipo_documento
go
truncate table cl_tmp_fiduciaria
go
truncate table cl_total_entes_log
go
truncate table cl_tplan
go
truncate table cl_tplan_tmp
go
truncate table cl_trabajo
go
truncate table cl_tran_bloqueada
go
truncate table cl_tran_servicio_conv
go
truncate table cl_tran_servicio_conv_dir
go
truncate table cl_tran_servicio_conv_mer
go
truncate table cl_tran_servicio_conv_tel
go
truncate table cl_trn_bandom
go
truncate table cl_ws_alerta_tmp
go
truncate table cl_ws_ente_tmp
go
truncate table mig_cifin
go
truncate table productos_tmp
go
truncate table rp_consolidacion
go
truncate table rp_consolidacion_no_cli
go


update cl_seqnos
set siguiente = 0
where tabla = 'cl_asoc_clte_serv'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_atr_tbl_inf'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_atr_valores'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_det_producto'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_ente'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_grupo'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_mercado'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_refinh'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_relacion'
go
update cl_seqnos
set siguiente = 0
where tabla = 'cl_tbl_inf'
go



