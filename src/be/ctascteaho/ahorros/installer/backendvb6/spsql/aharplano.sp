/************************************************************************/
/*      Archivo:              aharplano.sp                              */
/*      Stored procedure:     sp_archivo_plano_ah                       */
/*      Base de datos:        cob_ahorros                               */
/*      Producto:             Cuentas de Ahorros                        */
/*      Disenado por:         Mario Algarin                             */
/*      Fecha de escritura:   08/sep/2010                               */
/************************************************************************/
/*              IMPORTANTE                                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*      PROPOSITO                                                       */
/*      Este programa realiza lo SIGUIENTE:                             */
/*      Crea un Archivo plano con la informacion de la tabla maestra de */
/*      Ahorros.                                                        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA         AUTOR           RAZON                             */
/*  08/sep/2010      Mario Algarin   Emision Inicial                   */
/*  02/May/2016      J. Calderon      Migración a CEN                   */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_archivo_plano_ah')
  drop proc sp_archivo_plano_ah
go

create proc sp_archivo_plano_ah
(
  @t_show_version bit = 0,
  @i_param1       datetime = null,--Fecha Proceso
  @i_param2       varchar(20) = null,--Monto Inicial
  @i_param3       varchar(20) = null,--Monto Final
  @i_param4       char(1) = 'T',--Opcion sucursal
  @i_param5       varchar(5) = '0' --Numero Sucursal
)
as
  declare
    @w_msg           descripcion,
    @w_fecha         datetime,
    @w_error         int,
    @w_max_ofi       int,
    @w_min_ofi       int,
    @w_path_s_app    varchar(30),
    @w_path          varchar(250),
    @w_s_app         varchar(250),
    @w_archivo       descripcion,
    @w_errores       descripcion,
    @w_archivo_bcp   descripcion,
    @w_cmd           varchar(250),
    @w_comando       varchar(250),
    @w_saldo_ini     money,
    @w_saldo_fin     money,
    @w_oficina       int,
    @w_encabezado    varchar(8000),
    @w_prod_bancario smallint,
    @w_sp_name       varchar(64)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_archivo_plano_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if @i_param1 is null
      or @i_param2 is null
      or @i_param3 is null
  begin
    select
      @w_msg = case
                 when @i_param1 is null then 'PARAMETRO FECHA ES OBLIGATORIO'
                 when @i_param2 is null then
                 'PARAMETRO MONTO INICIAL ES OBLIGATORIO'
                 when @i_param3 is null then
                 'PARAMETRO MONTO FINAL ES OBLIGATORIO'
               end,
      @w_error = case
                   when @i_param1 is null then 101114
                   when @i_param2 is null then 101115
                   when @i_param3 is null then 101116
                 end,
      @w_fecha = fp_fecha
    from   cobis..ba_fecha_proceso
    goto ERROR
  end

  select
    @w_fecha = @i_param1

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PBCB'

  select
    @w_saldo_ini = convert(money, @i_param2),
    @w_saldo_fin = convert(money, @i_param3),
    @w_oficina = convert(int, @i_param5)

  if @i_param4 = 'T'
  begin
    select
      @w_min_ofi = min(of_oficina),
      @w_max_ofi = max(of_oficina)
    from   cobis..cl_oficina
    where  of_subtipo = 'O'
  end
  else
  begin
    select
      @w_max_ofi = @w_oficina,
      @w_min_ofi = @w_oficina
  end

  /* SE LIMPIA LA TABLA DEL REPORTE LA TABLA */
  truncate table cob_ahorros..ah_ofica

  select
    *
  into   #ah_cuenta_tmp
  from   cob_ahorros..ah_cuenta_tmp
  where  (ah_oficina                                              >= @w_min_ofi
          and ah_oficina                                              <=
              @w_max_ofi)
     and ((ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas) >=
          @w_saldo_ini
          and (ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas) <=
              @w_saldo_fin
         )
     and ((ah_estado                                               = 'C'
           and ah_fecha_ult_mov                                        =
               @i_param1)
           or (ah_estado <> 'C'))
     and ah_prod_banc                                            <>
         @w_prod_bancario
  order  by ah_oficina,
            ah_prod_banc,
            ah_cta_banco

  alter table #ah_cuenta_tmp
    add ah_traslados int, ah_ofi_orig int, ah_ofi_dest int, ah_tipo_tras varchar
    (
    80), ah_est_cuenta varchar(80), ah_saldo_tras money, ah_usr_solt login,
    ah_ofi_solt int, ah_fec_solt datetime, ah_est_tras varchar(80), ah_usr_auto
    login, ah_ofi_auto int, ah_fec_auto datetime, ah_cau_recha varchar(80)

  select
    tr_cuenta = td_operacion,
    tr_ofi_orig = td_ofi_orig,
    tr_ofi_dest = td_ofi_dest,
    tr_tipo_traslado = (select
                          c.valor
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and t.tabla  = 'cl_tipo_traslado'
                           and c.codigo = tr_tipo_traslado),
    tr_estado_ope = (select
                       c.valor
                     from   cobis..cl_tabla t,
                            cobis..cl_catalogo c
                     where  t.codigo = c.tabla
                        and t.tabla  = 'ah_estado_cta'
                        and c.codigo = td_estado_ope),
    tr_saldo_dispo = td_saldo_dispo,
    tr_usr_ingresa = tr_usr_ingresa,
    tr_ofi_solicitud = tr_ofi_solicitud,
    tr_fecha_sol = tr_fecha_sol,
    tr_estado = (select
                   c.valor
                 from   cobis..cl_tabla t,
                        cobis..cl_catalogo c
                 where  t.codigo = c.tabla
                    and t.tabla  = 'cl_estado_traslado'
                    and c.codigo = tr_estado),
    tr_usr_autoriza = tr_usr_autoriza,
    tr_ofi_autoriza = tr_ofi_autoriza,
    tr_fecha_auto = tr_fecha_auto,
    tr_causa_rechazo = (select
                          c.valor
                        from   cobis..cl_tabla t,
                               cobis..cl_catalogo c
                        where  t.codigo = c.tabla
                           and t.tabla  = 'cl_rechazo_traslado'
                           and c.codigo = tr_causa_rechazo)
  into   #ah_traslados
  from   cobis..cl_traslado,
         cobis..cl_traslado_detalle
  where  tr_solicitud = td_solicitud
     and td_producto  = 4
     and tr_estado    <> 'I'
  order  by td_solicitud asc

  update #ah_cuenta_tmp
  set    ah_ofi_orig = tr_ofi_orig,
         ah_ofi_dest = tr_ofi_dest,
         ah_tipo_tras = tr_tipo_traslado,
         ah_est_cuenta = tr_estado_ope,
         ah_saldo_tras = tr_saldo_dispo,
         ah_usr_solt = tr_usr_ingresa,
         ah_ofi_solt = tr_ofi_solicitud,
         ah_fec_solt = tr_fecha_sol,
         ah_est_tras = tr_estado,
         ah_usr_auto = tr_usr_autoriza,
         ah_ofi_auto = tr_ofi_autoriza,
         ah_fec_auto = tr_fecha_auto,
         ah_cau_recha = tr_causa_rechazo
  from   #ah_traslados
  where  tr_cuenta = ah_cta_banco

  select
    traslado = count(td_operacion),
    cuenta = td_operacion
  into   #traslado
  from   cobis..cl_traslado_detalle
  where  td_estado_batch <> 'I'
     and td_producto     = 4
  group  by td_operacion
  --drop table #traslado

  update #ah_cuenta_tmp
  set    ah_traslados = isnull(traslado,
                               0)
  from   #traslado
  where  ah_cta_banco = cuenta

  select
    *
  from   #ah_cuenta_tmp

  /* SE INSERTA LE ENCABEZADO DEL REPORTE */
  select
    @w_encabezado =
