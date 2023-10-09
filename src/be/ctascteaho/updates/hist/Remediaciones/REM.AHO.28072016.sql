/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 28/07/2016 
--Descripción del Problema	: Creación Productos Aporte Social Adicional
--Descripción de la Solución: Errores, transacciones, sp y creación de Productos Aporte Social Ordinario y Adicional
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-- pe_error.sql ---------------------------------------------------------
delete cobis..cl_errores where numero in (357561, 357562, 357563, 357564, 357565,
                                          357566, 357567, 357568, 357569, 357570, 357571, 357572)

insert into cobis..cl_errores values ( 357561, 0, 'ERROR - DEPENDENCIA CIRCULAR EN PRODUCTO FINAL')
insert into cobis..cl_errores values ( 357562, 0, 'PRODUCTO BANCARIO NO PERMITE BLOQUEO DE MOVIMIENTOS')
insert into cobis..cl_errores values ( 357563, 0, 'CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA')
insert into cobis..cl_errores values ( 357564, 0, 'NO EXISTE PRODUCTO FINAL DEPENDIENTE')
insert into cobis..cl_errores values ( 357565, 0, 'NO EXISTE MERCADO PARA PRODUCTO FINAL DEPENDIENTE')
insert into cobis..cl_errores values ( 357566, 0, 'NO EXISTE PRODUCTO BANCARIO DEPENDIENTE')
insert into cobis..cl_errores values ( 357567, 0, 'PRODUCTO BANCARIO NO PERMITE ACTIVACION')
insert into cobis..cl_errores values ( 357568, 0, 'MONTO DE APORTE SOCIAL NO EXISTE')
insert into cobis..cl_errores values ( 357569, 0, 'MONTO DEPOSITADO ES SUPERIOR A MONTO MÁXIMO ESTABLECIDO')
insert into cobis..cl_errores values ( 357570, 0, 'PRODUCTO APORTE SOCIAL NO PUEDE SER MAYOR A MONTO APORTE SOCIAL')
insert into cobis..cl_errores values ( 357571, 0, 'CLIENTE POSEE CREDITOS VIGENTES CON BLOQUEOS')
insert into cobis..cl_errores values ( 357572, 0, 'NO SE PUDO REALIZAR BLOQUEO EN CUENTA DE APORTE SOCIAL')

------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_producsp tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 17,
	   @w_transaccion = 425,
	   @w_descripcion = 'CONSULTA CARACTERISTICAS ADICIONALES',
	   @w_nemonico    = 'PFCCA',
	   @w_desc_larga  = 'CONSULTA CARACTERISTICAS ADICIONALES',
	   @w_producsp    = 17,
	   @w_procedure   = 422,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_caradicionales',
	   @w_filesp      = 'caradi.sp'
-- CL_TTRANSACCION---pe_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---pe_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---pe_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producsp, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---pe_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go


------------------------------------------------------------------------
declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_producsp tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 17,
	   @w_transaccion = 426,
	   @w_descripcion = 'ACTUALIZACION CARACTERISTICAS ADICIONALES',
	   @w_nemonico    = 'PFACA',
	   @w_desc_larga  = 'ACTUALIZACION CARACTERISTICAS ADICIONALES',
	   @w_producsp    = 17,
	   @w_procedure   = 422,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_caradicionales',
	   @w_filesp      = 'caradi.sp'
-- CL_TTRANSACCION---pe_tran.sql---------------------------------
DELETE cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)
-- AD_PROCEDURE---pe_proc.sql------------------------------------
DELETE from cobis..ad_procedure WHERE pd_procedure = @w_procedure
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
-- AD_PRO_TRANSACCION---pe_protran.sql---------------------------
DELETE from ad_pro_transaccion where pt_transaccion = @w_transaccion
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producsp, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
-- AD_TR_AUTORIZADA---pe_traut.sql------------------------------
DELETE from ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_rol = @w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
go



-- pe_parametria.sql
---CREACION PRODUCTO APORTE SOCIAL ORDINARIO
print '--------------------------------------------------'
PRINT 'APORTE SOCIAL ORDINARIO'
print '--------------------------------------------------'
use cob_remesas
go

set nocount on

