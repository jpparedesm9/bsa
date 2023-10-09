

/**********************************************************************/
/*  Archivo:            b2c_geolocoper.sp                             */
/*  Stored procedure:   sp_geolocaliza_operacion                      */
/*  Base de datos:      cob_cartera                                   */
/*  Producto:           CARTERA                                       */
/*  Disenado por:       Walther Toledo                                */
/*  Fecha de escritura: 01-Sep-2021                                   */
/**********************************************************************/
/*                        IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  'COBISCORP SA',representantes exclusivos para el Ecuador de la    */
/*  AT&T                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como        */
/*  cualquier autorizacion o agregado hecho por alguno de sus         */
/*  usuario sin el debido consentimiento por escrito de la            */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante          */
/**********************************************************************/
/*                          PROPOSITO                                 */
/* - Almacenar los datos de geolocalización por cada operación        */
/* que realice el cliente a través de la App Tuiio Móvil.             */
/**********************************************************************/
/*                    MODIFICACIONES                                  */
/*  FECHA          AUTOR            RAZON                             */
/*  01-Sep-2021    W.Toledo      158406 Geolocalización B2C           */
/**********************************************************************/
use cob_bvirtual
go
if exists (select 1 from sysobjects where name = 'sp_geolocaliza_operacion')
   drop proc sp_geolocaliza_operacion
go
CREATE proc sp_geolocaliza_operacion(
   @s_ssn         int           = null,
   @s_date        smalldatetime = null,
   @s_user        login         = null,
   @s_term        descripcion   = null,
   @s_ofi         smallint      = null,
   @t_debug       char(1)       = 'N',
   @t_file         varchar(14)  = null,
   @t_trn         int           = null,
   -- -----
   @i_operacion   char(1)       = 'I',
   @i_login       login         = null,
   @i_fecha       datetime    = null,
   @i_tipo_tran   varchar(75)   = null,
   @i_tipo_serv   catalogo      = null,
   @i_aplicativo  varchar(100)  = null,
   @i_longitud    varchar(20)  = null,
   @i_latitud     varchar(20)  = null
)
as
declare
   @w_sp_name   varchar(32),
   @w_return    int,
   @w_error     int,
   @w_msg       varchar(100),
   @w_tramite   varchar(10),
   @w_status    varchar(10)
 
select @w_sp_name = 'sp_geolocaliza_operacion'

select @w_status = 'Aceptada'
 
-- ----------------------------------------
 
if @i_operacion = 'I'
begin
    if @i_fecha is null
	begin
		select @i_fecha = fp_fecha from cobis..ba_fecha_proceso
    end
    if @i_tipo_tran is null or @i_tipo_tran = ''
    begin
        select @w_error = 1802147,
               @w_msg = 'Campo [Servicio Rest] es Obligatorio'
        goto ERROR
    end
    if @i_tipo_serv is null or @i_tipo_serv = ''
    begin
        select @w_error = 1802147,
               @w_msg = 'Campo [Tipo de Servicio] es Obligatorio'
        goto ERROR
    end
    if @i_aplicativo is null or @i_aplicativo = ''
    begin
        select @w_error = 1802147,
               @w_msg = 'Campo [Aplicativo] es Obligatorio'
        goto ERROR
    end
    if @i_longitud is null or @i_latitud is null
    begin
        select @w_error = 1802147,
               @w_msg = 'Campos [Latitud] y [Longitud] son Obligatorios'
        goto ERROR
    end
    
    if(@i_tipo_tran='SOLCO') 
    begin
        
        select top 1 @w_tramite = tr_tramite 
        from cob_credito..cr_tramite 
        where tr_usuario = 'onboarding'
        and tr_cliente = @i_login 
        order by tr_tramite desc

        if exists (Select 1 from cob_cartera..ca_onboard_seguro_ext where se_tramite = @w_tramite) 
        begin
            insert into bv_geolocaliza_operacion(
                go_login,        go_fecha,  go_tipo_tran,go_ente,    go_tipo_serv,
                go_aplicativo,    go_longitud,go_latitud,        go_ssn ,go_estado ,go_fecha_proceso )
            values(
                @i_login,        getdate(),   @i_tipo_tran,@i_login  ,   @i_tipo_serv,
                @i_aplicativo,    @i_longitud,@i_latitud,        @s_ssn ,@w_status ,@i_fecha
            )
            if @@error != 0 begin
                select @w_error = 1802147
                goto ERROR
            end
                return 0
        end
    end
    else
    begin
        insert into bv_geolocaliza_operacion(
            go_login,        go_fecha,  go_tipo_tran,go_ente,    go_tipo_serv,
            go_aplicativo,    go_longitud,go_latitud,        go_ssn ,go_estado , go_fecha_proceso )
        values(
            @i_login,        getdate(),   @i_tipo_tran,@i_login  ,   @i_tipo_serv,
            @i_aplicativo,    @i_longitud,@i_latitud,        @s_ssn, @w_status , @i_fecha
        )
        if @@error != 0 begin
            select @w_error = 1802147
            goto ERROR
        end
        return 0
    end
end
 

return 0
ERROR:
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
        @i_msg    = @w_msg
   return @w_error
GO
