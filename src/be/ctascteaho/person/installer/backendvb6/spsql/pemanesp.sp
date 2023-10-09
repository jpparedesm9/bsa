/****************************************************************************/
/*      Archivo         : pemanesp.sp                                       */
/*      Store Procedure : sp_mant_especiales                                */
/*      Base de Datos   : cob_remesas                                       */
/*      Producto        : Personalizacion                                   */
/*      Disenado por    : Carlos Leon                                       */
/*      Fecha de escritura : 13/Dic/2005                                    */
/****************************************************************************/
/*                          IMPORTANTE                                      */
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
/*                              PROPOSITO                                   */
/*       Este programa realiza la aprobacion o eliminacion de costos        */
/*       especiales generales y personalizados                              */
/****************************************************************************/
/*                             MODIFICACIONES                               */
/*   FECHA              AUTOR           RAZON                               */
/* 13/Dic/2005      Carlos Leon     Emision inicial                         */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ansi_nulls off
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_mant_especiales')
  drop proc sp_mant_especiales
go
create proc sp_mant_especiales
(
  @s_ssn            int,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_user           varchar(30) = null,
  @s_sesn           int,
  @s_term           varchar(10),
  @s_date           datetime,
  @s_org            char(1),
  @s_ofi            smallint,
  @s_rol            smallint,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            mensaje = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           varchar(32) = null,
  @t_rty            char(1) = 'N',
  @t_trn            smallint,
  @t_show_version   bit = 0,
  @i_operacion      char(2) = null,
  @i_tipo_rango     tinyint =null,
  @i_codigo         smallint = null,
  @i_rubro          catalogo = null,
  @i_descripcion    descripcion = null,
  @i_tipo_dato      char(1) = null,
  @i_tipo           char(1) = null,
  @i_grupo_rango    smallint = null,
  @i_rango          tinyint = null,
  @i_tipo_costo     char(1) = null,
  @i_tipo_per       char(1) = null,
  @i_val_minimo     money = null,
  @i_valor_per      money = null,
  @i_val_maximo     money = null,
  @i_fecha_vigencia smalldatetime = null,
  @i_fecha_mod      smalldatetime = null,
  @i_cuenta         cuenta = null,
  @i_cliente        int = null,
  @i_oficina        smallint = null,
  @i_producto       tinyint = null,
  @i_formato_fecha  tinyint = 101,
  @i_aprobado       char(1) = null,
  @i_secuencial     int = null,
  @i_person         char(1) = null
)
as
  declare
    @w_servicio   int,
    @w_return     int,
    @w_sp_name    varchar(32),
    @w_sec_costo  int,
    @w_tipo_costo char(1)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_mant_especiales'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo Debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Store Procedure **/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      i_operacion = @i_operacion,
      i_codigo = @i_codigo,
      i_rubro = @i_rubro,
      i_descripcion = @i_descripcion,
      i_tipo_dato = @i_tipo_dato,
      i_tipo = @i_tipo,
      i_grupo_rango = @i_grupo_rango,
      i_rango = @i_rango,
      i_val_minimo = @i_val_minimo,
      i_val_maximo = @i_val_maximo,
      i_fecha_vigencia = @i_fecha_vigencia,
      i_tipo_costo = @i_tipo_costo,
      i_tipo_per = @i_tipo_per,
      i_valor_per = @i_valor_per,
      i_fecha_mod = @i_fecha_mod,
      i_cuenta = @i_cuenta,
      i_cliente = @i_cliente,
      i_oficina = @i_oficina,
      i_producto = @i_producto,
      i_secuencial = @i_secuencial,
      i_person = @i_person

    exec cobis..sp_end_debug
  end

  if @i_operacion = 'U'
  begin
    if @t_trn <> 4092
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    begin tran

    if @i_person = 'G'
    begin
      if @i_aprobado = 'S'
      begin
        update pe_costo_especial
        set    ce_aprobado = @i_aprobado,
               ce_fecha_aprob = getdate()
        where  ce_servicio_dis = @i_codigo
           and ce_rubro        = @i_rubro
           and ce_tipo_dato    = @i_tipo_dato
           and ce_tipo_rango   = @i_tipo_rango
           and ce_grupo_rango  = @i_grupo_rango
           and ce_rango        = @i_rango
           and ce_en_linea     = 'N'

        if @@rowcount <> 1
        begin
          /* Error en actualizacion de costo especial */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 355507
          return 355507
        end

      end
      else -- Eliminacion de costos incorrectos
      begin
        delete pe_costo_especial
        where  ce_servicio_dis = @i_codigo
           and ce_rubro        = @i_rubro
           and ce_tipo_dato    = @i_tipo_dato
           and ce_tipo_rango   = @i_tipo_rango
           and ce_grupo_rango  = @i_grupo_rango
           and ce_rango        = @i_rango
           and ce_en_linea     = 'N'

        if @@rowcount <> 1
        begin
          /* Error en eliminacion de costo especial */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357505
          return 357505
        end
      end
    end
    else
    begin -- Eliminacion de costos personalizados
      begin
        delete pe_costo_especial_per
        where  cp_secuencial = @i_secuencial

        if @@rowcount <> 1
        begin
          /* Error en eliminacion de costo especial */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357505
          return 357505
        end
      end
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_fecha,ts_secuencial,ts_tipo_transaccion,ts_usuario,
                 ts_tipo_default,
                 ts_rol,ts_terminal,ts_reentry,ts_servicio_per,ts_tipo_rango,
                 ts_grupo_rango,ts_rango,ts_minimo,ts_val_medio,ts_maximo,
                 ts_fecha_vigencia,ts_fecha_cambio,ts_cuenta,ts_codigo,
                 ts_oficina,
                 ts_producto,ts_tipo,ts_cod_alterno)
    values      (@s_date,@s_ssn,@t_trn,@s_user,@i_tipo_costo,
                 @i_tipo_per,@s_term,'N',@i_codigo,@i_tipo_rango,
                 @i_grupo_rango,@i_rango,@i_val_minimo,@i_valor_per,
                 @i_val_maximo,
                 @i_fecha_vigencia,getdate(),@i_cuenta,@i_cliente,@i_oficina,
                 @i_producto,@i_aprobado,@i_secuencial)

    /*Ocurrio un error en la insercion*/
    if @@error <> 0
    begin
      /*Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      return 353515
    end

    commit tran
    return 0

  end

  /* Consulta de costos especiales personalizados */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 4091
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      '1365' = convert(char(10), cp_fecha_vigencia, @i_formato_fecha),  --FECHA VIGENCIA
      '1747' = case
                       when cp_tipo_costo = 'F' then 'VALOR FIJO'
                       when cp_tipo_costo = 'V' then 'VALOR VARIABLE'
                       else 'VALOR EXONERADO'
                     end, --TIPO COSTO
      '1689' = substring(cp_rubro,
                          1,
                          6), --RUBRO
      '1197' = substring(valor,
                                         1,
                                         40), --DESCRIPCION DE RUBRO
      '1742' = substring(cp_tipo_dato,
                         1,
                         6),  --TIPO
      '1213' = ra_desde,      --DESDE
      '1398' = ra_hasta,      --HASTA
      '1812' = cp_valor_per,  --VALOR PERSONALIZADO
      '1807' = cp_minimo,     --VALOR MINIMO
      '1806' = cp_maximo,     --VALOR MAXIMO
      '1018' = case
                       when cp_tipo_aplic = 'N' then 'NACIONAL'
                       when cp_tipo_aplic = 'O' then 'OFICINA'
                       else ''
                     end,       --APLICACION
      '1213' = cp_tipo_rango,   --TIPO RANGO
      '1383' = cp_grupo_rango,  --GRUPO RANGO
      '1678' = cp_rango,        --RANGO
      '1753' = cp_tipo_per,     --TIPO PER
      '1702' = cp_secuencial,   --SEC
      '1706' = cp_servicio_dis, --SERV. DISP
      '1646.' = cp_producto     --PROD
    from   pe_costo_especial_per
           left outer join cobis..cl_catalogo
                        on cp_rubro = codigo
           left outer join pe_rango
                        on cp_tipo_rango = ra_tipo_rango
                           and cp_grupo_rango = ra_grupo_rango
                           and cp_rango = ra_rango
    where  cp_servicio_dis   = @i_codigo
       and cp_fecha_vigencia >= @i_fecha_vigencia
       and cp_rubro          = @i_rubro
       and tabla             = (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'pe_rubro')
       and cp_cuenta         = @i_cuenta
       and cp_oficina        = @i_oficina
       and cp_cliente        = @i_cliente
  end

  /* Consulta de costos generales*/
  if @i_operacion = 'C'
  begin
    if @t_trn <> 4091
    begin
      /*Error en codigo de transaccion*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      '1365' = convert(char(10), ce_fecha_vigencia, @i_formato_fecha),  --FECHA VIGENCIA
      '1333' = case
                   when ce_en_linea = 'S' then 'VIGENTE'
                   else 'INGRESADO'
                 end,  --ESTADO
      '1097' = case
                         when ce_aprobado = 'S' then 'APROBADO'
                         else 'PENDIENTE'
                       end,  --CONFIRMACION
      '1689' = substring(ce_rubro,
                          1,
                          6),      --RUBRO
      --'DESCRIPCION DE RUBRO'     = substring(valor,1,40),
      '1213' = ra_desde,           --DESDE
      '1398' = ra_hasta,           --HASTA
      '1798' = ce_base,            --VALOR BASE
      '1807' = ce_minimo,          --VALOR MINIMO
      '1806' = ce_maximo,          --VALOR MAXIMO
      '1742' = substring(ce_tipo_dato,
                         1,
                         6),       --TIPO
      '1198' = substring(ce_descripcion,
                                            1,
                                            40),                     --DESCRIPCION DEL DETALLE
      '1885' = convert(char(10), ce_fecha_aprob, @i_formato_fecha),  --FECHA APROBACION
      '1759' = ce_tipo_rango,  --TIPO RANGO
      '1383' = ce_grupo_rango, --GRUPO RANGO
      '1678' = ce_rango,       --RANGO
      '1884' = ce_servicio_dis --SERV. DISP.
    from   cobis..cl_catalogo,
           pe_costo_especial,
           pe_rango
    where  ce_servicio_dis   = @i_codigo
       and ce_rubro          = codigo
       and tabla             = (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'pe_rubro')
       and ce_rubro          = @i_rubro
       and ce_fecha_vigencia >= @i_fecha_vigencia
       and ce_tipo_rango     = ra_tipo_rango
       and ce_grupo_rango    = ra_grupo_rango
       and ce_rango          = ra_rango
    order  by ce_fecha_vigencia,
              ce_rango

  end

  return 0

GO 
