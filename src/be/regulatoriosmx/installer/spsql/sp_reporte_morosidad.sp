/* ********************************************************************* */
/*      Archivo:                sp_reporte_morosidad.sp                  */
/*      Stored procedure:       sp_reporte_morosidad                     */
/*      Base de datos:          cob_conta_super                          */
/*      Producto:               Regulatorios                             */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     14-Julio-2020                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Programa temporal para sumatoria de contabilidad                 */
/* ********************************************************************* */
/*                             MODIFICACION                              */
/*    FECHA         AUTOR                       RAZON                    */
/*    14/Jul/2020   SRO       Emision inicial                            */
/*    11/12/2020    JCASTR    REQ#145941                                 */
/*    03/06/2021    ACH       ERR#160014, no se reporta porque los integ */
/*                            del grupo ya no pertenecen al grupo        */
/* ********************************************************************* */

use cob_conta_super
go

if not object_id('sp_reporte_morosidad') is null
   drop proc sp_reporte_morosidad
go

create proc sp_reporte_morosidad
(
   @i_param1   datetime = null   --FECHA REPROCESO
)

as
declare
@w_min_atraso          int,
@w_max_atraso          int,
@w_error               int,
@w_fecha_proceso       datetime,
@w_fecha_corte         datetime,
@w_ciudad_nacional     int,
@w_query               varchar(6000),
@w_comando             varchar(6000),
@w_errores             varchar(255),
@w_s_app               VARCHAR(100),
@w_cmd                 varchar(5000),
@w_est_vencido         int,
@w_est_vigente         int,
@w_est_castigado       int,
@w_est_suspenso        INT,
@w_arch_resultado      VARCHAR(50),
@w_path_destino        VARCHAR(60),
@w_destino_reporte     VARCHAR(200)


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @i_param1 is null
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
   select @w_fecha_proceso = @i_param1   
   
select @w_fecha_corte  = @w_fecha_proceso

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end

select 
@w_arch_resultado       = ba_arch_resultado,
@w_path_destino         = ba_path_destino
from cobis..ba_batch 
where ba_batch = 28796

PRINT  'w_arch_resultado: ' + @w_arch_resultado
select @w_min_atraso = isnull(pa_int, 1)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'MINATR'
and    pa_producto = 'CCA'


select @w_max_atraso = isnull(pa_int, 180)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'MAXATR'
and    pa_producto = 'CCA'

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out 

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end


PRINT @w_min_atraso 
print @w_max_atraso
-- GRUPALES
select 
cm_cliente                     = do_codigo_cliente,
cm_banco                       = do_banco,
cm_nombre_cliente              = convert(varchar(500), null),
cm_agencia_actual              = convert(varchar(50),  null),
cm_fec_ref_agencia             = convert(varchar(10), null, 103),
cm_buc                         = convert(varchar(20), null),
cm_pagos_vencidos              = convert(int, do_num_cuotaven),
cm_total_deudor                = convert(money, null),
cm_pago_minimo                 = convert(money, null),
cm_monto_moroso                = convert(money, null),
cm_codigo_bloqueo              = convert(int, null),
cm_fec_codigo_bloqueo          = convert(varchar(10), null, 103),
cm_dia_corte                   = do_dia_pago, --porcaso194284
cm_dias_agencia                = convert(int, null),
cm_desc_producto               = convert(varchar(50), case when do_tipo_operacion = 'INDIVIDUAL' THEN 'INDIVIDUAL SIMPLE' 
                                                           when do_tipo_operacion = 'REVOLVENTE' THEN 'INDIVIDUAL REVOLVENTE' 
                                                           when do_tipo_operacion = 'GRUPAL' THEN do_subtipo_producto  end  ),
