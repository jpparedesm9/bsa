/************************************************************************/
/*	Archivo: 		maybatch.sp			        */
/*	Stored procedure: 	sp_maybatch				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     14-AGO-1995   				*/
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
/*	Este programa realiza la mayorizacion masiva de transacciones   */
/*	                                                                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	14-Ago/1995	M.Suarez        Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_maybatch')
	drop proc sp_maybatch  
go
create proc sp_maybatch (
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
        @i_fecha_tran 	datetime = null,
	@p_operacion 	int = null 
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
	@padre_oficina 	smallint,
	@temp_oficina 	smallint,
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
	@valor_me	money,
        @valor_ant 	money,
        @valor_ini 	money,
	@w_estado	char(1),
        @w_cuenta       cuenta,
        @w_cuenta_ini   cuenta,
        @w_oficina      smallint,
        @w_area         smallint,
        @w_debito       money,
        @w_credito      money,
        @w_debito_me    money,
        @w_credito_me   money,
        @w_numrec       int


select @w_today = getdate()
select @w_sp_name = 'sp_maybatch'


/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6301) 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


/***  DETERMINAR A QUE CORTE PERTENECE EL ASIENTO  ***/

select @corte = co_corte, @periodo = co_periodo, @w_estado = co_estado
from cob_conta..cb_corte
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

 select @corte_ini = @corte      
 select @w_numrec  = 0

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

/** Define cursor  ******************************/
declare cursor_asientos cursor
for select
    as_cuenta,      as_oficina_dest,
    as_area_dest,   
    sum(as_debito),     sum(as_credito),
    sum(as_debito_me),  sum(as_credito_me)
from cb_asiento , cb_comprobante
where as_empresa = @i_empresa
  and as_fecha_tran = @i_fecha_tran
  and as_mayorizado = 'N'
  and co_empresa = @i_empresa
  and co_fecha_tran = @i_fecha_tran
  and co_comprobante = as_comprobante
  and co_autorizado  = 'S'
group by as_oficina_dest, as_area_dest, as_cuenta



open cursor_asientos
fetch cursor_asientos into @w_cuenta, @w_oficina, @w_area,
                           @w_debito, @w_credito,
                           @w_debito_me, @w_credito_me
while (@@fetch_status = 0)
begin
/*** DETERMINAR SIGNO DEL VALOR A AFECTAR EN LA CUENTA ***/
 select @valor = (@w_debito - @w_credito) * @p_operacion
 select @valor_me = (@w_debito_me - @w_credito_me) * @p_operacion
 select @valor_ini = @valor
 select @w_cuenta_ini = @w_cuenta
 select @w_numrec = @w_numrec + 1

begin tran
select @flag1 = 1
while @flag1 > 0
begin
	if @w_cuenta IS NOT NULL
	begin
              select @flag3 = 1
              while @flag3 > 0
              begin
		if NOT EXISTS (select * from cob_conta..cb_saldo        
			      where sa_empresa = @i_empresa and
                                    sa_periodo = @periodo   and
                                    sa_corte   = @corte     and
			            sa_oficina = @w_oficina and 
				    sa_area    = @w_area    and
				    sa_cuenta  = @w_cuenta  )
		begin 
                /* SI NO EXISTE REGISTRO DE LA CUENTA, */
                /* INSERTA UNO NUEVO                   */

                  insert into cob_conta..cb_saldo  
			( sa_cuenta,sa_oficina,sa_area,sa_corte,
			  sa_periodo,sa_empresa,sa_saldo,
			  sa_saldo_me,sa_credito,sa_debito,sa_credito_me,
			  sa_debito_me
			)
                  values (@w_cuenta,@w_oficina,@w_area,@corte,@periodo,
                          @i_empresa,@valor,@valor_me,@w_credito,@w_debito,
			  @w_credito_me,@w_debito_me)

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
                else begin
                /* SI EXISTE REGISTRO DE LA CUENTA, LO ACTUALIZA */
                  update cob_conta..cb_saldo
                  set 	sa_saldo = sa_saldo + @valor,
			sa_saldo_me = sa_saldo_me + @valor_me,
			sa_credito  = sa_credito + @w_credito,
			sa_debito   = sa_debito + @w_debito,
			sa_credito_me = sa_credito_me + @w_credito_me,
			sa_debito_me  = sa_debito_me + @w_debito_me
		  where sa_empresa = @i_empresa and
                        sa_periodo = @periodo   and
                        sa_corte   = @corte     and
		        sa_oficina = @w_oficina and 
			sa_area    = @w_area    and
			sa_cuenta  = @w_cuenta 
                        

		  if @@error <> 0
		  begin
			/* 'Error en la actualizacion de saldos al mayorizar' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605036
                        close cursor_asientos
                        deallocate cursor_asientos
			return 1
	 	  end
                 end
                 /* DETERMINA SIGUIENTE CORTE A ACTUALIZAR */
                 select @corte_new = @corte + 1
                 if EXISTS (select * from cb_corte
                            where co_corte = @corte_new and
                                  (co_estado  = "V" or 
                                   co_estado  = "A" ) and
                                  co_periodo = @periodo and
				  co_empresa = @i_empresa
			    )
                     select @corte = @corte_new
                 else select @flag3 = 0, @corte = @corte_ini
               end  /* end flag 3 */
                /* DETERMINA EL PADRE DE LA CUENTA ACTUAL Y REPITE EL 
                   PROCESO CON LOS CORTES Y OFICINAS*/ 
                select @flag2 = 0 
	        select @valor_me = 0
		select @w_credito_me = 0
		select @w_debito_me = 0

	        select @padre_cta = cu_cuenta_padre
		from cb_cuenta
		where 	cu_empresa = @i_empresa and
			cu_cuenta = @w_cuenta 

		select @w_cuenta = @padre_cta
	end  /* end cuenta = null */
	else
	begin
	     select @flag1 = 0
	     continue
	end
end /* end flag1 */

/* Marcar status mayorizado */

update cb_asiento
   set as_mayorizado = 'S'
 from cb_comprobante
where as_empresa = @i_empresa
  and as_fecha_tran = @i_fecha_tran
  and as_oficina_dest = @w_oficina
  and as_area_dest  = @w_area
  and as_cuenta     = @w_cuenta_ini
  and as_mayorizado = 'N'
  and co_empresa    = @i_empresa
  and co_fecha_tran = @i_fecha_tran
  and co_comprobante = as_comprobante
  and co_autorizado  = 'S'

commit tran
fetch cursor_asientos into @w_cuenta, @w_oficina, @w_area,
                           @w_debito, @w_credito,
                           @w_debito_me, @w_credito_me
end /* end sqlstatus */

close cursor_asientos
deallocate cursor_asientos

/** Marcar Status cabecera de comprobantes **/

begin tran
update cb_comprobante
   set co_mayorizado = 'S'
where co_empresa    = @i_empresa
  and co_fecha_tran = @i_fecha_tran
  and co_autorizado  = 'S'
commit tran

select @w_numrec
return 0
go
