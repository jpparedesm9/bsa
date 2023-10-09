/************************************************************************/
/*	Archivo: 		saldotercerofp.sp 			*/
/*	Stored procedure: 	sp_saldo_tercerofp			*/
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
/*	Este proceso actualiza los saldos de terceros con fin de 	*/
/*      periodo								*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_tercerofp')
    drop proc sp_saldo_tercerofp

go
create proc sp_saldo_tercerofp (
   @s_ssn                int      	= null,
   @s_date               datetime 	= null,
   @s_user               login    	= null,
   @s_term               descripcion 	= null,
   @s_corr               char(1)  	= null,
   @s_ssn_corr           int      	= null,
   @s_ofi                smallint  	= null,
   @t_rty                char(1)  	= null,
   @t_trn                smallint 	= null,
   @t_debug              char(1)  	= 'N',
   @t_file               varchar(14) 	= null,
   @t_from               varchar(30) 	= null,
   @i_operacion          char(1)  	= null,
   @i_empresa		 tinyint 	= null,
   @i_nombre             descripcion  	= null,
   @i_modo		 tinyint 	= 0,
   @i_ente               int 		= null,            
   @i_ente1              int 		= null,            
   @i_fecha_i		 datetime 	= null,
   @i_fecha_f		 datetime 	= null,
   @i_oficina            smallint 	= null,
   @i_oficina1           smallint 	= null,
   @i_area               smallint 	= null,
   @i_area1              smallint 	= null,
   @i_saldo              money 		= null,
   @i_saldo_me           money 		= 0,
   @i_cuenta             cuenta 	= null,
   @i_cuenta1            cuenta 	= null,
   @i_formato_fecha      smallint 	= null,
   @i_comprobante        int 		= null,
   @i_debito             money 		= null,
   @i_credito            money 		= null,
   @i_debito_me          money 		= null,
   @i_credito_me         money 		= null
)
as

declare
   @w_return             int,    
   @w_sp_name            varchar(32), 
   @w_existe             tinyint,     
   @w_nombre             descripcion,
   @w_ente               int,
   @w_siguiente		 tinyint,
   @w_comprobante	 int,        
   @w_reg_fiscal	 varchar(10),
   @w_descripcion	 descripcion,
   @w_actividad		 char(20),
   @w_saldo              money,
   @w_saldo_inicial      money,
   @w_area               smallint,
   @w_empresa            tinyint,
   @w_oficina            smallint,
   @w_cuenta             cuenta,
   @w_corte 		 int,  
   @w_corte_fp 		 int,  
   @w_corte_max		 int,  
   @w_periodo 		 int,  
   @w_estado             char(1),
   @w_maxcorte           int,
   @w_saldomn            money,
   @w_saldome            money,
   @w_categoria          char(1),
   @w_saldo_ter          money,
   @flag1		 int,
   @periodo		 int,
   @periodo_ini		 int,
   @w_corte2		 int,
   @w_periodo2		 int,
   @w_estado2		 char(1),
   @w_periodo_finmes     int,
   @w_corte_finmes       int,
   @w_fecha_aux          datetime,
   @w_fecha_aux1         datetime


select @w_sp_name = 'sp_saldo_tercerofp'

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
   (@t_trn <> 6979 and @i_operacion = 'I') or 
   (@t_trn <> 6026 and @i_operacion = 'S') or 
   (@t_trn <> 6029 and @i_operacion = 'T') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


select @w_corte = co_corte, 
       @w_periodo = co_periodo, 
       @w_estado = co_estado
from   cob_conta..cb_corte
where  co_empresa = @i_empresa
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





if  @i_operacion = 'S' or @i_operacion = 'Q'
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

if @i_operacion = 'I'
begin 
   select @w_periodo_finmes  = co_periodo,
	  @w_corte_finmes    = max(co_corte)
   from   cb_corte,cb_periodo
   where  co_empresa  = @i_empresa
   and    pe_empresa  = co_empresa
   and    @i_fecha_i between pe_fecha_inicio and pe_fecha_fin  
   and    co_periodo  = pe_periodo
   and    datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_i)  
   group  by co_periodo

   select @w_fecha_aux = co_fecha_ini
   from   cb_corte
   where  co_empresa = @i_empresa
   and    co_periodo = @w_periodo_finmes
   and    co_corte   = @w_corte_finmes

--   begin tran 

   select @flag1 = 1

   while @flag1 > 0
   begin





	/* Inicio - Fin de Periodo */


	select @w_corte_max = max(co_corte)
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and   co_periodo = @w_periodo_finmes
	
	if @w_corte_max = @w_corte_finmes
	begin
		select @w_corte_fp = @w_corte_max + 1
		

        	if NOT EXISTS (select * from cob_conta_tercero..ct_saldo_tercero
          	where st_empresa = @i_empresa and
                	st_periodo = @w_periodo_finmes and
                	st_corte   = @w_corte_fp and
                	st_cuenta  = @i_cuenta and
                	st_oficina = @i_oficina and
                	st_area    = @i_area and
	        	st_ente    = @i_ente 
              	)
        	begin
           		insert into cob_conta_tercero..ct_saldo_tercero 
           		values (
		  		@i_empresa,@w_periodo_finmes,@w_corte_fp,
               	  		@i_cuenta,@i_oficina,@i_area,@i_ente,@i_saldo,
		  		@i_saldo_me,@i_debito,@i_credito,@i_debito_me,
		  		@i_credito_me
		  		)

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
        	else 
        	begin
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

           		if @@error <> 0
           		begin
              			exec cobis..sp_cerror
              			@t_debug = @t_debug,
              			@t_file  = @t_file,
              			@t_from  = @w_sp_name,
              			@i_num   = 605086
              			return 1
           		end
        	end

	end
	else
	begin

        	if NOT EXISTS (select * from cob_conta_tercero..ct_saldo_tercero
          		where st_empresa = @i_empresa and
                	st_periodo = @w_periodo_finmes and
                	st_corte   = @w_corte_finmes and
                	st_cuenta  = @i_cuenta and
                	st_oficina = @i_oficina and
                	st_area    = @i_area and
	        	st_ente    = @i_ente 
              	)
        	begin
           		insert into cob_conta_tercero..ct_saldo_tercero 
           		values (
		  		@i_empresa,@w_periodo_finmes,@w_corte_finmes,
               	  		@i_cuenta,@i_oficina,@i_area,@i_ente,@i_saldo,
		  		@i_saldo_me,@i_debito,@i_credito,@i_debito_me,
		  		@i_credito_me
		  		)

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
        	else 
        	begin
           		update cob_conta_tercero..ct_saldo_tercero 
           		set st_saldo          = st_saldo + @i_saldo,
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

           		if @@error <> 0
           		begin
              			exec cobis..sp_cerror
              			@t_debug = @t_debug,
              			@t_file  = @t_file,
              			@t_from  = @w_sp_name,
              			@i_num   = 605086
              			return 1
           		end
        	end


	end


	/* Fin - Fin de Periodo */





       select @w_fecha_aux  = dateadd(dd,1,@w_fecha_aux)
       select @w_fecha_aux1 = @w_fecha_aux

       select @w_periodo_finmes  = co_periodo,
              @w_corte_finmes    = max(co_corte)
       from   cb_corte,cb_periodo
       where  co_empresa   = @i_empresa
       and    pe_empresa   = co_empresa
       and    @w_fecha_aux between pe_fecha_inicio and pe_fecha_fin  
       and    co_periodo   = pe_periodo
       and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_aux)  
       group by co_periodo

       select @w_fecha_aux = co_fecha_ini
       from   cb_corte
       where  co_empresa   = @i_empresa
       and    co_periodo   = @w_periodo_finmes
       and    co_corte     = @w_corte_finmes   


     if NOT EXISTS (select * from cb_corte
                    where co_empresa = @i_empresa 
                    and   co_fecha_ini between @w_fecha_aux1 
                    and   @w_fecha_aux 
                    and   (co_estado  = "V" or co_estado  = "A" )
     )
     begin
         select @flag1 = 0
     end
     else
     begin
         select @w_corte = @w_corte_finmes
     end
   end                                            
--   commit tran
end


return 0
go
