/************************************************************************/
/*   Archivo:              SantanderGenOrdenDep.sp                      */
/*   Stored procedure:     sp_santander_gen_orden_dep                   */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Raul Altamirano Mendez                       */
/*   Fecha de escritura:   Junio 2017                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera archivo de interface para ordenes de deposito, de cliente   */
/*   banco SANTANDER MX.                                                */
/*                              CAMBIOS                                 */
/*   26/03/2018        D.Cumbal         Cambios Caso 94602              */
/*   14/10/2019        J.Sanchez        Cambios Caso 124807             */
/*   20/07/2019        P.Romero         Req. 115252 Desc. de Tasa       */
/*   21/10/2019        AGO              Req. 119972  Colectivos         */
/*   28-12-2020        DCU              #151513                         */
/*   08-03-2021        ACH              Validacion estado V para presi  */
/*   11-01-2023        DCU              #189983 - validacion operacion  */
/*   08/06/2023        DCU              #209310 - bloquear sobrante     */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_santander_gen_orden_dep')
   drop proc sp_santander_gen_orden_dep
go

create proc sp_santander_gen_orden_dep
(
 @s_ssn        int         = 1,
 @s_user       login       = 'OPERADOR',
 @s_sesn       int         = 1,
 @s_term       varchar(30) = 'CONSOLA',
 @s_date       datetime    = null,
 @s_srv        varchar(30) = 'HOST',
 @s_lsrv       varchar(30) = 'LOCAL HOST',
 @s_ofi        smallint    = null,
 @s_servicio   int         = null,
 @s_cliente    int         = null,
 @s_rol        smallint    = null,
 @s_culture    varchar(10) = null,
 @s_org        char(1)     = null,
 @i_param1     char(3)     = 'IEN'
)

as 

declare
@w_cab_01  char(002),
@w_cab_02  char(007),
@w_cab_03  char(002),
@w_cab_04  char(003),
@w_cab_05  char(001),
@w_cab_06  char(001),
@w_cab_07  char(007),
@w_cab_08  char(008),
@w_cab_09  char(002),
@w_cab_10  char(002),
@w_cab_11  char(001),
@w_cab_12  char(040),
@w_cab_13  char(406),
@w_det_01  char(002),
@w_det_02  char(007),
@w_det_03  char(002),
@w_det_04  char(002),
@w_det_05  char(008),
@w_det_06  char(003),
@w_det_07  char(003),
@w_det_08  char(015),
@w_det_09  char(016),
@w_det_10  char(002),
@w_det_11  char(008),
@w_det_12  char(002),
@w_det_13  char(020),
@w_det_14  char(040),
@w_det_15  char(018),
@w_det_16  char(002),
@w_det_17  char(020),
@w_det_18  char(040),
@w_det_19  char(018),
@w_det_20  char(040),
@w_det_21  char(040),
@w_det_22  char(015),
@w_det_23  char(007),
@w_det_24  char(040),
@w_det_25  char(030),
@w_det_26  char(002),
@w_det_27  char(008),
@w_det_28  char(012),
@w_det_29  char(030),
@w_det_30  char(030),
@w_det_31  char(500),
@w_pie_01  char(002),
@w_pie_02  char(007),
@w_pie_03  char(002),
@w_pie_04  char(007),
@w_pie_05  char(007),
@w_pie_06  char(018),
@w_pie_07  char(040),
@w_pie_08  char(399),
@w_sep                char(01),
@w_param_dias_proceso smallint,
@w_param_tcta_ord     char(02),
@w_param_ncta_ord     char(20),
@w_param_ncta_cre     char(20),
@w_param_ncta_gar     char(20),
@w_param_nomb_ord     varchar(40),
@w_param_nrfc_ord     char(18),
@w_param_abrev_ord    char(30),
@w_param_fpago_dep    catalogo,
@w_toper_grupal       catalogo,
@w_fpago_sobrante     catalogo,
@w_dato_ncta_receptor char(20),
@w_dato_nomb_receptor char(40),
@w_dato_nrfc_benefi   char(18),
@w_dato_ref_ordenante char(40),
@w_dato_ref_cliente   char(30),
@w_dato_ref_serv_emi  char(40),
@w_dato_ref_des_pago  char(30),
@w_error              int,
@w_fecha_proceso      datetime,
@w_fecha_inicial      datetime,
@w_consecutivo        smallint,
@w_banco              cuenta,
@w_num_oper           int,
@w_cliente            int,
@w_nit                varchar(30),
@w_sec_desem          int,
@w_monto_des          money,
@w_ncta_des           cuenta,      
@w_benef_des          descripcion,
@w_count_op           int,
@w_monto_string       varchar(18),
@w_total_string       varchar(18),
@w_total_op           money,
@w_refer_ordenante    varchar(40),
@w_refer_cliente      varchar(30),
@w_lista_mails        varchar(255),
@w_tipo               varchar(10),
@w_sp_name_batch      varchar(50),
@w_s_app              varchar(30),
@w_path               varchar(255),
@w_nombre_archivo     varchar(30),
@w_destino            varchar(1000),
@w_errores            varchar(1000),
@w_comando            varchar(1000),
@w_tramite            int,
@w_ente               int,
@w_grupo              int,
@w_toperacion         catalogo,
@w_refer_grupal       cuenta,
@w_fecha_proceso_sis  datetime,
@w_sp_name            varchar(100),
@w_ofi_tramite        int,
@w_commit             char(1),
@w_msg_error          varchar(255),
@w_fecha_real         DATETIME,
@w_producto           VARCHAR(32),
@w_variables          varchar(255),
@w_result_values      varchar(255),
@w_parent             INT,
@w_resul_ciclo        VARCHAR(200),
@w_originante         VARCHAR(32),
@w_pos                SMALLINT,
@w_secuencial_ref     INT,
@w_fecha_hoy          VARCHAR(10), 
@w_fecha_ult_disper   DATETIME,
@w_hora_ult_dis       VARCHAR(10),
@w_forma_pago         VARCHAR(16),
@w_moneda             int,
@w_reintento          char(1),
@w_fecha_valor        datetime,
@w_seguro             char(1),
@w_tramite_grupal     int,
@w_habilitado_sob     varchar(2),
@w_fecha_inicial_sob  datetime,
@w_fecha_inicial_aux  datetime 

select @w_sp_name    = 'sp_santander_gen_orden_dep',
       @w_fecha_real = getdate()


select @w_fecha_proceso_sis = fp_fecha from cobis..ba_fecha_proceso

select @s_date = isnull(@s_date, @w_fecha_proceso_sis)

select @w_commit = 'N'

/*CONSULTA DE PARAMETROS GENERALES*/
select @w_sep = char(124)

