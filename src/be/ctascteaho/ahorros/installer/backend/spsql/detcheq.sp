use cob_remesas
go
if exists (select 1 from sysobjects where name = 'sp_detallecheque' and type = 'P')
   drop proc sp_detallecheque
go
create proc sp_detallecheque (
/********************************************************************/
/*     Archivo:	            detallecheque.sp                        */
/*     Base de datos:       cob_remesas                             */
/*     Disenado por:        Eduardo Williams                        */
/*     Fecha de escritura:  20/May/2015                             */
/********************************************************************/
/*                         IMPORTANTE                               */
/********************************************************************/
/* Este programa es parte de los paquetes bancarios propiedad de    */
/* "MACOSA", representantes exclusivos para el Ecuador de la        */
/* "NCR CORPORATION".                                               */
/* Su uso no autorizado queda expresamente prohibido asi como       */
/* cualquier alteracion o agregado hecho por alguno de sus          */
/* usuarios sin el debido consentimiento por escrito de la          */
/* Presidencia Ejecutiva de MACOSA o su representante.         	    */
/********************************************************************/
/*                          PROPOSITO                               */
/********************************************************************/
/* Registro temporal de los cheques ingresados en depositos de      */
/* cuentas corrientes y ahorros desde caja                          */
/********************************************************************/
/* FECHA          AUTOR                 RAZON                       */
/********************************************************************/
/* 20/May/2015	  Eduardo Williams  	Emision Inicial             */
/* 04/Jun/2015    Eduardo Williams      Se incluye user y hora      */
/* 22/Jul/2015    E. Corrales           Actualizacion Fecha         */
/*                                      de Efectivizacion           */
/* 30/Jul/2015    E. Corrales           Reversa carta remesa        */
/* 16/Oct/2015    G. Cueva              Nuevos Parametros de DetCheq*/
/* 15/Ago/2016    T. Baidal             Migración para versión COBIS*/
/*                                      Cloud Mexico                */
/********************************************************************/
   @s_ssn             int           = null,
   @s_ssn_branch      int           = null,
   @s_user            login         = null,
   @s_term            varchar(32)   = null,
   @s_date            datetime      = null,
   @s_srv             varchar(30)   = null,
   @s_lsrv            varchar(30)   = null,
   @s_ofi             smallint      = null,
   @s_rol             smallint      = null,
   @s_org             char(1)       = null,
   @t_debug           char(1)       = 'N',
   @t_file            varchar(14)   = null,
   @t_from            varchar(30)   = null,
   @t_rty             char(1)       = 'N',
   @t_ejec            char(1)       = 'N',
   @t_trn             smallint      = null,
   @t_corr            char(1)       = 'N',
   @t_ssn_corr        int           = null,
   @t_show_version    bit           = 0,
   @i_filial          tinyint       = 1,   
   @i_cta_banco       cuenta        = null, --Cuenta del deposito
   @i_producto        tinyint       = null, --Producto de la cuenta
   @i_idcaja          smallint      = null,
   @i_canal           smallint      = 4,
   @i_trn             int           = null,
   @i_ctrlchq         int           = null,
   @i_sec             smallint      = null,
   @i_tipo            catalogo      = null,
   @i_tipo_chq        catalogo      = null,
   @i_co_banco        smallint      = null,
   @i_no_banco        varchar(50)   = null,
   @i_cta_cheque      varchar(50)   = null, --Cuenta del cheque
   @i_num_cheque      int           = null,
   @i_valor           money         = null,
   @i_mon             tinyint       = null,
   @i_fechaemision    date          = null,
   @i_estado          char(1)       = null,
   @i_operacion       char(1)       = null,   
   @i_factor          float         = null,
   @i_cotizacion      float         = null,
   @i_valor_convertido  money       = null,
   @i_mon_destino     tinyint       = null,
   @i_prod_banc       tinyint       = 1,
   @i_ssn_dep         int           = null ,
   @i_ssn_branch_dep  int           = null
)
as
declare @w_return          int,
        @w_valor           money,
        @w_sp_name         varchar(30),
        @w_dc_secuencial   smallint,
        @w_dc_tipo_chq     tinyint,
        @w_dc_no_banco     varchar(50),
        @w_dc_cta_cheque   varchar(50),
        @w_dc_num_cheque   int,
        @w_dc_valor        money,
        @w_dc_moneda       tinyint,
        @w_producto        char(3),
        @w_hora            datetime,
        @w_fecha_efe       datetime,
        @w_num_dias        tinyint,
        @w_ciudad          int,
        @w_dias_ret        tinyint,
        @w_cont            tinyint,
        @w_hora_ejecucion  smalldatetime
        
