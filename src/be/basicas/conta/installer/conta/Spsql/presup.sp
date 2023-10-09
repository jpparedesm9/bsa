/************************************************************************/
/*	Archivo: 		presup.sp  			        */
/*	Stored procedure: 	sp_presupuesto				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo  	        	*/
/*	Fecha de escritura:     24-Octubre-1994				*/
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
/*	   Mantenimiento al catalogo de saldos de Presupuesto   	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Oct/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_presupuesto')
	drop proc sp_presupuesto  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_presupuesto (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = 0,
	@i_empresa              tinyint = null,
	@i_cuenta         	cuenta= null,
	@i_oficina		smallint = null,
	@i_area  		smallint = null ,
	@i_fecha		datetime = null,
	@i_presupuesto		money = null,
	@i_real			money = null,
	@i_anio			smallint = null,
	@i_formato_fecha	smallint = null,
	@i_cuenta1              cuenta = null,
	@i_cuenta2              cuenta = null,
	@i_mes                  tinyint  = null,
        @i_entre_fechas		char(1) = null,
        @i_fecha_ini 		datetime = null,
        @i_fecha_fin 		datetime = null,
        @i_fecha1    		datetime = null,
        @i_periodicidad		char(1) = null
)
as 
declare
	@w_today 		datetime,  	
	@w_return		int,		
	@w_sp_name		varchar(32),	
	@w_siguiente		tinyint,
	@w_cuenta         	cuenta,
	@w_empresa		tinyint,
	@w_oficina		smallint,
	@w_area			smallint,
	@w_presupuesto		money,
	@w_fecha		datetime,
        @w_real			money,
 	@w_saldo_cuenta         money,
        @w_suma_presup          money,
        @w_periodo              int,            
        @w_mes                  smallint,       
        @w_valor                money,          
        @w_cont                 int,            
	@w_existe		int		
						

select @w_today = getdate()
select @w_sp_name = 'sp_presupuesto'



if (@t_trn <> 6601 and @i_operacion = 'I') or
   (@t_trn <> 6602 and @i_operacion = 'U') or
   (@t_trn <> 6603 and @i_operacion = 'D') or
   (@t_trn <> 6606 and @i_operacion = 'Q') or
   (@t_trn <> 6119 and @i_operacion = 'E') or
   (@t_trn <> 6841 and @i_operacion = 'P') or  
   (@t_trn <> 6841 and @i_operacion = 'C') 
begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,
		i_cuenta   	= @i_cuenta ,
                i_oficina	= @i_oficina,
		i_area		= @i_area,
		i_presupuesto   = @i_presupuesto,
		i_real		= @i_real
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select  @w_empresa = sap_empresa,
		@w_cuenta  = sap_cuenta,
		@w_oficina = sap_oficina,
		@w_area    = sap_area,
		@w_fecha   = sap_fecha,
		@w_presupuesto = sap_presupuesto,
		@w_real	   = sap_real
	from cob_conta..cb_saldo_presupuesto
	where 	sap_empresa = @i_empresa and 
		sap_fecha   = @i_fecha and
		sap_cuenta  = @i_cuenta and
		sap_oficina = @i_oficina and
		sap_area    = @i_area 

	if @@rowcount > 0
		select @w_existe = 1 
	else
		select @w_existe = 0
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin

	/* Validacion de datos */
	/***********************/

	if 	@i_empresa is null or 
		@i_cuenta  is null or @i_oficina is null or
		@i_area    is null or
		@i_fecha   is null
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

	/**** Integridad Referencial *****/
	/*********************************/
	
        if NOT EXISTS (select * from cob_conta..cb_plan_general_presupuesto
			where  pgp_empresa = @i_empresa
			and    pgp_cuenta  = @i_cuenta
			and    pgp_oficina = @i_oficina
			and    pgp_area    = @i_area)
	begin
		/* 'No existe empresa' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609143
		return 1
	end

end


/****************************/
if @i_operacion = 'P'
begin
      select @w_mes = 0, @w_valor=0

      select @w_periodo = co_periodo
        from cb_corte
        where co_empresa = @i_empresa and
              co_fecha_ini <= @i_fecha_ini and
              co_fecha_fin >= @i_fecha_ini

      select @w_mes = datepart(mm, co_fecha_ini)
        from cb_corte
         where co_empresa = @i_empresa and
               co_periodo = @w_periodo and
               co_estado = 'A'   

          if @w_mes <> 0
              begin
                if @i_modo = 0
                begin


                 select @w_valor =isnull(sum(sap_real),0),
                        @w_cont = count(*)
                   from cob_conta..cb_saldo_presupuesto
                   where sap_empresa = @i_empresa and
                          sap_oficina in (
                            select je_oficina from cb_jerarquia
                            where je_empresa = @i_empresa
                            and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina)) and
                          sap_area    in (select ja_area from cb_jerararea
	                          		where  ja_empresa = @i_empresa
		                          	and (ja_area = @i_area or ja_area_padre = @i_area)) and
                         sap_cuenta = @i_cuenta and
                         datepart(mm,sap_fecha) <= @w_mes and
                         datepart(yy,sap_fecha) = datepart(yy, @i_fecha_ini)
                if @w_cont <> 0
                begin
                   select @w_valor = @w_valor/@w_cont
                end
               end
               else
               begin
                 select @w_valor =isnull(sum(sap_real),0),
                        @w_cont = count(*)
                   from cob_conta..cb_saldo_presupuesto
                   where sap_empresa = @i_empresa and
                         sap_oficina = @i_oficina and
                         sap_area = @i_area and
                         sap_cuenta = @i_cuenta and
                         datepart(mm,sap_fecha) <= @w_mes and
                         datepart(yy,sap_fecha) = datepart(yy, @i_fecha_ini)
                if @w_cont <> 0
                begin
                   select @w_valor = @w_valor/@w_cont
                end

               end




              end
             select @w_mes,
                    @w_valor
        return 0

