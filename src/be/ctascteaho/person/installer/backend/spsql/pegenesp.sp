/****************************************************************************/
/*     Archivo:     pegenesp.sp                                             */
/*     Stored procedure: sp_genera_costos_esp                               */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por: Carlos Leon                                            */
/*     Fecha de escritura: 20-Dic-2005                                      */
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
/*     servicio especial                                                    */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     20/Dic/2005      Carlos Leon     Emision Inicial                     */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_genera_costos_esp')
  drop proc sp_genera_costos_esp
go

create proc sp_genera_costos_esp
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cuenta       cuenta,
  @i_cliente      int,
  @i_oficina      smallint,
  @i_tipo         char(1) = 'R',
  @i_servicio     catalogo,
  @i_rubro        catalogo,
  @i_disponible   money= $0,
  @i_contable     money= $0,
  @i_promedio     money= $0,
  @i_prom_disp    money = $0,
  @i_valor        money = 1,
  @i_fecha        datetime,
  @i_sec_costo    int = null,
  @i_sec_valor    int = null,
  @i_pit          char(1) = 'N',
  @o_valor_total  money out,
  @o_sec_costo    int = null out,
  @o_sec_valor    int = null out
)
as
  declare
    @w_sp_name       varchar(32),
    @w_return        int,
    @w_valor_per     money,
    @w_valor_per_o   money,
    @w_rango         tinyint,
    @w_tipo_rango    tinyint,
    @w_grupo_rango   smallint,
    @w_mercado       int,
    @w_servicio_dis  int,
    @w_signo         char(1),
    @w_signo2        char(1),
    @w_tipo_dato     char(1),
    @w_tipo_dato_o   char(1),
    @w_tipo_base     char(1),
    @w_rubro         catalogo,
    @w_tipo_atributo catalogo,
    @w_monto         money,
    @w_valor_minimo  money,
    @w_valor_maximo  money,
    @w_valor_base    money,
    @w_fecha         datetime,
    @w_personalizada char(1),
    @w_tipo_costo    char(1),
    @w_sec_costo     int,
    @w_sec_costo_v   int,
    @w_cuenta        cuenta,
    @w_cliente       int,
    @w_oficina       smallint,
    @w_tipo_aplic    char(1),
    @w_valor         float

/*********************************************/
  --print '@i_rubro %1! @i_cuenta %2! @i_cliente %3! @i_oficina %4!', @i_rubro, @i_cuenta, @i_cliente, @i_oficina

  select
    @w_sp_name = 'sp_genera_costos_esp'
  select
    @w_fecha = convert(char(10), @i_fecha, 101)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --print '@w_fecha: %1!', @w_fecha
  /* Valida que se halla ingresado al menos un valor sobre el cual actuar */

  if @i_disponible is null
     and @i_contable is null
     and @i_promedio is null
     and @i_prom_disp is null
  begin
    /* No se ha ingresado el valor sobre el cual se actua */
    exec cobis..sp_cerror1
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351550,
      @i_pit   = @i_pit
    return 351550
  end

  /*=================[ Extraigo el servicio a utilizar ]=================*/
  select
    @w_servicio_dis = sd_servicio_dis
  from   pe_servicio_dis
  where  sd_nemonico = @i_servicio
     and sd_estado   = 'V'

  if @@rowcount = 0
  begin /*no existe servicio disponible */
    exec cobis..sp_cerror1
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351501,
      @i_pit   = @i_pit
    return 351501
  end

/*=============[ Determino servicio personalizable ]============*/
  --print "rubro: %1! ", @i_rubro
  --print "servicio_dis: %1! ", @w_servicio_dis

  select
    @w_tipo_rango = ce_tipo_rango,
    @w_grupo_rango = ce_grupo_rango
  from   pe_costo_especial
  where  ce_servicio_dis = @w_servicio_dis
     and ce_rubro        = @i_rubro

  if @@rowcount = 0
  begin /*No existe servicio personalizable*/
    exec cobis..sp_cerror1
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351540,
      @i_pit   = @i_pit
    return 351540
  end

  select
    @w_tipo_atributo = tr_tipo_atributo
  from   pe_tipo_rango
  where  tr_tipo_rango = @w_tipo_rango
     and tr_estado     = 'V'
  if @@rowcount = 0
  begin /*Error al buscar tipo de rango */
    exec cobis..sp_cerror1
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351532,
      @i_pit   = @i_pit
    return 351532
  end

  /*=========[ Busco el rango a utilizar ]================*/
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
  else
    select
      @w_monto = $1
  --print '%1!', @w_tipo_atributo
