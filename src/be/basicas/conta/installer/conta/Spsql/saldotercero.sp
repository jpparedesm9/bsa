/************************************************************************/
/*	Archivo: 		saldotercero.sp 			*/
/*	Stored procedure: 	sp_saldo_tercero			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan Carlos Gomez R.              	*/
/*	Fecha de escritura:     13/Nov/1997   				*/
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
/*	Este proceso consulta los saldo de terceros			*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		   RAZON			*/
/*      2005/07/25      John Jairo Rendon  Optimizacion                 */
/*      2006/05/11      John Jairo Rendon  Optimizacion                 */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_tercero')
	drop proc sp_saldo_tercero
go

create proc sp_saldo_tercero (
	@s_ssn			int      	= null,
	@s_date			datetime 	= null,
	@s_user			login    	= null,
	@s_term			descripcion 	= null,
	@s_corr			char(1)  	= null,
	@s_ssn_corr		int      	= null,
	@s_ofi			smallint  	= null,
	@t_rty			char(1)  	= null,
	@t_trn			smallint 	= null,
	@t_debug		char(1)  	= 'N',
	@t_file			varchar(14) 	= null,
	@t_from			varchar(30) 	= null,
	@i_operacion		char(1)  	= null,
	@i_empresa		tinyint 	= null,
	@i_nombre		descripcion  	= null,
	@i_modo			tinyint 	= 0,
	@i_ente			int 		= null,
	@i_ente1		int 		= null,
	@i_fecha_i		datetime 	= null,
	@i_fecha_f		datetime 	= null,
	@i_oficina		smallint 	= null,
	@i_oficina1		smallint 	= null,
	@i_area			smallint 	= null,
	@i_area1		smallint 	= null,
	@i_saldo		money 		= null,
	@i_saldo_me		money 		= 0,
	@i_cuenta		cuenta		= null,
	@i_cuenta1		cuenta		= null,
	@i_formato_fecha	smallint 	= null,
	@i_comprobante		int 		= null,
	@i_debito		money 		= null,
	@i_credito		money 		= null,
	@i_debito_me		money 		= null,
	@i_credito_me		money 		= null,
	@i_sub_tipo             varchar(5)      = null,
        @i_tipo_ced             varchar(5)      = null,
        @i_todos_reg            tinyint         = 1
)
as

declare	@w_return		int,
	@w_sp_name		varchar(32),
	@w_existe		tinyint,
	@w_ente			int,
	@w_saldo		money,
        @w_saldo_final          money,
        @w_saldo_inicial         money,
   	@w_area			smallint,
	@w_empresa		tinyint,
	@w_oficina		smallint,
	@w_cuenta		cuenta,
	@w_corte		int,  
	@w_corte_fp		int,  
	@w_corte_max		int,  
	@w_periodo		int,  
	@w_estado		char(1),
	@w_saldomn		money,
	@w_saldome		money,
	@w_categoria		char(1),
	@w_saldo_ter		money,
	@flag1			int,
	@w_corte2		int,
	@w_periodo2		int,
	@w_estado2		char(1),
	@w_periodo_finmes	int,
	@w_corte_finmes		int,
	@w_fecha_aux		datetime,
	@w_fecha_aux1		datetime,
	@w_status	  	int,
	@w_rowcount	  	int,
	@sp_id			int,

	@w_oficina_s		smallint,
	@w_area_s		smallint,
	@w_reg_oficina		int,
	@w_reg_area		int,
        @w_retornados		int,

	@w_query_1		varchar(255),
        @w_query_2		varchar(255),
        @w_query_3		varchar(255),
	@w_query_cuenta 	varchar(255),
	@w_query_oficina 	varchar(255),
	@w_query_area 		varchar(255),
	@w_query_ente 		varchar(255),
	@w_query_siguientes 	varchar(512),
	@w_query_orden  	varchar(255),
	@w_query_error  	varchar(255)


select @w_sp_name = 'sp_saldo_tercero'
select @sp_id = @@spid


