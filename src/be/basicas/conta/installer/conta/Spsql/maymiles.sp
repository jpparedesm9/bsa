/************************************************************************/
/*	Archivo: 		maymiles.sp			        */
/*	Stored procedure: 	sp_mayoriza_miles			*/
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
/*	   Actualizacion de saldos de cuentas en miles de sucres        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	08/Mar/1994	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mayoriza_miles')
	drop proc sp_mayoriza_miles  
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_mayoriza_miles (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'S',
	@t_file		varchar(14) = null,
	@t_from		varchar(14) = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint  = null,
   	@i_valor_mna	money = null,
	@i_valor_dol    money = null,
	@i_valor_uvc    money = null,
	@i_valor_tot    money = null,
   	@i_valor_mna_s	money = null,
	@i_valor_dol_s  money = null,
	@i_valor_uvc_s  money = null,
	@i_valor_tot_s  money = null,
	@i_periodo	int = null,
        @i_corte   	int = null,
        @i_credito 	money = 0,
        @i_debito  	money = 0,
	@i_credito_me 	money = 0,
	@i_debito_me	money = 0
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
        @periodo 	int,
        @periodo_ant 	int,
        @valor 		money,
	@valor_me	money,
        @valor_ant 	money,
        @valor_ini 	money,
	@w_estado	char(1)


select @w_today = getdate()
select @w_sp_name = 'sp_mayoriza_miles'


/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6291) 
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
select @valor_ini = @i_valor_mna

            /*******        *******/

select @w_estado = co_estado
from cob_conta..cb_corte
where co_empresa = @i_empresa and
	co_periodo = @i_periodo and
	co_corte = @i_corte 

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


select @corte_ini = @i_corte      
            /*******        *******/


begin tran
select @flag4 = 0
select @temp_oficina = @i_oficina
select @flag1 = 1
while @flag1 > 0
begin
   if @i_cuenta IS NOT NULL
   begin
     select @flag2 = 1
     while @flag2 > 0
     begin
       if @i_oficina IS NOT NULL
       begin
          if NOT EXISTS (select * from cob_conta..cb_balsuper
		      where bl_empresa = @i_empresa and
		            bl_oficina = @i_oficina and 
			    bl_cuenta = @i_cuenta and
                            bl_periodo = @i_periodo and
                            bl_corte   = @i_corte )
	  begin 
                  insert into cob_conta..cb_balsuper
			( bl_cuenta,bl_oficina,bl_corte,
			  bl_periodo,bl_empresa,bl_saldo_mna,         
                          bl_saldo_dol,bl_saldo_uvc,bl_saldo_tot,
                          bl_saldo_mna_s,bl_saldo_dol_s,bl_saldo_uvc_s,
                          bl_saldo_tot_s,bl_debito,bl_credito,
                          bl_debito_me,bl_credito_me
			)
                  values (@i_cuenta,@i_oficina,@i_corte,@i_periodo,
                          @i_empresa,round(@i_valor_mna,0),round(@i_valor_dol,0),
			  round(@i_valor_uvc,0),round(@i_valor_tot,0),
                          round(@i_valor_mna_s,0),round(@i_valor_dol_s,0),
			  round(@i_valor_uvc_s,0),round(@i_valor_tot_s,0),
                          round(@i_debito,0),round(@i_credito,0),
                          round(@i_debito_me,0),round(@i_credito_me,0))

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
                  update cob_conta..cb_balsuper
                  set bl_saldo_mna   = round(bl_saldo_mna   + @i_valor_mna,0),
                      bl_saldo_dol   = round(bl_saldo_dol   + @i_valor_dol,0),
                      bl_saldo_uvc   = round(bl_saldo_uvc   + @i_valor_uvc,0),
                      bl_saldo_tot   = round(bl_saldo_tot   + @i_valor_tot,0),
                      bl_saldo_mna_s = round(bl_saldo_mna_s + @i_valor_mna_s,0),
                      bl_saldo_dol_s = round(bl_saldo_dol_s + @i_valor_dol_s,0),
                      bl_saldo_uvc_s = round(bl_saldo_uvc_s + @i_valor_uvc_s,0),
                      bl_saldo_tot_s = round(bl_saldo_tot_s + @i_valor_tot_s,0),
                      bl_debito      = round(bl_debito + @i_debito,0),
                      bl_credito     = round(bl_credito + @i_credito,0),
                      bl_debito_me   = round(bl_debito_me + @i_debito_me,0),
                      bl_credito_me  = round(bl_credito_me + @i_credito_me,0)
		  where bl_empresa = @i_empresa and
		        bl_oficina = @i_oficina and 
			bl_cuenta = @i_cuenta and
                        bl_periodo = @i_periodo and
                        bl_corte  = @i_corte 

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
          /* DETERMINA EL PADRE DE LA OFICINA ACTUAL */ 

          select @corte = @corte_ini
          select @valor = @valor_ini
	  if @flag4 = 0
          begin
	     select @i_oficina = of_oficina
  	     from cob_conta..cb_oficina
    	     where of_empresa = @i_empresa and
		   of_oficina_padre is null
		select @flag4 = 1
	  end
	  else select @i_oficina = null
/*******
	  select @padre_oficina = of_oficina_padre
	  from cb_oficina                                   
	  where of_empresa = @i_empresa and
	        of_oficina = @i_oficina 
	  select @i_oficina = @padre_oficina         
********/

       end
       else
       begin   /*  OFICINA ES NULL */
		 /* DETERMINA EL PADRE DE LA CUENTA ACTUAL Y REPITE EL 
                    PROCESO CON LOS CENTROS DE COSTO */ 
                 select @flag4 = 0 
                 select @flag2 = 0 
	         select @valor_me = 0
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
end        /* while flag > 0 */
commit tran
return 0
go
