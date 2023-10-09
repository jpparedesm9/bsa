/*****************************************************************************/
/* ARCHIVO:         ahdatmov.sp                                              */
/* NOMBRE LOGICO:   sp_datos_mov_rec                                         */
/* PRODUCTO:        Ahorros                                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Ingresar informacion de los movimientos a las tablas de REC.              */
/*****************************************************************************/
/*                          MODIFICACIONES                                   */
/* FECHA           AUTOR              RAZON                                  */
/* 10/18/2013      D. Lozano          Ajustes CCA 385                        */
/* 10/28/2014      A. Diab            CCA 466 Inclusion transacciones 26534  */
/*                                    Consulta Saldo Banca Movil             */
/* 02/03/2015      L. Coto            REQ486 PASO REPOSITORIO                */
/*                                    DATOS TRASLADOS CLIENTES               */
/* 31/03/2015      L. Guzman          REQ_432 TRASLADO PASIVOS ATSK 618      */
/* 03/May/2016     J. Salazar         Migracion COBIS CLOUD MEXICO           */
/* 03/Ago/2016     T. Baidal          Se agrega parametro para batch         */
/* 07/Sep/2016     T. Baidal          Campo origen efectivo para depositos   */
/*****************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where  name = 'sp_datos_mov_rec')
  drop proc sp_datos_mov_rec
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_mov_rec
(
  @t_show_version bit     = 0,
  @i_corresponsal char(1) = 'N', -- Req. 381 CB Red Posicionada
  @i_param1       char(1) = null
)
as
  declare
    @w_error         int,
    @w_msg           descripcion,
    @w_fecha_proc    datetime,
    @w_tabla         int,
    @w_ciudad        int,
    @w_siguiente_dia datetime,
    @w_sp_name       varchar(30),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /* Captura nombre de stored procedure */
  select @w_sp_name = 'sp_datos_mov_rec'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  --Para ejecución del batch
  if @i_param1 is not null
      select @i_corresponsal = @i_param1
  
  /* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */
  select @w_fecha_proc = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 4

  /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */-- Validacion Req 203
  select @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
  and    pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
      select @w_error = 205031,
             @w_msg   = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
      print @w_msg
      goto ERROR
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
  and    cl_tabla.tabla     = 're_pro_banc_cb'
  and    cl_catalogo.estado = 'V'

  create table #cotizacion
  (
    moneda tinyint,
    valor  money
  )

  select ct_moneda     as uc_moneda,
         max(ct_fecha) as uc_fecha
  into   #ult_cotiz
  from   cob_conta..cb_cotizacion
  where  ct_fecha <= @w_fecha_proc
  group  by ct_moneda

  insert into #cotizacion
  select ct_moneda,ct_valor
  from   cob_conta..cb_cotizacion,
         #ult_cotiz
  where  ct_moneda = uc_moneda
  and    ct_fecha  = uc_fecha

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR AHORROS EN COB_EXTERNOS */

  delete cob_externos..ex_dato_transaccion
  where  dt_aplicativo = 4

  if @@error <> 0
  begin
    select @w_error = 147000,
           @w_msg = 'Error al eliminar registros cob_externos..ex_dato_transaccion'
    goto ERROR
  end

  delete cob_externos..ex_dato_transaccion_det
  where  dd_aplicativo = 4

  if @@error <> 0
  begin
    select @w_error = 147000,
           @w_msg = 'Error al eliminar registros cob_externos..ex_dato_transaccion_det'
    goto ERROR
  end

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin

      select
      dt_tipo_tran          = tm_tipo_tran,
      dt_fecha              = @w_fecha_proc,
      dt_sec_mod            = tm_secuencial,
      dt_secuencial         = row_number() over(order by tm_cta_banco, tm_secuencial asc),
      dt_banco              = tm_cta_banco,
      dt_toperacion         = convert(varchar(10), tm_prod_banc),
      dt_aplicativo         = 4,
      dt_fecha_trans        = tm_fecha,
      dt_tipo_trans         = isnull((select tp_tipo
                                    from   cob_remesas..re_trn_perfil
                                    where  tp_tipo_tran = t.tm_tipo_tran),
                                    'XXXXX'),
      dt_moneda             = isnull(tm_moneda,0),
      dt_concepto           = cc_concepto,
      dt_valor              = case cc_campo1
                              when 'tm_valor'           then isnull(tm_valor,0)
                              when 'tm_chq_propios'     then isnull(tm_chq_propios,0)
                              when 'tm_chq_locales'     then isnull(tm_chq_locales,0)
                              when 'tm_chq_ot_plazas'   then isnull(tm_chq_ot_plazas,0)
                              when 'tm_efectivo'        then isnull(tm_efectivo,0)
                              when 'tm_saldo_interes'   then isnull(tm_saldo_interes,0)
                              when 'tm_interes'         then isnull(tm_interes,0)
                              when 'tm_monto_imp'       then isnull(tm_monto_imp,0)
                              when 'tm_valor_comision'  then isnull(tm_valor_comision,0)
                              else 0
                              end,
      dt_reversa            = isnull(tm_estado,'N'),
      dt_naturaleza         = tm_signo,
      dt_canal              = isnull((select eq_val_interfaz
                                      from   cob_remesas..re_equivalencias
                                      where  eq_modulo  = 4
                                      and    eq_mod_int = 36
                                      and    eq_tabla   = 'CANAL'
                                      and    t.tm_canal = eq_val_cfijo),'OFI'),
      dt_oficina            = tm_oficina,
      dt_secuencial_caja    = isnull(tm_ssn_branch,tm_secuencial),
      dt_usuario            = tm_usuario,
      dt_terminal           = tm_terminal,
      dt_fecha_hora         = tm_hora,
      dd_codigo_valor       = tp_perfil,
	  dt_origen_efectivo    = case when tm_tipo_tran in (246, 248,251, 252, 254) then tm_stand_in else NULL end
      into  #transaccion_cb
      from  cob_ahorros..ah_tran_monet_tmp t,
            cob_remesas..re_concepto_contable,
            cob_remesas..re_trn_perfil
      where cc_producto             = 4
      and   tp_producto             = 4
      and   tp_tipo_tran            = tm_tipo_tran
      and   tm_tipo_tran            = cc_tipo_tran
      and   isnull(tm_causa,'')     = isnull(cc_causa,'')
      and   isnull(tm_indicador,0)  = isnull(cc_indicador,0)
      and   tm_estado is null
      and   tm_prod_banc           <> @w_prod_bancario
      -- Req. 381 CB Red Posicionada
      order by tm_cta_banco,
               tm_secuencial,
               tm_tipo_tran
      -- print ' cambio de signo'
      -- print 'nuevamente'
      -- select  * from #transaccion where  dt_naturaleza = 'D'
      -- print ' Ex_dato_transaccion ..........'
      /* REGISTRO DE LAS TRANSACCIONES DIARIAS EN COB_EXTERNOS */
      insert into cob_externos..ex_dato_transaccion
                  (dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
                   dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
                   dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,
                   dt_fecha_hora)
      select distinct
             dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
             dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
             dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,dt_fecha_hora
      from   #transaccion_cb

      if @@error <> 0
      begin
          select * from   #transaccion_cb
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion'
          print @w_msg
          goto ERROR
      end
  end
  else
  begin
      -- print ' comienza '
      select
      dt_tipo_tran          = tm_tipo_tran,
      dt_fecha              = @w_fecha_proc,
      dt_sec_mod            = tm_secuencial,
      dt_secuencial         = row_number() over(order by tm_cta_banco, tm_secuencial asc),
      dt_banco              = tm_cta_banco,
      dt_toperacion         = convert(varchar(10), tm_prod_banc),
      dt_aplicativo         = 4,
      dt_fecha_trans        = tm_fecha,
      dt_tipo_trans         = isnull((select
                                        tp_tipo
                                      from   cob_remesas..re_trn_perfil
                                      where  tp_tipo_tran = t.tm_tipo_tran),
                                     'XXXXX'),
      dt_moneda             = isnull(tm_moneda,0),
      dt_concepto           = cc_concepto,
      dt_valor              = case cc_campo1
                              when 'tm_valor'           then isnull(tm_valor,0)
                              when 'tm_chq_propios'     then isnull(tm_chq_propios,0)
                              when 'tm_chq_locales'     then isnull(tm_chq_locales,0)
                              when 'tm_chq_ot_plazas'   then isnull(tm_chq_ot_plazas,0)
                              when 'tm_efectivo'        then isnull(tm_efectivo,0)
                              when 'tm_saldo_interes'   then isnull(tm_saldo_interes,0)
                              when 'tm_interes'         then isnull(tm_interes,0)
                              when 'tm_monto_imp'       then isnull(tm_monto_imp,0)
                              when 'tm_valor_comision'  then isnull(tm_valor_comision,0)
                              else 0
                              end,
      dt_reversa            = isnull(tm_estado,'N'),
      dt_naturaleza         = tm_signo,
      dt_canal              = isnull((select eq_val_interfaz
                                      from   cob_remesas..re_equivalencias
                                      where  eq_modulo  = 4
                                      and    eq_mod_int = 36
                                      and    eq_tabla   = 'CANAL'
                                      and    t.tm_canal = eq_val_cfijo),'OFI'),
      dt_oficina            = tm_oficina,
      dt_secuencial_caja    = isnull(tm_ssn_branch,tm_secuencial),
      dt_usuario            = tm_usuario,
      dt_terminal           = tm_terminal,
      dt_fecha_hora         = tm_hora,
      dd_codigo_valor       = tp_perfil
      into  #transaccion
      from  cob_ahorros..ah_tran_monet_tmp t,
            cob_remesas..re_concepto_contable,
            cob_remesas..re_trn_perfil
      where cc_producto            = 4
      and   tp_producto            = 4
      and   tp_tipo_tran           = tm_tipo_tran
      and   tm_tipo_tran           = cc_tipo_tran
      and   isnull(tm_causa,'')    = isnull(cc_causa,'')
      and   isnull(tm_indicador,0) = isnull(cc_indicador,0)
      and   tm_estado is null
      order by tm_cta_banco,
               tm_secuencial,
               tm_tipo_tran
      -- print ' cambio de signo'
      -- print 'nuevamente'
      -- select  * from #transaccion where  dt_naturaleza = 'D'
      -- print ' Ex_dato_transaccion ..........'
      /* REGISTRO DE LAS TRANSACCIONES DIARIAS EN COB_EXTERNOS */
      insert into cob_externos..ex_dato_transaccion
                 (dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
                  dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
                  dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,
                  dt_fecha_hora)
      select distinct
             dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
             dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
             dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,dt_fecha_hora
      from   #transaccion

      if @@error <> 0
      begin
          select * from   #transaccion
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion'
          print @w_msg
          goto ERROR
      end
  end

