/************************************************************************/
/*   Archivo:                 sp_riesgo_hrc_lcr.sp                      */
/*   Stored procedure:        sp_riesgo_hrc_lcr                         */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:            Paúl Ortiz Vera                           */
/*   Fecha de Documentacion:  Junio 21 de 2019                          */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'COBISCORP'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante              */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*21/06/2019      P. Ortiz Vera Emision Inicial                         */
/* 04/10/2019      D. Cumbal            #126877                         */
/* 28/10/2019      ACHP         Caso #Soporte #128989                   */
/* 09/01/2020      D. Cumbal    Caso #133108                            */
/* 27/03/2020      D. Cumbal    Caso #135888                            */
/* 28/07/2020      DCU          Caso #143417                            */
/* 12/11/2021      DCU          Caso #172460                            */
/* 10/01/2022      DCU          Caso #170130                            */
/* 02/02/2022      DCU          Caso #173928                            */
/* 04/02/2022      KVI          Req. #177295 - Cambio Formula           */
/* 28/02/2022      DCU          Caso #177295                            */
/* 07/03/2022      DCU          Caso #179643                            */
/* 29/04/2022      DCU          Caso #183102                            */
/* 25/08/2022      KVI          Sop.189747                              */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_riesgo_hrc_lcr') is null
   drop proc sp_riesgo_hrc_lcr
go

create proc sp_riesgo_hrc_lcr
   @i_param1   datetime    = null,   --FECHA
   @i_param2   varchar(10) = null,   --FORMATO FECHA
   @i_param3   char(1)     = null    --PARAMETRO PARA INDICAR DESDE DONDE ES INVOCADO 'N'-> NODS -> 'C' -> COBIS
as
declare 
   @w_s_app           varchar(255),
   @w_destino         varchar(255),
   @w_errores         varchar(255),
   @w_error           int,
   @w_mensaje         varchar(255),
   @w_ruta_arch       varchar(255),
   @w_nombre_arch     varchar(255),
   @w_sp_name         varchar(30),
   @w_comando         varchar(6000),
   @w_fecha           datetime,
   @w_columna         varchar(50),
   @w_col_id          int,
   @w_cabecera        varchar(5000),
   @w_msg             varchar(255),
   @w_formato_fecha   int,
   @w_est_vigente     int,
   @w_est_vencido     int,
   @w_est_cancelado   int,
   @w_est_castigado   int,
   @w_return          int,
   @w_cont_columnas   int,
   @w_sql             varchar(5000),
   @w_nom_cabecera    varchar(8000),
   @w_nom_columnas    varchar(8000),
   @w_est_suspenso    int,
   @w_operacion       int,
   @w_fecha_vencimiento datetime,
   @w_fecha_lectura   datetime,
   @w_ciudad_nacional int,
   @w_est_etapa2      int,
   @w_tipo_reporte    char(1),
   @w_est_no_vigente  int, -- Sop.189747
   @w_est_anulado     int, -- Sop.189747
   @w_est_credito     int  -- Sop.189747 
   

select @w_sp_name = 'sp_riesgo_hrc_lcr'
declare @resultadobcp table (linea varchar(max))
select @w_tipo_reporte = isnull(@i_param3,'C')

select
@w_fecha_lectura = @i_param1,
@w_formato_fecha = convert(int,@i_param2)

if @i_param1 is null
   select @w_fecha_lectura = fp_fecha from cobis..ba_fecha_proceso
if @i_param2 is null
   select @w_formato_fecha = 111

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM' 
/* Fecha de lectura Consolidador */
select @w_fecha = dateadd(day,-1, @w_fecha_lectura)         
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional 
                     and df_fecha  = @w_fecha) 
begin
   select @w_fecha = dateadd(day,-1, @w_fecha) 
end 

select @w_s_app = pa_char from cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1 
begin
   select 
   @w_error = 70135,
   @w_mensaje = 'Error Al consultar informacion de parametro S_APP'
   goto ERROR_PROCESO
end


--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_etapa2    = @w_est_etapa2    out,
@o_est_novigente = @w_est_no_vigente out, -- Sop.189747
@o_est_anulado   = @w_est_anulado    out, -- Sop.189747
@o_est_credito   = @w_est_credito    out  -- Sop.189747

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end

