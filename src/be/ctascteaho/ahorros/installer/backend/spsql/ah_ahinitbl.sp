/************************************************************************/
/*      Archivo           :  sp_ah_ahinitbl                             */
/*      Base de datos     :  cob_ahorros                                */
/*      Producto          :  Cuentas de Ahorros                         */
/*      Disenado por      :  Andres Enriquez                            */
/*      Fecha de escritura:  30/May/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Inicializacion de tablas para procesos batch					*/
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      23/May/2016     A Enriquez      	Emision Inicial	            */ 
/*      18/Jul/2016     Pedro Montenegro    Modificación nombres  		*/
/*                                      	parametros y llamada a      */
/*											sp sp_errorlog				*/
/************************************************************************/

use cob_ahorros
go

if object_id('sp_ah_ahinitbl') is not null
begin
	drop procedure sp_ah_ahinitbl
	if object_id('sp_ah_ahinitbl') is not null
		print 'FAILED DROPPING PROCEDURE sp_ah_ahinitbl'  
end

go

CREATE procedure  sp_ah_ahinitbl
(
	--Parámetros para regístro de log ejecución 
   	@t_show_version     bit         = 0,
	@i_param1           int,				--@i_filial
	@i_param2           datetime			--@i_fecha_proceso
)	
AS
DECLARE
	@w_existe           varchar(2),
	@w_sp_name			varchar(30),
	@w_contador			int,

	@w_rango			int,
	@w_tot_ctas			int,
	@w_ofi_ini			int,
	@w_ofi_fin			int,
	@w_num_ctas			int,
	@w_acum				int,

	@w_oficina			smallint,
	@w_ah_oficina		smallint,
	@w_num_ctas_ofi		int,
	
	@w_error			int,
	@w_trn_code			int,
	@w_msg				mensaje,
	
	@w_fila_0			int,
	@w_no_fila_0		int,
	
	@w_filial           int,
	@w_fecha_proceso    datetime,

	@return_value		int	
	
select 	@w_sp_name 		= 'sp_ah_ahinitbl', 
		@w_filial 		= @i_param1, 
		@w_fecha_proceso= @i_param2

if @t_show_version = 1
begin
	print 'Stored procedure: ' + @w_sp_name + ' Version: ' + '4.0.0.0'
	return 0
end

if not exists (select 1 from cobis..cl_filial where fi_filial = @w_filial)
begin
	select 	@w_error 	= 101002,
			@w_msg		= null
	goto ERRORFIN
end

if exists(select 1 
			from tempdb..sysobjects 
			where upper(name) like upper('%DatosCuentaXOficina%'))
begin
	drop table #DatosCuentaXOficina
end

create table #DatosCuentaXOficina
(
	identificador	int identity,
	oficina 		smallint,
	cantidad_cta	int
)

set @w_existe = 'N'

/****************************************************************************************************/
/*  Inicializacion de Tabla de Acumulacion															*/
/****************************************************************************************************/
--select @w_contador = (select isnull(count(*), 0) from cob_ahorros..ah_acumulador)

--if @w_contador > 0
	truncate table cob_ahorros..ah_acumulador
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 288503,
				@w_msg		= 'ERROR AL ELIMINAR TABLA ah_acumulador'
		goto ERRORFIN
	end 
--else
--	Print 'cob_ahorros..ah_acumulador No tiene Registros'

/****************************************************************************************************/
/*  Tabla de reprocesamiento de cuentas																*/
/****************************************************************************************************/
set @w_contador = 0
set @w_contador = (select isnull(count(*), 0) from cob_ahorros..sysobjects where name = 'ah_cuenta_batch')
		
if @w_contador > 0
begin
	set @w_existe = 'S'
	truncate table cob_ahorros..ah_cuenta_batch
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 288503,
				@w_msg		= 'ERROR AL ELIMINAR TABLA ah_cuenta_batch'
		goto ERRORFIN
	end 
end
else
begin
	set @w_existe = 'N'
	create table cob_ahorros..ah_cuenta_batch (cb_cuenta cuenta not null)
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 357020,
				@w_msg		= 'ERROR EN CREACION DE TABLA ah_cuenta_batch'
		goto ERRORFIN
	end 
end

insert into cob_ahorros..ah_cuenta_batch values ('0')

if (@@error > 0)
begin
	select 	@w_error 	= 263500,
			@w_msg		= 'ERROR EN INGRESO EN TABLA ah_cuenta_batch DATO INCIAL'
	goto ERRORFIN
