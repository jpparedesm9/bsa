/************************************************************************/
/*  Archivo:            s_h_busq.sp                                     */
/*  Stored procedure:   sp_soc_hecho_busq                               */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 02/Sep/1994                                     */
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
/*  Este programa implementa la busqueda de sociedades de hecho         */
/*  segun distintos criterios de busqueda:                              */
/*      codigo de cliente                                               */
/*      nombre                                                          */
/*      ruc                                                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  02/Sep/94   C. Rodriguez V. Emision Inicial                         */
/*  05/May/2016 T. Baidal    Migracion a CEN                            */
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
           where  name = 'sp_soc_hecho_busq')
           drop proc sp_soc_hecho_busq
go

create proc sp_soc_hecho_busq
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_rol            smallint = null,
  @s_ofi            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint = null,
  @t_show_version   bit = 0,
  @i_subtipo        char(1) = null,
  @i_tipo           tinyint = null,
  @i_tipo_soc_hecho catalogo = null,
  @i_modo           tinyint = null,
  @i_valor          varchar(32) = '%',
  @i_ente           int = null,
  @i_nombre         descripcion = null,
  @i_ced_ruc        numero = null
)
as
  declare @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_soc_hecho_busq'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1247
  begin
    /* Traer los resultados de 20 en 20 */
    set rowcount 20

    /* Si subtipo es S, traer datos de sociedades de hecho */
    if @i_subtipo = 'S'
    begin
      /* Si tipo es 1, traer los datos ordenados por ente */
      if @i_tipo = 1
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), en_ente) like @i_valor
             and en_subtipo = 'S'
          order  by en_ente

        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), en_ente) like @i_valor
             and en_ente    > @i_ente
             and en_subtipo = 'S'
          order  by en_ente

        else
        begin
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_ente    = convert(int, @i_valor)
             and en_subtipo = 'S'

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
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), en_ced_ruc) like @i_valor
             and en_subtipo = 'S'
          order  by en_ced_ruc
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  convert(char(32), en_ced_ruc) like @i_valor
             and en_ced_ruc > @i_ced_ruc
             and en_subtipo = 'S'
          order  by en_ced_ruc

        else
        begin
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_ced_ruc = @i_valor
             and en_subtipo = 'S'
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

      /* Si tipo es 4, traer los datos cuyo nombre son como
         un valor dado */
      if @i_tipo = 4
      begin
        if @i_modo = 0
        begin
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre like @i_valor
             and en_subtipo = 'S'

        end
        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre like @i_valor
             and en_nombre  > @i_nombre
             and en_subtipo = 'S'
        else
        begin
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  en_nombre  = @i_valor
             and en_subtipo = 'S'
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
      /* Si tipo es 5, traer los datos ordenados por tipo de sociedad de hecho */
      if @i_tipo = 5
      begin
        if @i_modo = 0
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'Tipo' = s_tipo_soc_hecho,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  s_tipo_soc_hecho like @i_valor
             and en_subtipo = 'S'
          order  by s_tipo_soc_hecho

        else if @i_modo = 1
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'Tipo' = s_tipo_soc_hecho,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  s_tipo_soc_hecho like @i_valor
             and s_tipo_soc_hecho > @i_tipo_soc_hecho
             and en_subtipo       = 'S'
          order  by s_tipo_soc_hecho

        else
        begin
          select
            'No.' = en_ente,
            'Nombre' = en_nombre,
            'Tipo' = s_tipo_soc_hecho,
            'NIT' = en_ced_ruc,
            'Cod.Of.' = en_oficial,
            'Nombre del Oficial' = substring(fu_nombre,
                                             1,
                                             30)
          from   cl_ente
                 left outer join cl_funcionario
                              on en_oficial = fu_funcionario
          where  s_tipo_soc_hecho = @i_valor
             and en_subtipo       = 'S'

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

go

