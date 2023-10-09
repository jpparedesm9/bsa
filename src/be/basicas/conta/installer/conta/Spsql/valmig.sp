/************************************************************************/
/*	Archivo: 		valmig.sp			        */
/*	Stored procedure: 	sp_valmig				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Pedro Coello Ramirez            	*/
/*	Fecha de escritura:     23-marzo-2001 				*/
/*************************************************************************/
/*				IMPORTANTE				 */
/*	Este programa es parte de los paquetes bancarios propiedad de	 */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	 */
/*	"NCR CORPORATION".						 */
/*	Su uso no autorizado queda expresamente prohibido asi como	 */
/*	cualquier alteracion o agregado hecho por alguno de sus		 */
/*	usuarios sin el debido consentimiento por escrito de la 	 */
/*	Presidencia Ejecutiva de MACOSA o su representante.		 */
/*				PROPOSITO				 */
/*	Este programa procesa las transacciones de:			 */
/*	Realiza validaciones efectuadas anteriormente en el 		 */
/*	cb_valmig.sqr        						 */
/*				MODIFICACIONES				 */
/*	FECHA		AUTOR		  RAZON				 */
/*      23-Marzo-2001   P. Coello         Emision Inicial	         */
/*************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_valmig')
	drop proc sp_valmig
go

create proc sp_valmig (
	@t_debug	   char(1) = 'N',
	@i_operacion       varchar(1) = null,
	@i_empresa         tinyint  = null,
	@i_fecha_tran	   varchar(10) = null, 
	@i_oficina_orig	   smallint = null,
	@i_oficina_dest	   smallint = null,
	@i_area_orig	   smallint = null,
	@i_area_dest	   smallint = null,
	@i_cuenta	   cuenta   = null,
	@i_oper_banco	   char(4)  = null,
	@i_credito_me	   money    = null,
	@i_debito_me	   money    = null,
	@i_credito	   money    = null,
	@i_debito	   money    = null,
	@o_error	   varchar(100) = null out
)
as 
declare @w_error varchar(100),
	@w_moneda_base tinyint,
	@w_moneda      tinyint

if @i_operacion = 'V'
   begin
       select @w_moneda_base = em_moneda_base
	 from cb_empresa
	where em_empresa = @i_empresa

       if @@rowcount = 0
	  begin
	      --print 'EMPRESA CONSULTADA NO EXISTE %1! ', @i_empresa
	      select @w_error = 'EMPRESA'
	  end
       --else
         --print 'Empresa Ok '

	select 1
          from cb_corte
         where co_empresa   = @i_empresa
           and co_fecha_ini = @i_fecha_tran
           and co_estado    in ('V','A')

       if @@rowcount = 0
	  begin
	      --print 'CORTE NO SE ENCUENTRA DEFINIDO PARA MAYORIZAR ===> %1! ', @i_fecha_tran
	      select @w_error = @w_error + 'FECHA-'
	  end
       --else
         --print 'Corte Ok '

       select 1
         from cb_oficina
	where of_empresa       = @i_empresa
          and   of_oficina     = @i_oficina_orig
          and   of_estado      = 'V'
          and   of_movimiento  = 'S'

       if @@rowcount = 0
	  begin
	      --print 'OFICINA CONSULTADA NO EXISTE O NO ES DE MOVIMIENTO %1! ',@i_oficina_orig
	      select @w_error = @w_error + 'OFC ORIGEN-'
	  end
       --else
         --print 'Oficina Ok '

       select 1
         from cb_oficina
	where of_empresa       = @i_empresa
          and   of_oficina     = @i_oficina_dest
          and   of_estado      = 'V'
          and   of_movimiento  = 'S'

       if @@rowcount = 0
	  begin
	      --print 'OFICINA CONSULTADA NO EXISTE O NO ES DE MOVIMIENTO %1! ', @i_oficina_dest
	      select @w_error = @w_error + 'OFC DESTINO-'
	  end
       --else
         --print 'Oficina Destino Ok '

       select 1
         from cb_area 
        where ar_empresa    = @i_empresa
          and ar_area       = @i_area_orig
          and ar_estado     = 'V'
          and ar_movimiento = 'S'

       if @@rowcount = 0
	  begin
	      --print 'AREA CONSULTADA NO EXISTE O NO ES DE MOVIMIENTO %1! ', @i_area_orig
	      select @w_error = @w_error + 'AREA ORIGEN-'
	  end
       --else
         --print 'Area Ok '

       select 1
         from cb_area 
        where ar_empresa    = @i_empresa
          and ar_area       = @i_area_dest
          and ar_estado     = 'V'
          and ar_movimiento = 'S'

       if @@rowcount = 0
	  begin
	      --print 'AREA CONSULTADA NO EXISTE O NO ES DE MOVIMIENTO %1! ', @i_area_dest
	      select @w_error = @w_error + 'AREA DEST-'
	  end
       --else
         --print 'Area Destino Ok '

       select @w_moneda = cu_moneda
         from cb_cuenta                            
        where cu_empresa    = @i_empresa
          and cu_cuenta     = @i_cuenta
          and cu_estado     = 'V'
          and cu_movimiento = 'S'

       if @@rowcount = 0
	  begin
	      --print 'CUENTA CONSULTADA NO EXISTE O NO ES DE MOVIMIENTO %1! ', @i_cuenta
	      select @w_error = @w_error + 'CUENTA-'
	  end
       --else
         --print 'Cuenta Ok '

       if @w_moneda = @w_moneda_base
          if (@i_debito_me <> 0 or @i_credito_me <> 0)
             begin
	       --print 'CUENTA MN CON VALORES EN MONEDA EXTRANJERA %1! ', @i_cuenta
	       select @w_error = @w_error + 'CUENTA MN CON VALOR ME-'
             end
/*
       if @w_moneda <> @w_moneda_base
          if (@i_debito_me = 0 and @i_credito_me = 0)
             begin
	       --print 'CUENTA ME SIN VALORES EN MONEDA EXTRANJERA %1! ', @i_cuenta
	       select @w_error = @w_error + 'FALTA ME-'
             end
*/
       select 1
	 from  cb_plan_general
	where pg_empresa = @i_empresa
	  and pg_oficina = @i_oficina_dest
	  and pg_area    = @i_area_dest
	  and pg_cuenta  = @i_cuenta

       if @@rowcount = 0
	  begin
	      --print 'CUENTA %1! NO RELACIONADA A OF. %2! AREA %3!', @i_cuenta, @i_oficina_dest, @i_area_dest
	      select @w_error = @w_error + 'PLAN GENERAL-'
	  end
       --else
         --print 'Plan General Ok '

       select 1
	 from cb_banco
	where ba_empresa  = @i_empresa
	  and ba_cuenta = @i_cuenta

       if @@rowcount <> 0
          if @i_oper_banco = ''
	     begin
	        --print 'CUENTA DE BANCO PARA CONCILIACION NO EXISTE %1! ', @i_cuenta
	        select @w_error = @w_error + 'BANCO-'
	     end
       --else
         --print 'Banco Ok '

       select @o_error = @w_error
    end      

return 0
go