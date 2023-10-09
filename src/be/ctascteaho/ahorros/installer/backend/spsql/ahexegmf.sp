/************************************************************************/
/*      Archivo:                ahexegmf.sp                             */
/*      Stored procedure:       sp_exencion_gmf                         */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Claudia Rodriguez                       */
/*      Fecha de escritura:     17-Ene-2007                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      BATCH:  Procesa devolucion gmf cobrado a cuentas marcadas       */
/*              como excentas a partir de su fecha de marcacion         */
/*                                                                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*      FECHA           AUTOR           RAZON                           */
/*      17/Ene/2007     Claudia R.      Emision Inicial                 */
/*      29/Mar/2007     Claudia R.      Modif. reintegro diario         */
/*      04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_exencion_gmf')
  drop proc sp_exencion_gmf
go

/****** Object:  StoredProcedure [dbo].[sp_exencion_gmf]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_exencion_gmf
(
  @t_show_version bit = 0,
  @i_ssn          int,
  @i_srv          varchar(30),
  @i_user         varchar(30),
  @i_sesn         int,
  @i_term         varchar(10),
  @i_filial       tinyint,
  @i_fecha        smalldatetime,
  @o_num_reg      int out
)
as
  declare
    @w_sp_name       varchar(64),
    @w_ssn           int,
    @w_moneda        smallint,
    @w_tope          money,
    @w_tope_pen      money,
    @w_imp_2x1000    float,
    @w_usadeci       char(1),
    @w_numdeci       tinyint,
    @w_numdeciimp    tinyint,
    @w_fin_mes       varchar(12),
    @w_error         int,
    @w_mensaje       descripcion,
    @w_cta_banco     cuenta,
    @w_cuenta        int,
    @w_mes_deb       money,
    @w_acumu_deb     money,
    @w_acumula_efe   money,
    @w_acumula_imp   money,
    @w_acumula_gmf_n money,
    @w_acumula_int   money,
    @w_acumula_gmf_i money,
    @w_return        int,
    @w_procesadas    int,
    @w_total_deb     money,
    @w_total_gmf     money,
    @w_oficina       smallint,
    @w_mm            char(2),
    @w_sql           varchar(800),
    @w_columna       varchar(16),
    @w_categoria     char(1)

  /*Limpia tabla temporal */
  truncate table ah_temp_devgmf

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_exencion_gmf'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Inicializar el contador de cuentas procesadas */
  select
    @w_procesadas = 0,
    @w_moneda = 0

  /* Se calcula mes de la fecha de proceso */

  select
    @w_fin_mes = convert(varchar(12), @i_fecha, 101)
  select
    @w_mm = convert(varchar(2), substring(@w_fin_mes,
                                          1,
                                          2))
  select
    @w_columna = 'eg_mes_' + @w_mm

  --print 'Fecha: %1!', @w_fin_mes
  --print 'Mes  : %1!', @w_mm 
  --print 'Columna: %1!', @w_columna

  /* Determinar el SSN */
  begin tran

  /* Encuentra el SSN inicial */
  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 50000

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  commit tran

  /* Encuentra el monto tope exencion */

  select
    @w_tope = pa_money
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'TEGMF'

  if @@rowcount <> 1
  begin
    /* Error en lectura de parametro tope exencion */
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN LECTURA DE PARAMETRO TOPE EXENCION'

    select
      @o_num_reg = @w_procesadas
    return 201196
  end

  /* Encuentra el monto tope pensionados */

  select
    @w_tope_pen = pa_money
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'TPGMF'

  if @@rowcount <> 1
  begin
    /* Error en lectura de parametro tope exencion */
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN LECTURA DE PARAMETRO TOPE EXENCION PENSIONADO'

    select
      @o_num_reg = @w_procesadas
    return 201196
  end

  select
    @w_imp_2x1000 = pa_float
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'IMDB'

  if @@rowcount <> 1
  begin
    /* Error en lectura de parametro tope exencion */
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN LECTURA DE PARAMETRO EMERGENCIA ECON.'

    select
      @o_num_reg = @w_procesadas
    return 201196
  end

  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DCI'

    if @@rowcount <> 1
    begin
      /* Error en lectura de parametro de decimales */
      exec cobis..sp_cerror
        @i_num = 201196,
        @i_msg = 'ERROR EN LECTURA DE PARAMETRO DE DECIMALES'

      select
        @o_num_reg = @w_procesadas
      return 201196
    end
    select
      @w_numdeciimp = pa_tinyint
    from   cobis..cl_parametro
    where  pa_producto = 'AHO'
       and pa_nemonico = 'DIM'

    if @@rowcount <> 1
    begin
      /* Error en lectura de parametro de decimales */
      exec cobis..sp_cerror
        @i_num = 201196,
        @i_msg = 'ERROR EN LECTURA DE PARAMETRO DECIMALES IMPUESTOS'

      select
        @o_num_reg = @w_procesadas
      return 201196
    end
  end
  else
    select
      @w_numdeci = 0,
      @w_numdeciimp = 0

  /* Inserta en Temporal */
  insert into cob_ahorros..ah_temp_devgmf
    select
      eg_cta_banco,eg_cuenta,ah_oficina,case
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
      end,isnull (sum (isnull(tm_efectivo,
                          0)),
              0),
      0,--isnull (SUM (isnull(tm_impuesto,0)),0),
      isnull (sum (isnull(tm_monto_imp,
                          0)),
              0),isnull (sum (isnull(tm_interes,
                          0)),
              0),isnull(sum (case
                    when tm_tipo_tran = 250 then isnull(tm_valor,
                                                        0)
                  end),
             0),ah_categoria
    from   cob_ahorros..ah_tran_monet,
           cob_ahorros..ah_exenta_gmf,
           cob_ahorros..ah_cuenta
    where  tm_cta_banco                        = eg_cta_banco
       and tm_fecha                            = @i_fecha
       and tm_estado is null
       and tm_signo                            = 'D'
       and (tm_monto_imp                        <> 0
             or tm_tipo_tran                        = 250)
       and eg_cuenta                           = ah_cuenta
       and eg_marca                            = 'S'
       and isnull(eg_fecha_valor,
                  '01/01/1900') < @i_fecha
    group  by eg_cta_banco,
              eg_cuenta,
              ah_oficina,
              eg_mes_01,
              eg_mes_02,
              eg_mes_03,
              eg_mes_04,
              eg_mes_05,
              eg_mes_06,
              eg_mes_07,
              eg_mes_08,
              eg_mes_09,
              eg_mes_10,
              eg_mes_11,
              eg_mes_12,
              ah_categoria

  if @@error <> 0
  begin
    print 'ERROR EN INSERCION  SOBRE ah_temp_devgmf cuentas exentas'
    return 1
  end

  /* Cursor para ah_exenta_gmf, seleccion de cuentas marcadas */

  declare excento_gmf cursor for
    select
      td_cta_banco,
      td_cuenta,
      td_oficina,
      td_mes,
      td_acum_efe,
      td_acum_imp,
      td_acum_gmfn,
      td_acum_int,
      td_acum_gfmi,
      td_categoria
    from   cob_ahorros..ah_temp_devgmf
    for read only
  open excento_gmf

  /* Ubicar el primer registro para el cursor */
  fetch excento_gmf into @w_cta_banco,
                         @w_cuenta,
                         @w_oficina,
                         @w_mes_deb,
                         @w_acumula_efe,
                         @w_acumula_imp,
                         @w_acumula_gmf_n,
                         @w_acumula_int,
                         @w_acumula_gmf_i,
                         @w_categoria

  /* Recorre los registros para cuentas marcadas */
  while @@fetch_status <> -2
  begin
    if @@fetch_status = -1
    begin
      /* Error en lectura de tabla de marcacion de cuentas */
      exec cobis..sp_cerror
        @i_num = 351037,
        @i_sev = 1

      /* Grabar en la tabla de errores */
      insert cob_ahorros..re_error_batch
      values ('0','ERROR EN LECTURA DE TABLA MARCACION EXENCION')

      /* Cerrar y liberar cursor */
      close excento_gmf
      deallocate excento_gmf

      select
        @o_num_reg = @w_procesadas
      return 351037
    end

    /* Determinar la fecha desde la cual devuelve GMF*/

    select
      @w_total_deb = 0,
      @w_total_gmf = 0,
      @w_error = 0

    select
      @w_total_deb = @w_acumula_efe + @w_acumula_imp + @w_acumula_int
    select
      @w_total_gmf = @w_acumula_gmf_n + @w_acumula_gmf_i
    select
      @w_acumu_deb = @w_mes_deb + @w_total_deb

    if @w_categoria <> 'O'
    begin
      if @w_acumu_deb > @w_tope
        select
          @w_total_gmf = round((@w_tope - @w_mes_deb) * @w_imp_2x1000,
                               @w_numdeciimp)
    end
    else
    begin
      if @w_acumu_deb > @w_tope_pen
        select
          @w_total_gmf = round((@w_tope_pen - @w_mes_deb) * @w_imp_2x1000,
                               @w_numdeciimp)
    end

    begin tran

    if @w_total_gmf > 0
    begin
      select
        @w_ssn = @w_ssn + 1

      /**** Credito  a cuenta por devolucion GMF *****/
      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv   = @i_srv,
        @s_ofi   = @w_oficina,
        @s_ssn   = @w_ssn,
        @s_user  = @i_user,
        @s_user  = @i_user,
        @t_trn   = 253,
        @i_cta   = @w_cta_banco,
        @i_val   = @w_total_gmf,
        @i_cau   = '385',-- Causal de NC devolucion GMF
        @i_mon   = @w_moneda,
        @i_fecha = @i_fecha

      if @w_return <> 0
      begin
        rollback tran
        print 'Procesando 1 ... Error EJECUCION NOTA CREDITO'
        select
          @w_error = @w_return
        goto ERRORES
      end
    end

    /*** Actualiza registro de procesada y total debitos en tabla de marcaciones, proceso finalizado ***/

    select
      @w_sql =