/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA SB_DATO_OPERACION */
select 
cliente                  = do_codigo_cliente,
operacion                = do_operacion,
fecha_info               = convert(varchar(10),do_fecha,@w_formato_fecha),
num_cred                 = do_banco,
destino_cr               = do_codigo_destino,
num_cliente_operativo    = convert(varchar(64),null),
desc_nombre_cliente      = convert(varchar(255),null),
cod_entidad              = '0078',
desc_entidad             = 'SANTANDER INCLUSION FINANCIERA',
desc_sistema_orig        = 'COBIS',
num_suc_titular          = do_oficina,
cod_producto             = '96',
cod_subproducto          = case do_tipo_operacion 
                             when 'REVOLVENTE' then '0002' 
                           end,
desc_producto            = 'INCLUSION FINANCIERA',
desc_subproducto         = 'CREDITO INDIVIDUAL',
flg_revolvente           = 1,
flg_tratamiento_contable = 1,
cod_tipo_amortiza        = 1,
desc_tipo_amortiza       = 'Capital E Intereses Periodicos',
num_cta_cheques          = do_cuenta,
fec_formaliza            = convert(varchar(10),null,@w_formato_fecha),
fec_vencimiento          = isnull(convert(varchar(10),do_fecha_vencimiento,@w_formato_fecha),''),
cod_tasa                 = 'FIJA',
desc_tasa                = 'TASA FIJA',
flg_tasa_variable        = 0,
fec_prox_revisa_tasa     = convert(varchar(10),null),
cod_periodo_revisa_tasa  = convert(varchar(10),null),
pct_tasa_cobr            = do_tasa_com,
num_puntos_spread        = 0,
fec_ult_amort_incump_cap = case
                             when (do_dias_mora_365 - 1) <= 0 then convert(varchar(10),null)
                             when (do_dias_mora_365 - 1) > 0 then isnull(convert(varchar(10),dateadd(dd,-(do_dias_mora_365 - 1),@w_fecha),@w_formato_fecha),'')
                           end,
fec_ult_amort_incump_int = case
                             when (do_dias_mora_365 - 1) <= 0 then convert(varchar(10),null)
                             when (do_dias_mora_365 - 1) > 0 then isnull(convert(varchar(10),dateadd(dd,-(do_dias_mora_365 - 1),@w_fecha),@w_formato_fecha),'')
                           end,
num_doctos_vencidos      = do_num_cuotaven,
cod_periodo_capital      = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then 107--'Semanal' 
                             when 14 then 115--'Quincenal' 
                             when 30 then 201--'Mensual' 
                           end,
desc_periodo_capital     = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then '7 DIAS' 
                             when 14 then 'QUINCENAL' 
                             when 30 then 'MENSUAL' 
                           end,
cod_periodo_intereses    = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then 107--'Semanal' 
                             when 14 then 115--'Quincenal' 
                             when 30 then 201--'Mensual' 
                           end,
desc_periodo_intereses   = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then '7 DIAS' 
                             when 14 then 'QUINCENAL' 
                             when 30 then 'MENSUAL' 
                           end,
cod_bloqueo              = case
                             when do_estado_cartera = @w_est_castigado then 15
                             when (do_dias_mora_365 - 1) > 90 then 14
                             when (do_dias_mora_365 - 1) between 1 and 90 then 13
                             when (select top 1 lb_bloqueo from cob_cartera..ca_lcr_bloqueo where lb_operacion = do_operacion) = 'S' then 12
                             else 0
                           end,
