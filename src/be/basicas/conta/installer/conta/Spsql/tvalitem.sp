/************************************************************************/
/*	Archivo: 		tvalitem.sp				*/
/*	Stored procedure: 	sp_tvalitem				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Insercion en tabla temporal de datos para conciliacion       */
/*	   bancaria							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	01/feb/1995	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tvalitem')
    drop proc sp_tvalitem
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tvalitem (
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
   @i_opcion             tinyint  = null,
   @i_debcred            char(  1)  = null,
   @i_item               tinyint  = null,
   @i_fecha_tran         datetime  = null,
   @i_comprobante        int  = null,
   @i_asiento            smallint  = null,
   @i_valor              descripcion  = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_opcion             tinyint,
   @w_debcred            char(  1),
   @w_item               tinyint,
   @w_fecha_tran         datetime,
   @w_comprobante        int,
   @w_asiento            smallint,
   @w_valor              descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_tvalitem'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6811 and @i_operacion = 'I')
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
         @w_empresa = ti_empresa,
         @w_opcion = ti_opcion,
         @w_debcred = ti_debcred,
         @w_item = ti_item,
         @w_fecha_tran = ti_fecha_tran,
         @w_comprobante = ti_comprobante,
         @w_asiento = ti_asiento,
         @w_valor = ti_valor
    from cob_conta..cb_tval_item
    where 
         ti_empresa = @i_empresa and
         ti_opcion = @i_opcion and
         ti_debcred = @i_debcred and
         ti_item = @i_item and
         ti_fecha_tran = @i_fecha_tran and
         ti_comprobante = @i_comprobante and
         ti_asiento = @i_asiento

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' 
begin
    if @i_empresa is NULL or 
       @i_opcion  is NULL or 
       @i_debcred is NULL or 
       @i_item is NULL or 
       @i_fecha_tran  is NULL or 
       @i_comprobante is NULL or 
       @i_asiento is NULL 
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
         insert into cb_tval_item(
              ti_empresa,
              ti_opcion,
              ti_debcred,
              ti_item,
              ti_fecha_tran,
              ti_comprobante,
              ti_asiento,
              ti_valor)
         values (
              @i_empresa,
              @i_opcion,
              @i_debcred,
              @i_item,
              @i_fecha_tran,
              @i_comprobante,
              @i_asiento,
              @i_valor)

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
