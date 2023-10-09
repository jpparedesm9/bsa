/***********************************************************************/
/*     Archivo:                   cu_trans.sql                         */
/*     Base de Datos:             cob_custodia                         */
/*     Producto:                  Garantias                            */
/*     Fecha de Documentacion:    27-Oct-2004                          */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de     */
/*   'MACOSA',representantes exclusivos para el Ecuador de la AT&T     */
/*   Su uso no autorizado queda expresamente prohibido asi como        */
/*   cualquier autorizacion o agregado hecho por alguno de sus         */
/*   usuario sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante                */
/***********************************************************************/
/*                          PROPOSITO                                  */
/*   Creacion de Transacciones, Procedimientos                         */
/***********************************************************************/

use cobis
go

print 'Comienzo cu_trans'
print '***  ad_rol .....(Creacion de rol MENU POR PROCESOS)'


declare @w_rol  smallint,
        @w_moneda  tinyint

if not exists (select 1 from ad_rol
                where ro_descripcion = 'MENU POR PROCESOS'
                  and ro_filial = 1)
begin
   select @w_rol = max(ro_rol) + 1
     from ad_rol
    where ro_filial = 1

   update cl_seqnos
      set siguiente = @w_rol
    where tabla = 'ad_rol'

   insert into ad_rol
   (ro_rol,ro_filial,ro_descripcion,ro_fecha_crea,ro_creador,
   ro_estado,ro_fecha_ult_mod)
   values (@w_rol,1,'MENU POR PROCESOS',getdate(),1,'V',getdate())
end
else begin
   print 'Ya existe el rol MENU POR PROCESOS'
end


/*    Asignacion de productos al rol Administrador de Custodia */

print '***  ad_pro_rol .....(Asignacion de productos a MENU POR PROCESOS)'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
   and ro_filial = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete ad_pro_rol
 where pr_rol = @w_rol
   and pr_producto in (19,21,1,2,6,7,8)
   and pr_moneda = @w_moneda

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 19, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 21, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 1, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 2, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 6, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 7, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 8, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)

/* Creacion de Stored Procedures */
delete ad_procedure
 where pd_procedure in (19000,19001,19002,19003,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,19014,19015,19016,19017,19018,19019,19020,
                        19021,19022,19023,19024,19025,19026,19027,19028,19029,19030,19031,19032,19033,19034,19035,19036,19037,19038,19039,19040,19041,
                        19042,19043,19044,19045,19046,19047,19048,19049,19050,19051,19052,19053,19054,19055,19056,19057,19058,19059,19060,19061,19062,
                        19063,19064,19065,19066,19067,19068,19069,19070,19071,19072,19073,19074,19075,19076,19077,19078,19084,19085,19092,19093,19100,
                        19500,19800,19801,19802,19803,19804,19805,19806,19807,19808,19809,19810,19811,19812,19813)
   and pd_base_datos = 'cob_custodia'
go

print ' INICIO DE INGRESO DE STORED PROCEDURES'
insert into ad_procedure values ( 19000, 'sp_transaccion',          'cob_custodia', 'V', getdate(), 'transacc.sp')
insert into ad_procedure values ( 19001, 'sp_almacenera',           'cob_custodia', 'V', getdate(), 'almacen.sp')
insert into ad_procedure values ( 19002, 'sp_recuperacion',         'cob_custodia', 'V', getdate(), 'recupera.sp')
insert into ad_procedure values ( 19003, 'sp_vencimiento',          'cob_custodia', 'V', getdate(), 'vencimie.sp')
insert into ad_procedure values ( 19004, 'sp_cliente_garantia',     'cob_custodia', 'V', getdate(), 'cliente.sp')
insert into ad_procedure values ( 19005, 'sp_item_custodia',        'cob_custodia', 'V', getdate(), 'itemcust.sp')
insert into ad_procedure values ( 19006, 'sp_inspeccion',           'cob_custodia', 'V', getdate(), 'inspecci.sp')
insert into ad_procedure values ( 19007, 'sp_ctrl_inspect',         'cob_custodia', 'V', getdate(), 'ctlinspr.sp')
insert into ad_procedure values ( 19008, 'sp_inspector',            'cob_custodia', 'V', getdate(), 'inspecto.sp')
insert into ad_procedure values ( 19009, 'sp_custodia',             'cob_custodia', 'V', getdate(), 'custodia.sp')
insert into ad_procedure values ( 19010, 'sp_poliza',               'cob_custodia', 'V', getdate(), 'poliza.sp')
insert into ad_procedure values ( 19011, 'sp_item',                 'cob_custodia', 'V', getdate(), 'item.sp')
insert into ad_procedure values ( 19012, 'sp_tipo_custodia',        'cob_custodia', 'V', getdate(), 'tipocust.sp')
insert into ad_procedure values ( 19013, 'sp_sucursal',             'cob_custodia', 'V', getdate(), 'sucursal.sp')
insert into ad_procedure values ( 19014, 'sp_ente_custodia',        'cob_custodia', 'V', getdate(), 'entecust.sp')
insert into ad_procedure values ( 19015, 'sp_moneda',               'cob_custodia', 'V', getdate(), 'moneda.sp')
insert into ad_procedure values ( 19016, 'sp_por_inspeccionar',     'cob_custodia', 'V', getdate(), 'por_insp.sp')
insert into ad_procedure values ( 19017, 'sp_retorna_inspeccion',   'cob_custodia', 'V', getdate(), 'ret_insp.sp')
insert into ad_procedure values ( 19018, 'sp_con_garante',          'cob_custodia', 'V', getdate(), 'congarnt.sp')
insert into ad_procedure values ( 19019, 'sp_con_garop',            'cob_custodia', 'V', getdate(), 'congarop.sp')
insert into ad_procedure values ( 19020, 'sp_con_opgar',            'cob_custodia', 'V', getdate(), 'conopgar.sp')
insert into ad_procedure values ( 19021, 'sp_consulta_garantia',    'cob_custodia', 'V', getdate(), 'con_gara.sp')
insert into ad_procedure values ( 19022, 'sp_monto_garantia',       'cob_custodia', 'V', getdate(), 'montogar.sp')
insert into ad_procedure values ( 19023, 'sp_parametro',            'cob_custodia', 'V', getdate(), 'paramet.sp')
insert into ad_procedure values ( 19024, 'sp_compuesto',            'cob_custodia', 'V', getdate(), 'compuest.sp')
insert into ad_procedure values ( 19025, 'sp_garclien',             'cob_custodia', 'V', getdate(), 'garclien.sp')
insert into ad_procedure values ( 19026, 'sp_gargrupo',             'cob_custodia', 'V', getdate(), 'gargrupo.sp')
insert into ad_procedure values ( 19027, 'sp_virtualg',             'cob_custodia', 'V', getdate(), 'virtualg.sp')
insert into ad_procedure values ( 19028, 'sp_enlace_conta',         'cob_custodia', 'V', getdate(), 'contaenl.sp')
insert into ad_procedure values ( 19029, 'sp_carta_inspeccion',     'cob_custodia', 'V', getdate(), 'cart_ins.sp')
insert into ad_procedure values ( 19030, 'sp_buscar_custodia',      'cob_custodia', 'V', getdate(), 'buscusto.sp')
insert into ad_procedure values ( 19031, 'sp_conta',                'cob_custodia', 'V', getdate(), 'conta.sp')
insert into ad_procedure values ( 19032, 'sp_tipo_conta',           'cob_custodia', 'V', getdate(), 'tipocont.sp')
insert into ad_procedure values ( 19033, 'sp_crgarcli',             'cob_custodia', 'V', getdate(), 'crgarcli.sp')
insert into ad_procedure values ( 19034, 'sp_crtotcli',             'cob_custodia', 'V', getdate(), 'crtotcli.sp')
insert into ad_procedure values ( 19035, 'sp_crtotgru',             'cob_custodia', 'V', getdate(), 'crtotgru.sp')
insert into ad_procedure values ( 19036, 'sp_cropegar',             'cob_custodia', 'V', getdate(), 'cropegar.sp')
insert into ad_procedure values ( 19037, 'sp_deb_automatico',       'cob_custodia', 'V', getdate(), 'debautom.sp')
insert into ad_procedure values ( 19038, 'sp_credito4',             'cob_custodia', 'V', getdate(), 'credito4.sp')
insert into ad_procedure values ( 19039, 'sp_credito5',             'cob_custodia', 'V', getdate(), 'credito5.sp')
insert into ad_procedure values ( 19040, 'sp_credito6',             'cob_custodia', 'V', getdate(), 'credito6.sp')
insert into ad_procedure values ( 19041, 'sp_credito1',             'cob_custodia', 'V', getdate(), 'credito1.sp')
insert into ad_procedure values ( 19042, 'sp_credito2',             'cob_custodia', 'V', getdate(), 'credito2.sp')
insert into ad_procedure values ( 19043, 'sp_credito3',             'cob_custodia', 'V', getdate(), 'credito3.sp')
insert into ad_procedure values ( 19044, 'sp_riesgos',              'cob_custodia', 'V', getdate(), 'riesgos.sp')
insert into ad_procedure values ( 19045, 'sp_consult1',             'cob_custodia', 'V', getdate(), 'consult1.sp')
insert into ad_procedure values ( 19046, 'sp_consult2',             'cob_custodia', 'V', getdate(), 'consult2.sp')
insert into ad_procedure values ( 19047, 'sp_consult3',             'cob_custodia', 'V', getdate(), 'consult3.sp')
insert into ad_procedure values ( 19048, 'sp_custopv',              'cob_custodia', 'V', getdate(), 'custopv.sp')
insert into ad_procedure values ( 19049, 'sp_intcre01',             'cob_custodia', 'V', getdate(), 'intcre01.sp')
insert into ad_procedure values ( 19050, 'sp_intcre02',             'cob_custodia', 'V', getdate(), 'intcre02.sp')
insert into ad_procedure values ( 19051, 'sp_intcre03',             'cob_custodia', 'V', getdate(), 'intcre03.sp')
insert into ad_procedure values ( 19052, 'sp_intcre04',             'cob_custodia', 'V', getdate(), 'intcre04.sp')
insert into ad_procedure values ( 19053, 'sp_intcre05',             'cob_custodia', 'V', getdate(), 'intcre05.sp')
insert into ad_procedure values ( 19054, 'sp_intcre06',             'cob_custodia', 'V', getdate(), 'intcre06.sp')
insert into ad_procedure values ( 19055, 'sp_intcre07',             'cob_custodia', 'V', getdate(), 'intcre07.sp')
insert into ad_procedure values ( 19056, 'sp_vencimi1',             'cob_custodia', 'V', getdate(), 'vencimi1.sp')
insert into ad_procedure values ( 19057, 'sp_recuper1',             'cob_custodia', 'V', getdate(), 'recuper1.sp')
insert into ad_procedure values ( 19058, 'sp_transac1',             'cob_custodia', 'V', getdate(), 'transac1.sp')
insert into ad_procedure values ( 19059, 'sp_inspecc1',             'cob_custodia', 'V', getdate(), 'inspecc1.sp')
insert into ad_procedure values ( 19060, 'sp_riesgos1',             'cob_custodia', 'V', getdate(), 'riesgos1.sp')
insert into ad_procedure values ( 19061, 'sp_riesgos2',             'cob_custodia', 'V', getdate(), 'riesgos2.sp')
insert into ad_procedure values ( 19062, 'sp_cancela',              'cob_custodia', 'V', getdate(), 'cancela.sp')
insert into ad_procedure values ( 19063, 'sp_colateral',            'cob_custodia', 'V', getdate(), 'colatera.sp')
insert into ad_procedure values ( 19064, 'sp_gastos',               'cob_custodia', 'V', getdate(), 'gastos.sp')
insert into ad_procedure values ( 19065, 'sp_gastos1',              'cob_custodia', 'V', getdate(), 'gastos1.sp')
insert into ad_procedure values ( 19066, 'sp_buscolateral',         'cob_custodia', 'V', getdate(), 'buscol.sp')
insert into ad_procedure values ( 19067, 'sp_conpfijo',             'cob_custodia', 'V', getdate(), 'conpfijo.sp')
insert into ad_procedure values ( 19068, 'sp_conconta',             'cob_custodia', 'V', getdate(), 'conconta.sp')
insert into ad_procedure values ( 19069, 'sp_modificacion',         'cob_custodia', 'V', getdate(), 'modifgar.sp')
insert into ad_procedure values ( 19070, 'sp_total_gar',            'cob_custodia', 'V', getdate(), 'totgar.sp')
insert into ad_procedure values ( 19071, 'sp_tran_canje',           'cob_custodia', 'V', getdate(), 'trancanje.sp')
insert into ad_procedure values ( 19072, 'sp_cancela_canje',        'cob_custodia', 'V', getdate(), 'delcanje.sp')
insert into ad_procedure values ( 19073, 'sp_inst_ope',             'cob_custodia', 'V', getdate(), 'inst_ope.sp')
insert into ad_procedure values ( 19074, 'sp_migracion',            'cob_custodia', 'V', getdate(), 'migraci.sp')
insert into ad_procedure values ( 19075, 'sp_items_new',            'cob_custodia', 'V', getdate(), 'itemsnew.sp')
insert into ad_procedure values ( 19076, 'sp_cambios_estado',       'cob_custodia', 'V', getdate(), 'cambesta.sp')
insert into ad_procedure values ( 19077, 'sp_codval_gar',           'cob_custodia', 'V', getdate(), 'codval_gar.')
insert into ad_procedure values ( 19078, 'sp_avaluo',               'cob_custodia', 'V', getdate(), 'cu_avaluo.s')
insert into ad_procedure values ( 19084, 'sp_depedencias',          'cob_custodia', 'V', getdate(), 'cu_depen.sp')
insert into ad_procedure values ( 19085, 'sp_dep_usuario',          'cob_custodia', 'V', getdate(), 'cu_depusu.s')
insert into ad_procedure values ( 19092, 'sp_custodia_garantias',   'cob_custodia', 'V', getdate(), 'cu_cusgar.s')
insert into ad_procedure values ( 19093, 'sp_garantia_custodia',    'cob_custodia', 'V', getdate(), 'cu_garcus.s')
insert into ad_procedure values ( 19100, 'sp_cambio_caracter',      'cob_custodia', 'V', getdate(), 'cambcara.sp')
insert into ad_procedure values ( 19500, 'sp_front_end_cu',         'cob_custodia', 'V', getdate(), 'frontend.sp')
insert into ad_procedure values ( 19800, 'sp_asig_abogado',         'cob_custodia', 'V', getdate(), 'por_abogado.s')
insert into ad_procedure values ( 19801, 'sp_carta_abogado',        'cob_custodia', 'V', getdate(), 'carta_abg.sp')
insert into ad_procedure values ( 19802, 'sp_abg_concepto',         'cob_custodia', 'V', getdate(), 'abgconce.sp')
insert into ad_procedure values ( 19803, 'sp_ctrl_abg',             'cob_custodia', 'V', getdate(), 'ctrlabg.sp')
insert into ad_procedure values ( 19804, 'sp_dat_insp',             'cob_custodia', 'V', getdate(), 'dat_insp.sp')
insert into ad_procedure values ( 19805, 'sp_cons_pol',             'cob_custodia', 'V', getdate(), 'cons_pol.sp')
insert into ad_procedure values ( 19806, 'sp_cons_cond',            'cob_custodia', 'V', getdate(), 'cons_cond.sp')
insert into ad_procedure values ( 19807, 'sp_estados',              'cob_custodia', 'V', getdate(), 'estados.sp')
insert into ad_procedure values ( 19808, 'sp_vigencia',             'cob_custodia', 'V', getdate(), 'vigencia.sp')
insert into ad_procedure values ( 19809, 'sp_trn_gar',              'cob_custodia', 'V', getdate(), 'cutrngar.sp')
insert into ad_procedure values ( 19810, 'sp_consulta_trans',       'cob_custodia', 'V', getdate(), 'constrn.sp')
insert into ad_procedure values ( 19811, 'sp_cambio_valor',         'cob_custodia', 'V', getdate(), 'cambvalor.sp')
insert into ad_procedure values ( 19812, 'sp_cxcobrar',             'cob_custodia', 'V', getdate(), 'cxcobrar.sp')
insert into ad_procedure values ( 19813, 'sp_deb_autom_poliza',     'cob_custodia', 'V', getdate(), 'dbautpol.sp')
go

