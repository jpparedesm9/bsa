/************************************************************************/
/*   Archivo:                 sp_reporte_operativo_lcr.sp               */
/*   Stored procedure:        sp_reporte_operativo_lcr                  */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Julio 22 de 2019                          */
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
/*   22/07/2019 D. Cumbal        Version Inicial                        */ 
/*   01/08/2019 A. Inca          Actualización                          */
/*   17/04/2021 JCASTRO          REQ#155119                             */   
/*   09/11/2021 AGO              Error #171517                          */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_reporte_operativo_lcr') is null
   drop proc sp_reporte_operativo_lcr
go

create proc sp_reporte_operativo_lcr
   @i_param1            varchar(10),   --FECHA
   @i_param2            varchar(10),   --BATCH 28793
   @i_param3            varchar(10)    --FORMATO FECHA
as
declare 
@w_s_app                varchar(255),
@w_path                 varchar(255),
@w_destino              varchar(255),
@w_destino2             varchar(255),
@w_errores              varchar(255),
@w_cmd                  varchar(5000),
@w_error                int,
@w_comando              varchar(6000),
@w_fecha                datetime,
@w_batch                int,
@w_columna              varchar(50),
@w_col_id               int,
@w_cabecera             varchar(5000),
@w_anio                 char(4), 
@w_fecha2               char(10),
@w_fecha_desde          datetime,
@w_lineas               varchar(10),
@w_garhip               varchar(10),
@w_garpre               varchar(10),
@w_fp_usaid             varchar(30),
@w_tabla                int,
@w_estado_nota          char(1),
@w_empresa              tinyint,
@w_formato_fecha        int,
@w_est_vencido          int,
@w_est_vigente          int,
@w_est_castigado        int,
@w_grupo_act            int,
@w_num_ciclo_ant        int,
@w_resultado            int,
@w_return               int,
@w_fecha_provision      datetime,
@w_codigo_act_apr       int ,
@w_est_suspenso         int ,
@w_ente_aux             int,
@w_exp_credit           char(1),
@w_referencia           varchar(20),
@w_operacion            int,
@w_fecha_vencimiento    datetime,
@w_ciudad_nacional      int,
@w_dia                  varchar(2),
@w_mes                  varchar(2),
@w_ano                  varchar(4),
@w_ext_arch             varchar(6),
@w_nom_arch             varchar(50),
@w_nom_log              varchar(50),
@w_fecha_default        datetime,
@w_member_code          varchar(20),
-- REQ 155119
@w_dia_uno              varchar(10),
@w_ultimo_dia           varchar(10)

select
@w_batch         = convert(int,@i_param2),
@w_formato_fecha = convert(int,@i_param3),
@w_fecha         = @i_param1

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


select @w_fecha = dateadd(day,-1, @w_fecha)         
while exists(select 1 from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_nacional
             and   df_fecha  = @w_fecha) 
begin
        select @w_fecha = dateadd(day,-1,@w_fecha)                                    
end
            
select @w_empresa = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'EMP'
and   pa_producto = 'ADM'



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


SET NOCOUNT ON
SET ROWCOUNT 0

/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA SB_DATO_OPERACION */
select 
mca_operacion                = do_operacion,
mca_buc                      = convert(varchar(20),''),
mca_tipo_mercado             = convert(varchar(20),''),
mc_nivel_cliente_colectivo   = convert(varchar(20),''),
mca_banco                    = do_banco               ,
mca_cliente                  = do_codigo_cliente      ,
mca_nombre                   = convert(varchar(255),''),
mca_cuenta_cliente           = convert(varchar(100),''),
mca_referencia               = convert(varchar(64),''),
mca_oficina                  = do_oficina,
mca_desc_oficina             = convert(varchar(64),''),
mca_region                   = convert(varchar(64),''),
mca_oficial                  = convert(varchar(64),''),
mca_oficial_id               = do_oficial,
mca_fecha_desem              = do_fecha_concesion,
mca_fecha_vencimiento        = do_fecha_vencimiento,
mca_periodicidad             = (select td_descripcion from cob_cartera..ca_tdividendo a  where a.td_factor = b.do_periodicidad_cuota),
mca_fecha_primer_disposicion = convert(datetime,null),
mca_monto_primer_disposicion = convert(money,null),
mca_fecha_ult_disposicion    = convert(datetime,null),
mca_monto_ult_disposicion    = convert(money,null),
mca_limite_credito_actual    = do_monto_aprobado,
mca_cap_saldo                = do_saldo_cap,
mca_saldo_disponible         = do_monto_aprobado - do_saldo_cap,
mca_saldo_exigible           = convert(money,0), 
mca_pago_minimo              = convert(money,null), 
mca_cap_pago_minimo          = convert(money,null), 
mca_int_pago_minimo          = convert(money,null), 
mca_iva_int_pago_minimo      = convert(money,null), 
mca_comision_pago_minimo     = convert(money,null), 
mca_iva_comision_pago_minimo = convert(money,null), 
mca_importe_liquidacion      = do_saldo, 
mca_fecha_prox_vencimiento   = convert(datetime,null), 
mca_numero_disposiciones     = convert(int,null), 
mca_monto_dispuesto          = do_monto,
mca_comision_por_disposicion = convert(money,null), 
mca_iva_comi_por_disposicion = convert(money,null), 
mca_dias_atraso_act          = case when do_dias_mora_365>1 then do_dias_mora_365-1 else do_dias_mora_365 end,
mca_dias_atraso_max          = do_atraso_grupal,
mca_estado_cartera           = do_estado_cartera,
mca_status_credito           = convert(varchar(64),null),
mca_dias_de_atraso_6_meses   = convert(int,null), 
mca_dias_de_atraso_3_meses   = convert(int,null), 
mca_num_de_atraso_6_meses    = convert(int,null), 
mca_num_de_atraso_3_meses    = convert(int,null), 
mca_num_incrementos          = convert(int,null), 
mca_num_estrellas            = 0, 
mca_fecha_prox_aumento       = convert(datetime,null), 
mca_fecha_ult_aumento        = convert(datetime,null), 

mca_fecha_ven_uno            = convert(datetime,null), 
mca_monto_exigible_ven_uno   = convert(money,null), 
mca_saldo_capital_ven_uno    = convert(money,null), 
mca_monto_pag_cap_ven_uno    = convert(money,null), 
mca_monto_util_cap_ven_uno   = convert(money,null), 
mca_fecha_ult_pag_ven_uno    = convert(datetime,null),  
mca_num_disposicion_ven_uno  = convert(int,null),  

