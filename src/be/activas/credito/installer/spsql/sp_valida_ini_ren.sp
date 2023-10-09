/************************************************************************/
/*  Archivo:                sp_valida_ini_ren.sp                        */
/*  Stored procedure:       sp_valida_ini_ren                           */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sonia Rojas                                 */
/*  Fecha de Documentacion: 12 Enero de 2020                            */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure programa de arranque, no inicia el flujo si el solicitante,*/
/* o algún integrante del grupo no es un cliente                        */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA          AUTOR                   RAZON                        */
/* 12/Ene/2021    S. Rojas    Emision Inicial                           */
/* 17/Dic/2021    ACH         ERR #169730, por pruebas de renovacion    */
/* **********************************************************************/
use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_valida_ini_ren')
begin
    drop procedure sp_valida_ini_ren
end
go

create procedure sp_valida_ini_ren
(
    @s_ssn                int          = null,
    @s_user               varchar(30)  = null,
    @s_sesn               int          = null,
    @s_term               varchar(30)  = null,
    @s_date               datetime     = null,
    @s_srv                varchar(30)  = null,
    @s_lsrv               varchar(30)  = null,
    @s_ofi                smallint     = null,
    @t_trn                int          = null,
    @t_debug              char(1)      = 'N',
    @t_file               varchar(14)  = null,
    @t_from               varchar(30)  = null,
    @s_rol                smallint     = null,
    @s_org_err            char(1)      = null,
    @s_error              int          = null,
    @s_sev                tinyint      = null,
    @s_msg                descripcion  = null,
    @s_org                char(1)      = null,
    @t_show_version       bit          = 0, -- Mostrar la version del programa
    @t_rty                char(1)      = null,
    @i_operacion          char(1)      = 'I',
    @i_login              login        = null,
    @i_id_proceso         smallint     = null,
    @i_version            smallint     = null,
    @i_nombre_proceso     varchar(100) = null,
    @i_id_actividad       int          = null,
    @i_campo_1            int          = null,
    @i_campo_2            varchar(255) = null,
    @i_campo_3            int          = null,
    @i_campo_4            varchar(10)  = null,
    @i_campo_5            int          = null,
    @i_campo_6            money        = null,
    @i_campo_7            varchar(255) = null,
    @i_ruteo              char(1)      = 'M',
    @i_ofi_inicio         smallint     = null,
    @i_ofi_entrega        smallint     = null,
    @i_ofi_asignacion     smallint     = null,
    @i_id_inst_act_padre  int          = null,
    @i_comentario         varchar(255) = null,
    @i_id_usuario         int          = null,
    @i_id_rol             int          = null,
    @i_id_empresa         smallint     = null,
    @i_inst_padre         int          = null,
    @i_inst_inmediato     int          = null,
    @i_vinculado          char(1)      = null,
    @o_siguiente          int          = null out

)As
declare
@w_sp_name                  varchar(64),
@w_est_vigente              int,
@w_est_cancelado            int,
@w_est_vencido              int,
@w_fecha_proceso            datetime,
@w_porc_transcurrido        float,
@w_porc_capital             float,
@w_max_atraso_ren           int,
@w_act_atraso_ren           int,
@w_ciclo_ren                int,
@w_error                    int,
@w_plazo                    int,
@w_fecha_ini                datetime,
@w_fecha_ven                datetime,
@w_pagado                   money,
@w_capital                  money,
@w_dias_atraso_act          int,
@w_dias_atraso_max          int,
@w_ciclo_grupal             int,
@w_banco_actual             varchar(30),
@w_grupo                    int,
@w_oficial_grupo            int,
@w_oficial_solicitud        int,
@w_op_ciclo_ant             int,
@w_op_ciclo_ant_vigentes    int

select @w_sp_name = 'sp_valida_ini_ren'

if @t_show_version = 1
begin
    print 'Stored procedure sp_valida_ini_ren, Version 1.0.0.0'
    return 0
end

print '@i_campo_1:'+convert(varchar, @i_campo_1)
print '@i_campo_2:'+convert(varchar, @i_campo_2)
print '@i_campo_3:'+convert(varchar, @i_campo_3)
print '@i_campo_4:'+convert(varchar, @i_campo_4)
print '@i_campo_5:'+convert(varchar, @i_campo_5)
print '@i_campo_6:'+convert(varchar, @i_campo_6)
print '@i_campo_7:'+convert(varchar, @i_campo_7)

select @w_grupo = @i_campo_1

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_porc_transcurrido = (isnull(pa_float, 80)/100)
from cobis..cl_parametro
where pa_nemonico          = 'PTRREN'

select @w_porc_capital     = (isnull(pa_float, 60)/100)
from cobis..cl_parametro
where pa_nemonico          = 'PCAREN'

select @w_max_atraso_ren   = isnull(pa_int, 30)
from cobis..cl_parametro
where pa_nemonico          = 'ATMREN'

select @w_act_atraso_ren   = isnull(pa_int, 0)
from cobis..cl_parametro
where pa_nemonico          = 'ATAREN'

select @w_ciclo_ren        = isnull(pa_int, 4)
from cobis..cl_parametro
where pa_nemonico          = 'CICREN'

exec @w_error     = cob_cartera..sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out

if @w_error <> 0 begin
   goto ERROR
end