select @w_query_1 = '',
       @w_query_2 = '',
       @w_query_3 = '',
       @w_query_cuenta = '',
       @w_query_oficina = '',
       @w_query_area = '',
       @w_query_ente = '',
       @w_query_siguientes = '',
       @w_query_orden = '',
       @w_query_error = ''

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select  '/**  Stored Procedure  **/ ' = @w_sp_name,
	s_ssn                      = @s_ssn,
	s_user                     = @s_user,
	s_term                     = @s_term,
	s_date                     = @s_date,
	t_debug                    = @t_debug,
	t_file                     = @t_file,
	t_from                     = @t_from,
	t_trn                      = @t_trn,
	i_modo                     = @i_modo,
	i_operacion		   = @i_operacion,
	i_empresa		   = @i_empresa,
	i_nombre		   = @i_nombre,
	i_ente                     = @i_ente,
	i_fecha_i		   = @i_fecha_i,
	i_fecha_f		   = @i_fecha_f
	exec cobis..sp_end_debug
end

if (@t_trn <> 6278 and @i_operacion = 'Q') or
   (@t_trn <> 6278 and @i_operacion = 'X') or
   (@t_trn <> 6979 and @i_operacion = 'I') or
   (@t_trn <> 6026 and @i_operacion = 'S') or
   (@t_trn <> 6029 and @i_operacion = 'T') or
   (@t_trn <> 6029 and @i_operacion = 'Y') 
begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
	@i_num   = 601077
	return 1
end

if @i_operacion <> 'I'
begin
   set rowcount 0

   select @w_oficina_s = je_oficina
   from cb_jerarquia
   where je_empresa = @i_empresa
   and   je_oficina_padre = @i_oficina

   select @w_reg_oficina = @@rowcount

   select @w_area_s = ja_area
   from cb_jerararea
   where ja_empresa = @i_empresa 
   and   ja_area_padre = @i_area

   select @w_reg_area = @@rowcount

end

select @w_corte = co_corte,
       @w_periodo = co_periodo,
       @w_estado = co_estado
from   cob_conta..cb_corte
where  co_empresa = @i_empresa
and    co_periodo >= 0
and    co_corte >= 0
and    co_fecha_ini <= @i_fecha_i
and    co_fecha_fin >= @i_fecha_i
if @@rowcount = 0
begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
	@i_num   = 603063
	return 1
end


if @i_operacion in('T', 'Y', 'Q', 'X')
begin
   select @w_corte2 = co_corte, 
     	  @w_periodo2 = co_periodo, 
       	  @w_estado2 = co_estado
   from cob_conta..cb_corte
   where co_empresa = @i_empresa
   and co_periodo >= 0
   and co_corte >= 0
   and co_fecha_ini <= @i_fecha_f
   and co_fecha_fin >= @i_fecha_f

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
	   @t_debug = @t_debug,
	   @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 603063
      return 1
   end
end


if @i_operacion <> 'Q' and @i_operacion <> 'T' and @i_operacion <> 'I' and @i_operacion <> 'X' and @i_operacion <> 'Y'
begin
	select	@w_empresa = st_empresa,
		@w_cuenta = st_cuenta,
		@w_oficina = st_oficina,
		@w_ente = st_ente,
		@w_area = st_area,
		@w_saldo = st_saldo
	from  cob_conta_tercero..ct_saldo_tercero, cobis..cl_ente
	where  st_empresa = @i_empresa
	and  st_periodo = @w_periodo
	and  st_corte   = @w_corte
	and  st_cuenta  = @i_cuenta
	and  st_oficina = @i_oficina
	and  st_area    = @i_area
	and  st_ente    = @i_ente
	and  en_ente    = @i_ente
	if @@rowcount > 0
		select @w_existe = 1
	else
		select @w_existe = 0
end

