/************************************************************************/
/*	Archivo: 	            cu_clidad.sp                                */ 
/*	Stored procedure:       sp_alineacion_gar                           */ 
/*	Base de datos:  	    cob_custodia				                */
/*	Producto:               Garantias               		            */
/*	Disenado por:           Pablo Gaibor                  	            */
/*	Fecha de escritura:     Junio-1995  				                */
/************************************************************************/
/*				            PROPOSITO				                    */
/*	Genera la contabilidad de Garantias         		                */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		    RAZON				                    */
/*	08-Ago-2007 Martha Gil V.   Ajuste para tomear la moneda de la CTA  */
/************************************************************************/


use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_alineacion_gar')
drop proc sp_alineacion_gar
go

create proc sp_alineacion_gar
@i_filial         tinyint,
@i_fecha_ajuste   datetime,
@i_fecha_comp     datetime,
@i_usuario        login,
@i_producto       tinyint,
@i_descripcion    varchar(255),
@i_tipo           varchar(10),
@i_reproceso      varchar(15) = 'NO'-- AQUI VA LA PALABRA 'REPROCESO'  SI SE NECESITA REPROCESAR
as
declare
   @w_corte           int,
   @w_periodo         int,
   @w_area_oficina    smallint,
   
   @w_oficina         smallint,
   @w_area            smallint,
   @w_limite_ajuste   money,
   
   @w_cuenta          char(14),
   @w_cuenta_contra   char(14),
   @w_tipo_area       varchar(10),
   @w_tipo_oficina    char(2),
   @w_debito_contra   money,
   @w_credito_contra  money,
   @w_oficina_contra  smallint,
   @w_area_contra     smallint,
   
   @w_naturaleza      char(1),
   @w_comprobante     int,
   @w_nro_asiento     int,
   @w_debito          money,
   @w_credito         money,
   @w_tot_debito      money,
   @w_tot_credito     money,
   @w_saldo_producto   money,
   @w_saldo_conta     money,
   @w_diferencia      money,
   
   @w_asiento_ant     int,
   @w_error           int,
   @w_anexo           varchar(255),
   @w_moneda          tinyint,
   @w_def_moneda      tinyint,
   @w_debito_me       money,
   @w_credito_me      money,
   @w_debito_contra_me   money,
   @w_credito_contra_me  money,   
   @w_cotizacion      money,
   @w_rowcount        int,
   @w_garantia        cuenta,
   @w_cliente         int,
   @w_documento       cuenta
