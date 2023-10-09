/************************************************************************/
/*	Archivo: 		perfconc.sp				*/
/*	Stored procedure: 	sp_perfil_conc                          */
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           N. Puetaman                      	*/
/*	Fecha de escritura:     23-Marzo-2000 				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Insercion de cabecera de perfiles contables.                    */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	23/Mar/2000	 	        Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_perfil_conc')
    drop proc sp_perfil_conc 
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create proc sp_perfil_conc (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi	        smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1)  = null,
	@i_modo		smallint = null,
	@i_empresa  	tinyint  = null, 
        @i_banco        varchar(3)  = null,
	@i_transaccion 	varchar(10) = null, 
	@i_cuenta_ban 	cuenta = null,
        @i_asiento      smallint    = null,
        @i_area         smallint     = null,
        @i_oficina      smallint     = null,
        @i_cuenta       cuenta  = null,
        @i_debcred      char(1)  = null,
        @i_tipo_tran    char(1)  = null,
        @i_origen_dest  char(1)  = null

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint

select @w_today   = getdate()
select @w_sp_name = 'sp_perfil_conc'
select @w_existe  = 0

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_modo		= @i_modo,
		i_empresa  	= @i_empresa , 
                i_banco      = @i_banco,
                i_cuenta        = @i_cuenta,
		i_transaccion 	= @i_transaccion
	exec cobis..sp_end_debug
end
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6815 and @i_operacion = 'I') or
   (@t_trn <> 6816 and @i_operacion = 'D') or
   (@t_trn <> 6817 and @i_operacion = 'E') or
   (@t_trn <> 6818 and @i_operacion = 'U') or
   (@t_trn <> 6819 and @i_operacion = 'Q') or
   (@t_trn <> 6820 and @i_operacion = 'S')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'D' or @i_operacion = 'U'
begin
    if 
         @i_empresa is NULL or 
         @i_banco   is NULL or
         @i_transaccion is NULL  or
         @i_cuenta_ban  is NULL
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1 
    end
end
/* Chequea la existencia del perfil */
/************************************/

if exists (select * from cob_conta_tercero..ct_perfil_transaccion 
           where pt_empresa = @i_empresa and
           pt_banco = @i_banco and 
           pt_transaccion = @i_transaccion and
           pt_cuenta = @i_cuenta_ban)
   select @w_existe = 1
else
   select @w_existe = 0

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
        /* Ya existe registro en tabla temporal de perfiles */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601160

        return 1 
    end
    begin tran
         insert into cob_conta_tercero..ct_perfil_transaccion (
              pt_empresa,
              pt_banco,
              pt_cuenta,
              pt_transaccion)
         values (
              @i_empresa,
              @i_banco,
              @i_cuenta_ban,
              @i_transaccion)
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059
             return 1 
         end

    commit tran 
    return 0
end

/* Inserccion detalle del perfil*/
if @i_operacion = 'D'
begin
    --if @w_existe = 0
    --begin
    --/* No existe emcabezado */
      -- exec cobis..sp_cerror
      -- @t_debug = @t_debug,
      -- @t_file  = @t_file, 
      -- @t_from  = @w_sp_name,
      -- @i_num   = 601155
      -- return 1 
    --end

    begin tran
         insert into cob_conta_tercero..ct_det_perfil_transaccion (
              dp_empresa,
	      dp_banco,
              dp_cuenta,
              dp_transaccion,
              dp_asiento,
              dp_cuenta_cte,
              dp_oficina,
              dp_area,
              dp_debcred,
              dp_tipo_tran)
         values (
              @i_empresa,
              @i_banco,
              @i_cuenta_ban,
              @i_transaccion,
              @i_asiento,
              @i_cuenta,
              @i_oficina,
              @i_area,
              @i_debcred,
              @i_tipo_tran)

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059
	     delete cob_conta_tercero..ct_perfil_transaccion
	     where pt_empresa 	= @i_empresa and
		   pt_banco 	= @i_banco and
		   pt_cuenta 	= @i_cuenta_ban and
                   pt_transaccion = @i_transaccion
	     delete cob_conta_tercero..ct_det_perfil_transaccion
	     where dp_empresa 	= @i_empresa and
		   dp_banco 	= @i_banco and
		   dp_cuenta    = @i_cuenta_ban and
                   dp_transaccion = @i_transaccion
             return 1 
         end

    commit tran 
    return 0
