/************************************************************************/
/*  Archivo:        qrgrupo.sp                                          */
/*  Stored procedure:   sp_qr_grupo                                     */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 08-Nov-1992                                     */
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
/*  Este programa implementa la busqueda de grupos economicos           */
/*      de acuerdo a dos criterios:                                     */
/*      codigo de grupo                                                 */
/*      nombre de grupo                                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  28/Oct/93   M. Davila   Emision Inicial                             */
/*  15/Ene/97   J. Loyo     Se implemento la consulta de los            */
/*                          grupos economicos a los cuales              */
/*                          no pertenece(tipo 3) y los que              */
/*                          pertenece(tipo 4)un cliente                 */
/*                          COGRNOE                                     */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_qr_grupo')
           drop proc sp_qr_grupo
go

create proc sp_qr_grupo
(
  @s_ssn          int = null,
  @s_user         login = null,
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
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_tipo         tinyint = null,
  @i_modo         tinyint = null,
  @i_valor        varchar(32) = '1',
  @i_grupo        int = null,
  @i_ente         int = null,
  @i_nombre       descripcion = null
)
as
  declare
    @w_sp_name   varchar(32),
    @o_fecha_reg datetime

  select
    @w_sp_name = 'sp_qr_grupo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 150
  begin
    set rowcount 20
    if @i_tipo = 1
    begin
      if @i_modo = 0
      begin
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_grupo >= @i_grupo
        order  by gr_grupo

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
      if @i_modo = 1
      begin
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_grupo > @i_grupo
        order  by gr_grupo

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 2
      begin
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_grupo = @i_grupo
        order  by gr_grupo

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
    end /** FIN @i_tipo  = 1  ***/
    if @i_tipo = 2
    begin
      if @i_modo = 0
      begin
        select
          @i_valor = isnull(@i_valor,
                            '%')
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_nombre >= @i_valor
        order  by gr_nombre

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
      if @i_modo = 1
      begin
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_nombre > @i_nombre
           and gr_nombre > @i_valor
        order  by gr_nombre

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 2
      begin
        select
          'No.' = gr_grupo,
          'Grupo' = gr_nombre,
          'Cod.' = gr_representante,
          'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) +
                            ' '
                            +
                            en_nombre,
          'Oficial' = gr_oficial,
          'Nombre' = substring(fu_nombre,
                               1,
                               30)
        from   cl_grupo
               left outer join cl_ente
                            on en_ente = gr_representante
               left outer join cl_funcionario
                            on gr_oficial = fu_funcionario
        where  gr_nombre = @i_valor
        order  by gr_nombre

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
    end /** FIN @i_tipo  = 2  ***/

    if @i_tipo = 3
    begin
      set rowcount 0
      select
        'No.' = gr_grupo,
        'Grupo' = gr_nombre,
        'Cod.' = gr_representante,
        'Representante' = rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' '
                          +
                          en_nombre,
        'Oficial' = gr_oficial,
        'Nombre' = substring(fu_nombre,
                             1,
                             30)
      from   cl_grupo
             left outer join cl_ente
                          on en_ente = gr_representante
             left outer join cl_funcionario
                          on gr_oficial = fu_funcionario
      where  gr_grupo not in (select
                                cg_grupo
                              from   cl_cliente_grupo
                              where  cg_ente = @i_ente)
      order  by gr_nombre

      /* if @@rowcount = 0
      begin
         exec sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 101001
         /* 'No existe dato solicitado'*/
         return 1
      end */
      return 0
    end /** FIN @i_tipo  = 3  ***/

    if @i_tipo = 4
    begin
      set rowcount 0
      select
        'Codigo Grupo' = cg_grupo,
        'Grupo Economico' = gr_nombre
      from   cl_cliente_grupo,
             cl_grupo
      where  cg_ente  = @i_ente
         and gr_grupo = cg_grupo
      return 0
    end
    set rowcount 0
    if @i_tipo = 5
    begin
      set rowcount 0
      select
        gr_fecha_registro,
        gr_fecha_modificacion
      from   cl_cliente_grupo,
             cl_grupo
      where  cg_ente  = @i_ente
         and gr_grupo = cg_grupo
      return 0
    end
    set rowcount 0
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