delete ad_procedure
 where pd_procedure in (19814,19815)
   and pd_base_datos = 'cobis'
go

insert into ad_procedure values ( 19814, 'sp_admisible',            'cobis',        'V', getdate(), 'admperfi.sp')
insert into ad_procedure values ( 19815, 'sp_clase_cartera',        'cobis',        'V', getdate(), 'ccaperfi.sp')
go

delete ad_procedure
 where pd_procedure in (19816,19817,19818)
   and pd_base_datos = 'cob_custodia'
go

insert into ad_procedure values ( 19816, 'sp_deb_autom_abg',        'cob_custodia', 'V', getdate(), 'debabg.sp')
insert into ad_procedure values ( 19817, 'sp_buscar_transaccion',   'cob_custodia', 'V', getdate(), 'bustran.sp')
insert into ad_procedure values ( 19818, 'sp_abogados',             'cob_custodia', 'V', getdate(), 'abogados.sp')
go

delete ad_procedure
 where pd_procedure in (19819)
   and pd_base_datos = 'cobis'
go

insert into ad_procedure values ( 19819, 'sp_tipo_bien',            'cobis',        'V', getdate(), 'tipobien.sp')
go

delete ad_procedure
 where pd_procedure in (19820,19821,19822,19823,19824,19825,19826,19827,19828,19829,19830,19831,19832,19833,19834,19835,19836,19837,19838,19839,19840,
                        19841,19842,19843,19844,19845,19846,19947,19950,19951)
   and pd_base_datos = 'cob_custodia'
go

insert into ad_procedure values ( 19820, 'sp_entidad',              'cob_custodia', 'V', getdate(), 'entidad.sp')
insert into ad_procedure values ( 19821, 'sp_compartida',           'cob_custodia', 'V', getdate(), 'compartida.sp')
insert into ad_procedure values ( 19822, 'sp_arevalorizar',         'cob_custodia', 'V', getdate(), 'arevalor.sp')
insert into ad_procedure values ( 19823, 'sp_fuente',               'cob_custodia', 'V', getdate(), 'fuente.sp')
insert into ad_procedure values ( 19824, 'sp_gar_admisible',        'cob_custodia', 'V', getdate(), 'admisi.sp')
insert into ad_procedure values ( 19825, 'sp_asegura',              'cob_custodia', 'V', getdate(), 'asegura.sp')
insert into ad_procedure values ( 19826, 'sp_documentos',           'cob_custodia', 'V', getdate(), 'documentos.sp')
insert into ad_procedure values ( 19827, 'sp_buscar_documentos',    'cob_custodia', 'V', getdate(), 'busdoc.sp')
insert into ad_procedure values ( 19828, 'sp_agrupar_documentos',   'cob_custodia', 'V', getdate(), 'agrupdoc.sp')
insert into ad_procedure values ( 19829, 'sp_heredar_gar',          'cob_custodia', 'V', getdate(), 'heregar.sp')
insert into ad_procedure values ( 19830, 'sp_estados_garantia',     'cob_custodia', 'V', getdate(), 'estgar.sp')
insert into ad_procedure values ( 19831, 'sp_asignar_estados',      'cob_custodia', 'V', getdate(), 'estasig.sp')
insert into ad_procedure values ( 19832, 'sp_aplicar_vencimiento',  'cob_custodia', 'V', getdate(), 'aplivto.sp')
insert into ad_procedure values ( 19833, 'sp_vencimiento_mig',      'cob_custodia', 'V', getdate(), 'vtomig.sp')
insert into ad_procedure values ( 19834, 'sp_archivos_cargados',    'cob_custodia', 'V', getdate(), 'archcarg.sp')
insert into ad_procedure values ( 19835, 'sp_cerror_mig',           'cob_custodia', 'V', getdate(), 'errormig.sp')
insert into ad_procedure values ( 19836, 'sp_codigo_externo',       'cob_custodia', 'V', getdate(), 'codext.sp')
insert into ad_procedure values ( 19837, 'sp_castigo',              'cob_custodia', 'V', getdate(), 'castigo.sp')
insert into ad_procedure values ( 19838, 'sp_agotada',              'cob_custodia', 'V', getdate(), 'agotada.sp')
insert into ad_procedure values ( 19839, 'sp_pago_avaluador',       'cob_custodia', 'V', getdate(), 'pagoaval.sp')
insert into ad_procedure values ( 19840, 'sp_pago_abogado',         'cob_custodia', 'V', getdate(), 'pagoabog.sp')
insert into ad_procedure values ( 19841, 'sp_cambio_estado_doc',    'cob_custodia', 'V', getdate(), 'camesdo.sp')
insert into ad_procedure values ( 19842, 'sp_cambio_clase',         'cob_custodia', 'V', getdate(), 'camclase.sp')
insert into ad_procedure values ( 19843, 'sp_documen_gar',          'cob_custodia', 'V', getdate(), 'docgar.sp')
insert into ad_procedure values ( 19844, 'sp_observa',              'cob_custodia', 'V', getdate(), 'cu_obs.sp')
insert into ad_procedure values ( 19845, 'sp_clasif_riesgo',        'cob_custodia', 'V', getdate(), 'clasifri.sp')
insert into ad_procedure values ( 19846, 'sp_clase_vehiculo',       'cob_custodia', 'V', getdate(), 'claveh.sp')
insert into ad_procedure values ( 19947, 'sp_administra',           'cob_custodia', 'V', getdate(), 'adminis.sp')
insert into ad_procedure values ( 19950, 'sp_ciudad_porcentaje',    'cob_custodia', 'V', getdate(), 'cu_ciupor.s')
insert into ad_procedure values ( 19951, 'sp_porcentaje_estrato',   'cob_custodia', 'V', getdate(), 'cu_cporest.')
go

/*Fin_Creacion_de_Stored_Procedures*/

/* Creacion de Transacciones */
delete cl_ttransaccion
 where tn_trn_code in (19000,19001,19002,19003,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,19014,19015,19016,19017,19018,19019,19020,
                       19021,19022,19023,19024,19025,19026,19030,19031,19032,19033,19034,19035,19036,19037,19038,19039,19040,19041,19042,19043,19044,
                       19045,19046,19047,19048,19049,19050,19051,19052,19053,19054,19055,19056,19060,19061,19062,19063,19064,19065,19066,19067,19068,
                       19069,19070,19071,19072,19073,19074,19075,19076,19077,19078,19080,19081,19082,19083,19084,19085,19086,19090,19091,19092,19093,
                       19094,19095,19096,19097,19098,19099,19100,19101,19102,19103,19104,19105,19106,19107,19108,19109,19110,19111,19112,19113,19114,
                       19115,19116,19117,19118,19119,19120,19121,19122,19123,19124,19125,19126,19127,19128,19130,19131,19132,19133,19134,19135,19136,
                       19137,19138,19139,19140,19141,19142,19143,19144,19145,19146,19147,19148,19150,19151,19160,19161,19162,19163,19164,19165,19166,
                       19167,19175,19184,19193,19194,19196,19197,19204,19214,19224,19233,19245,19254,19264,19270,19284,19295,19304,19305,19307,19308,
                       19309,19310,19326,19334,19344,19354,19364,19371,19377,19384,19394,19404,19414,19424,19434,19445,19455,19465,19475,19494)
go

