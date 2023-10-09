/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 08/05/2016 
--Descripción del Problema	: AHO-H79806-Provisión de Intereses Paramétrica
--Descripción de la Solución: Remediación de Historia
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-- ah_param.sql
if not exists (select 1 from   cobis..cl_parametro where  pa_producto = 'AHO' and pa_nemonico = 'PRVDIA')	
begin  
	INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	values ('CALCULO PROVISION DIARIA', 'PRVDIA', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'AHO')
end

-- pe_catlgo.sql
if exists (select 1 from cobis..cl_catalogo where valor = 'INTERES SOBRE EL PROM DISPONIBLE')
begin
	update cobis..cl_catalogo 
	set estado = 'V'
	where valor = 'INTERES SOBRE EL PROM DISPONIBLE'
end 

-- pe_parametria.sql
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
        @w_tipo_rango_disp     int,
        @w_tipo_rango_prom     int,
        @w_mercado             int,
        @w_ser_per             int,
        @w_grupo_rango_disp         int,
        @w_grupo_rango_prom         int,
        @w_servicio_disponible int,
        @w_rubro               varchar(5),  
        @w_costo               int,
		@w_fecha_proceso       datetime

select @w_descripcion = 'APORTE SOCIAL ADICIONAL',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	   
----------------------------------------------------------------------------------------------------------------------------
-- ELIMINACION
----------------------------------------------------------------------------------------------------------------------------
SELECT @w_pro_final = pf_pro_final FROM cob_remesas..pe_pro_final  WHERE pf_descripcion = @w_descripcion
SELECT @w_codigo = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAASA' and pa_producto = 'AHO'

		----------------------------------------------------------------------------------------------------------------------------
		-- Tipo Rango sobre DISPONIBLE (para MMAP y SMS)
		if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE' and tr_estado = 'V')    
		begin
			exec @w_return = cobis..sp_cseqnos
				 @i_tabla     = 'pe_pro_final',
				 @o_siguiente = @w_tipo_rango_disp out
			if @w_return <> 0 print 'Error en la obtencion de secuencial pe_pro_final'
			INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
			VALUES (@w_tipo_rango_disp, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')    
			if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
			else print 'Creación pe_tipo_rango DISP OK!'
		end
		else select @w_tipo_rango_disp = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'  and tr_estado = 'V' 
		-- Rango
		if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
		begin
			select @w_grupo_rango_disp = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
			INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
			VALUES (@w_tipo_rango_disp, @w_grupo_rango_disp , @w_tipo_rango_disp, 0, 999999, 'V')
			if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
			else print 'Creación pe_rango DISP OK!'
		end
		else select @w_grupo_rango_disp = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_disp and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'

		----------------------------------------------------------------------------------------------------------------------------
		-- Tipo Rango sobre PROMEDIO (para PINT)
		if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE PROMEDIO DISPONIBLE' and tr_estado = 'V')    
		begin
			exec @w_return = cobis..sp_cseqnos
				 @i_tabla     = 'pe_pro_final',
				 @o_siguiente = @w_tipo_rango_prom out
			if @w_return <> 0 print 'Error en la obtencion de secuencial pe_pro_final'
			INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
			VALUES (@w_tipo_rango_prom, 'RUBRO SOBRE PROMEDIO DISPONIBLE', 'E', 0, 'V')    
			if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
			else print 'Creación pe_tipo_rango PROM OK!'
		end
		else select @w_tipo_rango_prom = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE PROMEDIO DISPONIBLE'  and tr_estado = 'V' 
		-- Rango
		if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_prom and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
		begin
			select @w_grupo_rango_prom = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
			INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
			VALUES (@w_tipo_rango_prom, @w_grupo_rango_prom , @w_tipo_rango_prom, 0, 999999, 'V')
			if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
			else print 'Creación pe_rango PROM OK!'
		end
		else select @w_grupo_rango_prom = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango_prom and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'


----------------------------------------------------------------------------------------------------------------------------
-- Producto Bancario
if not exists(select 1 from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion)
begin
	exec @w_return    = cobis..sp_cseqnos
		 @i_tabla     = 'pe_pro_bancario',
		 @o_siguiente = @w_codigo out
	if @w_return != 0 print 'Error al obtener secuencial pe_pro_bancario'
	INSERT INTO cob_remesas..pe_pro_bancario (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
	values (@w_codigo,@w_descripcion,'V',@w_fecha_proceso)    
	if @@error != 0 print 'Error en la inserccion de registro en pe_pro_bancario'
	else print 'Creación Producto Bancario: ' + convert(varchar(10),@w_codigo)
end
else
	select @w_codigo = pb_pro_bancario from cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion

----------------------------------------------------------------------------------------------------------------------------
-- Parametro PCAASA
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PCAASA')
begin
	INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	VALUES (@w_descripcion, 'PCAASA', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')
	print 'Creación PCAASA OK!'
end
else
begin
	update cobis..cl_parametro set pa_int = @w_codigo where pa_nemonico = 'PCAASA'
	print 'Actualización PCAASA OK!'
end

----------------------------------------------------------------------------------------------------------------------------
-- Mercado		
if not exists (select 1 from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo)
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_mercado',
		 @o_siguiente = @w_mercado out
	if @w_return <> 0 print 'Error al obtener secuencial pe_mercado'
	INSERT INTO cob_remesas..pe_mercado (me_pro_bancario, me_tipo_ente, me_mercado, me_estado, me_fecha_estado) 
	VALUES (@w_codigo, 'P', @w_mercado, 'V', @w_fecha_proceso)
	if @@error <> 0 print 'Error en la inserccion de registro en pe_mercado'
	else print 'Creación Mercado: ' + convert(varchar(10),@w_mercado)
end
else
	select @w_mercado = me_mercado from cob_remesas..pe_mercado where me_pro_bancario = @w_codigo and me_tipo_ente = 'P'
	
----------------------------------------------------------------------------------------------------------------------------
-- Parametro PCAASA x Dependencia
select @w_codigo_dep = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAASO' and pa_producto = 'AHO'

----------------------------------------------------------------------------------------------------------------------------
-- Producto Final
if not exists (select 1 from cob_remesas..pe_pro_final WHERE pf_pro_final = @w_pro_final and pf_mercado = @w_mercado and pf_descripcion = @w_descripcion)
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_pro_final',
		 @o_siguiente = @w_pro_final out
	if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
	INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
	values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion,@w_codigo_dep,'N',2)
	if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
	else print 'Creación Prod. Final: ' + convert(varchar(10),@w_pro_final)
end
else
begin
	update cob_remesas..pe_pro_final  set
	pf_depende = @w_codigo_dep,
	pf_provisiona = 'N',
	pf_cod_rango_edad = 2
	WHERE pf_pro_final = @w_pro_final and pf_mercado = @w_mercado
	print 'Actualización Producto Final OK!'
end
----------------------------------------------------------------------------------------------------------------------------
-- Categoria ProFinal
if not exists( select 1 from cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final and cp_categoria = 'D')
begin
	insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual) 
	values (@w_pro_final,'D','S','N')
	if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
	else print 'Creación Categoria Profinal. ok!'
end

----------------------------------------------------------------------------------------------------------------------------
-- Capitaliza ProFinal
if not exists( select 1 from cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final and cp_tipo_capitalizacion = 'M' and cp_tipo_rango = @w_tipo_rango_disp)
begin
	insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) 
	values (@w_pro_final,'M',@w_tipo_rango_disp)
	if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
	else print 'Creación Capitaliza Profinal - Rango ' + convert(varchar(10),@w_tipo_rango_disp)