desc_bloqueo             = convert(varchar(10),null),
cod_moneda               = 'MXN',
imp_concedido            = convert(varchar(10),'0'),
imp_limite_credito       = do_monto_aprobado,
imp_disponible           = do_monto_aprobado - do_saldo_cap,
imp_total_riesgo_sistema = convert(money,0),
imp_cap_noexig           = convert(money,0), 
imp_cap_exig             = convert(money,0), 
imp_int_noexig           = convert(money,0), 
imp_int_exig             = convert(money,0), 
imp_int_suspen           = convert(money,0), 
imp_inversion            = convert(money,0), 
imp_total_riesgo         = convert(money,0), 
fec_traspaso_vencido     = isnull(convert(varchar(10),do_fecha_dividendo_ven,@w_formato_fecha),convert(varchar(10),null)),
num_linea_madre          = do_banco,
flg_mora_sistema         = case  
                             when (do_dias_mora_365 - 1) <= 30 and @w_tipo_reporte = 'N'  then 1 
							 when (do_dias_mora_365 - 1) <= 30 and @w_tipo_reporte <> 'N' then 0
							 when (do_dias_mora_365 - 1) >= 31 and (do_dias_mora_365 - 1) <= 89 and @w_tipo_reporte = 'N' then 2
							 when (do_dias_mora_365 - 1) >= 31 and (do_dias_mora_365 - 1) <= 89 and @w_tipo_reporte <> 'N' then 1
                             when (do_dias_mora_365 - 1) >= 90 and @w_tipo_reporte = 'N' then 3
							 when (do_dias_mora_365 - 1) >= 90 and @w_tipo_reporte <> 'N' then 2
                           end,
fec_prox_corte           = isnull(convert(varchar(10),do_fecha_prox_vto,@w_formato_fecha),'0001-01-01'),
cod_pais_origen          = convert(int,0),
cod_pais_residencia      = convert(int,0),
cod_tipo_persona         = convert(varchar(32),null),
cod_sector_economico     = convert(varchar(10),null),
cod_unidad_negocio       = convert(varchar(10),null),
cod_unidad_negocio_ope_ori = convert(varchar(10),null),
cod_sector_contable      = convert(varchar(10),null),
cod_actividad_economica  = convert(varchar(10),null),
desc_rfc                 = convert(varchar(64),null),
desc_pais_origen         = convert(varchar(64),null),
desc_pais_residencia     = convert(varchar(64),null),
desc_sector_economico    = convert(varchar(64),null),
desc_tipo_persona        = convert(varchar(64),null),
desc_unidad_negocio      = convert(varchar(20),null),
cod_localidad_dom_primario = convert(varchar(20),null),
desc_actividad_economica_esp = convert(varchar(200),null),
fec_prox_corte_prin      = isnull(convert(varchar(10),do_fecha_prox_vto,@w_formato_fecha),''),
fec_prox_corte_int       = isnull(convert(varchar(10),do_fecha_prox_vto,@w_formato_fecha),'0001-01-01'),
fec_formaliza_ult_disp   = convert(varchar(10),null,@w_formato_fecha),
imp_seguro_desempleo     = 0,
imp_seguro_vida          = convert(money,0), 
flg_garantia             = 0,
pct_tasa_base            = do_tasa_com,
imp_pag_adelantado       = 0,
num_ult_recibo_facturado = do_cuota_ult_vto,
cod_bloq_disposicion     = convert(varchar(10),null),
imp_pago_domiciliado     = 0,
fec_cobranza             = convert(varchar(10),null),
pct_cat                  = do_valor_cat,
desc_tipo_solicitud      = 'MERCADO ABIERTO',
desc_canal               = 'OFICINAS TUIIO',
fec_vencimiento_renovacion = convert(varchar(10),null),
fec_nacimiento           = convert(varchar(10),null,@w_formato_fecha),
cod_estado_civil         = convert(varchar(10),null),
cod_genero               = convert(varchar(10),null),
imp_ingreso_dispersion   = 0,
flg_dispersion_ult_3m    = 0,
cod_tipo_interviniente   = convert(varchar(10),null),
cod_finalidad_credito    = convert(varchar(64),null),
cod_periodo_capital_1    = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then 107--'Semanal' 
                             when 14 then 115--'Quincenal' 
                             when 30 then 201--'Mensual' 
                           end,
desc_periodo_capital_1   = case  do_periodicidad_cuota   --'ca_periodicidad_lcr'
                             when 7 then '7 DIAS' 
                             when 14 then 'QUINCENAL' 
                             when 30 then 'MENSUAL' 
                           end,
num_dias_atraso          = case -- Sop.189747
                             when do_dias_mora_365 > 0 then do_dias_mora_365 - 1
							 else do_dias_mora_365
                           end, 
