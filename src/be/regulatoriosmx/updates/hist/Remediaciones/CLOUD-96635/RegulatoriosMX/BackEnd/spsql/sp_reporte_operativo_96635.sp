/************************************************************************/
/*   Archivo:                 sp_reporte_operativo_96635.sp             */
/*   Stored procedure:        sp_reporte_operativo_96635                */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Marzo 21 de 2018                          */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   21/03/2018 Jorge Salazar   Emision Inicial                         */
/************************************************************************/
use cob_conta_super
go

if not object_id('sp_reporte_operativo_96635') is null
   drop proc sp_reporte_operativo_96635
go

create proc sp_reporte_operativo_96635
   @i_param1   varchar(10),   --FECHA
   @i_param2   varchar(10),   --BATCH
   @i_param3   varchar(10)    --FORMATO FECHA
as
declare 
@w_s_app           varchar(255),
@w_path            varchar(255),
@w_destino         varchar(255),
@w_destino2        varchar(255),
@w_errores         varchar(255),
@w_cmd             varchar(5000),
@w_error           int,
@w_comando         varchar(6000),
@w_fecha           datetime,
@w_batch           int,
@w_columna         varchar(50),
@w_col_id          int,
@w_cabecera        varchar(5000),
@w_mes             char(20),
@w_anio            char(4), 
@w_fecha2          char(10),
@w_fecha_desde     datetime,
@w_lineas          varchar(10),
@w_garhip          varchar(10),
@w_garpre          varchar(10),
@w_fp_usaid        varchar(30),
@w_tabla           int,
@w_estado_nota     char(1),
@w_empresa         tinyint,
@w_formato_fecha   int,
@w_est_vencido     int,
@w_est_vigente     int,
@w_est_castigado   int


select
@w_batch         = convert(int,@i_param2),
@w_formato_fecha = convert(int,@i_param3),
@w_fecha         = @i_param1

select @w_empresa = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'EMP'
and   pa_producto = 'ADM'

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end


SET NOCOUNT ON
SET ROWCOUNT 0