end 

/****************************************************************************************************/
/*  Tabla de rangos de oficinas																		*/
/****************************************************************************************************/
truncate table cob_ahorros..ah_rango_oficina_batch

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_rango_oficina_batch'
	goto ERRORFIN
end 

set @w_rango			= 1
set @w_tot_ctas			= 0
set @w_ofi_ini			= 0
set @w_ofi_fin			= 0

set @w_num_ctas =  (select isnull(count(*), 0) from cob_ahorros..ah_cuenta) 
set @w_num_ctas =  (@w_num_ctas/4 + 1)

insert into #DatosCuentaXOficina
select ah_oficina, count(*)
	from cob_ahorros..ah_cuenta 
	group by ah_oficina 
	order by ah_oficina
	
if (@@error > 0)
begin
	select 	@w_error 	= 263500,
			@w_msg		= 'ERROR EN INGRESO DE DATOS CUENTAS POR OFICINA'
	goto ERRORFIN
end 

select @w_fila_0 = isnull(min(identificador), 0) from #DatosCuentaXOficina
select @w_no_fila_0 = isnull(max(identificador), 0) from #DatosCuentaXOficina

if (@w_fila_0 > 0)
begin
	while @w_fila_0 <= @w_no_fila_0
	begin
		select 	@w_ah_oficina = oficina, 
				@w_num_ctas_ofi = cantidad_cta
			from #DatosCuentaXOficina
			where identificador = @w_fila_0
			
		select @w_oficina = @w_ah_oficina

		if @w_tot_ctas = 0
		begin
			select @w_ofi_ini  = @w_ah_oficina
		end

		select @w_acum = @w_tot_ctas + @w_num_ctas_ofi
	
		if @w_acum >= @w_num_ctas
		begin
			select @w_ofi_fin = @w_ah_oficina

			insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, @w_ofi_ini, @w_ofi_fin, '0', -1) 
			
			if (@@error > 0)
			begin
				select 	@w_error 	= 263500,
						@w_msg		= 'ERROR EN INGRESO DE EN TABLA ah_rango_oficina_batch: RANGO = ' + CONVERT(VARCHAR, @w_rango) + ', OFICINA INICIO = ' + CONVERT(VARCHAR, @w_ofi_ini)+ ', OFICINA FIN = ' + CONVERT(VARCHAR, @w_ofi_fin)
				goto ERRORFIN
			end 

			select @w_tot_ctas = 0
			select @w_rango = @w_rango + 1
		end
		else
		begin
			select @w_tot_ctas = @w_tot_ctas + @w_num_ctas_ofi
		end
		
		select @w_fila_0 = @w_fila_0 + 1
	end
end

if @w_tot_ctas > 0
begin
	insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, @w_ofi_ini, @w_oficina, '0', -1)
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= 'ERROR EN INGRESO DE EN TABLA ah_rango_oficina_batch: RANGO = ' + CONVERT(VARCHAR, @w_rango) + ', OFICINA INICIO = ' + CONVERT(VARCHAR, @w_ofi_ini)+ ', OFICINA FIN = ' + CONVERT(VARCHAR, @w_ofi_fin)
		goto ERRORFIN
	end 
end

while @w_rango < 4
begin
	insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, -1, -1, '0', -1) 
	
	if (@@error > 0)
	begin
		select 	@w_error 	= 263500,
				@w_msg		= 'ERROR EN INGRESO DE EN TABLA ah_rango_oficina_batch: RANGO = ' + CONVERT(VARCHAR, @w_rango)
		goto ERRORFIN
	end
	
	select @w_rango = @w_rango + 1
end 

/****************************************************************************************************/
/*Inicializacion de Tabla de Reportes de Saldos														*/
/****************************************************************************************************/
truncate table cob_ahorros..ah_saldos_rep

if (@@error > 0)
begin
	select 	@w_error 	= 288503,
			@w_msg		= 'ERROR AL ELIMINAR TABLA ah_saldos_rep'
	goto ERRORFIN
end 

return 0

ERRORFIN:

exec sp_errorlog
	@i_fecha       = @w_fecha_proceso,
	@i_error       = @w_error,
	@i_usuario     = 'batch',
	@i_tran        = @w_trn_code,
	@i_descripcion = @w_msg,
	@i_programa    = @w_sp_name

return 1

go
	