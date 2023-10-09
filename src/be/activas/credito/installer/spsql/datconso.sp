/*datconso.sp************************************************************/
/*   Archivo:             datconso.sp                                   */
/*   Stored procedure:    sp_datos_consolidador                         */
/*   Base de datos:       cob_credito                                   */
/*   Producto:            Credito                                       */
/*   Disenado por:        Fernando Carvajal                             */
/*   Fecha de escritura:  23/Mar/2010.                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Extraccion de datos de credito y cobranza para repositorio         */
/*   ENE-2015         Luis C. Moreno   RQ486-REPOSITORIO SEGUROS        */
/************************************************************************/

use cob_credito
go
 
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_datos_consolidador')
   drop proc sp_datos_consolidador
go

CREATE proc sp_datos_consolidador  
@i_fecha                 smalldatetime,
@i_proceso               int


as declare
@w_error                int,
@w_trn_prg              smallint,
@w_return               int,
@w_sp_name              varchar(64),
@w_fecha_proceso        smalldatetime,
@w_msg                  varchar(64),
@w_sig_habil            datetime,
@w_ciudad               int,
@w_fin_mes              char(1),
@w_fecha_ini            datetime, 
@w_aplicativo           tinyint,
@w_vig_origen           int


create table #tramite_proceso_nuevo (tramite   int   not null)
create unique nonclustered index idx1 on #tramite_proceso_nuevo (tramite)

create table #tramite_proceso (tramite   int   not null, estado char(1) not null)
create unique nonclustered index idx1 on #tramite_proceso (tramite)

create table #benef (tramite int not null, cantidad int not null)
create unique nonclustered index idx1 on #benef (tramite)

create table #dec_jurada (tramite int not null, valor float not null)
create unique nonclustered index idx1 on #dec_jurada (tramite)

/* CARGADO DE VARIABLES DE TRABAJO */
select 
@w_sp_name = 'sp_datos_consolidador', 
@w_trn_prg = 22871  -- Tipo de Transaccion para ingreso de pregunta.

/* APLICATIVO PARA CREDITO */
select @w_aplicativo = pd_producto 
from   cobis..cl_producto 
where  pd_abreviatura = 'CRE'


/* CALCULA LOS TRAMITES SIN DUPLICADOS*/
insert into #tramite_proceso
select tt_tramite, tr_estado
from   cr_consolidador_tramite_tmp, cr_tramite
where  tt_fecha   =  @i_fecha
and    tt_tramite = tr_tramite
                                                                      
if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR EN AL EXTRAER LOS TRAMITES SIN DUPLICADOS'
   goto ERROR
end

/* CALCULA LOS TRAMITES NUEVOS */
insert into #tramite_proceso_nuevo
select tramite 
from   #tramite_proceso
where  tramite not in (select ct_tramite from cr_consolidador_tramite where ct_fecha <= @i_fecha and ct_estado = 'P')  
            
if @@error <> 0 begin
   select   
   @w_error = 2103046, 
   @w_msg = 'ERROR EN AL CALCULAR LOS TRAMITES NUEVOS'
   goto ERROR
end

/* DATO DEUDORES */
insert into cob_externos..ex_dato_deudores (
de_fecha,       de_rol,         de_banco,       
de_aplicativo,  de_cliente,     de_toperacion)
select 
@i_fecha,       ltrim(rtrim(de_rol)),         convert(varchar(24), tr_tramite),
@w_aplicativo,  de_cliente,     isnull(tr_toperacion, '') 
from  #tramite_proceso, cr_deudores, cr_tramite
where tramite = tr_tramite       
and   tramite = de_tramite       

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_deudores'
   goto ERROR
end

--Req 440
/* REPUNTUACION */
insert into cob_externos..ex_repuntuacion (
 re_tramite,   re_fecha_repuntuacion,	   re_tipo_proceso)
select 
re_tramite,	   re_fecha_repuntuacion,	   re_tipo_proceso
from  cr_repuntuacion crr
where crr.re_fecha_repuntuacion = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_repuntacion'
   goto ERROR
end

/* REQ. 300 DATO GESTION CAMPA¥A*/
insert into cob_externos..ex_dato_gestion_campana (
gc_fecha,           gc_aplicativo,         gc_campana,
gc_cliente,         gc_fecha_campana,      gc_secuencial,	        
gc_gestor,          gc_forma_gestion,	   gc_logro_contacto,	
gc_contacto_con,    gc_causa_no_contacto,  gc_resp_favorable,	
gc_causa_rechazo,   gc_cerrar_gestion,	   gc_causa_cierre,	        
gc_comentario,      gc_fecha_gestion,      gc_hora_gestion,	        
gc_user,            gc_hora_real)

select 
@i_fecha,              21,                    gc_campana,
gc_cliente,            gc_fecha_campana,      gc_secuencial,	        
gc_gestor,             gc_forma_gestion,      gc_logro_contacto,	
gc_contacto_con,       gc_causa_no_contacto,  gc_resp_favorable,	
gc_causa_rechazo,      gc_cerrar_gestion,     gc_causa_cierre,	        
gc_comentario,         gc_fecha_gestion,      gc_hora_gestion,	        
gc_user,               gc_hora_real   
from cob_credito..cr_gestion_campana
where gc_fecha_gestion =  @i_fecha 

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_gestion_campana '
   goto ERROR
end

