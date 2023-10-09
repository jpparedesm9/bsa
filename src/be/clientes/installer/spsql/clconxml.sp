/************************************************************************/
/*  Archivo:            clconxml.sp                                     */
/*  Stored procedure:   sp_cons_inf_xml                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:       Gabriel Alvis                                   */
/*  Fecha de escritura: 12/Abr/2010                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                           PROPOSITO                                  */
/*  Consulta la Historia de Crédito proveniente de las Centrales de     */
/*  Riesgo posterior a la interpretación de la trama XML.               */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR             RAZON                               */
/* 01/Sep/2010  J. Ardila      Req. 130 Modificaciones Datacredito      */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if object_id('sp_cons_inf_xml') is not null
  drop proc sp_cons_inf_xml
go

create proc sp_cons_inf_xml
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_show_version bit = 0,
  @i_modo         char(1) = null,
  @i_ente         int = null,
  @i_secuencial   int = null,
  @i_item         int = 0
as
  declare
    @w_return  int,
    @w_error   int,
    @w_sp_name varchar(32),
    -- INI JAR CASO 130
    @w_fecha   varchar(10),
    @w_mm      varchar(2),
    @w_yy      varchar(4)
  -- FIN JAR CASO 130

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_cons_inf_xml'

  if @i_modo = 'A'
  begin
    set rowcount 10

    select
      wa_item,
      wa_desc_fuente,
      wa_fecha_colocacion,
      wa_texto
    from   cl_ws_alerta_tmp
    where  wa_secuencial = @i_secuencial
       and wa_item       > @i_item
    order  by wa_item

    set rowcount 0
  end

  if @i_modo = 'C'
  begin
    select
      wc_fecha,
      wc_tipo_cuenta,
      wc_entidad,
      wc_oficina,
      wc_ciudad,
      wc_orden = row_number()
                   over(
                     order by convert(datetime, wc_fecha, 103) desc, wc_entidad)
    into   #consulta
    from   cl_ws_consulta_tmp
    where  wc_secuencial = @i_secuencial

    set rowcount 10

    select
      wc_fecha,
      wc_tipo_cuenta,
      wc_entidad,
      wc_oficina,
      wc_ciudad,
      wc_orden
    from   #consulta
    where  wc_orden > @i_item
    order  by wc_orden

    set rowcount 0
  end

  if @i_modo = 'D'
  begin
    select
      we_fecha_reporte,
      we_num_comercial = sum(case
                               when we_tipo_credito = 'CMR' then
                               we_numero_creditos
                             end),
      we_vlr_comercial = sum(case
                               when we_tipo_credito = 'CMR' then
                               we_saldo_pendiente / 1000
                             end),
      we_num_hipotecario = sum(case
                                 when we_tipo_credito = 'HIP' then
                                 we_numero_creditos
                               end),
      we_vlr_hipotecario = sum(case
                                 when we_tipo_credito = 'HIP' then
                                 we_saldo_pendiente / 1000
                               end),
      we_num_consumo = sum(case
                             when we_tipo_credito = 'CNS' then
                             we_numero_creditos
                           end),
      we_vlr_consumo = sum(case
                             when we_tipo_credito = 'CNS' then
                             we_saldo_pendiente / 1000
                           end),
      we_num_microcredito = sum(case
                                  when we_tipo_credito = 'MIC' then
                                  we_numero_creditos
                                end),
      we_vlr_microcredito = sum(case
                                  when we_tipo_credito = 'MIC' then
                                  we_saldo_pendiente / 1000
                                end),
      we_orden = row_number()
                   over(
                     order by we_fecha_reporte)
    into   #endeudamiento
    from   cl_ws_endeuda_tmp
    where  we_secuencial = @i_secuencial
    group  by we_fecha_reporte

    set rowcount 40

    select
      we_fecha_reporte,
      we_num_comercial,
      we_vlr_comercial,
      we_num_hipotecario,
      we_vlr_hipotecario,
      we_num_consumo,
      we_vlr_consumo,
      we_num_microcredito,
      we_vlr_microcredito,
      we_orden
    from   #endeudamiento
    where  we_orden > @i_item
    order  by we_orden

    set rowcount 0
  end

  --INI JAR CASO 130
  if @i_modo = 'G' -- Endeudamiento Global Clasificado
  begin
    select
      @w_fecha = max(we_fecha_reporte)
    from   cobis..cl_ws_endeuda_tmp
    where  we_secuencial = @i_secuencial

    if @w_fecha is not null
    begin
      select
        @w_fecha = @w_fecha + '/01'

      select
        @w_yy = convert(varchar, datepart(yy,
                                          dateadd(mm,
                                                  -6,
                                                  convert(datetime, @w_fecha))))
        ,
        @w_mm = convert(varchar, datepart(mm,
                                          dateadd(mm,
                                                  -6,
                                                  convert(datetime, @w_fecha))))

      select
        @w_mm = replicate('0', 2-len(@w_mm)) + @w_mm
      select
        @w_fecha = @w_yy + '/' + @w_mm

      select
        we_fecha_reporte,
        we_calificacion,
        we_entidad = ltrim(rtrim(replace(we_entidad,
                                         '0',
                                         ''))),
        we_vlr_comercial = isnull(sum(case
                                        when we_tipo_credito = 'CMR' then isnull
                                        (
                                        we_saldo_pendiente,
                                        0) / 1000
                                      end),
                                  0),
        we_vlr_hipotecario = isnull(sum(case
                                          when we_tipo_credito = 'HIP' then
                                          isnull
                                          (
                                          we_saldo_pendiente,
                                          0) / 1000
                                        end),
                                    0),
        we_vlr_consumo = isnull(sum(case
                                      when we_tipo_credito = 'CNS' then isnull(
                                      we_saldo_pendiente,
                                      0) / 1000
                                    end),
                                0),
        we_vlr_microcredito = isnull(sum(case
                                           when we_tipo_credito = 'MIC' then
                                           isnull(
                                           we_saldo_pendiente,
                                           0) / 1000
                                         end),
                                     0),
        we_moneda,
        we_garantia = substring(we_garantia,
                                1,
                                2),
        we_orden = row_number()
                     over(
                       order by we_fecha_reporte desc, we_calificacion,
                     we_entidad
                     )
      into   #glb_endeuda
      from   cobis..cl_ws_endeuda_tmp
      where  we_secuencial    = @i_secuencial
         and we_fecha_reporte >= @w_fecha
      group  by we_fecha_reporte,
                we_calificacion,
                we_entidad,
                we_moneda,
                we_garantia

      set rowcount 40
      select
        we_fecha_reporte,
        we_calificacion,
        we_entidad,
        we_vlr_comercial,
        we_vlr_hipotecario,
        we_vlr_consumo,
        we_vlr_microcredito,
        we_moneda,
        we_garantia,
        we_orden
      from   #glb_endeuda
      where  we_orden > @i_item
      order  by we_orden

      set rowcount 0
    end
  end

  if @i_modo = 'H' -- Habito de Pago
  begin
    select
      wo_tip_producto,
      wo_estado,
      wo_tipo_cuenta,
      wo_num_ctas = count(1),
      wo_orden = row_number()
                   over(
                     order by case when wo_tip_producto = 'AHO' then 1 when
                   wo_tip_producto =
                   'CTE' then 2 when wo_tip_producto = 'TCR' then 3 when
                   wo_tip_producto = 'CAR'
                   then 4 end, wo_tipo_cuenta)
    into   #hab_pago
    from   cl_ws_obligacion_tmp
    where  wo_secuencial = @i_secuencial
    group  by wo_tipo_cuenta,
              wo_tip_producto,
              wo_estado

    set rowcount 40
    select
      wo_desc_tipo_cta = (select
                            C.valor
                          from   cl_catalogo C,
                                 cl_tabla T
                          where  T.tabla  = 'cl_tip_cta_data'
                             and T.codigo = C.tabla
                             and C.codigo = H.wo_tipo_cuenta),
      wo_desc_estado = case
                         when wo_tip_producto in ('CAR', 'TCR') then
                         (select
                            valor
                          from   cl_tabla T,
                                 cl_catalogo C
                          where
                         T.tabla  = 'cl_est_tc_ca_data'
                                                                         and
                         C.tabla
                         = T.codigo
                                                                         and
                         C.codigo
                         = H.wo_estado)
                         when wo_tip_producto in ('AHO', 'CTE') then
                         (select
                            valor
                          from   cl_tabla T,
                                 cl_catalogo C
                          where
                         T.tabla  = 'cl_est_ah_cc_data'
                                                                         and
                         C.tabla
                         = T.codigo
                                                                         and
                         C.codigo
                         = H.wo_estado)
                       end,
      wo_num_ctas,
      wo_orden
    from   #hab_pago H
    where  wo_orden > @i_item
    order  by wo_orden

    set rowcount 0
  end

  --FIN JAR CASO 130

  if @i_modo = 'E'
  begin
    select
      we_nomlar,
      we_ced_ruc,
      we_procedencia,
      we_nacional,
      (select
         valor
       from   cobis..cl_tabla T,
              cobis..cl_catalogo C
       where  T.tabla  = 'cl_gen_data'
          and C.tabla  = T.codigo
          and C.codigo = W.we_genero),
      (select
         valor
       from   cobis..cl_tabla T,
              cobis..cl_catalogo C
       where  T.tabla  = 'cl_eciv_data'
          and C.tabla  = T.codigo
          and C.codigo = W.we_ecivil),
      we_edad_min,
      we_edad_max,
      (select
         valor
       from   cobis..cl_tabla T,
              cobis..cl_catalogo C
       where  T.tabla  = 'cl_edoc_data'
          and C.tabla  = T.codigo
          and C.codigo = W.we_id_estado),
      we_id_fecha_exp,
      we_id_ciudad_exp,
      we_id_dpto_exp,
      dbo.fn_concatena('cl_respue_data',
                       we_cod_fin_consulta),
      we_fecha_consulta,
      we_cod_fin_consulta -- JAR CASO 130
    from   cl_ws_ente_tmp W
    where  we_secuencial = @i_secuencial
  end

  if @i_modo = 'O'
  begin
    select
      wo_estado,
      wo_desc_estado = case
                         when wo_tip_producto in ('CAR', 'TCR') then
                         (select
                            valor
                          from   cobis..cl_tabla T,
                                 cobis..cl_catalogo C
                          where
                         T.tabla  = 'cl_est_tc_ca_data'
                                                                         and
                         C.tabla
                         = T.codigo
                                                                         and
                         C.codigo
                         = O.wo_estado)
                         when wo_tip_producto in ('AHO', 'CTE') then
                         (select
                            valor
                          from   cobis..cl_tabla T,
                                 cobis..cl_catalogo C
                          where
                         T.tabla  = 'cl_est_ah_cc_data'
                                                                         and
                         C.tabla
                         = T.codigo
                                                                         and
                         C.codigo
                         = O.wo_estado)
                       end,
      wo_tip_producto,
      wo_entidad,
      wo_fecha_apertura,
      wo_fecha_ult_actualiza,
      wo_fecha_vencimiento,
      wo_num_cuenta,
      wo_oficina,
      wo_ciudad,
      wo_periodicidad = isnull(wo_periodicidad,
                               'X'),
      wo_comportamiento,
      wo_tipo_cuenta,
      wo_garante,
      wo_desc_garante = (select
                           valor
                         from   cobis..cl_tabla T,
                                cobis..cl_catalogo C
                         where  T.tabla  = 'cl_garante_data'
                            and C.tabla  = T.codigo
                            and C.codigo = O.wo_garante),
      wo_cuota = isnull(cast(wo_cuota / 1000 as varchar),
                        'NO INFORMO'),
      wo_tot_cuotas = isnull(cast(cast(wo_tot_cuotas as numeric(12, 0)) as
                                  varchar
                             ),
                             'X'),
      wo_cuotas_canceladas = isnull(cast(cast(wo_cuotas_canceladas as
                                              numeric(12, 0)
                                         )
                                         as varchar),
                                    'X'),
      wo_cupo = isnull(cast(wo_cupo / 1000 as varchar),
                       'NO INFORMO'),
      wo_saldo_mora = isnull(cast(wo_saldo_mora / 1000 as varchar),
                             'NO INFORMO'),
      wo_saldo_act = isnull(cast(wo_saldo_act / 1000 as varchar),
                            'NO INFORMO'),
      wo_valor_inicial = isnull(cast(wo_valor_inicial / 1000 as varchar),
                                'NO INFORMO'),
      wo_max_mora,
      wo_orden = row_number()
                   over(
                     order by case when wo_tip_producto = 'AHO' then 1 when
                   wo_tip_producto =
                   'CTE' then 2 when wo_tip_producto = 'TCR' then 3 when
                   wo_tip_producto = 'CAR'
                   then 4 end, wo_tipo_cuenta)
    into   #obligacion
    from   cl_ws_obligacion_tmp O
    where  wo_secuencial = @i_secuencial

    set rowcount 5

    select
      wo_estado,
      wo_desc_estado,
      wo_tip_producto,
      wo_entidad,
      wo_fecha_apertura,
      wo_fecha_ult_actualiza,
      wo_fecha_vencimiento,
      wo_num_cuenta,
      wo_oficina,
      wo_ciudad,
      wo_periodicidad,
      wo_comportamiento,
      wo_tipo_cuenta,
      wo_garante,
      wo_desc_garante,
      wo_cuota,
      wo_tot_cuotas,
      wo_cuotas_canceladas,
      wo_cupo,
      wo_saldo_mora,
      wo_saldo_act,
      wo_valor_inicial,
      wo_max_mora,
      wo_orden
    from   #obligacion
    where  wo_orden > @i_item
    order  by wo_orden

    set rowcount 0
  end

  if @i_modo = 'T'
  begin
    select
      ws_tipo = case
                  when (wo_tip_producto = 'CAR'
                        and wo_garante = '00')
                        or (wo_tip_producto = 'TCR'
                            and wo_amparada = 'false') then 1
                  else 2
                end,
      ws_saldo_act = wo_saldo_act / 1000,
      ws_saldo_mora = wo_saldo_mora / 1000,
      ws_cuota = wo_cuota / 1000
    into   #saldo
    from   cl_ws_obligacion_tmp
    where  wo_secuencial = @i_secuencial
       and wo_tip_producto in ('TCR', 'CAR')
       and wo_estado in ('01', '13', '14', '15',
                         '16', '17', '18', '19',
                         '20', '21', '22', '23',
                         '24', '25', '26', '27',
                         '28', '29', '30', '31',
                         '32', '33', '34', '35',
                         '36', '37', '38', '39',
                         '40', '41', '45', '47')
    union
    select
      ws_tipo = 3,
      ws_saldo_act = wo_saldo_act / 1000,
      ws_saldo_mora = wo_saldo_mora / 1000,
      ws_cuota = wo_cuota / 1000
    from   cl_ws_obligacion_tmp
    where  wo_secuencial = @i_secuencial
       and wo_tip_producto in ('TCR', 'CAR')
       and wo_estado in ('01', '13', '14', '15',
                         '16', '17', '18', '19',
                         '20', '21', '22', '23',
                         '24', '25', '26', '27',
                         '28', '29', '30', '31',
                         '32', '33', '34', '35',
                         '36', '37', '38', '39',
                         '40', '41', '45', '47')

    select
      ws_tipo = case
                  when ws_tipo = 1 then 'SUBTOTAL TITULAR'
                  when ws_tipo = 2 then 'SUBTOTAL CODEUDOR'
                  when ws_tipo = 3 then 'TOTAL'
                end,
      ws_saldo_act = sum(ws_saldo_act),
      ws_saldo_mora = sum(ws_saldo_mora),
      ws_cuota = sum(ws_cuota)
    from   #saldo
    group  by ws_tipo
  end

  if @i_modo = 'S'
  begin
    select
      ws_tipo,
      ws_desc_tipo = (select
                        valor
                      from   cobis..cl_tabla T,
                             cobis..cl_catalogo C
                      where  T.tabla  = 'cl_score_data'
                         and C.tabla  = T.codigo
                         and C.codigo = S.ws_tipo),
      ws_puntaje,
      ws_calificacion
    from   cl_ws_score_tmp S
    where  ws_secuencial = @i_secuencial
  end

  return 0

  ERROR:

  exec sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error

  return 1

go