select @w_sp_name_batch = 'cob_cartera..sp_santander_gen_orden_dep'

select @w_path = ba_path_destino
from  cobis..ba_batch
where ba_arch_fuente = @w_sp_name_batch

--Obtiene el parametro de la ubicacion del kernel\bin en el servidor
select @w_s_app = pa_char
from  cobis..cl_parametro
where pa_producto = 'ADM' 
and   pa_nemonico = 'S_APP'


/*CONSULTA DE PARAMETROS CONSTANTES*/
--select @w_param_dias_proceso = 15
select @w_param_dias_proceso = pa_tinyint
from cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'DPDES'

select @w_param_dias_proceso = isnull(@w_param_dias_proceso, 0) * (- 1)

----------------------------> validar tipo de cuenta
select @w_param_tcta_ord = pa_char
from cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'TCTAOR'

select @w_habilitado_sob = isnull(pa_char,'S')
from cobis..cl_parametro
where pa_nemonico = 'HADESO'

select @w_fecha_inicial_sob = pa_datetime
from cobis..cl_parametro
where pa_nemonico = 'FEINSO'
   

select @w_param_tcta_ord = isnull(@w_param_tcta_ord, '01')

select @w_param_ncta_cre = isnull(@w_param_ncta_cre, 'XXXXXXXXXXX'),
       @w_param_ncta_gar = isnull(@w_param_ncta_gar, 'YYYYYYYYYYY')

select @w_fpago_sobrante = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'SOBAUT'

select @w_fpago_sobrante = isnull(@w_fpago_sobrante, 'SOBRANTE')

select @w_param_fpago_dep = 'NC_BCO_MN',
       @w_toper_grupal    = 'GRUPAL'

/*DETERMINAR FECHA DE PROCESO*/
select @w_fecha_proceso = fc_fecha_cierre,
       @w_fecha_inicial = dateadd(dd, @w_param_dias_proceso, fc_fecha_cierre) 
from cobis..ba_fecha_cierre 
where  fc_producto = 7


-- RECUPERAR LOS VALORES DE LAS REGLAS
DECLARE @w_tab_rule AS TABLE (
fpago    VARCHAR(32),
tipo     VARCHAR(32),
ctacte   VARCHAR(32),
nombre   VARCHAR(64),
rfc      VARCHAR(13)
)

INSERT INTO @w_tab_rule
select  
substring(cr_1.cr_max_value,1,32),
substring(cr_2.cr_max_value,1,32),
substring(cr_3.cr_max_value,1,32),
substring(cr_4.cr_max_value,1,64),
substring(cr_5.cr_max_value,1,13)
from 
           cob_pac..bpl_rule r
inner join cob_pac..bpl_rule_version   rv          on rv.rl_id = r.rl_id

inner join cob_pac..bpl_condition_rule cr_1 on rv.rv_id = cr_1.rv_id and cr_1.cr_parent is null
inner join cob_workflow..wf_variable v_1    on v_1.vb_codigo_variable = cr_1.vd_id 

inner join cob_pac..bpl_condition_rule cr_2 on rv.rv_id = cr_2.rv_id and cr_2.cr_parent = cr_1.cr_id
inner join cob_workflow..wf_variable v_2    on v_2.vb_codigo_variable = cr_2.vd_id 

inner join cob_pac..bpl_condition_rule cr_3 on rv.rv_id = cr_3.rv_id and cr_3.cr_parent = cr_2.cr_id
inner join cob_workflow..wf_variable v_3    on v_3.vb_codigo_variable = cr_3.vd_id 

inner join cob_pac..bpl_condition_rule cr_4 on rv.rv_id = cr_4.rv_id and cr_4.cr_parent = cr_3.cr_id
inner join cob_workflow..wf_variable v_4    on v_4.vb_codigo_variable = cr_4.vd_id 

inner join cob_pac..bpl_condition_rule cr_5 on rv.rv_id = cr_5.rv_id and cr_5.cr_parent = cr_4.cr_id
inner join cob_workflow..wf_variable v_5    on v_5.vb_codigo_variable = cr_5.vd_id 

where rl_acronym = 'CTACHQ' and rv.rv_status = 'PRO'
 
ORDER BY 1,2



/*ASIGNACION DE VARIABLES FIJAS*/
select 
@w_cab_01 = '01',
@w_cab_02 = '0000001',
@w_cab_03 = '60',
@w_cab_04 = '014',
@w_cab_05 = 'E',
@w_cab_06 = '2',
@w_cab_07 = dbo.LlenarI(datepart(dd,@w_fecha_proceso), '0', 2) + '00001',
@w_cab_08 = convert(varchar(8),@w_fecha_proceso, 112),
@w_cab_09 = '01',
@w_cab_10 = replicate('0', 2),
@w_cab_11 = '1',
@w_cab_12 = space(40),
@w_cab_13 = space(406),

@w_det_01 = '02',
@w_det_03 = '60',
@w_det_04 = '01',
@w_det_05 = convert(varchar(8),@w_fecha_proceso, 112),
@w_det_06 = '014',
@w_det_07 = '014',
@w_det_09 = space(16),
@w_det_10 = '98',
@w_det_11 = convert(varchar(8),@w_fecha_proceso, 112),
@w_det_12 = @w_param_tcta_ord,
@w_det_16 = '01',
@w_det_21 = space(40),
@w_det_22 = replicate('0', 15),
@w_det_23 = '0000001',
@w_det_25 = space(30),
@w_det_26 = replicate('0', 2),
@w_det_27 = convert(varchar(8),@w_fecha_proceso, 112),
@w_det_28 = space(12),
@w_det_30 = dbo.LlenarD('ABONO TUIIO', space(1), 30),

@w_pie_01 = '09',
@w_pie_03 = '60',
@w_pie_04 = dbo.LlenarI(datepart(dd,@w_fecha_proceso), '0', 2) + '00001',
@w_pie_07 = space(40),
@w_pie_08 = space(399)

/*DETERMINAR PROXIMO CONSECUTIVO Y NOMBRE DE ARCHIVOS*/
select @w_consecutivo = isnull(max(sod_consecutivo), 0) + 1
from ca_santander_orden_deposito
where sod_fecha = @w_fecha_proceso

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 0 ,0, 0,0,0,'Inicio'
--/////////////////////////////////////////////////////////////////////////////

/*Inicio para controlar garantias que no han cambiado de estado*/
select 
cliente       = op_cliente, 
grupo         = tg_grupo, 
tramite_padre = tg_tramite,
operacion     = op_operacion,
banco         = op_banco
into   #datos_op
from   cob_credito..cr_tramite_grupal, ca_operacion h
where  tg_operacion = op_operacion
and    tg_cliente = op_cliente
and    tg_prestamo <> tg_referencia_grupal
and    tg_monto > 0
and    op_estado = 3

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 1 ,0, 0,0,0,'Paso 1'
--/////////////////////////////////////////////////////////////////////////////