/* REQ. 300 DATO RESPUESTAS*/
insert into cob_externos..ex_dato_encuestas (
re_fecha,        re_aplicativo,        re_cliente,
re_fecha_resp,   re_formulario,        re_version,
re_secuencial,   re_cod_pregunta,      re_pregunta,
re_respuesta)
select 
@i_fecha,         21,              re_cliente, 
re_fecha,         re_formulario,   re_version,
re_secuencial,    rd_pregunta,     (select pr_descripcion from cr_pregunta where pr_pregunta=rd_pregunta),
rd_respuesta
from  cob_credito..cr_respuestas ,cob_credito..cr_respuestas_det 
where re_secuencial=rd_secuencial
and  re_fecha =  @i_fecha 


if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_encuestas'
   goto ERROR
end

/* Clientes prospecto_contraoferta */
insert into cob_externos..ex_prospecto_contraoferta (
pr_cliente,  pr_operacion, pr_fecha_proceso)
select
pr_cliente,  pr_operacion, pr_fecha_proceso
from cob_credito..cr_prospecto_contraoferta
where pr_fecha_proceso = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_prospecto_contraoferta'
   goto ERROR
end

/*FIN  REQ. 300*/

/* DATO TRAMITE */
insert into cob_externos..ex_dato_tramite (
dt_aplicativo, dt_fecha,               dt_tramite,     
dt_tipo,       dt_truta,               dt_fecha_creacion,
dt_mercado,    dt_tipo_credito,        dt_sujcred,
dt_clase,      dt_cliente,             dt_oficina,
dt_fuente_recurso, dt_banco,           dt_campana,     -- GAL 10/AGO/2010 - OMC (dt_cliente_nuevo)
dt_alianza,    dt_autoriza_central,    dt_negado_mir,
dt_num_devri) -- JTC Req 353
select 
@w_aplicativo, @i_fecha,               tr_tramite,     
tr_tipo,       tr_truta,               tr_fecha_crea,
tr_mercado,    (case tr_tipo_credito when 'N' then 'S' else 'N' end),tr_sujcred,        -- GAL 10/AGO/2010 - OMC (case)
tr_clase,      tr_cliente,             tr_oficina,
tr_fuente_recurso, tr_numero_op_banco, tr_campana,
tr_alianza,                            tr_autoriza_central,      -- JTC Req 353
tr_negado_mir,                         tr_num_devri
from  #tramite_proceso_nuevo, cr_tramite
where tramite = tr_tramite

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_tramite'
   goto ERROR
end

/****LC Req 368 28/08/2013****/
update cob_externos..ex_dato_tramite
set dt_cliente = de_cliente
from cob_credito..cr_deudores 
where  dt_tramite = de_tramite 
and    de_rol = 'D'
/**** FIN LC Req 368 28/08/2013****/

/* DATO SITUACION TRAMITE */    
insert into cob_externos..ex_dato_tramite_sit (
ts_fecha,            ts_tramite,             ts_estado,
ts_tipo_cuota,       ts_tipo_plazo,          ts_plazo,
ts_oficina,          ts_oficial,             ts_ciudad,
ts_monto,            ts_fecha_concesion,     ts_toperacion,
ts_aplicativo,       ts_cuota_aprox,
ts_cant_benef_seg, 
ts_tasa_op,
/* INI - GAL 01/AGO/2010 - OMC */
ts_mercado_objetivo, ts_sujcred,             ts_fecha_apr,
ts_banco           , ts_funcionario                           --LC Req 368 28/08/2013 (ts_funcionario)
/* FIN - GAL 10/AGO/2010 - OMC */
)
SELECT    
@i_fecha,            tr_tramite,             tr_estado,
tr_tipo_cuota,       tr_tipo_plazo,          tr_plazo,
tr_oficina,          tr_oficial,             tr_ciudad,
tr_monto_solicitado, tr_fecha_concesion,     tr_toperacion,
@w_aplicativo,       isnull(tr_cuota_aproximada, 0),
(select count(1) from cr_benefic_micro_aseg, cr_microempresa where mi_tramite = T.tr_tramite and mi_secuencial = bm_microseg), -- cant beneficiarios
case 
   when tr_tipo in ('E', 'O', 'R') then 
      (select avg(ro_porcentaje_efa) from cob_cartera..ca_operacion,  cob_cartera..ca_rubro_op where op_tramite = T.tr_tramite and ro_operacion = op_operacion and ro_tipo_rubro = 'I') 
   else 0 
end,
/* INI - GAL 01/AGO/2010 - OMC */
tr_mercado_objetivo, tr_sujcred,             tr_fecha_apr,
tr_numero_op_banco , tr_usuario_apr                            --LC Req 368 28/08/2013 (tr_usuario)
/* FIN - GAL 10/AGO/2010 - OMC */
from  #tramite_proceso, cr_tramite T
where tramite = tr_tramite

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_tramite_sit'
   goto ERROR
end

/* Ticket 0140685: Se actualiza con el ultimo usuario que realizo una modificacion sobre el tramite en el dia de generacion*/
select
tt_tramite    = b.tramite,
tt_fecha      = b.fecha,
tt_secuencial = b.secuencial,
tt_usuario    = b.usuario
into #ts_tramite
from cob_externos.dbo.ex_dato_tramite_sit a inner join cob_credito..ts_tramite b on a.ts_tramite = b.tramite

select
ff_tramite    = tt_tramite,
ff_secuencial = tt_secuencial,
ff_usuario    = tt_usuario
into   #FuncionarioFecha
from   #ts_tramite
where  tt_fecha = @i_fecha

