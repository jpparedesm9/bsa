/************************************************************************/
/*  Archivo:            cl_autnr.sp                                     */
/*  Stored procedure:   sp_autoriza_norestrictivas                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           MIS                                             */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa para llenar la pantalla FApLista.frm del modulo de    */
/*  clientes                                                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR               RAZON                           */
/*  18/Feb/2010     Wilson Romero       Emision Inicial                 */
/*  27/Sept/2013    Oscar Saavedra      ORS 620 - Mensajes Sarlaft      */
/*  02/May/2016     DFu                 Migracion CEN                   */
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
           where  name = 'sp_autoriza_norestrictivas')
  drop proc sp_autoriza_norestrictivas
go

---INC 111076  ABR.25.2013
create proc sp_autoriza_norestrictivas
  @s_ssn              int = null,
  @s_user             login = null,
  @s_term             varchar(30) = null,
  @s_date             datetime = null,
  @s_srv              varchar(30) = null,
  @s_lsrv             varchar(30) = null,
  @s_ofi              smallint = null,
  @s_rol              smallint = null,
  @t_debug            char(1) = 'N',
  @t_file             varchar(10) = null,
  @t_from             varchar(32) = null,
  @t_trn              smallint = null,
  @t_show_version     bit = 0,
  @i_operacion        char(1),
  @i_codigo           int = 0,
  @i_cliente          int = null,
  @i_observacion      varchar(255) = null,
  @i_modo             tinyint = null,
  @o_autorizacion     char(1) = null output,
  @o_fu_nombre        varchar(100) = null output,
  @i_autorizado       char(1) = null,
  @i_tipo_usuario     char(1) = null,
  @i_usr_autorizacion varchar(30) = null,
  @i_cargo            varchar(30) = null,
  @i_formato_fecha    int = null,
  @i_tipo             char(1) = 'N',
  @i_ced_ruc          char(13) = '%',
  @i_nombre           varchar(37) = '%',
  @i_nombre2          varchar(37) = null,
  @i_nomlar           varchar(64) = null