end

----------------------------------------------------------------------------------------------------------------------------
-- Ciclo ProFinal
if not exists( select 1 from cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final)              
begin
	insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,1)
	if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
	else print 'Creación Ciclo ProFinal. ok!'
end

-- Oficina Autorizada
if not exists( select 1 from cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo)
begin
	insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
	values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
	if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
	else print 'Creación Oficina Autorizada. ok!'
end
    
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
else print 'Rubro: ' + convert(varchar(10),@w_rubro)

if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)-- and sp_tipo_rango = @w_tipo_rango_disp and sp_grupo_rango = @w_grupo_rango_disp)
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

if not exists (select 1 from cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final))
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0.00, 10.00, 10.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
end

----------------------------------------------------------------------------------------------------------------------------
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

if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)-- and sp_tipo_rango = @w_tipo_rango_disp and sp_grupo_rango = @w_grupo_rango_disp)
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
if not exists (select 1 from cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final))
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
end 

print '--------------------------------------------------'
----------------------------------------------------------------------------------------------------------------------------
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
WHERE vs_servicio_dis = @w_servicio_disponible 
and vs_rubro in (select codigo from cobis..cl_catalogo 
                 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
				 and valor = 'SALDO MAXIMO DE LA CUENTA')
if @w_rubro is null print 'No existe VARServicio SMA'
else print 'Rubro SMA: ' + convert(varchar(10),@w_rubro)

if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)-- and sp_tipo_rango = @w_tipo_rango_disp and sp_grupo_rango = @w_grupo_rango_disp)
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

if not exists (select 1 from cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final))
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango_disp, @w_grupo_rango_disp, 1, 0.00, 1000.00, 1000.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
end

----------------------------------------------------------------------------------------------------------------------------
print '--------------------------------------------------'
print 'PAGO DE INTERES'
print '--------------------------------------------------'
SELECT @w_servicio_disponible = sd_servicio_dis
FROM cob_remesas..pe_servicio_dis 
WHERE sd_nemonico = 'PINT' 
if @w_servicio_disponible is null print 'No existe Servicio Disponible PINT'
else print 'Servicio Disponible PINT: ' + convert(varchar(10),@w_servicio_disponible)

if exists (select codigo from cobis..cl_catalogo where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro')  and valor = 'INTERES SOBRE EL PROM DISPONIBLE')
begin
	select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
	WHERE vs_servicio_dis = @w_servicio_disponible 
	and vs_rubro in (select codigo from cobis..cl_catalogo
					 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
					 and valor = 'INTERES SOBRE EL PROM DISPONIBLE')
	if @w_rubro is null print 'No existe VARServicio PAGO INT SALDO PROMEDIO DISP'
	else print 'Rubro: ' + convert(varchar(10),@w_rubro)
end
else
begin
	print 'No existe Rubro 23 - INTERES SOBRE EL PROM DISPONIBLE'
end

if not exists (select 1 from cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final and sp_servicio_dis = @w_servicio_disponible and sp_rubro = @w_rubro)-- and sp_tipo_rango = @w_tipo_rango_prom and sp_grupo_rango = @w_grupo_rango_prom)
begin
	exec @w_return    = cobis..sp_cseqnos
		 @i_tabla     = 'pe_servicio_per',
		 @o_siguiente = @w_ser_per out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
	INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
	VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango_prom, @w_grupo_rango_prom)
	if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
	else print 'Creación Servicio PER: ' + convert(varchar(10),@w_ser_per)
end 

if not exists (select 1 from cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final))
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_costo',
		 @o_siguiente = @w_costo out
	if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
	INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
	VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango_prom, @w_grupo_rango_prom, 1, 10.00, 10.00, 10.00, @w_fecha_proceso, 'admuser') 
	if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
	else print 'Creación Costo: ' + convert(varchar(10),@w_costo)
end

go    