select 
glt_id        = gl_id, 
glt_grupo     = gl_grupo, 
glt_cliente   = gl_cliente, 
glt_tramite   = gl_tramite, 
glt_valor     = gl_pag_valor,
glt_operacion = operacion,
glt_banco     = banco
into   #garliq
from   ca_garantia_liquida, #datos_op
where  gl_tramite = tramite_padre
and    gl_grupo   = grupo
and    gl_cliente = cliente
and    gl_dev_estado is null
and    gl_pag_valor  > 0
and    gl_pag_valor  >= gl_monto_garantia
and    gl_pag_estado = 'CB'

update ca_garantia_liquida set
gl_dev_estado = 'PD'
from   #garliq 
where  gl_id = glt_id

insert into ca_log_dispercion_gl (
ld_gl_id,    ld_fecha_proceso, ld_fecha_real    ,ld_grupo,
ld_cliente,  ld_tramite_padre, ld_pag_valor    ,ld_operacion   ,ld_banco)
select                             
glt_id,      @w_fecha_proceso, @w_fecha_real,    glt_grupo,
glt_cliente, glt_tramite,      glt_valor,        glt_operacion, glt_banco
from   #garliq

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 2 ,0, 0,0,0,'Paso 2'
--/////////////////////////////////////////////////////////////////////////////

/*DETERMINAR INFORMACION A PROCESAR*/
---------------------------------------->   DESEMBOLSOS
select 
dm_secuencial,      dm_operacion,      dm_desembolso, 
dm_producto,        dm_cuenta,         dm_beneficiario,
dm_oficina_chg,     dm_usuario,        dm_oficina,
dm_dividendo,       dm_moneda, 
dm_monto_mds,       dm_monto_mop,      dm_monto_mn,
dm_cotizacion_mds,  dm_cotizacion_mop, dm_tcotizacion_mds,
dm_tcotizacion_mop, dm_estado,         dm_cod_banco,
dm_cheque,          dm_fecha,          convert(varchar(10),'DES') as  dm_tipo, 
convert(int,0) as dm_ente, convert(int,0) as dm_tramite,
convert(int,0) as dm_grupo,
convert(int,0) as dm_secuencial_ref,
convert(char,null) as dm_reintento
into #tmp_ca_data_proceso	   
from ca_desembolso
where dm_operacion > 0
and   dm_fecha between @w_fecha_inicial and @w_fecha_proceso
and dm_estado = 'A'
and dm_producto = @w_param_fpago_dep -------->>> 'NC_BCO_MN'

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 3 ,0, 0,0,0,'Paso 3 DES'
--/////////////////////////////////////////////////////////////////////////////

/*Para registras las devoluciones de las garantias liquidas que no han sido creadas*/
insert into #tmp_ca_data_proceso (
dm_secuencial,      dm_operacion,      dm_desembolso, 
dm_producto,        dm_cuenta,         dm_beneficiario,
dm_oficina_chg,     dm_usuario,        dm_oficina,
dm_dividendo,       dm_moneda,         
dm_monto_mds,       
dm_monto_mop,       
dm_monto_mn,       
dm_cotizacion_mds,  dm_cotizacion_mop, dm_tcotizacion_mds,
dm_tcotizacion_mop, dm_estado,         dm_fecha,          
dm_tipo,			dm_ente,           dm_tramite,
dm_grupo,           dm_secuencial_ref)
select 
gl_id,              -3,                0,
gl_forma_pago,      null,              '',
0,                  '',                0,
0,                  0,                 
case when (gl_pag_valor > gl_monto_garantia) then (gl_pag_valor-gl_monto_garantia) else gl_pag_valor end,
case when (gl_pag_valor > gl_monto_garantia) then (gl_pag_valor-gl_monto_garantia) else gl_pag_valor end,
case when (gl_pag_valor > gl_monto_garantia) then (gl_pag_valor-gl_monto_garantia) else gl_pag_valor end,
0,                  0,                 '',                                     
'',                 gl_dev_estado,     gl_fecha_vencimiento,                   
'GAR',              gl_cliente,        gl_tramite,
gl_grupo,           0
from cob_cartera..ca_garantia_liquida
where gl_dev_estado  ='PD'
and   gl_pag_valor  >= gl_monto_garantia
and   gl_pag_valor  >0

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 4 ,0, 0,0,0,'Paso 4 GL'
--/////////////////////////////////////////////////////////////////////////////

---------------------------------------->   SEGUROS
/* Para registrar las devoluciones de los seguros */
create table #data_seguros(
secuencial    int     identity,
cliente       int         null,
producto      varchar(16) null,
beneficiario  varchar(50) null,
monto         money       null,       
tipo          varchar(3)  null,
estado_seg    char(1)     null,
fecha         datetime    null,
tramite       int         null,
grupo         int         null,
cuenta_banco  cuenta      null)

insert into #data_seguros(
cliente       , producto      , beneficiario  ,
monto         ,
tipo          , estado_seg    , fecha         ,
tramite       , grupo         , cuenta_banco  )
select 
se_cliente    , se_forma_pago , substring(en_nombre + ' ' + p_p_apellido,1,50),
case when (se_monto_pagado > se_monto) then (se_monto_pagado - (isnull(se_monto,0) + isnull(se_monto_devuelto,0)) ) else se_monto_pagado end,
'SEG'         ,  se_estado    , se_fecha_ult_intento,
se_tramite    ,  se_grupo     , null
from cob_cartera..ca_seguro_externo,
     cobis..cl_ente
where se_cliente      = en_ente
and   isnull(se_monto_pagado,0) > (isnull(se_monto,0) + isnull(se_monto_devuelto,0))
and   isnull(se_monto_pagado,0) >0

update #data_seguros set
cuenta_banco = ea_cta_banco
from cobis..cl_ente_aux
where cliente     = ea_ente

