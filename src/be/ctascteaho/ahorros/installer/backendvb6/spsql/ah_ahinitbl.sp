/************************************************************************/
/*      Archivo           :  sp_ah_ahinitbl                               */
/*      Base de datos     :  cob_ahorros                                */
/*      Producto          :  Cuentas de Ahorros                         */
/*      Disenado por      :  Andres Enriquez							*/
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
/*	    30/Mayo/1999	    Andres Enriquez 	Emision Inicial			*/
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

	@i_filial			int			= null,
	@i_fecha_proceso	datetime	,
   	@t_show_version     bit			= 0	,
    @o_registros        int			= 0	output
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

	@return_value		int
	
	select @w_sp_name = 'sp_ah_ahinitbl'

	if @t_show_version = 1
	begin
		 print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
		return 0
	end

	set @w_existe = 'N'
	
	/****************************************************************************************************/
	/*  Inicializacion de Tabla de Acumulacion															*/
	/****************************************************************************************************/
	 select @w_contador = ( select count(*) from cob_ahorros..ah_acumulador)
			if @w_contador > 0
				truncate table cob_ahorros..ah_acumulador
            else
				Print 'cob_ahorros..ah_acumulador No tiene Registros'

	/****************************************************************************************************/
	/*  Tabla de reprocesamiento de cuentas																*/
	/****************************************************************************************************/
	 set @w_contador = 0
	 set @w_contador = (select count(*) from cob_ahorros..sysobjects where name = 'ah_cuenta_batch')
			if @w_contador > 0
			begin
				set @w_existe = 'S'
					truncate table cob_ahorros..ah_cuenta_batch
			end
            else
			begin
				set @w_existe = 'N'
				  	create table cob_ahorros..ah_cuenta_batch (cb_cuenta  cuenta  not null)
					insert into cob_ahorros..ah_cuenta_batch 	values ('0')
			end

	/****************************************************************************************************/
	/*  Tabla de rangos de oficinas																		*/
	/****************************************************************************************************/
	 set @w_contador = null
	 set @w_contador = ( select count(*) from cob_ahorros..ah_rango_oficina_batch)
			if @w_contador > 0
			begin
				truncate table cob_ahorros..ah_rango_oficina_batch

				set @w_rango			= 1
				set @w_tot_ctas			= 0
				set @w_ofi_ini			= 0
				set @w_ofi_fin			= 0

				set @w_num_ctas =  (select count(*)  from cob_ahorros..ah_cuenta ) 
				set @w_num_ctas =  ( @w_num_ctas/4 + 1)
				
				Declare db_cursor  cursor GLOBAL
				for  select ah_oficina, count(*) as num_ctas_ofi from cob_ahorros..ah_cuenta group by ah_oficina order by ah_oficina
				Open db_cursor 
					fetch db_cursor  into @w_ah_oficina , @w_num_ctas_ofi
					while(@@fetch_status=0)
					begin
					       
							set @w_oficina = @w_ah_oficina

							if @w_tot_ctas = 0
							begin
								set  @w_ofi_ini  = @w_ah_oficina
							end

							set @w_acum = @w_tot_ctas + @w_num_ctas_ofi
						
							if @w_acum >= @w_num_ctas
							begin
								set @w_ofi_fin = @w_ah_oficina

								insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, @w_ofi_ini, @w_ofi_fin, '0', -1) 
																							
								set @w_tot_ctas = 0
								set @w_rango = @w_rango +1
							end
							else
							begin
								set @w_tot_ctas = @w_tot_ctas + @w_num_ctas_ofi
							end
						
					fetch db_cursor  
					into @w_ah_oficina , @w_num_ctas_ofi
				end
				close db_cursor 
				deallocate db_cursor 
				
			end
            else
			begin
				Print 'cob_ahorros..ah_acumulador No tiene Registros'
			end

			if @w_tot_ctas > 0
			begin
				insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, @w_ofi_ini, @w_oficina, '0', -1) 
			end
			
			while @w_rango < 4
			begin
				      insert into cob_ahorros..ah_rango_oficina_batch values (@w_rango, -1, -1, '0', -1) 
			end 

	/****************************************************************************************************/
	/*																									*/
	/****************************************************************************************************/
	 set @w_contador = 0
	 set @w_contador = (select count(*) from tempdb..sysobjects where name = 'ah_cuenta_batch')
			if @w_contador > 0
			begin
				set @w_existe = 'S'
			end
            else
			begin
				set @w_existe = 'N'
			end

	/****************************************************************************************************/
	/*																									*/
	/****************************************************************************************************/
	 set @w_contador = 0
	 set @w_contador = (select count(*) from cob_ahorros..ah_saldos_rep)
			if @w_contador > 0
			begin
				truncate table cob_ahorros..ah_saldos_rep
			end
            
		