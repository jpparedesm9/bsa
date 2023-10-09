/************************************************************************/
/*  Archivo:            ahcalgmf.sp                                     */
/*  Stored procedure:   sp_calcula_gmf                                  */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Davis Medina                                    */
/*  Fecha de escritura: 20-Ago-2009                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa calcula el valor del gmf para la cuenta dada          */
/*  de acuerdo con el concepto de exencion                              */
/*                          MODIFICACIONES                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  20/Ago/2009 D. Medina   Emision inicial                             */
/*  27/Mar/2013 J. Colorado Alianza Comercial                           */
/*  02/May/2016 J. Calderon Migración a CEN                             */
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
           where  name = 'sp_calcula_gmf')
  drop proc sp_calcula_gmf
go

create proc sp_calcula_gmf
(
  @s_user            varchar(30) = null,
  @s_date            datetime,
  @s_ofi             smallint = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_trn             smallint = null,
  @t_ssn_corr        int = null,
  @t_show_version    bit = 0,
  @i_factor          smallint = null,
  @i_mon             tinyint = 0,
  @i_cta             cuenta = null,
  @i_cuenta          int,
  @i_val             money = 0,
  @i_numdeciimp      tinyint = 0,
  @i_producto        tinyint = 4,
  @i_operacion       char(1) = 'Q',
  @i_corr            char(1) = null,
  @i_reverso         char(1) = null,
  @i_val_tran        money = null,
  @i_total           char(1) = 'N',
  @i_acum_deb        money = 0,-- Nuevo acumualdo debitos
  @i_is_batch        char(1) = 'N',
  @i_cliente         int = null,
  @o_total_gmf       money = 0 out,-- GMF Calculado
  @o_acumu_deb       money = 0 out,-- Devuelve acumulado debitos
  @o_actualiza       char(1) = null out,-- Indicador para actualizar acumulado
  @o_base_gmf        money = 0 out,-- Devuelve base calculo gmf
  @o_concepto        smallint = 0 out,-- Devuelve concepto exencion
  @o_tasa            float = 0 out,-- Devuelve la tasa aplicada
  @o_difer_gmf       money = 0 out,-- Devuelve la diferencia para embargos
  @o_tasa_reintegro  float = 0 out,

  -- Devuelve el porcentaje de reitengro de alianza
  @o_valor_reintegro money = 0 out -- Devuelve el valor cubierto para reitengro 
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_imp_gmf        float,
    @w_mm             char(2),
    @w_sql            varchar(800),
    @w_columna        varchar(16),
    @w_deb_mes        money,
    @w_ind_tope       char(1),
    @w_vlr_tope       money,
    @w_difer_gmf      money,
    @w_tasa           float,
    @w_prod_gmf       tinyint,
    @w_valor_tot      money,
    @w_factor         smallint,
    @w_ind            char(1),
    @w_error          int,
    @w_debug          char(1),
    @w_numdeciimp     tinyint,
    @w_gmf_alianza    money,
    @w_total_gmf_rein money,
    @w_usadeci        char(1)

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_calcula_gmf'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_debug = 'N'

  /* Inicializa variables  */
  select
    @w_mm = convert(varchar(2), substring(convert(varchar(12), @s_date, 101),
                                          1,
                                          2))
  select
    @w_columna = 'eg_mes_' + @w_mm

/* Captura de Parametro Decimales*/
  /* Encuentra parametro de decimales */
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_mon

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeciimp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DIM'
       and pa_producto = 'AHO'

    if @w_numdeciimp is null
      select
        @i_numdeciimp = 0
    else
      select
        @i_numdeciimp = @w_numdeciimp
  end
  else
    select
      @i_numdeciimp = 0

/*
    select @w_numdeciimp = pa_tinyint
    from  cobis..cl_parametro
    where pa_producto = 'AHO'
    and   pa_nemonico = 'DIM'

    if @w_numdeciimp is null
       select @i_numdeciimp = 0
    else
       select @i_numdeciimp = @w_numdeciimp
       */
  /*  Carga de datos de exencion de cuenta */
  if @i_operacion = 'Q'
  begin
    /*Impuesto GMF general a debitos*/
    select
      @w_tasa = pa_float
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'IGMF'

    if @@rowcount = 0
    begin
      select
        @w_error = 201196
      goto ERROR
    end

    select
      @w_difer_gmf = 0,
      @w_deb_mes = 0,
      @w_valor_tot = 0,
      @w_factor = 1,
      @o_concepto = 0,
      @o_total_gmf = 0,
      @o_acumu_deb = 0,
      @o_base_gmf = 0,
      @o_actualiza = 'N',
      @w_ind = 'S',
      @w_gmf_alianza = 0

    /*  Validacion de execion de gmf con su concepto correspondiente */
    select
      @o_concepto = eg_concepto,
      @w_deb_mes = case
                     when @w_mm = '01' then eg_mes_01
                     when @w_mm = '02' then eg_mes_02
                     when @w_mm = '03' then eg_mes_03
                     when @w_mm = '04' then eg_mes_04
                     when @w_mm = '05' then eg_mes_05
                     when @w_mm = '06' then eg_mes_06
                     when @w_mm = '07' then eg_mes_07
                     when @w_mm = '08' then eg_mes_08
                     when @w_mm = '09' then eg_mes_09
                     when @w_mm = '10' then eg_mes_10
                     when @w_mm = '11' then eg_mes_11
                     when @w_mm = '12' then eg_mes_12
                   end
    from   ah_exenta_gmf with (holdlock)
    where  eg_cuenta = @i_cuenta
       and eg_marca  = 'S'

    if @i_factor = -1
        or @i_corr = 'S'
        or @i_reverso = 'R'
      select
        @w_factor = -1

    select
      @w_total_gmf_rein = 0

    /* Transaccion de reverso.  Busca transaccion original */
    if @w_factor = -1
    begin
      if @i_corr = 'S'
         and @t_trn = 253
        select
          @t_trn = 264

      select
        @o_total_gmf = tm_monto_imp,
        @w_valor_tot = tm_valor,
        @o_base_gmf = tm_saldo_lib
      from   ah_tran_monet
      where  tm_ssn_branch = @t_ssn_corr
         and tm_oficina    = @s_ofi
         and tm_cta_banco  = @i_cta
         and tm_moneda     = @i_mon
         and tm_tipo_tran  = @t_trn
         and tm_estado is null
         and tm_usuario    = @s_user
         and tm_efectivo   = @i_val_tran

      if @@rowcount <> 1
        select
          @w_ind = 'N'

    end

    /*  Fin transaccion de reverso */

    if @o_concepto <> 0
    begin
      select
        @w_ind_tope = ce_tope,
        @w_vlr_tope = ce_vlr_tope,
        @w_tasa = ce_tasa,
        @w_prod_gmf = ce_producto
      from   cob_remesas..re_concep_exen_gmf
      where  ce_concepto = @o_concepto

      if @@rowcount <> 1
      begin
        select
          @w_error = 352079
        goto ERROR
      end

      if @w_debug = 'S'
        print '@w_ind_tope: ' + @w_ind_tope + ' @w_tasa: ' + cast(@w_tasa as
              varchar
              )
              +
                                      ' @i_total: '
              + @i_total

      if @w_ind_tope = 'S' /* Validacion de tope para exencion */
      begin
        select
          @o_acumu_deb = @w_deb_mes + (@i_val * @w_factor)

        if @o_acumu_deb >= 0
          select
            @o_actualiza = 'S'

        /* Reverso cuando no encuentra transac. original */
        if @w_factor = -1
        begin
          if @w_deb_mes > @w_vlr_tope
          begin
            select
              @w_difer_gmf = @w_vlr_tope - @o_acumu_deb
            if @w_difer_gmf > 0
              select
                @o_base_gmf = @i_val - @w_difer_gmf
            else
              select
                @o_base_gmf = @i_val

            if @i_total = 'S'
              select
                @o_base_gmf = (@o_base_gmf) * (1 / (1 + @w_tasa))

            select
              @o_total_gmf = round(@o_base_gmf * @w_tasa,
                                   @i_numdeciimp)
          end
        end

        if @w_factor = 1 /* Transaccion Normal */
        begin
          if @o_acumu_deb > @w_vlr_tope
          begin
            select
              @w_difer_gmf = @w_vlr_tope - @w_deb_mes
            if @w_difer_gmf > 0
              select
                @o_base_gmf = @i_val - @w_difer_gmf
            else
              select
                @o_base_gmf = @i_val

            if @i_total = 'S'
              select
                @o_base_gmf = (@o_base_gmf) * (1 / (1 + @w_tasa))

            select
              @o_total_gmf = round(@o_base_gmf * @w_tasa,
                                   @i_numdeciimp)
          end
        end
      end /* Fin exencion con tope */
      else
      begin
        /* Fin exencion sin tope */
        if @w_tasa = 0
          select
            @o_base_gmf = 0,
            @o_total_gmf = 0
        else
        begin
          select
            @o_base_gmf = @i_val

          if @i_total = 'S'
            select
              @o_base_gmf = (@o_base_gmf) * (1 / (1 + @w_tasa))

          select
            @o_total_gmf = round((@o_base_gmf * @w_tasa),
                                 @i_numdeciimp)
        end

      end
    end /*  Fin concepto diferente cero          */
    else
    begin
      if @w_debug = 'S'
        print '@i_val: ' + cast(@i_val as varchar) + ' @w_tasa: ' + cast(@w_tasa
              as
                                varchar)
              + ' @i_total: ' + @i_total

      if @w_tasa = 0
        select
          @o_base_gmf = 0,
          @o_total_gmf = 0
      else
      begin
        select
          @o_base_gmf = @i_val

        if @i_total = 'S'
          select
            @o_base_gmf = (@o_base_gmf) * (1 / (1 + @w_tasa))

        select
          @o_total_gmf = round((@o_base_gmf * @w_tasa),
                               @i_numdeciimp)
      end
    end

    /* Datos de salida para Embargos */

    select
      @o_tasa = @w_tasa
    if @w_difer_gmf > 0
      select
        @o_difer_gmf = @w_difer_gmf
    else
      select
        @o_difer_gmf = 0

    /* ALIANZA */
    select
      @o_tasa_reintegro = 0,
      @o_valor_reintegro = 0

    if @o_total_gmf > 0
    begin
      select
        @o_tasa_reintegro = isnull(al_porcentaje_gmfbanco,
                                   0)
      from   cobis..cl_alianza with (nolock)
      where  al_cuenta_bancaria = @i_cta
         and al_estado          = 'V'

      if @@rowcount <> 0
        select
          @o_valor_reintegro = isnull(round(isnull(@o_total_gmf,
                                                   0) * (@o_tasa_reintegro / 100
                                                        ),
                                            @i_numdeciimp),
                                      0)
    end
    if @w_debug = 'S'
    begin
      print '@o_total_gmf ' + cast(@o_total_gmf as varchar)
      print '@o_acumu_deb ' + cast(@o_acumu_deb as varchar)
      print '@o_actualiza ' + cast(@o_actualiza as varchar)
      print '@o_base_gmf  ' + cast(@o_base_gmf as varchar)
      print '@o_concepto  ' + cast(@o_concepto as varchar)
      print '@o_tasa      ' + cast(@o_tasa as varchar)
      print '@o_difer_gmf ' + cast(@o_difer_gmf as varchar)
      print '@i_cta ' + cast(@i_cta as varchar)
      print '@o_tasa_reintegro ' + cast(@o_tasa_reintegro as varchar)
      print '@o_valor_reintegro ' + cast(@o_valor_reintegro as varchar)
    end
  end

  if @i_operacion = 'U'
  begin
    if @i_producto = 4
      select
        @w_sql = 'UPDATE cob_ahorros..ah_exenta_gmf SET eg_fecha_valor = '''
                 + convert(char(10), @s_date, 101) + ''',' + @w_columna + ' = '
                 + convert(varchar(20), @i_acum_deb) + ' WHERE eg_cuenta = '
                 + convert(varchar(12), @i_cuenta)
    else
      select
        @w_sql =
'UPDATE cob_cuentas..cc_exenta_gmf SET eg_fecha_valor = ''+convert(char(10),@s_date,101)+'','
         + @w_columna + ' = ' + convert(varchar(20), @i_acum_deb) +
' WHERE eg_cuenta = '
         + convert(varchar(12), @i_cuenta)

  exec (@w_sql)

  if @@rowcount <> 1
      or @@error <> 0
  begin
    select
      @w_error = 352081
    goto ERROR
  end
end

  ----------------------------------------------------------
  -- DEVUELVE LA LISTA DE CONCEPTOS DE EXENCION FRONT END
  ----------------------------------------------------------

  if @i_operacion = 'F'
  begin
    set rowcount 20
    select
      ce_concepto,
      ce_descripc
    from   cob_remesas..re_concep_exen_gmf
    where  ce_concepto > @i_cuenta
       and ce_producto in (@i_producto, 9)
    order  by ce_concepto

    if @@rowcount = 0
    begin
      select
        @w_error = 352079
      goto ERROR
    end
    set rowcount 0
  end

  ----------------------------------------------------------
  -- DEVUELVE LA DESCRIPCION CONCEPTO EXENCION FRONT END            
  ----------------------------------------------------------

  if @i_operacion = 'B'
  begin
    select
      ce_descripc,
      ce_tipo_per,
      ce_titular,
      ce_otra_exen
    from   cob_remesas..re_concep_exen_gmf
    where  ce_concepto = @i_cuenta
       and ce_producto in (@i_producto, 9)

    if @@rowcount = 0
    begin
      select
        @w_error = 352079
      goto ERROR
    end
  end
  return 0
  ERROR:

  if @i_is_batch = 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error
  end
  return @w_error

go