cm_calle_no_cliente            = convert(varchar(100),null),
cm_colonia_cliente             = convert(int,null),
cm_colonia_cliente_desc        = convert(varchar(100),null),
cm_ciudad_cliente              = convert(varchar(30),null),
cm_estado                      = convert(int,null),
cm_estado_desc                 = convert(varchar(100),null),
cm_codigo_postal               = convert(varchar(20),null),
cm_lada_1                      = convert(int, null),
cm_tel_1                       = convert(varchar(20),null),
cm_lada_2                      = convert(int, null),
cm_tel_2                       = convert(varchar(20),null),
cm_lada_3                      = convert(int, null),
cm_tel_3                       = convert(varchar(20),null),
cm_agencia_previa              = convert(varchar(20),null),
cm_fec_ref_agencia_previa      = convert(varchar(10), null, 103),
cm_fec_ultima_compra           = convert(varchar(10), null, 103), 
cm_fec_ultima_disposicion      = convert(varchar(10), null, 103),
cm_monto_ultima_compra         = convert(money, null),
cm_monto_ultima_disposicion    = convert(money, null),	
cm_fecha_apertura_cuenta       = convert(varchar(10),null, 103),
cm_rfc                         = convert(varchar(30), null),
cm_monto_asignado_agencia      = convert(money, null),
cm_monto_asignado_agencia_prev = convert(money, null),
cm_fecha_limite_pago           = convert(varchar(10), null, 103),
cm_limite_credito              = convert(money, do_cupo_original),
cm_cuenta_cheques              = convert(varchar(24), do_cuenta),
cm_stacteca                    = convert(varchar(10),null),
cm_saldo_vencido_30_dias       = convert(money, null),
cm_saldo_vencido_60_dias       = convert(money, null),
cm_saldo_vencido_90_dias       = convert(money, null),
cm_saldo_vencido_120_dias      = convert(money, null),
cm_segmento_actual             = convert(varchar(10), do_estado_cartera),
cm_segmento_posterior          = convert(varchar(10), null),
cm_dias_faltantes              = convert(int,null),
cm_fecha_cambio_segmento       = convert(varchar(10), null, 103),
cm_correo                      = convert(varchar(100), null),
cm_dias_atraso                 = do_dias_mora_365,
cm_fecha_desem                 = do_fecha_concesion,
cm_tramite                     = do_tramite,
cm_nombre_grupo                = convert(varchar(50),null),
cm_rol_cliente                 = convert(varchar(30),null),
cm_atraso_grupal               = convert(money,null),
cm_grupo_id                    = convert(varchar(10),cg_grupo),
cm_estado_grupo                = convert(varchar(2),cg_estado)
into #clientes_morosidad
from  cob_conta_super..sb_dato_operacion,
      cobis..cl_cliente_grupo--,(select gr_grupo from cobis..cl_grupo where gr_estado = 'V') gr -- Caso#160014
where cg_ente   = do_codigo_cliente
and   cg_grupo  = do_grupo--gr.gr_grupo -- Caso#160014
--and   cg_estado = 'V' -- Caso#160014
and   do_dias_mora_365 between @w_min_atraso AND @w_max_atraso
and   do_fecha  = @w_fecha_corte
and   do_aplicativo = 7
and   do_tipo_operacion = 'GRUPAL'

-- REVOLVENTES
select 
cm_cliente                     = do_codigo_cliente,
cm_banco                       = do_banco,
cm_nombre_cliente              = convert(varchar(500), null),
cm_agencia_actual              = convert(varchar(50),  null),
cm_fec_ref_agencia             = convert(varchar(10), null, 103),
cm_buc                         = convert(varchar(20), null),
cm_pagos_vencidos              = convert(int, do_num_cuotaven),
cm_total_deudor                = convert(money, null),
cm_pago_minimo                 = convert(money, null),
cm_monto_moroso                = convert(money, null),
cm_codigo_bloqueo              = convert(int, null),
cm_fec_codigo_bloqueo          = convert(varchar(10), null, 103),
cm_dia_corte                   = do_dia_pago, --porcaso194284,
cm_dias_agencia                = convert(int, null),
cm_desc_producto               = convert(varchar(50), case when do_tipo_operacion = 'INDIVIDUAL' THEN 'INDIVIDUAL SIMPLE' 
                                                           when do_tipo_operacion = 'REVOLVENTE' THEN 'INDIVIDUAL REVOLVENTE' 
                                                           when do_tipo_operacion = 'GRUPAL' THEN do_subtipo_producto  end  ),