mca_fecha_ven_dos            = convert(datetime,null), 
mca_monto_exigible_ven_dos   = convert(money,null), 
mca_saldo_capital_ven_dos    = convert(money,null), 
mca_monto_pag_cap_ven_dos    = convert(money,null), 
mca_monto_util_cap_ven_dos   = convert(money,null), 
mca_fecha_ult_pag_ven_dos    = convert(datetime,null),  
mca_num_disposicion_ven_dos  = convert(int,null),  

mca_fecha_ven_tres           = convert(datetime,null), 
mca_monto_exigible_ven_tres  = convert(money,null), 
mca_saldo_capital_ven_tres   = convert(money,null), 
mca_monto_pag_cap_ven_tres   = convert(money,null), 
mca_monto_util_cap_ven_tres  = convert(money,null), 
mca_fecha_ult_pag_ven_tres   = convert(datetime,null),  
mca_num_disposicion_ven_tres = convert(int,null), 
mca_fecha_ven_cuatro         = convert(datetime,null), 
mca_monto_exigible_ven_cuatro= convert(money,null), 
mca_saldo_capital_ven_cuatro = convert(money,null), 
mca_monto_pag_cap_ven_cuatro = convert(money,null), 
mca_monto_util_cap_ven_cuatro= convert(money,null), 
mca_fecha_ult_pag_ven_cuatro = convert(datetime,null),  
mca_num_disposicion_ven_cuatro= convert(int,null),
mca_bloqueo                   = convert(varchar(2), null),
mca_usuario_ult_modifica_bl   = convert(varchar(14), null),
mca_numero_renovaciones       = 0, 
mca_operacion_anterior        = convert(varchar(24), null),
mca_monto_inc                 = convert(money,null),  -- inicio campos REQ#155119
mca_sal_car_ries              = case when do_dias_mora_365 >= 03 then do_saldo_cap else 0 end, 
mca_id_gerente                = convert(varchar(10),null),
mca_id_coordinador            = convert(varchar(10),null),
mca_id_asesor                 = do_oficial,
mca_tdisposicion_mes          = convert(int,0),
mca_tdispuesto_mes            = convert(money,null),
mca_num_bloqueos              = convert(int,0),
mca_tot_bloqueos              = convert(int,0), -- fin campos REQ#155119
mca_periodicidad_cuota   = do_periodicidad_cuota
into #maestro_cartera_lcr
from cob_conta_super..sb_dato_operacion b
where do_fecha          = @w_fecha
and   do_aplicativo     = 7
and   do_tipo_operacion = 'REVOLVENTE'


if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx0 on #maestro_cartera_lcr(mca_operacion)
create index idx1 on #maestro_cartera_lcr(mca_banco)
create index idx2 on #maestro_cartera_lcr(mca_cliente)


update #maestro_cartera_lcr
set mca_status_credito = es_descripcion
from  cob_cartera..ca_estado
where es_codigo = mca_estado_cartera

update #maestro_cartera_lcr
set mca_status_credito = 'ACTIVO SIN SALDO'
where  not exists (select 1
                   from cob_conta_super..sb_dato_transaccion
                   where dt_banco = mca_banco
                   and   dt_tipo_trans = 'DES')
				   
				   
				   



----------------------------------------
--Actualizaciones Masivas
----------------------------------------

update #maestro_cartera_lcr set 
mca_buc                 = en_banco,
mca_nombre              = UPPER(isnull(p_p_apellido,'')) + ' ' + UPPER(isnull(p_s_apellido,'')) + ' ' + UPPER(isnull(en_nombre,'')) + ' ' + UPPER(isnull(p_s_nombre,'')),
mca_cuenta_cliente      = ea_cta_banco,
mca_tipo_mercado        = (select valor
                           from cobis..cl_tabla t,
                           cobis..cl_catalogo c
                           where t.tabla = 'cl_tipo_mercado'
                           and   t.codigo = c.tabla
                           and   c.codigo = ea_colectivo),
mc_nivel_cliente_colectivo = (select valor
                           from cobis..cl_tabla t,
                           cobis..cl_catalogo c
                           where t.tabla = 'cl_nivel_cliente_colectivo'
                           and   t.codigo = c.tabla
                           and   c.codigo = ea_nivel_colectivo)
from cobis..cl_ente,
     cobis..cl_ente_aux
where en_ente = mca_cliente 
and   en_ente = ea_ente 
 

select @w_operacion = 0

while 1 = 1
begin
      select top 1 @w_operacion = mca_operacion
      from #maestro_cartera_lcr
      where mca_operacion > @w_operacion
      order by mca_operacion
      
      if @@rowcount = 0
         break
      
      exec cob_cartera..sp_santander_gen_ref
           @i_tipo_tran      = 'PI',
           @i_id_referencia  = @w_operacion,
           @i_monto          = null,
           @i_monto_desde    = null,
           @i_monto_hasta    = null,
           @i_fecha_lim_pago = null,	  
           @o_referencia     = @w_referencia out
		   
	   exec cob_cartera..sp_lcr_calc_corte
           @i_operacionca   = @w_operacion,
           @i_fecha_proceso = @w_fecha,
           @o_fecha_corte   = @w_fecha_vencimiento out
		   

      update #maestro_cartera_lcr
      set mca_referencia  = @w_referencia,
	      mca_fecha_prox_vencimiento = @w_fecha_vencimiento
      where mca_operacion = @w_operacion
     
end

/* 
--Division
update #maestro_cartera_lcr
set mca_desc_oficina = upper(of_nombre)
from cobis..cl_oficina
where  of_oficina = mca_oficina

if @@error <> 0 begin
   print 'Error Actualizando Descripciion Oficina'
   return 1
end

*/

/*
update  #maestro_cartera_lcr set 
mca_oficial        = fu_nombre
from cobis..cl_funcionario f
where fu_funcionario = mca_oficial_id  

if @@error <> 0 begin
   print 'Error Actualizar Asesor'
   return 1
end
*/

--Regional
update #maestro_cartera_lcr
set mca_region = (select A.of_nombre
                  from cobis..cl_oficina A, cobis..cl_oficina B
                  where A.of_oficina = B.of_regional
                  and   B.of_oficina = P.mca_oficina)
from  #maestro_cartera_lcr P

if @@error <> 0 begin
   print 'Error Actualizando Datos Regional'
   return 1
end

select banco              = dt_banco, 
       sec_min_desembolso = min(dt_secuencial), 
       sec_max_desembolso =max(dt_secuencial)
into #dispersiones       
from cob_conta_super..sb_dato_transaccion,
     #maestro_cartera_lcr
where dt_fecha      <= @w_fecha
and   dt_banco      = mca_banco
and   dt_tipo_trans = 'DES'
group by dt_banco


