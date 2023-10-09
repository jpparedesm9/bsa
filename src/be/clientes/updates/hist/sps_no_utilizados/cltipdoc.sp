/************************************************************************/
/*      Archivo:                cltipdoc.sp                             */
/*      Stored procedure:       sp_tipodoc                              */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Johana Laguna R.                   */
/*      Fecha de escritura:     03-Abr-2001                             */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tipodoc')
  drop proc sp_tipodoc
go

create proc sp_tipodoc
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
  @i_tipo         char(1) = null,
  @i_subtipo      char(1) = null,
  @i_codigo       varchar(10) = null,
  @i_sexo         char(1) = 'O',
  @i_operacion    char(1) = null,
  @i_modo         tinyint = 0
)
as
  declare
    @w_sp_name     varchar(32),
    @o_tipodoc     varchar(10),
    @o_descripcion varchar(64),
    @w_mascara     varchar(30)

  select
    @w_sp_name = 'sp_tipodoc'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1115
  begin
    if @i_tipo = 'A'
    begin
      select
        ct_codigo,
        ct_descripcion,
        ct_sexo
      from   cobis..cl_tipo_documento
      where  ct_subtipo = @i_subtipo
         and ct_estado  = 'V'
      order  by ct_codigo
    end

    if @i_tipo = 'V'
    begin
      select
        ct_descripcion,
        ct_mascara,
        ct_num_dijitos_docu_max,
        ct_tipo_dato,
        ct_sexo,
        ct_valor_cade_campo_inclu,
        ct_valida_nit
      from   cobis..cl_tipo_documento
      where  ct_subtipo = @i_subtipo
         and ct_codigo  = @i_codigo

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101221
        return 1

      end
    end

    if @i_tipo = 'B'
    begin
      if @i_subtipo is null
        select
          @i_subtipo = 'P'

      select
        ct_codigo,
        ct_descripcion,
        ct_sexo
      from   cobis..cl_tipo_documento
      where  ct_subtipo = @i_subtipo
         and ct_codigo like @i_codigo
         and ct_estado  = 'V'
      order  by ct_codigo
    end
  end
  return 0

go

