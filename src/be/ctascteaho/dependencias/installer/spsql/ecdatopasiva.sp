/*****************************************************************************/
/*  Archivo:                         ecdatpasiva.sp                          */
/*  Stored procedure:                sp_dato_pasivas                         */
/*  Base de datos:                   cob_conta_super                         */
/*  Producto:                        REC                                     */
/*  Disenado por:                    Juan C Ponce de León C                  */
/*  Fecha de escritura:              26/Ago/2009                             */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                          PROPOSITO                                        */
/*  Insertar saldos de pasivas desde cob_externos a cob_conta_super en       */
/*  sb_dato_pasivas                                                          */
/*****************************************************************************/
/*                        MODIFICACIONES                                     */
/*  FECHA          AUTOR                  RAZON                              */
/* 26/Ago/2009     JC Ponce de Leon C     Emision inicial                    */
/* 10/03/2013      D. Lozano              Ajustes CCA 384                    */
/* 29/08/2014      Andres Diab            Ajustes CCA 453 Relacion Canal     */
/* 16/08/2016      Jorge Salazar          Migracion Cobis CLOUD MEX          */
/*****************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_dato_pasivas')
   drop proc sp_dato_pasivas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_dato_pasivas(
   @t_show_version bit = 0,
   @i_param1       datetime
)
as

declare 
   @i_fecha_proceso  datetime,
   @w_sp_name        varchar(30),
   @w_ciudad         int,
   @w_siguiente_dia  datetime

    select @i_fecha_proceso = @i_param1,
           @w_sp_name       = 'sp_dato_pasivas'

  -- Versionamiento del Programa --
    if @t_show_version = 1
    begin
      print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
      return 0
    end
		  
  /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */-- Validacion Req 203
	select @w_ciudad  = pa_int
	  from cobis..cl_parametro
	 where pa_producto = 'CTE'
	  and  pa_nemonico = 'CMA'

	if @@rowcount <> 1 begin
       exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @i_fecha_proceso,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '205031',
            @i_descrp_error  = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
	end 
	
delete sb_errorlog
 where er_fuente = @w_sp_name

if @@error <> 0 begin
    exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @i_fecha_proceso,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28010',
         @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN sb_errorlog'           
