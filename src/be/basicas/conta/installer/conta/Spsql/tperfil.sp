/************************************************************************/
/*	Archivo: 		tperfil.sp				*/
/*	Stored procedure: 	sp_tperfil                              */
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Narcisa Maldonado                   	*/
/*	Fecha de escritura:     24-julio-1995 				*/
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
/*	Insercion de cabecera de perfiles contables en la tabla temporal*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Jul/1995	 	        Emision Inicial			*/
/*	12/Jul/1996	L. Tandazo	Modificacion  	 		*/
/*	23/Jul/1996	S. de la Cruz	Correspondencia mensajes error	*/	
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tperfil')
    drop proc sp_tperfil 
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tperfil (
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
        @i_producto     tinyint  = null,
	@i_perfil 	varchar(20) = null, 
	@i_descripcion 	descripcion = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_fecha              datetime

select @w_today   = getdate()
select @w_sp_name = 'sp_tperfil'
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
                i_producto      = @i_producto,
                i_perfil        = @i_perfil,
		i_descripcion 	= @i_descripcion
	exec cobis..sp_end_debug
end
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6901 and @i_operacion = 'I')
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
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_empresa  is NULL or 
         @i_producto is NULL or
         @i_perfil   is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601078
        return 1 
    end
end
/* Chequea la existencia del perfil */
/************************************/

if exists (select * from cb_tperfil 
           where tp_empresa = @i_empresa and
           tp_producto = @i_producto and tp_perfil = @i_perfil)
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
        @i_num   = 601155
	delete cb_tperfil
	where tp_empresa 	= @i_empresa and
	      tp_producto 	= @i_producto and
	      tp_perfil 	= @i_perfil
	delete cb_tdet_perfil
	where td_empresa 	= @i_empresa and
	      td_producto 	= @i_producto and
	      td_perfil    = @i_perfil
        return 1 
    end
	if not exists (select *
			from cobis..cl_producto, cb_producto
			where pr_empresa = @i_empresa
			   and pr_producto = @i_producto
			   and pr_producto = pd_producto)
     	begin
       		/* Error Registro ya existe */
          	exec cobis..sp_cerror
          		@t_debug = @t_debug,
          		@t_file  = @t_file, 
          		@t_from  = @w_sp_name,
          		@i_num   = 601168
          		return 1 
     	end
    begin tran
         insert into cb_tperfil(
              tp_empresa,
              tp_producto,
              tp_perfil,
              tp_descripcion)
         values (
              @i_empresa,
              @i_producto,
              @i_perfil,
              @i_descripcion)
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

if @i_operacion = 'U'
begin
    if @w_existe = 1
    begin
        /* Ya existe registro en tabla temporal de perfiles */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601155
        return 1 
    end
    if not exists (select * from cb_perfil 
           where pe_empresa = @i_empresa and
           pe_producto = @i_producto and pe_perfil = @i_perfil)
        /* Registro no existe en la tabla de perfiles */
    begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601156
        return 1 
   end
begin tran
         insert into cb_tperfil(
              tp_empresa,
              tp_producto,
              tp_perfil,
              tp_descripcion)
         values (
              @i_empresa,
              @i_producto,
              @i_perfil,
              @i_descripcion)
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
go
