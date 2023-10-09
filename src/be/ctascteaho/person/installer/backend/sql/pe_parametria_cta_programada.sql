print '--------------------------------------------------'
PRINT 'AHORRO PROGRAMADO'
print '--------------------------------------------------'
use cob_remesas
go

set nocount on
        
declare @w_return               int,
        @w_codigo               int,
        @w_pro_final            int,
        @w_descripcion          varchar(100),
        @w_descripcion_profinal varchar(100),
        @w_tipo_rango_disp      int,
        @w_mercado              int,
        @w_ser_per              int,
        @w_grupo_rango_disp     int,
        @w_servicio_disponible  int,
        @w_rubro                varchar(5),  
        @w_costo                int,
        @w_fecha_proceso        datetime,
        @w_tipo_ente            char(1),
        @w_while1                int,
        @w_while2                int,
        @w_categoria            char(1),
        @w_categoria_p          char(1),
        @w_costo_actual         varchar(50),
        @w_minimo               money,
        @w_base                 money,
        @w_maximo               money,
        @w_contador_costos      int,
        @w_msg_error            varchar(50)

select @w_descripcion = 'AHORRO PROGRAMADO',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

-- borrado de pe_categoria_profinal       
delete cob_remesas..pe_categoria_profinal WHERE cp_categoria in ('N')

----------------------------------------------------------------------------------------------------------------------------
--- Tipo Rango sobre DISPONIBLE (para MMAP y SMS)
    if exists(select 1 from cob_remesas..pe_tipo_rango WHERE upper(tr_descripcion) like upper('%RUBRO SOBRE SALDO DISPONIBLE%') and tr_estado = 'V')    
    begin
        select @w_tipo_rango_disp = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'  and tr_estado = 'V'
        print 'Elegido pe_tipo_rango : ' + cast (@w_tipo_rango_disp as varchar)
    end
    else 
    begin
        exec @w_return = cobis..sp_cseqnos
             @i_tabla     = 'pe_tipo_rango',
             @o_siguiente = @w_tipo_rango_disp out
        if @w_return <> 0 print 'Error en la obtencion de secuencial pe_tipo_rango'
        INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
        VALUES (@w_tipo_rango_disp, 'RUBRO SOBRE SALDO DISPONIBLE', 'E', 0, 'V')    
        if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
        else print 'Creación pe_tipo_rango DISP : ' + cast (@w_tipo_rango_disp as varchar)
    end
    -- Rango
    if exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta >= 999999999.99  and ra_estado = 'V')
    begin
        select @w_grupo_rango_disp = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta >= 999999999.99  and ra_estado = 'V'
        print 'Elegido pe_rango : '  + cast (@w_grupo_rango_disp as varchar)
    end 
    else 
    begin
        select @w_grupo_rango_disp = isnull(max(ra_grupo_rango)+1,1) from cob_remesas..pe_rango
        INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
        VALUES (@w_tipo_rango_disp, @w_grupo_rango_disp , 1, 0, 999999999.99, 'V')
        if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
        else print 'Creación pe_rango DISP : '  + cast (@w_grupo_rango_disp as varchar)
    end
