/************************************************************************/
/*  Archivo:            clconxmlcf.sp                                   */
/*  Stored procedure:   sp_cons_inf_xml_cf                              */
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
/*      FECHA            AUTOR                RAZON                     */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if object_id('fn_concatena') is not null
  drop function fn_concatena
go

create function fn_concatena
(
  @w_tabla  char(30),
  @w_codigo varchar(10)
)
returns varchar(255)
as
begin
  declare @w_valor varchar(255)

  select
    @w_valor = ''

  select
    @w_valor = @w_valor + valor
  from   cobis..cl_tabla T,
         cobis..cl_catalogo C
  where  T.tabla   = @w_tabla
     and C.tabla   = T.codigo
     and @w_codigo = case
                       when charindex('-',
                                      C.codigo) > 0 then substring(C.codigo,
                                                                   1,
                                                                   charindex(
                                                                   '-',
     C.codigo)
     - 1)
     else C.codigo
     end
  order  by substring(C.codigo,
                      charindex('-', C.codigo) + 1,
                      len(C.codigo))

  return @w_valor
end
go

if object_id('sp_cons_inf_xml_cf') is not null
  drop proc sp_cons_inf_xml_cf
go

create proc sp_cons_inf_xml_cf
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_show_version bit = 0,
  @i_modo         char(2) = null,
  @i_ente         int = null,
  @i_secuencial   int = null,
  @i_item         int = 0
