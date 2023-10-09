/************************************************************************/
/*	Archivo: 		trancta.sp			        */
/*	Stored procedure: 	sp_trancta 				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-Sep-1993 				*/
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
/*	   Consulta de transacciones de una cuenta                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Sep/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	25/Jul/1996	S. de la Cruz	Utilizacion tabla cb_hist_saldo */
/*	16/Ene/1998	M .Victoria Garay Presentacion Saldos Absolutos */ 
/*      16/Nov/1999     Sandra Robayo   Se quita manejo de i_moneda     */
/*                                      ahora se retorna debito_me y    */
/*                                      credito_me en el mismo query    */
/*     01/31/2005       benjamin Posada Optimizacion 			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tranctah')
	drop proc sp_tranctah  

go

create proc sp_tranctah   (
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
	@i_operacion	char(1)  = null,
	@i_modo		smallint = null,
	@i_empresa	tinyint  = null,
	@i_cuenta     	cuenta = null,
	@i_oficina      smallint = null,
	@i_area		smallint = null,
	@i_oficina_orig smallint = null,
	@i_fecha_ini    datetime = null,
	@i_fecha_fin	datetime = null,
	@i_comprobante  int = null,
	@i_asiento	smallint = null,
	@i_moneda       char(1) = null,
	@i_fecha	datetime = null,
	@i_formato_fecha smallint = null,
	@i_sesion        int = 0
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
	@w_corte	int,
	@w_periodo	int,
        @w_fecha	datetime,
	@w_saldo	money,
	@w_saldo_me	money,
	@w_oficina      smallint,
	@w_area		smallint,
	@w_oficinum     int,
	@w_areanum	int, 
	@w_existe	int,	
        @w_corte_ant	int,
	@w_periodo_ant	int,
	@w_saldo0	tinyint,
        @w_saldo_me0	tinyint,
        @w_flag		int,
        @w_categoria    char(1),
        @w_sesion       int

select @w_today = getdate()
select @w_sp_name = 'sp_trancta'


/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6309 and @i_operacion = 'S') 
or (@t_trn <> 6309 and @i_operacion = 'T')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

select 	@w_corte = co_corte, 
	@w_periodo = co_periodo
  from 	cob_conta..cb_corte
 where 	co_empresa = @i_empresa
   and	co_fecha_ini <= @i_fecha_ini
   and	co_fecha_fin >= @i_fecha_ini 
   
   
select  @w_sesion = @@spid * 100


if @i_sesion = 0
begin
 select distinct @w_oficinum = count(1)
 from cb_jerarquia
 where je_empresa = @i_empresa 
 and   je_oficina > 0
 and   je_oficina_padre = @i_oficina


 select distinct @w_areanum = count(1)
 from cb_jerararea
 where ja_empresa = @i_empresa 
 and   ja_area > 0
 and   ja_area_padre = @i_area



 if (@w_oficinum>1 or @w_areanum>1) 
 begin 

 select @w_flag = 1
 
 delete from cob_conta_historico..ofic_tctah
 where sesion_of = @w_sesion

 delete from cob_conta_historico..area_tctah
 where sesion_ar = @w_sesion

 insert into cob_conta_historico..ofic_tctah
 select distinct je_oficina, @w_sesion  
 from cb_jerarquia
 where je_empresa = @i_empresa 
 and   je_oficina_padre = @i_oficina

 insert into cob_conta_historico..area_tctah
 select distinct  ja_area,@w_sesion
 from cb_jerararea
 where ja_empresa = @i_empresa 
 and   ja_area_padre = @i_area


 end 

 else
 begin 
  select @w_flag = 2
 
  select distinct @w_oficina = je_oficina
  from cb_jerarquia
  where je_empresa = @i_empresa 
  and   je_oficina_padre = @i_oficina

  select distinct @w_area = ja_area
  from cb_jerararea
  where ja_empresa = @i_empresa 
  and   ja_area_padre = @i_area

 end
end

if @w_corte = 1 
begin
   select @w_periodo_ant = pe_periodo
     from cob_conta..cb_periodo
    where pe_empresa = @i_empresa
    and   pe_periodo = @w_periodo - 1

   if @@rowcount = 0
   begin
      select @w_saldo0 = 1
      select @w_saldo_me0 = 1
   end
   else 
   begin
      select @w_saldo0 = 0
      select @w_saldo_me0 = 0
      select @w_corte_ant = max(co_corte)
      from cob_conta..cb_corte
      where co_empresa = @i_empresa
	and co_periodo = @w_periodo_ant
   end
end
else
begin
   select @w_corte_ant = @w_corte - 1
   select @w_periodo_ant = @w_periodo 
   select @w_saldo0 = 0
   select @w_saldo_me0 = 0
end
      

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa   	= @i_empresa,      
		i_cuenta     	= @i_cuenta ,
		i_oficina     	= @i_oficina,
		i_fecha_ini     = @i_fecha_ini,
		i_fecha_fin	= @i_fecha_fin 
	exec cobis..sp_end_debug
end

select @w_categoria = cu_categoria
from cb_cuenta
where cu_empresa = @i_empresa
and   cu_cuenta = @i_cuenta



if @i_operacion = 'S'
begin

         if @i_modo = 0
         begin

		 delete from  cob_conta_historico..cb_estadocta_tmp
	      	 where et_sesion= @w_sesion
	      	 and   et_user= @s_user
	      	 and et_fecha_tran>= @i_fecha_ini 
		 and et_fecha_tran<=@i_fecha_fin

                 select @w_saldo = 0 
		
	    if @w_flag = 1
	    begin 
	         select @w_saldo = isnull(sum(hi_saldo) ,0),
 		      @w_saldo_me = isnull(sum(hi_saldo_me) ,0)
	         from cob_conta_historico..cb_hist_saldo ,cob_conta_historico..ofic_tctah,cob_conta_historico..area_tctah
	         where hi_empresa = @i_empresa
	 	 and hi_periodo = @w_periodo_ant
		 and hi_corte = @w_corte_ant
		 and hi_oficina = je_oficina
		 and hi_area   = ja_area
		 and hi_area > 0
		 and hi_oficina > 0
		 and hi_cuenta > ''
		 and hi_cuenta = @i_cuenta 
                 and @w_saldo0 = 0
                 and sesion_ar = @w_sesion
                 and sesion_of = @w_sesion
           end          
           if @w_flag=2
           begin 
              
              select @w_saldo = isnull(sum(hi_saldo) ,0),
 		      @w_saldo_me = isnull(sum(hi_saldo_me) ,0)
	         from cob_conta_historico..cb_hist_saldo 
	         where hi_empresa = @i_empresa
	 	 and hi_periodo = @w_periodo_ant
		 and hi_corte = @w_corte_ant
		 and hi_oficina = @w_oficina
		 and hi_area   = @w_area
		 and hi_area > 0
		 and hi_oficina > 0
		 and hi_cuenta > ''
		 and hi_cuenta = @i_cuenta 
                 and @w_saldo0 = 0
           
           end                        		

	       /* Envia saldo al front end */
	       select @w_saldo
	       select @w_saldo_me
	       
               select @w_categoria
               select @w_sesion
	       if @w_flag=2
	       begin 
	        insert into cob_conta_historico..cb_estadocta_tmp
	        select as_fecha_tran,
		      as_comprobante,
 		      as_asiento,
		      as_debito,
		      as_credito,
		      as_debito_me,
		      as_credito_me,
		      substring(as_concepto,1,50),
                      co_digitador,
                      co_oficina_orig,
                      as_cuenta,
                      @s_user,
                      @w_sesion 
		  from cob_conta_historico..cb_asiento, cob_conta_historico..cb_comprobante
	          where as_empresa = @i_empresa
	          and as_fecha_tran>= @i_fecha_ini 
		  and as_fecha_tran<=@i_fecha_fin
	          and as_comprobante = co_comprobante
		  and as_comprobante > 0
	          and as_asiento >= 0
	          and as_oficina_orig = co_oficina_orig
  		  and as_cuenta = @i_cuenta
		  and as_oficina_dest = @w_oficina 
		  and as_area_dest  = @w_area
	          and as_mayorizado = 'S'
                  and co_empresa = as_empresa         
                  and co_fecha_tran = as_fecha_tran
                 end
                else
                begin
                insert into cob_conta_historico..cb_estadocta_tmp
                 select 
                      as_fecha_tran,
		      as_comprobante,
 		      as_asiento,
		      as_debito,
		      as_credito,
		      as_debito_me,
		      as_credito_me,
		      substring(as_concepto,1,50),
                      co_digitador,
                      co_oficina_orig,
                      as_cuenta,
                      @s_user,
                      @w_sesion 
		 from cob_conta_historico..cb_asiento,cob_conta_historico..cb_comprobante, cob_conta_historico..ofic_tctah, cob_conta_historico..area_tctah
	         where as_empresa = @i_empresa
	          and as_fecha_tran>= @i_fecha_ini 
		  and as_fecha_tran<=@i_fecha_fin
	          and as_comprobante = co_comprobante
		  and as_comprobante > 0
		  and as_asiento >= 0
                  and as_area_dest> 0
	          and as_oficina_orig = co_oficina_orig
  		  and as_cuenta = @i_cuenta
		  and as_oficina_dest = je_oficina 
		  and as_area_dest  = ja_area 
	          and as_mayorizado = 'S'
                  and co_empresa = as_empresa         
                  and co_fecha_tran = as_fecha_tran
                  and sesion_ar = @w_sesion
                  and sesion_of = @w_sesion
	     
                end
               
	       if @@rowcount = 0
	       begin
	        
	       
		  /* 'No existen transacciones para a cuenta especificada' */
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 601074
		  return 1
	       end

	      set rowcount 20    
               
	       select 'Fecha' = convert(char(10),et_fecha_tran, @i_formato_fecha),
		      'Comp' = et_comprobante,
 		      'Asi.' = et_asiento,
		      'Debito' = et_debito,
		      'Credito' = et_credito ,
		      'Debito_me' = et_debito_me,
		      'Credito_me' = et_credito_me,
		      'Descripcion' = substring(et_concepto,1,50),
                      'usuario' = et_digitador,
                      'ofi.origen' = et_oficina_orig 
		  from cob_conta_historico..cb_estadocta_tmp
	          where et_fecha_tran >= @i_fecha_ini 
		  and et_fecha_tran <= @i_fecha_fin
	          and et_cuenta = @i_cuenta
		  and et_sesion= @w_sesion
		  and et_comprobante > 0
		  and et_user= @s_user
	          order by et_fecha_tran,et_comprobante,et_asiento,et_oficina_orig 
              

	      if @@rowcount < 20
	       begin	  
	      	 delete from  cob_conta_historico..cb_estadocta_tmp
	      	 where et_sesion= @w_sesion
	      	 and   et_user= @s_user
	      	 and   et_fecha_tran>= @i_fecha_ini 
		 and   et_fecha_tran<=@i_fecha_fin
	       end  
	     	             	       
         end
         else
         begin
           set rowcount 20
           
	       select 'Fecha' = convert(char(10),et_fecha_tran, @i_formato_fecha),
		      'Comp' = et_comprobante,
 		      'Asi.' = et_asiento,
		      'Debito' = et_debito,
		      'Credito' = et_credito ,
		      'Debito_me' = et_debito_me,
		      'Credito_me' = et_credito_me,
		      'Descripcion' = substring(et_concepto,1,50),
                      'usuario' = et_digitador,
                      'ofi.origen' = et_oficina_orig 
		  from cob_conta_historico..cb_estadocta_tmp
	          where et_fecha_tran >= @i_fecha_ini
		  and et_fecha_tran<=@i_fecha_fin
	          and et_cuenta = @i_cuenta
	          and et_sesion= @i_sesion
		  and et_user= @s_user
		  and (
			(et_fecha_tran > @i_fecha) or
			(et_fecha_tran = @i_fecha and et_comprobante > @i_comprobante) or
			(et_fecha_tran = @i_fecha and et_comprobante = @i_comprobante and et_asiento > @i_asiento) or
			(et_fecha_tran = @i_fecha and et_comprobante = @i_comprobante and et_asiento = @i_asiento and et_oficina_orig > @i_oficina_orig)
		      )
		  		  
		  order by et_fecha_tran,et_comprobante,et_asiento,et_oficina_orig

                           
              if @@rowcount < 20
	       begin
                 set rowcount 0     	       
	         delete from  cob_conta_historico..cb_estadocta_tmp
	      	 where et_sesion= @i_sesion
	      	 and   et_user= @s_user
	      	 and   et_fecha_tran>= @i_fecha_ini 
		 and   et_fecha_tran<=@i_fecha_fin
		 
		 delete from cob_conta_historico..ofic_tctah
 		 where sesion_of = @i_sesion

 		 delete from cob_conta_historico..area_tctah
 		 where sesion_ar = @i_sesion
		 
		  /* 'No existen transacciones para a cuenta especificada' */
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 609135
		  return 0
	       end
              
        end	
        return 0
