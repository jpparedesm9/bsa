/************************************************************************/
/*  Archivo:            query_cambio_tasa.sp                            */
/*  Stored procedure:   sp_query_cambio_tasa                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*      Este programa verifica los cambios de tasas efetuados a cuentas */
/*  de ahorros que garantizan lineas.                                   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA             AUTOR                  RAZON                      */
/*  18/Abr/05       Luis Bernuil         Emision Inicial                */
/*  02/May/2016     Juan Tagle           Migración a CEN                */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_query_cambio_tasa')
        drop proc sp_query_cambio_tasa
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_query_cambio_tasa (
       @t_show_version  bit = 0,
       @i_srv           varchar(64),
       @i_filial        tinyint,
       @i_fecha_proceso smalldatetime
 )
as
declare @w_return       int,
    @w_sp_name      varchar(30),
    @w_cuenta       int,
    @w_cta_banco        char(16),
    @w_tasa_hoy     real,
    @w_tasa_ayer        real,
    @w_mensaje      varchar(132),
    @w_ngarantia        char(25),
    @w_nlinea_sob       varchar(24),
    @w_numcte           varchar(24)


select @w_sp_name = 'sp_query_cambio_tasa'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

declare cambio_tasa cursor
for select  hb_cuenta,
        hb_ngarantia,
        hb_nlinea_sob,
        hb_numcte
from cob_ahorros..ah_his_bloqueo
where hb_accion     = 'B'
  and hb_levantado  = 'NO'
  and hb_ngarantia  is not null
  --and hb_nlinea_sob   is not null
  --and hb_numcte   is not null

open cambio_tasa
fetch cambio_tasa into
    @w_cuenta,
    @w_ngarantia,
    @w_nlinea_sob,
    @w_numcte

if @@fetch_status = -1
begin

     close cambio_tasa
     deallocate cambio_tasa

    select @w_mensaje = mensaje
        from cobis..cl_errores
        where numero = 201157

        insert into cob_remesas..re_error_batch values
        ('0', @w_mensaje)

     return 1
end

if @@fetch_status = -2
begin
     close cambio_tasa
     deallocate cambio_tasa
     return 0
end

while @@fetch_status = 0
begin

     if @@fetch_status = -1
     begin
        close cambio_tasa
        deallocate cambio_tasa
        return 1
     end


     if exists (select 1
          from cob_ahorros..ah_cuenta
         where ah_cuenta = @w_cuenta
               and ah_tasa_ayer <> ah_tasa_hoy)
        begin

            select  @w_cta_banco = ah_cta_banco,
            @w_tasa_hoy  = ah_tasa_hoy,
            @w_tasa_ayer = ah_tasa_ayer
           from cob_ahorros..ah_cuenta
          where ah_cuenta = @w_cuenta
            and ah_tasa_ayer <> ah_tasa_hoy

        begin tran


        insert into cob_remesas..re_cambio_tasa
        values(@i_fecha_proceso, @w_cta_banco, @w_tasa_hoy, @w_tasa_ayer, @w_ngarantia, @w_nlinea_sob, @w_numcte)


        if @@error <> 0
           begin


            select @w_mensaje = mensaje
              from cobis..cl_errores
            where numero = 203080

            insert into cob_remesas..re_error_batch values
                (@w_cta_banco, @w_mensaje)

            rollback tran
            goto LEER
           end

        commit tran
    end

LEER:
        fetch cambio_tasa into
            @w_cuenta,
        @w_ngarantia,
        @w_nlinea_sob,
        @w_numcte
end

close cambio_tasa
deallocate cambio_tasa

return 0


go