print ' INICIO DE INGRESO DE TRANSACCIONES'
insert into cl_ttransaccion values ( 19000, 'Ingreso de transaccion',                         '19000', 'Ingreso de transaccion')
insert into cl_ttransaccion values ( 19001, 'Actualizacion de transaccion',                   '19001', 'Actualizacion de transaccion')
insert into cl_ttransaccion values ( 19002, 'Eliminacion de transaccion',                     '19002', 'Eliminacion de transaccion')
insert into cl_ttransaccion values ( 19003, 'Descripcion de transaccion',                     '19003', 'Descripcion de transaccion')
insert into cl_ttransaccion values ( 19004, 'Busqueda de transacciones',                      '19004', 'Busqueda de transacciones')
insert into cl_ttransaccion values ( 19005, 'Informacion de una transaccion',                 '19005', 'Informacion de una transaccion')
insert into cl_ttransaccion values ( 19006, 'Todas las transacciones',                        '19006', 'Todas las transacciones')
insert into cl_ttransaccion values ( 19007, 'Todos los usuarios',                             '19007', 'Todos los usuarios')
insert into cl_ttransaccion values ( 19008, 'Descripcion del usuario',                        '19008', 'Descripcion del usuario')
insert into cl_ttransaccion values ( 19009, 'Transacciones del usuario',                      '19009', 'Transacciones del usuario')
insert into cl_ttransaccion values ( 19010, 'Ingreso de almacenera',                          '19010', 'Ingreso de almacenera')
insert into cl_ttransaccion values ( 19011, 'Actualizacion de almacenera',                    '19011', 'Actualizacion de almacenera')
insert into cl_ttransaccion values ( 19012, 'Eliminacion de almacenera',                      '19012', 'Eliminacion de almacenera')
insert into cl_ttransaccion values ( 19013, 'Entrega la descripcion dado el codigo',          '19013', 'Entrega la descripcion dado el codigo')
insert into cl_ttransaccion values ( 19014, 'Busqueda de almaceneras',                        '19014', 'Busqueda de almaceneras')
insert into cl_ttransaccion values ( 19015, 'Consulta de almacenera',                         '19015', 'Consulta de almacenera')
insert into cl_ttransaccion values ( 19016, 'Informacion de todas las almaceneras',           '19016', 'Informacion de todas las almaceneras')
insert into cl_ttransaccion values ( 19017, 'Autorizacion para Consulta de Gtias',            '19017', 'Consulta Garantias')
insert into cl_ttransaccion values ( 19018, 'Autoriza Imprimir Gtias',                        '19018', 'Modificacion Garantias')
insert into cl_ttransaccion values ( 19019, 'Autoriza Boton Especificacion Gtias',            '19019', 'Modificacion Garantias')
insert into cl_ttransaccion values ( 19020, 'Ingreso de recuperacion',                        '19020', 'Ingreso de recuperacion')
insert into cl_ttransaccion values ( 19021, 'Actualizacion de recuperacion',                  '19021', 'Actualizacion de recuperacion')
insert into cl_ttransaccion values ( 19022, 'Eliminacion de recuperacion',                    '19022', 'Eliminacion de recuperacion')
insert into cl_ttransaccion values ( 19023, 'Descripcion de la recuperacion',                 '19023', 'Descripcion de la recuperacion')
insert into cl_ttransaccion values ( 19024, 'Busqueda de recuperacion',                       '19024', 'Busqueda de recuperacion')
insert into cl_ttransaccion values ( 19025, 'Consulta de una recuperacion',                   '19025', 'Consulta de una recuperacion')
insert into cl_ttransaccion values ( 19026, 'Todas las recuperaciones',                       '19026', 'Todas las recuperaciones')
insert into cl_ttransaccion values ( 19030, 'Ingreso de vencimientos',                        '19030', 'Ingreso de vencimientos')
insert into cl_ttransaccion values ( 19031, 'Actualizacion de vencimientos',                  '19031', 'Actualizacion de vencimientos')
insert into cl_ttransaccion values ( 19032, 'Eliminacion de vencimientos',                    '19032', 'Eliminacion de vencimientos')
insert into cl_ttransaccion values ( 19033, 'Descripcion de un vencimiento',                  '19033', 'Descripcion de un vencimiento')
insert into cl_ttransaccion values ( 19034, 'Busqueda de vencimientos',                       '19034', 'Busqueda de vencimientos')
insert into cl_ttransaccion values ( 19035, 'Consulta de un vencimiento',                     '19035', 'Consulta de un vencimiento')
insert into cl_ttransaccion values ( 19036, 'Todos los vencimientos',                         '19036', 'Todos los vencimientos')
insert into cl_ttransaccion values ( 19037, 'Verifica las Cuentas',                           '19037', 'Verifica las Cuentas')
insert into cl_ttransaccion values ( 19038, 'Inserta en tablas definitivas',                  '19038', 'Inserta en tablas definitivas')
insert into cl_ttransaccion values ( 19039, 'Carga en tabla temporal',                        '19039', 'Carga en tabla temporal')
insert into cl_ttransaccion values ( 19040, 'Ingreso de clientes',                            '19040', 'Ingreso de clientes')
insert into cl_ttransaccion values ( 19041, 'Actualizacion de clientes',                      '19041', 'Actualizacion de clientes')
insert into cl_ttransaccion values ( 19042, 'Eliminacion de cliente',                         '19042', 'Eliminacion de cliente')
insert into cl_ttransaccion values ( 19043, 'Descripcion de un cliente',                      '19043', 'Descripcion de un cliente')
insert into cl_ttransaccion values ( 19044, 'Busqueda de clientes',                           '19044', 'Busqueda de clientes')
insert into cl_ttransaccion values ( 19045, 'Consulta de un cliente',                         '19045', 'Consulta de un cliente')
insert into cl_ttransaccion values ( 19046, 'Todos los clientes',                             '19046', 'Todos los clientes')
insert into cl_ttransaccion values ( 19047, 'Clientes de la garantia',                        '19047', 'Clientes de la garantia')
insert into cl_ttransaccion values ( 19048, 'Otros Clientes de la garantia',                  '19048', 'Otros Clientes de la garantia')
insert into cl_ttransaccion values ( 19049, 'Autorizacion para Ingreso Gtias',                '19049', 'Ingreso Garantias')
insert into cl_ttransaccion values ( 19050, 'Ingreso de valores de items',                    '19050', 'Ingreso de valores de items')
insert into cl_ttransaccion values ( 19051, 'Actualizacion de valores de items',              '19051', 'Actualizacion de valores de items')
insert into cl_ttransaccion values ( 19052, 'Eliminacion de valores de items',                '19052', 'Eliminacion de valores de items')
insert into cl_ttransaccion values ( 19053, 'Descripcion de items de custodia',               '19053', 'Descripcion de items de custodia')
insert into cl_ttransaccion values ( 19054, 'Busqueda de items de custodia',                  '19054', 'Busqueda de items de custodia')
insert into cl_ttransaccion values ( 19055, 'Consulta de un valor de item',                   '19055', 'Consulta de un valor de item')
insert into cl_ttransaccion values ( 19056, 'Todos los valores de items',                     '19056', 'Todos los valores de items')
insert into cl_ttransaccion values ( 19060, 'Ingreso de inspecciones',                        '19060', 'Ingreso de inspecciones')
insert into cl_ttransaccion values ( 19061, 'Actualizacion de inspecciones',                  '19061', 'Actualizacion de inspecciones')
insert into cl_ttransaccion values ( 19062, 'Elimina inspecciones',                           '19062', 'Elimina inspecciones')
insert into cl_ttransaccion values ( 19063, 'Descripcion de una inspeccion',                  '19063', 'Descripcion de una inspeccion')
insert into cl_ttransaccion values ( 19064, 'Busqueda de inspecciones',                       '19064', 'Busqueda de inspecciones')
insert into cl_ttransaccion values ( 19065, 'Consulta de una inspeccion',                     '19065', 'Consulta de una inspeccion')
insert into cl_ttransaccion values ( 19066, 'Todas las inspecciones',                         '19066', 'Todas las inspecciones')
insert into cl_ttransaccion values ( 19067, 'Inspecciones a cobrar',                          '19067', 'Inspecciones a cobrar')
insert into cl_ttransaccion values ( 19068, 'Inspecciones del Cliente',                       '19068', 'Inspecciones del Cliente')
insert into cl_ttransaccion values ( 19069, 'Inspecciones Cobradas',                          '19069', 'Inspecciones Cobradas')
insert into cl_ttransaccion values ( 19070, 'Ingreso de control de inspector',                '19070', 'Ingreso de control de inspector')
insert into cl_ttransaccion values ( 19071, 'Actualizacion de ctrl de inspector',             '19071', 'Actualizacion de ctrl de inspector')
insert into cl_ttransaccion values ( 19072, 'Eliminacion de ctrl de inspector',               '19072', 'Eliminacion de ctrl de inspector')
insert into cl_ttransaccion values ( 19073, 'Descripcion de ctrl de inspector',               '19073', 'Descripcion de ctrl de inspector')
insert into cl_ttransaccion values ( 19074, 'Busqueda de ctrl de inspector',                  '19074', 'Busqueda de ctrl de inspector')
insert into cl_ttransaccion values ( 19075, 'Consulta de ctrl de inspector',                  '19075', 'Consulta de ctrl de inspector')
insert into cl_ttransaccion values ( 19076, 'Todos los controles de inspector',               '19076', 'Todos los controles de inspector')
insert into cl_ttransaccion values ( 19077, 'Busca prendas por inspeccionar',                 '19077', 'Busca prendas por inspeccionar')
insert into cl_ttransaccion values ( 19078, 'Busca prendas con novedades',                    '19078', 'Busca prendas con novedades')
insert into cl_ttransaccion values ( 19080, 'Ingreso de inspector',                           '19080', 'Ingreso de inspector')
insert into cl_ttransaccion values ( 19081, 'Actualiza inspectores',                          '19081', 'Actualiza inspectores')
insert into cl_ttransaccion values ( 19082, 'Elimina inspectores',                            '19082', 'Elimina inspectores')
insert into cl_ttransaccion values ( 19083, 'Descripcion de un inspector',                    '19083', 'Descripcion de un inspector')
insert into cl_ttransaccion values ( 19084, 'Busqueda de inspectores',                        '19084', 'Busqueda de inspectores')
insert into cl_ttransaccion values ( 19085, 'Consulta de un inspector',                       '19085', 'Consulta de un inspector')
insert into cl_ttransaccion values ( 19086, 'Todos los inspectores',                          '19086', 'Todos los inspectores')
insert into cl_ttransaccion values ( 19090, 'Ingreso de custodias',                           '19090', 'Ingreso de custodias')
insert into cl_ttransaccion values ( 19091, 'Actualizacion de custodias',                     '19091', 'Actualizacion de custodias')
insert into cl_ttransaccion values ( 19092, 'Eliminacion de custodias',                       '19092', 'Eliminacion de custodias')
insert into cl_ttransaccion values ( 19093, 'Descripcion de custodia',                        '19093', 'Descripcion de custodia')
insert into cl_ttransaccion values ( 19094, 'Busqueda de custodias',                          '19094', 'Busqueda de custodias')
insert into cl_ttransaccion values ( 19095, 'Consulta de custodia',                           '19095', 'Consulta de custodia')
insert into cl_ttransaccion values ( 19096, 'Todas las custodias',                            '19096', 'Todas las custodias')
insert into cl_ttransaccion values ( 19097, 'Autorizacion para modificar inspeccion',         '19097', 'Autorizacion para modificar inspeccion')
insert into cl_ttransaccion values ( 19098, 'Autorizacion para modificar suficiencia legal',  '19098', 'Autorizacion para modificar suficiencia legal')
insert into cl_ttransaccion values ( 19099, 'Autorizacion para modificar cobranza judicial',  '19099', 'Autorizacion para modificar cobranza judicial')
insert into cl_ttransaccion values ( 19100, 'Ingreso de poliza',                              '19100', 'Ingreso de poliza')
insert into cl_ttransaccion values ( 19101, 'Actualizacion de poliza',                        '19101', 'Actualizacion de poliza')
insert into cl_ttransaccion values ( 19102, 'Eliminacion de poliza',                          '19102', 'Eliminacion de poliza')
insert into cl_ttransaccion values ( 19103, 'Descripcion de poliza',                          '19103', 'Descripcion de poliza')
insert into cl_ttransaccion values ( 19104, 'Busqueda de polizas',                            '19104', 'Busqueda de polizas')
insert into cl_ttransaccion values ( 19105, 'Consulta de poliza',                             '19105', 'Consulta de poliza')
insert into cl_ttransaccion values ( 19106, 'Todas las polizas',                              '19106', 'Todas las polizas')
insert into cl_ttransaccion values ( 19107, 'Consulta de polizas',                            '19107', 'Consulta de polizas')
insert into cl_ttransaccion values ( 19108, 'Pasar a tabla definitiva',                       '19108', 'Pasar a tabla definitiva')
insert into cl_ttransaccion values ( 19109, 'Cargar a tabla temporal',                        '19109', 'Cargar a tabla temporal')
insert into cl_ttransaccion values ( 19110, 'Ingreso de item',                                '19110', 'Ingreso de item')
insert into cl_ttransaccion values ( 19111, 'Actualizacion de item',                          '19111', 'Actualizacion de item')
insert into cl_ttransaccion values ( 19112, 'Eliminacion de item',                            '19112', 'Eliminacion de item')
insert into cl_ttransaccion values ( 19113, 'Descripcion de un item',                         '19113', 'Descripcion de un item')
insert into cl_ttransaccion values ( 19114, 'Busqueda de items',                              '19114', 'Busqueda de items')
insert into cl_ttransaccion values ( 19115, 'Consulta de un item',                            '19115', 'Consulta de un item')
insert into cl_ttransaccion values ( 19116, 'Todos los items',                                '19116', 'Todos los items')
insert into cl_ttransaccion values ( 19117, 'Busqueda de items con criterios',                '19117', 'Busqueda de items con criterios')
insert into cl_ttransaccion values ( 19118, 'Busqueda de items y valores',                    '19118', 'Busqueda de items y valores')
insert into cl_ttransaccion values ( 19119, 'Busqueda del numero de operacion',               '19119', 'Busqueda del numero de operacion')
insert into cl_ttransaccion values ( 19120, 'Ingreso de Tipo de Custodia',                    '19120', 'Ingreso de Tipo de Custodia')
insert into cl_ttransaccion values ( 19121, 'Actualizacion de Tipo de custodia',              '19121', 'Actualizacion de Tipo de custodia')
insert into cl_ttransaccion values ( 19122, 'Eliminacion de Tipo de Custodia',                '19122', 'Eliminacion de Tipo de Custodia')
insert into cl_ttransaccion values ( 19123, 'Descripcion de Tipo de Custodia',                '19123', 'Descripcion de Tipo de Custodia')
insert into cl_ttransaccion values ( 19124, 'Busqueda de Tipo de Custodia',                   '19124', 'Busqueda de Tipo de Custodia')
insert into cl_ttransaccion values ( 19125, 'Consulta de Tipo de Custodia',                   '19125', 'Consulta de Tipo de Custodia')
insert into cl_ttransaccion values ( 19126, 'Todos los Tipos de Custodia',                    '19126', 'Todos los Tipos de Custodia')
insert into cl_ttransaccion values ( 19127, 'Los Tipos de Custodia Hijos',                    '19127', 'Los Tipos de Custodia Hijos')
insert into cl_ttransaccion values ( 19128, 'Verificacion de Cuenta Contable',                '19128', 'Verifiacion de Cuenta Contable')
insert into cl_ttransaccion values ( 19130, 'Consulta de Sucursal',                           '19130', 'Consulta de Sucursal')
insert into cl_ttransaccion values ( 19131, 'Consulta de Filiales',                           '19131', 'Consulta de Filiales')
insert into cl_ttransaccion values ( 19132, 'Consulta de Sucursales',                         '19132', 'Consulta de Sucursales')
insert into cl_ttransaccion values ( 19133, 'INSERTAR PARAMETRIZACION CODIGO VALOR',          'IPCV',  'INSERTAR PARAMETRIZACION CODIGO VALOR')
insert into cl_ttransaccion values ( 19134, 'ACTUALIZAR PARAMETRIZACION CODIGO VALOR',        'APCV',  'ACTUALIZAR PARAMETRIZACION CODIGO VALOR')
insert into cl_ttransaccion values ( 19135, 'CONSULTAR PARAMETRIZACION CODIGO VALOR',         'CCV',   'CONSULTAR PARAMETRIZACION CODIGO VALOR')
insert into cl_ttransaccion values ( 19136, 'ELIMINAR PARAMETRIZACION CODIGO VALOR',          'EPCV',  'ELIMINAR PARAMETRIZACION CODIGO VALOR')
insert into cl_ttransaccion values ( 19137, 'INSERTAR REGISTRO DE AVALUOS',                   'IRAV',  'INSERTAR REGISTRO DE AVALUOS')
insert into cl_ttransaccion values ( 19138, 'ACTUALIZAR REGISTRO DE AVALUOS',                 'ARAV',  'ACTUALIZAR REGISTRO DE AVALUOS')
insert into cl_ttransaccion values ( 19139, 'CONSULTAR REGISTRO DE AVALUOS',                  'CRAV',  'CONSULTAR REGISTRO DE AVALUOS')
insert into cl_ttransaccion values ( 19140, 'Consulta de Entes',                              '19140', 'Consulta de Entes')
insert into cl_ttransaccion values ( 19141, 'Descripcion de Entes',                           '19141', 'Descripcion de Entes')
insert into cl_ttransaccion values ( 19142, 'Existencia de Cuenta',                           '19142', 'Existencia de Cuenta')
insert into cl_ttransaccion values ( 19143, 'Existencia de Cuenta',                           '19143', 'Existencia de Cuenta')
insert into cl_ttransaccion values ( 19144, 'Busqueda de Cuentas',                            '19144', 'Busqueda de Cuentas')
insert into cl_ttransaccion values ( 19145, 'Busqueda de Oficial',                            '19145', 'Busqueda de Oficial')
insert into cl_ttransaccion values ( 19146, 'Codigo de Oficial',                              '19146', 'Codigo de Oficial')
insert into cl_ttransaccion values ( 19147, 'Todos los Oficiales',                            '19147', 'Todos los Oficiales')
insert into cl_ttransaccion values ( 19148, 'Consulta del Oficial de un Cliente',             '19148', 'Consulta del Oficial de un Cliente')
insert into cl_ttransaccion values ( 19150, 'Todas las monedas',                              '19150', 'Todas las monedas')
insert into cl_ttransaccion values ( 19151, 'Descripcion de la moneda',                       '19151', 'Descripcion de la moneda')
insert into cl_ttransaccion values ( 19160, 'Ingreso de Prendas por Inspeccionar',            '19160', 'Ingreso de Prendas por Inspeccionar')
insert into cl_ttransaccion values ( 19161, 'Actualizacion de Prendas por inspeccionar',      '19161', 'Actualizacion de Prendas por inspeccionar')
insert into cl_ttransaccion values ( 19162, 'Eliminacion de Prendas por inspeccionar',        '19162', 'Eliminacion de Prendas por inspeccionar')
insert into cl_ttransaccion values ( 19163, 'Descripcion de Prendas por Inspeccionar',        '19163', 'Descripcion de Prendas por Inspeccionar')
insert into cl_ttransaccion values ( 19164, 'Busqueda de Prendas por inspeccionar',           '19164', 'Busqueda de Prendas por inspeccionar')
insert into cl_ttransaccion values ( 19165, 'Consulta de Prendas por inspeccionar',           '19165', 'Consulta de Prendas por Inspeccionar')
insert into cl_ttransaccion values ( 19166, 'Todos las Prendas por inspeccionar',             '19166', 'Todos las prendas por inspeccionar')
insert into cl_ttransaccion values ( 19167, 'Las Prendas por inspeccionar',                   '19167', 'Las Prendas por inspeccionar')
insert into cl_ttransaccion values ( 19175, 'Retorno de la ultima inspeccion',                '19175', 'Retorno de la ultima inspeccion')
insert into cl_ttransaccion values ( 19184, 'Consulta de garantias por garante',              '19184', 'Consulta de garantias por garante')
insert into cl_ttransaccion values ( 19193, 'Descripcion de producto',                        '19193', 'Descripcion de producto')
insert into cl_ttransaccion values ( 19194, 'Consulta de garantias de una operacion',         '19194', 'Consulta de garantias de una operacion')
insert into cl_ttransaccion values ( 19196, 'Consulta de productos Cobis',                    '19196', 'Consulta de productos Cobis')
insert into cl_ttransaccion values ( 19197, 'Consulta de Operaciones',                        '19197', 'Consulta de Operaciones')
insert into cl_ttransaccion values ( 19204, 'Consulta de operaciones de una garantia',        '19204', 'Consulta de operaciones de una garantia')
insert into cl_ttransaccion values ( 19214, 'Consulta de garantias para Credito',             '19214', 'Consulta de garantias para Credito')
insert into cl_ttransaccion values ( 19224, 'Consulta de montos de garantias',                '19224', 'Consulta de montos de garantias')
insert into cl_ttransaccion values ( 19233, 'Valor del parametro',                            '19233', 'Valor del parametro')
insert into cl_ttransaccion values ( 19245, 'Descomposicion del codigo de la garantia',       '19245', 'Descomposicion del codigo de la garantia')
insert into cl_ttransaccion values ( 19254, 'Total de garantias de un cliente',               '19254', 'Total de garantias de un cliente')
insert into cl_ttransaccion values ( 19264, 'Total de garantias de un grupo',                 '19264', 'Total de garantias de un grupo')
insert into cl_ttransaccion values ( 19270, 'Autorizacion para modificar estado de garantia', '19270', 'Autorizacion para modificar estado de garantia')
insert into cl_ttransaccion values ( 19284, 'Enlace con Contabilidad',                        '19284', 'Enlace con Contabilidad')
insert into cl_ttransaccion values ( 19295, 'Carta para Inspeccion',                          '19295', 'Carta para Inspeccion')
insert into cl_ttransaccion values ( 19304, 'Buscar Custodias',                               '19304', 'Buscar Custodias')
insert into cl_ttransaccion values ( 19305, 'Buscar Custodias con Operaciones',               '19305', 'Buscar Custodias con Operaciones')
insert into cl_ttransaccion values ( 19307, 'Buscar Clientes',                                '19307', 'Buscar Clientes')
insert into cl_ttransaccion values ( 19308, 'Busqueda General de Garantias',                  '19308', 'Busqueda General de Garantias')
insert into cl_ttransaccion values ( 19309, 'Descripcion de una Garantia',                    '19309', 'Descripcion de una Garantia')
insert into cl_ttransaccion values ( 19310, 'Ingreso de Total Contable',                      '19310', 'Ingreso de Total Contable')
insert into cl_ttransaccion values ( 19326, 'Tipos de garantias',                             '19326', 'Tipos de garantias')
insert into cl_ttransaccion values ( 19334, 'Garantias del Cliente',                          '19334', 'Garantias del Cliente')
insert into cl_ttransaccion values ( 19344, 'Total de Garantias del Cliente',                 '19344', 'Total de Garantias del Cliente')
insert into cl_ttransaccion values ( 19354, 'Total de Garantias del Grupo',                   '19354', 'Total de Garantias del Grupo')
insert into cl_ttransaccion values ( 19364, 'Operaciones de las garantias',                   '19364', 'Operaciones de las garantias')
insert into cl_ttransaccion values ( 19371, 'Notas de Debito automaticas',                    '19371', 'Notas de Debito automaticas')
insert into cl_ttransaccion values ( 19377, 'Reverso Notas de Debito automaticas',            '19377', 'Reverso Notas de Debito automaticas')
insert into cl_ttransaccion values ( 19384, 'Situacion actual de un cliente',                 '19384', 'Situacion actual de un cliente')
insert into cl_ttransaccion values ( 19394, 'Situacion actual de un grupo',                   '19394', 'Situacion actual de un grupo')
insert into cl_ttransaccion values ( 19404, 'Operaciones garantizadas por clientes',          '19404', 'Operaciones garantizadas por clientes')
insert into cl_ttransaccion values ( 19414, 'Consulta de Credito Garantias por Cliente',      '19414', 'Consulta de Credito Garantias por Cliente')
insert into cl_ttransaccion values ( 19424, 'Consulta de garantias por grupo',                '19424', 'Consulta de garantias por grupo')
insert into cl_ttransaccion values ( 19434, 'Consulta desglosada de una garantia',            '19434', 'Consulta desglosada de una garantia')
insert into cl_ttransaccion values ( 19445, 'Consulta de los Riesgos de una garantia',        '19445', 'Consulta de los Riesgos de una garantia')
insert into cl_ttransaccion values ( 19455, 'Consulta rapida de una garantia',                '19455', 'Consulta rapida de una garantia')
insert into cl_ttransaccion values ( 19465, 'Consulta rapida de items de una garantia',       '19465', 'Consulta rapida de items de una garantia')
insert into cl_ttransaccion values ( 19475, 'Consulta rapida de riesgos de una garantia',     '19475', 'Consulta rapida de riesgos de una garantia')
insert into cl_ttransaccion values ( 19494, 'Consulta para Credito de totales del cliente',   '19494', 'Consulta para Credito de totales del cliente')
go