end


if @i_operacion = 'U'
begin
    
    if not exists (select * from cob_conta_tercero..ct_perfil_transaccion 
           where pt_empresa = @i_empresa and
                 pt_banco = @i_banco and
                 pt_cuenta = @i_cuenta_ban and
                 pt_transaccion = @i_transaccion)
        /* Registro no existe en la tabla de perfiles */
    begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
   end
   begin tran
    	 delete cob_conta_tercero..ct_det_perfil_transaccion
	  where dp_empresa 	= @i_empresa and
		dp_banco 	= @i_banco and
		dp_cuenta    = @i_cuenta_ban and
                dp_transaccion = @i_transaccion

   commit tran 
   return 0
end


if @i_operacion = 'E'
begin
    
    if not exists (select * from cob_conta_tercero..ct_perfil_transaccion 
           where pt_empresa = @i_empresa and
                 pt_banco = @i_banco and
                 pt_cuenta = @i_cuenta_ban and
                 pt_transaccion = @i_transaccion)
        /* Registro no existe en la tabla de perfiles */
    begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
   end
   begin tran
         delete cob_conta_tercero..ct_perfil_transaccion
          where pt_empresa 	= @i_empresa and
		pt_banco 	= @i_banco and
		pt_cuenta 	= @i_cuenta_ban and
                pt_transaccion = @i_transaccion

	 delete cob_conta_tercero..ct_det_perfil_transaccion
	  where dp_empresa 	= @i_empresa and
		dp_banco 	= @i_banco and
		dp_cuenta    = @i_cuenta_ban and
                dp_transaccion = @i_transaccion

   commit tran 
   return 0
end


if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	   if @w_existe = 1
           begin
              --select @w_producto, @w_perfil, @w_descripcion
	      select  dp_asiento,
                      dp_oficina,
                      dp_area, 
                      dp_cuenta_cte, 
                      dp_debcred, 
                      dp_tipo_tran
              from cob_conta_tercero..ct_det_perfil_transaccion
	      where dp_empresa 	= @i_empresa
                and dp_banco = @i_banco
                and dp_cuenta   = @i_cuenta_ban
                and dp_transaccion = @i_transaccion
	      order by dp_asiento
	      if @@rowcount = 0
              begin
    		 /*Registro no existe */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601153
                 return 1 
              end
           end
    	   else begin
    		/*Registro no existe */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 601153
              return 1 
           end
	end
	else begin
              select  dp_asiento,
                      dp_oficina,
                      dp_area, 
                      dp_cuenta_cte, 
                      dp_debcred, 
                      dp_tipo_tran
              from cob_conta_tercero..ct_det_perfil_transaccion
	      where dp_empresa 	= @i_empresa
                and dp_banco = @i_banco
                and dp_cuenta   = @i_cuenta_ban
                and dp_transaccion = @i_transaccion
                and dp_asiento > @i_asiento
	      order by dp_asiento

	      if @@rowcount = 0 
	      begin
    		/*No existen mas registros*/
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
              end

	end
	return 0	
end

if @i_operacion = 'S'
begin
	--set rowcount 20
	if @i_modo = 0
	begin
	     select  'Banco  ' = pt_banco,
                     'Cuenta    ' = pt_cuenta,
                     'Transaccion ' = pt_transaccion 
              from cob_conta_tercero..ct_perfil_transaccion
	      where pt_empresa 	= @i_empresa
              --  and (pt_banco = @i_banco or @i_banco = "")
              order by pt_banco, pt_cuenta, pt_transaccion

	      if @@rowcount = 0
              begin
    		 /*Registro no existe */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601153
                 return 1 
              end
       	end
	else begin
              select 'Banco  ' = pt_banco,
                     'Cuenta    ' = pt_cuenta,
                     'Transaccion ' = pt_transaccion 
              from cob_conta_tercero..ct_perfil_transaccion
	      where pt_empresa 	= @i_empresa
                and pt_banco >= @i_banco
                and pt_cuenta >= @i_cuenta_ban
                and pt_transaccion > @i_transaccion
              order by pt_banco, pt_cuenta, pt_transaccion

	      if @@rowcount = 0 
	      begin
    		/*No existen mas registros*/
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
              end

	end
	return 0	
end

go
