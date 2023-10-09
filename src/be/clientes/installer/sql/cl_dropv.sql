/*  Script de eliminacion de vistas del */
/*  modulo de CLIENTES  */


use cobis
go

/* ts_mercado */
print '=====> ts_mercado'
go
if exists (select * from sysobjects where name = 'ts_mercado' )
    DROP VIEW ts_mercado
go

/* ts_alianza */
print '=====> ts_alianza'
go
if exists (select * from sysobjects where name = 'ts_alianza' )
    DROP VIEW ts_alianza
go

/* ts_forma_extractos */
print '=====> ts_forma_extractos'
go
if exists (select * from sysobjects where name = 'ts_forma_extractos' )
    DROP VIEW ts_forma_extractos
go

/* ts_sector */
print '=====> ts_sector'
go
if exists (select * from sysobjects where name = 'ts_sector' )
    DROP VIEW ts_sector
go

/* ts_mala_ref */
print '=====> ts_mala_ref'
go
if exists (select * from sysobjects where name = 'ts_mala_ref' )
    DROP VIEW ts_mala_ref
go

/* ts_estatuto */
print '=====> ts_estatuto'
go
if exists (select * from sysobjects where name = 'ts_estatuto' )
    DROP VIEW ts_estatuto
go

/* ts_objeto */
print '=====> ts_objeto'
go
if exists (select * from sysobjects where name = 'ts_objeto' )
    DROP VIEW ts_objeto
go

/* ts_soc_hecho */
print '=====> ts_soc_hecho'
go
if exists (select * from sysobjects where name = 'ts_soc_hecho' )
    DROP VIEW ts_soc_hecho
go

/* ts_grupo */
print '=====> ts_grupo'
go
if exists (select * from sysobjects where name = 'ts_grupo' )
    DROP VIEW ts_grupo
go

/* ts_direccion */
print '=====> ts_direccion'
go
if exists (select * from sysobjects where name = 'ts_direccion' )
    DROP VIEW ts_direccion
go

/* ts_telefono */
print '=====> ts_telefono'
go
if exists (select * from sysobjects where name = 'ts_telefono' )
    DROP VIEW ts_telefono
go

/* ts_casilla */
print '=====> ts_casilla'
go
if exists (select * from sysobjects where name = 'ts_casilla' )
    DROP VIEW ts_casilla
go

/* ts_referencia */
print '=====> ts_referencia'
go
if exists (select * from sysobjects where name = 'ts_referencia' )
    DROP VIEW ts_referencia
go

/* ts_trabajo */
print '=====> ts_trabajo'
go
if exists (select * from sysobjects where name = 'ts_trabajo' )
    DROP VIEW ts_trabajo
go

/* ts_relacion */
print '=====> ts_relacion'
go
if exists (select * from sysobjects where name = 'ts_relacion' )
    DROP VIEW ts_relacion
go

/* ts_aut_sarlaft_lista */
print '=====> ts_aut_sarlaft_lista'
go
if exists (select * from sysobjects where name = 'ts_aut_sarlaft_lista' )
    DROP VIEW ts_aut_sarlaft_lista
go

/* ts_balance */
print '=====> ts_balance'
go
if exists (select * from sysobjects where name = 'ts_balance' )
    DROP VIEW ts_balance
go

/* ts_plan */
print '=====> ts_plan'
go
if exists (select * from sysobjects where name = 'ts_plan' )
    DROP VIEW ts_plan
go

/* ts_cuenta */
print '=====> ts_cuenta'
go
if exists (select * from sysobjects where name = 'ts_cuenta' )
    DROP VIEW ts_cuenta
go

/* ts_tplan */
print '=====> ts_tplan'
go
if exists (select * from sysobjects where name = 'ts_tplan' )
    DROP VIEW ts_tplan
go

/* ts_estatuto_com */
print '=====> ts_estatuto_com'
go
if exists (select * from sysobjects where name = 'ts_estatuto_com' )
    DROP VIEW ts_estatuto_com
go

/* ts_objeto_com */
print '=====> ts_objeto_com'
go
if exists (select * from sysobjects where name = 'ts_objeto_com' )
    DROP VIEW ts_objeto_com
go

/* ts_otros_ingresos */
print '=====> ts_otros_ingresos'
go
if exists (select * from sysobjects where name = 'ts_otros_ingresos' )
    DROP VIEW ts_otros_ingresos
go

/* ts_covinco */
print '=====> ts_covinco'
go
if exists (select * from sysobjects where name = 'ts_covinco' )
    DROP VIEW ts_covinco
go

/* ts_area_inf */
print '=====> ts_area_inf'
go
if exists (select * from sysobjects where name = 'ts_area_inf' )
    DROP VIEW ts_area_inf
go

/* ts_narcos */
print '=====> ts_narcos'
go
if exists (select * from sysobjects where name = 'ts_narcos' )
    DROP VIEW ts_narcos
go

/* ts_actividad_sector */
print '=====> ts_actividad_sector'
go
if exists (select * from sysobjects where name = 'ts_actividad_sector' )
    DROP VIEW ts_actividad_sector
go

