/************************************************************************/
/*  Archivo:            prospectos.sp                                   */
/*  Stored procedure:   sp_prospectos_ofi                               */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Jaime Loyo H.                                   */
/*  Fecha de escritura: 30-Ene-1997                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa implementa la busqueda de prospectos( para personas   */
/*  naturales o personas juridicas) segun distintos criterios           */
/*  de busqueda:                                                        */
/*      codigo de cliente                                               */
/*      apellido                                                        */
/*      cedula                                                          */
/*  Adicionalmente se puede enviar la oficina en particular o null en   */
/*  la variable @i_oficina, y la busqueda sera en todo el banco         */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  05/Mar/2004 E. Laguna   Tunning                                     */
/*  09/Mar/2004 D. Duran    Ajuste Orden Busqueda Alfabetica            */
/*  16/Mar/2004 E. Laguna   Se limita la busqueda sin comodines         */
/*  22/Abr/2004 E. Laguna   Se baja prioridad busq alfabetica           */
/*  18/May/2004 E. Laguna   Se ajusta parallel                          */
/*  08/Feb/2005 D. Duran    Ajuste Consulta Alfabetica Concatena Nombre */
/*  21/Feb/13   D.Pulido        REQ 349                                 */
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
           where  name = 'sp_prospectos_ofi')
           drop proc sp_prospectos_ofi
go