/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA SB_DATO_OPERACION */
select 
mca_fecha                = convert(varchar,do_fecha,111),
mca_territorial          = convert(varchar(64),''),
mca_division             = convert(varchar(64),''),
mca_region               = convert(varchar(64),''),
mca_oficina              = do_oficina,
mca_banco                = do_banco,
mca_grupo                = do_grupo,
mca_nombre_grupo         = convert(varchar(64),''),
mca_tipo_doc             = convert(varchar(10),''),
mca_doc_cliente          = convert(varchar(24),''),
mca_tramite              = do_tramite,
mca_oficial_ci           = convert(varchar(64),''),
mca_oficial_id           = do_oficial,
mca_oficial              = convert(varchar(64),''),
mca_id_cliente           = do_codigo_cliente,
mca_nombre1              = convert(varchar(64),''),
mca_nombre2              = convert(varchar(64),''),
mca_apellido_paterno     = convert(varchar(64),''),
mca_apellido_materno     = convert(varchar(64),''),
mca_genero               = convert(varchar(10),''),
mca_edad                 = convert(int,0),
mca_fecha_nac            = convert(datetime,null),
mca_tel_negocio          = convert(varchar(16),''),
mca_tel_cliente          = convert(varchar(16),''),
mca_dir_negocio          = convert(varchar(254),''),
mca_dir_domicil          = convert(varchar(254),''),
mca_dep_negocio          = convert(varchar(64),''),
mca_dep_domicil          = convert(varchar(64),''),
mca_ciu_negocio          = convert(varchar(64),''),
mca_ciu_domicil          = convert(varchar(64),''),
mca_bar_negocio          = convert(varchar(64),''),
mca_bar_domicil          = convert(varchar(64),''),
mca_cp_domicil           = convert(int,0),
mca_cp_negocio           = convert(int,0),
mca_tlocal_negocio       = convert(varchar(64),''),
mca_pers_cargo           = convert(int,0),
mca_hijos                = convert(int,0),
mca_estrato              = convert(varchar(64),''),
mca_est_civil            = convert(varchar(64),''),
mca_tipo_vivienda        = convert(varchar(64),''),
mca_nivel_estudio        = convert(varchar(64),''),
mca_cony_nombres         = convert(varchar(64),''),
mca_cony_tipo_doc        = convert(varchar(10),''),
mca_cony_doc             = convert(varchar(30),''),
mca_codeudor1            = convert(varchar(64),''),
mca_codeudor1_dir        = convert(varchar(255),''),
mca_codeudor1_tel        = convert(varchar(16),''),
mca_codeudor2            = convert(varchar(64),''),
mca_codeudor2_dir        = convert(varchar(255),''),
mca_codeudor2_tel        = convert(varchar(16),''),
mca_codeudor3            = convert(varchar(64),''),
mca_codeudor3_dir        = convert(varchar(255),''),
mca_codeudor3_tel        = convert(varchar(16),''),
mca_cr_otros_banc        = convert(int,0),
mca_num_creditos         = convert(int,0),
mca_procedencia          = convert(varchar(64),''),
mca_act_economica        = convert(varchar(200),''),
mca_antiguedad           = convert(int,0),
mca_experiencia          = convert(varchar(10),'N'),
mca_dst_economico        = convert(varchar(64),''),
mca_total_act            = convert(money,0),
mca_total_pas            = convert(money,0),
mca_total_pat            = convert(money,0),
mca_total_ing_b          = convert(money,0),  
mca_total_gastos         = convert(money,0), 
mca_total_ing_add        = convert(money,0),
mca_total_dec_jur        = convert(money,0),
mca_liquidez_disp        = convert(money,0),
mca_banca                = convert(varchar(64),''),
mca_mercado_obj          = convert(varchar(64),''),
mca_mercado_sub          = convert(varchar(64),''),
mca_sujeto_cred          = convert(varchar(64),''),
mca_tipo_usuario         = convert(varchar(64),''),
mca_monto                = do_monto,
mca_monto_par            = convert(money,0),
mca_fecha_sol            = convert(datetime,null),
mca_tipo_cred            = convert(varchar(64),''),
mca_tipo_cuota           = convert(varchar(64),''),
mca_dia_cuota            = convert(int,0),
mca_saldo_cap            = do_saldo_cap,
mca_saldo_int            = convert(money,0),
mca_saldo_cmora          = convert(money,0),
mca_saldo_int_cont       = do_saldo_int_contingente,
mca_saldo_imo            = convert(money,0),
mca_saldo_mip            = convert(money,0),
mca_saldo_fng            = convert(money,0),
mca_saldo_seg            = convert(money,0),
mca_saldo_otr            = convert(money,0),
mca_monto_pg_fng         = convert(money,0),
mca_saldo_cap_v          = do_valor_mora,
mca_saldo_int_v          = convert(money,0),
mca_saldo_imo_v          = convert(money,0),
mca_saldo_mip_v          = convert(money,0),
mca_saldo_fng_v          = convert(money,0),
mca_saldo_seg_v          = convert(money,0),
mca_saldo_otr_v          = convert(money,0),
mca_saldo_v              = do_valor_mora,
mca_pag_cap              = convert(money,0),
mca_pag_int              = convert(money,0),
mca_pag_imo              = convert(money,0),
mca_pag_mip              = convert(money,0),
mca_pag_fng              = convert(money,0),
mca_pag_seg              = convert(money,0),
mca_pag_abog             = convert(money,0),
mca_pag_f_abog           = convert(datetime,null),
mca_pag_otr              = convert(money,0),
mca_pag_total            = convert(money,0),
mca_pag_rev              = convert(money,0),
mca_estado_car           = convert(varchar(64),do_estado_cartera),
mca_estado_cob           = convert(varchar(64),''),
mca_rango_mora           = convert(varchar(30),''),
mca_etapa_cobranza       = convert(varchar(10),''),
mca_fecha_exp            = convert(datetime,null),
mca_abogado_int          = convert(varchar(64),''),
mca_acuerdo_pag          = convert(varchar(10),'N'),
mca_num_acuer_pag        = convert(int,0),
mca_ult_fec_ac_pg        = convert(datetime,null),
mca_valor_acuerdo        = convert(money,null),
mca_tasa_int             = do_tasa_com,
mca_tasa_com             = convert(float,0),
mca_tasa_mor             = convert(float,0),
mca_nota                 = convert(tinyint,0),
mca_calif_temp           = convert(varchar(10),''),
mca_clase_cartera        = convert(varchar(64),do_clase_cartera),
mca_fecha_desem          = do_fecha_concesion,
mca_fecha_vencimiento    = do_fecha_vencimiento,
mca_fecha_otorga         = convert(datetime,null),
mca_num_cuotas           = do_num_cuotas,
mca_plazo_dias           = do_plazo_dias,
mca_num_cuotaven         = do_num_cuotaven,
mca_toperacion           = do_tipo_operacion,
mca_valor_cuota          = do_valor_cuota,
mca_periodicidad         = do_periodicidad_cuota,
mca_prox_vto             = do_fecha_prox_vto,
mca_tipo_garantia        = do_tipo_garantias,
mca_saldo                = do_saldo,
mca_edad_mora            = do_edad_mora,
mca_valor_mora           = do_cap_vencido,
mca_fecha_ult_pago       = do_fecha_ult_pago,
mca_prov_cap             = do_prov_cap,
mca_prov_int             = do_prov_int,
mca_prov_cxc             = do_prov_cxc,
mca_prov_con_cap         = do_prov_con_cap,
mca_prov_con_int         = do_prov_con_int,
mca_prov_con_cxc         = do_prov_con_cxc,
mca_estado_contable      = do_estado_contable,
mca_calificacion         = do_calificacion,
mca_fecha_castigo        = do_fecha_castigo,
mca_num_acta             = do_num_acta,
mca_cuotas_pendietes     = do_num_cuotas - do_cuotas_pag,
mca_tipo_garantias       = do_tipo_garantias,
mca_valor_garantias      = do_valor_garantias,
mca_aplicativo           = do_aplicativo,
mca_op_lin_credito       = do_linea_credito,               --PGA
mca_consumo_cupo         = convert(money,0),               --PGA
mca_codres_colater       = convert(varchar(13),''),
mca_des_garantia         = convert(varchar(30),''),
mca_pago_x_recono        = convert(varchar(1),''),         --LCM
mca_fecha_recono         = convert(datetime,'01/01/1900'), --LCM
mca_vr_recono_recupera   = convert(money,0),               --LCM
mca_valor_amort          = convert(money,0),               --LCM
mca_subtipo_garantia     = convert(varchar(30),''),        --LCM
mca_3nivel_garantia      = convert(varchar(255),''),       --LCM
mca_des_gar_real         = convert(varchar(30),''),
mca_campana              = convert(int,0),
mca_campana_det          = convert(varchar(64),''),
mca_valor_recono         = convert(money,0),               --113336
mca_alianza              = convert(varchar(100),''),       --Req 353
mca_cat                  = convert(float,0)
into #maestro_cartera
from cob_conta_super..sb_dato_operacion
where do_fecha      = @w_fecha
and   do_aplicativo = 7
and   do_estado_cartera in (@w_est_vencido,@w_est_vigente,@w_est_castigado)

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx1 on #maestro_cartera(mca_banco)
create index idx2 on #maestro_cartera(mca_id_cliente)

