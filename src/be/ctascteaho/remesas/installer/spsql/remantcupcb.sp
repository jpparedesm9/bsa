/************************************************************************/
/*   Archivo:            remantcupcb.sp                                 */
/*   Stored procedure:   sp_mantenimiento_cupo_cb                       */
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
/*   Procedimiento que utiliza la pantalla del mantenimiento de cupo de */
/*   corresponsal                                                       */
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
           where  name = 'sp_mantenimiento_cupo_cb')
  drop proc sp_mantenimiento_cupo_cb
go

/****** Object:  StoredProcedure [dbo].[sp_mantenimiento_cupo_cb]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_mantenimiento_cupo_cb(
@s_ssn                int,
@s_user               login,
@s_date               datetime,
@s_ofi                smallint,
@s_term               varchar(10),
@s_srv                varchar(30) = null,
@t_trn                int,
@t_show_version       bit = 0,
@i_cta_banco          cuenta   = null,
@i_valor_cupo         money    = null,
@i_dias_vigencia      smallint = null,
@i_fecha_vencimiento  datetime = null,
@i_tipo_mov           char(1)  = null,
@i_operacion          char(1),
@i_hora               datetime = '',
@i_cod_cb             smallint = 0,
@i_formato_fecha      tinyint  = 103
)

as
declare 
@w_error                   int,
@w_sp_name                 varchar(50),
@w_param_prod_red          smallint,
@w_creditos_hoy            money,
@w_debitos_hoy             money,
@w_id_cuenta               int,
@w_saldo_disponible_1_dia  money,
@w_saldo_disponible_2_dias money,
@w_cupos_disponible        money,
@w_cod_cb                  smallint,
@w_nom_corresponsal        varchar(255),
@w_disponible              money,
@w_fecha_vencimiento       datetime,
@w_dias_vigencia           int,
@w_moneda                  tinyint,
@w_trn                     smallint,
@w_causal                  char(3),
@w_numdeci                 tinyint,
@w_msg                     varchar(132),
@w_fecha_ven_con           datetime,
@w_valor_cupo              money,
@w_saldo_favor             money,

@w_clase_clte              char(1),
@w_oficina_p               smallint,
@w_cliente                 int,
@w_tipocta                 char(1),
@w_categoria               char(1),
@w_prod_banc               smallint,
@w_registro_cupo           money,
@w_ciudad                  int,

@w_fecha_1                 datetime,
@w_fecha_2                 datetime,
@w_disponible_1            money,
@w_disponible_2            money,
@w_cupo_aprobado           money,
@w_cupo_aprobado_1         money,
@w_cupo_aprobado_2         money,
@w_cupo_utilizado          money,
@w_cupo_utilizado_1        money,
@w_cupo_utilizado_2        money,
@w_fecha_3                 varchar(10),
@w_saldo_ayer              money,
@w_saldo_dia2              money

   select @w_cupo_utilizado   = 0,         
          @w_cupo_utilizado_1 = 0,
          @w_cupo_utilizado_2 = 0,
          @w_disponible_1     = 0,
          @w_disponible_2     = 0,
          @w_cupo_aprobado    = 0,
          @w_cupo_aprobado_1  = 0,
          @w_cupo_aprobado_2  = 0


select @w_sp_name   = 'sp_mantenimiento_cupo_cb',
       @w_error     = 0

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  
if @i_operacion in ('I','H','S')
begin
   if @i_cta_banco is null 
   begin
      select @w_error = 2609841
      goto ERROR
   end
end

select @w_param_prod_red = pa_smallint 
   from  cobis..cl_parametro
   where pa_producto = 'AHO'
   and   pa_nemonico = 'PBCB'
   
if @@rowcount = 0
begin
   select @w_error = 2609822
   goto ERROR
end

if @i_tipo_mov in ('D', 'I')
begin
   select @w_fecha_ven_con = mc_fecha_ven_con
   from cob_remesas..re_mantenimiento_cb
   where mc_cta_banco = @i_cta_banco
   --print 'Fecha Ven ' + cast(@w_fecha_ven_con as varchar) + ' Fec Sis ' + cast(@s_date as varchar)
   if convert(datetime, @w_fecha_ven_con, 103) < convert(datetime, @s_date, 103)
   begin
      select @w_error = 2609864
      goto ERROR
   end
end



select @w_numdeci = isnull(pa_tinyint ,0)
from cobis..cl_parametro
where pa_nemonico = 'DCI'
and   pa_producto = 'AHO'
	   
if @i_operacion = 'I'
begin

   -- Validaciones de datos requeridos
   if @i_valor_cupo is null 
   begin
      select @w_error = 2609837
      goto ERROR
   end
   
   if @i_dias_vigencia is null 
   begin
      select @w_error = 2609838
      goto ERROR
   end
   
   if @i_fecha_vencimiento is null 
   begin
      select @w_error = 2609839
      goto ERROR
   end
   
   if @i_tipo_mov is null 
   begin
      select @w_error = 2609840
      goto ERROR
   end
   
   if @i_tipo_mov = 'R'
   begin
      -- validar que no exista un registro ingresado con el tipo de movimiento R
      if exists (select 1 from re_mantenimiento_cupo_cb where cc_cta_banco = @i_cta_banco and cc_tipo_mov = 'R')
      begin
         select @w_error = 2609842
         goto ERROR
      end
	  	  
	  select @w_causal = '51',
	         @w_trn   = 751, 
	         @w_valor_cupo      = round(@i_valor_cupo,@w_numdeci)
   end
   
   if @i_tipo_mov in ('I', 'D', 'V')
   begin
      -- validar que exista un registro ingresado con el tipo de movimiento R
      if not exists (select 1 from re_mantenimiento_cupo_cb where cc_cta_banco = @i_cta_banco and cc_tipo_mov = 'R')
      
	  if @@rowcount = 0
      begin
         select @w_error = 2609844
         goto ERROR
      end
	  
      select top 1 @w_valor_cupo = cc_valor_cupo 
      from re_mantenimiento_cupo_cb 
      where cc_cta_banco =  @i_cta_banco 
      and   cc_tipo_mov  <> 'V'
      order by cc_fecha_ingreso desc, cc_hora_ingreso desc
      
	  if @i_tipo_mov = ('D') and (@w_valor_cupo - @i_valor_cupo) < 0
      begin
	     select @w_error = 2609867
         goto ERROR
	  end
	  
	  if @i_tipo_mov = 'I'
	     select @w_causal = '52',
	            @w_trn   = 751,
	            @w_valor_cupo      = round(@w_valor_cupo, @w_numdeci) + round(@i_valor_cupo,@w_numdeci)
		 
      if @i_tipo_mov = 'D'
	     select @w_causal = '50', 
	            @w_trn   = 752,
	            @w_valor_cupo      = round(@w_valor_cupo, @w_numdeci) - round(@i_valor_cupo,@w_numdeci)
				
	  if @i_tipo_mov = 'V'
	     select @w_causal = NULL, 
	            @w_trn   = 751,
	            @w_valor_cupo      = 0
   end

             
   begin tran
   
   select 
   @w_clase_clte = ah_clase_clte,
   @w_oficina_p  = ah_oficina,
   @w_cliente    = ah_cliente,
   @w_tipocta    = ah_tipocta,
   @w_categoria  = ah_categoria,
   @w_prod_banc  = ah_prod_banc
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta_banco
   
   insert into cob_ahorros..ah_tran_servicio
  (ts_secuencial,    ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,    ts_usuario,
   ts_terminal,      ts_correccion, ts_ssn_corr,    ts_reentry,
   ts_origen,        ts_nodo,       ts_tsfecha,     ts_cta_banco,        ts_moneda,
   ts_valor,         ts_interes,    ts_indicador,   ts_causa,            
   ts_prod_banc,     ts_categoria,  ts_oficina_cta, 
   ts_tipocta_super, ts_clase_clte, ts_cliente,    ts_hora) 
  values 
  (@s_ssn,           @s_ssn,        1,              @w_trn,                 @s_ofi,        @s_user,
   @s_term,          'N',           null,           'N',
   'L',              @s_srv,        @s_date,        @i_cta_banco,        0,
   @i_valor_cupo,    null,          1,              @w_causal,           
   @w_prod_banc,     @w_categoria,  @w_oficina_p,   
   @w_tipocta,       @w_clase_clte,  @w_cliente,    getdate())

   if @@error <> 0
   begin
      rollback tran
      select @w_error = 2609843
	  goto ERROR
   end
   
   -- Insertar el cupo para el corresponsal
   insert into re_mantenimiento_cupo_cb 
   ( 
      cc_cta_banco   , cc_valor_cupo    , cc_dias_vigencia , cc_fecha_vencimiento , cc_tipo_mov, cc_oficina_reg, 
      cc_usuario_reg , cc_fecha_ingreso , cc_hora_ingreso
   )
   values
   (
      @i_cta_banco  , @w_valor_cupo , @i_dias_vigencia , @i_fecha_vencimiento , @i_tipo_mov , @s_ofi , 
      @s_user       , @s_date       , getdate()
   )
   
   if @@error <> 0
   begin
      rollback tran
      select @w_error = 2609843
      goto ERROR
   end  
  
   commit tran
end

if @i_operacion = 'H'
begin


   /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */
   select @w_ciudad  = pa_int
   from  cobis..cl_parametro
   where pa_producto = 'CTE'
   and   pa_nemonico = 'CMA'

   if @@rowcount <> 1 begin
      select @w_error = 205031, @w_msg = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
      goto ERROR 
   end
   
   /* DETERMINAR FECHAS DE PROCESO PARA CONSULTA DIAS ATRAS */
   select @w_fecha_1 = dateadd(dd,-1, @s_date)
   while exists(select 1 from cobis..cl_dias_feriados                                             
                where df_ciudad = @w_ciudad                                                   
                and   df_fecha  = @w_fecha_1)
   begin
      select @w_fecha_1 = dateadd(dd, -1, @w_fecha_1)
   end            

   select @w_fecha_2 = dateadd(dd,-1, @w_fecha_1)
   while exists(select 1 from cobis..cl_dias_feriados                                             
                where df_ciudad = @w_ciudad                                                   
                and   df_fecha  = @w_fecha_2)
   begin
      select @w_fecha_2 = dateadd(dd, -1, @w_fecha_2)
   end            

   /* DATOS DE LA CUENTA DE AHORROS */
   select @w_id_cuenta        = ah_cuenta,
		  @w_nom_corresponsal = ah_nombre,
		  @w_cod_cb           = ah_oficina,
		  @w_disponible       = ah_disponible		  
   from cob_ahorros..ah_cuenta 
   where ah_cta_banco = @i_cta_banco
   and   ah_prod_banc = @w_param_prod_red