/* ts_cia_liquidacion */
print '=====> ts_cia_liquidacion'
go
if exists (select * from sysobjects where name = 'ts_cia_liquidacion' )
    DROP VIEW ts_cia_liquidacion
go

/* ts_def_tablas */
print '=====> ts_def_tablas'
go
if exists (select * from sysobjects where name = 'ts_def_tablas' )
    DROP VIEW ts_def_tablas
go

/* ts_def_campos */
print '=====> ts_def_campos'
go
if exists (select * from sysobjects where name = 'ts_def_campos' )
    DROP VIEW ts_def_campos
go

/* ts_aplica_tipo_persona */
print '=====> ts_aplica_tipo_persona'
go
if exists (select * from sysobjects where name = 'ts_aplica_tipo_persona' )
    DROP VIEW ts_aplica_tipo_persona
go

/* ts_historico_vinculos */
print '=====> ts_historico_vinculos'
go
if exists (select * from sysobjects where name = 'ts_historico_vinculos' )
    DROP VIEW ts_historico_vinculos
go

/* ts_cliente_grupo */
print '=====> ts_cliente_grupo'
go
if exists (select * from sysobjects where name = 'ts_cliente_grupo' )
    DROP VIEW ts_cliente_grupo
go

/* ts_natjur */
print '=====> ts_natjur'
go
if exists (select * from sysobjects where name = 'ts_natjur' )
    DROP VIEW ts_natjur
go

/* ts_relacion_inter */
print '=====> ts_relacion_inter'
go
if exists (select * from sysobjects where name = 'ts_relacion_inter' )
    DROP VIEW ts_relacion_inter
go

/* ts_sectoreco */
print '=====> ts_sectoreco'
go
if exists (select * from sysobjects where name = 'ts_sectoreco' )
    DROP VIEW ts_sectoreco
go

/* ts_categoria */
print '=====> ts_categoria'
go
if exists (select * from sysobjects where name = 'ts_categoria' )
    DROP VIEW ts_categoria
go

/* ts_servicio_bandom */
print '=====> ts_servicio_bandom'
go
if exists (select * from sysobjects where name = 'ts_servicio_bandom' )
    DROP VIEW ts_servicio_bandom
go

/* ts_bandom */
print '=====> ts_bandom'
go
if exists (select * from sysobjects where name = 'ts_bandom' )
    DROP VIEW ts_bandom
go

/* ts_rango_empleo */
print '=====> ts_rango_empleo'
go
if exists (select * from sysobjects where name = 'ts_rango_empleo' )
    DROP VIEW ts_rango_empleo
go

/* ts_rango_actividad */
print '=====> ts_rango_actividad'
go
if exists (select * from sysobjects where name = 'ts_rango_actividad' )
    DROP VIEW ts_rango_actividad
go

/* ts_alerta */
print '=====> ts_alerta'
go
if exists (select * from sysobjects where name = 'ts_alerta' )
    DROP VIEW ts_alerta
go

/* ts_forma_homologa */
print '=====> ts_forma_homologa'
go
if exists (select * from sysobjects where name = 'ts_forma_homologa' )
    DROP VIEW ts_forma_homologa
go

/* ts_tipos_de_documentos */
print '=====> ts_tipos_de_documentos'
go
if exists (select * from sysobjects where name = 'ts_tipos_de_documentos' )
    DROP VIEW ts_tipos_de_documentos
go

/* ts_fecha_tipo_doc */
print '=====> ts_fecha_tipo_doc'
go
if exists (select * from sysobjects where name = 'ts_fecha_tipo_doc' )
    DROP VIEW ts_fecha_tipo_doc
go

/* ts_rango_tipo_doc */
print '=====> ts_rango_tipo_doc'
go
if exists (select * from sysobjects where name = 'ts_rango_tipo_doc' )
    DROP VIEW ts_rango_tipo_doc
go

/* ts_promedio_producto */
print '=====> ts_promedio_producto'
go
if exists (select * from sysobjects where name = 'ts_promedio_producto' )
    DROP VIEW ts_promedio_producto
go

/* ts_balance_tmp */
print '=====> ts_balance_tmp'
go
if exists (select * from sysobjects where name = 'ts_balance_tmp' )
    DROP VIEW ts_balance_tmp
go

/* ts_dat_merc_ente */
print '=====> ts_dat_merc_ente'
go
if exists (select * from sysobjects where name = 'ts_dat_merc_ente' )
    DROP VIEW ts_dat_merc_ente
go

/* ts_at_instancia */
print '=====> ts_at_instancia'
go
if exists (select * from sysobjects where name = 'ts_at_instancia' )
    DROP VIEW ts_at_instancia
go

/* ts_at_relacion */
print '=====> ts_at_relacion'
go
if exists (select * from sysobjects where name = 'ts_at_relacion' )
    DROP VIEW ts_at_relacion
go

/* ts_atributo */
print '=====> ts_atributo'
go
if exists (select * from sysobjects where name = 'ts_atributo' )
    DROP VIEW ts_atributo
go

/* ts_contacto */
print '=====> ts_contacto'
go
if exists (select * from sysobjects where name = 'ts_contacto' )
    DROP VIEW ts_contacto