cm_calle_no_cliente            = convert(varchar(100),null),
cm_colonia_cliente             = convert(int,null),
cm_colonia_cliente_desc        = convert(varchar(100),null),
cm_ciudad_cliente              = convert(varchar(30),null),
cm_estado                      = convert(int,null),
cm_estado_desc                 = convert(varchar(100),null),
cm_codigo_postal               = convert(varchar(20),null),
cm_lada_1                      = convert(int, null),
cm_tel_1                       = convert(varchar(20),null),
cm_lada_2                      = convert(int, null),
cm_tel_2                       = convert(varchar(20),null),
cm_lada_3                      = convert(int, null),
cm_tel_3                       = convert(varchar(20),null),
cm_agencia_previa              = convert(varchar(20),null),
cm_fec_ref_agencia_previa      = convert(varchar(10), null, 103),
cm_fec_ultima_compra           = convert(varchar(10), null, 103), 
cm_fec_ultima_disposicion      = convert(varchar(10), null, 103),
cm_monto_ultima_compra         = convert(money, null),
cm_monto_ultima_disposicion    = convert(money, null),	
cm_fecha_apertura_cuenta       = convert(varchar(10),null, 103),
cm_rfc                         = convert(varchar(30), null),
cm_monto_asignado_agencia      = convert(money, null),
cm_monto_asignado_agencia_prev = convert(money, null),
cm_fecha_limite_pago           = convert(varchar(10), null, 103),
cm_limite_credito              = convert(money, do_cupo_original),
cm_cuenta_cheques              = convert(varchar(24), do_cuenta),
cm_stacteca                    = convert(varchar(10),null),
cm_saldo_vencido_30_dias       = convert(money, null),
cm_saldo_vencido_60_dias       = convert(money, null),
cm_saldo_vencido_90_dias       = convert(money, null),
cm_saldo_vencido_120_dias      = convert(money, null),
cm_segmento_actual             = convert(varchar(10), do_estado_cartera),
cm_segmento_posterior          = convert(varchar(10), null),
cm_dias_faltantes              = convert(int,null),
cm_fecha_cambio_segmento       = convert(varchar(10), null, 103),
cm_correo                      = convert(varchar(100), null),
cm_dias_atraso                 = do_dias_mora_365,
cm_fecha_desem                 = do_fecha_concesion,
cm_tramite                     = do_tramite,
cm_nombre_grupo                = convert(varchar(50),null),
cm_rol_cliente                 = convert(varchar(30),null),
cm_atraso_grupal               = convert(money,null),
cm_grupo_id                    = convert(varchar(10),null),
cm_estado_grupo                = convert(varchar(2),'C')
into #clientes_morosidad_a
from  cob_conta_super..sb_dato_operacion
where do_dias_mora_365 between @w_min_atraso AND @w_max_atraso
and   do_fecha = @w_fecha_corte
and   do_aplicativo = 7
and   do_banco not in (select cm_banco from #clientes_morosidad)
and   do_tipo_operacion <> 'GRUPAL'

insert into #clientes_morosidad
select * from #clientes_morosidad_a

print @@rowcount
print @w_fecha_corte
if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx1 on #clientes_morosidad(cm_banco)
create index idx2 on #clientes_morosidad(cm_cliente)

select 
dr_banco,
cm_grupo_id,
dr_cap_ven_ex     = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then   isnull(dr_valor,0) else 0 end),
dr_saldo_ex       = sum(case when dr_exigible   = 1   then   isnull(dr_valor, 0) else 0 end),
dr_saldo_prestamo = sum( isnull(dr_valor,0))
into #rubros
from #clientes_morosidad, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_corte
and   dr_aplicativo = 7
and   dr_banco      = cm_banco
group by dr_banco, cm_grupo_id

PRINT 2
update #clientes_morosidad set
cm_total_deudor           = dr_saldo_prestamo,
cm_pago_minimo            = dr_saldo_ex,
cm_monto_moroso           = dr_cap_ven_ex,
cm_monto_asignado_agencia = dr_saldo_prestamo,
cm_saldo_vencido_30_dias  = case when cm_dias_atraso between 0  and 30 then dr_saldo_ex else 0.0 end,
cm_saldo_vencido_60_dias  = case when cm_dias_atraso between 31 and 60 then dr_saldo_ex else 0.0 end,
cm_saldo_vencido_90_dias  = case when cm_dias_atraso between 61 and 90 then dr_saldo_ex else 0.0 end,
cm_saldo_vencido_120_dias = case when cm_dias_atraso >= 91 then dr_saldo_ex else 0.0             end
from #rubros
where cm_banco  = dr_banco 

