use cob_credito
go
IF OBJECT_ID ('dbo.sp_var_porcentaje_utilizacion') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_porcentaje_utilizacion
GO
/************************************************************************/
/*  Archivo:                sp_var_por_uti.sp                           */
/*  Stored procedure:       sp_var_porcentaje_utilizacion               */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*Procedure  tipo  Variable,  Retorna tipo de mercado del cliente.      */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR               RAZON                               */
/*  08/11/18    ATO                 Emision Inicial                     */
/* **********************************************************************/

CREATE PROC sp_var_porcentaje_utilizacion(
   @s_ssn        int         = null,
   @s_ofi        smallint    = null,
   @s_user       login       = null,
   @s_date       datetime    = null,
   @s_srv		 varchar(30) = null,
   @s_term	     descripcion = null,
   @s_rol		 smallint    = null,
   @s_lsrv	     varchar(30) = null,
   @s_sesn	     int 	     = null,
   @s_org		 char(1)     = NULL,
   @s_org_err    int 	     = null,
   @s_error      int 	     = null,
   @s_sev        tinyint     = null,
   @s_msg        descripcion = null,
   @t_rty        char(1)     = null,
   @t_trn        int         = null,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   --variables
   @i_id_inst_proc    int,    --codigo de instancia del proceso
   @i_id_inst_act     int,    
   @i_id_asig_act     int,
   @i_id_empresa      int, 
   @i_id_variable     smallint )
AS
DECLARE 
@w_sp_name           varchar(32),
@w_return            int,
@w_tramite           int,
@w_operacionca       int,
@w_primer_div        int,
@w_ultimo_div        int,
@w_incrementos       money,
@w_cortes_evaluar    int,
@w_fecha_ini         datetime,
@w_fecha_fin         datetime,
@w_dividendo         int,
@w_consumo_cuota     money,
@w_porc_utilizacion  float,
@w_fecha_proceso     datetime,
@w_cupo_cuota        money,
@w_monto_aprobado    money,
---var variables     
@w_valor_ant         varchar(255),
@w_valor_nuevo       varchar(255),
@w_fecha_ult_proc_op datetime,
@w_fecha             datetime,
@w_estado            tinyint,
@w_error             int,
@w_est_cancelado     tinyint,
@w_est_novigente     tinyint,
@w_est_vigente       tinyint,
@w_est_vencido       tinyint,
@w_fecha_corte       datetime,
@w_utilizacion       money

SELECT @w_sp_name='sp_var_porcentaje_utilizacion'

exec @w_error    = cob_cartera..sp_estados_cca
@o_est_novigente = @w_est_novigente out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_cancelado = @w_est_cancelado out

SELECT @w_tramite = convert(int,io_campo_3)
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

print 'sp_var_porcentaje_utilizacion - @i_id_inst_proc' + convert(varchar, @i_id_inst_proc)
print 'sp_var_porcentaje_utilizacion - @w_tramite' + convert(varchar, @w_tramite)

select 
@w_operacionca       = op_operacion,
@w_monto_aprobado    = op_monto_aprobado,
@w_fecha_ult_proc_op = op_fecha_ult_proceso,
@w_estado            = op_estado
from cob_cartera..ca_operacion
where op_tramite = @w_tramite



if @w_operacionca = 0 return 0

print 'sp_var_porcentaje_utilizacion - @w_operacionca' + convert(varchar, @w_operacionca)

select @w_fecha_corte = @w_fecha_ult_proc_op

if @w_estado = @w_est_cancelado begin
   exec @w_error    = cob_cartera..sp_lcr_calc_corte 
   @i_operacionca   = @w_operacionca,
   @i_fecha_proceso = @w_fecha_ult_proc_op,
   @o_fecha_corte   = @w_fecha_corte out

   if @w_error <> 0 begin
      select @w_fecha_corte = @w_fecha_ult_proc_op
   end
end

print 'sp_var_porcentaje_utilizacion - @w_estado' + convert(varchar, @w_estado)

select @w_cortes_evaluar = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'NCEIC'
and pa_producto = 'CCA'

print 'sp_var_porcentaje_utilizacion - @w_cortes_evaluar' + convert(varchar, @w_cortes_evaluar)

if object_id('tempdb..#prestamos_dividendos') is null
begin
    print 'sp_var_porcentaje_utilizacion - Se crea tabla #prestamos_dividendos'
	
    create table #prestamos_dividendos(
    secuencial      int IDENTITY(1,1),
    operacion       int, 
    banco           cuenta,
    cliente         int,
    monto_aprobado  money,
    id_inst_proceso int,
    fecha_ini       datetime,
    fecha_fin       datetime,
    fecha_des       datetime,
    utilizacion     money,
    pagos           money,
    diferencia      money
    )
	
	exec cob_cartera..sp_lcr_gen_dividendos 
    @i_cortes      = @w_cortes_evaluar, 
    @i_fecha       = @w_fecha_corte,
    @i_operacionca = @w_operacionca
end

select 'sp_var_porcentaje_utilizacion', * from #prestamos_dividendos

select @w_porc_utilizacion = min(utilizacion/monto_aprobado*100)
from #prestamos_dividendos
where operacion = @w_operacionca

print 'sp_var_porcentaje_utilizacion - @w_cortes_evaluar' + convert(varchar, @w_porc_utilizacion)

print 'sp_var_porcentaje_utilizacion @w_porc_utilizacion: '+convert(varchar, isnull(@w_porc_utilizacion, ''))

select @w_valor_nuevo = @w_porc_utilizacion

-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
from cob_workflow..wf_variable_actual
where va_id_inst_proc = @i_id_inst_proc
and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin 
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )
end

if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())   
	if @@error > 0
	begin
          --registro ya existe			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end             
END

return 0

go