/**************** INICIO - TRANSACCIONES FRONTEND DE GARANTIAS ****************/
delete cl_ttransaccion
 where tn_trn_code in (19506,19505,19507,19508,19509,19510,19511,19512,19513,19515,19516,19517,19518,19520,19521,19522,19523,19525,19526,19527,19528,
                       19529,19530,19531,19532,19533,19535,19536,19537,19538,19539,19540,19541,19542,19543,19545,19546,19547,19548,19549,19550,19551,
                       19985)
go


insert into cl_ttransaccion values ( 19506, 'Garantias\Garantia\Ingreso\Historico Documentos',                    '19506', 'Garantias\Garantia\Ingreso\Historico Documentos' )
insert into cl_ttransaccion values ( 19505, 'Garantias\Garantia\Ingreso\Polizas',                                 '19505', 'Garantias\Garantia\Ingreso\Polizas' )
insert into cl_ttransaccion values ( 19507, 'Garantias\Garantia\Cambio Clase\Ingresar',                           '19507', 'Garantias\Garantia\Cambio Clase\Ingresar' )
insert into cl_ttransaccion values ( 19508, 'Garantias\Garantia\Cambio Valor\Ingresar',                           '19508', 'Garantias\Garantia\Cambio Valor\Ingresar' )
insert into cl_ttransaccion values ( 19509, 'Garantias\Avaluadores\Orden Servicio',                               '19509', 'Garantias\Avaluadores\Orden Servicio' )
insert into cl_ttransaccion values ( 19510, 'Garantias\Avaluadores\Orden Servicio\Imprimir',                      '19510', 'Garantias\Avaluadores\Orden Servicio\Imprimir' )
insert into cl_ttransaccion values ( 19511, 'Garantias\Avaluadores\Orden Servicio\Archivo',                       '19511', 'Garantias\Avaluadores\Orden Servicio\Archivo' )
insert into cl_ttransaccion values ( 19512, 'Garantias\Avaluadores\Resultado Visitas\Imprimir',                   '19512', 'Garantias\Avaluadores\Resultado Visitas\Imprimir' )
insert into cl_ttransaccion values ( 19513, 'Garantias\Avaluadores\Resultado Visitas\Observacion',                '19513', 'Garantias\Avaluadores\Resultado Visitas\Observacion' )
insert into cl_ttransaccion values ( 19515, 'Garantias\Avaluadores\Resultado Visitas\Aniadir\Transmitir',         '19515', 'Garantias\Avaluadores\Resultado Visitas\Aniadir\Transmitir' )
insert into cl_ttransaccion values ( 19516, 'Garantias\Avaluadores\Pago Avaluadores',                             '19516', 'Garantias\Avaluadores\Pago Avaluadores' )
insert into cl_ttransaccion values ( 19517, 'Garantias\Avaluadores\Pago Avaluadores\Aplicar',                     '19517', 'Garantias\Avaluadores\Pago Avaluadores\Aplicar' )
insert into cl_ttransaccion values ( 19518, 'Garantias\Consultas\General Garantias',                              '19518', 'Garantias\Consultas\General Garantias' )
insert into cl_ttransaccion values ( 19520, 'Garantias\Consultas\Garantias Especiales\Buscar',                    '19520', 'Garantias\Consultas\Garantias Especiales\Buscar' )
insert into cl_ttransaccion values ( 19521, 'Garantias\Consultas\Estado Cuenta\Imprimir',                         '19521', 'Garantias\Consultas\Estado Cuenta\Imprimir' )
insert into cl_ttransaccion values ( 19522, 'Garantias\Consultas\Garantia Operacion',                             '19522', 'Garantias\Consultas\Garantia Operacion' )
insert into cl_ttransaccion values ( 19523, 'Garantias\Consultas\Obligacion Operacion',                           '19523', 'Garantias\Consultas\Obligacion Operacion' )
insert into cl_ttransaccion values ( 19525, 'Garantias\Consultas\Obligacion Operacion\Buscar',                    '19525', 'Garantias\Consultas\Obligacion Operacion\Buscar' )
insert into cl_ttransaccion values ( 19526, 'Garantias\Consultas\Garantias vs Obligacion',                        '19526', 'Garantias\Consultas\Garantias vs Obligacion' )
insert into cl_ttransaccion values ( 19527, 'Garantias\Consultas\Garantias vs Obligacion\Buscar',                 '19527', 'Garantias\Consultas\Garantias vs Obligacion\Buscar' )
insert into cl_ttransaccion values ( 19528, 'Garantias\Consultas\Consulta Poliza\Buscar',                         '19528', 'Garantias\Consultas\Consulta Poliza\Buscar' )
insert into cl_ttransaccion values ( 19529, 'Garantias\Consultas\Control Avaluadores\Buscar',                     '19529', 'Garantias\Consultas\Control Avaluadores\Buscar' )
insert into cl_ttransaccion values ( 19530, 'Garantias\Consultas\Control Abogados\Buscar',                        '19530', 'Garantias\Consultas\Control Abogados\Buscar' )
insert into cl_ttransaccion values ( 19531, 'Garantias\Administracion\Estados Garantia\Modificar',                '19531', 'Garantias\Administracion\Estados Garantia\Modificar' )
insert into cl_ttransaccion values ( 19532, 'Garantias\Administracion\Estados Garantia\Eliminar',                 '19532', 'Garantias\Administracion\Estados Garantia\Eliminar' )
insert into cl_ttransaccion values ( 19533, 'Garantias\Administracion\Asignacion Garantia\Ingresar',              '19533', 'Garantias\Administracion\Asignacion Garantia\Ingresar' )
insert into cl_ttransaccion values ( 19535, 'Garantias\Administracion\Asignacion Garantia\Modificar',             '19535', 'Garantias\Administracion\Asignacion Garantia\Modificar' )
insert into cl_ttransaccion values ( 19536, 'Garantias\Administracion\Asignacion Garantia\Editar',                '19536', 'Garantias\Administracion\Asignacion Garantia\Editar' )
insert into cl_ttransaccion values ( 19537, 'Garantias\Administracion\Asignacion Garantia\Eliminar',              '19537', 'Garantias\Administracion\Asignacion Garantia\Eliminar' )
insert into cl_ttransaccion values ( 19538, 'Garantias\Administracion\Porc.Ciudad Estrato\Ingresar',              '19538', 'Garantias\Administracion\Porc.Ciudad Estrato\Ingresar' )
insert into cl_ttransaccion values ( 19539, 'Garantias\Administracion\Porc.Ciudad Estrato\Modificar',             '19539', 'Garantias\Administracion\Porc.Ciudad Estrato\Modificar' )
insert into cl_ttransaccion values ( 19540, 'Garantias\Administracion\Porc.Ciudad Estrato\Editar',                '19540', 'Garantias\Administracion\Porc.Ciudad Estrato\Editar' )
insert into cl_ttransaccion values ( 19541, 'Garantias\Administracion\Porc.Ciudad Estrato\Eliminar',              '19541', 'Garantias\Administracion\Porc.Ciudad Estrato\Eliminar' )
insert into cl_ttransaccion values ( 19542, 'Garantias\Administracion\Porcentaje Ciudad\Editar',                  '19542', 'Garantias\Administracion\Porcentaje Ciudad\Editar' )
insert into cl_ttransaccion values ( 19543, 'Garantias\Administracion\Codigos Valor\Ingresar',                    '19543', 'Garantias\Administracion\Codigos Valor\Ingresar' )
insert into cl_ttransaccion values ( 19545, 'Garantias\Administracion\Codigos Valor\Modificar',                   '19545', 'Garantias\Administracion\Codigos Valor\Modificar' )
insert into cl_ttransaccion values ( 19546, 'Garantias\Administracion\Codigos Valor\Editar',                      '19546', 'Garantias\Administracion\Codigos Valor\Editar' )
insert into cl_ttransaccion values ( 19547, 'Garantias\Administracion\Codigos Valor\Eliminar',                    '19547', 'Garantias\Administracion\Codigos Valor\Eliminar' )
insert into cl_ttransaccion values ( 19548, 'Garantias\Consultas\Instrucciones Opetaivas\Ejecutar',               '19548', 'Garantias\Consultas\Instrucciones Opetaivas\Ejecutar' )
insert into cl_ttransaccion values ( 19549, 'Garantias\Garantia\Ingreso Garantias\Polizas\Transmitir',            '19549', 'Garantias\Garantia\Ingreso Garantias\Polizas\Transmitir' )
insert into cl_ttransaccion values ( 19550, 'Garantias\Consultas\Gral.Garantias\Inst.Operativas\Buscar',          '19550', 'Garantias\Consultas\Gral.Garantias\Inst.Operativas\Buscar' )
insert into cl_ttransaccion values ( 19551, 'Garantias\Administracion\Estados de Garantia\Editar',                '19551', 'Garantias\Administracion\Estados de Garantia\Editar' )
insert into cl_ttransaccion values ( 19985, 'Administración\Porcentajes por Ciudad y Estrato',                    '19985', 'Administración\Porcentajes por Ciudad y Estrato' )
go

/**************** FIN - TRANSACCIONES FRONTEND DE GARANTIAS ****************/

delete cl_ttransaccion
 where tn_trn_code in (19504,19514,19524,19534,19544,19554,19564,19565,19574,19584,19594,19604,19614,19624,19625,19630,19631,19632,19634,19635,19640,
                       19641,19642,19644,19645,19654,19655,19656,19657,19658,19659,19661,19662,19663,19664,19674,19678,19684,19704,19705,19710,19726,
                       19730,19731,19732,19733,19734,19735,19736,19737,19738,19739,19740,19741,19742,19743,19744,19745,19746,19747,19748,19749,19750,
                       19751,19752,19753,19754,19760,19761,19762,19763,19772,19773,19774,19777,19778,19779,19780,19781,19782,19783,19784,19785,19786,
                       19789,19810,19811,19812,19813,19814,19816,19820,19821,19822,19823,19824,19825,19826,19827,19828,19829,19830,19831,19832,19833,
                       19834,19835,19836,19837,19838,19843,19844,19846,19850,19851,19852,19853,19854,19855,19856,19857,19858,19859,19860,19861,19862,
                       19863,19864,19865,19866,19867,19868,19869,19870,19871,19872,19873,19874,19875,19876,19877,19878,19879,19880,19881,19882,19883,
                       19884,19885,19886,19887,19888,19889,19890,19891,19892,19893,19894,19895,19896,19897,19898,19899,19900,19901,19902,19903,19904,
                       19905,19906,19907,19908,19909,19910,19911,19912,19913,19914,19915,19916,19917,19918,19919,19920,19921,19922,19923,19924,19925,
                       19926,19927,19928,19929,19930,19931,19932,19933,19934,19935,19936,19937,19938,19939,19940,19941,19942,19943,19944,19945,19946,
                       19947,19948,19949,19950,19951,19952,19953,19954,19955,19956,19957,19958,19959,19970,19971,19972,19973,19974,19975,19976,19977,
                       19978,19979,19980,19981,19982,19983,19984)
go

