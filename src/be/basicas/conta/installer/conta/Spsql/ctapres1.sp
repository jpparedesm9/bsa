/************************************************************************/
/*      Archivo:                ctapresu.sp                             */
/*      Stored procedure:       sp_cta_presupuesto                      */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     10-noviembre-1997                       */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Generar automaticamente en el plan de cuentas de presupuesto    */
/*      las cuentas padre tomando como base el plan general de cuentas  */
/*      las marcadas como de presupuesto.                               */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10/Nov/97     Martha Gil V.	Emision Inicial                 */
/************************************************************************/   
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cta_presupuesto')
        drop proc sp_cta_presupuesto

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cta_presupuesto (
        @s_ssn          int = null,
        @s_date         datetime = null,
        @s_user         login = null,
        @s_term         descripcion = null,
        @s_corr         char(1) = null,
        @s_ssn_corr     int = null,
        @s_ofi          smallint = null,
        @t_rty          char(1) = null,
        @t_trn          smallint = null,
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null,
        @t_from         varchar(30) = null,
        @i_operacion    char(1) = null,        
        @i_modo         smallint = null,
        @i_empresa      tinyint  = null,
        @i_cuenta       cuenta = null  
)
as
declare @w_sp_name      varchar(32),
        @w_return       int,        
        @w_flag         int,          
	@w_cuenta       cuenta,
	@w_cta_padre  cuenta         

select @w_sp_name = 'sp_cta_presupuesto'

/************************************************/
/*  Tipo de Transaccion = 610X                  */
/************************************************/

if (@t_trn <> 6101 and @i_operacion = 'I')
begin
        /* 'Tipo de transaccion no corresponde' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601077
        return 1
end
/************************************************/

if @i_operacion = 'I'
begin
 
begin tran 
   select @w_flag = 1
   select @w_cuenta = @i_cuenta 
   while  @w_flag <> 0
   begin

       select @w_cta_padre = cu_cuenta_padre
       from   cb_cuenta
       where  cu_empresa = @i_empresa 
       and    cu_cuenta = @w_cuenta
       if @w_cta_padre is null
          select @w_flag = 0
       else

       /* Verifica que no este la cuenta  en cb_cuenta_presupuesto
          para ingresarla de acuerdo a cb_cuenta */

       if NOT EXISTS ( select cup_cuenta
                       from   cb_cuenta_presupuesto
                       where  cup_empresa = @i_empresa
                       and    cup_cuenta = @w_cta_padre)

       begin 
       	   select @w_cuenta = @w_cta_padre
  
      	   insert into cb_cuenta_presupuesto 
    	   select cu_empresa, cu_cuenta, cu_cuenta_padre, 
    	   cu_nombre, cu_descripcion, cu_nivel_cuenta, 
    	   cu_categoria, cu_movimiento, cu_estado
    	   from cb_cuenta
    	   where cu_empresa = @i_empresa 
    	   and   cu_cuenta  = @w_cta_padre

  	   if @@error <> 0
       	   begin
        	/* 'Error en la Insercion de Cuentas Padre  ' */
       		exec cobis..sp_cerror
          	@t_debug = @t_debug,
          	@t_file  = @t_file,
          	@t_from  = @w_sp_name,
          	@i_num   = 603018
         	return 1
           end     
       end
       else
           break
   end
 
 commit tran
 return 0   
end
go

