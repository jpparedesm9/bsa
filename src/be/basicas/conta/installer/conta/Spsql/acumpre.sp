/************************************************************************/
/*	Archivo: 		acumpre.sp  			        */
/*	Stored procedure: 	sp_acumpre				*/
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
/*	   Consulta de saldos acumulados de presupuesto         	*/
/*         Consulta de Cta. Contable dada Cta. de Presupuesto		*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/*   12/Oct/1995     G Jaramillo       Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_acumpre')
	drop proc sp_acumpre  

go
create proc sp_acumpre (
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
	@i_modo			smallint = null,
	@i_empresa              tinyint = null,
	@i_cuenta         	cuenta = null,
	@i_oficina		smallint = null,
	@i_area  		smallint = null ,
	@i_fecha		datetime = null,
	@i_cuenta1              cuenta = null ,
	@i_cuenta2              cuenta = null 
)
as 
declare
	@w_today 		datetime,  	/* fecha del dia */
	@w_return		int,		/* valor que retorna */
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_siguiente		tinyint,
	@w_cuenta       	cuenta,
	@w_empresa		tinyint,
	@w_oficina		smallint,
	@w_area			smallint,
	@w_presupuesto		money,
	@w_presup		money,
	@w_real			money,
	@w_fecha		datetime,
	@w_maximo		tinyint,
	@w_existe		int		/* codigo existe = 1 
						   no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_acumpre'



if (@t_trn <> 6879 and @i_operacion = 'C') or 
   (@t_trn <> 6878 and @i_operacion = 'S')
begin
	/* 'Tipo de transaccion no corresponde' */
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
		i_area		= @i_area 
	exec cobis..sp_end_debug
end



if @i_operacion = 'C'
begin  
   set rowcount 20

      if @i_modo = 0 
      begin
	select 	"Cuenta" = sap_cuenta, 
        	"Nombre Cuenta" = substring(cu_nombre,1,30),
		"Real Acumulado" = sum(isnull(sap_real,0)),
		"Presup. Acum." = sum(isnull(sap_presupuesto,0)),	
        	--"Variacion" = round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
		"Variacion" = sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
        	"Porc. Ejecucion" = "" 
	from cb_saldo_presupuesto , cb_cuenta
	where sap_cuenta like @i_cuenta
         and  sap_oficina in (select je_oficina
                         	from cb_jerarquia
                         	where je_empresa = @i_empresa and
                              	(je_oficina = @i_oficina or je_oficina_padre = @i_oficina)) 
         and  sap_area in (select ja_area
                         	from cb_jerararea
                         	where ja_empresa = @i_empresa and
                           	(ja_area = @i_area or ja_area_padre = @i_area)) 
        and   sap_cuenta = cu_cuenta 
        and   cu_cuenta like @i_cuenta
	and   (sap_fecha <= @i_fecha)
	and   datepart(yy,sap_fecha) = datepart(yy,@i_fecha)
	and   (sap_cuenta > @i_cuenta1 or @i_cuenta1 is null)
	and   cu_empresa = @i_empresa
	and   sap_empresa = @i_empresa
	group by sap_cuenta, cu_nombre

      if @@rowcount = 0
      begin
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
	select 	"Cuenta" = sap_cuenta, 
        	"Nombre Cuenta" = substring(cu_nombre,1,30),
		"Real Acumulado" = sum(isnull(sap_real,0)),
		"Presup. Acum." = sum(isnull(sap_presupuesto,0)),	
        	--"Variacion" = round(sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),0),
        	"Variacion" = sum(isnull(sap_real,0))-sum(isnull(sap_presupuesto,0)),
        	"Porc. Ejecucion" = "" 
	from cb_saldo_presupuesto , cb_cuenta
	where sap_cuenta like @i_cuenta
        and  sap_oficina  = @i_oficina 
        and  sap_area = @i_area 
        and   sap_cuenta = cu_cuenta 
        and   cu_cuenta like @i_cuenta
	and   (sap_fecha <= @i_fecha)
	and   datepart(yy,sap_fecha) = datepart(yy,@i_fecha)
	and   (sap_cuenta > @i_cuenta1 or @i_cuenta1 is null)
	and   cu_empresa = @i_empresa
	and   sap_empresa = @i_empresa
	group by sap_cuenta, cu_nombre

      if @@rowcount = 0
      begin
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


if @i_operacion = 'S'
begin  

	select gp_cuenta from cb_general_presupuesto
	where gp_cuenta_presupuesto = @i_cuenta and
              gp_oficina_presupuesto = @i_oficina and
	      gp_area_presupuesto = @i_area and
	      gp_empresa = @i_empresa and
	      gp_cuenta in (select cu_cuenta from cb_cuenta
			    where cu_cuenta = @i_cuenta and
			          cu_empresa = @i_empresa and
				  cu_movimiento = 'S')
		
       if @@rowcount = 0
       begin
		/* Cuenta COBIS no es de Movimiento */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609124
		return 1
       end
      return 0
	      
end

go
