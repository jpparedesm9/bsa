/************************************************************************/
/*    Archivo:          ahcmslmn.sp                                     */
/*    Stored procedure: sp_calc_sldmin                                  */
/*    Base de datos:    cob_ahorros                                     */
/*    Producto:         Cuentas de Ahorros                              */
/*    Disenado por:     D. Villagomez                                   */
/*    Fecha de escr.:   11-Feb-2005                                     */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                            PROPOSITO                                 */
/*    Calcula la comision sobre saldo minimo de las cuentas de ahorros  */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA           AUTOR           RAZON                           */
/* 11-Feb-2005   D Villagomez   Emision inicial                         */
/* 17-Mar-2005   D. villagomez  usar saldo minimo mensual D             */
/* 17-Mar-2005   D. villagomez  eliminar rubro valor saldo              */
/* 01-jUL-2006   P. COELLO      MESES DE GRACIA PARA CUENTAS DE JUBILADO*/
/* 20-Sep-2006   P. COELLO      MODIFICAR PARAMETRO QUE INDICA AL GENERA*/
/*                              COSTOS QUE ES BATCH                     */
/* 20-Sep-2006   P. COELLO      CONTROLA ERROR EN EL INSERT ENERROR LOG */
/* 20-Sep-2006   P. COELLO      ELIMINAR PRINT'S                        */
/* 02/May/2016   J. Calderon    Migración a CEN                         */
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
           where  name = 'sp_calc_sldmin')
  drop proc sp_calc_sldmin
go