----------------------------------------
--Actualizaciones Masivas
----------------------------------------

--Datos del Cliente
update #maestro_cartera set
mca_doc_cliente      = en_rfc,
mca_tipo_doc         = 'RFC',
mca_genero           = p_sexo,
mca_edad             = datediff(yy,p_fecha_nac,@w_fecha) - 
                       case when (month(@w_fecha) * 100) + day(@w_fecha) < (month(p_fecha_nac) * 100) + day(p_fecha_nac) then 1 else 0 end,
mca_fecha_nac        = p_fecha_nac,
mca_nombre1          = UPPER(isnull(en_nombre,'')),
mca_nombre2          = UPPER(isnull(p_s_nombre,'')),
mca_apellido_paterno = UPPER(isnull(p_p_apellido,'')),
mca_apellido_materno = UPPER(isnull(p_s_apellido,'')),
mca_est_civil        = p_estado_civil,
mca_nivel_estudio    = p_nivel_estudio,
--mca_act_economica   = en_actividad
mca_act_economica    =(SELECT isnull(ac_descripcion,' ') FROM 
cobis..cl_negocio_cliente,cobis..cl_actividad_ec WHERE 
nc_ente=mca_id_cliente AND nc_actividad_ec=ac_codigo AND nc_estado_reg='V' 
AND nc_codigo=(SELECT isnull(min(nc_codigo),0)
FROM cobis..cl_negocio_cliente WHERE nc_ente=mca_id_cliente AND nc_estado_reg='V' 
))
from cobis..cl_ente
where en_ente = mca_id_cliente

