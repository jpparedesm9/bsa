
use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_isba_reversar_lotes')
  drop proc sp_isba_reversar_lotes
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc sp_isba_reversar_lotes
   @s_ssn             int             = NULL,
   @s_date            datetime        = NULL,
   @s_term            varchar(30)     = NULL,
   @s_sesn            int             = NULL,
   @s_srv             varchar(30)     = NULL,
   @s_lsrv            varchar(30)     = NULL,
   @s_user            varchar(30)     = NULL,
   @s_ofi             smallint        = NULL,
   @s_rol             smallint        = NULL,
   @t_debug           char(1)         = NULL,
   @t_file            varchar(14)     = NULL,
   @t_trn             smallint        = NULL,
   @i_codigo_alterno  int             = NULL,
   @i_origen_ing      char(1)         = NULL,
   @i_secuencial      int             = NULL,
   @i_modulo          varchar         = NULL,
   @i_moneda          tinyint         = NULL,
   @i_func_aut        login           = NULL,
   @i_producto        tinyint         = NULL,     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @i_instrumento     smallint        = NULL,     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @i_subtipo_ins     int             = NULL,     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @i_causal_anul     descripcion     = NULL,     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @i_llamada_ext     char(1)         = NULL,     -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
   @i_grupo1          varchar(30)     = NULL      -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
   
as

declare 
   @w_error         int

   
exec @w_error = cob_sbancarios..sp_actualizar_lotes
   @s_ssn          = @s_ssn,
   @s_date         = @s_date,
   @s_user         = @s_user,
   @s_term         = @s_term,
   @s_ofi          = @s_ofi,
   @s_lsrv         = @s_lsrv,
   @s_srv          = @s_srv,   
   @t_trn          = 29301,
   @i_producto     = @i_producto,
   @i_instrumento  = @i_instrumento,
   @i_causa_anul   = @i_causal_anul,
   @i_subtipo      = @i_subtipo_ins,
   @i_grupo1       = @i_grupo1,
   @i_llamada_ext  = @i_llamada_ext

if @w_error <> 0 
   return @w_error 

return 0


GO

