/*************************************************************************/
/*      Archivo         : pebasico.sp                                    */
/*      Store Procedure : sp_basico_pe                                   */
/*      Base de Datos   : cob_remesas                                    */
/*      Producto        : XXXXXXXXXXXXXXX                                */
/*      Disenado por    : Javier G.                                      */
/*      Fecha de escritura : 01/DIC/94                                   */
/*************************************************************************/
/*                           IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                              PROPOSITO                                */
/*       Este programa realiza la transaccion que permite el ingreso     */
/*       de registros a la tabla de servicios.                           */
/*       XXXXXX  = Insercion de Servicios.                               */
/*************************************************************************/
/*                             MODIFICACIONES                            */
/*      FECHA             AUTOR                 RAZON                    */
/*   30/Sep/2003      Gloria Rueda         Retornar c¢digos de error     */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/*************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_basico_pe')
  drop proc sp_basico_pe
go
create proc sp_basico_pe
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
  @i_mercado      smallint = null,
  @i_servicio     smallint = null,
  @i_estado       char(1) = null
)
as
  declare
    @w_servicio    int,
    @w_return      int,
    @w_sp_name     varchar(32),
    @w_tabla_causa varchar(30),
    @w_estado      char(1)

  /* Capture nombre del store procedure */
  select
    @w_sp_name = 'sp_basico_pe'

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
      i_mercado = @i_mercado,
      i_servicio = @i_servicio,
      i_estado = @i_estado
    exec cobis..sp_end_debug
  end

  if @i_operacion = 'I'
  begin
    if @t_trn != 4040
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
    if @i_estado not in ('V', 'N')
    begin
      /* Error en tipo de estado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    if not exists (select
                     *
                   from   pe_mercado
                   where  me_mercado = @i_mercado)
    begin
      /* No existe mercado definido*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351511
      return 351511
    end

    if not exists (select
                     *
                   from   pe_servicio_dis
                   where  sd_servicio_dis = @i_servicio)
    begin
      /* No existe servicio disponible */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351501
      return 351501
    end

    if exists (select
                 *
               from   pe_basico
               where  ba_mercado  = @i_mercado
                  and ba_servicio = @i_servicio)
    begin
      /* Ya existe servicio basicos  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351546
      return 351546
    end
    /* Inicio de Transaccion */
    begin tran

    insert into pe_basico
                (ba_mercado,ba_servicio,ba_estado)
    values      (@i_mercado,@i_servicio,@i_estado )

    if @@error != 0
    begin
      /* Error en insercion de servicios basicos */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353510
      return 353510
    end
    commit tran
    return 0
  end

  if @i_operacion = 'U'
  begin
    if @t_trn != 4042
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
    if @i_estado not in ('V', 'N')
    begin
      /* Error en tipo de estado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351500
      return 351500
    end

    if not exists (select
                     *
                   from   pe_mercado
                   where  me_mercado = @i_mercado)
    begin
      /* No existe mercado definido*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351511
      return 351511
    end

    if not exists (select
                     *
                   from   pe_servicio_dis
                   where  sd_servicio_dis = @i_servicio)
    begin
      /* No existe servicio disponible */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351501
      return 351501
    end
    /* Inicio de Transaccion */
    begin tran

    update pe_basico
    set    ba_estado = @i_estado
    where  ba_servicio = @i_servicio
       and ba_mercado  = @i_mercado

    if @@rowcount != 1
    begin
      /* Error en actualizacion de servicios basicos */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 355514
      return 355514
    end
    commit tran
    return 0
  end
  if @i_operacion = 'S'
  begin
    if @t_trn != 4041
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
      '1475' = ba_mercado,
      '1648' = substring(pb_descripcion,
                                   1,
                                   35),
      '1710' = ba_servicio,
      '1189' = substring(sd_descripcion,
                                1,
                                35),
      '1333' = ba_estado
    from   pe_basico,
           pe_mercado,
           pe_servicio_dis,
           pe_pro_bancario
    where  ba_mercado      = me_mercado
       and me_pro_bancario = pb_pro_bancario
       and ba_servicio     = sd_servicio_dis
       and (ba_mercado      > @i_mercado
             or (ba_mercado      = @i_mercado
                 and ba_servicio     > @i_servicio))
    order  by ba_mercado,
              ba_servicio

    set rowcount 0
    return 0
  end

go 