/*==========[ Busca rango adecuado ]=========================*/
  --print '@w_tipo_rango %1!', @w_tipo_rango
  --print '@w_grupo_rango %1!', @w_grupo_rango

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
    exec cobis..sp_cerror1
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351551,
      @i_pit   = @i_pit
    return 351551
  end

  --print '@w_rango %1!', @w_rango

/*========[ Extraigo registro de costos ]===================*/
  /* Consulta de costos especiales personalizados por cuenta. cliente, oficina */

  select
    @w_sec_costo = max(cp_secuencial)
  from   pe_costo_especial_per
  where  cp_cuenta         = @i_cuenta
     and cp_rubro          = @i_rubro
     and cp_fecha_vigencia <= @w_fecha

  if @w_sec_costo is null
    select
      @w_sec_costo = max(cp_secuencial)
    from   pe_costo_especial_per
    where  cp_cliente        = @i_cliente
       and cp_rubro          = @i_rubro
       and cp_fecha_vigencia <= @w_fecha

  if @w_sec_costo is null
    select
      @w_sec_costo = max(cp_secuencial)
    from   pe_costo_especial_per
    where  cp_oficina        = @i_oficina
       and cp_rubro          = @i_rubro
       and cp_fecha_vigencia <= @w_fecha

  if @w_sec_costo is not null
  begin
    select
      @w_cuenta = cp_cuenta,
      @w_cliente = cp_cliente,
      @w_oficina = cp_oficina,
      @w_tipo_costo = cp_tipo_costo
    from   pe_costo_especial_per
    where  cp_secuencial = @w_sec_costo

    --print '@w_tipo_costo %1! @w_sec_costo %2!', @w_tipo_costo, @w_sec_costo

    if @w_tipo_costo = 'V' /* Verificar si tipo costo es variable */
    begin
      if @w_cuenta is not null
        select
          @w_sec_costo_v = cp_secuencial
        from   pe_costo_especial_per
        where  cp_servicio_dis   = @w_servicio_dis
           and cp_rubro          = @i_rubro
           and cp_tipo_rango     = @w_tipo_rango
           and cp_grupo_rango    = @w_grupo_rango
           and cp_rango          = @w_rango
           and cp_cuenta         = @w_cuenta
           and cp_fecha_vigencia <= @w_fecha

      if @w_sec_costo_v is null
        if @w_cliente is not null
          select
            @w_sec_costo_v = cp_secuencial
          from   pe_costo_especial_per
          where  cp_servicio_dis   = @w_servicio_dis
             and cp_rubro          = @i_rubro
             and cp_tipo_rango     = @w_tipo_rango
             and cp_grupo_rango    = @w_grupo_rango
             and cp_rango          = @w_rango
             and cp_cliente        = @w_cliente
             and cp_fecha_vigencia <= @w_fecha

      if @w_sec_costo_v is null
        if @w_oficina is not null
          select
            @w_sec_costo_v = cp_secuencial
          from   pe_costo_especial_per
          where  cp_servicio_dis   = @w_servicio_dis
             and cp_rubro          = @i_rubro
             and cp_tipo_rango     = @w_tipo_rango
             and cp_grupo_rango    = @w_grupo_rango
             and cp_rango          = @w_rango
             and cp_oficina        = @w_oficina
             and cp_fecha_vigencia <= @w_fecha

      if @w_sec_costo_v is not null
        select
          @w_sec_costo = @w_sec_costo_v
      else
        select
          @w_sec_costo = null

    end

  end
  --print '@w_sec_costo_v %1!', @w_sec_costo_v

  if @w_sec_costo is not null
    select
      @w_personalizada = 'S'
  else
    select
      @w_personalizada = 'N'
  --print '@w_personalizada %1!', @w_personalizada

  if @w_personalizada = 'N' /* costos generales */
  begin
    select
      @w_valor_per = ce_base,
      @w_tipo_dato = ce_tipo_dato
    from   pe_costo_especial
    where  ce_servicio_dis   = @w_servicio_dis
       and ce_rubro          = @i_rubro
       and ce_tipo_rango     = @w_tipo_rango
       and ce_grupo_rango    = @w_grupo_rango
       and ce_rango          = @w_rango
       and ce_fecha_vigencia <= @w_fecha
       and ce_en_linea       = 'S'

    if @@rowcount = 0
    begin /*Error al buscar costo */
      exec cobis..sp_cerror1
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351552,
        @i_pit   = @i_pit
      return 351552
    end

    if @w_tipo_dato = 'M'
      select
        @o_valor_total = @w_valor_per
    else
      select
        @o_valor_total = round(@w_monto * @w_valor_per / 100.0,
                               2)

  --print '@w_valor_per %1! @w_tipo_dato %2!', @w_valor_per, @w_tipo_dato
  end
  else /* personalizada = 'S' */
  begin
    select
      @w_tipo_costo = cp_tipo_costo,
      @w_valor_per = cp_valor_per,
      @w_tipo_dato = cp_tipo_dato,
      @w_cuenta = cp_cuenta,
      @w_cliente = cp_cliente,
      @w_oficina = cp_oficina,
      @w_tipo_aplic = cp_tipo_aplic
    from   cob_remesas..pe_costo_especial_per
    where  cp_secuencial = @w_sec_costo

    if @w_tipo_costo = 'F'
    begin
      if @w_tipo_dato = 'M'
        select
          @o_valor_total = @w_valor_per
      else
        select
          @o_valor_total = round(@w_monto * @w_valor_per / 100.0,
                                 2)
      return 0
    end
    else if @w_tipo_costo = 'E'
    begin
      select
        @o_valor_total = 0
      return 0
    end
    else
    begin /* valor variable */
      if @w_tipo_aplic = 'O'
      begin
        select
          @w_valor_per_o = cp_valor_per,
          @w_tipo_dato_o = cp_tipo_dato
        from   pe_costo_especial_per
        where  cp_servicio_dis = @w_servicio_dis
           and cp_rubro        = @i_rubro
           and cp_tipo_rango   = @w_tipo_rango
           and cp_grupo_rango  = @w_grupo_rango
           and cp_rango        = @w_rango
           and cp_oficina      = @i_oficina

        if @@rowcount = 0
          select
            @w_valor_per_o = 0,
            @w_tipo_dato_o = ''

      --print '@w_valor_per_o %1! @w_tipo_dato_o %2!', @w_valor_per_o ,@w_tipo_dato_o
      end
    end

    /* lectura de valores generales para aplicar montos variables */
    select
      @w_valor_base = ce_base,
      @w_tipo_base = ce_tipo_dato,
      @w_valor_maximo = ce_maximo,
      @w_valor_minimo = ce_minimo
    from   pe_costo_especial
    where  ce_servicio_dis   = @w_servicio_dis
       and ce_rubro          = @i_rubro
       and ce_tipo_rango     = @w_tipo_rango
       and ce_grupo_rango    = @w_grupo_rango
       and ce_rango          = @w_rango
       and ce_fecha_vigencia <= @w_fecha
       and ce_en_linea       = 'S'

    if @@rowcount = 0
    begin /*Error al buscar costo */
      exec cobis..sp_cerror1
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351553,
        @i_pit   = @i_pit
      return 351553
    end

    --print '@w_valor_base %1! @w_tipo_base %2!', @w_valor_base,  @w_tipo_base
    --print '@w_tipo_dato %1! @w_valor_per %2!', @w_tipo_dato, @w_valor_per

    if @w_tipo_aplic = 'N'
        or @w_tipo_aplic is null
    begin
      if @w_tipo_dato = 'P'
        select
          @w_valor = @w_valor_base + @w_valor_base * @w_valor_per / 100.0
      else
        select
          @w_valor = @w_valor_base + @w_valor_per

      if @w_valor > @w_valor_maximo
        select
          @w_valor = @w_valor_maximo

      if @w_valor < @w_valor_minimo
        select
          @w_valor = @w_valor_minimo

      if @w_tipo_dato = 'P'
         and @w_tipo_base = 'P'
        select
          @o_valor_total = round(@w_monto * @w_valor / 100.0,
                                 2)
      else
        select
          @o_valor_total = @w_valor

    end

    if @w_tipo_aplic = 'O'
    begin
      if @w_tipo_dato_o = 'P'
        select
          @w_valor = @w_valor_base + @w_valor_base * @w_valor_per_o / 100.0
      else
        select
          @w_valor = @w_valor_base + @w_valor_per_o

      if @w_tipo_dato = 'P'
        select
          @w_valor = @w_valor + @w_valor * @w_valor_per / 100.0
      else
        select
          @w_valor = @w_valor + @w_valor_per

      if @w_valor > @w_valor_maximo
        select
          @w_valor = @w_valor_maximo

      if @w_valor < @w_valor_minimo
        select
          @w_valor = @w_valor_minimo

      if @w_tipo_dato = 'P'
         and @w_tipo_base = 'P'
        select
          @o_valor_total = round(@w_monto * @w_valor / 100.0,
                                 2)
      else
        select
          @o_valor_total = @w_valor

    end
  --print '@w_tipo_aplic %1! @w_tipo_dato_o %2! @w_valor_per_o %3!',@w_tipo_aplic, @w_tipo_dato_o, @w_valor_per_o

  end /* personalizada = 'S' */

  return 0

GO 
