/************************************************************************/
/*      Archivo:                clasoser.sp                             */
/*      Stored procedure:       sp_clasoser                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               clientes                                */
/*      Disenado por:           Alfredo Zamudio                         */
/*      Fecha de escritura:     30/12/2011                              */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa procesa las relaciones entre clientes y CNB's     */
/*      S:  Busqueda de relaciones cliente - CNB por parametro cliente  */
/*      V:  Valida que el cliente ingresado tenga una ocurrencia valida */
/*      S1: Busqueda de oficinas CNB's sin relacionar                   */
/*      Q1: Busqueda del nombre de la oficina enviada por parámetro     */
/*      I:  Inserta una nueva relación cliente - CNB                    */
/*      U:  Actualiza las relaciones cliente - CNB                      */
/*      D:  Elimina las relaciones cliente - CNB                        */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists(select
            1
          from   sysobjects
          where  name = 'sp_clasoser')
  drop proc sp_clasoser
go

/*CREACION DEL PROCEDIMIENTO*/
create proc sp_clasoser
(
  @t_show_version bit = 0,
  @i_secuencial   smallint = null,
  @i_operacion    varchar(2) = null,
  @i_servicio     int = null,
  @i_cliente      int = null,
  @i_codigo       int = null,
  @i_estado       char(1) = null,
  @i_fecha_crea   datetime = null,
  @i_fecha_mod    datetime = null,
  @i_siguiente    int = 0,
  @i_modo         smallint = null,
  @i_oficina      int = null,
  @i_criterio     varchar(60)= null,
  @i_tipo_cb      char(1) = null,-- Req. 381 CB III
  @s_user         login = null,
  @s_ssn          int = null,
  @t_trn          smallint = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null
)
as
  /*DECLARACION VARIABLES DE TRABAJO*/

  declare
    @w_sp_name      varchar,
    @w_commit      char(1),
    @w_msg         varchar(100),
    @w_error       int,
    @w_sec         smallint,
    @w_of_nombre   varchar,
    @w_fecha       datetime,
    @w_tabla       int,
    @w_relacion    int,
    @w_cob         int,
    @w_debug       char(1),
    @w_tipo_cl     varchar(10),
    @w_tipo_cl_pos varchar(10),
    @w_nombre      varchar(64),
    @w_apellido1   varchar(64),
    @w_apellido2   varchar(64),
    @w_ofiCNB      varchar(64),
    @w_estado      char(1)

  /*INSTANCIACION VARIABLES DE TRABAJO*/

  select
    @w_sp_name = 'sp_clasoser',
    @w_commit = 'N',
    @w_msg = ' ',
    @w_error = 0,
    @w_debug = 'S'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_tipo_cl = isnull(pa_char,
                        '000')
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TCCNB'

  select
    @w_tipo_cl_pos = isnull(pa_char,
                            '000')
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TCCBP'

  /*BUSQUEDA RELACIONES CLIENTES - CNB*/

  if @i_operacion = 'S'
  begin
    if @i_modo = 0
    begin
      select
        @w_tabla = codigo
      from   cobis..cl_tabla
      where  tabla = 're_estado_servicio'
      if @w_tabla is null
      begin
        select
          @w_error = 101249,
          @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
        goto CONTROL_ERROR
      end
      else
      begin
        set rowcount 15
        select
          '   ' = '           ',
          'Sec' = ac_secuencial,
          'Cod.CB' = ac_codigo,
          'Nombre Corresponsal' = (select
                                     of_nombre
                                   from   cl_oficina
                                   where  of_oficina = a.ac_codigo),
          'Cod.Cliente     ' = ac_cliente,
          'Nombre Cliente     ' = (select
                                     isnull(p_p_apellido, '') + ' ' + isnull(
                                     p_s_apellido
                                     , '') + ' ' + en_nombre
                                   from   cl_ente
                                   where  en_ente = ac_cliente),
          'Estado' = (select
                        valor
                      from   cl_catalogo
                      where  tabla  = @w_tabla
                         and codigo = a.ac_estado),
          'Fecha Creacion' = ac_fecha_crea,
          'Usuario' = ac_usuario,
          'Tipo CB' = ac_tipo_cb
        from   cl_asoc_clte_serv as a
        where  ac_servicio   = 'CNB'
           and ac_secuencial > @i_siguiente
        order  by ac_secuencial

        if @@rowcount = 0
           and @i_siguiente = 0
        begin
          select
            @w_msg = 'ERROR EN LA CONSULTA, NO HAY RELACIONES CB',
            @w_error = 101240
          set rowcount 0
          goto CONTROL_ERROR
        end
        set rowcount 0
      end
    end
    if @i_modo = 1
    begin
      select
        @w_tabla = codigo
      from   cobis..cl_tabla
      where  tabla = 're_estado_servicio'
      if @w_tabla is null
      begin
        select
          @w_error = 101249,
          @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
        goto CONTROL_ERROR
      end
      else
      begin
        set rowcount 15
        select
          '   ' = '           ',
          'Sec' = ac_secuencial,
          'Cod.CB' = ac_codigo,
          'Nombre Corresponsal' = b.of_nombre,
          'Cod.Cliente     ' = ac_cliente,
          'Nombre Cliente     ' = (select
                                     isnull(p_p_apellido, '') + ' ' + isnull(
                                     p_s_apellido
                                     , '') + ' ' + en_nombre
                                   from   cl_ente
                                   where  en_ente = ac_cliente),
          'Estado' = (select
                        valor
                      from   cl_catalogo
                      where  tabla  = @w_tabla
                         and codigo = ac_estado),
          'Fecha Creacion' = ac_fecha_crea,
          'Usuario' = ac_usuario,
          'Tipo CB' = ac_tipo_cb
        from   cl_asoc_clte_serv a,
               cl_oficina b
        where  ac_cliente    = @i_cliente
           and b.of_oficina  = a.ac_codigo
           and a.ac_cliente  = @i_cliente
           and ac_servicio   = 'CNB'
           and ac_secuencial > @i_siguiente
        order  by ac_secuencial

        if @@rowcount = 0
        begin
          select
            @w_msg = 'ERROR EN LA CONSULTA, NO EXISTEN RELACIONES',
            @w_error = 101241
          set rowcount 0
          goto CONTROL_ERROR
        end
        set rowcount 0
      end
    end
    return 0
  end -- Termina Operacion 'S'

  -- 'V' --> Valida que el cliente ingresado tenga una ocurrencia
  -- de la relacion creada en el parámetro XXX en la tabla cl_instancia.
  -- En caso de no tener la ocurrencia desplegar mensaje de error ******

  if @i_operacion = 'V'
  begin
    if @i_modo = 0
    begin
      select
        @w_relacion = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'CRCNB'

      if @w_debug = 'S'
      begin
        print '@w_relacion ' + cast(@w_relacion as varchar) + ' @i_cliente: '
              + cast(@i_cliente as varchar)
      end

      if @i_cliente is null
          or @w_relacion is null
      begin
        select
          @w_error = 101249,
          @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
        goto CONTROL_ERROR
      end
      else
      begin
        select
          in_ente_d = in_ente_d
        from   cl_instancia
        where  in_lado     = 'I'
           and in_ente_d   = @i_cliente
           and in_relacion = @w_relacion

        if @@rowcount = 0
        begin
          select
            @w_msg = 'NO EXISTEN OCURRENCIAS SOBRE ESTE CLIENTE',
            @w_error = 101242
          goto CONTROL_ERROR
        end
      end
    end
    if @i_modo = 1
    begin
      if @i_cliente is null
      begin
        select
          @w_error = 101249,
          @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
        goto CONTROL_ERROR
      end
      else
      begin
        select
          1
        from   cl_ente
        where  en_ente = @i_cliente
           and en_categoria in (@w_tipo_cl, @w_tipo_cl_pos)
        if @@rowcount = 0
        begin
          select
            @w_msg = 'CLIENTE NO ES CB',
            @w_error = 101253
          goto CONTROL_ERROR
        end
        return 0
      end
    end
  end -- Termina Operacion 'V'

  --'S1' --> Buscar la lista de oficinas (código - of_oficina, nombre - of_nombre)
  -- de la tabla de oficinas (cl_oficina) para las oficinas tipo (of_subtipo) 'O'
  -- y que pertenezcan al COB o COB'S (of_cob) parametrizados para manejo de CNB.
  -- Excluir las que ya se encuentran asociadas a alg·n cliente ( cl_asoc_clte_serv)

  if @i_operacion = 'S1'
  begin
    if @i_modo = 0
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 60
      select
        'Código' = of_oficina,
        'Nombre' = of_nombre
      from   cl_oficina
      where  of_subtipo = 'O'
         and of_cob     = @w_cob
         and of_oficina > @i_siguiente
         and of_oficina not in (select
                                  ac_codigo
                                from   cl_asoc_clte_serv)
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          --@w_msg = 'ERROR EN LA CONSULTA, NO HAY OFICINAS CNB CREADAS',
          @w_error = 101243
        set rowcount 0
        goto CONTROL_ERROR
      end
      set rowcount 0
      return 0
    end
    if @i_modo = 1
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 60
      select
        'Codigo' = of_oficina,
        'Nombre' = of_nombre
      from   cl_oficina
      where  of_subtipo = 'O'
         and of_cob     = @w_cob
         and of_oficina > @i_siguiente
         and of_oficina not in (select
                                  ac_codigo
                                from   cl_asoc_clte_serv)
         and of_nombre like @i_criterio + '%'
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_msg = 'ERROR EN LA CONSULTA, OFICINA CB YA ESTA ASOCIADA',
          @w_error = 101245
        set rowcount 0
        goto CONTROL_ERROR
      end
      set rowcount 0
      return 0
    end
    if @i_modo = 2 --Corresponsales habilitados para mostrar catalogo
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 20
      select
        'Codigo' = of_oficina,
        'Nombre' = of_nombre,
        'Cliente' = ac_cliente
      from   cl_oficina,
             cl_asoc_clte_serv
      where  of_subtipo = 'O'
         and of_cob     = 9007
         and of_oficina = ac_codigo
         and ac_estado  = 'H' --Corresponsales que esten habilitados
         and ac_codigo  > @i_siguiente
         and ac_tipo_cb = 'O' --Corresponsales Bancarios Red Posicionada
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_msg = 'ERROR EN LA CONSULTA, NO EXISTEN REGISTROS',
          @w_error = 2609998
        set rowcount 0
        goto CONTROL_ERROR
      end
      set rowcount 0
      return 0
    end
    if @i_modo = 3 --Corresponsales habilitados para mostrar catalogo
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 20
      select
        'Codigo' = of_oficina,
        'Nombre' = of_nombre,
        'Cliente' = ac_cliente
      from   cl_oficina,
             cl_asoc_clte_serv
      where  of_subtipo = 'O'
         and of_cob     = 9007
         and of_oficina = ac_codigo
         and ac_estado  = 'H' --Corresponsales que esten habilitados
         and ac_codigo  > @i_siguiente
         and ac_tipo_cb = 'O' --Corresponsales Bancarios Red Posicionada
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_msg = 'ERROR EN LA CONSULTA, NO EXISTEN REGISTROS',
          @w_error = 2609998
        set rowcount 0
        goto CONTROL_ERROR
      end
      set rowcount 0
      return 0
    end
    if @i_modo = 4 --Corresponsales habilitados para mostrar catalogo
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 20
      select
        'Codigo' = of_oficina,
        'Nombre' = of_nombre,
        'Cliente' = ac_cliente
      from   cl_oficina,
             cl_asoc_clte_serv
      where  of_subtipo = 'O'
         and of_cob     = 9007
         and of_oficina = ac_codigo
         and ac_estado  = 'H' --Corresponsales que esten habilitados
         and ac_codigo  = @i_codigo
         and ac_tipo_cb = 'O' --Corresponsales Bancarios Red Posicionada
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_msg =
    'ERROR EN LA CONSULTA, CORRESPONSAL NO EXISTE O NO ESTA ASOCIADO A CLIENTE',
    @w_error = 2609809
    set rowcount 0
    goto CONTROL_ERROR
    end
      set rowcount 0
      return 0
    end
    if @i_modo = 5 --Corresponsales Red Posicionada
    begin
      select
        @w_cob = pa_int
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
         and pa_nemonico = 'CCCNB'

      set rowcount 20
      select
        'Codigo' = of_oficina,
        'Nombre' = of_nombre,
        'Cliente' = ac_cliente
      from   cl_oficina,
             cl_asoc_clte_serv
      where  of_subtipo = 'O'
         and of_cob     = 9007
         and of_oficina = ac_codigo
         and ac_codigo  = @i_codigo
         and ac_tipo_cb = 'O' --Corresponsales Bancarios Red Posicionada
      order  by of_oficina

      if @@rowcount = 0
      begin
        select
          @w_msg =
    'ERROR EN LA CONSULTA, CORRESPONSAL NO EXISTE O NO ESTA ASOCIADO A CLIENTE',
    @w_error = 2609809
    set rowcount 0
    goto CONTROL_ERROR
    end
      set rowcount 0
      return 0
    end
  end -- Termina Operacion 'S1'

  --'Q1' --> Buscar el nombre (of_nombre)  de la oficina enviada por
  -- parámetro de la tabla de oficinas (cl_oficina) que sea de tipo
  -- (of_subtipo) 'O' y que pertenezcan al COB o COB'S (of_cob)
  -- parametrizados para manejo de CNB. En caso de no existir desplegar
  -- mensaje de error ******. Excluir las que ya se encuentran asociadas
  -- a alg·n cliente ( cl_asoc_clte_serv), si ya existe la relaci¾n con
  -- otro cliente desplegar mensaje de error ******

  if @i_operacion = 'Q1'
  begin
    select
      @w_cob = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
       and pa_nemonico = 'CCCNB'

    if @i_codigo is null
        or @w_cob is null
    begin
      select
        @w_error = 101249,
        @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
      goto CONTROL_ERROR
    end
    else
    begin
      if exists(select
                  1
                from   cl_oficina
                where  of_oficina = @i_codigo
                   and of_cob     = @w_cob)
      begin
        if exists(select
                    1
                  from   cl_asoc_clte_serv
                  where  ac_codigo = @i_codigo)
        begin
          select
            @w_msg = 'LA OFICINA REQUERIDA YA SE ENCUENTRA ASIGNADA',
            @w_error = 101245
          goto CONTROL_ERROR
        end
        else
        begin
          set rowcount 60
          select
            @w_nombre = of_nombre
          from   cl_oficina a
          where  of_subtipo = 'O'
             and of_oficina = @i_codigo
             and of_oficina > @i_siguiente
          order  by of_oficina

          if @@rowcount = 0
          begin
            select
              @w_msg = 'ERROR AL CONSULTAR LAS OFICINAS CB',
              @w_error = 101244
            set rowcount 0
            goto CONTROL_ERROR
          end
          set rowcount 0

          select
            @w_nombre
        end
      end
      else
      begin
        select
          @w_msg = 'LA OFICINA REQUERIDA NO EXISTE O NO ES CB',
          @w_error = 101246
        goto CONTROL_ERROR
      end
      return 0
    end
  end -- Termina Operacion 'Q1'

  if @i_operacion = 'I'
  begin
    if not exists(select
                    1
                  from   cl_ente
                  where  en_ente = @i_cliente
                     and en_categoria in (@w_tipo_cl, @w_tipo_cl_pos))
    begin
      select
        @w_error = 101253,
        @w_msg = 'CLIENTE NO EXISTE/NO ES CB'
      goto CONTROL_ERROR
    end
    if exists(select
                1
              from   cl_asoc_clte_serv
              where  ac_servicio = 'CNB'
                 and ac_codigo   = @i_codigo)
    begin
      select
        @w_error = 101247,
        @w_msg = 'CODIGO DE CB YA EXISTE'
      goto CONTROL_ERROR
    end
    else
    begin
      exec @w_error = cobis..sp_cseqnos
        @i_tabla     = 'cl_asoc_clte_serv',
        @o_siguiente = @w_sec out

      if @i_cliente is null
          or @w_sec is null
      begin
        select
          @w_error = 101249,
          @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
        goto CONTROL_ERROR
      end
      else
      begin
        if @@trancount = 0
        begin
          begin tran
          select
            @w_commit = 'S'
        end

        --Agregado campo ac_tipo_cb para Req. 381 CB III
        insert into cl_asoc_clte_serv
                    (ac_secuencial,ac_servicio,ac_cliente,ac_codigo,ac_estado,
                     ac_fecha_crea,ac_fecha_mod,ac_usuario,ac_tipo_cb)
        values      ( @w_sec,'CNB',@i_cliente,@i_codigo,'N',
                      getdate(),null,@s_user,@i_tipo_cb )

        if @@error <> 0
        begin
          select
            @w_error = 103102,
            @w_msg = 'ERROR AL INSERTAR LA RELACION CB - CLIENTE'
          goto CONTROL_ERROR
        end
        else
        begin
          select
            @w_nombre = (select
                           en_nombre
                         from   cl_ente
                         where  en_ente = @i_cliente),
            @w_apellido1 = (select
                              isnull(p_p_apellido,
                                     '')
                            from   cl_ente
                            where  en_ente = @i_cliente),
            @w_apellido2 = (select
                              isnull(p_s_apellido,
                                     '')
                            from   cl_ente
                            where  en_ente = @i_cliente),
            @w_estado = (select
                           ac_estado
                         from   cl_asoc_clte_serv
                         where  ac_cliente = @i_cliente
                            and ac_codigo  = @i_codigo),
            @w_fecha = (select
                          ac_fecha_crea
                        from   cl_asoc_clte_serv
                        where  ac_cliente = @i_cliente
                           and ac_codigo  = @i_codigo)
          insert into ts_CNB
                      (secuencial,tipo_transaccion,alterno,clase,fecha,
                       usuario,terminal,srv,lsrv,persona,
                       nombre,p_apellido,s_apellido,ofiCNB,Estado,
                       fecha_mod)
          values      ( @s_ssn,@t_trn,0,'N',@w_fecha,
                        @s_user,@s_term,@s_srv,@s_lsrv,@i_cliente,
                        @w_nombre,@w_apellido1,@w_apellido2,@i_codigo,@w_estado,
                        getdate() )
        end

        if @w_commit = 'S'
        begin
          commit tran
          select
            @w_commit = 'N'
        end

        return 0
      end
    end
  end -- Termina Operacion 'I'

  --'U' --> Validar que exista el registro que relaciona el cliente
  -- con el código de CNB. En caso de no existir desplegar mensaje
  -- de error ******.  Realizar la actualización del registro teniendo
  -- en cuenta que solo se actualiza el estado y la fecha de actualización.

  if @i_operacion = 'U'
  begin
    if @i_estado is null
        or @i_secuencial is null
    begin
      select
        @w_error = 101249,
        @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
      goto CONTROL_ERROR
    end
    else
    begin
      if not exists(select
                      1
                    from   cl_asoc_clte_serv
                    where  ac_secuencial = @i_secuencial)
      begin
        select
          @w_error = 101250,
          @w_msg = 'RELACION CLIENTE - CB NO EXISTE'
        goto CONTROL_ERROR
      end
      if @@trancount = 0
      begin
        begin tran
        select
          @w_commit = 'S'
        select
          @w_nombre = (select
                         en_nombre
                       from   cl_ente
                       where  en_ente = @i_cliente),
          @w_apellido1 = (select
                            isnull(p_p_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_apellido2 = (select
                            isnull(p_s_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_estado = (select
                         ac_estado
                       from   cl_asoc_clte_serv
                       where  ac_cliente = @i_cliente
                          and ac_codigo  = @i_codigo),
          @w_fecha = (select
                        ac_fecha_crea
                      from   cl_asoc_clte_serv
                      where  ac_cliente = @i_cliente
                         and ac_codigo  = @i_codigo)

        insert into ts_CNB
                    (secuencial,tipo_transaccion,alterno,clase,fecha,
                     usuario,terminal,srv,lsrv,persona,
                     nombre,p_apellido,s_apellido,ofiCNB,Estado,
                     fecha_mod)
        values      ( @s_ssn,@t_trn,0,'A',@w_fecha,
                      @s_user,@s_term,@s_srv,@s_lsrv,@i_cliente,
                      @w_nombre,@w_apellido1,@w_apellido2,@i_codigo,@w_estado,
                      getdate() )
      end

      update cl_asoc_clte_serv
      set    ac_estado = @i_estado,
             ac_fecha_mod = getdate()
      where  ac_secuencial = @i_secuencial

      if @@error <> 0
      begin
        select
          @w_error = 105002,
          @w_msg = 'ERROR AL ACTUALIZAR LA RELACION CB - CLIENTE'
        goto CONTROL_ERROR
      end

      if @i_tipo_cb = 'O'
      begin
        update cob_remesas..re_mantenimiento_cb
        set    mc_estado = @i_estado
        where  mc_cod_cb = @i_codigo
      end

      if @@error <> 0
      begin
        select
          @w_error = 105002,
          @w_msg = 'ERROR AL ACTUALIZAR LA RELACION CB - CLIENTE'
        goto CONTROL_ERROR
      end

      else
      begin
        select
          @w_nombre = (select
                         en_nombre
                       from   cl_ente
                       where  en_ente = @i_cliente),
          @w_apellido1 = (select
                            isnull(p_p_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_apellido2 = (select
                            isnull(p_s_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_fecha = (select
                        ac_fecha_crea
                      from   cl_asoc_clte_serv
                      where  ac_cliente = @i_cliente
                         and ac_codigo  = @i_codigo)

        insert into ts_CNB
                    (secuencial,tipo_transaccion,alterno,clase,fecha,
                     usuario,terminal,srv,lsrv,persona,
                     nombre,p_apellido,s_apellido,ofiCNB,Estado,
                     fecha_mod)
        values      ( @s_ssn,@t_trn,0,'A',@w_fecha,
                      @s_user,@s_term,@s_srv,@s_lsrv,@i_cliente,
                      @w_nombre,@w_apellido1,@w_apellido2,@i_codigo,@i_estado,
                      getdate() )
      end

      if @w_commit = 'S'
      begin
        commit tran
        select
          @w_commit = 'N'
      end

      return 0
    end
  end -- Termina Operacion 'U'

  -- 'D' -->Validar que exista el registro que relaciona el cliente con
  -- el código de CNB. En caso de no existir desplegar mensaje de error
  -- ******. Realizar la eliminación del registro teniendo en cuenta los
  -- campos ac_cliente y ac_codigo

  if @i_operacion = 'D'
  begin
    if @i_cliente is null
        or @i_codigo is null
    begin
      select
        @w_error = 101249,
        @w_msg = 'ALGUNOS DE LOS PARAMETROS NO TIENEN UN VALOR DEFINIDO'
      goto CONTROL_ERROR
    end
    else
    begin
      if not exists(select
                      1
                    from   cl_asoc_clte_serv
                    where  ac_cliente = @i_cliente
                       and ac_codigo  = @i_codigo)
      begin
        select
          @w_error = 101250,
          @w_msg = 'RELACION CLIENTE - CB NO EXISTE'
        goto CONTROL_ERROR
      end

      if exists(select
                  1
                from   cl_asoc_clte_serv
                where  ac_estado  = 'H'
                   and ac_codigo  = @i_codigo
                   and ac_cliente = @i_cliente)
      begin
        select
          @w_error = 101250,
          @w_msg =
        'RELACION CLIENTE CB SE ENCUENTRA HABILITADA, NO PUEDE ELIMINARSE'
        goto CONTROL_ERROR
      end

      if @@trancount = 0
      begin
        begin tran
        select
          @w_commit = 'S'
        select
          @w_nombre = (select
                         en_nombre
                       from   cl_ente
                       where  en_ente = @i_cliente),
          @w_apellido1 = (select
                            isnull(p_p_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_apellido2 = (select
                            isnull(p_s_apellido,
                                   '')
                          from   cl_ente
                          where  en_ente = @i_cliente),
          @w_estado = (select
                         ac_estado
                       from   cl_asoc_clte_serv
                       where  ac_cliente = @i_cliente
                          and ac_codigo  = @i_codigo),
          @w_fecha = (select
                        ac_fecha_crea
                      from   cl_asoc_clte_serv
                      where  ac_cliente = @i_cliente
                         and ac_codigo  = @i_codigo)
        insert into ts_CNB
                    (secuencial,tipo_transaccion,alterno,clase,fecha,
                     usuario,terminal,srv,lsrv,persona,
                     nombre,p_apellido,s_apellido,ofiCNB,Estado,
                     fecha_mod)
        values      ( @s_ssn,@t_trn,0,'D',@w_fecha,
                      @s_user,@s_term,@s_srv,@s_lsrv,@i_cliente,
                      @w_nombre,@w_apellido1,@w_apellido2,@i_codigo,@w_estado,
                      getdate() )
      end

      delete cl_asoc_clte_serv
      where  ac_cliente = @i_cliente
         and ac_codigo  = @i_codigo

      if @@error <> 0
      begin
        select
          @w_error = 107104,
          @w_msg = 'ERROR AL ELIMINAR LA RELACION CB - CLIENTE'
        goto CONTROL_ERROR
      end

      if @w_commit = 'S'
      begin
        commit tran
        select
          @w_commit = 'N'
      end

      return 0
    end
  end -- Termina Operacion 'D'

  CONTROL_ERROR:

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

  exec cobis..sp_cerror
    @i_num = @w_error,
    @i_msg = @w_msg

  return @w_error

go