if @i_operacion in('T','Y')
begin

   select @w_query_1 = '
	set rowcount 20

	select 	''OFICINA''	= st_oficina,
		''AREA''		= st_area,
		''ID''		= st_ente,
		''IDENTIFICACION'' = en_ced_ruc,'

   select @w_query_2 = '
		''TIPO ID.''	= en_tipo_ced,
		''NOMBRE''	= ltrim(p_p_apellido + '' '' + p_s_apellido + '' '' + en_nombre),
		''SALDO FINAL MN'' = st_saldo,
		''SALDO FINAL ME'' = st_saldo_me'

   select @w_query_3 = '
	from cob_conta_tercero..ct_saldo_tercero, cobis..cl_ente
	where st_corte 	= ' + convert(varchar, @w_corte2) + '
	and st_periodo 	= ' + convert(varchar, @w_periodo2) + '
	and st_cuenta 	= ''' + @i_cuenta + ''' 
	and st_empresa  = ' + convert(varchar, @i_empresa)
 
   if @w_reg_oficina = 1
      select @w_query_oficina = '
	and st_oficina = ' + convert(varchar, @w_oficina_s)
   else
      select @w_query_oficina = '
	and st_oficina > 0
	and st_oficina in(select je_oficina from cb_jerarquia where je_oficina_padre = ' + convert(varchar, @i_oficina) + ' and je_empresa = ' + convert(varchar, @i_empresa) + ')'

   if @w_reg_area = 1
      select @w_query_area = '
	and st_area = ' + convert(varchar, @w_area_s)
   else
      select @w_query_area = '
	and st_area > 0
	and st_area in(select ja_area from cb_jerararea where ja_area_padre = ' + convert(varchar, @i_area) + ' and ja_empresa = ' + convert(varchar, @i_empresa) + ')'
   
    if @i_tipo_ced is null
       select @i_tipo_ced = ''''
    if @i_sub_tipo is null
       select @i_sub_tipo = ''''
       
   if @i_ente is null
   begin
    select @w_query_ente = '
	and en_ente = st_ente
	and ((' + convert(varchar, @i_todos_reg) + ' = 1) 
	      or (en_subtipo = '+ @i_sub_tipo + ' and en_tipo_ced= ' + @i_tipo_ced + '))'
   end
   else
    select @w_query_ente = '
	and st_ente = ' + convert(varchar, @i_ente) + '
	and en_ente = st_ente
	and ((' + convert(varchar, @i_todos_reg) + ' = 1) 
	      or (en_subtipo = ''' + @i_sub_tipo + ''' and en_tipo_ced= ''' + @i_tipo_ced + '''))'

   select @w_query_orden = '
	order by st_ente,st_oficina,st_area'

   if @i_modo = 0
      select @w_query_siguientes = ''
   else
      select @w_query_siguientes = '
	and ((st_ente > ' + convert(varchar, @i_ente1) + ') 
	      or ((st_ente = ' + convert(varchar, @i_ente1) + ') and (st_oficina > ' + convert(varchar, @i_oficina1) + ')) 
	      or ((st_ente = ' + convert(varchar, @i_ente1) + ') and (st_oficina = ' + convert(varchar, @i_oficina1) + ') and (st_area > ' + convert(varchar, @i_area1) + ')))'


   select @w_query_error = '
	if @@rowcount = 0
	begin
	   exec cobis..sp_cerror
		@t_debug = ''' + @t_debug + ''',
		@t_file  = ''' + @t_file + ''',
		@t_from  = ''' + @w_sp_name + ''',
		@i_num   = 601069
	end'

-- print 'uno'

-- Este segmento solo debe activarse para depuracion

/*
print @w_query_1 
print @w_query_2 
print @w_query_3 
print @w_query_oficina 
print @w_query_area 
print @w_query_ente 
print @w_query_siguientes 
print @w_query_orden 
print @w_query_error
*/

   exec (@w_query_1 + @w_query_2 + @w_query_3 + @w_query_oficina + @w_query_area + @w_query_ente + @w_query_siguientes
	   + @w_query_orden + @w_query_error)