'UPDATE cob_ahorros..ah_exenta_gmf SET eg_fecha_valor = ''+convert(char(10),@i_fecha,101)+'','
         + @w_columna + ' = ' + convert(varchar(18), @w_acumu_deb)
         + ' WHERE eg_cta_banco = ''+@w_cta_banco+'''

  exec (@w_sql)

  if @@rowcount <> 1
      or @@error <> 0
  begin
    rollback tran
    print 'Procesando 2 ... Error ACTUALIZACION ACUMULADO DEBITOS'
    select
      @w_mensaje = 'Error ACTUALIZACION ACUMULADO DEBITOS'
    goto ERRORES
  end

  select
    @w_procesadas = @w_procesadas + 1

  commit tran
  goto FETCH_REGISTRO

  ERRORES:

  if @w_error <> 0
  begin
    select
      @w_mensaje = isnull(mensaje,
                          'NO HAY MENSAJE ASOCIADO')
    from   cobis..cl_errores
    where  numero = @w_error
  end
  insert into cob_ahorros..re_error_batch
  values      (@w_cta_banco,@w_mensaje + '  --> VR. NC  ' + convert(varchar(18),
               @w_total_gmf))

  if @@error <> 0
  begin
    /* Error en grabacion de archivo de errores */
    exec cobis..sp_cerror
      @i_num = 203035

    /* Cerrar y liberar cursor */
    close excento_gmf
    deallocate excento_gmf

    select
      @o_num_reg = @w_procesadas
    return 203035
  end

  FETCH_REGISTRO:

  fetch excento_gmf into @w_cta_banco,
                         @w_cuenta,
                         @w_oficina,
                         @w_mes_deb,
                         @w_acumula_efe,
                         @w_acumula_imp,
                         @w_acumula_gmf_n,
                         @w_acumula_int,
                         @w_acumula_gmf_i,
                         @w_categoria
end

  close excento_gmf
  deallocate excento_gmf
  /* Retornar el numero de registros procesados */
  select
    @o_num_reg = @w_procesadas
  return 0

go

