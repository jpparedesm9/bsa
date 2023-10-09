/************************************************************************/
/*   Archivo:                   cu_errolog.sp                           */
/*   Stored procedure:          sp_errorlog                             */
/*   Base de datos:             cob_custodia                            */
/*   Producto:                  Custodia                                */
/*   Disenado por:              Monica Vidal                            */
/*   Fecha de escritura:        Marzo-2009                              */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "COBISCORP".                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP o su representante.             */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Ingresar datos en el log de errores de custodia en batch.          */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_errorlog')
    drop proc sp_errorlog
go
create proc sp_errorlog
@i_fecha_proc         datetime,
@i_usuario            login        = '',
@i_tran               int          = 19000,
@i_garantia           varchar(64)  = '',
@i_descripcion        varchar(255) = ''

as

insert into cu_errorlog(
er_fecha_proc,   er_usuario,      er_tran,
er_garantia,     er_descripcion  )
values(
@i_fecha_proc,   @i_usuario,      @i_tran,
@i_garantia,     @i_descripcion)

if @@error <> 0 begin
   print 'OCURRIO UN ERROR INSERTANDO EL LOG'
   return 1
end

return 0



go

