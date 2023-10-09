/* ***********************************************************************/
/*      Archivo:                clfunofi.sp                              */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           A Correa                                 */
/*      Fecha de escritura:     14-Abr-2008                              */
/* ***********************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Permite seleccionar funcionario de determinado cargo en una          */
/*  oficina                                                              */
/*************************************************************************/
/*                 MODIFICACIONES                                        */
/*  FECHA          AUTOR            RAZON                                */
/*  14-Abr-2008    A. Correa        Emision inicial                      */
/*  02-Feb-2009    E. Alvarez       Req.002 Area deInfluencia Ciu-Ofi.   */
/*  07-May-2009    E. Laguna        Caso 301                             */
/*  21-May-2009    E. Laguna        Caso 522                             */
/*  25-May-2009    E. Laguna        Caso 554                             */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/* ***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_funcionario_oficina')
  drop proc sp_funcionario_oficina
go

create proc sp_funcionario_oficina
(
  @s_ofi          smallint = null,
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_debug        char(1) = null,
  @t_file         varchar(10) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_funcionario  smallint = 0,
  @i_parcargo     char(6) = null,
  @i_cargo        smallint = null,
  @i_tipo         catalogo = '001',
  @i_cod_ciudad   int = 0,
  @i_desc_ciudad  varchar(30) = null,
  @i_cod_oficina  int = 0,
  @i_desc_oficina varchar(30) = null,
  @i_modo         tinyint = null,
  @i_secuencial   int = null,
  @i_linea        char(1) = 'S',
  @i_crea_ext     char(1) = null,-- Req. 353 Alianzas Comerciales
  @o_msg_msv      varchar(255) = null out,-- Req. 353 Alianzas Comerciales
  @o_funcionario  smallint = null out
)
as
  declare
    @w_sp_name descripcion,
    @w_cargo   smallint,
    @w_debug   char(1),
    @w_sec     int,
    @w_opi     char(1)

  select
    @w_sp_name = 'sp_funcionario_oficina'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --VERSION /*  25-May-2009    E. Laguna        Caso 554                             */

  select
    @w_debug = 'N'

  if @w_debug = 'S'
    print '@i_parcargo: ' + @i_parcargo + ' @i_tipo: ' + @i_tipo

  if @i_parcargo is not null
  begin
    select
      @w_cargo = pa_smallint
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = @i_parcargo
    if @@rowcount = 0
        or convert(varchar, @w_cargo) is null
        or ltrim(rtrim(convert(varchar, @w_cargo))) = ''
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101036
      /*'No existe parametro'*/
      return 101036
    end
  end
  else
  begin
    select
      @w_cargo = c.valor
    from   cobis..cl_tabla t,
           cobis..cl_catalogo c
    where  t.tabla  = 'cl_director_oficina'
       and t.codigo = c.tabla
       and c.codigo = @i_tipo
    if @@rowcount = 0
    begin
      select
        @w_cargo = pa_smallint
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'DOF'
      if @@rowcount = 0
          or convert(varchar, @w_cargo) is null
          or ltrim(rtrim(convert(varchar, @w_cargo))) = ''
      begin
        if @i_linea = 'S'
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101036
        /*'No existe parametro'*/
        end
        return 101036

      end
    end

  end

  /* Valida si es oficina OPI y asigna ENCARGADO */

  select
    @w_opi = to_opi
  from   cob_credito..cr_tipo_oficina
  where  to_oficina = @s_ofi

  if @w_opi = 'S'
  begin
    select
      @w_cargo = pa_smallint
    from   cobis..cl_parametro
    where  pa_nemonico = 'ENCOPI' --Encargado OPI
       and pa_producto = 'CRE'

    if @@rowcount = 0
    begin
      /* No existe oficial */
      if @i_linea = 'S'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101199
      end
      return 101199
    end

  end

  if @i_operacion = 'A'
  begin
    set rowcount 20
    if @w_cargo is null
    begin
      select
        'OFICIAL' = oc_oficial,
        'NOMBRE' = fu_nombre,
        'NIVEL' = valor,
        'BANCA' = oc_banca,
        'CODIGO' = codigo
      from   cobis..cc_oficial,
             cobis..cl_funcionario,
             cobis..cl_catalogo
      where  oc_oficial     > @i_funcionario
         and oc_funcionario = fu_funcionario
         and codigo         = oc_tipo_oficial
         and tabla          = (select
                                 codigo
                               from   cobis..cl_tabla
                               where  tabla = 'cc_tipo_oficial')
         and fu_oficina     = @s_ofi
         and fu_estado      = 'V'
    end
    else
    begin
      select
        'OFICIAL' = oc_oficial,
        'NOMBRE' = fu_nombre,
        'NIVEL' = valor,
        'BANCA' = oc_banca,
        'CODIGO' = codigo
      from   cobis..cc_oficial,
             cobis..cl_funcionario,
             cobis..cl_catalogo
      where  oc_oficial     > @i_funcionario
         and oc_funcionario = fu_funcionario
         and codigo         = oc_tipo_oficial
         and tabla          = (select
                                 codigo
                               from   cobis..cl_tabla
                               where  tabla = 'cc_tipo_oficial')
         and fu_oficina     = @s_ofi
         and fu_cargo       = @w_cargo
         and fu_estado      = 'V'
    end
    set rowcount 0
    return 0
  end

  /* Tipo Value dado el codigo del oficial retornar el nombre */
  if @i_operacion = 'V'
  begin
    if @i_funcionario = 0
        or @i_funcionario is null
    begin
      /* No existe funcionario */
      if @i_linea = 'S'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
      end
      return 101036
    end

    if @w_cargo is null
    begin
      select
        'NOMBRE' = fu_nombre
      from   cobis..cc_oficial,
             cobis..cl_funcionario
      where  oc_oficial     = @i_funcionario
         and oc_funcionario = fu_funcionario
         and fu_oficina     = @s_ofi
         and fu_estado      = 'V'
    end
    else
    begin
      select
        'NOMBRE' = fu_nombre
      from   cobis..cc_oficial,
             cobis..cl_funcionario
      where  oc_oficial     = @i_funcionario
         and oc_funcionario = fu_funcionario
         and fu_oficina     = @s_ofi
         and fu_cargo       = @w_cargo
         and fu_estado      = 'V'
    end

    if @@rowcount = 0
    begin
      /* No existe oficial */
      if @i_linea = 'S'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101199
      end
      return 101199

    end
    return 0
  end

  if @i_operacion = 'Q'
  begin
    set rowcount 1

    select
      @o_funcionario = oc_oficial
    from   cobis..cc_oficial,
           cobis..cl_funcionario
    where  oc_funcionario = fu_funcionario
       and fu_oficina     = @s_ofi
       and fu_cargo       = @w_cargo
       and fu_estado      = 'V'

    if @@rowcount = 0
    begin
      if @w_debug = 'S'
        print 'Oficina : ' + isnull(convert(varchar, @s_ofi), 'nula ') +
                                ' Cargo en numero :'
              + isnull(convert(varchar, @w_cargo), ' nulo ') +
              ' Cargo en letras : '
              + isnull(convert(varchar, @i_parcargo), 'nulo')

      if isnull(@i_crea_ext,
                'N') = 'S'
        select
          @o_msg_msv = 'No hay relacion oficial-funcionario con Oficina: '
                       + convert(varchar(10), isnull(@s_ofi, 'nula ')) +
                       ' Cargo:'
                       + isnull(convert(varchar, @w_cargo), ' nulo ') +
                                                   ' Cargo en letras: '
                       + isnull(convert(varchar, @i_parcargo), 'nulo') +
                       ' tipo:'
                       +
                       isnull
                                                   (@i_tipo, 'nulo')

      if @i_linea = 'S'
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101199
      end
      return 101199

    end
    set rowcount 0
  end

  if @i_operacion = 'S' -- FSAP_Clientes_006
  begin
    set rowcount 20

    select
      'OFICIAL' = oc_oficial,
      'NOMBRE' = fu_nombre,
      'NIVEL' = valor,
      'BANCA' = oc_banca,
      'CODIGO' = codigo
    from   cobis..cc_oficial,
           cobis..cl_funcionario,
           cobis..cl_catalogo
    where  oc_oficial     > @i_funcionario
       and oc_funcionario = fu_funcionario
       and codigo         = oc_tipo_oficial
       and tabla          = (select
                               codigo
                             from   cobis..cl_tabla
                             where  tabla = 'cc_tipo_oficial')
       and fu_oficina     = @s_ofi
       and fu_cargo       = @i_cargo
       and fu_estado      = 'V'
  end

  /* Ingreso Parametrizacion Area de Influencia */
  if @i_operacion = 'N'
  begin
    if exists (select
                 1
               from   cobis..cl_area_influencia
               where  ari_cod_ciudad  = @i_cod_ciudad
                  and ari_cod_oficina = @i_cod_oficina)
    begin
      if @i_linea = 'S'
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
      /* 'Ya existe ese registro'*/
      end
      return 1

    end

    else
    begin
      insert into cobis..cl_area_influencia
                  (ari_cod_ciudad,ari_cod_oficina)
      values      (@i_cod_ciudad,@i_cod_oficina)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103092
        rollback tran
        return 1 /*'Error en creacion de area influencia'*/
      end

      /* transaccion de servicio*/
      insert into ts_area_inf
                  (secuencial,tipo_transaccion,fecha,usuario,terminal,
                   srv,lsrv,clase,oficina,ciudad,
                   oficina_par,descripcion)
      values      (@s_ssn,1030,@s_date,@s_user,@s_term,
                   @s_srv,@s_lsrv,'P',@s_ofi,@i_cod_ciudad,
                   @i_cod_oficina,'CREA RELACION CIUDAD OFICINA')
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        return 1 /*'Error en creacion de area influencia'*/
      end

    end --existe

  end

  /* Elimina Parametrizacion Area de Influencia EAL FEB/2009*/
  if @i_operacion = 'E'
  begin
    delete cobis..cl_area_influencia
    where  ari_cod_ciudad  = @i_cod_ciudad
       and ari_cod_oficina = @i_cod_oficina
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107108 /* OJO..... CAMBIAR .... */
      rollback tran
      return 1 /*'Error en creacion de area influencia'*/
    end

    /* transaccion de servicio*/
    insert into ts_area_inf
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 srv,lsrv,clase,oficina,ciudad,
                 oficina_par,descripcion)
    values      (@s_ssn,1031,@s_date,@s_user,@s_term,
                 @s_srv,@s_lsrv,'P',@s_ofi,@i_cod_ciudad,
                 @i_cod_oficina,'ELIMINA RELACION CIUDAD OFICINA')
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      rollback tran
      return 1 /*'Error en creacion de area influencia'*/
    end
  end

  if @i_operacion = 'B'
  begin
    set rowcount 40
    select
      'COD. CIUDAD' = ari_cod_ciudad,
      'DESCRIPCION CIUDAD' = ci_descripcion,
      'COD. OFICINA' = ari_cod_oficina,
      'DESCRIPCION OFICINA' = of_nombre
    from   cobis..cl_area_influencia,
           cobis..cl_oficina,
           cobis..cl_ciudad
    where  ari_cod_ciudad  = ci_ciudad
       and ari_cod_oficina = of_oficina
       and ari_cod_ciudad  > @i_cod_ciudad
    order  by ari_cod_ciudad,
              ari_cod_oficina
  end

  if @i_operacion = 'C'
  begin
    if @i_tipo = 'X'
    begin
      drop table listado_tmp3
      begin
        select
          secuencial = 0,
          ciudad = ari_cod_ciudad,
          nomciudad = ci_descripcion,
          oficina = ari_cod_oficina,
          nomoficina = of_nombre
        into   listado_tmp3
        from   cobis..cl_area_influencia,
               cobis..cl_ciudad,
               cobis..cl_oficina
        where  ari_cod_oficina = @i_cod_oficina
           and ari_cod_ciudad  = @i_cod_ciudad
           and ari_cod_oficina = of_oficina
           and ari_cod_ciudad  = ci_ciudad
        order  by ari_cod_ciudad,
                  ari_cod_oficina
      end

      select
        @w_sec = 1
      update listado_tmp3
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'COD. CIUDAD' = ciudad,
          'DESCRIPCION CIUDAD' = nomciudad,
          'COD. OFICINA' = oficina,
          'DESCRIPCION OFICINA' = nomoficina,
          'SEC' = secuencial
        from   cobis..listado_tmp3
        order  by secuencial
      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'COD. CIUDAD' = ciudad,
          'DESCRIPCION CIUDAD' = nomciudad,
          'COD. OFICINA' = oficina,
          'DESCRIPCION OFICINA' = nomoficina,
          'SEC' = secuencial
        from   listado_tmp3
        where  secuencial > @i_secuencial
        order  by secuencial
      end
    end --tipo X

    if @i_tipo = 'Y'
    begin
      drop table listado_tmp3
      begin
        select
          secuencial = 0,
          ciudad = ari_cod_ciudad,
          nomciudad = ci_descripcion,
          oficina = ari_cod_oficina,
          nomoficina = of_nombre
        into   listado_tmp3
        from   cobis..cl_area_influencia,
               cobis..cl_ciudad,
               cobis..cl_oficina
        where  ari_cod_oficina = of_oficina
           and ari_cod_ciudad  = ci_ciudad
        order  by ari_cod_ciudad,
                  ari_cod_oficina
      end

      select
        @w_sec = 0
      update listado_tmp3
      set    secuencial = @w_sec,
             @w_sec = @w_sec + 1

      if @i_modo = 0
      begin
        set rowcount 20
        select
          'COD. CIUDAD' = ciudad,
          'DESCRIPCION CIUDAD' = nomciudad,
          'COD. OFICINA' = oficina,
          'DESCRIPCION OFICINA' = nomoficina,
          'SEC' = secuencial
        from   listado_tmp3
        order  by secuencial
      end

      if @i_modo = 1
      begin
        set rowcount 20
        select
          'COD. CIUDAD' = ciudad,
          'DESCRIPCION CIUDAD' = nomciudad,
          'COD. OFICINA' = oficina,
          'DESCRIPCION OFICINA' = nomoficina,
          'SEC' = secuencial
        from   listado_tmp3
        where  secuencial > @i_secuencial
        order  by secuencial
      end
    end --tipo Y

  end --operacion C

  if @i_operacion = 'H'
  begin
    if @i_tipo = 'B'
    begin --Alfabetico
      if @i_desc_oficina is null
        select
          @i_desc_oficina = '%'

      select
        'COD. OFICINA' = ari_cod_oficina,
        'DESCRIPCION OFICINA' = of_nombre
      from   cobis..cl_area_influencia,
             cobis..cl_ciudad,
             cobis..cl_oficina
      where  ari_cod_ciudad  = @i_cod_ciudad
         and ari_cod_ciudad  = ci_ciudad
         and ari_cod_oficina = of_oficina
         and of_nombre like @i_desc_oficina
    end
    else
    begin
      select
        'COD. OFICINA' = ari_cod_oficina,
        'DESCRIPCION OFICINA' = of_nombre
      from   cobis..cl_area_influencia,
             cobis..cl_ciudad,
             cobis..cl_oficina
      where  ari_cod_ciudad  = @i_cod_ciudad
         and ari_cod_ciudad  = ci_ciudad
         and ari_cod_oficina = of_oficina
    end

    if @@rowcount = 0
    begin
      if @i_linea = 'S'
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101227
      /*'No existe parametrizacion'*/
      end
      return 101227

    end

  end

  /* Consulta en Direcciones EAL FEB/2009 */
  if @i_operacion = 'P'
  begin
    if exists(select
                1
              from   cobis..cl_area_influencia
              where  ari_cod_oficina = @i_cod_oficina
                 and ari_cod_ciudad  = @i_cod_ciudad)
    begin
      select
        'DESCRIPCION OFICINA' = of_nombre
      from   cobis..cl_area_influencia,
             cobis..cl_ciudad,
             cobis..cl_oficina
      where  ari_cod_ciudad  = @i_cod_ciudad
         and ari_cod_ciudad  = ci_ciudad
         and ari_cod_oficina = of_oficina
         and ari_cod_oficina = @i_cod_oficina
    end
    else
    begin
      if @i_linea = 'S'
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101228
      end
      return 101228

    end
  end

  return 0

go