update #maestro_cartera_lcr
set   mca_fecha_primer_disposicion = dt_fecha_trans,
      mca_monto_primer_disposicion = dd_monto
from  #dispersiones,
       cob_conta_super..sb_dato_transaccion,
       cob_conta_super..sb_dato_transaccion_det
where  mca_banco     = banco
and    banco         = dt_banco
and    dt_secuencial = sec_min_desembolso --primer dispersion
and    dt_banco      = dd_banco 
and    dt_secuencial = dd_secuencial
and    dd_concepto   = 'CAP'


update #maestro_cartera_lcr
set   mca_fecha_ult_disposicion = dt_fecha_trans,
      mca_monto_ult_disposicion = dd_monto
from  #dispersiones,
       cob_conta_super..sb_dato_transaccion,
       cob_conta_super..sb_dato_transaccion_det
where  mca_banco     = banco
and    banco         = dt_banco
and    dt_secuencial = sec_max_desembolso --ultima dispersion
and    dt_banco      = dd_banco 
and    dt_secuencial = dd_secuencial
and    dd_concepto   = 'CAP'

select
dr_banco,
--SALDOS DEL PRESTAMO
dr_saldo_ex      = sum(case when dr_exigible   = 1   then  isnull(dr_valor, 0) else 0 end),
dr_saldo_prestamo= sum(isnull(dr_valor,0))
into #rubros
from #maestro_cartera_lcr, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha
and   dr_aplicativo = 7
and   dr_banco      = mca_banco
group by dr_banco


update #maestro_cartera_lcr set
mca_saldo_exigible = dr_saldo_ex
from #rubros
where mca_banco = dr_banco

-- actualizacion pago minimo, capital pago minimo, interes,iva,comision,iva comision
update #maestro_cartera_lcr set 
mca_pago_minimo               = isnull(cm_monto,0),
mca_cap_pago_minimo           = isnull(cm_capital,0),
mca_int_pago_minimo           = isnull(cm_interes,0),
mca_iva_int_pago_minimo       = isnull(cm_iva_interes,0),
mca_comision_pago_minimo      = isnull(cm_comision,0),
mca_iva_comision_pago_minimo  = isnull(cm_iva_comision,0)
from cob_conta_super..sb_cuota_minima
where cm_fecha = @w_fecha
and  mca_banco = cm_banco



-- actualizacion numero de disposiciones 
update #maestro_cartera_lcr
set mca_numero_disposiciones = isnull((select count(1)
                                from cob_conta_super..sb_dato_transaccion
                                where dt_banco = mca_banco
                                and dt_tipo_trans = 'DES'
                                group by dt_banco),0)

--comisiones disposiciones

select banco= mca_banco, concepto = dd_concepto, monto = sum(dd_monto)
into #comision_disposiciones
from  #maestro_cartera_lcr,
       cob_conta_super..sb_dato_transaccion,
       cob_conta_super..sb_dato_transaccion_det
where  mca_banco     = dt_banco
and    dt_banco      = dd_banco 
and    dt_secuencial = dd_secuencial
and    dt_tipo_trans = 'DES'
and    dd_concepto   in ('COM', 'IVA_COM')
group by mca_banco, dd_concepto

update #maestro_cartera_lcr set  
mca_comision_por_disposicion = monto
from #comision_disposiciones
where mca_banco  = banco
and  concepto = 'COM'

update #maestro_cartera_lcr set  
mca_iva_comi_por_disposicion = monto
--mca_comision_por_disposicion = monto
from #comision_disposiciones
where mca_banco = banco
and   concepto  = 'IVA_COM'

update #maestro_cartera_lcr set 
mca_dias_de_atraso_6_meses   = dl_dias_de_atraso_6_meses,
mca_dias_de_atraso_3_meses   = dl_dias_de_atraso_3_meses,
mca_num_de_atraso_6_meses    = dl_num_de_atraso_6_meses,
mca_num_de_atraso_3_meses    = dl_num_de_atraso_3_meses,
mca_num_incrementos          = dl_num_incrementos,
mca_num_estrellas            = isnull(dl_num_estrellas,0),
mca_fecha_prox_aumento       = dl_fecha_prox_aumento,
mca_fecha_ult_aumento        = dl_fecha_ult_aumento,
mca_bloqueo                  = dl_bloqueado,
mca_usuario_ult_modifica_bl  = dl_usuario_ult_modifica,
mca_numero_renovaciones      = dl_num_renovacion        ,    
mca_operacion_anterior       = dl_credito_anterior
from  sb_datos_lcr
where dl_fecha  = @w_fecha
and   mca_banco = dl_banco 

print '@w_fecha' + convert(varchar(20),@w_fecha)

if object_id('tempdb..#prestamos_dividendos') is  null  
begin
    create table #prestamos_dividendos(
       secuencial     int IDENTITY(1,1),
       operacion      int, 
       banco          cuenta,
       cliente        int,
       monto_aprobado money,
       id_inst_proceso int,
       fecha_ini      datetime,
       fecha_fin      datetime,
       fecha_des      datetime,
       utilizacion    money,
       pagos           money,
       diferencia     money,
       puntaje         int)
end    
    
exec cob_cartera..sp_lcr_gen_dividendos_tmp 
    @i_fecha           = @w_fecha,
	@i_cortes          = 4


alter table #prestamos_dividendos add capital_pagado money null
alter table #prestamos_dividendos add saldo_capital money null
alter table #prestamos_dividendos add saldo_exigible money null
alter table #prestamos_dividendos add fecha_ultimo_pago datetime null

update #prestamos_dividendos
set  capital_pagado = 0,
     saldo_capital  = 0     
     
     
select dr_banco,  
       dr_fecha, 
       puntaje,
       dr_cap_pag   = sum(case when dr_categoria  = 'C' then  isnull(dr_pagado,0) else 0 end),
       dr_saldo_ex  = sum(case when dr_exigible   = 1   then  isnull(dr_valor, 0) else 0 end)
into #valores_dividendos       
from #prestamos_dividendos,
     cob_conta_super..sb_dato_operacion_rubro
where banco     = dr_banco
and   fecha_fin = dr_fecha
group by dr_banco, dr_fecha, puntaje
order by dr_banco, dr_fecha


update #prestamos_dividendos
set  saldo_capital     = do_saldo_cap,
     fecha_ultimo_pago = do_fecha_ult_pago
from cob_conta_super..sb_dato_operacion
where do_fecha = fecha_fin
and   do_banco = banco    


update #prestamos_dividendos
set   capital_pagado = dr_cap_pag,
      saldo_exigible = dr_saldo_ex
from  #valores_dividendos
where banco     = dr_banco
and   fecha_fin = dr_fecha   