select  @w_sp_name = 'sp_detallecheque'

select @w_hora_ejecucion = convert(varchar(5),getdate(),108),
       @w_fecha_efe      = @s_date,
       @w_cont           = 0

if @t_show_version = 1
   begin
      print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
      return 0
   end

if (@t_trn != 639 and @i_operacion in ('I', 'O'))
or (@t_trn != 640 and @i_operacion = 'U')
or (@t_trn != 641 and @i_operacion in ('D', 'E'))
or (@t_trn != 642 and @i_operacion in ('C', 'Q'))
   begin
      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 601077 --Tipo de transaccion no corresponde
      return 601077
   end
   
if @i_operacion = 'I' --Nuevo cheque
   begin
      insert into re_detalle_cheque_tmp
      (dc_filial,     dc_oficina, dc_fecha,       dc_id,       dc_trn,        dc_numctrl,
       dc_secuencial, dc_tipo,    dc_tipo_chq,    dc_co_banco, dc_no_banco,   dc_cta_cheque,
       dc_num_cheque, dc_valor,   dc_moneda,      dc_fechaemision,
	   dc_factor    , dc_cotizacion, dc_valor_convertido, dc_mon_destino)
      values 
      (@i_filial,     @s_ofi,     @s_date,        @i_idcaja,   @i_trn,        @i_ctrlchq,
       @i_sec,        @i_tipo,    @i_tipo_chq,    @i_co_banco, @i_no_banco,   @i_cta_cheque,
       @i_num_cheque, @i_valor,   @i_mon,         @i_fechaemision,
	   @i_factor    ,@i_cotizacion,@i_valor_convertido, @i_mon_destino)
      
      if @@error != 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610095 --Error al registrar cheque en la tabla temporal
            return 2610095
         end
   end --@i_operacion = 'I'

if @i_operacion = 'U' --Actualizar datos del cheque
   begin
      update re_detalle_cheque_tmp
      set dc_tipo_chq     = @i_tipo_chq,
          dc_co_banco     = @i_co_banco,
          dc_no_banco     = @i_no_banco,
          dc_cta_cheque   = @i_cta_cheque,
          dc_num_cheque   = @i_num_cheque,
          dc_valor        = @i_valor,
          dc_moneda       = @i_mon,
          dc_fechaemision = @i_fechaemision,
		  dc_factor       = @i_factor, 
		  dc_cotizacion   = @i_cotizacion, 
		  dc_valor_convertido = @i_valor_convertido, 
		  dc_mon_destino  = @i_mon_destino 
      where dc_filial     = @i_filial
        and dc_oficina    = @s_ofi
        and dc_fecha      = @s_date
        and dc_id         = @i_idcaja
        and dc_trn        = @i_trn
        and dc_numctrl    = @i_ctrlchq
        and dc_secuencial = @i_sec
        
      if @@error != 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610096 --Error al actualizar cheque en la tabla temporal
            return 2610096
         end
   end --@i_operacion = 'U'
   
if @i_operacion = 'E' --Eliminar cheque
   begin
      delete from re_detalle_cheque_tmp
      where dc_filial     = @i_filial
        and dc_oficina    = @s_ofi
        and dc_fecha      = @s_date
        and dc_id         = @i_idcaja
        and dc_trn        = @i_trn
        and dc_numctrl    = @i_ctrlchq
        and dc_secuencial = @i_sec
             
      if @@error != 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610097 --Error al eliminar cheque de la tabla temporal
            return 2610097
         end
   end --@i_operacion = 'E'

if @i_operacion = 'D' --Elimina todos los cheques de una transaccion
   begin
      delete from re_detalle_cheque_tmp
      where dc_filial     = @i_filial
        and dc_oficina    = @s_ofi
        and dc_fecha      = @s_date
        and dc_id         = @i_idcaja
        and dc_trn        = @i_trn
        and dc_numctrl    = @i_ctrlchq
         
      if @@error != 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610097 --Error al eliminar cheque de la tabla temporal
            return 2610097
         end
   end --@i_operacion = 'D'
   