as
  declare
    @w_return  int,
    @w_error   int,
    @w_sp_name varchar(32)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_cons_inf_xml_cf'

  if @i_modo = 'A' --MENSAJES Y RECLAMOS
  begin
    set rowcount 10

    select
      wa_item,
      wa_codigo_alerta,
      substring(wa_texto,
                1,
                255 - charindex(' ',
                                reverse(substring(wa_texto,
                                                  1,
                                                  255)))),
      --primera parte mensaje
      wa_tipo_registro,
      wa_identificalinea,
      substring(wa_texto,
                255 - charindex(' ',
                                reverse(substring(wa_texto,
                                                  1,
                                                  255))) + 1,
                255) --segunda parte mensaje
    from   cl_ws_alerta_tmp
    where  wa_secuencial = @i_secuencial
       and wa_item       > @i_item
    order  by wa_item

    set rowcount 0
  end

  if @i_modo = 'C' -- HUELLA CONSULTAS
  begin
    select
      wc_fecha,
      wc_tipo_cuenta,
      wc_entidad,
      wc_oficina,
      wc_ciudad,
      wc_motivi_cons,
      wc_cod_tipo_ent,
      wc_cod_ent,
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
      wc_motivi_cons,
      wc_cod_tipo_ent,
      wc_cod_ent,
      wc_orden
    from   #consulta
    where  wc_orden > @i_item
    order  by wc_orden

    set rowcount 0
  end

  if @i_modo = 'D' --CONSOLIDADO
  begin
    select
      we_tipo = case
                  when we_tipo_registro = 'CONSOLPRIN' then 1
                  else 2
                end,
      we_tipo_registro,
      we_tip_producto,
      we_numero_creditos = isnull(we_numero_creditos,
                                  0),
      we_total_saldo = isnull(we_total_saldo,
                              0),
      we_participac_deuda = isnull(we_participac_deuda,
                                   0),
      we_numero_Obli_dia = isnull(we_numero_Obli_dia,
                                  0),
      we_saldo_Obli_dia = isnull(we_saldo_Obli_dia,
                                 0),
      we_cuota_Obli_dia = isnull(we_cuota_Obli_dia,
                                 0),
      we_cant_Obli_mora = isnull(we_cant_Obli_mora,
                                 0),
      we_saldo_Obli_mora = isnull(we_saldo_Obli_mora,
                                  0),
      we_cuota_Obli_mora = isnull(we_cuota_Obli_mora,
                                  0),
      we_saldo_pendiente = isnull(we_saldo_pendiente,
                                  0)
    into   #saldos
    from   cl_ws_endeuda_tmp
    where  we_secuencial = @i_secuencial
       and we_tip_producto not in ('Total', 'Subtotal Principal',
                                   'Subtotal Codeudor Y Otros')
    union
    select
      we_tipo = 3,
      we_tipo_registro,
      we_tip_producto,
      we_numero_creditos = isnull(we_numero_creditos,
                                  0),
      we_total_saldo = isnull(we_total_saldo,
                              0),
      we_participac_deuda = isnull(we_participac_deuda,
                                   0),
      we_numero_Obli_dia = isnull(we_numero_Obli_dia,
                                  0),
      we_saldo_Obli_dia = isnull(we_saldo_Obli_dia,
                                 0),
      we_cuota_Obli_dia = isnull(we_cuota_Obli_dia,
                                 0),
      we_cant_Obli_mora = isnull(we_cant_Obli_mora,
                                 0),
      we_saldo_Obli_mora = isnull(we_saldo_Obli_mora,
                                  0),
      we_cuota_Obli_mora = isnull(we_cuota_Obli_mora,
                                  0),
      we_saldo_pendiente = isnull(we_saldo_pendiente,
                                  0)
    from   cl_ws_endeuda_tmp
    where  we_secuencial = @i_secuencial
       and we_tip_producto not in ('Total', 'Subtotal Principal',
                                   'Subtotal Codeudor Y Otros')

    insert into #saldos
      select
        we_tipo = case
                    when we_tipo = 3 then 4
                    else we_tipo
                  end,we_tipo_registro = 'TOTALES',we_tip_producto = case
                            when we_tipo = 1 then 'SUBTOTAL TITULAR'
                            when we_tipo = 2 then 'SUBTOTAL CODEUDOR Y OTROS'
                            when we_tipo = 3 then 'TOTAL'
                          end,we_numero_creditos = sum(isnull(we_numero_creditos
                                                       ,
                                        0)),we_total_saldo =
                                            sum(isnull(we_total_saldo
                                                ,
                                    0)),
        we_participac_deuda = sum(isnull(we_participac_deuda,
                                         0)),we_numero_Obli_dia =
                                             sum(isnull(we_numero_Obli_dia,
                                        0)),we_saldo_Obli_dia =
                                            sum(isnull(we_saldo_Obli_dia,
                                       0)),we_cuota_Obli_dia =
                                           sum(isnull(we_cuota_Obli_dia,
                                       0)),we_cant_Obli_mora =
                                           sum(isnull(we_cant_Obli_mora,
                                       0)),
        we_saldo_Obli_mora = sum(isnull(we_saldo_Obli_mora,
                                        0)),we_cuota_Obli_mora =
                                            sum(isnull(we_cuota_Obli_mora,
                                        0)),we_saldo_pendiente =
                                            sum(isnull(we_saldo_pendiente,
                                        0))
      from   #saldos
      group  by we_tipo

    select
      we_tipo,
      we_tipo_registro,
      we_tip_producto,
      we_numero_creditos,
      substring (convert(varchar(16), we_total_saldo),
                 1,
                 len(we_total_saldo) - 3),
      we_participac_deuda,
      we_numero_Obli_dia,
      substring (convert(varchar(16), we_saldo_Obli_dia),
                 1,
                 len(we_saldo_Obli_dia) - 3),
      substring (convert(varchar(16), we_cuota_Obli_dia),
                 1,
                 len(we_cuota_Obli_dia) - 3),
      we_cant_Obli_mora,
      substring (convert(varchar(16), we_saldo_Obli_mora),
                 1,
                 len(we_saldo_Obli_mora) - 3),
      substring (convert(varchar(16), we_cuota_Obli_mora),
                 1,
                 len(we_cuota_Obli_mora) - 3),
      substring (convert(varchar(16), we_saldo_pendiente),
                 1,
                 len(we_saldo_pendiente) - 3)
    from   #saldos
    where  we_tipo in (1, 2, 4)
    order  by we_tipo,
              we_tipo_registro
  end

  if @i_modo = 'E' -- DATOS CLIENTE
  begin
    select
      we_nomlar,
      we_ced_ruc,
      we_tip_ced,
      we_procedencia,
      we_nacional,
      we_id_estado,
      we_id_validada,
      we_id_fecha_exp,
      we_id_ciudad_exp,
      we_id_dpto_exp,
      we_ente_int,
      we_fecha_consulta,
      we_identificalinea,
      we_tipo_registro,
      we_cod_ciiu,
      we_hora_consulta,
      we_rango_edad,
      we_nro_inf,
      we_cod_ciudad,
      we_activid_econ,
      we_estado_dcto,
      (select
         c.valor
       from   cl_catalogo c,
              cl_tabla t
       where  t.codigo = c.tabla
          and t.tabla  = 'cl_codcons'
          and c.codigo = we_id_validada),-- we_desc_valida
      (select
         count(1)
       from   cl_ws_endeu_cons_tmp
       where  wec_secuencial = @i_secuencial),-- we_endeu_cons
      (select
         count(1)
       from   cl_ws_endeu_contig_tmp
       where  wet_secuencial = @i_secuencial),-- we_endeu_contig
      (select
         count(1)
       from   cl_ws_endeu_det_tmp
       where  wed_secuencial = @i_secuencial),-- we_endeu_det
      (select
         count(1)
       from   cl_ws_endeu_reest_tmp
       where  wer_secuencial = @i_secuencial),-- we_endeu_reest
      (select
         count(1)
       from   cl_ws_endeu_cast_tmp
       where  wec_secuencial = @i_secuencial),-- we_endeu_cast
      (select
         count(1)
       from   cl_ws_endeu_cmp_tmp
       where  wem_secuencial = @i_secuencial),-- we_endeu_cmp
      (select
         count(1)
       from   cl_ws_score_tmp
       where  ws_secuencial = @i_secuencial) -- we_score
    from   cl_ws_ente_tmp W
    where  we_secuencial = @i_secuencial
  end

  if @i_modo = 'O'
  begin -- OBLIGACIONES
    select
      wo_estado,
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
      wo_amparada,
      wo_tipo_obigacion,
      wo_tipo_cuenta,
      wo_forma_pago,
      wo_cuota = substring (convert(varchar(16), wo_cuota),
                            1,
                            len(wo_cuota) - 3),
      wo_cupo = substring (convert(varchar(16), wo_cupo),
                           1,
                           len(wo_cupo) - 3),
      wo_saldo_mora = substring (convert(varchar(16), wo_saldo_mora),
                                 1,
                                 len(wo_saldo_mora) - 3),
      wo_saldo_act = substring (convert(varchar(16), wo_saldo_act),
                                1,
                                len(wo_saldo_act) - 3),
      wo_tipo_entidad,
      wo_chq_devueltos,
      wo_dias_cartera,
      wo_linea_credito,
      wo_calificacion,
      wo_estado_contrato,
      wo_participac_deuda,
      wo_fecha_pago,
      wo_fecha_permanencia,
      wo_nro_restructu,
      wo_nat_restructu,
      wo_marca_tarj,
      wo_clase_tarj,
      wo_tipo_pago,
      wo_clausu_perm,
      wo_estado_tit,
      wo_tipoent_orig_cart,
      wo_ent_orig_cart,
      wo_tipo_moneda,
      wo_nro_cuotas_cancl,
      wo_nro_cuota_mora,
      wo_cubrim_garantia,
      wo_tipo_fideicomiso,
      wo_nro_fideicomiso,
      wo_restructurado,
      wo_plazo,
      wo_tipo_registro,
      wo_identificalinea,
      wo_ProbabilidadNoPago,
      wo_garante,
      wo_dias_aut_sobregiro,
      wo_valor_inicial = substring (convert(varchar(16), wo_valor_inicial),
                                    1,
                                    len(wo_valor_inicial) - 3),
      wo_max_mora = substring (convert(varchar(16), wo_max_mora),
                               1,
                               len(wo_max_mora) - 3),
      wo_fecha_terminacion,
      wo_orden = row_number()
                   over(
                     order by case when wo_tip_producto = '0023' then 1 when
                   wo_tip_producto =
                   '0001' then 2 when wo_tip_producto = '0002' then 3 else 4 end
                   ,
                   wo_tipo_cuenta)
    into   #obligacion
    from   cl_ws_obligacion_tmp O
    where  wo_secuencial = @i_secuencial

    set rowcount 5

    select
      isnull(cast(wo_estado as varchar),
             '-'),
      '-',
      isnull(cast(wo_tip_producto as varchar),
             '-'),
      isnull(cast(wo_entidad as varchar),
             '-'),
      isnull(cast(wo_fecha_apertura as varchar),
             '-'),
      isnull(cast(wo_fecha_ult_actualiza as varchar),
             '-'),
      isnull(cast(wo_fecha_vencimiento as varchar),
             '-'),
      isnull(cast(wo_num_cuenta as varchar),
             '-'),
      isnull(cast(wo_oficina as varchar),
             '-'),
      isnull(cast(wo_ciudad as varchar),
             '-'),
      isnull(cast(wo_periodicidad as varchar),
             '-'),
      isnull(cast(wo_comportamiento as varchar(74)),
             '-'),
      isnull(cast(wo_amparada as varchar),
             '-'),
      isnull(cast(wo_tipo_obigacion as varchar),
             '-'),
      isnull(cast(wo_tipo_cuenta as varchar),
             '-'),
      isnull(cast(wo_forma_pago as varchar),
             '-'),
      isnull(cast(wo_cuota as varchar),
             '-'),
      isnull(cast(wo_cupo as varchar),
             '-'),
      isnull(cast(wo_saldo_mora as varchar),
             '-'),
      isnull(cast(wo_saldo_act as varchar),
             '-'),
      isnull(cast(wo_tipo_entidad as varchar),
             '-'),
      isnull(wo_chq_devueltos,
             0),
      isnull(wo_dias_cartera,
             0),
      isnull(cast(wo_linea_credito as varchar),
             '-'),
      isnull(wo_calificacion,
             '-'),
      isnull(cast(wo_estado_contrato as varchar),
             '-'),
      isnull(wo_participac_deuda,
             0),
      isnull(cast(wo_fecha_pago as varchar),
             '-'),
      isnull(cast(wo_fecha_permanencia as varchar),
             '-'),
      isnull(wo_nro_restructu,
             0),
      isnull(cast(wo_nat_restructu as varchar),
             '-'),
      isnull(cast(wo_marca_tarj as varchar),
             '-'),
      isnull(cast(wo_clase_tarj as varchar),
             '-'),
      isnull(cast(wo_tipo_pago as varchar),
             '-'),
      isnull(wo_clausu_perm,
             '-'),
      isnull(cast(wo_estado_tit as varchar),
             '-'),
      isnull(cast(wo_tipoent_orig_cart as varchar),
             '-'),
      isnull(cast(wo_ent_orig_cart as varchar),
             '-'),
      isnull(cast(wo_tipo_moneda as varchar),
             '-'),
      isnull(wo_nro_cuotas_cancl,
             0),
      isnull(wo_nro_cuota_mora,
             0),
      isnull(wo_cubrim_garantia,
             0),
      isnull(cast(wo_tipo_fideicomiso as varchar),
             '-'),
      isnull(wo_nro_fideicomiso,
             0),
      isnull(cast(wo_restructurado as varchar),
             '-'),
      isnull(cast(wo_plazo as varchar),
             '-'),
      isnull(cast(wo_tipo_registro as varchar),
             '-'),
      isnull(cast(wo_identificalinea as varchar),
             '-'),
      isnull(wo_ProbabilidadNoPago,
             0),
      isnull(cast(wo_garante as varchar),
             '-'),
      isnull(wo_dias_aut_sobregiro,
             0),
      isnull(cast(wo_valor_inicial as varchar),
             '-'),
      isnull(cast(wo_max_mora as varchar),
             '-'),
      isnull(cast(wo_fecha_terminacion as varchar),
             '-'),
      wo_orden
    from   #obligacion
    where  wo_orden > @i_item
    order  by wo_orden

    set rowcount 0
  end

  if @i_modo = 'S' -- DATOS SCORE
  begin
    select
      ws_tipo,
      ws_puntaje,
      ws_codigos,
      ws_tasa_morosidad,
      ws_ind_default,
      ws_sub_pobl,
      ws_politica,
      ws_observacion
    from   cl_ws_score_tmp
    where  ws_secuencial = @i_secuencial
  end

  if @i_modo = 'TE' -- TRIMESTRAL ENCABEZADO
  begin
    select
      isnull(wee_ent_trim1,
             0),
      isnull(cast(wee_fecha_trim1 as varchar),
             '-'),
      isnull(wee_ent_trim2,
             0),
      isnull(cast(wee_fecha_trim2 as varchar),
             '-'),
      isnull(wee_ent_trim3,
             0),
      isnull(cast(wee_fecha_trim3 as varchar),
             '-'),
      isnull(wee_cmp_trim1,
             0),
      isnull(wee_cmp_trim2,
             0),
      isnull(wee_cmp_trim3,
             0),
      isnull(wee_ree_trim1,
             0),
      isnull(wee_ree_trim2,
             0),
      isnull(wee_ree_trim3,
             0),
      isnull(wee_cas_trim1,
             0),
      isnull(wee_cas_trim2,
             0),
      isnull(wee_cas_trim3,
             0)
    from   cl_ws_endeu_encab_tmp
    where  wee_secuencial = @i_secuencial
  end

  if @i_modo = 'TC' -- TRIMESTRAL CONSOLIDADO
  begin
    select
      wec_calificacion,
      wec_tipo_moneda,
      wec_num_op_comercial,
      wec_num_op_consumo,
      wec_num_op_vivienda,
      wec_num_op_micro,
      wec_val_deu_comercial,
      wec_val_deu_consumo,
      wec_val_deu_vivienda,
      wec_val_deu_micro,
      wec_total,
      wec_par_tot_deudas,
      wec_cub_gar_comercial,
      wec_cub_gar_consumo,
      wec_cub_gar_vivienda,
      wec_cub_gar_micro,
      wec_tipo_registro,
      wec_item = row_number()
                   over(
                     order by wec_tipo_registro)
    into   #endeu_cons
    from   cl_ws_endeu_cons_tmp
    where  wec_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wec_calificacion as varchar),
             '-'),
      isnull(cast(wec_tipo_moneda as varchar),
             '-'),
      isnull(wec_num_op_comercial,
             0),
      isnull(wec_num_op_consumo,
             0),
      isnull(wec_num_op_vivienda,
             0),
      isnull(wec_num_op_micro,
             0),
      isnull(cast(wec_val_deu_comercial as varchar),
             '-'),
      isnull(cast(wec_val_deu_consumo as varchar),
             '-'),
      isnull(cast(wec_val_deu_vivienda as varchar),
             '-'),
      isnull(cast(wec_val_deu_micro as varchar),
             '-'),
      isnull(cast(wec_total as varchar),
             '-'),
      isnull(cast(wec_par_tot_deudas as varchar),
             '-'),
      isnull(cast(wec_cub_gar_comercial as varchar),
             '-'),
      isnull(cast(wec_cub_gar_consumo as varchar),
             '-'),
      isnull(cast(wec_cub_gar_vivienda as varchar),
             '-'),
      isnull(cast(wec_cub_gar_micro as varchar),
             '-'),
      isnull(cast(wec_tipo_registro as varchar),
             '-'),
      cast(wec_item as varchar)
    from   #endeu_cons
    where  wec_item > @i_item
    order  by wec_item

    set rowcount 0
  end

  if @i_modo = 'TO' -- TRIMESTRAL CONTINGENCIAS
  begin
    select
      wet_tipo_moneda,
      wet_num_contingencias,
      wet_val_contingencias,
      wet_cuota_esperada,
      wet_cuota_cumplimiento,
      wet_tipo_registro,
      wet_item = row_number()
                   over(
                     order by wet_tipo_registro, wet_tipo_moneda)
    into   #endeu_contig
    from   cl_ws_endeu_contig_tmp
    where  wet_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wet_tipo_moneda as varchar),
             '-'),
      isnull(wet_num_contingencias,
             0),
      isnull(cast(wet_val_contingencias as varchar),
             '-'),
      isnull(cast(wet_cuota_esperada as varchar),
             '-'),
      isnull(cast(wet_cuota_cumplimiento as varchar),
             '-'),
      isnull(cast(wet_tipo_registro as varchar),
             '-'),
      cast(wet_item as varchar)
    from   #endeu_contig
    where  wet_item > @i_item
    order  by wet_item

    set rowcount 0
  end

  if @i_modo = 'TD' -- TRIMESTRAL DETALLE
  begin
    select
      wed_tipo_entidad,
      wed_nom_entidad,
      wed_tipo_ent_orig_car,
      wed_nom_ent_orig_car,
      wed_tipo_fideicomiso,
      wed_num_fideicomiso,
      wed_mod_credito,
      wed_calificacion,
      wed_tipo_moneda,
      wed_num_operadores,
      wed_valor_deuda,
      wed_par_tot_deudas,
      wed_cubrim_garantia,
      wed_tipo_garantia,
      wed_fecha_ult_avaluo,
      wed_cuota_esperada,
      wed_cumplim_cuota,
      wed_tipo_registro,
      wed_item = row_number()
                   over(
                     order by wed_tipo_registro)
    into   #endeu_det
    from   cl_ws_endeu_det_tmp
    where  wed_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wed_tipo_entidad as varchar),
             '-'),
      isnull(cast(wed_nom_entidad as varchar),
             '-'),
      isnull(cast(wed_tipo_ent_orig_car as varchar),
             '-'),
      isnull(cast(wed_nom_ent_orig_car as varchar),
             '-'),
      isnull(cast(wed_tipo_fideicomiso as varchar),
             '-'),
      isnull(cast(wed_num_fideicomiso as varchar),
             '-'),
      isnull(cast(wed_mod_credito as varchar),
             '-'),
      isnull(cast(wed_calificacion as varchar),
             '-'),
      isnull(cast(wed_tipo_moneda as varchar),
             '-'),
      isnull(cast(wed_num_operadores as varchar),
             '-'),
      isnull(cast(wed_valor_deuda as varchar),
             '-'),
      isnull(cast(wed_par_tot_deudas as varchar),
             '-'),
      isnull(cast(wed_cubrim_garantia as varchar),
             '-'),
      isnull(cast(wed_tipo_garantia as varchar),
             '-'),
      isnull(cast(wed_fecha_ult_avaluo as varchar),
             '-'),
      isnull(cast(wed_cuota_esperada as varchar),
             '-'),
      isnull(cast(wed_cumplim_cuota as varchar),
             '-'),
      isnull(cast(wed_tipo_registro as varchar),
             '-'),
      cast(wed_item as varchar)
    from   #endeu_det
    where  wed_item > @i_item
    order  by wed_item

    set rowcount 0
  end

  if @i_modo = 'TR' -- TRIMESTRAL REESTRUCTURACIONES
  begin
    select
      wer_tipo_entidad,
      wer_nom_entidad,
      wer_tipo_ent_orig_car,
      wer_nom_ent_orig_car,
      wer_tipo_fideicomiso,
      wer_num_fideicomiso,
      wer_mod_credito,
      wer_calificacion,
      wer_id_credito,
      wer_monto,
      wer_fecha_formaliza,
      wer_fecha_termina,
      wer_numero_veces,
      wer_tipo_reestruc,
      wer_peri_gracia_cap,
      wer_peri_gracia_int,
      wer_factor_reest,
      wer_tipo_registro,
      wer_item = row_number()
                   over(
                     order by wer_tipo_registro)
    into   #endeu_reest
    from   cl_ws_endeu_reest_tmp
    where  wer_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wer_tipo_entidad as varchar),
             '-'),
      isnull(cast(wer_nom_entidad as varchar),
             '-'),
      isnull(cast(wer_tipo_ent_orig_car as varchar),
             '-'),
      isnull(cast(wer_nom_ent_orig_car as varchar),
             '-'),
      isnull(cast(wer_tipo_fideicomiso as varchar),
             '-'),
      isnull(cast(wer_num_fideicomiso as varchar),
             '-'),
      isnull(cast(wer_mod_credito as varchar),
             '-'),
      isnull(cast(wer_calificacion as varchar),
             '-'),
      isnull(cast(wer_id_credito as varchar),
             '-'),
      isnull(cast(wer_monto as varchar),
             '-'),
      isnull(cast(wer_fecha_formaliza as varchar),
             '-'),
      isnull(cast(wer_fecha_termina as varchar),
             '-'),
      isnull(wer_numero_veces,
             0),
      isnull(cast(wer_tipo_reestruc as varchar),
             '-'),
      isnull(wer_peri_gracia_cap,
             0),
      isnull(wer_peri_gracia_int,
             0),
      isnull(cast(wer_factor_reest as varchar),
             '-'),
      isnull(cast(wer_tipo_registro as varchar),
             '-'),
      cast (wer_item as varchar)
    from   #endeu_reest
    where  wer_item > @i_item
    order  by wer_item

    set rowcount 0
  end

  if @i_modo = 'TA' -- TRIMESTRAL CASTIGOS
  begin
    select
      wec_tipo_entidad,
      wec_nom_entidad,
      wec_tipo_ent_orig_car,
      wec_nom_ent_orig_car,
      wec_tipo_fideicomiso,
      wec_num_fideicomiso,
      wec_mod_credito,
      wec_tipo_castigo,
      wec_num_acta_aprob,
      wec_calidad,
      wec_fecha_otorg_ini,
      wec_valor_ini_oblig,
      wec_valor_castigado,
      wec_tipo_garantia,
      wec_valor_garantia,
      wec_tipo_registro,
      wec_item = row_number()
                   over(
                     order by wec_tipo_registro)
    into   #endeu_cast
    from   cl_ws_endeu_cast_tmp
    where  wec_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wec_tipo_entidad as varchar),
             '-'),
      isnull(cast(wec_nom_entidad as varchar),
             '-'),
      isnull(cast(wec_tipo_ent_orig_car as varchar),
             '-'),
      isnull(cast(wec_nom_ent_orig_car as varchar),
             '-'),
      isnull(cast(wec_tipo_fideicomiso as varchar),
             '-'),
      isnull(cast(wec_num_fideicomiso as varchar),
             '-'),
      isnull(cast(wec_mod_credito as varchar),
             '-'),
      isnull(cast(wec_tipo_castigo as varchar),
             '-'),
      isnull(cast(wec_num_acta_aprob as varchar),
             '-'),
      isnull(cast(wec_calidad as varchar),
             '-'),
      isnull(cast(wec_fecha_otorg_ini as varchar),
             '-'),
      isnull(cast(wec_valor_ini_oblig as varchar),
             '-'),
      isnull(cast(wec_valor_castigado as varchar),
             '-'),
      isnull(cast(wec_tipo_garantia as varchar),
             '-'),
      isnull(cast(wec_valor_garantia as varchar),
             '-'),
      isnull(cast(wec_tipo_registro as varchar),
             '-'),
      cast(wec_item as varchar)
    from   #endeu_cast
    where  wec_item > @i_item
    order  by wec_item

    set rowcount 0
  end

  if @i_modo = 'TM' -- TRIMESTRAL COMPRAS
  begin
    select
      wem_tipo_entidad,
      wem_nom_entidad,
      wem_tipo_ent_orig_car,
      wem_nom_ent_orig_car,
      wem_tipo_fideicomiso,
      wem_num_fideicomiso,
      wem_mod_credito,
      wem_calificacion,
      wem_tipo_moneda,
      wem_valor_deuda,
      wem_tipo_operacion,
      wem_clase_operacion,
      wem_cond_contrato,
      wem_tipo_comp_vend,
      wem_tipo_ent_operacion,
      wem_nom_ent_operacion,
      wem_tipo_registro,
      wem_item = row_number()
                   over(
                     order by wem_tipo_registro)
    into   #endeu_cmp
    from   cl_ws_endeu_cmp_tmp
    where  wem_secuencial = @i_secuencial

    set rowcount 20

    select
      isnull(cast(wem_tipo_entidad as varchar),
             '-'),
      isnull(cast(wem_nom_entidad as varchar),
             '-'),
      isnull(cast(wem_tipo_ent_orig_car as varchar),
             '-'),
      isnull(cast(wem_nom_ent_orig_car as varchar),
             '-'),
      isnull(cast(wem_tipo_fideicomiso as varchar),
             '-'),
      isnull(cast(wem_num_fideicomiso as varchar),
             '-'),
      isnull(cast(wem_mod_credito as varchar),
             '-'),
      isnull(cast(wem_calificacion as varchar),
             '-'),
      isnull(cast(wem_tipo_moneda as varchar),
             '-'),
      isnull(cast(wem_valor_deuda as varchar),
             '-'),
      isnull(cast(wem_tipo_operacion as varchar),
             '-'),
      isnull(cast(wem_clase_operacion as varchar),
             '-'),
      isnull(cast(wem_cond_contrato as varchar),
             '-'),
      isnull(cast(wem_tipo_comp_vend as varchar),
             '-'),
      isnull(cast(wem_tipo_ent_operacion as varchar),
             '-'),
      isnull(cast(wem_nom_ent_operacion as varchar),
             '-'),
      isnull(cast(wem_tipo_registro as varchar),
             '-'),
      cast(wem_item as varchar)
    from   #endeu_cmp
    where  wem_item > @i_item
    order  by wem_item

    set rowcount 0
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