if @@error <> 0 begin
   print 'Error en actualizacion datos del cliente'
   return 1
end

--Actividad Economica del Cliente
/*update #maestro_cartera set
mca_act_economica   = ae_actividad
from cobis..cl_actividad_economica
where ae_ente = mca_id_cliente

if @@error <> 0 begin
   print 'Error en actualizacion de Actividad Economica del Cliente'
   return 1
end*/

select distinct
di_cliente          = mca_id_cliente,
di_neg_telefono     = mca_tel_negocio,
di_neg_cod_dir      = convert(int,0),
di_neg_direccion    = mca_dir_negocio,
di_neg_cod_depar    = convert(int,-999),
di_neg_depar        = mca_dep_negocio,
di_neg_cod_ciu      = convert(int,0),
di_neg_ciudad       = mca_ciu_negocio,
di_neg_cod_bar      = convert(int,0),
di_neg_barrio       = mca_bar_negocio,
di_neg_cp           = convert(int,0),
di_dom_cod_tel      = convert(int,0),
di_dom_telefono     = mca_tel_cliente,
di_dom_cod_dir      = convert(int,0),
di_dom_direccion    = mca_dir_domicil,
di_dom_cod_depar    = convert(int,-999),
di_dom_depar        = mca_dep_domicil,
di_dom_cod_ciu      = convert(int,0),
di_dom_ciudad       = mca_ciu_domicil,
di_dom_cod_bar      = convert(int,0),
di_dom_barrio       = mca_bar_domicil,
di_dom_cp           = convert(int,0),
di_tlocal_negocio   = mca_tlocal_negocio,
di_tiempo_actividad = convert(int,0)
into #direcciones
from #maestro_cartera

create index idx1 on #direcciones(di_cliente)


update #direcciones set
di_neg_cod_dir     = di_direccion,
di_neg_direccion   = rtrim('Calle: '+di_calle+' N.-: '+convert(varchar(50),di_nro)),
di_neg_cod_ciu     = di_ciudad,
di_neg_cod_bar     = di_parroquia,
di_neg_cod_depar   = di_provincia,
di_neg_cp          = di_codpostal
from cobis..cl_direccion
where di_ente = di_cliente
and   di_tipo = 'AE' 
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and   di_tipo = 'AE') --negocio


update #direcciones set
di_dom_cod_dir     = di_direccion,
di_dom_direccion   = rtrim('Calle: '+di_calle+' N.-: '+convert(varchar(50),di_nro)),
di_dom_cod_tel     = di_telefono,
di_dom_cod_ciu     = di_ciudad,
di_dom_cod_bar     = di_parroquia,
di_dom_cod_depar   = di_provincia,
di_dom_cp          = di_codpostal
from cobis..cl_direccion
where di_ente = di_cliente
and   di_tipo = 'RE'  
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and   di_tipo = 'RE')--domicilio


/*TELEFONO*/
update #direcciones set
di_neg_telefono = case when te_prefijo <> '' then ltrim(rtrim(te_prefijo)) +'-'+ isnull(te_valor,0) else te_valor end 
from cobis..cl_telefono
where te_ente       = di_cliente
and   te_direccion  = di_neg_cod_dir

update #direcciones set
di_dom_telefono = case when te_prefijo <> '' then ltrim(rtrim(te_prefijo)) +'-'+ isnull(te_valor,0) else te_valor end 
from cobis..cl_telefono
where te_ente       = di_cliente
and   te_direccion  = di_dom_cod_dir

/*CIUDAD*/
update #direcciones set
di_neg_ciudad = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = di_neg_cod_ciu   --negocio

update #direcciones set
di_dom_ciudad = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = di_dom_cod_ciu   --domicilio


/*DEPARTAMENTO*/
update #direcciones set
di_neg_depar = pv_descripcion
from cobis..cl_provincia
where pv_provincia = di_neg_cod_depar   --negocio