end
/****************************/

/* Insercion de cuenta */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Registro de presupuesto ya existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601145
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cob_conta..cb_saldo_presupuesto
		(sap_empresa,sap_fecha,sap_cuenta,sap_oficina,sap_area,
		 sap_presupuesto,sap_real)
		values (@i_empresa,@i_fecha,@i_cuenta,@i_oficina,@i_area,
			@i_presupuesto,@i_real)
		if @@error <> 0 
		begin
		/*'Error en insercion de presupuesto'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603055
			return 1
		end

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	/*insert into ts_saldo_presupuesto
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa,@i_cuenta,@i_oficina,@i_area,@i_presupuesto,
		@i_real)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end*/
	commit tran
	return 0
end

/* Actualizacion de cuenta  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
	/*'Registro de presupuesto a actualizar NO existe'*/
	/*	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605076
		return 1 */
	begin tran
		insert into cob_conta..cb_saldo_presupuesto
		(sap_empresa,sap_fecha,sap_cuenta,sap_oficina,sap_area,
		 sap_presupuesto,sap_real)
		values (@i_empresa,@i_fecha,@i_cuenta,@i_oficina,@i_area,
			@i_presupuesto,@i_real)
		if @@error <> 0 
		begin
		/*'Error en insercion de presupuesto'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603055
			return 1
		end

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	/*insert into ts_saldo_presupuesto
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa,@i_cuenta,@i_oficina,@i_area,@i_presupuesto,
		@i_real)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end*/
	commit tran
	return 0

	end

	/*  Actualizacion del registro  */
	/********************************/
	begin tran
		update cob_conta..cb_saldo_presupuesto
		set 	sap_presupuesto = @i_presupuesto
		where  	sap_empresa = @i_empresa and
			datepart(mm,sap_fecha) = datepart(mm,@i_fecha) and
			sap_cuenta = @i_cuenta and
			sap_oficina = @i_oficina and
			sap_area = @i_area


		if @@error <> 0
		begin
		/*'Error en Actualizacion de presupuesto'*/ 
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605077
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		/*insert into ts_saldo_presupuesto
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,
			@s_ofi,@w_empresa,@w_cuenta,@w_oficina,@w_area,
			@w_presupuesto,@w_real)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
		insert into ts_saldo_presupuesto 
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,
			@s_ofi,@i_empresa,@i_cuenta,@i_oficina,@i_area,
			@w_presupuesto,@w_real)
		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end */

	commit tran
	return 0