if @i_operacion = 'C' --Consultar cheques de una transaccion
   begin
      select '508724' = dc.dc_tipo,                         --Tipo
             '501633' = dc.dc_secuencial,                   --Secuencial
             '5273' = dc.dc_tipo_chq,                     --Cod. Tipo Chq.
             '5274' = (select ct.valor
                           from cobis..cl_tabla    tb,
                                cobis..cl_catalogo ct
                           where tb.codigo = ct.tabla
                             and tb.tabla  = 're_origen_cheque'
                             and ct.codigo = dc.dc_tipo_chq), --Des. Tipo Chq.
             '5275' = dc.dc_co_banco,                        --Cod. Banco
             '501445' = dc.dc_no_banco,                  --Banco
             '501058' = dc.dc_cta_cheque,
             '501434' = dc.dc_num_cheque,
             '502417' = dc.dc_valor,
             '509368' = convert(varchar(10), dc.dc_fechaemision, 101),
             '5276' = dc.dc_moneda,
             '5277' = (select ct.valor
                         from cobis..cl_tabla    tb,
                              cobis..cl_catalogo ct
                         where tb.codigo = ct.tabla
                           and tb.tabla  = 'cl_moneda'
                           and ct.codigo = convert(varchar, dc.dc_moneda)),
			 '5278' = dc.dc_factor,
			 '5269' = dc.dc_cotizacion,
			 '5268' = dc.dc_valor_convertido,
			 '5279' = dc.dc_mon_destino
      from re_detalle_cheque_tmp dc
      where dc.dc_filial  = @i_filial
        and dc.dc_oficina = @s_ofi
        and dc.dc_fecha   = @s_date
        and dc.dc_id      = @i_idcaja
        and dc.dc_trn     = @i_trn
        and dc.dc_numctrl = @i_ctrlchq
      order by dc.dc_secuencial
   end --@i_operacion = 'C'

if @i_operacion = 'Q' --Consulta si ya se registro un cheque (propio o local)
   begin
      if exists (select 1 from re_detalle_cheque
                 where dc_co_banco   = @i_co_banco
                   and dc_cta_cheque = @i_cta_cheque
                   and dc_num_cheque = @i_num_cheque)
         select 'S'
      else    
         select 'N' 
         
   end --@i_operacion = 'Q'

if @i_operacion = 'P' --Pasa los cheques propios de la tabla temporal a la tabla definitiva
   begin      
      select @w_valor = isnull(sum(dc_valor), 0)
      from re_detalle_cheque_tmp
      where dc_filial  = @i_filial
        and dc_oficina = @s_ofi
        and dc_fecha   = @s_date
        and dc_id      = @i_idcaja
        and dc_trn     = @i_trn
        and dc_numctrl = @i_ctrlchq
        and dc_tipo    = '3'

      if @w_valor != @i_valor
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610099 --El valor registrado no coincide con la suma de los cheques
            return 2610099
         end
      
      if @i_valor > 0
         begin         
            insert into re_detalle_cheque
            (dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, dc_ssn,
             dc_ssn_branch, dc_cta_banco, dc_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
             dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, dc_estado,   dc_user,     dc_hora, dc_fecha_efe,
             dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino)
            select dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, @s_ssn,
                   @s_ssn_branch, @i_cta_banco, @i_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
                   dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, @i_estado,   @s_user,     getdate(), @s_date,
				   dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino
            from re_detalle_cheque_tmp
            where dc_filial  = @i_filial
              and dc_oficina = @s_ofi
              and dc_fecha   = @s_date
              and dc_id      = @i_idcaja
              and dc_trn     = @i_trn
              and dc_numctrl = @i_ctrlchq
              and dc_tipo    = '3'
                            
            if @@error != 0
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug, 
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 2610098 --Error al insertar cheques en la tabla definitiva
                  return 2610098
               end                                    
         end --@i_valor > 0
         
   end --@i_operacion = 'P'
   