'"Oficina","Producto","Cod. Cuenta","Nro Cuenta","Estado","Moneda","Apertura","Oficial",'
  ,
@w_encabezado = @w_encabezado
                +
'"Cod. Cliente","Cedula","Nombre","Categoria","T. Promedio","T. Capitalizaci¾n","Ciclo Extracto",'
  ,
@w_encabezado = @w_encabezado
                +
'"No. Vlr Suspenso","No. Bloqueos Mov","Condiciones","Vlr. Bloqueado","No. Bloqueos","Sal. Disponible",'
  ,
@w_encabezado = @w_encabezado
                +
'"Canje Liberacion","Valor Retefuente","Canje Cons. hoy","Remesas","Cont. remesas cobro",'
  ,
@w_encabezado = @w_encabezado
                +
'"Int. Pend.capitalizar","Sal. Anterior","Sal. ult corte","Saldo ayer","Cred. Mes","Deb. Mes",'
  ,
@w_encabezado = @w_encabezado
                +
'"Cred. Hoy","Deb. Hoy","Ult. mov. cliente","Ult. mov. interno","Ult. actualizacion","Prox. corte",'
  ,
@w_encabezado = @w_encabezado
                +
'"Ult. corte","Ult. capitalizacion","Prox. capitalizacion","Genera EC","Cod. Cliente EC","Cod. Dir. EC",'
  ,