/* **** CAMBIO DE SIGNO PARA LAS NOTAS DEBITOS ***** */
  -- select * from #transaccion where  dt_naturaleza = 'D'

/* *** Todos los valores van en positivo sin importar naturaleza **** */
/* ***
update #transaccion
set dt_valor = dt_valor * -1
where  dt_naturaleza = 'D'

if @@error <> 0 begin
   select
   @w_error = 143003,
   @w_msg = 'Error en al Actualizar el signo de los valores con naturaleza Debito'
   print @w_msg
   goto ERROR
end
**** */

  /* REGISTRO DEL DETALLE DE TRANSACCIONES DIARIAS EN COB_EXTERNOS */
  -- print ' Ex_dato_transaccion_det ....'
  select *
  into   #ex_dato_transaccion_det
  from   cob_externos..ex_dato_transaccion_det
  where  1 = 2

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
      insert into #ex_dato_transaccion_det
                 (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
                  dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_origen_efectivo)
      select @w_fecha_proc,dt_secuencial,dt_banco,dt_toperacion,4,
	         isnull((select eq_val_interfaz
                     from   cob_remesas..re_equivalencias
                     where  eq_modulo    = 4
                     and    eq_mod_int   = 36
                     and    eq_tabla     = 'TIPCONCEPT'
                     and    eq_val_cfijo = dt_concepto),dt_concepto),
			 dt_moneda,valor,sum(dt_valor),dt_origen_efectivo
      from   #transaccion_cb,
             #cotizacion -- , cob_conta_super..sb_equivalencias
      where  moneda = dt_moneda
      -- and   eq_catalogo      = 'TIPCONCEPT'
      -- and   eq_valor_cat     = dt_concepto
      group  by dt_secuencial,
                dt_banco,
                dt_toperacion,
                dt_concepto,
                dt_moneda,
                valor,
                dd_codigo_valor,
				dt_origen_efectivo
      order  by dt_banco,
                dt_secuencial,
                dt_toperacion,
                dt_moneda,
                valor

      if @@error <> 0
      begin
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det'
          print @w_msg
          goto ERROR
      end

      /* **** Se ingresan las mismas transacciones con cambio de signo para reflejar la contrapartida contable **** */
      insert into #ex_dato_transaccion_det
                  (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
                   dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_codigo_valor,dd_origen_efectivo)
      select @w_fecha_proc,dt_secuencial,dt_banco,dt_toperacion,4,
            'CAP',dt_moneda,valor,sum(dt_valor),dd_codigo_valor, dt_origen_efectivo
      /* * la contrapartida va con valor en positivo ttambien *** */
      from   #transaccion_cb,
             #cotizacion -- , cob_conta_super..sb_equivalencias
      where  moneda = dt_moneda
      -- and   eq_catalogo      = 'TIPCONCEPT'
      group  by dt_secuencial,
                dt_banco,
                dt_toperacion,
                dt_moneda,
                valor,
                dd_codigo_valor,
				dt_origen_efectivo
      order  by dt_banco,
                dt_secuencial,
                dt_toperacion,
                dt_moneda,
                valor

      if @@error <> 0
      begin
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det CAP'
          print @w_msg
          goto ERROR
      end

      insert into cob_externos..ex_dato_transaccion_det
      select *
      from   #ex_dato_transaccion_det
      where  dd_monto <> 0
      order  by dd_secuencial
  end
  else
  begin
      insert into #ex_dato_transaccion_det
                (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
                 dd_concepto,dd_moneda,dd_cotizacion,dd_monto)
      select @w_fecha_proc,dt_secuencial,dt_banco,dt_toperacion,4,
             isnull((select eq_val_interfaz
                     from   cob_remesas..re_equivalencias
                     where  eq_modulo    = 4
                     and    eq_mod_int   = 36
                     and    eq_tabla     = 'TIPCONCEPT'
                     and    eq_val_cfijo = dt_concepto),dt_concepto),
					 dt_moneda,valor,sum(dt_valor)
      from   #transaccion,
             #cotizacion -- , cob_conta_super..sb_equivalencias
      where  moneda = dt_moneda
      -- and   eq_catalogo      = 'TIPCONCEPT'
      -- and   eq_valor_cat     = dt_concepto
      group  by dt_secuencial,
                dt_banco,
                dt_toperacion,
                dt_concepto,
                dt_moneda,
                valor,
                dd_codigo_valor
      order  by dt_banco,
                dt_secuencial,
                dt_toperacion,
                dt_moneda,
                valor

      if @@error <> 0
      begin
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det'
          print @w_msg
          goto ERROR
      end

      /* **** Se ingresan las mismas transacciones con cambio de signo para reflejar la contrapartida contable **** */
      insert into #ex_dato_transaccion_det
                  (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
                   dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_codigo_valor)
      select @w_fecha_proc,dt_secuencial,dt_banco,dt_toperacion,4,
            'CAP',dt_moneda,valor,sum(dt_valor),dd_codigo_valor
      /* * la contrapartida va con valor en positivo ttambien *** */
      from   #transaccion,
             #cotizacion -- , cob_conta_super..sb_equivalencias
      where  moneda = dt_moneda
      -- and   eq_catalogo      = 'TIPCONCEPT'
      group  by dt_secuencial,
                dt_banco,
                dt_toperacion,
                dt_moneda,
                valor,
                dd_codigo_valor
      order  by dt_banco,
                dt_secuencial,
                dt_toperacion,
                dt_moneda,
                valor

      if @@error <> 0
      begin
          select @w_error = 143003,
                 @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det CAP'
          print @w_msg
          goto ERROR
      end

      insert into cob_externos..ex_dato_transaccion_det
      select *
      from   #ex_dato_transaccion_det
      where  dd_monto <> 0
      order  by dd_secuencial
  end

  
  -- ---------------------------------------------------------------------------------------------
  -- ah_tran_servicio + ah_cuenta => ex_dato_transaccion
  -- ---------------------------------------------------------------------------------------------
  /* ** INSERTANDO TRANSACCIONES NO MONETARIAS EN COB_EXTERNOS - TRANSACCIONES DE CONSULTA** */
  insert into cob_externos..ex_dato_transaccion
              (dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
               dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
               dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,
               dt_fecha_hora)
  select ts_tsfecha,ts_secuencial,ts_cta_banco,'0',4,
         ts_tsfecha,case ts_tipo_transaccion when 230 then 'CONS' end,
         isnull(ts_estado,'N'),'D','OFI',
         ts_oficina,ts_ssn_branch,
         substring(ts_usuario,1,14),
         substring(ts_terminal,1,20),ts_hora
  from   cob_ahorros..ah_tran_servicio t,
         cob_ahorros..ah_cuenta
  where  ts_tipo_transaccion in (230)
  and    ts_estado is null
  and    ts_tsfecha   = @w_fecha_proc
  and    ts_cta_banco = ah_cta_banco
  and    ts_ssn_branch not in (select dt_secuencial_caja
                               from   cob_externos..ex_dato_transaccion
                               where  dt_fecha      = @w_fecha_proc
                               and    dt_aplicativo = 4)
  if @@error <> 0
  begin
      -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
      if @i_corresponsal = 'N'
          select * from   #transaccion_cb
      else
          select * from   #transaccion
        
      select @w_error = 143003,
             @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion 2'
      print @w_msg
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- ex_dato_transaccion + ah_tran_servicio => ex_dato_transaccion_det
  -- ---------------------------------------------------------------------------------------------
  insert into cob_externos..ex_dato_transaccion_det
              (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
               dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_codigo_valor)
  select dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
         'EFEMN',isnull(ts_moneda,0),0,0,ts_causa
  from   cob_externos..ex_dato_transaccion,
         cob_ahorros..ah_tran_servicio t
  where  dt_aplicativo      = 4 --ahorros
  and    dt_fecha           = @w_fecha_proc
  and    dt_fecha           = ts_tsfecha
  and    ts_tipo_transaccion in (230)
  and    dt_secuencial_caja = ts_ssn_branch
	  
  if @@error <> 0
  begin
      select @w_error = 143003,
             @w_msg = 'Error en al Grabar en table cob_externos..ex_dato_transaccion_det EFEMN '
      print @w_msg
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- cc_tran_servicio + cc_ctacte => ex_dato_transaccion
  -- ---------------------------------------------------------------------------------------------
  --Transaccion de pago de cheque por ventanilla cca 385, en el camopo dt_toperacion se guarda el numero del cheque
  insert into cob_externos..ex_dato_transaccion
              (dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
               dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
               dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,
               dt_fecha_hora)
  select ts_tsfecha,ts_secuencial,ts_cta_banco,convert(varchar(10), ts_cheque),3,
         ts_tsfecha,case ts_tipo_transaccion when 64 then 'PAGCHQ'end,
		   isnull(ts_estado,'N'),'D','OFI',
         ts_oficina,ts_ssn_branch,
		   substring(ts_usuario,1,14),
		   substring(ts_terminal,1,20),
		   ts_hora
  from   cob_cuentas..cc_tran_servicio t,
         cob_cuentas..cc_ctacte
  where  ts_tipo_transaccion = 64
  and    ts_estado is null
  and    ts_tsfecha          = @w_fecha_proc
  and    ts_cta_banco        = cc_cta_banco
  and    ts_secuencial not in (select dt_secuencial
                               from   cob_externos..ex_dato_transaccion
                               where  dt_fecha      = @w_fecha_proc
                               and    dt_aplicativo = 3)
  if @@error <> 0
  begin
      select @w_error = 203042,
             @w_msg = 'Error en inserci¾n en tabla cob_externos..ex_dato_transaccion'
      print @w_msg
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- ex_dato_transaccion + cc_tran_servicio => ex_dato_transaccion_det
  -- ---------------------------------------------------------------------------------------------
  insert into cob_externos..ex_dato_transaccion_det
              (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
               dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_codigo_valor)
  select dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
         'EFEMN',isnull(ts_moneda,0),0,ts_saldo,ts_causa
  from   cob_externos..ex_dato_transaccion,
         cob_cuentas..cc_tran_servicio t
  where  dt_aplicativo       = 3 --ahorros
  and    dt_fecha            = @w_fecha_proc
  and    dt_fecha            = ts_tsfecha
  and    ts_tipo_transaccion = 64
  and    dt_secuencial       = ts_secuencial
  if @@error <> 0
  begin
      select @w_error = 201242,
             @w_msg = 'Error al Grabar en tabla cob_externos..ex_dato_transaccion_det EFEMN '
      print @w_msg
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- ws_tran_servicio + ah_cuenta => ex_dato_transaccion
  -- ---------------------------------------------------------------------------------------------
  /* ** INSERTANDO TRANSACCIONES NO MONETARIAS EN COB_EXTERNOS - TRANSACCIONES DE CONSULTA WS - REQ 371 - CAV - 21/09/2013** */
  insert into cob_externos..ex_dato_transaccion
              (dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
               dt_fecha_trans,dt_tipo_trans,dt_reversa,dt_naturaleza,dt_canal,
               dt_oficina,dt_secuencial_caja,dt_usuario,dt_terminal,
               dt_fecha_hora)
  select ts_fecha,ts_ssn,ts_banco_orig,'0',4,
         ts_fecha,'CONS',ts_correccion,'D',(select eq_val_interfaz
											  from   cob_remesas..re_equivalencias
											  where  eq_tabla     = 'CANAL'
											  and    eq_val_cfijo = ts_canal),
         isnull(ts_codcorr,ts_oficina),0,ts_login_ext,ts_terminal,
		 ts_hora
  from   cobis..ws_tran_servicio,
         cob_ahorros..ah_cuenta
  where  ts_tipo_tran in (26518, 26534)
     and ts_estado     = 'A' -- SOLO EXITOSAS
     and ts_fecha      = @w_fecha_proc
     and ts_banco_orig = ah_cta_banco
     and ts_ssn not in (select
                          dt_secuencial
                        from   cob_externos..ex_dato_transaccion
                        where  dt_fecha      = @w_fecha_proc
                           and dt_aplicativo = 4)
  if @@error <> 0
  begin
      select *
      from   #transaccion
      select @w_error = 143004,
             @w_msg = 'Error en al Grabar en tabla cob_externos..ex_dato_transaccion (ws)'
      print @w_msg
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- ex_dato_transaccion + ws_tran_servicio => ex_dato_transaccion_det
  -- ---------------------------------------------------------------------------------------------
  insert into cob_externos..ex_dato_transaccion_det
              (dd_fecha,dd_secuencial,dd_banco,dd_toperacion,dd_aplicativo,
               dd_concepto,dd_moneda,dd_cotizacion,dd_monto,dd_codigo_valor)
  select dt_fecha,dt_secuencial,dt_banco,dt_toperacion,dt_aplicativo,
         case ts_tipo_tran
         when 26518 then 'EFEMN'
         when 26534 then 'EFMN'
         end,0,0,0,ts_tipo_tran
  from   cob_externos..ex_dato_transaccion,
         cobis..ws_tran_servicio
  where  ts_tipo_tran in (26518, 26534)
  and    ts_estado     = 'A' -- SOLO EXITOSAS
  and    dt_fecha      = @w_fecha_proc
  and    dt_fecha      = ts_fecha
  and    dt_aplicativo = 4
  and    dt_banco      = ts_banco_orig
  and    dt_secuencial = ts_ssn

  if @@error <> 0
  begin
      select @w_error = 143004,
             @w_msg = 'Error en al Grabar en tabla cob_externos..ex_dato_transaccion_det (ws)'
      print @w_msg
      goto ERROR
  end
  
  /* ** TRANSACCIONES NO MONETARIAS EN COB_EXTERNOS - TRANSACCIONES DE CONSULTA WS - REQ 371 - CAV - 21/09/2013** */
  /* DETERMINAR EL SIGUIENTE DIA HABIL (ULTIMO PROCESO) */
  select @w_siguiente_dia = dateadd(dd,1,@w_fecha_proc)

  while datepart(mm,@w_fecha_proc) = datepart(mm,@w_siguiente_dia)
  and exists(select 1 from   cobis..cl_dias_feriados
             where  df_ciudad = @w_ciudad
             and    df_fecha  = @w_siguiente_dia)
  begin
      select @w_siguiente_dia = dateadd(dd,1,@w_siguiente_dia)
  end

  -- ---------------------------------------------------------------------------------------------
  -- Cambio de MES
  -- ---------------------------------------------------------------------------------------------
  if (datepart(mm,@w_siguiente_dia) <> datepart(mm,@w_fecha_proc))
  begin
	  -- -------------------------------------------------------
	  -- ELIMINA DATA ex_tran_mensual
	  -- ------------------------------------------------------- 
      if exists (select 1 from   cob_externos..ex_tran_mensual)
      begin
          delete cob_externos..ex_tran_mensual
          if @@error <> 0
          begin
              select @w_error = 147000,
                     @w_msg = 'Error al eliminar registros cob_externos..ex_tran_mensual'
              goto ERROR
          end
      end
	  -- -------------------------------------------------------
	  -- ELIMINA DATA ex_tran_rechazos
	  -- -------------------------------------------------------       
      if exists (select 1 from   cob_externos..ex_tran_rechazos)
      begin
          delete cob_externos..ex_tran_rechazos
          if @@error <> 0
          begin
              select @w_error = 147000,
                     @w_msg = 'Error al eliminar registros cob_externos..ex_tran_rechazos'
              goto ERROR
          end
      end
	  -- -------------------------------------------------------
	  -- INSERTA DATA ex_tran_mensual
	  -- -------------------------------------------------------       
      insert into cob_externos..ex_tran_mensual
                  (tm_ano,tm_mes,tm_cuenta,tm_cod_trn,tm_cantidad)
      select tm_ano,tm_mes,tm_cuenta,tm_cod_trn,tm_cantidad
      from   cob_ahorros..ah_tran_mensual

      if @@error <> 0
      begin
          select @w_error = 28010,
                 @w_msg = 'ERROR INSERTANDO DATOS EN ex_tran_rechazos'
          print @w_msg
          goto ERROR
      end
	  -- -------------------------------------------------------
	  -- INSERTA DATA ex_tran_rechazos
	  -- -------------------------------------------------------   	  
      insert into cob_externos..ex_tran_rechazos
                  (tr_fecha,tr_oficina,tr_cod_cliente,tr_id_cliente,tr_nom_cliente,
                   tr_cta_banco,tr_tipo_tran,tr_nom_tran,
                   tr_vlr_comision,tr_vlr_iva,
                   tr_modulo,tr_causal_rech)
      select tr_fecha,tr_oficina,tr_cod_cliente,tr_id_cliente,tr_nom_cliente,
             tr_cta_banco,tr_tipo_tran,tr_nom_tran,tr_vlr_comision,tr_vlr_iva,
             tr_modulo,tr_causal_rech
      from   cob_ahorros..ah_tran_rechazos

      if @@error <> 0
      begin
          select @w_error = 28010,
                 @w_msg = 'ERROR INSERTANDO DATOS EN ex_tran_rechazos'
          print @w_msg
          goto ERROR
      end
  end
  
  
  
  -- ---------------------------------------------------------------------------------------------
  -- ELIMINA DATA ex_carga_archivo_ctas
  -- ---------------------------------------------------------------------------------------------
  if exists (select 1 from   cob_externos..ex_carga_archivo_ctas)
  begin
      delete cob_externos..ex_carga_archivo_ctas
      if @@error <> 0
      begin
          select @w_error = 147000,
                 @w_msg = 'Error al eliminar registros cob_externos..ex_carga_archivo_ctas'
          goto ERROR
      end
  end
  -- ---------------------------------------------------------------------------------------------
  -- INSERTA DATA ex_carga_archivo_ctas
  -- ---------------------------------------------------------------------------------------------
  insert into cob_externos..ex_carga_archivo_ctas
  select ca_tipo_reg,ca_secuencia,ca_tipo_carga,ca_tipo_ced,ca_ced_ruc,
         ca_nomb_arch,ca_ente,ca_cta_banco,ca_tipo_prod,ca_fecha_reg,
         ca_cant_reg,ca_valor,ca_tipo_mov,ca_causal,ca_fecha_proc,
         ca_tipo_oper,ca_estado,ca_error
  from   cob_ahorros..ah_carga_archivo_cuentas

  if @@error <> 0
  begin
      select @w_error = 28010,
             @w_msg = 'ERROR INSERTANDO DATOS EN ah_carga_archivo_cuentas'
      print @w_msg
      goto ERROR
  end
  -- ---------------------------------------------------------------------------------------------
  -- ELIMINA DATA ah_carga_archivo_cuentas
  -- ---------------------------------------------------------------------------------------------
  if exists (select 1 from   cob_ahorros..ah_carga_archivo_cuentas)
  begin
      delete cob_ahorros..ah_carga_archivo_cuentas
      if @@error <> 0
      begin
          select @w_error = 147000,
                 @w_msg = 'Error al eliminar registros cob_ahorros..ah_carga_archivo_cuentas'
          goto ERROR
      end
  end

  
  
  -- ---------------------------------------------------------------------------------------------
  -- INSERTA DATA ex_traslado_ctas_ca_ah
  -- ---------------------------------------------------------------------------------------------  
  -- REQ486 PASO REPOSITORIO DATOS TRASLADOS CLIENTES
  -- OBTENIENDO DATOS DE TRASLADO DE PASIVOS
  insert into cob_externos..ex_traslado_ctas_ca_ah
              (tc_fecha_corte,tc_cliente,tc_oficina_ini,tc_oficina_fin,
               tc_tipo_prod)
  select distinct
         td_fecha_tras,tr_ente,td_ofi_orig,td_ofi_dest,'P'
  from   cobis..cl_traslado,
         cobis..cl_traslado_detalle
  where  tr_solicitud      = td_solicitud
  and    tr_fecha_traslado = @w_fecha_proc
  order  by td_fecha_tras

  if @@error <> 0
  begin
      select @w_error = 28010,
             @w_msg = 'ERROR INSERTANDO DATOS EN EX_TRASLADO_CTAS_CA_AH'
      goto ERROR
  end

  -- ---------------------------------------------------------------------------------------------
  -- INSERTA DATA ex_condonacion_aho
  -- ---------------------------------------------------------------------------------------------  
  --REQ_557 
  insert into cob_externos..ex_condonacion_aho
              (ca_ente,ca_celular,ca_tarjeta,ca_cta_banco,ca_estado_tar,
               ca_oficina,ca_causa,ca_valor,ca_dias,ca_fecha,
               ca_aplicativo)
  select co_ente,co_celular,co_tarjeta,co_cta_banco,co_estado_tar,
         co_oficina,co_causa,co_valor,co_dias,co_fecha,
         co_aplicativo
  from   cob_ahorros..ah_condonacion
  where  co_fecha = @w_fecha_proc

  if @@error <> 0
  begin
      select @w_error = 28010,
             @w_msg = 'ERROR INSERTANDO DATOS EN cob_externos..ex_condonacion_aho'
      goto ERROR
  end --FIN --REQ_557 

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_mov_rec'

  return @w_error

go