if @i_operacion = 'L' --Pasa los cheques locales de la tabla temporal a la tabla definitiva
   begin     

      select @w_valor = isnull(sum(dc_valor), 0)
      from re_detalle_cheque_tmp
      where dc_filial  = @i_filial
        and dc_oficina = @s_ofi
        and dc_fecha   = @s_date
        and dc_id      = @i_idcaja
        and dc_trn     = @i_trn
        and dc_numctrl = @i_ctrlchq
        and dc_tipo    = '1'      
      
      if @w_valor != @i_valor
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610099 --El valor registrado no coincide con la suma de los cheques
            return 2610099
         end
      
      if @i_valor > 0
         begin
            insert into re_detalle_cheque
            (dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, dc_ssn,
             dc_ssn_branch, dc_cta_banco, dc_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
             dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, dc_estado,   dc_user,     dc_hora, dc_fecha_efe,
             dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino)
            select dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, @s_ssn,
                   @s_ssn_branch, @i_cta_banco, @i_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
                   dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, @i_estado,   @s_user,     getdate(), @s_date,
				   dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino
            from re_detalle_cheque_tmp
            where dc_filial  = @i_filial
              and dc_oficina = @s_ofi
              and dc_fecha   = @s_date
              and dc_id      = @i_idcaja
              and dc_trn     = @i_trn
              and dc_numctrl = @i_ctrlchq
              and dc_tipo    = '1'
              
            if @@error != 0
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 2610098 --Error al insertar cheques en la tabla definitiva
                  return 2610098
               end
               
         /*   -- Determinar HORA DE INICIO DEL HORARIO DIFERIDO BRANCH
            select @w_hora = pa_datetime
            from cobis..cl_parametro
            where pa_nemonico = 'HDIF'
            and pa_producto = 'ATX'
            if @@rowcount = 0
            begin
            
                  exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 2610111
               return 2610111
            end*/
            
            
            --Determinar el codigo de la ciudad de la compensacion
            select @w_ciudad = of_ciudad
            from cobis..cl_oficina
            where of_oficina = @s_ofi
            
            if @@rowcount = 0
            begin
            
                  exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 351095
               return 351095
            end                       
            
            -- Numero de dias entre hoy y proxima fecha laborable nacional
            select @w_dias_ret = rl_dias
            from cob_cuentas..cc_retencion_locales_hsbc
            where rl_agencia = @s_ofi
            and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin
			and rl_prod_banc = @i_prod_banc
                  
            if @@rowcount = 0
            begin    /* Determinar el parametro general */
               select @w_dias_ret = pa_tinyint
                 from cobis..cl_parametro
                where pa_producto = 'CTE'
                  and pa_nemonico = 'DIRE'
               if @@rowcount = 0
               begin
            
                      exec cobis..sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 205001
                  return 205001
               end
            end                  
               
         /*   if convert(varchar(5),getdate(),108) >= convert(varchar(5),@w_hora,108)
            begin      
               select @w_dias_ret = @w_dias_ret + 1,
                      @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
            end  */
       
            if @w_dias_ret >= 1
            begin              
               while @w_cont <= @w_dias_ret
                  if exists (select 1 from cobis..cl_dias_feriados
                              where df_ciudad = @w_ciudad
                              and df_fecha  = @w_fecha_efe)
                              
                      select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)   
                  else
                   begin
                       select @w_cont = @w_cont + 1
                       if @w_cont <= @w_dias_ret
                          select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
                   end
                   
               select @w_num_dias = datediff(dd, @s_date, @w_fecha_efe)      

               if @w_num_dias > 0
               begin

                  update cob_remesas..re_detalle_cheque
                     set dc_fecha_efe = @w_fecha_efe
                  where dc_ssn_branch = @s_ssn_branch
                    and dc_tipo = '1'
                  if @@error != 0
                  begin
               
                        exec cobis..sp_cerror
                             @t_debug        = @t_debug,
                             @t_file         = @t_file,
                             @t_from         = @w_sp_name,
                             @i_num          = 2610110
                  
                     return 2610110
                  end
               end               
            end                                                         
         end --@i_valor > 0     
                                 
   end --@i_operacion = 'L'