update cob_externos..ex_dato_tramite_sit
set    ts_funcionario = usuario
from   cob_credito..ts_tramite 
where  ts_tramite = tramite
and    secuencial = (select MAX(ff_secuencial) from #FuncionarioFecha where ts_tramite = ff_tramite)  

/* DATO RUTA */
insert into cob_externos..ex_dato_ruta (
dr_fecha,       dr_tramite,             dr_secuencia,           dr_truta,
dr_paso,        dr_etapa,               dr_estacion,            dr_llegada,
dr_estado,      dr_prioridad,           dr_aplicativo,          dr_comite, 
dr_funcionario)
SELECT    
@i_fecha,       rt_tramite,             rt_secuencia,           rt_truta,
rt_paso,        rt_etapa,               rt_estacion,            rt_llegada,
rt_estado,      rt_prioridad,           @w_aplicativo,          rt_comite,
(select max(fu_funcionario) from cr_estacion, cobis..cl_funcionario where es_estacion = RT.rt_estacion and es_usuario = fu_login)
from  #tramite_proceso, cr_ruta_tramite RT
where rt_tramite  = tramite
and   rt_llegada >= @i_fecha 
and   rt_llegada  < dateadd(dd, 1, @i_fecha)

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_ruteo'
   goto ERROR
end


/* DATO MICROEMPRESA */
insert into cob_externos..ex_dato_microempresa (
dm_fecha,            dm_aplicativo,                  dm_id_microempresa,     
dm_nombre,           dm_descripcion)
SELECT 
@i_fecha,            @w_aplicativo,                  mi_identificacion,      
max(mi_nombre), max(mi_descripcion)
from  cr_microempresa, #tramite_proceso_nuevo
where mi_tramite = tramite
and   mi_identificacion not in (select mi_identificacion from cr_microempresa, cr_tramite
                                where mi_tramite = tr_tramite and tr_fecha_crea < @i_fecha)

group by mi_identificacion

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_microempresa'
   goto ERROR
end

/* DATO SITUACION MICROEMPRESA */
insert into cob_externos..ex_dato_microempresa_sit (
ms_fecha,               ms_id_microempresa,     ms_tramite,             
ms_tipo_local,          ms_tipo_empresa,        ms_dias_trabajados,     
ms_num_trbjdr_remu,     ms_num_trbjdr_no_remu,  ms_aplicativo,
ms_microempresa,
ms_fecha_apertura,      -- Fecha Apertura de Microempresa
ms_fini_posesion,       -- Antiguedad, Fecha de posesion de la microempresa 
ms_fini_experiencia,    -- Experiencia del cliente en el negocio
ms_fini_abr_econ,       -- Fecha inicio Actividad Economica de la microempresa
ms_decl_jurada,         -- Total de la declaracion Jurada
ms_actividad)           -- Profesion del deudor principal   
SELECT 
@i_fecha,               mi_identificacion,      mi_tramite,             
mi_local,               mi_tipo_empresa,        mi_dias_trabajados,     
mi_num_trabaj_remu,     mi_num_trabaj_no_remu,  @w_aplicativo,
mi_secuencial,          mi_antiguedad,          mi_antiguedad,          
mi_experiencia,         mi_antiguedad,          
isnull((select sum(dj_total_bien) from cr_dec_jurada where dj_codigo_mic = M.mi_secuencial),0),
(select max(p_profesion) from cobis..cl_ente, cob_credito..cr_deudores where de_tramite = M.mi_tramite and en_ente = de_cliente and de_rol = 'D')
from  #tramite_proceso, cr_microempresa M
where tramite = mi_tramite

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_microempresa_sit'
   goto ERROR
end


/* DATO INFORMACION FINANCIERA */
insert into cob_externos..ex_dato_bal_fnciero (
bf_fecha,               bf_aplicativo,          bf_tramite,             bf_sec_balance,             
bf_nivel1,              bf_nivel2,              bf_nivel3,              bf_nivel4,              
bf_sumatoria,           bf_total,               bf_descripcion,         bf_nivel,               
bf_actualizado,         bf_microempresa,        bf_id_microempresa)
select 
@i_fecha,               @w_aplicativo,          if_tramite,             if_codigo,              
if_nivel1,              if_nivel2,              if_nivel3,              if_nivel4,              
if_sumatoria,           if_total,               if_descripcion,         if_nivel,               
if_actualizado,         if_microempresa,
(select min(mi_identificacion) from cr_microempresa where mi_tramite = I.if_tramite)
from  #tramite_proceso, cr_inf_financiera I
where tramite = if_tramite
and   estado in ('Z', 'A')

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_bal_fnciero'
   goto ERROR
end

/* DATO DETALLE INFORMACION FINANCIERA */
insert into cob_externos..ex_dato_bal_fnciero_det (
bd_fecha,               bd_aplicativo,          bd_tramite,             bd_sec_balance,
bd_codigo_var,          bd_secuencial,          bd_tipo,                bd_decl_jur,            
bd_microempresa,        bd_valor,               bd_id_microempresa)
select 
@i_fecha,               @w_aplicativo,          if_tramite,             dif_inf_fin,
dif_codigo_var,         dif_secuencial,         dif_tipo,               dif_decl_jur,
dif_microempresa,
isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), ''),
(select min(mi_identificacion) from cr_microempresa where mi_tramite = I.if_tramite)
from  cr_det_inf_financiera, #tramite_proceso, cr_inf_financiera I
where tramite         = if_tramite
and   estado         in ('Z', 'A')
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_bal_fnciero_det'
   goto ERROR
end

