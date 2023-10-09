/************************************************************************/
/*      Archivo:                lcr_pargen.sp                           */
/*      Stored procedure:       sp_lcr_parametros_generales             */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Nov/2018                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Genera preguntas de verificacion para recuperacion de clave     */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/* 21/Nov/2018           TBA              Emision Inicial               */
/* 10/Dic/2019           P. Ortiz         Corregir ejecuciión de reglas */
/* 29/Jul/2021           S. Rojas         #161141 LCR V2.0 Fase 2       */
/* 02/Sep/2021           A. Inca          #161141 Obtención parametros  */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_lcr_parametros_generales')
    drop proc sp_lcr_parametros_generales
go

create proc sp_lcr_parametros_generales(
@s_ssn           int          = null,
@s_sesn          int          = null,
@s_date          datetime     = null,
@s_user          login        = null,
@s_term          varchar(30)  = null,
@s_ofi           smallint     = null,
@s_srv           varchar(30)  = null,
@s_lsrv          varchar(30)  = null,
@s_rol           smallint     = null,
@s_org           varchar(15)  = null,
@s_culture       varchar(15)  = null,
@t_rty           char(1)      = null,
@t_debug         char(1)      = 'N',
@t_file          varchar(14)  = null,
@t_trn           smallint     = null,
@i_banco         cuenta,
@i_cliente       int,
@o_msg           varchar(200) = null output
)
as
declare
@w_sp_name                 varchar(25),
@w_tasa_iva                float,
@w_error                   int,
@w_tasa_referencial        varchar(20),
@w_sector                  catalogo,
@w_operacionca             int,
@w_valor_variable_regla    varchar(200), 
@w_msg                     varchar(200), 
@w_monto_min               varchar(200),
@w_monto_max               varchar(200),
@w_param_monto_min         money,
@w_param_incre_max         money,
@w_fecha_proceso           datetime,
@w_tramite                 int,
@w_inst_proceso            int,
@w_nro_ciclo               int,
@w_rl_id                   int,
@w_default_nivel_cliente   varchar(30),
@w_tipo_mercado            varchar(4),
@w_nivel_cliente           varchar(4)

select  @w_sp_name = 'sp_lcr_parametros_generales'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_param_monto_min = pa_money from cobis..cl_parametro where pa_nemonico = 'MINDIS'
select @w_param_incre_max = pa_money from cobis..cl_parametro where pa_nemonico = 'MAXDIS'
select @w_default_nivel_cliente = pa_char from cobis..cl_parametro where pa_nemonico = 'CDDFNC'

IF OBJECT_ID('tempdb..#tasas_comision') IS NOT NULL DROP TABLE #tasas_comision

create table #tasas_comision (
   valor_inicio   money,
   valor_fin      money,
   operador       varchar(30),
   porcentaje     float
)


select
@w_sector      = op_sector, 
@w_operacionca = op_operacion,
@w_tramite     = op_tramite
from ca_operacion
where op_banco    = @i_banco

if @@rowcount = 0 begin
   select 
   @w_error = 724617, 
   @o_msg   = 'ERROR: ESTE CLIENTE NO TIENE OPERACION REVOLVENTE'
   goto ERROR
end

select @w_tasa_referencial = ro_referencial
from cob_cartera..ca_rubro_op
where ro_operacion         = @w_operacionca
and ro_concepto            = 'IVA_INT'

select @w_tasa_iva = vd_valor_default
from ca_valor_det
where vd_tipo      = @w_tasa_referencial
and vd_sector      = @w_sector

if @@rowcount = 0 begin
   select 
   @w_error = 724669, 
   @o_msg   = 'ERROR: AL OBTENER LA TASA IVA'
   goto ERROR
end

PRINT 'Antes de la regla LCRMMUTI'
/* Se obtiene la Instancia de Proceso */
select @w_inst_proceso = io_id_inst_proc from cob_workflow..wf_inst_proceso where io_campo_3 = @w_tramite