num_plazo_remanente_dias = convert(varchar(10),null),
num_hijas_grupo          = convert(varchar(10), '1'),  --integrantes_grupo -- Sop.189747
ciclo_ind                = convert(varchar(10), null)                      -- Sop.189747
into #hrc_lcr
from cob_conta_super..sb_dato_operacion
where do_fecha      = @w_fecha
and   do_aplicativo = 7
and   do_tipo_operacion = 'REVOLVENTE'
and   (do_estado_cartera in (@w_est_vigente, @w_est_etapa2, @w_est_vencido) or   (do_estado_cartera = @w_est_cancelado and do_fecha_vencimiento > @w_fecha ))


if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx1 on #hrc_lcr(operacion)
create index idx2 on #hrc_lcr(num_cred)
create index idx3 on #hrc_lcr(cliente)

/* Actualizar datos de cliente */
update #hrc_lcr set 
num_cliente_operativo   = en_banco,
desc_nombre_cliente     = UPPER(isnull(p_p_apellido,'') + ' ' +  isnull(p_s_apellido,'') + ' ' + isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'')),
cod_pais_origen         = p_pais_emi,
cod_tipo_persona        = case en_subtipo
                           when 'P' then 'F'
                           when 'C' then 'J'
                        end,
cod_actividad_economica = (select top 1 min(nc_actividad_ec) from  cobis..cl_negocio_cliente where nc_ente  = cliente and nc_estado_reg  ='V' and nc_actividad_ec is not null),
desc_rfc                = en_rfc,
desc_pais_origen        = (select top 1 pa_descripcion from cobis..cl_pais where pa_pais = p_pais_emi),
desc_tipo_persona       = (select c.valor from cobis..cl_tabla t,cobis..cl_catalogo c where t.tabla = 'cl_tipo_persona' and t.codigo = c.tabla and en_subtipo = c.codigo),
fec_nacimiento          = convert(varchar(10),p_fecha_nac,@w_formato_fecha),
cod_estado_civil        = p_estado_civil,
cod_genero              = p_sexo
from cobis..cl_ente, cobis..cl_ente_aux
where en_ente = cliente 
and   en_ente = ea_ente


update #hrc_lcr set   
cod_finalidad_credito  = case destino_cr when '01' then 'Capital de Trabajo' else lower(c.valor) end
from  cobis..cl_tabla t, cobis..cl_catalogo c
where t.tabla = 'cr_destino'
and   c.tabla = t.codigo
and   c.codigo = destino_cr

/* Sector Economico */
update #hrc_lcr set
desc_sector_economico         = acg_actividad_generica,
desc_actividad_economica_esp  = acg_nombre_corto,
cod_sector_economico          = case when acg_codigo_generica = 'III' then 3
                                     when acg_codigo_generica = 'IV'  then 4
                                else
                                     8
                                end 
from cobis..cl_actividad_generica
where acg_codigo_actividad = cod_actividad_economica

/* Actividad Economica */
update #hrc_lcr set
desc_actividad_economica_esp = c.valor 
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.tabla             = 'cl_actividad'
and   t.codigo            = c.tabla
and   cod_actividad_economica = c.codigo


select distinct
di_cliente          = cliente,
di_cod_pais         = cod_pais_residencia,
di_desc_pais        = desc_pais_residencia
into #direcciones
from #hrc_lcr
create index idx1 on #direcciones(di_cliente)