end

if @i_operacion in('Q', 'X')
begin
   select @w_query_1 = '
	set rowcount 20

	select 	''CUENTA'' 	= st_cuenta,
		''OFICINA''	= st_oficina,
		''AREA''		= st_area,
		''ID''		= st_ente,
		''IDENTIFICACION'' = en_ced_ruc,'

   select @w_query_2 = '
		''TIPO ID''	= en_tipo_ced,
		''NOMBRE''	= en_nombre,
		''SALDO MN'' = st_saldo,
		''SALDO ME'' = st_saldo_me'

   select @w_query_3 = '
        from cob_conta_tercero..ct_saldo_tercero, cobis..cl_ente
	where st_corte 	= ' + convert(varchar, @w_corte2) + '
	and st_periodo 	= ' + convert(varchar, @w_periodo2) + '
	and st_empresa  = ' + convert(varchar, @i_empresa)
 
   if @i_cuenta is null
      select @w_query_cuenta = ''
   else
      select @w_query_cuenta = '
              and st_cuenta 	=' + '''' + @i_cuenta + ''''


   if @w_reg_oficina = 1
      select @w_query_oficina = '
	and st_oficina = ' + convert(varchar, @w_oficina_s)
   else
      select @w_query_oficina = '
	and st_oficina > 0
	and st_oficina in(select je_oficina from cb_jerarquia where je_oficina_padre = ' + convert(varchar, @i_oficina) + ' and je_empresa = ' + convert(varchar, @i_empresa) + ')'

   if @w_reg_area = 1
      select @w_query_area = '
	and st_area = ' + convert(varchar, @w_area_s)
   else
      select @w_query_area = '
	and st_area > 0
	and st_area in(select ja_area from cb_jerararea where ja_area_padre = ' + convert(varchar, @i_area) + ' and ja_empresa = ' + convert(varchar, @i_empresa) + ')'
   
   select @w_query_ente = '
	and st_ente = ' + convert(varchar, @i_ente) + '
	and en_ente = st_ente
	and en_subtipo = ''' + @i_sub_tipo + '''
	and en_tipo_ced= ''' + @i_tipo_ced + ''''

   select @w_query_orden = '
	order by st_cuenta, st_oficina,st_area'

   if @i_modo = 0
      select @w_query_siguientes = ''
   else
      select @w_query_siguientes = '
	and ((st_cuenta > ''' + @i_cuenta1 + ''') 
		or ((st_cuenta = ''' + @i_cuenta1 + ''') and (st_oficina > ' + convert(varchar, @i_oficina1) + ')) 
		or ((st_cuenta = ''' + @i_cuenta1 + ''') and (st_oficina = ' + convert(varchar, @i_oficina1) + ' and (st_area > ' + convert(varchar, @i_area1) + ')) 
		or ((st_cuenta = ''' + @i_cuenta1 + ''') and (st_oficina = ' + convert(varchar, @i_oficina1) + ') and (st_area = ' + convert(varchar, @i_area1) + ') and (st_ente > ' + convert(varchar, @i_ente1) + '))))'

   select @w_query_error = '
	if @@rowcount = 0
	begin
	   exec cobis..sp_cerror
		@t_debug = ''' + @t_debug + ''',
		@t_file  = ''' + @t_file + ''',
		@t_from  = ''' + @w_sp_name + ''',
		@i_num   = 601069
	end'

/* Este segmento solo debe activarse para depuracion
   select @w_query_1,
	  @w_query_2,
	  @w_query_3,
	  @w_query_cuenta,
	  @w_query_oficina,
 	  @w_query_area,
	  @w_query_ente,
	  @w_query_siguientes,
	  @w_query_orden,
	  @w_query_error
*/

   exec (@w_query_1 + @w_query_2 + @w_query_3 + @w_query_cuenta + @w_query_oficina + @w_query_area + @w_query_ente 
           + @w_query_siguientes + @w_query_orden + @w_query_error)

