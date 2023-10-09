use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_desc_cliente_cc')
  drop proc sp_desc_cliente_cc
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_desc_cliente_cc
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_rol           smallint = null,
  @s_ofi           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(2),
  @i_cliente       int = null,
  @i_cta           cuenta = null,
  @i_formato_fecha int = 101
)
as
  declare
    @w_sp_name            varchar(30),
    @w_ce_ruc_pas         varchar(30),
    @w_nombre             varchar(64),
    @w_snombre            varchar(64),
    @w_apellido           varchar(64),
    @w_sapellido          varchar(64),
    @w_capellido          varchar(64),
    @w_tipo               varchar(4),
    @w_rep_legal          int,
    @w_pais               smallint,
    @w_sexo               sexo,
    @w_estado_civil       catalogo,
    @w_nit                numero,
    @w_num_hijos          tinyint,
    @w_num_cargas         tinyint,
    @w_direccion          tinyint,
    @w_telefono           tinyint,
    @w_desc_direc         varchar(254),
    @w_num_telef          varchar(16),
    @w_num_fax            varchar(16),
    @w_fecha_nac          datetime,
    @w_ciudad_nac         int,
    @w_desc_ciudad_nac    descripcion,
    @w_lugar_doc          int,
    @w_desc_lugar_doc     descripcion,
    @w_dep_doc            smallint,
    @w_desc_dep_doc       descripcion,
    @w_profesion          varchar(10),
    @w_desc_profesion     descripcion,
    @w_emp_cargo          descripcion,
    @w_empresa            descripcion,
    @w_emp_razonsocial    descripcion,
    @w_emp_telefono       varchar(20),--> gagm1050 campo telefono
    @w_act_economica      char(10),
    @w_desc_act_economica descripcion,
    @w_desc_rep_legal     descripcion,
    @w_emp_fecha_ing      datetime,
    @w_emp_fecha_salida   datetime,
    @w_rl_email           descripcion,
    @w_numPatC            varchar(15),
    @w_numRegM            int,
    @w_numFolioRegM       int,
    @w_numLibroRegM       int,
    @w_tiempo             varchar(30),--int,
    @w_fecha_const        datetime,
    @w_objetoSoc          descripcion,
    @w_desc_estado_civil  descripcion,
    @w_desc_dep_nac       descripcion,
    @w_desc_pais          descripcion,
    @w_desc_pais_nac      descripcion,
    @w_tipo_rel           smallint,
    @w_nacionalidad       descripcion,
    @w_tipo_vivienda      catalogo,
    @w_desc_tipo_vivienda descripcion,
    @w_tipo_ced           char(2),
    @w_ingre              varchar(10),
    @w_desc_en_ingre      descripcion,
    @w_actividad          catalogo,
    @w_sector             catalogo,
    @w_desc_actividad     descripcion,
    @w_direccion_emp      descripcion,
    @w_digito             char(2),
    @w_estado_cli         char(1),
    @w_razon_social       descripcion,
    @w_nombre_completo_DE varchar(254),
    @w_ente_empresa       int,
    @w_en_nacionalidad    descripcion,
    @w_actividad_ec       catalogo,
    @w_act                catalogo,
    @w_mala_refer         char(1),
    @w_tde                char(3),
    @w_abpais             varchar(10),
    @w_abclie             varchar(10),
    @w_dir                int

  /*  Inicializa Variables  */
  select
    @w_sp_name = 'sp_desc_cliente_cc'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Modo de Debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '**  Stored Procedure  ** ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_from = @t_from,
      t_file = @t_file,
      i_operacion = @i_operacion,
      i_cliente = @i_cliente
    exec cobis..sp_end_debug
  end

  select
    @w_abpais = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'ABPAIS'
     and pa_producto = 'ADM'

  if @w_abpais is null
    select
      @w_abpais = 'PA'

  select
    @w_abclie = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'CLIENT'
     and pa_producto = 'ADM'

  if @w_abclie is null
    select
      @w_abclie = ''

  /*  Encuentra la descripcion de un cliente  */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 2543
    begin
      select
        @w_act = pa_char
      from   cobis..cl_parametro
      where  pa_nemonico = 'ADPN'
         and pa_producto = 'CTE'

      select
        @w_estado_cli = 'N'

      /* LBM 08ABR2005 - Inclusion de Nueva Validacion de Clientes Bloqueados */
      select
        @w_ce_ruc_pas = case en_ced_ruc
                          when '' then p_pasaporte
                          else isnull(en_ced_ruc,
                                      p_pasaporte)
                        end,
        @w_nombre_completo_DE = en_nomlar,
        @w_razon_social = en_nomlar,
        @w_tipo = en_subtipo,
        @w_actividad_ec = en_actividad,
        @w_mala_refer = en_mala_referencia,
        @w_estado_cli = en_tipo_dp
      from   cobis..cl_ente
      where  en_ente = @i_cliente

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          /*error, no existe cliente */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        return 1
      end

      if @w_estado_cli = 'S'
         and @w_abclie <> 'BM' -- Validacion en programa de clientes
      begin
        exec cobis..sp_cerror
          /*error, cliente bloqueado */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201310
        return 1
      end

      select
        'Identificacion' = @w_ce_ruc_pas,
        'Nombre' = @w_nombre_completo_DE,
        'Tipo' = @w_tipo,
        'ac' = @w_actividad_ec,
        'Referencia' = @w_mala_refer
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  if @i_operacion = 'T'
  begin
    if @t_trn = 2543
    begin
      select
        @w_estado_cli = 'N'

      select
        @w_estado_cli = en_tipo_dp,
        @w_ce_ruc_pas = en_ced_ruc,
        @w_nombre = case en_subtipo
                      when 'C' then ltrim(rtrim(isnull(en_nomlar,
                                                       en_nombre)))
                      else ltrim(rtrim(en_nombre))
                    end,
        @w_snombre = '',
        @w_apellido = ltrim(rtrim(p_p_apellido)),
        @w_sapellido = ltrim(rtrim(p_s_apellido)),
        @w_capellido = '',
        @w_tipo = en_subtipo,
        @w_rep_legal = c_rep_legal,
        @w_pais = en_pais,
        @w_sexo = p_sexo,
        @w_estado_civil = p_estado_civil,
        @w_nit = en_nit,
        @w_fecha_nac = p_fecha_nac,
        @w_num_hijos = p_num_hijos,
        @w_num_cargas = p_num_cargas,
        @w_direccion = en_direccion,
        @w_nombre_completo_DE = en_nomlar,
        @w_razon_social = en_nomlar,
        @w_mala_refer = en_mala_referencia
      from   cobis..cl_ente
      where  en_ente = @i_cliente

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          /*error, no existe cliente */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        return 1
      end

      if @w_estado_cli = 'S'
         and @w_abclie <> 'BM' -- Validacion en programa de clientes
      begin
        exec cobis..sp_cerror
          /*error, cliente bloqueado */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201310
        return 1
      end

      if @w_ce_ruc_pas is null
          or @w_ce_ruc_pas = ''
        select
          @w_ce_ruc_pas = p_pasaporte
        from   cobis..cl_ente
        where  en_ente = @i_cliente

      select
        @w_telefono = di_telefono,
        @w_desc_direc = di_descripcion
      from   cobis..cl_direccion
      where  di_ente      = @i_cliente
         and di_direccion = @w_direccion

      select
        @w_num_telef = te_valor
      from   cobis..cl_telefono
      where  te_ente       = @i_cliente
         and te_secuencial = @w_telefono

      select
        'Identificacion' = @w_ce_ruc_pas,
        'Nombre1' = @w_nombre,
        'Nombre2' = @w_snombre,
        'Apellido1' = @w_apellido,
        'Apellido2' = @w_sapellido,
        'Apellido3' = @w_capellido,
        'Tipo' = @w_tipo,
        'Rep Legal' = @w_rep_legal,
        'Pais' = @w_pais,
        'Sexo' = @w_sexo,
        'Est Civil' = @w_estado_civil,
        'Nit' = @w_nit,
        'Fec Nac' = convert(varchar(10), @w_fecha_nac, @i_formato_fecha),
        'Hijos' = @w_num_hijos,
        'Cargas' = @w_num_cargas,
        'Direccion'= @w_desc_direc,
        'telefono' = @w_num_telef,
        'Nombre' = @w_nombre_completo_DE,
        'Referencia' = @w_mala_refer

      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  if @i_operacion = 'R'
  begin
    select
      @w_tipo_rel = pa_smallint
    from   cobis..cl_parametro
    where  pa_producto in ('CLI', 'MIS')
       and pa_nemonico = 'RL5'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101077
      return 1
    end

    if @t_trn = 2543
    begin
      select
        @w_estado_cli = 'N'

      /* LBM 08ABR2005    - Inclusion de Nueva Validacion de Clientes Bloqueados */

      select
        @w_ce_ruc_pas = en_ced_ruc,
        @w_nombre = ltrim(rtrim(en_nombre)),
        @w_snombre = '',--ltrim(rtrim(p_s_nombre)),
        @w_apellido = ltrim(rtrim(p_p_apellido)),
        @w_sapellido = ltrim(rtrim(p_s_apellido)),
        @w_capellido = '',--ltrim(rtrim(p_c_apellido)),
        @w_tipo = en_subtipo,
        @w_pais = en_pais,
        @w_sexo = p_sexo,
        @w_estado_civil = p_estado_civil,
        @w_nit = en_nit,
        @w_fecha_nac = p_fecha_nac,
        @w_num_hijos = p_num_hijos,
        @w_num_cargas = p_num_cargas,
        @w_direccion = en_direccion,
        @w_ciudad_nac = p_ciudad_nac,
        @w_lugar_doc = p_lugar_doc,
        @w_dep_doc = p_depa_emi,
        @w_profesion = p_profesion,
        @w_emp_razonsocial = en_nomlar,
        @w_act_economica = en_actividad,
        @w_numPatC = c_registro,
        @w_numRegM = 0,--c_No_RegM,
        @w_numFolioRegM = 0,--c_Folio_RegM,
        @w_numLibroRegM = 0,--c_Libro_RegM,
        @w_tiempo = isnull(datediff(m,
                                    c_fecha_const,
                                    getdate()),
                           '0'),
        @w_fecha_const = c_fecha_const,
        @w_tipo_vivienda = p_tipo_vivienda,
        @w_tipo_ced = en_tipo_ced,
        @w_desc_en_ingre = en_otringr,
        @w_actividad = en_actividad,
        @w_sector = en_sector,
        @w_digito = en_digito,
        @w_nombre_completo_DE = en_nomlar,
        @w_en_nacionalidad = (select
                                pa_nacionalidad
                              from   cobis..cl_pais
                              where  pa_pais = e.en_pais),
        @w_estado_cli = en_tipo_dp
      from   cobis..cl_ente e
      where  en_ente = @i_cliente

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          /*error, no existe cliente */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        return 1
      end

      if @w_estado_cli = 'S'
         and @w_abclie <> 'BM' -- Validacion en programa de clientes
      begin
        exec cobis..sp_cerror
          /*error, cliente bloqueado */
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201310
        return 1
      end

      --Obtiene representante legal, si y solo si es empresa
      if (@w_tipo = 'C')
      begin
        select
          @w_rep_legal = in_ente_d
        from   cobis..cl_instancia
        where  in_relacion = @w_tipo_rel
           and in_ente_i   = @i_cliente

        if @@rowcount = 0
           and @w_abclie <> 'BM' -- Validacion en programa de clientes
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101026
          return 1
        end
      end
      else
        select
          @w_rep_legal = null

      if @w_tipo = 'P'
      begin
        if @w_ce_ruc_pas is null
            or @w_ce_ruc_pas = ''
          select
            @w_ce_ruc_pas = p_pasaporte
          from   cobis..cl_ente
          where  en_ente = @i_cliente

        select
          @w_desc_ciudad_nac = ci_descripcion,
          @w_desc_dep_nac = pv_descripcion,
          @w_desc_pais_nac = b.valor
        from   cobis..cl_tabla a,
               cobis..cl_catalogo b,
               cobis..cl_ciudad c,
               cobis..cl_provincia d
        where  ci_ciudad    = @w_ciudad_nac
           and pv_provincia = ci_provincia
           and a.tabla      = 'cl_pais'
           and a.codigo     = b.tabla
           and b.codigo     = convert(char(10), pv_pais)

        select
          @w_nacionalidad = ''

        select
          @w_nacionalidad = pa_nacionalidad
        from   cobis..cl_pais
        where  pa_pais = @w_pais

        select
          @w_desc_lugar_doc = ci_descripcion
        from   cobis..cl_ciudad
        where  ci_ciudad = @w_lugar_doc

        select
          @w_desc_dep_doc = pv_descripcion
        from   cobis..cl_provincia
        where  pv_provincia = @w_dep_doc

        select
          @w_desc_profesion = X.valor
        from   cobis..cl_tabla Y,
               cobis..cl_catalogo X
        where  Y.tabla  = 'cl_profesion'
           and Y.codigo = X.tabla
           and X.codigo = @w_profesion

        select
          @w_desc_tipo_vivienda = X.valor
        from   cobis..cl_tabla Y,
               cobis..cl_catalogo X
        where  Y.tabla  = 'cl_tipo_vivienda'
           and Y.codigo = X.tabla
           and X.codigo = @w_tipo_vivienda

        select
          @w_desc_act_economica = aa_descripcion
        from   cobis..cl_asociacion_actividad
        where  aa_actividad = convert(varchar(10), @w_actividad)

        if @w_abpais = 'CO'
        begin
          set rowcount 1

          select
            @w_empresa = substring(tr_empresa,
                                   1,
                                  64),
            @w_emp_cargo = tr_cargo,
            @w_emp_fecha_ing = tr_fecha_ingreso,
            @w_emp_fecha_salida = tr_fecha_salida
          from   cobis..cl_trabajo
          where  tr_persona = @i_cliente
             and tr_fecha_salida is null

          select
            @w_tde = pa_char
          from   cobis..cl_parametro
          where  pa_nemonico = 'TDE'
             and (pa_producto = 'MIS'
                   or pa_producto = 'CLI')

          select
            @w_direccion_emp =
            ltrim(rtrim(di_descripcion)) + ', ' + case di_rural_urb when 'U'
            then
            (
            select
            pq_descripcion from
            cobis..cl_parroquia
            where pq_parroquia
            = x.di_parroquia) else di_barrio end,
            @w_dir = di_direccion
          from   cobis..cl_direccion x
          where  di_ente = @i_cliente
             and di_tipo = @w_tde

          select
            @w_emp_telefono = isnull(te_prefijo, '') + '-' + te_valor
          from   cobis..cl_telefono
          where  te_ente      = @i_cliente
             and te_direccion = @w_dir
        end
        else
        begin
          select
            @w_desc_en_ingre = X.valor
          from   cobis..cl_tabla Y,
                 cobis..cl_catalogo X
          where  Y.tabla  = 'cl_ingresos'
             and Y.codigo = X.tabla
             and X.codigo = @w_ingre

          set rowcount 1

          select
            @w_ente_empresa = isnull(tr_empresa,
                                     -999)
          --PCOELLO A VECES AQUI ES NULO Y NO ENCAJA EN CONDICIONES
          from   cobis..cl_trabajo --DE ABAJO
          where  tr_persona = @i_cliente

          set rowcount 0

          if @w_ente_empresa < 0 --Empresa no registrada en Cobis.
          begin
            select
              @w_emp_cargo = (select
                                oc_descripcion
                              from   cobis..cl_ocupacion
                              where  oc_codigo = x.tr_cargo),
              @w_empresa = tr_nombre_emp,
              @w_emp_telefono = tr_telefono,
              @w_emp_fecha_ing = tr_fecha_ingreso,
              @w_emp_fecha_salida = tr_fecha_salida,
              @w_desc_actividad = tr_objeto_emp,
              @w_direccion_emp = substring(tr_direccion_emp,
                                           1,
                                           64)
            from   cobis..cl_trabajo x
            where  tr_persona               = @i_cliente
               and isnull(tr_empresa,
                          -999) = @w_ente_empresa

          end
          else
          begin
            if @w_ente_empresa > 0
            begin
              select
                @w_emp_cargo = (select
                                  oc_descripcion
                                from   cobis..cl_ocupacion
                                where  oc_codigo = x.tr_cargo),
                @w_empresa = en_nomlar,--en_nombre,
                @w_emp_razonsocial = en_nomlar,
                @w_emp_telefono = te_valor,
                @w_emp_fecha_ing = tr_fecha_ingreso,
                @w_emp_fecha_salida = tr_fecha_salida,
                @w_direccion_emp = ltrim(rtrim(di_descripcion)) + ', ' +
                                   di_barrio
              /*,
                                       @w_desc_actividad=tr_objeto_emp,
                                       @w_direccion_emp=substring(tr_direccion_emp,1,64)*/
              from   cobis..cl_ente,
                     cobis..cl_trabajo x,
                     cobis..cl_telefono,
                     cobis..cl_direccion
              where  tr_persona    = @i_cliente
                 and tr_empresa    = @w_ente_empresa
                 and tr_empresa    = en_ente
                 and di_ente       = tr_empresa
          and te_ente       = tr_empresa
                 and te_direccion  = di_direccion
                 and te_secuencial = di_telefono
                 and di_principal  = 'S'
                 and tr_vigencia   = 'S'
            end
          end

          /* Obtener la actividad economica de la empresa */
          if @w_ente_empresa > 0
          begin
            select
              @w_desc_actividad = (select distinct
                                     (aa_descripcion)
                                   from   cobis..cl_asociacion_actividad
                                   where  aa_actividad = x.en_actividad
                                      and aa_tipo_pers = x.en_subtipo)
            from   cobis..cl_ente x
            where  en_ente = @w_ente_empresa
          end
        end

        select
          @w_desc_estado_civil = b.valor
        from   cobis..cl_tabla a,
               cobis..cl_catalogo b
        where  a.tabla  = 'cl_ecivil'
           and a.codigo = b.tabla
           and b.codigo = @w_estado_civil

        select
          @w_desc_pais = ''

        select
          @w_desc_pais = pa_descripcion
        from   cobis..cl_pais
        where  pa_pais = @w_pais

        select
          @w_rl_email = di_descripcion
        from   cobis..cl_direccion
        where  di_ente     = @i_cliente
           and di_tipo     = '001'
           and di_vigencia = 'S'

        select
          @w_ce_ruc_pas,--1
          @w_nombre,--2
          @w_snombre,--3
          @w_apellido,--4
          @w_sapellido,--5
          @w_capellido,--6
          @w_tipo,--7
          @w_rep_legal,--8
          @w_desc_pais,--9
          @w_sexo,--10
          @w_desc_estado_civil,--11
          @w_nit,--12
          convert(varchar(10), @w_fecha_nac, @i_formato_fecha),--13
          @w_num_hijos,--14
          @w_num_cargas,--15
          @w_desc_ciudad_nac,--16
          @w_desc_lugar_doc,--17
          @w_desc_dep_doc,--18
          @w_desc_profesion,--19
          @w_emp_cargo,--20
          @w_empresa,--21
          @w_emp_razonsocial,--22
          @w_emp_telefono,--23
          @w_desc_dep_nac,--24
          @w_desc_pais_nac,--25
          convert(varchar(10), @w_emp_fecha_ing, @i_formato_fecha),--26
          convert(varchar(10), @w_emp_fecha_salida, @i_formato_fecha),--27
          @w_nacionalidad,--28
          @w_desc_tipo_vivienda,--29
          @w_tipo_ced,--30
          @w_desc_en_ingre,--31
          @w_desc_act_economica,--32
          @w_desc_actividad,--33
          @w_direccion_emp,--34
          @w_rl_email,--35
          @w_digito,--36
          @w_nombre_completo_DE --37
      end

      if @w_tipo = 'C'
      begin
        /* Obtener la actividad economica de la empresa */

        select
          @w_desc_act_economica = (select distinct
                                     (aa_descripcion)
                                   from   cobis..cl_asociacion_actividad
                                   where  aa_actividad = x.en_actividad
                                      and aa_tipo_pers = x.en_subtipo)
        from   cobis..cl_ente x
        where  en_ente = @i_cliente

        select
          @w_nit = @w_ce_ruc_pas

        select
          @w_desc_rep_legal = en_nomlar,
          @w_ce_ruc_pas = isnull(en_ced_ruc,
                                 p_pasaporte)
        from   cobis..cl_ente
        where  en_ente = @w_rep_legal

        select
          @w_emp_cargo = tr_cargo,
          @w_emp_fecha_ing = tr_fecha_ingreso
        from   cobis..cl_trabajo
        where  tr_persona = @w_rep_legal
           and tr_empresa = @i_cliente

        set rowcount 1

        select
          @w_num_telef = te_valor
        from   cobis..cl_telefono
        where  te_ente          = @w_rep_legal
           and te_tipo_telefono = 'T'

        set rowcount 1
        select
          @w_num_fax = te_valor
        from   cobis..cl_telefono
        where  te_ente          = @w_rep_legal
           and te_tipo_telefono = 'F'

        set rowcount 1
        select
          @w_rl_email = di_descripcion
        from   cl_direccion
        where  di_ente     = @w_rep_legal
           and di_tipo     = '001'
           and di_vigencia = 'S'

        select
          @w_objetoSoc = ob_linea
        from   cl_objeto_com
        where  ob_compania = @i_cliente

        select
          @w_desc_pais = ''

        select
          @w_desc_pais = pa_descripcion
        from   cobis..cl_pais
        where  pa_pais = @w_pais

        select
          @w_nombre,
          @w_desc_act_economica,
          @w_emp_razonsocial,
          @w_desc_rep_legal,
          @w_desc_pais,--@w_pais,
          @w_ce_ruc_pas,
          @w_tipo,
          @w_num_telef,
          @w_num_fax,
          @w_emp_cargo,
          @w_rl_email,
          convert(varchar(10), @w_emp_fecha_ing, @i_formato_fecha),
          @w_ce_ruc_pas,
          @w_numPatC,
          @w_numRegM,
          @w_numFolioRegM,
          @w_numLibroRegM,
          @w_tiempo,
          convert(varchar(10), @w_fecha_const, @i_formato_fecha),
          @w_objetoSoc,
          @w_nit,
          @w_tipo_ced,--22
          @w_digito --23
      end

      select
        isnull(B.ba_descripcion,
               co_institucion),
        datediff(yy,
                 A.ec_fec_apertura,
                 A.ec_fec_exp_ref),
        A.re_sucursal,
        C.valor,
        A.re_telefono
      from   cl_catalogo C,
             cl_tabla D,
             cl_referencia A
             left outer join cl_banco_rem B
                          on isnull(ec_banco,
                                    fi_banco) = ba_banco
      where  re_ente                    = @i_cliente
         and re_tipo in ('B', 'C')
         and C.tabla                    = D.codigo
         and D.tabla                    = 'cl_tipo_cuenta'
         and isnull(A.ec_tipo_cta,
                    'OT') = C.codigo
      order  by A.re_referencia

      set rowcount 3

      select
        ba_descripcion
      from   cl_banco_rem,
             cl_economica
      where  ba_banco = banco
         and ente     = @i_cliente
         and vigencia = 'S'
         and tipo     = 'B'

      set rowcount 0
      select
        'REF. PERSONAL',
        0,--Dato tiempo de relacion
        ltrim(rtrim(isnull(rp_nombre, '') + ' ' + isnull(rp_p_apellido, '') +
                    ' '
                    +
                    isnull(
                          rp_s_apellido, ''))),
        (select
           valor
         from   cobis..cl_tabla a,
                cobis..cl_catalogo b
         where  a.tabla  = 'cl_parentesco'
            and a.codigo = b.tabla
            and b.codigo = x.rp_parentesco),
        case
          --< se agregan celular de las referencia. gagm1050. 03abr2007
          when (rp_telefono_d <> null
                and rp_telefono_e is not null
                and rp_telefono_o is not null) then
          rp_telefono_d + ' / ' + rp_telefono_e + '/' + rp_telefono_o
          when (rp_telefono_d is null
                and rp_telefono_e is not null
                and rp_telefono_o is not null) then
          rp_telefono_e + '/' + rp_telefono_o
          when (rp_telefono_d <> null
                and rp_telefono_o is not null
                and rp_telefono_e is null) then
          rp_telefono_d + '/' + rp_telefono_o
          when (rp_telefono_d is null
                and rp_telefono_o is not null
                and rp_telefono_e is null) then rp_telefono_o
          when (rp_telefono_d is null
                and rp_telefono_o is null
                and rp_telefono_e <> null) then rp_telefono_e
          when (rp_telefono_d <> null
                and rp_telefono_o is null
                and rp_telefono_e is null) then rp_telefono_d
        --> se agregan celular de las referencia. gagm1050 03abr2007
        end
      from   cobis..cl_ref_personal x
      where  rp_persona = @i_cliente

      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end
  
go