begin

      exec @w_error = sp_cuentas_gar
      
      if @w_error != 0
      begin
         ROLLBACK
         select @w_anexo = ''
         goto ERROR_SP
      end

   delete cob_conta_tercero..ct_scomprobante_tmp
   where sc_fecha_tran  = @i_fecha_comp
   and   sc_producto    = @i_producto
   
   delete cob_conta_tercero..ct_sasiento_tmp
   where sa_fecha_tran  = @i_fecha_comp
   and   sa_producto    = @i_producto
   
   -- PONER OK LOS COMPROBANTES DE ALINEACION QUE HAYAN PASADO A TABLAS DEFINITIVAS
   update cob_cartera..ca_cbte_alineacion
   set    ca_estado = 'OK'
   from   cob_conta_tercero..ct_scomprobante
   where  ca_fecha         = @i_fecha_comp
   and    ca_producto      = @i_producto
   and    ca_tipo          = @i_tipo
   and    sc_fecha_tran    = ca_fecha
   and    sc_producto      = ca_producto
   and    sc_comprobante   = ca_comprobante
   and    sc_empresa       = @i_filial
   
   -- QUITAR LOS QUE NO PASEN LA VALIDACION
   delete cob_cartera..ca_cbte_alineacion
   where  ca_fecha = @i_fecha_comp
   and    ca_estado != 'OK'
   and    ca_tipo    = @i_tipo
   
   -- PERMITIR REPROCESO
   if @i_reproceso = 'REPROCESO'
   begin
      update cob_cartera..ca_cbte_alineacion
      set    ca_fecha = dateadd(yy, -33, ca_fecha)
      where  ca_fecha   = @i_fecha_comp
      and    ca_tipo    = @i_tipo
   end
   
   select @w_periodo = datepart(yy, @i_fecha_ajuste)
   
   select @w_corte = co_corte
   from   cob_conta..cb_corte
   where  co_empresa = @i_filial
   and    co_periodo = @w_periodo
   and    co_fecha_ini = @i_fecha_ajuste
   
   if @@rowcount = 0
   begin
      select @w_error = 7100011,
             @w_anexo = ''
      goto ERROR_SP
   end
   
   select @w_area_oficina = ta_area
   from   cob_conta..cb_tipo_area
   where  ta_empresa  = @i_filial
   and    ta_producto = @i_producto
   and    ta_tiparea  = case
                        when @i_producto = 19 then 'CTB_OF'
                        else 'CTB_OF'
                        end

   if @@rowcount = 0
   begin
      select @w_error = 7100013,
             @w_anexo = ''
      goto ERROR_SP
   end
   
   select @w_nro_asiento = 0,
          @w_tot_debito  = 0,
          @w_tot_credito = 0
   
   select @w_limite_ajuste = pa_money
   from   cobis..cl_parametro
   where  pa_producto = 'CCA'
   and    pa_nemonico = 'LIAJUV'
   
   if @@rowcount = 0
   begin
      select @w_limite_ajuste = 9999999999999
      --goto ERROR_SP
   end
   /* MGV BUSCAR COTIZACIONES A LA FECHA */
   
    select	a.ct_moneda, a.ct_valor
    INTO #cotizaciones    
    from  cob_conta..cb_cotizacion a, cob_conta..cb_cotiz_mon_fechamax m
    where a.ct_moneda = m.cv_moneda
    and   a.ct_fecha = m.cv_fecha_max
    and   a.ct_fecha <= @i_fecha_ajuste
    

    select 	@w_def_moneda 	= pa_tinyint
    from 	cobis..cl_parametro
    where 	pa_nemonico 	= 'MLOCR'
    and   	pa_producto 	= 'CRE'
    select @w_rowcount = @@rowcount
    set transaction isolation level read uncommitted
    
    if @w_rowcount = 0
    begin
      select @w_def_moneda = 0
    end    
   
   select distinct bo_area
   into   #area
   from   cob_ccontable..cco_boc_det
   where  bo_empresa  = @i_filial
   and    bo_producto = @i_producto
   and    bo_fecha    = @i_fecha_ajuste

   
   declare
      cur_ofi cursor
      for select distinct re_ofconta
          from   cob_conta..cb_relofi o
          where  not exists(select 1
                            from   cob_cartera..ca_cbte_alineacion
                            where  ca_fecha    = @i_fecha_comp
                            and    ca_producto = @i_producto
                            and    ca_tipo     = @i_tipo
                            and    ca_oficina  = o.re_ofconta
                            and    ca_estado   = 'OK')
      for read only
   
   declare
      cur_area cursor
      for select distinct bo_area
          from #area
      for read only
   
   declare
      cur_cuenta  cursor
      for select ca_cuenta, cu_categoria, ca_cuenta_contra, ca_tipo_oficina, ca_tipo_area, ca_garantia
          from   cob_custodia..cu_cuentas_ajuste, cob_conta..cb_cuenta
          where  ca_estado   = 'V'
          and    cu_empresa  = @i_filial
          and    cu_cuenta   = ca_cuenta
          and    ca_producto = @i_producto
          and    ca_tipo     = @i_tipo
          order  by ca_cuenta
      for read only
   
   open cur_ofi
   
   BEGIN TRAN
   
   fetch cur_ofi
   into @w_oficina
   
   while @@fetch_status = 0 
   begin
      if @i_producto = 7 and @w_oficina = 3029
      begin
         fetch cur_ofi
         into @w_oficina
         continue
      end

      exec @w_error = cob_conta..sp_cseqcomp
           @i_tabla      = 'cb_scomprobante',
           @i_empresa    = @i_filial,
           @i_fecha      = @i_fecha_comp,
           @i_modulo     = @i_producto,
           @i_modo       = 0, 
           @o_siguiente  = @w_comprobante out
      
      if @w_error != 0
      begin
         ROLLBACK
         select @w_anexo = ''
         goto ERROR_SP
      end
      
      print 'Oficina: ' + cast(@w_oficina as varchar) + ' Comprobante: ' + cast(@w_comprobante as varchar)

      select @w_nro_asiento = 0
      
      open cur_area
      
      fetch cur_area
      into  @w_area
      
      while @@fetch_status = 0 
      begin

         print 'Area: ' + cast(@w_area as varchar)

         open cur_cuenta
         
         fetch cur_cuenta
         into  @w_cuenta, @w_naturaleza, @w_cuenta_contra, @w_tipo_oficina, @w_tipo_area,@w_garantia
         
         while @@fetch_status = 0 
         begin

            print 'Cuenta: ' + cast(@w_cuenta as varchar)

            -- OBTEBER TERCERO
            select @w_cliente = cg_ente 
            from   cu_cliente_garantia
            where  cg_codigo_externo = @w_garantia
            order by cg_tipo_garante 

            select @w_documento = en_ced_ruc
            from   cobis..cl_ente
            where  en_ente = @w_cliente


            -- EXTRACCION DEL AREA
            select @w_area_contra = ta_area
            from   cob_conta..cb_tipo_area
            where  ta_empresa  = @i_filial
            and    ta_producto = @i_producto
            and    ta_tiparea  = @w_tipo_area
            
            -- PARA TODOS LOS EFECTOS LA OFICINA 9000 DEBE TENER LAS CUENTAS DE CARTERA EN EL AREA 3030
            if @i_producto in (7, 19, 21) and @w_oficina = 9000 and @w_tipo_area in ('CTB_OF', 'GAREA1')
               select @w_area_contra = 31
            
            -- PARA TODOS LOS EFECTOS LA OFICINA 3029 DEBE TENER LAS CUENTAS DE CARTERA EN EL AREA 3029
            if @i_producto in (7, 19, 21) and @w_oficina = 3029 and @w_tipo_area in ('CTB_OF', 'GAREA1')
               select @w_area_contra = 31 
            
            -- COMPARACION DE SALDOS
            select @w_saldo_producto = isnull(sum(bo_val_opera_mn), 0), @w_moneda = bo_moneda
            from   cob_ccontable..cco_boc_det
            where  bo_empresa  = @i_filial
            and    bo_producto = @i_producto
            and    bo_fecha    = @i_fecha_ajuste
            and    bo_oficina  = @w_oficina
            and    bo_area     = @w_area
            and	   bo_tipo     = 'S'
            and    bo_cuenta   = @w_cuenta
            group by bo_moneda
            
            if @@rowcount = 0
               select @w_saldo_producto = 0
            
            select @w_saldo_conta = isnull(sum(hi_saldo), 0)
            from   cob_conta_his..cb_hist_saldo
            where  hi_empresa = @i_filial
            and    hi_periodo = @w_periodo
            and    hi_corte   = @w_corte
            and    hi_oficina = @w_oficina
            and    hi_area    = @w_area
            and    hi_cuenta  = @w_cuenta
            
            if @@rowcount = 0
               select @w_saldo_conta = 0
            
            select @w_diferencia = @w_saldo_producto - @w_saldo_conta
            select @w_debito = 0,
                   @w_credito = 0
            
            if abs(@w_diferencia) between 0.01 and @w_limite_ajuste
            begin
               if @w_naturaleza = 'D'
               begin
                  if @w_diferencia < 0 -- SOBRA EN CONTABILIDAD
                     select @w_credito = abs(@w_diferencia)
                  else -- FALTA EN LA CONTABILIDAD
                     select @w_debito = @w_diferencia
               end
               ELSE -- NATURALEZA CREDITO
               begin
                  if @w_diferencia < 0 -- FALTA PLATA EN CONTA
                     select @w_credito = abs(@w_diferencia)
                  else
                     select @w_debito = @w_diferencia
               end


              select @w_debito_me = 0,
                     @w_credito_me = 0,
                     @w_cotizacion = 0
                                        
               if @w_moneda <> @w_def_moneda 
               begin
                              
                  select @w_cotizacion = ct_valor from #cotizaciones where ct_moneda = @w_moneda
                         
                  if @w_debito > 0 
                     select @w_debito_me = @w_debito / @w_cotizacion              

                  if @w_credito > 0 
                     select @w_credito_me = @w_credito /  @w_cotizacion                 
               end
               
               
               
               -- INSERTAR ASIENTO
               select @w_nro_asiento = @w_nro_asiento + 1,
                      @w_tot_debito  = @w_tot_debito  + @w_debito,
                      @w_tot_credito = @w_tot_credito + @w_credito


               print 'Inserta en ct_sasiento_tmp ' + cast(@w_comprobante as varchar) 

               
               insert into cob_conta_tercero..ct_sasiento_tmp
                     (sa_producto,      sa_fecha_tran,          sa_comprobante,
                      sa_empresa,       sa_asiento,             sa_cuenta,
                      sa_oficina_dest,  sa_area_dest,           sa_credito,
                      sa_debito,        sa_concepto,            sa_credito_me,
                      sa_debito_me,     sa_cotizacion,          sa_tipo_doc,
                      sa_tipo_tran,     sa_moneda,              sa_opcion,
                      sa_ente,          sa_con_rete,            sa_base,
                      sa_valret,        sa_con_iva,             sa_valor_iva,
                      sa_iva_retenido,  sa_con_ica,             sa_valor_ica,
                      sa_con_timbre,    sa_valor_timbre,        sa_con_iva_reten,
                      sa_con_ivapagado, sa_valor_ivapagado,     sa_documento,
                      sa_mayorizado,    sa_con_dptales,         sa_valor_dptales,
                      sa_posicion,      sa_debcred,             sa_oper_banco,
                      sa_cheque,        sa_doc_banco,           sa_fecha_est,
                      sa_detalle,       sa_error)
               values(@i_producto,      @i_fecha_comp,          @w_comprobante,
                      @i_filial,        @w_nro_asiento,         @w_cuenta,
                      @w_oficina,       @w_area,                @w_credito,
                      @w_debito,        'AUTOMATICO',           @w_credito_me,
                      @w_debito_me,     @w_cotizacion,          'N',
                      'N',              @w_moneda,              null,
                      @w_cliente,       null,                   0,
                      null,             'N',                    0,
                      null,             null,                   null,
                      'N',              0,                      null,
                      null,             null,                   @w_documento,
                      'N',              null,                   null,
                      'S',              null,                   null,
                      '123',            null,                   null,
                      null,             'N')
               
               if @@error !=0
               begin
                  select @w_error = 710001,
                         @w_anexo = ''
                  goto ERROR_SP
               end
               
               select @w_credito_contra = @w_debito,
                      @w_debito_contra  = @w_credito,
                      @w_credito_contra_me = @w_debito_me,
                      @w_debito_contra_me  = @w_credito_me
               
               if @w_tipo_oficina = 'OF'
                  select @w_oficina_contra = @w_oficina
               else
                  select @w_oficina_contra = 9000
               
               select @w_tot_debito  = @w_tot_debito  + @w_debito_contra,
                      @w_tot_credito = @w_tot_credito + @w_credito_contra
               
               -- INSERTAR LA CUENTA CONTRARIA
               if exists(select 1 from cob_conta_tercero..ct_sasiento_tmp
                         where sa_empresa      = @i_filial
                         and   sa_producto     = @i_producto
                         and   sa_fecha_tran   = @i_fecha_comp
                         and   sa_comprobante  = @w_comprobante
                         and   sa_oficina_dest = @w_oficina_contra
                         and   sa_area_dest    = @w_area_contra
                         and   sa_cuenta       = @w_cuenta_contra
                         )
               begin
                  update cob_conta_tercero..ct_sasiento_tmp
                  set    sa_debito  = sa_debito  + @w_debito_contra,
                         sa_credito = sa_credito + @w_credito_contra,
                         sa_debito_me  = sa_debito_me  + @w_debito_contra_me,
                         sa_credito_me = sa_credito_me + @w_credito_contra_me
                  where sa_empresa      = @i_filial
                  and   sa_producto     = @i_producto
                  and   sa_fecha_tran   = @i_fecha_comp
                  and   sa_comprobante  = @w_comprobante
                  and   sa_oficina_dest = @w_oficina_contra
                  and   sa_area_dest    = @w_area_contra
                  and   sa_cuenta       = @w_cuenta_contra
               end
               ELSE
               begin
                  select @w_nro_asiento = @w_nro_asiento + 1,
                         @w_area_contra = isnull(@w_area_contra ,31)
                  
                  insert into cob_conta_tercero..ct_sasiento_tmp
                        (sa_producto,           sa_fecha_tran,          sa_comprobante,
                         sa_empresa,            sa_asiento,             sa_cuenta,
                         sa_oficina_dest,       sa_area_dest,           sa_credito,
                         sa_debito,             sa_concepto,            sa_credito_me,
                         sa_debito_me,          sa_cotizacion,          sa_tipo_doc,
                         sa_tipo_tran,          sa_moneda,              sa_opcion,
                         sa_ente,               sa_con_rete,            sa_base,
                         sa_valret,             sa_con_iva,             sa_valor_iva,
                         sa_iva_retenido,       sa_con_ica,             sa_valor_ica,
                         sa_con_timbre,         sa_valor_timbre,        sa_con_iva_reten,
                         sa_con_ivapagado,      sa_valor_ivapagado,     sa_documento,
                         sa_mayorizado,         sa_con_dptales,         sa_valor_dptales,
                         sa_posicion,           sa_debcred,             sa_oper_banco,
                         sa_cheque,             sa_doc_banco,           sa_fecha_est,
                         sa_detalle,            sa_error)
                  values(@i_producto,           @i_fecha_comp,          @w_comprobante,
                         @i_filial,             @w_nro_asiento,         @w_cuenta_contra,
                         @w_oficina_contra,     @w_area_contra,         @w_credito_contra,
                         @w_debito_contra,      'AJUSTE AUTOMATICO',    @w_credito_contra_me,
                         @w_debito_contra_me,   @w_cotizacion,          'N',
                         'N',                   @w_moneda,                      null,
                         @w_cliente,            null,                   0,
                         null,                  'N',                    0,
                         null,                  null,                   null,
                         'N',                   0,                      null,
                         null,                  null,                   @w_documento,
                         'N',                   null,                   null,
                         'S',                   null,                   null,
                         '123',                 null,                   null,
                         null,                  'N')
                  
                  if @@error !=0
                  begin
                     select @w_error = 710001,
                            @w_anexo = ''
                     goto ERROR_SP
                  end
               end
            end
            
            fetch cur_cuenta
            into  @w_cuenta, @w_naturaleza, @w_cuenta_contra, @w_tipo_oficina, @w_tipo_area, @w_garantia
         end -- CURSOR CUENTA
         
         close cur_cuenta
         
         fetch cur_area
         into  @w_area
      end -- CURSOR AREA
      
      close cur_area
      
      -- CERRAR COMPROBANTE DE LA OFICINA
      if @w_nro_asiento > 0
      begin
         
         delete cob_conta_tercero..ct_sasiento_tmp
         where  sa_empresa      = @i_filial
         and    sa_producto     = @i_producto
         and    sa_fecha_tran   = @i_fecha_comp
         and    sa_comprobante  = @w_comprobante
         and    sa_debito       = sa_credito
         
         update cob_conta_tercero..ct_sasiento_tmp
         set    sa_debito = sa_debito - sa_credito,
                sa_credito = 0
         where  sa_empresa      = @i_filial
         and    sa_producto     = @i_producto
         and    sa_fecha_tran   = @i_fecha_comp
         and    sa_comprobante  = @w_comprobante
         and    sa_debito       > sa_credito
         
         update cob_conta_tercero..ct_sasiento_tmp
         set    sa_credito = sa_credito - sa_debito,
                sa_debito = 0
         where  sa_empresa      = @i_filial
         and    sa_producto     = @i_producto
         and    sa_fecha_tran   = @i_fecha_comp
         and    sa_comprobante  = @w_comprobante
         and    sa_credito       > sa_debito
         
         -- RENUMERACION ASIENTOS
         select @w_nro_asiento = 0,
                @w_asiento_ant = 100
         
         while @w_asiento_ant != 0
         begin
            select @w_asiento_ant = isnull(min(sa_asiento), 0)
            from   cob_conta_tercero..ct_sasiento_tmp
            where  sa_empresa     = 1
            and    sa_producto    = @i_producto
            and    sa_fecha_tran  = @i_fecha_comp
            and    sa_comprobante = @w_comprobante
            and    sa_asiento     > @w_nro_asiento
            
            if @w_asiento_ant > 0
            begin
               select @w_nro_asiento = @w_nro_asiento + 1
               
               if @w_asiento_ant != @w_nro_asiento
               begin
                  update cob_conta_tercero..ct_sasiento_tmp
                  set    sa_asiento = @w_nro_asiento
                  where  sa_empresa     = 1
                  and    sa_producto    = @i_producto
                  and    sa_fecha_tran  = @i_fecha_comp
                  and    sa_comprobante = @w_comprobante
                  and    sa_asiento     = @w_asiento_ant
               end
            end
         end
         --
         select @w_tot_debito = sum(sa_debito),
                @w_tot_credito = sum(sa_credito),
                @w_nro_asiento = count(1)
         from   cob_conta_tercero..ct_sasiento_tmp
         where  sa_empresa      = @i_filial
         and    sa_producto     = @i_producto
         and    sa_fecha_tran   = @i_fecha_comp
         and    sa_comprobante  = @w_comprobante
         
         if @w_nro_asiento > 0
         begin
            -- INSERCION DEL COMPROBANTE

            print 'insert en ct_scomprobante_tmp ' + cast(@w_comprobante as varchar)

            insert into cob_conta_tercero..ct_scomprobante_tmp
                  (sc_producto,       sc_comprobante,       sc_empresa,        
                   sc_fecha_tran,     sc_oficina_orig,      sc_area_orig, 
                   sc_fecha_gra,      sc_digitador,         sc_descripcion, 
                   sc_perfil,         sc_detalles,          sc_tot_debito,
                   sc_tot_credito,    sc_tot_debito_me,     sc_tot_credito_me,
                   sc_automatico,     sc_reversado,         sc_estado,    
                   sc_mayorizado,     sc_observaciones,     sc_comp_definit,  
                   sc_usuario_modulo, sc_tran_modulo,       sc_error)
            values(@i_producto,       @w_comprobante,       @i_filial,
                   @i_fecha_comp,     @w_oficina,           @w_area_oficina,
                   getdate(),         @i_usuario,           @i_descripcion,
                   '',                @w_nro_asiento,       @w_tot_debito,
                   @w_tot_credito,    0,                    0,
                   0,                 'N',                  'I',
                   'N',               null,                 null,
                   @i_usuario,        '',                   'N')
            
            insert into cob_cartera..ca_cbte_alineacion
                  (ca_oficina,     ca_fecha,       ca_producto,
                   ca_comprobante, ca_tipo,        ca_estado)
            values(@w_oficina,     @i_fecha_comp,  @i_producto,
                   @w_comprobante, @i_tipo,        'VA')
         end
      end
      
      --
      fetch cur_ofi
      into @w_oficina
   end -- CURSOR OFICINA
   
   close cur_ofi
   
   while @@trancount>0 COMMIT
   
   deallocate cur_cuenta
   deallocate cur_area
   deallocate cur_ofi

  
   exec @w_error = cob_conta..sp_sasiento_val
        @i_operacion      = 'V',
        @i_empresa        = @i_filial,
        @i_producto       = @i_producto
   
   If @w_error != 0
   begin
      select @w_anexo = 'comprobante ' + convert(varchar, @w_comprobante)
      goto ERROR_SP
   end

   
   BEGIN TRAN
   
   -- PONER OK LOS COMPROBANTES DE ALINEACION QUE HAYAN PASADO A TABLAS DEFINITIVAS
   update cob_cartera..ca_cbte_alineacion
   set    ca_estado = 'OK'
   from   cob_conta_tercero..ct_scomprobante
   where  ca_fecha         = @i_fecha_comp
   and    ca_producto      = @i_producto
   and    ca_tipo          = @i_tipo
   and    sc_fecha_tran    = ca_fecha
   and    sc_producto      = ca_producto
   and    sc_comprobante   = ca_comprobante
   and    sc_empresa       = @i_filial
   
   COMMIT
   return 0
ERROR_SP:
   while @@trancount > 0 rollback
   
   return 0
end
                                                                                                                                                    
go
