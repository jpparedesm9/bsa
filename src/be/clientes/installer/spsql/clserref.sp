/************************************************************************/
/*  Archivo:            clserref.sp                                     */
/*  Stored procedure:   sp_serv_referenciacion                          */
/*  Base de datos:      cobis                                           */
/*  Producto:           MIS                                             */
/*  Disenado por:       Gabriel Alvis                                   */
/*  Fecha de escritura: 12/Abr/2011                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*  Determinacion de la viabilidad del cliente para la asignación de    */
/*  un producto                                                         */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR             RAZON                               */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

if object_id('sp_serv_referenciacion') is not null
  drop proc sp_serv_referenciacion
go

create proc sp_serv_referenciacion
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_producto     varchar(10) = null,
  @o_viable       char(1) = null out
as
  declare
    @w_sp_name       varchar(32),
    @w_error         int,
    @w_grupo_info    varchar(10),
    @w_tabla         varchar(64),
    @w_campo_entrada varchar(64),
    @w_campo_salida  varchar(64),
    @w_ponderado     int,
    @w_acumulado     int,
    @w_cantidad      smallint,
    @w_cant_noref    smallint,
    @w_fecha_proceso datetime,
    @w_comando       varchar(2000),
    @w_subtipo       char(1)
  declare @wt_ponderacion table
  (
     grupo      varchar(10),
     ponderado  int,
     acumulado  int,
     cantidad   smallint,
     cant_noref smallint
  )

  create table #verificacion
  (
    viabilidad varchar(10) null
  )

  select
    @w_sp_name = 'sp_serv_referenciacion'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = fp_fecha
  from   ba_fecha_proceso

  select
    @w_subtipo = en_subtipo
  from   cl_ente
  where  en_ente = @i_ente

  -- CICLO DE VALIDACION DE REFERENCIAS
  select
    @w_grupo_info = '',
    @w_tabla = ''

  while 1 = 1
  begin
    select top(1)
      @w_grupo_info = re_grupo_info,
      @w_tabla = er_tabla,
      @w_campo_entrada = er_campo_entrada,
      @w_campo_salida = er_campo_salida,
      @w_ponderado = vi_ponderacion
    from   cl_referenciacion,
           cl_viabilidad,
           cl_equivalencia_referenciacion
    where  re_producto     = @i_producto
       and re_tipo_persona = @w_subtipo
       and re_grupo_info   > @w_grupo_info
       and vi_resultado    = re_viabilidad
       and vi_estado       = 'V'
       and er_producto     = re_producto
       and er_tipo_persona = re_tipo_persona
       and er_grupo_info   = re_grupo_info
       and er_tabla        >= case
                                when re_grupo_info = @w_grupo_info then @w_tabla
                                else ''
                              end
    order  by re_grupo_info,
              er_tabla

    if @@rowcount = 0
      break

    truncate table #verificacion

    select
      @w_comando = 'insert into #verificacion select ' + @w_campo_salida +
                   ' from '
                   +
                                                         @w_tabla +
                                                         ' where '
                   + @w_campo_entrada + ' = ' + convert(varchar(10), @i_ente)

    exec(@w_comando)

    if @@error <> 0
      return 103096

    select
      @w_acumulado = sum(vi_ponderacion),
      @w_cantidad = count(1),
      @w_cant_noref = count(case
                              when vi_ponderacion is null then 1
                            end)
    from   #verificacion
           left outer join cl_viabilidad
                        on vi_resultado = viabilidad

    select
      @w_ponderado = isnull(@w_ponderado,
                            0),
      @w_acumulado = isnull(@w_acumulado,
                            0),
      @w_cant_noref = isnull(@w_cant_noref,
                             0)

    insert into @wt_ponderacion
    values      (@w_grupo_info,@w_ponderado,@w_acumulado,@w_cantidad,
                 @w_cant_noref
    )

    if @@error <> 0
      return 103097
  end

  if exists (select
               1
             from   @wt_ponderacion
             where  cant_noref > 0)
    select
      @o_viable = 'P'
  else
  begin
    if exists (select
                 1
               from   @wt_ponderacion
               where  ponderado > acumulado / isnull(nullif(cantidad,
                                                            0),
                                                     1))
      select
        @o_viable = 'N'
    else
      select
        @o_viable = 'S'

    exec @w_error = sp_tarea
      @i_operacion  = 'M',
      @i_ente       = @i_ente,
      @i_tipo       = 'R',
      @i_resultado  = @o_viable,
      @i_producto   = @i_producto,
      @i_fecha_proc = @w_fecha_proceso

    if @w_error <> 0
      return @w_error
  end

  return 0

go

