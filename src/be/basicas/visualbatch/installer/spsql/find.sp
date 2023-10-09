/************************************************************************/
/* Archivo:                find.sp                                      */
/* Stored procedure:       sp_find                                      */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Marzo-1994                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */ 
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento al catalogo de Cuentas de un tipo de plan           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    30-Mar-1994    R. Garces       Emision Inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_find')
   drop proc sp_find

go
create proc sp_find    (
   @s_ssn            int = null,
   @s_date           datetime = null,
   @s_user           login = null,
   @s_term           descripcion = null,
   @s_corr           char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi            smallint = null,
   @t_rty            char(1) = null,
   @t_trn            smallint = 601,
   @t_debug          char(1) = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @i_operacion      char(1),
   @i_fileName       varchar(255),
   @i_palabra        descripcion,
   @i_offset         int
)
as 
declare
   @w_sp_name        varchar(30),
   @w_today       datetime,
   @w_offset                    int

select @w_today = getdate()
select @w_sp_name = 'sp_find'

/************************************************/

if (@t_trn <> 8074 and @i_operacion = 'S')
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 601077
   return 1
end
/************************************************/

exec ADMIN...rp_find @i_fileName=@i_fileName, @i_palabra=@i_palabra,
   @i_offset=@i_offset, @o_offset=@w_offset out
select @w_offset
go