update #direcciones set
di_cod_pais         = di_pais,
di_desc_pais        = (select top 1 pa_descripcion from cobis..cl_pais where pa_pais = di_pais)
from cobis..cl_direccion
where di_ente = di_cliente
and   di_tipo = 'RE'  
and   di_direccion=(select top 1 min(di_direccion) from cobis..cl_direccion where di_ente = di_cliente and di_tipo = 'RE')--domicilio
--ACTUALIZACION EN CASO DE NO EXISTIR DIRECCION DOMICILIO 
if exists(select 1 from #direcciones  where di_cod_pais = 0 or di_desc_pais is null)
begin
   update #direcciones set
   di_cod_pais         = di_pais,
   di_desc_pais        = (select top 1 pa_descripcion from cobis..cl_pais where pa_pais = di_pais)
   from cobis..cl_direccion
   where di_ente = di_cliente
   and   di_direccion=(select top 1 min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente and di_tipo not in ('CE'))--domicilio
end

/* Se actualiza Pais de Residencia */
update #hrc_lcr set
cod_pais_residencia  = di_cod_pais,
desc_pais_residencia = di_desc_pais
from #direcciones
where di_cliente = cliente 

--DATO DE APROBACION DEL WF
update #hrc_lcr 
set fec_formaliza  = isnull(convert(varchar(10),op_fecha_ini,@w_formato_fecha),io_fecha_fin)
from cob_workflow..wf_inst_proceso, cob_cartera..ca_operacion 
where io_campo_3    = op_tramite
and   op_banco      = num_cred
and   op_toperacion = 'REVOLVENTE'
and   op_cliente    = cliente

/* fecha ultima dispersión */
select 
dt_banco as banco,
max(dt_secuencial) as secuencial
into #hrc_lcr_max
from cob_conta_super..sb_dato_transaccion, #hrc_lcr
where dt_banco = num_cred
and dt_toperacion = 'REVOLVENTE'
and dt_tipo_trans = 'DES'
and dt_fecha <= @w_fecha
group by dt_banco

update #hrc_lcr
set fec_formaliza_ult_disp = isnull(convert(varchar(10),dt_fecha_trans,@w_formato_fecha),'')
from cob_conta_super..sb_dato_transaccion, #hrc_lcr_max
where dt_banco = num_cred
and num_cred = banco
and dt_secuencial = secuencial
and dt_tipo_trans = 'DES'

/* imp_cocedido */

select mc_banco = dt_banco,
mc_concedido = sum(dd_monto) 
into #monto_concedido
from cob_conta_super..sb_dato_transaccion, cob_conta_super..sb_dato_transaccion_det, #hrc_lcr
where dt_banco = dd_banco
and dt_fecha = dd_fecha
and dt_secuencial = dd_secuencial
and dt_banco = num_cred
and dt_tipo_trans = 'DES'
and dd_concepto = 'CAP'
and dt_fecha between (dateadd(mm, datediff(mm, 0, @w_fecha), 0)) and @w_fecha
and dt_secuencial > 0
group by dt_banco



/* Capitales e intereses*/
select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vigente, @w_est_vencido, @w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vigente, @w_est_vencido)  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),
--SEGUROS
dr_seg_saldo     = sum(case when dr_categoria  = 'S' then  isnull(dr_valor, 0) else 0 end)
into #rubros
from #hrc_lcr, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha
and   dr_aplicativo = 7
and   dr_banco      = num_cred
group by dr_banco


update #hrc_lcr set 
imp_cap_noexig           = dr_cap_vig_ne,
imp_cap_exig             = dr_cap_vig_ex,
imp_int_noexig           = dr_int_vig_ne + dr_int_ven_ne + dr_int_sus_ne,
imp_int_exig             = dr_int_vig_ex + dr_int_ven_ex,-- + dr_int_sus_ex,
imp_int_suspen           = dr_int_sus_ex + dr_int_sus_ne,
imp_seguro_vida          = dr_seg_saldo
from #rubros
where num_cred          = dr_banco

/*if @w_tipo_reporte = 'C' --Req. #177295  
begin*/
  update #hrc_lcr set
  imp_total_riesgo_sistema = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0),
  imp_inversion            = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0),
  imp_total_riesgo         = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0) 
/*end
else 
begin 
  update #hrc_lcr set
  imp_total_riesgo_sistema = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0) - isnull(imp_int_suspen,0), 
  imp_inversion            = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0) - isnull(imp_int_suspen,0), 
  imp_total_riesgo         = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0) - isnull(imp_int_suspen,0)  
end*/

--ciclo individual -- Sop.189747
select 
@w_est_no_vigente = isnull(@w_est_no_vigente, 0),
@w_est_anulado    = isnull(@w_est_anulado, 6),
@w_est_credito    = isnull(@w_est_credito, 99)

select num_ciclo = count(1), ente = op_cliente 
into #ciclo_ind
from cob_cartera..ca_operacion  
where op_toperacion = 'REVOLVENTE'
and op_estado not in (@w_est_no_vigente, @w_est_anulado, @w_est_credito)
group by op_cliente

update #hrc_lcr
set  ciclo_ind = num_ciclo
from #ciclo_ind
where cliente = ente  


