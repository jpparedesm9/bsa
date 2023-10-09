/************************************************************************/
/*  Archivo:            ah_subtd.sp                                     */
/*  Stored procedure:   sp_mantenimiento_std                            */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Personalizacion                                 */
/*  Disenado por:       Igmar Berganza                                  */
/*  Fecha de escritura: 30-Jul-2014                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Stored Procedure para realizar el mantenimiento de subtipos de      */
/*  tarjeta de debito                                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*    02/Mayo/2016   Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_mantenimiento_std')
  drop proc sp_mantenimiento_std
go

create proc sp_mantenimiento_std
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_sesn         int = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_rty          char(1) = null,
  @t_trn          int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_producto     tinyint = null,
  @i_operacion    char(1) = null,
  @i_tabla        varchar(2) = null,-- Producto Bancario
  @i_subtipo      varchar(3) = null,
  @i_desc_subtipo varchar(255) = null,
  @i_estado       char(1) = null,
  @i_modo         int = null,
  @i_cta          varchar(16) = null,
  @i_cliente      int = null,
  @i_motivo       char(2) = null,
  @i_siguiente    int = null
)
as
  declare
    @w_sp_name      varchar(60),
    @w_subtipo      varchar(20),
    @w_codigo_t     smallint,
    @w_tabla        varchar(60),
    @w_conteo_t     int,
    @w_conteo_r     int,
    @w_desc_subtipo varchar(255),
    @w_msg          varchar(255),
    @w_mensaje      varchar(255),
    @w_error        int,
    @w_estado_old   char(1),
    @w_secuencial   int = 0

  select
    @w_sp_name = 'sp_mantenimiento_std'

  select
    @w_tabla = 'pe_subtipo_' + cast(@i_producto as varchar(2)) + '_' + @i_tabla

  if @t_show_version = 1
  begin
    print 'Stored Procedure=%1! Version=%2!' + @w_sp_name + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'I'
  begin
    if exists (select
                 1
               from   cobis..cl_tabla T,
                      cobis..cl_catalogo C
               where  T.codigo = C.tabla
                  and T.tabla like 'pe_subtipo_%'
                  and C.codigo = @i_subtipo
                  and C.estado = 'V')
    begin
      select
        @w_msg =
      'Producto Bancario no puede tener un código Subtipo ya utilizado'
        ,
        @w_error = 351578
      goto ERROR
    end

    if not exists (select
                     1
                   from   cobis..cl_tabla
                   where  tabla = @w_tabla)
    begin
      select
        @w_codigo_t = (max(isnull(codigo, 0)) + 1)
      from   cobis..cl_tabla

      insert into cobis..cl_tabla
      values      (@w_codigo_t,@w_tabla,@w_tabla)

      if @@error <> 0
      begin
        select
          @w_msg = 'Error en creacion de tabla de catalogo',
          @w_error = 103063
        goto ERROR
      end

      insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
      values      (@w_codigo_t,@i_subtipo,@i_desc_subtipo,@i_estado)

      if @@error <> 0
      begin
        select
          @w_msg = 'Error en creacion de catalogo',
          @w_error = 103015
        goto ERROR
      end

      insert into cob_remesas..pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_producto,ts_tipo,ts_fecha_cambio,
                   ts_hora,ts_rubro,ts_codigo,ts_origen,ts_especie)
      values      ( @s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                    'N',@i_operacion,@i_producto,@i_estado,@s_date,
                    getdate(),@i_subtipo,@w_codigo_t,@w_tabla,@i_desc_subtipo)

      /* error en la insercion de la transaccion de servicio */
      if @@error <> 0
      begin
        select
          @w_msg = 'Error en insercion de transaccion de servicio',
          @w_error = 143005
        goto ERROR
      end
    end
    else
    begin
      select
        @w_codigo_t = codigo
      from   cobis..cl_tabla
      where  tabla = @w_tabla

      if exists (select
                   1
                 from   cobis..cl_catalogo
                 where  tabla  = @w_codigo_t
                    and codigo = @i_subtipo)
      begin
        select
          @w_msg =
        'Producto Bancario no puede tener un c¾digo Subtipo ya utilizado'
          ,
          @w_error = 351578
        goto ERROR
      end

      insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
      values      (@w_codigo_t,@i_subtipo,@i_desc_subtipo,@i_estado)

      if @@error <> 0
      begin
        select
          @w_msg = 'Error en creacion de catalogo',
          @w_error = 103015
        goto ERROR
      end

      insert into cob_remesas..pe_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                   ts_terminal,
                   ts_reentry,ts_operacion,ts_producto,ts_tipo,ts_fecha_cambio,
                   ts_hora,ts_rubro,ts_codigo,ts_origen,ts_especie)
      values      ( @s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                    'N',@i_operacion,@i_producto,@i_estado,@s_date,
                    getdate(),@i_subtipo,@w_codigo_t,@w_tabla,@i_desc_subtipo)

      /* error en la insercion de la transaccion de servicio */
      if @@error <> 0
      begin
        select
          @w_msg = 'Error en insercion de transaccion de servicio',
          @w_error = 143005
        goto ERROR
      end
    end
  end --@i_operacion = 'I'

  if @i_operacion = 'U'
  begin
    select
      @w_codigo_t = codigo
    from   cobis..cl_tabla
    where  tabla = @w_tabla

    select
      @w_estado_old = estado
    from   cobis..cl_catalogo
    where  tabla  = @w_codigo_t
       and codigo = @i_subtipo

    if (@w_estado_old <> @i_estado)
       and @w_estado_old = 'V'
    begin
      if exists (select
                   1
                 from   cob_remesas..re_relacion_cta_canal
                 where  rc_canal   = 'TAR'
                    and rc_subtipo = @i_subtipo
                    and rc_estado  = 'V')
      begin
        select
          @w_msg =
    'EXISTE RELACIONES VIGENTE CON ESTE SUBTIPO, NO ES POSIBLE CAMBIO DE ESTADO'
    ,
    @w_error = 351579
    goto ERROR
    end
    end

    update cobis..cl_catalogo
    set    valor = @i_desc_subtipo,
           estado = @i_estado
    where  tabla  = @w_codigo_t
       and codigo = @i_subtipo

    if @@error <> 0
    begin
      select
        @w_msg = 'Error en actualizacion de catalogo',
        @w_error = 105000
      goto ERROR
    end

    insert into cob_remesas..pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_operacion,ts_producto,ts_tipo,ts_fecha_cambio,
                 ts_hora,ts_rubro,ts_codigo,ts_origen,ts_especie)
    values      ( @s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                  'N',@i_operacion,@i_producto,@i_estado,@s_date,
                  getdate(),@i_subtipo,@w_codigo_t,@w_tabla,@i_desc_subtipo)

    /* error en la insercion de la transaccion de servicio */
    if @@error <> 0
    begin
      select
        @w_msg = 'Error en insercion de transaccion de servicio',
        @w_error = 143005
      goto ERROR
    end

  end --@i_operacion = 'U'

  if @i_operacion = 'S'
  begin
    select
      @w_codigo_t = codigo
    from   cobis..cl_tabla
    where  tabla = @w_tabla

    if @i_modo = 0
    begin
      select
        'Secuencial' = convert(int, 0),
        pb_pro_bancario,
        pb_descripcion,
        codigo,
        valor,
        estado
      into   #tempcatalogo
      from   cobis..cl_catalogo,
             cob_remesas..pe_pro_bancario
      where  tabla           = @w_codigo_t
         and pb_pro_bancario = @i_tabla
      order  by codigo

      select
        @w_secuencial = 0

      update #tempcatalogo
      set    Secuencial = @w_secuencial,
             @w_secuencial = @w_secuencial + 1

      set rowcount 15

      select
        '1906' = pb_pro_bancario,    --COD. PROD. BANC.
        '1645' = pb_descripcion,  --PROD BANC
        '1734' = codigo,     --SUBTIPO
        '1896' = valor,   -- DESCRIPCION
        '1333' = estado,   -- ESTADO
        '1703' = Secuencial    --SECUENCIAL
      from   #tempcatalogo
      where  Secuencial > isnull(@i_siguiente,
                                 0)
      order  by Secuencial

      set rowcount 0

    /*select 'COD PROD BANC' = pb_pro_bancario,
           'PROD BANC'     = pb_descripcion,
           'SUBTIPO'       = codigo,
           'DESCRIPCION'   = valor,
           'ESTADO'        = estado
    from cobis..cl_catalogo, cob_remesas..pe_pro_bancario
    where tabla = @w_codigo_t
    and pb_pro_bancario = @i_tabla
    order by codigo  */
    end

    if @i_modo = 1
    begin
      select
        '1906' = pb_pro_bancario,    --COD. PROD. BANC.
        '1645' = pb_descripcion,  --PROD BANC
        '1734' = codigo,     --SUBTIPO
        '1896' = valor,   -- DESCRIPCION
        '1333' = estado   -- ESTADO
      from   cobis..cl_catalogo,
             cob_remesas..pe_pro_bancario
      where  tabla           = @w_codigo_t
         and codigo          = @i_subtipo
         and pb_pro_bancario = @i_tabla
      order  by codigo
    end

  end

  if @i_operacion = 'Q'
  begin
    select
      @w_codigo_t = codigo
    from   cobis..cl_tabla
    where  tabla = @w_tabla

    select
      @w_conteo_t = count(*)
    from   cobis..cl_catalogo
    where  tabla  = @w_codigo_t
       and estado = 'V'

    select
      @w_conteo_r = count(*)
    from   cob_remesas..re_relacion_cta_canal
    where  rc_cliente = @i_cliente
       and rc_cuenta  = @i_cta
       and rc_canal   = 'TAR'
       and rc_estado  = 'V'

    if @w_conteo_t = 0
    begin
      select
        @w_subtipo = null,
        @w_desc_subtipo = null
      goto MAPEO
    end

    if @w_conteo_t >= @w_conteo_r
    begin
      if @i_motivo in ('03', '02')
      begin
        select
          @w_subtipo = codigo,
          @w_desc_subtipo = valor
        from   cobis..cl_catalogo,
               cob_remesas..re_relacion_cta_canal
        where  tabla      = @w_codigo_t
           and rc_cuenta  = @i_cta
           and rc_canal   = 'TAR'
           and rc_estado  = 'V'
           and estado     = 'V'
           and rc_subtipo = codigo
        order  by codigo

        goto MAPEO
      end
      else
      begin
        select
          subtipo = codigo,
          desc_subtipo = valor
        into   #temp
        from   cobis..cl_catalogo
        where  tabla  = @w_codigo_t
           and estado = 'V'
        order  by codigo

        delete from #temp
        where  subtipo in
               (select
                  rc_subtipo
                from   cob_remesas..re_relacion_cta_canal
                where  rc_cliente = @i_cliente
                   and rc_canal   = 'TAR'
                   and rc_estado  = 'V')

        select top 1
          @w_subtipo = subtipo,
          @w_desc_subtipo = desc_subtipo
        from   #temp
        order  by subtipo

        if @@rowcount = 0
        begin
          select
            @w_subtipo = 'XXX',
            @w_desc_subtipo = 'XXX'
        end
      end
    end
    else
    begin
      select
        @w_subtipo = null,
        @w_desc_subtipo = null
    end

    MAPEO:

    select
      @w_subtipo
    select
      @w_desc_subtipo

  end

  fin:

  return 0

  ERROR:

  set @w_mensaje = @w_sp_name + ' ---> ' + @w_msg

  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error,
    @i_msg  = @w_mensaje

go 