insert into cl_ttransaccion values ( 19504, 'Consulta para Credito de totales de garantias registradas',       '19504', 'Consulta para Credito de totales de garantias registradas')
insert into cl_ttransaccion values ( 19514, 'Consulta para Credito de totales de garantias del grupo',         '19514', 'Consulta para Credito de totales de garantias del grupo')
insert into cl_ttransaccion values ( 19524, 'Consulta para Credito de garantias abiertas de un cliente',       '19524', 'Consulta para Credito de garantias abiertas de un cliente')
insert into cl_ttransaccion values ( 19534, 'Consulta para Credito de clientes de un garante',                 '19534', 'Consulta para Credito de clientes de un garante')
insert into cl_ttransaccion values ( 19544, 'Consulta para Credito de Operaciones de garantia cerrada',        '19544', 'Consulta para Credito de Operaciones de garantia cerrada')
insert into cl_ttransaccion values ( 19554, 'Consulta para Credito de Garantias Cerradas de una operacion',    '19554', 'Consulta para Credito de Garantias Cerradas de una operacion')
insert into cl_ttransaccion values ( 19564, 'Consulta de Descripcion y Busqueda de vencimientos',              '19564', 'Consulta de Descripcion y Busqueda de vencimientos')
insert into cl_ttransaccion values ( 19565, 'Consulta de Descripcion y Busqueda de garantia',                  '19565', 'Consulta de Descripcion y Busqueda de garantia')
insert into cl_ttransaccion values ( 19574, 'Consulta de Descripcion y Busqueda de recuperaciones',            '19574', 'Consulta de Descripcion y Busqueda de recuperaciones')
insert into cl_ttransaccion values ( 19584, 'Consulta de Descripcion y Busqueda de transacciones',             '19584', 'Consulta de Descripcion y Busqueda de transacciones')
insert into cl_ttransaccion values ( 19594, 'Consulta de Descripcion y Busqueda de inspecciones',              '19594', 'Consulta de Descripcion y Busqueda de inspecciones')
insert into cl_ttransaccion values ( 19604, 'Consulta de Riesgos tomando en cuenta la operacion',              '19604', 'Consulta de Riesgos tomando en cuenta la operacion')
insert into cl_ttransaccion values ( 19614, 'Consulta de Riesgos de una garantia cerrada',                     '19614', 'Consulta de Riesgos de una garantia cerrada')
insert into cl_ttransaccion values ( 19624, 'Liberacion de garantia',                                          '19624', 'Liberacion de garantia')
insert into cl_ttransaccion values ( 19625, 'Transaccion virtual para Liberacion de garantia',                 '19625', 'Transaccion virtual para Liberacion de garantia')
insert into cl_ttransaccion values ( 19630, 'Ingreso de Garantias Colaterales',                                '19630', 'Ingreso de Garantias Colaterales')
insert into cl_ttransaccion values ( 19631, 'Modificacion de Garantias Colaterales',                           '19631', 'Modificacion de Garantias Colaterales')
insert into cl_ttransaccion values ( 19632, 'Eliminacion de Garantias Colaterales',                            '19632', 'Eliminacion de Garantias Colaterales')
insert into cl_ttransaccion values ( 19634, 'Busqueda de Garantias Colaterales',                               '19634', 'Busqueda de Garantias Colaterales')
insert into cl_ttransaccion values ( 19635, 'Consulta de Garantias Colaterales',                               '19635', 'Consulta de Garantias Colaterales')
insert into cl_ttransaccion values ( 19640, 'Ingreso de Gastos Administrativos',                               '19640', 'Ingreso de Gastos Administrativos')
insert into cl_ttransaccion values ( 19641, 'Modificacion de Gastos Administrativos',                          '19641', 'Modificacion de Gastos Administrativos')
insert into cl_ttransaccion values ( 19642, 'Eliminacion de Gastos Administrativos',                           '19642', 'Eliminacion de Gastos Administrativos')
insert into cl_ttransaccion values ( 19644, 'Busqueda de Gastos Administrativos',                              '19644', 'Busqueda de Gastos Administrativos')
insert into cl_ttransaccion values ( 19645, 'Consulta de Gastos Administrativos',                              '19645', 'Consulta de Gastos Administrativos')
insert into cl_ttransaccion values ( 19654, 'Consulta Rapida de Gastos Administrativos',                       '19654', 'Consulta Rapida de Gastos Administrativos')
insert into cl_ttransaccion values ( 19655, 'Salida de Colaterales',                                           '19655', 'Salida de Colaterales')
insert into cl_ttransaccion values ( 19656, 'Regreso de Colaterales',                                          '19656', 'Regreso de Colaterales')
insert into cl_ttransaccion values ( 19657, 'Consulta de Colaterales',                                         '19657', 'Consulta de Colaterales')
insert into cl_ttransaccion values ( 19658, 'Transmision de Colaterales',                                      '19658', 'Transmision de Colaterales')
insert into cl_ttransaccion values ( 19659, 'Busqueda para Colaterales',                                       '19659', 'Busqueda para Colaterales')
insert into cl_ttransaccion values ( 19661, 'Insertar nuevo Colateral',                                        '19661', 'Insertar nuevo Colateral')
insert into cl_ttransaccion values ( 19662, 'Eliminar nuevo Colateral',                                        '19662', 'Eliminar nuevo Colateral')
insert into cl_ttransaccion values ( 19663, 'Consulta de Colateral',                                           '19663', 'Consulta de Colateral')
insert into cl_ttransaccion values ( 19664, 'Consulta de Fechas',                                              '19664', 'Consulta de Fechas')
insert into cl_ttransaccion values ( 19674, 'Consulta de Plazo Fijo',                                          '19674', 'Consulta de Plazo Fijo')
insert into cl_ttransaccion values ( 19678, 'Consulta Garantias a modificar',                                  '19678', 'Consulta Garantias a modificar')
insert into cl_ttransaccion values ( 19684, 'Consulta de transacciones Contables',                             '19684', 'Consulta de Transacciones Contables')
insert into cl_ttransaccion values ( 19704, 'Consulta de Totales',                                             '19704', 'Consulta de Totales')
insert into cl_ttransaccion values ( 19705, 'Consulta de riesgos',                                             '19705', 'Consulta de riesgos')
insert into cl_ttransaccion values ( 19710, 'Transacciones por canje',                                         '19710', 'Transacciones por canje')
insert into cl_ttransaccion values ( 19726, 'Cancelacion por canje',                                           '19726', 'Cancelacion por canje')
insert into cl_ttransaccion values ( 19730, 'Ingreso Instrucciones Operativas',                                '19730', 'Ingreso Instrucciones Operativas')
insert into cl_ttransaccion values ( 19731, 'Consulta Instrucciones Operativas',                               '19731', 'Consulta Instrucciones Operativas')
insert into cl_ttransaccion values ( 19732, 'Consulta de Operaciones',                                         '19732', 'Consulta de Operaciones')
insert into cl_ttransaccion values ( 19733, 'Insercion de Instrucciones Operativas',                           '19733', 'Insercion de Instrucciones Operativas')
insert into cl_ttransaccion values ( 19734, 'Eliminar un pago a Inspector',                                    '19734', 'Eliminar un pago a Inspector')
insert into cl_ttransaccion values ( 19735, 'Oficina de Contabilizacion',                                      '19735', 'Oficina de Contabilizacion')
insert into cl_ttransaccion values ( 19736, 'Clase de la Garantia',                                            '19736', 'Clase de la Garantia')
insert into cl_ttransaccion values ( 19737, 'Suficiencia Legal',                                               '19737', 'Suficiencia Legal')
insert into cl_ttransaccion values ( 19738, 'Cobranza Judicial',                                               '19738', 'Cobranza Judicial')
insert into cl_ttransaccion values ( 19739, 'Instruccion',                                                     '19739', 'Instruccion')
insert into cl_ttransaccion values ( 19740, 'Adecuada',                                                        '19740', 'Adecuada')
insert into cl_ttransaccion values ( 19741, 'Migracion',                                                       '19741', 'Migracion')
insert into cl_ttransaccion values ( 19742, 'Catalogos',                                                       '19742', 'Catalogo')
insert into cl_ttransaccion values ( 19743, 'Tipo de Garantia',                                                '19743', 'Tipo de Garantia')
insert into cl_ttransaccion values ( 19744, 'Inspectores',                                                     '19744', 'Inspectores')
insert into cl_ttransaccion values ( 19745, 'Cambios de Estado',                                               '19745', 'Cambios de Estado')
insert into cl_ttransaccion values ( 19746, 'Todos los Tipos de Garantias',                                    '19746', 'Todos los Tipos de Garantias')
insert into cl_ttransaccion values ( 19747, 'Sectores de Garantias',                                           '19747', 'Sectores de Garantias')
insert into cl_ttransaccion values ( 19748, 'Consulta de CDTS por cliente.',                                   '19748', 'Consulta de CDTS por cliente.')
insert into cl_ttransaccion values ( 19749, 'Valida CDT por cliente.',                                         '19749', 'Valida CDT por cliente.')
insert into cl_ttransaccion values ( 19750, 'Insercion de Pignoracion y CDT.',                                 '19750', 'Insercion de Pignoracion y CDT.')
insert into cl_ttransaccion values ( 19751, 'Levantamiento de Pignoracion.',                                   '19751', 'Levantamiento de Pignoracion.')
insert into cl_ttransaccion values ( 19752, 'Buscar cliente de Garantia.',                                     '19752', 'Buscar Cliente de Garantia.')
insert into cl_ttransaccion values ( 19753, 'Insercion de Item Nuevo.',                                        '19753', 'Insercion de Item Nuevo.')
insert into cl_ttransaccion values ( 19754, 'Actualizacion de Item Nuevo.',                                    '19754', 'Actualizacion de Item Nuevo.')
insert into cl_ttransaccion values ( 19760, 'BUSCAR GARANTIAS EN CUSTODIA',                                    '19760', 'BUSCAR GARANTIAS EN CUSTODIA')
insert into cl_ttransaccion values ( 19761, 'MODIFICAR ESTADO DE LAS GARANTIAS',                               '19761', 'MODIFICAR ESTADO DE LAS GARANTIAS')
insert into cl_ttransaccion values ( 19762, 'IMPRESION DE GARANTIAS ENVIADAS',                                 '19762', 'IMPRESION DE GARANTIAS ENVIADAS')
insert into cl_ttransaccion values ( 19763, 'MENU CUSTODIA DE GARANTIAS',                                      '19763', 'MENU CUSTODIA DE GARANTIAS')
insert into cl_ttransaccion values ( 19772, 'MENU CUSTODIA DE GARANTIAS/CENTRAL  DE CUSTODIA',                 '19772', 'MENU CUSTODIA DE GARANTIAS/CENTRAL  DE CUSTODIA')
insert into cl_ttransaccion values ( 19773, 'MENU CUSTODIA DE GARANTIAS/DEPENDENCIAS BANCO',                   '19773', 'MENU CUSTODIA DE GARANTIAS/DEPENDENCIAS BANCO')
insert into cl_ttransaccion values ( 19774, 'MENU CUSTODIA DE GARANTIAS/CONSULTAS',                            '19774', 'MENU CUSTODIA DE GARANTIAS/CONSULTAS')
insert into cl_ttransaccion values ( 19777, 'MENU CUSTODIA DE GARANTIAS/PARAMETRIZACION',                      '19777', 'MENU CUSTODIA DE GARANTIAS/PARAMETRIZACION')
insert into cl_ttransaccion values ( 19778, 'MENU CUSTODIA DE GARANTIAS/ PARAMETRIZACION/DEPENDENCIAS',        '19778', 'MENU CUSTODIA DE GARANTIAS/ PARAMETRIZACION/DEPENDENCIAS')
insert into cl_ttransaccion values ( 19779, 'MENU CUSTODIA DE GARANTIAS/PARAMETRIZACION/USUARIOS AUTORIZADOS', '19779', 'MENU CUSTODIA DE GARANTIAS/PARAMETRIZACION/USUARIOS AUTORIZADOS')
insert into cl_ttransaccion values ( 19780, 'BUSQUEDA DE DEPENDENCIAS CENTRAL DE CUSTODIA',                    '19780', 'BUSQUEDA DE DEPENDENCIAS CENTRAL DE CUSTODIA')
insert into cl_ttransaccion values ( 19781, 'INSERCION DEPENDENCIAS EN CENTRAL DE CUSTODIA',                   '19781', 'INSERCION DEPENDENCIAS EN CENTRAL DE CUSTODIA')
insert into cl_ttransaccion values ( 19782, 'USUARIOS DE UNA DEPENDENCIA CENTRAL DE CUSTODIA',                 '19782', 'USUARIOS DE UNA DEPENDENCIA CENTRAL DE CUSTODIA')
insert into cl_ttransaccion values ( 19783, 'INSERCION DE DEPENDENCIAS CUSTODIA DE GARANTIAS',                 '19783', 'INSERCION DE DEPENDENCIAS CUSTODIA DE GARANTIAS')
insert into cl_ttransaccion values ( 19784, 'ACTUALIZACION DE DEPENDENCIAS CUSTODIA DE GARANTIAS',             '19784', 'ACTUALIZACION DE DEPENDENCIAS CUSTODIA DE GARANTIAS')
insert into cl_ttransaccion values ( 19785, 'HELP DE DEPENDENCIAS',                                            '19785', 'HELP DE DEPENDENCIAS')
insert into cl_ttransaccion values ( 19786, 'HELP DE USUARIOS DE DEPENDENCIAS',                                '19786', 'HELP DE USUARIOS DE DEPENDENCIAS')
insert into cl_ttransaccion values ( 19789, 'MENU CUSTODIA  DE GARANTIAS/CENTRAL DE CUSTODIA/ENVIO DE GARA',   '19789', 'MENU CUSTODIA  DE GARANTIAS/CENTRAL DE CUSTODIA/ENVIO DE GARANTIAS')
insert into cl_ttransaccion values ( 19810, 'Ingreso Garantias Para Abogados.',                                '19810', 'Ingreso Garantias Para Abogados.')
insert into cl_ttransaccion values ( 19811, 'Actualizacion Garantias Para Abogados.',                          '19811', 'Actualizacion Garantias Para Abogados.')
insert into cl_ttransaccion values ( 19812, 'Eliminacion Garantias Para Abogados.',                            '19812', 'Eliminacion Garantias Para Abogados.')
insert into cl_ttransaccion values ( 19813, 'Consulta Garantias Para Abogados.',                               '19813', 'Consulta Garantias Para Abogados.')
insert into cl_ttransaccion values ( 19814, 'Busqueda de 1 Garantia Para Abogados.',                           '19814', 'Busqueda Garantias Para Abogados.')
insert into cl_ttransaccion values ( 19816, 'Consulta Garantias para Reporte Abg',                             '19816', 'Consulta Garantias Para Reporte Abg')
insert into cl_ttransaccion values ( 19820, 'Impresion Carta para Abogados',                                   '19820', 'Impresion Carta para Abogados')
insert into cl_ttransaccion values ( 19821, 'Ingreso de Concepto Juridico',                                    '19821', 'Ingreso de Concepto Juridico')
insert into cl_ttransaccion values ( 19822, 'Actualizacion de Concepto Juridico',                              '19822', 'Actualizacion de Concepto Juridico')
insert into cl_ttransaccion values ( 19823, 'Eliminacion de Concepto Juridico',                                '19823', 'Eliminacion de Concepto Juridico')
insert into cl_ttransaccion values ( 19824, 'Descripcion de Concepto Juridico',                                '19824', 'Descripcion de Concepto Juridico')
insert into cl_ttransaccion values ( 19825, 'Busqueda de Concepto Juridico',                                   '19825', 'Busqueda de Concepto Juridico')
insert into cl_ttransaccion values ( 19826, 'Consulta de un Concepto Juridico',                                '19826', 'Consulta de un Concepto Juridico')
insert into cl_ttransaccion values ( 19827, 'Todos los Conceptos',                                             '19827', 'Todos los Conceptos')
insert into cl_ttransaccion values ( 19828, 'Conceptos Juridicos a Cobrar',                                    '19828', 'Conceptos Juridicos a Cobrar')
insert into cl_ttransaccion values ( 19829, 'Conceptos Juridicos del Cliente',                                 '19829', 'Conceptos Juridicos del Cliente')
insert into cl_ttransaccion values ( 19830, 'Conceptos Juridicos Cobrados',                                    '19830', 'Conceptos Juridicos Cobrados')
insert into cl_ttransaccion values ( 19831, 'Busca Garantias para Abogados',                                   '19831', 'Busca Garantias para Abogados')
insert into cl_ttransaccion values ( 19832, 'CAMBIO DE CARACTER',                                              '19832', 'CAMBIO DE CARACTER')
insert into cl_ttransaccion values ( 19833, 'CAMBIO ROL DEL CLIENTE',                                          '19833', 'CAMBIO ROL DEL CLIENTE')
insert into cl_ttransaccion values ( 19834, 'MODIFICACION DE CARACTER DE LA GARANTIA',                         '19834', 'MODIFICACION DE CARACTER DE LA GARANTIA')
insert into cl_ttransaccion values ( 19835, 'CONSULTA DE CARACTER DE LA GARANTIA',                             '19835', 'CONSULTA DE CARACTER DE LA GARANTIA')
insert into cl_ttransaccion values ( 19836, 'MODIFICACION DEL ROL DE LA GARANTIA',                             '19836', 'MODIFICACION DEL ROL DE LA GARANTIA')
insert into cl_ttransaccion values ( 19837, 'BUSQUEDA DEL ROL DE LA GARANTIA',                                 '19837', 'BUSQUEDA DEL ROL DE LA GARANTIA')
insert into cl_ttransaccion values ( 19838, 'ELIMINACION DEL ROL DE LA GARANTIA',                              '19838', 'ELIMINACION DEL ROL DE LA GARANTIA')
insert into cl_ttransaccion values ( 19843, 'Consulta de un Abogados',                                         '19843', 'Consulta de un Abogados')
insert into cl_ttransaccion values ( 19844, 'Consulta Abogados',                                               '19844', 'Consulta Abogados')
insert into cl_ttransaccion values ( 19846, 'Consulta de todos los Abogados',                                  '19846', 'Consulta de todos los Abogados')
insert into cl_ttransaccion values ( 19850, 'Consulta de Inspectores',                                         '19850', 'Consulta de Inspectores')
insert into cl_ttransaccion values ( 19851, 'Consulta de Polizas',                                             '19851', 'Consulta de Polizas')
insert into cl_ttransaccion values ( 19852, 'Consulta Garantias por Condicion',                                '19852', 'Consulta Garantias Por Condicion')
insert into cl_ttransaccion values ( 19853, 'Consulta Siguientes Garantias Por Condicion',                     '19853', 'Consulta Siguientes Garantias Por Condicion')
insert into cl_ttransaccion values ( 19854, 'Renovacion Poliza de Seguros',                                    '19854', 'Actualizar el monto a renovar de la poliza')
insert into cl_ttransaccion values ( 19855, 'Renovacion Poliza de Seguros',                                    '19855', 'Debito automatico')
insert into cl_ttransaccion values ( 19856, 'Posibles estados',                                                '19856', 'Posibles estados')
insert into cl_ttransaccion values ( 19857, 'Vigencia de la Garantia',                                         '19857', 'Vigencia de la Garantia')
insert into cl_ttransaccion values ( 19858, 'Ingreso de Perfiles Contables',                                   '19858', 'Ingreso de Perfiles Contables')
insert into cl_ttransaccion values ( 19859, 'Eliminacion de Perfiles Contables',                               '19859', 'Eliminacion de Perfiles Contables')
insert into cl_ttransaccion values ( 19860, 'Actualizacion de Perfiles Contables',                             '19860', 'Actualizacion de Perfiles Contables')
insert into cl_ttransaccion values ( 19861, 'Consulta de Perfiles Contables',                                  '19861', 'Consulta de Perfiles Contables')
insert into cl_ttransaccion values ( 19862, 'Consulta de Transacciones',                                       '19862', 'Consulta de Transacciones')
insert into cl_ttransaccion values ( 19863, 'Ingreso de Transacciones',                                        '19863', 'Ingreso de Transacciones')
insert into cl_ttransaccion values ( 19864, 'Insercion de operacion',                                          '19864', 'Insercion de operacion')
insert into cl_ttransaccion values ( 19865, 'Clase de Garantia',                                               '19814', 'Clase de Garantia')
insert into cl_ttransaccion values ( 19866, 'Clase de Cartera',                                                '19815', 'Clase de Cartera')
insert into cl_ttransaccion values ( 19867, 'Debito automatico Abg.',                                          '19867', 'Debito automatico Abg')
insert into cl_ttransaccion values ( 19868, 'Busqueda de transacciones por criterio',                          '19868', 'Busqueda de transacciones por criterio')
insert into cl_ttransaccion values ( 19869, 'Detalle de transacciones',                                        '19869', 'Detalle de transacciones')
insert into cl_ttransaccion values ( 19870, 'Consulta de Abogados',                                            '19870', 'Consulta de Abogados')
insert into cl_ttransaccion values ( 19871, 'Tipo de Bien',                                                    '19819', 'Tipo de Bien')
insert into cl_ttransaccion values ( 19872, 'Estado Garantia',                                                 '19872', 'Estado Garantia')
insert into cl_ttransaccion values ( 19873, 'Consulta de Entidades',                                           '19873', 'Consulta de una entidad')
insert into cl_ttransaccion values ( 19874, 'Ingreso de Garantia Compartida',                                  '19874', 'Ingreso de Garantia Compartida')
insert into cl_ttransaccion values ( 19875, 'Actualizacion de Garantia Compartida',                            '19875', 'Actualizacion de Garantia Compartida')
insert into cl_ttransaccion values ( 19876, 'Eliminacion de Garantia Compartida',                              '19876', 'Eliminacion de Garantia Compartida')
insert into cl_ttransaccion values ( 19877, 'Query de Garantia Compartida',                                    '19877', 'Query de Garantia Compartida')
insert into cl_ttransaccion values ( 19878, 'Ingreso de Revalorizacion Accion',                                '19878', 'Ingreso de Revalorizacion Accion')
insert into cl_ttransaccion values ( 19879, 'Modificacion de Revalorizacion Accion',                           '19879', 'Modificacion de Revalorizacion Accion')
insert into cl_ttransaccion values ( 19880, 'Eliminacion de Revalorizacion Accion',                            '19880', 'Eliminacion de Revalorizacion Accion')
insert into cl_ttransaccion values ( 19881, 'Busqueda de Revalorizacion Accion',                               '19881', 'Busqueda de Revalorizacion Accion')
insert into cl_ttransaccion values ( 19882, 'Busqueda de Fuente de Valor',                                     '19882', 'Busqueda de Fuente de Valor')
insert into cl_ttransaccion values ( 19883, 'Bandera Tramite tiene Garantia Admisible o no',                   '19883', 'Bandera Tramite')
insert into cl_ttransaccion values ( 19884, 'Aseguradoras de Polizas',                                         '19884', 'Aseguradoras')
insert into cl_ttransaccion values ( 19885, 'Liberacion de Avales',                                            '19885', 'Liberacion de Avales')
insert into cl_ttransaccion values ( 19886, 'Transaccion virtual para Liberacion de Avales',                   '19886', 'Transaccion virtual para Liberacion de garantia')
insert into cl_ttransaccion values ( 19887, 'Documentos Factoring',                                            '19887', 'Factoring')
insert into cl_ttransaccion values ( 19888, 'Busqueda de Documentos Factoring',                                '19888', 'Busqueda Factoring')
insert into cl_ttransaccion values ( 19889, 'Agrupacion de Documentos Factoring',                              '19889', 'Agrupar Documento')
insert into cl_ttransaccion values ( 19890, 'Heredar Garantias',                                               '19890', 'Heredar Garantias')
insert into cl_ttransaccion values ( 19891, 'Ingresar Estados de Garantias',                                   '19891', 'Ingresar Estados de Garantias')
insert into cl_ttransaccion values ( 19892, 'Actualizar Estados de Garantias',                                 '19892', 'Actualizar Estados de Garantias')
insert into cl_ttransaccion values ( 19893, 'Eliminar Estados de Garantias',                                   '19893', 'Eliminar Estados de Garantias')
insert into cl_ttransaccion values ( 19894, 'Search Estados de Garantias',                                     '19894', 'Search Estados de Garantias')
insert into cl_ttransaccion values ( 19895, 'Query Estados de Garantias',                                      '19895', 'Query Estados de Garantias')
insert into cl_ttransaccion values ( 19896, 'Ingresar Asignar Estados de Garantias',                           '19896', 'Ingresar Asignar Estados de Garantias')
insert into cl_ttransaccion values ( 19897, 'Actualizar Asignar Estados de Garantias',                         '19897', 'Actualizar Asignar Estados de Garantias')
insert into cl_ttransaccion values ( 19898, 'Eliminar Asignar Estados de Garantias',                           '19898', 'Eliminar Asignar Estados de Garantias')
insert into cl_ttransaccion values ( 19899, 'Asignacion Estados de Garantia',                                  '19899', 'Asignacion Estados de Garantia Garantia')
insert into cl_ttransaccion values ( 19900, 'Query Estados de Garantias',                                      '19900', 'Query Estados de Garantias')
insert into cl_ttransaccion values ( 19901, 'Busqueda negocio Dctos. Descontados',                             '19901', 'Busqueda negocio Dctos. Descontados')
insert into cl_ttransaccion values ( 19902, 'Aplicar Vencimientos',                                            '19902', 'Aplicar Vencimientos')
insert into cl_ttransaccion values ( 19903, 'Carga de Vencimientos',                                           '19903', 'Carga de Vencimientos')
insert into cl_ttransaccion values ( 19904, 'Buscar Archivos Cargados',                                        '19904', 'Buscar Archivos Cargados')
insert into cl_ttransaccion values ( 19905, 'Borrar Archivos Cargados',                                        '19905', 'Borrar Archivos Cargados')
insert into cl_ttransaccion values ( 19906, 'Insertar Archivos Cargados',                                      '19906', 'Insertar Archivos Cargados')
insert into cl_ttransaccion values ( 19907, 'Insertar Errores de Migracion',                                   '19907', 'Insertar Errores de Migracion')
insert into cl_ttransaccion values ( 19908, 'Consultar Errores de Migracion',                                  '19908', 'Consultar Errores de Migracion')
insert into cl_ttransaccion values ( 19909, 'Consulta del Codigo Externo',                                     '19909', 'Consulta del Codigo Externo')
insert into cl_ttransaccion values ( 19910, 'Actualizacion estado para Garantias castigadas',                  '19909', 'Actualizacion de estado para Garantias castigadas')
insert into cl_ttransaccion values ( 19911, 'Actualizacion valor de Agotamiento de las Garantias',             '19911', 'Actualizacion valor garantia')
insert into cl_ttransaccion values ( 19912, 'Consulta Pago a Avaluadores',                                     '19912', 'Consulta Pago a Avaluadores')
insert into cl_ttransaccion values ( 19913, 'Pago a Avaluadores',                                              '19913', 'Pago a Avaluadores')
insert into cl_ttransaccion values ( 19914, 'Consulta Pago a Abogados',                                        '19914', 'Consulta Pago a Abogados')
insert into cl_ttransaccion values ( 19915, 'Pago a Abogados',                                                 '19915', 'Pago a Abogados')
insert into cl_ttransaccion values ( 19916, 'Asociar documentos al tramite',                                   '19916', 'Asociar documentos al tramite')
insert into cl_ttransaccion values ( 19917, 'Agrupar documentos',                                              '19917', 'Agrupar documentos')
insert into cl_ttransaccion values ( 19918, 'Desagrupar documentos',                                           '19918', 'Desagrupar documentos')
insert into cl_ttransaccion values ( 19919, 'Aniadir documentos',                                              '19919', 'Aniadir documentos')
insert into cl_ttransaccion values ( 19920, 'Eliminar documentos',                                             '19920', 'Eliminar documentos')
insert into cl_ttransaccion values ( 19921, 'Editar documentos',                                               '19921', 'Editar documentos')
insert into cl_ttransaccion values ( 19922, 'Ingresar documentos',                                             '19922', 'Ingresar documentos')
insert into cl_ttransaccion values ( 19923, 'Modificar documentos',                                            '19923', 'Modificar documentos')
insert into cl_ttransaccion values ( 19924, 'Eliminar documentos',                                             '19924', 'Eliminar documentos')
insert into cl_ttransaccion values ( 19925, 'Buscar documentos',                                               '19925', 'Buscar documentos')
insert into cl_ttransaccion values ( 19926, 'Liberar documentos',                                              '19926', 'Liberar documentos')
insert into cl_ttransaccion values ( 19927, 'Ingresar Vencimientos',                                           '19927', 'Ingresar Vencimientos')
insert into cl_ttransaccion values ( 19928, 'Carga masiva de Vencimientos',                                    '19928', 'Carga masiva de Vencimientos')
insert into cl_ttransaccion values ( 19929, 'Ingreso de Recuperaciones',                                       '19929', 'Ingreso de Recuperaciones')
insert into cl_ttransaccion values ( 19930, 'Resultado de visitas',                                            '19930', 'Ingreso de Resultado de visitas')
insert into cl_ttransaccion values ( 19931, 'Concepto juridico',                                               '19931', 'Ingreso de concepto juridico')
insert into cl_ttransaccion values ( 19932, 'Cambio de Estado de Documentos',                                  '19932', 'Cambio de Estado de Documentos')
insert into cl_ttransaccion values ( 19933, 'Cambio de Clase de la Garantia',                                  '19933', 'Cambio de Clase de la Garantia')
insert into cl_ttransaccion values ( 19934, 'Solicitud de consultas y/o documentos a la central de custodia',  '19934', 'Solicitud de consultas y/o documentos a la central de custodia')
insert into cl_ttransaccion values ( 19935, 'Input en la tabla cu_observaciones',                              '19935', 'Input en la tabla cu_observaciones')
insert into cl_ttransaccion values ( 19936, 'Update en la tabla cu_observaciones',                             '19936', 'Update en la tabla cu_observaciones')
insert into cl_ttransaccion values ( 19937, 'Delete en la tabla cu_observaciones',                             '19937', 'Delete en la tabla cu_observaciones')
insert into cl_ttransaccion values ( 19938, 'Search en la tabla cu_observaciones',                             '19938', 'Search en la tabla cu_observaciones')
insert into cl_ttransaccion values ( 19939, 'Query en la tabla cu_observacionesg',                             '19939', 'Query en la tabla cu_observacionesg')
insert into cl_ttransaccion values ( 19940, 'Ingresar Documentos de Garantias',                                '19940', 'Ingresar Documentos de Garantias')
insert into cl_ttransaccion values ( 19941, 'Consulta Documentos de Garantias',                                '19941', 'Consulta Documentos de Garantias')
insert into cl_ttransaccion values ( 19942, 'Actualizacion Documentos de Garantias',                           '19942', 'Consulta Documentos de Garantias')
insert into cl_ttransaccion values ( 19943, 'Query Documentos de Garantias',                                   '19943', 'Consulta Documentos de Garantias')
insert into cl_ttransaccion values ( 19944, 'Clasificacion Riesgo',                                            '19944', 'Clasificacion Riesgo')
insert into cl_ttransaccion values ( 19945, 'Insert Clases de Vehiculos',                                      '19945', 'Insert Clases de Vehiculos')
insert into cl_ttransaccion values ( 19946, 'Delete Clases de Vehiculos',                                      '19946', 'Delete Clases de Vehiculos')
insert into cl_ttransaccion values ( 19947, 'Query Clases de Vehiculos',                                       '19947', 'Query Clases de Vehiculos')
insert into cl_ttransaccion values ( 19948, 'Search Clases de Vehiculos',                                      '19948', 'Search Clases de Vehiculos')
insert into cl_ttransaccion values ( 19949, 'Update Clases de Vehiculos',                                      '19949', 'Update Clases de Vehiculos')
insert into cl_ttransaccion values ( 19950, 'Existencia Clases de Vehiculos',                                  '19950', 'Existencia Clases de Vehiculos')
insert into cl_ttransaccion values ( 19951, 'Select All Clases de Vehiculos',                                  '19951', 'Select All Clases de Vehiculos')
insert into cl_ttransaccion values ( 19952, 'Entrega la descripcion dado el codigo',                           '19952', 'Entrega la descripcion dado el codigo')
insert into cl_ttransaccion values ( 19953, 'Activacion Menu Garantias',                                       '19953', 'Activacion Menu Garantias')
insert into cl_ttransaccion values ( 19954, 'Activacion Menu Descuento Documentos',                            '19954', 'Activacion Menu Descuento Documentos')
insert into cl_ttransaccion values ( 19955, 'Activacion Menu Inspecciones',                                    '19955', 'Activacion Menu Inspecciones')
insert into cl_ttransaccion values ( 19956, 'Activacion Menu Abogados',                                        '19955', 'Activacion Menu Abogados')
insert into cl_ttransaccion values ( 19957, 'Activacion Menu Consultas',                                       '19956', 'Activacion Menu Consultas')
insert into cl_ttransaccion values ( 19958, 'Activacion Menu Administracion',                                  '19958', 'Activacion Menu Administracion')
insert into cl_ttransaccion values ( 19959, 'Parametros Generales',                                            '19959', 'Parametros Generales')
insert into cl_ttransaccion values ( 19970, 'INSERCION SP_CIUDAD_PORCENTAJE',                                  '19970', 'INSERCION SP_CIUDAD_PORCENTAJE')
insert into cl_ttransaccion values ( 19971, 'ACTUALIZACION SP_CIUDAD_PORCENTAJE',                              '19971', 'ACTUALIZACION SP_CIUDAD_PORCENTAJE')
insert into cl_ttransaccion values ( 19972, 'ELIMINAR SP_CIUDAD_PORCENTAJE',                                   '19972', 'ELIMINAR SP_CIUDAD_PORCENTAJE')
insert into cl_ttransaccion values ( 19973, 'RETORNAR SP_CIUDAD_PORCENTAJE',                                   '19973', 'RETORNAR SP_CIUDAD_PORCENTAJE')
insert into cl_ttransaccion values ( 19974, 'INSERCION SP_PORCENTAJE_ESTRATO',                                 '19974', 'INSERCION SP_PORCENTAJE_ESTRATO')
insert into cl_ttransaccion values ( 19975, 'ACTUALIZACION SP_PORCENTAJE_ESTRATO',                             '19975', 'ACTUALIZACION SP_PORCENTAJE_ESTRATO')
insert into cl_ttransaccion values ( 19976, 'ELIMINAR SP_PORCENTAJE_ESTRATO',                                  '19976', 'ELIMINAR SP_PORCENTAJE_ESTRATO')
insert into cl_ttransaccion values ( 19977, 'RETORNAR SP_PORCENTAJE_ESTRATO',                                  '19977', 'RETORNAR SP_PORCENTAJE_ESTRATO')
insert into cl_ttransaccion values ( 19978, 'Activacion Avaluos',                                              'ACAV',  'Activacion Avaluos')
insert into cl_ttransaccion values ( 19979, 'Activacion Garantias vs Obligaciones',                            'ACGO',  'Activacion Garantias vs Obligaciones')
insert into cl_ttransaccion values ( 19980, 'Activacion Consultas Instrucciones Operativas',                   'AIO',   'Activacion Consultas Instrucciones Operativas')
insert into cl_ttransaccion values ( 19981, 'Activacion consulta Batch',                                       'ACB',   'Activacion consulta Batch')
insert into cl_ttransaccion values ( 19982, 'Activacion codigos valor garantias',                              'ACVG',  'Activacion codigos valor garantias')
insert into cl_ttransaccion values ( 19983, 'Activacion menu Parametros Generales',                            'AMPG',  'Activacion menu Parametros Generales')
insert into cl_ttransaccion values ( 19984, 'Activacion menu Parametros por ciudad y estrato',                 'AMPG',  'Activacion menu Parametros Generales')
go