end

  create table #aplicativo(aplicativo tinyint null)

  insert into #aplicativo
  select distinct dp_aplicativo
    from cob_externos..ex_dato_pasivas
   where dp_fecha = @i_fecha_proceso

  if exists(select 1 from #aplicativo) begin

      if exists (select 1 from #aplicativo, sb_dato_pasivas
                  where dp_fecha      = @i_fecha_proceso
                    and dp_aplicativo = aplicativo) 
      begin
         delete sb_dato_pasivas
           from #aplicativo
          where dp_aplicativo = aplicativo
            and dp_fecha      = @i_fecha_proceso
         
         if @@error <> 0 begin
            exec cob_conta_super..sp_errorlog
                 @i_operacion     = 'I',
                 @i_fecha_fin     = @i_fecha_proceso,
                 @i_fuente        = @w_sp_name,
                 @i_origen_error  = '28010',
                 @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN SB_DATO_PASIVAS'           
         end
      end

      -- Insercion de Registros por Fecha de Proceso
      insert into cob_conta_super..sb_dato_pasivas(
      dp_fecha,              dp_banco,              dp_toperacion,         dp_aplicativo,
      dp_categoria_producto, dp_naturaleza_cliente, dp_cliente,            dp_oficina,      
      dp_oficial,            dp_moneda,             dp_monto,              dp_tasa,               
      dp_modalidad,          dp_plazo_dias,         dp_fecha_apertura,     dp_fecha_radicacion,
      dp_fecha_vencimiento,  dp_num_renovaciones,   dp_estado,             dp_razon_cancelacion,  
      dp_num_cuotas,         dp_periodicidad_cuota, dp_saldo_disponible,   dp_saldo_int,          
      dp_saldo_camara12h,    dp_saldo_camara24h,    dp_saldo_camara48h,    dp_saldo_remesas,      
      dp_condicion_manejo,   dp_exen_gmf,           dp_fecha_ini_exen_gmf, dp_fecha_fin_exen_gmf, 
      dp_tesoro_nacional,    dp_ley_exen           ,dp_tasa_variable      ,dp_referencial_tasa,
      dp_signo_spread       ,dp_spread             ,dp_signo_puntos       ,dp_puntos,
      dp_signo_tasa_ref     ,dp_puntos_tasa_ref    ,dp_origen             ,dp_provisiona,
      dp_blqpignoracion)

      select 
      dp_fecha,              dp_banco,              dp_toperacion,         dp_aplicativo,
      dp_categoria_producto, dp_naturaleza_cliente, dp_cliente,            dp_oficina,   
      dp_oficial,            dp_moneda,             dp_monto,              dp_tasa,               
      dp_modalidad,          dp_plazo_dias,         dp_fecha_apertura,     dp_fecha_radicacion,
      dp_fecha_vencimiento,  dp_num_renovaciones,   dp_estado,             dp_razon_cancelacion,  
      dp_num_cuotas,         dp_periodicidad_cuota, dp_saldo_disponible,   dp_saldo_int,          
      dp_saldo_camara12h,    dp_saldo_camara24h,    dp_saldo_camara48h,    dp_saldo_remesas,      
      dp_condicion_manejo,   dp_exen_gmf,           dp_fecha_ini_exen_gmf, dp_fecha_fin_exen_gmf, 
      dp_tesoro_nacional,    dp_ley_exen           ,dp_tasa_variable      ,dp_referencial_tasa,
      dp_signo_spread       ,dp_spread             ,dp_signo_puntos       ,dp_puntos,
      dp_signo_tasa_ref     ,dp_puntos_tasa_ref    ,dp_origen             ,dp_provisiona,
      dp_blqpignoracion
      from cob_externos..ex_dato_pasivas
      where dp_fecha = @i_fecha_proceso

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
          @i_operacion     = 'I',
          @i_fecha_fin     = @i_fecha_proceso,
          @i_fuente        = @w_sp_name,
          @i_origen_error  = '28010',
          @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_DATO_PASIVAS'           
      end
      
      --tabla que contiene las cuentas en estado G
      
      delete cob_conta_super..sb_ctas_ingresadas
      where ci_fecha  = @i_fecha_proceso

      if @@error <> 0 
      begin
          exec cob_conta_super..sp_errorlog
          @i_operacion     = 'I',
          @i_fecha_fin     = @i_fecha_proceso,
          @i_fuente        = @w_sp_name,
          @i_origen_error  = '357006',
          @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN SB_CTAS_INGRESADAS'           
      end
      

      insert into cob_conta_super..sb_ctas_ingresadas
      select * from cob_externos..ex_ctas_ingresadas
      where ci_fecha  = @i_fecha_proceso

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
          @i_operacion     = 'I',
          @i_fecha_fin     = @i_fecha_proceso,
          @i_fuente        = @w_sp_name,
          @i_origen_error  = '203042',
          @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_CTAS_INGRESADAS'           
      end

      

  end -- exists #aplicativo
     else print 'Sin registros en la fecha: ' +cast(convert(varchar(10),@i_fecha_proceso,103) as varchar)

  -- Borra registros de Temporal
  delete #aplicativo

  insert into #aplicativo
  select distinct bo_aplicativo
    from cob_externos..ex_bloqueo_operaciones
   where bo_fecha = @i_fecha_proceso

  if exists(select 1 from #aplicativo) begin

      if exists (select 1 from #aplicativo, sb_bloqueo_operaciones
                  where bo_fecha      = @i_fecha_proceso
                    and bo_aplicativo = aplicativo) 
      begin
         delete sb_bloqueo_operaciones
           from #aplicativo
          where bo_aplicativo = aplicativo
            and bo_fecha      = @i_fecha_proceso
         
         if @@error <> 0 begin
            exec cob_conta_super..sp_errorlog
                 @i_operacion     = 'I',
                 @i_fecha_fin     = @i_fecha_proceso,
                 @i_fuente        = @w_sp_name,
                 @i_origen_error  = '28010',
                 @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN SB_DATO_PASIVAS'           
         end
      end

      -- Insercion de Bloqueos  'A'
      insert into sb_bloqueo_operaciones (
      bo_fecha,         bo_banco,         bo_aplicativo,       bo_secuencial,
      bo_causa_bloqueo, bo_fecha_bloqueo, bo_fecha_desbloqueo, bo_estado,     bo_fecha_modif)
      select
      bo_fecha,         bo_banco,         bo_aplicativo,       bo_secuencial,
      bo_causa_bloqueo, bo_fecha_bloqueo, bo_fecha_desbloqueo, bo_estado,     convert(varchar(10),getdate(),101)
      from cob_externos..ex_bloqueo_operaciones
      where bo_fecha  = @i_fecha_proceso
      and   bo_estado =  'A'

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28011',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_BLOQUEO_OPERACIONES'
      end

      -- Actualizacion de Bloqueos A -> C
      update sb_bloqueo_operaciones set 
            bo_fecha_desbloqueo = bo.bo_fecha_bloqueo,
            bo_estado           = bo.bo_estado,
            bo_fecha_modif      = convert(varchar(10),getdate(),101)      
       from cob_externos..ex_bloqueo_operaciones bo, 
            sb_bloqueo_operaciones op
      where bo.bo_fecha            = @i_fecha_proceso
        and bo.bo_fecha_desbloqueo = op.bo_fecha_bloqueo
        and bo.bo_estado           =  'C'
        and bo.bo_secuencial       = op.bo_secuencial
        and bo.bo_banco            = op.bo_banco
        and bo.bo_causa_bloqueo    = op.bo_causa_bloqueo

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
          @i_operacion     = 'I',
          @i_fecha_fin     = @i_fecha_proceso,
          @i_fuente        = @w_sp_name,
          @i_origen_error  = '28012',
          @i_descrp_error  = 'ERROR ACTUALIZANDO BLOQUEOS EN SB_BLOQUEO_OPERACIONES'
      end

  end
     else print 'No hay bloqueos para: ' +cast(convert(varchar(10),@i_fecha_proceso,103) as varchar)

  -- Borra registros de Temporal
  delete #aplicativo
  
  /* DETERMINAR EL SIGUIENTE DIA HABIL (ULTIMO PROCESO) */
	select @w_siguiente_dia = dateadd(dd,1,@i_fecha_proceso)

	while datepart(mm,@i_fecha_proceso) = datepart(mm,@w_siguiente_dia)
	  and exists(select 1 from cobis..cl_dias_feriados                                             
				  where df_ciudad = @w_ciudad                                                   
				    and df_fecha  = @w_siguiente_dia)
	begin
	   select @w_siguiente_dia = dateadd(dd, 1, @w_siguiente_dia)
	end
    
	if (datepart(mm,@w_siguiente_dia) <> datepart(mm,@i_fecha_proceso)) 
	begin
	  
      /*** ELIMINA DATOS EN TRAN MENSUAL Y RECHAZOS DE TRANSACCIONES***/  
      --if exists (select 1 from cob_conta_super..sb_tran_mensual) begin   
        -- delete cob_conta_super..sb_tran_mensual       
      --end
	
      insert into cob_conta_super..sb_tran_mensual(  
      tm_ano,                tm_mes,               tm_cuenta,										
      tm_cod_trn,            tm_cantidad
      )
      select 
      tm_ano,                tm_mes,               tm_cuenta,										
      tm_cod_trn,            tm_cantidad 
      from cob_externos..ex_tran_mensual

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28010',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_tran_mensual'           
      end
      insert into cob_conta_super..sb_tran_rechazos(  
      tr_fecha,              tr_oficina,               tr_cod_cliente,	       tr_id_cliente, 									
      tr_nom_cliente,        tr_cta_banco,             tr_tipo_tran,           tr_nom_tran,
      tr_vlr_comision,       tr_vlr_iva,               tr_modulo,              tr_causal_rech   
      )
      select 
      tr_fecha,              tr_oficina,               tr_cod_cliente,	       tr_id_cliente, 									
      tr_nom_cliente,        tr_cta_banco,             tr_tipo_tran,           tr_nom_tran,
      tr_vlr_comision,       tr_vlr_iva,               tr_modulo,              tr_causal_rech 
      from cob_externos..ex_tran_rechazos

      if @@error <> 0 begin
          exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @i_fecha_proceso,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28010',
               @i_descrp_error  = 'ERROR INSERTANDO DATOS EN sb_tran_rechazos'           
      end
      
      /*** ELIMINA DATOS MENSUALES EN LA TABLE DE AHORROS TRAN MENSUAL Y RECHAZOS REQ 203***/  
      if exists (select 1 from cob_ahorros..ah_tran_mensual) begin   
         delete from cob_ahorros..ah_tran_mensual
         
         if @@error <> 0 begin
            exec cob_conta_super..sp_errorlog
                 @i_operacion     = 'I',
                 @i_fecha_fin     = @i_fecha_proceso,
                 @i_fuente        = @w_sp_name,
                 @i_origen_error  = '147000',
                 @i_descrp_error  = 'Error al eliminar registros cob_ahorros..ah_tran_mensual'
         end     
      end
      /*** ELIMINA DATOS MENSUALES EN LA TABLE DE AHORROS TRAN MENSUAL Y RECHAZOS REQ 203***/  
      if exists (select 1 from cob_ahorros..ah_tran_rechazos) begin   
         delete from cob_ahorros..ah_tran_rechazos
         
         if @@error <> 0 begin
            exec cob_conta_super..sp_errorlog
                 @i_operacion     = 'I',
                 @i_fecha_fin     = @i_fecha_proceso,
                 @i_fuente        = @w_sp_name,
                 @i_origen_error  = '147000',
                 @i_descrp_error  = 'Error al eliminar registros cob_ahorros..ah_tran_rechazos'
         end     
      end
      
	end    

   /*** INSERTA DATOS EN sb_carga_archivo_cuentas***/  
 
   insert into cob_conta_super..sb_carga_archivo_cuentas
   select *
   from cob_externos..ex_carga_archivo_ctas
   
   if @@error <> 0 begin
      exec cob_conta_super..sp_errorlog
           @i_operacion     = 'I',
           @i_fecha_fin     = @i_fecha_proceso,
           @i_fuente        = @w_sp_name,
           @i_origen_error  = '28010',
           @i_descrp_error  = 'ERROR INSERTANDO DATOS EN ex_carga_archivo_ctas'         
   end 

   /*** REQ 453: PASO DE INFORMACION DE RELACIONES A CANALES ***/
   insert into #aplicativo
   select distinct rc_aplicativo
     from cob_externos..ex_relacion_canal
    where rc_fecha_proceso = @i_fecha_proceso
   
   if exists(select 1 from #aplicativo) 
   begin
       if exists (select 1 from #aplicativo, sb_relacion_canal
                   where rc_fecha_proceso = @i_fecha_proceso
                     and rc_aplicativo    = aplicativo) 
       begin
          delete sb_relacion_canal
            from #aplicativo
           where rc_aplicativo    = aplicativo
             and rc_fecha_proceso = @i_fecha_proceso
          
          if @@error <> 0 
          begin
             exec cob_conta_super..sp_errorlog
                  @i_operacion     = 'I',
                  @i_fecha_fin     = @i_fecha_proceso,
                  @i_fuente        = @w_sp_name,
                  @i_origen_error  = '28019',
                  @i_descrp_error  = 'ERROR ELIMINANDO DATOS EN SB_RELACION_CANAL'           
          end
       end
   
       -- Insercion de Relacion a Canal
       insert into sb_relacion_canal (
        rc_cuenta,     rc_cliente, rc_tel_celular, rc_tarj_debito,
        rc_canal,      rc_motivo,  rc_estado,      rc_fecha,
        rc_fecha_mod,  rc_usuario, rc_subtipo,     rc_tipo_operador,
        rc_aplicativo, rc_fecha_proceso)
       select
        rc_cuenta,     rc_cliente, rc_tel_celular, rc_tarj_debito,
        rc_canal,      rc_motivo,  rc_estado,      rc_fecha,
        rc_fecha_mod,  rc_usuario, rc_subtipo,     rc_tipo_operador,
        rc_aplicativo, rc_fecha_proceso
       from cob_externos..ex_relacion_canal
       where rc_fecha_proceso  = @i_fecha_proceso
       and   rc_aplicativo = 4
   
       if @@error <> 0 
       begin
           exec cob_conta_super..sp_errorlog
                @i_operacion     = 'I',
                @i_fecha_fin     = @i_fecha_proceso,
                @i_fuente        = @w_sp_name,
                @i_origen_error  = '28020',
                @i_descrp_error  = 'ERROR INSERTANDO DATOS EN SB_RELACION_CANAL'
       end     
   
   end
      else print 'NO HAY RELACIONES A CANALES PARA: ' +cast(convert(varchar(10),@i_fecha_proceso,103) as varchar)
     
return 0
go
