/************************************************************************/
/*  Archivo:        his_rela.sp                                         */
/*  Stored procedure:   sp_his_relacion                                 */
/*  Base de datos:      Cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:           Carlos Rodriguez V.                         */
/*  Fecha de escritura:     16-May-94                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones del store procedure         */
/*  Busqueda de Historia de Relaciones                                  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*                             Emision Inicial                          */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_his_relacion')
    drop proc sp_his_relacion
go

create proc sp_his_relacion
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_ente_i       int,
  @i_relacion     smallint = null,
  @i_ente_d       int = null
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_his_relacion'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 101
  begin
    set rowcount 20
    if @i_modo = 0
      select
        'Relacion' = hr_relacion,
        'Descripcion' = substring(re_descripcion,
                                  1,
                                  25),
        'Cod. Cliente' = hr_ente_d,
        'Nombre del Cliente' = substring(rtrim(en_nombre) + ' ' + rtrim(
                                         p_p_apellido
                                         )
                                         +
                                         ' ' + rtrim(
                                                                p_s_apellido),
                                         1,
                                         65),
        'Desde' = convert(char(10), hr_fecha_ini, 103),
        'Hasta' = convert(char(10), hr_fecha_fin, 103)
      from   cl_his_relacion,
             cl_relacion,
             cl_ente
      where  hr_relacion = re_relacion
         and hr_ente_d   = en_ente
         and hr_ente_i   = @i_ente_i
      order  by hr_relacion

    if @i_modo = 1
      select
        'Relacion' = hr_relacion,
        'Descripcion' = substring(re_descripcion,
                                  1,
                                  25),
        'Cod. Cliente' = hr_ente_d,
        'Nombre del Cliente' = substring(rtrim(en_nombre) + ' ' + rtrim(
                                         p_p_apellido
                                         )
                                         +
                                         ' ' + rtrim(
                                                                p_s_apellido),
                                         1,
                                         65),
        'Desde' = convert(char(10), hr_fecha_ini, 103),
        'Hasta' = convert(char(10), hr_fecha_fin, 103)
      from   cl_his_relacion,
             cl_relacion,
             cl_ente
      where  hr_relacion = re_relacion
         and hr_ente_d   = en_ente
         and (hr_relacion > @i_relacion
               or (hr_relacion = @i_relacion
                   and hr_ente_d   > @i_ente_d))
         and hr_ente_i   = @i_ente_i
      order  by hr_relacion

    set rowcount 0
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