truncate table cob_conta_super..sb_riesgo_hrc_lcr
insert into cob_conta_super..sb_riesgo_hrc_lcr(
   FECHA_INFO,
   NUM_CRED,
   NUM_CLIENTE_OPERATIVO,
   DESC_NOMBRE_CLIENTE,
   COD_ENTIDAD,
   DESC_ENTIDAD,
   DESC_SISTEMA_ORIG,
   NUM_SUC_TITULAR,
   COD_PRODUCTO,
   COD_SUBPRODUCTO,
   DESC_PRODUCTO,
   DESC_SUBPRODUCTO,
   FLG_REVOLVENTE,
   FLG_TRATAMIENTO_CONTABLE,
   COD_TIPO_AMORTIZA,
   DESC_TIPO_AMORTIZA,
   NUM_CTA_CHEQUES,
   FEC_FORMALIZA,
   FEC_VENCIMIENTO,
   COD_TASA,
   DESC_TASA,
   FLG_TASA_VARIABLE,
   FEC_PROX_REVISA_TASA,
   COD_PERIODO_REVISA_TASA,
   PCT_TASA_COBR,
   NUM_PUNTOS_SPREAD,
   FEC_ULT_AMORT_INCUMP_CAP,
   FEC_ULT_AMORT_INCUMP_INT,
   NUM_DOCTOS_VENCIDOS,
   COD_PERIODO_CAPITAL,
   DESC_PERIODO_CAPITAL,
   COD_PERIODO_INTERESES,
   DESC_PERIODO_INTERESES,
   COD_BLOQUEO,
   DESC_BLOQUEO,
   COD_MONEDA,
   IMP_CONCEDIDO,
   IMP_LIMITE_CREDITO,
   IMP_DISPONIBLE,
   IMP_TOTAL_RIESGO_SISTEMA,
   IMP_CAP_NOEXIG,
   IMP_CAP_EXIG,
   IMP_INT_NOEXIG,
   IMP_INT_EXIG,
   IMP_INT_SUSPEN,
   IMP_INVERSION,
   IMP_TOTAL_RIESGO,
   FEC_TRASPASO_VENCIDO,
   NUM_LINEA_MADRE,
   FLG_MORA_SISTEMA,
   FEC_PROX_CORTE,
   COD_PAIS_ORIGEN,
   COD_PAIS_RESIDENCIA,
   COD_TIPO_PERSONA,
   COD_SECTOR_ECONOMICO,
   COD_UNIDAD_NEGOCIO,
   COD_UNIDAD_NEGOCIO_OPE_ORI,
   COD_SECTOR_CONTABLE,
   COD_ACTIVIDAD_ECONOMICA,
   DESC_RFC,
   DESC_PAIS_ORIGEN,
   DESC_PAIS_RESIDENCIA,
   DESC_SECTOR_ECONOMICO,
   DESC_TIPO_PERSONA,
   DESC_UNIDAD_NEGOCIO,
   COD_LOCALIDAD_DOM_PRIMARIO,
   DESC_ACTIVIDAD_ECONOMICA_ESP,
   FEC_PROX_CORTE_PRIN,
   FEC_PROX_CORTE_INT,
   FEC_FORMALIZA_ULT_DISP,
   IMP_SEGURO_DESEMPLEO,
   IMP_SEGURO_VIDA,
   FLG_GARANTIA,
   PCT_TASA_BASE,
   IMP_PAG_ADELANTADO,
   NUM_ULT_RECIBO_FACTURADO,
   COD_BLOQ_DISPOSICION,
   IMP_PAGO_DOMICILIADO,
   FEC_COBRANZA,
   PCT_CAT,
   DESC_TIPO_SOLICITUD,
   DESC_CANAL,
   FEC_VENCIMIENTO_RENOVACION,
   FEC_NACIMIENTO,
   COD_ESTADO_CIVIL,
   COD_GENERO,
   IMP_INGRESO_DISPERSION,
   FLG_DISPERSION_ULT_3M,
   COD_TIPO_INTERVINIENTE,
   COD_FINALIDAD_CREDITO,
   COD_PERIODO_CAPITAL_1,
   DESC_PERIODO_CAPITAL_1,
   NUM_DIAS_ATRASO,
   NUM_PLAZO_REMANENTE_DIAS,
   INTEGRANTES_GRUPO, -- Sop.189747
   CICLO_INDIVIDUAL   -- Sop.189747
)
select 
   isnull(fecha_info,''),
   isnull(num_cred,''),
   isnull(num_cliente_operativo,''),
   isnull(desc_nombre_cliente,''),
   isnull(cod_entidad,''),
   isnull(desc_entidad,''),
   isnull(desc_sistema_orig,''),
   isnull(num_suc_titular,''),
   isnull(cod_producto,''),
   isnull(cod_subproducto,''),
   isnull(desc_producto,''),
   isnull(desc_subproducto,''),
   isnull(flg_revolvente,''),
   isnull(flg_tratamiento_contable,''),
   isnull(cod_tipo_amortiza,''),
   isnull(desc_tipo_amortiza,''),
   isnull(num_cta_cheques,''),
   isnull(fec_formaliza,''),
   isnull(fec_vencimiento,''),
   cod_tasa,
   desc_tasa,
   flg_tasa_variable,
   fec_prox_revisa_tasa,
   cod_periodo_revisa_tasa,
   isnull(pct_tasa_cobr,''),
   num_puntos_spread,
   fec_ult_amort_incump_cap,
   fec_ult_amort_incump_int,
   isnull(num_doctos_vencidos,'0'),
   cod_periodo_capital,
   desc_periodo_capital,
   cod_periodo_intereses,
   desc_periodo_intereses,
   isnull(cod_bloqueo,'0'),
   desc_bloqueo,
   cod_moneda,
   isnull(imp_concedido,'0'),
   isnull(imp_limite_credito,'0'),
   isnull(imp_disponible,'0'),
   isnull(imp_total_riesgo_sistema,'0'),
   isnull(imp_cap_noexig,'0'),
   isnull(imp_cap_exig,'0'),
   isnull(imp_int_noexig,'0'),
   isnull(imp_int_exig,'0'),
   isnull(imp_int_suspen,'0'),
   isnull(imp_inversion,'0'),
   isnull(imp_total_riesgo,'0'),
   fec_traspaso_vencido,
   num_linea_madre,
   flg_mora_sistema,
   fec_prox_corte,
   cod_pais_origen,
   cod_pais_residencia,
   cod_tipo_persona,
   cod_sector_economico,
   cod_unidad_negocio,
   cod_unidad_negocio_ope_ori,
   cod_sector_contable,
   cod_actividad_economica,
   isnull(desc_rfc,''),
   isnull(desc_pais_origen,''),
   isnull(desc_pais_residencia,''),
   desc_sector_economico,
   desc_tipo_persona,
   desc_unidad_negocio,
   cod_localidad_dom_primario,
   desc_actividad_economica_esp,
   isnull(fec_prox_corte_prin,''),
   isnull(fec_prox_corte_int,''),
   fec_formaliza_ult_disp,
   isnull(imp_seguro_desempleo,''),
   isnull(imp_seguro_vida,'0'),
   isnull(flg_garantia,''),
   pct_tasa_base,
   imp_pag_adelantado,
   num_ult_recibo_facturado,
   cod_bloq_disposicion,
   isnull(imp_pago_domiciliado,'0'),
   fec_cobranza,
   pct_cat,
   desc_tipo_solicitud,
   desc_canal,
   fec_vencimiento_renovacion,
   fec_nacimiento,
   cod_estado_civil,
   cod_genero,
   imp_ingreso_dispersion,
   flg_dispersion_ult_3m,
   cod_tipo_interviniente,
   cod_finalidad_credito,
   cod_periodo_capital_1,
   desc_periodo_capital_1,
   isnull(num_dias_atraso,'0'),
   num_plazo_remanente_dias,
   num_hijas_grupo, -- Sop.189747
   ciclo_ind        -- Sop.189747           
from  #hrc_lcr
if @@error != 0
begin
   print 'Error al actualizar informacion en Estructura para generar Reporte'
   select 
   @w_error = 70137,
   @w_mensaje = 'Error al actualizar informacion en Estructura para generar Reporte'
   goto ERROR_PROCESO
end

SALIDA_PROCESO:
   return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error
go