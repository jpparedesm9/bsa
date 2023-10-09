/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 09/08/2016 
--Descripción del Problema	: Creación Categorias para Aporte Social y Campo para Capitalización ProFinal
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-----------------------------------
-- CATEGORIAS PARA APORTE SOCIAL -- pe_catlgo.sql
-----------------------------------
print '=====> Creación Categorias Aporte Social'
declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'pe_categoria'
if exists(select 1 from cobis..cl_catalogo where tabla = @w_codigo and codigo = 'R')
	delete from cobis..cl_catalogo where tabla = @w_codigo and codigo = 'R'
if exists(select 1 from cobis..cl_catalogo where tabla = @w_codigo and codigo = 'A')
	delete from cobis..cl_catalogo where tabla = @w_codigo and codigo = 'A'

insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'R', 'Aporte Social Ordinario','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A', 'Aporte Social Adicional','V')


-------------------------------------------------
-- CAMPO cp_dias_capi en pe_categoria_profinal -- pe_table.sql
-------------------------------------------------

use cob_remesas
go
print '====> cob_remesas..pe_categoria_profinal'
if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_categoria_profinal' AND COLUMN_NAME = 'cp_dias_plazo') 
BEGIN
      ALTER TABLE cob_remesas..pe_categoria_profinal 
	  add cp_dias_plazo int  null          
end  
go


-------------------------------------------------
-- VISTA Tran_servicio guardar 3 campos nuevos -- ah_view.sql 
-------------------------------------------------

use cob_ahorros
go

print '--------------> ah_tsapertura'
go
if exists (select 1 from sysobjects where type='V' and name='ah_tsapertura')
    drop view ah_tsapertura
go

create view ah_tsapertura (
       secuencial,    ssn_branch,        tipo_transaccion, oficina,
       usuario,       terminal,          reentry,
       clase,         tsfecha,           origen,
       cuenta,        cta_banco,         filial, 
       oficial,       fecha_aper,        cliente,        ced_ruc,    estado,
       direccion_ec,  ciclo,             categoria,      producto,   tipo,
       moneda,        def,               tipo_def,       rol_ente,   microficha, 
       tipo_promedio, alterno,           descripcion_ec, cliente_ec,
       tipo_interes,  capitalizacion,    ctafun,         mercantil,
       tipocta,       producto_bancario, origen_cta,     numlib,     accion,
       monto,         oficina_cta,       hora,
       prod_banc,     nombre1,           cedula1,
       promotor,      tipocta_super,     direccion_dv,   descripcion_dv,
       tipodir_dv,    turno,             estado_cta,     permite_sldcero, fideicomiso,
       clase_clte,    nxmil,             observacion,    marca_gmf, fec_marca_gmf,
	   valor,         dias_plazo,        cta_relacionada
) as
select ts_secuencial,   ts_ssn_branch,     ts_tipo_transaccion, ts_oficina, 
       ts_usuario,      ts_terminal,       ts_reentry,
       ts_clase,        ts_tsfecha,        ts_origen,
       ts_ctacte,       ts_cta_banco,      ts_filial, 
       ts_oficial,      ts_fecha_aper,     ts_cliente,     ts_ced_ruc,   ts_estado,
       ts_direccion_ec, ts_ciclo,          ts_categoria,   ts_producto,  ts_tipo,
       ts_moneda,       ts_default,        ts_tipo_def,    ts_rol_ente,  ts_endoso, 
       ts_tipo_promedio,ts_cod_alterno,    ts_descripcion_ec, ts_cheque,
       ts_tipo_interes, ts_capitalizacion, ts_cta_funcionario, ts_mercantil,
       ts_tipocta,      ts_departamento,   ts_causa,       ts_numlib,    ts_accion, ts_monto,
       ts_oficina_cta,  ts_hora,
       ts_prod_banc,    ts_nombre1,        ts_cedruc1,
       ts_ofi_aut,      ts_tipocta_super,  ts_ofi_anula,   ts_autoriz_aut,
       ts_clase_np,     ts_turno,          ts_causa_np,    ts_orden,     ts_cta_banco_dep,
       ts_clase_clte,   ts_nxmil,          ts_observacion, ts_marca_gmf, ts_fec_marca_gmf,
	   ts_valor,        ts_secuencia,      ts_cta_gir
from    ah_tran_servicio
where   ts_tipo_transaccion in (201, 202, 205)
go