/*Fin_Creacion_de_Transacciones*/

/* Relacion entre Stored Procedures y Transacciones */
declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete ad_pro_transaccion
 where pt_producto = 19
   and pt_transaccion in (19000,19001,19002,19003,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,19014,19015,19016,19017,19018,19019,19020,
                          19021,19022,19023,19024,19025,19026,19030,19031,19032,19033,19034,19035,19036,19037,19038,19039,19040,19041,19042,19043,19044,
                          19045,19046,19047,19048,19049,19050,19051,19052,19053,19054,19055,19056,19060,19061,19062,19063,19064,19065,19066,19067,19068,
                          19069,19070,19071,19072,19073,19074,19075,19076,19077,19078,19080,19081,19082,19083,19084,19085,19086,19090,19091,19092,19093,
                          19094,19095,19096,19097,19098,19099,19100,19101,19102,19103,19104,19105,19106,19107,19108,19109,19110,19111,19112,19113,19114,
                          19115,19116,19117,19118,19119,19120,19121,19122,19123,19124,19125,19126,19127,19128,19130,19131,19132,19133,19134,19135,19136,
                          19137,19138,19139,19140,19141,19142,19143,19144,19145,19146,19147,19148,19150,19151,19160,19161,19162,19163,19164,19165,19166,
                          19167,19175,19184,19193,19194,19196,19197,19204,19214,19224,19233,19245,19254,19264,19270,19284,19295,19304,19305,19307,19308,
                          19309,19310,19326,19334,19344,19354,19364,19371,19377,19384,19394,19404,19414,19424,19434,19445,19455,19465,19475,19494,19504,
                          19514,19524,19534,19544,19554,19564,19565,19574,19584,19594,19604,19614,19624,19625,19630,19631,19632,19634,19635,19640,19641,
                          19642,19644,19645,19654,19655,19656,19657,19658,19659,19661,19662,19663,19664,19674,19678,19684,19704,19705,19710,19726,19730)
   and pt_moneda = @w_moneda