if @i_operacion = 'T' --Pasa los cheques del exterior de la tabla temporal a la tabla definitiva
   begin
        
      select @w_valor = isnull(sum(dc_valor), 0)
      from re_detalle_cheque_tmp
      where dc_filial  = @i_filial
        and dc_oficina = @s_ofi
        and dc_fecha   = @s_date
        and dc_id      = @i_idcaja
        and dc_trn     = @i_trn
        and dc_numctrl = @i_ctrlchq
        and dc_tipo    = '2'
        
      if @w_valor != @i_valor
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2610099 --El valor registrado no coincide con la suma de los cheques
            return 2610099
         end
      
      if @i_valor > 0
         begin
            insert into re_detalle_cheque
            (dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, dc_ssn,
             dc_ssn_branch, dc_cta_banco, dc_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
             dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, dc_estado,   dc_user,     dc_hora,
			 dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino)
            select dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, @s_ssn,
                   @s_ssn_branch, @i_cta_banco, @i_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
                   dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, @i_estado,   @s_user,     getdate(),
				   dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino
            from re_detalle_cheque_tmp
            where dc_filial  = @i_filial
              and dc_oficina = @s_ofi
              and dc_fecha   = @s_date
              and dc_id      = @i_idcaja
              and dc_trn     = @i_trn
              and dc_numctrl = @i_ctrlchq
              and dc_tipo    = '2'
              
            if @@error != 0
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 2610098 --Error al insertar cheques en la tabla definitiva
                  return 2610098
               end                                    
               
            /*Llamada al sp_rem_ingcar por cada cheque registrado*/
            declare c_detalle_cheque cursor
            for
            select dc_secuencial, convert(tinyint, dc_tipo_chq), dc_no_banco, dc_cta_cheque, dc_num_cheque, dc_valor, dc_moneda
            from re_detalle_cheque_tmp
            where dc_filial  = @i_filial
              and dc_oficina = @s_ofi
              and dc_fecha   = @s_date
              and dc_id      = @i_idcaja
              and dc_trn     = @i_trn
              and dc_numctrl = @i_ctrlchq
              and dc_tipo    = '2'
              
            open c_detalle_cheque
              
            select @w_dc_secuencial = null, @w_dc_tipo_chq = null, @w_dc_no_banco = null, @w_dc_cta_cheque = null,
                   @w_dc_num_cheque = null, @w_dc_valor    = null, @w_dc_moneda   = null, @w_producto      = null
                                   
            fetch c_detalle_cheque
            into @w_dc_secuencial, @w_dc_tipo_chq, @w_dc_no_banco, @w_dc_cta_cheque, @w_dc_num_cheque, @w_dc_valor, @w_dc_moneda
                 
            while @@fetch_status = 0
               begin                   
                  select @w_producto = 'OTR'
                  
                  if (@i_producto in (3, 4))
                  begin
                     select @w_producto = pd_abreviatura
                     from cobis..cl_producto
                     where pd_producto = @i_producto
                  end
                   
                  exec @w_return      = cob_remesas..sp_rem_ingcar --No enviar @s_rol ni @t_ejec para que no actualice totales
                       @s_user        = @s_user,
                       @s_ofi         = @s_ofi,
                       @s_srv         = @s_srv,
                       @s_lsrv        = @s_lsrv,
                       @s_ssn         = @s_ssn,
                       @s_ssn_branch  = @s_ssn_branch,
                       @s_term        = @s_term,
                       @s_date        = @s_date,
                       @t_corr        = @t_corr,
                       @t_ssn_corr    = @t_ssn_corr,
                       @t_rty         = @t_rty,                
                       @t_trn         = 401,                       
                       @i_filial      = @i_filial,
                       @i_idcaja      = @i_idcaja,
                       @i_canal       = @i_canal,
                       @i_ctadep      = @i_cta_banco,
                       @i_mon         = @i_mon,
                       @i_alterno     = @w_dc_secuencial,
                       @i_tipo_cheque = @w_dc_tipo_chq,
                       @i_banco       = @w_dc_no_banco,
                       @i_ctagir      = @w_dc_cta_cheque,
                       @i_chq         = @w_dc_num_cheque,
                       @i_val         = @w_dc_valor,
                       @i_mon_chq     = @w_dc_moneda,
                       @i_prddep      = @w_producto,
                       @o_fecha_term  = @w_fecha_efe out
                                                                                                                                                          
                  if @w_return != 0
                     return @w_return
                                        
                  select @w_dc_secuencial = null, @w_dc_tipo_chq = null, @w_dc_no_banco = null, @w_dc_cta_cheque = null,
                         @w_dc_num_cheque = null, @w_dc_valor    = null, @w_dc_moneda   = null, @w_producto      = null
                        
                  fetch c_detalle_cheque
                  into @w_dc_secuencial, @w_dc_tipo_chq, @w_dc_no_banco, @w_dc_cta_cheque, @w_dc_num_cheque, @w_dc_valor, @w_dc_moneda
                   
               end --@@sqlstatus = 0
                 
            close c_detalle_cheque
            deallocate c_detalle_cheque
            
            --Fecha de efectivizacion
            update re_detalle_cheque
               set dc_fecha_efe  = @w_fecha_efe            
             where dc_tipo       = '2'
               and dc_ssn_branch = @s_ssn_branch
            if @@error != 0
            begin
            
                  exec cobis..sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 2610110
            
               return 2610110
            end
            
         end --@i_valor > 0          