use cobis
go


-- pe_parametria.sql

print '--------------------------------------------------'
PRINT 'APORTE SOCIAL ORDINARIO'
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
		@w_ciclo			    int,
		@w_categoria            char(1)

select @w_descripcion = 'APORTE SOCIAL ORDINARIO',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

-- borrado de pe_categoria_profinal	   
delete cob_remesas..pe_categoria_profinal WHERE cp_categoria in ('A','R')

----------------------------------------------------------------------------------------------------------------------------
--- Tipo Rango sobre DISPONIBLE (para MMAP y SMS)
	if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'SOBRE SALDO DISPONIBLE' and tr_estado = 'V')    
	begin
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_tipo_rango',
			 @o_siguiente = @w_tipo_rango_disp out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_tipo_rango'
		INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
		VALUES (@w_tipo_rango_disp, 'SOBRE SALDO DISPONIBLE', 'R', 0, 'V')    
		if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
		else print 'Creación pe_tipo_rango DISP : ' + cast (@w_tipo_rango_disp as varchar)
	end
	else 
	begin
		select @w_tipo_rango_disp = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'SOBRE SALDO DISPONIBLE'  and tr_estado = 'V'
		print 'Elegido pe_tipo_rango : ' + cast (@w_tipo_rango_disp as varchar)
	end
	-- Rango
	if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
	begin
		select @w_grupo_rango_disp = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
		INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
		VALUES (@w_tipo_rango_disp, @w_grupo_rango_disp , @w_tipo_rango_disp, 0, 999999, 'V')
		if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
		else print 'Creación pe_rango DISP : '  + cast (@w_grupo_rango_disp as varchar)
	end
	else 
	begin
		select @w_grupo_rango_disp = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'
		print 'Elegido pe_rango : '  + cast (@w_grupo_rango_disp as varchar)
	end 
----------------------------------------------------------------------------------------------------------------------------
--- Producto Bancario
	if not exists(select 1 from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion)
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
	else
	begin
		select @w_codigo = pb_pro_bancario from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion
		print 'Producto Bancario: ' + cast(@w_codigo as varchar)
	end 
