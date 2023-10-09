/************************************************************************/
/*      Archivo:                cldescongela.sp                         */
/*      Stored procedure:       sp_descongela                           */
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
/*    Este programa procesa las transacciones de Descongelamiento de    */
/*    fondos y Productos de un Cliente cl_cab_embargo, cl_det_embargo   */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    19/Ene/2010     O. Usi¤a        Embargos Cta. Ahorros             */
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
           where  name = 'sp_descongela')
  drop proc sp_descongela
go

create proc sp_descongela
(
  @s_ssn          int = null,
  @s_sesn         int = null,
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
  @i_cliente      int = null,
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
  @i_num_cta      cuenta = null,
  @i_producto     varchar(3) = null,
  @i_observacion  descripcion = null,
  @i_subproducto  varchar(30) = null,
  @i_linea        char(1) = 'S',
  @i_tbloq        varchar(3) = null,
  @i_desemb       char(1) = 'N'
)
as
  declare
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
    @w_producto               varchar(3),--int,
    @w_subproducto            int,
    @w_tipo_bloq              tinyint,
    @w_return                 int,
    @w_sp_name                varchar (32),
    @w_seqnos                 int,
    @w_newsaldo               money,
    @w_falta                  money,
    @w_error                  int,
    @w_contador               int,
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
    @w_fecha_date             datetime,
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
    @o_subproducto            tinyint,
    @o_tbloq                  tinyint,
    @w_observa                varchar(120),
    @o_registrado             datetime,
    @o_funcionario            login,
    @o_modificado             datetime,
    @o_observacion            descripcion

  --U2 V9
  select
    @w_sp_name = 'sp_descongela'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Parametros Generales */
  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  /*** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1447
    begin
      if @i_producto = '4'
        select
          @w_producto = 'AHO'

      if @i_producto = '3'
        select
          @w_producto = 'CTE'

      begin tran
      if @i_observacion = 'DESCONGELAMIENTO MANUAL/OPERATIVO'
      begin
        if @w_producto = 'AHO'
        begin
          select
            @w_secuencial = isnull(cb_secuencial,
                                   0)
          from   cob_ahorros..ah_ctabloqueada
          where  cb_cuenta in
                 (select
                    ah_cuenta
                  from   cob_ahorros..ah_cuenta
                  where  ah_cta_banco = @i_num_cta)
                 and cb_tipo_bloqueo = @i_tbloq
                 and cb_estado       = 'V'
        end

        if @w_producto = 'CTE'
        begin
          select
            @w_secuencial = isnull(cb_secuencial,
                                   0)
          from   cob_cuentas..cc_ctabloqueada
          where  cb_cuenta in
                 (select
                    cc_ctacte
                  from   cob_cuentas..cc_ctacte
                  where  cc_cta_banco = @i_num_cta)
                 and cb_tipo_bloqueo = @i_tbloq
                 and cb_estado       = 'V'
        end

        select
          @w_contador = isnull(count(0),
                               0)
        from   cobis..cl_det_embargo,
               cobis..cl_cab_embargo
        where  de_num_cuenta   = @i_num_cta
           and de_producto     = convert(int, @i_producto)
           and de_ente         = ca_ente
           and de_secuencial   = ca_secuencial
           and ca_estado       = 'C'
           and ca_tipo_proceso = 'C'
           and de_sec_interno  = @w_secuencial

        if @w_contador <= 1
        begin
          select
            @w_observa = 'Embargos ' + ltrim(rtrim(@i_demandante)) + ' Oficio: '
                         +
                         ltrim
                         (
                                rtrim(
                                @i_oficio) )
                         + ' DESCONGELAMIENTO CLIENTES'
          if @w_producto = 'AHO'
          begin
            exec @w_return = cob_ahorros..sp_tr_bloqueo_mov_ah
              @s_ssn         = @s_ssn,
              @s_srv         = @s_srv,
              @s_lsrv        = @s_lsrv,
              @s_user        = @s_user,
              @s_sesn        = @s_sesn,
              @s_term        = @s_term,
              @s_date        = @w_fecha,
              @s_ofi         = @s_ofi,
              @s_org         = @s_org,
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @t_trn         = 212,
              @i_mon         = 0,
              @i_cta         = @i_num_cta,
              @i_tbloq       = @i_tbloq,
              @i_aut         = @s_user,
              @i_causa       = '3',
              @i_solicit     = @i_solicitante,
              @i_observacion = @w_observa

            if @w_return <> 0
                or @@error <> 0
            begin
              select
                @w_error = @w_return

              goto ERROR
            end
          end -- congelamiento  AHO

          if @w_producto = 'CTE'
          begin
            exec @w_return = cob_cuentas..sp_tr_bloq_cierre
              @s_ssn     = @s_ssn,
              @s_srv     = @s_srv,
              @s_lsrv    = @s_lsrv,
              @s_user    = @s_user,
              @s_sesn    = @s_sesn,
              @s_term    = @s_term,
              @s_date    = @w_fecha,
              @s_ofi     = @s_ofi,
              @s_org     = @s_org,
              @t_debug   = @t_debug,
              @t_file    = @t_file,
              @t_from    = @w_sp_name,
              @t_trn     = 12,
              @i_mon     = 0,
              @i_cta     = @i_num_cta,
              @i_tbloq   = @i_tbloq,
              @i_aut     = @s_user,
              @i_causa   = '3',
              @i_accion  = 'B',
              @i_solicit = @i_solicitante,
              @i_oficio  = @i_oficio,
              @i_demanda = @i_demandante

            if @w_return <> 0
            begin
              select
                @w_error = @w_return
              goto ERROR
            end
          end
        end --contador
      end --manual

      if @i_observacion <> 'DESCONGELAMIENTO MANUAL/OPERATIVO'
      begin
        select
          @w_contador = isnull(count(0),
                               0)
        from   cobis..cl_det_embargo,
               cobis..cl_cab_embargo
        where  de_num_cuenta   = @i_num_cta
           and de_producto     = convert(int, @i_producto)
           and de_ente         = ca_ente
           and de_secuencial   = ca_secuencial
           and ca_estado       = 'P'
           and ca_tipo_proceso = 'B'
           and ca_debita_cta   = 'S'

        if @w_contador <= 1
        begin
          select
            @w_observa = 'Embargos ' + ltrim(rtrim(@i_demandante)) + ' Oficio: '
                         +
                         ltrim
                         (
                                rtrim(
                                @i_oficio) )
                         + ' DESCONGELAMIENTO CLIENTES'
          if @w_producto = 'AHO'
          begin
            exec @w_return = cob_ahorros..sp_tr_bloqueo_mov_ah
              @s_ssn         = @s_ssn,
              @s_srv         = @s_srv,
              @s_lsrv        = @s_lsrv,
              @s_user        = @s_user,
              @s_sesn        = @s_sesn,
              @s_term        = @s_term,
              @s_date        = @w_fecha,
              @s_ofi         = @s_ofi,
              @s_org         = @s_org,
              @t_debug       = @t_debug,
              @t_file        = @t_file,
              @t_from        = @w_sp_name,
              @t_trn         = 212,
              @i_mon         = 0,
              @i_cta         = @i_num_cta,
              @i_tbloq       = '2',
              @i_aut         = @s_user,
              @i_causa       = '3',
              @i_solicit     = @i_solicitante,
              @i_observacion = @w_observa

            if @w_return <> 0
                or @@error <> 0
            begin
              select
                @w_error = @w_return

              goto ERROR
            end
          end -- congelamiento  AHO

          if @w_producto = 'CTE'
          begin
            exec @w_return = cob_cuentas..sp_tr_bloq_cierre
              @s_ssn     = @s_ssn,
              @s_srv     = @s_srv,
              @s_lsrv    = @s_lsrv,
              @s_user    = @s_user,
              @s_sesn    = @s_sesn,
              @s_term    = @s_term,
              @s_date    = @w_fecha,
              @s_ofi     = @s_ofi,
              @s_org     = @s_org,
              @t_debug   = @t_debug,
              @t_file    = @t_file,
              @t_from    = @w_sp_name,
              @t_trn     = 12,
              @i_mon     = 0,
              @i_cta     = @i_num_cta,
              @i_tbloq   = '2',
              @i_aut     = @s_user,
              @i_causa   = '3',
              @i_accion  = 'B',
              @i_solicit = @i_solicitante,
              @i_oficio  = @i_oficio,
              @i_demanda = @i_demandante

            if @w_return <> 0
            begin
              select
                @w_error = @w_return
              goto ERROR
            end
          end
        end -- contador = 1
      end -- if @i_observacion<> 'DESCONGELAMIENTO MANUAL/OPERATIVO' begin

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
         and ca_tipo_proceso = 'C'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 108080
        /*  'No existe dato solicitado'*/
        return 1
      end

      /* Cambio estado a registro de Cabecera */
      update cl_cab_embargo
      set    ca_tipo_proceso = 'D' --Descongelamiento
      where  ca_ente         = @i_cliente
         and ca_oficio       = @i_oficio
         and ca_tipo_proceso = 'C'

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
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_cliente,@w_secuencial,
                   @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                   @w_monto,@w_estado,@w_tipo_proceso,@w_autorizante,
                   @w_saldo_pdte
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

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
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
                   @s_term,@s_srv,@s_lsrv,@i_cliente,@w_secuencial,
                   @w_fecha,@w_fecha_ofi,@w_oficio,@w_solicitante,@w_demandante,
                   @w_monto,@w_estado,'D',@w_autorizante,@w_saldo_pdte,
                   @w_debita_cta,@w_oficina,@w_tipo_persona,@w_juzgado,
                   @w_concepto
                   ,
                   @w_oficina_destino,@w_tipo_doc_demandante,
                   @w_numero_doc_demandante,
                   @w_nombre_demandante,@w_apellido_demandante,
                   @w_cuenta_especifica,@w_nro_cta_especifica,@w_reversado,
                   @w_sec_depjud,@w_fecha_reversa,
                   @w_usuario_rev,@w_observacion,@w_tipo_doc_solicitante,
                   @w_numero_doc_solicitante,@w_producto_ca)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /* Actualizo los registros correspondientes del detalle */
      update cl_det_embargo
      set    de_estado_levantamiento = "S",
             de_fecha_levantamiento = @w_fecha,
             de_observacion = @i_observacion
      where  de_ente       = @i_cliente
         and de_secuencial = @i_secuencial

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

      commit tran
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  if @i_operacion = 'S'
  begin
    if @t_trn = 1448
    begin
      /* Muestra las Cabeceras de embargos Levantados */
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = convert (char(10), ca_fecha, 101),
        'FECHA OFI ' = convert (char(10), ca_fecha_ofi, 101),
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_demandante,
        'MONTO      ' = ca_monto,
        'PENDIENTE  ' = ca_saldo_pdte,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'CUENTA     ' = de_num_cuenta,
        'PRODUCTO   ' = de_producto,
        'SEC MODULO' = de_sec_interno,
        'OBSERVACION' = de_observacion
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente         = @i_cliente
         and ca_ente         = de_ente
         and ca_secuencial   = de_secuencial
         and ca_tipo_proceso = 'C'
         and ca_estado       = 'C'
         and de_producto     <> 14
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
  end

  /* Query especifico de un embargo */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1449
    begin
      /*Muestra las Cabeceras de embargos Insertadas */
      select
        @o_secuencial = ca_secuencial,
        @o_fecha_ofi = ca_fecha_ofi,
        @o_oficio = ca_oficio,
        @o_solicitante = ca_solicitante,
        @o_demandante = ca_demandante,
        @o_monto = ca_monto,
        @o_saldo_pdte = isnull(ca_saldo_pdte,
                               0),
        @o_num_cta = de_num_cuenta,
        @o_producto = de_producto,
        @o_secinterno = de_sec_interno,
        @o_tbloq = de_tipo_bloqueo,
        @o_subproducto = de_subproducto,
        @o_registrado = ca_fecha,
        @o_funcionario = ca_autorizante,
        @o_observacion = de_observacion
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente         = @i_cliente
         and ca_ente         = de_ente
         and de_ente         = ca_ente
         and ca_secuencial   = de_secuencial
         and de_secuencial   = ca_secuencial
         and ca_secuencial   = @i_secuencial
         and ca_oficio       = @i_oficio
         and de_producto     <> 14
         and ca_tipo_proceso = "C"

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
        @o_tbloq,
        @o_subproducto,
        @o_registrado,
        @o_funcionario,
        @o_modificado,
        @o_observacion
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  --while @@trancount > 0
  --   commit tran

  return 0

  ERROR:
  if @i_linea = "S"
  begin
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = @w_error
    return @w_error
  end
  else
  begin
    exec sp_errorlog
      @i_fecha       = @w_fecha,
      @i_error       = @w_error,
      @i_usuario     = 'misbatch',
      @i_tran        = 1423,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @i_num_cta,
      @i_descripcion = 'Error retornado por el sp de descongelamiento',
      @i_rollback    = 'S'
    return @w_error
  end

go