update  #maestro_cartera_lcr set 
mca_fecha_ven_uno            = fecha_fin,
mca_monto_exigible_ven_uno   = isnull(saldo_exigible,0),
mca_saldo_capital_ven_uno    = isnull(saldo_capital,0) ,
mca_monto_pag_cap_ven_uno    = isnull(capital_pagado,0),
mca_monto_util_cap_ven_uno   = isnull(utilizacion,0),
mca_fecha_ult_pag_ven_uno    = fecha_ultimo_pago,
mca_num_disposicion_ven_uno  = (select count(1) 
                                from cob_conta_super..sb_dato_transaccion 
                                where dt_banco     = mca_banco 
                                and  dt_tipo_trans = 'DES' 
                                and dt_fecha_trans >= fecha_ini 
                                and  dt_fecha_trans < fecha_fin)
from #prestamos_dividendos
where banco = mca_banco
and   puntaje = 5

update  #maestro_cartera_lcr set 
mca_fecha_ven_dos            = fecha_fin,
mca_monto_exigible_ven_dos   = isnull(saldo_exigible,0),
mca_saldo_capital_ven_dos    = isnull(saldo_capital,0) ,
mca_monto_pag_cap_ven_dos    = isnull(capital_pagado,0),
mca_monto_util_cap_ven_dos   = isnull(utilizacion,0),
mca_fecha_ult_pag_ven_dos    = fecha_ultimo_pago,
mca_num_disposicion_ven_dos  = (select count(1) 
                                from cob_conta_super..sb_dato_transaccion 
                                where dt_banco     = mca_banco 
                                and  dt_tipo_trans = 'DES' 
                                and dt_fecha_trans >= fecha_ini 
                                and  dt_fecha_trans < fecha_fin)
from #prestamos_dividendos
where banco = mca_banco
and   puntaje = 2

update  #maestro_cartera_lcr set 
mca_fecha_ven_tres            = fecha_fin,
mca_monto_exigible_ven_tres   = isnull(saldo_exigible,0),
mca_saldo_capital_ven_tres    = isnull(saldo_capital,0) ,
mca_monto_pag_cap_ven_tres    = isnull(capital_pagado,0),
mca_monto_util_cap_ven_tres   = isnull(utilizacion,0),
mca_fecha_ult_pag_ven_tres    = fecha_ultimo_pago,
mca_num_disposicion_ven_tres  = (select count(1) 
                                from cob_conta_super..sb_dato_transaccion 
                                where dt_banco     = mca_banco 
                                and  dt_tipo_trans = 'DES' 
                                and dt_fecha_trans >= fecha_ini 
                                and  dt_fecha_trans < fecha_fin)
from #prestamos_dividendos
where banco = mca_banco
and   puntaje = 1



update  #maestro_cartera_lcr set 
mca_fecha_ven_cuatro         = fecha_fin,
mca_monto_exigible_ven_cuatro   = isnull(saldo_exigible,0),
mca_saldo_capital_ven_cuatro    = isnull(saldo_capital,0) ,
mca_monto_pag_cap_ven_cuatro    = isnull(capital_pagado,0),
mca_monto_util_cap_ven_cuatro   = isnull(utilizacion,0),
mca_fecha_ult_pag_ven_cuatro    = fecha_ultimo_pago,
mca_num_disposicion_ven_cuatro  = (select count(1) 
                                from cob_conta_super..sb_dato_transaccion 
                                where dt_banco     = mca_banco 
                                and  dt_tipo_trans = 'DES' 
                                and dt_fecha_trans >= fecha_ini 
                                and  dt_fecha_trans < fecha_fin)
from #prestamos_dividendos
where banco = mca_banco
and   puntaje = 0

select banco,
       puntaje       = sum(puntaje)  ,
       fecha_ult_ven = max(fecha_fin)
into #suma_operacion       
from #prestamos_dividendos
where utilizacion = pagos
and   utilizacion >  0
group by banco

update #maestro_cartera_lcr
set mca_num_estrellas = isnull((select case when puntaje = 8 then 3
                                     when puntaje = 7 then 2   
                                     when puntaje = 6 then 1
                                     when puntaje = 5 then 1
                                     else 0 end
                         from  #suma_operacion                                    
                         where mca_banco = banco),0)                 

update #maestro_cartera_lcr
set mca_fecha_prox_aumento = case when mca_num_estrellas is null or mca_num_estrellas = 0 then 
                                       null
                                  when mca_num_estrellas = 3 then
                                       @w_fecha
                                  when mca_num_estrellas = 1 and mca_periodicidad = 'SEMANAL' then 
                                       dateadd(dd, 14, mca_fecha_prox_vencimiento)
                                  when mca_num_estrellas = 2 and mca_periodicidad = 'SEMANAL' then
                                       dateadd(dd, 7, mca_fecha_prox_vencimiento)                                  
                                  when mca_num_estrellas = 1 and mca_periodicidad = 'BISEMANAL' then 
                                       dateadd(dd, 28, mca_fecha_prox_vencimiento)
                                  when mca_num_estrellas = 2 and mca_periodicidad = 'BISEMANAL' then
                                       dateadd(dd, 14, mca_fecha_prox_vencimiento)
                                  when mca_num_estrellas = 1 and mca_periodicidad = 'MENSUAL' then 
                                       dateadd(dd, 60, mca_fecha_prox_vencimiento)
                                  when mca_num_estrellas = 2 and mca_periodicidad = 'MENSUAL' then
                                       dateadd(dd, 30, mca_fecha_prox_vencimiento)
                                  end
                                  
/* REQ#155119 */
select @w_dia_uno = right('00'+convert(varchar(2),datepart(mm,@w_fecha)),2) + '/01/' + right('0000'+convert(varchar(4),datepart(yyyy,@w_fecha)),4)
select @w_ultimo_dia = convert(varchar(10),dateadd(mm,1,@w_dia_uno),101)
select @w_ultimo_dia = convert(varchar(10),dateadd(dd,-1,@w_ultimo_dia),101)

select operacion = op_operacion, banco = mca_banco, incremento = ic_incremento
into   #incrementos
from   #maestro_cartera_lcr,
       cob_cartera..ca_operacion,
       cob_cartera..ca_incremento_cupo
where  mca_banco = op_banco
and    op_operacion = ic_operacion
and    ic_fecha_proceso = (select max(ic_fecha_proceso) from cob_cartera..ca_incremento_cupo where ic_operacion = op_operacion)
group by op_operacion, mca_banco, ic_incremento

update #maestro_cartera_lcr
set    mca_monto_inc = incremento
from   #incrementos
where  mca_banco = banco

drop table #incrementos