----------------------------------------------------------------------------------------------------------------------------
--- Parametro PCAASO
	if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PCAASO')
	begin
		INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
		VALUES (@w_descripcion, 'PCAASO', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')
		print 'Creación PCAASO : ' + cast(@w_codigo as varchar)
	end
	else
	begin
		update cobis..cl_parametro set pa_int = @w_codigo where pa_nemonico = 'PCAASO'
		print 'Actualización PCAASO : ' + cast(@w_codigo as varchar)
	end	


SELECT @w_ciclo = 1
WHILE (@w_ciclo < 3)
BEGIN
	if (@w_ciclo = 1)
	begin
		print ''
		print '----- MERCADO PERSONA -----'
		select @w_descripcion_profinal = 'APORTE SOCIAL ORDINARIO - PER.NAT.'
		select @w_tipo_ente  = 'P'	
	end
	
	if (@w_ciclo = 2)
	begin
		print ''
		print '----- MERCADO COMPANIA -----'
		select @w_descripcion_profinal = 'APORTE SOCIAL ORDINARIO - COMPANIA.'
		select @w_tipo_ente  = 'C'
	end
	
	SELECT @w_ciclo = @w_ciclo + 1
	
	----------------------------------------------------------------------------------------------------------------------------
	--- Mercado		
		if not exists (select 1 from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente)
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
		else
		begin
			select @w_mercado = me_mercado from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente
			print 'Mercado Elegido: ' + cast(@w_mercado as varchar)
		end
	----------------------------------------------------------------------------------------------------------------------------
	--- Producto Final
		if not exists (select 1 from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1)
		begin
			exec @w_return = cobis..sp_cseqnos
				 @i_tabla     = 'pe_pro_final',
				 @o_siguiente = @w_pro_final out
			if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
			INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
			values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion_profinal,null,'N',2)
			if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
			else print 'Creación Prod. Final: ' + convert(varchar(10),@w_pro_final)
		end
		else
		begin
			select @w_pro_final = pf_pro_final from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1
			update cob_remesas..pe_pro_final  set
			pf_descripcion = @w_descripcion_profinal,
			pf_depende = null,
			pf_provisiona = 'N',
			pf_cod_rango_edad = 2
			WHERE pf_pro_final = @w_pro_final and pf_mercado = @w_mercado
			print 'Actualización Producto Final: ' + cast(@w_pro_final as varchar)
		end
	----------------------------------------------------------------------------------------------------------------------------
	--- Categoria ProFinal
        select @w_categoria = 'R'
		if exists( select 1 from cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria)
			delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = 'R'
		
		insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual,cp_dias_plazo) 
		values (@w_pro_final,@w_categoria,'S','N',0)
		if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
		else print 'Creación Categoria Profinal: ' + cast(@w_pro_final as varchar) + ' ---> R'
	----------------------------------------------------------------------------------------------------------------------------
	--- Capitaliza ProFinal
		if exists( select 1 from cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp)
			delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp
		
		insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) 
		values (@w_pro_final,'M',@w_tipo_rango_disp)
		if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
		else print 'Creación Capitaliza Profinal - Rango ' + cast(@w_tipo_rango_disp as varchar)

	----------------------------------------------------------------------------------------------------------------------------
	--- Ciclo ProFinal
		if exists( select 1 from cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final)              
			delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final

		insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,1)
		if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
		else print 'Creación Ciclo ProFinal: ' + cast(@w_pro_final as varchar)

	----------------------------------------------------------------------------------------------------------------------------
	--- Oficina Autorizada
		if exists( select 1 from cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo)
			delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo

		insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
		values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
		if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
		else print 'Creación Oficina Autorizada: ' + cast(@w_codigo as varchar)
			
	----------------------------------------------------------------------------------------------------------------------------


	print '--------------------------------------------------'
	print 'MONTO MINIMO DE APERTURA'
	print '--------------------------------------------------'

	SELECT @w_servicio_disponible = sd_servicio_dis
	FROM cob_remesas..pe_servicio_dis 
	WHERE sd_nemonico = 'MMAP' -- 'MONTO MINIMO APERTURA'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible MMAP'
	else print 'Servicio Disponible MMAP: ' + convert(varchar(10),@w_servicio_disponible)

	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'MONTO MINIMO')
	if @w_rubro is null print 'No existe VARServicio MONTO MINIMO'
	else print 'Rubro MMAP: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
	begin
		exec @w_return    = cobis..sp_cseqnos
			 @i_tabla     = 'pe_servicio_per',
			 @o_siguiente = @w_ser_per out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
		INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
		VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_disp, @w_grupo_rango_disp)
		if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
		else print 'Creación Servicio PER: ' + convert(varchar(10),@w_ser_per)
	end
	else
	begin
		update cob_remesas..pe_servicio_per 
		set sp_grupo_rango = @w_grupo_rango_disp,
		sp_tipo_rango = @w_tipo_rango_disp
		where  sp_pro_final = @w_pro_final 
		and sp_servicio_dis = @w_servicio_disponible 
		and sp_rubro = @w_rubro 
		
		select @w_ser_per = sp_servicio_per from cob_remesas..pe_servicio_per 
		where sp_pro_final = @w_pro_final 
		and sp_servicio_dis = @w_servicio_disponible 
		and sp_rubro = @w_rubro 
		and sp_tipo_rango = @w_tipo_rango_disp 
		and sp_grupo_rango = @w_grupo_rango_disp
		print 'Se editó Servicio PER: ' + convert(varchar(10),@w_ser_per)
	end

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end		
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 100.00, 100.00, 100.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	print 'SALDO MINIMO'
	print '--------------------------------------------------'
	select @w_servicio_disponible = sd_servicio_dis 
	from cob_remesas..pe_servicio_dis 
	where sd_nemonico = 'SMC' -- 'SALDO MINIMO'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible SMC'
	else print 'Servicio Disponible SMC: ' + convert(varchar(10),@w_servicio_disponible)

	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'SALDO MINIMO DE LA CUENTA')
	if @w_rubro is null print 'No existe VARServicio SMI'
	else print 'Rubro SMI: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end 
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'SALDO MAXIMO DE LA CUENTA')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro SMA: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0.00, 1000.00, 1000.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	print 'CIERRE DE CUENTAS'
	print '--------------------------------------------------'
	select @w_servicio_disponible = sd_servicio_dis 
	from cob_remesas..pe_servicio_dis 
	where sd_nemonico = 'CCTA' -- 'CIERRE DE CUENTAS'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible CCTA'
	else print 'Servicio Disponible CCTA: ' + convert(varchar(10),@w_servicio_disponible)

	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'MULTA POR GASTOS DE MANEJO')
	if @w_rubro is null print 'No existe VARServicio 22'
	else print 'Rubro 22 Multa: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end	
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'COMISION')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro 3 Comision: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'CARGO CIERRE CUENTA ANTES DE TIEMPO')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro 41 Cargo Cierre: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria 
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)

	
END
	
