/****************************************************************************/
/*     Archivo:     peheprmo.sp                                             */
/*     Stored procedure: sp_help_promo_pe                                   */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 20-Dic-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
/****************************************************************************/
use cobis
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_promo_pe')
  drop proc sp_help_promo_pe
go
create proc sp_help_promo_pe
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
  @s_org_err      char(1),
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
  @i_codigo       tinyint = null,
  @i_moneda       tinyint = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_codigo  int

  select
    @w_sp_name = 'sp_help_promo_pe'

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
      i_moneda = @i_moneda
    exec cobis..sp_end_debug
  end
  if @i_tipo = 'A'
  begin
    set rowcount 15
    if @i_modo = 0
      select
        'CODIGO' = pm_producto,
        'DESCRIPCION' = substring(pm_descripcion,
                                  1,
                                  35)
      from   cl_pro_moneda
      order  by pm_producto
    else
    begin
      select
        'CODIGO' = pm_producto,
        'DESCRIPCION' = substring(pm_descripcion,
                                  1,
                                  35)
      from   cl_pro_moneda
      where  pm_producto > @i_codigo
      order  by pm_producto
    end
    set rowcount 0
  end
  if @i_tipo = 'V'
  begin
    select
      pm_tipo,
      pm_moneda,
      pm_descripcion
    from   cl_pro_moneda
    where  pm_producto = @i_codigo
       and pm_moneda   = @i_moneda

  end
  return 0
go 
