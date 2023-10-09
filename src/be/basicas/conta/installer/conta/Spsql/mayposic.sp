/************************************************************************/
/*	Archivo: 		mayposic.sp			        */
/*	Stored procedure: 	sp_mayoriza_posicion			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   'Mayorizacion' de posicion moneda extranjera                 */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	05/Mar/1994	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mayoriza_posicion')
	drop proc sp_mayoriza_posicion  
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_mayoriza_posicion (
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
	@t_from		varchar(14) = null,
	@i_empresa 	tinyint = null,
        @i_fecha_tran 	datetime = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint  = null,
	@i_posicion  	money = null 
	)                        
as

declare @w_today 	datetime,
	@w_return	int,
	@w_sp_name	varchar(32),
	@flag1 		int,             /* flag cuentas */
	@flag2 		int,             /* flag oficinas */
        @flag3 		int,             /* flag cortes  */
        @flag4 		int,             /* flag cortes  */
	@padre_cta 	char(20), 
	@padre_oficina 	int,
	@temp_oficina 	smallint,
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
select @w_sp_name = 'sp_mayoriza_posicion'


/************************************************/
/*  Tipo de Transaccion = 6311			*/

if (@t_trn <> 6311 )
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/

/********* Selecciona la cuenta de grupo superior ********/


select @padre_cta = cu_cuenta_padre
from cb_cuenta
where 	cu_empresa = @i_empresa and
	cu_cuenta = @i_cuenta 

select @i_cuenta = @padre_cta


            /*******        *******/


/***  DETERMINAR A QUE CORTE PERTENECE EL ASIENTO  ***/

select @corte = co_corte, @periodo = co_periodo, @w_estado = co_estado
from cb_corte
where co_empresa = @i_empresa and
      co_fecha_ini <= @i_fecha_tran and
      co_fecha_fin >= @i_fecha_tran 

if @@rowcount = 0
begin
	/* 'Periodo o corte no definido para mayorizar'*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 603023
	return 1
end

if @w_estado <> 'A' and @w_estado <> 'V'
begin
	/* 'Cortes con estado NO VIGENTE  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 603023
	return 1
end


select @corte_ini = @corte      
            /*******        *******/


begin tran
select @temp_oficina = @i_oficina
select @flag1 = 1
select @flag4 = 0
while @flag1 > 0
begin
	if @i_cuenta IS NOT NULL
	begin
	  select @flag2 = 1
	  while @flag2 > 0
	  begin
	    if @i_oficina IS NOT NULL
	    begin
		if NOT EXISTS (select * from cb_saldo        
			      where sa_empresa = @i_empresa and
                                    sa_periodo = @periodo and
                                    sa_corte  = @corte and
			            sa_oficina = @i_oficina and 
				    sa_cuenta = @i_cuenta)
		begin 
		/* 'Error en la insercion de saldos al mayorizar Posicion' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601001
			return 1
		end
                else
                begin
                /* SI EXISTE REGISTRO DE LA CUENTA, LO ACTUALIZA */
                  update cb_saldo
                  set sa_saldo_me = sa_saldo_me + @i_posicion
		  where sa_empresa = @i_empresa and
                        sa_periodo = @periodo and
                        sa_corte  = @corte and
		        sa_oficina = @i_oficina and 
			sa_cuenta = @i_cuenta

		  if @@error <> 0
		  begin
		/* 'Error en la actualizacion de saldos al mayorizar posicion'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605036
			return 1
	 	  end
                 end

               /* DETERMINA CODIGO DE OFICINA CONSOLIDADA */ 
               select @corte = @corte_ini
               select @valor = @valor_ini
	       if @flag4 = 0
	       begin
		 select @i_oficina = of_oficina
		 from cb_oficina
		 where of_empresa = @i_empresa and
			of_oficina_padre is null

		 select @flag4 = 1
	       end
	       else select @i_oficina = null 

/*****************
	       select @padre_oficina = of_oficina_padre
	       from cb_oficina                                   
	       where 	of_empresa = @i_empresa and
			of_oficina = @i_oficina 
	       select @i_oficina = @padre_oficina         
******************/


	    end
	    else
	    begin
                 /* DETERMINA EL PADRE DE LA CUENTA ACTUAL Y REPITE EL 
                    PROCESO CON LOS CENTROS DE COSTO */ 
		 select @flag4 = 0
                 select @flag2 = 0 
                 select @i_oficina = @temp_oficina 

		 select @padre_cta = cu_cuenta_padre
		 from cb_cuenta
		 where 	cu_empresa = @i_empresa and
			cu_cuenta = @i_cuenta 

		 select @i_cuenta = @padre_cta

		 continue
	    end
          end 
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
