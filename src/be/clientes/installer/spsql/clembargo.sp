/************************************************************************/
/*      Archivo:                clembargo.sp                            */
/*      Stored procedure:       sp_embargo                              */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
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
/*    Este programa procesa las transacciones de Embargo de fondos      */
/*    de un Cliente cl_cab_embargo, cl_det_embargo                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR            RAZON                              */
/*  04/Feb/2010    O. Usi¤a          Embragos Cuenta ahorros            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_embargo')
  drop proc sp_embargo
go

create proc sp_embargo
(
  @s_ssn                   int = null,
  @s_user                  login = null,
  @s_term                  varchar(30) = null,
  @s_date                  datetime = null,
  @s_srv                   varchar(30) = null,
  @s_lsrv                  varchar(30) = null,
  @s_ofi                   smallint = null,
  @s_rol                   smallint = null,
  @s_org_err               char(1) = null,
  @s_error                 int = null,
  @s_sev                   tinyint = null,
  @s_msg                   descripcion = null,
  @s_org                   char(1) = null,
  @s_sesn                  int,
  @t_debug                 char(1) = 'N',
  @t_file                  varchar(10) = null,
  @t_from                  varchar(32) = null,
  @t_trn                   smallint = null,
  @t_show_version          bit = 0,
  @c_fecha                 datetime = null,
  @i_operacion             char(1) = null,
  @i_linea                 char(1) = 'S',
  @i_cliente               int = null,
  @i_fecha                 datetime = null,
  @i_fecha_ofi             datetime = null,
  @i_oficio                varchar(16) = null,
  @i_solicitante           varchar(64) = 'BANCAMIA',
  @i_demandante            varchar(64) = null,
  @i_monto                 money = null,
  @i_monto_emb             money = null,
  @i_interes               money = null,
  @i_saldo_pdte            money = null,
  @i_tipo_proceso          char(1) = null,
  @i_autorizante           login = null,
  @i_estado                varchar(10) = null,
  @i_estado_lev            char(1) = null,
  @i_secuencial            int = null,
  @i_num_cta               cuenta = null,
  @i_producto              varchar(10) = null,
  @i_subproducto           varchar(30) = null,
  @i_observacion           varchar(30) = 'COBRO EN LINEA',
  @i_sec_modulo            int = null,
  @i_oficina               smallint = null,
  @i_debita_cta            char(1) = null,
  @i_tipo_persona          char(1) = null,
  @i_juzgado               varchar(64) = null,
  @i_concepto              tinyint = null,
  @i_oficina_destino       smallint = null,
  @i_tipo_doc_demandante   char(2) = null,
  @i_numero_doc_demandante varchar(13) = null,
  @i_nombre_demandante     varchar(20) = null,
  @i_apellido_demandante   varchar(30) = null,
  @i_tipo_doc_demandado    char(2) = null,
  @i_numero_doc_demandado  varchar(13) = null,
  @i_nombre_demandado      varchar(20) = null,
  @i_apellido_demandado    varchar(30) = null,
  @i_cuenta_especifica     char(1) = null,
  @i_nro_cta_especifica    cuenta = null,
  @i_sec_depjud            int = null,
  @i_modulo                tinyint = null,
  @i_mmi                   varchar(10) = null,
  @i_subtipo               char(1) = null,
  @i_modo                  int = null,
  @i_siguiente             int = null,
  @i_tembargo              varchar(10) = null,
  @o_seclientes            int = null out,
  @o_saldopdte             money = null out,
  @o_siguiente             int = null out,
  @o_siguiente2            int = null out,
  @o_secuencial            int = null out,
  @o_fecha_ofi             datetime = null out,
  @o_cod_deposito          int = null out,
  @o_oficio                varchar(16) = null out,
  @o_solicitante           varchar(64) = null out,
  @o_demandante            varchar(64) = null out,
  @o_monto                 money = null out,
  @o_saldo_pdte            money = null out,
  @o_existe                char(1) = null out,
  @o_juzgado               varchar(64) = null out,
  @o_concepto              catalogo = null out,
  @o_tido_doc              catalogo = null out,
  @o_numero_id             varchar(13) = null out,
  @o_apellido_demandante   varchar(30) = null out,
  @o_cuenta                varchar(20) = null out,
  @o_debita_cuenta         char(1) = null out,
  @o_cta_especifica        varchar(20) = null out,
  @o_mmi                   varchar(10) = null out,
  @o_base_gmf              money = 0 out,-- Devuelve base calculo gmf
  @o_tasa                  float = 0 out,-- Devuelve la tasa aplicada
  @o_difer_gmf             money = 0 out,

  -- Devuelve la diferencia para calculo gmf
  @o_total_gmf             money = 0 out,-- GMF Calculado
  @o_especifica            char(1) = null out,-- cta_especifica 'S/N'
  @o_estado                char(1) = null out,
  @o_registrado            datetime = null out,
  @o_funcionario           login = null out,
  @o_modificado            datetime = null out
)
as
  declare
    @w_error            int,
    @w_sp_name          varchar(64),
    @w_fecha_proceso    datetime,
    @w_commit           char(1),
    @w_secuencial       int,
    @w_fecha            datetime,
    @w_fecha_ofi        datetime,
    @w_oficio           varchar(16),
    @w_solicitante      varchar(64),
    @w_demandante       varchar(64),
    @w_monto            numeric(18, 2),
    @w_estado           char(1),
    @w_tipo_proceso     char(1),
    @w_autorizante      login,
    @w_producto         int,
    @w_subproducto      int,
    @w_tipo_bloq        tinyint,
    @v_tipo_bloq        char(3),
    @w_return           int,
    @w_seqnos           int,
    @w_sec_modulo       tinyint,
    @w_newsaldo         money,
    @w_falta            money,
    @w_siguiente        int,
    @w_producto1        varchar(10),
    @w_producto2        varchar(10),
    @w_congelado        int,
    @w_valor_emb        money,
    @w_valor_3xmil      money,
    @w_causa            char(1),
    @w_ok               char(1),
    @w_cod_deposito     int,
    @w_sec_prod         int,
    @w_sec_prod_chq     int,
    @w_concepto         varchar(10),
    @w_ofdestino        varchar(10),
    @w_numdeciimp       tinyint,
    @w_piva             float,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_impuesto         money,
    @w_val_emb          money,
    @w_imp_emb          money,
    @w_imp_embii        money,
    @w_dif_emb          money,
    @w_valor_cobro      numeric(18, 2),
    @w_3xmil            char(1),
    @w_cta              int,
    @w_spendiente       money,
    @w_autorizante1     login,
    @w_rollback         char(1),
    @w_pardian          varchar(10),
    @w_parsuper         varchar(10),
    @w_descr            varchar(132),
    @w_fecha_error      datetime,
    @w_oficina2         smallint,
    @w_cuenta           cuenta,
    @w_marca_gmf        char(1),
    @w_monto1           numeric(18, 2),
    @w_montoSin         numeric(18, 2),
    @w_montoCon         numeric(20, 2),
    @w_monto_diferencia money,
    @w_redcero          tinyint,
    @w_moneda           tinyint,
    @w_monto_inemb      money,
    @w_total_gmf        money,-- GMF Calculado
    @w_acumu_deb        money,-- Devuelve acumulado debitos
    @w_actualiza        char(1),-- Indicador para actualizar acumulado
    @w_base_gmf         money,-- Devuelve base calculo gmf
    @w_tasa             float,-- Devuelve la tasa aplicada
    @w_difer_gmf        money,-- Devuelve la diferencia para calculo gmf
    @w_val_2x1000       float,
    @w_papel            smallint,
    @w_primera_cta      cuenta,
    @w_saldo            money,
    @w_cong_prod        tinyint,
    @w_cong_ncta        varchar(16),
    @w_tembargo         tinyint,
    @w_estadoN          char(1),
    @w_observa          varchar(64),--Envia obsevacion ahorros
    @w_sec_conge        int,
    @w_tipo_ced         varchar(10),
    @w_natjur           varchar(10),
    @w_campo1           varchar(30),
    @w_ced_ruc          varchar(30),
    @w_nombre           varchar(60),
    @w_num_orden        int,
    @w_user             login,
    @w_congelamiento    smallint,
    @w_tipo_emb         char(1)

  --U2 V9
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* CARGA INICIAL DE VARIABLES DE TRABAJO */

  select
    @w_sp_name = 'sp_embargo'
  select
    @w_commit = 'N'
  select
    @w_valor_cobro = (@i_monto_emb + (isnull(@i_interes,
                                             0)))
  select
    @w_fecha_error = getdate()
  select
    @w_concepto = convert(varchar(10), @i_concepto)
  select
    @w_ofdestino = convert(varchar(10), @i_oficina_destino)
  select
    @w_tipo_bloq = 2
  select
    @w_pardian = 'MMIDIA'
  select
    @w_parsuper = 'MMISUP'
  select
    @w_redcero = 0
  select
    @w_total_gmf = 0
  select
    @w_acumu_deb = 0
  select
    @w_base_gmf = 0
  select
    @w_tasa = 0
  select
    @w_difer_gmf = 0

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  /* Query especifico de un embargo */

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1421
    begin
      /*   Muestra las Cabeceras de embargos Insertadas */
      select
        @o_secuencial = ca_secuencial,
        @o_fecha_ofi = ca_fecha,
        @o_oficio = ca_oficio,
        @o_solicitante = ca_solicitante,
        @o_demandante = ca_apellido_demandante + ' ' + ca_demandante,
        @o_monto = ca_monto,
        @o_saldo_pdte = ca_saldo_pdte,
        @o_juzgado = ca_juzgado,
        @o_concepto = ca_concepto,
        @o_tido_doc = ca_tipo_doc_demandante,
        @o_numero_id = ca_numero_doc_demandante,
        @o_apellido_demandante = ca_apellido_demandante,
        @o_debita_cuenta = ca_debita_cta,
        @o_cta_especifica = ca_nro_cta_especifica,
        @o_mmi = isnull(ca_mmi,
                        'MMINAP'),
        @o_especifica = ca_cuenta_especifica,
        @o_estado = ca_estado,
        @o_registrado = ca_fecha,
        @o_funcionario = ca_autorizante
      from   cl_cab_embargo
      where  ca_ente         = @i_cliente
         and ca_secuencial   = @i_secuencial
         and ca_oficio       = @i_oficio
         and ca_tipo_proceso = 'B'

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
        @o_juzgado,
        @o_concepto,
        @o_tido_doc,
        @o_numero_id,
        @o_apellido_demandante,
        @o_debita_cuenta,
        @o_cta_especifica,
        @o_mmi,
        @o_especifica,
        @o_estado,
        @o_registrado,
        @o_funcionario,
        @o_modificado
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051 /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end --operacion Q

  if @i_operacion = 'S'
  begin
    if @t_trn = 1424
    begin
      if @i_modo = 0
      begin
        /*   Muestra las Cabeceras de embargos Insertadas */
        set rowcount 20
        select
          'SECUENCIAL' = isnull(ca_secuencial,
                                0),
          'FECHA     ' = convert(varchar(10), ca_fecha, 101),
          'FECHA OFI ' = convert(varchar(10), ca_fecha_ofi, 101),
          'OFICIO    ' = ca_oficio,
          'SOLICITANTE' = ca_solicitante,
          'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_demandante,
          'MONTO      ' = ca_monto,
          'PENDIENTE  ' = ca_saldo_pdte,
          'ESTADO' = ca_estado,
          'TIPO EMB.' = ca_tipo_proceso,
          'AUTORIZA   ' = ca_autorizante,
          'JUZGADO    ' = ca_juzgado,
          'SEC MODULO' = de_sec_interno,
          'CUENTA     ' = de_num_cuenta
        from   cobis..cl_cab_embargo,
               cobis..cl_det_embargo
        where  ca_ente         = @i_cliente
           and ca_ente         = de_ente
           and ca_secuencial   = de_secuencial
           and ca_tipo_proceso = 'B'
        order  by de_sec_interno
      end
      else
      begin
        select
          'SECUENCIAL' = ca_secuencial,
          'FECHA     ' = convert(varchar(10), ca_fecha, 101),
          'FECHA OFI ' = convert(varchar(10), ca_fecha_ofi, 101),
          'OFICIO    ' = ca_oficio,
          'SOLICITANTE' = ca_solicitante,
          'DEMANDANTE ' = ca_apellido_demandante + ' ' + ca_demandante,
          'MONTO      ' = ca_monto,
          'PENDIENTE  ' = ca_saldo_pdte,
          'ESTADO' = ca_estado,
          'TIPO EMB.' = ca_tipo_proceso,
          'AUTORIZA   ' = ca_autorizante,
          'JUZGADO    ' = ca_juzgado,
          'SEC MODULO' = de_sec_interno,
          'CUENTA     ' = de_num_cuenta
        from   cobis..cl_cab_embargo,
               cobis..cl_det_embargo
        where  ca_ente         = @i_cliente
           and ca_ente         = de_ente
           and ca_secuencial   = de_secuencial
           and ca_tipo_proceso = 'B'
           and de_secuencial   > @i_siguiente
        order  by de_sec_interno
      end
    end
  end--operacion S

  if @i_operacion = 'X'
  begin
    if @t_trn = 1424
    begin
      /*   Muestra las Cabeceras de embargos Insertadas */

      if exists (select
                   1
                 from   cl_cab_embargo
                 where  ca_oficio               = @i_oficio
                    and isnull(ca_reversado,
                               '') <> 'S'
                    and ca_tipo_proceso in('B', 'L'))
      begin
        select
          @w_secuencial = ca_secuencial
        from   cl_cab_embargo
        where  ca_oficio               = @i_oficio
           and ca_tipo_proceso         = @i_tipo_proceso
           and isnull(ca_reversado,
                      '') <> 'S'

        select
          @o_existe = 'S'
        select
          @o_secuencial = @w_secuencial
        select
          @o_existe
        select
          @o_secuencial

      end
      else
      begin
        select
          @o_existe = 'N'
        select
          @o_secuencial = 0
        select
          @o_existe
        select
          @o_secuencial
      end

      select
        @o_existe
      select
        @o_secuencial
      select
        @o_existe
      select
        @o_secuencial
    end
  end --operacion X

  if @i_operacion in ('I', 'U')
  begin
    begin tran
    if @i_subtipo = 'C'
       and @i_mmi = @w_pardian
    begin
      select
        @w_error = 100207
      goto ERROR
    end

    if @i_cliente < 1
    begin
      select
        @w_error = 101146 --No existe cliente
      goto ERROR
    end

    select
      @w_tipo_ced = en_tipo_ced,
      @w_ced_ruc = en_ced_ruc,
      @w_natjur = c_tipo_compania,
      @w_nombre = en_nomlar
    from   cobis..cl_ente
    where  en_ente = @i_cliente

    select
      @w_siguiente = isnull(max(ca_secuencial), 0) + 1
    from   cl_cab_embargo
    where  ca_ente = @i_cliente

    if @w_siguiente is null
      select
        @w_siguiente = 1

    if @i_cuenta_especifica = 'S'
      select
        @w_producto1 = @i_producto
    else
      select
        @w_producto1 = null

    if @i_monto_emb is null
      select
        @w_valor_emb = isnull(@i_monto, 0) + isnull(@i_saldo_pdte, 0)
    --Para no enviar valor mayores de lo embargado - lo pagado

    if @i_saldo_pdte is null
      select
        @i_saldo_pdte = 0

    if @w_valor_emb < @i_monto_emb
    begin
      select
        @w_error = 101216
      goto ERROR
    end

    if @i_tembargo = 'CAP'
    begin
      select
        @w_tembargo = 0
    end

    if @i_tembargo = 'CIN'
    begin
      select
        @w_tembargo = 1
    end

    if @i_tembargo = 'INT'
    begin
      select
        @w_tembargo = 1
    end

    if (@i_producto = 'CTE'
         or @i_producto = 'AHO')
    begin
      select
        @w_saldo = 0
      select
        @w_saldo = saldo
      from   productos_tmp2
      where  producto = @i_producto
         and cuenta   = @i_num_cta

      select
        @w_saldo_para_girar = @w_saldo

      select
        @w_numdeciimp = pa_tinyint
      from   cobis..cl_parametro
      where  pa_producto = 'CTE'
         and pa_nemonico = 'DCI'

      if @@rowcount = 0
      begin
        select
          @w_error = 201196
        goto ERROR
      end

      if @i_producto = 'CTE'
      begin
        select
          @w_producto = 3

        select
          @w_cta = cc_ctacte
        from   cob_cuentas..cc_ctacte
        where  cc_cta_banco = @i_num_cta

        if @@rowcount = 0
        begin
          select
            @w_error = 101127
        --goto ERROR
        end
      end
      else
      begin
        select
          @w_producto = 4

        select
          @w_cta = ah_cuenta
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @i_num_cta

        if @@rowcount = 0
        begin
          select
            @w_error = 101127
        --goto ERROR
        end
      end
      select
        @w_valor_cobro = @i_monto_emb --@w_saldo_para_girar --@i_monto_emb
    end -- fin (@i_producto = 'CTE' Or @i_producto = 'AHO')

    if @i_debita_cta = 'S'
      select
        @w_causa = '1'
    else if @i_producto = 'AHO'
      select
        @w_causa = '3'
    else
      select
        @w_causa = '5'

    if @i_producto = 'AHO' --and @i_monto_emb > 0
    begin
      select
        @s_ssn = @s_ssn + 1,
        @w_observa = 'EMBARGO DESDE CLIENTES Oficio: ' + @i_oficio,
        @w_demandante = ltrim(rtrim(@i_nombre_demandante)) + ' ' + ltrim(rtrim(
                        @i_apellido_demandante))

      exec @w_return = cob_ahorros..sp_tr_bloq_val_ah
        @s_ssn          = @s_ssn,
        @s_srv          = @s_srv,
        @s_lsrv         = @s_lsrv,
        @s_user         = @s_user,
        @s_sesn         = @s_sesn,
        @s_term         = @s_term,
        @s_date         = @s_date,
        @s_ofi          = @s_ofi,
        @s_org          = @s_org,
        @t_trn          = 217,
        @i_mon          = 0,
        @i_cta          = @i_num_cta,
        @i_accion       = 'B',
        @i_causa        = @w_causa,
        @i_valor        = @w_valor_cobro,
        @i_aut          = @i_autorizante,
        @i_solicit      = @i_solicitante,
        @i_observacion  = @w_observa,
        @i_valida_saldo = 'N',
        @o_siguiente    = @w_sec_prod out,
        @o_prod_banc    = @w_subproducto out

      if @w_return <> 0
          or @@error <> 0
      begin
        select
          @w_sp_name = 'sp_tr_bloq_val_ah'
        select
          @w_error = @w_return
        goto ERROR
      end
    end--@i_producto = 'AHO'

    if @i_producto = 'CTE'
    begin
      select
        @s_ssn = @s_ssn + 1
      exec @w_return = cob_cuentas..sp_tr_bloq_val_cc
        @s_ssn           = @s_ssn,
        @s_srv           = @s_srv,
        @s_lsrv          = @s_lsrv,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term,
        @s_date          = @s_date,
        @s_ofi           = @s_ofi,
        @s_org           = @s_org,
        @t_trn           = 9,
        @i_mon           = 0,
        @i_cta           = @i_num_cta,
        @i_accion        = 'B',
        @i_causa         = @w_causa,
        @i_valor         = @w_valor_cobro,
        @i_aut           = @i_autorizante,
        @i_oficio        = @i_oficio,
        @i_deman         = @i_demandante,
        @i_pit           = 'S',
        @i_oficina_dest  = @i_oficina_destino,
        @i_mmi           = @i_mmi,
        @o_hb_secuencial = @w_sec_prod out

      if @w_return <> 0
          or @@error <> 0
      begin
        select
          @w_error = @w_return
        select
          @w_sp_name = 'sp_tr_bloq_val_cc'
        goto ERROR
      end
    end --@i_producto = 'CTE'

    if @i_producto = 'PFI'
    begin
      exec @w_return = cob_pfijo..sp_embargo
        @s_user                      = @s_user,
        @s_term                      = @s_term,
        @s_date                      = @s_date,
        @s_sesn                      = @s_sesn,
        @s_ssn                       = @s_ssn,
        @s_srv                       = @s_srv,
        @s_ofi                       = @s_ofi,
        @t_trn                       = 14560,
        @i_operacion                 = 'I',
        @i_op_num_banco              = @i_num_cta,
        @i_oficina                   = @s_ofi,
        @i_bl_num_oficio             = @i_oficio,
        @i_bl_valor_embgdo_juzgado   = @i_monto,
        @i_bl_valor_embgdo_banco     = @i_monto_emb,--@w_valor_cobro,
        @i_bl_valor_int_embgdo_banco = @i_interes,
        @i_bl_fecha_oficio           = @i_fecha_ofi,
        @i_bl_autoridad              = @i_juzgado,
        @i_bl_observacion            = 'EMBARGADO DESDE CLIENTES',
        @i_modifico_fp               = @w_tembargo,
        @i_ente                      = @i_cliente,
        @o_sec_embargo               = @w_sec_prod out
      if @w_return <> 0
          or @@error <> 0
      begin
        select
          @w_sp_name = 'sp_embargo'
        select
          @w_error = @w_return
        goto ERROR
      end
    end --@i_producto = 'PFI'

    select
      @w_campo1 = @w_tipo_ced + '-' + @w_ced_ruc

    --Se genera cheque de gerencia por el valor debitado
    if (@i_producto = 'CTE'
         or @i_producto = 'AHO')
       and @i_monto_emb > 0
       and @w_sec_prod > 0
       and @i_debita_cta = 'S'
    begin
      if isnull(@s_user,
                '') in ('', 'Embargos')
        select
          @w_user = 'sa'
      else
        select
          @w_user = @s_user

      exec @w_return = cob_interfase..sp_isba_imprimir_lotes
        @t_trn             = 29334,
        @s_ssn             = @s_ssn,
        @s_date            = @s_date,
        @s_user            = @w_user,
        @s_term            = @s_term,
        @s_ofi             = @s_ofi,
        @s_lsrv            = @s_lsrv,
        @s_srv             = @s_srv,
        @i_estado          = 'D',
        --> ESTADO DE LA SOLICITUD ('DISPONIBLE PARA GIRO)
        @i_oficina_origen  = @s_ofi,--  OFICINA ORIGEN
        @i_ofi_destino     = @s_ofi,--  OFICINA QUE GIRA EL CHEQUE
        @i_area_origen     = 99,
        @i_fecha_solicitud = @s_date,--  FECHA DE SOLICITUD DE GIRO
        @i_producto        = @w_producto,-- (4- VENTA DE INSTRUMENTOS)
        @i_instrumento     = 1,-- (1-cheques de gerencia, 5-cheques comerciales)
        @i_subtipo         = 1,-- (depende del instrumento, 1 para  CGER)
        @i_valor           = @i_monto_emb,--  Valor
        @i_beneficiario    = @i_juzgado,
        --  Nombre beneficiario cheque (Deben estar en cl_ente)
        @i_referencia      = @w_cta,
        --  Campo entero que sirve para la cuenta/operacion/referencia
        --  general de quien origina la solicitud
        @i_tipo_benef      = @w_natjur,--  Particular u Oficial
        @i_campo1          = @w_campo1,
        --  tipo y numero del titular ej. CC-79876543
        @i_campo2          = @w_nombre,--  Nombre Titular
        @i_campo3          = '',
        --  tipo y numero del beneficiario ej. CC-79876545
        @i_campo4          = @i_juzgado,--  Nombre Beneficiario
        @i_campo5          = @i_oficio,
        --  Numero oficio o algo que identifique la operacion(conocido por el cliente)
        @i_campo6          = '047',--  Código concepto de emision
        @i_campo7          = ' ENTREGA EMBARGOS',
        --  Descripcion concepto de emision
        @i_campo21         = 'MIS',
        --  Sigla del producto que envía (DPF, CCA, MIS, e.t.c.)
        @i_campo22         = 'D',
        @i_campo40         = 'E',--  Idioma 'E' --> Español, 'I' --> Ingles
        @o_secuencial      = @w_sec_prod_chq out
      --@w_num_orden  --  Código de secuencial  (Campo de salida que  devuelve el sp y se debe grabar en tabla del modulo)

      if @w_return <> 0
          or @@error <> 0
      begin
        select
          @w_sp_name = 'sp_isba_imprimir_lotes'
        select
          @w_error = @w_return
        goto ERROR
      end
    end

    if @i_operacion = 'I'
    begin
      select
        @w_spendiente = @i_monto - @w_valor_cobro
      if @w_spendiente = 0
        select
          @w_estado = 'C'
      else
        select
          @w_estado = 'P'

      /* Insertar los datos de entrada */
      insert into cl_cab_embargo
                  (ca_ente,ca_secuencial,ca_fecha,ca_fecha_ofi,ca_oficio,
                   ca_solicitante,ca_demandante,ca_monto,ca_estado,
                   ca_tipo_proceso
                   ,
                   ca_autorizante,ca_saldo_pdte,ca_debita_cta,
                   ca_oficina,
                   ca_tipo_persona,
                   ca_juzgado,ca_concepto,ca_oficina_destino,
                   ca_tipo_doc_demandante,
                   ca_numero_doc_demandante,
                   ca_nombre_demandante,ca_apellido_demandante,
                   ca_cuenta_especifica,
                   ca_nro_cta_especifica,ca_producto,
                   ca_mmi)
      values      ( @i_cliente,@w_siguiente,@w_fecha_proceso,@i_fecha_ofi,
                    @i_oficio,
                    @i_solicitante,@i_demandante,@i_monto,@w_estado,
                    @i_tipo_proceso,
                    @i_autorizante,@w_spendiente,@i_debita_cta,@i_oficina,
                    @i_tipo_persona,
                    @i_juzgado,@w_concepto,@w_ofdestino,@i_tipo_doc_demandante,
                    @i_numero_doc_demandante,
                    @i_nombre_demandante,@i_apellido_demandante,
                    @i_cuenta_especifica
                    ,
                    @i_nro_cta_especifica,@w_producto1,
                    @i_mmi)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        select
          @w_error = 208109
        goto ERROR
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
                   ,producto,
                   mmi)
      values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_cliente,@w_siguiente,
                    @w_fecha_proceso,@i_fecha_ofi,@i_oficio,@i_solicitante,
                    @i_demandante,
                    @i_monto,@w_estado,@i_tipo_proceso,@i_autorizante,
                    @w_spendiente,
                    @i_debita_cta,@i_oficina,@i_tipo_persona,@i_juzgado,
                    @w_concepto,
                    @w_ofdestino,@i_tipo_doc_demandante,@i_numero_doc_demandante
                    ,
                    @i_nombre_demandante,@i_apellido_demandante,
                    @i_cuenta_especifica,@i_nro_cta_especifica,null,null,null,
                    null,null,null,null,@w_producto1,
                    @i_mmi)

      /*  Error en creacion de transaccion de servicio  */
      if @@error <> 0
      begin
        select
          @w_error = 103005
        goto ERROR
      end

      if @w_spendiente > 0
         and @i_debita_cta = 'S'
         and @i_producto = 'AHO'
      begin
        select
          @c_fecha = convert(char(10), @i_fecha, 101)

        if @s_user = ''
          select
            @w_autorizante1 = 'Embargos'
        else
          select
            @w_autorizante1 = @s_user

        select
          @w_congelamiento = count(0)
        from   cob_ahorros..ah_ctabloqueada
        where  cb_estado      = 'V'
           and cb_cuenta      = @w_cta
           and cb_tipo_bloqueo in('2', '3')
           and cb_observacion <> 'Embargos'

        if @w_congelamiento > 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   =
          'BLOQUEO ADMINISTRATIVO PREVIO - FAVOR DESBLOQUAR ANTES DE EMBARGAR',
            @i_num   = 201054 --TIPO DE BLOQUEO NO HA SIDO LEVANTADO PREVIAMENTE
          return 1
        end

        exec @w_return = cobis..sp_congela
          @s_ssn          = @s_ssn,
          @s_srv          = @s_srv,
          @s_lsrv         = @s_lsrv,
          @s_user         = 'embargos',--@s_user,
          @s_sesn         = @s_sesn,
          @s_term         = @s_term,
          @s_date         = @s_date,
          @s_ofi          = @s_ofi,
          @s_org          = @s_org,
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @t_trn          = 1442,
          @i_operacion    = 'I',
          @i_cliente      = @i_cliente,
          @i_fecha        = @c_fecha,
          @i_oficio       = @i_oficio,
          @i_solicitante  = @i_solicitante,
          @i_demandante   = @i_demandante,
          @i_tipo_proceso = 'C',
          @i_autorizante  = @w_autorizante1,
          @i_estado       = 'C',
          @i_secuencial   = @w_siguiente,
          @i_producto     = @i_producto,
          @i_subproducto  = @i_subproducto,
          @i_estado_lev   = 'N',
          @i_num_cta      = @i_num_cta,
          @i_sec_modulo   = @w_sec_prod,
          @i_tbloq        = 2,
          @i_observacion  = 'CONGELAMIENTO AUTOMATICO'

        if @w_return <> 0
            or @@error <> 0
        begin
          select
            @w_sp_name = "sp_congela"
          select
            @w_error = @w_return
          goto ERROR
        end
      end /*if @w_spendiente > 0*/

    /* Insercion de detalle del Embargo */
      /* Determino el entero del producto */

      if @i_producto = 'AHO'
        select
          @w_producto = 4

      if @i_producto = 'CTE'
        select
          @w_producto = 3

      if @i_producto = 'PFI'
        select
          @w_producto = 14

      if @w_sec_prod is not null
      begin
        insert into cl_det_embargo
                    (de_ente,de_secuencial,de_sec_interno,de_fecha,de_producto,
                     de_subproducto,de_monto,de_tipo_bloqueo,
                     de_estado_levantamiento
                     ,
                     de_num_cuenta,
                     de_observacion,de_sec_depjud)
        values      ( @i_cliente,@w_siguiente,@w_sec_prod,@w_fecha_proceso,
                      @w_producto
                      ,
                      @w_subproducto,@w_valor_cobro,@w_tipo_bloq,
                      @i_estado_lev,
                      @i_num_cta,
                      @i_observacion,@w_sec_prod_chq )

        /* Si no se puede insertar error */
        if @@error <> 0
        begin
          select
            @w_error = 148055
          goto ERROR
        end

        select
          @o_seclientes = @w_siguiente
        select
          @o_seclientes
        select
          @o_saldopdte

        /* Se incluye modificacion para controlar monto inembargabilidad */

        if @i_cuenta_especifica = 'S'
          select
            @w_tipo_emb = 'E'
        else
          select
            @w_tipo_emb = 'T'

        if (@w_producto = 3
             or @w_producto = 4)
           and @i_operacion = 'I'
        begin
          if @w_estado = 'P'
          begin
            exec @w_return = cobis..sp_saldo_min_embargado
              @s_srv       = @s_srv,
              @s_user      = @s_user,
              @s_term      = @s_term,
              @s_ofi       = @s_ofi,
              @s_date      = @s_date,
              @t_trn       = 1423,--Nuevo embargo
              @i_oper      = 'I',--Insercion de Embargo
              @i_cod_emb   = @w_siguiente,
              @i_cliente   = @i_cliente,
              @i_param_emb = @i_mmi,
              -- Parametro 'MMINAP' Monto Minimo No Aplica, 'MMISUP'  Monto Minimo Super, 'MMIDIA'  Monto Minimo Dian
              @i_tipo_emb  = @w_tipo_emb,
              -- Especifico,    -- 'T' Todas las cuentas
              @i_producto  = @w_producto,-- 4 - Ahorros  3 - Corrientes,
              @i_num_cta   = @i_num_cta
            -- Numero de Cuenta en caso de tipo de embargo Especifico

            if @w_return <> 0
                or @@error <> 0
            begin
              select
                @w_sp_name = "sp_saldo_min_embargo"
              select
                @w_error = @w_return
              goto ERROR
            end
          end
        end
      end --- @i_operacion = 'I'
      commit tran
    end /* @i_operacion in ('I', 'U')*/

    if @i_operacion = 'U'
    begin
      if exists (select
                   1
                 from   cl_cab_embargo
                 where  ca_oficio       = @i_oficio
                    and ca_tipo_proceso = 'B')
      begin
        select
          @w_falta = isnull(ca_saldo_pdte,
                            0)
        from   cl_cab_embargo
        where  ca_ente         = @i_cliente
           and ca_oficio       = @i_oficio
           and ca_secuencial   = @i_secuencial
           and ca_tipo_proceso = 'B'

        begin tran

        if @w_falta < @w_valor_cobro
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141241
          /*El Monto a Embargar debe ser menor que el Disponible a ser Embargado           */
          return 1
        end

        select
          @w_newsaldo = isnull(@w_falta,
                               0) - isnull(@w_valor_cobro,
                                           0)

        if @w_newsaldo = 0.00
        begin
          select
            @w_estadoN = 'C'
        end
        else
        begin
          select
            @w_estadoN = 'P'
        end
        if @w_newsaldo = 0.00 /* Descongelo */ --defecto 8084
        begin
          update cl_cab_embargo
          set    ca_saldo_pdte = @w_newsaldo,
                 ca_estado = @w_estadoN
          where  ca_ente         = @i_cliente
             and ca_oficio       = @i_oficio
             and ca_secuencial   = @i_secuencial
             and ca_tipo_proceso = 'B'

          /* Si no se puede insertar error */
          if @@error <> 0
          begin
            select
              @w_error = 102020
            goto ERROR
          end

        /* Verificacion de que la cuenta se encuentre efectivamente bloqueada */
          /* esto se hace cuando se hace el levantamiento por tadmin*/

          if @i_producto = 'AHO'
            select
              @w_producto2 = '4'

          if @i_producto = 'CTE'
            select
              @w_producto2 = '3'

          select
            @w_cong_prod = de_producto,
            @w_cong_ncta = de_num_cuenta,
            @w_sec_conge = de_secuencial
          from   cobis..cl_det_embargo
          where  de_ente = @i_cliente
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
              @w_secuencial = isnull(cb_secuencial,
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
              @w_secuencial = isnull(cb_secuencial,
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

          if @w_secuencial is not null
             and @w_cong_prod = 4
          begin
            /* Registrar el descongelamiento */
            exec @w_return = sp_descongela
              @s_ssn          = @s_ssn,
              @s_srv          = @s_srv,
              @s_lsrv         = @s_lsrv,
              @s_user         = 'Embargos',
              @s_term         = @s_term,
              @s_date         = @w_fecha_proceso,
              @s_ofi          = @s_ofi,
              @s_org          = @s_org,
              @t_trn          = 1447,
              @s_sesn         = @s_sesn,
              @i_linea        = @i_linea,
              @i_operacion    = 'I',
              @i_cliente      = @i_cliente,
              @i_fecha        = @i_fecha,
              @i_fecha_ofi    = @i_fecha_ofi,
              @i_solicitante  = @i_solicitante,
              @i_demandante   = @i_demandante,
              @i_tipo_proceso = 'D',
              @i_oficio       = @i_oficio,
              @i_autorizante  = @i_autorizante,
              @i_num_cta      = @w_cong_ncta,--@i_num_cta,
              @i_producto     = @w_producto2,
              @i_observacion  = @i_observacion,
              @i_tbloq        = '2',
              @i_secuencial   = @w_sec_conge

            if @w_return <> 0
                or @@error <> 0
            begin
              select
                @w_error = @w_return
              goto ERROR
            end
          end -- @w_secuencial is not null
        end -- @w_newsaldo = 0.00
        else
        begin
          update cl_cab_embargo
          set    ca_saldo_pdte = isnull(@w_newsaldo,
                                        0),
                 ca_estado = @w_estadoN
          where  ca_ente         = @i_cliente
             and ca_oficio       = @i_oficio
             and ca_secuencial   = @i_secuencial
             and ca_tipo_proceso = 'B'

          /* Si no se puede actualizar error */
          if @@error <> 0
          begin
            select
              @w_error = 102020
            goto ERROR
          end
        end

        select
          @o_siguiente = @i_secuencial

      /* Insercion de detalle del Embargo */
        /* Determino el entero del producto */

        if @i_producto = 'AHO'
          select
            @w_producto = 4

        if @i_producto = 'CTE'
          select
            @w_producto = 3

        if @i_producto = 'PFI'
          select
            @w_producto = 14

        if @w_producto = 14
          select
            @w_subproducto = td_tipo_deposito
          from   cob_pfijo..pf_tipo_deposito
          where  td_mnemonico = @i_subproducto
      end

      if @i_producto = 'PFI'
        select
          @w_sec_prod_chq = 0

      if @w_sec_prod is null
        select
          @w_sec_prod = 9999

      /* Insertar los datos de entrada */
      insert into cl_det_embargo
                  (de_ente,de_secuencial,de_sec_interno,de_fecha,de_producto,
                   de_subproducto,de_monto,de_tipo_bloqueo,
                   de_estado_levantamiento
                   ,
                   de_num_cuenta,
                   de_observacion,de_sec_depjud)
      values      ( @i_cliente,@i_secuencial,@w_sec_prod,@w_fecha_proceso,
                    @w_producto,
                    @w_subproducto,@w_valor_cobro,@w_tipo_bloq,@i_estado_lev,
                    @i_num_cta,
                    @i_observacion,@w_sec_prod_chq)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin
        select
          @w_error = 148055
        goto ERROR
      end

      if (@w_producto = 3
           or @w_producto = 4)
         and @w_estadoN = 'C'
      begin
        exec @w_return = cobis..sp_saldo_min_embargado
          @s_srv       = @s_srv,
          @s_user      = @s_user,
          @s_term      = @s_term,
          @s_ofi       = @s_ofi,
          @s_date      = @s_date,
          @t_trn       = 1432,--Nuevo embargo
          @i_oper      = 'C',--Insercion de Embargo
          @i_cod_emb   = @i_secuencial,
          @i_cliente   = @i_cliente,
          @i_param_emb = @i_mmi,
          -- Parametro 'MMINAP' Monto Minimo No Aplica, 'MMISUP'  Monto Minimo Super, 'MMIDIA'  Monto Minimo Dian
          @i_tipo_emb  = @w_tipo_emb,-- Especifico, -- 'T' Todas las cuentas
          @i_producto  = @w_producto,-- 4 - Ahorros  3 - Corrientes,
          @i_num_cta   = @i_num_cta
        -- Numero de Cuenta en caso de tipo de embargo Especifico

        if @w_return <> 0
            or @@error <> 0
        begin
          select
            @w_sp_name = "sp_saldo_min_embargo"
          select
            @w_error = @w_return
          goto ERROR
        end
      end

      select
        @o_seclientes = @w_siguiente
      select
        @o_seclientes
      select
        @o_saldopdte = @w_newsaldo
      commit tran
    end
  end -- operacion = U

  while @@trancount > 0
    commit tran
  return 0

  ERROR:

  if @i_linea = 'S'
  begin
    if @@trancount > 0
      rollback tran

    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = @w_error
    return @w_error

  end
  else
  begin
    if @@trancount > 0
      select
        @w_rollback = 'S'
    else
      select
        @w_rollback = 'N'
    select
      @w_descr = mensaje
    from   cobis..cl_errores
    where  numero = @w_error

    exec sp_errorlog
      @i_fecha       = @w_fecha_error,
      @i_error       = @w_error,
      @i_usuario     = 'misbatch',
      @i_tran        = 1423,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @i_num_cta,
      @i_descripcion = @w_descr,
      @i_rollback    = @w_rollback
    return @w_error
  end
  return 0

go