end --@i_operacion = 'T'
   
if @t_corr = 'S'
begin
    update cob_remesas..re_detalle_cheque
       set dc_estado = 'R'
    where dc_ssn_branch = @t_ssn_corr
      and dc_estado <> 'C' --chq confirmado
    if @@error != 0
    begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 2610112
      
         return 2610112
    end
      
    select @w_valor = isnull(sum(dc_valor), 0)
    from re_detalle_cheque
    where dc_tipo    = '2'
      and dc_ssn_branch = @t_ssn_corr

    if @w_valor > 0
    begin
    	 /*Llamada al sp_rem_ingcar por cada cheque registrado*/
          declare c_detalle_cheque cursor
          for
          select dc_secuencial, convert(tinyint, dc_tipo_chq), dc_no_banco, dc_cta_cheque, dc_num_cheque, dc_valor, dc_moneda
          from re_detalle_cheque
          where dc_tipo    = '2'
            and dc_ssn_branch = @t_ssn_corr
            
          open c_detalle_cheque
            
          select @w_dc_secuencial = null, @w_dc_tipo_chq = null, @w_dc_no_banco = null, @w_dc_cta_cheque = null,
                 @w_dc_num_cheque = null, @w_dc_valor    = null, @w_dc_moneda   = null, @w_producto      = null
                                 
          fetch c_detalle_cheque
          into @w_dc_secuencial, @w_dc_tipo_chq, @w_dc_no_banco, @w_dc_cta_cheque, @w_dc_num_cheque, @w_dc_valor, @w_dc_moneda
               
          while @@fetch_status = 0
             begin                   
                
                select @w_producto = 'OTR'
                
                if (@i_producto in (3, 4))
                begin
                   select @w_producto = pd_abreviatura
                   from cobis..cl_producto
                   where pd_producto = @i_producto
                end
                                                        
                exec @w_return      = cob_remesas..sp_rem_ingcar --No enviar @s_rol ni @t_ejec para que no actualice totales
                     @s_user        = @s_user,
                     @s_ofi         = @s_ofi,
                     @s_srv         = @s_srv,
                     @s_lsrv        = @s_lsrv,
                     @s_ssn         = @s_ssn,
                     @s_ssn_branch  = @s_ssn_branch,
                     @s_term        = @s_term,
                     @s_date        = @s_date,
                     @t_corr        = @t_corr,
                     @t_ssn_corr    = @t_ssn_corr,
                     @t_rty         = @t_rty,                
                     @t_trn         = 401,                       
                     @i_filial      = @i_filial,
                     @i_idcaja      = @i_idcaja,
                     @i_canal       = @i_canal,
                     @i_ctadep      = @i_cta_banco,
                     @i_mon         = @i_mon,
                     @i_alterno     = @w_dc_secuencial,
                     @i_tipo_cheque = @w_dc_tipo_chq,
                     @i_banco       = @w_dc_no_banco,
                     @i_ctagir      = @w_dc_cta_cheque,
                     @i_chq         = @w_dc_num_cheque,
                     @i_val         = @w_dc_valor,
                     @i_mon_chq     = @w_dc_moneda,
                     @i_prddep      = @w_producto,
                     @i_origen      = 1
                                                                                                                                                        
                if @w_return != 0
                   return @w_return
                                      
                select @w_dc_secuencial = null, @w_dc_tipo_chq = null, @w_dc_no_banco = null, @w_dc_cta_cheque = null,
                       @w_dc_num_cheque = null, @w_dc_valor    = null, @w_dc_moneda   = null, @w_producto      = null
                      
                fetch c_detalle_cheque
                into @w_dc_secuencial, @w_dc_tipo_chq, @w_dc_no_banco, @w_dc_cta_cheque, @w_dc_num_cheque, @w_dc_valor, @w_dc_moneda
                 
             end --@@sqlstatus = 0
               
          close c_detalle_cheque
          deallocate c_detalle_cheque
    end
