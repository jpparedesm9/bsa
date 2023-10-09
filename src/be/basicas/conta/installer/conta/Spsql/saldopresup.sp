/************************************************************************/
/*	Archivo: 		saldopresup.sp	    		        */
/*	Stored procedure: 	sp_saldo_presupuesto			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     09-marzo-1998 				*/
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
/*	   Mantenimiento al catalogo de Saldos presupuesto              */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	09/Mar/1998	Sandra Robayo   Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_presupuesto')
	drop proc sp_saldo_presupuesto    

go
create proc sp_saldo_presupuesto (
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
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint  = null,
	@i_cuenta     	cuenta = null,
        @i_cuenta1      cuenta = null,
	@i_oficina 	smallint = null,
        @i_oficina_pre  tinyint = null,
	@i_area		smallint = null,
 	@i_fecha	datetime = null,	
	@i_formato_fecha	tinyint = 1
)
as 
declare
	@w_today 	datetime,  	
	@w_return	int,		
	@w_sp_name	varchar(32),	
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
        @w_categoria    char(1),
	@w_secuencial	smallint,
        @w_oficina      smallint,
        @w_area         smallint,
        @w_variacion    money,
        @w_presupuesto  money,
        @w_real         money, 
	@w_operador	int,
	@w_existe	tinyint	,	
        @w_saldo        money, 
        @w_nombre       descripcion 

select @w_today = getdate()
select @w_sp_name = 'sp_saldo_presupuesto'


if (@t_trn <> 6296 and @i_operacion = 'S') 
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
		i_empresa	= @i_empresa,
		i_cuenta     	= @i_cuenta,
		i_oficina	= @i_oficina
	exec cobis..sp_end_debug
end

if @i_operacion = 'S'
begin

	set rowcount 20

        if @i_oficina_pre = 0 
        begin
  
           if @i_modo = 0 
           begin
	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) < isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta
               order by sap_oficina, sap_area, sap_cuenta


	       if @@rowcount = 0
               begin
               /* 'No existen Saldos para la Cuenta Especificada' */
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 601065
                  return 1
               end
            end
            else
            begin

	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) < isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta and
                  ((sap_oficina = @i_oficina and
                    sap_area = @i_area and   
                    sap_cuenta > @i_cuenta1) or
                   (sap_oficina = @i_oficina and
                    sap_area > @i_area) or
                   (sap_oficina > @i_oficina))
               order by sap_oficina, sap_area, sap_cuenta


               if @@rowcount = 0
               begin
	       /* 'No existen mas Saldos para la Cuenta Especificada'*/
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 601065
                   return 1
               end

            end
        end

        if @i_oficina_pre = 1 
        begin
  
           if @i_modo = 0 
           begin
	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) > isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta
               order by sap_oficina, sap_area, sap_cuenta


	       if @@rowcount = 0
               begin
               /* 'No existen Saldos para la Cuenta Especificada' */
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 601065
                  return 1
               end

            end
            else
            begin

	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) > isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta and
                  ((sap_oficina = @i_oficina and
                    sap_area = @i_area and   
                    sap_cuenta > @i_cuenta1) or
                   (sap_oficina = @i_oficina and
                    sap_area > @i_area) or
                   (sap_oficina > @i_oficina))
               order by sap_oficina, sap_area, sap_cuenta


               if @@rowcount = 0
               begin
	       /* 'No existen mas Saldos para la Cuenta Especificada'*/
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 601065
                   return 1
               end

            end
        end

        if @i_oficina_pre = 2 
        begin
  
           if @i_modo = 0 
           begin
	       select  "Oficina" 	= sap_oficina,
                       "Area" 		= sap_area,
                       "Cuenta" 	= sap_cuenta,
                       --"Real" 		= round(isnull(sap_real,0),0),
                       --"Presupuesto" 	= round(isnull(sap_presupuesto,0),0),
                       --"Variacion" 	= round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" 		= isnull(sap_real,0),
                       "Presupuesto" 	= isnull(sap_presupuesto,0),
                       "Variacion" 	= isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) = isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta
               order by sap_oficina, sap_area, sap_cuenta


	       if @@rowcount = 0
               begin
               /* 'No existen Saldos para la Cuenta Especificada' */
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 601065
                  return 1
               end

            end
            else
            begin

	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where isnull(sap_presupuesto,0) = isnull(sap_real,0) and
                  sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta and
                  ((sap_oficina = @i_oficina and
                    sap_area = @i_area and   
                    sap_cuenta > @i_cuenta1) or
                   (sap_oficina = @i_oficina and
                    sap_area > @i_area) or
                   (sap_oficina > @i_oficina))
               order by sap_oficina, sap_area, sap_cuenta


               if @@rowcount = 0
               begin
	       /* 'No existen mas Saldos para la Cuenta Especificada'*/
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 601065
                   return 1
               end

            end
        end

        if @i_oficina_pre = 3 
        begin
  
           if @i_modo = 0 
           begin
	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta
               order by sap_oficina, sap_area, sap_cuenta


	       if @@rowcount = 0
               begin
               /* 'No existen Saldos para la Cuenta Especificada' */
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 601065
                  return 1
               end

            end
            else
            begin

	       select  "Oficina" = sap_oficina,
                       "Area" = sap_area,
                       "Cuenta" = sap_cuenta,
                       --"Real" = round(isnull(sap_real,0),0),
                       --"Presupuesto" = round(isnull(sap_presupuesto,0),0),
                       --"Variacion" = round(isnull(sap_real,0) - isnull(sap_presupuesto,0),0),
                       "Real" = isnull(sap_real,0),
                       "Presupuesto" = isnull(sap_presupuesto,0),
                       "Variacion" = isnull(sap_real,0) - isnull(sap_presupuesto,0),
                       "Porc. de Ejecucion="=""
               from cob_conta..cb_saldo_presupuesto
               where sap_empresa = @i_empresa and
                  sap_fecha = @i_fecha and
                  sap_cuenta = @i_cuenta and
                  ((sap_oficina = @i_oficina and
                    sap_area = @i_area and   
                    sap_cuenta > @i_cuenta1) or
                   (sap_oficina = @i_oficina and
                    sap_area > @i_area) or
                   (sap_oficina > @i_oficina))
               order by sap_oficina, sap_area, sap_cuenta


               if @@rowcount = 0
               begin
	       /* 'No existen mas Saldos para la Cuenta Especificada'*/
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 601065
                   return 1
               end

            end
        end


   return 0

end

go