as
  declare
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_error              varchar(25),
    @w_max_data           int,
    @w_cliente            int,
    @w_bandera            int,
    @w_fecha              datetime,
    @w_moneda             smallint,
    @w_conta_rango        smallint,
    @w_abreviatura        char(3),
    @w_abreviatura_tmp    char(3),
    @w_forma_hom          varchar(10),
    @w_forma_hom_tmp      varchar(10),
    @w_producto           char(3),
    @w_producto_tmp       char(3),
    @w_co_forma           varchar(10),
    @w_co_forma_tmp       varchar(10),
    @w_contador           int,
    @w_today              datetime,
    @w_aut_sarlaft        varchar(10),
    @w_aut_comercial      varchar(10),
    @w_cargo              varchar(10),
    @w_tipo_id            char(2),
    @w_nro_id             char(13),
    @w_nombrelargo        varchar(100),
    @w_origen_refinh      varchar(10),
    @w_estado_refinh      varchar(10),
    @w_fecha_refinh       datetime,
    @w_fecha_ref          datetime,
    @w_desc_tipo          varchar(30),
    @w_descr_autorizado   varchar(10),
    @w_codigo             smallint,
    @w_estado             smallint,
    @w_parlista           varchar(10),
    @w_con_estado_sarlaft char(1),
    @w_con_estado_ccial   char(1),
    @w_valida_total       char(1),
    @w_subtipo            char(1),
    @w_tipo_ced           char(2),
    @w_codautoriza        int,
    @w_inhib              int,
    @w_inhmer             int,
    @w_today_aut          datetime,
    @w_codigo_ri          int,
    @w_restrictiva        varchar(10),
    @w_msg                varchar(255)

  select
    @w_sp_name = 'sp_autoriza_norestrictivas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set @i_formato_fecha = 103
  set @w_aut_sarlaft = null
  set @w_aut_comercial = null

  if @i_codigo is null
    set @i_codigo = 0

  select
    @w_today = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_today_aut = getdate()

  select
    @w_contador = 0

  select
    @w_codigo = codigo
  from   cl_tabla
  where  tabla = 'cl_refinh_sarlaft'

  select
    @w_estado = codigo
  from   cl_tabla
  where  tabla = 'cl_estado_refinh_sarlaft'

  --parametro listas no restrictivas
  select
    @w_parlista = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LNRES'

  -- Se contara con un control dual que requiere dos aprobaciones una de un nivel superior 
  -- (Director Zonal, Gerente Territorial o Vicepresidente Comercial). 
  -- Y la otra corresponde a la aprobaci¾n del ßrea de SARLAFT (Oficial de Cumplimiento). 

  -- Consultar si ejecutivo tiene permisos para sarlaft o para nivel superior
  if @i_operacion = 'S'
  begin
    select
      @w_cargo = fu_cargo
    from   cobis..cl_funcionario
    where  fu_login = @s_user
    --and   fu_oficina  = @s_ofi

    if @w_cargo is null
      select
        @w_cargo = ''

    select
      @o_autorizacion = '0'

    --  VALIDACION POR CATALOGO  --> SARLAFT 
    select
      @w_aut_sarlaft = cl_catalogo.codigo
    from   cobis..cl_tabla,
           cobis..cl_catalogo
    where  cl_tabla.tabla     = 'cl_aut_sarlaft'
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_catalogo.codigo = @w_cargo

    -- el codigo de  --> COMERCIAL 
    select
      @w_aut_comercial = cl_catalogo.codigo
    from   cobis..cl_tabla,
           cobis..cl_catalogo
    where  cl_tabla.tabla     = 'cl_aut_comercial'
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_catalogo.codigo = @w_cargo

    if @w_aut_sarlaft is not null
    begin
      select
        @o_autorizacion = '1'
    end

    if @w_aut_comercial is not null
    begin
      select
        @o_autorizacion = '2'
    end

  end -- fin operacion = 'S'

  ---/*************************************************************/
  -- Retornar datos de un funcionario
  ---/*************************************************************/
  if @i_operacion = 'F'
  begin
    if @i_cargo is null
    begin
      select
        @w_cargo = '',
        @o_fu_nombre = ''
    end

    select
      @w_cargo = fu_cargo,
      @o_fu_nombre = fu_nombre
    from   cobis..cl_funcionario
    where  fu_login = @i_cargo

    select
      fu_cargo,
      fu_nombre,
      ''
    from   cobis..cl_funcionario
    where  fu_login = @i_cargo

  end

  ---/*************************************************************/
  -- Retornar datos de para determinar si ya posee la autorizacion dual
  ---/*************************************************************/
  if @i_operacion = 'E'
  begin
    set @w_valida_total = 'N'
    set @w_subtipo = ''
    set @w_tipo_ced = null

    select
      @w_valida_total = isnull(as_valida_total,
                               'N')
    from   cobis..cl_autoriza_sarlaft_lista
    where  as_sec_refinh = @i_codigo

    select
      @w_subtipo = in_subtipo,
      @w_tipo_ced = in_tipo_ced
    from   cl_refinh
    where  in_codigo = @i_codigo

    select
      @w_valida_total,
      @w_subtipo,
      @w_tipo_ced
  end

  ---/*************************************************************/
  -- Manejo para datos que aun no han sido aprobados o rechazados
  ---/*************************************************************/

  -- se retorna el listado de clientes no restrictibos sin aprobacion
  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1046
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    select
      @w_nro_id = en_ced_ruc
    from   cobis..cl_ente
    where  en_ente = @i_codigo

    if @w_nro_id is not null
       and @w_nro_id <> ''
    begin ---3
      if exists (select
                   1
                 from   cobis..cl_refinh
                 where  in_ced_ruc = @w_nro_id
                    and in_codigo not in
                        (select
                           as_sec_refinh
                         from   cobis..cl_autoriza_sarlaft_lista)
                )
      begin ---2
        select
          *
        into   #autorizacion_sarlaft
        from   cobis..cl_refinh
        where  in_ced_ruc = @w_nro_id
        order  by in_codigo

        while 1 = 1
        begin ---1
          select top 1
            @w_codigo_ri = in_codigo,
            @w_nombrelargo = in_nomlar,
            @w_nro_id = in_ced_ruc,
            @w_tipo_ced = in_tipo_ced,
            @w_origen_refinh = in_origen,
            @w_estado_refinh = in_estado,
            @w_fecha_refinh = in_fecha_ref
          from   #autorizacion_sarlaft
          order  by in_codigo

          if @@rowcount = 0
            break

          if not exists (select
                           1
                         from   cl_autoriza_sarlaft_lista
                         where  as_sec_refinh = @w_codigo_ri)
          begin
            insert into cl_autoriza_sarlaft_lista
                        (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
                         as_origen_refinh,
                         as_estado_refinh,as_fecha_refinh)
            values      (@w_codigo_ri,@w_tipo_ced,@w_nro_id,@w_nombrelargo,
                         @w_origen_refinh,
                         @w_estado_refinh,@w_fecha_refinh)

            if @@error <> 0
              print 'Error: Ingresando Autorizacion Sarlaft COD: ' + cast(
                    @w_codigo_ri
                    as
                    varchar
                    )
          end

          delete #autorizacion_sarlaft
          where  in_codigo = @w_codigo_ri
        end ---1
      end ---2
    end --3

    select
      @w_origen_refinh = as_origen_refinh,
      @w_estado_refinh = as_estado_refinh,
      @w_fecha_ref = as_fecha_refinh
    from   cl_autoriza_sarlaft_lista
    where  as_nro_id = @w_nro_id
    order  by 3 desc

    --ORS 620 - Detalle Mensaje Frontend
    if @@rowcount > 0
    begin
      select
        ms_restrictiva,
        ms_origen
      into   #Sarlaft
      from   cobis..cl_manejo_sarlaft

      if @w_origen_refinh = '029'
        select
          @w_msg =
        'Cliente PEP, solicite autorizacion (SARLAFT y Gerente Zonal)'

      if (@w_origen_refinh in
          (select
             ms_origen
           from   #Sarlaft
           where  ms_restrictiva = '002'))
         and (@w_origen_refinh <> '029')
        select
          @w_msg =
        'Cliente requiere autorizacion, favor comuniquese con SARLAFT'

      if (@w_origen_refinh in
          (select
             ms_origen
           from   #Sarlaft
           where  ms_restrictiva = '001'))
         and (@w_origen_refinh <> '019')
        select
          @w_msg = 'Cliente NO objetivo'

      if @w_origen_refinh = '019'
        select
          @w_msg =
        'Cliente requiere autorizacion, favor comuniquese con SARLAFT'

    end

    set rowcount 20
    if @i_modo = 0
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Ente      ' = en_ente,
        'Tipo ID' = as_tipo_id,
        'Descrip. Documento' = (select
                                  ct_descripcion
                                from   cobis..cl_tipo_documento
                                where  ct_codigo = as_tipo_id),
        'Número ID' = as_nro_id,
        'Nombre' = en_nomlar,
        'Origen' = as_origen_refinh,
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Estado' = as_estado_refinh,
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = en_oficina,
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Maneja Rec Publico(PEP)' = en_recurso_pub,
        'Influye Politica(PEP)' = en_influencia,
        'Personaje Publico(PEP)' = en_persona_pub,
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a,
             cobis..cl_ente
      where  as_sec_refinh >= @i_codigo
         and as_valida_total is null
         and as_origen_refinh in
             (select
                ms_origen
              from   cl_manejo_sarlaft
              where  ms_restrictiva = @w_parlista)
         and as_nro_id     = en_ced_ruc
      union
      select
        'Secuencial' = as_sec_refinh,
        'Ente      ' = en_ente,
        'Tipo ID' = as_tipo_id,
        'Descrip. Documento' = (select
                                  ct_descripcion
                                from   cobis..cl_tipo_documento
                                where  ct_codigo = as_tipo_id),
        'Número ID' = as_nro_id,
        'Nombre' = en_nomlar,
        'Origen' = as_origen_refinh,
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Estado' = as_estado_refinh,
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = en_oficina,
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Maneja Rec Publico(PEP)' = en_recurso_pub,
        'Influye Politica(PEP)' = en_influencia,
        'Personaje Publico(PEP)' = en_persona_pub,
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a,
             cobis..cl_ente
      where  as_sec_refinh   >= @i_codigo
         and as_valida_total = 'N'
         and as_origen_refinh in
             (select
                ms_origen
              from   cl_manejo_sarlaft
              where  ms_restrictiva = @w_parlista)
         and as_nro_id       = en_ced_ruc
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end -- modo 0

    if @i_modo = 1
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Ente      ' = en_ente,
        'Tipo ID' = as_tipo_id,
        'Descrip. Documento' = (select
                                  ct_descripcion
                                from   cobis..cl_tipo_documento
                                where  ct_codigo = as_tipo_id),
        'Número ID' = as_nro_id,
        'Nombre' = en_nomlar,
        'Origen' = as_origen_refinh,
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Estado' = as_estado_refinh,
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = en_oficina,
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Maneja Rec Publico(PEP)' = en_recurso_pub,
        'Influye Politica(PEP)' = en_influencia,
        'Personaje Publico(PEP)' = en_persona_pub,
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a,
             cobis..cl_ente
      where  as_sec_refinh   > @i_codigo
         and (as_valida_total = 'N'
               or as_valida_total is null)
         and as_origen_refinh in
             (select
                ms_origen
              from   cl_manejo_sarlaft
              where  ms_restrictiva = @w_parlista)
         and as_nro_id       = en_ced_ruc
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end --- fin modo 1

    if @i_modo = 2
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Ente      ' = en_ente,
        'Tipo ID' = as_tipo_id,
        'Descrip. Documento' = (select
                                  ct_descripcion
                                from   cobis..cl_tipo_documento
                                where  ct_codigo = as_tipo_id),
        'Número ID' = as_nro_id,
        'Nombre' = en_nomlar,
        'Origen' = as_origen_refinh,
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Estado' = as_estado_refinh,
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = en_oficina,
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Maneja Rec Publico(PEP)' = en_recurso_pub,
        'Influye Politica(PEP)' = en_influencia,
        'Personaje Publico(PEP)' = en_persona_pub,
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a,
             cobis..cl_ente
      where  en_ente         = @i_codigo
         and (as_valida_total = 'N'
               or as_valida_total is null)
         and as_origen_refinh in
             (select
                ms_origen
              from   cl_manejo_sarlaft
              where  ms_restrictiva = @w_parlista)
         and as_nro_id       = en_ced_ruc
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = @w_msg,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end -- fin modo 2
  end -- fin operacion = 'C'

  ---/*************************************************************/
  -- Solo se muestran datos que YA fueron aprobados o rechazados
  ---/*************************************************************/
  if @i_operacion = 'H'
  begin
    set rowcount 20
    if @i_modo = 0
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Tipo ID' = as_tipo_id,
        'N·mero ID' = as_nro_id,
        'Nombre' = en_nomlar,
        'Origen' = as_origen_refinh,
        'Estado' = as_estado_refinh,
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = as_oficina,
        'Descrip. Documento'= (select
                                 ct_descripcion
                               from   cobis..cl_tipo_documento
                               where  ct_codigo = as_tipo_id),
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a,
             cobis..cl_ente
      where  as_sec_refinh >= @i_codigo
         and as_aut_sarlaft in ('S', 'N')
         and as_aut_cial in ('S', 'N')
         and as_nro_id     = en_ced_ruc
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end -- modo 0

    if @i_modo = 1
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Tipo ID' = as_tipo_id,
        'N·mero ID' = as_nro_id,
        'Nombre' = as_nombrelargo,
        'Origen' = as_origen_refinh,
        'Estado' = as_estado_refinh,
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = as_oficina,
        'Descrip. Documento'= (select
                                 ct_descripcion
                               from   cobis..cl_tipo_documento
                               where  ct_codigo = as_tipo_id),
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a
      where  as_sec_refinh > @i_codigo
         and as_aut_sarlaft in ('S', 'N')
         and as_aut_cial in ('S', 'N')
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end --- fin modo 1

    if @i_modo = 2
    begin
      select
        'Secuencial' = as_sec_refinh,
        'Tipo ID' = as_tipo_id,
        'N·mero ID' = as_nro_id,
        'Nombre' = as_nombrelargo,
        'Origen' = as_origen_refinh,
        'Estado' = as_estado_refinh,
        'Aut. Sarlaft' = as_aut_sarlaft,
        'Obs. Sarlaft' = as_obs_sarlaft,
        'Usr. Sarlaft' = as_usr_sarlaft,
        'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha),
        'Aut. Comercial' = as_aut_cial,
        'Obs. Comercial' = as_obs_cial,
        'Usr. Comercial' = as_usr_cial,
        'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha),
        'Valida' = as_valida_total,
        'Oficina' = as_oficina,
        'Descrip. Documento'= (select
                                 ct_descripcion
                               from   cobis..cl_tipo_documento
                               where  ct_codigo = as_tipo_id),
        'Fecha Referencia' = convert(char(10), as_fecha_refinh, @i_formato_fecha
                             ),
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_origen_refinh
                                   and tabla  = @w_codigo),
        'Descripcion Estado' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.as_estado_refinh
                                   and tabla  = @w_estado),
        'Hora Sarlaft' = as_fecha_sarlaft,
        'Hora Comercial' = as_fecha_cial
      from   cobis..cl_autoriza_sarlaft_lista a
      where  as_sec_refinh = @i_codigo
         and as_aut_sarlaft in ('S', 'N')
         and as_aut_cial in ('S', 'N')
      order  by as_sec_refinh

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end
    end -- fin modo 2
  end -- operacion 'H'  historico

  --esta operacion actualiza el usuario sarlaft o comercial, las observaciones

  if @i_operacion = 'U'
  begin
    select
      @w_tipo_id = as_tipo_id,
      @w_nro_id = as_nro_id,
      @w_nombrelargo = as_nombrelargo,
      @w_origen_refinh = as_origen_refinh,
      @w_estado_refinh = as_estado_refinh,
      @w_fecha_refinh = as_fecha_refinh
    from   cobis..cl_autoriza_sarlaft_lista,
           cobis..cl_refinh
    where  as_sec_refinh = in_codigo
       and as_sec_refinh = @i_codigo
    --in_entid       = @w_codautoriza

    if @i_autorizado = 'S'
    begin
      select
        @w_descr_autorizado = 'APROBADO'
    end
    if @i_autorizado = 'N'
    begin
      select
        @w_descr_autorizado = 'RECHAZADO'
    end

    if @i_tipo_usuario = '1'
    begin -- usuario Sarlaft
      select
        @w_desc_tipo = 'AUTORIZACION SARLAFT'
      update cobis..cl_autoriza_sarlaft_lista
      set    as_aut_sarlaft = @i_autorizado,
             as_obs_sarlaft = @i_observacion,
             as_usr_sarlaft = @s_user,
             as_fecha_sarlaft = @w_today_aut
      from   cobis..cl_autoriza_sarlaft_lista,
             cobis..cl_refinh
      where  as_sec_refinh = in_codigo
         and as_sec_refinh = @i_codigo
      --in_entid       = @w_codautoriza

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 105514
        --'No Existen Registros'
        return 105514
      end
    end

    else if @i_tipo_usuario = '2'
    begin -- usuario Comercial
      select
        @w_desc_tipo = 'AUTORIZACION COMERCIAL'

      update cobis..cl_autoriza_sarlaft_lista
      set    as_aut_cial = @i_autorizado,
             as_obs_cial = @i_observacion,
             as_usr_cial = @s_user,
             as_fecha_cial = @w_today_aut,
             as_oficina = @s_ofi
      from   cobis..cl_autoriza_sarlaft_lista,
             cobis..cl_refinh
      where  as_sec_refinh = in_codigo
         and as_sec_refinh = @i_codigo
      --in_entid       = @w_codautoriza

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 105514
        --'No Existen Registros'
        return 105514
      end
    end

    ------------/*Transaccion de Servicio*/
    insert into ts_aut_sarlaft_lista
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,tipo_documento,ced_ruc,
                 nombre,fecha_ref,origen,estado,tipo_aprobacion,
                 Descr_aprobacion,estado_autorizacion,descr_autorizacion,
                 observacion
                 ,fecha_mod,
                 ref_estado,oficina)
    values      ( @i_codigo,@t_trn,'N',getdate(),@s_user,
                  @s_term,@s_srv,@s_lsrv,@w_tipo_id,@w_nro_id,
                  @w_nombrelargo,@w_fecha_refinh,@w_origen_refinh,
                  @w_estado_refinh
                  ,
                  @i_tipo_usuario,
                  @w_desc_tipo,@i_autorizado,@w_descr_autorizado,@i_observacion,
                  @w_today,
                  'U',@s_ofi )
    -- @s_ssn
    /* Si no puede insertar , enviar el error*/
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 903002
      return 1
    end
    select
      @w_con_estado_sarlaft = as_aut_sarlaft,
      @w_con_estado_ccial = as_aut_cial
    from   cobis..cl_autoriza_sarlaft_lista,
           cobis..cl_refinh
    where  as_sec_refinh = in_codigo
       and as_sec_refinh = @i_codigo
    --in_entid       = @w_codautoriza

    if (@w_con_estado_sarlaft = 'S'
         or @w_con_estado_sarlaft = 'N')
       and (@w_con_estado_ccial = 'S'
             or @w_con_estado_ccial = 'N')
    begin
      update cobis..cl_autoriza_sarlaft_lista
      set    as_valida_total = 'S'
      from   cobis..cl_refinh,
             cobis..cl_autoriza_sarlaft_lista
      where  as_sec_refinh = in_codigo
         and as_sec_refinh = @i_codigo
      --in_entid       = @w_codautoriza

      if @@error <> 0
      begin
        exec sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 105514
        --Error en la Actualizacion del registro!!!
        return 710568
      end

      if (@w_con_estado_sarlaft = 'S'
          and @w_con_estado_ccial = 'S')
      begin
        if exists (select
                     1
                   from   cobis..cl_refinh
                   where  in_codigo = @i_codigo)
        begin
          delete cobis..cl_refinh
          where  in_codigo = @i_codigo
        end

        select
          @w_inhib = isnull(count(0),
                            0)
        from   cobis..cl_refinh
        where  in_ced_ruc = @w_nro_id

        select
          @w_inhmer = isnull(count(0),
                             0)
        from   cobis..cl_mercado
        where  me_ced_ruc = @w_nro_id

        select
          @w_contador = @w_inhib + @w_inhmer

        if @w_contador = 0
        begin
          update cobis..cl_ente
          set    en_mala_referencia = 'N',
                 en_cont_malas = @w_contador
          where  en_ced_ruc = @w_nro_id
        end

        if @w_contador > 0
        begin
          update cobis..cl_ente
          set    en_mala_referencia = 'S',
                 en_cont_malas = @w_contador
          where  en_ced_ruc = @w_nro_id
        end
      end
    end
  end --- fin operacion = 'U'   