update #direcciones set
di_dom_depar = pv_descripcion
from cobis..cl_provincia
where pv_provincia = di_dom_cod_depar   --domicilio


/*BARRIO*/
update #direcciones set
di_neg_barrio = pq_descripcion
from cobis..cl_parroquia
where pq_parroquia = di_neg_cod_bar   --negocio

update #direcciones set
di_dom_barrio = pq_descripcion
from cobis..cl_parroquia
where pq_parroquia = di_dom_cod_bar   --domicilio

--Datos del Negocio
update #direcciones set
di_tlocal_negocio   = nc_tipo_local,
di_tiempo_actividad = nc_tiempo_actividad
from cobis..cl_negocio_cliente
where di_cliente     = nc_ente
and   nc_estado_reg  = 'V'

if @@error <> 0 begin
   print 'Error Actualizando Datos de Negocio'
   return 1
end


/*ACTUALIZA LA MAESTRO DE CARTERA*/

--Datos de Direccion Negocio y Domicilio
update #maestro_cartera set
mca_tel_negocio    = di_neg_telefono,
mca_dir_negocio    = di_neg_direccion,
mca_dep_negocio    = di_neg_depar,
mca_ciu_negocio    = di_neg_ciudad,
mca_bar_negocio    = di_neg_barrio,
mca_cp_negocio     = di_neg_cp,
mca_tel_cliente    = di_dom_telefono,
mca_dir_domicil    = di_dom_direccion,
mca_dep_domicil    = di_dom_depar,
mca_ciu_domicil    = di_dom_ciudad,
mca_bar_domicil    = di_dom_barrio,
mca_cp_domicil     = di_dom_cp,
mca_tlocal_negocio = di_tlocal_negocio,
mca_experiencia    = di_tiempo_actividad
from #direcciones
where mca_id_cliente = di_cliente

if @@error <> 0 begin
   print 'Error Actualizando Datos de Negocio y Domicilio'
   return 1
end

--Datos del Conyuge
update #maestro_cartera
set mca_cony_nombres    = isnull(hi_papellido,'') + ' ' + isnull(hi_sapellido,'') + ' ' + isnull(hi_nombre,''),
    mca_cony_tipo_doc   = hi_tipo_doc,
    mca_cony_doc        = hi_documento
from cobis..cl_hijos
where hi_ente = mca_id_cliente
and   hi_tipo = 'C'

if @@error <> 0 begin
   print 'Error Actualizando Datos de Conyuge'
   return 1
end

--Division
update #maestro_cartera
set mca_division = of_descripcion
from cob_conta..cb_oficina
where of_empresa = @w_empresa
and   of_oficina = mca_oficina

if @@error <> 0 begin
   print 'Error Actualizando Datos Division'
   return 1
end


--Regional
update #maestro_cartera
set mca_region = (select A.of_nombre
                  from cobis..cl_oficina A, cobis..cl_oficina B
                  where A.of_oficina = B.of_regional
                  and   B.of_oficina = P.mca_oficina)
from  #maestro_cartera P

if @@error <> 0 begin
   print 'Error Actualizando Datos Regional'
   return 1
end

update #maestro_cartera
set mca_nombre_grupo = gr_nombre
from cobis..cl_grupo
where gr_grupo = mca_grupo

if @@error <> 0 begin
   print 'Error Actualizando Nombre Grupo'
   return 1
end

--Nombre oficial original
update #maestro_cartera
set mca_oficial = fu_login
from cobis..cc_oficial , cobis..cl_funcionario
where oc_funcionario = fu_funcionario
and   oc_oficial     = mca_oficial_id

if @@error <> 0 begin
   print 'Error Actualizando Datos del Oficial Original'
   return 1
end


--Saldos
select banco        = dr_banco,       
       saldo_int    = sum(case dr_concepto when 'INT'         then dr_valor else 0   end),
       saldo_cmora  = sum(case dr_concepto when 'COMMORA'     then dr_valor else 0   end),
       saldo_seg    = sum(case dr_concepto when 'SEGDEUANT'   then dr_valor
                                           when 'SEGDEUVEN'   then dr_valor
                                           when 'SEGDEUEM'    then dr_valor else 0 end),
       saldo_otr    = sum(case when dr_concepto not in ('CAP','INT', 'COMMORA', 'SEGDEUANT','SEGDEUVEN','SEGDEUEM') then dr_valor else 0 end)
