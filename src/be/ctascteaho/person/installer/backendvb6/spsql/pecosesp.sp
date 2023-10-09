/****************************************************************************/
/*      Archivo         : pecosesp.sp                                       */
/*      Store Procedure : sp_costos_especiales                              */
/*      Base de Datos   : cob_remesas                                       */
/*      Producto        : XXXXXXXXXXXXXXX                                   */
/*      Disenado por    : Carlos Leon                                       */
/*      Fecha de escritura : 23/Nov/2005                                    */
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
/*       actualizacion y consulta de costos especiales generales            */
/****************************************************************************/
/*                             MODIFICACIONES                               */
/*   FECHA              AUTOR           RAZON                               */
/* 23/Nov/2005      Carlos Leon     Emision inicial                         */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_costos_especiales')
  drop proc sp_costos_especiales
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_costos_especiales
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
  @i_tipo_rango     smallint=null,
  @i_codigo         smallint = null,
  @i_rubro          catalogo = null,
  @i_descripcion    descripcion = null,
  @i_tipo_dato      char(1) = null,
  @i_tipo           char(1) = null,
  @i_grupo_rango    smallint = null,
  @i_rango          tinyint = null,
  @i_val_minimo     money = null,
  @i_val_base       money = null,
  @i_val_maximo     money = null,
  @i_fecha_vigencia smalldatetime = null,
  @i_fecha_mod      smalldatetime = null,
  @i_formato_fecha  tinyint = 101
)
as
  declare
    @w_servicio   int,
    @w_return     int,
    @w_sp_name    varchar(32),
    @w_secuencial int,
    @w_clave      int,
    @w_vigente    char(1)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_costos_especiales'

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
      i_val_base = @i_val_base,
      i_val_maximo = @i_val_maximo,
      i_fecha_vigencia = @i_fecha_vigencia

    exec cobis..sp_end_debug
  end

  if @i_operacion = 'I'
  begin
    if @t_trn != 4087
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if exists (select
                 1
               from   pe_servicio_dis
               where  sd_servicio_dis = @i_codigo
                  and sd_estado       = 'N')
    begin
      /* El servicio esta fuera de vigencia                 */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351519
      return 351519
    end

    if exists (select
                 1
               from   pe_costo_especial
               where  ce_servicio_dis = @i_codigo
                  and ce_rubro        = @i_rubro
                  and ce_tipo_rango   = @i_tipo_rango
                  and ce_grupo_rango  = @i_grupo_rango
                  and ce_rango        = @i_rango)
    begin
      /* Ya existe servicio asociado a este rubro           */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351503
      return 351503
    end

    /* Inicio de Transaccion */
    begin tran

    insert into pe_costo_especial
                (ce_servicio_dis,ce_rubro,ce_descripcion,ce_tipo_dato,
                 ce_tipo_rango,
                 ce_grupo_rango,ce_rango,ce_minimo,ce_base,ce_maximo,
                 ce_fecha_ing,ce_fecha_vigencia,ce_aprobado,ce_en_linea)
    values      (@i_codigo,@i_rubro,@i_descripcion,@i_tipo_dato,@i_tipo_rango,
                 @i_grupo_rango,@i_rango,@i_val_minimo,@i_val_base,@i_val_maximo
                 ,
                 @s_date,@i_fecha_vigencia,'N','N')

    if @@error != 0
    begin
      /* Error en insercion de detalle de servicio   */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353501
      return 353501
    end

    /* Incrementa en uno el contador de rubros */
    update pe_servicio_dis
    set    sd_num_rubro = sd_num_rubro + 1
    where  sd_servicio_dis = @i_codigo

    if @@error != 0
    begin
      /* Error en creacion de registros en detalle servicio   */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355501
      return 355501
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_fecha,ts_secuencial,ts_tipo_transaccion,ts_oficina,
                 ts_usuario,
                 ts_terminal,ts_reentry,ts_servicio_per,ts_categoria,
                 ts_tipo_rango
                 ,
                 ts_grupo_rango,ts_minimo,ts_val_medio,ts_maximo,
                 ts_fecha_vigencia)
    values      (@s_date,@s_ssn,@t_trn,@s_ofi,@s_user,
                 @s_term,'N',@i_codigo,@i_rubro,@i_tipo_rango,
                 @i_grupo_rango,@i_val_minimo,@i_val_base,@i_val_maximo,getdate(
                 ))

    /*Ocurrio un error en la insercion*/
    if @@error != 0
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

  end

  if @i_operacion = 'U'
  begin
    if @t_trn != 4088
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    /* Inicio de Transaccion */
    begin tran

    if exists (select
                 1
               from   cob_remesas..pe_costo_especial
               where  ce_servicio_dis = @i_codigo
                  and ce_rubro        = @i_rubro
                  and ce_tipo_rango   = @i_tipo_rango
                  and ce_grupo_rango  = @i_grupo_rango
                  and ce_rango        = @i_rango
                  and ce_en_linea     = 'N')
    begin
      update pe_costo_especial
      set    ce_descripcion = @i_descripcion,
             ce_tipo_dato = @i_tipo_dato,
             ce_minimo = @i_val_minimo,
             ce_base = @i_val_base,
             ce_maximo = @i_val_maximo,
             ce_aprobado = 'N',
             ce_fecha_aprob = null,
             ce_fecha_vigencia = @i_fecha_vigencia,
             ce_fecha_mod = @s_date
      where  ce_servicio_dis = @i_codigo
         and ce_rubro        = @i_rubro
         and ce_tipo_rango   = @i_tipo_rango
         and ce_grupo_rango  = @i_grupo_rango
         and ce_rango        = @i_rango
         and ce_en_linea     = 'N'

      if @@rowcount != 1
      begin
        /* Error en actualizacion de detalle servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355500
        return 355500
      end

      /* Transaccion de Servicio */

      insert into pe_tran_servicio
                  (ts_fecha,ts_secuencial,ts_tipo_transaccion,ts_oficina,
                   ts_usuario,
                   ts_terminal,ts_reentry,ts_servicio_per,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_grupo_rango,ts_minimo,ts_val_medio,ts_maximo,
                   ts_fecha_vigencia)
      values      (@s_date,@s_ssn,@t_trn,@s_ofi,@s_user,
                   @s_term,'N',@i_codigo,@i_rubro,@i_tipo_rango,
                   @i_grupo_rango,@i_val_minimo,@i_val_base,@i_val_maximo,
                   @i_fecha_vigencia)

      /*Ocurrio un error en la insercion*/
      if @@error != 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end

    end
    else
    begin
      insert into pe_costo_especial
                  (ce_servicio_dis,ce_rubro,ce_descripcion,ce_tipo_dato,
                   ce_tipo_rango,
                   ce_grupo_rango,ce_rango,ce_minimo,ce_base,ce_maximo,
                   ce_fecha_ing,ce_fecha_vigencia,ce_aprobado,ce_en_linea)
      values      (@i_codigo,@i_rubro,@i_descripcion,@i_tipo_dato,@i_tipo_rango,
                   @i_grupo_rango,@i_rango,@i_val_minimo,@i_val_base,
                   @i_val_maximo
                   ,
                   @s_date,@i_fecha_vigencia,'N','N')

      if @@error != 0
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
                  (ts_fecha,ts_secuencial,ts_tipo_transaccion,ts_oficina,
                   ts_usuario,
                   ts_terminal,ts_reentry,ts_servicio_per,ts_categoria,
                   ts_tipo_rango
                   ,
                   ts_grupo_rango,ts_minimo,ts_val_medio,ts_maximo,
                   ts_fecha_vigencia)
      values      (@s_date,@s_ssn,@t_trn,@s_ofi,@s_user,
                   @s_term,'N',@i_codigo,@i_rubro,@i_tipo_rango,
                   @i_grupo_rango,@i_val_minimo,@i_val_base,@i_val_maximo,
                   getdate(
                   ))

      /*Ocurrio un error en la insercion*/
      if @@error != 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end

    end

    commit tran

  end

  /* Consulta sin tipo dato*/
  if @i_operacion = 'S'
  begin
    if @t_trn != 4086
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
      '1365' = convert(char(10), ce_fecha_vigencia, @i_formato_fecha), --FECHA VIGENCIA
      '1333' = case
                   when ce_en_linea = 'S' then 'VIGENTE'
                   else 'INGRESADO'
               end,                                                    --ESTADO
      '1097' = case
                   when ce_aprobado = 'S' then 'APROBADO'
                   else 'PENDIENTE'
               end,                                                    --CONFIRMACION
      '1689' = substring(ce_rubro, 1, 6),                              --RUBRO
      '1742' = substring(ce_tipo_dato, 1, 6),                          --TIPO
      '1198' = substring(ce_descripcion, 1, 40),                       --DESCRIPCION DEL DETALLE
      '1213' = ra_desde,                                               --DESDE
      '1398' = ra_hasta,                                               --HASTA
      '1807' = ce_minimo,                                              --VALOR MINIMO
      '1798' = ce_base,                                                --VALOR BASE
      '1806' = ce_maximo,                                              --VALOR MAXIMO
      '1202' = substring(valor, 1, 40),                                --DESCRIPCION DE RUBRO
      '1759' = ce_tipo_rango,                                          --TIPO RANGO
      '1383' = ce_grupo_rango,                                         --GRUPO RANGO
      '1678' = ce_rango
    from   cobis..cl_catalogo,
           pe_costo_especial,
           pe_rango
    where  ce_servicio_dis = @i_codigo
       and ce_rubro        = @i_rubro
       and ce_rubro        = codigo
       and tabla           = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla = 'pe_rubro')
       and ce_tipo_rango   = ra_tipo_rango
       and ce_grupo_rango  = ra_grupo_rango
       and ce_rango        = ra_rango

  end

  /* Consulta con tipo dato*/
  if @i_operacion = 'C'
  begin
    if @t_trn != 4086
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
      '1365' = convert(char(10), ce_fecha_vigencia, @i_formato_fecha), --FECHA VIGENCIA
      /* 'ESTADO'        = case when ce_en_linea = 'S' then 'VIGENTE'
                       else 'INGRESADO' end,
      'CONFIRMACION'     = case when ce_aprobado = 'S' then 'APROBADO'
                       else 'PENDIENTE' end, */
      '1689' = substring(ce_rubro, 1, 6),                              --RUBRO
      '1742' = substring(ce_tipo_dato, 1, 6),                          --TIPO
      --'DESCRIPCION DEL DETALLE'  = substring(ce_descripcion,1,40),
      '1213' = ra_desde,                                               --DESDE
      '1398' = ra_hasta,                                               --HASTA
      '1807' = ce_minimo,                                              --VALOR MINIMO
      '1798' = ce_base,                                                --VALOR BASE
      '1806' = ce_maximo,                                              --VALOR MAXIMO
      '1202' = substring(valor, 1, 40),                                --DESCRIPCION DE RUBRO
      '1759' = ce_tipo_rango,                                          --TIPO RANGO
      '1383' = ce_grupo_rango,                                         --GRUPO RANGO
      '1678' = ce_rango                                                --RANGO
    from   cobis..cl_catalogo,
           pe_costo_especial,
           pe_rango
    where  ce_servicio_dis = @i_codigo
       and ce_rubro        = @i_rubro
       and ce_rubro        = codigo
       and tabla           = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla = 'pe_rubro')
       and ce_en_linea     = 'S'
       and ce_tipo_rango   = ra_tipo_rango
       and ce_grupo_rango  = ra_grupo_rango
       and ce_rango        = ra_rango

  end

  /* Help */
  if @i_operacion = 'H'
  begin
    if @i_tipo = 'A'
    begin
      set rowcount 15
      select
        '1093' = tr_tipo_rango,                   --CODIGO
        '1896' = substring(tr_descripcion, 1, 35) --DESCRIPCION
      from   pe_tipo_rango
      where  tr_tipo_rango > @i_codigo
      order  by tr_tipo_rango
      set rowcount 0
    end
    if @i_tipo = 'V'
    begin
      select
        tr_descripcion
      from   pe_tipo_rango
      where  tr_tipo_rango = @i_codigo
      if @@rowcount = 0
      begin
        /*No existe tipo de rango */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351526
        return 351526
      end
    end

  end

  return 0

GO 
