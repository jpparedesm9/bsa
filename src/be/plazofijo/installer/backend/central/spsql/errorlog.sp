/************************************************************************/
/*      Archivo:                errorlog.sp                             */
/*      Stored procedure:       sp_errorlog                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las inserciones        */
/*      de errores generados por los procesos batch                     */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA          AUTOR              RAZON                         */
/*      24-Oct-94      Juan Lam           Creacion                      */
/*      14-Abr-2005    N. Silva           Indentacion/Nuevos campos     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_errorlog' and type = 'P')
   drop proc sp_errorlog
go
create proc sp_errorlog(
@s_date                 datetime     =  null,
@i_fecha                datetime     =  null,
@i_error                int,
@i_usuario              login,
@i_tran                 int,
@i_cuenta               cuenta       =  null,
@i_operacion            cuenta       =  null,
@i_descripcion          mensaje      =  null,
@i_cta_pagrec           cuenta       =  null)
with encryption
as
declare
@w_sev                  int

select @w_sev = severidad
from   cobis..cl_errores
where  numero = @i_error

insert pf_errorlog(
er_fecha_proc, er_error, er_usuario, er_tran, er_cuenta, er_descripcion, er_cta_pagrec)
values(
@i_fecha     , @i_error, @i_usuario, @i_tran, @i_cuenta, @i_descripcion, @i_cta_pagrec)
return 0
go
