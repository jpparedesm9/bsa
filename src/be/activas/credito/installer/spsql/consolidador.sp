/************************************************************************/
/*   Archivo:             consolidador.sp                               */
/*   Stored procedure:    sp_consolidador                               */
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
/*   Extraccion de datos de tramites para repositorio credito           */
/*   ENE-2015         Luis C. Moreno   RQ486-REPOSITORIO SEGUROS        */
/************************************************************************/

use cob_credito
go
 
if exists (select 1 from sysobjects where name = 'sp_consolidador')
   drop proc sp_consolidador
go

CREATE proc sp_consolidador
@i_param1               varchar(60)    = null,
@i_fecha                smalldatetime  = null

as declare
@w_error                int,
@w_sp_name              varchar(64),
@w_proceso              int,
@w_msg                  varchar(64),
@w_sig_habil            datetime,
@w_cantidad             int,
@w_ciudad               int,
@w_return               int,
@w_fin_mes              char(1),
@w_fecha_ini            datetime, 
@w_aplicativo           tinyint

SET ANSI_WARNINGS OFF
/* CARGADO DE VARIABLES DE TRABAJO */
select @w_sp_name = 'sp_consolidador'

/* APLICATIVO PARA CREDITO */
select @w_aplicativo = pd_producto 
from   cobis..cl_producto 
where  pd_abreviatura = 'CRE'

/*DETERMINAR LA FECHA DE PROCESO */
select @i_fecha = isnull(@i_param1, fc_fecha_cierre)
from  cobis..ba_fecha_cierre
where fc_producto = @w_aplicativo

create table #tramite (tramite   int   not null)
create unique nonclustered index idx1 on #tramite (tramite)

create table #tramite_error (
tramite      int             not null, 
procesar     char(1)         not null, 
error        int             not null, 
mensaje      varchar(255)    not null)

/* SELECCIONAR TRAMITES MODIFICADOS */
insert into #tramite
select distinct tramite
from   cob_credito..ts_tramite
where  fecha = @i_fecha

/* DATO SITUACION TRAMITE */
insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_tramite-TASA DE LA OPERACION ES NULL'        
from  #tramite, cr_tramite T
where tramite = tr_tramite
and   tr_tipo in ('O') 
and   (select avg(ro_porcentaje_efa) from cob_cartera..ca_operacion,  cob_cartera..ca_rubro_op where op_tramite = T.tr_tramite and ro_operacion = op_operacion and ro_tipo_rubro = 'I') is null
   
if @@error <> 0 
begin
   select 
   @w_error = 2103046, @w_msg = 'ERROR AL INGRESAR ERRORES DE TASA DE SITUACION TRAMITE (Original)'
   goto ERROR
end

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_tramite-TASA DE LA OPERACION ES NULL'        
from  #tramite, cr_tramite T
where tramite = tr_tramite
and   tr_tipo in ('E') 
and   (select avg(ro_porcentaje_efa) from cob_cartera..ca_operacion,  cob_cartera..ca_rubro_op where op_operacion = T.tr_numero_op  and ro_operacion = op_operacion and ro_tipo_rubro = 'I') is null
   
if @@error <> 0 
begin
   select 
   @w_error = 2103046, @w_msg = 'ERROR AL INGRESAR ERRORES DE TASA DE SITUACION TRAMITE (Reestructuracion)'
   goto ERROR
end

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_tramite-TASA DE LA OPERACION ES NULL'        
from  #tramite, cr_tramite T
where tramite = tr_tramite
and   tr_tipo in ('R') 
and   (select avg(ro_porcentaje_efa) from cob_credito..cr_op_renovar, cob_cartera..ca_operacion, cob_cartera..ca_rubro_op where T.tr_tramite = or_tramite and or_num_operacion = op_banco and op_operacion = ro_operacion and ro_tipo_rubro = 'I')  is null
   
