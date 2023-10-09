/************************************************************************/
/*   Archivo:                clixsec.sp                                 */
/*   Stored procedure:       sp_cli_actividad                           */
/*   Base de datos:          cobis                                      */
/*   Producto:               Clientes                                   */
/*   Disenado por:           Angela Ramirez                             */
/*   Fecha de documentacion: 10-Jul-1996                                */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                           PROPOSITO                                  */
/*      Dado el codigo de un pais y la actividad economica              */
/*   retorna el numero  de clientes de  cada una de las                 */
/*      actividadeses                                                   */
/*      NOTA: No hay control de select de 20 en 20. el control debe     */
/*            ser administrativo                                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*        FECHA          AUTOR          RAZON                           */
/*      10/Jul/96       A. Ramirez    Emision inicial                   */
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
           where  name = 'sp_cli_actividad')
  drop proc sp_cli_actividad
go

create proc sp_cli_actividad
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
  @i_pais         smallint = null,
  @i_actividad    char(3) = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_cli_actividad'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  if @t_trn = 1295
  begin
    /* verificar que exista la actividad */
    exec @w_return = cobis..sp_catalogo
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'cl_actividad',
      @i_operacion = 'E',
      @i_codigo    = @i_actividad

    if @w_return = 1
    begin
      /*    'No existe actividad'*/
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101027
      return 1
    end

    /* verificar si existe el pais */
    if not exists (select
                     pa_pais
                   from   cl_pais
                   where  pa_pais = @i_pais)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101018
      /*'No existe pais'*/
      return 1
    end

    select
      'Actividad Economica' = b.valor,
      'Clientes' = count(*)
    from   cobis..cl_ente,
           cobis..cl_pais,
           cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  en_pais      = pa_pais
       and a.tabla      = 'cl_actividad'
       and a.codigo     = b.tabla
       and en_actividad = b.codigo
       and en_pais      = @i_pais
       and b.codigo     = @i_actividad
    group  by b.valor

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