go

/* ts_det_embargo */
print '=====> ts_det_embargo'
go
if exists (select * from sysobjects where name = 'ts_det_embargo' )
    DROP VIEW ts_det_embargo
go

/* ts_instancia */
print '=====> ts_instancia'
go
if exists (select * from sysobjects where name = 'ts_instancia' )
    DROP VIEW ts_instancia
go

/* ts_objeto_tmp */
print '=====> ts_objeto_tmp'
go
if exists (select * from sysobjects where name = 'ts_objeto_tmp' )
    DROP VIEW ts_objeto_tmp
go

/* ts_oficna_ente */
print '=====> ts_oficna_ente'
go
if exists (select * from sysobjects where name = 'ts_oficna_ente' )
    DROP VIEW ts_oficna_ente
go

/* ts_mercado_objetivo_cliente */
print '=====> ts_mercado_objetivo_cliente'
go
if exists (select * from sysobjects where name = 'ts_mercado_objetivo_cliente' )
    DROP VIEW ts_mercado_objetivo_cliente
go

/* ts_tbalance */
print '=====> ts_tbalance'
go
if exists (select * from sysobjects where name = 'ts_tbalance' )
    DROP VIEW ts_tbalance
go

/* ts_tbl_inf */
print '=====> ts_tbl_inf'
go
if exists (select * from sysobjects where name = 'ts_tbl_inf' )
    DROP VIEW ts_tbl_inf
go

/* ts_traslado_alerta */
print '=====> ts_traslado_alerta'
go
if exists (select * from sysobjects where name = 'ts_traslado_alerta' )
    DROP VIEW ts_traslado_alerta
go

/* ts_cab_embargo */
print '=====> ts_cab_embargo'
go
if exists (select * from sysobjects where name = 'ts_cab_embargo' )
    DROP VIEW ts_cab_embargo
go

/* ts_traslado_producto */
print '=====> ts_traslado_producto'
go
if exists (select * from sysobjects where name = 'ts_traslado_producto' )
    DROP VIEW ts_traslado_producto
go

/* cl_economica */
print '=====> cl_economica'
go
if exists (select * from sysobjects where name = 'cl_economica' )
    DROP VIEW cl_economica
go

/* cl_tarjeta */
print '=====> cl_tarjeta'
go
if exists (select * from sysobjects where name = 'cl_tarjeta' )
    DROP VIEW cl_tarjeta
go

/* ts_ref_personal */
print '=====> ts_ref_personal'
go
if exists (select * from sysobjects where name = 'ts_ref_personal' )
    DROP VIEW ts_ref_personal
go

/* cl_comercial */
print '=====> cl_comercial'
go
if exists (select * from sysobjects where name = 'cl_comercial' )
    DROP VIEW cl_comercial
go

/* ts_familia */
print '=====> ts_familia'
go
if exists (select * from sysobjects where name = 'ts_familia' )
    DROP VIEW ts_familia
go

/* cl_financiera */
print '=====> cl_financiera'
go
if exists (select * from sysobjects where name = 'cl_financiera' )
    DROP VIEW cl_financiera
go

/* ts_viabilidad */
print '=====> ts_viabilidad'
go
if exists (select * from sysobjects where name = 'ts_viabilidad' )
    DROP VIEW ts_viabilidad
go

/* ts_referenciacion */
print '=====> ts_referenciacion'
go
if exists (select * from sysobjects where name = 'ts_referenciacion' )
    DROP VIEW ts_referenciacion
go

/* ts_propiedad */
print '=====> ts_propiedad'
go
if exists (select * from sysobjects where name = 'ts_propiedad' )
    DROP VIEW ts_propiedad
go

/* ts_persona */
print '=====> ts_persona'
go
if exists (select * from sysobjects where name = 'ts_persona' )
    DROP VIEW ts_persona
go

/* ts_origen_fondos */
print '=====> ts_origen_fondos'
go
if exists (select * from sysobjects where name = 'ts_origen_fondos' )
    DROP VIEW ts_origen_fondos
go

/* ts_compania */
print '=====> ts_compania'
go
if exists (select * from sysobjects where name = 'ts_compania' )
    DROP VIEW ts_compania
go

/* cl_persona */
print '=====> cl_persona'
go
if exists (select * from sysobjects where name = 'cl_persona' )
    DROP VIEW cl_persona
go


/* cl_compania */
print '=====> cl_compania'
go
if exists (select * from sysobjects where name = 'cl_compania' )
    DROP VIEW cl_compania
go

/* ts_CNB */
print '=====> ts_CNB'
go
if exists (select * from sysobjects where name = 'ts_CNB' )
    DROP VIEW ts_CNB
go

/* ts_alertas_zonal */
print '=====> ts_alertas_zonal'
go
if exists (select * from sysobjects where name = 'ts_alertas_zonal' )
    DROP VIEW ts_alertas_zonal
go

/* ts_refinh */
print '=====> ts_refinh'
go
if exists (select * from sysobjects where name = 'ts_refinh' )
    DROP VIEW ts_refinh
go

