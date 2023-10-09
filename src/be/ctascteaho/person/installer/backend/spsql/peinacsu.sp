/****************************************************************************/
/*      Archivo         : peinacsu.sp                                       */
/*      Store Procedure : sp_det_serv_pe                                      */
/*      Base de Datos   : cob_remesas                                       */
/*      Producto        : XXXXXXXXXXXXXXX                                   */
/*      Disenado por    : Javier G.                                         */
/*      Fecha de escritura : 01/DIC/94                                      */
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
/*       Este programa realiza la transaccion que permite el ingreso        */
/*       actualizacion y consulta.                                          */
/****************************************************************************/
/*                             MODIFICACIONES                               */
/*   FECHA             AUTOR                 RAZON                          */
/*                                                                          */
/* 30/Sep/2003      Gloria Rueda    Retornar c¢digos de error              */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_det_serv_pe')
  drop proc sp_det_serv_pe
go
create proc sp_det_serv_pe
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
  @i_operacion    char(2) = null,
  @i_codigo       smallint,
  @i_rubro        catalogo,
  @i_descripcion  descripcion,
  @i_tipo_dato    char(1),
  @i_estado       char(1)
)
as
  declare
    @w_servicio   int,
    @w_return     int,
    @w_sp_name    varchar(32),
    @w_secuencial int,
    @w_clave      int

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_det_serv_pe'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo Debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Store Procedure **/' = @w_sp_name,
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
      i_codigo = @i_codigo,
      i_rubro = @i_rubro,
      i_descripcion = @i_descripcion,
      i_tipo_dato = @i_tipo_dato,
      i_estado = @i_estado
    exec cobis..sp_end_debug
  end

  if @t_trn not in (4025, 4026)
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  /* Validaciones */
  if @i_tipo_dato not in ('P', 'M')
  begin
    /* Tipo de dato  no definido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351505
    return 351505
  end

  if not exists (select
                   *
                 from   pe_servicio_dis
                 where  sd_servicio_dis = @i_codigo)
  begin
    /* No existe servicio disponible */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351501
    return 351501
  end

  if @i_operacion = 'I'
  begin
    if @t_trn != 4025
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if exists (select
                 *
               from   pe_servicio_dis
               where  sd_servicio_dis = @i_codigo
                  and sd_estado       = 'N')
    begin
      /* El servicio esta fuera de vigencia                 */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351519
      return 351519
    end

    if exists (select
                 *
               from   pe_var_servicio
               where  vs_servicio_dis = @i_codigo
                  and vs_rubro        = @i_rubro)
    begin
      /* Ya existe servicio asociado a este rubro           */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351503
      return 351503
    end

    /* Inicio de Transaccion */
    begin tran

    insert into pe_var_servicio
                (vs_servicio_dis,vs_rubro,vs_descripcion,vs_tipo_dato,vs_estado)
    values      (@i_codigo,@i_rubro,@i_descripcion,@i_tipo_dato,@i_estado)

    if @@error != 0
    begin
      /* Error en insercion de detalle de servicio   */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353501
      return 353501
    end
    /* Incrementa en uno el contador de rubros */
    update pe_servicio_dis
    set    sd_num_rubro = sd_num_rubro + 1
    where  sd_servicio_dis = @i_codigo

    if @@error != 0
    begin
      /* Error en creacion de registros en detalle servicio   */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355501
      return 355501
    end
    commit tran
    return 0
  end

  if @i_operacion = 'U'
  begin
    if @t_trn != 4026
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    if not exists (select
                     *
                   from   cob_remesas..pe_var_servicio
                   where  vs_servicio_dis = @i_codigo
                      and vs_rubro        = @i_rubro)
    begin
      /* No existe servicio asociado a este rubro */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351502
      return 351502
    end

    /* Inicio de Transaccion */
    begin tran
    update pe_var_servicio
    set    vs_descripcion = @i_descripcion,
           vs_tipo_dato = @i_tipo_dato,
           vs_estado = @i_estado
    where  vs_servicio_dis = @i_codigo
       and vs_rubro        = @i_rubro

    if @@error != 0
    begin
      /* Error en actualizacion de detalle servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355500
      return 355500
    end
    commit tran
  end
  return 0

GO 
