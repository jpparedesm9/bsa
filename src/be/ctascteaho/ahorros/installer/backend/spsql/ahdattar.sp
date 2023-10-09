/******************************************************************************/
/*  ARCHIVO:         ahdattar.sp                                              */
/*  NOMBRE LOGICO:   sp_datos_tarifas_rec                                     */
/*  PRODUCTO:        Ahorros                                                  */
/******************************************************************************/
/*                              IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/*  Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/*  alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/*  consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/*  la ley de derechos de autor y por las convenciones internacionales de     */
/*  propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/*  para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/*  penalmente a  los autores de cualquier infraccion.                        */
/** ***************************************************************************/
/*                                PROPOSITO                                   */
/*  Ingresar informacion a las tablas de las taridas para REC.                */
/** ***************************************************************************/
/*                             MODIFICACIONES                                 */
/*  FECHA             AUTOR                   RAZON                           */
/*  30/Oct/2013       Doris A Lozano          CCA 389 Formato 365 tarifas     */
/*  03/May/2016       J. Salazar              Migracion COBIS CLOUD MEXICO    */
/******************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_tarifas_rec')
  drop proc sp_datos_tarifas_rec
go

/****** Object:  StoredProcedure [dbo].[sp_datos_tarifas_rec]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_tarifas_rec
  @t_show_version bit = 0
as
  declare
    @w_error      int,
    @w_msg        descripcion,
    @w_fecha      datetime,
    @w_fecha_ini  datetime,
    @w_producto   tinyint,
    @w_tabla      int,
    @w_fecha_aux  datetime,
    @w_tasaiva    float,
    @w_return     int,
    @w_fecha_proc datetime,
    @w_sp_name    varchar(30),
    @w_numreg     int

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_datos_tarifas_rec'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_producto = 4

  --Fecha de Cierre del producto
  select
    @w_fecha = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = @w_producto

  if @@rowcount = 0
  begin
    select
      @w_error = 2609964,
      @w_msg = 'Error No es Posible Obtener la Fecha de Cierre'
    goto ERROR
  end

  --Fecha de Proceso
  select
    @w_fecha_proc = fp_fecha
  from   cobis..ba_fecha_proceso

  if @@rowcount = 0
  begin
    select
      @w_error = 2902764,
      @w_msg = 'No es Posible Obtener la Fecha de Proceso'
    goto ERROR
  end

  --Se modifica parametro  @i_finsemana a 'S'  para no tener el cuenta el sabado como dia habil CCA 389
  select
    @w_return = 0
  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fecha_proc,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'S',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  if @w_return <> 0
  begin
    select
      @w_error = 708208,
      @w_msg = 'Error al ejecutar sp_fecha_habil'
    goto ERROR
  end

  if convert(tinyint, datepart(mm,
                               @w_fecha_aux)) =
              convert(tinyint, datepart(mm,
                                        @w_fecha_proc))
  begin
    print 'No se generara informaci¾n por validacion de fecha'
    return 0
  end

  select
    @w_tabla = codigo
  from   cobis..cl_tabla
  where  tabla = 'pe_tipo_atributo'

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR AHORROS EN COB_EXTERNOS */
  delete cob_externos..ex_datos_tarifas
  where  dt_aplicativo = 4

  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg = 'Error al eliminar registros cob_externos..ex_datos_tarifas'
    goto ERROR
  end

  delete cob_externos..ex_param_tarifas
  where  pt_aplicativo = 4

  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg = 'Error al eliminar registros cob_externos..ex_param_tarifas'
    goto ERROR
  end

  select
    descripcion = vs_descripcion,
    tipo_dato = vs_tipo_dato,
    vig_desde = co_fecha_vigencia,
    producto = pf_producto,
    filial = pf_filial,
    sucursal = pf_sucursal,
    tipo_ente = me_tipo_ente,
    moneda = pf_moneda,
    pro_bancario = me_pro_bancario,
    categoria = co_categoria,
    servicio_dis = sd_nemonico,
    rubro = sp_rubro,
    tipo_atributo = tr_tipo_atributo,
    rango_desde = ra_desde,
    rango_hasta = ra_hasta,
    valor = co_val_medio,
    secuencial = co_secuencial,
    rango = co_rango
  into   #auxiliar
  from   cob_remesas..pe_servicio_dis,
         cob_remesas..pe_servicio_per,
         cob_remesas..pe_pro_final,
         cob_remesas..pe_costo,
         cob_remesas..pe_mercado,
         cob_remesas..pe_tipo_rango,
         cob_remesas..pe_rango,
         cob_remesas..pe_var_servicio
  where  sp_servicio_dis   = sd_servicio_dis
     and pf_pro_final      = sp_pro_final
     and pf_producto       = @w_producto
     and co_servicio_per   = sp_servicio_per
     and co_rango          = ra_rango
     and co_grupo_rango    = ra_grupo_rango
     and co_tipo_rango     = ra_tipo_rango
     and me_mercado        = pf_mercado
     and tr_tipo_rango     = sp_tipo_rango
     and sp_tipo_rango     = ra_tipo_rango
     and sp_grupo_rango    = ra_grupo_rango
     and vs_servicio_dis   = sd_servicio_dis
     and sp_servicio_dis   = vs_servicio_dis
     and sp_rubro          = vs_rubro
     and me_estado         = 'V'
     and sd_estado         = 'V'
     and co_fecha_vigencia <= @w_fecha_proc

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en #auxiliar'
    goto ERROR
  end

  select
    @w_numreg = count(1)
  from   #auxiliar

  print ' Cantidad de registros encontrados :' + cast (@w_numreg as varchar)

  select
    se_sec = max(secuencial),
    se_prod = producto,
    se_filial = filial,
    se_sucursal = sucursal,
    se_tipoente = tipo_ente,
    se_moneda = moneda,
    se_pro_bancario = pro_bancario,
    se_categoria = categoria,
    se_servicio = servicio_dis,
    se_rubro = rubro
  into   #secuencial
  from   #auxiliar
  group  by producto,
            filial,
            sucursal,
            tipo_ente,
            moneda,
            pro_bancario,
            categoria,
            servicio_dis,
            rubro

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en #auxiliar'
    goto ERROR
  end

  select
    pt_fecha = @w_fecha,
    pt_aplicativo = @w_producto,
    pt_nemonico = servicio_dis + '-' + rubro,
    pt_concepto = descripcion,
    pt_campo1 = convert(varchar(64), 'tabla-cl_filial'),-- filial,
    pt_campo2 = convert(varchar(64), 'tabla-cl_oficina'),-- sucursal,
    pt_campo3 = convert(varchar(64), 'catalogo-cc_tipo_banca'),-- tipo_ente,
    pt_campo4 = convert(varchar(64), 'catalogo-cl_moneda'),-- moneda,
    pt_campo5 = convert(varchar(64), 'tabla-pe_pro_bancario'),-- pro_bancario,
    pt_campo6 = convert(varchar(64), 'catalogo-pe_categoria'),-- categoria,
    pt_campo7 = convert(varchar(64), ''),
    pt_campo8 = convert(varchar(64), ''),
    pt_campo9 = convert(varchar(64), ''),
    pt_campo10 = convert(varchar(64), ''),
    pt_forma_calculo = case tipo_dato
                         when 'P' then '03'
                         when 'M' then (case moneda
                                          when 0 then '02'
                                          when 1 then '01'
                                        end)
                       end,
    pt_estado = 'V'
  into   #param_tarifas
  from   #secuencial,
         #auxiliar a
  where  se_prod         = a.producto
     and se_filial       = a.filial
     and se_sucursal     = a.sucursal
     and se_tipoente     = a.tipo_ente
     and se_moneda       = a.moneda
     and se_pro_bancario = a.pro_bancario
     and se_categoria    = a.categoria
     and se_servicio     = a.servicio_dis
     and se_rubro        = a.rubro
     and se_sec          = a.secuencial

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en #param_tarifas'
    goto ERROR
  end

  select
    @w_tasaiva = (pa_float / 100)
  from   cobis..cl_parametro
  where  pa_nemonico = 'PIVA'
     and pa_producto = 'CTE'

  if @w_tasaiva is null
  begin
    select
      @w_error = 499999,
      @w_msg = 'No existe tasa de IVA'
    goto ERROR
  end

  select
    dt_fecha = @w_fecha,
    dt_aplicativo = @w_producto,
    dt_nemonico = a.servicio_dis + '-' + a.rubro,
    dt_campo1 = convert(varchar(10), a.filial),
    dt_campo2 = convert(varchar(10), a.sucursal),
    dt_campo3 = convert(varchar(10), a.tipo_ente),
    dt_campo4 = convert(varchar(10), a.moneda),
    dt_campo5 = convert(varchar(10), a.pro_bancario),
    dt_campo6 = convert(varchar(10), a.categoria),
    dt_campo7 = convert(varchar(10), ''),
    dt_campo8 = convert(varchar(10), ''),
    dt_campo9 = convert(varchar(10), ''),
    dt_campo10 = convert(varchar(10), ''),
    dt_base_calculo = case a.tipo_atributo
                        when 'B' then 'Saldo Promedio' + '-' + cast (rango_desde
                                      as
                                      varchar) + '-' +
                                      cast (rango_hasta
                                      as varchar)
                        when 'C' then 'Saldo Contable' + '-' + cast (rango_desde
                                      as
                                      varchar) + '-' +
                                      cast (rango_hasta
                                      as varchar)
                        when 'A' then 'Saldo Disponible' + '-' + cast (
                                      rango_desde
                                      as varchar) + '-'
                                      + cast (rango_hasta as varchar)
                        when 'E' then 'Promedio Disponible' + '-' + cast (
                                      rango_desde as varchar) +
                                      '-'
                                      + cast (rango_hasta as varchar)
                        when 'D' then 'Saldo Minimo Mensual' + '-' + cast (
                                      rango_desde as varchar) +
                                      '-'
                                      + cast (rango_hasta as varchar)
                        else 'Sin Dato' + '-' + cast (rango_desde as varchar) +
                             '-'
                             + cast (rango_hasta as
                             varchar)
                      end,
    dt_valor = case tipo_dato
                 when 'P' then convert(varchar(32), convert(money, a.valor))
                 when 'M' then convert(varchar(32), (convert(money, a.valor) +
                                                     round
                                                     ((convert(
                                                     money,
                                                                     a.valor)*
                                                     @w_tasaiva), 0))
                               )
               end,
    dt_estado = 'V'
  into   #datos_tarifas
  from   #secuencial,
         #auxiliar a
  where  se_prod         = a.producto
     and se_filial       = a.filial
     and se_sucursal     = a.sucursal
     and se_tipoente     = a.tipo_ente
     and se_moneda       = a.moneda
     and se_pro_bancario = a.pro_bancario
     and se_categoria    = a.categoria
     and se_servicio     = a.servicio_dis
     and se_rubro        = a.rubro
     and se_sec          = a.secuencial

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en #datos_tarifas'
    goto ERROR
  end

  select
    @w_tabla = codigo
  from   cobis..cl_tabla
  where  tabla = 're_param_tarifario'

  /* Genera tarifario para Remesas - Cabecera */
  insert into #param_tarifas
    select
      pt_fecha = @w_fecha,pt_aplicativo = @w_producto,
      pt_nemonico = rtrim(pa_nemonico) + '-' + pa_producto,
      pt_concepto = pa_parametro,pt_campo1 = 'tabla-cl_parametro',
      pt_campo2 = 'catalogo-re_param_tarifario',pt_campo3 = '',pt_campo4 = '',
      pt_campo5 = '',pt_campo6 = '',
      pt_campo7 = '',pt_campo8 = '',pt_campo9 = '',pt_campo10 = '',
      pt_forma_calculo
      = case pa_tipo
                           when 'F' then '01'
                           else '02'
                         end,
      pt_estado = estado
    from   cobis..cl_parametro,
           cobis..cl_catalogo
    where  tabla  = @w_tabla
       and codigo = pa_nemonico
       and valor  = pa_producto

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar Cabecera #param_tarifas de Remesas'
    goto ERROR
  end

  /* Genera tarifario para Remesas - Detalle */
  insert into #datos_tarifas
    select
      dt_fecha = @w_fecha,dt_aplicativo = @w_producto,
      dt_nemonico = rtrim(pa_nemonico) + '-' + pa_producto,
      dt_campo1 = pa_producto
      ,
      dt_campo2 = codigo,
      dt_campo3 = '',dt_campo4 = '',dt_campo5 = '',dt_campo6 = '',dt_campo7 = ''
      ,
      dt_campo8 = '',dt_campo9 = '',dt_campo10 = '',
      dt_base_calculo = 'Parametro',
      dt_valor = case pa_tipo
                   when 'T' then convert(varchar(20), pa_tinyint)
                   when 'S' then convert(varchar(20), pa_smallint)
                   when 'I' then convert(varchar(20), pa_int)
                   when 'M' then convert(varchar(20), pa_money)
                   when 'F' then convert(varchar(20), pa_float)
                   else 'TIPO DE DATO INCOMPATIBLE'
                 end,
      dt_estado = 'V'
    from   cobis..cl_parametro,
           cobis..cl_catalogo
    where  tabla  = @w_tabla
       and codigo = pa_nemonico
       and valor  = pa_producto

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar Detalle #datos_tarifas de Remesas'
    goto ERROR
  end

  insert into cob_externos..ex_param_tarifas
    select distinct
      *
    from   #param_tarifas

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en  cob_externos..ex_param_tarifas'
    goto ERROR
  end

  select
    @w_numreg = count(1)
  from   #param_tarifas

  print ' Datos pasados  a cob_externos..ex_param_tarifas :' + cast (@w_numreg
        as
                                varchar)

  insert into cob_externos..ex_datos_tarifas
    select
      *
    from   #datos_tarifas

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar en ex_datos_tarifas'
    goto ERROR
  end

  return 0
  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_tarifas_rec'

  return @w_error

go