create proc sp_calc_sldmin
(
  @t_show_version bit = 0,
  @i_srv          varchar(64),
  @i_fecha        datetime,
  @o_procesadas   int = null out
)
as
  declare
    @w_saldo_min_prod  money,
    @w_saldo_min_his   money,
    @w_comision        money,
    @w_ssn             int,
    @w_sp_name         descripcion,
    @w_mensaje         mensaje,
    @w_tipo_atributo   char(1),
    @w_monto           money,
    @w_sucursal        smallint,
    @w_causa           varchar(3),
    @w_return          int,
    @w_ctacte          int,
    @w_cta_banco       varchar(24),
    @w_filial          tinyint,
    @w_oficina         smallint,
    @w_producto        tinyint,
    @w_moneda          tinyint,
    @w_tipo            varchar(1),
    @w_tipocta         varchar(1),
    @w_disponible      money,
    @w_12h             money,
    @w_24h             money,
    @w_remesas         money,
    @w_promedio1       money,
    @w_prom_disponible money,
    @w_personalizada   varchar(1),
    @w_default         int,
    @w_tipo_def        varchar(1),
    @w_rol_ente        varchar(1),
    @w_saldo_min       money,
    @w_contable        money,
    @w_categoria       varchar(1),
    @w_prod_banc       smallint,
    @w_estado          varchar(1),
    @w_dias            int,
    @w_fecha_eval      smalldatetime,
    @w_meses_gracia    tinyint,
    @w_fecha_gracia    datetime,
    @w_fecha_aper      datetime

  select
    @o_procesadas = 0,
    @w_sp_name = 'sp_calc_sldmin'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_dias = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'DSLM'
     and pa_producto = 'AHO'

  select
    @w_fecha_eval = dateadd(day,
                            @w_dias * -1,
                            @i_fecha)
  begin tran
  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en la lectura del secuencial */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 1000000

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end
  commit tran

  declare com_smin cursor for
    select
      ah_cuenta,
      ah_cta_banco,
      ah_filial,
      ah_oficina,
      ah_producto,
      ah_moneda,
      ah_tipo,
      ah_tipocta,
      ah_disponible,
      ah_12h,
      ah_24h,
      ah_remesas,
      ah_promedio1,
      ah_prom_disponible,
      ah_personalizada,
      ah_default,
      ah_tipo_def,
      ah_rol_ente,
      ah_12h + ah_24h + ah_48h + ah_remesas + ah_disponible,
      ah_categoria,
      ah_prod_banc,
      ah_estado,
      ah_min_dispmes,
      ah_fecha_aper
    from   cob_ahorros..ah_cuenta
    where  ah_estado in ('A', 'I')
       and ah_fecha_aper < @w_fecha_eval

  open com_smin
  fetch com_smin into @w_ctacte,
                      @w_cta_banco,
                      @w_filial,
                      @w_oficina,
                      @w_producto,
                      @w_moneda,
                      @w_tipo,
                      @w_tipocta,
                      @w_disponible,
                      @w_12h,
                      @w_24h,
                      @w_remesas,
                      @w_promedio1,
                      @w_prom_disponible,
                      @w_personalizada,
                      @w_default,
                      @w_tipo_def,
                      @w_rol_ente,
                      @w_contable,
                      @w_categoria,
                      @w_prod_banc,
                      @w_estado,
                      @w_saldo_min,
                      @w_fecha_aper

  if @@fetch_status = -1
  begin
    close com_smin
    deallocate com_smin
    exec cobis..sp_cerror
      @i_num = 201157
    insert into cob_ahorros..re_error_batch
    values      ('0','ERROR AL ABRIR CURSOR DE CUENTAS DE AHORROS')
    return 201157
  end

  if @@fetch_status = -2
  begin
    close com_smin
    deallocate com_smin
    return 0
  end

  while @@fetch_status = 0
  begin
    select
      @w_sucursal = isnull(of_sucursal,
                           of_oficina)
    from   cobis..cl_oficina
    where  of_oficina = @w_oficina

    /******* PEDRO COELLO VERIFICA SI LA CUENTA TIENE MESES DE GRACIA PARA NO SOBRAR COMISION POR SALDO MINIMO *****/
    if @w_personalizada = 'N'
    begin
      select
        @w_tipo_atributo = tipo_atributo
      from   tempdb..pe_tipo_atributo
      where  filial       = @w_filial
         and sucursal     = @w_sucursal
         and producto     = 4
         and moneda       = @w_moneda
         and pro_bancario = @w_prod_banc
         and tipo_cta     = @w_tipocta
         and servicio     = 'CSLM'
         and rubro        = '66'

      if @@rowcount <> 1
      begin
        --SI NO ENCUENTRA TIPO ATRIBUTO NO DA ERROR SOLO LE ASIGNA MESES DE GRACIA 0
        select
          @w_meses_gracia = 0
        goto CalculaComision
      end

      if @w_tipo_atributo = 'B' /* Saldo promedio */
        select
          @w_monto = @w_promedio1
      else if @w_tipo_atributo = 'C' /* Saldo Contable */
        select
          @w_monto = @w_contable
      else if @w_tipo_atributo = 'A' /* Saldo Disponible */
        select
          @w_monto = @w_disponible
      else if @w_tipo_atributo = 'E' /* Promedio Disponible */
        select
          @w_monto = @w_prom_disponible
      else if @w_tipo_atributo = 'D' /* Saldo minimo mensual disponible*/
        select
          @w_monto = @w_saldo_min
      else
        select
          @w_monto = $1

      select
        @w_meses_gracia = valor
      from   tempdb..cslm4
      where  tipo_ente     = @w_tipocta
         and pro_bancario  = @w_prod_banc
         and filial        = @w_filial
         and sucursal      = @w_sucursal
         and producto      = 4
         and moneda        = @w_moneda
         and categoria     = @w_categoria
         and servicio_dis  = 'CSLM'
         and rubro         = '66'
         and tipo_atributo = @w_tipo_atributo
         and rango_desde   <= @w_monto
         and rango_hasta   > @w_monto

      if @@rowcount <> 1
      begin
        --SI NO ENCUENTRA TIPO ATRIBUTO NO DA ERROR SOLO LE ASIGNA MESES DE GRACIA 0
        select
          @w_meses_gracia = 0
        goto CalculaComision
      end
    end
    else
    begin
      /* Llamada al stored procedure que calcula el valor a debitar */
      exec @w_return = cob_remesas..sp_genera_costos
        @t_debug       = 'N',
        @t_file        = null,
        @t_from        = @w_sp_name,
        @t_trn         = 0,
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipocta,
        --PCOELLO ENVIE EL TIPO DE CUENTA Y NO EL ROL DEL ENTE
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_default,
        @i_servicio    = 'CSLM',
        @i_rubro       = '66',
        @i_disponible  = @w_disponible,
        @i_contable    = @w_contable,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disponible,
        @i_min_dispmes = @w_saldo_min,
        @i_valor       = 1,
        @i_personaliza = @w_personalizada,
        @i_fecha       = @i_fecha,
        @i_is_batch    = 'S',
        @o_valor_total = @w_meses_gracia output

      if @w_return <> 0
      begin
        --SI NO ENCUENTRA TIPO ATRIBUTO NO DA ERROR SOLO LE ASIGNA MESES DE GRACIA 0
        select
          @w_meses_gracia = 0
        goto CalculaComision
      end
    end

    select
      @w_meses_gracia = isnull(@w_meses_gracia,
                               0)

    if @w_meses_gracia <> 0
      select
        @w_fecha_gracia = dateadd(month,
                                  @w_meses_gracia * -1,
                                  @i_fecha)
    else
      select
        @w_fecha_gracia = @i_fecha

    if @w_fecha_aper >= @w_fecha_gracia
    begin
      select
        @w_comision = 0
      goto NoCalculaComision
    end

    /*******FIN: PEDRO COELLO VERIFICA SI LA CUENTA TIENE MESES DE GRACIA PARA NO SOBRAR COMISION POR SALDO MINIMO *****/

    CalculaComision:

    select
      @w_comision = 0

    if @w_personalizada = 'N'
    begin
      select
        @w_tipo_atributo = tipo_atributo
      from   tempdb..pe_tipo_atributo
      where  filial       = @w_filial
         and sucursal     = @w_sucursal
         and producto     = 4
         and moneda       = @w_moneda
         and pro_bancario = @w_prod_banc
         and tipo_cta     = @w_tipocta
         and servicio     = 'CSLM'
         and rubro        = '60'

      if @@rowcount <> 1
      begin
        /* Grabar en la tabla de errores */
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,
                'ERROR AL BUSCAR EL TIPO DE ATRIBUTO CUANDO RUBRO = 60'
        )

        if @@error <> 0
        begin
        /* Error en grabacion de archivo de errores */
          /* Cerrar y liberar cursor */
          close com_smin
          deallocate com_smin
          return 203028
        end
        goto LEER
      end

      if @w_tipo_atributo = 'B' /* Saldo promedio */
        select
          @w_monto = @w_promedio1
      else if @w_tipo_atributo = 'C' /* Saldo Contable */
        select
          @w_monto = @w_contable
      else if @w_tipo_atributo = 'A' /* Saldo Disponible */
        select
          @w_monto = @w_disponible
      else if @w_tipo_atributo = 'E' /* Promedio Disponible */
        select
          @w_monto = @w_prom_disponible
      else if @w_tipo_atributo = 'D' /* Saldo minimo mensual disponible*/
        select
          @w_monto = @w_saldo_min
      else
        select
          @w_monto = $1

      select
        @w_comision = valor
      from   tempdb..cslm4
      where  tipo_ente     = @w_tipocta
         and pro_bancario  = @w_prod_banc
         and filial        = @w_filial
         and sucursal      = @w_sucursal
         and producto      = 4
         and moneda        = @w_moneda
         and categoria     = @w_categoria
         and servicio_dis  = 'CSLM'
         and rubro         = '60'
         and tipo_atributo = @w_tipo_atributo
         and rango_desde   <= @w_monto
         and rango_hasta   > @w_monto

      if @@rowcount <> 1
      begin
        /* Grabar en la tabla de errores */
        insert cob_ahorros..re_error_batch
        values (@w_cta_banco,
                'ERROR EN TABLA CSLM4 DE PERSONALIZACION CUANDO RUBRO = 60')

        if @@error <> 0
        begin
        /* Error en grabacion de archivo de errores */
          /* Cerrar y liberar cursor */
          close com_smin
          deallocate com_smin
          return 203028
        end
        goto LEER
      end
    end
    else
    begin
      /* Llamada al stored procedure que calcula el valor a debitar */
      exec @w_return = cob_remesas..sp_genera_costos
        @t_debug       = 'N',
        @t_file        = null,
        @t_from        = @w_sp_name,
        @t_trn         = 0,
        @i_filial      = @w_filial,
        @i_oficina     = @w_oficina,
        @i_categoria   = @w_categoria,
        @i_tipo_ente   = @w_tipocta,
        @i_rol_ente    = @w_rol_ente,
        @i_tipo_def    = @w_tipo_def,
        @i_prod_banc   = @w_prod_banc,
        @i_producto    = @w_producto,
        @i_moneda      = @w_moneda,
        @i_tipo        = @w_tipo,
        @i_codigo      = @w_default,
        @i_servicio    = 'CSLM',
        @i_rubro       = '60',
        @i_disponible  = @w_disponible,
        @i_contable    = @w_contable,
        @i_promedio    = @w_promedio1,
        @i_prom_disp   = @w_prom_disponible,
        @i_min_dispmes = @w_saldo_min,
        @i_valor       = 1,
        @i_personaliza = @w_personalizada,
        @i_fecha       = @i_fecha,
        @i_is_batch    = 'S',
        @o_valor_total = @w_comision output

      if @w_return <> 0
      begin
        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = @w_return

        select
          @w_mensaje = isnull(@w_mensaje,
          'OCURRIO UN PROBLEMA AL INSERTAR MENSAJE DE ERROR DEL BATCH'
                                      )

        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,@w_mensaje)

        if @@error <> 0
        begin
        /* Error en grabacion de archivo de errores */
          /* Cerrar y liberar cursor */
          close com_smin
          deallocate com_smin
          return 203028
        end

        goto LEER
      end
    end

    NoCalculaComision:

    -- Causa para nota de debito de cuentas normales
    select
      @w_causa = '58'

    if @w_estado = 'I'
      if @w_disponible > 0
         and @w_comision > @w_disponible
        select
          @w_comision = @w_disponible
      else if @w_disponible <= 0
        select
          @w_comision = 0

    /*  Control para N/D con valor Cero  */
    if @w_comision > 0
    begin
      begin tran
      /* Llamada al stored procedure que emite la nota de debito  */
      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv         = @i_srv,
        @s_ofi         = @w_oficina,
        @s_ssn         = @w_ssn,
        @s_date        = @i_fecha,
        @t_trn         = 264,
        @i_cta         = @w_cta_banco,
        @i_val         = @w_comision,
        @i_cau         = @w_causa,
        @i_mon         = @w_moneda,
        @i_fecha       = @i_fecha,
        @i_inmovi      = 'S',
        @i_imprime_ndc = 'S'

      if @w_return <> 0
      begin
        rollback tran
        print 'Procesando 3...'
        select
          @w_mensaje = mensaje
        from   cobis..cl_errores
        where  numero = @w_return

        select
          @w_mensaje = isnull(@w_mensaje,
          'OCURRIO UN PROBLEMA AL INSERTAR MENSAJE DE ERROR DEL BATCH'
                                      )

        insert into cob_ahorros..re_error_batch
        values      (@w_cta_banco,@w_mensaje)

        if @@error <> 0
        begin
        /* Error en grabacion de archivo de errores */
          /* Cerrar y liberar cursor */
          close com_smin
          deallocate com_smin
          return 203028
        end
        goto LEER
      end

      select
        @w_ssn = @w_ssn + 1,
        @o_procesadas = @o_procesadas + 1

      commit tran
    end

    LEER:
    fetch com_smin into @w_ctacte,
                        @w_cta_banco,
                        @w_filial,
                        @w_oficina,
                        @w_producto,
                        @w_moneda,
                        @w_tipo,
                        @w_tipocta,
                        @w_disponible,
                        @w_12h,
                        @w_24h,
                        @w_remesas,
                        @w_promedio1,
                        @w_prom_disponible,
                        @w_personalizada,
                        @w_default,
                        @w_tipo_def,
                        @w_rol_ente,
                        @w_contable,
                        @w_categoria,
                        @w_prod_banc,
                        @w_estado,
                        @w_saldo_min,
                        @w_fecha_aper

    if @@fetch_status = -1
    begin
      close com_smin
      deallocate com_smin
      exec cobis..sp_cerror
        @i_num = 201151
      return 201151
    end
  end

  close com_smin
  deallocate com_smin

  return 0

go

