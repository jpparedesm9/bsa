/****************************************************************************/
/*     Archivo:     pevalcon.sp                                             */
/*     Stored procedure: sp_contrato_servicios                              */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
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
/*     Este programa inserta y actualiza los valores contratados para un    */
/*     servicio.                                                            */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*       JUN/95       J.Gordillo     Personalizacion Bco. Produccion        */
/*  23/Ene/97     Juan F. Cadena Personalizacion Bco. de Prestamos          */
/*      30/Sep/2003     Gloria Rueda    Retornar c½digos de error          */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_contrato_servicios')
  drop proc sp_contrato_servicios

go
create proc sp_contrato_servicios
(
  @s_ssn            int = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_user           varchar(30) = null,
  @s_sesn           int,
  @s_term           varchar(10),
  @s_date           datetime,
  @s_org            char(1),
  @s_ofi            smallint,
  @s_rol            smallint,
  @s_org_err        char(1)= null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            mensaje = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           varchar(32) = null,
  @t_rty            char(1) = 'N',
  @t_trn            smallint= null,
  @t_show_version   bit = 0,
  @i_operacion      char(2) = null,
  @i_tipo_default   char(1) = null,
  @i_codigo         int = null,
  @i_rol            char(1) = null,
  @i_pro_final      smallint,
  @i_producto       tinyint = null,
  @i_moneda         tinyint,
  @i_categoria      catalogo = null,
  @i_servicio_per   smallint = 0,
  @i_tipo_rango     tinyint = null,
  @i_grupo_rango    smallint = null,
  @i_rango          tinyint = 0,
  @i_tipo_variacion char(1) = null,
  @i_valor_con      float = null,
  @i_servicio       smallint = 0,
  @i_rubro          catalogo = '',
  @i_formato_fecha  smallint = 101,
  @i_fecha_venc     datetime = null
)
as
  declare
    @w_sp_name      varchar(32),
    @w_today        datetime,
    @w_tipo_dato    char(1),
    @w_decimal      char(1),
    @w_no_decimal   tinyint,
    @w_operacion    char(1),
    @w_secuencial   int,
    @w_tipo_ente    char (1),
    @w_return       int,
    @w_fechamax     datetime,
    @w_servicio_per smallint,
    @w_estado       char(1)

  select
    @w_sp_name = 'sp_contrato_servicios',
    @w_today = convert(char(10), getdate(), 101),
    @w_decimal = 'N',
    @w_no_decimal = 0,
    @w_operacion = 'I'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from
    exec cobis..sp_end_debug
  end

  /*Validaciones*/

  if @i_tipo_default in ('P', 'C')
    select
      @w_tipo_ente = 'P'
  else if @i_tipo_default in ('E', 'G')
    select
      @w_tipo_ente = 'C'

  if @i_operacion = 'T'
  begin
    if @t_trn != 4068
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      @w_tipo_dato = vs_tipo_dato
    from   cob_remesas..pe_var_servicio,
           cob_remesas..pe_servicio_per
    where  sp_servicio_per = @i_servicio_per
       and vs_servicio_dis = sp_servicio_dis
       and vs_rubro        = sp_rubro

    if @i_tipo_variacion = 'M'
       and @w_tipo_dato = 'M'
    begin
      select
        @w_decimal = mo_decimales
      from   cobis..cl_moneda
      where  mo_moneda = @i_moneda

      if @w_decimal = 'S'
        select
          @w_no_decimal = pa_tinyint
        from   cobis..cl_parametro
        where  pa_nemonico = 'DCI'
    end
    else
      select
        @w_no_decimal = 2

    /**********[ Insercion de nuevas instancias de personalizacion ]*********/

    begin tran
    /* Secuencial para valor contratado */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = 'N',
      @t_file      = null,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_val_contratado',
      @o_siguiente = @w_secuencial out
    if @w_return != 0
    begin
      rollback tran
      return @w_return
    end

    /*** Inicio Cambio
     fecha: 07/05/2002, Ing. Elkin Pulido (Banco)
     Descripcion: Buscar rol ente segun producto ****/

    if @i_producto = 3
      select
        @w_tipo_ente = cc_rol_ente
      from   cob_cuentas..cc_ctacte
      where  cc_ctacte = @i_codigo
    else if @i_producto = 4
      select
        @w_tipo_ente = ah_rol_ente
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_codigo
    /** Fin Cambio **/

    select
      @w_estado = 'V'

    insert into pe_val_contratado
                (vc_secuencial,vc_tipo_default,vc_rol,vc_producto,vc_codigo,
                 vc_servicio_per,vc_categoria,vc_tipo_rango,vc_grupo_rango,
                 vc_rango,
                 vc_valor_con,vc_tipo_variacion,vc_fecha,vc_fecha_venc,vc_estado
    )
    values      (@w_secuencial,
                 --@i_tipo_default,@i_rol,@i_producto,
                 @i_tipo_default,@w_tipo_ente,@i_producto,
                 /*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/@i_codigo,
                 @i_servicio_per,@i_categoria,@i_tipo_rango,@i_grupo_rango,
                 @i_rango,
                 round(@i_valor_con,
                       @w_no_decimal),@i_tipo_variacion,@w_today,@i_fecha_venc,
                 @w_estado)
    if @@error != 0
    begin
      /* Error de insercion en valor contratado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353509
      rollback tran
      return 353509
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_cod_alterno,ts_tipo_default,ts_rol,ts_codigo,
                 ts_producto,ts_servicio_per,ts_categoria,ts_tipo_rango,
                 ts_grupo_rango,
                 ts_rango,ts_valor_con,ts_fecha,ts_tipo_variacion)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 'N',0,
                 --@i_tipo_default, @i_rol, @i_codigo, @i_producto,
                 @i_tipo_default,@w_tipo_ente,@i_codigo,
                 @i_producto,/*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/
                 @i_servicio_per,@i_categoria,@i_tipo_rango,@i_grupo_rango,
                 @i_rango,round(@i_valor_con,
                       @w_no_decimal),@w_today,@i_tipo_variacion)

    if @@error != 0
    begin
      /* Error de insercion en transaccion de servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      rollback tran
      return 353515
    end

    commit tran
  end

  /* Consulta de Servicios */

  if @i_operacion = 'D'
  begin
    if @t_trn != 4069
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if @i_servicio = 0
    begin
      select
        co_secuencial = max(co_secuencial),
        co_fecha_vigencia = max(co_fecha_vigencia),
        co_servicio_per,
        co_categoria,
        co_tipo_rango,
        co_grupo_rango,
        co_rango,
        sp_servicio_dis,
        sp_rubro
      into   #costo_servicio
      from   pe_costo,
             pe_servicio_per
      where  sp_pro_final    = @i_pro_final
         and sp_servicio_per = co_servicio_per
         and co_categoria    = @i_categoria
      group  by co_servicio_per,
                co_categoria,
                co_tipo_rango,
                co_grupo_rango,
                co_rango,
                sp_servicio_dis,
                sp_rubro

      set rowcount 50
      select
        '1189' = substring(vs_descripcion,
                                  1,
                                  35),
        '1710' = a.co_servicio_per,
        '1213' = ra_desde,
        '1759' = a.co_tipo_rango,
        '1398' = ra_hasta,
        '1381' = a.co_grupo_rango,
        '1116' = a.co_val_medio,
        '1678' = a.co_rango,
        '1749' = vs_tipo_dato
      from   pe_costo a,
             #costo_servicio b,
             pe_var_servicio,
             pe_rango
      where  vs_servicio_dis     = sp_servicio_dis
         and vs_rubro            = sp_rubro
         and a.co_secuencial     = b.co_secuencial
         and a.co_servicio_per   = b.co_servicio_per
         and a.co_categoria      = b.co_categoria
         and a.co_tipo_rango     = b.co_tipo_rango
         and a.co_grupo_rango    = b.co_grupo_rango
         and a.co_rango          = b.co_rango
         and a.co_fecha_vigencia = b.co_fecha_vigencia
         and ra_tipo_rango       = a.co_tipo_rango
         and ra_grupo_rango      = a.co_grupo_rango
         and ra_rango            = a.co_rango
         and ((a.co_servicio_per   = @i_servicio_per
               and a.co_rango          > @i_rango)
               or a.co_servicio_per   > @i_servicio_per)
      order  by a.co_servicio_per,
                a.co_tipo_rango,
                a.co_rango
    end
    else
    begin
      select
        @w_servicio_per = sp_servicio_per
      from   cob_remesas..pe_servicio_per
      where  sp_pro_final    = @i_pro_final
         and sp_servicio_dis = @i_servicio
         and sp_rubro        = @i_rubro

      select
        co_secuencial = max(co_secuencial),
        co_fecha_vigencia = max(co_fecha_vigencia),
        co_servicio_per,
        co_categoria,
        co_tipo_rango,
        co_grupo_rango,
        co_rango
      into   #servicio_per
      from   pe_costo
      where  co_servicio_per = @w_servicio_per
         and co_categoria    = @i_categoria
      group  by co_servicio_per,
                co_categoria,
                co_tipo_rango,
                co_grupo_rango,
                co_rango

      set rowcount 20
      select
        '1365'= convert(varchar(10), A.co_fecha_vigencia,
                          @i_formato_fecha
                          ),
        '1189' = substring(vs_descripcion,
                                  1,
                                  35),
        '1710' = A.co_servicio_per,
        '1213' = ra_desde,
        '1759' = A.co_tipo_rango,
        '1398' = ra_hasta,
        '1381' = A.co_grupo_rango,
        '1116' = A.co_val_medio,
        '1678' = A.co_rango,
        '1749' = vs_tipo_dato
      from   cob_remesas..pe_var_servicio,
             cob_remesas..pe_costo A,
             cob_remesas..pe_rango,
             #servicio_per B
      where  B.co_secuencial  = A.co_secuencial
         and A.co_tipo_rango  = ra_tipo_rango
         and A.co_grupo_rango = ra_grupo_rango
         and A.co_rango       = ra_rango
         and vs_servicio_dis  = @i_servicio
         and vs_rubro         = @i_rubro
    end
    set rowcount 0
  end

  /* Consulta de Valores Contratados */

  if @i_operacion = 'C'
  begin
    if @t_trn != 4070
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    /*** Inicio Cambio
     fecha: 07/05/2002, Ing. Elkin Pulido (Banco)
     Descripcion: Buscar rol ente segun producto ****/

    if @i_producto = 3
      select
        @w_tipo_ente = cc_rol_ente
      from   cob_cuentas..cc_ctacte
      where  cc_ctacte = @i_codigo
    else if @i_producto = 4
      select
        @w_tipo_ente = ah_rol_ente
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_codigo
  /** Fin Cambio **/
    /*** Inicio Cambio
     fecha: 09/04/2002, Ing. Elkin Pulido (Banco)
     Descripcion: Adicionar campos de busqueda ****/
    set rowcount 15

    select
      '1710' = a.vc_servicio_per,
      '1203' = substring(vs_descripcion,
                                             1,
                                             35),
      '1678' = a.vc_rango,
      '1213' = ra_desde,
      '1398' = ra_hasta,
      '1761' = a.vc_tipo_variacion,
      '1800' = round(a.vc_valor_con,
                                 2),
      '1364' = convert(varchar(10), a.vc_fecha_venc, 101)
    from   pe_val_contratado a,
           pe_servicio_per,
           pe_var_servicio,
           pe_rango
    where  sp_servicio_per   = a.vc_servicio_per
       and sp_pro_final      = @i_pro_final
       and vs_servicio_dis   = sp_servicio_dis
       and vs_rubro          = sp_rubro
       and sp_servicio_dis   = @i_servicio --ERP 09/04/2002
       and sp_rubro          = @i_rubro --ERP 09/04/2002
       and ra_tipo_rango     = a.vc_tipo_rango
       and ra_grupo_rango    = a.vc_grupo_rango
       and ra_rango          = a.vc_rango
       and a.vc_tipo_default = @i_tipo_default
       --and a.vc_rol = @i_rol
       and a.vc_rol          = @w_tipo_ente
       /*Fecha: 03/07/2002 Ing.Elkin Pulido (Banco)*/
       and a.vc_codigo       = @i_codigo
       and a.vc_producto     = @i_producto
       and a.vc_categoria    = @i_categoria
       and a.vc_fecha in
           (select
              max(b.vc_fecha)
            from   pe_val_contratado b
            where  b.vc_servicio_per = a.vc_servicio_per
               and b.vc_categoria    = a.vc_categoria
               and b.vc_tipo_rango   = a.vc_tipo_rango
               and b.vc_grupo_rango  = a.vc_grupo_rango
               and b.vc_rango        = a.vc_rango
               and b.vc_tipo_default = a.vc_tipo_default
               and b.vc_rol          = a.vc_rol
               and b.vc_codigo       = a.vc_codigo
               and b.vc_producto     = a.vc_producto)
       and a.vc_secuencial in
           (select
              max(c.vc_secuencial)
            from   pe_val_contratado c
            where  c.vc_servicio_per = a.vc_servicio_per
               and c.vc_categoria    = a.vc_categoria
               and c.vc_tipo_rango   = a.vc_tipo_rango
               and c.vc_grupo_rango  = a.vc_grupo_rango
               and c.vc_rango        = a.vc_rango
               and c.vc_tipo_default = a.vc_tipo_default
               and c.vc_rol          = a.vc_rol
               and c.vc_codigo       = a.vc_codigo
               and c.vc_producto     = a.vc_producto)
       and ((a.vc_servicio_per = @i_servicio_per
             and a.vc_rango        > @i_rango)
             or a.vc_servicio_per > @i_servicio_per)
       and a.vc_estado       = 'V'
    order  by a.vc_servicio_per,
              a.vc_tipo_rango,
              a.vc_rango
  /** Fin Cambio **/

  end

  if @i_operacion = 'H'
  begin
    set rowcount 20

    select
      '1093' = sd_servicio_dis,
      '1497' = sd_nemonico,
      '1710' = sd_descripcion,
      '1086' = vs_rubro,
      '1689' = vs_descripcion
    from   cob_remesas..pe_servicio_dis,
           cob_remesas..pe_var_servicio
    where  vs_servicio_dis = sd_servicio_dis
       and vs_estado       = 'V'
       and sd_estado       = 'V'
       and ((sd_servicio_dis = @i_servicio
             and vs_rubro        > @i_rubro)
             or (sd_servicio_dis > @i_servicio))
    order  by sd_servicio_dis,
              vs_rubro

    set rowcount 0
  end

  if @i_operacion = 'H2'
  begin
    set rowcount 20

    select
      '1093' = sd_servicio_dis,
      '1497' = sd_nemonico,
      '1710' = sd_descripcion,
      '1086' = vs_rubro,
      '1689' = vs_descripcion
    from   cob_remesas..pe_servicio_dis,
           cob_remesas..pe_var_servicio
    where  vs_servicio_dis = sd_servicio_dis
       and vs_estado       = 'V'
       and sd_estado       = 'V'
       and sd_servicio_dis = @i_servicio
       and vs_rubro        > @i_rubro
    order  by vs_rubro

    set rowcount 0
  end

  return 0

GO 
