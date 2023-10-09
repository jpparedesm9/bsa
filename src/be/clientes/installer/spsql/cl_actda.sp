/* ***********************************************************************/
/*      Archivo:                cl_actda.sp                              */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           E Correa                                 */
/*      Fecha de escritura:     22-May-2009                              */
/* ***********************************************************************/
/*                          IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*                          PROPOSITO                                    */
/*  Permite aplicar en los productos los cambios de Clientes             */
/* ***********************************************************************/
/*                        MODIFICACIONES                                 */
/*  FECHA          AUTOR            RAZON                                */
/* ABR.02.2014    EliraPelaez B.    ORS:837 Habilitar para Bancamia      */
/* May/02/2016    DFu               Migracion CEN                        */
/* ***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_actualiza_dat')
  drop proc sp_actualiza_dat
go

create proc sp_actualiza_dat
(
  @i_param1       datetime = null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name       descripcion,
    @w_error         int,
    @w_fechai        datetime,
    @w_fechaf        datetime,
    @w_msg           varchar(200),
    @w_ente          int,
    @w_ente_solo     int,
    @w_valor_nue     descripcion,
    @w_campo_upd_ant descripcion,
    @w_campo         descripcion,
    @w_reg           int,
    @w_apellidos     varchar(255),
    @w_nombre_solo   varchar(255),
    @w_nombre_largo  varchar(255),
    @w_cedula_sola   varchar(30)

  select
    @w_sp_name = 'sp_actualiza_dat'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_param1 is null
  begin
    print 'ATENCION ... la fecha de parametro no se registro'
    select
      @w_error = 101001
    goto ERROR_FIN
  end

  select
    @w_fechai = convert(varchar(10), @i_param1, 101) + ' 00:00AM'
  select
    @w_fechaf = convert(varchar(10), @i_param1, 101) + ' 11:59PM'

  select
    @w_reg = isnull(count(1),
                    0)
  from   cobis..cl_actualiza
  where  ac_fecha >= @w_fechai
     and ac_fecha <= @w_fechaf

  if @w_reg = 0
  begin
    print 'ATENCION No ay datos para actualizar en esta fecha : ==> '
          + cast(@i_param1 as varchar)
    goto ERROR_FIN
  end

  print 'FEcha de Proceso ' + cast ( @i_param1 as varchar) +
        ' Registros de la fecha '
        + cast(@w_reg as varchar)
  ---PREPARACION DATOS PARA ACTUALIZAR
  ---CArga de datos para Actaulizar
  select
    fecha = ac_fecha,
    ente = ac_ente,
    campo = ac_campo,
    valor_nuevo = ac_valor_nue,
    valor_ant = ac_valor_ant
  into   #clientesActaulizados
  from   cobis..cl_actualiza
  where  ac_tabla       = 'cl_ente'
     and ac_campo in ('en_ced_ruc', 'en_nomlar', 'en_nombre', 'p_p_apellido',
                      'p_s_apellido')
     and ac_transaccion = 'U'
     and ac_valor_nue is not null
     and ac_fecha       >= @w_fechai
     and ac_fecha       <= @w_fechaf

  select
    *
  into   #clientesActaulizados_1
  from   #clientesActaulizados

  update #clientesActaulizados
  set    campo = 1
  where  campo in ('en_nomlar', 'en_nombre', 'p_p_apellido', 'p_s_apellido')

  select distinct
    'cliente_u' = ente,
    'campo_u'= campo
  into   #clientesActaulizadosunicos
  from   #clientesActaulizados

  alter table #clientesActaulizadosunicos
    add campo_upd descripcion null

  update #clientesActaulizadosunicos
  set    campo_upd = valor_nuevo
  from   #clientesActaulizados
  where  cliente_u = ente
     and campo_u   = campo
     and campo     = 'en_ced_ruc'

  alter table #clientesActaulizadosunicos
    add campo_upd_ant descripcion null

  update #clientesActaulizadosunicos
  set    campo_upd_ant = valor_ant
  from   #clientesActaulizados
  where  cliente_u = ente
     and campo_u   = campo
     and campo     = 'en_ced_ruc'

  ---Poner el nombre LArgo
  update #clientesActaulizadosunicos
  set    campo_upd = en_nomlar
  from   cobis..cl_ente
  where  cliente_u = en_ente
     and campo_u   = '1'

  print 'Los de procesar'
  select
    count(1)
  from   #clientesActaulizadosunicos

  ---FIN PREPARAR DATOS TRABAJAR
  print ''
  print 'nicio primer while'
  select
    getdate()
  print ''
  declare UPD_cliente_productos cursor for
    select
      cliente_u,
      campo_u,
      campo_upd,
      campo_upd_ant
    from   #clientesActaulizadosunicos

  open UPD_cliente_productos
  fetch UPD_cliente_productos into @w_ente, @w_campo, @w_valor_nue,
                                   @w_campo_upd_ant

  while @@fetch_status = 0
  begin
    if (@@fetch_status = -1)
    begin
      print 'Error En el cursor, No se procesara Nada'
      goto ERROR_FIN
    end

    if @w_campo = '1'
    begin
      update cob_cartera..ca_operacion
      set    op_nombre = @w_valor_nue
      where  op_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_cartera..ca_operacion  valor '
              + cast (@w_valor_nue as varchar)

      update cob_cartera..ca_operacion_his
      set    oph_nombre = @w_valor_nue
      from   cob_cartera..ca_operacion,
             cob_cartera..ca_operacion_his
      where  op_cliente    = @w_ente
         and oph_operacion = op_operacion
      if @@error <> 0
        print 'Error Actualizando cob_cartera..ca_operacion_his   valor '
              + cast (@w_valor_nue as varchar)

      update cob_pfijo..pf_operacion
      set    op_descripcion = @w_valor_nue
      where  op_ente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_pfijo..pf_operacion  valor '
              + cast (@w_valor_nue as varchar)

      update cob_pfijo..pf_det_pago_tmp
      set    dt_descripcion = @w_valor_nue
      where  dt_beneficiario = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_pfijo..pf_det_pago_tmp  valor '
              + cast (@w_valor_nue as varchar)

      update cob_sbancarios..sb_productos_neg
      set    pn_beneficiario = @w_valor_nue
      where  pn_cod_beneficiario    = @w_ente
         and pn_origen_beneficiario = 'M'
      if @@error <> 0
        print 'Error Actualizando cob_sbancarios..sb_productos_neg  valor '
              + cast (@w_valor_nue as varchar)

      update cob_credito..cr_abogado
      set    ab_nombre = @w_valor_nue
      where  ab_cliente = @w_ente
         and ab_tipo    = 'E'
      if @@error <> 0
        print 'Error Actualizando cob_credito..cr_abogado  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_cuenta
      set    ah_nombre = @w_valor_nue
      where  ah_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_cuenta  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_estado_cta
      set    ec_nombre = @w_valor_nue
      from   cob_ahorros..ah_cuenta,
             cob_ahorros..ah_estado_cta
      where  ec_cuenta          = ah_cuenta
         and ec_cliente         = ah_cliente
         and ec_fecha_prx_corte > '01/01/2009'
         and ec_cliente         = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_estado_cta  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_tran_rechazos
      set    tr_nom_cliente = @w_valor_nue
      where  tr_cod_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_tran_rechazos  valor '
              + cast (@w_valor_nue as varchar)

      update cob_cuentas..cc_ctacte
      set    cc_nombre = @w_valor_nue
      where  cc_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_cuentas..cc_ctacte  valor '
              + cast (@w_valor_nue as varchar)

      update cob_sbancarios..sb_clientes
      set    cl_nombre = @w_valor_nue
      where  cl_cod_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_cuentas..sb_clientes  valor '
              + cast (@w_valor_nue as varchar)

    end --Nombre ---> en_nomlar

    if @w_campo = 'en_ced_ruc'
    begin
      ---print 'cliente que va en ced ruc   --> ' + cast (  @w_ente as varchar) + ' @w_valor_nue: ' + cast ( @w_valor_nue as varchar) + '  @w_campo_upd_ant  : ' + cast (@w_campo_upd_ant as varchar)

      update cob_credito..cr_beneficiarios
      set    be_ced_ruc = @w_valor_nue
      where  be_ced_ruc = @w_campo_upd_ant
      if @@error <> 0
        print 'Error Actualizando  cob_credito..cr_beneficiarios  valor '
              + cast (@w_valor_nue as varchar)

      update cob_credito..cr_asegurados
      set    as_ced_ruc = @w_valor_nue
      where  as_ced_ruc = @w_campo_upd_ant
      if @@error <> 0
        print 'Error Actualizando  cob_credito..cr_asegurados  valor '
              + cast (@w_valor_nue as varchar)

      update cob_credito..cr_aseg_microseguro
      set    am_identificacion = @w_valor_nue
      where  am_identificacion = @w_campo_upd_ant
      if @@error <> 0
        print 'Error Actualizando  cob_credito..cr_aseg_microseguro  valor '
              + cast (@w_valor_nue as varchar)

      update cob_credito..cr_benefic_micro_aseg
      set    bm_identificacion = @w_valor_nue
      where  bm_identificacion = @w_campo_upd_ant
      if @@error <> 0
        print 'Error Actualizando  cob_credito..cr_benefic_micro_aseg  valor '
              + cast (@w_valor_nue as varchar)

      update cob_pfijo..pf_operacion
      set    op_ced_ruc = @w_valor_nue
      where  op_ente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_pfijo..pf_operacion  valor '
              + cast (@w_valor_nue as varchar)

      update cob_sbancarios..sb_productos_neg
      set    pn_id = @w_valor_nue
      where  pn_cod_beneficiario    = @w_ente
         and pn_origen_beneficiario = 'M'
      if @@error <> 0
        print 'Error Actualizando cob_sbancarios..sb_productos_neg  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_cuenta
      set    ah_ced_ruc = @w_valor_nue
      where  ah_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_cuenta  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_tran_servicio
      set    ts_ced_ruc = @w_valor_nue
      where  ts_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_tran_servicio  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros_his..ah_his_servicio
      set    hs_ced_ruc = @w_valor_nue
      from   cob_ahorros_his..ah_his_servicio,
             cob_ahorros..ah_cuenta
      where  hs_cliente   = @w_ente
         and hs_cta_banco = ah_cta_banco
         and hs_cliente   = ah_cliente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros_his..ah_his_servicio  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_estado_cta
      set    ec_ced_ruc = @w_valor_nue
      from   cob_ahorros..ah_cuenta,
             cob_ahorros..ah_estado_cta
      where  ec_cuenta          = ah_cuenta
         and ec_fecha_prx_corte > '01/01/2009'
         and ec_cliente         = ah_cliente
         and ec_cliente         = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_estado_cta  valor '
              + cast (@w_valor_nue as varchar)

      update cob_ahorros..ah_tran_rechazos
      set    tr_id_cliente = @w_valor_nue
      where  tr_cod_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_ahorros..ah_tran_rechazos  valor '
              + cast (@w_valor_nue as varchar)

      update cob_cuentas..cc_ctacte
      set    cc_ced_ruc = @w_valor_nue
      where  cc_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_cuentas..cc_ctacte  valor '
              + cast (@w_valor_nue as varchar)

      update cob_remesas..re_archivo_alianza
      set    ar_identificacion = @w_valor_nue
      where  ar_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_remesas..re_archivo_alianza  valor '
              + cast (@w_valor_nue as varchar)

      update cob_remesas..re_cabecera_transfer
      set    ct_identificacion = @w_valor_nue
      where  ct_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_remesas..re_cabecera_transfer  valor '
              + cast (@w_valor_nue as varchar)

      update cob_remesas..re_detalle_transfer
      set    dt_identificacion = @w_valor_nue
      where  dt_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_remesas..re_detalle_transfer  valor '
              + cast (@w_valor_nue as varchar)

      update cob_remesas..re_orden_caja
      set    oc_numdoc = @w_valor_nue
      where  oc_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_remesas..re_orden_caja  valor '
              + cast (@w_valor_nue as varchar)

      update cob_credito..cr_deudores
      set    de_ced_ruc = @w_valor_nue
      where  de_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_credito..cr_deudores valor '
              + cast (@w_valor_nue as varchar)

      update cob_sbancarios..sb_productos_neg
      set    pn_id = @w_valor_nue
      where  pn_id = @w_campo_upd_ant
      if @@error <> 0
        print 'Error Actualizando cob_sbancarios..sb_productos_neg valor '
              + cast (@w_valor_nue as varchar)

      update cob_sbancarios..sb_clientes
      set    cl_id = @w_valor_nue
      where  cl_cod_cliente = @w_ente
      if @@error <> 0
        print 'Error Actualizando cob_sbancarios..sb_clientes valor '
              + cast (@w_valor_nue as varchar)

    end --Cedula ---> en_ced_ruc

    fetch UPD_cliente_productos into @w_ente, @w_campo, @w_valor_nue,
                                     @w_campo_upd_ant
  end

  close UPD_cliente_productos
  deallocate UPD_cliente_productos

  print ''
  print 'Finnn primer while'
  select
    getdate()
  print ''

  ---Actualizar los individuales
  ---que solo se puede hacer por la cedula

  select distinct
    ente
  into   #entes_apellidos
  from   #clientesActaulizados_1
  where  campo in ('en_nombre', 'p_p_apellido', 'p_s_apellido')

  print ''
  print ''
  print 'Finalmente Las tablas que se actualizan por Cedula'

  print ''
  print 'Inico Segundo while'
  select
    getdate()
  print ''

  select
    @w_ente_solo = 0
  while 1 = 1
  begin
    set rowcount 1

    select
      @w_ente_solo = ente
    from   #entes_apellidos
    where  ente > @w_ente_solo
    order  by ente

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end
    set rowcount 0
    ---se actaulizan los tres campos
    ---de las tablas que van separadas
    select
      @w_apellidos = p_p_apellido + ' ' + p_s_apellido,
      @w_nombre_solo = en_nombre,
      @w_cedula_sola = en_ced_ruc,
      @w_nombre_largo = en_nomlar
    from   cobis..cl_ente
    where  en_ente = @w_ente_solo

    update cob_sbancarios..sb_productos_neg
    set    pn_beneficiario = @w_nombre_largo
    where  pn_id = @w_cedula_sola
    if @@error <> 0
      print 'Error Actualizando cob_sbancarios..sb_productos_neg valor '
            + cast (@w_cedula_sola as varchar)

    update cob_credito..cr_beneficiarios
    set    be_apellidos = @w_apellidos,
           be_nombres = @w_nombre_solo
    where  be_ced_ruc = @w_cedula_sola --ya la cedula esta OK sies que cambio
    if @@error <> 0
      print 'Error Actualizando cob_credito..cr_beneficiarios valor '
            + cast (@w_cedula_sola as varchar)

    update cob_credito..cr_asegurados
    set    as_apellidos = @w_apellidos,
           as_nombres = @w_nombre_solo
    where  as_ced_ruc = @w_cedula_sola --ya la cedula esta OK sies que cambio
    if @@error <> 0
      print 'Error Actualizando cob_credito..cr_asegurados valor '
            + cast (@w_cedula_sola as varchar)

    update cob_credito..cr_aseg_microseguro
    set    am_nombre_comp = @w_nombre_largo
    where  am_identificacion = @w_cedula_sola
    if @@error <> 0
      print 'Error Actualizando cob_credito..cr_aseg_microseguro  valor '
            + cast (@w_cedula_sola as varchar)

    update cob_credito..cr_benefic_micro_aseg
    set    bm_nombre_comp = @w_nombre_largo
    where  bm_identificacion = @w_cedula_sola
    if @@error <> 0
      print 'Error Actualizando cob_credito..cr_benefic_micro_aseg  valor '
            + cast (@w_cedula_sola as varchar)

  end ---while

  ---finde actualizar los individuales
  print ''
  print 'Fin Segundo while'
  select
    getdate()
  print ''

  print 'FIn DEl PRoceso'

  return 0

  ERROR_FIN:
begin
  print ''
  print @w_msg
  return 0
end

go

