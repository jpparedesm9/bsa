/************************************************************************/
/*	Archivo: 		testcta.sp				*/
/*	Stored procedure: 	sp_testcta				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     26-enero-1995 				*/
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
/*	   Insercion de cabecera de estado de cuenta en tabla temporal  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	26/Ene/1995	G Jaramillo     Emision Inicial			*/
/*	07/Mar/1999	Juan C. G¢mez	Cambio de tabla y nuevo 	*/
/*					par metro JCG10			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_testcta')
    drop proc sp_testcta
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_testcta (
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
   @i_saldo_ini          money  = null,
   @i_saldo_fin          money  = null,
   @i_cuenta	  	 char(20) = null	--JCG10
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
   @w_saldo_ini          money,
   @w_saldo_fin          money

select @w_today = getdate()
select @w_sp_name = 'sp_testcta'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6751 and @i_operacion = 'I')
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
         @i_empresa is NULL or 
         @i_banco is NULL or 
         @i_fecha is NULL or
	 @i_cuenta is NULL	--JCG10
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601010
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
        @i_num   = 601160
        return 1 
    end

    begin tran
         insert into cob_conta_tercero..ct_testcta(
              te_empresa,
              te_banco,

              te_fecha,
              te_saldo_ini,
              te_saldo_fin,
	      te_cuenta)	--JCG10
         values (
              @i_empresa,
              @i_banco,
              @i_fecha,
              @i_saldo_ini,
              @i_saldo_fin,
	      @i_cuenta)	--JCG10

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 601161
             return 1 
         end

    commit tran 
    return 0
end
go
