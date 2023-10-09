/************************************************************************/
/*   Archivo:            remdevalrec.sp                                 */
/*   Stored procedure:   sp_devolucion_val_recaudo                      */
/*   Base de datos:      cob_remesas                                    */
/*   Producto:           AHORROS                                        */
/*   Fecha de escritura: Jun. 2014                                      */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno  de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales de propiedad inte-         */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para      */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*                                                                      */
/*   Procedimiento que realiza la devolucion de valores de recaudos     */
/*                                                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA            AUTOR             RAZON                           */
/*   24/Jun/2016      J. Calderon       Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_devolucion_val_recaudo')
  drop proc sp_devolucion_val_recaudo
go

/****** Object:  StoredProcedure [dbo].[sp_devolucion_val_recaudo]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

IF OBJECT_ID ('dbo.sp_devolucion_val_recaudo') IS NOT NULL
	DROP PROCEDURE dbo.sp_devolucion_val_recaudo
GO

CREATE proc sp_devolucion_val_recaudo(
@s_ssn           int = null,
@s_term          varchar(10) = null,
@s_user          varchar(30) = null,
@s_ofi           smallint = null,
@s_date          datetime = null,
@t_trn           int,
@t_show_version  bit = 0,
@s_srv           varchar(30) = null,
@i_operacion     char(1),
@i_cta_banco     char(16) = null,
@i_codigo_red    smallint,
@i_fecha_desde   datetime = null,
@i_fecha_hasta   datetime = null,
@i_dias_dev      smallint = 1,
@i_sec           int = 0,
@i_formato_fecha int = 103 
)

as
declare 
@w_sp_name              varchar(50),
@w_error                int,
@w_msg                  varchar(255), 
@w_ah_cuenta            int, 
@w_fp_fecha             datetime,
@w_ah_fecha_ult_proceso datetime,
@w_nombre               char(60),
@w_cta_banco            char(16),
@w_cupo_aprobado        money,
@w_num_dias             int,
@w_fecha_desde_rec      datetime,
@w_fecha_hasta_rec      datetime,
@w_fecha_desde_lab      datetime

select @w_sp_name         = 'sp_devolucion_val_recaudo',
       @w_error           = 0

	   
  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

/* CONSULTA VALORES DE CABECERA */
if @i_operacion = 'C'
begin
   if exists( select 1 from cobis..cl_asoc_clte_serv where ac_codigo = @i_codigo_red and ac_estado = 'H')
   begin
      select @w_nombre = ah_nombre,
             @w_cta_banco = ah_cta_banco
      from cob_ahorros..ah_cuenta,
           cob_remesas..re_mantenimiento_cb 
      where mc_cta_banco = ah_cta_banco
      and   mc_cod_cb = @i_codigo_red
      and   mc_estado = 'H'
     
      if @@rowcount = 0
      begin
         select @w_error = 2609820
         goto ERROR
      end
      
      -- CONSULTA CUPO APROBADO
      select top 1 cc_tipo_mov , cc_valor_cupo, cc_fecha_ingreso
      into #cupo
      from re_mantenimiento_cupo_cb 
      where cc_cta_banco     =  @w_cta_banco
      and   cc_fecha_ingreso <= @s_date
      and   cc_tipo_mov      <> 'V'
      order by cc_fecha_ingreso desc, cc_hora_ingreso desc

      if @@rowcount = 0
      begin
         select @w_error = 701065
         goto ERROR
      end

      select @w_cupo_aprobado = isnull(cc_valor_cupo,0)
      from #cupo 
      where cc_fecha_ingreso <= @s_date
      
      --RETORNA CONSULTA AL FRONTEND
      select @w_nombre,
             @w_cupo_aprobado,
             @w_cta_banco
   end
   else
      begin
         select @w_error = 101253
         goto ERROR
      end
end

