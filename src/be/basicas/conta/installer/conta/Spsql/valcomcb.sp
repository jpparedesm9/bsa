/************************************************************************/
/*	Archivo: 		valcomcb.sp  			        */
/*	Stored procedure: 	sp_valida_comprobante_mig		*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marcelo Poveda     	        	*/
/*	Fecha de escritura:    	Marzo 2002				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Realiza la validacion de cuentas especiales del proceso de 	*/
/*	Migración							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = "sp_valida_comprobante_mig")
   drop proc sp_valida_comprobante_mig
go

create proc sp_valida_comprobante_mig
as
declare
@w_sp_name		varchar(30),
@w_scm_comprobante	int,
@w_scm_empresa		tinyint,
@w_sam_comprobante	int,
@w_sam_area_orig	smallint,
@w_sam_cuenta		varchar(15),
@w_sam_oficina_dest	smallint,
@w_sam_credito		money,
@w_sam_debito		money,
@w_sam_credito_me	money,
@w_sam_debito_me	money,
@w_sam_tipo_tercero	varchar(2),
@w_sam_id_tercero	varchar(15),
@w_sam_ente		int,
@w_sam_proceso		smallint,
@w_sam_empresa		tinyint,
@w_sam_asiento		smallint,
@w_sam_con_impuesto	varchar(10),
@w_sam_base		money,
@w_existe		tinyint,
@w_comprobante		int,
@w_tdebito		money,
@w_tcredito		money,
@w_tdebito_me		money,
@w_tcredito_me		money,
@w_tdebito_as		money,
@w_tcredito_as		money,
@w_tdebito_me_as	money,
@w_tcredito_me_as	money,
@w_base			money,
@w_porcentaje		float,
@w_resta_proceso	float,  	/*variable de prueba*/
@w_afectacion		char(1),
@w_retencion_aux	money,
@w_cuenta_asociada	varchar(15),
@w_dato			varchar(255)

/*Inicializacion de variables*/
select @w_sp_name = "sp_valida_comprobante_mig"
select @w_existe  = 1  --0 Si existe 1 No existe

declare cursor_comprobante cursor for
select 
scm_comprobante, scm_empresa
from cob_conta..cb_scomprobante_mig

open cursor_comprobante
fetch cursor_comprobante into @w_scm_comprobante, @w_scm_empresa