into #saldos_rop
from  cob_conta_super..sb_dato_operacion_rubro
where dr_fecha       = @w_fecha
and   dr_aplicativo  = 7
group by dr_banco


update #maestro_cartera
set mca_saldo_int     = saldo_int,
    mca_saldo_cmora   = saldo_cmora,
    mca_saldo_seg     = saldo_seg,
    mca_saldo_otr     = saldo_otr
from #saldos_rop
where banco = mca_banco

if @@error <> 0 begin
   print 'Error Actualizando de Rubros Operacion'
   return 1
end

----------------------------------------
--Datos Credito
----------------------------------------
update #maestro_cartera
set mca_fecha_sol    = tr_fecha_crea,
    mca_dst_economico= tr_destino,
    mca_fecha_otorga = tr_fecha_apr
from cob_credito..cr_tramite
where tr_tramite = mca_tramite

if @@error <> 0 begin
   print 'Error Actualizando Datos Credito'
   return 1
end

------------------------------------------
--Actualizar descripciones de catalogos
------------------------------------------
update #maestro_cartera
set mca_est_civil = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and   t.tabla       = 'cl_ecivil'
and   mca_est_civil = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cl_ecivil'
   return 1
end

update #maestro_cartera
set mca_nivel_estudio = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and   t.tabla       = 'cl_nivel_estudio'
and   mca_nivel_estudio = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cl_nivel_estudio'
   return 1
end

/*update #maestro_cartera
set mca_act_economica = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo          = c.tabla 
and   t.tabla           = 'cl_actividad'
and   mca_act_economica = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cl_actividad'
   return 1
end
*/
update #maestro_cartera
set mca_dst_economico = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo          = c.tabla
and   t.tabla           = 'cr_destino'
and   mca_dst_economico = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cr_destino'
   return 1
end

update #maestro_cartera
set mca_tlocal_negocio = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo           = c.tabla
and   t.tabla            = 'cr_tipo_local'
and   mca_tlocal_negocio = c.codigo

if @@error <> 0 begin
   print 'Error Actualizando cr_tipo_local'
   return 1
end

update #maestro_cartera
set mca_cat = op_valor_cat
from cob_cartera..ca_operacion
where op_banco = mca_banco

if @@error <> 0 begin
   print 'Error Actualizando op_valor_cat'
   return 1
end

----------------------------------------
--Paso de datos a tabla formato reporte
----------------------------------------

/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
if not object_id('sb_reporte_operativo') is null drop table sb_reporte_operativo

