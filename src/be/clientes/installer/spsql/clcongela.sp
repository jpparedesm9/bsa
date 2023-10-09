/************************************************************************/
/*      Archivo:                clcongela.sp                            */
/*      Stored procedure:       sp_congela                              */
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
/*    Este programa procesa las transacciones de Congelamientos de los  */
/*    Prod. de Ahorros, Corrientes y Plazo Fijo de un Cliente, sobre    */
/*    la tabla cl_cab_embargo                                           */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*       FECHA           AUTOR               RAZON                      */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_congela')
  drop proc sp_congela

go

create proc sp_congela
(
  @s_ssn             int = null,
  @s_sesn            int = null,
  @s_user            varchar(14) = null,
  @s_term            varchar(30) = null,
  @s_date            datetime = null,
  @s_srv             varchar(30) = null,
  @s_lsrv            varchar(30) = null,
  @s_ofi             smallint = null,
  @s_rol             smallint = null,
  @s_org_err         char(1) = null,
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_msg             varchar(64) = null,
  @s_org             char(1) = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(10) = null,
  @t_from            varchar(32) = null,
  @t_trn             smallint = null,
  @t_show_version    bit = 0,
  @i_operacion       char(1) = null,
  @i_cliente         int,
  @i_fecha           datetime = null,
  @i_oficio          varchar(16) = null,
  @i_solicitante     varchar(64) = null,
  @i_demandante      varchar(64) = null,
  @i_tipo_proceso    char(1) = null,
  @i_autorizante     varchar(14) = null,
  @i_estado          char(1) = null,
  @i_secuencial      int = null,
  @i_producto        varchar(3) = null,
  @i_subproducto     varchar(30) = null,
  @i_estado_lev      char(1) = null,
  @i_num_cta         varchar(24) = null,
  @i_sec_modulo      int = null,
  @i_tbloq           tinyint = null,
  @i_tipo_doc_soicit varchar(10) = null,
  @i_num_doc_solicit varchar(30) = null,
  @i_tipo_doc_deman  varchar(10) = null,
  @i_num_doc_deman   varchar(30) = null,
  @i_observacion     varchar(60) = 'EN LINEA',
  @i_mon             tinyint = null,
  @i_linea           char(1) = 'S'
)
as
  declare
    @w_secuencial             int,
    @w_sec_prod               int,
    @w_fecha_proceso          datetime,
    @w_error                  int,
    @w_fecha                  datetime,
    @w_fecha_ofi              datetime,
    @w_oficio                 varchar(16),
    @w_solicitante            varchar(64),
    @w_demandante             varchar(64),
    @w_monto                  money,
    @w_estado                 char(1),
    @w_tipo_proceso           char(1),
    @w_autorizante            login,
    @w_producto               tinyint,
    @w_subproducto            smallint,
    @w_tipo_bloq              tinyint,
    @w_return                 int,
    @w_sp_name                varchar (32),
    @w_seqnos                 int,
    @w_sec_modulo             int,
    @w_newsaldo               money,
    @w_falta                  money,
    @w_tbloq                  char(3),
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
    @w_observa                varchar(10),
    @w_cantidad               smallint,
    @w_cantidad_cong          smallint,
    @w_msgconge               descripcion,
    @w_siguientedet           int,
    @o_siguiente              int,
    @o_siguiente2             int,
    @o_secuencial             int,
    @o_fecha                  datetime,
    @o_oficio                 varchar(16),
    @o_solicitante            varchar(64),
    @o_demandante             varchar(64),
    @o_monto                  money,
    @o_saldo_pdte             money,
    @o_seclientes             int

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --U2 V6
  select
    @w_sp_name = 'sp_congela'
  select
    @w_msgconge = 'CONGELAMIENTO MANUAL/OPERATIVO'
  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_tbloq = convert(char(3), @i_tbloq)

  /*** Insert ***/

  if @i_operacion = 'I'
  begin
    select
      @w_cantidad = isnull(count(0),
                           0)
    from   cl_cab_embargo
    where  ca_oficio               = @i_oficio
       and isnull(ca_reversado,
                  '') <> 'S'
       and ca_tipo_proceso in('C')

    if @w_cantidad > 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103064,
        @i_msg  = 'Congelamiento con ese oficio ya existe en la base de datos'
      return 1
    end

    begin tran
    select
      @w_secuencial = 0

    if @i_observacion = "CONGELAMIENTO MANUAL/OPERATIVO"
    begin
      select
        @w_tbloq = convert(char(3), @i_tbloq)
      if @i_producto = 'AHO'
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

      if @i_producto = 'CTE'
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
    end --manual

    if @i_observacion <> "CONGELAMIENTO MANUAL/OPERATIVO"
    begin
      if @i_producto = 'AHO'
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
               and cb_tipo_bloqueo in('2', '3')
               and cb_estado = 'V'
      end

      if @i_producto = 'CTE'
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
               and cb_tipo_bloqueo in('2', '3')
               and cb_estado = 'V'
      end
    end --automatico

    if @w_secuencial = 0
    begin
      if @i_producto = 'AHO'
      begin
        select
          @w_observa = 'Embargos'

        exec @w_return = cob_ahorros..sp_tr_bloqueo_mov_ah
          @s_ssn         = @s_ssn,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_user        = 'embargos',
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_ofi         = @s_ofi,
          @s_org         = @s_org,
          @t_trn         = 211,
          @i_mon         = 0,
          @i_cta         = @i_num_cta,
          @i_causa       = '3',
          @i_aut         = @i_autorizante,
          @i_solicit     = @i_solicitante,
          @i_tbloq       = @w_tbloq,
          @i_observacion = @w_observa,
          @o_secuencial  = @w_sec_prod out

        if @w_return <> 0
        begin
          select
            @w_error = @w_return
          goto ERROR
        end
      end --prod aho

      if @i_producto = 'CTE'
      begin
        exec @w_return = cob_cuentas..sp_tr_bloq_cierre
          @s_ssn           = @s_ssn,
          @s_srv           = @s_srv,
          @s_lsrv          = @s_lsrv,
          @s_user          = @s_user,
          @s_sesn          = @s_sesn,
          @s_term          = @s_term,
          @s_date          = @s_date,
          @s_ofi           = @s_ofi,
          @s_org           = @s_org,
          @t_trn           = 11,
          @i_mon           = 0,
          @i_cta           = @i_num_cta,
          @i_causa         = '4',
          @i_aut           = @i_autorizante,
          @i_tbloq         = @w_tbloq,
          @i_demanda       = @i_demandante,
          @i_solicit       = @i_solicitante,
          @o_cb_secuencial = @w_sec_prod out
        if @w_return <> 0
        begin
          select
            @w_error = @w_return
          goto ERROR
        end
      end --prod cte

      select
        @w_sec_modulo = @w_sec_prod

    end --@w_secuencial = 0

    if @w_secuencial > 0
    begin
      select
        @w_sec_modulo = @w_secuencial
    end

    /* seleccionar el nuevo secuencial para el Congelamiento */

    select
      @w_siguientedet = isnull(max(ca_secuencial), 0) + 1
    from   cl_cab_embargo
    where  ca_ente = @i_cliente

    /* Insertar los datos de entrada */
    insert into cl_cab_embargo
                (ca_ente,ca_secuencial,ca_fecha,ca_fecha_ofi,ca_oficio,
                 ca_solicitante,ca_demandante,ca_monto,ca_estado,ca_tipo_proceso
                 ,
                 ca_autorizante,ca_saldo_pdte,
                 ca_tipo_doc_demandante,
                 ca_numero_doc_demandante,ca_tipo_doc_solicitante,
                 ca_numero_doc_solicitante)
    values      (@i_cliente,@w_siguientedet,@i_fecha,@w_fecha,@i_oficio,
                 @i_solicitante,@i_demandante,0,@i_estado,@i_tipo_proceso,
                 @i_autorizante,0,@i_tipo_doc_deman,@i_num_doc_deman,
                 @i_tipo_doc_soicit,
                 @i_num_doc_solicit)

    /* Si no se puede insertar error */
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103064
      return 1
    end

    /*  Transaccion de Servicio  */
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
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_cliente,@w_siguientedet,
                 @i_fecha,@w_fecha,@i_oficio,@i_solicitante,@i_demandante,
                 0,@i_estado,@i_tipo_proceso,@i_autorizante,0,
                 null,null,null,null,null,
                 null,@i_tipo_doc_deman,@i_num_doc_deman,null,null,
                 null,null,null,null,null,
                 null,null,@i_tipo_doc_soicit,@i_num_doc_solicit,null)

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

  /* Insercion de detalle del Congelamiento */
    /* Determino el entero del producto */

    if @i_producto = 'AHO'
      select
        @w_producto = 4

    if @i_producto = 'CTE'
      select
        @w_producto = 3

    /* Determino el entero del subproducto  */

    set rowcount 1
    if @w_producto in(3, 4)
    begin
      select
        @w_subproducto = (pb_pro_bancario)
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_pro_bancario
      where  pf_filial       = 1
         and pf_sucursal     = 1
         and pf_producto     = @w_producto
         and pf_moneda       = 0
         and pf_tipo         = 'R'
         and me_mercado      = pf_mercado
         and me_pro_bancario = pb_pro_bancario
         and pb_descripcion  = @i_subproducto
    end

    /*Insertar los datos de entrada */
    insert into cl_det_embargo
                (de_ente,de_secuencial,de_sec_interno,de_fecha,de_producto,
                 de_subproducto,de_monto,de_tipo_bloqueo,de_estado_levantamiento
                 ,
                 de_num_cuenta,
                 de_observacion)
    values      (@i_cliente,@w_siguientedet,@w_sec_modulo,@w_fecha,@w_producto,
                 @w_subproducto,0,@i_tbloq,@i_estado_lev,@i_num_cta,
                 @i_observacion)

    commit tran
    return 0
  end

  if @i_operacion = 'S'
  begin
    if @t_trn = 1443
    begin
      /*   Muestra las Cabeceras de congelamientos Insertados */
      select
        'SECUENCIAL' = ca_secuencial,
        'FECHA     ' = ca_fecha,
        'OFICIO    ' = ca_oficio,
        'SOLICITANTE' = ca_solicitante,
        'DEMANDANTE ' = ca_demandante,
        'ESTADO' = ca_estado,
        'TIPO EMB.' = ca_tipo_proceso,
        'AUTORIZA   ' = ca_autorizante,
        'SEC MODULO' = de_sec_interno,
        'CUENTA     ' = de_num_cuenta
      from   cobis..cl_cab_embargo,
             cobis..cl_det_embargo
      where  ca_ente         = @i_cliente
         and ca_ente         = de_ente
         and ca_secuencial   = de_secuencial
         and de_secuencial   = ca_secuencial
         and ca_tipo_proceso = 'C'
      order  by ca_secuencial
    end
    return 0
  end

  /* Query especifico de un embargo */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1444
    begin
      /*   Muestra las Cabeceras de embargos Insertadas */
      select
        @o_secuencial = ca_secuencial,
        @o_fecha = ca_fecha,
        @o_oficio = ca_oficio,
        @o_solicitante = ca_solicitante,
        @o_demandante = ca_demandante
      from   cl_cab_embargo
      where  ca_ente         = @i_cliente
         and ca_secuencial   = @i_secuencial
         and ca_oficio       = @i_oficio
         and ca_tipo_proceso = 'C'

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
        @o_secuencial,
        convert (char(10), @o_fecha, 101),
        @o_oficio,
        @o_solicitante,
        @o_demandante
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

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1445
    begin
      select
        @w_secuencial = ca_secuencial,
        @w_fecha = ca_fecha,
        @w_oficio = ca_oficio,
        @w_solicitante = ca_solicitante,
        @w_demandante = ca_demandante,
        @w_estado = ca_estado,
        @w_tipo_proceso = ca_tipo_proceso,
        @w_autorizante = ca_autorizante,
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
         and ca_secuencial   = @i_secuencial
         and ca_tipo_proceso = 'C'

      /* sino existe embargo */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No dato solicitado' */
        return 1
      end

      begin tran

      /* borrar el registro */
      delete from cl_cab_embargo
      where  ca_ente         = @i_cliente
         and ca_secuencial   = @i_secuencial
         and ca_tipo_proceso = 'C'

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069
        /* 'Error en eliminacion del embargo de un cliente '*/
        return 1
      end
      /*  Transaccion de Servicio  */
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
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
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
      commit tran
    end
    return 0
  end

  select
    @o_seclientes

  while @@trancount > 0
    commit tran

  return 0

  ERROR:
  if @i_linea = 'S'
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
      @i_fecha       = @w_fecha_proceso,
      @i_error       = @w_error,
      @i_usuario     = 'misbatch',
      @i_tran        = 1423,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @i_num_cta,
      @i_descripcion = 'Error retornado por el sp_congela',
      @i_rollback    = 'S'

    return @w_error
  end

go

