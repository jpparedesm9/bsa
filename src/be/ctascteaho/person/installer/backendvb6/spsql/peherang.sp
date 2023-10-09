/****************************************************************************/
/*     Archivo:     peherang.sp                                             */
/*     Stored procedure: sp_help_rango_pe                                   */
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
/*     Este programa presenta help de la tabla de tipo rango                */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error          */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_rango_pe')
  drop proc sp_help_rango_pe
go
create proc sp_help_rango_pe
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int=null,
  @s_term         varchar(10)=null,
  @s_date         datetime,
  @s_org          char(1)=null,
  @s_ofi          smallint=null,
  @s_rol          smallint=null,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint=null,
  @t_show_version bit = 0,
  @i_modo         char(1),
  @i_tipo         char(1)=null,
  @i_codigo       tinyint = 0,
  @i_grupo        smallint = 0,
  @i_rango        tinyint = 0,
  @i_moneda       tinyint = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_help_rango_pe'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn != 4038
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @i_modo = 'T'
  begin
    if @i_tipo = 'A'
    begin
      set rowcount 15

      if @i_moneda is null
      begin
        select
          '1093' = tr_tipo_rango,                    --CODIGO
          '1883' = substring(tr_descripcion, 1, 35), --DESC TRANGO
          '1481' = tr_moneda,                        --MONEDA
          '1186' = substring(mo_descripcion, 1, 15)  --DESC MONEDA
        from   pe_tipo_rango,
               cobis..cl_moneda
        where  mo_moneda     = tr_moneda
           and tr_tipo_rango > @i_codigo
        order  by tr_tipo_rango
      end
      else if @i_moneda is not null
      begin
        select
          '1093' = tr_tipo_rango,                    --CODIGO
          '1883' = substring(tr_descripcion, 1, 35), --DESC TRANGO
          '1481' = tr_moneda,                        --MONEDA
          '1186' = substring(mo_descripcion, 1, 15)  --DESC MOONEDA
        from   pe_tipo_rango,
               cobis..cl_moneda
        where  mo_moneda     = tr_moneda
           and tr_moneda     = @i_moneda
           and tr_tipo_rango > @i_codigo
        order  by tr_tipo_rango
      end

      set rowcount 0
    end

    if @i_tipo = 'V'
    begin
      if @i_moneda is null
      begin
        select
          substring(tr_descripcion,
                    1,
                    35),
          tr_moneda,
          substring(mo_descripcion,
                    1,
                    15)
        from   pe_tipo_rango,
               cobis..cl_moneda
        where  mo_moneda     = tr_moneda
           and tr_tipo_rango = @i_codigo
        order  by tr_tipo_rango
      end
      else if @i_moneda is not null
      begin
        select
          substring(tr_descripcion,
                    1,
                    35),
          tr_moneda,
          substring(mo_descripcion,
                    1,
                    15)
        from   pe_tipo_rango,
               cobis..cl_moneda
        where  mo_moneda     = tr_moneda
           and tr_moneda     = @i_moneda
           and tr_tipo_rango = @i_codigo
        order  by tr_tipo_rango
      end

      if @@rowcount = 0
      begin
        /*No existe tipo de rango*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351507
        return 351507
      end
    end

  end

  if @i_modo = 'G'
  begin
    set rowcount 15

    if @i_tipo = 'A'
    begin
      select
        '1381' = ra_grupo_rango, --GRUPO
        '1678' = ra_rango,       --RANGO
        '1213' = ra_desde,       --DESDE
        '1398' = ra_hasta        --HASTA
      from   pe_rango
      where  ra_tipo_rango  = @i_codigo
         and (ra_grupo_rango > @i_grupo
               or (ra_grupo_rango = @i_grupo
                   and ra_rango       > @i_rango))
    end
    else if @i_tipo = 'V'
    begin
      if not exists (select
                       *
                     from   pe_rango
                     where  ra_tipo_rango  = @i_codigo
                        and ra_grupo_rango = @i_grupo)
      begin
        /*No existe grupo de rango*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351559
        return 351559
      end
    end

    set rowcount 0
  end

  return 0

GO 
