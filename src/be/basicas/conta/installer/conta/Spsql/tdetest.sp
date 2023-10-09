/************************************************************************/
/*	Archivo: 		tdetest.sp				*/
/*	Stored procedure: 	sp_tdetest				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     26-Enero-1995 				*/
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
/*	26/Ene/1995	G Jaramillo     Emision Inicial			*/
/*	06/Abril/1999	Juan C. G¢mez	Cambio en la tabla JCG10	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tdetest')
    drop proc sp_tdetest
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tdetest (
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
   @i_banco              varchar( 20)  = null,
   @i_fecha              datetime  = null,
   @i_detalle            smallint  = null,
   @i_operac             varchar( 20)  = null,
   @i_referencia         varchar( 35)  = null,
   @i_valor              money  = null,
   @i_debcred            char(  1)  = null,
   @i_fecha_tran         datetime  = null,
   @i_comprobante        int  = null,
   @i_asiento            smallint  = null,
   @i_cuenta		 cuenta = null	--JCG10
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_banco              varchar( 20),
   @w_fecha              datetime,
   @w_detalle            smallint,
   @w_operac             varchar( 20),
   @w_referencia         varchar( 35),
   @w_valor              money,
   @w_debcred            char(  1),
   @w_fecha_tran         datetime,
   @w_comprobante        int,
   @w_asiento            smallint,
   @w_cuenta		 varchar(20)		--JCG10

select @w_today = getdate()
select @w_sp_name = 'sp_tdetest'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6761 and @i_operacion = 'I')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
         @w_empresa = td_empresa,
         @w_banco = td_banco,
         @w_fecha = td_fecha,
         @w_detalle = td_detalle,
         @w_operac = td_operacion,
         @w_referencia = td_referencia,
         @w_valor = td_valor,
         @w_debcred = td_debcred,
         @w_fecha_tran = td_fecha_tran,
         @w_comprobante = td_comprobante,
         @w_asiento = td_asiento,
	 @w_cuenta = td_cuenta		--JCG10
    from cob_conta_tercero..ct_tdetest	--JCG10
    where 
         td_empresa = @i_empresa and
         td_banco = @i_banco and
         td_fecha = @i_fecha and
         td_detalle = @i_detalle and
	 td_cuenta = @i_cuenta		--JCG10

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_empresa is NULL or 
         @i_banco   is NULL or 
         @i_fecha   is NULL or 
         @i_detalle is NULL or
	 @i_cuenta is NULL	--JCG10
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
         insert into cob_conta_tercero..ct_tdetest(	--JCG10
              td_empresa,
              td_banco,
              td_fecha,
              td_detalle,
              td_operacion,
              td_referencia,
              td_valor,
              td_debcred,
              td_fecha_tran,
              td_comprobante,
              td_asiento,
	      td_cuenta)	--JCG10
         values (
              @i_empresa,
              @i_banco,
              @i_fecha,
              @i_detalle,
              @i_operac,
              @i_referencia,
              @i_valor,
              @i_debcred,
              @i_fecha_tran,
              @i_comprobante,
              @i_asiento,
	      @i_cuenta)	--JCG10

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