declare @w_return int,
        @w_codigo  int,
        @w_pro_final   int,
        @w_descripcion varchar(100),
        @w_tipo_rango       int,
        @w_mercado          int,
        @w_ser_per          int,
        @w_grupo_rango      int,
        @w_servicio_disponible int,
        @w_rubro               varchar(5),  
        @w_costo               int,
		@w_fecha_proceso       datetime

select @w_descripcion = 'APORTE SOCIAL ORDINARIO',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	   
----------------------------------------------------------------------------------------------------------------------------
-- ELIMINACION
----------------------------------------------------------------------------------------------------------------------------
SELECT @w_pro_final = pf_pro_final FROM cob_remesas..pe_pro_final  WHERE pf_descripcion = @w_descripcion
SELECT @w_codigo = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAASO' and pa_producto = 'AHO'

delete cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion
if @@error != 0 print 'Error en la eliminacion de registro en pe_pro_bancario'
delete cob_remesas..pe_pro_final WHERE pf_pro_final =  @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_pro_final'
delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_categoria_profinal'
delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_capitaliza_profinal'
delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final                      
if @@error != 0 print 'Error en la eliminacion de registro en pe_ciclo_profinal'
delete cob_remesas..pe_mercado where me_pro_bancario = @w_codigo
if @@error != 0 print 'Error en la eliminacion de registro en pe_mercado'
delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo
if @@error != 0 print 'Error en la eliminacion de registro en pe_oficina_autorizada'
delete cobis..cl_parametro where pa_nemonico = 'PCAASO' and pa_producto = 'AHO'
if @@error != 0 print 'Error en la eliminacion de registro en cl_parametro'
delete cob_remesas..pe_cambio_costo where cc_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final)
if @@error != 0 print 'Error en la eliminacion de registro en pe_cambio_costo'
delete cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final)
if @@error != 0 print 'Error en la eliminacion de registro en pe_cambio_costo'
delete cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_servicio_per'
----------------------------------------------------------------------------------------------------------------------------

-- Tipo Rango
if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE' and tr_estado = 'V')    
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_pro_final',
		 @o_siguiente = @w_tipo_rango out
    if @w_return <> 0 print 'Error en la obtencion de secuencial pe_pro_final'
    INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
    VALUES (@w_tipo_rango, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')    
    if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
end
else select @w_tipo_rango = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'  and tr_estado = 'V' 

-- Rango
if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
begin
	select @w_grupo_rango = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
	INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
	VALUES (@w_tipo_rango, @w_grupo_rango , @w_tipo_rango, 0, 999999, 'V')
	if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
end
else select @w_grupo_rango = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'

----------------------------------------------------------------------------------------------------------------------------
-- Producto Bancario
exec @w_return    = cobis..sp_cseqnos
     @i_tabla     = 'pe_pro_bancario',
     @o_siguiente = @w_codigo out
if @w_return != 0 print 'Error al obtener secuencial pe_pro_bancario'
INSERT INTO cob_remesas..pe_pro_bancario (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
values (@w_codigo,@w_descripcion,'V',@w_fecha_proceso)    
if @@error != 0 print 'Error en la inserccion de registro en pe_pro_bancario'
else print 'Producto Bancario: ' + convert(varchar(10),@w_codigo)
-- Mercado
exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_mercado',
     @o_siguiente = @w_mercado out
if @w_return <> 0 print 'Error al obtener secuencial pe_mercado'
INSERT INTO cob_remesas..pe_mercado (me_pro_bancario, me_tipo_ente, me_mercado, me_estado, me_fecha_estado) VALUES (@w_codigo, 'P', @w_mercado, 'V', @w_fecha_proceso)
if @@error <> 0 print 'Error en la inserccion de registro en pe_mercado'
else print 'Mercado: ' + convert(varchar(10),@w_mercado)

-- Producto Final
exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_pro_final',
     @o_siguiente = @w_pro_final out
if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion,null,'N',2)
if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
else print 'Prod. Final: ' + convert(varchar(10),@w_pro_final)

-- Parametro PCAASO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES (@w_descripcion, 'PCAASO', 'I', NULL, NULL, NULL, @w_pro_final, NULL, NULL, NULL, 'AHO') 
		
-- Categoria ProFinal
insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual) values (@w_pro_final,'D','S','N')
if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
else print 'Categoria Profinal. ok!'