if exists( select 1 from cobis..cl_grupo where gr_grupo=@w_grupo and gr_estado='C')
begin
   print 'Error: El Grupo tiene estado Cancelado'
   select @w_error = 103147
   goto ERROR
end

exec @w_error = cob_pac..sp_grupo_busin
@i_operacion  ='V',
@i_grupo      = @w_grupo,
@t_trn        = 800

if @w_error <> 0
begin
   select @w_error = 208925
   goto ERROR
end

/* Oficial diferente al del grupo ***/
select @w_oficial_grupo = gr_oficial
from cobis..cl_grupo
where gr_grupo = @w_grupo

select @w_oficial_solicitud = oc_oficial
from cobis..cc_oficial,cobis..cl_funcionario
where oc_funcionario = fu_funcionario
and fu_login = @s_user

if @w_oficial_grupo <> @w_oficial_solicitud
begin
   print 'La solicitud tiene otro oficial diferente al del grupo' 
   select @w_error = 101115
   goto ERROR
end  

if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_1 = @i_campo_1 and io_estado = 'EJE') begin
   select @w_error = 2108086
   goto ERROR
end

select  
@w_ciclo_grupal = isnull(max(dc_ciclo_grupo),0)
from cob_cartera..ca_det_ciclo 
where dc_grupo  = @w_grupo 
			
select * into #operaciones
from cob_cartera..ca_det_ciclo, cob_credito..cr_tramite_grupal
where dc_ciclo_grupo = @w_ciclo_grupal
and dc_grupo = @w_grupo
and dc_grupo = tg_grupo
and dc_referencia_grupal = tg_referencia_grupal
and tg_prestamo <> tg_referencia_grupal
and dc_operacion = tg_operacion
and dc_cliente = tg_cliente
and tg_monto > 0
and tg_participa_ciclo = 'S'

select @w_op_ciclo_ant = @@rowcount

select @w_op_ciclo_ant_vigentes = count(dc_operacion)
from   #operaciones, cob_cartera..ca_operacion op
where  dc_operacion   = op_operacion
and    dc_grupo       = @w_grupo
and    dc_ciclo_grupo = @w_ciclo_grupal
and    op_estado      = @w_est_vigente

if @w_op_ciclo_ant <> @w_op_ciclo_ant_vigentes begin
   select @w_error = 2108080
   goto ERROR
end

select
@w_fecha_ini        = min(di_fecha_ini),
@w_fecha_ven        = max(di_fecha_ven)
from   cob_cartera..ca_dividendo
where  di_operacion in (select dc_operacion from #operaciones)

print 'SEMANAS TRANSCURRIDAS:'+ CONVERT(VARCHAR, datediff(ww, @w_fecha_ini, @w_fecha_proceso))
print '% SEMANAS TOTALES :'+ CONVERT(VARCHAR,(datediff(ww, @w_fecha_ini, @w_fecha_ven  )  * @w_porc_transcurrido))

if datediff(ww, @w_fecha_ini, @w_fecha_proceso ) < (datediff(ww, @w_fecha_ini, @w_fecha_ven  )  * @w_porc_transcurrido) begin
   select @w_error = 2108081
   goto ERROR
end

select
@w_pagado  = sum(isnull(am_pagado,0)),
@w_capital = sum(am_cuota)
from cob_cartera..ca_amortizacion
where am_operacion in (select dc_operacion from #operaciones)
and   am_concepto  = 'CAP'

print 'PAGADO: '+ convert(varchar, @w_pagado)
print 'CAPITAL:'+CONVERT(VARCHAR, @w_capital)

if @w_pagado < (@w_capital * @w_porc_capital) begin
   select @w_error = 2108082
   goto ERROR
end

select @w_dias_atraso_act  = isnull(max(datediff(dd, di_fecha_ven, @w_fecha_proceso)),0)
from   cob_cartera..ca_dividendo
where  di_operacion in (select dc_operacion from #operaciones)
and    di_estado           = @w_est_vencido 

select @w_dias_atraso_act = case when @w_dias_atraso_act < 0 then 0 else @w_dias_atraso_act end

print '@w_dias_atraso_act:'+ convert(varchar, @w_dias_atraso_act)

if @w_dias_atraso_act > @w_act_atraso_ren begin
   select @w_error = 2108083
   goto ERROR
end

select
isnull(max(datediff(dd, di_fecha_ven, case when di_estado = 3 then di_fecha_can else @w_fecha_proceso end)), 0) as dias_atraso,
di_operacion as operacion,
di_dividendo as dividendo
into #atrasos
from   cob_cartera..ca_dividendo, #operaciones
where  di_operacion   = dc_operacion
and    di_fecha_can   > di_fecha_ven
group by di_operacion, di_dividendo


if not exists (select 1 from #atrasos) begin
   select @w_dias_atraso_max = 0
end else begin
   select @w_dias_atraso_max = max(dias_atraso)
   from #atrasos
   
   select @w_dias_atraso_max = case when @w_dias_atraso_max < 0 then 0 else @w_dias_atraso_max end
end

print '@w_dias_atraso_max:'+ convert(varchar, @w_dias_atraso_max)
if @w_dias_atraso_max > @w_max_atraso_ren begin
   select @w_error = 2108084
   goto ERROR
end

if @w_ciclo_grupal < @w_ciclo_ren begin
   select @w_error = 2108085
   goto ERROR
end

return 0

ERROR:

return @w_error

go
