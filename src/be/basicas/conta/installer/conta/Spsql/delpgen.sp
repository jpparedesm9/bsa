/***********************************************************************/
/*	Archivo: 		delpgen.sp 				*/
/*	Stored procedure: 	sp_delpgen 				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           G. Jaramillo                        	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
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
/*	   Eliminacion de registros del plan_general                    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de Secciones	*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_delpgen')
	drop proc sp_delpgen
go

create proc sp_delpgen    (
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
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina	smallint = null   ,
	@i_area		smallint = null
)
as
declare
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_cuenta 	cuenta

select @w_sp_name = 'sp_delpgen'


/************************************************/
/*  Tipo de Transaccion = 607X 			*/
if (@t_trn <> 6073 and @i_operacion = 'D')
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


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,
		i_cuenta 	= @i_cuenta,
		i_oficina 	= @i_oficina
	exec cobis..sp_end_debug
end


if @i_empresa is null or @i_cuenta is null or
@i_oficina is null or @i_area is null
begin
	/* 'Campos NOT NULL con valores nulos' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601001
	return 1
end


/***** DELETE ******/
if @i_operacion = 'D'
   begin
   select @w_cuenta = sa_cuenta
   from cob_conta..cb_saldo
   where sa_empresa = @i_empresa 
   and   sa_oficina = @i_oficina 
   and   sa_area    = @i_area 
   and   sa_cuenta  = @i_cuenta
   and   sa_saldo   <> 0
   if @@rowcount > 0
   begin
         /* 'Cuenta de Movimiento relacionado con Saldos   ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 607049
      return 1
   end

/******** Asientos ***********/
if exists(select  as_cuenta
          from cob_conta..cb_asiento,
               cob_conta..cb_comprobante
          where as_empresa      = @i_empresa 
          and   as_oficina_dest = @i_oficina 
          and   as_area_dest    = @i_area 
          and   as_cuenta       = @i_cuenta 
          and   as_mayorizado   = 'N'
          and   as_comprobante  = co_comprobante
          and   as_fecha_tran   = co_fecha_tran
          and   as_oficina_orig = co_oficina_orig
          and   as_empresa      = co_empresa
          and   co_autorizado   = 'S')
begin
      /* 'Cuenta de Movimiento relacionado con Asientos   ' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file	 = @t_file,
   @t_from	 = @w_sp_name,
   @i_num	 = 607050
   return 1
end

/******** Comprobantes Tipo ********/
   select @w_cuenta = dct_cuenta
   from cob_conta..cb_det_comptipo
   where dct_empresa      = @i_empresa 
   and   dct_oficina_dest = @i_oficina 
   and   dct_area_dest    = @i_area 
   and   dct_cuenta       = @i_cuenta
   if @@rowcount > 0
   begin
         /* 'Cuenta de Movimiento relacionado con detalle Comp. Tipo ' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file	 = @t_file,
   @t_from	 = @w_sp_name,
   @i_num	 = 607051
   return 1
   end


begin tran
/****************************************/
   /* TRANSACCION DE SERVICIO		*/
   insert into ts_plan_general
   values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
           @i_empresa,@i_cuenta,@i_oficina,@i_area)
   if @@error <> 0
   begin
	/* 'Error en insercion de transaccion de servicio' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 603032
      return 1
   end

   if exists (select 1 from cb_plan_general
             where pg_empresa = @i_empresa 
             and   pg_oficina = @i_oficina 
             and   pg_area    = @i_area 
             and   pg_cuenta  = @i_cuenta)
   begin
      delete cb_plan_general
      where pg_empresa = @i_empresa and
      pg_oficina = @i_oficina and
      pg_area = @i_area and
      pg_cuenta = @i_cuenta
      if @@error <> 0
      begin
         /* 'Error en la elimin relacion cuenta-oficina-area' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 607052
         return 1
      end
   end
   commit tran
   return 0
end

go