end

/* Eliminacion de presupuesto  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
	/*'registro de presupuesto a eliminar NO existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607116
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_saldo_presupuesto
		where 	sap_empresa = @i_empresa and
			sap_fecha  = @i_fecha and
			sap_cuenta = @i_cuenta and
			sap_oficina = @i_oficina and
			sap_area = @i_area

		if @@error <> 0
		begin
		/* 'Error en Eliminacion de registro de presupuesto' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607117
			return 1
		end
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_saldo_presupuesto
	values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		@w_empresa,@w_cuenta,@w_oficina,@w_area,
		@w_presupuesto,@w_real)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end
	/****************************************/

         commit tran
	 return 0
end


if @i_operacion = 'Q'
begin
	select  convert(char(10),sap_fecha,101),
		sap_presupuesto
	from cb_saldo_presupuesto
	where sap_empresa = @i_empresa and
	      sap_cuenta  = @i_cuenta and
	      sap_oficina = @i_oficina and
	      sap_area    = @i_area and
	      datepart(yy,sap_fecha) = @i_anio and
	      datepart(dd,dateadd(dd,1,sap_fecha)) = 1


	if @@rowcount = 0
	begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
	end
        return 0
end

/**** LEER CUENTAS EJECUCION PRESUPUESTAL ****/
/****************/
if @i_operacion = 'E'
begin
        select  @w_presupuesto = sap_presupuesto,
		@w_real = sap_real
        from cob_conta..cb_saldo_presupuesto
        where sap_empresa  = @i_empresa and
              sap_cuenta   = @i_cuenta and
              sap_oficina  = @i_oficina and
              datepart(yy,sap_fecha) = @i_anio and
              datepart(mm,sap_fecha) = @i_mes
        select @w_suma_presup = sum(sap_presupuesto)
        from cob_conta..cb_saldo_presupuesto
        where   sap_empresa = @i_empresa and
                sap_cuenta = @i_cuenta and
                sap_oficina = @i_oficina and
                datepart(yy,sap_fecha) = @i_anio

 	/*select @w_saldo_cuenta = sa_saldo
        from cob_conta..cb_saldo
        where   sa_empresa = @i_empresa and
                sa_oficina = @i_oficina and
                sa_cuenta = @i_cuenta*/
        select @w_presupuesto, @w_real, @w_suma_presup
      if @@rowcount = 0
      begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
      end
      return 0
end

if @i_operacion = 'C'

set rowcount 20