----------------------------------------------------------------------------------------------------------------------------
--- Producto Bancario
    if exists(select 1 from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion)
    begin
        select @w_codigo = pb_pro_bancario from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion
        print 'Producto Bancario: ' + cast(@w_codigo as varchar)
    end 
    else
    begin
        exec @w_return    = cobis..sp_cseqnos
             @i_tabla     = 'pe_pro_bancario',
             @o_siguiente = @w_codigo out
        if @w_return != 0 print 'Error al obtener secuencial pe_pro_bancario'
        INSERT INTO cob_remesas..pe_pro_bancario (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
        values (@w_codigo,@w_descripcion,'V',@w_fecha_proceso)    
        if @@error != 0 print 'Error en la inserccion de registro en pe_pro_bancario'
        else print 'Creación Producto Bancario: ' + cast(@w_codigo as varchar)
    end
----------------------------------------------------------------------------------------------------------------------------
--- Parametro PAHCT
    if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PAHCT')
    begin
        update cobis..cl_parametro set pa_int = @w_codigo where pa_nemonico = 'PAHCT'
        print 'Actualización PAHCT : ' + cast(@w_codigo as varchar)
    end    
    else
    begin
        INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
        VALUES (@w_descripcion, 'PAHCT', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')
        print 'Creación PAHCT : ' + cast(@w_codigo as varchar)
    end

----------------------------------------------------------------------------------------------------------------------------
--- DOBLE CICLO PARA 1. PERSONAS  2. COMPANIAS
SELECT @w_while1 = 1
WHILE (@w_while1 < 3)
BEGIN
    if (@w_while1 = 1)
    begin
        print ''
        print '----- MERCADO PERSONA -----'
        select @w_descripcion_profinal = 'AHORRO PROGRAMADO - PER.NAT.'
        select @w_tipo_ente  = 'P'    
    end
    
    if (@w_while1 = 2)
    begin
        print ''
        print '----- MERCADO COMPANIA -----'
        select @w_descripcion_profinal = 'AHORRO PROGRAMADO - COMPANIA.'
        select @w_tipo_ente  = 'C'
    end
    
    SELECT @w_while1 = @w_while1 + 1
    
    ----------------------------------------------------------------------------------------------------------------------------
    --- Mercado        
        if exists (select 1 from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente)
        begin
            select @w_mercado = me_mercado from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente
            print 'Mercado Elegido: ' + cast(@w_mercado as varchar)
        end
        else
        begin
            exec @w_return = cobis..sp_cseqnos
                 @i_tabla     = 'pe_mercado',
                 @o_siguiente = @w_mercado out
            if @w_return <> 0 print 'Error al obtener secuencial pe_mercado'
            INSERT INTO cob_remesas..pe_mercado (me_pro_bancario, me_tipo_ente, me_mercado, me_estado, me_fecha_estado) 
            VALUES (@w_codigo, @w_tipo_ente, @w_mercado, 'V', @w_fecha_proceso)
            if @@error <> 0 print 'Error en la inserccion de registro en pe_mercado'
            else print 'Creación Mercado: ' + cast(@w_mercado as varchar)
        end
    ----------------------------------------------------------------------------------------------------------------------------
    --- Producto Final
        if exists (select 1 from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1)
        begin
            select @w_pro_final = pf_pro_final from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1
            update cob_remesas..pe_pro_final  set
            pf_descripcion = @w_descripcion_profinal,
            pf_depende = null,
            pf_provisiona = 'S',
            pf_cod_rango_edad = 2
            WHERE pf_pro_final = @w_pro_final and pf_mercado = @w_mercado
            print 'Actualización Producto Final: ' + cast(@w_pro_final as varchar)
        end
        else 
        begin
            exec @w_return = cobis..sp_cseqnos
                 @i_tabla     = 'pe_pro_final',
                 @o_siguiente = @w_pro_final out
            if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
            INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
            values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion_profinal,null,'S',2)
            if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
            else print 'Creación Prod. Final: ' + convert(varchar(10),@w_pro_final)
        end
    ----------------------------------------------------------------------------------------------------------------------------
    --- Categoria ProFinal D
        select @w_categoria = 'D'
	
        if exists( select 1 from cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria)
            delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria
        
        insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual,cp_dias_plazo) 
        values (@w_pro_final,@w_categoria,'S','S', NULL)
        if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
        else print 'Creación Categoria Profinal: ' + cast(@w_pro_final as varchar) + ' ---> D'
    --- Categoria ProFinal P
		select @w_categoria_p = pa_char
		from cobis..cl_parametro
		where pa_producto = 'AHO'
		and pa_nemonico = 'CAMCAT'
	
        if exists( select 1 from cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria_p)
            delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria_p
        
        insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual,cp_dias_plazo) 
        values (@w_pro_final,@w_categoria_p,'S','S', NULL)
        if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
        else print 'Creación Categoria Profinal: ' + cast(@w_pro_final as varchar) + ' ---> D'

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- CONTRACTUAL D
		if exists( select 1 from cob_remesas..pe_producto_contractual WHERE pc_profinal =  @w_pro_final and pc_categoria = @w_categoria)
		delete cob_remesas..pe_producto_contractual WHERE pc_profinal =  @w_pro_final and pc_categoria = @w_categoria
	
		INSERT INTO cob_remesas..pe_producto_contractual
		(pc_profinal, pc_categoria, pc_plazo, pc_plazo_neg,
		pc_cuota, pc_cuota_neg, pc_periodicidad, pc_monto_final,
		pc_dias_max_mora, pc_estado, pc_ptos_premio, pc_fecha_crea, 
		pc_fecha_upd, pc_plan_pago)
		values
		(@w_pro_final,@w_categoria,3,'S',
		1000,'S','M', 3 * 1000, 
		0, 'V', 10,  @w_fecha_proceso, 
		@w_fecha_proceso, 'S')

	----------------------------------------------------------------------------------------------------------------------------
    --- Capitaliza ProFinal
        if exists( select 1 from cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp)
            delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp
        
        insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) 
        values (@w_pro_final,'M',1)  -- @w_tipo_rango_disp
        if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
        else print 'Creación Capitaliza Profinal - Rango ' + cast(@w_tipo_rango_disp as varchar)

    ----------------------------------------------------------------------------------------------------------------------------
    --- Ciclo ProFinal
        if exists( select 1 from cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final)              
            delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final

        insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,3)  -- 3 = 30 de cada mes
        if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
        else print 'Creación Ciclo ProFinal: ' + cast(@w_pro_final as varchar)

    ----------------------------------------------------------------------------------------------------------------------------
    --- Oficina Autorizada
        if exists( select 1 from cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo)
            delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo

        insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
        values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
        if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
        else print 'Creación Oficina Autorizada 1: ' + cast(@w_codigo as varchar)

        insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
        values (4,@w_codigo,7020,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
        if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
        else print 'Creación Oficina Autorizada 7020: ' + cast(@w_codigo as varchar)        
    ----------------------------------------------------------------------------------------------------------------------------
    --- WHILE DE CREACION DE COSTOS

    if exists(select 1 from tempdb..sysobjects where upper(name) like upper('%costos_contrac%'))
    begin
        drop table #costos_contrac
        
        if (@@error > 0)
        begin
            SELECT @w_msg_error = 'ERROR AL ELIMINAR LA TABLA #costos_contrac'
           --    GOTO ERROR
        end 
    end
        
    create table #costos_contrac (
        id                  INT         IDENTITY,
        costo_actual        varchar(50) null,
        servicio_disponible int         null,
        rubro               varchar(10) null,
        minimo              money       null,
        base                money       null,
        maximo              money       null
    )
        
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('MMAP',28,'39',80, 150, 250)                -- 'MMAP' -- 'MONTO MINIMO APERTURA' -- 'pe_rubro'  'MONTO MINIMO'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('SALDO MIN/MAX',50,'SMI',1000, 1400.00, 1500.00) -- 'MMAP' -- 'MONTO MINIMO APERTURA' -- 'pe_rubro'  'MONTO MINIMO'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('SALDO MIN/MAX',50,'SMA',10000,10000,10000) -- 'SMC'  -- 'SALDO MINIMO' -- 'pe_rubro'  'SALDO MAXIMO DE LA CUENTA'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('CIERRE DE CUENTAS',14,'22',5,10,20)        -- 'CCTA' -- 'CIERRE DE CUENTAS' -- 'pe_rubro'  'MULTA POR GASTOS DE MANEJO'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('CIERRE DE CUENTAS',14,'3',3.50,3.60,3.70)  -- 'CCTA' -- 'CIERRE DE CUENTAS' -- 'pe_rubro'  'DEDUCCION DE INTERES CIERRE ANTICIPADO'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('CIERRE DE CUENTAS',14,'41',5,10,20)        -- 'CCTA' -- 'CIERRE DE CUENTAS' -- 'pe_rubro'  'CARGO CIERRE CUENTA ANTES DE TIEMPO'
    -- insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('PINT',1,'23',0,0,0)                     -- 'PINT' -- 'PAGO DE INTERES' -- 'pe_rubro'  'Interes por Cierre (JCA)'
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('PINT',1,'18',4.25,4.50,5.00)               -- 'PINT' -- 'PAGO DE INTERES' -- 'pe_rubro'  'PAGO INT. SOBRE EL DISPONIBLE'
    -- insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('PINT',1,'2',1.12,1.25,1.50)             -- RETENCION IMPUESTO POR INTERESSELECT
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('SECU',10,'15',1.00, 1.25, 1.50)            -- COSTO EXTRACTO CUENTA
    insert into #costos_contrac (costo_actual, servicio_disponible, rubro, minimo, base, maximo) values ('CDEV',7,'11',1.00, 1.25, 1.50)             -- COSTO DEVOLUCION CHEQUE

	select @w_contador_costos = count(1) from #costos_contrac
	SELECT @w_while2 = 0
    
    WHILE (@w_while2 < @w_contador_costos)
    BEGIN
     
        select @w_while2 = @w_while2 + 1
        select @w_costo_actual  = costo_actual,
        @w_servicio_disponible = servicio_disponible,
        @w_rubro  = rubro,        
        @w_minimo = minimo, 
        @w_base   = base, 
        @w_maximo = maximo
        from #costos_contrac
        where id = @w_while2
        
        select @w_costo_actual,@w_servicio_disponible,@w_rubro
        print ' ----------------------------------- '
        print 'Servicio Disponible ' + @w_costo_actual + ': ' + convert(varchar(10),@w_servicio_disponible)
        print 'Rubro ' + @w_costo_actual + ': ' + convert(varchar(10),@w_rubro)

        if exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
        begin
            update cob_remesas..pe_servicio_per 
            set sp_grupo_rango = @w_grupo_rango_disp,
            sp_tipo_rango = @w_tipo_rango_disp
            where  sp_pro_final = @w_pro_final 
            and sp_servicio_dis = @w_servicio_disponible 
            and sp_rubro = @w_rubro 
                
            select @w_ser_per = sp_servicio_per 
            from cob_remesas..pe_servicio_per
            where sp_pro_final = @w_pro_final 
            and sp_servicio_dis = @w_servicio_disponible 
            and sp_rubro = @w_rubro 
            and sp_tipo_rango = @w_tipo_rango_disp 
            and sp_grupo_rango = @w_grupo_rango_disp
            print 'Ya existe Servicio PER: ' + convert(varchar(10),@w_ser_per)
        end
        else
        begin
            exec @w_return = cobis..sp_cseqnos
                 @i_tabla     = 'pe_servicio_per',
                 @o_siguiente = @w_ser_per out
            if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
            INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
            VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_disp, @w_grupo_rango_disp)
            if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
            else print 'Creación Servicio PER: ' + convert(varchar(10),@w_ser_per)
        end 

    ----------------------------------------------------------------------------------------------------------------------------
    --- Categoria ProFinal D	
		print 'CATEGORIA ' + @w_categoria
		if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria) 
		begin
			delete cob_remesas..pe_costo 
			where co_servicio_per = @w_ser_per 
			and co_categoria = @w_categoria 
		end
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_costo',
			 @o_siguiente = @w_costo out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
		INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_minimo, co_val_medio, co_maximo, co_fecha_vigencia, co_usuario)
		VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, @w_tipo_rango_disp, @w_minimo, @w_base, @w_maximo, @w_fecha_proceso, 'admuser') 
		if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
		else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
		
		if exists (select 1 from cob_remesas..pe_cambio_costo where cc_servicio_per = @w_ser_per and cc_categoria = @w_categoria) 
		begin
			delete cob_remesas..pe_cambio_costo 
			where cc_servicio_per = @w_ser_per 
			and cc_categoria = @w_categoria 
		end
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_cambio_costo',
			 @o_siguiente = @w_costo out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_cambio_costo'
		INSERT INTO cob_remesas..pe_cambio_costo (cc_secuencial, cc_servicio_per, cc_categoria, cc_tipo_rango, cc_grupo_rango, cc_rango, cc_minimo, cc_val_medio, cc_maximo, cc_fecha_vigencia, cc_fecha_cambio, cc_operacion, cc_tipo, cc_en_linea)
		VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, @w_tipo_rango_disp, @w_minimo, @w_base, @w_maximo, @w_fecha_proceso, @w_fecha_proceso, 'I', 'I', 'S') 
		if @@error != 0 print 'Error en la inserccion de registro en pe_cambio_costo'
		else print 'Creación Costo: ' + convert(varchar(10),@w_costo)		    
		
    ----------------------------------------------------------------------------------------------------------------------------
    --- Categoria ProFinal P
		print 'CATEGORIA ' + @w_categoria_p 
		if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria_p) 
		begin
			delete cob_remesas..pe_costo 
			where co_servicio_per = @w_ser_per 
			and co_categoria = @w_categoria_p 
		end
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_costo',
			 @o_siguiente = @w_costo out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
		INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_minimo, co_val_medio, co_maximo, co_fecha_vigencia, co_usuario)
		VALUES (@w_costo, @w_ser_per, @w_categoria_p, @w_tipo_rango_disp, @w_grupo_rango_disp, @w_tipo_rango_disp, @w_minimo, @w_base, @w_maximo, @w_fecha_proceso, 'admuser') 
		if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
		else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
		
		if exists (select 1 from cob_remesas..pe_cambio_costo where cc_servicio_per = @w_ser_per and cc_categoria = @w_categoria_p) 
		begin
			delete cob_remesas..pe_cambio_costo 
			where cc_servicio_per = @w_ser_per 
			and cc_categoria = @w_categoria_p 
		end
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_cambio_costo',
			 @o_siguiente = @w_costo out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_cambio_costo'
		INSERT INTO cob_remesas..pe_cambio_costo (cc_secuencial, cc_servicio_per, cc_categoria, cc_tipo_rango, cc_grupo_rango, cc_rango, cc_minimo, cc_val_medio, cc_maximo, cc_fecha_vigencia, cc_fecha_cambio, cc_operacion, cc_tipo, cc_en_linea)
		VALUES (@w_costo, @w_ser_per, @w_categoria_p, @w_tipo_rango_disp, @w_grupo_rango_disp, @w_tipo_rango_disp, @w_minimo, @w_base, @w_maximo, @w_fecha_proceso, @w_fecha_proceso, 'I', 'I', 'S') 
		if @@error != 0 print 'Error en la inserccion de registro en pe_cambio_costo'
		else print 'Creación Costo: ' + convert(varchar(10),@w_costo)		    
	
	END
end    

go
    