/************************************************************************/
/*	Archivo: 		mayorifp.sp			        */
/*	Stored procedure: 	sp_mayorizafp				*/
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
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mayorizacion de asientos de fin de periodo                   */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	25/Jul/1996	S. de la Cruz	Utilizacion tabla cb_hist_saldo */
/*	22/Jul/1997	F Salgado	Estandarizacion version 3.0	*/
/*					Manejo variables @valor FS001 	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mayorizafp')
	drop proc sp_mayorizafp  
go
create proc sp_mayorizafp (
	@s_ssn		  int = null,
	@s_date		  datetime = null,
	@s_user		  login = null,
	@s_term		  descripcion = null,
	@s_corr		  char(1) = null,
	@s_ssn_corr	  int = null,
        @s_ofi		  tinyint = null,
	@t_rty		  char(1) = null,
        @t_trn		  smallint = null,
	@t_debug	  char(1) = 'N',
	@t_file		  varchar(14) = null,
	@t_from		  varchar(30) = null,
	@i_empresa 	  tinyint = null,
        @i_fecha_tran 	  datetime = null,
	@i_cuenta 	  cuenta = null,
	@i_oficina 	  smallint  = null,
	@i_area		  smallint = null,
        @i_credito 	  money = 0,
        @i_debito  	  money = 0,
	@i_credito_me 	  money = 0,
	@i_debito_me	  money = 0,
	@p_operacion 	  int = null 
)                        
as

declare @w_today 	  datetime,
	@w_return	  int,
	@w_sp_name	  varchar(32),
	@flag1 		  int,
	@flag2 		  int,
        @flag3 		  int,
        @flag4 		  int,
	@padre_cta 	  char(20), 
	@padre_oficina 	  int,
	@temp_oficina 	  int,
	@padre_area	  smallint,
	@temp_area	  smallint,
	@cuenta_nom 	  varchar(64),
	@oficina_nom 	  varchar(64),
        @categoria 	  char(1),
        @corte 		  int,    
        @corte_ini 	  int,    
        @corte_new 	  int,    
        @periodo 	  int,
        @periodo_ant 	  int,
	@periodo_ini	  int,
        @valor 		  money,
	@valor_me	  money,
        @valor_ant 	  money,
        @valor_ini 	  money,
	@w_estado	  char(1),
	@estado_ini	  char(1),
        @w_corte_max 	  int,
	@w_corte_max_fp	  int,
	@w_corte_fp 	  int,
        @w_fecha_max	  datetime,
	@w_moneda_base    tinyint,
	@w_moneda_cuenta  tinyint,
	@w_status	  int,
	@w_rowcount	  int


select @w_today = getdate()
select @w_sp_name = 'sp_mayorizafp'

if (@t_trn <> 6301) 
begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

select @valor    = 0
select @valor_me = 0

if @i_credito <> 0
	select @valor = @i_credito * (-1) * @p_operacion
if @i_credito_me <> 0
	select @valor_me = @i_credito_me * (-1) * @p_operacion
if @i_debito <> 0
	select @valor = @valor + @i_debito * @p_operacion
if @i_debito_me <> 0
	select @valor_me = @valor_me + @i_debito_me * @p_operacion


select @corte    = co_corte, 
       @periodo  = co_periodo, 
       @w_estado = co_estado
from   cb_corte
where  co_empresa = @i_empresa 
and    co_fecha_ini <= @i_fecha_tran 
and    co_fecha_fin >= @i_fecha_tran 

if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 601078
    return 1
end

if @w_estado = 'N' 
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file	 = @t_file,
    @t_from	 = @w_sp_name,
    @i_num	 = 603023
    return 1
end

select @corte_ini   = @corte,
       @periodo_ini = @periodo,
       @estado_ini  = @w_estado

--begin tran

select @flag1 = 1

while @flag1 > 0
begin
  if @i_cuenta IS NOT NULL
  begin
    select @flag3 = 1
    while @flag3 > 0
    begin
      if @w_estado = 'V'
      begin





/* Inicio - Fin de Periodo */        


	select @w_corte_max_fp = max(co_corte)
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and   co_periodo = @periodo
	
	if @w_corte_max_fp = @corte
	begin
		select @w_corte_fp = @w_corte_max_fp + 1
		

        	update cob_conta_his..cb_hist_saldo
        	set    hi_saldo = hi_saldo + @valor,
        	hi_saldo_me = hi_saldo_me + @valor_me,
		hi_credito  = hi_credito + @i_credito,
		hi_debito   = hi_debito + @i_debito,
		hi_credito_me = hi_credito_me + @i_credito_me,
		hi_debito_me  = hi_debito_me + @i_debito_me
		where  hi_empresa = @i_empresa 
        	and    hi_periodo = @periodo  
        	and    hi_corte  = @w_corte_fp
        	and    hi_oficina = @i_oficina 
        	and    hi_area    = @i_area 
		and    hi_cuenta = @i_cuenta


		select @w_status=@@error, @w_rowcount=@@rowcount


        	if @w_status <> 0
		begin
	      		exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 605036
				return 1
        	end
		else
		begin
			if @w_rowcount = 0
			begin
            			insert into cob_conta_his..cb_hist_saldo  
            			( hi_cuenta,hi_oficina,hi_area,hi_corte,
	      			hi_periodo,hi_empresa,hi_saldo,
	      			hi_saldo_me,hi_credito,hi_debito,hi_credito_me,
	      			hi_debito_me
	    			)
            			values 
            			( @i_cuenta,@i_oficina,@i_area,@w_corte_fp,@periodo,
              			@i_empresa,@valor,@valor_me,@i_credito,@i_debito,
	      			@i_credito_me,@i_debito_me
            			)

	            		if @@error <> 0
	    			begin
	      				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 601001
					return 1
	    			end
			end
		end
	end
	else
	begin
        	update cob_conta_his..cb_hist_saldo
        	set    hi_saldo = hi_saldo + @valor,
        	hi_saldo_me = hi_saldo_me + @valor_me,
		hi_credito  = hi_credito + @i_credito,
		hi_debito   = hi_debito + @i_debito,
		hi_credito_me = hi_credito_me + @i_credito_me,
		hi_debito_me  = hi_debito_me + @i_debito_me
		where  hi_empresa = @i_empresa 
        	and    hi_periodo = @periodo  
        	and    hi_corte  = @corte 
        	and    hi_oficina = @i_oficina 
        	and    hi_area    = @i_area 
		and    hi_cuenta = @i_cuenta


		select @w_status=@@error, @w_rowcount=@@rowcount


        	if @w_status <> 0
		begin
	      		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605036
			return 1
        	end
		else
		begin
			if @w_rowcount = 0
			begin
            			insert into cob_conta_his..cb_hist_saldo  
            			( hi_cuenta,hi_oficina,hi_area,hi_corte,
	      			hi_periodo,hi_empresa,hi_saldo,
	      			hi_saldo_me,hi_credito,hi_debito,hi_credito_me,
	      			hi_debito_me
	    			)
            			values 
            			( @i_cuenta,@i_oficina,@i_area,@corte,@periodo,
              			@i_empresa,@valor,@valor_me,@i_credito,@i_debito,
	      			@i_credito_me,@i_debito_me
            			)

	            		if @@error <> 0
	    			begin
	      				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 601001
					return 1
	    			end
			end
		end


	end





