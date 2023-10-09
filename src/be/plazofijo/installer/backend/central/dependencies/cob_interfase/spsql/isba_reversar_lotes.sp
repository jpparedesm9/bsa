/************************************************************************/
/*  Archivo:              isba_reversar_lotes.sp                        */
/*  Stored procedure:     sp_isba_reversar_lotes                        */
/*  Base de datos:        cob_interfase                                 */
/*  Producto:             PFIJO                                         */
/*  Disenado por:         Byron Ron                                     */
/*  Fecha de escritura:   15-Jul-2009                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                 PROPOSITO                                            */
/*  Sp interfase.                                                       */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  15-JUL-2009     B. RON          Emision Inicial                     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_isba_reversar_lotes') is not null
   drop procedure sp_isba_reversar_lotes
go

create proc sp_isba_reversar_lotes
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
with encryption
as
declare 
@w_error           int
   
exec @w_error   = cob_sbancarios..sp_actualizar_lotes
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
go
