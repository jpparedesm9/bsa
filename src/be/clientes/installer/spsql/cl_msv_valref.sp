/***********************************************************************/
/*   Archivo:                    cl_msv_valref.sp                      */
/*   Stored procedure:           sp_msv_valrefe                        */
/*   Base de Datos:              cobis                                 */
/*   Producto:                   cobis                                 */
/*   Disenado por:               Julian Mendigaña                      */
/*   Fecha de Documentacion:     22/Jun/2016                           */
/***********************************************************************/
/*                        IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                        PROPOSITO                                    */
/*   Este procedimiento realiza proceso Masivo de validación de fechas */
/*   de activación de productos de referidos para que complemente una  */
/*   tabla intermedia en cob_externos para el aplicativo Solución de   */
/*   Referidos. RQ518 SPRINT                                           */
/***********************************************************************/
/*                     MODIFICACIONES                                  */
/*      FECHA            AUTOR          RAZON                          */
/*  22/SEPTIEMBRE/2015   ANDRES MUÑOZ   CCA 540 NOTIF. PROCESO EXITOSO */
/*  02/MAYO/2016         DFu            Migracion CEN                  */
/***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_msv_valrefe')
  drop proc sp_msv_valrefe
go

create proc sp_msv_valrefe
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name       char(30),
    @w_fecha_ini     datetime,
    @w_fecha_fin     datetime,
    @w_fecha_proceso datetime,
    @w_dias_Val_prod int,
    @w_monto_cdt     money,
    @w_plazo_cdt     int,
    @w_msg           varchar(255),
    @w_flag          int,
    -- Variables para calculo de fechas a validar cuando el dia es 
    -- festivo
    @w_fecha         datetime,
    @w_fecha1        datetime,
    @w_numero        int,
    @w_cont          int

  select
    @w_sp_name = 'sp_msv_valrefe'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_flag = 0

  -- Fecha proceso
  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  --  PARAMETROS ---------------------------------------------------

  -- Obtiene dias de validacion de productos
  select
    @w_dias_Val_prod = pa_int * -1
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'DVPRD'

  if @@rowcount < 1
  begin
    select
      @w_msg = 'NO EXISTE PARAMETRO PARA NUMERO DE DIAS DE VALIDACION REFERIDOS'
    goto ERROR
  end

  -- Obtiene monto minimo de CDT a validar
  select
    @w_monto_cdt = pa_money
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'MCDTRD'

  if @@rowcount < 1
  begin
    select
      @w_msg = 'NO EXISTE PARAMETRO PARA MONTOS CDT DE VALIDACION REFERIDOS'
    goto ERROR
  end

  -- Obtiene plazo de CDT a validar
  select
    @w_plazo_cdt = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'PCDTRD'

  if @@rowcount < 1
  begin
    select
      @w_msg = 'NO EXISTE PARAMETRO PARA PLAZOS CDT DE VALIDACION REFERIDOS'
    goto ERROR
  end

  --Catßlogo de Productos del -ctivo de Referidos
  select
    codigo,
    valor
  into   #actreferidos
  from   cobis..cl_catalogo
  where  tabla  = (select
                     codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_prod_act_referido')
     and estado = 'V'

  --Catßlogo de Productos del Pasivo de Referidos (CDT)
  select
    codigo,
    valor
  into   #pascdtreferidos
  from   cobis..cl_catalogo
  where  tabla  = (select
                     codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_prod_pas_cdt_referido')
     and estado = 'V'

  --Catßlogo de Productos del Pasivo de Referidos (AHORROS)
  select
    codigo,
    valor
  into   #pasahoreferidos
  from   cobis..cl_catalogo
  where  tabla  = (select
                     codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_prod_pas_ah_referido')
     and estado = 'V'

  -- Catßlogo de productos de Referidos (SEGUROS)
  select
    codigo,
    valor
  into   #segreferidos
  from   cobis..cl_catalogo
  where  tabla  = (select
                     codigo
                   from   cobis..cl_tabla
                   where  tabla = 'cl_prod_pas_seg_referido')
     and estado = 'V'

  -- INICIALIZA VARIABLES --------------------------------

  -- Fecha inferior
  select
    @w_fecha_ini = dateadd(day,
                           @w_dias_Val_prod,
                           @w_fecha_proceso)

  -- OBTIENE RANGO DE FECHAS A CONSULTAR CUANDO EL SIGUIENTE DIA 
  -- A LA FECHA DE PROCESO ES FESTIVO, ESTO DEBIDO A QUE LOS 
  -- FESTIVOS NO SE EJECUTA ESTE PROCESO ENTONCES SE SIMULA 
  -- LA EJECUCION DEL DIA CORRESPONDIENTE SEGUN EL PARAMETRO @w_dias_Val_prod

  select
    @w_fecha = @w_fecha_proceso
  select
    @w_fecha1 = @w_fecha_ini
  select
    @w_fecha = @w_fecha + 1
  select
    @w_numero = 0
  select
    @w_cont = 0

  --mirar si el siguiente dia es feriado
  while 1 = 1
  begin
    if exists(select
                *
              from   cobis..cl_dias_feriados
              where  df_ciudad = 99999
                 and df_fecha  = @w_fecha)
    begin
      select
        @w_fecha = @w_fecha + 1
      select
        @w_numero = @w_numero + 1
    end
    else
      break
  end

  while @w_cont < @w_numero
  begin
    select
      @w_fecha1 = @w_fecha1 + 1
    select
      @w_cont = @w_cont + 1
  end
  select
    @w_fecha_fin = @w_fecha1

  truncate table cob_externos..ex_carga_archivo_referidos_det

  -- CRUCE DE TABLAS  --------------------------------

  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select
      ca_tipo_id_referente,ca_nro_id_referente,'REFERENTE NO EXISTE EN COBIS',
      ca_tipo_id_referido,ca_nro_id_referido,
      'REFERIDO NO ES CLIENTE BANCAMIA',ca_fecha_inscripcion,null,null,null,
      null
    from   cob_externos..ex_carga_archivo_referidos

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 1 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --Actualizacion de existencia de referente como cliente
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_obs_referente = 'OK'
  from   cobis..cl_ente
  where  cad_tipo_id_referente = en_tipo_ced
     and cad_nro_id_referente  = en_ced_ruc

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 2 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --Actualizacion de existencia de referido como cliente
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_obs_referido = 'OK'
  from   cobis..cl_ente
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 3 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  -- Validacion fecha de inscripcion
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_obs_referido = 'FECHA DE INSCRIPCION INVALIDA'
  where  cad_fecha_inscripcion is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 4 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --Selecccion de Clientes Referidos
  select distinct
    cliente = en_ente
  into   #clientes
  from   cob_externos..ex_carga_archivo_referidos_det,
         cobis..cl_ente
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc

  -- Base de clientes con seguro
  select
    cliente_seg= op_cliente,
    operacion_seg=min(se_operacion)
  into   #seguros_cl
  from   #clientes,
         cob_cartera..ca_operacion,
         cob_cartera..ca_seguros,
         #segreferidos
  where  cliente        = op_cliente
     and se_operacion   = op_operacion
     and se_tipo_seguro = codigo
  group  by op_cliente

  select
    se_operacion,
    se_tipo_seguro
  into   #seguros
  from   #seguros_cl,
         cob_cartera..ca_seguros
  where  operacion_seg = se_operacion

  -- operaciones de cartera sin seguros 
  select
    cliente1=op_cliente,
    banco1=max(op_banco)
  into   #opera1
  from   cob_cartera..ca_operacion,
         #clientes
  where  cliente   = op_cliente
     and op_estado = 1
     and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
     and op_operacion not in (select
                                se_operacion
                              from   #seguros)
  group  by op_cliente

  -- incluye operaciones con reversos para 
  -- la fecha indicada con desembolsos realizados en otra fecha
  -- y que no tienen seguros asociados
  insert into #opera1
    select
      cliente1=op_cliente,banco1=max(op_banco)
    from   cob_cartera..ca_operacion,
           cob_cartera..ca_transaccion,
           #clientes
    where  cliente       = op_cliente
       and tr_operacion  = op_operacion
       and op_operacion not in (select
                                  se_operacion
                                from   #seguros)
       and tr_fecha_mov between @w_fecha_ini and @w_fecha_fin
       -- reversos en la fecha indicada
       and tr_fecha_mov  > op_fecha_liq
       and tr_estado     = 'CON'
       and tr_tran       = 'DES'
       and tr_secuencial < 0
    group  by op_cliente

  -- operaciones de cartera con seguros 
  select
    cliente2=op_cliente,
    banco2=max(op_banco)
  into   #opera2
  from   cob_cartera..ca_operacion,
         #clientes,
         #seguros
  where  cliente      = op_cliente
     and op_estado    = 1
     and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
     and op_operacion = se_operacion
  group  by op_cliente

  -- incluye reversos para la fecha indicada
  -- y que tienen seguros asociados y con desembolsos 
  -- realizados en una fecha anterior
  insert into #opera2
    select
      cliente2=op_cliente,banco2=max(op_banco)
    from   cob_cartera..ca_operacion,
           cob_cartera..ca_transaccion,
           #clientes,
           #seguros
    where  cliente       = op_cliente
       and op_operacion  = se_operacion
       and tr_operacion  = op_operacion
       and tr_fecha_mov between @w_fecha_ini and @w_fecha_fin
       -- reversos en la fecha indicada
       and tr_fecha_mov  > op_fecha_liq
       and tr_estado     = 'CON'
       and tr_tran       = 'DES'
       and tr_secuencial < 0
    group  by op_cliente

  delete #opera1
  from   #opera2
  where  cliente1 = cliente2

  select
    cliente1 = cliente1,
    banco = banco1
  into   #opera
  from   #opera1

  insert into #opera
    select
      *
    from   #opera2

  select
    op_cliente,
    op_banco,
    op_toperacion,
    op_fecha_liq,
    op_operacion,
    op_estado,
    op_tramite
  into   #operacion
  from   #opera,
         cob_cartera..ca_operacion
  where  op_banco = banco

  -- Seleccionar una cuenta de Ahorros por cliente
  select
    ah_cliente,
    min(ah_cta_banco)  ah_cta_banco,
    min(ah_fecha_aper) ah_fecha_aper,
    min(ah_prod_banc)  ah_prod_banc,
    min(ah_estado)     ah_estado
  into   #Ahorros1
  from   #clientes,
         cob_ahorros..ah_cuenta,
         #pasahoreferidos,
         cob_ahorros..ah_tran_servicio
  where  cliente             = ah_cliente
     and ah_cliente          = ts_cliente
     and ah_estado           = 'A'
     and ts_estado           = ah_estado
     and ts_tipo_transaccion = 201 -- activacion por deposito
     and convert(varchar, ts_fecha_ven, 101) between
         @w_fecha_ini and @w_fecha_fin
  group  by ah_cliente,
            codigo
  having codigo = min(ah_prod_banc)

  -- Seleccionar una cuenta de Ahorros por cliente
  select
    ah_cliente,
    min(ah_cta_banco)  ah_cta_banco,
    min(ah_fecha_aper) ah_fecha_aper,
    min(ah_prod_banc)  ah_prod_banc,
    min(ah_estado)     ah_estado
  into   #Ahorros_his
  from   #clientes,
         cob_ahorros..ah_cuenta,
         #pasahoreferidos,
         cob_ahorros_his..ah_his_servicio
  where  cliente             = ah_cliente
     and ah_cliente          = hs_cliente
     and ah_estado           = 'A'
     and hs_estado           = ah_estado
     and hs_tipo_transaccion = 201 -- activacion por deposito
     and convert(varchar, hs_fecha_ven, 101) between
         @w_fecha_ini and @w_fecha_fin
  group  by ah_cliente,
            codigo
  having codigo = min(ah_prod_banc)

  select
    *
  into   #Ahorros
  from   #Ahorros1

  insert into #Ahorros
    select
      *
    from   #Ahorros_his
    where  ah_cliente not in (select
                                ah_cliente
                              from   #Ahorros1)

  -- Seleccionar un CDT por cliente
  select
    op_ente,
    min(op_operacion)  op_operacion,
    min(op_toperacion) op_toperacion,
    min(op_monto)      op_monto,
    min(op_plazo_orig) op_plazo_orig,
    min(op_estado)     op_estado,
    min(op_num_banco)  op_num_banco,
    min(hi_fecha)      hi_fecha
  into   #CDT
  from   #clientes,
         cob_pfijo..pf_operacion X,
         cob_pfijo..pf_historia,
         #pascdtreferidos
  where  cliente       = op_ente
     and op_operacion  = hi_operacion
     and op_monto      >= @w_monto_cdt
     and op_plazo_orig >= @w_plazo_cdt
     and op_estado     = 'ACT'
     and hi_trn_code   = 14914
     and hi_fecha between @w_fecha_ini and @w_fecha_fin
  group  by op_ente,
            codigo
  having codigo = min(op_toperacion)

  -- EVALUACION REFERIDO PRODUCTO DE CARTERA
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = op_fecha_liq,
         cad_tipo_producto = op_toperacion,
         cad_desc_producto = valor + ' - DESEMBOLSO',
         cad_nro_producto = op_banco
  from   #operacion X,
         cobis..cl_ente,
         #actreferidos
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = op_cliente
     and op_estado            = 1
     and codigo               = X.op_toperacion
     and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
     and op_fecha_liq         >= convert(varchar, cad_fecha_inscripcion, 101)
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 5 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  -- Si no actualiza registro, lo inserta      
  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(op_fecha_liq),max(op_toperacion),
      max(valor + ' - DESEMBOLSO'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           cob_externos..ex_carga_archivo_referidos_det,
           #actreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and op_estado            = 1
       and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
       and op_fecha_liq         >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 6 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION REFERIDO PRODUCTO DE CARTERA REVERSO
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = tr_fecha_mov,
         cad_tipo_producto = op_toperacion,
         cad_desc_producto = valor + '- REVERSO DESEMBOLSO',
         cad_nro_producto = op_banco
  from   #operacion X,
         cobis..cl_ente,
         cob_cartera..ca_transaccion,
         #actreferidos
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = op_cliente
     and tr_operacion         = op_operacion
     and tr_estado            = 'CON'
     and tr_tran              = 'DES'
     and tr_secuencial        < 0
     and tr_fecha_mov between @w_fecha_ini and @w_fecha_fin
     and tr_fecha_mov         > op_fecha_liq
     and tr_fecha_mov         >= convert(varchar, cad_fecha_inscripcion, 101)
     and codigo               = X.op_toperacion
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 7 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  -- Si no actualiza registro, lo inserta   
  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(tr_fecha_mov),max(op_toperacion),
      max(valor + ' - REVERSO DESEMBOLSO'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           cob_cartera..ca_transaccion,
           cob_externos..ex_carga_archivo_referidos_det,
           #actreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and tr_operacion         = op_operacion
       and tr_estado            = 'CON'
       and tr_tran              = 'DES'
       and tr_secuencial        < 0
       and tr_fecha_mov between @w_fecha_ini and @w_fecha_fin
       and tr_fecha_mov         > op_fecha_liq
       and tr_fecha_mov         >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_desc_producto not like '%REVERSO DESEMBOLSO%'
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 8 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION REFERIDO PRODUCTO DE CARTERA REVERSO EN DIA DIFERENTE A DESEMBOLSO
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = tr_fecha_mov,
         cad_tipo_producto = op_toperacion,
         cad_desc_producto = valor + '- REVERSO EN DIA DIFERENTE A DESEMBOLSO',
         cad_nro_producto = op_banco
  from   #operacion X,
         cobis..cl_ente,
         cob_cartera..ca_transaccion,
         #actreferidos
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = op_cliente
     and tr_operacion         = op_operacion
     and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
     and tr_estado            = 'CON'
     and tr_tran              = 'DES'
     and tr_secuencial        < 0
     and tr_fecha_mov         > op_fecha_liq
     and tr_fecha_mov         >= convert(varchar, cad_fecha_inscripcion, 101)
     and codigo               = X.op_toperacion
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 8A HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  -- Si no actualiza registro, lo inserta   
  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(tr_fecha_mov),max(X.op_toperacion),
      max(valor + ' - REVERSO EN DIA DIFERENTE A DESEMBOLSO'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           cob_cartera..ca_transaccion,
           cob_externos..ex_carga_archivo_referidos_det,
           #actreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and tr_operacion         = op_operacion
       and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
       and tr_estado            = 'CON'
       and tr_tran              = 'DES'
       and tr_secuencial        < 0
       and tr_fecha_mov not between @w_fecha_ini and @w_fecha_fin
       and tr_fecha_mov         > op_fecha_liq
       and tr_fecha_mov         >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 8B HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION REFERIDO PRODUCTO DE CARTERA REVERSO (INSERCION DEL DESEMBOLSO QUE SE REVERSO)
  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(op_fecha_liq),max(X.op_toperacion),
      max(valor + ' - DESEMBOLSO DEL REVERSO'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           #actreferidos,
           cob_externos..ex_carga_archivo_referidos_det
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and cad_nro_producto     = op_banco
       and cad_desc_producto like '%REVERSO DESEMBOLSO%'
       and op_fecha_liq not between @w_fecha_ini and @w_fecha_fin
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 8 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --UTILIZACION DE CUPO DE CREDITO
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = op_fecha_liq,
         cad_tipo_producto = op_toperacion,
         cad_desc_producto = valor + ' - UTILIZACION',
         cad_nro_producto = op_banco
  from   #operacion X,
         cobis..cl_ente,
         cob_credito..cr_tramite,
         #actreferidos
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = op_cliente
     and op_tramite           = tr_tramite
     and tr_tipo              = 'T'
     and tr_estado            <> 'Z' -- anulado
     and op_estado            = 1
     and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
     and op_fecha_liq         >= convert(varchar, cad_fecha_inscripcion, 101)
     and codigo               = X.op_toperacion
     and op_banco             <> isnull(cad_nro_producto,
                                        0)
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 9 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(op_fecha_liq),max(op_toperacion),
      max(valor + ' - UTILIZACION'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           cob_credito..cr_tramite,
           cob_externos..ex_carga_archivo_referidos_det,
           #actreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and op_tramite           = tr_tramite
       and tr_tipo              = 'T'
       and tr_estado            <> 'Z' -- anulado
       and op_estado            = 1
       and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
       and op_fecha_liq         >= convert(varchar, cad_fecha_inscripcion, 101)
       and op_banco             <> isnull(cad_nro_producto,
                                          0)
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 10 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION PRODUCTOS SEGUROS
  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(op_fecha_liq),min(se_tipo_seguro),
      min(valor + ' - SEGUROS VOLUNTARIOS'),
      max(op_banco)
    from   #operacion X,
           cobis..cl_ente,
           cob_externos..ex_carga_archivo_referidos_det,
           #seguros,
           #segreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_cliente
       and se_operacion         = op_operacion
       and op_estado            = 1
       and op_fecha_liq between @w_fecha_ini and @w_fecha_fin
       and op_fecha_liq         >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_tipo_producto    = op_toperacion
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = min(se_tipo_seguro)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 11 HACIENDO INSERT EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION PRODUCTOS PASIVOS (CUENTAS AHORROS)

  -- busca en transacciones del dia
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = ah_fecha_aper,
         cad_tipo_producto = ah_prod_banc,
         cad_desc_producto = valor + ' - AHORROS',
         cad_nro_producto = ah_cta_banco
  from   cobis..cl_ente,
         #Ahorros X,
         #pasahoreferidos
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = ah_cliente
     and ah_fecha_aper        >= convert(varchar, cad_fecha_inscripcion, 101)
     and codigo               = X.ah_prod_banc
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 12 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(ah_fecha_aper),max(ah_prod_banc),
      max(valor + ' - AHORROS'),
      max(ah_cta_banco)
    from   cob_externos..ex_carga_archivo_referidos_det,
           cobis..cl_ente,
           #Ahorros X,
           #pasahoreferidos
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = ah_cliente
       and ah_fecha_aper        >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = max(X.ah_prod_banc)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 13 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --EVALUACION PRODUCTOS PASIVOS (CDT)
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_fecha_activ = hi_fecha,
         cad_tipo_producto = op_toperacion,
         cad_desc_producto = valor + ' - CDT',
         cad_nro_producto = op_num_banco
  from   cobis..cl_ente,
         #pascdtreferidos,
         #CDT
  where  cad_tipo_id_referido = en_tipo_ced
     and cad_nro_id_referido  = en_ced_ruc
     and en_ente              = op_ente
     and hi_fecha             >= convert(varchar, cad_fecha_inscripcion, 101)
     and cad_tipo_producto is null

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 16 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  insert into cob_externos..ex_carga_archivo_referidos_det
              (cad_tipo_id_referente,cad_nro_id_referente,cad_obs_referente,
               cad_tipo_id_referido,cad_nro_id_referido,
               cad_obs_referido,cad_fecha_inscripcion,cad_fecha_activ,
               cad_tipo_producto,cad_desc_producto,
               cad_nro_producto)
    select distinct
      cad_tipo_id_referente,cad_nro_id_referente,'OK',cad_tipo_id_referido,
      cad_nro_id_referido,
      'OK',cad_fecha_inscripcion,max(hi_fecha),max(op_toperacion),
      max(valor + ' - CDT'),
      max(convert(varchar(24), op_num_banco))
    from   cob_externos..ex_carga_archivo_referidos_det,
           cobis..cl_ente,
           #pascdtreferidos,
           #CDT
    where  cad_tipo_id_referido = en_tipo_ced
       and cad_nro_id_referido  = en_ced_ruc
       and en_ente              = op_ente
       and hi_fecha             >= convert(varchar, cad_fecha_inscripcion, 101)
       and cad_tipo_producto is not null
    group  by cad_tipo_id_referente,
              cad_nro_id_referente,
              cad_tipo_id_referido,
              cad_nro_id_referido,
              cad_fecha_inscripcion,
              codigo
    having codigo = min(op_toperacion)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 17 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  -- Enmascara numero de producto
  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_nro_producto = right(replicate('*', 12) + substring(
                                  cad_nro_producto, len(
                                         rtrim(
                                                            cad_nro_producto))
                                                            -3, 4),
                                  12)

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 18 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  --Eliminar duplicados
  select
    *
  into   #temporal
  from   cob_externos..ex_carga_archivo_referidos_det

  truncate table cob_externos..ex_carga_archivo_referidos_det

  insert into cob_externos..ex_carga_archivo_referidos_det
    select distinct
      *
    from   #temporal

  ---- Actualiza referidos sin productos
  select
    cad_nro_id_referido,
    count(1) cantidad
  into   #ref_null
  from   cob_externos..ex_carga_archivo_referidos_det
  where  cad_fecha_activ is null
     and cad_obs_referido = 'OK'
  group  by cad_nro_id_referido
  having count(1) = 1

  update cob_externos..ex_carga_archivo_referidos_det
  set    cad_obs_referido = 'REFERIDO SIN PRODUCTOS ACTIVADOS EN ESTA FECHA'
  from   #ref_null ref
  where  cob_externos..ex_carga_archivo_referidos_det.cad_nro_id_referido =
         ref.cad_nro_id_referido

  if @@error <> 0
  begin
    select
      @w_msg =
'ERROR 19 HACIENDO UPDATE EN TABLA cob_externos..ex_carga_archivo_referidos_det'
  goto ERROR
end

  return 0

  ERROR:

  exec cobis..sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = 1,
    @i_usuario     = 'opbatch',
    @i_tran        = 9999,
    @i_tran_name   = 'sp_msv_valrefe',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg

  return 1

go

