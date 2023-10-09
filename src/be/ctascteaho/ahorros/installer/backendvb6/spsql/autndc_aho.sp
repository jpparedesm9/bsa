/*******************************************************************/
/*  Archivo:          ahautndc.sp                                  */
/*  Stored procedure: sp_autndc_aho                                */
/*  Base de datos:    cob_ahorros                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Permite almacenar las notas de credito y debito de cuentas      */
/* de ahorros en una tabla de transaciones por autorizar.          */
/* Estas transacciones son realizadas desde el modulo de TADMIN    */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 21/Abr/2005          L. Bernuil      Emision Inicial            */
/* 09/Sep/2005          J. Suarez       Adaptacion en TADMIN       */
/* 12/Dec/2006          P. Coello       Devolver codigo trn oper S */
/* 02/May/2016          J. Calderon     Migración a CEN            */
/*******************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_autndc_aho'
              and type = 'P')
  drop procedure sp_autndc_aho
go

create proc sp_autndc_aho
(
  @s_ofi           smallint,
  @s_ssn_branch    int = null,
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_rol           smallint,
  @s_term          varchar(10),
  @s_user          varchar(32),
  @s_date          datetime,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_ejec          char(1) = null,
  @t_trn           int = null,
  @t_rty           char(1) = 'N',
  @t_filial        int = 1,
  @t_show_version  bit = 0,
  @i_trn           int,
  @i_producto      tinyint,
  @i_mon           tinyint,
  @i_cta           char(20),
  @i_cau           char(10),
  @i_ind           tinyint = null,
  @i_operacion     char(1) = 'I',
  @i_val           money,
  @i_fecha_valor_a datetime = null,
  @i_boleta        varchar(20) = null,
  @i_nombre_ocx    varchar(20),
  @i_tabla         varchar(20) = null,
  @i_concep        varchar(50) = null,
  @i_fac           char(10),
  @i_idcaja        int = null,-- JCSA
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_siguiente     int = 0,
  @i_sec_rev       int = null,
  @i_nchq          int = null,
  @i_ctachq        varchar(18) = null,
  @i_codbanco      varchar(10) = null,
  @o_nombre        char(80) = '' out,
  @o_saldo         money = 0 out
)
as
  declare
    @w_sp_name       varchar(64),
    @w_nombre        char(80),
    @w_cau           smallint,
    @w_return        int,
    @w_cuenta        int,
    @w_filial_p      tinyint,
    @w_oficina_p     smallint,
    @w_tipo_promedio char(1),
    @w_oficial       smallint,
    @w_autorizante   varchar(32),
    @w_canje         money,
    @w_tran          int

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_autndc_aho'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end
  if @i_trn not in (253, 264, 240)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 201048
  end

  if @i_nombre_ocx = 'TADMIN.EXE'
  begin -- nombre ocx
    select
      @i_fecha_valor_a = @s_date,
      @i_idcaja = 0

    if @i_operacion = 'S'
    begin -- Operacion S
      set rowcount 20
      select
        'Producto  ' = an_producto,
        'Cuenta    ' = an_cuenta,
        'Causa     ' = an_causa,
        'Valor     ' = an_valor,
        'Nombre OCX' = an_nombre_ocx,
        'Boleta    ' = an_boleta,
        'Concepto  ' = an_concepto,
        'Secuencial' = an_ssn,
        'Transaccion'= an_trn
      from   cob_remesas..re_autoriza_ndnc
      where  an_fecha_valor_a = @s_date
         and an_user          = @s_user
         and an_producto      = @i_producto
         and an_trn           = @i_trn
         and an_estado        = 'I'
         and an_ssn           > @i_siguiente
      order  by an_ssn
      set rowcount 0
    end -- Operacion S

    if @i_operacion = 'D'
    begin -- Operacion D
      if exists(select
                  1
                from   cob_remesas..re_autoriza_ndnc
                where  an_producto = @i_producto
                   and an_moneda   = @i_mon
                   and an_ssn      = @i_sec_rev
                   and an_cuenta   = @i_cta
                   and an_ofi      = @s_ofi
                   and an_estado   = 'I'
                   and an_user     = @s_user)
      begin
        /* si la transaccion esta en estado ingresada y no ha sido aprobada o ejecutada puede ser reversada */
        delete cob_remesas..re_autoriza_ndnc
        where  an_producto = @i_producto
           and an_moneda   = @i_mon
           and an_ssn      = @i_sec_rev
           and an_cuenta   = @i_cta
           and an_ofi      = @s_ofi
           and an_estado   = 'I'
           and an_user     = @s_user

        if @@error <> 0
            or @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357015
          return 357015
        end
      end
      else
      begin
        /* No se puede efectuar el reverso de la transaccion */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351088
        return 351088
      end
    end -- Operacion D
  end -- nombre ocx

  if @i_operacion = 'I'
  begin -- Operacion I
    /* Verificar si la persona que ejecuta esta definida como ejecutor */
    if not exists (select
                     1
                   from   cobis..cl_funcionario,
                          cob_remesas..re_funcionario_autoriz
                   where  fu_funcionario = fa_ejecutor
                      and fu_login       = @s_user
                      and fa_tipo        = 'D')
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201330
      return 1
    end

    /* Chequeo de la Causa */
    if @i_trn = 253
    begin
      if not exists (select
                       1
                     from   cobis..cl_catalogo
                     where  tabla in
                            (select
                               codigo
                             from   cobis..cl_tabla
                             where  tabla in ('ah_causa_nc'))
                            and codigo = @i_cau)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201030
        return 201030
      end
      else
      begin
        select
          @w_cau = convert(smallint, @i_cau)
        if @w_cau < 201
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201332
          return 201332
        end
      end
    end

    /* Chequeo de la Causa */
    if @i_trn = 264
    begin
      if not exists (select
                       1
                     from   cobis..cl_catalogo
                     where  tabla in
                            (select
                               codigo
                             from   cobis..cl_tabla
                             where  tabla in ('ah_causa_nd'))
                            and codigo = @i_cau)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201030
        return 201030
      end
      else
      begin
        select
          @w_cau = convert(smallint, @i_cau)
        if @w_cau < 201 -- CAUSAS PROGRAMADAS
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201332
          return 201332
        end
      end
    end

    /* Chequeo de la Causa */

    if @t_trn = 240
    begin
      if not exists (select
                       1
                     from   cobis..cl_catalogo
                     where  tabla in
                            (select
                               codigo
                             from   cobis..cl_tabla
                             where  tabla in ('cc_devolucion_cheque'))
                            and codigo = @i_cau)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201030
        return 201030
      end
    end

    select
      @w_nombre = ah_nombre,
      @w_canje = ah_12h + ah_12h_dif + ah_24h + ah_48h + ah_remesas
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201004
      return 201004
    end

    -- SI ES 2502 TCORR N VALIDA QUE EL VALOR DE CHEQUE EXISTA EN SALDO DE CANJE
    if @i_trn = 240
       and @t_corr = 'N'
    begin
      if @w_canje < @i_val
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201004,
          @i_msg   = 'VALOR NOTA DEBITO POR CHQ DEVUELTO EXCEDE SALDO EN CANJE'
        return 201004
      end
    end

    /*  Determinacion de vigencia de cuenta  */
    exec @w_return = cob_ahorros..sp_ctah_vigente
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_cta_banco = @i_cta,
      @i_moneda    = @i_mon,
      @o_cuenta    = @w_cuenta out,
      @o_filial    = @w_filial_p out,
      @o_oficina   = @w_oficina_p out,
      @o_tpromedio = @w_tipo_promedio out,
      @o_oficial   = @w_oficial out

    if @w_return <> 0
      return @w_return

    if @i_nombre_ocx = 'TADMIN.EXE'
    begin -- nombre ocx
      begin tran

      --insercion en la tabla de autorizaciones
      select
        @w_autorizante = ' '
      --Ya no se obtiene el autorizante por la tabla de cl_funcionario

      insert into cob_remesas..re_autoriza_ndnc
                  (an_ssn_branch,an_trn,an_producto,an_moneda,an_cuenta,
                   an_causa,an_indicador,an_valor,an_fecha_valor_a,an_boleta,
                   an_nombre_ocx,an_tabla,an_concepto,an_fac,an_estado,
                   an_idcaja,an_ofi,an_user,an_ssn,an_autorizante,
                   an_nchq,an_ctachq,an_codbanco)
      values      ( @s_ssn_branch,@i_trn,@i_producto,@i_mon,@i_cta,
                    @i_cau,1,@i_val,@i_fecha_valor_a,@i_boleta,
                    @i_nombre_ocx,@i_tabla,@i_concep,@i_fac,'I',
                    @i_idcaja,@s_ofi,@s_user,@s_ssn,@w_autorizante,
                    @i_nchq,@i_ctachq,@i_codbanco)

      if @@error <> 0
      begin
        /* Error en insercion en re_autoriza_ndnc */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353035
        return 353035
      end
      else
      begin
        if @i_nombre_ocx = 'FCA80.ocx'
            or @i_nombre_ocx = 'FCC2502.ocx'
          print 'N/D Pendiente de Autorizaci=n'
      end

      if @t_trn = 253
        select
          @w_tran = 2915
      else
        select
          @w_tran = 2916

      -- Inserta en tabla de transacciones de servicio
      insert into cob_ahorros..ah_tran_servicio
                  (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                   ts_usuario,
                   ts_terminal,ts_oficina,ts_origen,ts_cta_banco,ts_clase,
                   ts_valor,ts_causa,ts_estado,ts_producto)
      values      (@s_ssn,@s_ssn_branch,@w_tran,@s_date,@s_user,
                   @s_term,@s_ofi,'L',@i_cta,'I',
                   @i_val,@i_cau,'C',@i_producto)

      if @@error <> 0
      begin
        -- Error en creacion de transaccion de servicio
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 203005
        return 203005
      end
      commit tran
    end -- nombre ocx

    if @i_nombre_ocx <> 'TADMIN.EXE'
    begin -- nombre ocx <>
      if @t_corr = 'N'
      begin -- t_corr = 'N'
        select
          @w_autorizante = ' '
        --Ya no se obtiene el autorizante por la tabla de cl_funcionario
        insert into cob_remesas..re_autoriza_ndnc
                    (an_ssn_branch,an_trn,an_producto,an_moneda,an_cuenta,
                     an_causa,an_indicador,an_valor,an_fecha_valor_a,an_boleta,
                     an_nombre_ocx,an_tabla,an_concepto,an_fac,an_estado,
                     an_idcaja,an_ofi,an_user,an_ssn,an_autorizante,
                     an_nchq,an_ctachq,an_codbanco)
        values      ( @s_ssn_branch,@i_trn,@i_producto,@i_mon,@i_cta,
                      @i_cau,@i_ind,@i_val,@i_fecha_valor_a,@i_boleta,
                      @i_nombre_ocx,@i_tabla,@i_concep,@i_fac,'I',
                      @i_idcaja,@s_ofi,@s_user,@s_ssn,@w_autorizante,
                      @i_nchq,@i_ctachq,@i_codbanco)

        if @@error <> 0
        begin
          /* Error en insercion en re_autoriza_ndnc */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 353035
          return 353035
        end
        else
        begin
          if @i_nombre_ocx = 'FCA80.ocx'
              or @i_nombre_ocx = 'FCC2502.ocx'
            print 'N/D Pendiente de Autorizaci=n'
        end
      end -- t_corr = 'N'

      if @t_corr = 'S'
      begin -- t_corr = 'S'
        if exists(select
                    1
                  from   cob_remesas..re_autoriza_ndnc
                  where  an_trn        = @i_trn
                     and an_producto   = @i_producto
                     and an_moneda     = @i_mon
                     and an_ssn_branch = @t_ssn_corr
                     and an_cuenta     = @i_cta
                     and an_idcaja     = @i_idcaja
                     and an_ofi        = @s_ofi
                     and an_estado     = 'I'
                     and an_user       = @s_user)
        begin
          /* si la transaccion esta en estado ingresada y no ha sido aprobada o ejecutada puede ser reversada */

          delete cob_remesas..re_autoriza_ndnc
          where  an_trn        = @i_trn
             and an_producto   = @i_producto
             and an_moneda     = @i_mon
             and an_ssn_branch = @t_ssn_corr
             and an_cuenta     = @i_cta
             and an_idcaja     = @i_idcaja
             and an_ofi        = @s_ofi
             and an_estado     = 'I'
             and an_user       = @s_user

          if @@error <> 0
              or @@rowcount = 0
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 357015
            return 357015
          end
        end
        else
        begin
          /* No se puede efectuar el reverso de la transaccion */
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 351088
            return 351088
          end
        end
      end -- t_corr = 'S'

      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @s_rol,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @i_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'L',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @t_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja,
        @i_causa      = @i_cau,
        @i_cta_banco  = @i_cta

      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end -- nombre ocx <>
  end -- Operacion I

  if @t_ejec = 'R'
  begin
    exec cob_remesas..sp_resultados_branch_caja
      @i_sldcaja  = @i_sld_caja,
      @i_idcierre = @i_idcierre,
      @i_ssn_host = @s_ssn
  end

  select
    'results_submit_rpc',
    r_nombre = @w_nombre,
    r_autorizante = @s_user

  -- commit tran
  return 0

go