/* DATO COSTO TIPO MERCANCIA */
insert into cob_externos..ex_dato_bal_resultado (
br_fecha,               br_secuencial,          br_costo_mercancia,
br_aplicativo,          br_producto,            br_ventas,
br_part_ventas,         br_costo,               br_costo_pond,
br_precio_unidad,       br_unidad_prod,         br_precio_venta,
br_costo_var,           br_tipo_costo,          br_id_microempresa,
br_tramite,             br_microempresa)
select 
@i_fecha,               ct_secuencial,          ct_costo_mercancia,
@w_aplicativo,          ct_producto,            ct_ventas,
ct_part_ventas,         ct_costo,               ct_costo_pond,
ct_precio_unidad,       ct_unidad_prod,         ct_precio_venta,
ct_costo_var,           ct_tipo_costo,          mi_identificacion,
tramite,                ct_secuencial
from  #tramite_proceso, cr_costo_tipo, cr_microempresa
where tramite         = mi_tramite
and   estado         in ('Z', 'A')
and   ct_microempresa = mi_secuencial

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_bal_resultado'
   goto ERROR
end

-- Aplica para Control 120 

/** DATO RESPUESTA ENCUESTA MIR **/
insert into cob_externos..ex_dato_encuesta_resp (
er_fecha,               er_aplicativo,          er_tramite,             
er_pregunta,            er_respuesta)
select 
@i_fecha,               @w_aplicativo,          re_tramite,             
re_pregunta,            re_respuesta
from  #tramite_proceso, cr_respuesta_mir
where tramite         = re_tramite
and   estado         in ('Z', 'A')
and   re_respuesta   is not null

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_encuesta_resp'
   goto ERROR
end

/** DATO PREGUNTA ENCUESTA MIR **/
if exists(select 1 from cob_credito..cr_tran_servicio 
where ts_tipo_transaccion = @w_trn_prg 
and   ts_fecha = @i_fecha)
begin
   insert into cob_externos..ex_dato_encuesta_preg (
   ep_fecha,               ep_aplicativo,          ep_pregunta,            ep_texto,               
   ep_tipo_resp,           ep_catalogo,            ep_estado,              ep_identificador,
   ep_tipo,                ep_subtipo_m)
   select 
   @i_fecha,               @w_aplicativo,          pr_pregunta,            pr_texto,               
   pr_tipo_resp,           pr_catalogo,            pr_estado,              pr_identificador,
   pr_tipo,                pr_subtipo_m
   from cr_pa_pregunta_mir
   
   if @@error <> 0 begin
      select 
      @w_error = 2103047, 
      @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_encuesta_preg'
      goto ERROR
   end
end

/** DATO CAUSALES DE RECHAZO **/
insert into cob_externos..ex_dato_causa_rechazo (
cr_fecha,               cr_aplicativo,          cr_tramite,             
cr_causal,              cr_tipo)
select distinct
@i_fecha,               @w_aplicativo,          cr_tramite,             
cr_requisito,           cr_tipo
from  #tramite_proceso, cr_cau_tramite
where tramite         = cr_tramite
and   estado         in ('Z')
and cr_tipo = 'NEG'    --LC Req 368 28/08/2013

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_causa_rechazo'
   goto ERROR
end

-- INI - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010
insert into cob_externos..ex_variables_entrada_mir(
ve_fecha,                ve_fecha_cons,           ve_tramite,
ve_orden,                ve_tipo,                 ve_identificador,
ve_valor)
select
@i_fecha,                ve_fecha,                ve_tramite,
ve_orden,                ve_tipo,                 ve_identificador,
ve_valor
from cr_var_entrada_mir, cobis..cl_orden_consulta_ext
where oc_secuencial = ve_orden
and   oc_fecha_resp = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_variables_entrada_mir'
   goto ERROR
end


insert into cob_externos..ex_respuestas_variables_mir(
rv_fecha,                rv_tramite,              rv_variable,
rv_valor,                rv_fecha_resp,           rv_orden)
select
@i_fecha,                rm_tramite,              rm_variable,
rm_valor,                rm_fecha_resp,           rm_orden
from cr_respuesta_mir_ws, cobis..cl_orden_consulta_ext
where oc_secuencial = rm_orden
and   oc_fecha_resp = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_respuestas_variables_mir'
   goto ERROR
end


insert into cob_externos..ex_micro_seguro(
ms_fecha,                ms_secuencial,           ms_tramite,
ms_plazo,                ms_director_ofic,        ms_vendedor,
ms_estado,               ms_fecha_ini,            ms_fecha_fin,
ms_fecha_envio,          ms_cliente_aseg,         ms_valor,
ms_pagado,               ms_fecha_mod,            ms_usuario_mod)
select 
@i_fecha,                ms_secuencial,           ms_tramite,
ms_plazo,                ms_director_ofic,        ms_vendedor,
ms_estado,               ms_fecha_ini,            ms_fecha_fin,
ms_fecha_envio,          ms_cliente_aseg,         ms_valor,
ms_pagado,               ms_fecha_mod,            ms_usuario_mod
from cr_micro_seguro
where ms_fecha_mod = @i_fecha
union all
select 
@i_fecha,                ms_secuencial,           ms_tramite,
ms_plazo,                ms_director_ofic,        ms_vendedor,
ms_estado,               ms_fecha_ini,            ms_fecha_fin,
ms_fecha_envio,          ms_cliente_aseg,         ms_valor,
ms_pagado,               ms_fecha_mod,            ms_usuario_mod
from cr_micro_seguro_his
where ms_fecha_mod = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_micro_seguro'
   goto ERROR
end

select distinct ms_secuencial 
into #micro_seguro
from cob_externos..ex_micro_seguro

