/************************************************************************/
/*   Archivo:       cltraslado.sp                                       */
/*   Stored procedure:   sp_traslado_productos                          */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:           Diego Duran                                */
/*   Fecha de escritura:      06-Sep-2004                               */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Este programa Realiza traslado de productos entre clientes         */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   06/Sep/2004    D.Duran   Emision Inicial                           */
/*   20/Sep/2004    D.Duran        Optimizacion                         */
/*      28/Dic/2004 D.Duran         Adiciono No Doc. en Update Aho/Cte  */
/*      25/Ene/2004 D.Duran           Optimizacion                      */
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
           where  name = 'sp_traslado_productos')
  drop proc sp_traslado_productos
go

create proc sp_traslado_productos
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
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
  @i_modo         tinyint = null,
  @i_ente         int = null,
  @i_nue_cliente  int = null,
  @i_operacion    char = null,
  @i_det_producto int = null,
  @i_producto     char(3) = null
)
as
  declare
    @w_sp_name               varchar(32),
    @w_natjur                varchar(10),
    @w_natjur_nuevo          varchar(10),
    @w_tipo_cliente          varchar(10),
    @w_tipo_cliente_nuevo    varchar(10),
    @w_tipo_persona          char(1),
    @w_tipo_persona_nuevo    char(1),
    @w_nombre_cliente_nuevo  varchar(254),
    @w_tipoced_cliente_nuevo char(2),
    @w_tipoced_cliente_viejo char(2),
    @w_numced_cliente_nuevo  varchar(30),
    @w_numced_cliente_viejo  varchar(30),
    @w_cerror                int,
    @w_cl_rol_viejo          char(1),
    @w_cl_rol_nuevo          char(1)

  select
    @w_sp_name = 'sp_traslado_productos'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1108
  begin
    set rowcount 20
    if @i_modo = 0
      select
        'Filial' = fi_abreviatura,
        'Oficina' = substring(of_nombre,
                              1,
                              15),
        'Producto' = pd_abreviatura,
        'Cuenta' = dp_cuenta,
        'Rol' = cl_rol,
        'Fecha' = convert(char(8), cl_fecha, 1),
        'Moneda' = substring(mo_descripcion,
                             1,
                             10),
        'Servicio' = cl_det_producto
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente      = @i_ente
         and dp_det_producto = cl_det_producto
         and fi_filial       = dp_filial
         and of_oficina      = dp_oficina
         and pd_producto     = dp_producto
         and mo_moneda       = dp_moneda

    if @i_modo = 1
      select
        'Filial' = fi_abreviatura + '  ',
        'Oficina' = substring(of_nombre,
                              1,
                              15),
        'Producto' = pd_abreviatura + '     ',
        'Cuenta' = dp_cuenta,
        'Rol' = cl_rol,
        'Fecha' = convert(char(8), cl_fecha, 1),
        'Moneda' = substring(mo_descripcion,
                             1,
                             10),
        'Servicio' = cl_det_producto
      from   cl_cliente,
             cl_det_producto,
             cl_oficina,
             cl_producto,
             cl_moneda,
             cl_filial
      where  cl_cliente      = @i_ente
         and cl_det_producto > @i_det_producto
         and dp_det_producto = cl_det_producto
         and fi_filial       = dp_filial
         and of_oficina      = dp_oficina
         and pd_producto     = dp_producto
         and mo_moneda       = dp_moneda
    set rowcount 0
  end

  if @t_trn = 1109
  begin
    if @i_operacion = 'U'
    begin
      select
        @w_cerror = 0

      /**** Selecciona Naturaleza juridica / tipo cliente y tipo vinculacion ***/

      select
        @w_natjur = c_tipo_compania,
        @w_tipo_cliente = p_tipo_persona,
        @w_tipo_persona = en_subtipo,
        @w_numced_cliente_viejo = en_ced_ruc,
        @w_tipoced_cliente_viejo = en_tipo_ced
      from   cobis..cl_ente
      where  en_ente = @i_ente

      select
        @w_natjur_nuevo = c_tipo_compania,
        @w_tipo_cliente_nuevo = p_tipo_persona,
        @w_tipo_persona_nuevo = en_subtipo,
        @w_numced_cliente_nuevo = en_ced_ruc,
        @w_tipoced_cliente_nuevo = en_tipo_ced,
        @w_nombre_cliente_nuevo = en_nomlar
      from   cobis..cl_ente
      where  en_ente = @i_nue_cliente

      /**** Valida Naturaleza juridica / tipo cliente y tipo vinculacion  entre clientes ***/

      if (@w_natjur <> @w_natjur_nuevo)
      begin
        print 'Naturaleza Juridica es Diferente entre Clientes Tener En cuenta.'

      end

      if (@w_tipo_cliente is not null)
         and (@w_tipo_cliente_nuevo is not null)
      begin
        if (@w_tipo_cliente <> @w_tipo_cliente_nuevo)
        begin
          print 'El campo Tipo de Cliente es Diferente, Tener en cuenta.'
        end
      end

      if (@w_tipo_persona is not null)
         and (@w_tipo_persona_nuevo is not null)
      begin
        if (@w_tipo_persona <> @w_tipo_persona_nuevo)
        begin
          print
      'El Campo Tipo de Persona es Diferente entre Clientes tener en cuenta.'
        end
      end

      begin tran

      insert into ts_traslado_producto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,det_producto,
                   cod_producto,fecha_modificacion,subtipo,tipo_persona,
                   tipo_sociedad)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_det_producto,
                   @i_producto,getdate(),@w_tipo_persona,@w_tipo_cliente,
                   @w_natjur
      )

      /*** CLIENTES ***/

      update cobis..cl_det_producto
      set    dp_cliente_ec = @i_nue_cliente
      where  dp_det_producto = @i_det_producto

      select
        @w_cl_rol_viejo = cl_rol
      from   cobis..cl_cliente
      where  cl_cliente      = @i_ente
         and cl_det_producto = @i_det_producto

      if exists (select
                   1
                 from   cobis..cl_cliente
                 where  cl_cliente      = @i_nue_cliente
                    and cl_det_producto = @i_det_producto)
      begin
        delete cobis..cl_cliente
        where  cl_cliente      = @i_ente
           and cl_det_producto = @i_det_producto

        update cobis..cl_cliente
        set    cl_rol = @w_cl_rol_viejo
        where  cl_cliente      = @i_nue_cliente
           and cl_det_producto = @i_det_producto

      end

      else
      begin
        update cobis..cl_cliente
        set    cl_cliente = @i_nue_cliente,
               cl_ced_ruc = @w_numced_cliente_nuevo
        where  cl_cliente      = @i_ente
           and cl_det_producto = @i_det_producto

      end

      update cobis..cl_ente
      set    en_nombre = 'TRASLADO DE ENTE NO USAR',
             en_casilla = 99
      where  en_ente = @i_ente

      /* SBA */

      update cob_sbancarios..sb_operacion
      set    op_cod_cliente = @i_nue_cliente
      where  op_cod_cliente = @i_ente
         and op_tipo_cod    = 'M'

      update cob_sbancarios..sb_juzgados
      set    ju_ente = @i_nue_cliente
      where  ju_ente = @i_ente

      update cob_sbancarios..sb_entidades_ext
      set    ee_cod_ente = @i_nue_cliente
      where  ee_cod_ente = @i_ente

      /* ATM */

      if @i_producto = 'ATM'
      begin
        update cob_atm..tm_tarjeta
        set    ta_cliente = @i_nue_cliente,
               ta_propietario = case
                                  when ta_propietario = ta_cliente then
                                  @i_nue_cliente
                                  else ta_propietario
                                end
        where  ta_cliente = @i_ente

        update cob_atm..tm_tarjeta
        set    ta_propietario = @i_nue_cliente
        where  ta_propietario = @i_ente
           and ta_cliente     != ta_propietario

      end

      /** CCA **/

      if @i_producto = 'CCA'
      begin
        update cob_cartera..ca_operacion
        set    op_cliente = @i_nue_cliente,
               op_nombre = @w_nombre_cliente_nuevo
        where  op_cliente = @i_ente

        update cob_cartera..ca_operacion_his
        set    oph_cliente = @i_nue_cliente,
               oph_nombre = @w_nombre_cliente_nuevo
        from   cob_cartera..ca_operacion
        where  op_cliente   = @i_ente
           and op_operacion = oph_operacion

        update cob_cartera..ca_maestro_operaciones
        set    mo_cliente = @i_nue_cliente,
               mo_nombre_cliente = @w_nombre_cliente_nuevo
        from   cob_cartera..ca_operacion
        where  op_cliente   = @i_ente
           and op_operacion = mo_numero_de_operacion

        update cob_cartera..ca_prepagos_pasivas
        set    pp_cliente = @i_nue_cliente,
               pp_nombre = @w_nombre_cliente_nuevo
        from   cob_cartera..ca_operacion
        where  op_cliente = @i_ente
           and op_banco   = pp_banco

      end

      /** GAR **/

      update cob_custodia..cu_cliente_garantia
      set    cg_ente = @i_nue_cliente
      where  cg_ente = @i_ente

      /** BON **/

      if @i_producto = 'BON'
      begin
        update cob_bonos..bo_mov_monet
        set    mm_beneficiario = @i_nue_cliente
        where  mm_beneficiario = @i_ente

        update cob_bonos..bo_cliente_subcuenta
        set    cs_ente = @i_nue_cliente
        where  cs_ente = @i_ente

        update cob_bonos..bo_fraccion
        set    fr_ente = @i_nue_cliente
        where  fr_ente = @i_ente

        update cob_bonos..bo_sasiento
        set    sa_ente = @i_nue_cliente
        where  sa_ente = @i_ente

        update cob_bonos..bo_venta
        set    ve_ente = @i_nue_cliente
        where  ve_ente = @i_ente

        update cob_bonos..bo_venta
        set    ve_ente_ant = @i_nue_cliente
        where  ve_ente_ant = @i_ente
      end

      /* SIDAC */

      if @i_producto = 'SAC'
      begin
        update cob_sidac..sid_registros_padre
        set    rp_ente = @i_nue_cliente
        where  rp_ente = @i_ente

        update cob_sidac..sid_tran_monet
        set    tm_ente = @i_nue_cliente
        where  tm_filial     = 1
           and tm_secuencial > 0
           and tm_ente       = @i_ente

        update cob_sidac..sid_proveedores
        set    pr_ente = @i_nue_cliente
        where  pr_ente = @i_ente
      end

      /* AHO */

      if @i_producto = 'AHO'
      begin
        update cob_ahorros..ah_cuenta
        set    ah_cliente = @i_nue_cliente,
               ah_cliente_ec = @i_nue_cliente,
               ah_ced_ruc = @w_numced_cliente_nuevo
        where  ah_cliente = @i_ente

      end

      /* CTE */

      if @i_producto = 'CTE'
      begin
        update cob_cuentas..cc_ctacte
        set    cc_cliente = @i_nue_cliente,
               cc_cliente_ec = @i_nue_cliente,
               cc_ced_ruc = @w_numced_cliente_nuevo
        where  cc_cliente = @i_ente
      end

      /** CRE **/

      if @i_producto = 'CRE'
      begin
        update cob_credito..cr_arch_redes_tamortiz
        set    re_cliente = @i_nue_cliente
        from   cob_credito..cr_tramite
        where  tr_tramite = re_tramite
           and tr_cliente = @i_ente

        update cob_credito..cr_destino_tramite
        set    dt_cliente = @i_nue_cliente
        from   cob_credito..cr_tramite
        where  tr_cliente = @i_ente
           and tr_tramite = dt_tramite

        update cob_credito..cr_tramite
        set    tr_cliente = @i_nue_cliente
        where  tr_cliente = @i_ente

        update cob_credito..cr_linea
        set    li_cliente = @i_nue_cliente
        where  li_cliente = @i_ente

        update cob_credito..cr_cobranza
        set    co_cliente = @i_nue_cliente
        where  co_cliente = @i_ente

        update cob_credito..cr_deudores
        set    de_cliente = @i_nue_cliente
        where  de_cliente = @i_ente

        update cob_credito..cr_concordato
        set    cn_cliente = @i_nue_cliente
        where  cn_cliente = @i_ente

        update cob_credito..cr_dato_cliente
        set    dc_cliente = @i_nue_cliente
        where  dc_cliente  = @i_ente
           and dc_tipo_reg = 'D'

        update cob_credito..cr_dato_garantia
        set    dg_cliente = @i_nue_cliente
        where  dg_cliente = @i_ente

        update cob_credito..cr_califs_cl_je
        set    cl_cod_cliente = @i_nue_cliente
        where  cl_cod_cliente = @i_ente

        update cob_credito..cr_notif_concordato
        set    nc_cliente = @i_nue_cliente
        where  nc_cliente = @i_ente

        update cob_credito..cr_asignacion_cob
        set    ac_cod_cliente = @i_nue_cliente
        where  ac_cod_cliente = @i_ente

        update cob_credito..cr_calificacion_cl
        set    cl_cod_cliente = @i_nue_cliente
        where  cl_cod_cliente = @i_ente

        update cob_credito..cr_estados_concordato
        set    ec_cliente = @i_nue_cliente
        where  ec_cliente = @i_ente

        update cob_credito..cr_archivo_redescuento
        set    re_cliente = @i_nue_cliente
        where  re_cliente = @i_ente
           and re_tramite > 0

        update cob_credito..cr_calificacion_cl
        set    cl_cod_cliente = @i_nue_cliente
        where  cl_cod_cliente = @i_ente

        update cob_credito..cr_calificacion_op
        set    co_cod_cliente = @i_nue_cliente
        where  co_cod_cliente = @i_ente

        update cob_credito..cr_calificaciones_cl
        set    cl_cod_cliente = @i_nue_cliente
        where  cl_cod_cliente = @i_ente

        update cob_credito..cr_dato_operacion
        set    do_codigo_cliente = @i_nue_cliente
        where  do_codigo_cliente = @i_ente
      end

      /** PFI **/

      if @i_producto = 'PFI'
      begin
        update cob_pfijo..pf_operacion
        set    op_ente = @i_nue_cliente,
               op_ced_ruc = @w_numced_cliente_nuevo
        where  op_ente = @i_ente

        update cob_pfijo..pf_mov_monet
        set    mm_beneficiario = @i_nue_cliente
        from   cob_pfijo..pf_operacion
        where  op_ente      = @i_ente
           and op_operacion = mm_operacion

        update cob_pfijo..pf_emision_cheque
        set    ec_ente = @i_nue_cliente
        where  ec_ente = @i_ente

        update cob_pfijo..pf_beneficiario
        set    be_ente = @i_nue_cliente
        where  be_ente = @i_ente

        update cob_pfijo..pf_det_pago
        set    dp_ente = @i_nue_cliente
        where  dp_ente = @i_ente

        update cob_pfijo..pf_endoso_cond
        set    ed_ente = @i_nue_cliente
        where  ed_ente = @i_ente

        update cob_pfijo..pf_endoso_prop
        set    ep_ente_old = @i_nue_cliente
        where  ep_ente_old = @i_ente

        update cob_pfijo..pf_endoso_prop
        set    ep_ente_new = @i_nue_cliente
        where  ep_ente_new = @i_ente

        update cob_pfijo..pf_sasiento
        set    sa_ente = @i_nue_cliente
        where  sa_ente        = @i_ente
           and sa_fecha_tran  > '05/31/2004'
           and sa_comprobante > 0

        update cob_pfijo..pf_beneficiario_logconv
        set    bl_tipo_ced = @w_tipoced_cliente_nuevo,
               bl_ced_ruc = @w_numced_cliente_nuevo
        where  bl_tipo_ced = @w_tipoced_cliente_viejo
           and bl_ced_ruc  = @w_numced_cliente_viejo

        update cob_pfijo..pf_fpago_logconv
        set    fl_tipo_ced = @w_tipoced_cliente_nuevo,
               fl_ced_ruc = @w_numced_cliente_nuevo
        where  fl_tipo_ced = @w_tipoced_cliente_viejo
           and fl_ced_ruc  = @w_numced_cliente_viejo

        update cob_pfijo..pf_cancela_logconv
        set    cl_tipo_ced = @w_tipoced_cliente_nuevo,
               cl_ced_ruc = @w_numced_cliente_nuevo
        where  cl_tipo_ced = @w_tipoced_cliente_viejo
           and cl_ced_ruc  = @w_numced_cliente_viejo

        update cob_pfijo..pf_endoso_logconv
        set    el_tipo_ced = @w_tipoced_cliente_nuevo,
               el_ced_ruc = @w_numced_cliente_nuevo
        where  el_tipo_ced = @w_tipoced_cliente_viejo
           and el_ced_ruc  = @w_numced_cliente_viejo

        update cob_pfijo..pf_fraccio_logconv
        set    fl_tipo_ced = @w_tipoced_cliente_nuevo,
               fl_ced_ruc = @w_numced_cliente_nuevo
        where  fl_tipo_ced = @w_tipoced_cliente_viejo
           and fl_ced_ruc  = @w_numced_cliente_viejo
      end

      /** INSERTA EN TABLA REGISTROS MODIFICADOS */

      insert into cl_pivote_ente_upd
                  (pi_ente_nuevo,pi_ente_viejo,pi_fecha_traslado,pi_funcionario,
                   pi_procesado)
      values      (@i_nue_cliente,@i_ente,getdate(),@s_user,'P')

      /** INSERTA TRANSERVICIO **/

      insert into ts_traslado_producto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,det_producto,
                   cod_producto,fecha_modificacion,subtipo,tipo_persona,
                   tipo_sociedad)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_nue_cliente,@i_det_producto,
                   @i_producto,getdate(),@w_tipo_persona_nuevo,
                   @w_tipo_cliente_nuevo
                   ,
                   @w_natjur_nuevo)

      commit tran

    end
  end
  return 0

go