select banco= mca_banco, concepto = count(0), monto = sum(dd_monto)
into  #disposiciones_mes
from  #maestro_cartera_lcr,
       cob_conta_super..sb_dato_transaccion,
       cob_conta_super..sb_dato_transaccion_det
where  mca_banco     = dt_banco
and    dt_banco      = dd_banco 
and    dt_fecha between @w_dia_uno and @w_ultimo_dia
and    dt_secuencial = dd_secuencial
and    dt_tipo_trans = 'DES'
and    dd_concepto   = 'CAP'
group by mca_banco, dd_concepto

update #maestro_cartera_lcr
set    mca_tdisposicion_mes = concepto,
       mca_tdispuesto_mes   = monto
from   #disposiciones_mes
where  mca_banco = banco

drop table #disposiciones_mes

select operacion = op_operacion, banco = mca_banco, fecha = lbs_fecha_ult_mod, cuenta = count(0)
into   #bloqueos
from   #maestro_cartera_lcr,
       cob_cartera..ca_operacion,
       cob_cartera..ca_lcr_bloqueo_ts
where  mca_banco = op_banco
and    op_operacion = lbs_operacion
and    lb_bloqueo = 'S'
group by op_operacion, mca_banco, lbs_fecha_ult_mod

select operacion = op_operacion, banco = mca_banco, fecha = lbs_fecha_proceso_ts, cuenta = count(0)
into   #bloqueos_mes
from   #maestro_cartera_lcr,
       cob_cartera..ca_operacion,
       cob_cartera..ca_lcr_bloqueo_ts
where  mca_banco = op_banco
and    op_operacion = lbs_operacion
and    lb_bloqueo = 'S'
and    lbs_fecha_proceso_ts between @w_dia_uno and @w_ultimo_dia
group by op_operacion, mca_banco, lbs_fecha_proceso_ts

update #maestro_cartera_lcr
set    mca_num_bloqueos = cuenta
from   #bloqueos_mes
where  mca_banco = banco

update #maestro_cartera_lcr
set    mca_tot_bloqueos = cuenta
from   #bloqueos
where  mca_banco = banco

drop table #bloqueos
drop table #bloqueos_mes

update #maestro_cartera_lcr
set    mca_id_coordinador = fu_jefe
from   cobis..cl_funcionario
where  fu_funcionario = mca_id_asesor

update #maestro_cartera_lcr
set    mca_id_gerente = fu_jefe
from   cobis..cl_funcionario
where  fu_funcionario = mca_id_coordinador
/* REQ#155119 */


/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
if not object_id('sb_reporte_operativo_lcr') is null drop table sb_reporte_operativo_lcr
if not object_id('sb_reporte_linea_lcr') is null drop table sb_reporte_linea_lcr

create table sb_reporte_linea_lcr (rb_cadena varchar (max) null)