end


if  @i_operacion = 'S' or @i_operacion = 'Q' or @i_operacion = 'X' or @i_operacion = 'Y'
begin
	if @w_estado <> 'A' and @w_estado <> 'V' and @w_estado <> 'C'
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 603023
		return 1
	end
end
else
begin
	if  @i_operacion <> 'T' 
	begin
		if @w_estado <> 'A' and @w_estado <> 'V'
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603023
			return 1
		end
	end
end

if @i_operacion = 'I'
begin
	select	@w_periodo_finmes  = co_periodo,
		@w_corte_finmes    = max(co_corte)
	from   cb_corte, cb_periodo
	where  co_empresa  = @i_empresa
	and    co_periodo  = pe_periodo
	and    co_corte >= 0
	and    pe_empresa  = co_empresa
	and    pe_periodo >= 0
	and    @i_fecha_i between pe_fecha_inicio and pe_fecha_fin
	and    datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_i)
	group  by co_periodo

	select @w_fecha_aux = co_fecha_ini
	from   cb_corte
	where  co_empresa = @i_empresa
	and    co_periodo = @w_periodo_finmes
	and    co_corte   = @w_corte_finmes

	select @flag1 = 1

	while @flag1 > 0
	begin
			update cob_conta_tercero..ct_saldo_tercero 
			set	st_saldo          = st_saldo + @i_saldo,
				st_saldo_me       = st_saldo_me + @i_saldo_me,
				st_mov_debito     = st_mov_debito + @i_debito,
				st_mov_credito    = st_mov_credito + @i_credito,
				st_mov_debito_me  = st_mov_debito_me + @i_debito_me,
				st_mov_credito_me = st_mov_credito_me + @i_credito_me
			where st_empresa      = @i_empresa
			and   st_periodo      = @w_periodo_finmes
			and   st_corte        = @w_corte_finmes
			and   st_cuenta       = @i_cuenta
			and   st_oficina      = @i_oficina
			and   st_area         = @i_area
			and   st_ente         = @i_ente
			
			select @w_status=@@error, @w_rowcount=@@rowcount


			if @w_status <> 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 605086
				return 1
			end
			else
			begin
   
				if @w_rowcount = 0
			  	begin
					insert into cob_conta_tercero..ct_saldo_tercero values
					(@i_empresa,@w_periodo_finmes,@w_corte_finmes,
					@i_cuenta,@i_oficina,@i_area,@i_ente,@i_saldo,
					@i_saldo_me,@i_debito,@i_credito,@i_debito_me,
					@i_credito_me)
					
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
			
		/* Inicio - Fin de Periodo */
		select @w_corte_max = max(co_corte)
		from cob_conta..cb_corte
		where co_empresa = @i_empresa
		and   co_periodo = @w_periodo_finmes
		and   co_corte >= 0

		if @w_corte_max = @w_corte_finmes
		begin
			select @w_corte_fp = @w_corte_max + 1
	
	           		update cob_conta_tercero..ct_saldo_tercero
	           		set st_saldo          = st_saldo + @i_saldo,
		       		st_saldo_me       = st_saldo_me + @i_saldo_me,
	               		st_mov_debito     = st_mov_debito + @i_debito,
	               		st_mov_credito    = st_mov_credito + @i_credito,
	               		st_mov_debito_me  = st_mov_debito_me + @i_debito_me,
	               		st_mov_credito_me = st_mov_credito_me + @i_credito_me
	           		where st_empresa      = @i_empresa 
	           		and   st_periodo      = @w_periodo_finmes
	           		and   st_corte        = @w_corte_fp
	           		and   st_cuenta       = @i_cuenta
	           		and   st_oficina      = @i_oficina
	           		and   st_area         = @i_area
	           		and   st_ente         = @i_ente
	           		
	           		select @w_status=@@error, @w_rowcount=@@rowcount
	           		
	           		if @w_status <> 0
	           		begin
	              			exec cobis..sp_cerror
	              			@t_debug = @t_debug,
	              			@t_file  = @t_file,
	              			@t_from  = @w_sp_name,
	              			@i_num   = 605086
	              			return 1
	           		end
	        		else
	        		begin
	        		   if @w_rowcount = 0
			  	   begin
		           		insert into cob_conta_tercero..ct_saldo_tercero
		           		values (@i_empresa,@w_periodo_finmes,@w_corte_fp,
		               	  		@i_cuenta,@i_oficina,@i_area,@i_ente,@i_saldo,
				  		@i_saldo_me,@i_debito,@i_credito,@i_debito_me,
				  		@i_credito_me)
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

		select @w_fecha_aux  = dateadd(dd,1,@w_fecha_aux)
		select @w_fecha_aux1 = @w_fecha_aux

		select	@w_periodo_finmes  = co_periodo,
			@w_corte_finmes    = max(co_corte)
		from   cb_corte, cb_periodo
		where  co_empresa   = @i_empresa
		and    co_periodo   = pe_periodo
		and    co_corte >= 0
		and    pe_empresa   = co_empresa
		and    @w_fecha_aux between pe_fecha_inicio and pe_fecha_fin
		and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_aux)
		group by co_periodo

		select @w_fecha_aux = co_fecha_ini
		from   cb_corte
		where  co_empresa   = @i_empresa
		and    co_periodo   = @w_periodo_finmes
		and    co_corte     = @w_corte_finmes

		if exists (select 1 from cb_corte
		            where co_empresa = @i_empresa
		            and   co_periodo >= 0
		            and   co_corte >= 0
		            and   co_fecha_ini between @w_fecha_aux1 and @w_fecha_aux
		            and   (co_estado  = 'V' or co_estado  = 'A' or co_estado  = 'C' ))
		begin
			select @w_corte = @w_corte_finmes
		end
		else
		begin
			select @flag1 = 0
		end
	end
