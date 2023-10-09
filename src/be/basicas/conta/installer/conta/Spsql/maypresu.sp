/************************************************************************/
/*	Archivo: 		maypresu.sp			        */
/*	Stored procedure: 	sp_maypresu				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     21-Octubre-1994				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Mayoriza los saldos reales a nivel de oficinas y areas de       */
/*	movimiento                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	26/Jul/1995	G Jaramillo     Emision Inicial			*/
/*	04/Nov/1996	D.Guerrero      Mayoriza saldos a nivel de      */
/*	                                oficinas y areas de movimiento  */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_maypresu')
	drop proc sp_maypresu  
go
create proc sp_maypresu (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint  = null,
	@i_area		smallint = null,
        @i_presupuesto  money = 0,
	@i_real 	money = 0,
	@i_fecha	datetime = null 
		)                        
as

declare @w_today 	datetime,
	@w_return	int,
	@w_sp_name	varchar(32),
	@flag1 		int,             /* flag cuentas */
	@flag2 		int,             /* flag oficinas */
        @flag3 		int,             /* flag cortes  */
        @flag4 		int,             /* flag ofc. consolidada*/
	@padre_cta 	char(20), 
	@w_cta_superior char(20),
	@w_area_superior	smallint,
	@padre_oficina 	int,
	@temp_oficina 	int,
	@padre_area	smallint,
	@temp_area	smallint,
	@cuenta_nom 	varchar(64),
	@oficina_nom 	varchar(64),
        @categoria 	char(1),
        @corte 		int,    
        @corte_ini 	int,    
        @corte_new 	int,    
        @periodo 	tinyint,
        @periodo_ant 	tinyint,
        @valor 		money,
        @valor_ant 	money,
        @valor_ini 	money,
	@w_estado	char(1)


select @w_today = getdate()
select @w_sp_name = 'sp_maypresu'


/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6303) 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


/***********************************************/

begin tran
select @flag4 = 0
select @flag1 = 1

while @flag1 > 0
begin
	if @i_cuenta IS NOT NULL
	begin
		   if NOT EXISTS (select * from cob_conta..cb_saldo_presupuesto
			      where sap_empresa = @i_empresa and
			            sap_oficina = @i_oficina and 
				    sap_area    = @i_area and
				    sap_cuenta = @i_cuenta and
				    sap_fecha = @i_fecha)
		   begin 
                   /* SI NO EXISTE REGISTRO DE LA CUENTA, */
                   /* INSERTA UNO NUEVO                   */

                    insert into cob_conta..cb_saldo_presupuesto
			( sap_cuenta,sap_oficina,sap_area,sap_fecha,
			  sap_empresa,sap_real)
                     values (@i_cuenta,@i_oficina,@i_area,@i_fecha,
                          @i_empresa,@i_real)

		     if @@error <> 0
		     begin
			/* 'Error en la insercion de saldos al mayorizar' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
	 	     end
		   end
                   else
                   begin


                   /* SI EXISTE REGISTRO DE LA CUENTA, LO ACTUALIZA */
                     update cob_conta..cb_saldo_presupuesto
                     set sap_real = isnull(sap_real,0) + @i_real  
		     where sap_empresa = @i_empresa and
		        sap_oficina = @i_oficina and 
			sap_area    = @i_area and
			sap_cuenta  = @i_cuenta and
			sap_fecha   = @i_fecha

		     if @@error <> 0
		     begin
			/* 'Error en la actualizacion de saldos al mayorizar' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605036
			return 1
	 	     end
                    end
                 /* DETERMINA EL PADRE DE LA CUENTA ACTUAL Y REPITE EL 
                    PROCESO CON LOS CORTES Y OFICINAS*/ 
		 select @flag4 = 0
                 select @flag2 = 0 
		 select @padre_cta = cup_cuenta_padre
		 from cb_cuenta_presupuesto
		 where 	cup_empresa = @i_empresa and
			cup_cuenta = @i_cuenta 

		 select @i_cuenta = @padre_cta

		 continue
	end 
	else
	begin
	     select @flag1 = 0
	     continue
	end
end
commit tran
return 0
go
