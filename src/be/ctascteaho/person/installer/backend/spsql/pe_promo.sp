/************************************************************************/
/*      Archivo               : pe_help_promon              */
/*      Store Procedure       : sp_promon                        */
/*      Base de Datos         : cob_remesas                 */
/*      Producto              : Personalizacion                       */
/*      Disenado por          :                             */
/*      Fecha de escritura    : 04 dic 1994                 */
/************************************************************************/
/*                           IMPORTANTE                              */
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
/*                              PROPOSITO                   */
/*       Este programa realiza una ayuda para los productos y para      */
/*       la moneda                                                      */
/************************************************************************/
/*                             MODIFICACIONES                    */
/*     FECHA             AUTOR                 RAZON             */
/*    30/Sep/2003    Gloria Rueda   Retornar c¢digos de error           */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                  */
/************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_promon')
  drop proc sp_promon
go

create proc sp_promon
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
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_producto     tinyint = null,
  @i_moneda       tinyint = 0
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_promon'

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
      i_operacion = @i_operacion,
      i_producto = @i_producto,
      i_moneda = @i_moneda
    exec cobis..sp_end_debug
  end

  /***Consulta para el producto *******/

  if @i_operacion = 'P'
  begin
    if @t_trn != 4043
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end
    select
      cobis..cl_producto.pd_descripcion
    from   cobis..cl_producto
    where  cobis..cl_producto.pd_producto = @i_producto
    if @@rowcount = 0
    begin
      /*No existe producto*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351518
      return 351518
    end
  end

  /***Consulta para la moneda *******/

  if @i_operacion = 'M'
  begin
    if @t_trn != 4044
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      cobis..cl_moneda.mo_descripcion
    from   cobis..cl_moneda
    where  cobis..cl_moneda.mo_moneda = @i_moneda
    if @@rowcount = 0
    begin
      /*No existe moneda*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351510
      return 351510
    end
  end

  if @i_operacion = 'H'
  begin
    if @t_trn != 4075
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    set rowcount 15

    select
      '1653' = pm_producto,    --PRODUCTO
      '1481' = pm_moneda,    --MONEDA
      '1896' = pm_descripcion,    --DESCRIPCION
      '1742' = pm_tipo      --TIPO
    from   cobis..cl_pro_moneda
    where  pm_producto in (3, 4, 16, 70)
       and (pm_producto > @i_producto
             or (pm_producto = @i_producto
                 and pm_moneda   > @i_moneda))
    order  by pm_producto,
              pm_moneda

    set rowcount 0
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn != 4076
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    set rowcount 15

    if @i_modo = 0
    begin
      select
       '1653' = pm_producto,    --PRODUCTO
      '1481' = pm_moneda,    --MONEDA
      '1896' = pm_descripcion,    --DESCRIPCION
      '1742' = pm_tipo      --TIPO
      from   cobis..cl_pro_moneda
      where  pm_producto = @i_producto
      order  by pm_moneda
    end
    if @i_modo = 1
    begin
      select
       '1653' = pm_producto,    --PRODUCTO
      '1481' = pm_moneda,    --MONEDA
      '1896' = pm_descripcion,    --DESCRIPCION
      '1742' = pm_tipo      --TIPO
      from   cobis..cl_pro_moneda
      where  pm_producto = @i_producto
         and pm_moneda   > @i_moneda
      order  by pm_moneda
    end

    set rowcount 0
  end

  if @i_operacion = 'D'
  begin
    if @t_trn != 4044
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      mo_decimales
    from   cobis..cl_moneda
    where  mo_moneda = @i_moneda
    if @@rowcount = 0
    begin
      /*No existe moneda*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351510
      return 351510
    end
  end

  return 0

go 
