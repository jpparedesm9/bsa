/****************************************************************************/
/*      Archivo         : pe_cosubser2.sp                                   */
/*      Store Procedure : sp_help_cosub                                     */
/*      Base de Datos   : cob_remesas                                       */
/*      Producto        : Personalizacion                                   */
/*      Disenado por    :                                                   */
/*      Fecha de escritura : 04 dic 1994                                    */
/****************************************************************************/
/*                          IMPORTANTE                                      */
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
/*                              PROPOSITO                                   */
/*       Este programa realiza otra consulta de los subservicios            */
/****************************************************************************/
/*                             MODIFICACIONES                               */
/*           FECHA             AUTOR                 RAZON                  */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error          */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_cosub')
  drop proc sp_help_cosub
go

create proc sp_help_cosub
(
  @s_ssn          int,
  @s_srv          varchar(30)=null,
  @s_lsrv         varchar(30)=null,
  @s_user         varchar(30)=null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char (1),
  @s_ofi          smallint,
  @s_rol          smallint =1,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1)='N',
  @t_file         varchar(14)=null,
  @t_from         varchar(32)=null,
  @t_rty          char(1)='N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(2),
  @i_tipo         char (1)=null,
  @i_codigo       smallint=null,
  @i_rubro        catalogo=null
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_help_cosub'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo Debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      i_codigo = @i_codigo,
      i_rubro = @i_rubro
    exec cobis..sp_end_debug
  end

  if @t_trn != 4039
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @i_operacion = 'H1'
  begin
    set rowcount 15

    select
      '1203' = substring(sd_descripcion, 1, 35), --DESCRIPCION DEL SERVICIO
      '1197' = substring(a.valor, 1, 35),        --DESCRIPCION DE RUBRO
      '1710' = vs_servicio_dis,                  --SERVICIO
      '1689' = substring(vs_rubro, 1, 4),        --RUBRO
      '1750' = substring(b.valor, 1, 35),        --TIPO DE DATO
      '1333' = substring(vs_estado, 1, 6)        --ESTADO
    from   pe_var_servicio,
           pe_servicio_dis,
           cobis..cl_catalogo a,
           cobis..cl_catalogo b,
           cobis..cl_tabla c,
           cobis..cl_tabla d
    where  sd_servicio_dis = vs_servicio_dis
       and c.tabla         = 'pe_rubro'
       and a.tabla         = c.codigo
       and a.codigo        = vs_rubro
       and d.tabla         = 'pe_tipo_dato'
       and b.tabla         = d.codigo
       and b.codigo        = vs_tipo_dato
       and ((vs_servicio_dis > @i_codigo)
             or (vs_servicio_dis = @i_codigo
                 and vs_rubro        > @i_rubro))
    order  by vs_servicio_dis,
              vs_rubro

    set rowcount 0
  end

  if @i_operacion = 'H2'
  begin
    set rowcount 15

    select
      '1203' = substring(sd_descripcion, 1, 35), --DESCRIPCION DEL SERVICIO
      '1202' = substring(a.valor, 1, 35),        --DESCRIPCION DE RUBRO
      '1689' = substring(vs_rubro, 1, 4),        --RUBRO
      '1750' = substring(b.valor,  1, 35),       --TIPO DE DATO
      '1333' = substring(vs_estado, 1, 6)        --ESTADO
    from   pe_var_servicio,
           pe_servicio_dis,
           cobis..cl_catalogo a,
           cobis..cl_catalogo b,
           cobis..cl_tabla c,
           cobis..cl_tabla d
    where  sd_servicio_dis = vs_servicio_dis
       and c.tabla         = 'pe_rubro'
       and a.tabla         = c.codigo
       and a.codigo        = vs_rubro
       and d.tabla         = 'pe_tipo_dato'
       and b.tabla         = d.codigo
       and b.codigo        = vs_tipo_dato
       and vs_servicio_dis = @i_codigo
       and vs_rubro        > @i_rubro
    order  by vs_rubro

    set rowcount 0
  end

  return 0

GO 