-- Capitaliza ProFinal
insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) values (@w_pro_final,'M',@w_tipo_rango)
if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
else print 'Capitaliza Profinal - Rango ' + convert(varchar(10),@w_tipo_rango)

-- Ciclo ProFinal
insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,1)
if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
else print 'Ciclo ProFinal. ok!'

-- Oficina Autorizada
insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
else print 'Oficina Autorizada. ok!'

----------------------------------------------------------------------------------------------------------------------------
-- MONTO MINIMO DE APERTURA
----------------------------------------------------------------------------------------------------------------------------

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

exec @w_return    = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0.00, 10.00, 10.00, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

----------------------------------------------------------------------------------------------------------------------------
-- SALDO MINIMO
----------------------------------------------------------------------------------------------------------------------------
print '--------------------------------------------------'
select @w_servicio_disponible = sd_servicio_dis 
from cob_remesas..pe_servicio_dis 
where sd_nemonico = 'SMC' -- 'SALDO MINIMO'
if @w_servicio_disponible is null print 'No existe Servicio Disponible SMC'
else print 'Servicio Disponible SMC: ' + convert(varchar(10),@w_servicio_disponible)
print '--------------------------------------------------'

----------------------------------------------------------------------------------------------------------------------------
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
WHERE vs_servicio_dis = @w_servicio_disponible 
and vs_rubro in (select codigo from cobis..cl_catalogo 
                 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
				 and valor = 'SALDO MINIMO DE LA CUENTA')
if @w_rubro is null print 'No existe VARServicio SMI'
else print 'Rubro SMI: ' + convert(varchar(10),@w_rubro)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0.00, 0.00, 0.00, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

print '--------------------------------------------------'
----------------------------------------------------------------------------------------------------------------------------
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
WHERE vs_servicio_dis = @w_servicio_disponible 
and vs_rubro in (select codigo from cobis..cl_catalogo 
                 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
				 and valor = 'SALDO MAXIMO DE LA CUENTA')
if @w_rubro is null print 'No existe VARServicio SMA'
else print 'Rubro SMA: ' + convert(varchar(10),@w_rubro)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0.00, 1000.00, 1000.00, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

go


print '--------------------------------------------------'
PRINT 'APORTE SOCIAL ADICIONAL'
print '--------------------------------------------------'

declare @w_return              int,
        @w_codigo              int,
		@w_codigo_dep          int,
        @w_pro_final           int,
        @w_descripcion         varchar(100),
        @w_tipo_rango          int,
        @w_mercado             int,
        @w_ser_per             int,
        @w_grupo_rango         int,
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

delete cob_remesas..pe_pro_bancario WHERE pb_descripcion = @w_descripcion
if @@error != 0 print 'Error en la eliminacion de registro en pe_pro_bancario'
delete cob_remesas..pe_pro_final WHERE pf_pro_final =  @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_pro_final'
delete cob_remesas..pe_categoria_profinal WHERE cp_profinal =  @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_categoria_profinal'
delete cob_remesas..pe_capitaliza_profinal  WHERE cp_profinal = @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_capitaliza_profinal'
delete cob_remesas..pe_ciclo_profinal WHERE cp_profinal = @w_pro_final                      
if @@error != 0 print 'Error en la eliminacion de registro en pe_ciclo_profinal'
delete cob_remesas..pe_mercado where me_pro_bancario = @w_codigo
if @@error != 0 print 'Error en la eliminacion de registro en pe_mercado'
delete cob_remesas..pe_oficina_autorizada where oa_prod_banc = @w_codigo
if @@error != 0 print 'Error en la eliminacion de registro en pe_oficina_autorizada'
delete cobis..cl_parametro where pa_nemonico = 'PCAASA' and pa_producto = 'AHO'
if @@error != 0 print 'Error en la eliminacion de registro en cl_parametro'
delete cob_remesas..pe_cambio_costo where cc_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final)
if @@error != 0 print 'Error en la eliminacion de registro en pe_cambio_costo'
delete cob_remesas..pe_costo where co_servicio_per in ( select sp_servicio_per from  cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final)
if @@error != 0 print 'Error en la eliminacion de registro en pe_cambio_costo'
delete cob_remesas..pe_servicio_per where sp_pro_final = @w_pro_final
if @@error != 0 print 'Error en la eliminacion de registro en pe_servicio_per'
----------------------------------------------------------------------------------------------------------------------------