/************************************
************************************
*************************************/
  ---/*************************************************************/
  -- Retornar datos del cliente con funcion F5 para aprobacion 
  -- que falta alguana aprobacion orechazo de alguno de las dos personas autorizadas.la autorizacion es dual
  ---/*************************************************************/
  if @i_operacion = 'B'
  begin
    set rowcount 20
    if @i_tipo = 'C' /*BUSQUEDA POR NUMERO DE DOCUMENTO*/
    begin
      if @i_modo = 0
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Ente      ' = en_ente,
          'Tipo ID' = as_tipo_id,
          'Descrip. Documento' = (select
                                    ct_descripcion
                                  from   cobis..cl_tipo_documento
                                  where  ct_codigo = as_tipo_id),
          'Número ID' = as_nro_id,
          'Nombre' = en_nomlar,
          'Origen' = as_origen_refinh,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_origen_refinh
                                     and tabla  = @w_codigo),
          'Estado' = as_estado_refinh,
          'Descripcion Estado' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_estado_refinh
                                     and tabla  = @w_estado),
          'Aut. Sarlaft' = as_aut_sarlaft,
          'Obs. Sarlaft' = as_obs_sarlaft,
          'Usr. Sarlaft' = as_usr_sarlaft,
          'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha
                            ),
          'Aut. Comercial' = as_aut_cial,
          'Obs. Comercial' = as_obs_cial,
          'Usr. Comercial' = as_usr_cial,
          'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha)
          ,
          'Valida' = as_valida_total,
          'Oficina' = en_oficina,
          'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                               @i_formato_fecha
                               ),
          'Maneja Rec Publico(PEP)' = en_recurso_pub,
          'Influye Politica(PEP)' = en_influencia,
          'Personaje Publico(PEP)' = en_persona_pub
        from   cobis..cl_autoriza_sarlaft_lista a,
               cobis..cl_ente
        where  as_sec_refinh   >= @i_codigo
           and (as_valida_total = 'N'
                 or as_valida_total is null)
           and as_origen_refinh in
               (select
                  ms_origen
                from   cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)
           and as_nro_id       = en_ced_ruc
           --      and   as_tipo_id     = en_tipo_ced
           and as_nro_id like ltrim(rtrim( @i_ced_ruc)) + '%'
        order  by as_nro_id --, in_codigo
      end
      else
      begin
        if @i_modo = 1
          select
            'Secuencial' = as_sec_refinh,
            'Ente      ' = en_ente,
            'Tipo ID' = as_tipo_id,
            'Descrip. Documento' = (select
                                      ct_descripcion
                                    from   cobis..cl_tipo_documento
                                    where  ct_codigo = as_tipo_id),
            'Número ID' = as_nro_id,
            'Nombre' = en_nomlar,
            'Origen' = as_origen_refinh,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.as_origen_refinh
                                       and tabla  = @w_codigo),
            'Estado' = as_estado_refinh,
            'Descripcion Estado' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.as_estado_refinh
                                       and tabla  = @w_estado),
            'Aut. Sarlaft' = as_aut_sarlaft,
            'Obs. Sarlaft' = as_obs_sarlaft,
            'Usr. Sarlaft' = as_usr_sarlaft,
            'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft,
                              @i_formato_fecha
                              ),
            'Aut. Comercial' = as_aut_cial,
            'Obs. Comercial' = as_obs_cial,
            'Usr. Comercial' = as_usr_cial,
            'Fecha Comercial' = convert(char(10), as_fecha_cial,
                                @i_formato_fecha)
            ,
            'Valida' = as_valida_total,
            'Oficina' = en_oficina,
            'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                                 @i_formato_fecha
                                 ),
            'Maneja Rec Publico(PEP)' = en_recurso_pub,
            'Influye Politica(PEP)' = en_influencia,
            'Personaje Publico(PEP)' = en_persona_pub
          from   cobis..cl_autoriza_sarlaft_lista a,
                 cobis..cl_ente
          where  as_origen_refinh in
                 (select
                    ms_origen
                  from   cl_manejo_sarlaft
                  where  ms_restrictiva = @w_parlista)
                 and as_sec_refinh   >= @i_codigo
                 and (as_valida_total = 'N'
                       or as_valida_total is null)
                 and as_nro_id       = en_ced_ruc
                 --      and   as_tipo_id     = en_tipo_ced
                 and as_nro_id       > @i_ced_ruc
          order  by as_nro_id
        else
          select
            'Secuencial' = as_sec_refinh,
            'Ente      ' = en_ente,
            'Tipo ID' = as_tipo_id,
            'Descrip. Documento' = (select
                                      ct_descripcion
                                    from   cobis..cl_tipo_documento
                                    where  ct_codigo = as_tipo_id),
            'Número ID' = as_nro_id,
            'Nombre' = en_nomlar,
            'Origen' = as_origen_refinh,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.as_origen_refinh
                                       and tabla  = @w_codigo),
            'Estado' = as_estado_refinh,
            'Descripcion Estado' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.as_estado_refinh
                                       and tabla  = @w_estado),
            'Aut. Sarlaft' = as_aut_sarlaft,
            'Obs. Sarlaft' = as_obs_sarlaft,
            'Usr. Sarlaft' = as_usr_sarlaft,
            'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft,
                              @i_formato_fecha
                              ),
            'Aut. Comercial' = as_aut_cial,
            'Obs. Comercial' = as_obs_cial,
            'Usr. Comercial' = as_usr_cial,
            'Fecha Comercial' = convert(char(10), as_fecha_cial,
                                @i_formato_fecha)
            ,
            'Valida' = as_valida_total,
            'Oficina' = en_oficina,
            'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                                 @i_formato_fecha
                                 ),
            'Maneja Rec Publico(PEP)' = en_recurso_pub,
            'Influye Politica(PEP)' = en_influencia,
            'Personaje Publico(PEP)' = en_persona_pub
          from   cobis..cl_autoriza_sarlaft_lista a,
                 cobis..cl_ente
          where  as_origen_refinh in
                 (select
                    ms_origen
                  from   cl_manejo_sarlaft
                  where  ms_restrictiva = @w_parlista)
                 and as_sec_refinh   >= @i_codigo
                 and (as_valida_total = 'N'
                       or as_valida_total is null)
                 and as_nro_id       = en_ced_ruc
                 --      and   as_tipo_id     = en_tipo_ced
                 and as_nro_id       = @i_ced_ruc
          order  by as_nro_id
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
    end

    if @i_tipo = 'N'
    begin --tipo N /*BUSQUEDA POR NOMBRE */
      if @i_modo = 0
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Ente      ' = en_ente,
          'Tipo ID' = as_tipo_id,
          'Descrip. Documento' = (select
                                    ct_descripcion
                                  from   cobis..cl_tipo_documento
                                  where  ct_codigo = as_tipo_id),
          'Número ID' = as_nro_id,
          'Nombre' = en_nomlar,
          'Origen' = as_origen_refinh,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_origen_refinh
                                     and tabla  = @w_codigo),
          'Estado' = as_estado_refinh,
          'Descripcion Estado' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_estado_refinh
                                     and tabla  = @w_estado),
          'Aut. Sarlaft' = as_aut_sarlaft,
          'Obs. Sarlaft' = as_obs_sarlaft,
          'Usr. Sarlaft' = as_usr_sarlaft,
          'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha
                            ),
          'Aut. Comercial' = as_aut_cial,
          'Obs. Comercial' = as_obs_cial,
          'Usr. Comercial' = as_usr_cial,
          'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha)
          ,
          'Valida' = as_valida_total,
          'Oficina' = en_oficina,
          'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                               @i_formato_fecha
                               ),
          'Maneja Rec Publico(PEP)' = en_recurso_pub,
          'Influye Politica(PEP)' = en_influencia,
          'Personaje Publico(PEP)' = en_persona_pub
        from   cobis..cl_autoriza_sarlaft_lista a,
               cobis..cl_ente
        where  as_origen_refinh in
               (select
                  ms_origen
                from   cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)
               and as_sec_refinh   >= @i_codigo
               and (as_valida_total = 'N'
                     or as_valida_total is null)
               and as_nro_id       = en_ced_ruc
               --      and   as_tipo_id     = en_tipo_ced
               and en_nomlar like ltrim(rtrim(@i_nombre)) + '%'
        order  by en_nomlar
      end
      else if @i_modo = 1
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Ente      ' = en_ente,
          'Tipo ID' = as_tipo_id,
          'Descrip. Documento' = (select
                                    ct_descripcion
                                  from   cobis..cl_tipo_documento
                                  where  ct_codigo = as_tipo_id),
          'Número ID' = as_nro_id,
          'Nombre' = en_nomlar,
          'Origen' = as_origen_refinh,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_origen_refinh
                                     and tabla  = @w_codigo),
          'Estado' = as_estado_refinh,
          'Descripcion Estado' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_estado_refinh
                                     and tabla  = @w_estado),
          'Aut. Sarlaft' = as_aut_sarlaft,
          'Obs. Sarlaft' = as_obs_sarlaft,
          'Usr. Sarlaft' = as_usr_sarlaft,
          'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha
                            ),
          'Aut. Comercial' = as_aut_cial,
          'Obs. Comercial' = as_obs_cial,
          'Usr. Comercial' = as_usr_cial,
          'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha)
          ,
          'Valida' = as_valida_total,
          'Oficina' = en_oficina,
          'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                               @i_formato_fecha
                               ),
          'Maneja Rec Publico(PEP)' = en_recurso_pub,
          'Influye Politica(PEP)' = en_influencia,
          'Personaje Publico(PEP)' = en_persona_pub
        from   cobis..cl_autoriza_sarlaft_lista a,
               cobis..cl_ente
        where  as_origen_refinh in
               (select
                  ms_origen
                from   cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)
               and as_sec_refinh   >= @i_codigo
               and (as_valida_total = 'N'
                     or as_valida_total is null)
               and as_nro_id       = en_ced_ruc
               --      and   as_tipo_id     = en_tipo_ced
               and en_nomlar       > @i_nombre
        order  by en_nomlar

      end
      else
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Ente      ' = en_ente,
          'Tipo ID' = as_tipo_id,
          'Descrip. Documento' = (select
                                    ct_descripcion
                                  from   cobis..cl_tipo_documento
                                  where  ct_codigo = as_tipo_id),
          'Número ID' = as_nro_id,
          'Nombre' = en_nomlar,
          'Origen' = as_origen_refinh,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_origen_refinh
                                     and tabla  = @w_codigo),
          'Estado' = as_estado_refinh,
          'Descripcion Estado' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.as_estado_refinh
                                     and tabla  = @w_estado),
          'Aut. Sarlaft' = as_aut_sarlaft,
          'Obs. Sarlaft' = as_obs_sarlaft,
          'Usr. Sarlaft' = as_usr_sarlaft,
          'Fecha Sarlaft' = convert(char(10), as_fecha_sarlaft, @i_formato_fecha
                            ),
          'Aut. Comercial' = as_aut_cial,
          'Obs. Comercial' = as_obs_cial,
          'Usr. Comercial' = as_usr_cial,
          'Fecha Comercial' = convert(char(10), as_fecha_cial, @i_formato_fecha)
          ,
          'Valida' = as_valida_total,
          'Oficina' = en_oficina,
          'Fecha Referencia' = convert(char(10), as_fecha_refinh,
                               @i_formato_fecha
                               ),
          'Maneja Rec Publico(PEP)' = en_recurso_pub,
          'Influye Politica(PEP)' = en_influencia,
          'Personaje Publico(PEP)' = en_persona_pub
        from   cobis..cl_autoriza_sarlaft_lista a,
               cobis..cl_ente
        where  as_origen_refinh in
               (select
                  ms_origen
                from   cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)
               and as_sec_refinh   >= @i_codigo
               and (as_valida_total = 'N'
                     or as_valida_total is null)
               and as_nro_id       = en_ced_ruc
               --      and   as_tipo_id     = en_tipo_ced
               and en_nomlar       = @i_nombre
        order  by en_nomlar

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
      set rowcount 0
    end
    return 0
  end