end  --@w_valor > 0 
  
if @i_operacion = 'O'
begin
  	 if @i_tipo <> '1'
	 begin
	       exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 357586 --Tipo de cheque enviado no es local
            return 357586
	 end
	   
       
	  -----
	   /*select @w_valor = isnull(sum(dc_valor), 0)
     from re_detalle_cheque_tmp
     where dc_filial  = @i_filial
       and dc_oficina = @s_ofi
       and dc_fecha   = @s_date
       and dc_id      = @i_idcaja
       and dc_trn     = @i_trn
       and dc_numctrl = @i_ctrlchq
       and dc_tipo    = '1'      
     
     if @w_valor != @i_valor
        begin
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 2610099 --El valor registrado no coincide con la suma de los cheques
           return 2610099
        end */
     
      if @i_valor > 0
      begin
          insert into re_detalle_cheque
          (dc_filial,     dc_oficina,   dc_fecha,    dc_id,           dc_trn,      dc_numctrl,  dc_secuencial, dc_ssn,
           dc_ssn_branch, dc_cta_banco, dc_producto, dc_tipo,         dc_tipo_chq, dc_co_banco, dc_no_banco,   dc_cta_cheque,
           dc_num_cheque, dc_valor,     dc_moneda,   dc_fechaemision, dc_estado,   dc_user,     dc_hora, dc_fecha_efe,
           dc_factor,     dc_cotizacion, dc_valor_convertido, dc_mon_destino)
          values 
	      (@i_filial,       @s_ofi,        @s_date,             @i_idcaja,       @i_trn,      @i_ctrlchq,  @i_sec,      @i_ssn_dep,
           @i_ssn_branch_dep, @i_cta_banco,  @i_producto,         @i_tipo,         @i_tipo_chq, @i_co_banco, @i_no_banco, @i_cta_cheque,
           @i_num_cheque,   @i_valor,      @i_mon,              @i_fechaemision, @i_estado,   @s_user,     getdate(),   @s_date,
           @i_factor,       @i_cotizacion, @i_valor_convertido, @i_mon_destino)
			  
              
          if @@error != 0
          begin
              exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 2610098 --Error al insertar cheques en la tabla definitiva
                  return 2610098
          end
               
          --Determinar el codigo de la ciudad de la compensacion
          select @w_ciudad = of_ciudad
          from cobis..cl_oficina
          where of_oficina = @s_ofi
          
          if @@rowcount = 0
          begin
                exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 351095
             return 351095
          end                       
          
          -- Numero de dias entre hoy y proxima fecha laborable nacional
          select @w_dias_ret = rl_dias
          from cob_cuentas..cc_retencion_locales_hsbc
          where rl_agencia = @s_ofi
          and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin
		  and rl_prod_banc = @i_prod_banc
                  
          if @@rowcount = 0
          begin    /* Determinar el parametro general */
             select @w_dias_ret = pa_tinyint
               from cobis..cl_parametro
              where pa_producto = 'CTE'
                and pa_nemonico = 'DIRE'
             if @@rowcount = 0
             begin
                    exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                         @i_num          = 205001
                return 205001
             end
          end                  
             
          if @w_dias_ret >= 1
          begin     
		  
              while @w_cont <= @w_dias_ret
                if exists (select 1 from cobis..cl_dias_feriados
                            where df_ciudad = @w_ciudad
                            and df_fecha  = @w_fecha_efe)
                            
                    select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)   
                else
                 begin
                     select @w_cont = @w_cont + 1
                     if @w_cont <= @w_dias_ret
                        select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
                 end
                 
             select @w_num_dias = datediff(dd, @s_date, @w_fecha_efe)      
              
             if @w_num_dias > 0
             begin
			
                update cob_remesas..re_detalle_cheque
                   set dc_fecha_efe = @w_fecha_efe
                where dc_ssn_branch = @i_ssn_branch_dep
				  and dc_oficina    = @s_ofi
				  and dc_co_banco   = @i_co_banco
				  and dc_cta_cheque = @i_cta_cheque
				  and dc_num_cheque = @i_num_cheque
                  and dc_tipo = '1'
                if @@error != 0
                begin
				    
                      exec cobis..sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 2610110
                
                   return 2610110
                end
            end               
        end                                                         
    end --@i_valor > 0    
end
   
return 0

go
