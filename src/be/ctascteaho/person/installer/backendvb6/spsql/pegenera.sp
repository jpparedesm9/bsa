/****************************************************************************/
/*     Archivo:          pegenera.sp                                        */
/*     Stored procedure: sp_genera_costos                                   */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 02-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa se encarga de obtener el valor del rubro de un         */
/*     servicio especificado                                                */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     16/DIC/94      G.Calderon      Emision Inicial                       */
/*     JUN/95         J.Gordillo      Personalizacion                       */
/*     20/dic/2003    C.Ruiz          agregar indicador @i_pit              */
/*     24/Jul/2007    John Jairo Rendon Optimizacion                        */
/*     12/Ago/2013    C. Avendaño     Variable @i_tran_ext para WS         */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_genera_costos')
  drop proc sp_genera_costos
go

create proc sp_genera_costos
(
  @s_srv          varchar(30) = null,
  @s_ofi          smallint = null,
  @s_ssn          int = null,
  @s_user         varchar(30) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @t_trn          smallint = null,
  @i_batch        char(1) = 'N',
  @i_filial       tinyint,
  @i_oficina      smallint,
  @i_categoria    catalogo,
  @i_tipo_ente    catalogo,
  @i_rol_ente     char(1),
  @i_tipo_def     char(1),
  @i_prod_banc    smallint,
  @i_producto     tinyint,
  @i_moneda       tinyint,
  @i_tipo         char(1) = 'R',
  @i_codigo       int,
  @i_servicio     catalogo,
  @i_rubro        catalogo,
  @i_disponible   money= $0,
  @i_contable     money= $0,
  @i_promedio     money= $0,
  @i_prom_disp    money = $0,
  @i_valor        money = 1,
  @i_personaliza  char(1),
  @i_fecha        datetime,
  @i_sec_costo    int = null,
  @i_sec_valor    int = null,
  @i_pit          char(1) = 'N',
  @i_paquete      int = null,
  @i_porc_tiempo  float = null,
  @i_tran_ext     char(1) = 'N',

  --CAV Valida que la transaccion sea por WS / N -> No
  @o_valor_total  money out,
  @o_sec_costo    int = null out,
  @o_sec_valor    int = null out
)
as
  declare
    @w_sp_name       varchar(32),
    @w_return        int,
    @w_valor_con     float,
    @w_valor_medio   float,
    @w_rango         tinyint,
    @w_tipo_rango    tinyint,
    @w_grupo_rango   smallint,
    @w_mercado       int,
    @w_servicio_dis  int,
    @w_servicio_per  smallint,
    @w_signo         char(1),
    @w_signo2        char(1),
    @w_tipo_dato     char(1),
    @w_tipo_dato2    char(1),
    @w_rubro         catalogo,
    @w_tipo_atributo catalogo,
    @w_monto         money,
    @w_minimo        float,
    @w_maximo        float,
    @w_fecha         smalldatetime,
    @w_sec_costo     int,
    @w_sec_valor     int,
    @w_pro_final     smallint,
    @w_sucursal      smallint,
    @w_subtipo       char(1),
    @w_bonificacion  real,
    @w_debug         char(1),
    @w_error         int,
    --Controla los errores para utilizarlos en la etiqueta ERROR
    @w_severidad     int

  /*********************************************/
  select
    @w_debug = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'DEBUG'

  select
    @w_severidad = 0

  if @w_debug is null
    select
      @w_debug = 'N'

  select
    @w_subtipo = of_subtipo
  from   cobis..cl_oficina
  where  of_oficina = @i_oficina

  if @w_subtipo = 'R'
    select
      @w_sucursal = @i_oficina
  else if @w_subtipo = 'O'
    select
      @w_sucursal = of_regional
    from   cobis..cl_oficina
    where  of_oficina = @i_oficina

  select
    @w_sp_name = 'sp_genera_costos'
  select
    @w_fecha = convert(char(10), @i_fecha, 101)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @w_debug = 'S'
     and @i_tran_ext = 'N'
  begin
    print '@i_fecha: ' + cast(@i_fecha as varchar)
    print '@w_fecha: ' + cast(@w_fecha as varchar)
  end

  /* Valida que se halla ingresado al menos un valor sobre el cual actuar */

  if @i_disponible is null
     and @i_contable is null
     and @i_promedio is null
     and @i_prom_disp is null
     and @i_porc_tiempo is null
  begin
    /* No se ha ingresado el valor sobre el cual se actua */
    select
      @w_error = 351550
    goto ERROR
  end

  /************ CLE 04122006 VALIDA SI LA CUENTA PERTENECE A UN PAQUETE **************/
  if @i_paquete is not null
  begin
    select
      @i_producto = gp_prod_cobis_pq,
      @i_prod_banc = gp_prod_banc_pq,
      @i_categoria = gp_categoria_pq
    from   pa_gestion_paquete
    where  gp_numpq     = @i_paquete
       and gp_estado_pq = 'A'

    if @@rowcount = 0
    begin /*no existe paquete*/
      select
        @w_error = 351525
      goto ERROR
    end

  --if @w_debug = 'S'
  --   print '@i_producto %1! @i_prod_banc %2! @i_categoria %3!', @i_producto, @i_prod_banc, @i_categoria
  end

  /* ============[ Determino si existe mercado ]===================== */

  select
    @w_mercado = me_mercado
  from   pe_mercado
  where  me_tipo_ente    = @i_tipo_ente
     and me_pro_bancario = @i_prod_banc
     and me_estado       = 'V'

  if @@rowcount = 0
  begin /*no existe mercado*/
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
      print '@i_tipo_ente: ' + @i_tipo_ente + ' @i_prod_banc: ' + cast(
            @i_prod_banc
                                     as
                                     varchar)

    select
      @w_error = 351511
    goto ERROR
  end

  /* =============[ Determino si existe producto final ]====================== */

  select
    @w_pro_final = pf_pro_final
  from   pe_pro_final
  where  pf_filial   = @i_filial
     and pf_sucursal = @w_sucursal
     and pf_mercado  = @w_mercado
     and pf_producto = @i_producto
     and pf_moneda   = @i_moneda
     and pf_tipo     = @i_tipo

  if @@rowcount <> 1
  begin /*no existe producto final */
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
    begin
      print '@w_mercado:    ' + cast(@w_mercado as varchar)
      print '@w_sucursal:   ' + cast(@w_sucursal as varchar)
      print '@i_producto:   ' + cast(@i_producto as varchar)
      print '@i_moneda:     ' + cast(@i_moneda as varchar)
      print '@i_tipo:       ' + cast(@i_tipo as varchar)
      print '------------------------------'
      print '@i_servicio:   ' + cast(@i_servicio as varchar)
    end
    select
      @w_error = 351527
    goto ERROR
  end
  /* =================[ Extraigo el servicio a utilizar ]================= */
  select
    @w_servicio_dis = sd_servicio_dis
  from   pe_servicio_dis
  where  sd_nemonico = @i_servicio
     and sd_estado   = 'V'

  if @@rowcount = 0
  begin /*no existe servicio disponible */
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
      print '@i_servicio:   ' + cast(@i_servicio as varchar)

    select
      @w_error = 351501
    goto ERROR
  end

  /* =================[ Extraigo el registro de rubro ]================= */
  select
    @w_rubro = vs_rubro,
    @w_signo = vs_signo,
    @w_tipo_dato = vs_tipo_dato
  from   pe_var_servicio
  where  vs_servicio_dis = @w_servicio_dis
     and vs_rubro        = @i_rubro
     and vs_estado       = 'V'
  if @@rowcount = 0
  begin /*Error al buscar rubros */
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
      print '@w_servicio_dis: ' + @i_servicio + '-' + cast(@w_servicio_dis as
            varchar)
                                     +
                                     ' @i_rubro: '
            + @i_rubro

    select
      @w_error = 351531
    goto ERROR
  end

  /* =============[ Determino servicio personalizable ]============ */
  select
    @w_servicio_per = sp_servicio_per,
    @w_tipo_rango = sp_tipo_rango,
    @w_grupo_rango = sp_grupo_rango
  from   pe_servicio_per
  where  sp_servicio_dis = @w_servicio_dis
     and sp_rubro        = @i_rubro
     and sp_pro_final    = @w_pro_final

  if @@rowcount = 0
  begin /*No existe servicio personalizable*/
    select
      @w_error = 351540
    goto ERROR
  --print 'servicio_dis: ' + cast(@w_servicio_dis as varchar) + ' rubro: ' + cast(@i_rubro as varchar) + ' pro_final: ' + cast(@w_pro_final as varchar)
  end

  select
    @w_tipo_atributo = tr_tipo_atributo
  from   pe_tipo_rango
  where  tr_tipo_rango = @w_tipo_rango
     and tr_estado     = 'V'
  if @@rowcount = 0
  begin /*Error al buscar tipo de rango */
    select
      @w_error = 351532
    goto ERROR
  end

  /* =========[ Busco el rango a utilizar ]================ */
  if @w_tipo_atributo = 'B' /* Saldo promedio */
  begin
    select
      @w_monto = @i_promedio
  end
  else if @w_tipo_atributo = 'C' /* Saldo Contable */
  begin
    select
      @w_monto = @i_contable
  end
  else if @w_tipo_atributo = 'A' /* Saldo Disponible */
  begin
    select
      @w_monto = @i_disponible
  end
  else if @w_tipo_atributo = 'E' /* Promedio Disponible */
  begin
    select
      @w_monto = @i_prom_disp
  end
  else if @w_tipo_atributo = 'F' /* Porcentaje Tiempo Transcurrido */
  begin
    select
      @w_monto = convert(money, @i_porc_tiempo)
  end
  else
    select
      @w_monto = $1

  /* ==========[ Busca rango adecuado ]========================= */
  select
    @w_rango = ra_rango
  from   pe_rango
  where  ra_tipo_rango  = @w_tipo_rango
     and ra_grupo_rango = @w_grupo_rango
     and ra_desde       <= @w_monto
     and ra_hasta       > @w_monto
     and ra_estado      = 'V'
  if @@rowcount = 0
  begin /*Error al buscar rango */
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
    begin
      print '@w_tipo_atributo: ' + cast(@w_tipo_atributo as varchar)
      print '@w_tipo_rango   : ' + cast(@w_tipo_rango as varchar)
      print '@w_grupo_rango  : ' + cast(@w_grupo_rango as varchar)
      print '@w_monto        : ' + cast(@w_monto as varchar)
    end

    select
      @w_error = 351551
    goto ERROR

  end

  /* ========[ Extraigo registro de costos ]=================== */
  begin tran

  if @i_sec_costo is null
  begin
    select
      @w_sec_costo = max(co_secuencial)
    from   pe_costo
    where  co_servicio_per   = @w_servicio_per
       and co_categoria      = @i_categoria
       and co_tipo_rango     = @w_tipo_rango
       and co_grupo_rango    = @w_grupo_rango
       and co_rango          = @w_rango
       and co_fecha_vigencia <= @w_fecha
  end
  else
    select
      @w_sec_costo = @i_sec_costo

  if @w_sec_costo is null
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
    begin
      print '@i_fecha: ' + cast(@i_fecha as varchar)
      print '@w_fecha: ' + cast(@w_fecha as varchar)
    end

  select
    @w_valor_medio = co_val_medio,
    @w_minimo = co_minimo,
    @w_maximo = co_maximo
  from   pe_costo
  where  co_secuencial   = @w_sec_costo
     and co_servicio_per = @w_servicio_per
     and co_categoria    = @i_categoria
     and co_tipo_rango   = @w_tipo_rango
     and co_grupo_rango  = @w_grupo_rango
     and co_rango        = @w_rango

  if @@rowcount = 0
  begin /*Error al buscar costo */
    if @w_debug = 'S'
       and @i_tran_ext = 'N'
    begin
      print ' @i_sec_costo:   ' + cast(@i_sec_costo as varchar)
      print ' @w_servicio_per:' + cast(@w_servicio_per as varchar)
      print ' @w_tipo_rango:  ' + cast(@w_tipo_rango as varchar)
      print ' @w_grupo_rango: ' + cast(@w_grupo_rango as varchar)
      print ' @w_rango:       ' + cast(@w_rango as varchar)
      print ' @w_sec_costo:   ' + cast(@w_sec_costo as varchar)
      print ' @i_categoria:   ' + cast(@i_categoria as varchar)
      print ' @i_personaliza: ' + cast(@i_personaliza as varchar)
    end

    select
      @w_error = 351552,
      @w_severidad = 1
    goto ERROR
  end

  if @i_personaliza = 'S'
     and @i_paquete is null
  begin
    if @i_sec_valor is null
    begin
      select
        @w_sec_valor = max(vc_secuencial)
      from   pe_val_contratado
      where  vc_tipo_default = @i_tipo_def
         and vc_rol          = @i_rol_ente
         and vc_producto     = @i_producto
         and vc_codigo       = @i_codigo
         and vc_servicio_per = @w_servicio_per
         and vc_categoria    = @i_categoria
         and vc_tipo_rango   = @w_tipo_rango
         and vc_grupo_rango  = @w_grupo_rango
         and vc_rango        = @w_rango
         and vc_fecha        <= @w_fecha
    end
    else
      select
        @w_sec_valor = @i_sec_valor

    if @w_sec_valor is null
      if @w_debug = 'S'
         and @i_tran_ext = 'N'
      begin
        print '@i_fecha: ' + cast(@i_fecha as varchar)
        print '@w_fecha: ' + cast(@w_fecha as varchar)
      end

    select
      @w_valor_con = vc_valor_con,
      @w_tipo_dato2 = vc_tipo_variacion,
      @w_signo2 = vc_signo
    from   pe_val_contratado
    where  vc_secuencial   = @w_sec_valor
       and vc_tipo_default = @i_tipo_def
       and vc_rol          = @i_rol_ente
       and vc_producto     = @i_producto
       and vc_codigo       = @i_codigo
       and vc_servicio_per = @w_servicio_per
       and vc_categoria    = @i_categoria
       and vc_tipo_rango   = @w_tipo_rango
       and vc_grupo_rango  = @w_grupo_rango
       and vc_rango        = @w_rango
       and vc_estado       = 'V'

    if @@rowcount = 0
      select
        @w_valor_con = 0

    if @w_tipo_dato2 = 'P'
      select
        @w_valor_medio = @w_valor_medio + @w_valor_medio * (@w_valor_con / 100)
    else
      select
        @w_valor_medio = @w_valor_medio + @w_valor_con
  end

  --print '@w_servicio_dis %1! @w_rubro %2! @w_fecha %3! @i_paquete %4!', @w_servicio_dis,@w_rubro, @w_fecha, @i_paquete

  /* CLE 04172006 BONIFICACIONES DEL PAQUETE */
  if @i_paquete is not null
  begin
    select
      @w_bonificacion = isnull(bc_porc_bonificacion,
                               0)
    from   pa_bonificacion_cargos
    where  bc_numpq    = @i_paquete
       and bc_servicio = @w_servicio_dis
       and bc_rubro    = @w_rubro
       and @w_fecha between bc_fec_ini and bc_fec_vto
       and bc_estado   = 'V'

    if @@rowcount = 0
      select
        @w_bonificacion = 0

    if @w_bonificacion > 0
      select
        @w_valor_medio = @w_valor_medio - (@w_valor_medio * @w_bonificacion /
                                           100)
  --print '@w_bonificacion %1!', @w_bonificacion
  end

  if @w_valor_medio < @w_minimo
    select
      @w_valor_medio = @w_minimo
  else if @w_valor_medio > @w_maximo
    select
      @w_valor_medio = @w_maximo

  if @w_tipo_dato = 'P'
    select
      @w_valor_medio = @i_valor * @w_valor_medio / 100

  select
    @o_valor_total = @w_valor_medio,
    @o_sec_costo = @w_sec_costo,
    @o_sec_valor = @w_sec_valor

  if @w_debug = 'S'
     and @i_tran_ext = 'N'
    print '@i_servicio : ' + @i_servicio + ' @w_rubro: ' + @w_rubro +
                                   ' @o_valor_total: '
          + cast(@o_valor_total as varchar) + ' @w_servicio_per: '
          + cast(@w_servicio_per as varchar)

  commit tran
  return 0

  ERROR:
  if @i_tran_ext = 'N'
  begin
    if @i_batch = 'N'
    begin
      exec cobis..sp_cerror1
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error,
        @i_sev   = @w_severidad,
        @i_pit   = @i_pit
    end
    return @w_error
  end
  else
  begin
    if @w_severidad = 1
      rollback tran

    return @w_error
  end

GO 