end

if @i_operacion = 'S'
begin
	if @w_estado = 'A'
	begin
		select @w_saldomn   = sum(sa_saldo),
		      @w_saldome   = sum (sa_saldo_me),
		      @w_categoria = cu_categoria
		from cob_conta..cb_cuenta,cob_conta..cb_saldo
		where sa_corte = @w_corte
		and sa_periodo = @w_periodo
                and sa_oficina > 0
		and sa_oficina in(select je_oficina from cb_jerarquia where je_oficina_padre = @i_oficina and je_empresa = @i_empresa)
                and sa_area > 0
		and sa_area in(select ja_area from cb_jerararea where ja_area_padre = @i_area and ja_empresa = @i_empresa)
		and sa_cuenta =  @i_cuenta
		and sa_empresa = @i_empresa
		and cu_empresa = @i_empresa
 		and cu_cuenta = @i_cuenta
		group by cu_categoria
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601069
			return 1
		end
		select @w_saldo_ter = @w_saldomn + @w_saldome
		select @w_saldo_ter
		select @w_categoria
	end
	else
	begin
		select	@w_saldomn  = sum(hi_saldo),
			@w_saldome = sum (hi_saldo_me),
			@w_categoria = cu_categoria
		from cb_cuenta, cob_conta_his..cb_hist_saldo
		where hi_corte = @w_corte
		and hi_periodo = @w_periodo
                and hi_oficina > 0
		and hi_oficina in(select je_oficina from cb_jerarquia where je_oficina_padre = @i_oficina and je_empresa = @i_empresa)
                and hi_area > 0
		and hi_area in(select ja_area from cb_jerararea where ja_area_padre = @i_area and ja_empresa = @i_empresa)
		and hi_cuenta =  @i_cuenta
                and hi_empresa = @i_empresa
		and cu_empresa = @i_empresa
		and cu_cuenta = @i_cuenta
		group by cu_categoria

		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601069
			return 1
		end
		else
		begin
			select @w_categoria
		end
	end
end



return 0
go