print ' INICIO DE INGRESO DE RELACION ENTRE STORED PROCEDURE Y TRANSACCIONES'

/* Relacion entre Stored Procedures y Transacciones */
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19000          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19001          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19002          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19003          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19004          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19005          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19006          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19007          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19008          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19009          , 'V', getdate(),  19000        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19010          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19011          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19012          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19013          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19014          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19015          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19016          , 'V', getdate(),  19001        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19017          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19018          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19019          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19020          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19021          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19022          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19023          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19024          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19025          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19026          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19030          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19031          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19032          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19033          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19034          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19035          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19036          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19037          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19038          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19039          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19040          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19041          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19042          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19043          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19044          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19045          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19046          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19047          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19048          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19049          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19050          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19051          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19052          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19053          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19054          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19055          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19056          , 'V', getdate(),  19005        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19060          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19061          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19062          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19063          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19064          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19065          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19066          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19067          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19068          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19069          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19070          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19071          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19072          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19073          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19074          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19075          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19076          , 'V', getdate(),  19007        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19077          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19078          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19080          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19081          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19082          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19083          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19084          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19085          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19086          , 'V', getdate(),  19008        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19090          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19091          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19092          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19093          , 'V', getdate(),  19048        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19094          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19095          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19096          , 'V', getdate(),  19048        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19097          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19098          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19099          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19100          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19101          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19102          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19103          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19104          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19105          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19106          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19107          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19108          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19109          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19110          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19111          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19112          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19113          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19114          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19115          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19116          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19117          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19118          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19119          , 'V', getdate(),  19011        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19120          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19121          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19122          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19123          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19124          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19125          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19126          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19127          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19128          , 'V', getdate(),  19012        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19130          , 'V', getdate(),  19013        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19131          , 'V', getdate(),  19013        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19132          , 'V', getdate(),  19013        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19133          , 'V', getdate(),  19077        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19134          , 'V', getdate(),  19077        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19135          , 'V', getdate(),  19077        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19136          , 'V', getdate(),  19077        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19137          , 'V', getdate(),  19078        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19138          , 'V', getdate(),  19078        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19139          , 'V', getdate(),  19078        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19140          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19141          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19142          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19143          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19144          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19145          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19146          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19147          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19148          , 'V', getdate(),  19014        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19150          , 'V', getdate(),  19015        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19151          , 'V', getdate(),  19015        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19160          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19161          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19162          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19163          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19164          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19165          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19166          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19167          , 'V', getdate(),  19016        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19175          , 'V', getdate(),  19017        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19184          , 'V', getdate(),  19018        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19193          , 'V', getdate(),  19019        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19194          , 'V', getdate(),  19019        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19196          , 'V', getdate(),  19019        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19197          , 'V', getdate(),  19019        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19204          , 'V', getdate(),  19020        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19214          , 'V', getdate(),  19021        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19224          , 'V', getdate(),  19022        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19233          , 'V', getdate(),  19023        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19245          , 'V', getdate(),  19024        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19254          , 'V', getdate(),  19025        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19264          , 'V', getdate(),  19026        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19270          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19284          , 'V', getdate(),  19028        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19295          , 'V', getdate(),  19029        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19304          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19305          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19307          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19308          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19309          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19310          , 'V', getdate(),  19031        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19326          , 'V', getdate(),  19032        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19334          , 'V', getdate(),  19033        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19344          , 'V', getdate(),  19034        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19354          , 'V', getdate(),  19035        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19364          , 'V', getdate(),  19036        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19371          , 'V', getdate(),  19037        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19377          , 'V', getdate(),  19037        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19384          , 'V', getdate(),  19038        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19394          , 'V', getdate(),  19039        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19404          , 'V', getdate(),  19040        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19414          , 'V', getdate(),  19041        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19424          , 'V', getdate(),  19042        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19434          , 'V', getdate(),  19043        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19445          , 'V', getdate(),  19044        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19455          , 'V', getdate(),  19045        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19465          , 'V', getdate(),  19046        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19475          , 'V', getdate(),  19047        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19494          , 'V', getdate(),  19049        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19504          , 'V', getdate(),  19050        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19514          , 'V', getdate(),  19051        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19524          , 'V', getdate(),  19052        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19534          , 'V', getdate(),  19053        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19544          , 'V', getdate(),  19054        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19554          , 'V', getdate(),  19055        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19564          , 'V', getdate(),  19056        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19565          , 'V', getdate(),  19056        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19574          , 'V', getdate(),  19057        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19584          , 'V', getdate(),  19058        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19594          , 'V', getdate(),  19059        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19604          , 'V', getdate(),  19060        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19614          , 'V', getdate(),  19061        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19624          , 'V', getdate(),  19062        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19625          , 'V', getdate(),  19062        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19630          , 'V', getdate(),  19063        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19631          , 'V', getdate(),  19063        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19632          , 'V', getdate(),  19063        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19634          , 'V', getdate(),  19063        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19635          , 'V', getdate(),  19063        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19640          , 'V', getdate(),  19064        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19641          , 'V', getdate(),  19064        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19642          , 'V', getdate(),  19064        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19644          , 'V', getdate(),  19064        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19645          , 'V', getdate(),  19064        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19654          , 'V', getdate(),  19065        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19655          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19656          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19657          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19658          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19659          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19661          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19662          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19663          , 'V', getdate(),  19066        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19664          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19674          , 'V', getdate(),  19067        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19678          , 'V', getdate(),  19069        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19684          , 'V', getdate(),  19068        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19704          , 'V', getdate(),  19070        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19705          , 'V', getdate(),  19070        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19710          , 'V', getdate(),  19071        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19726          , 'V', getdate(),  19072        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19730          , 'V', getdate(),  19073        , null)
go

declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete ad_pro_transaccion
 where pt_producto = 19
   and pt_transaccion in (19731,19732,19733,19734,19735,19736,19737,19738,19739,19740,19741,19742,19743,19744,19745,19748,19749,19750,19751,19752,19753,
                          19754,19760,19761,19762,19763,19772,19773,19774,19777,19778,19779,19780,19781,19782,19783,19784,19785,19786,19789,19810,19811,
                          19812,19813,19814,19816,19820,19821,19822,19823,19824,19825,19826,19827,19828,19829,19830,19831,19832,19833,19834,19835,19836,
                          19837,19838,19843,19844,19846,19850,19851,19852,19854,19855,19856,19857,19858,19859,19860,19861,19862,19863,19864,19865,19866,
                          19867,19868,19869,19870,19871,19872,19873,19874,19875,19876,19877,19878,19879,19880,19881,19882,19883,19884,19885,19886,19887,
                          19888,19889,19890,19891,19892,19893,19894,19895,19896,19897,19898,19899,19900,19901,19902,19903,19904,19905,19906,19907,19908,
                          19909,19910,19911,19912,19913,19914,19915,19916,19917,19918,19919,19920,19921,19922,19923,19924,19925,19926,19927,19928,19929,
                          19930,19931,19932,19933,19934,19935,19936,19937,19938,19939,19940,19941,19942,19943,19944,19945,19946,19947,19948,19949,19950,
                          19951,19952,19953,19954,19955,19956,19957,19958,19959,19970,19971,19972,19973,19974,19975,19976,19977,19978,19979,19980,19981,
                          19982,19983,19984,19985)
   and pt_moneda = @w_moneda

insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19731          , 'V', getdate(),  19073        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19732          , 'V', getdate(),  19073        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19733          , 'V', getdate(),  19073        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19734          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19735          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19736          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19737          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19738          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19739          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19740          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19741          , 'V', getdate(),  19074        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19742          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19743          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19744          , 'V', getdate(),  19027        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19745          , 'V', getdate(),  19076        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19748          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19749          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19750          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19751          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19752          , 'V', getdate(),  19009        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19753          , 'V', getdate(),  19075        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19754          , 'V', getdate(),  19075        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19760          , 'V', getdate(),  19093        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19761          , 'V', getdate(),  19093        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19762          , 'V', getdate(),  19093        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19763          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19772          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19773          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19774          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19777          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19778          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19779          , 'V', getdate(),  19085        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19780          , 'V', getdate(),  19084        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19781          , 'V', getdate(),  19084        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19782          , 'V', getdate(),  19085        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19783          , 'V', getdate(),  19085        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19784          , 'V', getdate(),  19084        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19785          , 'V', getdate(),  19084        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19786          , 'V', getdate(),  19085        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19789          , 'V', getdate(),  19092        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19810          , 'V', getdate(),  19800        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19811          , 'V', getdate(),  19800        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19812          , 'V', getdate(),  19800        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19813          , 'V', getdate(),  19800        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19814          , 'V', getdate(),  19800        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19816          , 'V', getdate(),  19801        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19820          , 'V', getdate(),  19801        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19821          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19822          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19823          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19824          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19825          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19826          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19827          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19828          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19829          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19830          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19831          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19832          , 'V', getdate(),  19100        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19833          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19834          , 'V', getdate(),  19100        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19835          , 'V', getdate(),  19100        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19836          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19837          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19838          , 'V', getdate(),  19004        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19843          , 'V', getdate(),  19803        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19844          , 'V', getdate(),  19803        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19846          , 'V', getdate(),  19803        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19850          , 'V', getdate(),  19804        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19851          , 'V', getdate(),  19805        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19852          , 'V', getdate(),  19806        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19854          , 'V', getdate(),  19010        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19855          , 'V', getdate(),  19813        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19856          , 'V', getdate(),  19807        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19857          , 'V', getdate(),  19808        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19858          , 'V', getdate(),  19809        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19859          , 'V', getdate(),  19809        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19860          , 'V', getdate(),  19809        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19861          , 'V', getdate(),  19809        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19862          , 'V', getdate(),  19810        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19863          , 'V', getdate(),  19811        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19864          , 'V', getdate(),  19812        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19865          , 'V', getdate(),  19814        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19866          , 'V', getdate(),  19815        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19867          , 'V', getdate(),  19816        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19868          , 'V', getdate(),  19817        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19869          , 'V', getdate(),  19817        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19870          , 'V', getdate(),  19818        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19871          , 'V', getdate(),  19819        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19872          , 'V', getdate(),  19818        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19873          , 'V', getdate(),  19820        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19874          , 'V', getdate(),  19821        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19875          , 'V', getdate(),  19821        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19876          , 'V', getdate(),  19821        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19877          , 'V', getdate(),  19821        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19878          , 'V', getdate(),  19822        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19879          , 'V', getdate(),  19822        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19880          , 'V', getdate(),  19822        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19881          , 'V', getdate(),  19822        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19882          , 'V', getdate(),  19823        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19883          , 'V', getdate(),  19824        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19884          , 'V', getdate(),  19825        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19885          , 'V', getdate(),  19062        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19886          , 'V', getdate(),  19062        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19887          , 'V', getdate(),  19826        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19888          , 'V', getdate(),  19827        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19889          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19890          , 'V', getdate(),  19829        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19891          , 'V', getdate(),  19830        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19892          , 'V', getdate(),  19830        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19893          , 'V', getdate(),  19830        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19894          , 'V', getdate(),  19830        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19895          , 'V', getdate(),  19830        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19896          , 'V', getdate(),  19831        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19897          , 'V', getdate(),  19831        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19898          , 'V', getdate(),  19831        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19899          , 'V', getdate(),  19831        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19900          , 'V', getdate(),  19831        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19901          , 'V', getdate(),  19820        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19902          , 'V', getdate(),  19832        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19903          , 'V', getdate(),  19833        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19904          , 'V', getdate(),  19834        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19905          , 'V', getdate(),  19834        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19906          , 'V', getdate(),  19834        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19907          , 'V', getdate(),  19835        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19908          , 'V', getdate(),  19835        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19909          , 'V', getdate(),  19836        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19910          , 'V', getdate(),  19837        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19911          , 'V', getdate(),  19838        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19912          , 'V', getdate(),  19839        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19913          , 'V', getdate(),  19839        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19914          , 'V', getdate(),  19840        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19915          , 'V', getdate(),  19840        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19916          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19917          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19918          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19919          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19920          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19921          , 'V', getdate(),  19828        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19922          , 'V', getdate(),  19826        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19923          , 'V', getdate(),  19826        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19924          , 'V', getdate(),  19826        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19925          , 'V', getdate(),  19827        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19926          , 'V', getdate(),  19827        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19927          , 'V', getdate(),  19003        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19928          , 'V', getdate(),  19833        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19929          , 'V', getdate(),  19002        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19930          , 'V', getdate(),  19006        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19931          , 'V', getdate(),  19802        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19932          , 'V', getdate(),  19841        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19933          , 'V', getdate(),  19842        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19934          , 'V', getdate(),  19843        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19935          , 'V', getdate(),  19844        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19936          , 'V', getdate(),  19844        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19937          , 'V', getdate(),  19844        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19938          , 'V', getdate(),  19844        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19939          , 'V', getdate(),  19844        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19940          , 'V', getdate(),  19843        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19941          , 'V', getdate(),  19843        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19942          , 'V', getdate(),  19843        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19943          , 'V', getdate(),  19843        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19944          , 'V', getdate(),  19845        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19945          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19946          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19947          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19948          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19949          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19950          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19951          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19952          , 'V', getdate(),  19846        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19953          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19954          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19955          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19956          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19957          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19958          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19959          , 'V', getdate(),  19947        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19970          , 'V', getdate(),  19950        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19971          , 'V', getdate(),  19950        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19972          , 'V', getdate(),  19950        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19973          , 'V', getdate(),  19950        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19974          , 'V', getdate(),  19951        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19975          , 'V', getdate(),  19951        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19976          , 'V', getdate(),  19951        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19977          , 'V', getdate(),  19951        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19978          , 'V', getdate(),  19078        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19979          , 'V', getdate(),  19030        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19980          , 'V', getdate(),  21191        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19981          , 'V', getdate(),  8235         , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19982          , 'V', getdate(),  19077        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19983          , 'V', getdate(),  19023        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19984          , 'V', getdate(),  19950        , null)
insert into ad_pro_transaccion values ( 19          , 'R', @w_moneda,  19985          , 'V', getdate(),  19951        , null)
go

-- RELACION DE LAS TRANSACCIONES DE FRONTEND CON UN SP FICTICIO
declare @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete ad_pro_transaccion
 where pt_producto = 19
   and pt_transaccion between 19505 and 19551
   and pt_transaccion not in (19514, 19524, 19534, 19544)
   and pt_moneda = @w_moneda
   
insert into ad_pro_transaccion (
   pt_producto,      pt_tipo,        pt_moneda,
   pt_transaccion,   pt_estado,      pt_fecha_ult_mod,
   pt_procedure,     pt_especial  )
select
   19,               'R',            @w_moneda,
   tn_trn_code,      'V',            getdate(),
   19500,            null
  from cl_ttransaccion
 where tn_trn_code between 19505 and 19551
   and tn_trn_code not in (19514, 19524, 19534, 19544)
go

/*Fin_Relacion_entre_Stored_Procedures_y_Transacciones*/

print 'INICIO DE INGRESO DE TRANSACCIONES AUTORIZADAS '
/* Transacciones Autorizadas */

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 1
   and ta_transaccion in (15030,15031,15037,15069,15098,15103,15222,19150,19872,19746,1504 ,1556 ,1562 ,1564 ,1565 ,1571 ,1574 ,1577 ,1578 ,1579 ,568  ,
                          584  ,585  ,1502 ,19865,19944,19866,19871,28744)

/* Ingreso de transacciones autorizadas para conexion y desconexion */

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15030, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15031, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15037, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15069, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15098, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15103, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 15222, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19150, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19872, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19746, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1504 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1556 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1562 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1564 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1565 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1571 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1574 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1577 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1578 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1579 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 568  , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 584  , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 585  , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 1502 , @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19865, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19944, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19866, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 19871, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 1, 'R',  @w_rol , 28744, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 2
   and ta_transaccion in (1182,1241)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 2, 'R',  @w_rol , 1182, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 2, 'R',  @w_rol , 1241, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 6
   and ta_transaccion in (6901)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 6, 'R',  @w_rol , 6901, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 7
   and ta_transaccion in (7107)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 7, 'R',  @w_rol , 7107, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 8
   and ta_transaccion in (8008,8073,1502)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 8, 'R',  @w_rol , 8008, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 8, 'R',  @w_rol , 8073, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 8, 'R',  @w_rol , 1502, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 19
   and ta_transaccion in (19865,19944,19945,19946,19947,19948,19949,19950,19951,19952,19953,19954,19955,19956,19957,19958,19970,19971,19972,19973,19974,
                          19975,19976,19977,19978,19748,19749,19750,19751,19752,19753,19754,19760,19763,19774,19777,19778,19779,19780,19781,19782,19783,
                          19784,19785,19786,19810,19811,19812,19813,19814,19816,19820,19821,19822,19823,19824,19825,19826,19827,19828,19829,19830,19831,
                          19832,19833,19834,19835,19836,19837,19838,19843,19844,19846,19850,19851,19852,19854,19855,19856,19857,19858,19859,19860,19861,
                          19862,19863,19864,19982,19980,19981,19871,19979,19866,19867,19868,19869,19870,19983,19984,19985,19872,19873,19874,19875,19876,
                          19877,19878,19879,19880,19881,19882,19883,19884,19885,19886,19887,19888,19889,19890,19891,19892,19893,19894,19895,19896,19897,
                          19898,19899,19900,19901,19902,19903,19904,19905,19906,19907,19908,19909,19910,19911,19912,19913,19914,19915,19916,19917,19918,
                          19919,19920,19921,19922,19923,19924,19925,19926,19927,19928,19929,19930,19931,19932,19933,19934,19935,19936,19937,19938,19939,
                          19940,19941,19942,19943,19150,19151,19160,19161,19162,19163,19164,19165,19166,19167,19175,19184,19193,19194,19196,19197,19204,
                          19214,19224,19233,19245,19254,19264,19270,19284,19295,19304,19305,19307,19308,19309,19310,19326,19334,19344,19354,19364,19371,
                          19377,19384,19394,19404,19414,19424,19434,19445,19455,19465,19475,19494,19504,19514,19524,19534,19544,19554,19564,19565,19574)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19865, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19944, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19945, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19946, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19947, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19948, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19949, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19950, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19951, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19952, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19953, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19954, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19955, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19956, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19957, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19958, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19970, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19971, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19972, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19973, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19974, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19975, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19976, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19977, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19978, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19748, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19749, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19750, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19751, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19752, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19753, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19754, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19760, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19763, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19774, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19777, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19778, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19779, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19780, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19781, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19782, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19783, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19784, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19785, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19786, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19810, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19811, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19812, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19813, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19814, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19816, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19820, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19821, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19822, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19823, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19824, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19825, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19826, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19827, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19828, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19829, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19830, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19831, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19832, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19833, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19834, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19835, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19836, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19837, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19838, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19843, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19844, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19846, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19850, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19851, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19852, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19854, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19855, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19856, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19857, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19858, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19859, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19860, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19861, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19862, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19863, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19864, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19982, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19980, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19981, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19871, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19979, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19866, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19867, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19868, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19869, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19870, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19983, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19984, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19985, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19872, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19873, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19874, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19875, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19876, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19877, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19878, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19879, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19880, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19881, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19882, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19883, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19884, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19885, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19886, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19887, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19888, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19889, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19890, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19891, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19892, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19893, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19894, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19895, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19896, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19897, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19898, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19899, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19900, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19901, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19902, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19903, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19904, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19905, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19906, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19907, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19908, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19909, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19910, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19911, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19912, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19913, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19914, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19915, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19916, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19917, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19918, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19919, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19920, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19921, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19922, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19923, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19924, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19925, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19926, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19927, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19928, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19929, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19930, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19931, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19932, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19933, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19934, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19935, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19936, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19937, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19938, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19939, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19940, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19941, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19942, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19943, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19150, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19151, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19160, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19161, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19162, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19163, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19164, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19165, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19166, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19167, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19175, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19184, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19193, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19194, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19196, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19197, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19204, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19214, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19224, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19233, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19245, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19254, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19264, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19270, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19284, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19295, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19304, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19305, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19307, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19308, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19309, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19310, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19326, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19334, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19344, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19354, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19364, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19371, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19377, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19384, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19394, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19404, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19414, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19424, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19434, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19445, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19455, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19465, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19475, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19494, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19504, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19514, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19524, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19534, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19544, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19554, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19564, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19565, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19574, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 19
   and ta_transaccion in (19584,19594,19604,19614,19624,19625,19630,19631,19632,19634,19635,19640,19641,19642,19644,19645,19654,19655,19656,19657,19658,
                          19659,19661,19662,19663,19664,19674,19678,19684,19704,19705,19710,19726,19730,19731,19732,19733,19734,19735,19736,19737,19738,
                          19739,19740,19741,19742,19743,19744,19745,19000,19001,19002,19003,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,
                          19014,19015,19016,19017,19018,19019,19020,19021,19022,19023,19024,19025,19026,19030,19031,19032,19033,19034,19035,19036,19037,
                          19038,19039,19040,19041,19042,19043,19044,19045,19046,19047,19048,19049,19050,19051,19052,19053,19054,19055,19056,19060,19061,
                          19062,19063,19064,19065,19066,19067,19068,19069,19070,19071,19072,19073,19074,19075,19076,19077,19078,19080,19081,19082,19083,
                          19084,19085,19086,19090,19091,19092,19093,19094,19095,19096,19097,19098,19099,19100,19101,19102,19103,19104,19105,19106,19107,
                          19108,19109,19110,19111,19112,19113,19114,19115,19116,19117,19118,19119,19120,19121,19122,19123,19124,19125,19126,19127,19128,
                          19130,19131,19132,19133,19134,19135,19136,19137,19138,19139,19140,19141,19142,19143,19144,19145,19146,19147,19148)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19584, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19594, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19604, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19614, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19624, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19625, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19630, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19631, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19632, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19634, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19635, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19640, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19641, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19642, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19644, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19645, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19654, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19655, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19656, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19657, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19658, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19659, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19661, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19662, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19663, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19664, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19674, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19678, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19684, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19704, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19705, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19710, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19726, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19730, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19731, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19732, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19733, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19734, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19735, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19736, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19737, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19738, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19739, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19740, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19741, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19742, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19743, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19744, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19745, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19000, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19001, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19002, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19003, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19004, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19005, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19006, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19007, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19008, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19009, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19010, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19011, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19012, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19013, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19014, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19015, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19016, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19017, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19018, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19019, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19020, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19021, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19022, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19023, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19024, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19025, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19026, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19030, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19031, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19032, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19033, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19034, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19035, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19036, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19037, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19038, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19039, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19040, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19041, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19042, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19043, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19044, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19045, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19046, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19047, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19048, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19049, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19050, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19051, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19052, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19053, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19054, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19055, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19056, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19060, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19061, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19062, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19063, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19064, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19065, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19066, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19067, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19068, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19069, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19070, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19071, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19072, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19073, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19074, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19075, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19076, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19077, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19078, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19080, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19081, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19082, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19083, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19084, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19085, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19086, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19090, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19091, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19092, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19093, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19094, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19095, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19096, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19097, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19098, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19099, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19100, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19101, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19102, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19103, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19104, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19105, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19106, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19107, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19108, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19109, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19110, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19111, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19112, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19113, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19114, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19115, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19116, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19117, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19118, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19119, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19120, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19121, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19122, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19123, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19124, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19125, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19126, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19127, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19128, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19130, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19131, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19132, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19133, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19134, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19135, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19136, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19137, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19138, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19139, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19140, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19141, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19142, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19143, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19144, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19145, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19146, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19147, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 19, 'R',  @w_rol , 19148, @w_moneda, getdate(), 1, 'V', getdate())
go

declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial      = 1

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
delete ad_tr_autorizada
 where ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_producto = 21
   and ta_transaccion in (21041,21042,21045,21048,21145,21368,21445,21545,21611,21612,21668,21815,21819,21839,21884,21891,21970,21971,19979,19981,19980,19982,19978)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21041, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21042, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21045, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21048, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21145, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21368, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21445, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21545, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21611, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21612, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21668, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21815, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21819, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21839, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21884, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21891, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21970, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 21971, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 19979, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 19981, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 19980, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 19982, @w_moneda, getdate(), 1, 'V', getdate())
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) values( 21, 'R',  @w_rol , 19978, @w_moneda, getdate(), 1, 'V', getdate())

-- AUTORIZACION DE LAS TRANSACCIONES DE FRONTEND AL ADMINISTRADOR
delete ad_tr_autorizada
 where ta_producto = 19
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion between 19505 and 19551
   and ta_transaccion not in (19514, 19524, 19534, 19544)

insert into ad_tr_autorizada(
   ta_producto,      ta_tipo,       ta_moneda,
   ta_transaccion,   ta_rol,        ta_fecha_aut,
   ta_autorizante,   ta_estado,     ta_fecha_ult_mod
)
select
   19,               'R',           @w_moneda,
   tn_trn_code,      @w_rol,        getdate(),
   1,                'V',           getdate()
  from cl_ttransaccion
 where tn_trn_code between 19505 and 19551
   and tn_trn_code not in (19514, 19524, 19534, 19544)

print 'Fin cu_trans.sql'
go

