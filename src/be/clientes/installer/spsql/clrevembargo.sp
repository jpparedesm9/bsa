/************************************************************************/
/*      Archivo:                clrevembargo.sp                         */
/*      Stored procedure:       sp_reverso_embargos                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Diego F. Duran Ruiz                     */
/*      Fecha de escritura:     07-Abr-2003                             */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa procesa Reversos de Embargos efectuados en el dia   */
/*    correspondientes a la Oficina en donde fueron realizados para los */
/*    embargos judiciales de cuentas de ahorros y corrientes.           */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    21/Ene/2010     O. Usiña        Embargos ahorros                  */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_reverso_embargos')
  drop proc sp_reverso_embargos
go

create proc sp_reverso_embargos
(
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_org          char(1) = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_oficina      int = null,
  @i_operacion    char(1) = null,
  @i_accion       char(1) = null,
  @i_secuencial   int = null,
  @i_sec          int = null,
  @i_observacion  descripcion = null,
  @i_ente         int = null,
  @i_producto     int = null,
  @i_cta          cuenta = null,
  @i_valor        money = null,
  @i_oficio       varchar(16) = null,
  @i_solicit      varchar(64) = null,
  @i_cod_deposito int = null,
  @i_ofi_origen   smallint = null,
  @i_filial       tinyint = null,
  @i_modo         tinyint = null,
  @i_siguiente    int = null,
  @o_funcionario  login = null out,
  @o_registrado   datetime = null out
)
as
  /** GENERALES **/
  declare
    @w_en_nombre              descripcion,
    @w_apellido               descripcion,
    @w_secuencial             int,
    @w_secuencial1            int,
    @w_saldo_pdte             money,
    @w_num_cta                cuenta,
    @w_num_cta1               cuenta,
    @w_tipo_bloq              tinyint,
    @w_producto               int,
    @w_estado                 char(1),
    @w_subproducto            int,
    @w_fecha                  datetime,
    @w_return                 int,
    @w_sp_name                descripcion,
    @w_fecha_ofi              datetime,
    @w_oficio                 varchar(16),
    @w_solicitante            varchar(64),
    @w_demandante             varchar(64),
    @w_monto                  money,
    @w_tipo_proceso           catalogo,
    @w_autorizante            login,
    @w_debita_cta             char(1),
    @w_oficina                smallint,
    @w_tipo_persona           char(1),
    @w_juzgado                varchar(64),
    @w_concepto               catalogo,
    @w_oficina_destino        catalogo,
    @w_tipo_doc_demandante    catalogo,
    @w_numero_doc_demandante  varchar(13),
    @w_nombre_demandante      varchar(20),
    @w_apellido_demandante    varchar(30),
    @w_cuenta_especifica      char(1),
    @w_nro_cta_especifica     varchar(20),
    @w_reversado              char(1),
    @w_sec_depjud             int,
    @w_fecha_reversa          datetime,
    @w_usuario_rev            login,
    @w_observacion            descripcion,
    @w_tipo_doc_solicitante   catalogo,
    @w_numero_doc_solicitante varchar(13),
    @w_producto_ca            varchar(10),
    @w_ssn_corr               int,
    @w_hora                   datetime,
    @w_sec_bloqueo            int,
    @w_sec_conge              int,
    @w_monto_reverso          money,
    @w_cauemb                 varchar(10),
    @w_causa_rev              char(1),
    @w_instrumento            int,
    @w_grupo1                 varchar(255),
    @w_numorden               int,
    @w_moneda                 tinyint,
    @w_error                  int,
    @w_sec                    int,
    @w_sec2                   int,
    @w_sec_bloqueo_dpf        tinyint,
    @w_sec_bloqueo_dpf0       varchar(3),
    @w_tbloqueo               varchar(10)

  --U2 V9
  /* Parametros Generales */
  select
    @w_sp_name = 'sp_reverso_embargos'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Valida Transaccion Autorizada */
  if @t_trn not in (1103, 1104)
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  /* BUSQUEDA DE EMBARGOS */
  if @i_operacion = 'S'
  begin
    if @i_accion = 'A'
    begin
      if @i_modo = 0
      begin
        set rowcount 20
        select
          'ENTE ' = ca_ente,
          'SECUENCIAL  ' = ca_secuencial,
          'OFICIO      ' = ca_oficio,
          'No. CUENTA  ' = de_num_cuenta,
          'NOMBRE DEMANDADO   ' = en_nombre,
          'APELLIDO DEMANDADO   ' = (p_p_apellido + ' ' + p_s_apellido),
          'NOMBRE DEMANDANTE  ' = ca_nombre_demandante,
          'APELLIDO DEMANDANTE   ' = ca_apellido_demandante,
          'MONTO       ' = de_monto,
          'JUZGADO     ' = ca_juzgado,
          'OBSERVACION ' = ca_observacion,
          'PRODUCTO    ' = de_producto,
          'DEPJUD      ' = de_sec_depjud,
          'OFICINA ORIG' = ca_oficina,
          'SEC INTERNO ' = de_sec_interno
        from   cl_cab_embargo,
               cl_det_embargo,
               cl_ente
        where  ca_ente                  = de_ente
           and ca_ente                  = en_ente
           and de_secuencial            = ca_secuencial
           and ca_oficina               = convert(smallint, @i_oficina)
           and de_fecha                 = @w_fecha
           and ca_fecha                 = de_fecha
           --        and de_producto in (3,4)
           and isnull(ca_reversado,
                      ' ') <> 'S'
           and ca_monto                 > 0
           and ca_tipo_proceso          <> 'L'
           and ca_debita_cta            = 'S'
        order  by ca_ente,
                  ca_secuencial
      end
      else
      begin
        select
          'ENTE ' = ca_ente,
          'SECUENCIAL  ' = ca_secuencial,
          'OFICIO      ' = ca_oficio,
          'No. CUENTA  ' = de_num_cuenta,
          'NOMBRE DEMANDADO   ' = en_nombre,
          'APELLIDO DEMANDADO   ' = (p_p_apellido + ' ' + p_s_apellido),
          'NOMBRE DEMANDANTE  ' = ca_nombre_demandante,
          'APELLIDO DEMANDANTE   ' = ca_apellido_demandante,
          'MONTO       ' = de_monto,
          'JUZGADO     ' = ca_juzgado,
          'OBSERVACION ' = ca_observacion,
          'PRODUCTO    ' = de_producto,
          'DEPJUD      ' = de_sec_depjud,
          'OFICINA ORIG' = ca_oficina,
          'SEC INTERNO ' = de_sec_interno
        from   cl_cab_embargo,
               cl_det_embargo,
               cl_ente
        where  ca_ente                  = de_ente
           and ca_ente                  = en_ente
           and de_secuencial            = ca_secuencial
           and ca_oficina               = convert(smallint, @i_oficina)
           and de_fecha                 = @w_fecha
           and ca_fecha                 = de_fecha
           --        and de_producto in (3,4)
           and isnull(ca_reversado,
                      ' ') <> 'S'
           and ca_monto                 > 0
           and ca_tipo_proceso          <> 'L'
           and ca_debita_cta            = 'S'
           and de_sec_interno           > @i_siguiente
        order  by ca_ente,
                  ca_secuencial

      end --modo
    end --accion A

    if @i_accion = 'B'
    begin
      set rowcount 15
      select
        'ENTE  ' = ca_ente,
        'SECUENCIAL  ' = ca_secuencial,
        'OFICIO      ' = ca_oficio,
        'No. CUENTA  ' = de_num_cuenta,
        'NOMBRE DEMANDADO   ' = en_nombre,
        'APELLIDO DEMANDADO   ' = (p_p_apellido + ' ' + p_s_apellido),
        'NOMBRE DEMANDANTE  ' = ca_nombre_demandante,
        'APELLIDO DEMANDANTE   ' = ca_apellido_demandante,
        'MONTO       ' = de_monto,
        'JUZGADO     ' = ca_juzgado,
        'OBSERVACION ' = ca_observacion,
        'PRODUCTO    ' = de_producto,
        'DEPJUD      ' = de_sec_depjud,
        'OFICINA ORIG' = ca_oficina,
        'SEC INTERNO ' = de_sec_interno
      from   cl_cab_embargo,
             cl_det_embargo,
             cl_ente
      where  ca_ente                  = de_ente
         and ca_ente                  = en_ente
         and de_secuencial            = ca_secuencial
         and ((ca_ente                  >= @i_ente
               and ca_secuencial            > @i_secuencial)
               or (ca_ente > @i_ente))
         and ca_oficina               = convert(smallint, @i_oficina)
         and de_fecha                 = @w_fecha
         and ca_fecha                 = de_fecha
         and de_producto in (3, 4)
         and isnull(ca_reversado,
                    ' ') <> 'S'
         and ca_monto                 > 0
         and ca_debita_cta            = 'S'
      order  by ca_ente,
                ca_secuencial
    end
    set rowcount 0
  end

  /* SELECCIONA UN REGISTRO DEL GRID Y LO VISUALIZA EN LOS LABEL */
  if @i_operacion = 'Q'
  begin
    select
      @w_en_nombre = en_nombre,
      @w_apellido = (p_p_apellido + ' ' + p_s_apellido)
    from   cl_ente
    where  en_ente = @i_ente

    select
      'ENTE  ' = ca_ente,
      'SECUENCIAL  ' = ca_secuencial,
      'OFICIO      ' = ca_oficio,
      'No. CUENTA  ' = de_num_cuenta,
      'NOMBRE DEMANDADO   ' = @w_en_nombre,
      'APELLIDO DEMANDADO   ' = isnull(@w_apellido,
                                       ' '),
      'NOMBRE DEMANDANTE  ' = ca_nombre_demandante,
      'APELLIDO DEMANDANTE   ' = ca_apellido_demandante,
      'MONTO       ' = de_monto,
      'JUZGADO     ' = ca_juzgado,
      'OBSERVACION ' = ca_observacion,
      'PRODUCTO    ' = de_producto,
      'DEPJUD      ' = de_sec_depjud,
      'OFICINA ORIG' = ca_oficina,
      'SEC INTERNO ' = de_sec_interno
    from   cl_cab_embargo,
           cl_det_embargo
    where  ca_secuencial = @i_secuencial
       and ca_ente       = de_ente
       and de_secuencial = ca_secuencial
       and ca_ente       = @i_ente

    select
      @o_funcionario = ca_autorizante,
      @o_registrado = de_fecha
    from   cl_cab_embargo,
           cl_det_embargo
    where  ca_secuencial = @i_secuencial
       and ca_ente       = de_ente
       and de_secuencial = ca_secuencial
       and ca_ente       = @i_ente

    select
      convert(varchar(10), @o_registrado, 103)
    select
      @o_funcionario
  end

  /* REVERSA EMBARGO */
  if @i_operacion = 'U'
  begin
    begin tran
    -- Cargo variables locales para log de auditoria
    select
      @w_secuencial = ca_secuencial,
      @w_fecha = ca_fecha,
      @w_oficio = ca_oficio,
      @w_solicitante = ca_solicitante,
      @w_demandante = ca_demandante,
      @w_estado = ca_estado,
      @w_tipo_proceso = ca_tipo_proceso,
      @w_autorizante = ca_autorizante,
      @w_fecha_ofi = ca_fecha_ofi,
      @w_monto = ca_monto,
      @w_saldo_pdte = ca_saldo_pdte,
      @w_debita_cta = ca_debita_cta,
      @w_oficina = ca_oficina,
      @w_tipo_persona = ca_tipo_persona,
      @w_juzgado = ca_juzgado,
      @w_concepto = ca_concepto,
      @w_oficina_destino = ca_oficina_destino,
      @w_tipo_doc_demandante = ca_tipo_doc_demandante,
      @w_numero_doc_demandante = ca_numero_doc_demandante,
      @w_nombre_demandante = ca_nombre_demandante,
      @w_apellido_demandante = ca_apellido_demandante,
      @w_cuenta_especifica = ca_cuenta_especifica,
      @w_nro_cta_especifica = ca_nro_cta_especifica,
      @w_reversado = ca_reversado,
      @w_sec_depjud = ca_sec_depjud,
      @w_fecha_reversa = ca_fecha_reversa,
      @w_usuario_rev = ca_usuario_rev,
      @w_observacion = ca_observacion,
      @w_tipo_doc_solicitante = ca_tipo_doc_solicitante,
      @w_numero_doc_solicitante = ca_numero_doc_solicitante,
      @w_producto_ca = ca_producto
    from   cl_cab_embargo
    where  ca_ente         = @i_ente
       and ca_oficio       = @i_oficio
       and ca_secuencial   = @i_secuencial
       and ca_tipo_proceso = 'B'

    select
      @i_observacion = @i_observacion + ' *Reverso Embargo*'
    if @i_producto in(4, 14)
       and @i_valor <> 0
    begin
      select
        @w_sec = 10
      select
        @w_cauemb = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'AHO'
         and pa_nemonico = 'NDAHO'

      delete dpf_reverso
      insert into dpf_reverso
                  (secuencial,sec_interno,productoint,cuenta,monto)
        select
          secuencial = 0,sec_interno = de_sec_interno,productoint = de_producto,
          cuenta
          =
          de_num_cuenta,monto = de_monto
        from   cobis..cl_det_embargo
        where  de_ente                 = @i_ente
           and de_secuencial           = @i_secuencial
           and de_estado_levantamiento = 'N'
        order  by de_producto,
                  de_num_cuenta,
                  de_secuencial

      select
        @w_sec2 = 1

      update cobis..dpf_reverso
      set    secuencial = @w_sec2,
             @w_sec2 = @w_sec2 + 1

      set rowcount 1
      select
        @w_secuencial = secuencial,
        @w_sec_bloqueo = sec_interno,
        @w_producto = productoint,
        @w_num_cta = cuenta,
        @w_monto_reverso = monto
      from   cobis..dpf_reverso
      order  by secuencial

      if @@rowcount = 0
        select
          @w_sec_bloqueo = null
      while @w_sec_bloqueo is not null
      begin
        /* Determina el secuencial de la transaccion para el reverso */

        if @w_producto = 4
        begin
          select
            @w_numorden = de_sec_depjud
          from   cobis..cl_det_embargo
          where  de_ente                 = @i_ente
             and de_secuencial           = @i_secuencial
             and de_estado_levantamiento = 'N'
             and de_producto             = 4
             and de_sec_interno          = @w_sec_bloqueo

          select
            @w_hora = hb_hora
          from   cob_ahorros..ah_his_bloqueo
          where  hb_secuencial = @w_sec_bloqueo
             and hb_valor      = @w_monto_reverso

          select
            @w_ssn_corr = isnull(tm_ssn_branch,
                                 tm_secuencial)
          from   cob_ahorros..ah_tran_monet
          where  tm_cta_banco   = @w_num_cta
             and tm_fecha       = @w_fecha
             and tm_tipo_tran   = '264'
             and tm_signo       = 'D'
             and tm_oficina     = @i_ofi_origen
             and tm_valor       = @w_monto_reverso
             and tm_causa       = @w_cauemb
             and tm_cod_alterno = 10
             and tm_hora        = @w_hora
        end --prod 4

        if @w_ssn_corr > 0
           and @w_producto = 4
        begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
            @s_srv           = @s_srv,
            @s_ofi           = @s_ofi,
            @s_ssn           = @s_ssn,
            @t_trn           = 264,
            @i_cta           = @w_num_cta,
            @i_val           = @w_monto_reverso,
            @t_ssn_corr      = @w_ssn_corr,
            @i_cau           = @w_cauemb,
            @i_mon           = 0,
            @t_corr          = 'S',
            @i_alt           = @w_sec,
            @i_alt_corr      = 10,
            @i_fecha         = @w_fecha,
            @i_verificar_blq = 'N',
            @i_valida_saldo  = 'N',
            @i_inmovi        = 'S'

          if @w_return <> 0
              or @@error <> 0
          begin
            select
              @w_error = @w_return
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = @w_return
            /* 'Error Ejecutando Bloqueo'*/
            return 1
          end
          select
            @w_sec = @w_sec + 1
        end --ssn

        if @w_producto = 14
        begin
          select
            @w_sec_bloqueo_dpf0 = convert(varchar(3), @w_sec_bloqueo)
          select
            @w_sec_bloqueo_dpf = convert(tinyint, @w_sec_bloqueo_dpf0)

          exec @w_return = cob_pfijo..sp_embargo
            @s_user           = @s_user,
            @s_term           = @s_term,
            @s_date           = @s_date,
            @s_ofi            = @s_ofi,
            @s_sesn           = @s_sesn,
            @s_ssn            = @s_ssn,
            @s_srv            = @s_srv,
            @t_trn            = 14560,
            @i_operacion      = 'D',
            @i_modifico_fp    = 1,
            @i_bl_observacion = @i_observacion,
            @i_bl_secuencial  = @w_sec_bloqueo_dpf,
            @i_op_num_banco   = @w_num_cta,
            @i_oficina        = @i_oficina

          if @w_return <> 0
              or @@error <> 0
          begin
            set rowcount 1
            update cobis..cl_det_embargo
            set    de_procesa_cheque = 'N',
                   de_sec_depjud = @w_return
            where  de_ente        = @i_ente
               and de_secuencial  = @i_secuencial
               and de_sec_interno = @w_sec_bloqueo
               and de_num_cuenta  = @w_num_cta
            set rowcount 0
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'ERROR EN SP DE DPF',
              @i_num   = 101082
            return 101082
          end
        end --prod 14

        --reversando/anulando el cheque

        if @w_producto <> 14
        begin
          select
            @w_instrumento = pa_int
          from   cobis..cl_parametro
          where  pa_nemonico = 'CCHGER'
             and pa_producto = 'SBA'

          select
            @w_moneda = pa_tinyint
          from   cobis..cl_parametro
          where  pa_nemonico = 'CODML'
             and pa_producto = 'SBA'

          select
            @w_causa_rev = 'T'

          select
            @w_grupo1 = cast(@w_numorden as varchar) + '@' + @w_causa_rev + '@'
                        +
                        ''
                        +
                        '@'
                        +
                                                      '' + '@' +
                                                      '' + '@'
                        + cast(@w_moneda as varchar) + '@'

          if @w_numorden > 0
          begin
            exec @w_return = cob_sbancarios..sp_actualizar_lotes
              @s_ssn         = @s_ssn,
              @s_date        = @s_date,
              @s_user        = @s_user,
              @s_term        = @s_term,
              @s_ofi         = @s_ofi,
              @s_srv         = @s_srv,
              @t_trn         = 29301,
              @i_producto    = 4,
              @i_instrumento = @w_instrumento,
              @i_causa_anul  = '99',
              @i_subtipo     = @w_instrumento,
              @i_grupo1      = @w_grupo1,
              @i_llamada_ext = 'S'
            if @w_return <> 0
                or @@error <> 0
            begin
              /* Error al actualizar cheque */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 255001
              return 1
            end
          end --@w_numorden > 0
        end --producto <> dpf

        update cl_det_embargo
        set    de_estado_levantamiento = 'S',
               de_fecha_levantamiento = @w_fecha,
               de_observacion = @i_observacion
        where  de_ente        = @i_ente
           and de_secuencial  = @i_secuencial
           and de_sec_interno = @w_sec_bloqueo

        /* Si no encuentra Registros muestra error */
        if @@error != 0
        begin
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103064
          return 1
        end

        set rowcount 1
        select
          @w_secuencial = secuencial,
          @w_sec_bloqueo = sec_interno,
          @w_producto = productoint,
          @w_num_cta = cuenta,
          @w_monto_reverso = monto
        from   cobis..dpf_reverso
        where  secuencial > @w_secuencial
        order  by secuencial

        if @@rowcount = 0
        begin
          set rowcount 0
          break
        end
      end
    end

    else
    begin
      /* Actualizo los registros correspondientes del detalle */
      set rowcount 0
      select
        @s_ssn = @s_ssn + 1
      set rowcount 1
      select
        @w_num_cta = de_num_cuenta,
        @w_sec_bloqueo = de_sec_interno,
        @w_monto_reverso = de_monto
      from   cobis..cl_det_embargo
      where  de_ente                 = @i_ente
         and de_secuencial           = @i_secuencial
         and de_estado_levantamiento = 'N'
         and de_producto             = @w_producto
      order  by de_num_cuenta,
                de_secuencial
    end

    /* Cambio estado a registro de Cabecera */
    update cl_cab_embargo
    set    ca_reversado = 'S',
           ca_estado = 'C',
           ca_tipo_proceso = 'L',
           ca_saldo_pdte = 0,
           ca_usuario_rev = @s_user,
           ca_fecha_reversa = @s_date,
           ca_observacion = @i_observacion
    where  ca_secuencial   = @i_secuencial
       and ca_ente         = @i_ente
       and ca_fecha        = @w_fecha
       and ca_tipo_proceso = 'B'

    /* Si no encuentra Registros muestra error */
    if @@error != 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103064
      return 1
    end

    select
      @w_sec_conge = isnull(ca_secuencial,
                            0)
    from   cobis..cl_cab_embargo
    where  ca_ente         = @i_ente
       and ca_oficio       = @i_oficio
       and ca_tipo_proceso = 'C'

    select
      @w_sec_conge = isnull(@w_sec_conge,
                            0)

    if @w_sec_conge > 0
    begin
      select
        @w_sec_bloqueo = de_sec_interno,
        @w_num_cta1 = de_num_cuenta,
        @w_producto = de_producto,
        @w_tbloqueo = de_tipo_bloqueo
      from   cobis..cl_det_embargo
      where  de_secuencial = @w_sec_conge
         and de_ente       = @i_ente

      select
        @w_sec_bloqueo = isnull(@w_sec_bloqueo,
                                0)
    end

    if @w_sec_bloqueo > 0
    begin
      if @w_producto = 4
      begin
        select
          @w_secuencial1 = isnull(cb_secuencial,
                                  0)
        from   cob_ahorros..ah_ctabloqueada
        where  cb_cuenta in
               (select
                  ah_cuenta
                from   cob_ahorros..ah_cuenta
                where  ah_cta_banco = @w_num_cta1)
               and cb_tipo_bloqueo = '2'
               and cb_estado       = 'V'
        select
          @w_secuencial = isnull(@w_secuencial,
                                 0)
      end

      if @w_producto = 3
      begin
        select
          @w_secuencial1 = isnull(cb_secuencial,
                                  0)
        from   cob_cuentas..cc_ctabloqueada
        where  cb_cuenta in
               (select
                  cc_ctacte
                from   cob_cuentas..cc_ctacte
                where  cc_cta_banco = @w_num_cta1)
               and cb_tipo_bloqueo = '2'
               and cb_estado       = 'V'
      end
    end
    else
      select
        @w_secuencial1 = isnull(@w_secuencial1,
                                0)

    if @w_sec_bloqueo > 0
       and @w_secuencial1 > 0
       and @w_producto in(4)
    begin
      exec @w_return = cobis..sp_descongela
        @s_srv          = @s_srv,
        @s_ssn          = @s_ssn,
        @s_user         = 'Embargos',
        @s_term         = @s_term,
        @s_ofi          = @s_ofi,
        @s_date         = @w_fecha,
        @s_lsrv         = @s_lsrv,
        @s_org          = @s_org,
        @t_trn          = 1447,
        @i_operacion    = 'I',
        @i_oficio       = @i_oficio,
        @i_secuencial   = @w_sec_bloqueo,
        @i_cliente      = @i_ente,
        @i_linea        = 'S',
        @i_tipo_proceso = 'D',
        @i_observacion  = @i_observacion,
        @i_demandante   = @w_demandante,
        @i_solicitante  = @w_solicitante,
        @i_autorizante  = @w_autorizante,
        @i_producto     = @w_producto,
        @i_num_cta      = @w_num_cta1,
        @i_tbloq        = '2'--@w_tbloqueo
      if @w_return <> 0
          or @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_return
        /* 'Error Ejecutando Bloqueo'*/
        return @w_return
      end
    end

    /* Transaccion de Servicio Registro Posterior */
    insert into ts_cab_embargo
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ente,secuencial2,
                 fecha2,ts_fecha_ofi,oficio,solicitante,demandante,
                 monto,estado,tipo_proceso,autorizante,saldo_pdte,
                 debita_cta,oficina,tipo_persona,juzgado,concepto,
                 oficina_destino,tipo_doc_demandante,numero_doc_demandante,
                 nombre_demandante,apellido_demandante,
                 cuenta_especifica,nro_cta_especifica,reversado,sec_depjud,
                 fecha_reversa,
                 usuario_rev,observacion,tipo_doc_solicitante,
                 numero_doc_solicitante
                 ,producto)
    values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_ente,@w_secuencial,
                 @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                 @w_monto,@w_estado,@w_tipo_proceso,@w_autorizante,@w_saldo_pdte
                 ,
                 @w_debita_cta,@w_oficina,@w_tipo_persona,
                 @w_juzgado,@w_concepto,
                 @w_oficina_destino,@w_tipo_doc_demandante,
                 @w_numero_doc_demandante,
                 @w_nombre_demandante,@w_apellido_demandante,
                 @w_cuenta_especifica,@w_nro_cta_especifica,@w_reversado,
                 @w_sec_depjud,@w_fecha_reversa,
                 @w_usuario_rev,@w_observacion,@w_tipo_doc_solicitante,
                 @w_numero_doc_solicitante,@w_producto_ca)
    if @@error != 0
    begin
      /* Error en creacion de transaccion de servicio  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

    /* Transaccion de Servicio Registro Actual */
    insert into ts_cab_embargo
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ente,secuencial2,
                 fecha2,ts_fecha_ofi,oficio,solicitante,demandante,
                 monto,estado,tipo_proceso,autorizante,saldo_pdte,
                 debita_cta,oficina,tipo_persona,juzgado,concepto,
                 oficina_destino,tipo_doc_demandante,numero_doc_demandante,
                 nombre_demandante,apellido_demandante,
                 cuenta_especifica,nro_cta_especifica,reversado,sec_depjud,
                 fecha_reversa,
                 usuario_rev,observacion,tipo_doc_solicitante,
                 numero_doc_solicitante
                 ,producto)
    values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_ente,@w_secuencial,
                 @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                 @w_monto,'C','L',@w_autorizante,0,
                 @w_debita_cta,@w_oficina,@w_tipo_persona,@w_juzgado,@w_concepto
                 ,
                 @w_oficina_destino,@w_tipo_doc_demandante,
                 @w_numero_doc_demandante,
                 @w_nombre_demandante,@w_apellido_demandante,
                 @w_cuenta_especifica,@w_nro_cta_especifica,@w_reversado,
                 @w_sec_depjud,@w_fecha_reversa,
                 @w_usuario_rev,@w_observacion,@w_tipo_doc_solicitante,
                 @w_numero_doc_solicitante,@w_producto_ca)
    if @@error != 0
    begin
      /* Error en creacion de transaccion de servicio  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

    if (@w_producto = 3
         or @w_producto = 4)
    begin
      exec @w_return = cobis..sp_saldo_min_embargado
        @s_srv     = @s_srv,
        @s_user    = @s_user,
        @s_term    = @s_term,
        @s_ofi     = @s_ofi,
        @s_date    = @s_date,
        @t_trn     = 1432,-- Cancelacion o levantamiento de un Embargo = 1432
        @i_oper    = 'C',-- Cancelacion o levantamiento de Embargo
        @i_cod_emb = @i_secuencial,
        @i_cliente = @i_ente

      if @w_return <> 0
          or @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_return
        return 1
      end
    end
    commit tran
  end--operacion U

  return 0

go