insert into #tmp_ca_data_proceso (
dm_secuencial,      dm_operacion,      dm_desembolso, 
dm_producto,        dm_cuenta,         dm_beneficiario,
dm_oficina_chg,     dm_usuario,        dm_oficina,
dm_dividendo,       dm_moneda,         
dm_monto_mds,       dm_monto_mop,      dm_monto_mn,       
dm_cotizacion_mds,  dm_cotizacion_mop, dm_tcotizacion_mds,
dm_tcotizacion_mop, dm_estado,         dm_fecha,          
dm_tipo,			dm_ente,           dm_tramite,
dm_grupo,           dm_secuencial_ref)
select 
secuencial,         cliente          , 0,
producto  ,         cuenta_banco     , beneficiario,
0         ,         ''               , 0,
0         ,         0                ,
monto     ,         monto            , monto,
0         ,         0,                 '',                                     
'',                 estado_seg       , fecha,                   
'SEG'     ,         cliente          , tramite,
grupo     ,         0      
from #data_seguros
--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 4 ,0, 0,0,0,'Paso 4.5 Seguro'
--/////////////////////////////////////////////////////////////////////////////

---------------------------------------->   SOBRANTES
if @w_habilitado_sob = 'S'
begin

   if @w_fecha_inicial < @w_fecha_inicial_sob
      select @w_fecha_inicial_aux = @w_fecha_inicial_sob
   else 
      select @w_fecha_inicial_aux = @w_fecha_inicial

   /*Para registrar las devoluciones por Sobrantes de Pago*/
   insert into #tmp_ca_data_proceso (
   dm_secuencial,      dm_operacion,      dm_desembolso, 
   dm_producto,        dm_cuenta,         dm_beneficiario,
   dm_oficina_chg,     dm_usuario,        dm_oficina,
   dm_dividendo,       dm_moneda,         
   dm_monto_mds,       dm_monto_mop,      dm_monto_mn,       
   dm_cotizacion_mds,  dm_cotizacion_mop, 
   dm_tcotizacion_mds, dm_tcotizacion_mop, 
   dm_estado,          dm_fecha,          dm_tipo,			
   dm_ente,            dm_tramite,        dm_grupo,
   dm_secuencial_ref)
   select 
   tr_secuencial,      tr_operacion,      0, 
   dtr_concepto,       dtr_cuenta,        dtr_beneficiario,
   tr_ofi_usu,         tr_usuario,        tr_ofi_oper,
   dtr_dividendo,      dtr_moneda,                 
   dtr_monto,          dtr_monto,         dtr_monto_mn,
   dtr_cotizacion,     dtr_cotizacion, 
   dtr_tcotizacion,    dtr_tcotizacion, 
   tr_estado,          tr_fecha_mov,      'SOB', 
   0,                  0,                 0,
   tr_secuencial_ref
   from  ca_transaccion, ca_det_trn 
   where tr_fecha_mov between @w_fecha_inicial_aux and @w_fecha_proceso
   and   tr_tran    = 'PAG'
   and   tr_estado != 'RV'
   and   dtr_operacion  = tr_operacion 
   and   dtr_secuencial = tr_secuencial
   and   dtr_concepto   = @w_fpago_sobrante --- 'SOBRANTE'
   and   dtr_afectacion = 'C'
   and   tr_secuencial  > 0 -- no se toman encuenta los reversos
   and   tr_operacion   > 0
   
end 

----

update #tmp_ca_data_proceso set 
dm_ente = op_cliente 
from ca_operacion 
where dm_operacion = op_operacion 
and dm_tipo in ('DES','SOB')

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 5 ,0, 0,0,0,'Paso 5 SOB'
--/////////////////////////////////////////////////////////////////////////////

delete #tmp_ca_data_proceso
from ca_santander_orden_deposito
where sod_operacion = dm_operacion
and sod_secuencial  = dm_secuencial
and sod_tipo = dm_tipo
--and sod_fecha = dm_fecha --Para diferenciar la garantias de una fecha a otra

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 6 ,0, 0,0,0,'Paso 6 DEL TMP'
--/////////////////////////////////////////////////////////////////////////////

--Insertar reintentos fallidos de dispersion de garantias.
insert into #tmp_ca_data_proceso (
dm_secuencial,      dm_operacion,       dm_desembolso, 
dm_producto,        dm_cuenta,          dm_beneficiario,
dm_oficina_chg,     dm_usuario,         dm_oficina,
dm_dividendo,       dm_moneda,          dm_monto_mds,       
dm_monto_mop,       dm_monto_mn,        dm_cotizacion_mds,  
dm_cotizacion_mop,  dm_tcotizacion_mds, dm_tcotizacion_mop, 
dm_estado,          dm_fecha,           dm_tipo,			
dm_ente,            dm_tramite,         
dm_grupo,
dm_secuencial_ref,  dm_reintento)
select 
sod_secuencial,     sod_operacion,          0,
'GAR'         ,     sod_cuenta   ,          '',
0,                  '',                     0,
0,                  0,                      sod_monto,          
sod_monto,          sod_monto,              0,
0,                 '',                      '',                 
'PD',               sod_fecha_valor,        'GAR',
sod_cliente,        convert(int,sod_banco), 
(select max(tg_grupo) 
from cob_credito..cr_tramite_grupal
where tg_tramite = convert(int,re.sod_banco) ),
0          ,        'S'      
from ca_santander_orden_deposito_resp re
where sod_tipo    = 'GAR'
and   sod_enviado is null

update ca_santander_orden_deposito_resp
set   sod_enviado = 'S'
where sod_tipo    = 'GAR'
and   sod_enviado is null

update #tmp_ca_data_proceso
set dm_cuenta = ea_cta_banco
from cobis..cl_ente_aux
where dm_tipo in ('GAR')   --quitar el des 
and dm_ente = ea_ente

--ACTUALIZACION POR COLECTIVOS QUE NO SEAN LCR
update #tmp_ca_data_proceso
set dm_cuenta = ea_cta_banco
from cobis..cl_ente_aux ,ca_operacion 
where dm_operacion = op_operacion 
and   op_tipo_amortizacion <> 'ROTATIVA'
and   dm_tipo in ('DES')  
and   dm_ente = ea_ente
--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 7 ,0, 0,0,0,'Paso 7 RE GL'

--/////////////////////////////////////////////////////////////////////////////
insert into #tmp_ca_data_proceso (
dm_secuencial,      dm_operacion,       dm_desembolso, 
dm_producto,        dm_cuenta,          dm_beneficiario,
dm_oficina_chg,     dm_usuario,         dm_oficina,
dm_dividendo,       dm_moneda,          dm_monto_mds,       
dm_monto_mop,       dm_monto_mn,        dm_cotizacion_mds,  
dm_cotizacion_mop,  dm_tcotizacion_mds, dm_tcotizacion_mop, 
dm_estado,          dm_fecha,           dm_tipo,			
dm_ente,            dm_tramite,         dm_grupo,
dm_secuencial_ref,  dm_reintento)
select 
dd_id ,     		dd_operacion,		0,
'SANTANDER'   ,     substring(ltrim(rtrim(dd_cuenta)),1,30),	dd_beneficiario,
dd_oficina    ,     '',						dd_oficina     ,
0,                  0,        				dd_monto,          
dd_monto      	,dd_monto,         0,
0,                 	'',                     '',                 
'PD',              	dd_fecha_registro,		'DSC',
dd_ente,		    dd_tramite,      		dd_grupo,
0          ,        null      
from ca_devolucion_descuento
where dd_estado_pago 			= 'I'
and dd_tipo ='P'