go


-- pe_parametria.sql

print '--------------------------------------------------'
PRINT 'APORTE SOCIAL ADICIONAL'
print '--------------------------------------------------'

use cob_remesas
go

set nocount on

declare @w_return              int,
        @w_codigo              int,
		@w_codigo_dep          int,
        @w_pro_final           int,
        @w_descripcion         varchar(100),
        @w_descripcion_profinal varchar(100),
        @w_tipo_rango_disp     int,
        @w_mercado             int,
        @w_ser_per             int,
        @w_grupo_rango_disp    int,
        @w_servicio_disponible int,
        @w_rubro               varchar(5),  
        @w_costo               int,
		@w_fecha_proceso       datetime,
		@w_tipo_ente           char(1),
		@w_ciclo			   int,
		@w_categoria           char(1)

select @w_descripcion = 'APORTE SOCIAL ADICIONAL',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	   
----------------------------------------------------------------------------------------------------------------------------
--- Tipo Rango sobre DISPONIBLE (para MMAP y SMS)
	if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'SOBRE SALDO DISPONIBLE' and tr_estado = 'V')    
	begin
		exec @w_return = cobis..sp_cseqnos
			 @i_tabla     = 'pe_tipo_rango',
			 @o_siguiente = @w_tipo_rango_disp out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_tipo_rango'
		INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
		VALUES (@w_tipo_rango_disp, 'SOBRE SALDO DISPONIBLE', 'R', 0, 'V')    
		if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
		else print 'Creación pe_tipo_rango DISP : ' + cast (@w_tipo_rango_disp as varchar)
	end
	else 
	begin
		select @w_tipo_rango_disp = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'SOBRE SALDO DISPONIBLE'  and tr_estado = 'V'
		print 'Elegido pe_tipo_rango : ' + cast (@w_tipo_rango_disp as varchar)
	end
	-- Rango
	if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
	begin
		select @w_grupo_rango_disp = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
		INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
		VALUES (@w_tipo_rango_disp, @w_grupo_rango_disp , @w_tipo_rango_disp, 0, 999999, 'V')
		if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
		else print 'Creación pe_rango DISP : '  + cast (@w_grupo_rango_disp as varchar)
	end
	else 
	begin
		select @w_grupo_rango_disp = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'
		print 'Elegido pe_rango : '  + cast (@w_grupo_rango_disp as varchar)
	end 
----------------------------------------------------------------------------------------------------------------------------
--- Producto Bancario
	if not exists(select 1 from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion)
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
	else
	begin
		select @w_codigo = pb_pro_bancario from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion
		print 'Producto Bancario: ' + cast(@w_codigo as varchar)
	end 