PRINT 3
/* NOMBRE DEL CLIENTE */
update #clientes_morosidad set
cm_nombre_cliente =   case when en_nombre    is null then '' else en_nombre + ' '  end
                    + case when p_s_nombre   is null then '' else p_s_nombre + ' '  end
					+ case when p_p_apellido is null then '' else p_p_apellido + ' ' end
					+ case when p_s_apellido is null then '' else p_s_apellido end,
cm_buc            = en_banco,
cm_rfc            = en_rfc
from  cobis..cl_ente
where en_ente = cm_cliente 

PRINT 4
/* DIRECCION DE DOMICILIO */
update #clientes_morosidad set
cm_calle_no_cliente = di_calle 
                      + case when di_nro         is null then '' else ' # ' + convert(varchar,di_nro) end
                      + case when di_nro_interno is null then '' else '  Int. ' + convert(varchar, di_nro_interno) end,
cm_colonia_cliente  = di_parroquia,
cm_ciudad_cliente   = rtrim(ltrim(di_poblacion)),
cm_estado           = di_provincia,
cm_codigo_postal    = di_codpostal
from cobis..cl_direccion
where di_ente = cm_cliente
and   di_tipo = 'RE'

/*CORREO */
update #clientes_morosidad set
cm_correo     = di_descripcion 
from cobis..cl_direccion
where di_ente = cm_cliente
and   di_tipo = 'CE'

/*TELEFONO MÓVIL*/
update #clientes_morosidad set
cm_tel_1              = te_valor
from cobis..cl_telefono 
where te_ente          = cm_cliente
and   te_tipo_telefono = 'C'

/*TELEFONO NEGOCIO*/
update #clientes_morosidad set
cm_tel_2              = nc_telefono
from cobis..cl_negocio_cliente
where nc_ente          = cm_cliente

/*COLONIA*/
update #clientes_morosidad set 
cm_colonia_cliente_desc  = replace(pq_descripcion, ',','')
from cobis..cl_parroquia
where cm_colonia_cliente = pq_parroquia

/*ESTADO */
update #clientes_morosidad set
cm_estado_desc           = replace(pv_descripcion, ',','')
from cobis..cl_provincia
where cm_estado          = pv_provincia

/*FECHA ULTIMA DISPOSICION*/
update #clientes_morosidad set
cm_fec_ultima_compra      = convert(varchar(10),dt_fecha,103),
cm_fec_ultima_disposicion = convert(varchar(10),dt_fecha,103)
from  cob_conta_super..sb_dato_transaccion
where dt_banco      = cm_banco
and   dt_tipo_trans = 'DES'
and   dt_secuencial = (select max(dt_secuencial) from cob_conta_super..sb_dato_transaccion where dt_banco = cm_banco and dt_tipo_trans = 'DES')
PRINT 12
--ACTUALIZA FECHA APERTURA
update #clientes_morosidad set
cm_fecha_apertura_cuenta = convert(varchar(10),dt_fecha,103)
from  cob_conta_super..sb_dato_transaccion
where dt_banco = cm_banco
and   dt_tipo_trans = 'DES'
and   dt_secuencial = (select min(dt_secuencial) from cob_conta_super..sb_dato_transaccion where dt_banco = cm_banco and dt_tipo_trans = 'DES')
--ACTUALIZA VALORES ULTIMAS DISPOSICIONES
update #clientes_morosidad set
cm_monto_ultima_compra         = dd_monto,
cm_monto_ultima_disposicion    = dd_monto	
from   cob_conta_super..sb_dato_transaccion_det
where  dd_banco = cm_banco
and    dd_concepto = 'CAP'
and    dd_secuencial = (select max(dt_secuencial) from cob_conta_super..sb_dato_transaccion where dt_banco = cm_banco and dt_tipo_trans = 'DES')
PRINT 13
/*ACTUALIZAR DESCRIPCION ESTADO CREDITO*/
update #clientes_morosidad set
cm_segmento_actual       = es_descripcion
from cob_cartera..ca_estado
where es_codigo          = cm_segmento_actual