update ca_devolucion_descuento
set dd_estado_pago = 'P'
where dd_estado_pago = 'I'
and dd_tipo ='P'

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 8 ,0, 0,0,0,'Paso 8 DSC'
--/////////////////////////////////////////////////////////////////////////////
insert into #tmp_ca_data_proceso (
dm_secuencial,      dm_operacion,       dm_desembolso, 
dm_producto,        dm_cuenta,          dm_beneficiario,
dm_oficina_chg,     dm_usuario,         dm_oficina,
dm_dividendo,       dm_moneda,          dm_monto_mds,       
dm_monto_mop,       dm_monto_mn,        dm_cotizacion_mds,  
dm_cotizacion_mop,  dm_tcotizacion_mds, dm_tcotizacion_mop, 
dm_estado,          dm_fecha,           dm_tipo,			
dm_ente,            dm_tramite,         dm_grupo,
dm_secuencial_ref,  dm_reintento)
select 
de_secuencial ,     de_operacion ,          0              ,
'SANTANDER'   ,     substring(ltrim(rtrim(de_cuenta)),1,30) ,      substring(ltrim(rtrim(de_beneficiario)),1,64),
de_oficina    ,                '',      de_oficina     ,
0,                  0,                  de_monto,          
de_monto      ,          de_monto,           0,
0,                 '',                      '',                 
'PD',               de_fecha     ,      'DEV',
de_ente       ,     de_tramite   ,      de_grupo ,
0          ,        null      
from ca_devoluciones
where de_estado    = 'N'

update ca_devoluciones
set de_estado = 'S'
from #tmp_ca_data_proceso
where de_secuencial = dm_secuencial
and   dm_tipo       = 'DEV'

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 7 ,0, 0,0,0,'Paso 7 RE GL'
--/////////////////////////////////////////////////////////////////////////////

/*Para registrar las dispersiones al final del día*/

select @w_fecha_hoy=  CONVERT(varchar(10), getdate(), 101)

select @w_hora_ult_dis =  pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'HUDDD'

select @w_fecha_ult_disper = convert(datetime,@w_fecha_hoy+' '+@w_hora_ult_dis)

print getDate()
print @w_fecha_ult_disper
if getDate()>@w_fecha_ult_disper 
begin
   print 'Inicio devolucion insert de garantia '
   
   select distinct co_nombre
   into #corresponsal_tanquea
   from cob_cartera..ca_corresponsal,
        cob_cartera..ca_corresponsal_limites 
   where co_id = cl_corresponsal_id
   
   insert into #tmp_ca_data_proceso (
   dm_secuencial,         dm_operacion,        dm_desembolso, 
   dm_producto,           dm_cuenta,           dm_beneficiario,
   dm_oficina_chg,        dm_usuario,          dm_oficina,
   dm_dividendo,          dm_moneda,           
   dm_monto_mds,          dm_monto_mop,        dm_monto_mn,       
   dm_cotizacion_mds,     dm_cotizacion_mop,   
   dm_tcotizacion_mds,    dm_tcotizacion_mop,   
   dm_estado,             dm_fecha,            dm_tipo,			
   dm_ente,               dm_tramite,          dm_grupo,
   dm_secuencial_ref)

   select
   co_secuencial,	      -3,				   0,
   co_corresponsal,	      null,			       0,
   0,				      '', 		           0,
   0,       		      co_moneda,           
   isnull(co_monto,0),    isnull(co_monto,0),            isnull(co_monto,0),       
   0,  				      0,                   
   '', 				      '',                  
   co_estado,             @w_fecha_proceso,    'DEV_GAR',			
   '',                    co_codigo_interno,   co_codigo_interno,
   0
   from cob_cartera..ca_corresponsal_trn,
        #corresponsal_tanquea
   where co_estado = 'I' and co_tipo='GL'
   and   co_corresponsal = co_nombre
end


update #tmp_ca_data_proceso
set dm_cuenta = ea_cta_banco
from cobis..cl_ente_aux
where dm_tipo = 'GAR'
and dm_ente = ea_ente

delete #tmp_ca_data_proceso
from ca_santander_orden_deposito
where sod_operacion = dm_operacion
and sod_secuencial  = dm_secuencial
and sod_tipo = dm_tipo

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 9 ,0, 0,0,0,'Paso 9 DEV'
--/////////////////////////////////////////////////////////////////////////////
/*REGISTRO EN ESTRUCTURA DE CONTROL: CABECERA*/
insert into ca_santander_orden_deposito
(sod_fecha,
 sod_fecha_real,   sod_consecutivo, sod_linea,
 sod_banco,        sod_operacion,   sod_secuencial,
 sod_linea_dato)
select 
@w_fecha_proceso,
       @w_fecha_real, @w_consecutivo, 1,
	   'cabecera', 0, 0,  
       @w_cab_01 +
       @w_cab_02 +
       @w_cab_03 +
       @w_cab_04 +
       @w_cab_05 +
       @w_cab_06 +
       @w_cab_07 +
       @w_cab_08 +
       @w_cab_09 +
       @w_cab_10 +
       @w_cab_11 +
       @w_cab_12 +
       @w_cab_13 + 
	   @w_sep
	   
if @@error != 0  
begin
   select @w_error = @@error,
          @w_msg_error = 'Error Generando Archivo para Depositos - Insertar Cabecera de Archivo' 	  
   goto ERROR
end	   

select 
@w_num_oper = 0,
       @w_count_op = 1,
	   @w_total_op = 0	   

	   
/*PROCESAMIENTO PARA DETALLE DE ARCHIVO*/
declare cur_ordenes_deposito cursor for
select 
dm_operacion ,dm_secuencial      ,dm_monto_mop, 
dm_cuenta    ,dm_tipo            ,cob_conta_super.dbo.fn_formatea_ascii_ext(dm_beneficiario, 'AN'), 
dm_ente      ,dm_tramite	     ,dm_grupo, 
dm_producto  ,dm_secuencial_ref  ,dm_fecha, 
dm_reintento, dm_moneda
from   #tmp_ca_data_proceso
order  by dm_tipo, dm_operacion, dm_secuencial