insert into cob_externos..ex_aseg_microseguro(
am_fecha,                am_microseg,             am_secuencial,
am_tipo_iden,            am_tipo_aseg,            am_lugar_exp,
am_identificacion,       am_nombre_comp,          am_fecha_exp,
am_fecha_nac,            am_genero,               am_lugar_nac,
am_estado_civ,           am_ocupacion,            am_parentesco,
am_direccion,            am_derecho_acrec,        am_plan,
am_valor_plan,           am_telefono,             am_observaciones,
am_principal)
select 
@i_fecha,                am_microseg,             am_secuencial,
am_tipo_iden,            am_tipo_aseg,            am_lugar_exp,
am_identificacion,       am_nombre_comp,          am_fecha_exp,
am_fecha_nac,            am_genero,               am_lugar_nac,
am_estado_civ,           am_ocupacion,            am_parentesco,
am_direccion,            am_derecho_acrec,        am_plan,
am_valor_plan,           am_telefono,             am_observaciones,
am_principal
from cr_aseg_microseguro, #micro_seguro
where am_microseg = ms_secuencial
union all
select 
@i_fecha,                am_microseg,             am_secuencial,
am_tipo_iden,            am_tipo_aseg,            am_lugar_exp,
am_identificacion,       am_nombre_comp,          am_fecha_exp,
am_fecha_nac,            am_genero,               am_lugar_nac,
am_estado_civ,           am_ocupacion,            am_parentesco,
am_direccion,            am_derecho_acrec,        am_plan,
am_valor_plan,           am_telefono,             am_observaciones,
am_principal
from cr_aseg_microseguro_his, #micro_seguro
where am_microseg = ms_secuencial

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_aseg_microseguro'
   goto ERROR
end


insert into cob_externos..ex_benefic_micro_aseg(
bm_fecha,                bm_microseg,             bm_asegurado,
bm_secuencial,           bm_tipo_iden,            bm_identificacion,
bm_nombre_comp,          bm_fecha_nac,            bm_genero,
bm_lugar_nac,            bm_estado_civ,           bm_ocupacion,
bm_parentesco,           bm_direccion,            bm_telefono,
bm_porcentaje)
select 
@i_fecha,                bm_microseg,             bm_asegurado,
bm_secuencial,           bm_tipo_iden,            bm_identificacion,
bm_nombre_comp,          bm_fecha_nac,            bm_genero,
bm_lugar_nac,            bm_estado_civ,           bm_ocupacion,
bm_parentesco,           bm_direccion,            bm_telefono,
bm_porcentaje
from cr_benefic_micro_aseg, #micro_seguro
where bm_microseg = ms_secuencial
union all
select 
@i_fecha,                bm_microseg,             bm_asegurado,
bm_secuencial,           bm_tipo_iden,            bm_identificacion,
bm_nombre_comp,          bm_fecha_nac,            bm_genero,
bm_lugar_nac,            bm_estado_civ,           bm_ocupacion,
bm_parentesco,           bm_direccion,            bm_telefono,
bm_porcentaje
from cr_benefic_micro_aseg_his, #micro_seguro
where bm_microseg = ms_secuencial

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_benefic_micro_aseg'
   goto ERROR
end


insert into cob_externos..ex_enfermedades(
en_fecha,                en_microseg,             en_asegurado,
en_enfermedad)
select 
@i_fecha,                en_microseg,             en_asegurado,
en_enfermedad
from cr_enfermedades, #micro_seguro
where en_microseg = ms_secuencial
union all
select 
@i_fecha,                en_microseg,             en_asegurado,
en_enfermedad
from cr_enfermedades_his, #micro_seguro
where en_microseg = ms_secuencial

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_enfermedades'
   goto ERROR
end


insert into cob_externos..ex_filtros(
fi_fecha,                fi_filtro,               fi_descripcion,
fi_tipo_persona,         fi_etapa)
select 
@i_fecha,                fi_filtro,               fi_descripcion,
fi_tipo_persona,         fi_etapa
from cr_filtros

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_filtros'
   goto ERROR
end

---Inicio MAL04282011 ---

insert into cob_externos..ex_ruta_filtros(
rf_fecha,                rf_ruta,               rf_descripcion,
rf_estado)
select 
@i_fecha,                rf_ruta,               rf_descripcion,
rf_estado
from cr_ruta_filtros

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_ruta_filtros'
   goto ERROR
end

insert into cob_externos..ex_pasos_filtros(
pf_fecha,                pf_ruta,               pf_paso,
pf_etapa)
select 
@i_fecha,                pf_ruta,               pf_paso,
pf_etapa
from cr_pasos_filtros

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_pasos_filtros'
   goto ERROR
end

---Fin MAL04282011 ---

insert into cob_externos..ex_def_variables_filtros(
df_fecha,                df_variable,             df_descripcion,
df_programa,             df_tipo_var,             df_tipo_dato,
df_estado)
select 
@i_fecha,                df_variable,             df_descripcion,
df_programa,             df_tipo_var,             df_tipo_dato,
df_estado
from cr_def_variables_filtros

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_def_variables_filtros'
   goto ERROR
end


insert into cob_externos..ex_variables_filtros(
vf_fecha,                vf_filtro,               vf_variable,
vf_condicion,            vf_operador,             vf_valor_referencial,
vf_puntaje)
select 
@i_fecha,                vf_filtro,               vf_variable,
vf_condicion,            vf_operador,             vf_valor_referencial,
vf_puntaje
from cr_variables_filtros

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_variables_filtros'
   goto ERROR
end

