/****************************************************************************/
/*     Archivo:     peheserv.sp                                             */
/*     Stored procedure: sp_help_subs                                       */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa presenta help de la tabla de servicios disponibles     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_subs')
  drop proc sp_help_subs
go
create proc sp_help_subs
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_tipo         char(1),
  @i_codigo       smallint = null,
  @i_rubro        char(1) = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_help_subs'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      i_modo = @i_modo,
      i_tipo = @i_tipo,
      i_codigo = @i_codigo,
      i_rubro = @i_rubro
    exec cobis..sp_end_debug
  end
  if @i_tipo = 'A'
  begin
    set rowcount 15
    if @i_modo = 0
      select
        'CODIGO' = vs_servicio_dis,
        'RUBRO' = vs_rubro,
        'DESCRIPCION' = substring(vs_descripcion,
                                  1,
                                  35)
      from   pe_var_servicio
      order  by vs_servicio_dis
    else
    begin
      select
        'CODIGO' = vs_servicio_dis,
        'RUBRO' = vs_rubro,
        'DESCRIPCION' = substring(vs_descripcion,
                                  1,
                                  35)
      from   pe_var_servicio
      where  vs_servicio_dis > @i_codigo
      order  by vs_servicio_dis
    end
    set rowcount 0
  end
  if @i_tipo = 'V'
  begin
    select
      substring(vs_descripcion,
                1,
                35)
    from   pe_var_servicio
    where  vs_servicio_dis = @i_codigo
       and vs_rubro        = @i_rubro

    if @@rowcount = 0
    begin
      /*No existe subservicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351528
      return 351528
    end
  end
  return 0

GO 
