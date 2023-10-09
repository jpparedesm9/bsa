/************************************************************************/
/*   Archivo            : cl_formext.sp                                 */
/*   Stored procedure   : sp_forma_extracto                             */
/*   Base de datos      : cobis                                         */
/*   Producto           : MIS                                           */
/*   Disenado por       : Andres Muñoz                                  */
/*   Fecha de escritura : 2013/10/15                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                        PROPOSITO                                     */
/*   Proceso de Generación Archivos planos de extractos de              */
/*   Costos financieros  de clientes                                    */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*   FECHA                AUTOR              RAZON                      */
/*   2013/10/15           Andres Muñoz       Emision Inicial            */
/*   2016/05/02           DFu                Migracion CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_forma_extracto')
  drop proc sp_forma_extracto
go

create proc sp_forma_extracto
(
  @s_ssn          int,
  @s_date         datetime,
  @s_user         login = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_term         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_cliente      int,
  @i_codigo       smallint = null,
  @i_forma_ext    char(1) = null,
  @i_tipo         smallint = null,
  @i_territorial  smallint = null,
  @i_zona         smallint = null,
  @i_oficina      smallint = null,
  @i_siguiente    int = null,
  @o_msg_retorno  varchar(255) = null out,
  @i_linea        char(1) = 'S'
)
as
  declare
    @w_error      int,
    @w_msg        varchar(255),
    @w_sp_name    varchar(25),
    @w_oficina    int,
    @w_nomofi     varchar(100),
    @w_tcorreo    char(3),
    @w_tiene      char(1),
    @w_fecha_hora datetime

  select
    @w_sp_name = 'sp_forma_extracto'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn not in (1609, 1616)
  begin
    select
      @w_error = 2006020,
      @w_msg = 'Error El Codigo de La Transaccion no Corresponde'
    goto ERROR
  end

  select
    @w_fecha_hora = getdate()

  select
    @w_tcorreo = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'TDW'
     and pa_producto = 'MIS'

  if @i_operacion = 'I'
  begin
    if exists(select
                1
              from   cl_forma_extractos
              where  fe_cliente = @i_cliente)
    begin
      select
        @w_error = 103116,
        @w_msg =
        'YA EXISTE UNA DIRECCION MARCADA COMO ENVIO EXTRACTO COSTOS FINANCIEROS'
      goto ERROR
    end

    insert into cl_forma_extractos
                (fe_cliente,fe_forma_entrega,fe_codigo,fe_fecha,fe_fecha_real,
                 fe_usuario,fe_oficina_marca,fe_terminal)
    values      ( @i_cliente,@i_forma_ext,@i_codigo,@s_date,@w_fecha_hora,
                  @s_user,@s_ofi,@s_term)

    if @@error <> 0
    begin
      select
        @w_error = 103118,
        @w_msg = 'ERROR AL INGRESAR MARCACION ENVIO EXTRACTO COSTOS FINANCIEROS'
      goto ERROR
    end

    insert into ts_forma_extractos
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ente,forma_ext,
                 codigo,oficina,fecha_registro,observacion)
    values      ( @s_ssn,@t_trn,@i_operacion,@w_fecha_hora,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_cliente,@i_forma_ext,
                  @i_codigo,@s_ofi,@s_date,
                  'MARCACION FORMA DE ENVIO EXTRACTOS FINANCIEROS')

    if @@error <> 0
    begin
      select
        @w_error = 103118,
        @w_msg = 'ERROR AL INGRESAR TS ENVIO EXTRACTO COSTOS FINANCIEROS'
      goto ERROR
    end
  end

  if @i_operacion = 'U'
  begin
    if exists (select
                 1
               from   cl_forma_extractos
               where  fe_cliente = @i_cliente)
    begin
      update cl_forma_extractos
      set    fe_forma_entrega = @i_forma_ext,
             fe_codigo = @i_codigo,
             fe_fecha = @s_date,
             fe_fecha_real = @w_fecha_hora,
             fe_usuario = @s_user,
             fe_oficina_marca = @s_ofi,
             fe_terminal = @s_term
      where  fe_cliente = @i_cliente

      if @@error <> 0
      begin
        select
          @w_error = 103115,
          @w_msg = 'ERROR AL ACTUALIZAR ENVIO EXTRACTO COSTOS FINANCIEROS'
        goto ERROR
      end

      insert into ts_forma_extractos
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,forma_ext,
                   codigo,oficina,fecha_registro,observacion)
      values      ( @s_ssn,@t_trn,@i_operacion,@w_fecha_hora,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_cliente,@i_forma_ext,
                    @i_codigo,@s_ofi,@s_date,
                    'MARCACION FORMA DE ENVIO EXTRACTOS FINANCIEROS')

      if @@error <> 0
      begin
        select
          @w_error = 103118,
          @w_msg = 'ERROR AL INGRESAR TS ENVIO EXTRACTO COSTOS FINANCIEROS'
        goto ERROR
      end
    end
    else
    begin
      select
        @w_error = 2006013,
        @w_msg =
'CLIENTE A ACTUALIZAR NO TIENE REGISTRADA NINGUNA MARCACION DE ENVIO EXTRACTO FINANCIERO'
  goto ERROR
end
end

  if @i_operacion = 'Q'
  begin
    if @i_tipo = 1 --Registros de marcacion
    begin
      select
        'CLIENTE' = fe_cliente,
        'FORMA EXTRACTO' = fe_forma_entrega,
        'DESC. FORMA EXTRACTO' = (select
                                    c.valor
                                  from   cobis..cl_tabla t,
                                         cobis..cl_catalogo c
                                  where  t.tabla  = 'cl_forma_extractos'
                                     and t.codigo = c.tabla
                                     and c.codigo = fe_forma_entrega),
        'CODIGO' = fe_codigo,
        'DIRRECCION ENVIO' = (select
                                di_descripcion
                              from   cobis..cl_direccion
                              where  di_ente      = fe_cliente
                                 and di_direccion = fe_codigo),
        'FECHA MARCACION' = fe_fecha_real,
        'USUARIO' = fe_usuario,
        'OFICINA MARCACION' = fe_oficina_marca
      from   cl_forma_extractos
      where  fe_cliente = @i_cliente

      if @@rowcount = 0
      begin
        select
          @w_error = 2006013,
          @w_msg =
    'CLIENTE NO TIENE REGISTRADA NINGUNA MARCACION DE ENVIO EXTRACTO FINANCIERO'
    goto ERROR
    end
    end

    if @i_tipo = 2 --Consulta territoriales
    begin
      select
        'CODIGO' = of_oficina,
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'R'

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN REGIONALES'
        goto ERROR
      end
    end

    if @i_tipo = 3 --Consulta Zonales
    begin
      select
        'CODIGO' = of_oficina,
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_regional = @i_territorial
         and of_subtipo  = 'Z'

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN ZONAS PARA LA REGIONAL'
        goto ERROR
      end
    end

    if @i_tipo = 4 --Consulta Oficinas
    begin
      select
        'CODIGO' = of_oficina,
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_regional = @i_territorial
         and of_zona     = @i_zona
         and of_subtipo  = 'O'

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN OFICINAS PARA LA ZONA Y REGIONAL'
        goto ERROR
      end
    end

    if @i_tipo = 5 --Consulta Estadisticas C012
    begin
      select
        dp_cliente_ec,
        dp_oficina,
        dp_fecha
      into   #productos
      from   cobis..cl_det_producto
      where  dp_rol_cliente = 'T'
         and dp_estado_ser  = 'V'

      create clustered index idx1
        on #productos(dp_cliente_ec, dp_fecha)

      select
        *
      into   #Oficinas
      from   cobis..cl_oficina
      where  1 = 2

      if @i_territorial is null
      begin
        insert into #Oficinas
          select
            *
          from   cobis..cl_oficina
          where  of_subtipo = 'O'
          order  by of_oficina
      end
      else
      begin
        select
          'cod_reg' = of_oficina
        into   #Regionales
        from   cobis..cl_oficina
        where  of_subtipo = 'R'

        if @i_zona is null
        begin
          insert into #Oficinas
            select
              o.*
            from   cobis..cl_oficina o,
                   #Regionales
            where  of_regional = cod_reg
               and of_regional = @i_territorial
               and of_subtipo  = 'O'
            order  by of_oficina

          if @@rowcount = 0
          begin
            select
              @w_error = 103117,
              @w_msg = 'NO EXISTEN OFICINAS PARA LA REGIONAL'
            goto ERROR
          end
        end
        else
        begin
          select
            'cod_zona' = of_oficina
          into   #Zonas
          from   cobis..cl_oficina o,
                 #Regionales
          where  of_regional = cod_reg
             and cod_reg     = @i_territorial
             and of_subtipo  = 'Z'

          if @i_oficina is null
          begin
            insert into #Oficinas
              select
                o.*
              from   cobis..cl_oficina o,
                     #Zonas
              where  of_zona    = cod_zona
                 and of_zona    = @i_zona
                 and of_subtipo = 'O'
              order  by of_oficina

            if @@rowcount = 0
            begin
              select
                @w_error = 103117,
                @w_msg = 'NO EXISTEN OFICINAS PARA LA ZONA'
              goto ERROR
            end
          end
          else
          begin
            insert into #Oficinas
              select
                o.*
              from   cobis..cl_oficina o,
                     #Zonas
              where  of_zona    = cod_zona
                 and of_zona    = @i_zona
                 and of_subtipo = 'O'
                 and of_oficina = @i_oficina
              order  by of_oficina

            if @@rowcount = 0
            begin
              select
                @w_error = 103117,
                @w_msg = 'LA OFICINA NO ES DE ESTA ZONA'
              goto ERROR
            end
          end
        end
      end

      set rowcount 20

      select
        'OFICINA' = of_oficina,
        'DESCRIPCION OFICINA' = of_nombre,
        'CORREO ELECTRONICO' = (select
                                  count(1)
                                from   cobis..cl_forma_extractos
                                where  fe_forma_entrega = 'C'
                                   and fe_oficina_marca = of_oficina),
        'RETENCION OFICINA' = (select
                                 count(1)
                               from   cobis..cl_forma_extractos
                               where  fe_forma_entrega = 'R'
                                  and fe_oficina_marca = of_oficina),
        'DIR FISICA (IMPRESO)' = (select
                                    count(1)
                                  from   cobis..cl_forma_extractos
                                  where  fe_forma_entrega = 'D'
                                     and fe_oficina_marca = of_oficina),
        'SIN FORMA ENTREGA' = (select
                                 count(1)
                               from   cobis..cl_ente
                               where  en_ente not in
                                      (select
                                         fe_cliente
                                       from   cobis..cl_forma_extractos)
                                  and of_oficina = (select top 1
                                                      dp_oficina
                                                    from   #productos
                                                    where
                                      dp_cliente_ec = en_ente
                                                    order  by dp_fecha desc))
      from   #Oficinas
      where  of_oficina > isnull(@i_siguiente,
                                 0)
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_error = 2006013,
          @w_msg =
  'NO EXISTEN DATOS DE ENVIO EXTRACTOS FINANCIEROS EN LAS OFICINAS SOLICITADAS'
    goto ERROR
  end

  set rowcount 0
  end
  end

  if @i_operacion = 'S'
  begin
    if @i_tipo = 1 --Territorial
    begin
      select
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'R'
         and of_oficina = @i_territorial

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN DATOS PARA LA TERRITORIAL'
        goto ERROR
      end
    end

    if @i_tipo = 2 --Zona
    begin
      select
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'Z'
         and of_oficina = @i_zona

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN DATOS PARA LA ZONA'
        goto ERROR
      end
    end

    if @i_tipo = 3 --Oficina
    begin
      select
        'DESCRIPCION' = of_nombre
      from   cobis..cl_oficina
      where  of_subtipo = 'O'
         and of_oficina = @i_oficina

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN DATOS PARA LA OFICINA'
        goto ERROR
      end
    end

    if @i_tipo = 4 --Forma Entrega Extracto
    begin
      select
        'DESCRIPCION' = c.valor
      from   cobis..cl_catalogo c,
             cobis..cl_tabla t
      where  t.tabla  = 'cl_forma_extractos'
         and t.codigo = c.tabla
         and c.codigo = @i_forma_ext
         and c.estado = 'V'

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN DATOS PARA LA FORMA DE ENVIO EXTRACTO FINANCIERO'
        goto ERROR
      end
    end

    if @i_tipo = 5 --Direccion 
    begin
      if @i_forma_ext = 'C' --Correo
      begin
        select
          'DIRECCION' = di_descripcion
        from   cobis..cl_direccion
        where  di_ente      = @i_cliente
           and di_direccion = @i_codigo
           and di_tipo      = @w_tcorreo

        if @@rowcount = 0
        begin
          select
            @w_error = 2006019,
            @w_msg = 'CLIENTE NO TIENE DIRECCION TIPO CORREO'
          goto ERROR
        end
      end
      else
      begin --Direcciones FÝsicas
        select
          'DIRECCION' = di_descripcion
        from   cobis..cl_direccion
        where  di_ente      = @i_cliente
           and di_direccion = @i_codigo
           and di_tipo      <> @w_tcorreo

        if @@rowcount = 0
        begin
          select
            @w_error = 103117,
            @w_msg = 'CLIENTE NO TIENE DIRECCIONES FISICAS'
          goto ERROR
        end
      end
    end

    if @i_tipo = 6
    begin
      select
        'REGIONAL' = of_regional,
        'ZONA' = of_zona,
        'OFIINA' = of_oficina
      from   cobis..cl_oficina
      where  of_oficina = @i_oficina

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'NO EXISTEN DATOS PARA LA CONSULTA'
        goto ERROR
      end
    end
  end

  /*** OFICINA ***/
  if @i_operacion = 'O'
  begin
    /*** BUSCA OFICINA DEL CLIENTE PRODUCTO ACTIVAS ***/
    select top 1
      @w_oficina = do_oficina
    from   cob_conta_super..sb_dato_operacion
    where  do_codigo_cliente = @i_cliente
    order  by do_fecha desc

    if @w_oficina is null
    begin
      /*** BUSCA OFICINA DEL CLIENTE PRODUCTO PASIVAS ***/
      select top 1
        @w_oficina = dp_oficina
      from   cob_conta_super..sb_dato_pasivas
      where  dp_cliente = @i_cliente
      order  by dp_fecha desc

      if @w_oficina is null
      begin
        /*** BUSCA OFICINA DE CREACION DEL CLIENTE ***/
        select
          @w_oficina = case
                         when en_oficina_prod is null then en_oficina
                         else en_oficina_prod
                       end
        from   cobis..cl_ente
        where  en_ente = @i_cliente

        if @w_oficina is null
        begin
          select
            @w_error = 103117,
            @w_msg = 'ERROR CLIENTE NO TIENE OFICINA ASIGNADA'
          goto ERROR
        end
      end
    end

    select
      @w_nomofi = of_nombre
    from   cobis..cl_oficina
    where  of_oficina = isnull(@i_oficina,
                               @w_oficina)

    select
      @w_oficina,
      @w_nomofi
  end

  /*** DIRECCION ***/
  if @i_operacion = 'D'
  begin
    if @i_tipo = 1 --DIRECCION FISICA
    begin
      select
        'DIRECCION' = di_direccion,
        'DESCRIPCION' = di_descripcion
      from   cobis..cl_direccion
      where  di_ente = @i_cliente
         and di_tipo <> @w_tcorreo

      if @@rowcount = 0
      begin
        select
          @w_error = 103117,
          @w_msg = 'CLIENTE NO TIENE DIRECCIONES FISICAS'
        goto ERROR
      end
    end
    if @i_tipo = 2 --CORREO
    begin
      select
        'DIRECCION' = di_direccion,
        'DESCRIPCION' = di_descripcion
      from   cobis..cl_direccion
      where  di_ente = @i_cliente
         and di_tipo = @w_tcorreo

      if @@rowcount = 0
      begin
        select
          @w_error = 2006019,
          @w_msg = 'CLIENTE NO TIENE DIRECCION TIPO CORREO'
        goto ERROR
      end
    end
  end

  /*** VALIDAR ***/
  if @i_operacion = 'V'
  begin
    if exists (select
                 1
               from   cobis..cl_forma_extractos
               where  fe_cliente = @i_cliente)
      select
        @w_tiene = 'S'
    else
      select
        @w_tiene = 'N'

    select
      @w_tiene
  end

  return 0

  ERROR:
  select
    @o_msg_retorno = @w_msg

  if @i_linea = 'S'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_msg   = @w_msg
  end
  else
    print cast(@w_sp_name as varchar) + ' --> ' + cast(@w_error as varchar) +
          ', '
          + cast(@w_msg as varchar(50))

  return @w_error

go

