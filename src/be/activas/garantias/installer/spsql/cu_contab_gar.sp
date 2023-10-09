use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_contabiliza_gar')
   drop proc sp_contabiliza_gar
go
create proc sp_contabiliza_gar
   @i_fecha    datetime
as

declare
   @w_err_conta         varchar(10),
   @w_fecha             datetime,
   @w_cc_cuenta         varchar(24),
   @w_oficina           int,
   @w_area              varchar(12),
   @w_ente              int,
   @w_valor             money,
   @w_debcred           char(1),
   @w_comprobante       int,
   @w_return            int,
   @w_error             int,
   @w_mensaje           varchar(24),
   @w_tran_modulo       varchar(24),
   @w_perfil            varchar(10),
   @w_descripcion       varchar(255),
   @w_user              varchar(10),
   @w_sp_name           varchar(24),
   @w_en_ced_ruc        varchar(16),
   @w_asiento           int,
   @w_credito           money,
   @w_debito            money,
   @w_tot_debito        money,
   @w_tot_credito       money,
   @w_cuenta            varchar(12),
   @w_concepto          varchar(24),
   @w_fecha_ant         datetime,
   @w_periodo           int,
   @w_corte             int

   select @w_perfil       = 'GAR'
   select @w_user         = 'garbatch'
   select @w_sp_name      = 'sp_contabiliza_gar'
   select @w_asiento      = 0
   select @w_tot_debito   = 0
   select @w_tot_credito  = 0

   select @w_fecha = @i_fecha

   select * 
   into   #actual_mes
   from   cob_ccontable..cco_boc_det
   where  bo_empresa  = 1
   and    bo_producto = 19
   and    bo_fecha    = @i_fecha 
   and    bo_tipo     = 'S'
   and    bo_cuenta   like '8213%'

   set rowcount 1
   select @w_fecha_ant = max(co_fecha)
   from   cob_credito..cr_calificacion_op_rep
   where  co_producto        = 200
   and    co_fecha           < @i_fecha
   set rowcount 0

   delete from cu_cuentas_conta

   delete cob_conta_tercero..ct_scomprobante_tmp
   where sc_producto   = 19
   and   sc_empresa    = 1
   and   sc_fecha_tran = @i_fecha

   delete cob_conta_tercero..ct_sasiento_tmp
   where sa_producto   = 19
   and   sa_fecha_tran = @i_fecha
   and   sa_empresa    = 1

   select *
   into   #cuentas_conta
   from   cu_cuentas_conta
   where  1=2

   -- Insercion saldos de garatias actuales

   insert into #cuentas_conta
   (cc_fecha, cc_cuenta, cc_oficina, cc_area, cc_ente, cc_valor, cc_debcre)
   select 
   @i_fecha , bo_cuenta, bo_oficina, bo_area, convert(int,bo_adicional), sum(bo_val_opera_mn), cu_categoria
   from  #actual_mes, 
         cob_conta..cb_cuenta
   where cu_cuenta = bo_cuenta
   group by bo_cuenta, bo_oficina, bo_area, convert(int,bo_adicional), cu_categoria

   if @w_fecha_ant is not null
   begin


      select @w_periodo = datepart(yy, @w_fecha_ant)
   
      select @w_corte = co_corte
      from   cob_conta..cb_corte
      where  co_empresa   = 1
      and    co_periodo   = @w_periodo
      and    co_fecha_ini = @w_fecha_ant


       -- Insercion saldos de garatias anterior mes desde conta
      insert into #cuentas_conta
      (cc_fecha, cc_cuenta, cc_oficina, cc_area, cc_ente, cc_valor, cc_debcre)
      select        
      @i_fecha , st_cuenta, st_oficina, st_area, st_ente, sum(st_saldo)*(-1), cu_categoria
      from    cob_conta_tercero..ct_saldo_tercero, 
              cob_conta..cb_cuenta
      where   st_corte       = @w_corte 
      and     st_periodo     = @w_periodo
      and     st_cuenta      like '8213%'
      and     cu_cuenta      = st_cuenta
      group by st_cuenta, st_oficina, st_area, st_ente, cu_categoria 

      -- INSERCION DE VALORES DEFINITIVOS
      insert into cu_cuentas_conta
      SELECT cc_fecha,cc_cuenta, cc_oficina, cc_area, cc_ente,SUM(cc_valor),cc_debcre
      FROM #cuentas_conta
      group by cc_fecha,cc_cuenta, cc_oficina, cc_area, cc_ente, cc_debcre

      insert into cu_cuentas_conta
      SELECT cc_fecha,'84050000005', cc_oficina, cc_area, cc_ente,cc_valor*(-1), 'D'
      FROM   cu_cuentas_conta

   end


   --------------------------------CONTABILIZACION DE GARANTIAS-----------------------------------

   select distinct cc_oficina 
   into #cu_cuentas_conta
   from cu_cuentas_conta
   group by cc_oficina

   declare cur_ofi cursor
   for select cc_oficina
   from   #cu_cuentas_conta
   
   open cur_ofi
   fetch cur_ofi
   into     @w_oficina

   while (@@fetch_status = 0)  begin

      if @@fetch_status = -1 begin
         close cur_ofi
         deallocate cur_ofi
      end

     /* PROCESO CONTABILIZACION POR CLIENTE */

     /* BUSCAR NUMERO PROXIMO COMPROBANTE CONTABLE POR OFICINA */
     exec @w_error = cob_conta..sp_cseqcomp
     @i_tabla     = 'cb_scomprobante', 
     @i_empresa   = 1,
     @i_fecha     = @w_fecha,
     @i_modulo    = 19,
     @i_modo      = 0,                  -- Numera por EMPRESA-FECHA-PRODUCTO
     @o_siguiente = @w_comprobante out

      if @w_error <> 0 begin
         select @w_mensaje = 'ERROR AL GENERAR NUMERO COMPROBANTE '
         goto ERROR
      end

      select @w_tot_debito  = 0
      select @w_tot_credito = 0

      declare cur_gar cursor
      for select cc_fecha,     cc_cuenta,    cc_oficina,
                 cc_area,      cc_ente,      cc_valor,
                 cc_debcre
      from   cu_cuentas_conta
      where cc_oficina = @w_oficina
      and   cc_valor <> 0
   
      open cur_gar

      fetch cur_gar into   
      @w_fecha,     @w_cuenta,    @w_oficina,
      @w_area,      @w_ente,      @w_valor,
      @w_debcred

      while (@@fetch_status = 0)
      begin

         select @w_asiento = @w_asiento + 1
         select @w_credito = 0
         select @w_debito  = 0
         select @w_descripcion = 
           'Garantias ' +
           'Ofi: ' + ltrim(rtrim(convert(varchar,@w_oficina)))   + ' ' +
           'Cuenta: ' + ltrim(rtrim(convert(varchar,@w_cuenta))) + ' ' +
           'Area: ' + convert(char(4),@w_area)                   + ' '

         select 
         @w_en_ced_ruc = en_ced_ruc
         from cobis..cl_ente
         where en_ente = @w_ente

         select @w_debito  = 0
         select @w_credito = 0


         if @w_valor >= 0 begin
            select @w_debito  = @w_valor
            select @w_credito = 0
            select @w_debcred = 'D'
         end else begin
            select @w_credito  = @w_valor * -1
            select @w_debito   = 0
            select @w_debcred = 'C'
         end

         select @w_concepto = 'Garantia'

         exec @w_error = cob_conta..sp_sasiento
         @i_operacion      = 'I',
         @i_fecha_tran     = @w_fecha,
         @i_comprobante    = @w_comprobante,
         @i_empresa        = 1,
         @i_asiento        = @w_asiento,
         @i_ente           = @w_ente,
         @i_documento      = @w_en_ced_ruc,
         @i_cuenta         = @w_cuenta,
         @i_oficina_dest   = @w_oficina,
         @i_area_dest      = @w_area,
         @i_credito        = @w_credito,
         @i_debito         = @w_debito,
         @i_concepto       = @w_concepto,
         @i_credito_me     = 0,
         @i_debito_me      = 0,
         @i_moneda         = 0,
         @i_cotizacion     = 1,
         @i_tipo_doc       = 'N',
         @i_tipo_tran      = 'A',
         @i_producto       = 19,
         @i_debcred        = @w_debcred,
         @i_tran_modulo    = @w_comprobante,
         @o_desc_error     = @w_mensaje out

         if @w_error !=0 begin
            select @w_mensaje = '(sp_sasiento) '+ isnull(@w_mensaje, '')
            goto ERROR
         end

         select @w_tot_debito  = @w_tot_debito  + @w_debito
         select @w_tot_credito = @w_tot_credito + @w_credito

         fetch cur_gar  into     
         @w_fecha,     @w_cuenta,    @w_oficina,
         @w_area,      @w_ente,      @w_valor,
         @w_debcred

      end

      close cur_gar
      deallocate cur_gar

      exec @w_error = cob_conta..sp_scomprobante
      @i_operacion      = 'I',
      @i_producto       = 19,
      @i_comprobante    = @w_comprobante,
      @i_empresa        = 1,
      @i_fecha_tran     = @w_fecha,
      @i_oficina_orig   = @w_oficina,
      @i_area_orig      = @w_area,
      @i_digitador      = @w_user,
      @i_descripcion    = @w_descripcion,
      @i_perfil         = 'GAR',
      @i_detalles       = @w_asiento,
      @i_tot_debito     = @w_tot_debito,
      @i_tot_credito    = @w_tot_credito,
      @i_tot_debito_me  = 0,
      @i_tot_credito_me = 0,
      @i_automatico     = 19,
      @i_reversado      = 'N',
      @i_estado         = 'I',
      @i_tran_modulo    = @w_comprobante,
      @o_desc_error     = @w_mensaje out

      if @w_error !=0 begin
         select @w_mensaje = '(sp_scomprobante) ' + isnull(@w_mensaje, '')
         goto ERROR
      end

     /* FIN PROCESO POR CLIENTE */

     select @w_asiento = 0

     goto SIGUIENTE

     ERROR:
         exec @w_return = cob_interfase..sp_errorcconta
         @t_trn         = 60011,
         @i_operacion   = 'I',
         @i_empresa     = 1,
         @i_fecha       = @w_fecha,
         @i_producto    = 7,
         @i_tran_modulo = @w_tran_modulo,
         @i_asiento     = 0,
         @i_fecha_conta = @w_fecha,
         @i_numerror    = @w_error,
         @i_mensaje     = @w_mensaje,
         @i_perfil      = 'GAR',
         @i_oficina     = @w_oficina

         if @w_return <> 0
         begin
            print 'Error Ejecutando cob_ccontable..sp_errorcconta'
         end

         select @w_mensaje = @w_descripcion + ' ' + @w_mensaje

         exec @w_return = cob_credito..sp_errorlog
         @i_fecha       = @w_fecha,
         @i_error       = @w_error, 
         @i_usuario     = @w_user,
         @i_tran        = 7000, 
         @i_tran_name   = @w_sp_name, 
         @i_rollback    = 'N',
         @i_cuenta      = 'CONTAB_GAR', 
         @i_descripcion = @w_mensaje

         if @w_return <> 0
         begin
            print 'Error Ejecutando cob_ccontable..sp_errorcconta'
         end

      SIGUIENTE: 
      fetch cur_ofi
      into     @w_oficina
   end
   close cur_ofi
   deallocate cur_ofi

return 0
go
