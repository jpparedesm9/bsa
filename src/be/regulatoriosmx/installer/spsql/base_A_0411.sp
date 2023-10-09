/************************************************************************/
/*   Archivo:             base_A_0411.sp                                */
/*   Stored procedure:    sp_base_A_0411                                */
/*   Base de datos:       cob_conta_super                               */
/*   Producto:            Regulatorios                                  */
/*   Disenado por:        Pedro Montenegro                              */
/*   Fecha de escritura:  Agosto.2017.                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Extraccion de datos para el reporte A0411, que consta de los saldos*/
/*   contables de fin de mes y las provisiones segun una parametria     */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_base_A_0411')
   drop proc sp_base_A_0411
go

create proc sp_base_A_0411

as 

declare	
@w_error			int,
@w_return			int,
@w_mensaje          varchar(150),
@w_sql				varchar(5000),
@w_sql_bcp			varchar(5000),
@w_fecha_proceso	datetime,
@w_formato_fecha	int,
@w_ini_mes			datetime,
@w_fin_mes			datetime,
@w_fin_mes_hab		datetime,
@w_ruta_arch		varchar(255),
@w_nombre_arch		varchar(30),
@w_sp_name			varchar(30),
@w_msg				varchar(255),
@w_param_conta_pro	varchar(10),
@w_periodo			int,
@w_corte			int,
@w_batch			int,
@w_empresa			int,
@w_reporte          catalogo,
@w_solicitud        char(1)

select @w_sp_name = 'sp_base_A_0411', @w_reporte = 'A0411'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


declare @resultadobcp table (linea varchar(max))

declare @TablaRiesgo as table
(
	calificacion	varchar(3),
	rango_desde		float,
	rango_hasta		float
)


exec @w_return = cob_conta..sp_calcula_ultima_fecha_habil
@i_reporte			= @w_reporte,
@o_existe_solicitud = @w_solicitud out,
@o_ini_mes			= @w_ini_mes out,
@o_fin_mes			= @w_fin_mes out,
@o_fin_mes_hab		= @w_fin_mes_hab out

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

if @w_solicitud = 'N' goto SALIDA_PROCESO

select @w_formato_fecha = 111, @w_batch = 36411, @w_empresa = 1

select	
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= replace(ba_arch_resultado, '.', ('_' + replace(convert(varchar, @w_fin_mes, 106), ' ', '_') + '.'))
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

select @w_param_conta_pro = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PCPREP'
and pa_producto = 'REC'

if @@error != 0 or @@rowcount != 1 
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end

insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('A1', -0.1, 2.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('A2', 2.0, 3.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B1', 3.0, 4.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B2', 4.0, 5.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('B3', 5.0, 6.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('C1', 6.0, 8.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('C2', 8.0, 15.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('D', 15.0, 35.0)
insert into @TablaRiesgo (calificacion, rango_desde, rango_hasta) values ('E', 35.0, 100.0)

select 
@w_periodo	= co_periodo, 
@w_corte	= co_corte 
from cob_conta..cb_corte 
where co_fecha_fin	= @w_fin_mes
and co_empresa		= @w_empresa

if @@error != 0 or @@rowcount != 1 
begin
   select @w_error = 70136
   goto ERROR_PROCESO
end

select cu_cuenta, cu_cuenta_padre, cp_texto
into #cuentas
from cob_conta..cb_cuenta, cob_conta..cb_cuenta_proceso
where cu_movimiento = 'S'
and cu_cuenta_padre = cp_cuenta 
and cp_proceso		= @w_batch
and cu_empresa		= @w_empresa

if @@error != 0 or @@rowcount = 0 
begin
   select @w_error = 70137
   goto ERROR_PROCESO
end

select
st_ente						as cliente, 
convert(varchar(24), '')	as banco,
convert(varchar(10), '')	as toperacion,
sum(case when cp_texto = 'CAP VIG NE' then st_saldo else 0 end) as 'CAP_VIG_NE',
sum(case when cp_texto = 'INT VIG NE' then st_saldo else 0 end) as 'INT_VIG_NE',
sum(case when cp_texto = 'CAP VIG EX' then st_saldo else 0 end) as 'CAP_VIG_EX',
sum(case when cp_texto = 'INT VIG EX' then st_saldo else 0 end) as 'INT_VIG_EX',
sum(case when cp_texto = 'CAP VEN NE' then st_saldo else 0 end) as 'CAP_VEN_NE',
sum(case when cp_texto = 'CAP VEN EX' then st_saldo else 0 end) as 'CAP_VEN_EX',
sum(case when cp_texto = 'INT VEN EX' then st_saldo else 0 end) as 'INT_VEN_EX',		
convert(varchar(24), ' ')	as cta_provision,
convert(money, 0)			as val_provision,
convert(varchar(10), '')	as calificacion,
convert(float, 0)			as porc_riesgo
into #resultado
from cob_conta_tercero..ct_saldo_tercero, #cuentas
where st_cuenta	= cu_cuenta
and st_empresa	= @w_empresa
and st_corte	= @w_corte
and st_periodo	= @w_periodo
group by st_ente

if @@error != 0 or @@rowcount = 0 
begin
   select @w_error = 70138
   goto ERROR_PROCESO
end

delete from #resultado
where CAP_VIG_NE = 0
and INT_VIG_NE = 0
and CAP_VIG_EX = 0
and INT_VIG_EX = 0
and CAP_VEN_NE = 0
and CAP_VEN_EX = 0
and INT_VEN_EX = 0

if @@error != 0 
begin
   select @w_error = 710003
   goto ERROR_PROCESO
end

select	
do_codigo_cliente		as do_cliente, 
max(do_tipo_operacion)	as do_toperacion, 
max(do_banco)			as do_banco, 
sum(isnull(do_provision, 0)) as do_provision,
(sum(isnull(do_provision, 0)) / (sum(isnull(do_saldo_cap, 0) + isnull(do_saldo_int, 0))) * 100) as do_riesgo,
convert(varchar(3), null) as do_calificacion
into #datos_prestamo
from cob_conta_super..sb_dato_operacion	
where do_fecha		= @w_fin_mes_hab
and do_aplicativo	= 7
group by do_codigo_cliente
having (sum(isnull(do_saldo_cap, 0) + isnull(do_saldo_int, 0))) > 0

if @@error != 0 or @@rowcount = 0 
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end

update #datos_prestamo set do_calificacion = (select calificacion from @TablaRiesgo where do_riesgo > rango_desde and do_riesgo <= rango_hasta) 

--select * from #datos_prestamo
--where do_cliente in (6728, 6729)

if @@error != 0 or @@rowcount = 0 
begin
   select @w_error = 70140
   goto ERROR_PROCESO
end

update #resultado set 
banco			= do_banco,
toperacion		= ltrim(rtrim(do_toperacion)),
val_provision	= do_provision,
calificacion	= ltrim(rtrim(do_calificacion)),
porc_riesgo		= do_riesgo
from #datos_prestamo 
where cliente = do_cliente

if @@error != 0 or @@rowcount = 0 
begin
   select @w_error = 70141
   goto ERROR_PROCESO
end

update #resultado set 
cta_provision = re_substring
from cob_conta..cb_relparam
where re_empresa= @w_empresa
and re_parametro= @w_param_conta_pro
and re_clave	= (toperacion + '.' + calificacion)

if @@error != 0
begin
   select @w_error = 70142
   goto ERROR_PROCESO
end

truncate table cob_conta_super..sb_reporte_A_0411

if @@error != 0
begin
   select @w_error = 70143
   goto ERROR_PROCESO
end

insert into cob_conta_super..sb_reporte_A_0411 
(cliente, banco, toperacion, 
cuenta1, cuenta2, cuenta3, 
cuenta4, cuenta5, cuenta6, 
cuenta7, cta_provision, val_provision, 
calificacion, porc_riesgo)
values 
('CODIGO CLIENTE', 'NO PRESTAMO', 'TIPO PRESTAMO', 
'CAP VIG NE', 'INT VIG NE', 'CAP VIG EX', 
'INT VIG EX', 'CAP VEN NE', 'CAP VEN EX', 
'INT VEN EX', 'CTA PROVISION', 'VAL PROVISION', 
'CALIFICACION', '% RIESGO')

if @@error != 0
begin
   select @w_error = 70144
   goto ERROR_PROCESO
end

insert into cob_conta_super..sb_reporte_A_0411 
(cliente, banco, toperacion, cuenta1, cuenta2, cuenta3, cuenta4, cuenta5, cuenta6, 
cuenta7, cta_provision, val_provision, calificacion, porc_riesgo)
select	
cliente, banco, toperacion, CAP_VIG_NE, INT_VIG_NE, CAP_VIG_EX, INT_VIG_EX, CAP_VEN_NE, CAP_VEN_EX,
INT_VEN_EX,	cta_provision, val_provision, calificacion, porc_riesgo
from #resultado

if @@error != 0
begin
   select @w_error = 70145
   goto ERROR_PROCESO
end

select @w_sql = 'select * from cob_conta_super..sb_reporte_A_0411'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_nombre_arch + '" -C -c -t\t -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp;

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje =  linea 
         from @resultadobcp 
         where upper(linea) LIKE upper('%Error %')

if @w_mensaje is not null
begin
	select @w_error = 70146
	goto ERROR_PROCESO
end

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I' 

if @@error != 0
begin
	select @w_error = 710002
	goto ERROR_PROCESO
end

SALIDA_PROCESO:
   return 0
   
ERROR_PROCESO:

	select @w_msg = mensaje
		from cobis..cl_errores with (nolock)
		where numero = @w_error
		set transaction isolation level read uncommitted

	select @w_msg = isnull(@w_msg, @w_mensaje)
	
	exec @w_return = cob_conta_super..sp_errorlog 
		@i_operacion	= 'I',
		@i_fecha_fin	= @w_fecha_proceso,
		@i_origen_error = @w_error, 
		@i_fuente		= @w_sp_name,
		@i_descrp_error = @w_msg
	
	return @w_error

go