while @@fetch_status =0 begin
   /*Inicializacion de variables*/
   select @w_base = 0,
   @w_porcentaje  = 0,
   @w_retencion_aux = 0

   declare cursor_especial cursor for
   select distinct ca_cta_asoc
      from cob_conta..cb_cuenta_asociada,cob_conta..cb_sasiento_mig
      where ca_empresa = @w_scm_empresa
      and sam_cuenta like rtrim(ltrim(ca_cuenta)) + "%"
      and sam_empresa =ca_empresa  
      and sam_comprobante =@w_scm_comprobante
      and sam_cuenta_especial = 9
   
   open cursor_especial
 
   fetch cursor_especial into @w_cuenta_asociada

   while @@fetch_status = 0 begin
      /*Inicializacion de variables*/
      select @w_tdebito = 0,
      @w_tcredito = 0,
      @w_tdebito_me = 0,
      @w_tcredito_me = 0,
      @w_tdebito_as = 0,
      @w_tcredito_as = 0,
      @w_tdebito_me_as = 0,
      @w_tcredito_me_as = 0

      select @w_sam_cuenta = ca_cuenta
      from cob_conta..cb_cuenta_asociada
      where ca_empresa = @w_scm_empresa
      and   @w_cuenta_asociada = ca_cta_asoc

     --  print 'cuenta asociada %1!, cuenta %2!', @w_cuenta_asociada, @w_sam_cuenta
      if @w_sam_cuenta = '' begin
         update cob_conta..cb_scomprobante_mig
         set    scm_error = 1
         where  scm_comprobante = @w_scm_comprobante
         and    scm_empresa = @w_scm_empresa

	 update cob_conta..cb_sasiento_mig
         set    sam_error = 1
         where  sam_comprobante = @w_scm_comprobante
         and    sam_empresa     = @w_scm_empresa
         and    sam_cuenta      = @w_sam_cuenta

	 exec  sp_migra_log_errores
         @i_fuente       = @w_sp_name,
         @i_fila         = @w_scm_comprobante,
         @i_campo        = '',
         @i_dato         = @w_sam_cuenta,
         @i_referencia   = 600305,
         @i_operacion    = @w_scm_comprobante,
         @i_producto     = 6
      end

      /*Buscar cuenta asociada en el asiento*/

      select @w_existe = 0
      from cob_conta..cb_sasiento_mig
      where sam_empresa = @w_scm_empresa
      and   sam_comprobante = @w_scm_comprobante
      and   sam_cuenta like @w_cuenta_asociada + "%"
      and   sam_cuenta_especial = 10
     
      if @w_existe = 0 
      begin
         select @w_tdebito = sum(sam_debito),
	 @w_tcredito = sum(sam_credito),
	 @w_tdebito_me = sum(sam_debito_me),
	 @w_tcredito_me = sum(sam_credito_me)
	 from cob_conta..cb_sasiento_mig
	 where sam_empresa = @w_scm_empresa
 	 and   sam_comprobante = @w_scm_comprobante
         and   sam_cuenta_especial = 9

	 select @w_tdebito_as = sum(sam_debito),
	 @w_tcredito_as = sum(sam_credito),
	 @w_tdebito_me_as = sum(sam_debito_me),
	 @w_tcredito_me_as = sum(sam_credito_me)
	 from cob_conta..cb_sasiento_mig
	 where sam_empresa = @w_scm_empresa
 	 and   sam_comprobante = @w_scm_comprobante
	 and   sam_cuenta like @w_cuenta_asociada + "%"
	 and   sam_cuenta_especial = 10

	 if ((@w_tdebito - @w_tcredito) != (@w_tcredito_as - @w_tdebito_as)) or 
	    ((@w_tdebito_me - @w_tcredito_me) != ( @w_tcredito_me_as - @w_tdebito_me_as))
	 begin
               update cob_conta..cb_scomprobante_mig
               set    scm_error = 1
               where  scm_comprobante = @w_scm_comprobante
               and    scm_empresa = @w_scm_empresa
	     		
	       update cob_conta..cb_sasiento_mig
               set    sam_error = 1
               where  sam_comprobante = @w_scm_comprobante
               and    sam_empresa     = @w_scm_empresa
               and    sam_cuenta like @w_cuenta_asociada + "%"
               
               --print 'cuenta asiento %1!, cuenta cursor%2!', sam_cuenta , @w_sam_cuenta  /**borrar**/

	       exec  sp_migra_log_errores
               @i_fuente       = @w_sp_name,
               @i_fila         = @w_scm_comprobante,
               @i_campo        = '',
               @i_dato         = @w_sam_cuenta,
               @i_referencia   = 600307,
               @i_operacion    = @w_scm_comprobante,
               @i_producto     = 6      
         end
         /* Actualizar cuentas asociadas existentes */
         update cob_conta..cb_sasiento_mig
         set sam_cuenta_especial = 100
         from cob_conta..cb_sasiento_mig
	 where sam_empresa = @w_scm_empresa
 	 and   sam_comprobante = @w_scm_comprobante
	 and   sam_cuenta like @w_cuenta_asociada + "%"
	 and   sam_cuenta_especial = 10
      end 
      else 
      begin
         update cob_conta..cb_scomprobante_mig
         set    scm_error = 1
         where  scm_comprobante = @w_scm_comprobante
         and    scm_empresa = @w_scm_empresa

	 update cob_conta..cb_sasiento_mig
         set    sam_error = 1
         where  sam_comprobante = @w_scm_comprobante
         and    sam_empresa     = @w_scm_empresa
         and    sam_cuenta like @w_cuenta_asociada + "%"

	 exec  sp_migra_log_errores
         @i_fuente       = @w_sp_name,
         @i_fila         = @w_scm_comprobante,
         @i_campo        = '',
         @i_dato         = @w_sam_cuenta,
         @i_referencia   = 600306,
         @i_operacion    = @w_scm_comprobante,
         @i_producto     = 6      
      end

      fetch cursor_especial into @w_cuenta_asociada
   end
   close cursor_especial
   deallocate cursor_especial

   select @w_existe = 1

   select @w_existe = 0
   from cob_conta..cb_sasiento_mig
   where sam_empresa = @w_scm_empresa
   and   sam_comprobante = @w_scm_comprobante
   and   sam_cuenta_especial = 10 

   if @w_existe = 0 begin
      update cob_conta..cb_scomprobante_mig
      set    scm_error = 1
      where  scm_comprobante = @w_scm_comprobante
      and    scm_empresa = @w_scm_empresa

      update cob_conta..cb_sasiento_mig
      set    sam_error = 1
      where  sam_comprobante = @w_scm_comprobante
      and    sam_empresa     = @w_scm_empresa
      and    sam_cuenta      = @w_sam_cuenta

      exec  sp_migra_log_errores
      @i_fuente       = @w_sp_name,
      @i_fila         = @w_scm_comprobante,
      @i_campo        = '',
      @i_dato         = @w_sam_cuenta,
      @i_referencia   = 600308,
      @i_operacion    = @w_scm_comprobante,
      @i_producto     = 6
   end

   fetch cursor_comprobante into @w_scm_comprobante, @w_scm_empresa
end
close cursor_comprobante
deallocate cursor_comprobante

return 0
go
