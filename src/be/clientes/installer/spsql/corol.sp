/************************************************************************/
/*   Archivo:       corol.sp                                            */
/*   Stored procedure:   sp_cons_rol                                    */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:            Mauricio Bayas/Sandra Ortiz               */
/*   Fecha de escritura:      14-Jun-1993                               */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Encuentra los roles que juega una persona ante una compania        */
/*   o un grupo economico al que se halla asociado.                     */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   14-Jun-1993    S Ortiz        Emision inicial                      */
/*      12/Nov/93       R. Minga V.     Documentacion, verificacion de  */
/*                                      existencia.                     */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_cons_rol')
  drop proc sp_cons_rol
go

create proc sp_cons_rol
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
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_tipo         char (1),
  @i_codigo       int = null,
  @i_ente         int = null
)
as
  declare @w_sp_name varchar (30)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_cons_rol'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1179
  begin
    if @i_tipo = 'M'
    begin
      select
        @s_date
      return 0
    end

    /* chequear que exista el ente */
    if not exists (select
                     *
                   from   cl_ente
                   where  en_ente = @i_ente)
    begin
      /*  No existe cliente  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 101146
      return 1
    end

    /* Averiguar los roles que juega frente a una compania si el tipo es 'E' */
    if @i_tipo = 'E'
    begin
      if not exists (select
                       *
                     from   cl_ente
                     where  en_ente    = @i_codigo
                        and en_subtipo = 'C')
      begin
        /*  No existe compania  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 151030
        return 1
      end
      select distinct
        in_relacion,
        re_descripcion
      from   cl_instancia,
             cl_relacion
      where  in_ente_i   = @i_ente
         and in_ente_d   = @i_codigo
         and re_relacion = in_relacion
      if @@rowcount = 0
      begin
        /*  No existe relacion entre cliente y compania  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101087
        return 1
      end
    end

    /* Averiguar los roles que juega frente a un grupo si el tipo es 'G' */
    if @i_tipo = 'G'
    begin
      if not exists (select
                       *
                     from   cl_grupo
                     where  gr_grupo = @i_codigo)
      begin
        /*  No existe grupo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 151029
        return 1
      end
      select distinct
        in_relacion,
        re_descripcion
      from   cl_relacion,
             cl_instancia,
             cl_ente
      where  in_ente_i   = @i_ente
         and en_ente     = in_ente_d
         and en_grupo    = @i_codigo
         and re_relacion = in_relacion
      if @@rowcount = 0
      begin
        /*  No existe relacion entre cliente y grupo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101091
        return 1
      end
    end

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