select 
'BUC'                            = isnull(mca_buc,' '),  
'CONTRATO'                       = isnull(mca_banco,' '),   
'TIPO MERCADO'                   = isnull(mca_tipo_mercado, ' '),
'NIVEL CLIENTE COLECTIVO'        = isnull(mc_nivel_cliente_colectivo,' '),
'CLIENTE COBIS'                  = isnull(mca_cliente,0),      
'NUMERO DE CUENTA DE DEPOSITO'   = isnull(mca_cuenta_cliente, ' '),
'NOMBRE COMPLETO'                = isnull(mca_nombre, ' '),
'REFERENCIA'                     = isnull(mca_referencia, ' '),
'OFICINA'                        = isnull(mca_oficina,' '),                             
'REGION'                         = isnull(mca_region,' '),                               
'ASESOR'                         = isnull(mca_oficial_id, ' '),
'FECHA OTORGAMIENTO'             = isnull(convert(varchar,mca_fecha_desem,@w_formato_fecha),' '),
'FECHA VENCIMIENTO'              = isnull(convert(varchar,mca_fecha_vencimiento,@w_formato_fecha),' '),
'PERIODICIDAD'                   = isnull(mca_periodicidad,' '),
'NUMERO DE RENOVACION'           = isnull(mca_numero_renovaciones,1),
'NUMERO DE CREDITO ANTERIOR'     = isnull(mca_operacion_anterior,' '),
'FECHA PRIMER DISPOSICION'       = isnull(convert(varchar,mca_fecha_primer_disposicion,@w_formato_fecha),' '),
'MONTO PRIMERA DISPOSICION'      = isnull(mca_monto_primer_disposicion,0),
'FECHA ULTIMA DISPOSICION '      = isnull(convert(varchar,mca_fecha_ult_disposicion,@w_formato_fecha),' '),
'MONTO ULTIMA DISPOSICION'       = isnull(mca_monto_ult_disposicion,0),
'LIMITE DE CREDITO ACTUAL'       = isnull(mca_limite_credito_actual,0),
'ESTATUS DEL CREDITO'            = isnull(mca_status_credito, ' '),
'ESTADO DE CARTERA '             = mca_estado_cartera,
'BLOQUEO'                        = isnull(mca_bloqueo, 'N'),
'USUARIO ULT MOD'                = isnull(mca_usuario_ult_modifica_bl, ' '),
'SALDO CAPITAL DEL PRESTAMO'     = isnull(mca_cap_saldo,0),
'SALDO DISPONIBLE'               = isnull(mca_saldo_disponible,0),      
'SALDO EXIGIBLE'                 = isnull(mca_saldo_exigible,0),      
'PAGO MINIMO '                   = isnull(mca_pago_minimo,0),
'CAPITAL PAGO'                   = isnull(mca_cap_pago_minimo,0),          
'INTERES PAGO'                   = isnull(mca_int_pago_minimo,0),          
'IVA INTERES PAGO'               = isnull(mca_iva_int_pago_minimo,0),      
'COMISIONES PAGO'                = isnull(mca_comision_pago_minimo,0),     
'IVA COMISIONES PAGO'            = isnull(mca_iva_comision_pago_minimo,0),          
'COMISION POR DISPOSICION'       = isnull(mca_comision_por_disposicion,0),          
'IVA DE COMISION POR DISPOSICION'= isnull(mca_iva_comi_por_disposicion,0),
'IMPORTE LIQUIDA CON'            = isnull(mca_importe_liquidacion,0),
'FECHA PROXIMO VENCIMIENTO'      = isnull(convert(varchar,mca_fecha_prox_vencimiento,@w_formato_fecha),' '),
'NUMERO DE DISPOSICIONES'        = isnull(mca_numero_disposiciones,0),
'MONTO TOTAL DISPUESTO'          = isnull(mca_monto_dispuesto,0),   
'DIAS DE ATRASO ACTUAL'          = isnull(mca_dias_atraso_act,0),      
'DIAS DE ATRASO MAXIMO'          = isnull(mca_dias_atraso_max,0),
'DIAS DE ATRASO MAXIMO 6 MESES'  = isnull(mca_dias_de_atraso_6_meses,0),          
'DIAS DE ATRASO MAXIMO 3 MESES'  = isnull(mca_dias_de_atraso_3_meses,0),
'NUMERO DE ATRASOS EN 6 MESES'   = isnull(mca_num_de_atraso_6_meses,0),
'NUMERO DE ATRASOS EN 3 MESES'   = isnull(mca_num_de_atraso_3_meses,0),          
'NUMERO DE AUMENTOS'             = isnull(mca_num_incrementos,0),          
'RECORD PARA AUMENTO (ESTRELLAS)'= isnull(mca_num_estrellas,0),      
'FECHA PARA PROXIMO AUMENTO '    = isnull(convert(varchar,mca_fecha_prox_aumento,@w_formato_fecha),' '),   
'FECHA DE ÚLTIMO AUMENTO'        = isnull(convert(varchar,mca_fecha_ult_aumento,@w_formato_fecha),' '),      
'FECHA VEN - 1'                  = isnull(convert(varchar,mca_fecha_ven_uno,@w_formato_fecha),' '),          
'MONTO EXIGIBLE VEN - 1'         = isnull(mca_monto_exigible_ven_uno,0),    
'SALDO CAPITAL VEN -1'           = isnull(mca_saldo_capital_ven_uno,0),          
'MONTO PAGADO CAPITAL VEN-1'     = isnull(mca_monto_pag_cap_ven_uno,0),            
'MONTO UTILIZADO CAPITAL VEN-1'  = isnull(mca_monto_util_cap_ven_uno,0),       
'FECHA ULT PAGO VEN-1'           = isnull(convert(varchar,mca_fecha_ult_pag_ven_uno,@w_formato_fecha),' '),                  
'NRO DISPOSICIONES VEN-1'        = isnull(mca_num_disposicion_ven_uno,0),
'FECHA VEN-2'                    = isnull(convert(varchar,mca_fecha_ven_dos,@w_formato_fecha),' '),                  
'MONTO EXIGIBLE VEN-2'           = isnull(mca_monto_exigible_ven_dos,0),            
'SALDO CAPITAL VEN-2'            = isnull(mca_saldo_capital_ven_dos,0),               
'MONTO PAGADO CAPITAL VEN-2'     = isnull(mca_monto_pag_cap_ven_dos,0),                   
'MONTO UTILIZADO CAPITAL VEN-2'  = isnull(mca_monto_util_cap_ven_dos,0),                       
'FECHA ULT PAGO VEN-2'           = isnull(convert(varchar,mca_fecha_ult_pag_ven_dos,@w_formato_fecha),' '),                     
'NRO DISPOSICIONES VEN-2'        = isnull(mca_num_disposicion_ven_dos,0),                           
'FECHA VEN-3'                    = isnull(convert(varchar,mca_fecha_ven_tres,@w_formato_fecha),' '),   
'MONTO EXIGIBLE VEN-3'           = isnull(mca_monto_exigible_ven_tres,0), 
'SALDO CAPITAL VEN-3'            = isnull(mca_saldo_capital_ven_tres,0),             
'MONTO PAGADO CAPITAL VEN-3'     = isnull(mca_monto_pag_cap_ven_tres,0),   
'MONTO UTILIZADO CAPITAL VEN-3'  = isnull(mca_monto_util_cap_ven_tres,0),       
'FECHA ULT PAGO VEN-3'           = isnull(convert(varchar,mca_fecha_ult_pag_ven_tres,@w_formato_fecha),' '),       
'NRO DISPOSICIONES VEN-3'        = isnull(mca_num_disposicion_ven_tres,0),          
'FECHA VEN-4'                    = isnull(convert(varchar,mca_fecha_ven_cuatro,@w_formato_fecha),' '),     
'MONTO EXIGIBLE VEN-4'           = isnull(mca_monto_exigible_ven_cuatro,0),  
'SALDO CAPITAL VEN-4'            = isnull(mca_saldo_capital_ven_cuatro,0),   
'MONTO PAGADO CAPITAL VEN-4'     = isnull(mca_monto_pag_cap_ven_cuatro,0),   
'MONTO UTILIZADO CAPITAL VEN-4'  = isnull(mca_monto_util_cap_ven_cuatro,0),            
'FECHA ULT PAGO VEN-4'           = isnull(convert(varchar,mca_fecha_ult_pag_ven_cuatro,@w_formato_fecha),' '), 
'NRO DISPOSICIONES VEN-4'        = isnull(mca_num_disposicion_ven_cuatro,0),
'MONTO INCREMENTO'               = isnull(mca_monto_inc,0),
'SALDO DE CARTERA EN RIESGO'     = isnull(mca_sal_car_ries,0),
'ID GERENTE'                     = isnull(mca_id_gerente,''),
'ID COORDINADOR'                 = isnull(mca_id_coordinador,''),
'ID ASESOR'                      = isnull(mca_id_asesor,''),
'TOTAL DE DISPOSICIONES DEL MES' = isnull(mca_tdisposicion_mes,0),
'MONTO TOTAL DISPUESTO DEL MES'  = isnull(mca_tdispuesto_mes,0),
'BLOQUEOS MENSUALES'             = isnull(mca_num_bloqueos,0),
'BLOQUEOS ACUMULADOS'             = isnull(mca_tot_bloqueos,0)
into sb_reporte_operativo_lcr
from #maestro_cartera_lcr