open cur_ordenes_deposito
fetch cur_ordenes_deposito into 
@w_num_oper 	,@w_sec_desem		,@w_monto_des,
@w_ncta_des		,@w_tipo			,@w_benef_des, 
@w_ente			,@w_tramite			,@w_grupo,
@w_producto		,@w_secuencial_ref	,@w_fecha_valor,
@w_reintento,   @w_moneda

while @@fetch_status = 0
begin
   print 'El tipo es ' + @w_tipo
   select @w_seguro = 'N'
   select 
   @w_banco   = op_banco,   
   @w_cliente = op_cliente,
   @w_toperacion     = op_toperacion   
   from   ca_operacion 
   where  op_operacion = @w_num_oper

   if @w_tipo = 'SOB' begin-- EN CASO DE PAGOS BUSCAR EL ORIGEN
   
      if @w_sec_desem < 0 begin-- es una reversa        
         select
               @w_secuencial_ref = tr_secuencial_ref -- secuencial del RPA
         from ca_transaccion
         where tr_operacion   = @w_num_oper
         and   tr_secuencial  = abs(@w_sec_desem)
      end

      select TOP 1 @w_originante = dtr_concepto  -- FORMA DE PAGO
      from ca_det_trn
      where dtr_operacion = @w_num_oper
      and dtr_secuencial  = @w_secuencial_ref
      and dtr_concepto  <> 'VAC0'

        -- MIENTRAS NO SALGA LO DE OXXO, QUEDA SOLO SANTANDER
      if @w_originante = 'GAR_DEB'
      begin
          --select @w_originante = 'SANTANDER'
            PRINT '-------> GAR_DEB'
          select 
          @w_tramite_grupal = tg_tramite,
          @w_grupo          = tg_grupo
          from cob_credito..cr_tramite_grupal
          where tg_operacion = @w_num_oper
          
          select @w_originante = gl_forma_pago
          from cob_cartera..ca_garantia_liquida
          where gl_grupo   = @w_grupo
          and   gl_tramite = @w_tramite_grupal
          
          select @w_originante = isnull(@w_originante,'SANTANDER')
            
      end
      if @w_toperacion = @w_toper_grupal begin
            select @w_grupo = tg_grupo, 
	               @w_refer_grupal = tg_referencia_grupal
            from   cob_credito..cr_tramite_grupal
            where  tg_operacion  = @w_num_oper
            and    tg_prestamo   = @w_banco
			
         select @w_ncta_des = ea_cta_banco
			               from  cobis..cl_cliente_grupo,
			                     cobis..cl_ente_aux
			               where cg_grupo = @w_grupo
			               and   cg_rol = 'P'
			               and   ea_ente = cg_ente
			               and   cg_estado = 'V' 						   
            end
      else begin
         select @w_ncta_des = ea_cta_banco
         from  cobis..cl_ente_aux
         where ea_ente = @w_cliente
      end
   end
        
   if @w_tipo = 'GAR' begin
      select 
      @w_banco   = convert(varchar, @w_tramite),
      @w_cliente = @w_ente
      select @w_forma_pago = @w_producto

   end
   if @w_tipo ='DEV_GAR' begin
      print 'Ingerso al si dev_gar'
      print @w_sec_desem
      update ca_corresponsal_trn
      set co_estado = 'A'
      where co_secuencial = @w_sec_desem 
      and co_estado = 'I'
			
      select 
      @w_ncta_des = ea_cta_banco,
      @w_cliente  = ea_ente
			from  cobis..cl_cliente_grupo,
			      cobis..cl_ente_aux
			where cg_grupo = @w_grupo
			and   cg_rol = 'P'
			and   ea_ente = cg_ente
			and   cg_estado = 'V'
   end
     
   if @w_tipo = 'SEG' begin
      select 
      @w_banco   = convert(varchar, @w_tramite),
      @w_cliente = @w_ente,
      @w_seguro  = 'S'  
      select @w_forma_pago = @w_producto
   end
    
   if @w_tipo NOT IN ('SOB') select @w_originante = @w_producto    
     
   select 
   @w_param_ncta_ord = ctacte,
   @w_param_nomb_ord = nombre,
   @w_param_nrfc_ord = rfc
   from @w_tab_rule
   where fpago = @w_originante
   and tipo = @w_tipo
     

    PRINT  'PARAM = '+@w_resul_ciclo+ ' ORIG  ' + @w_originante + '   TIPO ' + @w_tipo  + '  CTA ' + @w_param_ncta_ord + '  NOMBRE ' + @w_param_nomb_ord  + '  RFC ' + @w_param_nrfc_ord
   
   
	
   if @w_tipo = 'DSC' 
         begin
	   if(@w_toperacion = @w_toper_grupal)
	   begin
		 select @w_cliente = cg_ente 
		 from  cobis..cl_cliente_grupo, cob_cartera..ca_operacion
		 where op_cliente = cg_grupo
		 and op_operacion = @w_num_oper
		 and cg_rol = 'P'
		 and cg_estado = 'V'
      end	  
    end
   
   select top 1 @w_lista_mails = di_descripcion
   from cobis..cl_direccion
   where di_ente = @w_cliente
   and di_tipo = 'CE'
   
   if @@rowcount = 0 select @w_lista_mails = space(1)
   
   select @w_benef_des = ltrim(rtrim(isnull(p_p_apellido, ''))) + ' ' + ltrim(rtrim(isnull(p_s_apellido,''))) + ' ' + ltrim(rtrim(isnull(en_nombre,''))),
          @w_nit       = en_nit
   from cobis..cl_ente 
   where en_ente = @w_cliente

   select @w_benef_des = cob_conta_super.dbo.fn_formatea_ascii_ext(@w_benef_des, 'AN') -- cambiar Ñ x N, quitar .

   select 
   @w_count_op = @w_count_op + 1,
          @w_total_op        = @w_total_op + @w_monto_des, 
          @w_monto_string    = convert(varchar, cast(floor(@w_monto_des * 100) as decimal(15,0))),
		  @w_ncta_des        = case ltrim(rtrim(@w_ncta_des)) when '' then '0' else isnull(@w_ncta_des, '0') end,
  		  @w_lista_mails     = isnull(@w_lista_mails, space(1)),
          @w_benef_des       = case ltrim(rtrim(@w_benef_des)) when '' then 'SIN NOMBRE' else isnull(@w_benef_des, 'SIN NOMBRE') end,
		  @w_nit             = isnull(@w_nit, space(1)),
          @w_refer_ordenante = 'CREDITO ' + ltrim(rtrim(@w_banco)),
		    @w_refer_cliente   = 'DEPOSITO CREDITO ' + ltrim(rtrim(@w_banco))
		  
   if @w_tipo = 'GAR'
   begin
         select @w_refer_ordenante = 'GARANTIA GRUPO: ' + convert(varchar,@w_grupo)
         select @w_refer_cliente = substring(ltrim(rtrim(gr_nombre)),1,30)
         from cobis..cl_grupo
         where gr_grupo = @w_grupo
   end
   
   if @w_tipo = 'SEG'
   begin
         select @w_refer_ordenante = 'DEVOL. SEG. CLI: ' + convert(varchar,@w_banco),
		        @w_seguro = 'S'
		 select @w_refer_cliente = substring(ltrim(rtrim(gr_nombre)),1,30)
		 from cobis..cl_grupo
		 where gr_grupo = @w_grupo 
   end
   		  
   if @w_tipo = 'SOB' begin
          select @w_refer_ordenante = 'CREDITO ' + ltrim(rtrim(@w_banco)),
		         @w_refer_cliente   = 'DEVOLUCION ' + ltrim(rtrim(@w_banco))
   end  
    		  		  		  		  
   if @w_tipo = 'DSC' 
   begin
          select @w_refer_cliente   = 'Dev. TUIIO Confiamos ' + convert(varchar,@w_grupo)		  
   end  
    		  		  		  		  
   if @w_tipo = 'DEV_GAR' begin
      select @w_refer_ordenante = 'DEVOLUCION GARANTIA GRUPO: ' + convert(varchar,@w_grupo)
      print @w_refer_ordenante
      select @w_refer_cliente = substring(gr_nombre,1,30)
      from cobis..cl_grupo
      where gr_grupo = @w_grupo
      
      select @w_tramite = tg_tramite 
      from cob_credito..cr_tramite_grupal
      where tg_grupo = @w_grupo
      
      select @w_ofi_tramite = tr_oficina
      from cob_credito..cr_tramite
      where tr_tramite = @w_tramite
      
      select 
      @w_banco   = convert(varchar, @w_tramite)

      EXEC @w_error  = cob_custodia..sp_contabiliza_garantia
      @s_date           = @s_date ,
      @s_ofi            = @w_ofi_tramite,
      @s_user           = @s_user ,
      @s_term           = @s_term,     
      @i_operacion      = 'V',
      @i_monto          = @w_monto_des,
      @i_en_linea       = 'S' ,   
      @i_grupo          = @w_grupo,
      @i_ente           = @w_grupo,
      @i_forma_pago     = 'SOBRANTE',
      @i_moneda         = @w_moneda
      
      
      if @w_error != 0
      begin
          goto ERROR_CURSOR
      end
    
      
   end
   
   select 
          @w_det_02 = dbo.LlenarI(@w_count_op, '0', 7),
          @w_det_08 = dbo.LlenarI(@w_monto_string, '0', 15),
          ----------------------------------------------------------
          -- DATOS DEL ORDENANTE
		  @w_det_13 = dbo.LlenarI(@w_param_ncta_ord, '0', 20),
		  @w_det_14 = dbo.LlenarD(@w_param_nomb_ord, space(1), 40),
		  @w_det_15 = dbo.LlenarD(@w_param_nrfc_ord, space(1), 18),
          ----------------------------------------------------------
		  @w_det_17 = dbo.LlenarI(@w_ncta_des, '0', 20),
		  @w_det_18 = dbo.LlenarD(@w_benef_des, space(1), 40),
		  @w_det_19 = dbo.LlenarD(@w_nit, space(1), 18),
		  @w_det_20 = replicate(space(1), 40),
		  @w_det_24 = dbo.LlenarD(@w_refer_ordenante, space(1), 40),
		  @w_det_29 = dbo.LlenarD(@w_refer_cliente, space(1), 30),
		  @w_det_30 = dbo.LlenarD(@w_consecutivo * 10000 + @w_count_op, space(1), 30),
		  @w_det_31 = dbo.LlenarD(@w_lista_mails, space(1), 500)

   if @@trancount = 0 
   begin
      begin tran
      select @w_commit = 'S'
   end
   
   select @w_msg_error = null
     
      /*REGISTRO EN ESTRUCTURA DE CONTROL: DETALLE*/
   insert into ca_santander_orden_deposito
   (sod_fecha,        sod_fecha_valor,
    sod_fecha_real,   sod_consecutivo, sod_linea,
    sod_banco,        sod_operacion,   sod_secuencial,
    sod_linea_dato,   sod_tipo,		   sod_monto,
	sod_cliente,	  sod_cuenta)
   select 
         @w_fecha_proceso, @w_fecha_valor,
         @w_fecha_real,    @w_consecutivo, @w_count_op,
         @w_banco,         @w_num_oper,    @w_sec_desem,
         @w_det_01 +
         @w_det_02 +
         @w_det_03 +
         @w_det_04 +
         @w_det_05 +
         @w_det_06 +
         @w_det_07 +
         @w_det_08 +
         @w_det_09 +
         @w_det_10 +
         @w_det_11 +
         @w_det_12 +
         @w_det_13 +
         @w_det_14 +
         @w_det_15 +
         @w_det_16 +
         @w_det_17 +
         @w_det_18 +
         @w_det_19 +
         @w_det_20 +
         @w_det_21 +
         @w_det_22 +
         @w_det_23 +
         @w_det_24 +
         @w_det_25 +
         @w_det_26 +
         @w_det_27 +
         @w_det_28 +
         @w_det_29 +
         @w_det_30 +
         @w_det_31 +
         @w_sep,
         @w_tipo,
		 @w_monto_des,
		 @w_cliente,
		 @w_ncta_des

   if @@error != 0 begin
      select 
      @w_error = @@error,
	         @w_msg_error = 'Error Generando Archivo para Depositos - Insertar Detalle'
      goto ERROR_CURSOR
   end
    
   if (@w_seguro = 'N'  and @w_tipo ='GAR' and @w_reintento is null)begin
	   if @w_ncta_des is null
	   begin
		  select @w_error = 70174
		  goto ERROR_CURSOR
       end
	   
	   select @w_ofi_tramite = tr_oficina
	   from cob_credito..cr_tramite
	   where tr_tramite = @w_tramite
	   
	   if @w_forma_pago is null
          select @w_forma_pago = 'SANTANDER'
      
       exec @w_error     = cob_custodia..sp_contabiliza_garantia
       @s_date           = @w_fecha_proceso,
       @s_user           = @s_user,
       @s_ofi            = @w_ofi_tramite ,
       @s_term           = @s_term,
       @i_operacion      = 'D',
       @i_tramite        = @w_tramite,
       @i_ente           = @w_ente,
      @i_grupo          = @w_grupo,
      @i_forma_pago     = @w_forma_pago
	   
       if @w_error <> 0 
	   begin
	      select @w_msg_error = 'Error Generando Archivo para Depositos - Contabilizacion de GAR'
	      goto ERROR_CURSOR
	   end
	   
    end
	
	/* Para registrar las devoluciones de los seguros */
	if (@w_seguro = 'S' )
    begin
	
	   if @w_ncta_des is null
	   begin
		  select @w_error = 70174
		  goto ERROR_CURSOR
       end
	   
	   select @w_ofi_tramite = tr_oficina
	   from cob_credito..cr_tramite
	   where tr_tramite = @w_tramite
	   
       exec @w_error     = cob_cartera..sp_contabiliza_seguro
       @s_date           = @w_fecha_proceso,
       @s_user           = @s_user,
       @s_ofi            = @w_ofi_tramite ,
       @s_term           = @s_term,
       @i_operacion      = 'D',
       @i_tramite        = @w_tramite,
       @i_ente           = @w_ente,
	   @i_grupo          = @w_grupo,
	   @i_monto          = @w_monto_des,
	   @i_forma_pago     = @w_forma_pago
	   
       if @w_error <> 0 
	   begin
	      select @w_msg_error = 'Error Generando Archivo para Depositos - Contabilizacion de SEG'
	      goto ERROR_CURSOR
	   end
	   
    end
   
   if @w_commit = 'S' begin
      commit tran
	  select @w_commit = 'N'
   end

   goto SIGUIENTE   
   
   ERROR_CURSOR:
   
   if @w_commit = 'S'
   begin
      rollback tran
	  select @w_commit = 'N'
   end   
   
   exec sp_errorlog 
   @i_fecha      = @w_fecha_proceso,
   @i_error      = @w_error,
   @i_usuario    = @s_user,
   @i_tran       = 7286,
   @i_tran_name  = @w_sp_name,
   @i_cuenta     = @w_cliente,
   @i_descripcion= @w_msg_error,
   @i_rollback   = 'N'
   
   
   SIGUIENTE:
   
   fetch cur_ordenes_deposito into 
   @w_num_oper 		,@w_sec_desem		,@w_monto_des,
   @w_ncta_des		,@w_tipo			,@w_benef_des, 
   @w_ente			,@w_tramite			,@w_grupo,
   @w_producto		,@w_secuencial_ref	,@w_fecha_valor,
   @w_reintento,   @w_moneda
   
