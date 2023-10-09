/********************************************************************/
/*  Archivo:                gen_periodo.sp                          */
/*  Stored procedure:       sp_gen_periodo                          */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*  Fecha de escritura:     04-Mar-1993                             */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Este programa genera la tabla de periodos de capitalizacion     */
/*  a ser usadas en  Cuentas de Ahorros.                            */
/*  Se consideran cuatro tipos de capitalizacion: [M]ensual,        */
/*  [B]imensual, [T]rimestral y [S]emestral.  En el caso de crear   */
/*  un nuevo tipo de capitalizacion se deberia crear una nueva      */
/*  columna en la que se almacenaria la correspondiente alicuota.   */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA         AUTOR         RAZON                               */
/*  04-Mar-1993   S Ortiz       Emision inicial                     */
/*  08-Ene-2010   J Arias       Modificacion Requerimiento FO-022   */
/*  04/May/2016   J. Salazar    Migracion COBIS CLOUD MEXICO        */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_gen_periodo')
  drop proc sp_gen_periodo
go

/****** Object:  StoredProcedure [dbo].[sp_gen_periodo]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_gen_periodo
(
  @t_show_version bit = 0,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @i_anio         smallint
)
as
  declare
    @w_mes            tinyint,
    @w_anio           smallint,
    @w_fecha_inicio   datetime,
    @w_fecha_fin      datetime,
    @w_num_dias       tinyint,
    @w_mes_siguiente  tinyint,
    @w_sp_name        varchar(30),
    @w_var            datetime,
    @w_var1           datetime,
    @w_incremento     tinyint,
    @w_periodo        tinyint,
    @w_anio_siguiente int,--variable a usarse en la capitalizacion semanal  JAR
    @w_mes_fin        tinyint
  --variable a usarse en la capitalizacion semanal  JAR 

  /*  Captura nombre del stored procedure   */
  select
    @w_sp_name = 'sp_gen_periodo'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/**  Stored Procedure  **/' = @w_sp_name,
      t_file = @t_file,
      t_from = @t_from,
      i_anio = @i_anio
    exec cobis..sp_end_debug
  end

  /*  Determinacion de periodos para capitalizacion mensual  */
  select
    @w_mes = 1,
    @w_anio = @i_anio

  while @w_mes <> 13
  begin
    select
      @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4
                        )
                        ,
                               @w_anio)

    if @w_mes <> 12
      select
        @w_mes_siguiente = @w_mes + 1
    else
      select
        @w_mes_siguiente = 1,
        @w_anio = @w_anio + 1

    select
      @w_fecha_fin = convert(varchar(2), @w_mes_siguiente) + '/01/' + convert(
                     varchar
                                                        ( 4), @w_anio)
    select
      @w_num_dias = datediff(dd,
                             convert(datetime, @w_fecha_inicio),
                             convert(datetime, @w_fecha_fin))
    select
      @w_fecha_fin = dateadd(dd,
                             @w_num_dias - 1,
                             convert(datetime, @w_fecha_inicio))

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('M',@w_mes,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
    end
    commit tran

    select
      @w_mes = @w_mes + 1
  end

  exec cob_ahorros..sp_gen_per_prom
    @i_tprom = 'M'

  /*  Determinacion de periodos para capitalizacion bimensual  */
  select
    @w_mes = 1,
    @w_incremento = 2,
    @w_periodo = 0,
    @w_anio = @i_anio

  while @w_mes <> 13
  begin
    select
      @w_periodo = @w_periodo + 1
    select
      @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4
                        )
                        ,
                                                               @w_anio)

    if @w_mes <> 11
      select
        @w_mes_siguiente = @w_mes + @w_incremento
    else
      select
        @w_mes_siguiente = 1,
        @w_anio = @w_anio + 1

    select
      @w_fecha_fin = convert(varchar(2), @w_mes_siguiente) + '/01/' + convert(
                     varchar
                                                        ( 4), @w_anio)
    select
      @w_num_dias = datediff(dd,
                             convert(datetime, @w_fecha_inicio),
                             convert(datetime, @w_fecha_fin))
    select
      @w_fecha_fin = dateadd(dd,
                             @w_num_dias - 1,
                             convert(datetime, @w_fecha_inicio))

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('B',@w_periodo,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 253002
    end
    commit tran

    select
      @w_mes = @w_mes + @w_incremento
  end

  exec cob_ahorros..sp_gen_per_prom
    @i_tprom = 'B'

  /*  Determinacion de periodos para capitalizacion trimestral  */
  select
    @w_mes = 1,
    @w_incremento = 3,
    @w_periodo = 0,
    @w_anio = @i_anio

  while @w_mes <> 13
  begin
    select
      @w_periodo = @w_periodo + 1
    select
      @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4
                        )
                        ,
                                                               @w_anio)

    if @w_mes <> 10
      select
        @w_mes_siguiente = @w_mes + @w_incremento
    else
      select
        @w_mes_siguiente = 1,
        @w_anio = @w_anio + 1

    select
      @w_fecha_fin = convert(varchar(2), @w_mes_siguiente) + '/01/' + convert(
                     varchar
                                                        ( 4), @w_anio)
    select
      @w_num_dias = datediff(dd,
                             convert(datetime, @w_fecha_inicio),
                             convert(datetime, @w_fecha_fin))
    select
      @w_fecha_fin = dateadd(dd,
                             @w_num_dias - 1,
                             convert(datetime, @w_fecha_inicio))

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('T',@w_periodo,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 253002
    end
    commit tran

    select
      @w_mes = @w_mes + @w_incremento
  end

  exec cob_ahorros..sp_gen_per_prom
    @i_tprom = 'T'

  /*  Determinacion de periodos para capitalizacion semestral  */
  select
    @w_mes = 1,
    @w_incremento = 6,
    @w_periodo = 0,
    @w_anio = @i_anio

  while @w_mes <> 13
  begin
    select
      @w_periodo = @w_periodo + 1
    select
      @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4
                        )
                        ,
                                                               @w_anio)

    if @w_mes <> 7
      select
        @w_mes_siguiente = @w_mes + @w_incremento
    else
      select
        @w_mes_siguiente = 1,
        @w_anio = @w_anio + 1

    select
      @w_fecha_fin = convert(varchar(2), @w_mes_siguiente) + '/01/' + convert(
                     varchar
                                                        ( 4), @w_anio)
    select
      @w_num_dias = datediff(dd,
                             convert(datetime, @w_fecha_inicio),
                             convert(datetime, @w_fecha_fin))
    select
      @w_fecha_fin = dateadd(dd,
                             @w_num_dias - 1,
                             convert(datetime, @w_fecha_inicio))

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('S',@w_periodo,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
    end
    commit tran

    select
      @w_mes = @w_mes + @w_incremento
  end

  exec cob_ahorros..sp_gen_per_prom
    @i_tprom = 'S'

  /*  Determinacion de periodos para capitalizacion semanal*/

  select
    @w_mes = 1,
    @w_anio = @i_anio,
    @w_periodo = 0,
    @w_incremento = 7

  select
    @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4),
                                                   @w_anio)

  select
    @w_anio_siguiente = datepart(yyyy,
                                 @w_fecha_inicio)

  while @w_anio = @w_anio_siguiente
  begin
    select
      @w_periodo = @w_periodo + 1
    select
      @w_fecha_fin = dateadd(dd,
                             @w_incremento,
                             convert(datetime, @w_fecha_inicio))

    if (datepart(yyyy,
                 @w_fecha_fin)) <> @w_anio
    begin
      select
        @w_mes_fin = datepart(mm,
                              convert(datetime, @w_fecha_inicio))

      select
        @w_fecha_fin = convert(varchar(2), @w_mes_fin) + '/31/' + convert(
                       varchar
                       (
                       4
                       ),
                       @w_anio)

      select
        @w_num_dias = datediff(dd,
                               convert(datetime, @w_fecha_inicio),
                               convert(datetime, @w_fecha_fin))
      if @w_num_dias <= 7
        select
          @w_num_dias = @w_num_dias + 1

    end
    else
    begin
      select
        @w_num_dias = datediff(dd,
                               convert(datetime, @w_fecha_inicio),
                               convert(datetime, @w_fecha_fin))
      select
        @w_fecha_fin = dateadd(dd,
                               @w_num_dias - 1,
                               convert(datetime, @w_fecha_inicio))

    end

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('E',@w_periodo,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 253002
    end
    commit tran
    select
      @w_fecha_inicio = dateadd(dd,
                                @w_incremento,
                                convert(datetime, @w_fecha_inicio))
    select
      @w_anio_siguiente = datepart(yyyy,
                                   @w_fecha_inicio)

  end

  /*  Determinacion de periodos para capitalizacion quincenal*/

  select
    @w_mes = 1,
    @w_anio = @i_anio,
    @w_periodo = 0,
    @w_incremento = 15

  select
    @w_fecha_inicio = convert(varchar(2), @w_mes) + '/01/' + convert(varchar(4),
                                                    @w_anio)

  select
    @w_anio_siguiente = datepart(yyyy,
                                 @w_fecha_inicio)

  while @w_anio = @w_anio_siguiente
  begin
    select
      @w_periodo = @w_periodo + 1
    select
      @w_fecha_fin = dateadd(dd,
                             @w_incremento,
                             convert(datetime, @w_fecha_inicio))

    if (datepart(yyyy,
                 @w_fecha_fin)) <> @w_anio
    begin
      select
        @w_mes_fin = datepart(mm,
                              convert(datetime, @w_fecha_inicio))

      select
        @w_fecha_fin = convert(varchar(2), @w_mes_fin) + '/31/' + convert(
                       varchar
                       (
                       4
                       ),
                       @w_anio)

      select
        @w_num_dias = datediff(dd,
                               convert(datetime, @w_fecha_inicio),
                               convert(datetime, @w_fecha_fin))
      if @w_num_dias <= 15
        select
          @w_num_dias = @w_num_dias + 1

    end
    else
    begin
      select
        @w_num_dias = datediff(dd,
                               convert(datetime, @w_fecha_inicio),
                               convert(datetime, @w_fecha_fin))
      select
        @w_fecha_fin = dateadd(dd,
                               @w_num_dias - 1,
                               convert(datetime, @w_fecha_inicio))
    end

    begin tran
    insert into ah_periodo
                (pe_capitalizacion,pe_periodo,pe_fecha_inicio,pe_fecha_fin,
                 pe_num_dias)
    values      ('Q',@w_periodo,convert(datetime, @w_fecha_inicio),@w_fecha_fin,
                 @w_num_dias)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253002
    end
    commit tran
    select
      @w_fecha_inicio = dateadd(dd,
                                @w_incremento,
                                convert(datetime, @w_fecha_inicio))
    select
      @w_anio_siguiente = datepart(yyyy,
                                   @w_fecha_inicio)

  end

  return 0

go