exec @w_error     = cob_cartera..sp_ejecutar_regla
@s_ssn            = @s_ssn,
@s_ofi            = @s_ofi,
@s_user           = @s_user,
@s_date           = @w_fecha_proceso,
@s_srv            = @s_srv,
@s_term           = @s_term,
@s_rol            = @s_rol,
@s_lsrv           = @s_lsrv,
@s_sesn           = @s_ssn,
@i_regla          = 'LCRMMUTI', 
@i_tipo_ejecucion = 'WORKFLOW',	 
@i_id_inst_proc   = @w_inst_proceso,
@o_resultado1     = @w_monto_min out

if @w_error <> 0 or @w_monto_min is null
begin
   select @w_monto_min = convert(varchar,@w_param_monto_min)
END

PRINT 'Antes de la regla LCRVALINC'

exec @w_error     = cob_cartera..sp_ejecutar_regla
@s_ssn            = @s_ssn,
@s_ofi            = @s_ofi,
@s_user           = @s_user,
@s_date           = @w_fecha_proceso,
@s_srv            = @s_srv,
@s_term           = @s_term,
@s_rol            = @s_rol,
@s_lsrv           = @s_lsrv,
@s_sesn           = @s_ssn,
@i_regla          = 'LCRVALINC', 
@i_tipo_ejecucion = 'WORKFLOW',	 
@i_id_inst_proc   = @w_inst_proceso,
@o_resultado2     = @w_monto_max out

if @w_error <> 0
begin
   select @w_monto_max = convert(varchar,@w_param_incre_max)
end

PRINT 'Despues de la regla LCRVALINC'
select @w_rl_id = rl_id FROM cob_pac..bpl_rule WHERE rl_acronym = 'LCRPORCOM'

select 
@w_tipo_mercado  = ea_colectivo,
@w_nivel_cliente = ea_nivel_colectivo
from cobis..cl_ente_aux
where ea_ente = @i_cliente

select @w_nivel_cliente = isnull(@w_nivel_cliente, @w_default_nivel_cliente)

if @w_tipo_mercado is null begin
   if exists (select 1 from cob_cartera..ca_operacion 
              where op_cliente = @i_cliente
              and op_estado not in (0,6,99)) begin			  
      select @w_tipo_mercado = 'CC'
   end
   else begin
      select @w_tipo_mercado = 'I'
   end
END

PRINT 'Antes tasas'
print @w_tipo_mercado
print @w_nivel_cliente

insert into #tasas_comision
select 
cr3.cr_min_value as valor_inicio_1, 
cr3.cr_max_value as valor_fin_1,
cr3.cr_operator  as operador_1,
cr4.cr_max_value as porcentaje       
from  cob_pac..bpl_condition_rule cr1
inner join cob_pac..bpl_condition_rule cr2 on cr1.cr_id = cr2.cr_parent
inner join cob_pac..bpl_condition_rule cr3 on cr2.cr_id = cr3.cr_parent 
inner join cob_pac..bpl_condition_rule cr4 on cr3.cr_id = cr4.cr_parent  
where cr1.rv_id = (select max(rv_id) 
                   from cob_pac..bpl_rule_version 
                   where rl_id = 31
                   and rv_status = 'PRO')	
AND ((cr1.cr_max_value   = @w_tipo_mercado and cr1.cr_operator = '=') or  cr1.cr_operator  =  'cualquier valor')
AND ((cr2.cr_max_value   = @w_nivel_cliente and cr2.cr_operator = '=' )or cr2.cr_operator  = 'cualquier valor')
and cr4.cr_is_last_son = 'true'

select @w_tasa_iva, @w_monto_min

select 
valor_inicio,
valor_fin,
operador,
porcentaje
from #tasas_comision
order by valor_inicio

if @@rowcount = 0 begin
    select 
	@w_error = 724669, 
	@o_msg   = 'ERROR: AL OBTENER PORCENTAJE DE COMISION POR UTILIZACION'
	goto ERROR
end

return 0

ERROR:

		
return @w_error

go