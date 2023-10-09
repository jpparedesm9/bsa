use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_propietarios_ctahorro.sp                     */
/*  Stored procedure:   sp_tr_propietarios_ctahorro                     */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*  Fecha de escritura: 16-Dic-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de ingreso y eliminacion       */
/*  de propietarios de una cuenta de ahorros.                           */
/*  206 = Insercion de un nuevo cliente duenio de una ctahorro          */
/*  207 = Eliminacion de un cliente duenio de una ctahorro              */
/*  208 = Consulta del detalle de producto de una ctahorro              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA      AUTOR           RAZON                                */
/*  16/Dic/1993    P Mena          Emision inicial                      */
/*  02/May/2016    Walther Toledo  Migración a CEN                      */
/*  30/Jun/2016    E. Moran        Envio del Parametro @s_lsrv          */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_propietarios_ctahorro')
  drop proc sp_tr_propietarios_ctahorro
go

create proc sp_tr_propietarios_ctahorro
(
    @s_ssn          int,
    @s_ssn_branch   int=null,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         varchar(30) = null,
    @s_sesn         int         = null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint,           -- Localidad origen transaccion
    @s_rol          smallint    = 1,
    @s_org_err      char(1)     = null, -- Origen de ERROR: [A], [S]
    @s_error        int         = null,
    @s_sev          tinyint     = null,
    @s_msg          mensaje     = null,
    @s_org          char(1),
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1)     = 'N',
    @t_trn          smallint,
    @t_show_version bit         = 0,
    @i_cta          cuenta,
    @i_mon          tinyint,
    @i_cli          int         = null,
    @i_dprod        int         = null,
    @i_rolcli       char(1)     = null,
    @i_cedruc       varchar(30) = null,
    @i_turno        smallint    = null,
    @o_det_prod     int         = null out
)
as

declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_rpc         descripcion,
    @w_filial      tinyint,
    @w_oficina     smallint,
    @w_producto    tinyint,
    @w_srv_rem     descripcion,
    @w_srv_local   descripcion,
    @w_tipo        char(1),
    @w_oficina_cta smallint

    -- Captura nombre de Stored Procedure
    select @w_sp_name = 'sp_tr_propietarios_ctahorro'

    ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
        return 0
    end

    select @s_ssn_branch = isnull(@s_ssn_branch, @s_ssn)

    if @i_turno is null
        select @i_turno = @s_rol

    -- Modo de debug

    if @t_debug = 'S'
    begin
        exec cobis..sp_begin_debug
             @t_file = @t_file
        select '/**  Stored Procedure  **/ ' = @w_sp_name,
                s_ssn = @s_ssn,
                s_srv = @s_srv,
                s_lsrv = @s_lsrv,
                s_user = @s_user,
                s_sesn = @s_sesn,
                s_term = @s_term,
                s_date = @s_date,
                s_ofi = @s_ofi,
                s_rol = @s_rol,
                s_org_err = @s_org_err,
                s_error = @s_error,
                s_sev = @s_sev,
                s_msg = @s_msg,
                s_ori = @s_org,
                t_from = @t_from,
                t_file = @t_file,
                t_rty = @t_rty,
                t_trn = @t_trn,
                i_cta = @i_cta,
                i_mon = @i_mon,
                i_cli = @i_cli,
                i_dprod = @i_dprod,
                i_rolcli = @i_rolcli,
                i_cedruc = @i_cedruc
        exec cobis..sp_end_debug
    end

    -- Chequeo de errores generados remotamente
    if @s_org_err is not null -- Error del Sistema
    begin
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @s_error,
             @i_sev   = @s_sev,
             @i_msg   = @s_msg
        return 1
    end

    -- Captura de parametros de la oficina
    exec @w_return = cobis..sp_parametros
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @s_lsrv         = @s_lsrv,
         @i_nom_producto = 'CUENTA%AHORROS',
         @o_oficina      = @w_oficina out,
         @o_producto     = @w_producto out

    if @w_return <> 0
        return @w_return

    -- Determinacion de condicion de local o remoto
    exec @w_return = cob_ahorros..sp_cta_origen
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_cta       = @i_cta,
         @i_producto  = @w_producto,
         @i_mon       = @i_mon,
         @i_oficina   = @w_oficina,
         @o_tipo      = @w_tipo out,
         @o_srv_local = @w_srv_local out,
         @o_srv_rem   = @w_srv_rem out

    if @w_return <> 0
        return @w_return

    if @t_debug = 'S'
    begin
        exec cobis..sp_begin_debug
             @t_file = @t_file
        select origen = @s_org,
               tipo = @w_tipo,
               srv_loc = @w_srv_local,
               srv_rem = @w_srv_rem
        exec cobis..sp_end_debug
    end

    select @w_srv_local = @s_lsrv

    select @w_rpc = 'sp_propietarios_ctahorro'
    
    if @w_tipo = 'L'
        select @w_rpc = 'cob_ahorros..' + @w_rpc
    else
        select @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

    begin tran
        if @w_tipo = 'L'
            exec @w_return      = @w_rpc
                 @s_ssn         = @s_ssn,
                 @s_ssn_branch  = @s_ssn_branch,
                 @s_date        = @s_date,
                 @s_sesn        = @s_sesn,
                 @s_org         = @s_org,
                 @s_srv         = @s_srv,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_ofi         = @s_ofi,
                 @s_rol         = @s_rol,
                 @s_org_err     = @s_org_err,
                 @s_error       = @s_error,
                 @s_sev         = @s_sev,
                 @s_lsrv        = @s_lsrv,
                 @s_msg         = @s_msg,
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @t_from,
                 @t_rty         = @t_rty,
                 @t_trn         = @t_trn,
                 @i_cta         = @i_cta,
                 @i_mon         = @i_mon,
                 @i_cli         = @i_cli,
                 @i_dprod       = @i_dprod,
                 @i_rolcli      = @i_rolcli,
                 @i_cedruc      = @i_cedruc,
                 @i_turno       = @i_turno,
                 @o_det_prod    = @o_det_prod out,
                 @o_oficina_cta = @w_oficina_cta out
        else
            exec @w_return      = @w_rpc
                 @s_ssn_branch  = @s_ssn_branch,
                 @s_srv         = @s_srv,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_ofi         = @s_ofi,
                 @s_rol         = @s_rol,
                 @s_org_err     = @s_org_err,
                 @s_error       = @s_error,
                 @s_sev         = @s_sev,
                 @s_lsrv        = @s_lsrv,
                 @s_msg         = @s_msg,
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @t_from,
                 @t_rty         = @t_rty,
                 @t_trn         = @t_trn,
                 @i_cta         = @i_cta,
                 @i_mon         = @i_mon,
                 @i_cli         = @i_cli,
                 @i_dprod       = @i_dprod,
                 @i_rolcli      = @i_rolcli,
                 @i_cedruc      = @i_cedruc,
                 @i_turno       = @i_turno,
                 @o_det_prod    = @o_det_prod out,
                 @o_oficina_cta = @w_oficina_cta out
        
        if @w_return <> 0
        begin
            rollback tran
            return @w_return
        end

        if @w_tipo = 'R'
        begin
            -- Grabar transaccion de servicio local
            if @t_trn = 206
            begin
                -- Creacion de transaccion de servicio
                insert into cob_ahorros..ah_tscliente_ctahorro(secuencial, ssn_branch,     tipo_transaccion, tsfecha,      clase,
                                                               usuario,    terminal,       oficina,          reentry,      origen,
                                                               cta_banco,  moneda,         cliente,          det_producto, rol_cliente,
                                                               cedula_ruc, oficina_cta,    turno)
                                                        values(@s_ssn,     @s_ssn_branch,  @t_trn,           @s_date,      'N',
                                                               @s_user,    @s_term,        @s_ofi,           @t_rty,       @s_org,
                                                               @i_cta,     @i_mon,         @i_cli,           @i_dprod,     @i_rolcli,
                                                               @i_cedruc,  @w_oficina_cta, @i_turno)
                if @@error <> 0
                begin
                    -- Error en creacion de transaccion de servicio
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 203005
                    return 1
                end
            end
            else
                if @t_trn = 207
                begin
                    insert into cob_ahorros..ah_tscliente_ctahorro(secuencial, ssn_branch,     tipo_transaccion, tsfecha,      clase,
                                                                   usuario,    terminal,       oficina,          reentry,      origen,
                                                                   cta_banco,  moneda,         cliente,          det_producto, rol_cliente,
                                                                   cedula_ruc, oficina_cta,    turno)
                                                            values(@s_ssn,     @s_ssn_branch,  @t_trn,           @s_date,      'B',
                                                                   @s_user,    @s_term,        @s_ofi,           @t_rty,       @s_org,
                                                                   @i_cta,     @i_mon,         @i_cli,           @i_dprod,     @i_rolcli,
                                                                   @i_cedruc,  @w_oficina_cta, @i_turno)
                    if @@error <> 0
                    begin
                        -- Error en creacion de transaccion de servicio
                        exec cobis..sp_cerror
                             @t_debug = @t_debug,
                             @t_file  = @t_file,
                             @t_from  = @w_sp_name,
                             @i_num   = 203005
                        return 1
                    end
                end
        end
    commit tran

    return 0

go