create proc sp_prospectos_ofi
(
  @s_ssn             int = null,
  @s_user            login = null,
  @s_term            varchar(30) = null,
  @s_date            datetime = null,
  @s_srv             varchar(30) = null,
  @s_lsrv            varchar(30) = null,
  @s_rol             smallint = null,
  @s_ofi             smallint = null,
  @s_org_err         char(1) = null,
  @s_error           int = null,
  @s_sev             tinyint = null,
  @s_msg             descripcion = null,
  @s_org             char(1) = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(10) = null,
  @t_from            varchar(32) = null,
  @t_trn             smallint = null,
  @t_show_version    bit = 0,
  @i_subtipo         char(1) = null,
  @i_tipo            tinyint = null,
  @i_modo            tinyint = null,
  @i_valor           varchar(32) = '%',
  @i_ente            int = null,
  @i_nombre          descripcion = null,
  @i_p_apellido      varchar(16) = null,
  @i_s_apellido      varchar(16) = null,
  @i_ced_ruc         numero = null,
  @i_oficina         smallint = null,
  @i_nombre_completo varchar(64) = null,
  @i_pasaporte       numero = null,
  @i_formato_f       tinyint = 101,
  @i_alianza         int = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_nombre   varchar(150),
    @w_criterio varchar(20),
    @w_alianza  int

  select
    @w_sp_name = 'sp_prospectos_ofi'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1318
  begin
    if @i_nombre is null
      select
        @i_nombre = ' '
    if @i_p_apellido is null
      select
        @i_p_apellido = ' '

    set rowcount 20
    /* Si subtipo es P, traer datos de persona */
    if @i_subtipo = 'P'
    begin
      select
        @w_nombre = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre

      /* Si tipo es 1, traer los datos ordenados por ente */
      if @i_tipo = 1
      begin
        if @i_alianza is not null
        begin
          select
            @w_alianza = ac_alianza
          from   cobis..cl_alianza_cliente with (nolock),
                 cobis..cl_alianza with (nolock)
          where  ac_ente    = @i_ente
             and ac_alianza = al_alianza
             and ac_alianza = @i_alianza
             and al_estado  = 'V'
             and ac_estado  = 'V'

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            -- 'No existe dato solicitado'
            return 1
          end
        end

        if @i_modo = 0
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente = @i_ente)
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ente    = @i_ente
             and en_cliente is null
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente = @i_ente)
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ente    = @i_ente
             and en_cliente is null
        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente = @i_ente)
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ente    = @i_ente
             and en_cliente is null

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
        end
        return 0
      end

      /* Si tipo es 2, traer los datos ordenados por cedula */
      if @i_tipo = 2
      begin
        if @i_alianza is not null
        begin
          select
            @w_alianza = ac_alianza
          from   cobis..cl_ente with (nolock),
                 cobis..cl_alianza_cliente with (nolock),
                 cobis..cl_alianza with (nolock)
          where  ac_ente    = en_ente
             and en_ced_ruc = @i_ced_ruc
             and ac_alianza = al_alianza
             and ac_alianza = @i_alianza
             and al_estado  = 'V'
             and ac_estado  = 'V'

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            -- 'No existe dato solicitado'
            return 1
          end
        end

        if @i_modo = 0
        begin
          select
            @w_criterio = @i_ced_ruc

          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ced_ruc = @w_criterio
             and en_cliente is null
          order  by en_ced_ruc
        end
        else if @i_modo = 1
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ced_ruc = @i_ced_ruc
             and en_cliente is null
          order  by en_ced_ruc
        end
        else
        begin
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_ced_ruc = @i_ced_ruc
             and en_cliente is null

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
        end
        return 0
      end

      /* Si tipo es 4, traer los datos cuyo primer apellido son como un valor dado */
      if @i_tipo = 4
      begin
        if @i_modo = 0
        begin
          if datalength(@i_valor) < 3
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101014,
              @i_msg   = 'Para busqueda alfabetica minimo 3 caracteres'
            /* 'No existe dato solicitado'*/
            return 1
          end

          select
            @w_criterio = @i_valor + '%'

          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_nomlar like @w_criterio
             and en_cliente is null
             and (en_ente in
                  (select
                     ac_ente
                   from   cobis..cl_alianza_cliente with (nolock),
                          cobis..cl_alianza with (nolock)
                   where  ac_ente    = X.en_ente
                      and ac_alianza = al_alianza
                      and ac_alianza = @i_alianza
                      and al_estado  = 'V'
                      and ac_estado  = 'V')
                   or (@i_alianza is null))
          order  by en_nomlar
        end
        else if @i_modo = 1
        begin
          --set parallel_degree 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_nomlar  > @w_nombre
             and en_cliente is null
             and (en_ente in
                  (select
                     ac_ente
                   from   cobis..cl_alianza_cliente with (nolock),
                          cobis..cl_alianza with (nolock)
                   where  ac_ente    = X.en_ente
                      and ac_alianza = al_alianza
                      and ac_alianza = @i_alianza
                      and al_estado  = 'V'
                      and ac_estado  = 'V')
                   or (@i_alianza is null))
          order  by en_nomlar
        end
        else
        begin
          --set parallel_degree 1
          select
            'No.' = en_ente,
            'Primer Apellido' = p_p_apellido,
            'Segundo Apellido' = p_s_apellido,
            'Nombre' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Fecha de Nacimiento' = convert(varchar(10), p_fecha_nac,
                                    @i_formato_f
                                    ),
            'Gerente' = en_oficial,
            'Mala Referencia' = en_mala_referencia,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Persona ' = p_tipo_persona,
            'Accion' = (select
                          case codigo
                            when 'NIN' then ''
                            else valor
                          end
                        from   cobis..cl_catalogo
                        where  tabla in
                               (select
                                  codigo
                                from   cobis..cl_tabla
                                where  tabla = 'cl_accion_cliente')
                               and codigo = X.en_accion),
            'Funcionario ' = (select
                                (case
                                   when isnull(fu_nomina,
                                               0) = 0 then 'N'
                                   else 'S'
                                 end) --REQ 349
                              from   cl_ente Y
                                     left outer join cl_funcionario
                                                  on Y.en_ced_ruc = convert(
                                                     varchar,
                                                                    fu_nomina)
                              where  Y.en_ente =
            (select
               en_ente
             from   cl_ente Z
             where
            X.en_ced_ruc  = Z.en_ced_ruc
                            and
            X.en_tipo_ced = Z.en_tipo_ced
                            and Z.en_subtipo  = 'P'
                            and Z.en_ente     = X.en_ente))
          from   cl_ente X
          where  en_subtipo = 'P'
             and en_nomlar  = @i_valor
             and en_cliente is null
             and (en_ente in
                  (select
                     ac_ente
                   from   cobis..cl_alianza_cliente with (nolock),
                          cobis..cl_alianza with (nolock)
                   where  ac_ente    = X.en_ente
                      and ac_alianza = al_alianza
                      and ac_alianza = @i_alianza
                      and al_estado  = 'V'
                      and ac_estado  = 'V')
                   or (@i_alianza is null))
          order  by en_nomlar

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
        end
        return 0
      end
    end
    else/* Si subtipo es C, traer datos de compania */
    begin
      /* Si tipo es 1, traer los datos de las companias ordenados por ente */
      if @i_tipo = 1
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ente    = @i_ente
             and en_cliente is null
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ente    = @i_ente
             and en_cliente is null
        else
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ente    = @i_ente
             and en_cliente is null

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
        end
        return 0
      end
      /* Si tipo es 2, traer los datos de las companias ordenados por RUC */
      if @i_tipo = 2
      begin
        if @i_modo = 0
        begin
          select
            @w_criterio = @i_ced_ruc

          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ced_ruc = @w_criterio
             and en_cliente is null
          order  by en_ced_ruc
        end
        else if @i_modo = 1
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ced_ruc = @i_ced_ruc
             and en_cliente is null
          order  by en_ced_ruc
        end
        else
        begin
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_ced_ruc = @i_ced_ruc
             and en_cliente is null

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
        end
        return 0
      end
      /* Si tipo es 4, traer los datos de las companias de acuerdo al nombre */
      if @i_tipo = 4
      begin
        if datalength(@i_valor) < 3
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101014,
            @i_msg   = 'Para busqueda alfabetica minimo 3 caracteres'
          /* 'No existe dato solicitado'*/
          return 1
        end

        select
          @w_criterio = @i_valor + '%'

        if @i_modo = 0
        begin
          --set parallel_degree 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_nomlar like @w_criterio
             and en_cliente is null
          order  by en_nomlar
        end
        else if @i_modo = 1
        begin
          --set parallel_degree 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_nomlar  > @i_nombre
             and en_cliente is null
          order  by en_nomlar
        end
        else
        begin
          --set parallel_degree 1
          select
            'No.' = en_ente,
            'Nombre/Razon Social' = en_nombre,
            'D.I.' = en_ced_ruc,
            'Tipo D.I.' = en_tipo_ced,
            'Mala Referencia' = en_mala_referencia,
            'Fecha Constituci¾n' = convert(varchar(10), c_fecha_const,
                                   @i_formato_f)
            ,
            'Gerente' = en_oficial,
            'Categoria' = en_categoria,
            'Banca ' = en_banca,
            'Regimen Fiscal ' = en_asosciada,
            'Tipo Compania' = c_tipo_compania
          from   cl_ente
          where  en_subtipo = 'C'
             and en_nomlar  = @i_valor
             and en_cliente is null
          order  by en_nomlar

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /*'No existe dato solicitado'*/
            return 1
          end
        end
      end
    end
    set rowcount 0
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
  return 0

go

