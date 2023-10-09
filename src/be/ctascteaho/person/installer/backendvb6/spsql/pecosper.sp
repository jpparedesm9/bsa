/****************************************************************************/
/*      Archivo         : pecosper.sp                                       */
/*      Store Procedure : sp_costos_especiales_per                          */
/*      Base de Datos   : cob_remesas                                       */
/*      Producto        : Personalizacion                                   */
/*      Disenado por    : Carlos Leon                                       */
/*      Fecha de escritura : 28/Nov/2005                                    */
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
/*       Este programa realiza la transaccion que permite el ingreso        */
/*       y consulta de costos especiales personalizados                     */
/****************************************************************************/
/*                             MODIFICACIONES                               */
/*   FECHA              AUTOR           RAZON                               */
/* 28/Nov/2005      Carlos Leon     Emision inicial                         */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ansi_nulls off
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_costos_especiales_per')
  drop proc sp_costos_especiales_per
go
create proc sp_costos_especiales_per
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
  @i_tipo_dato      char(1) = 'N',
  @i_tipo           char(1) = null,
  @i_grupo_rango    smallint = null,
  @i_rango          tinyint = null,
  @i_tipo_costo     char(1) = null,
  @i_tipo_per       char(1) = null,
  @i_val_minimo     money = null,
  @i_valor_per      money = null,
  @i_val_maximo     money = null,
  @i_tipo_aplic     char(1) = null,
  @i_fecha_vigencia smalldatetime = null,
  @i_fecha_mod      smalldatetime = null,
  @i_cuenta         cuenta = null,
  @i_cliente        int = null,
  @i_oficina        smallint = null,
  @i_producto       tinyint = null,
  @i_formato_fecha  tinyint = 101
)
as
  declare
    @w_servicio   int,
    @w_return     int,
    @w_sp_name    varchar(32),
    @w_secuencial int,
    @w_clave      int,
    @w_sec_costo  int,
    @w_tipo_costo char(1)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_costos_especiales_per'

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
      i_producto = @i_producto

    exec cobis..sp_end_debug
  end

  if @i_operacion = 'I'
  begin
    if @t_trn <> 4090
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    -- Determinar el secuencial para el costo
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_costo_especial_per',
      @o_siguiente = @w_sec_costo out

    if @i_val_minimo = -99
    begin
      select
        @i_val_minimo = null
      select
        @i_val_maximo = null
    end

    begin tran

    if exists (select
                 1
               from   pe_costo_especial_per
               where  cp_tipo_costo   = @i_tipo_costo
                  and cp_tipo_per     = @i_tipo_per
                  and cp_servicio_dis = @i_codigo
                  and cp_rubro        = @i_rubro
                  and cp_tipo_rango   = @i_tipo_rango
                  and cp_grupo_rango  = @i_grupo_rango
                  and cp_rango        = @i_rango
                  and cp_cuenta       = @i_cuenta
                  and cp_cliente      = @i_cliente
                  and cp_oficina      = @i_oficina)
    begin
      delete pe_costo_especial_per
      where  cp_tipo_costo   = @i_tipo_costo
         and cp_tipo_per     = @i_tipo_per
         and cp_servicio_dis = @i_codigo
         and cp_tipo_rango   = @i_tipo_rango
         and cp_grupo_rango  = @i_grupo_rango
         and cp_rango        = @i_rango
         and cp_cuenta       = @i_cuenta
         and cp_cliente      = @i_cliente
         and cp_oficina      = @i_oficina
         and cp_oficina      = @i_oficina

      if @@error <> 0
      begin
        /* Error al actualizar */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353501
        return 355509
      end
    end

    if exists (select
                 1
               from   pe_costo_especial_per
               where  cp_tipo_costo <> @i_tipo_costo
                  and cp_cuenta     = @i_cuenta
                  and cp_cliente    = @i_cliente
                  and cp_oficina    = @i_oficina)
    begin
      delete pe_costo_especial_per
      where  cp_tipo_costo <> @i_tipo_costo
         and cp_cuenta     = @i_cuenta
         and cp_cliente    = @i_cliente
         and cp_oficina    = @i_oficina

      if @@error <> 0
      begin
        /* Error al actualizar */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355509
        return 355509
      end
    end

    insert into pe_costo_especial_per
                (cp_secuencial,cp_tipo_costo,cp_tipo_per,cp_servicio_dis,
                 cp_rubro,
                 cp_tipo_dato,cp_tipo_rango,cp_grupo_rango,cp_rango,cp_cuenta,
                 cp_cliente,cp_oficina,cp_producto,cp_valor_per,cp_minimo,
                 cp_maximo,cp_tipo_aplic,cp_fecha_ing,cp_fecha_vigencia,
                 cp_en_linea)
    values      (@w_sec_costo,@i_tipo_costo,@i_tipo_per,@i_codigo,@i_rubro,
                 @i_tipo_dato,@i_tipo_rango,@i_grupo_rango,@i_rango,@i_cuenta,
                 @i_cliente,@i_oficina,@i_producto,@i_valor_per,@i_val_minimo,
                 @i_val_maximo,@i_tipo_aplic,@s_date,@i_fecha_vigencia,'S')

    if @@error <> 0
    begin
      /* Error en insercion de detalle de servicio   */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353501
      return 353501
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_fecha,ts_secuencial,ts_tipo_transaccion,ts_usuario,
                 ts_tipo_default,
                 ts_rol,ts_terminal,ts_reentry,ts_servicio_per,ts_tipo_rango,
                 ts_grupo_rango,ts_rango,ts_minimo,ts_val_medio,ts_maximo,
                 ts_fecha_vigencia,ts_fecha_cambio,ts_cuenta,ts_codigo,
                 ts_oficina,
                 ts_producto)
    values      (@s_date,@s_ssn,@t_trn,@s_user,@i_tipo_costo,
                 @i_tipo_per,@s_term,'N',@i_codigo,@i_tipo_rango,
                 @i_grupo_rango,@i_rango,@i_val_minimo,@i_valor_per,
                 @i_val_maximo,
                 @i_fecha_vigencia,getdate(),@i_cuenta,@i_cliente,@i_oficina,
                 @i_producto )

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

  /* Consulta */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 4089
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
      '1365' = convert(char(10), cp_fecha_vigencia, @i_formato_fecha), --FECHA VIGENCIA
      '1747' = case
                       when cp_tipo_costo = 'F' then 'VALOR FIJO'
                       when cp_tipo_costo = 'V' then 'VALOR VARIABLE'
                       else 'VALOR EXONERADO'
                     end,                                              --TIPO COSTO
      '1742' = substring(cp_tipo_dato, 1, 6),                          --TIPO
      '1213' = ra_desde,                                               --DESDE
      '1398' = ra_hasta,                                               --HASTA
      '1812' = cp_valor_per,                                           --VALOR PERSONALIZADO
      '1807' = cp_minimo,                                              --VALOR MINIMO
      '1806' = cp_maximo,                                              --VALOR MAXIMO
      '1689' = substring(cp_rubro, 1, 6),                              --RUBRO
      '1202' = substring(valor, 1, 40),                                --DESCRIPCION DE RUBRO
      '1018' = case
                       when cp_tipo_aplic = 'N' then 'NACIONAL'
                       when cp_tipo_aplic = 'O' then 'OFICINA'
                       else ''
                     end                                               --APLICACION
    from   pe_costo_especial_per
           left outer join cobis..cl_catalogo
                        on cp_rubro = codigo
           left outer join pe_rango
                        on cp_tipo_rango = ra_tipo_rango
                           and cp_grupo_rango = ra_grupo_rango
                           and cp_rango = ra_rango
    where  cp_servicio_dis = @i_codigo
       and cp_rubro        = @i_rubro
       and cp_cuenta       = @i_cuenta
       and cp_oficina      = @i_oficina
       and cp_cliente      = @i_cliente
       and cp_tipo_costo   = @i_tipo_costo
       and cp_tipo_per     = @i_tipo_per
       and tabla           = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla = 'pe_rubro')

  end

  return 0

GO 