/* Fin - Fin de Periodo */        


      end
      else 
      begin
          update cb_saldo
          set    sa_saldo = sa_saldo + @valor,
                 sa_saldo_me = sa_saldo_me + @valor_me,
	         sa_credito  = sa_credito + @i_credito,
	         sa_debito   = sa_debito + @i_debito,
	         sa_credito_me = sa_credito_me + @i_credito_me,
         	 sa_debito_me  = sa_debito_me + @i_debito_me
          where  sa_empresa = @i_empresa 
          and    sa_periodo = @periodo  
          and    sa_corte  = @corte 
	  and    sa_oficina = @i_oficina 
	  and    sa_area    = @i_area 
	  and    sa_cuenta = @i_cuenta


	  select @w_status=@@error, @w_rowcount=@@rowcount


          if @w_status <> 0
          begin
              exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605036
		return 1
	  end
    	  else
	  begin
	    if @w_rowcount = 0
	    begin
          		insert into cb_saldo ( 
			sa_cuenta,sa_oficina,sa_area,sa_corte,
          		sa_periodo,sa_empresa,sa_saldo,
	  		sa_saldo_me,sa_credito,sa_debito,
	  		sa_credito_me,sa_debito_me)
          		values (
          		@i_cuenta,@i_oficina,@i_area,@corte,
          		@periodo,@i_empresa,@valor,@valor_me,
	  		@i_credito,@i_debito,@i_credito_me,
	  		@i_debito_me)

          		if @@error <> 0
          		begin
            			exec cobis..sp_cerror
	         		@t_debug = @t_debug,
		 		@t_file  = @t_file,
		 		@t_from  = @w_sp_name,
		 		@i_num   = 601001
		 		return 1
	  		end



            end
      	  end 
      end
      select @corte_new = @corte + 1

      select @w_corte_max =max(co_corte) 
      from cb_corte
      where  co_empresa = @i_empresa
      and    co_periodo = @periodo
   	
      if @corte_new > @w_corte_max
      begin
          select @w_fecha_max = co_fecha_fin
          from cb_corte
	  where co_empresa = @i_empresa
	  and   co_periodo = @periodo 
          and   co_corte = @w_corte_max

          select @w_fecha_max = dateadd(dd,1,@w_fecha_max)
		
          select @periodo =co_periodo,
 		 @corte_new = co_corte
	  from cb_corte
	  where co_empresa = @i_empresa
	  and   co_fecha_ini = @w_fecha_max
      end
	
      select @w_estado = co_estado
      from   cb_corte
      where  co_empresa = @i_empresa 
      and    co_periodo = @periodo 
      and    co_corte = @corte_new 
      and    (co_estado  = 'V' or co_estado  = 'A' )

      if @@rowcount = 0
	select @flag3 = 0
      else 
	select @corte = @corte_new

    end
    select @flag2 = 0 
    select @valor_me = 0
    select @i_credito_me = 0
    select @i_debito_me = 0
    select @corte = @corte_ini
    select @periodo = @periodo_ini   
    select @w_estado = @estado_ini

    select @padre_cta = cu_cuenta_padre
    from   cb_cuenta
    where  cu_empresa = @i_empresa 
    and	   cu_cuenta  = @i_cuenta 

    select @i_cuenta = @padre_cta
  end 
  else
  begin
      select @flag1 = 0
      continue
  end
end

--commit tran
return 0
go
