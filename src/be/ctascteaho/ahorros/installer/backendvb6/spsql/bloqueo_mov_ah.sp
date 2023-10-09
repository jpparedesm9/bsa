/************************************************************************/
/*      Archivo:                ahtblqmv.sp                             */
/*      Stored procedure:       sp_bloqueo_mov_ah                       */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     19-Feb-1993                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de bloqueo de movim. y     */
/*      levantamiento de bloqueos de movimientos.                       */
/*      211 = Bloqueos a la cuenta                                      */
/*      212 = Levantamiento de bloqueos                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA           AUTOR           RAZON                             */
/*    19/Feb/1993     P Mena          Emision inicial                   */
/*    03/Dic/1994     J. Bucheli      Personalizacion para Banco de     */
/*                                      la Produccion                   */
/*    06/Jul/1995     A. Villarreal   Personalizacion B. de Prestamos   */
/*    16/Set/1998     G. George  Aumento del parametro @i_observacion   */
/*    09/Nov/2005     M. Gaona        Indicador para workflow           */
/*    15/jUN/2006     P. COELLO       PERMITIR BLOQUEAR CUENTAS INACTIVAS*/
/*    18/Ene/2010     O. Usina        Embargos Cta. Ahorros             */
/*    02/May/2016     J. Calderon      Migración a CEN                  */
/************************************************************************/

use cob_ahorros
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_bloqueo_mov_ah')
  drop proc sp_bloqueo_mov_ah
go