/* ACTUALIZA DATOS GRUPO */
update #clientes_morosidad
set    cm_rol_cliente  = (select valor from cobis..cl_catalogo where tabla = '414' and codigo = cg_rol),
       cm_nombre_grupo = (select gr_nombre from cobis..cl_grupo where gr_grupo = cg_grupo)
from   cobis..cl_cliente_grupo
where  cg_ente = cm_cliente
and    cg_estado = 'V'

select 'grupo' = cm_grupo_id,
       'total' = sum(cm_pago_minimo)
into   #total_grupo
from   #clientes_morosidad
group by cm_grupo_id

update #clientes_morosidad
set    cm_atraso_grupal = total
from   #total_grupo
where  cm_grupo_id = grupo

update #clientes_morosidad
set    cm_grupo_id     = '',
       cm_nombre_grupo = '',
       cm_rol_cliente  = ''
from   #clientes_morosidad
where  cm_estado_grupo = 'C'

truncate table  cob_conta_super..sb_reporte_morosidad

insert into cob_conta_super..sb_reporte_morosidad (
[CLIENTE],[BANCO],[NOMBRE_CLIENTE],[AGENCIA_ACTUAL],           
[FEC_REF_AGENCIA],[BUC],[PAGOS_VENCIDOS],[TOTAL_DEUDOR],                
[PAGO_MINIMO],[MONTO_MOROSO],[CODIGO_BLOQUEO],[FEC_CODIGO_BLOQUEO],          
[DIA_CORTE],[DIAS_AGENCIA],[DESC_PRODUCTO],[CALLE_NO_CLIENTE],            
[COLONIA_CLIENTE],[CIUDAD_CLIENTE],[ESTADO],[CODIGO_POSTAL],               
[LADA_1],[TEL_1],[LADA_2],[TEL_2],                       
[LADA_3],[TEL_3],[AGENCIA_PREVIA],[FEC_REF_AGENCIA_PREVIA],      
[FEC_ULTIMA_COMPRA],[FEC_ULTIMA_DISPOSICION],[MONTO_ULTIMA_COMPRA], [MONTO_ULTIMA_DISPOSICION],    
[FECHA_APERTURA_CUENTA],[RFC],[MONTO_ASIGNADO_AGENCIA],[MONTO_ASIGNADO_AGENCIA_PREV], 
[FECHA_LIMITE_PAGO],[LIMITE_CREDITO],[CUENTA_CHEQUES],[STACTECA],                    
[SALDO_VENCIDO_30_DIAS],[SALDO_VENCIDO_60_DIAS],[SALDO_VENCIDO_90_DIAS],[SALDO_VENCIDO_120_DIAS],     
[SEGMENTO_ACTUAL],[SEGMENTO_POSTERIOR],[DIAS_FALTANTES],[FECHA_CAMBIO_SEGMENTO],
[CORREO],[ID_GRUPAL],[NOMBRE_GRUPO],[ROL_CLIENTE],[ATRASO_GRUPAL])  
VALUES(
'CONSECUTIVO', 'NO_CUENTA', 'NOMBRE_CLIENTE', 'AGENCIA_ACTUAL',
'FEC_REF_AGENCIA', 'BUC', 'PAGOS_VENCIDOS', 'TOTAL_DEUDOR',
'PAGO_MINIMO','MONTO_MOROSO','CODIGO_BLOQUEO','FEC_CODIGO_BLOQUEO',         
'DIA_CORTE','DIAS_AGENCIA','DESC_PRODUCTO','CALLE_NO_CLIENTE',            
'COLONIA_CLIENTE','CIUDAD_CLIENTE','ESTADO','CODIGO_POSTAL',               
'LADA_1','TEL_1','LADA_2','TEL_2',                       
'LADA_3','TEL_3','AGENCIA_PREVIA','FEC_REF_AGENCIA_PREVIA',      
'FEC_ULTIMA_COMPRA','FEC_ULTIMA_DISPOSICION','MONTO_ULTIMA_COMPRA', 'MONTO_ULTIMA_DISPOSICION',    
'FECHA_APERTURA_CUENTA','RFC','MONTO_ASIGNADO_AGENCIA','MONTO_ASIGNADO_AGENCIA_PREV', 
'FECHA_LIMITE_PAGO','LIMITE_CREDITO','CUENTA_CHEQUES','STACTECA',                    
'SALDO_VENCIDO_30_DIAS','SALDO_VENCIDO_60_DIAS','SALDO_VENCIDO_90_DIAS','SALDO_VENCIDO_120_DIAS',     
'SEGMENTO_ACTUAL','SEGMENTO_POSTERIOR','DIAS_FALTANTES','FECHA_CAMBIO_SEGMENTO',
'CORREO','ID_GRUPAL','NOMBRE_GRUPO','ROL_CLIENTE','ATRASO_GRUPAL')
print 15

