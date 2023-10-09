/************************************************************************/
/*	Archivo: 		tdperfil.sp				*/
/*	Stored procedure: 	sp_tdperfil				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Narcisa Maldonado                     	*/
/*	Fecha de escritura:     24-Julio-1995 				*/
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
/*	   Insercion del detalle de un estado de cuenta en tabla tempora*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Jul/1995	N Maldonado     Emision Inicial			*/
/*	23/Jul/1996	S.de la Cruz	Correpondencia mensajes error	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tdperfil')
    drop proc sp_tdperfil
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tdperfil (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_empresa            tinyint  = null,
   @i_producto           tinyint  = null,
   @i_perfil             varchar(20)  = null,
   @i_asiento            smallint     = null,
   @i_area               varchar(10)  = null,
   @i_cuenta             varchar(40)  = null,
   @i_debcred            char(1)      = null,
--   @i_codval             smallint     = null,
   @i_codval             int     = null,
   @i_tipo_tran          char(1)      = 'N',
   @i_origen_dest        char(1)      = null,
   @i_constante          char(3)      = null,
   @i_fuente             char(1)      = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_banco              varchar(20),
   @w_fecha              datetime,
   @w_detalle            smallint,
   @w_opcion             tinyint,
   @w_referencia         varchar(35),
   @w_valor              money,
   @w_debcred            char(1),
   @w_fecha_tran         datetime,
   @w_comprobante        int,
   @w_asiento            smallint

select @w_today = getdate()
select @w_sp_name = 'sp_tdperfil'

/**************/
/*   Debug    */
/**************/
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
		i_asiento 	= @i_asiento,
		i_cuenta 	= @i_cuenta,
		i_debcred 	= @i_debcred,
		i_codval 	= @i_codval,
		i_tipo_tran 	= @i_tipo_tran,
		i_origen_dest 	= @i_origen_dest,
                i_constante     = @i_constante,
                i_fuente        = @i_fuente
	exec cobis..sp_end_debug
end
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6902 and @i_operacion = 'I')

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
if @i_operacion = 'I' 
begin
    if 
         @i_empresa 	is NULL or 
         @i_producto 	is NULL or 
         @i_perfil 	is NULL or 
         @i_asiento 	is NULL 
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


/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601155
        return 1 
    end

    begin tran
         insert into cb_tdet_perfil(
              td_empresa,
	      td_producto,
              td_perfil,
              td_asiento,
              td_area,
              td_cuenta,
              td_debcred,
              td_codval,
              td_tipo_tran,
              td_origen_dest,
              td_constante,
              td_fuente)
         values (
              @i_empresa,
              @i_producto,
              @i_perfil,
              @i_asiento,
              @i_area,
              @i_cuenta,
              @i_debcred,
              @i_codval,
              @i_tipo_tran,
              @i_origen_dest,
              @i_constante,
              @i_fuente)

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603059
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

    commit tran 
    return 0
end
go