/* CONSTRUIR DETALLE DE MOVIMIENTOS DE PRODUCTO */
if @i_operacion = 'D'
begin

   -- ELIMINA DATOS DE CARGAS ANTERIORES
   delete cob_ahorros..ah_reporte_devolucion_tmp
   where rd_usuario = @s_user
   
   -- OBTIENE VALORES DE RECAUDOS Y DEVOLUCIONES
   select dr_fecha, dr_cta_banco, dr_cash_in, dr_cash_out, dr_pos_neta, dr_devolucion, convert(money, 0) dr_pendiente, 0 dr_saldo_cierre, CONVERT(int,0) dr_secuencial, convert(datetime, null) dr_fecha_repro, CONVERT(int,0) dr_sec_saldo, convert(datetime, null) dr_fecha_saldo
   into #recaudos
   from cob_ahorros..ah_dev_recaudos_cb
   where dr_cta_banco = @i_cta_banco
   and   dr_fecha between @i_fecha_desde and @i_fecha_hasta
   
   -- OBTIENE FECHA DE CONSULTA DEL DIA INCIAL DE CONSULTA MENOS 30 DIAS
   
   select @w_fecha_desde_lab = dateadd(d, -30, @i_fecha_desde)
   
   -- CARGA TEMPORAL DE DIAS LABORALES DESDE LA FECHA OBTENIDA ANTERIORMENTE
   select * 
   into #ah_dias_laborables
   from cob_ahorros..ah_dias_laborables
   where dl_fecha between @w_fecha_desde_lab and @i_fecha_hasta
   and   dl_fecha in (select dr_fecha from cob_ahorros..ah_dev_recaudos_cb)
   and   dl_ciudad = 99999
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL OBTENER DIAS LABORALES'
      goto ERROR
   end
   
   -- ASIGNA SECUENCIAL A LA TABLA TEMPORAL DE DIAS LABORABLES
   alter table #ah_dias_laborables
   add secuencial int identity (1,1)
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL GENERAR SECUENCIALES TABLA DE DIAS LABORALES'
      goto ERROR
   end
   
   -- OBTIENE EL SECUENCIAL DEL RECAUDO ASOCIADO A LA POSICION NETA ANTERIOR
   update #recaudos
   set dr_secuencial = secuencial - @i_dias_dev
   from #ah_dias_laborables
   where  dl_ciudad = 99999
   and    dl_fecha = dr_fecha
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR DIAS DE RECIPROCIDAD'
      goto ERROR
   end 
   
   -- OBTIENE EL SECUENCIAL DEL RECAUDO PARA OBTENER EL SALDO DEL ULTIMO CIERRE
   update #recaudos
   set dr_sec_saldo = secuencial - 1
   from #ah_dias_laborables
   where  dl_ciudad = 99999
   and    dl_fecha = dr_fecha
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR SECUENCIAL DEL SALDO ANTERIOR'
      goto ERROR
   end 
   
   -- OBTIENE LA FECHA DEL RECAUDO ASOCIADO A LA POSICION NETA ANTERIOR
   update #recaudos
   set dr_fecha_repro = dl_fecha
   from #ah_dias_laborables
   where  secuencial = dr_secuencial
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR FECHA DE RECIPROCIDAD'
      goto ERROR
   end  
   
    -- OBTIENE LA FECHA DEL RECAUDO ASOCIADO AL SALDO ANTERIOR
   update #recaudos
   set dr_fecha_saldo = dl_fecha
   from #ah_dias_laborables
   where  secuencial = dr_sec_saldo
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR FECHA DE SALDO'
      goto ERROR
   end  
   
   -- OBTIENE POSICION NETA ANTERIOR
   select dr_fecha fecha, dr_cta_banco cta_banco_ant, dr_pos_neta pos_neta_ant
   into #recaudos_ant
   from cob_ahorros..ah_dev_recaudos_cb
   where dr_cta_banco = @i_cta_banco
   and   dr_fecha in (select dr_fecha_repro from #recaudos)

   -- ACTUALIZA VALOR DE PENDIENTE DEL RECAUDO
   update #recaudos
   set dr_pendiente = pos_neta_ant - dr_devolucion
   from #recaudos_ant
   where dr_cta_banco = cta_banco_ant
   and   fecha = dr_fecha_repro
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR VALOR PENDIENTE'
      goto ERROR
   end 
   
   -- OBTIENE SALDOS DE CIERRE
   select dr_fecha fecha_sld, dr_cta_banco cta_banco_sld, dr_saldo_cierre sld_cierre
   into #saldos_cierre
   from cob_ahorros..ah_dev_recaudos_cb
   where dr_cta_banco = @i_cta_banco
   and   dr_fecha in (select dr_fecha_saldo from #recaudos)
   
    -- ACTUALIZA SALDOS DE CIERRE
   update #recaudos
   set dr_saldo_cierre = sld_cierre
   from #saldos_cierre
   where dr_cta_banco = cta_banco_sld
   and   fecha_sld = dr_fecha_saldo
   
   if @@error <> 0
   begin
      select @w_error = 2609820,
             @w_msg = 'ERROR AL ACTUALIZAR SALDOS DE CIERRE'
      goto ERROR
   end 

   -- INSERTA VALORES EN TABLA DEL REPORTE
   insert into cob_ahorros..ah_reporte_devolucion_tmp
   select rd_fecha        = dr_fecha,
          rd_cash_in      = dr_cash_in,
          rd_cash_out     = dr_cash_out,
          rd_pos_neta     = dr_pos_neta,
          rd_val_recaudo  = dr_devolucion,
          rd_pend_cubrir  = dr_pendiente,
          rd_saldo_cierre = dr_saldo_cierre,
          rd_cta_banco    = @i_cta_banco,
          rd_usuario      = @s_user
   from #recaudos
   order by dr_fecha
   
   -- RETORNA CONSULTA AL FRONT END

   set rowcount 20
   
   select 'SECUENCIAL'             = rd_secuencial,
          'FECHA'                  = convert(varchar(12), rd_fecha, @i_formato_fecha),
          'CASH IN'                = rd_cash_in,
          'CASH OUT'               = rd_cash_out,
          'POSICION NETA'          = rd_pos_neta,
          'DEV VALORES RECAUDADOS' = rd_val_recaudo,
          'PENDIENTE POR CUBRIR'   = rd_pend_cubrir,
          'SALDO A INICIO DE DIA'  = rd_saldo_cierre
   from cob_ahorros..ah_reporte_devolucion_tmp
   where rd_cta_banco = @i_cta_banco
   and   rd_usuario   = @s_user
   order by rd_fecha
   
   if @@rowcount = 0
   begin
      select @w_error = 601153
      goto ERROR
   end
   
   set rowcount 0
end

/* CONSULTA DE MOVIMIENTOS DE PRODUCTO */
if @i_operacion = 'S'
begin

   -- RETORNA CONSULTA AL FRONT END
   set rowcount 20
   
   select 'SECUENCIAL'             = rd_secuencial,
          'FECHA'                  = convert(varchar(12), rd_fecha, @i_formato_fecha),
          'CASH IN'                = rd_cash_in,
          'CASH OUT'               = rd_cash_out,
          'POSICION NETA'          = rd_pos_neta,
          'DEV VALORES RECAUDADOS' = rd_val_recaudo,
          'PENDIENTE POR CUBRIR'   = rd_pend_cubrir,
          'SALDO A INICIO DE DIA'  = rd_saldo_cierre
   from cob_ahorros..ah_reporte_devolucion_tmp
   where rd_cta_banco  = @i_cta_banco
   and   rd_usuario    = @s_user
   and   rd_secuencial > @i_sec
   order by rd_fecha
 
   set rowcount 0
   
end


return 0

ERROR:

   set rowcount 0
   exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error,
   @i_sev  = 0
   

return @w_error



GO