insert into sb_reporte_linea_lcr(rb_cadena)
select 
'BUC'                            + '|' +
'CONTRATO'                       + '|' +
'TIPO DE MERCADO'                + '|' +
'NIVEL CLIENTE EN COLECTIVO'     + '|' +
'CLIENTE COBIS'                  + '|' +
'NUMERO DE CUENTA DE DEPOSITO'   + '|' +
'NOMBRE COMPLETO DEL CLIENTE'    + '|' +
'REFERENCIA'                     + '|' +
'OFICINA'                        + '|' +
'REGION'                         + '|' +
'ASESOR'                         + '|' +
'FECHA DE OTORGAMIENTO DE LINEA' + '|' +
'FECHA DE VENCIMIENTO DE LINEA'  + '|' +
'PERIODICIDAD'                   + '|' +
'NUMERO DE RENOVACION'           + '|' +
'NUMERO DE CREDITO ANTERIOR'     + '|' +
'FECHA PRIMER DISPOSICION'       + '|' +
'MONTO PRIMERA DISPOSICION'      + '|' +
'FECHA ULTIMA DISPOSICION '      + '|' +
'MONTO ULTIMA DISPOSICION'       + '|' +
'LIMITE DE CREDITO ACTUAL'       + '|' +
'ESTATUS DEL CREDITO'            + '|' +
'ESTADO DE CARTERA '             + '|' +
'BLOQUEO'                        + '|' +
'USUARIO ULT MOD'                + '|' +
'SALDO CAPITAL DEL PRESTAMO'     + '|' +
'SALDO DISPONIBLE'               + '|' +
'SALDO EXIGIBLE'                 + '|' +
'PAGO MINIMO '                   + '|' +
'CAPITAL'                        + '|' +
'INTERES'                        + '|' +
'IVA INTERES'                    + '|' +
'COMISIONES'                     + '|' +
'IVA COMISIONES'                 + '|' +
'COMISION POR DISPOSICION'       + '|' +
'IVA DE COMISION POR DISPOSICION'+ '|' +
'IMPORTE LIQUIDA CON'            + '|' +
'FECHA PROXIMO VENCIMIENTO'      + '|' +
'NUMERO DE DISPOSICIONES'        + '|' +
'MONTO TOTAL DISPUESTO'          + '|' +
'DIAS DE ATRASO ACTUAL'          + '|' +
'DIAS DE ATRASO MAXIMO'          + '|' +
'DIAS DE ATRASO MAXIMO 6 MESES'  + '|' +
'DIAS DE ATRASO MAXIMO 3 MESES'  + '|' +
'NUMERO DE ATRASOS EN 6 MESES'   + '|' +
'NUMERO DE ATRASOS EN 3 MESES'   + '|' +
'NUMERO DE AUMENTOS'             + '|' +
'RECORD PARA AUMENTO (ESTRELLAS)'+ '|' +
'FECHA PARA PROXIMO AUMENTO (PROYECTADO)'    + '|' +
'FECHA DE ULTIMO AUMENTO'        + '|' +
'FECHA VEN - 1'                  + '|' +
'MONTO EXIGIBLE VEN - 1'         + '|' +
'SALDO CAPITAL VEN -1'           + '|' +
'MONTO PAGADO CAPITAL VEN-1'     + '|' +
'MONTO UTILIZADO CAPITAL VEN-1'  + '|' +
'FECHA ULT PAGO VEN-1'           + '|' +         
'NRO DISPOSICIONES VEN-1'        + '|' +
'FECHA VEN-2'                    + '|' +
'MONTO EXIGIBLE VEN-2'           + '|' +
'SALDO CAPITAL VEN-2'            + '|' +
'MONTO PAGADO CAPITAL VEN-2'     + '|' +
'MONTO UTILIZADO CAPITAL VEN-2'  + '|' +
'FECHA ULT PAGO VEN-2'           + '|' +            
'NRO DISPOSICIONES VEN-2'        + '|' +
'FECHA VEN-3'                    + '|' +
'MONTO EXIGIBLE VEN-3'           + '|' +
'SALDO CAPITAL VEN-3'            + '|' +
'MONTO PAGADO CAPITAL VEN-3'     + '|' +
'MONTO UTILIZADO CAPITAL VEN-3'  + '|' +
'FECHA ULT PAGO VEN-3'           + '|' +
'NRO DISPOSICIONES VEN-3'        + '|' +
'FECHA VEN-4'                    + '|' +
'MONTO EXIGIBLE VEN-4'           + '|' +
'SALDO CAPITAL VEN-4'            + '|' +
'MONTO PAGADO CAPITAL VEN-4'     + '|' +
'MONTO UTILIZADO CAPITAL VEN-4'  + '|' +
'FECHA ULT PAGO VEN-4'           + '|' +
'NRO DISPOSICIONES VEN-4'        + '|' +
'MONTO INCREMENTO'               + '|' +
'SALDO DE CARTERA EN RIESGO'     + '|' +
'ID GERENTE'                     + '|' +
'ID COORDINADOR'                 + '|' +
'ID ASESOR'                      + '|' +
'TOTAL DE DISPOSICIONES DEL MES' + '|' +
'MONTO TOTAL DISPUESTO DEL MES'  + '|' +
'BLOQUEOS MENSUALES'             + '|' +
'BLOQUEOS ACUMULADOS'