insert into cob_externos..ex_valor_variables_filtros(
vv_fecha,                vv_ruta,                 vv_etapa,
vv_filtro,               vv_ente,                 vv_tramite,
vv_paso,                 vv_variable,             vv_valor_obtenido,
vv_valor_modificado,     vv_fecha_ult_modif,      vv_login,
vv_dictamen,             vv_dictamen_final )
select 
@i_fecha,                vv_ruta,                 vv_etapa,
vv_filtro,               vv_ente,                 vv_tramite,
vv_paso,                 vv_variable,             vv_valor_obtenido,
vv_valor_modificado,     vv_fecha_ult_modif,      vv_login,
vv_dictamen,             vv_dictamen_final
from cr_valor_variables_filtros
where vv_fecha_ult_modif = @i_fecha

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_valor_variables_filtros'
   goto ERROR
end
-- FIN - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010

------------------------------------------------------------------------
/*INSERTO LOS DATOS COMO PROCESADOS*/
/* CALCULA LOS TRAMITES SIN DUPLICADOS*/
insert into cr_consolidador_tramite
select @i_fecha, tt_tramite, 'P'
from   cr_consolidador_tramite_tmp, cr_tramite
where  tt_fecha   =  @i_fecha
and    tt_tramite = tr_tramite

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cr_consolidador_tramite'
   goto ERROR
end

------------------------------------------------------------------------
/* DATO COBRANZA */
create table #acuerdo (
ac_banco        varchar(24)     not null, 
ac_cobranza     varchar(10)     not null)
create nonclustered index idx1 on #acuerdo (ac_cobranza)

create table #gestion (
ge_banco        varchar(24)     not null, 
ge_cobranza     varchar(10)     not null)
create nonclustered index idx1 on #gestion (ge_cobranza)

insert into  #acuerdo 
select distinct
ac_banco    = oc_num_operacion, 
ac_cobranza = oc_cobranza 
from  cr_acciones, cr_operacion_cobranza 
where ac_fecha    = @i_fecha 
and   ac_cobranza = oc_cobranza
and   ac_descripcion like '%ACUERDO%DE%PAGO%'

if @@error <> 0 
begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla #acuerdo'
   goto ERROR
end

insert into #gestion         
select distinct
ge_banco    = oc_num_operacion, 
ge_cobranza = oc_cobranza 
from   cr_gestion_cobro, cr_operacion_cobranza 
where  gc_fecha_ges = @i_fecha 
and    gc_op_banco  = oc_num_operacion
and    gc_carta in (
select c.codigo 
from   cobis..cl_catalogo c, cobis..cl_tabla t 
where  t.tabla  = 'cr_tipo_carta' 
and    t.codigo = c.tabla 
and    upper(c.valor) like '%CITAC%')        
     

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla #gestion'
   goto ERROR
end

