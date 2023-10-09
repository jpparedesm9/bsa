/************************************************************************/
/*      Archivo:                cldesemba.sp                            */
/*      Stored procedure:       sp_desembargo                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Johana Laguna R.                   */
/*      Fecha de escritura:     03-Abr-2001                             */
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
/*    Este programa procesa las transacciones de Desembargo de fondos   */
/*    de un Cliente cl_cab_embargo, cl_det_embargo                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*      FECHA           AUTOR           RAZON                           */
/*   21/Ene/2010      O. Usi¤a         Embargos Cta. Ahorros            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_desembargo')
  drop proc sp_desembargo

go
create proc sp_desembargo
(
  @s_ssn          int = null,
  @s_sesn         int,
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
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_cliente      int,
  @i_fecha        datetime = null,
  @i_fecha_ofi    datetime = null,
  @i_oficio       varchar(16) = null,
  @i_solicitante  varchar(64) = null,
  @i_demandante   varchar(64) = null,
  @i_monto        money = null,
  @i_monto_emb    money = null,
  @i_saldo_pdte   money = null,
  @i_tipo_proceso char(1) = null,
  @i_autorizante  login = null,
  @i_estado       char(1) = null,
  @i_estado_lev   char(1) = null,
  @i_secuencial   int = null,
  @i_sec_interno  int = null,
  @i_num_cta      cuenta = null,
  @i_producto     varchar(3) = null,
  @i_observacion  descripcion = null,
  @i_subproducto  varchar(30) = null,
  @i_modo         tinyint = null,
  @i_siguiente    int = null,
  @i_mmi          varchar(10) = null
)
as
  declare
    @o_siguiente              int,
    @o_siguiente2             int,
    @o_secuencial             int,
    @o_fecha_ofi              datetime,
    @o_oficio                 varchar(16),
    @o_solicitante            varchar(64),
    @o_demandante             varchar(64),
    @o_monto                  money,
    @o_saldo_pdte             money,
    @o_num_cta                cuenta,
    @o_producto               int,
    @o_secinterno             int,
    @o_registrado             datetime,
    @o_funcionario            login,
    @o_modificado             datetime,
    @w_secuencial             int,
    @w_fecha                  datetime,
    @w_fecha_ofi              datetime,
    @w_oficio                 varchar(16),
    @w_solicitante            varchar(64),
    @w_demandante             varchar(64),
    @w_monto                  money,
    @w_estado                 char(1),
    @w_tipo_proceso           char(1),
    @w_autorizante            login,
    @w_producto               int,
    @w_subproducto            int,
    @w_tipo_bloq              tinyint,
    @w_return                 int,
    @w_sp_name                varchar (32),
    @w_seqnos                 int,
    @w_newsaldo               money,
    @w_falta                  money,
    @w_saldo_pdte             money,
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
    @w_fecha_proceso          datetime,
    @w_producto1              varchar(3),
    @w_sec_prod               int,
    @w_accion                 char(1),
    @w_cta                    int,
    @w_seccongela             int,
    @w_cliente                int,
    @w_sec_int                int,
    @w_cong_prod              tinyint,
    @w_cong_ncta              varchar(16),
    @w_producto2              varchar(10),
    @w_cont_emb               int,
    @w_sec_interno1           int,
    @w_prod1                  int,
    @w_numcta1                cuenta,
    @w_fecha_now              datetime,
    @w_cuenta                 cuenta,
    @w_sec_interno            int,
    @w_productoint            int,
    @w_ssn                    int,
    @w_sec                    int,
    @w_monto_emb              money,
    @w_secuencial_cc          int,
    @w_secuencial_ah          int,
    @w_nro_reg                tinyint,
    @w_cont_reg               tinyint,
    @w_secuencialw            int,
    @w_secuencial11           int,
    @w_contador               int,
    @w_vbloqueo               money,
    @w_tipo_bloqueo           varchar(10),
    @w_observa                varchar(64),
    @w_secint                 int

  --U2 V12

  /* Parametros Generales */
  select
    @w_sp_name = 'sp_desembargo'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = convert(varchar(10), fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  /* Valida Transaccion Autorizada */
  if @t_trn not in (1432, 1433, 1434)
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  if @i_operacion = 'S'
  begin
    /* Muestra las Cabeceras de embargos Levantados */
    if @i_modo = 0
    begin
      set rowcount 20
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = convert(char(10), ca_fecha, 101),
        'FECHA OFI ' = convert(char(10), ca_fecha_ofi, 101),
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_nombre_demandante,
        'MONTO EMBARGADO' = de_monto,
        'PENDIENTE  ' = ca_saldo_pdte,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'CUENTA     ' = de_num_cuenta,
        'PRODUCTO   ' = de_producto,
        'SEC MODULO' = de_sec_interno
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente                 = @i_cliente
         and ca_ente                 = de_ente
         and ca_secuencial           = de_secuencial
         and ca_tipo_proceso         = 'B'
         and de_estado_levantamiento = 'N'
      order  by de_sec_interno
    end
    else
    begin
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = convert(char(10), ca_fecha, 101),
        'FECHA OFI ' = convert(char(10), ca_fecha_ofi, 101),
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_nombre_demandante,
        'MONTO EMBARGADO' = de_monto,
        'PENDIENTE  ' = ca_saldo_pdte,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'CUENTA     ' = de_num_cuenta,
        'PRODUCTO   ' = de_producto,
        'SEC MODULO' = de_sec_interno
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente                 = @i_cliente
         and ca_ente                 = de_ente
         and ca_secuencial           = de_secuencial
         and ca_tipo_proceso         = 'B'
         and de_estado_levantamiento = 'N'
         and de_sec_interno          >= @i_siguiente
      order  by de_sec_interno

    end
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end
    set rowcount 0
  end

  if @i_operacion = 'F'
  begin
    if @i_modo = 0
    begin
      set rowcount 20
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = convert(char(10), ca_fecha, 101),
        'FECHA OFI ' = convert(char(10), ca_fecha_ofi, 101),
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_nombre_demandante,
        'MONTO EMBARGADO' = de_monto,
        'PENDIENTE  ' = ca_saldo_pdte,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'CUENTA     ' = de_num_cuenta,
        'PRODUCTO   ' = de_producto,
        'SEC MODULO' = de_sec_interno
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente                 = @i_cliente
         and ca_ente                 = de_ente
         and ca_secuencial           = de_secuencial
         and ca_tipo_proceso         = 'B'
         and ca_estado               = 'P'
         and de_estado_levantamiento = 'N'
      order  by de_sec_interno
    end
    else
    begin
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = convert(char(10), ca_fecha, 101),
        'FECHA OFI ' = convert(char(10), ca_fecha_ofi, 101),
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_nombre_demandante,
        'MONTO EMBARGADO' = de_monto,
        'PENDIENTE  ' = ca_saldo_pdte,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'CUENTA     ' = de_num_cuenta,
        'PRODUCTO   ' = de_producto,
        'SEC MODULO' = de_sec_interno
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente                 = @i_cliente
         and ca_ente                 = de_ente
         and ca_secuencial           = de_secuencial
         and ca_tipo_proceso         = 'B'
         and ca_estado               = 'P'
         and de_estado_levantamiento = 'N'
         and de_sec_interno          >= @i_siguiente
      order  by de_sec_interno

    end
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end
    set rowcount 0
  end

  if @i_operacion = 'H'
  begin
    select
      'SECUENCIAL' = ca_secuencial,
      'FECHA     ' = convert(char(10), ca_fecha, 101),
      'FECHA OFI ' = convert(char(10), ca_fecha_ofi, 101),
      'OFICIO    ' = ca_oficio,
      'SOLICITANTE'= ca_solicitante,
      'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_nombre_demandante,
      'MONTO      ' = ca_monto,
      'PENDIENTE  '= ca_saldo_pdte,
      'ESTADO' = ca_estado,
      'TIPO EMB.' = ca_tipo_proceso,
      'AUTORIZA   ' = ca_autorizante,
      'CUENTA     '= de_num_cuenta,
      'PRODUCTO   '= de_producto,
      'SEC MODULO' = de_sec_interno
    from   cobis..cl_cab_embargo,
           cobis..cl_det_embargo
    where  ca_ente         = @i_cliente
       and ca_ente         = de_ente
       and ca_secuencial   = de_secuencial
       and ca_tipo_proceso = 'D'
    order  by ca_secuencial

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end
  end

  /* Query especifico de un embargo */
  if @i_operacion = 'Q'
  begin
    /*   Muestra las Cabeceras de embargos Insertadas */
    select
      @o_secuencial = ca_secuencial,
      @o_fecha_ofi = ca_fecha_ofi,
      @o_oficio = ca_oficio,
      @o_solicitante = ca_solicitante,
      @o_demandante = ca_apellido_demandante + ' ' + ca_nombre_demandante,
      @o_monto = de_monto,--ca_monto,
      @o_saldo_pdte = ca_saldo_pdte,
      @o_num_cta = de_num_cuenta,
      @o_producto = de_producto,
      @o_secinterno = de_sec_interno,
      @o_registrado = ca_fecha,
      @o_funcionario = ca_autorizante
    from   cobis..cl_cab_embargo,
           cobis..cl_det_embargo
    where  ca_ente         = @i_cliente
       and ca_ente         = de_ente
       and de_ente         = ca_ente
       and ca_secuencial   = de_secuencial
       and de_secuencial   = ca_secuencial
       and ca_secuencial   = @i_secuencial
       and ca_oficio       = @i_oficio
       and ca_tipo_proceso = 'B'
       and de_sec_interno  = @i_sec_interno

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
      /* 'No existe dato solicitado'*/
      return 1
    end

    select
      @o_modificado = max(de_fecha)
    from   cobis..cl_det_embargo
    where  de_ente       = @i_cliente
       and de_secuencial = @i_secuencial

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001 /* No existe dato solicitado */
      return 1
    end

    select
      @o_secuencial,
      convert (char(10), @o_fecha_ofi, 101),
      @o_oficio,
      @o_solicitante,
      @o_demandante,
      @o_monto,
      @o_saldo_pdte,
      @o_num_cta,
      @o_producto,
      @o_secinterno,
      @o_registrado,
      @o_funcionario,
      @o_modificado

    return 0
  end

  /*** Insert ** */
  if @i_operacion = 'I'
  begin
    /*Datos para transaccion de servicio*/

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
    where  ca_ente         = @i_cliente
       and ca_oficio       = @i_oficio
       and ca_secuencial   = @i_secuencial
       and ca_tipo_proceso = 'B'
       and ca_estado       = 'C'

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 111111
      return 1
    end

    begin tran

    delete dpf_desembargo
    insert into dpf_desembargo
                (secuencial,sec_interno,productoint,cuenta)
      select
        secuencial = 0,sec_interno = de_sec_interno,productoint = de_producto,
        cuenta
        =
        de_num_cuenta
      from   cobis..cl_det_embargo
      where  de_ente                 = @i_cliente
         and de_secuencial           = @i_secuencial
         and de_producto             = @i_producto
         and de_estado_levantamiento = 'N'
         and de_procesa_cheque is null
      order  by de_sec_interno,
                de_num_cuenta

    select
      @w_sec = 1

    update cobis..dpf_desembargo
    set    secuencial = @w_sec,
           @w_sec = @w_sec + 1

    set rowcount 1

    select
      @w_secuencial = secuencial,
      @w_sec_interno = sec_interno,
      @w_productoint = productoint,
      @w_cuenta = cuenta
    from   cobis..dpf_desembargo
    order  by secuencial

    if @@rowcount = 0
      select
        @w_sec_interno = null
    while @w_sec_interno is not null
    begin
      --producto DPF
      if @w_productoint = 14
      begin
        set rowcount 0
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
          @i_bl_secuencial  = @w_sec_interno,
          @i_op_num_banco   = @w_cuenta,
          @i_oficina        = @s_ofi

        if @w_return <> 0
            or @@error <> 0
        begin
          set rowcount 1
          update cobis..cl_det_embargo
          set    de_procesa_cheque = 'N',
                 de_sec_depjud = @w_return
          where  de_ente        = @i_cliente
             and de_secuencial  = @i_secuencial
             and de_sec_interno = @w_sec_interno
             and de_num_cuenta  = @w_cuenta

          set rowcount 0
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = 'ERROR EN SP DE DPF',
            @i_num   = @w_return
          return @w_return
        end
      end

      --producto AHO
      if @w_productoint = 4
         and @w_debita_cta = 'N'
      begin
        /* Encuentra el SSN inicial */
        select
          @w_sec = se_numero
        from   cobis..ba_secuencial

        if @@rowcount <> 1
        begin
          exec cobis..sp_cerror
            @i_num = 201163
          return 201163
        end

        select
          @w_contador = count(0)
        from   cobis..dpf_desembargo

        update cobis..ba_secuencial
        set    se_numero = @w_sec + (@w_contador + 1)

        if @@rowcount <> 1
        begin
          exec cobis..sp_cerror
            @i_num = 205031 /* Error en actualizacion de SSN */
          return 205031
        end

        select
          @w_vbloqueo = isnull(hb_valor,
                               0)
        from   cob_ahorros..ah_his_bloqueo
        where  hb_cuenta in
               (select
                  ah_cuenta
                from   cob_ahorros..ah_cuenta
                where  ah_cta_banco = @w_cuenta)
               and hb_secuencial = @w_sec_interno

        set rowcount 0
        exec @w_return = cob_ahorros..sp_tr_bloq_val_ah
          @s_ssn          = @w_sec,
          @s_srv          = @s_srv,
          @s_lsrv         = @s_lsrv,
          @s_user         = @s_user,
          @s_sesn         = @s_sesn,
          @s_term         = @s_term,
          @s_date         = @s_date,
          @s_ofi          = @s_ofi,
          @s_org          = @s_org,
          @t_trn          = 218,
          @i_mon          = 0,
          @i_cta          = @w_cuenta,
          @i_accion       = 'L',
          @i_causa        = '3',-- verificar
          @i_valor        = @w_vbloqueo,--@w_monto_emb,
          @i_aut          = @w_solicitante,
          @i_observacion  = @i_observacion,
          @i_sec          = @w_sec_interno,
          @i_valida_saldo = 'N'

        if @w_return <> 0
            or @@error <> 0
        begin
          set rowcount 1

          update cobis..cl_det_embargo
          set    de_procesa_cheque = 'N',
                 de_sec_depjud = @w_return
          where  de_ente        = @i_cliente
             and de_secuencial  = @i_secuencial
             and de_sec_interno = @w_sec_interno
             and de_num_cuenta  = @w_cuenta

          set rowcount 0

          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = 'ERROR EN SP DE AHORROS',
            @i_num   = @w_return
          return @w_return
        end --debita
      end -- AHO

      update cobis..cl_det_embargo
      set    de_procesa_cheque = 'S',
             de_sec_depjud = 0
      where  de_ente        = @i_cliente
         and de_num_cuenta  = @w_cuenta
         and de_secuencial  = @i_secuencial
         and de_sec_interno = @w_sec_interno

      set rowcount 1
      select
        @w_secuencial = secuencial,
        @w_sec_interno = sec_interno,
        @w_productoint = productoint,
        @w_cuenta = cuenta
      from   cobis..dpf_desembargo
      where  secuencial > @w_secuencial
      order  by secuencial

      if @@rowcount = 0
      begin
        set rowcount 0
        break
      end
    end

    set rowcount 0

    /* Cambio estado a registro de Cabecera */
    update cl_cab_embargo
    set    ca_tipo_proceso = 'L'
    where  ca_ente         = @i_cliente
       and ca_oficio       = @i_oficio
       and ca_secuencial   = @i_secuencial
       and ca_tipo_proceso = 'B'

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103064
      return 1
    end

    /*  Transaccion de Servicio Registro Posterior */
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
    values      ( @s_ssn,@t_trn,'P',getdate(),@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_cliente,@w_secuencial,
                  @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                  @w_monto,@w_estado,@w_tipo_proceso,@w_autorizante,
                  @w_saldo_pdte,
                  @w_debita_cta,@w_oficina,@w_tipo_persona,@w_juzgado,
                  @w_concepto,
                  @w_oficina_destino,@w_tipo_doc_demandante,
                  @w_numero_doc_demandante
                  ,@w_nombre_demandante,@w_apellido_demandante,
                  @w_cuenta_especifica,@w_nro_cta_especifica,@w_reversado,
                  @w_sec_depjud,@w_fecha_reversa,
                  @w_usuario_rev,@w_observacion,@w_tipo_doc_solicitante,
                  @w_numero_doc_solicitante,@w_producto_ca)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

    /*  Transaccion de Servicio Registro Actual */
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
    values      ( @s_ssn,@t_trn,'A',getdate(),@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_cliente,@w_secuencial,
                  @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                  @w_monto,'C','L',@w_autorizante,0,
                  @w_debita_cta,@w_oficina,@w_tipo_persona,@w_juzgado,
                  @w_concepto,
                  @w_oficina_destino,@w_tipo_doc_demandante,
                  @w_numero_doc_demandante
                  ,@w_nombre_demandante,@w_apellido_demandante,
                  @w_cuenta_especifica,@w_nro_cta_especifica,@w_reversado,
                  @w_sec_depjud,@w_fecha_reversa,
                  @w_usuario_rev,@w_observacion,@w_tipo_doc_solicitante,
                  @w_numero_doc_solicitante,@w_producto_ca)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      return 1
    end

    update cl_det_embargo
    set    de_estado_levantamiento = "S",
           de_fecha_levantamiento = @i_fecha,
           de_observacion = @i_observacion
    where  de_ente        = @i_cliente
       and de_secuencial  = @i_secuencial
       and de_sec_interno = @i_sec_interno

    /* Si no encuentra Registros muestra error */
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103064
      return 1
    end

    if (@w_productoint = 3
         or @w_productoint = 4)
    begin
      exec @w_return = cobis..sp_saldo_min_embargado
        @s_srv     = @s_srv,
        @s_user    = @s_user,
        @s_term    = @s_term,
        @s_ofi     = @s_ofi,
        @s_date    = @s_date,
        @t_trn     = 1432,-- Cancelacion o levantamiento de un Embargo = 1432
        @i_oper    = 'C',--Cancelacion o levantamiento de Embargo
        @i_cod_emb = @o_secuencial,
        @i_cliente = @i_cliente

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

    return 0
  end --opearcion I

  if @i_operacion = 'O'
  begin
    /*** JAL Desembargo Forzoso ***/
    if @t_trn = 1432
    begin
      begin tran
      select
        @w_accion = ca_debita_cta,
        @w_solicitante = ca_solicitante,
        @w_demandante = ca_demandante,
        @w_producto1 = ca_producto,
        @w_oficio = ca_oficio
      from   cobis..cl_cab_embargo
      where  ca_ente       = @i_cliente
         and ca_secuencial = @i_secuencial

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 202020
        return 1
      end

      delete dpf_desembargo
      insert into dpf_desembargo
                  (secuencial,sec_interno,productoint,cuenta)
        select
          secuencial = 0,sec_interno = de_sec_interno,productoint = de_producto,
          cuenta
          =
          de_num_cuenta
        from   cobis..cl_det_embargo
        where  de_ente                 = @i_cliente
           and de_secuencial           = @i_secuencial
           and de_estado_levantamiento = 'N'
        order  by de_producto,
                  de_num_cuenta,
                  de_secuencial

      select
        @w_sec = 0

      select
        @w_sec = 1
      update cobis..dpf_desembargo
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      set rowcount 1
      select
        @w_secuencialw = secuencial,
        @w_sec_interno = sec_interno,
        @w_productoint = productoint,
        @w_cuenta = cuenta
      from   cobis..dpf_desembargo
      order  by secuencial

      if @@rowcount = 0
        select
          @w_sec_interno = null
      while @w_sec_interno is not null
      begin
        --producto DPF
        if @w_productoint = 14
        begin
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
            @i_bl_secuencial  = @w_sec_interno,
            @i_op_num_banco   = @w_cuenta,
            @i_oficina        = @s_ofi
          if @w_return <> 0
              or @@error <> 0
          begin
            set rowcount 1

            update cobis..cl_det_embargo
            set    de_procesa_cheque = 'N',
                   de_sec_depjud = @w_return
            where  de_ente        = @i_cliente
               and de_secuencial  = @i_secuencial
               and de_sec_interno = @w_sec_interno
               and de_num_cuenta  = @w_cuenta

            set rowcount 0
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101082
            return 101082
          end
          update cobis..cl_det_embargo
          set    de_procesa_cheque = 'S',
                 de_sec_depjud = 0
          where  de_ente        = @i_cliente
             and de_num_cuenta  = @w_cuenta
             and de_secuencial  = @i_secuencial
             and de_sec_interno = @w_sec_interno
        end --prod DPF

        --producto AHO
        if @w_productoint = 4
            or @w_productoint = 3
        begin
          select
            @o_saldo_pdte = ca_saldo_pdte
          from   cobis..cl_cab_embargo
          where  ca_ente         = @i_cliente
             and ca_oficio       = @i_oficio
             and ca_secuencial   = @i_secuencial
             and ca_tipo_proceso = 'B'

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101000
            return 1
          end

          select
            @w_accion = ca_debita_cta,
            @w_solicitante = ca_solicitante,
            @w_demandante = ca_demandante,
            @w_producto1 = ca_producto,
            @w_oficio = ca_oficio
          from   cobis..cl_cab_embargo
          where  ca_ente       = @i_cliente
             and ca_secuencial = @i_secuencial

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 202020
            return 1
          end

          if @w_accion = 'N'
          begin
            /* Encuentra el SSN inicial */
            select
              @w_sec = se_numero
            from   cobis..ba_secuencial

            if @@rowcount <> 1
            begin
              exec cobis..sp_cerror
                @i_num = 201163
              return 201163
            end

            select
              @w_contador = count(0)
            from   cobis..dpf_desembargo

            update cobis..ba_secuencial
            set    se_numero = @w_sec + (@w_contador + 1)
            if @@rowcount <> 1
            begin
              exec cobis..sp_cerror
                @i_num = 205031 /* Error en actualizacion de SSN */
              return 205031
            end

            select
              @w_vbloqueo = isnull(hb_valor,
                                   0)
            from   cob_ahorros..ah_his_bloqueo
            where  hb_cuenta in
                   (select
                      ah_cuenta
                    from   cob_ahorros..ah_cuenta
                    where  ah_cta_banco = @w_cuenta)
                   and hb_secuencial = @w_sec_interno

            --         if @w_productoint = 4 and  @w_sec_interno > 0  begin
            if @w_productoint = 4
               and @w_vbloqueo > 0
            begin
              exec @w_return = cob_ahorros..sp_tr_bloq_val_ah
                @s_ssn    = @w_sec,
                @s_srv    = @s_srv,
                @s_lsrv   = @s_lsrv,
                @s_user   = @s_user,
                @s_sesn   = @s_sesn,
                @s_term   = @s_term,
                @s_date   = @s_date,
                @s_ofi    = @s_ofi,
                @s_org    = @s_org,
                @t_trn    = 218,
                @i_mon    = 0,
                @i_cta    = @w_cuenta,
                @i_accion = 'L',
                @i_causa  = '3',
                @i_valor  = @w_vbloqueo,
                @i_aut    = @w_solicitante,
                @i_sec    = @w_sec_interno

              if @w_return <> 0
                  or @@error <> 0
              begin
                exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return
                return @w_return
              end
              select
                @w_sec = @w_sec + 1
            end --producto 4

            if @w_productoint = 3
               and @w_sec_interno > 0
            begin
              exec @w_return = cob_cuentas..sp_tr_bloq_val_cc
                @s_ssn    = @s_ssn,
                @s_srv    = @s_srv,
                @s_lsrv   = @s_lsrv,
                @s_user   = @s_user,
                @s_sesn   = @s_sesn,
                @s_term   = @s_term,
                @s_date   = @s_date,
                @s_ofi    = @s_ofi,
                @s_org    = @s_org,
                @t_trn    = 10,
                @i_mon    = 0,
                @i_cta    = @w_cuenta,
                @i_accion = 'L',
                @i_causa  = '3',
                @i_valor  = @i_monto_emb,
                @i_aut    = @i_autorizante,
                @i_oficio = @i_oficio,
                @i_sec    = @w_sec_int
              if @w_return <> 0
                  or @@error <> 0
              begin
                exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return
                return @w_return
              end
              select
                @w_sec = @w_sec + 1
            end -- producto 3

          end --  if @w_accion = "N"

          exec @w_return = cobis..sp_saldo_min_embargado
            @s_srv     = @s_srv,
            @s_user    = @s_user,
            @s_term    = @s_term,
            @s_ofi     = @s_ofi,
            @s_date    = @s_date,
            @t_trn     = 1432,
            -- Cancelacion o levantamiento de un Embargo = 1432
            @i_oper    = 'C',--Cancelacion o levantamiento de Embargo
            @i_cod_emb = @i_secuencial,
            @i_cliente = @i_cliente

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

        end --(@i_producto = 'CTE' Or @i_producto = 'AHO')

        select
          @w_sec = @w_sec + 1

        select
          @w_secuencialw = secuencial,
          @w_sec_interno = sec_interno,
          @w_productoint = productoint,
          @w_cuenta = cuenta
        from   cobis..dpf_desembargo
        where  secuencial > @w_secuencialw
        order  by secuencial

        if @@rowcount = 0
        begin
          set rowcount 0
          break
        end
      end

      /* Cambio estado a registro de Cabecera */
      update cl_cab_embargo
      set    ca_estado = 'C',
             ca_tipo_proceso = 'L',
             ca_saldo_pdte = 0
      where  ca_ente         = @i_cliente
         and ca_oficio       = @i_oficio
         and ca_secuencial   = @i_secuencial
         and ca_tipo_proceso = 'B'

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103064
        return 1
      end

      if @w_accion = 'S'
      begin
        select
          @w_cong_prod = de_producto,
          @w_cong_ncta = de_num_cuenta,
          @w_tipo_bloqueo = de_tipo_bloqueo,
          @w_observa = de_observacion,
          @w_secint = de_sec_interno
        from   cobis..cl_det_embargo
        where  de_ente        = @i_cliente
           and de_observacion = 'CONGELAMIENTO AUTOMATICO'
           and de_secuencial in
               (select
                  ca_secuencial
                from   cobis..cl_cab_embargo
                where  ca_ente         = @i_cliente
                   and ca_oficio       = @i_oficio
                   and ca_tipo_proceso = 'C')

        if @w_cong_prod = 4
        begin
          select
            @w_producto2 = '4'
          select
            @w_secuencial11 = isnull(cb_secuencial,
                                     0)
          from   cob_ahorros..ah_ctabloqueada
          where  cb_cuenta in
                 (select
                    ah_cuenta
                  from   cob_ahorros..ah_cuenta
                  where  ah_cta_banco = @w_cong_ncta)
                 and cb_tipo_bloqueo = '2'
                 and cb_estado       = 'V'
        end

        if @w_cong_prod = 3
        begin
          select
            @w_producto2 = '3'
          select
            @w_secuencial11 = isnull(cb_secuencial,
                                     0)
          from   cob_cuentas..cc_ctabloqueada
          where  cb_cuenta in
                 (select
                    cc_ctacte
                  from   cob_cuentas..cc_ctacte
                  where  cc_cta_banco = @w_cong_ncta)
                 and cb_tipo_bloqueo = '2'
                 and cb_estado       = 'V'
        end

        if @w_secuencial11 = @w_secint
           and @w_cong_prod in(3, 4)
           and @w_observa = 'CONGELAMIENTO AUTOMATICO'
        begin
          /* Registrar el descongelamiento */
          exec @w_return = sp_descongela
            @s_ssn          = @s_ssn,
            @s_srv          = @s_srv,
            @s_user         = 'embargos',
            @s_term         = @s_term,
            @s_date         = @w_fecha_proceso,
            @s_lsrv         = @s_lsrv,
            @s_ofi          = @s_ofi,
            @s_org          = @s_org,
            @t_trn          = 1447,
            @s_sesn         = @s_sesn,
            @i_cliente      = @i_cliente,
            @i_linea        = 'S',
            @i_operacion    = 'I',
            @i_fecha        = @i_fecha,
            @i_oficio       = @i_oficio,
            @i_fecha_ofi    = @i_fecha_ofi,
            @i_solicitante  = @w_solicitante,
            @i_demandante   = @w_demandante,
            @i_tipo_proceso = 'D',
            @i_autorizante  = @i_autorizante,
            @i_estado       = @i_estado,
            @i_estado_lev   = @i_estado_lev,
            @i_num_cta      = @w_cong_ncta,
            @i_producto     = @w_producto2,
            @i_observacion  = @i_observacion
          if @w_return <> 0
              or @@error <> 0
          begin
            /*'Error retornado por ahorros'*/
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = @w_return
            return 1 --@w_return
          end

        end
        select
          @w_sec = @w_sec + 1

      end --  if @w_accion = "S"

      select
        @o_monto = de_monto,
        @o_num_cta = de_num_cuenta,
        @w_tipo_bloq = de_tipo_bloqueo,
        @w_estado = 'S',
        @w_producto = de_producto,
        @w_subproducto = de_subproducto
      from   cobis..cl_det_embargo
      where  de_ente        = @i_cliente
         and de_secuencial  = @i_secuencial
         and de_sec_interno = @i_sec_interno

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103064
        return 1
      end

      select
        @i_observacion = @i_observacion + " *Embargo Forzoso*"
      update cl_det_embargo
      set    de_estado_levantamiento = "S",
             de_fecha_levantamiento = @s_date,
             de_observacion = @i_observacion
      where  de_ente        = @i_cliente
         and de_secuencial  = @i_secuencial
         and de_sec_interno = @i_sec_interno

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103064
        return 1
      end

      insert into cl_det_embargo
                  (de_ente,de_secuencial,de_sec_interno,de_fecha,de_producto,
                   de_subproducto,de_monto,de_tipo_bloqueo,
                   de_estado_levantamiento
                   ,
                   de_num_cuenta,
                   de_observacion,de_fecha_levantamiento)
      values      ( @i_cliente,(@i_secuencial),(@i_sec_interno + 100),@s_date,
                    convert(int, @w_producto),
                    @w_subproducto,@o_saldo_pdte,@w_tipo_bloq,@w_estado,
                    @o_num_cta
                    ,
                    @i_observacion,@s_date)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143049
        return 1
      end

      commit tran
    end
  end

  return 0

go