end

close cur_ordenes_deposito
deallocate cur_ordenes_deposito

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 8 ,0, 0,0,0,'Paso 8 PRO'
--/////////////////////////////////////////////////////////////////////////////


/*ASIGNACION DE VALORES VARIABLES: PIE DE ARCHIVO*/
select @w_total_string = convert(varchar, cast(floor(@w_total_op * 100) as decimal(15,0)))

select 
@w_pie_02 = dbo.LlenarI(convert(varchar,@w_count_op + 1), '0', 7),
       @w_pie_05 = dbo.LlenarI(convert(varchar,@w_count_op - 1), '0', 7),
	   @w_pie_06 = dbo.LlenarI(@w_total_string, '0', 18)
	   


/*REGISTRO EN ESTRUCTURA DE CONTROL: PIE DE ARCHIVO*/	   
insert into ca_santander_orden_deposito
(sod_fecha,
 sod_fecha_real,   sod_consecutivo, sod_linea,
 sod_banco,        sod_operacion,   sod_secuencial,
 sod_linea_dato)
select @w_fecha_proceso,
       @w_fecha_real, @w_consecutivo, @w_count_op + 1,
	   'pie', 0, 0,  
       @w_pie_01 +
       @w_pie_02 +
       @w_pie_03 +
       @w_pie_04 +
       @w_pie_05 +
       @w_pie_06 +
       @w_pie_07 +
       @w_pie_08 + 
	   @w_sep