/* SALDOS DIARIOS */ 
   select sd_fecha, sd_saldo_disponible
   into #saldo_diario
   from cob_ahorros_his..ah_saldo_diario
   where sd_cuenta = @w_id_cuenta
   and   sd_fecha >= @w_fecha_2
     
   select @w_disponible_1 = isnull(sd_saldo_disponible,0) from #saldo_diario where sd_fecha = @w_fecha_1
   select @w_disponible_2 = isnull(sd_saldo_disponible,0) from #saldo_diario where sd_fecha = @w_fecha_2
     
   /* DATOS CUPO APROBADO */
   select top 1 cc_tipo_mov , cc_valor_cupo, cc_fecha_ingreso
   into #cupo
   from re_mantenimiento_cupo_cb 
   where cc_cta_banco     =  @i_cta_banco
   and   cc_fecha_ingreso <= @s_date
   and   cc_tipo_mov      <> 'V'
   order by cc_fecha_ingreso desc, cc_hora_ingreso desc

   select @w_cupo_aprobado = isnull(cc_valor_cupo,0)
   from #cupo 
   where cc_fecha_ingreso <= @s_date

   select @w_cupo_aprobado_1 = isnull(cc_valor_cupo,0)
   from #cupo 
   where cc_fecha_ingreso <= @w_fecha_1
   
   select @w_cupo_aprobado_2 = isnull(cc_valor_cupo,0)
   from #cupo 
   where cc_fecha_ingreso <= @w_fecha_2

   select top 1 
   @w_fecha_vencimiento = cc_fecha_vencimiento, 
   @w_dias_vigencia = cc_dias_vigencia
   from re_mantenimiento_cupo_cb 
   where cc_cta_banco = @i_cta_banco
   and   cc_fecha_ingreso <= @s_date
   order by cc_hora_ingreso desc

   /* VALORES EN SUSPENSO POR USO DEL CUPO */
   select fecha = vs_fecha, procesada = vs_procesada, estado = vs_estado, valor = sum(vs_valor)
   into #val_suspenso      
   from   cob_ahorros..ah_val_suspenso
   where  vs_cuenta = @w_id_cuenta
   and    vs_fecha  <= @s_date
   group by vs_fecha, vs_procesada, vs_estado
     
   select @w_cupo_utilizado   = sum(round(isnull(valor,0), @w_numdeci)) from #val_suspenso where fecha <= @s_date and procesada = 'N'
   --select @w_cupo_utilizado_1 = sum(round(isnull(valor,0), @w_numdeci)) from #val_suspenso where fecha <= @w_fecha_1 and procesada = 'N'
   --select @w_cupo_utilizado_2 = sum(round(isnull(valor,0), @w_numdeci)) from #val_suspenso where fecha <= @w_fecha_2 and procesada = 'N'
   
   --Cupo utilizado un dia atras
   select @w_saldo_ayer = dr_saldo_cierre  from cob_ahorros..ah_dev_recaudos_cb where dr_fecha = dateadd(dd, -1, @s_date)
   
   --Cupo utilizado dos dias atras
   select @w_saldo_dia2 = dr_saldo_cierre  from cob_ahorros..ah_dev_recaudos_cb where dr_fecha = dateadd(dd, -1, @w_fecha_1)
   
   select 'sec_corr' = ts_ssn_corr 
   into #correccion 
   from cob_ahorros..ah_tran_servicio
   where ts_cta_banco = @i_cta_banco 
   and ts_tipo_transaccion = 258 
   and ts_causa = 260 
   and ts_estado is null 
   and ts_correccion = 'S' 
   and ts_ssn_corr is not null
   
   select @w_debitos_hoy   = round(sum(ts_valor),@w_numdeci) 
   from cob_ahorros..ah_tran_servicio
   where ts_tipo_transaccion = 258
   and   ts_cta_banco = @i_cta_banco 
   and   ts_causa = '260'
   and   ts_correccion <> 'S' 
   and   ts_secuencial not in (select sec_corr from #correccion)
   and   ts_secuencial not in (select vs_ssn from cob_ahorros..ah_val_suspenso where vs_cuenta = @w_id_cuenta
                               and   vs_estado = 'A' and vs_procesada = 'S' and vs_fecha = @s_date) --Excluye transacciones reversadas de suspenso
   
   select @w_creditos_hoy   = round(sum(tm_valor),@w_numdeci) 
   from cob_ahorros..ah_tran_monet
   where tm_cta_banco = @i_cta_banco 
   and tm_tipo_tran = 253 
   and tm_causa in ('260','261') 
   and tm_estado is null 

   
 
   select    'COD CORRESPONSAL'     = @w_cod_cb,  --OK
             'NOMBRE CORRESPONSAL'  = @w_nom_corresponsal,  --OK
             'NUMERO CUENTA'        = @i_cta_banco, --OK
             'DIAS VIGENCIA'        = datediff(dd,@s_date,@w_fecha_vencimiento), --OK
             'FECHA VENCIMIENTO'    = convert(varchar, @w_fecha_vencimiento, @i_formato_fecha), --OK
             'CUPO APROBADO'        = isnull(@w_cupo_aprobado, 0),  --OK
             'CUPO UTILIZADO'       = isnull(@w_cupo_utilizado, 0) - isnull(@w_disponible,0), --OK
             'CUPO DISPONIBLE'      = isnull(@w_cupo_aprobado, 0) - isnull(@w_cupo_utilizado, 0) + isnull(@w_disponible,0), --OK
             'SALDO DOS DIAS ANTES' = isnull((@w_cupo_aprobado_2 - (@w_saldo_dia2 * -1)), 0),
			 'SALDO UN DIA ANTES'   = isnull((@w_cupo_aprobado_1 - (@w_saldo_ayer * -1)), 0),
             'DEBITOS HOY'          = isnull((@w_debitos_hoy), 0) ,
			 'CREDITOS HOY'         = isnull((@w_creditos_hoy),0)  
                       
  
end

if @i_operacion = 'S'
begin
   set rowcount 20

   select 'VALOR CUPO'        = cc_valor_cupo,
          'TIPO MOVIMIENTO'   = cc_tipo_mov,
          'DIAS VIGENCIAS'    = cc_dias_vigencia,
          'FECHA VENCIMIENTO' = convert(varchar, cc_fecha_vencimiento, @i_formato_fecha),
          'OFICINA REGISTRO'  = cc_oficina_reg, 
          'USUARIO REGISTRO'  = cc_usuario_reg,
          'FECHA REGISTRO'    = convert(varchar, cc_fecha_ingreso, @i_formato_fecha),
		  'HORA REGISTRO'     = convert(varchar, cc_hora_ingreso, @i_formato_fecha) + ' ' + convert(varchar, cc_hora_ingreso, 114)
   from re_mantenimiento_cupo_cb
   where cc_cta_banco = @i_cta_banco
   and   cc_hora_ingreso > @i_hora
   order by cc_hora_ingreso

   if @@rowcount = 0
   begin
      select @w_error = 2609846
      goto ERROR
   end   
   
end

if @i_operacion = 'C'
begin
   set rowcount 20

   select distinct
      'COD CORRESPONSAL'     = mc_cod_cb, 
      'NOMBRE CORRESPONSAL'  = ah_nombre,
      'NUMERO CUENTA'        = ah_cta_banco,
      'DIAS VIGENCIA'        = (select top 1 cc_dias_vigencia
                                from re_mantenimiento_cupo_cb 
                                where cc_cta_banco = ah_cta_banco
                                order by cc_hora_ingreso desc),
      'CUPO UTILIZADO'       = (select sum(vs_valor)
                                from   cob_ahorros..ah_val_suspenso
                                where  vs_cuenta = ah_cuenta
                                and    vs_procesada = 'N'
                                )
   from cob_ahorros..ah_cuenta,
		re_mantenimiento_cb,
		re_mantenimiento_cupo_cb
   where ah_cta_banco = mc_cta_banco
   and   ah_cta_banco = cc_cta_banco
   and   mc_cod_cb > @i_cod_cb

   if @@rowcount = 0 and @i_cod_cb = 0
   begin
      select @w_error = 2609847
      goto ERROR
   end  
   
end

if @i_operacion = 'V'
begin
   
   select top 1 
          @w_dias_vigencia     = cc_dias_vigencia, 
		  @w_fecha_3 = convert(varchar(10), cc_fecha_vencimiento, @i_formato_fecha)
   from cob_remesas..re_mantenimiento_cupo_cb
   where cc_cta_banco = @i_cta_banco
   order by cc_hora_ingreso desc
   
   select @w_dias_vigencia,
          @w_fecha_3
end


return 0

ERROR:
   exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error,
   @i_sev  = 0,
   @i_msg  = @w_msg
   

return @w_error



go

