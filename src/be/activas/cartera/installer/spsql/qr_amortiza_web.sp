use cob_cartera
go

if object_id ('sp_qr_table_amortiza_web') is not null
	drop procedure sp_qr_table_amortiza_web
go

create proc sp_qr_table_amortiza_web
(
    @i_banco  cuenta,  --Numero de prestamo
    @i_opcion char(1) = 'T' -- T: Todo, R: Rubros, I: Items, C: Consolidado
)
as
declare @w_operacionca             int,
        @w_num_cuota               int,
	   @w_saldo_cap                money,
        @w_i                       int,
        @w_j                       int,
        @w_query                   varchar(400),
		@w_error                   int,
		@w_sp_name                 varchar(25),
		@w_est_cancelado           tinyint,
        @w_est_novigente           tinyint,
        @w_est_vigente             tinyint,
        @w_est_castigado           tinyint,
        @w_est_vencido             tinyint,
        @w_desc_estado             varchar(64),
        @w_cuotas                  int,
        @w_fecha_proceso           datetime,
        @w_saldo_operacion_finan   money,
        @w_return                  int,
        @w_fecha                   datetime,
        @w_producto                tinyint,
        @w_numdec_op               smallint,
        @w_moneda                  smallint,
        @w_pago_condonado          char(1),
        @w_porcentaje              float
        

    select @w_sp_name = 'sp_qr_table_amortiza_web'
    select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
    select @w_producto = pd_producto
    from cobis..cl_producto
    where pd_abreviatura = 'CCA'
   
    select @w_fecha = convert(varchar(10),fc_fecha_cierre,101)
    from cobis..ba_fecha_cierre
    where fc_producto = @w_producto
          
    select @w_operacionca = op_operacion,
           @w_moneda      = op_moneda
    from   ca_operacion
    where  op_banco = @i_banco
    if @@rowcount = 0 
    begin
        select @w_error =  710201
        goto ERROR
    end
    
     exec @w_return = sp_decimales
         @i_moneda    = @w_moneda,
         @o_decimales = @w_numdec_op out

    delete ca_qr_rubro_tmp
    where  qrt_pid = @@spid

    delete ca_qr_amortiza_tmp
    where  qat_pid = @@spid
    
    
    insert into ca_qr_rubro_tmp (qrt_pid, qrt_rubro)
    select distinct @@spid, ro_concepto
      from ca_rubro_op
      where ro_operacion = @w_operacionca
      and   ro_fpago    in ('P','A','M','T')
      order by ro_concepto
    
    --Rubros
    if @i_opcion = 'R' or @i_opcion = 'T'
    begin
        select co_descripcion, co_concepto
        from ca_qr_rubro_tmp, ca_concepto
        where qrt_pid = @@spid
        and qrt_rubro = co_concepto
        order by qrt_id
    end


    if @i_opcion = 'I' or @i_opcion = 'T'
    begin
        exec @w_return = sp_validar_fecha
                @s_user                  = 'opebatch',
                @s_term                  = 'central',
                @s_date                  = @w_fecha ,
                @s_ofi                   = 1,
                @i_operacionca           = @w_operacionca,
                @i_debug                 = 'N' 
        
        select @w_porcentaje = pa_float from cobis..cl_parametro where pa_nemonico = 'POCODE'
        
        if exists (select 1
                   from cob_cartera..ca_abono,
                        cob_cartera..ca_abono_det
                   where ab_operacion      = @w_operacionca
                   and   ab_operacion      = abd_operacion
                   and   ab_secuencial_ing = abd_secuencial_ing
                   and   ab_estado         in ('A', 'NA', 'ING')
                   and   abd_tipo          = 'CON'
                   and   abd_concepto      in ('INT_ESPERA', 'IVA_ESPERA'))
            select @w_pago_condonado = 'S'
        
        select am_operacion, 
        am_dividendo,
        am_concepto,
        am_estado,
        am_periodo,
        am_cuota     = case when @w_pago_condonado = 'S' and am_concepto like '%ESPERA%' then am_cuota     - round(convert(money,am_cuota * @w_porcentaje),@w_numdec_op) else am_cuota end,
        am_gracia,
        am_pagado    = case when @w_pago_condonado = 'S' and am_concepto like '%ESPERA%' then am_pagado    - round(convert(money,am_cuota * @w_porcentaje),@w_numdec_op) else am_pagado end,
        am_acumulado = case when @w_pago_condonado = 'S' and am_concepto like '%ESPERA%' then am_acumulado - round(convert(money,am_cuota * @w_porcentaje),@w_numdec_op) else am_acumulado end
        into #ca_amortizacion_consulta
        from ca_amortizacion
        where am_operacion = @w_operacionca
        
        update #ca_amortizacion_consulta set
        am_pagado    = case when am_pagado < 0 then 0 else am_pagado end,
        am_acumulado = case when am_acumulado < 0 then 0 else am_acumulado end
               
        --INSERT DE CUOTA
        insert into ca_qr_amortiza_tmp (qat_pid, qat_dividendo, qat_fecha_ven, qat_dias_cuota, qat_cuota,qat_estado,qat_porroga)
        select @@spid, di_dividendo, di_fecha_ven,di_dias_cuota, 
        sum(am_cuota + am_gracia), 
        substring(es_descripcion,1,20),di_prorroga
        from ca_dividendo,#ca_amortizacion_consulta,ca_estado
        where di_operacion = @w_operacionca
        and   am_operacion = di_operacion
        and   am_dividendo = di_dividendo
        and  di_estado    = es_codigo
        group by di_operacion, di_dividendo,di_fecha_ven, di_dias_cuota , di_prorroga, es_descripcion

        --ACTUALIZAR VALORES DE CADA RUBRO
        select @w_j = min(qrt_id)
        from   ca_qr_rubro_tmp
        where  qrt_pid = @@spid

        select @w_i = @w_j
        while @w_i <= @w_j + 14
        begin
           drop table tmp_dividendo       
           select di_operacion ,di_dividendo, 'saldo_couta'= sum(am_cuota + am_gracia)
           into tmp_dividendo
		   from ca_dividendo, #ca_amortizacion_consulta, ca_qr_rubro_tmp, ca_qr_amortiza_tmp where di_operacion = @w_operacionca
           and am_operacion = di_operacion and am_dividendo = di_dividendo and qat_dividendo = di_dividendo 
           and am_concepto = qrt_rubro and qrt_id = @w_i and qat_pid = @@spid and qat_pid = qrt_pid
           group by di_operacion , di_dividendo
           
            select @w_query = 'update ca_qr_amortiza_tmp set qat_rubro' + convert (varchar, @w_i + 1 - @w_j) + ' = saldo_couta ' + char(13) +
            'from tmp_dividendo, ca_amortizacion, ca_qr_rubro_tmp where di_operacion = ' + convert(varchar,@w_operacionca) + char(13) +
            'and am_operacion = di_operacion and am_dividendo = di_dividendo and qat_dividendo = di_dividendo ' + char(13) +
            'and am_concepto = qrt_rubro and qrt_id = ' + convert(varchar, @w_i) + ' and qat_pid = ' + convert(varchar,@@spid) + char(13) +
            'and qat_pid = qrt_pid'

            execute (@w_query)

            select @w_i = @w_i + 1
        end

        --ACTUALIZACION DE VALORES DE RUBROS NEGATIVOS A CERO
        select @w_i = 1
        while @w_i <= 15
        begin
            select @w_query = 'update ca_qr_amortiza_tmp set qat_rubro' + convert (varchar, @w_i) + ' = 0 where qat_rubro' + convert (varchar, @w_i) + ' <0 ' +
            'and qat_pid = ' +  convert(varchar,@@spid)

            execute (@w_query)
            select @w_i = @w_i + 1
        end

        --ACTUALIZACION DE VALORES DE CUOTA NEGATIVA A CERO
        update ca_qr_amortiza_tmp
        set    qat_cuota = 0
        where  qat_cuota <0
        and    qat_pid = @@spid

        --ACTUALIZACION DE COLUMNA SALDO DE CAPITAL
        select @w_num_cuota = 1
        while 1 = 1
        begin
            select @w_saldo_cap = 0

            select @w_saldo_cap = sum(qat_rubro1)
            from   ca_qr_amortiza_tmp
            where  qat_dividendo >= @w_num_cuota
            and    qat_pid = @@spid

            if isnull(@w_saldo_cap, 0) = 0
            break

            update ca_qr_amortiza_tmp
            set    qat_saldo_cap = @w_saldo_cap
            where  qat_dividendo = @w_num_cuota
            and    qat_pid = @@spid

            select @w_num_cuota = @w_num_cuota + 1
        end
   
        
        select qat_dividendo,
               qat_fecha_ven,
               qat_dias_cuota,
               qat_saldo_cap,
               isnull(qat_rubro1,0)qat_rubro1,
               isnull(qat_rubro2,0)qat_rubro2,
               isnull(qat_rubro3,0)qat_rubro3,
               isnull(qat_rubro4,0)qat_rubro4,
               isnull(qat_rubro5,0)qat_rubro5,
               isnull(qat_rubro6,0)qat_rubro6,
               isnull(qat_rubro7,0)qat_rubro7,
               isnull(qat_rubro8,0)qat_rubro8,
               isnull(qat_rubro9,0)qat_rubro9,
               isnull(qat_rubro10,0)qat_rubro10,
               isnull(qat_rubro11,0)qat_rubro11,
               isnull(qat_rubro12,0)qat_rubro12,
               isnull(qat_rubro13,0)qat_rubro13,
			isnull(qat_rubro14,0)qat_rubro14,
			isnull(qat_rubro15,0)qat_rubro15,
               qat_cuota,
               qat_estado,
               qat_porroga
        from   ca_qr_amortiza_tmp
        where  qat_pid = @@spid
        order by qat_dividendo
    end

    if @i_opcion = 'C'
    begin
           
           exec @w_error = sp_estados_cca
                @o_est_vigente    = @w_est_vigente   out,
                @o_est_cancelado  = @w_est_cancelado out,
                @o_est_novigente  = @w_est_novigente out,
                @o_est_vencido    = @w_est_vencido   out
                
           create table #tmp_total
           (tt_estado   varchar(64) not null,
            tt_capital  money           null,
            tt_interes  money           null,            
            tt_mora     money           null,
            tt_int_mora money           null,
            tt_otros    money           null,
            tt_total    money           null,
            tt_pagos    int             null
           )
           
           --Vencidos
           select @w_cuotas = 0
           select @w_desc_estado = es_descripcion
           from cob_cartera..ca_estado	   
           where es_codigo = @w_est_vencido
           
           select @w_cuotas  = isnull(count(di_dividendo),0)
           from cob_cartera..ca_dividendo
           where di_operacion = @w_operacionca
           and   (di_estado   = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
               
           
           select 'Concepto' = am_concepto, 
                  'Valor'    =  round(isnull(sum(am_acumulado + am_gracia - am_pagado),0), @w_numdec_op)                 
           into #tmp_vencidos       
           from cob_cartera..ca_dividendo,
                cob_cartera..ca_amortizacion
           where di_operacion = @w_operacionca
           and   am_operacion = di_operacion
           and   di_dividendo = am_dividendo 
           and   (di_estado    = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
           group by am_concepto
           
                 
           insert into #tmp_total
                  (tt_estado     ,tt_capital  ,tt_interes, tt_mora, tt_int_mora, tt_otros, tt_pagos )
           select @w_desc_estado,
                  tt_capital = (select isnull(sum(Valor),0)
                                from   #tmp_vencidos
                                where  Concepto = 'CAP' 
                               ),  
                  tt_interes = (select isnull(sum(Valor),0)
                                from   #tmp_vencidos
                                where  Concepto = 'INT'
                                ),
                  tt_mora    =  (select isnull(sum(Valor),0)
                                from   #tmp_vencidos
                                where  Concepto = 'IMO'
                                ),     
                  tt_int_mora=  (select isnull(sum(Valor),0)
                                from   #tmp_vencidos
                                where  Concepto in ('INT', 'IMO')  
                                ),                     
                  tt_otros   = (select  isnull(sum(Valor),0)
                                from   #tmp_vencidos
                                where  Concepto not in ('CAP', 'INT')  
                                ),
                  tt_pagos    = @w_cuotas
           --No Vigentes y Vigentes
           select @w_cuotas = 0
           select @w_desc_estado = es_descripcion
           from cob_cartera..ca_estado
           where es_codigo = @w_est_vigente
           
           select 'Concepto' = am_concepto, 
                  'Valor'    = round(isnull(sum(am_acumulado + am_gracia - am_pagado),0), @w_numdec_op)          
           into #tmp_no_vigente       
           from cob_cartera..ca_dividendo,
                cob_cartera..ca_amortizacion
           where di_operacion = @w_operacionca
           and   am_operacion = di_operacion
           and   di_dividendo = am_dividendo 
           and   di_estado    in (@w_est_novigente, @w_est_vigente)
           and   di_fecha_ven > @w_fecha_proceso
           group by am_concepto
           
           select @w_cuotas  = isnull(count(di_dividendo),0)
           from cob_cartera..ca_dividendo
           where di_operacion = @w_operacionca
           and   di_estado    in (@w_est_novigente, @w_est_vigente)
           
           insert into #tmp_total
           (tt_estado     ,tt_capital  ,tt_interes,  tt_mora, tt_int_mora, tt_otros,tt_pagos    )
            select @w_desc_estado,
                   tt_capital = (select isnull(sum(Valor),0)
                                 from   #tmp_no_vigente
                                 where  Concepto = 'CAP' 
                                 ),  
                   tt_interes = (select isnull(sum(Valor),0)
                                 from   #tmp_no_vigente
                                 where  Concepto = 'INT'
                                 ),
                   tt_mora    =  (select isnull(sum(Valor),0)
                                  from   #tmp_no_vigente
                                  where  Concepto = 'IMO'
                                  ),   
                   tt_int_mora = (select  isnull(sum(Valor),0)
                                 from   #tmp_no_vigente
                                  where  Concepto in ('INT','IMO') 
                                 ),
                   tt_otros    = (select  isnull(sum(Valor),0)
                                  from   #tmp_no_vigente
                                  where  Concepto not in ('CAP', 'INT')  
                                  ),
                   tt_pagos    = @w_cuotas
            -- Cancelados
            /*select @w_cuotas = 0
            select @w_desc_estado = es_descripcion
            from cob_cartera..ca_estado 
            where es_codigo = @w_est_cancelado
                  
            select 'Concepto' = am_concepto, 
                   'Valor'    = sum(am_pagado)       
            into #tmp_cancelado       
            from cob_cartera..ca_dividendo,
                 cob_cartera..ca_amortizacion
            where di_operacion = @w_operacionca
            and   am_operacion = di_operacion
            and   di_dividendo = am_dividendo 
            group by am_concepto
            
            select @w_cuotas  = isnull(count(di_dividendo),0)
            from cob_cartera..ca_dividendo
            where di_operacion = @w_operacionca
            and   di_estado    = @w_est_cancelado
            
             
            insert into #tmp_total
            (tt_estado     ,tt_capital  ,tt_interes, tt_mora, tt_int_mora, tt_otros,tt_pagos    )
            select @w_desc_estado,
                   tt_capital = (select isnull(sum(Valor),0)
                                 from   #tmp_cancelado
                                 where  Concepto = 'CAP' 
                                 ),  
                   tt_interes = (select isnull(sum(Valor),0)
                                 from   #tmp_cancelado
                                 where  Concepto = 'INT'
                                 ),
                    tt_mora    = (select isnull(sum(Valor),0)
                                  from   #tmp_cancelado
                                  where  Concepto = 'IMO'
                                  ), 
                   tt_int_mora = (select isnull(sum(Valor),0)
                                  from   #tmp_cancelado
                                  where  Concepto in ('INT','IMO')  
                                 ),
                   tt_otros    = (select  isnull(sum(Valor),0)
                                  from   #tmp_cancelado
                                  where  Concepto not in ('CAP', 'INT','IMO')  
                                ),
                   tt_pagos    = @w_cuotas*/
           update #tmp_total
           set tt_total = round(isnull(tt_capital,0) + isnull(tt_interes,0) + isnull(tt_otros,0),@w_numdec_op)
           
           
           select * 
           from #tmp_total            
    end   
    return 0

ERROR:

exec cobis..sp_cerror
     @t_debug = 'N',
     @t_from  = @w_sp_name,
     @i_num   = @w_error

return @w_error
go