if @@error != 0  
begin
   select @w_error = @@error,
          @w_msg_error = 'Error Generando Archivo para Depositos - Insertar Pie de Archivo' 	  
   goto ERROR
end


if exists (select 1
           from  ca_santander_orden_deposito
           where sod_fecha = @w_fecha_proceso
           and   sod_consecutivo = @w_consecutivo
           and   sod_banco not in ('cabecera', 'pie')) begin  
   if @i_param1 = 'IEN'
   begin
      select linea_dato = substring(sod_linea_dato, 1, datalength(sod_linea_dato) - 1)
      from  ca_santander_orden_deposito
      where sod_fecha = @w_fecha_proceso 
      and   sod_consecutivo = @w_consecutivo
      order by sod_linea
   end
   else begin
		truncate table ca_santander_archivo
		
      insert into ca_santander_archivo
      select substring(sod_linea_dato, 1, datalength(sod_linea_dato) - 1)
      from  ca_santander_orden_deposito
      where sod_fecha = @w_fecha_proceso 
      and   sod_consecutivo = @w_consecutivo
      order by sod_linea	  
	  
	 select @w_nombre_archivo = 'TRAN' + convert(varchar(8), @w_fecha_proceso, 112)
	 select @w_nombre_archivo = @w_nombre_archivo + '_CBDS_'
	 select 
         @w_nombre_archivo = 
         @w_nombre_archivo + 
	                        substring(convert(varchar(15), getdate(), 114), 1, 2) + --hh 
						    substring(convert(varchar(15), getdate(), 114), 4, 2) + --mm
						    substring(convert(varchar(15), getdate(), 114), 7, 2)   --ss 
	  
      select @w_comando = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_santander_archivo out '

      select @w_destino = @w_path + @w_nombre_archivo + '.in',
             @w_errores = @w_path + @w_nombre_archivo + '.err'

      select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
		PRINT ' comando --> ' + @w_comando 
      exec @w_error = xp_cmdshell @w_comando
	  
      if @w_error <> 0 
	  begin
	     select @w_msg_error = 'Error Generando Archivo para Depositos - Generacion de BCP'
	     goto ERROR
	  end
     
   end   
end

--/////////////////////////////////////////////////////////////////////////////
INSERT INTO ca_log_dispercion_gl
select @w_consecutivo *(-1), @w_fecha_proceso,  getdate(), 9 ,0, 0,0,0,'Paso 9 Fin'
--/////////////////////////////////////////////////////////////////////////////


return 0

ERROR:

if @w_commit = 'S'
begin
   rollback tran
   select @w_commit = 'N'
end   

exec sp_errorlog 
@i_fecha      = @w_fecha_proceso,
@i_error      = @w_error,
@i_usuario    = @s_user,
@i_tran       = 7286,
@i_tran_name  = @w_sp_name,
@i_cuenta     = @w_cliente,
@i_descripcion= @w_msg_error,
@i_rollback   = 'N'
   
  return @w_error

go