insert into sb_reporte_linea_lcr(rb_cadena)
select 
isnull(mca_buc,' ') + '|' + 
isnull(mca_banco,' ') + '|' +  
isnull(mca_tipo_mercado,' ') + '|' +
isnull(mc_nivel_cliente_colectivo,' ') + '|' +
convert(varchar(10),isnull(mca_cliente,0)) + '|' +   
isnull(mca_cuenta_cliente, ' ') + '|' +
isnull(mca_nombre, ' ') + '|' +
isnull(mca_referencia, ' ') + '|' +
convert(varchar(5),isnull(mca_oficina,' ')) + '|' +                             
isnull(mca_region,' ') + '|' +                              
convert(varchar(5),isnull(mca_oficial_id, ' ')) + '|' +
isnull(convert(varchar,mca_fecha_desem,@w_formato_fecha),' ') + '|' +
isnull(convert(varchar,mca_fecha_vencimiento,@w_formato_fecha),' ') + '|' +
isnull(mca_periodicidad,' ') + '|' +
convert(varchar(10),isnull(mca_numero_renovaciones,1)) + '|' +
isnull(mca_operacion_anterior,' ') + '|' +
isnull(convert(varchar,mca_fecha_primer_disposicion,@w_formato_fecha),' ')  + '|' +
convert(varchar(10),isnull(mca_monto_primer_disposicion,0))  + '|' +
isnull(convert(varchar,mca_fecha_ult_disposicion,@w_formato_fecha),' ')  + '|' +
convert(varchar(20),isnull(mca_monto_ult_disposicion,0)) + '|' +
convert(varchar(20),isnull(mca_limite_credito_actual,0))  + '|' +
isnull(mca_status_credito, ' ')  + '|' +
convert(varchar(3),mca_estado_cartera)  + '|' +
isnull(mca_bloqueo, 'N') + '|' +
isnull(mca_usuario_ult_modifica_bl, ' ') + '|' +
convert(varchar(20),isnull(mca_cap_saldo,0)) + '|' +
convert(varchar(20),isnull(mca_saldo_disponible,0)) + '|' +     
convert(varchar(20),isnull(mca_saldo_exigible,0)) + '|' +     
convert(varchar(20),isnull(mca_pago_minimo,0)) + '|' +
convert(varchar(20),isnull(mca_cap_pago_minimo,0)) + '|' +          
convert(varchar(20),isnull(mca_int_pago_minimo,0)) + '|' +       
convert(varchar(20),isnull(mca_iva_int_pago_minimo,0)) + '|' +      
convert(varchar(20),isnull(mca_comision_pago_minimo,0)) + '|' +     
convert(varchar(20),isnull(mca_iva_comision_pago_minimo,0)) + '|' +           
convert(varchar(20),isnull(mca_comision_por_disposicion,0)) + '|' +         
convert(varchar(20),isnull(mca_iva_comi_por_disposicion,0)) + '|' +
convert(varchar(20),isnull(mca_importe_liquidacion,0)) + '|' +
isnull(convert(varchar,mca_fecha_prox_vencimiento,@w_formato_fecha),' ') + '|' + 
convert(varchar(10),isnull(mca_numero_disposiciones,0)) + '|' + 
convert(varchar(20),isnull(mca_monto_dispuesto,0)) + '|' +    
convert(varchar(10),isnull(mca_dias_atraso_act,0)) + '|' +     
convert(varchar(10),isnull(mca_dias_atraso_max,0)) + '|' +
convert(varchar(10),isnull(mca_dias_de_atraso_6_meses,0)) + '|' +           
convert(varchar(10),isnull(mca_dias_de_atraso_3_meses,0)) + '|' +
convert(varchar(10),isnull(mca_num_de_atraso_6_meses,0)) + '|' +
convert(varchar(10),isnull(mca_num_de_atraso_3_meses,0)) + '|' +         
convert(varchar(10),isnull(mca_num_incrementos,0)) + '|' +          
convert(varchar(4),isnull(mca_num_estrellas,0)) + '|' +       
isnull(convert(varchar,mca_fecha_prox_aumento,@w_formato_fecha),' ') + '|' +    
isnull(convert(varchar,mca_fecha_ult_aumento,@w_formato_fecha),' ') + '|' +    
isnull(convert(varchar(10),mca_fecha_ven_uno,@w_formato_fecha),' ') + '|' +           
convert(varchar(20),isnull(mca_monto_exigible_ven_uno,0)) + '|' +     
convert(varchar(20),isnull(mca_saldo_capital_ven_uno,0)) + '|' +         
convert(varchar(20),isnull(mca_monto_pag_cap_ven_uno,0)) + '|' +           
convert(varchar(20),isnull(mca_monto_util_cap_ven_uno,0)) + '|' +       
isnull(convert(varchar,mca_fecha_ult_pag_ven_uno,@w_formato_fecha),' ') + '|' +                   
convert(varchar(10),isnull(mca_num_disposicion_ven_uno,0)) + '|' +
isnull(convert(varchar(10),mca_fecha_ven_dos,@w_formato_fecha),' ') + '|' +                   
convert(varchar(20),isnull(mca_monto_exigible_ven_dos,0))  + '|' +             
convert(varchar(20),isnull(mca_saldo_capital_ven_dos,0)) + '|' +            
convert(varchar(20),isnull(mca_monto_pag_cap_ven_dos,0)) + '|' +                  
convert(varchar(20),isnull(mca_monto_util_cap_ven_dos,0)) + '|' +                       
isnull(convert(varchar,mca_fecha_ult_pag_ven_dos,@w_formato_fecha),' ') + '|' +                      
convert(varchar(10),isnull(mca_num_disposicion_ven_dos,0)) + '|' +                            
isnull(convert(varchar(10),mca_fecha_ven_tres,@w_formato_fecha),' ') + '|' +    
convert(varchar(20),isnull(mca_monto_exigible_ven_tres,0)) + '|' +
convert(varchar(20),isnull(mca_saldo_capital_ven_tres,0)) + '|' +           
convert(varchar(20),isnull(mca_monto_pag_cap_ven_tres,0)) + '|' +  
convert(varchar(20),isnull(mca_monto_util_cap_ven_tres,0)) + '|' +        
isnull(convert(varchar,mca_fecha_ult_pag_ven_tres,@w_formato_fecha),' ')  + '|' +        
convert(varchar(10),isnull(mca_num_disposicion_ven_tres,0)) + '|' +           
isnull(convert(varchar(10),mca_fecha_ven_cuatro,@w_formato_fecha),' ') + '|' +      
convert(varchar(20),isnull(mca_monto_exigible_ven_cuatro,0)) + '|' +
convert(varchar(20),isnull(mca_saldo_capital_ven_cuatro,0)) + '|' +  
convert(varchar(20),isnull(mca_monto_pag_cap_ven_cuatro,0))  + '|' +   
convert(varchar(20),isnull(mca_monto_util_cap_ven_cuatro,0))  + '|' +          
isnull(convert(varchar,mca_fecha_ult_pag_ven_cuatro,@w_formato_fecha),' ') + '|' + 
convert(varchar(10),isnull(mca_num_disposicion_ven_cuatro,0)) + '|' +
convert(varchar(20),isnull(mca_monto_inc,0))         + '|' +
convert(varchar(20),isnull(mca_sal_car_ries,0))      + '|' +
convert(varchar(20),isnull(mca_id_gerente,''))       + '|' +
convert(varchar(20),isnull(mca_id_coordinador,''))   + '|' +
convert(varchar(20),isnull(mca_id_asesor,''))        + '|' +
convert(varchar(20),isnull(mca_tdisposicion_mes,0))  + '|' +
convert(varchar(20),isnull(mca_tdispuesto_mes,0))    + '|' +
convert(varchar(20),isnull(mca_num_bloqueos,0))      + '|' +
convert(varchar(20),isnull(mca_tot_bloqueos,0))
from #maestro_cartera_lcr



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

select @w_dia = right('00'+convert(varchar(2),datepart(dd, @i_param1)  ),2)
select @w_mes = right('00'+convert(varchar(2),datepart(mm, @i_param1)  ),2)
select @w_ano = substring(convert(varchar(4),datepart(yy, @i_param1)),3,2)

select @w_member_code='OPERATIVO_LCR_'
select @w_nom_arch = @w_member_code + '_' + @w_ano + @w_mes + @w_dia + '.txt'  
select @w_nom_log  = @w_member_code + '_' + @w_ano + @w_mes + @w_dia + '.err'

select @w_comando = 'bcp "select rb_cadena from cob_conta_super..sb_reporte_linea_lcr" queryout '

select @w_destino  = @w_path + @w_nom_arch, -- MEMBERCODE_DDMMYYYY.ext
       @w_errores  = @w_path + @w_nom_log   -- MEMBERCODE_DDMMYYYY.err

select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -T -e' + @w_errores

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte Operativo LCR de Cartera'
   print @w_comando
   return 1
end

return 0

go