insert into cob_conta_super..sb_reporte_morosidad (
[CLIENTE],[BANCO],[NOMBRE_CLIENTE],[AGENCIA_ACTUAL],           
[FEC_REF_AGENCIA],[BUC],[PAGOS_VENCIDOS],[TOTAL_DEUDOR],                
[PAGO_MINIMO],[MONTO_MOROSO],[CODIGO_BLOQUEO],[FEC_CODIGO_BLOQUEO],          
[DIA_CORTE],[DIAS_AGENCIA],[DESC_PRODUCTO],[CALLE_NO_CLIENTE],            
[COLONIA_CLIENTE],[CIUDAD_CLIENTE],[ESTADO],[CODIGO_POSTAL],               
[LADA_1],[TEL_1],[LADA_2],[TEL_2],                       
[LADA_3],[TEL_3],[AGENCIA_PREVIA],[FEC_REF_AGENCIA_PREVIA],      
[FEC_ULTIMA_COMPRA],[FEC_ULTIMA_DISPOSICION],[MONTO_ULTIMA_COMPRA], [MONTO_ULTIMA_DISPOSICION],    
[FECHA_APERTURA_CUENTA],[RFC],[MONTO_ASIGNADO_AGENCIA],[MONTO_ASIGNADO_AGENCIA_PREV], 
[FECHA_LIMITE_PAGO],[LIMITE_CREDITO],[CUENTA_CHEQUES],[STACTECA],                    
[SALDO_VENCIDO_30_DIAS],[SALDO_VENCIDO_60_DIAS],[SALDO_VENCIDO_90_DIAS],[SALDO_VENCIDO_120_DIAS],     
[SEGMENTO_ACTUAL],[SEGMENTO_POSTERIOR],[DIAS_FALTANTES],[FECHA_CAMBIO_SEGMENTO],
[CORREO],[ID_GRUPAL],[NOMBRE_GRUPO],[ROL_CLIENTE],[ATRASO_GRUPAL])    
select
'CONSECUTIVO'                = isnull(CONVERT(VARCHAR(100), cm_cliente),''),
'NO_CUENTA'                  = isnull(CONVERT(VARCHAR(100), cm_banco),''), 
'NOMBRE_CLIENTE'             = isnull(CONVERT(VARCHAR(100), cm_nombre_cliente),''),
'AGENCIA_ACTUAL'             = isnull(CONVERT(VARCHAR(100), cm_agencia_actual),''),           
'FEC_REF_AGENCIA'            = isnull(CONVERT(VARCHAR(100), cm_fec_ref_agencia),''), 
'BUC'                        = isnull(CONVERT(VARCHAR(100), cm_buc),''), 
'PAGOS_VENCIDOS'             = isnull(CONVERT(VARCHAR(100), cm_pagos_vencidos),''), 
'TOTAL_DEUDOR'               = isnull(CONVERT(VARCHAR(100), cm_total_deudor),''),               
'PAGO_MINIMO'                = isnull(CONVERT(VARCHAR(100), cm_pago_minimo),''), 
'MONTO_MOROSO'               = isnull(CONVERT(VARCHAR(100), cm_monto_moroso),''), 
'CODIGO_BLOQUEO'             = isnull(CONVERT(VARCHAR(100), cm_codigo_bloqueo),''), 
'FEC_CODIGO_BLOQUEO'         = isnull(CONVERT(VARCHAR(100), cm_fec_codigo_bloqueo),''),         
'DIA_CORTE'                  = isnull(CONVERT(VARCHAR(100), cm_dia_corte),''), 
'DIAS_AGENCIA'               = isnull(CONVERT(VARCHAR(100), cm_dias_agencia),''), 
'DESC_PRODUCTO'              = isnull(CONVERT(VARCHAR(100), cm_desc_producto),''),
'CALLE_NO_CLIENTE'           = isnull(CONVERT(VARCHAR(100), cm_calle_no_cliente),''),
'COLONIA_CLIENTE'            = isnull(CONVERT(VARCHAR(100), cm_colonia_cliente_desc),''), 
'CIUDAD_CLIENTE'             = isnull(CONVERT(VARCHAR(100), cm_ciudad_cliente),''), 
'ESTADO'                     = isnull(CONVERT(VARCHAR(100), cm_estado_desc),''),
'CODIGO_POSTAL'              = isnull(CONVERT(VARCHAR(100), cm_codigo_postal),''),             
'LADA_1'                     = isnull(CONVERT(VARCHAR(100), cm_lada_1),''), 
'TEL_1'                      = isnull(CONVERT(VARCHAR(100), cm_tel_1),''), 
'LADA_2'                     = isnull(CONVERT(VARCHAR(100), cm_lada_2),''), 
'TEL_2'                      = isnull(CONVERT(VARCHAR(100), cm_tel_2),''),
'LADA_3'                     = isnull(CONVERT(VARCHAR(100), cm_lada_3),''), 
'TEL_3'                      = isnull(CONVERT(VARCHAR(100), cm_tel_3),''), 
'AGENCIA_PREVIA'             = isnull(CONVERT(VARCHAR(100), cm_agencia_previa),''), 
'FEC_REF_AGENCIA_PREVIA'     = isnull(CONVERT(VARCHAR(100), cm_fec_ref_agencia_previa),''),     
'FEC_ULTIMA_COMPRA'          = isnull(CONVERT(VARCHAR(100), cm_fec_ultima_compra),''), 
'FEC_ULTIMA_DISPOSICION'     = isnull(CONVERT(VARCHAR(100), cm_fec_ultima_disposicion),''), 
'MONTO_ULTIMA_COMPRA'        = isnull(CONVERT(VARCHAR(100), format(cm_monto_ultima_compra,'#')),'0'), 
'MONTO_ULTIMA_DISPOSICION'   = isnull(CONVERT(VARCHAR(100), format(cm_monto_ultima_disposicion,'#')),'0'),
'FECHA_APERTURA_CUENTA'      = isnull(CONVERT(VARCHAR(100), cm_fecha_apertura_cuenta,103),''), 
'RFC'                        = isnull(CONVERT(VARCHAR(100), cm_rfc),''), 
'MONTO_ASIGNADO_AGENCIA'     = isnull(CONVERT(VARCHAR(100), cm_monto_asignado_agencia),''), 
'MONTO_ASIGNADO_AGENCIA_PREV'= isnull(CONVERT(VARCHAR(100), cm_monto_asignado_agencia_prev),''),
'FECHA_LIMITE_PAGO'          = isnull(CONVERT(VARCHAR(100), cm_fecha_limite_pago),''), 
'LIMITE_CREDITO'             = isnull(CONVERT(VARCHAR(100), format(cm_limite_credito,'#')),''), 
'CUENTA_CHEQUES'             = isnull(CONVERT(VARCHAR(100), cm_cuenta_cheques),''), 
'STACTECA'                   = isnull(CONVERT(VARCHAR(100), cm_stacteca),''),                   
'SALDO_VENCIDO_30_DIAS'      = isnull(CONVERT(VARCHAR(100), cm_saldo_vencido_30_dias),''), 
'SALDO_VENCIDO_60_DIAS'      = isnull(CONVERT(VARCHAR(100), cm_saldo_vencido_60_dias),''), 
'SALDO_VENCIDO_90_DIAS'      = isnull(CONVERT(VARCHAR(100), cm_saldo_vencido_90_dias),''), 
'SALDO_VENCIDO_120_DIAS'     = isnull(CONVERT(VARCHAR(100), cm_saldo_vencido_120_dias),''),
'SEGMENTO_ACTUAL'            = isnull(CONVERT(VARCHAR(100), cm_segmento_actual),''), 
'SEGMENTO_POSTERIOR'         = isnull(CONVERT(VARCHAR(100), cm_segmento_posterior),''), 
'DIAS_FALTANTES'             = isnull(CONVERT(VARCHAR(100), cm_dias_faltantes),''), 
'FECHA_CAMBIO_SEGMENTO'      = isnull(CONVERT(VARCHAR(100), cm_fecha_cambio_segmento),''),
'CORREO'                     = isnull(CONVERT(VARCHAR(100), cm_correo), ''),
'ID_GRUPAL'                  = isnull(CONVERT(VARCHAR(100), cm_grupo_id), ''),
'NOMBRE_GRUPO'               = isnull(CONVERT(VARCHAR(100), cm_nombre_grupo), ''),
'ROL_CLIENTE'                = isnull(CONVERT(VARCHAR(100), cm_rol_cliente), ''),
'ATRASO_GRUPAL'              = isnull(CONVERT(VARCHAR(100), format(cm_atraso_grupal,'#.00')), '0')
FROM #clientes_morosidad
order by cm_banco

