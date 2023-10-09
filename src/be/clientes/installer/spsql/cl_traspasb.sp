/************************************************************************/
/*   Archivo            : cl_traslado_ofi.sp                            */
/*   Stored procedure   : sp_traslado_oficina                           */
/*   Base de datos      : cob_ahorros                                   */
/*   Producto           : AHORROS                                       */
/*   Disenado por       : Andres Muñoz                                  */
/*   Fecha de escritura : 2013/12/16                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
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
/*                        PROPOSITO                                     */
/*   Trasladar oficina de costos de una oficina origen x a una          */
/*   oficina destino y, este programa se puede ejecutar en linea        */
/*   (oficina especifica) o fuera de linea(Batch Masivo)                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA                AUTOR              RAZON                      */
/*   2013/12/16           Andres Muñoz       Emision Inicial            */
/*   2015/03/17           Carlos Avendaño    Se traslada segun tipo     */
/*                                           de cierre                  */
/*                        Pedro Rojas        Se traslada PFijo          */
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
           where  name = 'sp_traslado_oficina'
              and type = 'P')
  drop proc sp_traslado_oficina
go

create proc sp_traslado_oficina
(
  @t_show_version bit = 0,
  @i_param1       datetime -- Fecha de Ejecucion del proceso
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(32),
    @w_ofiorig           int,
    @w_ofidest           int,
    @w_ctabco            cuenta,
    @w_cuenta            int,
    @w_estado            char(1),
    @w_estado_cdt        char(3),
    @w_trasladada        char(1),
    @w_error             int,
    @w_msg               varchar(250),
    @w_srv               varchar(20),
    @w_usuario           varchar(20),
    @w_terminal          varchar(20),
    @w_tsfecha           datetime,
    @w_secuencial        int,
    @w_clase             char(1),
    @w_tipo_transaccion  smallint,
    @w_causa             varchar(10),
    @w_archivo           varchar(60),
    @w_hora              datetime,
    @w_saldo             money,
    @w_interes           money,
    @w_cliente           int,
    @w_valor             money,
    @w_monto             money,
    @w_producto          smallint,
    @w_clase_clte        char(1),
    @w_s_app             varchar(255),
    @w_path              varchar(255),
    @w_nombre            varchar(255),
    @w_nombre_cab        varchar(255),
    @w_destino           varchar(2500),
    @w_errores           varchar(1500),
    @w_nombre_plano      varchar(2500),
    @w_col_id            int,
    @w_columna           varchar(100),
    @w_cabecera          varchar(2500),
    @w_nom_tabla         varchar(100),
    @w_comando           varchar(2500),
    @w_path_destino      varchar(30),
    @w_cmd               varchar(2500),
    @w_anio              varchar(4),
    @w_mes               varchar(2),
    @w_dia               varchar(2),
    @w_fecha1            varchar(10),
    @w_solicitud         int,
    @w_canje             money,
    @w_registros         int,
    @w_ofi_orig          int,
    @w_ofi_dest          int,
    @w_valor_pago        money,
    @w_operacion         int,
    @w_servidor          varchar(30),
    @v_historia          int,
    @w_getdate           datetime,
    @w_descripcion       varchar(200),
    @w_nchql             varchar(20),
    @w_nefec             varchar(20),
    @w_ndias             tinyint,
    @w_vxp               varchar(11),
    @w_valor_eop_decre   money,
    @w_valor_eop_cdt_can money,
    @w_valor_eop_chlo    money,
    @w_sql               nvarchar(4000)

  select
    @w_tipo_transaccion = 374,
    @w_terminal = 'CONSOLA',
    @w_usuario = 'op_batch',
    @w_sp_name = 'sp_traslado_oficina',
    @w_hora = getdate()

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_tsfecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_secuencial = max(ts_secuencial) + 1
  from   cob_ahorros..ah_tran_servicio

  select
    @w_servidor = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'SRVR'

  select
    @w_getdate = getdate()

  --GENERA SECUENCIAL AUTOMATTICO
  if @w_secuencial is null
    exec @w_secuencial = ADMIN...rp_ssn

  --Inicia Ahorros
  select
    solicitud = td_solicitud,
    ofiorig = td_ofi_orig,
    ofidest = td_ofi_dest,
    ctabco = td_operacion,
    estcta = td_estado_ope,
    trasla = convert(char(1), null),
    canje = td_encanje,
    cliente = convert(int, 0),
    dispgirar = convert(money, 0),
    disponible = convert(money, 0),
    encanje = convert(money, 0),
    saldoint = convert(money, 0),
    prodbanc = convert(money, 0),
    clase_clte = convert(char(1), null),
    observacion = convert(varchar(255), null)
  into   #cuenta
  from   cobis..cl_traslado,
         cobis..cl_traslado_detalle
  where  tr_solicitud = td_solicitud
     and td_producto  = 4
     and tr_estado in ('A', 'E')
  --Procesar todas las solicitudes que se encuentren en estado AUTORIZADO PARA TRASLADO O QUE SE ENCUENTREN REGISTROS PENDIENTES POR CANJE

  select
    @w_registros = @@rowcount
  select
    @w_error = @@error

  if @w_registros = 0
  begin
    select
      @w_error = 208158,
      @w_msg = 'NO EXISTEN REGISTROS PARA LA FECHA: ' + cast(@w_tsfecha as
               varchar
               )

    goto CDT
  end

  if @w_error <> 0
  begin
    select
      @w_error = 263500,
      @w_msg = 'ERROR AL CREAR TABLA DE TRABAJO PARA EL TRASLADO'

    goto ERROR
  end
  --Valido que las cuentas existan
  update #cuenta
  set    observacion =
         'CUENTA NO EXISTE O ESTA EN ESTADO NO PERMITIDO PARA TRASLADO'
  where  ctabco not in (select
                          ah_cta_banco
                        from   cob_ahorros..ah_cuenta
                        where  ah_estado in ('A', 'I', 'C', 'G'))

  if @@error <> 0
  begin
    select
      @w_error = 276004,
      @w_msg =
  'ERROR ACTUALIZANDO MENSAJE EN TABLA TEMPORAL TRASLADOS - ESTADO DE LA CUENTA'

    goto ERROR
  end

  update #cuenta
  set    trasla = 'S'
  from   #cuenta,
         cob_remesas..re_tesoro_nacional
  where  tn_cuenta = ctabco
     and tn_estado = 'P'

  if @@error <> 0
  begin
    select
      @w_error = 276002,
      @w_msg = 'ERROR AL ACTUALIZAR CUENTAS TRASLADADAS A DTN'
    goto ERROR
  end

  update #cuenta
  set    cliente = ah_cliente,
         dispgirar = ah_disponible + ah_12h + ah_24h,
         disponible = ah_disponible,
         encanje = ah_12h + ah_24h + ah_48h,--PEDRO ROJAS
         saldoint = ah_saldo_interes,
         prodbanc = ah_prod_banc,
         clase_clte = ah_clase_clte,
         estcta = ah_estado --PEDRO ROJAS
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = ctabco

  if @@error <> 0
  begin
    select
      @w_error = 276004,
      @w_msg =
      'ERROR ACTUALIZANDO MENSAJE EN TABLA TEMPORAL TRASLADOS - DETALLE CUENTA'

    goto ERROR
  end

  update #cuenta
  set    observacion = 'CUENTA CANCELADA SIN ORDEN DE PAGO'
  where  estcta = 'C'
     and ctabco not in (select
                          oc_ref3
                        from   cob_remesas..re_orden_caja
                        where  oc_estado = 'I'
                           and (oc_tipo   = 'P'
                                and oc_causa in ('035', '014', '012')))

  if @@error <> 0
  begin
    select
      @w_error = 276004,
      @w_msg =
      'ERROR ACTUALIZANDO MENSAJE EN TABLA TEMPORAL TRASLADOS - DETALLE CUENTA'

    goto ERROR
  end

  /* movi esto aca despues de actualizar el valor de canje de la ah_cuenta */

  update #cuenta
  set    observacion = 'CUENTA CON VALOR EN CANJE. NO ES POSIBLE TRASLADAR'
  where  encanje > 0

  if @@error <> 0
  begin
    select
      @w_error = 276004,
      @w_msg =
'ERROR ACTUALIZANDO MENSAJE EN TABLA TEMPORAL TRASLADOS - CUENTA CON CANJE'

goto ERROR
end

  update #cuenta
  set    observacion = 'OFICINA (ADMIN) ORIGEN NO EXISTE'
  where  ofiorig not in (select
                           of_oficina
                         from   cobis..cl_oficina)

  update #cuenta
  set    observacion = 'OFICINA (CONTA) ORIGEN NO EXISTE'
  where  ofiorig not in (select
                           of_oficina
                         from   cob_conta..cb_oficina)

  --PEDRO ROJAS
  update #cuenta
  set    observacion = 'OFICINA (ADMIN) DESTINO NO EXISTE'
  where  ofidest not in (select
                           of_oficina
                         from   cobis..cl_oficina)

  update #cuenta
  set    observacion = 'OFICINA (CONTA) DESTINO NO EXISTE'
  where  ofidest not in (select
                           of_oficina
                         from   cob_conta..cb_oficina)

  begin tran
  insert into cob_ahorros..ah_tran_servicio
              (ts_usuario,ts_terminal,ts_tsfecha,ts_secuencial,ts_clase,
               ts_hora,ts_tipo_transaccion,ts_cliente,ts_oficina,ts_oficina_cta,
               ts_cta_banco,ts_estado,ts_saldo,ts_valor,ts_monto,
               ts_interes,ts_prod_banc,ts_moneda,ts_clase_clte,ts_causa,
               ts_cod_alterno)
    select
      @w_usuario,@w_terminal,@w_tsfecha,@w_secuencial,'D',
      @w_hora,@w_tipo_transaccion,cliente,ofiorig,ofidest,
      ctabco,null,dispgirar,disponible,encanje,
      saldoint,prodbanc,0,clase_clte,case trasla
        when 'S' then 'T'
        else estcta
      end,
      row_number()
        over(
          order by @w_secuencial)
    from   #cuenta
    where  estcta <> 'C'
       and observacion is null

  if @@error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO + TRASLADO '

    goto ERROR
  end

  select
    @w_secuencial = @w_secuencial + 1

  insert into cob_ahorros..ah_tran_servicio
              (ts_usuario,ts_terminal,ts_tsfecha,ts_secuencial,ts_clase,
               ts_hora,ts_tipo_transaccion,ts_cliente,ts_oficina,ts_oficina_cta,
               ts_cta_banco,ts_estado,ts_saldo,ts_valor,ts_monto,
               ts_interes,ts_prod_banc,ts_moneda,ts_clase_clte,ts_causa,
               ts_cod_alterno)
    select
      @w_usuario,@w_terminal,@w_tsfecha,@w_secuencial,'D',
      @w_hora,@w_tipo_transaccion,cliente,ofiorig,ofidest,
      ctabco,null,oc_valor,oc_valor,0,
      0,prodbanc,0,clase_clte,case trasla
        when 'S' then 'T'
        else estcta
      end,
      (row_number()
         over(
           order by @w_secuencial))
    from   #cuenta,
           cob_remesas..re_orden_caja
    where  estcta     = 'C'
       and observacion is null
       and oc_ref3    = ctabco
       and oc_oficina = ofiorig
       and oc_cliente = cliente
       and oc_estado  = 'I'
       and (oc_tipo    = 'P'
            and oc_causa in ('035', '014', '012'))

  if @@error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO + TRASLADO '

    goto ERROR
  end

  --Actualizacion oficina en maestro de ahorros
  update cob_ahorros..ah_cuenta
  set    ah_oficina = ofidest
  from   #cuenta
  where  ah_cta_banco = ctabco
     and observacion is null

  if @@error <> 0
  begin
    select
      @w_error = 253004,
      @w_msg = 'ERROR ACTUALIZANDO OFICINA DEL PRODUCTO'

    goto ERROR
  end

  update cob_remesas..re_orden_caja
  set    oc_oficina = ofidest
  from   #cuenta
  where  oc_ref3    = ctabco
     and oc_oficina = ofiorig
     and oc_estado  = 'I'
     and observacion is null

  if @@error <> 0
  begin
    select
      @w_error = 276003,
      @w_msg =
    'ERROR AL ACTUALIZAR OFIDEST EN ORDENES DE PAGO EN CAJA PENDIENTES'
    goto ERROR
  end

  update cobis..cl_det_producto
  set    dp_oficina = ah_oficina
  from   cobis..cl_det_producto,
         cob_ahorros..ah_cuenta,
         #cuenta
  where  dp_producto = 4
     and dp_cuenta   = ah_cta_banco
     and ctabco      = ah_cta_banco
     and observacion is null

  if @@error <> 0
  begin
    select
      @w_error = 276006,
      @w_msg = 'ERROR ACTUALIZANDO OFICINA DEL PRODUCTO'
    goto ERROR
  end

  update cobis..cl_traslado_detalle
  set    td_estado_batch = case
                             when observacion is null then 'P'
                             when encanje > 0 then 'E'
                             else 'I'
                           end,
         td_fecha_tras = @w_tsfecha,
         td_estado_ope = estcta,
         td_saldo_total = dispgirar,
         td_saldo_dispo = disponible,
         td_observacion = isnull(observacion,
                                 'PRODUCTO TRASLADADO EXITOSAMENTE')
  from   #cuenta
  where  td_solicitud = solicitud
     and td_operacion = ctabco

  if @@error <> 0
  begin
    select
      @w_error = 276005,
      @w_msg = 'ERROR ACTUALIZANDO ESTADO DEL DETALLE DE TRASLADO'
    goto ERROR
  end
  --Termina Ahorros

  --Inicio Plazo Fijo
/* PROCESO DE TRASLADO DE LOS CDTS */
  /* CARGA PARAMETROS PLAZO FIJO */
  CDT:

  if @@trancount = 0
    begin tran

  --Concepto de cheque local
  select
    @w_nchql = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'NCHQL'

  --Concepto de efectivo
  select
    @w_nefec = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'NEFE'

  --Dias para realizar canje
  select
    @w_ndias = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'DCP'
     and pa_producto = 'PFI'

  --Concepto de VXP
  select
    @w_vxp = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'PFI'
     and pa_nemonico = 'VXP'

  /* CARGA LOS CDTS QUE FUERON APERTURADOS CON CHEQUE Y SE ENCUETNRA EN CANJE */

  select distinct
    op_operacion
  into   #cdt_en_canje
  from   cob_pfijo..pf_transaccion,
         cob_pfijo..pf_transaccion_det,
         cob_pfijo..pf_operacion
  where  op_estado      = 'ACT'
     and op_operacion   = tr_operacion
     and tr_operacion   = td_operacion
     and tr_secuencial  = td_secuencial
     and tr_tran        = 14901
     and tr_estado in ('CON', 'ING')
     and td_concepto    = @w_nchql
     and op_fecha_valor >= dateadd(dd,
                                   @w_ndias * -1,
                                   @w_tsfecha)

  /* CARGA LOS CDTS A TRASLADAR ACTIVOS A TRASLADAR */

  select
    op_operacion_c = op_operacion,
    ofi_orig = td_ofi_orig,
    ofi_dest = td_ofi_dest,
    op_monto = op_monto,
    op_total_int_estimado = op_total_int_estimado,
    op_total_int_pagados = op_total_int_pagados,
    op_int_ganado = op_int_ganado,
    op_estado = op_estado,
    op_num_banco_c = op_num_banco
  into   #cdt_traslado
  from   cob_pfijo..pf_operacion,
         cobis..cl_traslado_detalle,
         cobis..cl_traslado
  where  tr_estado in ('A', 'E')
     and td_solicitud = tr_solicitud
     and td_estado_batch in ('I', 'E')
     and td_producto  = '14'
     and td_operacion = op_num_banco
     and op_estado in ('ACT', 'VEN')
     and op_operacion not in (select
                                op_operacion
                              from   #cdt_en_canje)

  /* CDTS RECHAZADOS POR CANJE CARGA LOS CDTS CANCELADOS CON ORDEN DE PAGO ACTIVA A TRASLADAR */

  insert into #cdt_traslado
              (op_operacion_c,ofi_orig,ofi_dest,op_monto,op_total_int_estimado,
               op_total_int_pagados,op_int_ganado,op_estado,op_num_banco_c)
    select
      op_operacion,td_ofi_orig,td_ofi_dest,op_monto,op_total_int_estimado,
      op_total_int_pagados,op_int_ganado,op_estado,op_num_banco
    from   cob_pfijo..pf_emision_cheque,
           cob_pfijo..pf_mov_monet,
           cob_pfijo..pf_operacion,
           cobis..cl_traslado_detalle,
           cobis..cl_traslado
    where  tr_estado in ('A', 'E')
       and td_solicitud = tr_solicitud
       and td_estado_batch in ('I', 'E')
       and td_producto  = '14'
       and td_operacion = op_num_banco
       and op_estado    = 'CAN'
       and op_operacion = mm_operacion
       and mm_operacion = ec_operacion
       and mm_secuencia = ec_secuencia
       and ((mm_tran in (14543, 14903, 14919, 14905)
             and mm_producto  = @w_vxp) -- falta validar 14919
             or (mm_tran in (14543, 14903, 14919, 14905)
                 and mm_producto  = @w_nefec)-- falta validar 14919
           )
       and ec_estado is null

  /* Tabla <pf_operacion> */

  select
    operacion = op_operacion,
    banco = op_num_banco,
    of_org = op_oficina,
    of_des = ofi_dest
  into   #temporal1
  from   cob_pfijo..pf_operacion,
         #cdt_traslado
  where  op_operacion = op_operacion_c

  update cob_pfijo..pf_operacion
  set    op_oficina = ofi_dest
  from   #cdt_traslado
  where  op_operacion = op_operacion_c

  if @@error <> 0
  begin
    select
      @w_error = 149102,
      @w_msg = 'ERROR ACTUALIZANDO cob_pfijo..pf_operacion'
    goto ERROR
  end

  select
    @w_secuencial = @w_secuencial + 1

  insert cob_pfijo..ts_operacion
         (tipo_transaccion,secuencial,clase,operacion,fecha,
          usuario,terminal,srv,num_banco,descripcion)
    select
      14201,@w_secuencial,'P',operacion,getdate(),
      'batch','KERNELPROD','KERNELPROD',banco,'TRASLADO OFICINA' + convert(
      varchar
      (5 ), of_org) + ' A ' + convert(varchar(5)
      , of_des)
    from   #temporal1

  if @@error <> 0
  begin
    select
      @w_error = 149103,
      @w_msg = 'ERROR ACTUALIZANDO ts_operacion'
    goto ERROR
  end

/* TRASLADO CONTABLE CDTS */
  /* CARGA EN UNA TEMPORAL LOS CDTS TRASLADADOS */
  select
    op_operacion_c,
    ofi_dest,
    ofi_orig,
    op_monto,
    op_total_int_estimado,
    op_total_int_pagados,
    op_int_ganado,
    op_estado
  into   #cdt_procesar_conta
  from   #cdt_traslado
  order  by op_operacion_c

  while 1 = 1
  begin
    select
      @w_ofi_orig = 0,
      @w_ofi_dest = 0,
      @w_monto = 0,
      @w_valor_pago = 0,
      @w_valor = 0,
      @w_valor_eop_cdt_can = 0,
      @w_valor_eop_decre = 0,
      @w_estado = null

    select top 1
      @w_ofi_orig = ofi_orig,
      @w_ofi_dest = ofi_dest,
      @w_monto = op_monto,
      @w_valor = op_int_ganado,
      @w_operacion = op_operacion_c,
      @w_estado_cdt = op_estado
    from   #cdt_procesar_conta

    if @@rowcount = 0
      break

    delete #cdt_procesar_conta
    where  op_operacion_c = @w_operacion

    if @w_estado_cdt = 'VEN'
    begin
      /* pendiente por pagar de cada CDT por intereses */
      select
        @w_valor_pago = isnull(sum(isnull(mm_valor,
                                          0)),
                               0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14905
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cheque devuelto */
      select
        @w_valor_eop_chlo = isnull(sum(isnull(mm_valor,
                                              0)),
                                   0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14543
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cada CDT por decremento */
      select
        @w_valor_eop_decre = isnull(sum(isnull(mm_valor,
                                               0)),
                                    0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14919
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

    end

    if @w_estado_cdt = 'ACT'
    begin
      /* pendiente por pagar de cada CDT por intereses */
      select
        @w_valor_pago = isnull(sum(isnull(mm_valor,
                                          0)),
                               0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14905
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cheque devuelto */
      select
        @w_valor_eop_chlo = isnull(sum(isnull(mm_valor,
                                              0)),
                                   0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14543
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cada CDT por decremento */
      select
        @w_valor_eop_decre = isnull(sum(isnull(mm_valor,
                                               0)),
                                    0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14919
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

    end

    if @w_estado_cdt = 'CAN'
    begin
      /* pendiente por pagar de cada CDT por intereses */
      select
        @w_valor_pago = isnull(sum(isnull(mm_valor,
                                          0)),
                               0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14905
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cheque devuelto */
      select
        @w_valor_eop_chlo = isnull(sum(isnull(mm_valor,
                                              0)),
                                   0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14543
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cada CDT cancelado */
      select
        @w_valor_eop_cdt_can = isnull(sum(isnull(mm_valor,
                                                 0)),
                                      0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14903
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      /* pendiente por pagar de cada CDT por decremento */
      select
        @w_valor_eop_decre = isnull(sum(isnull(mm_valor,
                                               0)),
                                    0)
      from   cob_pfijo..pf_emision_cheque,
             cob_pfijo..pf_mov_monet
      where  mm_operacion = ec_operacion
         and mm_tran      = 14919
         and ec_tran      = mm_tran
         and mm_secuencia = ec_secuencia
         and ec_estado is null
         and mm_operacion = @w_operacion

      select
        @w_monto = 0
    --Se iguala a cero para no trasladar el capital de un CDT CANcelado

    end

    select
      @w_descripcion = 'TRASLADO CDT DE OFICINA ' + convert(varchar(5),
                       @w_ofi_orig)
                       +
                                    ' A OFICINA '
                       + convert(varchar(5), @w_ofi_dest)

    exec @w_return = cob_pfijo..sp_aplica_conta
      @s_date              = @w_tsfecha,--fecha de proceso
      @s_user              = 'op_batch',-- opbatch
      @s_term              = @w_servidor,-- 'Terminal'
      @s_ofi               = @w_ofi_orig,-- oficina OLD
      @i_fecha             = @w_getdate,--Gedate
      @i_tran              = 14201,--TRANSACCION DE TRASLADO
      @i_oficina_oper      = @w_ofi_dest,-- oficina NUEVA
      @i_descripcion       = @w_descripcion,--descripcion
      @i_monto             = @w_monto,-- CAPITAL
      @i_valor_pago        = @w_valor_pago,--  EOP  INERESES PENDIENTES
      @i_valor             = @w_valor,-- CAUSADO
      @i_operacionpf       = @w_operacion,
      -- Operacin interna de plazo fijo op_operaciobn
      @i_afectacion        = 'N',
      @i_secuencia         = 0,
      @i_valor_eop_cdt_can = @w_valor_eop_cdt_can,
      --EOP POR CANCELACION Q NO SE HAN RECLAMADO
      @i_valor_eop_decre   = @w_valor_eop_decre,
      -- EOP POR DECREMENTO QUE NO SE HAN RECLAMADO
      @i_valor_eop_chlo    = @w_valor_eop_chlo
    -- EOP POR SOBRANTE EN EFECTIVO CHEQUE DEVUELTO EN CANCELACION CDT
    --@o_comprobante  = @o_comprobante out

    if @w_return <> 0
    begin
      select
        @w_error = @w_return
      goto ERROR
    end

    /* GUARDA EL HISTORICO DEL CDT */

    select
      @w_secuencial = max(hi_secuencial)
    from   cob_pfijo..pf_historia
    where  hi_operacion = @w_operacion

    select
      @v_historia = @w_secuencial + 1

    update cob_pfijo..pf_operacion
    set    op_historia = @v_historia + 1
    where  op_operacion = @w_operacion

    insert into cob_pfijo..pf_historia
                (hi_operacion,hi_secuencial,hi_fecha,hi_trn_code,hi_valor,
                 hi_funcionario,hi_oficina,hi_fecha_crea,hi_fecha_mod,
                 hi_saldo_capital,
                 hi_secuencia,hi_observacion)
    values      (@w_operacion,@v_historia,@w_tsfecha,14201,@w_monto,
                 'op_batch',@w_ofi_orig,getdate(),getdate(),@w_valor_pago,
                 @v_historia,@w_descripcion )

    if @@error <> 0
    begin
      select
        @w_error = 123456,
        @w_msg = 'ERROR INSERTANDO EN cob_pfijo..pf_historia'
      goto ERROR
    end
  end

/* FIN TRASLADO CONTABLE CDTS */
/* TRASLADO Servicios Bancarios */
  /* vaida si existio un traslado por cierre de oficina */

  select
    td_ofi_orig,
    td_ofi_dest
  into   #ofi_serv_banc
  from   cobis..cl_traslado t,
         cobis..cl_traslado_detalle
  where  tr_tipo_traslado = 'CIE'
     and tr_estado        = 'A'
     and tr_solicitud     = td_solicitud
  group  by td_ofi_orig,
            td_ofi_dest
  order  by td_ofi_orig,
            td_ofi_dest

  /* CICLO PARA EL TRASLADO DE SERVICIOS BANCARIOS POR CADA CIERRE DE OFICINA */

  while 1 = 1
  begin
    select top 1
      @w_ofi_orig = td_ofi_orig,
      @w_ofi_dest = td_ofi_dest
    from   #ofi_serv_banc

    if @@rowcount = 0
      break

    delete #ofi_serv_banc
    where  td_ofi_orig = @w_ofi_orig
       and td_ofi_dest = @w_ofi_dest

    select
      @w_registros = count(1)
    from   cob_sbancarios..sb_inventario_ins
    where  ii_oficina = @w_ofi_orig

    if @w_registros > 0
    begin
      insert into cob_sbancarios..ts_inventario_ins
                  (secuencial,tipo_transaccion,clase,fecha,hora,
                   usuario,terminal,oficina,tabla,lsrv,
                   srv,producto,instrumento,sub_tipo,serie_literal,
                   serie_desde,serie_hasta,area,func_area,asignacion)
        select
          @w_secuencial,29289,'N',getdate(),getdate(),
          'sa','consola',@w_ofi_dest,'sb_inventario_ins','KERNELPROD',
          'KERNELPROD',ii_producto,ii_instrumento,ii_sub_tipo,ii_serie_literal,
          ii_serie_desde,ii_serie_hasta,ii_area,ii_func_area,ii_asignacion
        from   cob_sbancarios..sb_inventario_ins
        where  ii_oficina = @w_ofi_orig

      if @@error <> 0
      begin
        select
          @w_error = 149115,
          @w_msg = 'ERROR ACTUALIZANDO cob_sbancarios..ts_inventario_ins'
        goto ERROR
      end

      update cob_sbancarios..sb_inventario_ins
      set    ii_oficina = @w_ofi_dest
      where  ii_oficina = @w_ofi_orig

      if @@error <> 0
      begin
        select
          @w_error = 149116,
          @w_msg = 'ERROR ACTUALIZANDO cob_sbancarios..sb_inventario_ins'
        goto ERROR
      end

    end -- fin @w_registros > 0

    select
      @w_registros = 0

    select
      @w_registros = count(1)
    from   cob_sbancarios..sb_puntos_reorden
    where  pr_oficina = @w_ofi_orig

    if @w_registros > 0
    begin
      insert into cob_sbancarios..ts_puntos_reorden
                  (secuencial,tipo_transaccion,clase,fecha,hora,
                   usuario,terminal,oficina,tabla,lsrv,
                   srv,area,func_area,fecha_modif,func_modif,
                   producto,instrumento,sub_tipo,maximo,minimo,
                   actual,cant_fin_dia,fecha_conta)
        select
          @w_secuencial,29289,'N',getdate(),getdate(),
          'sa','consola',@w_ofi_dest,'sb_puntos_reorden','KERNELPROD',
          'KERNELPROD',pr_area,pr_func_area,getdate(),pr_func_creador,
          pr_producto,pr_instrumento,pr_sub_tipo,pr_maximo,pr_minimo,
          pr_actual,pr_cant_fin_dia,null
        from   cob_sbancarios..sb_puntos_reorden
        where  pr_oficina = @w_ofi_orig

      if @@error <> 0
      begin
        select
          @w_error = 149117,
          @w_msg = 'ERROR ACTUALIZANDO cob_sbancarios..ts_puntos_reorden'
        goto ERROR
      end

      update cob_sbancarios..sb_puntos_reorden
      set    pr_oficina = @w_ofi_dest
      where  pr_oficina = @w_ofi_orig

      if @@error <> 0
      begin
        select
          @w_error = 149118,
          @w_msg = 'ERROR ACTUALIZANDO cob_sbancarios..sb_puntos_reorden'
        goto ERROR
      end

    end --@w_registos > 0 (2do ciclo)

    select
      @w_registros = 0

    select
      @w_registros = count(1)
    from   cob_sbancarios..sb_impresion_lotes
    where  il_estado         = 'D'
       and il_oficina_origen = @w_ofi_orig

    if @w_registros > 0
    begin
      update cob_sbancarios..sb_impresion_lotes
      set    il_oficina_origen = @w_ofi_dest
      where  il_estado         = 'D'
         and il_oficina_origen = @w_ofi_orig

      if @@error <> 0
      begin
        select
          @w_error = 149119,
          @w_msg = 'ERROR ACTUALIZANDO cob_sbancarios..sb_impresion_lotes'
        goto ERROR
      end
    end

  end --fin servicios bancarios while 1=1

  /* ACTUALIZA LA cl_det_producto*/

  update cobis..cl_det_producto
  set    dp_oficina = ofi_dest
  from   cobis..cl_det_producto,
         #cdt_traslado
  where  dp_cuenta = op_num_banco_c

  /* ACTUALIZA EL ESTADO DEL DETALLE */

  update cobis..cl_traslado_detalle
  set    td_estado_batch = 'P',
         td_fecha_tras = @w_tsfecha,
         td_observacion = 'PRODUCTO TRASLADADO EXITOSAMENTE'
  from   cobis..cl_traslado_detalle,
         #cdt_traslado
  where  td_operacion = op_num_banco_c

  if @@error <> 0
  begin
    select
      @w_error = 149120,
      @w_msg = 'ERROR ACTUALIZANDO cobis..cl_traslado_detalle'
    goto ERROR
  end

  update cobis..cl_traslado_detalle
  set    td_estado_batch = 'E',
         td_fecha_tras = @w_tsfecha,
         td_observacion = 'PRODUCTO NO DISPONIBLE PARA TRASLADADO'
  from   cobis..cl_traslado_detalle,
         cobis..cl_traslado
  where  tr_estado in ('A', 'E')
     and td_operacion not in (select
                                op_num_banco_c
                              from   #cdt_traslado)
     and td_solicitud    = tr_solicitud
     and td_estado_batch = ('I')
     and td_producto     = '14'

  if @@error <> 0
  begin
    select
      @w_error = 149120,
      @w_msg = 'ERROR ACTUALIZANDO cobis..cl_traslado_detalle'
    goto ERROR
  end

  /* ACTUALIZA LA TEMPORAL PARA GENERAR EL REPORTE */
  insert into #cuenta
              (solicitud,ofiorig,ofidest,ctabco,estcta,
               cliente,observacion)
    select
      td_solicitud,td_ofi_orig,td_ofi_dest,td_operacion,td_estado_ope,
      tr_ente,'PRODUCTO TRASLADADO EXITOSAMENTE'
    from   cobis..cl_traslado_detalle,
           #cdt_traslado,
           cobis..cl_traslado
    where  td_operacion = op_num_banco_c
       and td_solicitud = tr_solicitud
       and td_producto  = 14

  insert into #cuenta
              (solicitud,ofiorig,ofidest,ctabco,estcta,
               cliente,observacion)
    select
      td_solicitud,td_ofi_orig,td_ofi_dest,td_operacion,td_estado_ope,
      tr_ente,'PRODUCTO NO DISPONIBLE PARA TRASLADADO'
    from   cob_pfijo..pf_operacion,
           cobis..cl_traslado_detalle,
           cobis..cl_traslado
    where  tr_estado in ('A', 'E')
       and td_solicitud    = tr_solicitud
       and td_estado_batch = 'E'
       and td_producto     = 14
       and td_operacion not in (select
                                  op_num_banco_c
                                from   #cdt_traslado)

  --Finaliza Plazo Fijo
  /*
  
  Una vez finazliado todo el proceso de traslado se cambia el estado a la solicitud del traslado
  update cobis..cl_traslado
  set tr_estado = 'P'
  
  */

  select
    tr_solicitud
  into   #solicitudes
  from   cobis..cl_traslado
  where  tr_estado in ('A', 'E')
  order  by tr_solicitud

  while 1 = 1
  begin
    select
      @w_solicitud = 0

    select top 1
      @w_solicitud = tr_solicitud
    from   #solicitudes

    if @@rowcount = 0
      break

    delete #solicitudes
    where  tr_solicitud = @w_solicitud

    if exists (select
                 1
               from   cobis..cl_traslado_detalle
               where  td_solicitud    = @w_solicitud
                  and td_estado_batch <> 'P')
    begin
      update cobis..cl_traslado
      set    tr_estado = 'E',
             tr_fecha_traslado = @w_tsfecha
      where  tr_solicitud = @w_solicitud
    end
    else
    begin
      update cobis..cl_traslado
      set    tr_estado = 'P',
             tr_fecha_traslado = @w_tsfecha
      where  tr_solicitud = @w_solicitud
    end

  end

  commit tran

  if exists (select
               1
             from   sysobjects
             where  name = 'Cheq_penemi'
                and type = 'U')
    drop table cobis..Cheq_penemi

  select
    *
  into   Cheq_penemi
  from   cob_sbancarios..sb_impresion_lotes,
         #cuenta
  where  il_oficina_destino = ofidest
     and il_estado          = 'D' --Pendiente de impresion

  if @@error <> 0
  begin
    select
      @w_error = 276000,
      @w_msg = 'Error al guardar ChqGer pendientes de imprimir'
    goto ERROR
  end

  if (select
        count(1)
      from   Cheq_penemi) = 0
  begin
    select
      @w_msg = 'NO HAY CHEQUES PENDIENTES DE IMPRESION PARA LA OFICINA: '
    drop table Cheq_penemi
    print cast(@w_msg as varchar(50)) + cast(@w_ofiorig as varchar)
  --goto FIN
  end

  /* Iniciando BCP */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  --Creando la tabla del reporte

  /* CREACION DE LA TABLA DONDE SE CARGARA EL ARCHIVO */
  if exists(select
              1
            from   sysobjects
            where  name = 'temp_arch')
    drop table temp_arch

  create table temp_arch
  (
    descripcion varchar(6000),
  )

  --Generando la fecha para el nombre del archivo
  select
    @w_anio = convert(varchar(4), datepart(yyyy,
                                           getdate())),
    @w_mes = convert(varchar(2), datepart(mm,
                                          getdate())),
    @w_dia = convert(varchar(2), datepart(dd,
                                          getdate()))

  select
    @w_fecha1 = (@w_anio + right('00' + @w_mes, 2) + right('00'+ @w_dia, 2))

  --Seleccionando el path destino para archivo de salida
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2160

  -----------------------------------------
  ----Generar Archivo de Cabeceras
  ------------------------------------------

  select
    @w_nombre_cab =
'SOLICITUD|TIPO TRASLADO|OFICINA ORIGEN|OFICINA DESTINO|NUMERO OPERACION|ESTADO OPERACION|ID CLIENTE|OBSERVACION'
  ,
@w_cabecera = convert(varchar(2000), ''),
@w_nombre = 'TRASLADOS'

  insert into temp_arch
  values      (@w_nombre_cab)

  /*Se actualiza el estado de los traslados */
  update #cuenta
  set    observacion = 'PRODUCTO TRASLADADO EXITOSAMENTE'
  where  observacion is null

  insert into temp_arch
    select
      convert(varchar(255), isnull(solicitud, ' ')) + '|'
      + convert(varchar(255), isnull(tr_tipo_traslado, ' ')) + '|'
      + convert(varchar(255), isnull(ofiorig, ' ')) + '|'
      + convert(varchar(255), isnull(ofidest, ' ')) + '|'
      + convert(varchar(255), isnull(ctabco, ' ')) + '|'
      + convert(varchar(255), isnull(estcta, ' ')) + '|'
      + convert(varchar(255), isnull(cliente, ' ')) + '|'
      + convert(varchar(255), isnull(observacion, ' ')) + '|'
    from   #cuenta,
           cobis..cl_traslado
    where  tr_solicitud = solicitud

  select
    @w_nombre_plano = @w_path + @w_nombre + '_' + @w_fecha1 + '.txt'

  --Ejecucion para Generar Archivo Datos
  select
    @w_comando = @w_s_app + 's_app bcp -auto -login cobis..temp_arch out '

  select
    @w_destino = @w_nombre_plano,
    @w_errores = @w_nombre_plano + '.err'

  select
    @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                 ' -t"|" '
                                                                  + '-config '
                                                                  + @w_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Archivo Reporte de TRASLADOS'
    goto ERROR
  end

  fin:

  print 'TRASLADO DE OFICINA OK!'

  return 0

  ERROR:

  if @@trancount > 0
    rollback tran

  if exists (select
               1
             from   sysobjects
             where  name = 'Cheq_penemi'
                and type = 'U')
    drop table cobis..Cheq_penemi

  print cast(upper(@w_sp_name) as varchar) + ', ERROR: ' + cast(@w_error as
        varchar) +
                                          ', '
        + cast(@w_msg as varchar(255))
  print 'Cuenta: ' + cast(@w_cuenta as varchar)

  select
    @w_sql =
       'echo ' + 'INFORMACIËN SOBRE EL PROCESO: ' + '>' + @w_comando +
       'Errores_PROCESO_TRASLADO'
             + '_' + replace(convert(varchar(10), sysdatetime(), 103), '/', '')
       +
       '.txt'
  exec xp_cmdshell
    @w_sql

  exec cobis..sp_errorlog
    @i_fecha       = @w_tsfecha,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = 374,
    @i_tran_name   = null,
    @i_rollback    = 'N',
    @i_descripcion = @w_msg

  --Creación archivo de salida
  select
    @w_sql = 'echo ' + @w_msg + ' Error: ' + convert(varchar, @w_error) + '>>' +
                    @w_comando
             + 'Errores_PROCESO_TRASLADO' + '_'
             + replace(convert(varchar(10), sysdatetime(), 103), '/', '') +
             '.txt' --Escribe una nueva línea en el archivo
  exec xp_cmdshell
    @w_sql

  return 0

go