insert into cob_externos..ex_dato_cobranza (
dc_fecha,               dc_aplicativo,          dc_cobranza,
dc_banco,               dc_estado,              dc_fecha_citacion,
dc_fecha_acuerdo,       
dc_ente_abogado) 
select 
@i_fecha,               @w_aplicativo,          co_cobranza,
ac_banco,               co_estado,              null,
@i_fecha,
(select min(ab_cliente) from cr_abogado where ab_abogado = C.co_abogado)
from  #acuerdo, cr_cobranza C
where ac_cobranza = co_cobranza
and   co_cobranza not in (select ge_cobranza from #gestion)

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_cobranza'
   goto ERROR
end

insert into cob_externos..ex_dato_cobranza (
dc_fecha,               dc_aplicativo,          dc_cobranza,
dc_banco,               dc_estado,              dc_fecha_citacion,
dc_fecha_acuerdo,       
dc_ente_abogado) 
select 
@i_fecha,               @w_aplicativo,          co_cobranza,
ge_banco,               co_estado,              @i_fecha,
null, 
(select min(ab_cliente) from cr_abogado where ab_abogado = C.co_abogado)
from  #gestion, cr_cobranza C
where ge_cobranza = co_cobranza
and   co_cobranza not in (select ac_cobranza from #acuerdo)

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_cobranza'
   goto ERROR
end

insert into cob_externos..ex_dato_cobranza (
dc_fecha,               dc_aplicativo,          dc_cobranza,
dc_banco,               dc_estado,              dc_fecha_citacion,
dc_fecha_acuerdo,       
dc_ente_abogado) 
select 
@i_fecha,               @w_aplicativo,          co_cobranza,
ac_banco,               co_estado,              @i_fecha,
@i_fecha,
(select min(ab_cliente) from cr_abogado where ab_abogado = C.co_abogado)
from  #gestion, cr_cobranza C, #acuerdo
where ge_cobranza = co_cobranza
and   ac_cobranza = co_cobranza

if @@error <> 0 begin
   select 
   @w_error = 2103047, 
   @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_cobranza'
   goto ERROR
end

-- INI - GAL 27/JUL/2010 - OMC
/* ACCIONES DE COBRANZA */
insert into cob_externos..ex_dato_acciones_cobranza(
ac_fecha,               ac_aplicativo,          ac_banco,
ac_cliente,             ac_cobranza,            ac_taccion,
ac_numero_acc,          ac_abogado,             ac_valor,
ac_descripcion )
select 
ac_fecha,               21,                     oc_num_operacion,
co_cliente,             ac_cobranza,            ac_taccion,
ac_numero,              ac_abogado,             ac_monto_compr,
ac_descripcion
from cr_acciones, cr_cobranza, cr_operacion_cobranza
where ac_fecha    = @i_fecha
and   co_cobranza = ac_cobranza
and   oc_cobranza = co_cobranza

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_dato_acciones_cobranza'
   goto ERROR
end
-- FIN - GAL 27/JUL/2010 - OMC


-- Inclusion paso a ex_calificacion_orig (control de cambio 260)

insert into cob_externos..ex_calificacion_orig(
cm_fecha,        cm_aplicativo,     cm_tramite,
cm_fecha_resp,   cm_calificacion,   cm_modo_calif,
cm_valor)
select 
@i_fecha,        @w_aplicativo,     cm_tramite,
cm_fecha_resp,   cm_calificacion,   cm_modo_calif, 
cm_valor
from cob_credito..cr_calificacion_orig, cob_cartera..ca_operacion, cobis..cl_parametro
where cm_tramite = op_tramite 
and   op_estado  in (1,2,4,9)
and   pa_nemonico = 'VIGOR' + op_banca
and   pa_producto = 'CRE'
and   datediff(mm, op_fecha_liq, @i_fecha) <= pa_int

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_calificacion_orig '
   goto ERROR
end


--ORS: 512

insert into cob_externos..ex_dato_linea (
dl_fecha,         dl_aplicativo,     dl_numero,
dl_num_banco,     dl_oficina,        dl_tramite,
dl_cliente,       dl_original,       dl_fecha_aprob,
dl_fecha_inicio,  dl_fecha_vto,      dl_rotativa,
dl_estado,        dl_moneda,         dl_monto,
dl_utilizado,     dl_reservado,      dl_usuario_mod,
dl_fecha_mod,     dl_plazo,          dl_tipo_plazo
)
select 
@i_fecha,         @w_aplicativo,     li_numero,
li_num_banco,     li_oficina,        li_tramite,
li_cliente,       li_original,       li_fecha_aprob,
li_fecha_inicio,  li_fecha_vto,      li_rotativa,
li_estado,        li_moneda,         li_monto,
li_utilizado,     li_reservado,      li_usuario_mod,
li_fecha_mod,     li_plazo,          li_tipo_plazo
from  #tramite_proceso, cr_linea 
where tramite = li_tramite

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_dato_linea '
   goto ERROR
end

insert into cob_externos..ex_dato_lin_ope_moneda (
dm_fecha,          dm_aplicativo,     dm_linea,
dm_toperacion,     dm_producto,       dm_moneda,
dm_monto,          dm_utilizado,      dm_tplazo,
dm_plazos,         dm_reservado
)
select 
@i_fecha,          @w_aplicativo,     om_linea,
om_toperacion,     om_producto,       om_moneda,
om_monto,          om_utilizado,      om_tplazo,
om_plazos,         om_reservado
from  #tramite_proceso, cob_credito..cr_linea, cob_credito..cr_lin_ope_moneda
where tramite   = li_tramite
and   li_numero = om_linea

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_dato_lin_ope_moneda '
   goto ERROR
end 


--Req 230 Cartas de Mora
insert into cob_externos..ex_impresion_cartas(
ic_fecha_proceso,    ic_aplicativo,      ic_no_operacion,     ic_nombre_cliente,
ic_zona,             ic_oficina,         ic_carta,            ic_reimpresiones,  
ic_saldo_vencido,    ic_saldo_capital,   ic_saldo_total,      ic_altura_mora)
select
@i_fecha,            @w_aplicativo,      ic_no_operacion,     ic_nombre_cliente,
ic_zona,             ic_oficina,         ic_carta,            ic_reimpresiones,  
ic_saldo_vencido,    ic_saldo_capital,   ic_saldo_total,      ic_altura_mora
from cob_credito..cr_impresion_cartas

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_impresion_cartas '
   goto ERROR
end

--REQ: 366

insert into cob_externos..ex_seguros_tramite (
st_fecha,                st_aplicativo,               st_secuencial_seguro,        
st_tipo_seguro,          st_tramite,                  st_vendedor,
st_cupo,                 st_origen
)
select 
@i_fecha,                @w_aplicativo,               st_secuencial_seguro,        
st_tipo_seguro,          st_tramite,                  st_vendedor,
st_cupo,                 st_origen
from cob_credito..cr_seguros_tramite, cob_cartera..ca_operacion
where st_tramite         = op_tramite
and   op_fecha_liq       = @i_fecha

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_seguros_tramite '
   goto ERROR
end

insert into cob_externos..ex_asegurados (
as_fecha,             as_aplicativo,         as_secuencial_seguro,
as_sec_asegurado,     as_tipo_aseg,          as_apellidos,
as_nombres,           as_tipo_ced,           as_ced_ruc,
as_lugar_exp,         as_fecha_exp,          as_ciudad_nac,
as_fecha_nac,         as_sexo,               as_estado_civil,
as_parentesco,        as_ocupacion,          as_direccion,
as_telefono,          as_ciudad,             as_correo_elec,
as_celular,           as_correspondencia,    as_plan,
as_fecha_modif,       as_usuario_modif,      as_observaciones,
as_act_economica,     as_ente
)
select 
@i_fecha,             @w_aplicativo,         as_secuencial_seguro,
as_sec_asegurado,     as_tipo_aseg,          as_apellidos,
as_nombres,           as_tipo_ced,           as_ced_ruc,
as_lugar_exp,         as_fecha_exp,          as_ciudad_nac,
as_fecha_nac,         as_sexo,               as_estado_civil,
as_parentesco,        as_ocupacion,          as_direccion,
as_telefono,          as_ciudad,             as_correo_elec,
as_celular,           as_correspondencia,    as_plan,
as_fecha_modif,       as_usuario_modif,      as_observaciones,
as_act_economica,     as_ente
from cob_credito..cr_seguros_tramite, cob_credito..cr_asegurados, cob_cartera..ca_operacion
where st_tramite             = op_tramite
and   op_fecha_liq           = @i_fecha
and   st_secuencial_seguro   = as_secuencial_seguro

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_asegurados '
   goto ERROR
end

insert into cob_externos..ex_beneficiarios  (
be_fecha,             be_aplicativo,         be_secuencial_seguro,
be_sec_asegurado,     be_sec_benefic,        be_apellidos,
be_nombres,           be_tipo_ced,           be_ced_ruc,
be_lugar_exp,         be_fecha_exp,          be_ciudad_nac,
be_fecha_nac,         be_sexo,               be_estado_civil,
be_parentesco,        be_ocupacion,          be_direccion,
be_telefono,          be_ciudad,             be_correo_elec,
be_celular,           be_correspondencia,    be_fecha_modif,
be_usuario_modif,     be_porcentaje,         be_ente
)
select 
@i_fecha,             @w_aplicativo,         be_secuencial_seguro,
be_sec_asegurado,     be_sec_benefic,        be_apellidos,
be_nombres,           be_tipo_ced,           be_ced_ruc,
be_lugar_exp,         be_fecha_exp,          be_ciudad_nac,
be_fecha_nac,         be_sexo,               be_estado_civil,
be_parentesco,        be_ocupacion,          be_direccion,
be_telefono,          be_ciudad,             be_correo_elec,
be_celular,           be_correspondencia,    be_fecha_modif,
be_usuario_modif,     be_porcentaje,         be_ente
from cob_credito..cr_seguros_tramite, cob_credito..cr_asegurados, cob_credito..cr_beneficiarios, cob_cartera..ca_operacion 
where st_tramite             = op_tramite
and   op_fecha_liq           = @i_fecha
and   st_secuencial_seguro   = as_secuencial_seguro
and   as_secuencial_seguro   = be_secuencial_seguro
and   as_sec_asegurado       = be_sec_asegurado

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_beneficiarios  '
   goto ERROR
end

--CCA 486: ESTADISTICAS SEGUROS
insert into cob_externos..ex_seguros_estadistica  (
se_fecha,             se_tipo_seguro,
se_tipo_seg_desc,     se_codigo_plan,        se_cod_plan_desc,
se_certificado,       se_antiguedad,         se_oficina,
se_zona,              se_of_nombre,          se_banco,
se_identif_vend,      se_codigo_vend,        se_nombre_vend,
se_fecha_venta,       se_fecha_desde,        se_fecha_hasta,
se_identif_cli,       se_tipo_doc_cli,       se_nombre_cli,
se_monto_aseg,        se_prima_total,        se_prima_mensual)
select 
@i_fecha,             se_tipo_seguro,
se_tipo_seg_desc,     se_codigo_plan,        se_cod_plan_desc,
se_certificado,       se_antiguedad,         se_oficina,
se_zona,              se_of_nombre,          se_banco,
se_identif_vend,      se_codigo_vend,        se_nombre_vend,
se_fecha_venta,       se_fecha_desde,        se_fecha_hasta,
se_identif_cli,       se_tipo_doc_cli,       se_nombre_cli,
se_monto_aseg,        se_prima_total,        se_prima_mensual
from cob_credito..cr_seguros_estadistica
where se_fecha      = @i_fecha

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_seguros_estadistica  '
   goto ERROR
end

insert into cob_externos..ex_asegurados_estadistica  (
ae_fecha,         ae_certificado,
ae_tipo_doc,      ae_identif,            ae_nombre,
ae_genero,        ae_fecha_nac,          ae_fecha_venta)
select 
@i_fecha,         ae_certificado,
ae_tipo_doc,      ae_identif,            ae_nombre,
ae_genero,        ae_fecha_nac,          ae_fecha_venta
from cob_credito..cr_asegurados_estadistica
where ae_fecha = @i_fecha

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_asegurados_estadistica  '
   goto ERROR
end
--FIN CCA 486

--AAMG --353 Alianzas Comerciales
insert into cob_externos..ex_msv_proc_cr (
mp_fecha,          mp_aplicativo,
mp_id_carga,       mp_id_Alianza,  mp_cedula,
mp_tipo_ced,       mp_oficial,     mp_tramite,
mp_tipo,           mp_estado,      mp_ruta,
mp_etapa,          mp_estacion,    mp_ejecutivo,
mp_descripcion
)
select 
@i_fecha,          @w_aplicativo,      
mp_id_carga,       mp_id_Alianza,  mp_cedula,
mp_tipo_ced,       mp_oficial,     mp_tramite,
mp_tipo,           mp_estado,      mp_ruta,
mp_etapa,          mp_estacion,    mp_ejecutivo,
mp_descripcion
from  cob_credito..cr_msv_proc
where convert( varchar(10), mp_fecha_proc, 101) =  @i_fecha

if @@error <> 0
begin
   select 
   @w_error = 2103047, 
   @w_msg   = 'Error al Grabar en tabla cob_externos..ex_msv_proc_cr '
   goto ERROR
end

return 0

ERROR:
exec @w_return = sp_errorlog 
@i_fecha       = @i_fecha,
@i_error       = @w_error, 
@i_usuario     = @w_sp_name, 
@i_tran        = @i_proceso,
@i_tran_name   = @w_sp_name,
@i_descripcion = @w_msg,
@i_cuenta      = 'Masivo',
@i_rollback    = 'N'

if @w_return <> 0
   print 'ERROR EN SP_ERRORLOG'

return @w_error
go