-- Tipo Rango
if not exists(select 1 from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE' and tr_estado = 'V')    
begin
	exec @w_return = cobis..sp_cseqnos
		 @i_tabla     = 'pe_pro_final',
		 @o_siguiente = @w_tipo_rango out
    if @w_return <> 0 print 'Error en la obtencion de secuencial pe_pro_final'
    INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
    VALUES (@w_tipo_rango, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')    
    if @@error != 0 print 'Error en la inserccion de registro en pe_tipo_rango'
end
else select @w_tipo_rango = tr_tipo_rango from cob_remesas..pe_tipo_rango WHERE tr_descripcion = 'RUBRO SOBRE SALDO DISPONIBLE'  and tr_estado = 'V' 

-- Rango
if not exists(select 1 from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V')
begin
	select @w_grupo_rango = max(ra_grupo_rango) + 1 from cob_remesas..pe_rango
	INSERT INTO cob_remesas..pe_rango (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
	VALUES (@w_tipo_rango, @w_grupo_rango , @w_tipo_rango, 0, 999999, 'V')
	if @@error != 0 print 'Error en la inserccion de registro en pe_rango'
end
else select @w_grupo_rango = ra_grupo_rango from cob_remesas..pe_rango WHERE ra_tipo_rango = @w_tipo_rango and ra_desde = 0 and ra_hasta > 999999  and ra_estado = 'V'

----------------------------------------------------------------------------------------------------------------------------
-- Producto Bancario
exec @w_return    = cobis..sp_cseqnos
     @i_tabla     = 'pe_pro_bancario',
     @o_siguiente = @w_codigo out
if @w_return != 0 print 'Error al obtener secuencial pe_pro_bancario'
INSERT INTO cob_remesas..pe_pro_bancario (pb_pro_bancario,pb_descripcion,pb_estado,pb_fecha_estado)
values (@w_codigo,@w_descripcion,'V',@w_fecha_proceso)    
if @@error != 0 print 'Error en la inserccion de registro en pe_pro_bancario'
else print 'Producto Bancario: ' + convert(varchar(10),@w_codigo)

-- Parametro PCAASA
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES (@w_descripcion, 'PCAASA', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO') 
		
-- Mercado		
exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_mercado',
     @o_siguiente = @w_mercado out
if @w_return <> 0 print 'Error al obtener secuencial pe_mercado'
INSERT INTO cob_remesas..pe_mercado (me_pro_bancario, me_tipo_ente, me_mercado, me_estado, me_fecha_estado) VALUES (@w_codigo, 'P', @w_mercado, 'V', @w_fecha_proceso)
if @@error <> 0 print 'Error en la inserccion de registro en pe_mercado'
else print 'Mercado: ' + convert(varchar(10),@w_mercado)

-- Parametro PCAASA x Dependencia
select @w_codigo_dep = pa_int from cobis..cl_parametro where pa_nemonico = 'PCAASO' and pa_producto = 'AHO'

-- Producto Final
exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_pro_final',
     @o_siguiente = @w_pro_final out
if @w_return <> 0 print 'Error al obtener secuencial pe_pro_final'
INSERT INTO cob_remesas..pe_pro_final (pf_pro_final,pf_filial,pf_sucursal,pf_mercado,pf_producto,pf_moneda,pf_tipo,pf_descripcion,pf_depende,pf_provisiona,pf_cod_rango_edad)  -- ******************************************************************
values (@w_pro_final,1,1,@w_mercado,4,0,'R',@w_descripcion,@w_codigo_dep,'N',2)
if @@error <> 0 print 'Error en la inserccion de registro en pe_pro_final'
else print 'Prod. Final: ' + convert(varchar(10),@w_pro_final)

-- Categoria ProFinal
insert into cob_remesas..pe_categoria_profinal (cp_profinal,cp_categoria,cp_posteo,cp_contractual) values (@w_pro_final,'D','S','N')
if @@error <> 0 print 'Error en la inserccion de registro en pe_categoria_profinal'
else print 'Categoria Profinal. ok!'

-- Capitaliza ProFinal
insert into cob_remesas..pe_capitaliza_profinal (cp_profinal,cp_tipo_capitalizacion,cp_tipo_rango) values (@w_pro_final,'M',@w_tipo_rango)
if @@error <> 0 print 'Error en la inserccion de registro en pe_capitaliza_profinal'
else print 'Capitaliza Profinal - Rango ' + convert(varchar(10),@w_tipo_rango)

-- Ciclo ProFinal
insert into cob_remesas..pe_ciclo_profinal (cp_profinal,cp_ciclo) values (@w_pro_final,1)
if @@error != 0 print 'Error en la inserccion de registro en pe_ciclo_profinal'
else print 'Ciclo ProFinal. ok!'

-- Oficina Autorizada
insert into cob_remesas..pe_oficina_autorizada (oa_producto, oa_prod_banc, oa_oficina, oa_estado, oa_fecha_crea, oa_fecha_modi, oa_fecha_inicio)
values (4,@w_codigo,1,'V',@w_fecha_proceso,@w_fecha_proceso,@w_fecha_proceso)
if @@error != 0 print 'Error en la inserccion de registro en pe_oficina_autorizada'
else print 'Oficina Autorizada. ok!'

    
----------------------------------------------------------------------------------------------------------------------------
-- MONTO MINIMO DE APERTURA
----------------------------------------------------------------------------------------------------------------------------

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

exec @w_return    = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0.00, 10.00, 10.00, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

----------------------------------------------------------------------------------------------------------------------------
-- SALDO MINIMO
----------------------------------------------------------------------------------------------------------------------------
print '--------------------------------------------------'
select @w_servicio_disponible = sd_servicio_dis 
from cob_remesas..pe_servicio_dis 
where sd_nemonico = 'SMC' -- 'SALDO MINIMO'
if @w_servicio_disponible is null print 'No existe Servicio Disponible SMC'
else print 'Servicio Disponible SMC: ' + convert(varchar(10),@w_servicio_disponible)
print '--------------------------------------------------'

----------------------------------------------------------------------------------------------------------------------------
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
WHERE vs_servicio_dis = @w_servicio_disponible 
and vs_rubro in (select codigo from cobis..cl_catalogo 
                 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
				 and valor = 'SALDO MINIMO DE LA CUENTA')
if @w_rubro is null print 'No existe VARServicio SMI'
else print 'Rubro SMI: ' + convert(varchar(10),@w_rubro)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0, 0, 0, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

print '--------------------------------------------------'
----------------------------------------------------------------------------------------------------------------------------
select @w_rubro = vs_rubro from cob_remesas..pe_var_servicio 
WHERE vs_servicio_dis = @w_servicio_disponible 
and vs_rubro in (select codigo from cobis..cl_catalogo 
                 where tabla in (select codigo From cobis..cl_tabla where tabla like 'pe_rubro') 
				 and valor = 'SALDO MAXIMO DE LA CUENTA')
if @w_rubro is null print 'No existe VARServicio SMA'
else print 'Rubro SMA: ' + convert(varchar(10),@w_rubro)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_servicio_per',
     @o_siguiente = @w_ser_per out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_servicio_per'
INSERT INTO cob_remesas..pe_servicio_per (sp_pro_final, sp_servicio_dis, sp_rubro, sp_servicio_per, sp_tipo_rango, sp_grupo_rango)
VALUES (@w_pro_final, @w_servicio_disponible, @w_rubro, @w_ser_per, @w_tipo_rango, @w_grupo_rango)
if @@error != 0 print 'Error en la inserccion de registro en pe_servicio_per'
else print 'Servicio PER: ' + convert(varchar(10),@w_ser_per)

exec @w_return = cobis..sp_cseqnos
     @i_tabla     = 'pe_costo',
     @o_siguiente = @w_costo out
if @w_return <> 0 print 'Error en la obtencion de secuencial pe_costo'
INSERT INTO cob_remesas..pe_costo (co_secuencial, co_servicio_per, co_categoria, co_tipo_rango, co_grupo_rango, co_rango, co_val_medio, co_minimo, co_maximo, co_fecha_vigencia, co_usuario)
VALUES (@w_costo, @w_ser_per, 'D', @w_tipo_rango, @w_grupo_rango, 1, 0.00, 1000.00, 1000.00, @w_fecha_proceso, 'admuser') 
if @@error != 0 print 'Error en la inserccion de registro en pe_costo'
else print 'Costo: ' + convert(varchar(10),@w_costo)

go    