end  /* Fin de Operacion 'S'  */

if @i_operacion = 'T'
begin
       /* Transacciones en moneda nac. y extranjera de una Cuenta en un periodo dado */

         set rowcount 20

         if @i_modo = 0
         begin

               select @w_saldo = 0 

	       select @w_saldo = isnull(hi_saldo ,0)
	         from cob_conta_historico..cb_hist_saldo
	        where hi_empresa = @i_empresa
	 	  and hi_periodo = @w_periodo_ant
		  and hi_corte = @w_corte_ant
		  and hi_oficina = @i_oficina
		  and hi_area    = @i_area 
		  and hi_cuenta = @i_cuenta 
                  and @w_saldo0 = 0

               select @w_saldo_me = 0 

	       select @w_saldo_me = isnull(hi_saldo_me ,0)
	       from cob_conta_historico..cb_hist_saldo
	       where hi_empresa = @i_empresa and
		     hi_periodo = @w_periodo_ant and
		     hi_corte = @w_corte_ant and
		     hi_oficina = @i_oficina and
		     hi_area    = @i_area and
		     hi_cuenta = @i_cuenta and
  		     @w_saldo_me0 = 0


	       /* if @w_saldo = 0
                begin*/
                /* 'Cuenta no tiene transacciones  '*/
                      /*  exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 601074
                        return 1
                end    */  
               /*presenta el saldo en valor absoluto MVG*/ 
               if @w_categoria = 'C'
               begin
                  select @w_saldo = @w_saldo *(-1)
                  select @w_saldo_me = @w_saldo_me *(-1)
               end

	       /* Envia saldo al front end */
	       select @w_saldo
	       --select @w_saldo_me

               select @w_categoria

	       select 'Fecha' = convert(char(10),as_fecha_tran,@i_formato_fecha),
		      'Comp' = as_comprobante,
 		      'Asi.' = as_asiento,
		      'Debito' = as_debito,
		      'Credito' = as_credito ,
		      'Descripcion' = substring(as_concepto,1,50), 
		      'usuario' = co_autorizante        
	         from cob_conta_historico..cb_asiento, cob_conta_historico..cb_comprobante
	        where as_empresa = @i_empresa
		  and as_oficina_dest = @i_oficina 
		  and as_area_dest = @i_area
  		  and as_cuenta = @i_cuenta
		  and as_fecha_tran>= @i_fecha_ini 
		  and as_fecha_tran<=@i_fecha_fin
	          and as_mayorizado = 'S'
		  and co_empresa=@i_empresa
                  and as_empresa = co_empresa 
		  and  as_fecha_tran= co_fecha_tran
                  and as_comprobante = co_comprobante 
		  and co_comprobante>0
		  and co_oficina_orig>0
	       order by as_fecha_tran,as_comprobante,as_asiento

	       if @@rowcount = 0
	       begin
		  /* 'No existen transacciones para a cuenta especificada' */
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 601074
		  return 1
	       end
         end
         else
         begin
               select 'Fecha' = convert(char(10),as_fecha_tran,@i_formato_fecha),
		      'Comp' = as_comprobante,
		      'Asi.'= as_asiento,
		      'Debito' = as_debito,
		      'Credito' = as_credito,
		      'Descripcion' = substring(as_concepto,1,50) ,
		      'usuario'	= co_autorizante    
	       from cob_conta_historico..cb_asiento, cob_conta_historico..cb_comprobante
	       where  as_empresa = @i_empresa and
		      as_oficina_dest = @i_oficina and
		      as_area_dest = @i_area and
		      as_cuenta = @i_cuenta and
		      as_mayorizado = 'S' and
                      as_empresa = co_empresa and
                      as_fecha_tran  = co_fecha_tran and
                      as_comprobante = co_comprobante  and  
	   	      ((as_fecha_tran = @i_fecha and 
	   	      ((as_comprobante = @i_comprobante and
                      as_asiento > @i_asiento) or
                      (as_comprobante > @i_comprobante))) or
		      as_fecha_tran > @i_fecha) and
		      as_fecha_tran <= @i_fecha_fin 
	       order by as_empresa,as_fecha_tran,as_comprobante,as_asiento


	       if @@rowcount = 0
	       begin
		  /* 'No existen transacciones para a cuenta especificada' */
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 609135
		  return 1
	       end

         end /* Fin de else  */



	 return 0
end  /* Fin de Operacion 'S'  */


go