@w_encabezado = @w_encabezado
                +
'"Descripcion EC","Tipo Dir EC","Sal. prom. disponible","Sal.Mes 1","Sal.Mes 2","Sal.Mes 3","Sal.Mes 4",'
  ,
@w_encabezado = @w_encabezado
                +
'"Sal.Mes 5","Sal.Mes 6","Cta Personalizada","Nro. Transacciones","Cta funcionario","Origen Cta",'
  ,
@w_encabezado = @w_encabezado
                +
'"Nro Firmas","Telefono","Int. Calc. hoy","Tasa interes","Sal. Min.Disp mes","Ult. retiro","Cobrado GMF",'
  ,
@w_encabezado = @w_encabezado
                +
'"Exonerado GMF","Titularidad","Int acumulado mes","Tipo Sociedad","Cod. Direccion DVC","Direccion DVC",'
  ,
@w_encabezado = @w_encabezado
                +
'"Tipo Direccion DVC","Ciudad DVC","Cod. Cliente DVC","Ult. valor capitalizado","Credito mes2",'
  ,
@w_encabezado = @w_encabezado
                +
'"Credito mes3","Credito mes4","Credito mes5","Credito mes6","Debito mes2","Debito mes3","Debito mes4",'
  ,
@w_encabezado = @w_encabezado
                +
'"Debito mes5","Debito mes6","Tasa Int ayer","Permite saldo 0","Nro Solicitud","Clase cliente",'
  ,
@w_encabezado = @w_encabezado
                +
'"Zona Oficina","Territorial Oficina","Cta. Trasl. DNT","Cod. Tutor","Ced. Tutor","Nom. Tutor","Fecha. Anulacion",'
  ,
@w_encabezado = @w_encabezado
                +
'"Cantidad Traslados","Oficina Origen","Oficina Destino","Tipo Traslado","Estado Cta. en el traslado",'
  ,
@w_encabezado = @w_encabezado
                +
'"Saldo Cta. en el traslado","Usuario solicitud","Oficina Solicitud","Fecha Solicitud","Estado Traslado",'
  ,
@w_encabezado = @w_encabezado
                +