select @w_query = 'select [CLIENTE] + char(44) + [BANCO]+ char(44) + [NOMBRE_CLIENTE] + char(44) + [AGENCIA_ACTUAL] + char(44) + '           
select @w_query = @w_query + '[FEC_REF_AGENCIA]+ char(44) +[BUC]+ char(44) +[PAGOS_VENCIDOS]+ char(44) +[TOTAL_DEUDOR]+ char(44) +'                
select @w_query = @w_query + '[PAGO_MINIMO]+ char(44) +[MONTO_MOROSO]+ char(44) +[CODIGO_BLOQUEO]+ char(44) +[FEC_CODIGO_BLOQUEO]+ char(44) +'          
select @w_query = @w_query + '[DIA_CORTE]+ char(44) +[DIAS_AGENCIA]+ char(44) +[DESC_PRODUCTO]+ char(44) +[CALLE_NO_CLIENTE]+ char(44) +'            
select @w_query = @w_query + '[COLONIA_CLIENTE]+ char(44) +[CIUDAD_CLIENTE]+ char(44) +[ESTADO]+ char(44) +[CODIGO_POSTAL]+ char(44) +'              
select @w_query = @w_query + '[LADA_1]+ char(44) +[TEL_1]+ char(44) +[LADA_2]+ char(44) +[TEL_2]+ char(44) +'                       
select @w_query = @w_query + '[LADA_3]+ char(44) +[TEL_3]+ char(44) +[AGENCIA_PREVIA]+ char(44) +[FEC_REF_AGENCIA_PREVIA]+ char(44) +'      
select @w_query = @w_query + '[FEC_ULTIMA_COMPRA]+ char(44) +[FEC_ULTIMA_DISPOSICION]+ char(44) +[MONTO_ULTIMA_COMPRA]+ char(44) + [MONTO_ULTIMA_DISPOSICION]+ char(44) +'    
select @w_query = @w_query + '[FECHA_APERTURA_CUENTA]+ char(44) +[RFC]+ char(44) +[MONTO_ASIGNADO_AGENCIA]+ char(44) +[MONTO_ASIGNADO_AGENCIA_PREV]+ char(44) +' 
select @w_query = @w_query + '[FECHA_LIMITE_PAGO]+ char(44) +[LIMITE_CREDITO]+ char(44) +[CUENTA_CHEQUES]+ char(44) +[STACTECA]+ char(44) +'                    
select @w_query = @w_query + '[SALDO_VENCIDO_30_DIAS]+ char(44) +[SALDO_VENCIDO_60_DIAS]+ char(44) +[SALDO_VENCIDO_90_DIAS]+ char(44) +[SALDO_VENCIDO_120_DIAS]+ char(44) +'     
select @w_query = @w_query + '[SEGMENTO_ACTUAL]+ char(44) +[SEGMENTO_POSTERIOR]+ char(44) +[DIAS_FALTANTES]+ char(44) +[FECHA_CAMBIO_SEGMENTO]+ char(44) +'
select @w_query = @w_query + '[CORREO]+ char(44) +[ID_GRUPAL]+ char(44) +[NOMBRE_GRUPO]+ char(44) +[ROL_CLIENTE]+ char(44) +[ATRASO_GRUPAL] from cob_conta_super..sb_reporte_morosidad' 


select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'       

select 
@w_destino_reporte = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar(10), @w_fecha_proceso,103),'/','') + '.txt',
@w_errores         = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar(10), @w_fecha_proceso,103),'/','') + '.err'

select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_destino_reporte + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  return 1
end

return 0
go