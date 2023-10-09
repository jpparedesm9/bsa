/************************************************************************/
/*  Archivo               : ayuda_tran_pfijo.sp                         */
/*  Stored procedure      : sp_ayuda_tran_pfijo                         */
/*  Base de datos         : cobis                                       */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : Miryam Davila                               */
/*  Fecha de documentacion: 07-Nov-94                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                          PROPOSITO                                   */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR              RAZON                               */
/*  07-Nov-94    R. Valencia        Creacion                            */
/*  25-Nov-94    J. Lam             Modificacion                        */
/*  14-Jun-2016  N. Silva           Porting DAVIVIENDA                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_ayuda_tran_pfijo')
   drop proc sp_ayuda_tran_pfijo
go

create proc sp_ayuda_tran_pfijo (
@s_ssn                  int             = null,
@s_user                 login           = null,
@s_term                 varchar(30)     = null,
@s_date                 datetime        = null,
@s_sesn                 int             = null,
@s_srv                  varchar(30)     = null,
@s_lsrv                 varchar(30)     = null,
@s_ofi                  smallint        = null,
@s_rol                  smallint        = null,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = null,
@t_from                 varchar(32)     = null,
@t_trn                  smallint,
@i_operacion            char(1),
@i_tipo_help            char(1)         = 'A',
@i_codigo               int             = 0)
with encryption
as
declare
@w_sp_name              varchar(32),
@w_error                int

select @w_sp_name = 'sp_ayuda_tran_pfijo'

if @i_operacion = 'H' and @t_trn <> 14810
begin
   select @w_error = 141091
   GOTO ERROR
end

if @i_tipo_help = 'A'
begin
   select top 20
          'TRN. '       = tn_trn_code,
          'DESCRIPCION' = tn_descripcion
     from cobis..cl_ttransaccion
    where tn_trn_code between 14000 and 14999 
      and tn_trn_code > @i_codigo 
    order by tn_trn_code

   return 0
end
else begin
     
   select substring(tn_descripcion,1,64)
     from cobis..cl_ttransaccion
    where tn_trn_code between 14000 and 14999 
      and tn_trn_code = @i_codigo
   
   if @@rowcount = 0
   begin
      select @w_error = 141018
      GOTO ERROR
   end
end
return 0

ERROR:
   exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = @w_error
   return @w_error
go