----------------------------------------------------------------------------------------------------------------------------
--- Parametro PCAASA
	if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PCAASA')
	begin
		INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
		VALUES (@w_descripcion, 'PCAASA', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')
		print 'Creación PCAASA : ' + cast(@w_codigo as varchar)
	end
	else
	begin
		update cobis..cl_parametro set pa_int = @w_codigo where pa_nemonico = 'PCAASA'
		print 'Actualización PCAASA : ' + cast(@w_codigo as varchar)
	end

-----------------------------------------------------------------------------------------------------------------------------
SELECT @w_ciclo = 1
WHILE (@w_ciclo < 3)
BEGIN
	if (@w_ciclo = 1)
	begin
		print ''
		print '----- MERCADO PERSONA -----'
		select @w_descripcion_profinal = 'APORTE SOCIAL ADICIONAL - PER.NAT.'
		select @w_tipo_ente  = 'P'	
	end
	
	if (@w_ciclo = 2)
	begin
		print ''
		print '----- MERCADO COMPANIA -----'
		select @w_descripcion_profinal = 'APORTE SOCIAL ADICIONAL - COMPANIA.'
		select @w_tipo_ente  = 'C'
	end
	
	SELECT @w_ciclo = @w_ciclo + 1
	
	----------------------------------------------------------------------------------------------------------------------------
	--- Parametro PCAASA x Dependencia
		select @w_codigo_dep = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAASO' and pa_producto = 'AHO'
		select @w_codigo_dep = pf_pro_final from cob_remesas..pe_pro_final 
		WHERE pf_filial = 1 and pf_sucursal = 1 
		and pf_mercado in (
							select me_mercado from cob_remesas..pe_mercado 
							where me_pro_bancario = @w_codigo_dep 
							and me_tipo_ente = @w_tipo_ente
						  )
						  
	----------------------------------------------------------------------------------------------------------------------------
	--- Mercado		
		if not exists (select 1 from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente)
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
		else
		begin
			select @w_mercado = me_mercado from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = @w_tipo_ente
			print 'Mercado Elegido: ' + cast(@w_mercado as varchar)
		end
	----------------------------------------------------------------------------------------------------------------------------
	--- Producto Final
		if not exists (select 1 from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1)
		begin
			exec @w_return = cobis..sp_cseqnos
				 @i_tabla     = 'pe_pro_final',
				 @o_siguiente = @w_pro_final out
			if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
			INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
			values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion_profinal,null,'N',2)
			if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
			else print 'Creación Prod. Final: ' + convert(varchar(10),@w_pro_final)
		end
		else
		begin
		    select @w_pro_final = pf_pro_final from cob_remesas..pe_pro_final WHERE pf_mercado = @w_mercado and pf_filial = 1 and pf_sucursal = 1
			update cob_remesas..pe_pro_final  set
			pf_descripcion = @w_descripcion_profinal,
			pf_depende = @w_codigo_dep,
			pf_provisiona = 'S',
			pf_cod_rango_edad = 2
			WHERE pf_pro_final = @w_pro_final and pf_mercado = @w_mercado
			print 'Actualización Producto Final: ' + cast(@w_pro_final as varchar)
		end

	----------------------------------------------------------------------------------------------------------------------------
	--- Categoria ProFinal
		select @w_categoria = 'A'
		if exists( select 1 from cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria)
			delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = @w_categoria
		
		insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual,cp_dias_plazo) 
		values (@w_pro_final,@w_categoria,'S','N',60)
		if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
		else print 'Creación Categoria Profinal: ' + cast(@w_pro_final as varchar) + ' ---> A'

	----------------------------------------------------------------------------------------------------------------------------
	--- Capitaliza ProFinal
		if exists( select 1 from cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp)
			delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp
		
		insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) 
		values (@w_pro_final,'M',@w_tipo_rango_disp)
		if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
		else print 'Creación Capitaliza Profinal - Rango ' + cast(@w_tipo_rango_disp as varchar)

	----------------------------------------------------------------------------------------------------------------------------
	--- Ciclo ProFinal
		if exists( select 1 from cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final)              
			delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final

		insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,1)
		if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
		else print 'Creación Ciclo ProFinal: ' + cast(@w_pro_final as varchar)

	----------------------------------------------------------------------------------------------------------------------------
	--- Oficina Autorizada
		if exists( select 1 from cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo)
			delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo

		insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
		values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
		if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
		else print 'Creación Oficina Autorizada: ' + cast(@w_codigo as varchar)
			
	----------------------------------------------------------------------------------------------------------------------------

	print '--------------------------------------------------'
	print 'MONTO MINIMO DE APERTURA'
	print '--------------------------------------------------'

	SELECT @w_servicio_disponible = sd_servicio_dis
	FROM cob_remesas..pe_servicio_dis 
	WHERE sd_nemonico = 'MMAP' -- 'MONTO MINIMO APERTURA'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible MMAP'
	else print 'Servicio Disponible MMAP: ' + convert(varchar(10),@w_servicio_disponible)

	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'MONTO MINIMO')
	if @w_rubro is null print 'No existe VARServicio MONTO MINIMO'
	else print 'Rubro MMAP: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
	begin
		exec @w_return    = cobis..sp_cseqnos
			 @i_tabla     = 'pe_servicio_per',
			 @o_siguiente = @w_ser_per out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
		INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
		VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_disp, @w_grupo_rango_disp)
		if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
		else print 'Creación Servicio PER: ' + convert(varchar(10),@w_ser_per)
	end
	else
	begin
		update cob_remesas..pe_servicio_per 
		set sp_grupo_rango = @w_grupo_rango_disp,
		sp_tipo_rango = @w_tipo_rango_disp
		where  sp_pro_final = @w_pro_final 
		and sp_servicio_dis = @w_servicio_disponible 
		and sp_rubro = @w_rubro 
		
		select @w_ser_per = sp_servicio_per from cob_remesas..pe_servicio_per 
		where sp_pro_final = @w_pro_final 
		and sp_servicio_dis = @w_servicio_disponible 
		and sp_rubro = @w_rubro 
		and sp_tipo_rango = @w_tipo_rango_disp 
		and sp_grupo_rango = @w_grupo_rango_disp
		print 'Se editó Servicio PER: ' + convert(varchar(10),@w_ser_per)
	end

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end		
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 100.00, 100.00, 100.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	print 'SALDO MINIMO'
	print '--------------------------------------------------'
	select @w_servicio_disponible = sd_servicio_dis 
	from cob_remesas..pe_servicio_dis 
	where sd_nemonico = 'SMC' -- 'SALDO MINIMO'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible SMC'
	else print 'Servicio Disponible SMC: ' + convert(varchar(10),@w_servicio_disponible)

	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'SALDO MINIMO DE LA CUENTA')
	if @w_rubro is null print 'No existe VARServicio SMI'
	else print 'Rubro SMI: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end 
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'SALDO MAXIMO DE LA CUENTA')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro SMA: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0.00, 1000.00, 1000.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	print 'CIERRE DE CUENTAS'
	print '--------------------------------------------------'
	select @w_servicio_disponible = sd_servicio_dis 
	from cob_remesas..pe_servicio_dis 
	where sd_nemonico = 'CCTA' -- 'CIERRE DE CUENTAS'
	if @w_servicio_disponible is null print 'No existe Servicio Disponible CCTA'
	else print 'Servicio Disponible CCTA: ' + convert(varchar(10),@w_servicio_disponible)

	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'MULTA POR GASTOS DE MANEJO')
	if @w_rubro is null print 'No existe VARServicio 22'
	else print 'Rubro 22 Multa: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end	
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'COMISION')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro 3 Comision: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)


	print '--------------------------------------------------'
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo 
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'CARGO CIERRE CUENTA ANTES DE TIEMPO')
	if @w_rubro is null print 'No existe VARServicio SMA'
	else print 'Rubro 41 Cargo Cierre: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
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
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 5, 5, 5, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)

	
	----------------------------------------------------------------------------------------------------------------------------
	print '--------------------------------------------------'
	print 'PAGO DE INTERES'
	print '--------------------------------------------------'
	SELECT @w_servicio_disponible = sd_servicio_dis
	FROM cob_remesas..pe_servicio_dis 
	WHERE sd_nemonico = 'PINT' 
	if @w_servicio_disponible is null print 'No existe Servicio Disponible PINT'
	else print 'Servicio Disponible PINT: ' + convert(varchar(10),@w_servicio_disponible)

	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'INTERES SOBRE EL DISPONIBLE')
	if @w_rubro is null print 'No existe VARServicio PAGO INT SALDO PROMEDIO DISP'
	else print 'Rubro PINT: ' + convert(varchar(10),@w_rubro)

	if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)
	begin
		exec @w_return    = cobis..sp_cseqnos
			 @i_tabla     = 'pe_servicio_per',
			 @o_siguiente = @w_ser_per out
		if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
		INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
		VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_disp, @w_grupo_rango_disp)
		if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
		else print 'Creación Servicio PER: ' + convert(varchar(10),@w_ser_per)
	end 
	else
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

	if exists (select 1 from cob_remesas..pe_costo where co_servicio_per = @w_ser_per and co_categoria = @w_categoria and co_tipo_rango = @w_tipo_rango_disp and co_grupo_rango = @w_grupo_rango_disp )
	begin
		delete cob_remesas..pe_costo 
		where co_servicio_per = @w_ser_per 
		and co_categoria = @w_categoria
		and co_tipo_rango = @w_tipo_rango_disp 
		and co_grupo_rango = @w_grupo_rango_disp	
	end
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, @w_categoria, @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 10.00, 10.00, 10.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)

	
	
END
go    