'"Usuario Autorizador","Oficina Autorizaci¾n","Fecha Autorizaci¾n","Causal Rechazo Traslado"'

  --insert into cob_ahorros..ah_ofica values ('"Oficina","Producto","Cod. Cuenta","Nro Cuenta","Estado","Moneda","Apertura","Oficial","Cod. Cliente","Cedula","Nombre","Categoria","T. Promedio","T. Capitalizaci¾n","Ciclo Extracto","No. Vlr Suspenso","No. Bloqueos Mov","Condiciones","Vlr. Bloqueado","No. Bloqueos","Sal. Disponible","Canje Liberacion","Valor Retefuente","Canje Cons. hoy","Remesas","Cont. remesas cobro","Int. Pend.capitalizar","Sal. Anterior","Sal. ult corte","Saldo ayer","Cred. Mes","Deb. Mes","Cred. Hoy","Deb. Hoy","Ult. mov. cliente","Ult. mov. interno","Ult. actualizacion","Prox. corte","Ult. corte","Ult. capitalizacion","Prox. capitalizacion","Genera EC","Cod. Cliente EC","Cod. Dir. EC","Descripcion EC","Tipo Dir EC","Sal. prom. disponible","Sal.Mes 1","Sal.Mes 2","Sal.Mes 3","Sal.Mes 4","Sal.Mes 5","Sal.Mes 6","Cta Personalizada","Nro. Transacciones","Cta funcionario","Origen Cta","Nro Firmas","Telefono","Int. Calc. hoy","Tasa interes","Sal. Min.Disp mes","Ult. retiro","Cobrado GMF","Exonerado GMF","Titularidad","Int acumulado mes","Tipo Sociedad","Cod. Direccion DVC","Direccion DVC","Tipo Direccion DVC","Ciudad DVC","Cod. Cliente DVC","Ult. valor capitalizado","Credito mes2","Credito mes3","Credito mes4","Credito mes5","Credito mes6","Debito mes2","Debito mes3","Debito mes4","Debito mes5","Debito mes6","Tasa Int ayer","Permite saldo 0","Nro Solicitud","Clase cliente","Zona Oficina","Territorial Oficina","Cta. Trasl. DNT","Cod. Tutor","Ced. Tutor","Nom. Tutor",')

  insert into cob_ahorros..ah_ofica
  values      (@w_encabezado)

  /*SE INSERTAN LOS REGISTROS DEL REPORTE*/
  insert into cob_ahorros..ah_ofica
    select
      '"' + isnull((select of_nombre from cobis..cl_oficina where of_oficina =
      ah_oficina), '') + '",' + '"'
      + isnull((select pb_descripcion from cob_remesas..pe_pro_bancario where
      pb_pro_bancario = ah_prod_banc), '') + '",' + '"'
      + isnull((cast(ah_cuenta as varchar(10))), '') + '",' + '"'
      + isnull((ltrim(ah_cta_banco)), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_estado_cta' and a.codigo = b.tabla and b.codigo = ah_estado)
      ,
      ''
      )
      + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'cl_moneda' and a.codigo = b.tabla and b.codigo = ah_moneda), ''
      )
      + '",' + '"' + isnull((convert(varchar(10), ah_fecha_aper, 101)), '') +
      '",'
      +
      '"'
      + isnull((select fu_nombre from cobis..cc_oficial, cobis..cl_funcionario
      where
      fu_funcionario = oc_funcionario and oc_oficial = ah_oficial), '') + '",' +
      '"'
      + isnull((cast(ah_cliente as varchar(10))), '') + '",' + '"'
      + isnull((select en_ced_ruc from cobis..cl_ente where en_ente = ah_cliente
      )
      ,
      ''
      ) + '",' + '"' + isnull((ltrim(ah_nombre)), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'pe_categoria' and a.codigo = b.tabla and b.codigo =
      ah_categoria)
      ,
      ''
      )
      + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_tpromedio' and a.codigo = b.tabla and b.codigo =
      ah_tipo_promedio)
      , '')
      + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_capitalizacion' and a.codigo = b.tabla and b.codigo =
      ah_capitalizacion),
      '')
      + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_ciclo' and a.codigo = b.tabla and b.codigo = ah_ciclo), '')
      + '",' + '"' + isnull((cast(ah_suspensos as varchar(10))), '') + '",' +
      '"'
      + isnull((cast(ah_bloqueos as varchar(10))), '') + '",' + '"'
      + isnull((cast(ah_condiciones as varchar(10))), '') + '",' + '"'
      + isnull((cast(ah_monto_bloq as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_num_blqmonto as varchar(10))), '') + '",' + '"'
      + isnull((cast(ah_disponible as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_12h as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_12h_dif as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_24h as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_remesas as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_rem_hoy as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_saldo_interes as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_saldo_anterior as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_saldo_ult_corte as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_saldo_ayer as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos_hoy as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos_hoy as varchar(20))), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_ult_mov, 101)), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_ult_mov_int, 101)), '') + '",' +
      '"'
      + isnull((convert(varchar(10), ah_fecha_ult_upd, 101)), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_prx_corte, 101)), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_ult_corte, 101)), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_ult_capi, 101)), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_prx_capita, 101)), '') + '",' +
      '"'
      + isnull((cast(ah_estado_cuenta as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_cliente_ec as varchar(10))), '') + '",' + '"'
      + isnull((cast(ah_direccion_ec as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_descripcion_ec as varchar(60))), '') + '",' + '"'
      + isnull((cast(ah_tipo_dir as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_prom_disponible as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio1 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio2 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio3 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio4 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio5 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_promedio6 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_personalizada as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_contador_trx as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_cta_funcionario as varchar(5))), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_tipocta' and a.codigo = b.tabla and b.codigo = ah_origen),
      '')
      + '",' + '"' + isnull((cast(ah_contador_firma as varchar(5))), '') + '",'
      +
      '"'
      + isnull((select top 1 (convert(varchar, isnull(ltrim(rtrim(te_prefijo)),
      '0')
      )
      + '-' + te_valor) from cobis..cl_direccion, cobis..cl_telefono where
      di_principal = 'S' and di_direccion = te_direccion and te_ente = di_ente
      and
      te_secuencial = di_telefono and di_ente = ah_cliente), '')
      + '",' + '"' + isnull((cast(ah_int_hoy as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_tasa_hoy as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_min_dispmes as varchar(20))), '') + '",' + '"'
      + isnull((convert(varchar(10), ah_fecha_ult_ret, 101)), '') + '",' + '"'
      + isnull((cast(ah_monto_imp as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_nxmil as varchar(5))), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 're_titularidad' and a.codigo = b.tabla and b.codigo =
      ah_ctitularidad
      ), '')
      + '",' + '"' + isnull((cast(ah_int_mes as varchar(20))), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'ah_cla_cliente' and a.codigo = b.tabla and b.codigo =
      ah_tipocta_super), '')
      + '",' + '"' + isnull((cast(ah_direccion_dv as varchar(5))), '') + '",' +
      '"'
      + isnull((ltrim(ah_descripcion_dv)), '') + '",' + '"'
      + isnull((select b.valor from cobis..cl_tabla a, cobis..cl_catalogo b
      where
      a.tabla = 'cl_direccion_ec' and a.codigo = b.tabla and b.codigo =
      ah_tipodir_dv)
      , '')
      + '",' + '"' + isnull((case when ah_parroquia_dv <> 0 then (select
      ci_descripcion from cobis..cl_ciudad where ci_ciudad = ah_parroquia_dv)
      else
      (
      select ci_descripcion from cobis..cl_oficina, cobis..cl_ciudad where
      of_oficina
      = ah_agen_dv and of_ciudad = ci_ciudad) end), '') + '",' + '"' + isnull((
      cast
      (
      ah_cliente_dv as varchar(10))), '') + '",' + '"'
      + isnull((cast(ah_monto_ult_capi as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos2 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos3 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos4 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos5 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_creditos6 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos2 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos3 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos4 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos5 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_debitos6 as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_tasa_ayer as varchar(20))), '') + '",' + '"'
      + isnull((cast(ah_permite_sldcero as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_numsol as varchar(10))), '') + '",' + '"' + isnull((case
      when
      ah_clase_clte = 'P' then 'PARTICULAR' else 'OFICIAL' end), '') + '",' +
      '"'
      + isnull((select (select ltrim(b.of_nombre) from cobis..cl_oficina b where
      a.of_zona = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo =
      'O'
      and
      a.of_oficina = ah_oficina), '') + '",' + '"'
      + isnull((select (select ltrim(b.of_nombre) from cobis..cl_oficina b where
      a.of_regional = b.of_oficina) from cobis..cl_oficina a where a.of_subtipo
      =
      'O'
      and
      a.of_oficina = ah_oficina), '') + '",' + '"' + isnull((case when (select 1
      from
      cob_remesas..re_tesoro_nacional where tn_estado = 'P' and tn_cuenta =
      ah_cta_banco) = 1 then 'S' else
      'N' end), '') + '",'
      + '"'
      + isnull((select cast(b.cl_cliente as varchar(10)) + '","' + b.cl_ced_ruc
      +
      '","' + a.en_nomlar from cobis..cl_ente a, cobis..cl_cliente b where
      a.en_ente
      =
      b.cl_cliente and b.cl_rol = 'U' and b.cl_det_producto = (select
      c.cl_det_producto from cobis..cl_cliente c, cobis..cl_det_producto d where
      c.cl_cliente =
      ah_cliente and d.dp_cuenta = ah_cta_banco and c.cl_det_producto =
      dp_det_producto)), '","","')
      + '",' + '"' + isnull((select convert(varchar, hs_tsfecha, 101) from
      cob_ahorros_his..ah_his_servicio where hs_tipo_transaccion = 4146 and
      hs_cta_banco = ah_cta_banco), '') + '",'
      + '"' + isnull((cast(ah_traslados as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_ofi_orig as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_ofi_dest as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_tipo_tras as varchar(60))), '') + '",' + '"'
      + isnull((cast(ah_est_cuenta as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_saldo_tras as varchar(25))), '') + '",' + '"'
      + isnull((cast(ah_usr_solt as varchar(60))), '') + '",' + '"'
      + isnull((cast(ah_ofi_solt as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_fec_solt as varchar(15))), '') + '",' + '"'
      + isnull((cast(ah_est_tras as varchar(15))), '') + '",' + '"'
      + isnull((cast(ah_usr_auto as varchar(60))), '') + '",' + '"'
      + isnull((cast(ah_ofi_auto as varchar(5))), '') + '",' + '"'
      + isnull((cast(ah_fec_auto as varchar(15))), '') + '",' + '"'
      + isnull((cast(ah_cau_recha as varchar(60))), '') + '",'
    from   #ah_cuenta_tmp

  if @@rowcount > 1
  begin
    select
      @w_path_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'S_APP'

    if @w_path_s_app is null
    begin
      select
        @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
      goto ERROR
    end

    /* Se Realiza BCP */
    select
      @w_s_app = @w_path_s_app + 's_app'

    select
      @w_path = ba_path_destino
    from   cobis..ba_batch
    where  ba_batch = 4139

    select
      @w_archivo = 'OFICA_' + convert(varchar, @i_param1, 112) + '.txt',
      @w_errores = 'ERR_OFICA_' + convert(varchar, @i_param1, 112) + '.txt'

    select
      @w_archivo_bcp = @w_path + @w_archivo,
      @w_errores = @w_path + @w_errores,
      @w_cmd = @w_s_app + ' bcp -auto -login cob_ahorros..ah_ofica out '

    select
      @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e' + @w_errores +
                   ' -config ' + @w_s_app
                   + '.ini'

    exec @w_error = xp_cmdshell
      @w_comando

    if @w_error <> 0
    begin
      select
        @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' ' + convert(
                 varchar
                 ,
                        @w_error)
      goto ERROR
    end

  end
  else
  begin
    select
      @w_msg =
'No Existen datos Para Generar Archivo Plano del Maestro de Cuentas de Ahorros'
  goto ERROR
end

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg

  return 1

go