begin  
   if @i_entre_fechas is null  -- Primera Consulta
   begin
  
      if @i_modo = 0
      begin
      	select 	"Cuenta"             = sap_cuenta, 
             	"Nombre"             = substring(cu_nombre,1,30),
             	--"Movimiento Real  "  = round(isnull(sum(sap_real),0),0),
	     	--"Presupuesto Mes "   = round(isnull(sum(sap_presupuesto),0),0),
             	--"Variacion" 	     = round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
             	"Movimiento Real  "  = isnull(sum(sap_real),0),
	     	"Presupuesto Mes "   = isnull(sum(sap_presupuesto),0),
             	"Variacion" 	     = sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
            	"Porc. de Ejecucion" = ""  
      	from cb_saldo_presupuesto, cb_cuenta
      	where sap_empresa = @i_empresa and
         	sap_empresa = cu_empresa and
	 	sap_fecha = @i_fecha and
                sap_oficina in (select je_oficina from cb_jerarquia
                          	where je_empresa = @i_empresa
                          	and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina)) and
                sap_area    in (select ja_area from cb_jerararea
                          	where  ja_empresa = @i_empresa
                          	and (ja_area = @i_area or ja_area_padre = @i_area)) and
    	 	sap_cuenta like @i_cuenta and
         	sap_cuenta = cu_cuenta and
         	cu_cuenta like @i_cuenta and
		(sap_cuenta > @i_cuenta1 or @i_cuenta1 is null)
      	group by sap_cuenta, cu_nombre 
 
      	if @@rowcount = 0
      	begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
      	end
      end
      else
      begin
      	select 	"Cuenta"            = sap_cuenta, 
        	"Nombre"            = substring(cu_nombre,1,30),
             	--"Movimiento Real  " = round(isnull(sum(sap_real),0),0),
	     	--"Presupuesto Mes "  = round(isnull(sum(sap_presupuesto),0),0),
             	--"Variacion" = round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
             	"Movimiento Real  " = isnull(sum(sap_real),0),
	     	"Presupuesto Mes "  = isnull(sum(sap_presupuesto),0),
             	"Variacion" = sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
             	"Porc. de Ejecucion" = ""  
      	from cb_saldo_presupuesto, cb_cuenta
      	where 	sap_empresa = @i_empresa and
         	sap_empresa = cu_empresa and
	 	sap_fecha = @i_fecha and
  	 	sap_oficina = @i_oficina and
	 	sap_area  = @i_area and
    	 	sap_cuenta like @i_cuenta and
         	sap_cuenta = cu_cuenta and
         	cu_cuenta like @i_cuenta and
		(sap_cuenta > @i_cuenta1 or @i_cuenta1 is null)
      	group by sap_cuenta, cu_nombre 
 
      	if @@rowcount = 0
      	begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
      	end

      end
      return 0
   end
   else -- Segunda Consulta
   begin
      
     if @i_modo = 0
     begin
     	select 	"Fecha" 		=  convert(char(10),sap_fecha,@i_formato_fecha),
             	--"Movimiento Real  " 	= round(isnull(sum(sap_real),0),0),
	     	--"Presupuesto Mes "  	= round(isnull(sum(sap_presupuesto),0),0),
             	--"Variacion" 		= round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
             	"Movimiento Real  " 	= isnull(sum(sap_real),0),
	     	"Presupuesto Mes "  	= isnull(sum(sap_presupuesto),0),
             	"Variacion" 		= sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
             	"Porc. de Ejecucion" 	= ""   
      	from cb_saldo_presupuesto, cb_cuenta
      	where 
            sap_empresa = @i_empresa and
            sap_empresa = cu_empresa and
            sap_fecha  >= @i_fecha_ini and 
            sap_fecha  <= @i_fecha_fin and
            sap_oficina in (select je_oficina from cb_jerarquia
                          where je_empresa = @i_empresa
                          and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina)) and
            sap_area    in (select ja_area from cb_jerararea
                          where  ja_empresa = @i_empresa
                          and    (ja_area = @i_area or ja_area_padre = @i_area)) and
            sap_cuenta  = @i_cuenta and 
            sap_cuenta = cu_cuenta and
            sap_cuenta = @i_cuenta and
           (sap_fecha > @i_fecha1 or @i_fecha1 is null)
      	group by sap_fecha 

      	if @@rowcount = 0
      	begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
      	end
      end
      else
      begin
     	select 	"Fecha" 		=  convert(char(10),sap_fecha,@i_formato_fecha),
             	--"Movimiento Real  " 	= round(isnull(sum(sap_real),0),0),
	     	--"Presupuesto Mes "  	= round(isnull(sum(sap_presupuesto),0),0),
             	--"Variacion" 		= round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
             	"Movimiento Real  " 	= isnull(sum(sap_real),0),
	     	"Presupuesto Mes "  	= isnull(sum(sap_presupuesto),0),
             	"Variacion" 		= sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
             	"Porc. de Ejecucion" 	= ""   
      	from cb_saldo_presupuesto, cb_cuenta
      	where 
            sap_empresa = @i_empresa and
            sap_empresa = cu_empresa and
            sap_fecha  >= @i_fecha_ini and 
            sap_fecha  <= @i_fecha_fin and
  	    sap_oficina  = @i_oficina and
	    sap_area = @i_area and
            sap_cuenta  = @i_cuenta and 
            sap_cuenta = cu_cuenta and
            sap_cuenta = @i_cuenta and
           (sap_fecha > @i_fecha1 or @i_fecha1 is null)
      	group by sap_fecha 

      	if @@rowcount = 0
      	begin
		/* 'No existen registros de presupuesto */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601146
		return 1
      	end

      end
      return 0
   end

end 
go