/*************************************************************/
/**************************************************************/
  /********** consulta historica con funcion F5 ****************/

  if @i_operacion = 'G'
  begin
    set rowcount 20
    if @i_tipo = 'C' /*BUSQUEDA POR NUMERO DE DOCUMENTO*/
    begin
      if @i_modo = 0
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Tipo ID' = as_tipo_id,
          'N·mero ID' = as_nro_id,
          'Nombre' = as_nombrelargo
        from   cobis..cl_autoriza_sarlaft_lista
        where  as_nro_id like ltrim(rtrim( @i_ced_ruc)) + '%'
           and as_aut_sarlaft in ('S', 'N')
           and as_aut_cial in ('S', 'N')
        order  by as_nro_id --, in_codigo
      end
      else
      begin
        if @i_modo = 1
          select
            'Secuencial' = as_sec_refinh,
            'Tipo ID' = as_tipo_id,
            'N·mero ID' = as_nro_id,
            'Nombre' = as_nombrelargo
          from   cobis..cl_autoriza_sarlaft_lista
          where  as_nro_id > @i_ced_ruc
             and as_aut_sarlaft in ('S', 'N')
             and as_aut_cial in ('S', 'N')
          order  by as_nro_id
        else
          select
            'Secuencial' = as_sec_refinh,
            'Tipo ID' = as_tipo_id,
            'N·mero ID' = as_nro_id,
            'Nombre' = as_nombrelargo
          from   cobis..cl_autoriza_sarlaft_lista
          where  as_nro_id = @i_ced_ruc
             and as_aut_sarlaft in ('S', 'N')
             and as_aut_cial in ('S', 'N')
          order  by as_nro_id --, in_codigo 

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
    end

    if @i_tipo = 'N'
    begin --tipo N /*BUSQUEDA POR NOMBRE */
      if @i_modo = 0
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Tipo ID' = as_tipo_id,
          'N·mero ID' = as_nro_id,
          'Nombre' = as_nombrelargo
        from   cobis..cl_autoriza_sarlaft_lista
        where  as_nombrelargo like ltrim(rtrim(@i_nombre)) + '%'
           and as_aut_sarlaft in ('S', 'N')
           and as_aut_cial in ('S', 'N')
        order  by as_nombrelargo --, in_codigo
      end
      else if @i_modo = 1
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Tipo ID' = as_tipo_id,
          'N·mero ID' = as_nro_id,
          'Nombre' = as_nombrelargo
        from   cobis..cl_autoriza_sarlaft_lista
        where  as_nombrelargo > @i_nombre
           and as_aut_sarlaft in ('S', 'N')
           and as_aut_cial in ('S', 'N')
        order  by as_nombrelargo
      end
      else
      begin
        select
          'Secuencial' = as_sec_refinh,
          'Tipo ID' = as_tipo_id,
          'N·mero ID' = as_nro_id,
          'Nombre' = as_nombrelargo
        from   cobis..cl_autoriza_sarlaft_lista
        where  as_nombrelargo = @i_nombre
           and as_aut_sarlaft in ('S', 'N')
           and as_aut_cial in ('S', 'N')
        order  by as_nombrelargo

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
      set rowcount 0
    end
    return 0
  end

  return 0

go

