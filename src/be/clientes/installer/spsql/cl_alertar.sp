/***********************************************************************/
/*   Archivo:             cl_alertar.sp                                 */
/*   Stored procedure:    sp_alerta_tarea                               */
/*   Base de datos:       cobis                                         */
/*   Producto:            Clientes                                      */
/*   Disenado por:        Jose Julian Cortes                            */
/*   Fecha de escritura:  Noviembre - 2011                              */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                             PROPOSITO                                */
/*   Consultqar en la tabla cobis..cl_tarea si el usuario registrado    */
/*   tiene o no tareas pendientes por ejecutar.                         */
/************************************************************************/
/*                             ACTUALIZACIONES                          */
/*                                                                      */
/*     FECHA              AUTOR            CAMBIO                       */
/*   Nov/11/11           Jose Cortes       Version inicial              */
/*   May/02/2016         DFu               Migracion CEN                */
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
           where  name = 'sp_alerta_tarea')
  drop proc sp_alerta_tarea
go

create proc sp_alerta_tarea
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
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

  --@i_operacion	    char(1)		 ,
  @i_tipo         char(1) = null,
  @i_modo         int = null,
  @o_tarea        char(1) = null out,
  @o_seq          int = null output
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(32),
    @w_codigo  int

  select
    @w_sp_name = 'sp_alerta_tarea'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1075
  begin
    if exists (select
                 1
               from   cobis..cl_tarea
               where  ta_login = @s_user
                  and ta_fecha_ejec is null)
    begin
      select
        @o_tarea = 'S'
    end
    else
    begin
      select
        @o_tarea = 'N'
    end
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go