select 
'DIVISION'                   = isnull(mca_division,' '),
'REGION'                     = isnull(mca_region,' '),
'AGENCIA'                    = isnull(mca_oficina,0),
'No. OBLIGACION'             = isnull(mca_banco,' '),
'ID GRUPO'                   = isnull(mca_grupo,0),
'NOMBRE GRUPO'               = isnull(mca_nombre_grupo,' '),
'TIPO DOCUMENTO'             = isnull(mca_tipo_doc,' '),
'DOCUMENTO'                  = isnull(mca_doc_cliente,' '),
'Nro Cliente'                = isnull(mca_id_cliente,0),
'NOMBRE1'                    = isnull(mca_nombre1,' '),
'NOMBRE2'                    = isnull(mca_nombre2,' '),
'APELLIDO PATERNO'           = isnull(mca_apellido_paterno,' '),
'APELLIDO MATERNO'           = isnull(mca_apellido_materno,' '),
'GENERO'                     = isnull(mca_genero,' '),
'EDAD'                       = isnull(mca_edad,0),
'FECHA NACIMIENTO'           = isnull(convert(varchar,mca_fecha_nac,@w_formato_fecha),' '),
'DOM_TELEFONO'               = isnull(mca_tel_cliente,' '),
'DOM_DIRECCION'              = isnull(mca_dir_domicil,' '),
'DOM_ESTADO'                 = isnull(mca_dep_domicil,' '),
'DOM_MUNICIPIO'              = isnull(mca_ciu_domicil,' '),
'DOM_LOCALIDAD'              = isnull(mca_bar_domicil,' '),
'DOM_CP'                     = isnull(mca_cp_domicil,0),
'NEG_TELEFONO'               = isnull(mca_tel_negocio,' '),
'NEG_DIRECCION'              = isnull(mca_dir_negocio,' '),
'NEG_ESTADO'                 = isnull(mca_dep_negocio,' '),
'NEG_MUNICIPIO'              = isnull(mca_ciu_negocio,' '),
'NEG_LOCALIDAD'              = isnull(mca_bar_negocio,' '),
'NEG_CP'                     = isnull(mca_cp_negocio,0),
'NEG_TIPO DE LOCAL'          = isnull(mca_tlocal_negocio,' '),
'ESCOLARIDAD'                = isnull(mca_nivel_estudio,' '),
'ACTIVIDAD ECONOMICA'        = isnull(mca_act_economica,' '),
'EXPERIENCIA ACT'            = isnull(mca_experiencia,' '),
'ESTADO CIVIL'               = isnull(mca_est_civil,' '),
'NOMBRE CONYUGE'             = isnull(mca_cony_nombres,' '),
'TIPO DOC CONYUGE'           = isnull(mca_cony_tipo_doc,' '),
'DOCUMENTO CONYUGE'          = isnull(mca_cony_doc,' '),
'DESTINO DEL CREDITO'        = isnull(mca_dst_economico,' '),
'PRODUCTO DE PRESTAMOS'      = isnull(mca_toperacion,' '),
'MONTO CREDITO'              = isnull(round(mca_monto,2),0),
'FECHA SOLICITUD'            = isnull(convert(varchar,mca_fecha_sol,@w_formato_fecha),' '),
'FECHA DESEMBOLSO'           = isnull(convert(varchar,mca_fecha_desem,@w_formato_fecha),' '),
'FECHA VENCIMIENTO PRESTAMO' = isnull(convert(varchar,mca_fecha_vencimiento,@w_formato_fecha),' '),
'NUMERO CUOTAS'              = isnull(mca_num_cuotas,0),
'PLAZO DIAS'                 = isnull(mca_plazo_dias,0),
'VALOR CUOTA'                = isnull(round(mca_valor_cuota,2),0),
'PERIOD.CUOTA DIAS'          = isnull(mca_periodicidad,0),
'FECHA PROX. CUOTA'          = isnull(convert(varchar,mca_prox_vto,@w_formato_fecha),' '),
'ASESOR RESPONSABLE'         = isnull(mca_oficial,' '),
'TASA INTERES (ANUAL)'       = isnull(mca_tasa_int,0),--
'CUOTAS PENDIENTES'          = isnull(mca_cuotas_pendietes,0),--
'CUOTAS VENCIDAS'            = isnull(mca_num_cuotaven,0),--
'SALDO CAP'                  = isnull(round(mca_saldo_cap,2),0),
'SALDO INT'                  = isnull(round(mca_saldo_int,2),0),
'SALDO COMMORA'              = isnull(round(mca_saldo_cmora,2),0),
'SALDO SEG'                  = isnull(round(mca_saldo_seg,2),0),
'SALDO OTR'                  = isnull(round(mca_saldo_otr,2),0),
'SALDO TOTAL'                = isnull(round(mca_saldo,2),0),
'SALDO EXIGIBLE'             = isnull(round(mca_saldo_v,2),0),
'DIAS MORA'                  = isnull(mca_edad_mora,0),
'ESTADO CARTERA'             = isnull(mca_estado_car,0),
'CAT'                        = isnull(mca_cat,0)
into sb_reporte_operativo
from #maestro_cartera


----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_operativo out '

select @w_destino  = @w_path + 'repoperativo_' + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_destino2 = @w_path + 'lineas_'      + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
       @w_errores  = @w_path + 'repoperativo_' + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'repoperativo -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end

----------------------------------------
-- Lineas Plano
----------------------------------------

select @w_lineas = convert(varchar,isnull(count(1),0)) from cob_conta_super..sb_reporte_operativo
select @w_comando = 'echo ' + @w_lineas + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas'
   print @w_comando
   return 1
end

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
       
while 1 = 1 begin
   set rowcount 1
   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_reporte_operativo'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + char(9)
end
--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_destino + ' ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas mas cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'repoperativo ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Agregando Cabeceras'
   print @w_comando
   return 1
end

return 0

go