create proc sp_bloqueo_mov_ah
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_tbloq        char(3) = null,
  @i_aut          descripcion,
  @i_causa        char(3),
  @i_solicit      descripcion,
  @o_oficina_cta  smallint out,
  @i_observacion  varchar(120) = null,
  @i_turno        smallint = null,
  @i_ind_wflow    char(1) = null,
  @i_alt          int = 0,
  @i_cod_pais     varchar(10) = null,
  @o_secuencial   int = null out,
  @o_prod_banc    smallint = null out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_est              char(1),
    @w_filial           tinyint,
    @w_num_bloqueos     smallint,
    @w_secuencial       int,
    @w_sec              int,
    @w_saldo_contable   money,
    @w_saldo_para_girar money,
    @w_t1               char(1),
    @w_t2               char(1),
    @w_t3               char(1),
    @w_oficina_cta      smallint,
    @w_prod_banc        smallint,
    @w_tipocta_super    char(1),
    @w_observacion      varchar(120),
    @w_debug            char(1)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_bloqueo_mov_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  select
    @w_debug = 'N'

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
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
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_tbloq = @i_tbloq,
      i_aut = @i_aut,
      i_solicit = @i_solicit,
      i_observa = @i_observacion
    exec cobis..sp_end_debug
  end

  if @t_trn not in (211, 212)
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @w_oficina_cta = ah_oficina,
    @w_prod_banc = ah_prod_banc,
    @w_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  if @@rowcount != 1
  begin
    /* No existe cuenta de ahorros */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  select
    @o_oficina_cta = @w_oficina_cta

  /* Validaciones */
  if @i_cod_pais = 'CO'
     and @i_causa != 3
    if @w_est != 'A'
    begin
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251002
      return 251002
    end
    else if @w_est != 'A'
       and @w_est != 'I'
    begin
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251057
      return 1
    end

  /* Transaccion de bloqueos a la cuenta */

  if @t_trn = 211
  begin
  /* Verificacion de que el tipo de bloqueo ingresado no se encuentre */
    /* vigente */

    if exists (select
                 cb_tipo_bloqueo
               from   cob_ahorros..ah_ctabloqueada
               where  cb_cuenta       = @w_cuenta
                  and cb_tipo_bloqueo = '3'
                  and cb_estado       = 'V')
    begin
      if @i_tbloq = '3'
      begin
        /* Tipo de bloqueo no ha sido levantado previamente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201054
        return 201054
      end
      select
        @w_t3 = 'S'
    end
    else
      select
        @w_t3 = 'N'

    if exists (select
                 cb_tipo_bloqueo
               from   cob_ahorros..ah_ctabloqueada
               where  cb_cuenta       = @w_cuenta
                  and cb_tipo_bloqueo = '2'
                  and cb_estado       = 'V')
    begin
      if @i_tbloq = '2'
      begin
        /* si es llamado desde workflow solo devuelvo el mensaje */
        if @i_ind_wflow = 'W'
        begin
          return 201054
        end

        /* Tipo de bloqueo no ha sido levantado previamente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201054
        return 201054
      end
      select
        @w_t2 = 'S'
    end
    else
      select
        @w_t2 = 'N'

    if exists (select
                 cb_tipo_bloqueo
               from   cob_ahorros..ah_ctabloqueada
               where  cb_cuenta       = @w_cuenta
                  and cb_tipo_bloqueo = '1'
                  and cb_estado       = 'V')
    begin
      if @i_tbloq = '1'
      begin
        /* Tipo de bloqueo no ha sido levantado previamente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201054
        return 201054
      end
      select
        @w_t1 = 'S'
    end
    else
      select
        @w_t1 = 'N'

    if @w_t3 = 'S'
    begin
      /* Cuenta esta bloqueada contra deposito y retiro */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201085
      return 1
    end

    if @w_t1 = 'S'
       and @w_t2 = 'S'
    begin
      /* Cuenta esta bloqueada contra deposito y retiro */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201085
      return 1
    end

    /* Validacion no crear bloqueos igual oficio creacion y causa*/
    if exists (select
                 cb_tipo_bloqueo
               from   cob_ahorros..ah_ctabloqueada
               where  cb_cuenta       = @w_cuenta
                  and (cb_tipo_bloqueo = '1'
                        or cb_tipo_bloqueo = '2')
                  and cb_estado       = 'V')
      if @@rowcount != 1
      begin
        /*REGISTRO YA EXISTE*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 2600014
        return 2600014
      end

    /* Generacion del secuencial del bloqueo */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_ctabloqueada',
      @o_siguiente = @w_sec out

    if @w_return != 0
      return @w_return

    select
      @w_num_bloqueos = ah_bloqueos + 1
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta

    /* Actualizacion de las tablas: ah_ctabloqueada y ah_cuenta */

    begin tran

    select
      @o_secuencial = @w_sec

    insert into ah_ctabloqueada
                (cb_cuenta,cb_secuencial,cb_tipo_bloqueo,cb_fecha,cb_hora,
                 cb_autorizante,cb_solicitante,cb_estado,cb_oficina,cb_causa,
                 cb_observacion)
    values      (@w_cuenta,@w_sec,@i_tbloq,@s_date,getdate(),
                 @i_aut,@i_solicit,'V',@s_ofi,@i_causa,
                 @i_observacion)

    /* cb_oficio_crea,  cb_demanda,  cb_oficio_levanta,  cb_fecha_vencimiento
       null,            @i_demanda,  @i_oficio_l,        @w_fecha_ven        */

    if @@error != 0
    begin
      /* Error en creacion de registro en ah_ctabloqueada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203009
      return 1
    end

    update cob_ahorros..ah_cuenta
    set    ah_bloqueos = @w_num_bloqueos
    where  ah_cuenta = @w_cuenta

    if @@rowcount != 1
    begin
      /* Error en actualizacion de registro en ah_cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 1
    end

    /* Creacion de transaccion de servicio */
    insert into cob_ahorros..ah_tsbloqueo
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,oficina,reentry,origen,cta_banco,
                 tipo_bloqueo,fecha,moneda,autorizante,estado,
                 causa,ctacte,hora,solicitante,oficina_cta,
                 observacion,turno,prod_banc,tipocta_super,alterno)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                 @i_tbloq,@s_date,@i_mon,@i_aut,'V',
                 @i_causa,@w_cuenta,getdate(),@i_solicit,@w_oficina_cta,
                 @i_observacion,@i_turno,@w_prod_banc,@w_tipocta_super,@i_alt)

    if @@error != 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    end
    commit tran
    select
      @o_prod_banc = @w_prod_banc
    return 0
  end

  /* Transaccion de levantamiento de bloqueos a la cuenta */

  if @t_trn = 212
  begin
    if @w_debug = 'S'
    begin
      print 'LEVANTAMIENTO BLQ CUENTA ' + @i_cta + ' @i_tbloq ' + @i_tbloq +
            ' @w_secuencial '
            + cast(@w_secuencial as varchar)
      print '@w_cuenta ' + cast(@w_cuenta as varchar) + ' @i_observacion ' +
            @i_observacion
    end

    select
      @w_num_bloqueos = ah_bloqueos - 1
    from   cob_ahorros..ah_cuenta
    where  ah_cuenta = @w_cuenta

    /* Verificacion de que la cuenta se encuentre efectivamente bloqueada */

    select
      @w_secuencial = cb_secuencial,
      @w_observacion = cb_observacion
    from   cob_ahorros..ah_ctabloqueada
    where  cb_cuenta       = @w_cuenta
       and cb_tipo_bloqueo = @i_tbloq
       and cb_estado       = 'V'

    if @@rowcount = 0
    begin
      /* CUENTA NO BLOQUEADA CONTRA EL TIPO DE BLOQUEO INGRESADO */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 252079
      return 252079
    end

    if upper(@w_observacion) = 'EMBARGOS'
       and charindex ('EMBARGO',
                      upper(isnull(@i_observacion,
                                   ''))) = 0
    begin
      /* CUENTA BLOQUEADA POR EMBARGOS, NO PUEDE REALIZARSE LEVANTAMIENTO ADMINISTRATIVO */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 252078
      return 252078
    end

    /* Actualizacion de las tablas: ah_ctabloqueada */

    begin tran

    update cob_ahorros..ah_ctabloqueada
    set    cb_estado = 'C'
    where  cb_cuenta     = @w_cuenta
       and cb_secuencial = @w_secuencial

    if @@rowcount != 1
    begin
      /* Error en actualizacion de registro en ah_ctabloqueada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205007
      return 1
    end

    /* Actualizacion del campo de numero de bloqueos en ah_cuenta */

    update cob_ahorros..ah_cuenta
    set    ah_bloqueos = @w_num_bloqueos
    where  ah_cuenta = @w_cuenta

    if @@rowcount != 1
    begin
      /* Error en actualizacion de registro en ah_cuenta */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 1
    end

    /* Generacion del registro de levantamiento */

    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'ah_ctabloqueada',
      @o_siguiente = @w_sec out
    if @w_return != 0
      return @w_return

    select
      @o_secuencial = @w_sec

    insert into ah_ctabloqueada
                (cb_cuenta,cb_secuencial,cb_tipo_bloqueo,cb_fecha,cb_hora,
                 cb_autorizante,cb_solicitante,cb_estado,cb_oficina,cb_causa,
                 cb_sec_asoc,cb_observacion)
    values      (@w_cuenta,@w_sec,@i_tbloq,@s_date,getdate(),
                 @i_aut,@i_solicit,'L',@s_ofi,@i_causa,
                 @w_secuencial,@i_observacion)

    if @@error != 0
    begin
      /* Error en creacion de registro en ah_ctabloqueada */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203009
      return 203009
    end

    /* Creacion de transaccion de servicio */

    insert into cob_ahorros..ah_tsbloqueo
                (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                 terminal,oficina,reentry,origen,cta_banco,
                 tipo_bloqueo,fecha,moneda,autorizante,estado,
                 causa,ctacte,hora,solicitante,oficina_cta,
                 turno,prod_banc,tipocta_super,alterno,observacion)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                 @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                 @i_tbloq,@s_date,@i_mon,@i_aut,'C',
                 @i_causa,@w_cuenta,getdate(),@i_solicit,@w_oficina_cta,
                 @i_turno,@w_prod_banc,@w_tipocta_super,@i_alt,@i_observacion)

    if @@error != 0
    begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203005
      return 1
    end
    commit tran
    return 0
  end

go

