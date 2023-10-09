/************************************************************************/
/*   Archivo:               cl_ordcobcr.sp                              */
/*   Stored procedure:      sp_orden_cobro_cer_ref                      */
/*   Base de datos:         cobis                                       */
/*   Producto:              Clientes                                    */
/*   Disenado por:          Andres Diab                                 */
/*   Fecha de escritura:    Octubre-2011                                */
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
/*                             PROPOSITO                                */
/*   Mantenimiento de las ordenes de cobro por concepto de pago de      */
/*   certificaciones y referencias bancarias.                           */
/*                                                                      */
/************************************************************************/
/*                             ACTUALIZACIONES                          */
/*     FECHA              AUTOR            CAMBIO                       */
/*    May/02/2016         DFu             Migracion CEN                 */
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
           where  name = 'sp_orden_cobro_cer_ref')
  drop proc sp_orden_cobro_cer_ref
go

create proc sp_orden_cobro_cer_ref
(
  @s_ssn          int = null,
  @s_ssn_branch   int = null,
  @s_rol          smallint = 1,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_org          char(1) = null,
  @s_sesn         int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_ref1         int = 0,-- Codigo de Transaccion enviada desde sp_genera_orden
  @i_ref2         int = 0,-- Codigo de Cliente enviado desde sp_genera_orden
  @i_ref3         varchar(30) = '',-- Valor Alfanumerico no obligatorio
  @i_modulo       char(3) = null,-- AHO, CTE, CCA, PFI
  @i_cuenta       cuenta = null,-- Numero del producto
  @i_cliente      int = null,-- Codigo del cliente
  @i_idorden      int = null,-- Numero orden de Caja, para pago en efectivo
  @i_secuencial   int = null,-- Secuencial branch de pago
  @i_fec_sol      datetime = null,-- Fecha de la solicitud
  @i_estado       char(3) = null,

  -- Estado: PXP - Pendiente por pagar, PXI - Pendiente de Imprimir, IMP - Impresa.
  @i_modo         char(1) = 'A' -- Modo: A - Automatico, M - Manual

)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(32),
    @w_error          int,
    @w_fecha_proceso  datetime,
    @w_idorden_estado char(1),
    @w_mensaje        mensaje,
    @w_estado         char(3),
    @w_clase          char(1),
    @w_secuencial     int,
    @w_modo           char(1)

  select
    @w_sp_name = 'sp_orden_cobro_cer_ref'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  if (@t_trn = 2934
      and @i_operacion <> 'I'
       or (@t_trn = 2935
            or @i_ref1 = 2935)
          and @i_operacion not in ('E', 'R')
       or @t_trn = 2936
          and @i_operacion <> 'S')
  begin
    /* Transaccion no valida */
    exec cobis..sp_cerror
      @i_num  = 351516,
      @t_from = @w_sp_name
    return 351516
  end

  /*** Si el programa es llamado desde sp_genera_orden ***/
  if @i_ref2 > 0
    select
      @i_cliente = @i_ref2

  select
    @w_clase = en_subtipo
  from   cobis..cl_ente
  where  en_ente = @i_cliente
  if @@rowcount = 0
  begin
    select
      @w_error = 101129
    goto ERROR
  end
  /*** INSERCION DE ORDEN DE COBRO ***/
  if @i_operacion = 'I'
  begin
    select
      @w_estado = pc_estado
    from   cobis..cl_pagos_certificaciones
    where  pc_modulo   = @i_modulo
       and pc_cuenta   = @i_cuenta
       and pc_cliente  = @i_cliente
       and pc_id_orden = @i_idorden
    if @@rowcount > 0
    begin
      --print 'Orden de Cobro Certificacion ya existe'
      select
        @w_error = 2903197
      goto ERROR
    end

    begin tran

    if @i_modo = 'M' -- Orden Debitada de Cta Aho.
    begin
      insert into cobis..cl_pagos_certificaciones
                  (pc_modulo,pc_cuenta,pc_cliente,pc_id_orden,pc_fec_sol,
                   pc_estado,pc_modo,pc_fec_pago)
      values      (@i_modulo,@i_cuenta,@i_cliente,@i_idorden,@w_fecha_proceso,
                   'PXI',@i_modo,@w_fecha_proceso)
      if @@error <> 0
      begin /*** Error en creacion de orden de cobro certificaciones  ***/
        select
          @w_error = 2903195
        goto ERROR
      end

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                   ts_fecha,
                   ts_usuario,ts_terminal,ts_ente,ts_oficina,ts_descripcion,
                   ts_toperacion,ts_fecha_ingreso,ts_producto,ts_observacion,
                   ts_estado
                   ,
                   ts_tipo)
      values      (@i_idorden,0,@t_trn,@w_clase,@w_fecha_proceso,
                   @s_user,@s_term,@i_cliente,@s_ofi,
                   'INSERCION DE ORDEN COBRO CERTIFICADO - DEB. AUT.',
                   'I',@s_date,@i_modulo,@i_cuenta,@i_modo,
                   'PXI')

      if @@error <> 0
      begin /*** Error en creacion de transaccion de servicio  ***/
        select
          @w_error = 103005,
          @w_mensaje = 'Error en creacion de transaccion de servicio'
        goto ERROR
      end
    end
    else --Orden de Cobro Branch
    begin
      insert into cobis..cl_pagos_certificaciones
                  (pc_modulo,pc_cuenta,pc_cliente,pc_id_orden,pc_fec_sol,
                   pc_estado,pc_modo)
      values      (@i_modulo,@i_cuenta,@i_cliente,@i_idorden,@w_fecha_proceso,
                   'PXP',@i_modo)
      if @@error <> 0
      begin /*** Error en creacion de orden de cobro certificaciones  ***/
        select
          @w_error = 2903195
        goto ERROR
      end

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                   ts_fecha,
                   ts_usuario,ts_terminal,ts_ente,ts_oficina,ts_descripcion,
                   ts_toperacion,ts_fecha_ingreso,ts_producto,ts_observacion,
                   ts_estado
                   ,
                   ts_tipo)
      values      (@i_idorden,0,@t_trn,@w_clase,@w_fecha_proceso,
                   @s_user,@s_term,@i_cliente,@s_ofi,
                   'INSERCION DE ORDEN COBRO CERTIFICADO',
                   'I',@s_date,@i_modulo,@i_cuenta,@i_modo,
                   'PXP')

      if @@error <> 0
      begin /*** Error en creacion de transaccion de servicio  ***/
        select
          @w_error = 103005,
          @w_mensaje = 'Error en creacion de transaccion de servicio'
        goto ERROR
      end
    end
    commit tran
  end

  /*** ACTUALIZACION DE ORDEN DE COBRO ***/
  if @i_operacion = 'E'
  begin
    select
      @w_estado = pc_estado,
      @i_modulo = pc_modulo,
      @i_cuenta = pc_cuenta,
      @w_modo = pc_modo
    from   cobis..cl_pagos_certificaciones
    where  pc_cliente  = @i_cliente
       and pc_id_orden = @i_idorden
       and pc_estado   <> 'IMP'
    if @@rowcount = 0
    begin
      select
        @w_error = 2903198
      goto ERROR
    end

    if @w_modo = 'A'
    begin
      select
        @w_idorden_estado = oc_estado
      from   cob_remesas..re_orden_caja
      where  oc_idorden = @i_idorden

      --Orden a procesar no existe
      if @w_idorden_estado is null
      begin
        select
          @w_error = 2600104
        goto ERROR
      end

      --Orden Anulada
      if @w_idorden_estado = 'A'
      begin
        select
          @w_error = 2600108
        goto ERROR
      end
    end

    if @w_estado = 'PXP'
    begin
      begin tran

      select
        @w_secuencial = ssn_branch
      from   cob_cuentas..cc_tsot_ingegre
      where  sec_ord_pago = @i_idorden
      if @w_secuencial is null
      begin
        select
          @w_error = 190059
        goto ERROR
      end

      update cobis..cl_pagos_certificaciones
      set    pc_estado = 'PXI',
             pc_secuencial = @w_secuencial,
             pc_fec_pago = @w_fecha_proceso
      where  pc_modulo   = @i_modulo
         and pc_cuenta   = @i_cuenta
         and pc_cliente  = @i_cliente
         and pc_id_orden = @i_idorden
      if @@error <> 0
      begin /*** Error en actualizacion de orden de cobro certificacion  ***/
        select
          @w_error = 2903196
        goto ERROR
      end

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                   ts_fecha,
                   ts_usuario,ts_terminal,ts_ente,ts_oficina,ts_descripcion,
                   ts_toperacion,ts_fecha_ingreso,ts_producto,ts_observacion,
                   ts_estado
                   ,
                   ts_tipo)
      values      (@i_idorden,0,isnull(@t_trn,
                          @i_ref1),@w_clase,@w_fecha_proceso,
                   @s_user,@s_term,@i_cliente,@s_ofi,
                   'ACTUALIZACION DE ORDEN IMPRESION CERTIFICADO',
                   'U',@w_fecha_proceso,@i_modulo,@i_cuenta,'A',
                   'PXI')

      if @@error <> 0
      begin /*** Error en creacion de transaccion de servicio  ***/
        select
          @w_error = 103005,
          @w_mensaje = 'Error en creacion de transaccion de servicio'
        goto ERROR
      end

    end

    if @w_estado = 'PXI'
    begin
      begin tran

      update cobis..cl_pagos_certificaciones
      set    pc_estado = 'IMP'
      where  pc_modulo   = @i_modulo
         and pc_cuenta   = @i_cuenta
         and pc_cliente  = @i_cliente
         and pc_id_orden = @i_idorden
      if @@error <> 0
      begin /*** Error en actualizacion de orden de cobro certificacion  ***/
        select
          @w_error = 2903196
        goto ERROR
      end

      insert into cobis..cl_tran_servicio
                  (ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_clase,
                   ts_fecha,
                   ts_usuario,ts_terminal,ts_ente,ts_oficina,ts_descripcion,
                   ts_toperacion,ts_fecha_ingreso,ts_producto,ts_observacion,
                   ts_estado
                   ,
                   ts_tipo)
      values      (@i_idorden,0,isnull(@t_trn,
                          @i_ref1),@w_clase,@w_fecha_proceso,
                   @s_user,@s_term,@i_cliente,@s_ofi,
                   'ACTUALIZACION DE ORDEN IMPRESION CERTIFICADO',
                   'U',@w_fecha_proceso,@i_modulo,@i_cuenta,'A',
                   'IMP')

      if @@error <> 0
      begin /*** Error en creacion de transaccion de servicio  ***/
        select
          @w_error = 103005,
          @w_mensaje = 'Error en creacion de transaccion de servicio'
        goto ERROR
      end
    end

    commit tran
  end

  /*** REVERSO DE ORDEN DE COBRO ***/
  if @i_operacion = 'R'
  begin
    select
      @w_estado = pc_estado,
      @i_modulo = pc_modulo,
      @i_cuenta = pc_cuenta
    from   cobis..cl_pagos_certificaciones
    where  pc_cliente  = @i_cliente
       and pc_id_orden = @i_idorden
    if @@rowcount = 0
    begin
      select
        @w_error = 2903198
      goto ERROR
    end

    select
      @w_idorden_estado = oc_estado
    from   cob_remesas..re_orden_caja
    where  oc_idorden = @i_idorden

    --Orden a procesar no existe
    if @w_idorden_estado is null
    begin
      select
        @w_error = 2600104
      goto ERROR
    end

    --Orden ya reversada
    if @w_idorden_estado = 'R'
    begin
      select
        @w_error = 2600105
      goto ERROR
    end

    if @w_estado <> 'IMP'
    begin
      -- Buscar secuencial de Reverso
      select
        @w_secuencial = ssn_corr
      from   cob_cuentas..cc_tsot_ingegre
      where  sec_ord_pago = @i_idorden
         and estado_corr is not null
         and correccion   = 'S'
      order  by secuencial asc
      if @w_secuencial is null
      begin
        select
          @w_error = 190059
        goto ERROR
      end

      update cobis..cl_pagos_certificaciones
      set    pc_estado = 'PXP',
             pc_fec_pago = null,
             pc_secuencial = @w_secuencial
      where  pc_modulo   = @i_modulo
         and pc_cuenta   = @i_cuenta
         and pc_cliente  = @i_cliente
         and pc_id_orden = @i_idorden
      if @@error <> 0
      begin /*** Error en actualizacion de orden de cobro certificacion  ***/
        select
          @w_error = 2903196
        goto ERROR
      end
    end
    else
    begin
      select
        @w_error = 2903199
      goto ERROR
    end

  end

  /*** CONSULTA DE ORDEN DE COBRO POR CLIENTE ***/
  if @i_operacion = 'S'
  begin
    select
      'ID.ORDEN' = pc_id_orden,
      'CUENTA' = pc_cuenta,
      'CLIENTE   ' = pc_cliente,
      'ID CLIENTE' = substring(en_ced_ruc,
                               1,
                               14),
      'NOMBRE    ' = substring ((ltrim(rtrim(en_nombre)) + ' ' + ltrim(rtrim(
                                 p_p_apellido)) + ' '
                                 + ltrim(rtrim(p_s_apellido))),
                                1,
                                50),
      'FORMA PAGO' = (case pc_modo
                        when 'M' then 'DEBITO A CUENTA'
                        when 'A' then 'EFECTIVO'
                        else ''
                      end),
      'FECHA SOLICITUD' = pc_fec_sol,
      'FECHA PAGO' = pc_fec_pago,
      'ESTADO' = (select
                    C.valor
                  from   cobis..cl_tabla T,
                         cobis..cl_catalogo C
                  where  T.codigo = C.tabla
                     and T.tabla  = 'cl_estado_cert'
                     and C.codigo = pc_estado)
    from   cobis..cl_pagos_certificaciones,
           cobis..cl_ente
    where  pc_cliente = en_ente
       and pc_cliente = @i_cliente
       and pc_modulo  = @i_modulo
       and pc_estado not in ('IMP', 'ANU')

  end

  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error,
    @i_msg  = @w_mensaje
  return @w_error

go