if @@error <> 0 
begin
   select 
   @w_error = 2103046, @w_msg = 'ERROR AL INGRESAR ERRORES DE TASA DE SITUACION TRAMITE (Renovacion)'
   goto ERROR
end
/* DATO RUTA */
insert into #tramite_error(tramite, procesar, error, mensaje)
select distinct tramite, 'S', 2103046, 'cr_ruta_tramite-FUNCIONARIO NO EXISTE PARA LA ESTACION: ' + convert(varchar(10), rt_estacion)
from   #tramite, cr_ruta_tramite RT
where  rt_tramite  = tramite
and    rt_llegada >= @i_fecha 
and    rt_llegada  < dateadd(dd, 1, @i_fecha)
and   (select max(fu_funcionario) from cr_estacion, cobis..cl_funcionario where es_estacion = RT.rt_estacion and es_usuario = fu_login and es_tipo <> 'C') is null
   
if @@error <> 0 
begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE FUNCIONARIO DE ESTACION EN LA RUTA'
   goto ERROR
end

/* DATO MICROEMPRESA */
select mid = mi_identificacion, cant = count(1)   
into   #microempresa
from   #tramite, cr_microempresa    
where  tramite = mi_tramite
group  by mi_identificacion
having count(1) > 1

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_microempresa-MICROEMPRESA REPETIDA' 
from   #tramite, cr_microempresa
where  tramite = mi_tramite
and    mi_identificacion in (select mid from #microempresa)

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE MICROEMPRESAS DUPLICADAS'
   goto ERROR
end

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'N', 2103046, 'cr_microempresa-ID MICROEMPRESA NULL' 
from   #tramite, cr_microempresa
where  tramite = mi_tramite
and    mi_identificacion is null

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE ID DE MICROEMPRESAS NULL'
   goto ERROR
end

/* DATO SITUACION MICROEMPRESA */
insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_microempresa-MICROEMPRESA SIN DECLARACION JURADA'          
from  #tramite, cr_microempresa M
where tramite = mi_tramite   
and   (select sum(dj_total_bien) from cr_dec_jurada where dj_codigo_mic = M.mi_secuencial) is null   

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE MICROEMPRESAS SIN DECLARACION JURADA'
   goto ERROR
end

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'S', 2103046, 'cr_microempresa-MICROEMPRESA SIN ACTIVIDAD'       
from  #tramite, cr_microempresa M
where tramite = mi_tramite   
and  (select max(p_profesion) from cobis..cl_ente, cob_credito..cr_deudores where de_tramite = M.mi_tramite and en_ente = de_cliente and de_rol = 'D') is null   

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE MICROEMPRESAS SIN DECLARACION JURADA'
   goto ERROR
end

/* DATO INFORMACION FINANCIERA */
insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'N', 2103046, 'cr_inf_financiera-INFORMACION FINANCIERA SIN ID DE MICROEMPRESA'          
from  #tramite, cr_inf_financiera I
where tramite = if_tramite
and   (select min(mi_identificacion) from cr_microempresa where mi_tramite = I.if_tramite) is null

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE INFORMACION FINANCIERA SIN ID DE MICROEMPRESA'
   goto ERROR
end

/* DATO DETALLE INFORMACION FINANCIERA */
insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'N', 2103046, 'cr_inf_financiera_det-DETALLE INFORMACION FINANCIERA SIN ID DE MICROEMPRESA'          
from  cr_det_inf_financiera, #tramite, cr_inf_financiera I
where tramite         = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   (select min(mi_identificacion) from cr_microempresa where mi_tramite = I.if_tramite) is null

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE DETALLE INFORMACION FINANCIERA SIN ID DE MICROEMPRESA'
   goto ERROR
end

insert into #tramite_error(tramite, procesar, error, mensaje)
select tramite, 'N', 2103046, 'cr_inf_financiera_det-VALOR EN NULL'
from  cr_det_inf_financiera, #tramite, cr_inf_financiera I
where tramite         = if_tramite
and   if_microempresa = dif_microempresa
and   if_codigo       = dif_inf_fin
and   (isnull(dif_cadena, '') + isnull(convert(varchar(60), dif_money), '')+ isnull(convert(varchar(60),dif_entero), '') + isnull(convert(varchar(60), dif_float), '') + isnull(convert(varchar(60),dif_fecha), '')) is null

if @@error <> 0 begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES DE DETALLE INFORMACION FINANCIERA SIN ID DE MICROEMPRESA'
   goto ERROR
end

/** INSERTA EN LA ERRORLOG LOS ERRORES **/
select @w_proceso = ba_batch
from   cobis..ba_batch 
where  ba_arch_fuente = 'cob_credito..' + @w_sp_name

select @w_proceso = isnull(@w_proceso, 21999)

insert into cr_errorlog (er_fecha_proc, er_error, er_usuario, er_tran, er_cuenta, er_descripcion)
select distinct @i_fecha, error, @w_sp_name, @w_proceso, convert(varchar(24), tramite), mensaje
from   #tramite_error

  
if @@error <> 0 
begin
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INGRESAR ERRORES EN ERRORLOG'
   goto ERROR
end  

begin tran
/** BORRA TODOS LOS DATOS DE LAS TABLAS **/
delete cob_externos..ex_dato_deudores         where de_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO DEUDORES PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_tramite          where dt_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO TRAMITE PARA PROCESAMIENTO'
   goto ERROR
end

--Req 440
delete cob_externos..ex_repuntuacion        
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR REPUNTUACION'
   goto ERROR
end

delete cob_externos..ex_dato_tramite_sit      where ts_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO TRAMITE SIT PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_ruta             where dr_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO RUTA PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_microempresa     where dm_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO MICROEMPRESA PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_microempresa_sit where ms_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO MICROEMPRESA SIT PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_bal_fnciero      where bf_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO BAL FINANCIERO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_bal_fnciero_det  where bd_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO BAL FINANCIERO DET PARA PROCESAMIENTO'
   goto ERROR
end
delete cob_externos..ex_dato_bal_resultado    where br_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO BAL RESULTADO PARA PROCESAMIENTO'
   goto ERROR
end
-- Aplica para Control 120 
delete cob_externos..ex_dato_encuesta_resp where er_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ENCUESTA RESP PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_encuesta_preg where ep_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ENCUESTA PREG PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_cobranza         where dc_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO COBRANZA PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_dato_causa_rechazo    where cr_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO CAUSALES RECHZO PARA PROCESAMIENTO'
   goto ERROR
end
-- INI - GAL 12/AGO/2010 - OMC
delete cob_externos..ex_dato_acciones_cobranza where ac_aplicativo = @w_aplicativo
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ACCIONES COBRANZA PARA PROCESAMIENTO'
   goto ERROR
end
-- FIN - GAL 12/AGO/2010 - OMC

-- INI - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010 
delete cob_externos..ex_variables_entrada_mir
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO VARIABLES ENTRADA MIR PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_respuestas_variables_mir
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO RESPUESTA VARIABLES MIR PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_micro_seguro
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO MICROSEGURO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_aseg_microseguro
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ASEGURADO MICROSEGURO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_benefic_micro_aseg
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO BENEFICIARIO MICROSEGURO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_enfermedades
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ENFERMEDADES MICROSEGURO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO FILTRO PARA PROCESAMIENTO'
   goto ERROR
end

---Inicio MAL04282011 ---

delete cob_externos..ex_ruta_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR RUTA FILTRO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_pasos_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR PASOS FILTRO PARA PROCESAMIENTO'
   goto ERROR
end

---Fin MAL04282011 ---

delete cob_externos..ex_def_variables_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO DEFINICION VARIABLE FILTRO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_variables_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO VARIABLE FILTRO PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_valor_variables_filtros
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO VALOR VARIABLE FILTRO PARA PROCESAMIENTO'
   goto ERROR
end
-- FIN - REQ 184 - COMPLEMENTO REPOSITORIO - GAL 09/DIC/2010 

delete cr_consolidador_tramite where ct_fecha = @i_fecha
if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR CONSOLIDADOR TRAMITE PARA PROCESAMIENTO'
   goto ERROR
end

truncate table cob_externos..ex_calificacion_orig

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR ex_calificacion_orig'
   goto ERROR
end

--REQ 331 

truncate table cob_externos..ex_prospecto_contraoferta

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL BORRAR ex_prospecto_contraoferta'
   goto ERROR
end

truncate table cob_externos..ex_dato_gestion_campana

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL BORRAR ex_dato_gestion_campana'
   goto ERROR
end

truncate table cob_externos..ex_dato_encuestas	

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL BORRAR ex_dato_encuestas'
   goto ERROR
end

--ORS 512
truncate table cob_externos..ex_dato_linea

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR ex_dato_linea'
   goto ERROR
end

truncate table cob_externos..ex_dato_lin_ope_moneda

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR ex_dato_lin_ope_moneda'
   goto ERROR
end

--Req 0230 Cartas de Mora
truncate table cob_externos..ex_impresion_cartas

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR ex_impresion_cartas'
   goto ERROR
end


/** INSERTA LOS REGISTROS SIN ERROR **/
delete cr_consolidador_tramite_tmp
where  tt_fecha = @i_fecha

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR TRAMITES PARA PROCESAMIENTO'
   goto ERROR
end


insert into cr_consolidador_tramite_tmp
select @i_fecha, tramite
from   #tramite
where  tramite not in (select tramite from #tramite_error where procesar = 'N')

if @@error <> 0 
begin
   rollback tran        
   select 
   @w_error = 2103046, 
   @w_msg = 'ERROR AL INSERTAR TRAMITES PARA PROCESAMIENTO'
   goto ERROR
end     


--REQ: 366
delete cob_externos..ex_seguros_tramite
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO SEGUROS PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_asegurados
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ASEGURADOS SEGUROS PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_beneficiarios
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO BENEFICIARIOS SEGUROS PARA PROCESAMIENTO'
   goto ERROR
end

--CCA 486: ESTADISTICAS SEGUROS
delete cob_externos..ex_seguros_estadistica
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ESTADISTICAS SEGUROS PARA PROCESAMIENTO'
   goto ERROR
end

delete cob_externos..ex_asegurados_estadistica
if @@error <> 0 
begin
   rollback tran
   select 
   @w_error = 2107001, 
   @w_msg = 'ERROR AL BORRAR DATO ESTADISTICAS ASEGURADOS PARA PROCESAMIENTO'
   goto ERROR
end

--EJECUCION DEL SP_DATOS_CONSOLIDADOR 
exec @w_return = sp_datos_consolidador 
@i_fecha   = @i_fecha,
@i_proceso = @w_proceso

if @w_return <> 0 
begin
   while @@trancount > 0 rollback  
   select 
   @w_error = @w_return, 
   @w_msg = 'error en sp_datos_consolidador - '
   goto ERROR
end
commit tran

-- EJECUCION DEL SP_CONTINGENCIAS 
exec @w_return = sp_contingencias
@i_fecha = @i_fecha

if @w_return <> 0 
begin   
   select 
   @w_error = @w_return, 
   @w_msg = 'error en sp_contingencias - '
   goto ERROR
end     

return 0

ERROR:
exec sp_errorlog 
@i_fecha     = @i_fecha,
@i_error     = @w_error, 
@i_usuario   = @w_sp_name, 
@i_tran      = @w_proceso,
@i_tran_name = @w_sp_name,
@i_descripcion = @w_msg,
@i_cuenta    = 'Masivo',
@i_rollback  = 'N'

return @w_error
go

/*

select getdate()
exec sp_consolidador
@i_param1 = '2010/01/14'
select getdate()

select * from cr_consolidador_tramite_tmp 

*/
