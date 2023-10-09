/****************************************************************************/
/*      Archivo         : peinser.sp                                        */
/*      Store Procedure : sp_ins_serv_pe                                    */
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
/*       de registros a la tabla de servicios.                              */
/*       XXXXXX  = Insercion de Servicios.                                  */
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
           where  name = 'sp_ins_serv_pe')
  drop proc sp_ins_serv_pe
go
create proc sp_ins_serv_pe
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
  @i_operacion    char(2),
  @i_modo         tinyint = null,
  @i_codigo       smallint = 0,
  @i_nemonico     varchar(10) = null,
  @i_descr        varchar(40) = null,
  @i_estad        char(1) = null,
  @i_costin       money = null,
  @i_histr        char(1) = null,
  @o_codser       smallint = null out
)
as
  declare
    @w_servicio int,
    @w_return   int,
    @w_sp_name  varchar(32),
    @w_estado   char(1)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_ins_serv_pe'

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
      i_nemonico = @i_nemonico,
      i_descr = @i_descr,
      i_estad = @i_estad,
      i_costin = @i_costin,
      i_histr = @i_histr
    exec cobis..sp_end_debug
  end

  if @i_operacion = 'I'
  begin
    if @t_trn <> 4027
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
    if @i_estad not in ('V', 'N')
    begin
      /* Error en tipo de estado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    /* Valida Existencia */
    if exists (select
                 *
               from   cob_remesas..pe_servicio_dis
               where  sd_nemonico = @i_nemonico)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351560
      return 351560
    end

    /* Inicio de Transaccion */
    begin tran
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @i_tabla     = 'pe_servicio_dis',
      @o_siguiente = @w_servicio out

    if @w_return <> 0
      return @w_return

    select
      @o_codser = @w_servicio

    insert into cob_remesas..pe_servicio_dis
                (sd_servicio_dis,sd_descripcion,sd_nemonico,sd_estado,
                 sd_costo_interno,
                 sd_num_rubro,sd_historico)
    values      (@w_servicio,@i_descr,@i_nemonico,@i_estad,@i_costin,
                 0,@i_histr)

    if @@error <> 0
    begin
      /* Error en insercion de servicio disponible */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353500
      return 353500
    end
    select
      @o_codser
    commit tran
    return 0
  end

  if @i_operacion = 'U'
  begin
    if @t_trn <> 4028
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
    if @i_estad not in ('V', 'N')
    begin
      /* Error en tipo de estado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    select
      @w_estado = sd_estado
    from   pe_servicio_dis
    where  sd_servicio_dis = @i_codigo

    if @@rowcount <> 1
    begin
      /*  No existe servicio disponible  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351501
      return 351501
    end

    /* Inicio de Transaccion */
    begin tran

    update cob_remesas..pe_servicio_dis
    set    sd_descripcion = @i_descr,
           sd_estado = @i_estad,
           sd_costo_interno = @i_costin,
           sd_historico = @i_histr
    where  sd_servicio_dis = @i_codigo

    if @@rowcount <> 1
    begin
      /* Error en actualizacion de servicio disponible */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355509
      return 355509
    end
  /* Si no esta en vigencia el servicio, todos los subservicios tambien */
    /* pierden vigencia.                                                  */
    if @i_estad <> @w_estado
    begin
      if exists (select
                   *
                 from   pe_var_servicio
                 where  vs_servicio_dis = @i_codigo)
      begin
        update pe_var_servicio
        set    vs_estado = @i_estad
        where  vs_servicio_dis = @i_codigo

        if @@rowcount <> 1
        begin
          /* Error en actualizacion de subservicios        */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 355500
          return 355500
        end
      end
    end
    commit tran
    return 0
  end
  if @i_operacion = 'S'
  begin
    if @t_trn <> 4029
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
      '1093' = sd_servicio_dis,                  --CODIGO
      '1497' = sd_nemonico,                      --NEMONICO
      '1710' = substring(sd_descripcion, 1, 40), --SERVICIO
      '1333' = sd_estado,                        --ESTADO
      '1118' = sd_costo_interno,                 --COSTO INTERNO
      '1515' = sd_num_rubro,                     --NO. RUBROS
      '1402' = sd_historico                      --HISTORICO
    from   pe_servicio_dis
    where  sd_servicio_dis > @i_codigo

    set rowcount 0
    return 0
  end
  if @i_operacion = 'Q'
  begin
    if @t_trn <> 4030
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
      sd_descripcion,
      sd_nemonico,
      sd_estado,
      sd_costo_interno,
      sd_historico,
      sd_num_rubro
    from   pe_servicio_dis
    where  sd_servicio_dis = @i_codigo

    if @@rowcount <> 1
    begin
      /* No existe servicios disponibles               */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351501
      return 351501
    end
    return 0
  end

GO 
