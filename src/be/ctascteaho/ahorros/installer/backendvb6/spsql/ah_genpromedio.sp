/*******************************************************************/
/* ARCHIVO:         genprom.sp                                     */
/* NOMBRE LOGICO:   sp_gen_aliprom                                 */
/* PRODUCTO:        Cuentas Ahorros                                */
/*******************************************************************/
/*                        IMPORTANTE                               */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado hecho por alguno  de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales de propiedad inte-      */
/* lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/* obtener ordenes  de secuestro o  retencion y para  perseguir    */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                          PROPOSITO                              */
/* Genera la alicuota                                              */
/*******************************************************************/
/*                      MODIFICACIONES                             */
/* FECHA    /    MVE               Emision Inicial                 */
/* 04/May/2016   J. Salazar        Migracion COBIS CLOUD MEXICO    */
/*******************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_gen_aliprom')
  drop proc sp_gen_aliprom
go

/****** Object:  StoredProcedure [dbo].[sp_gen_aliprom]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_gen_aliprom
(
  @t_show_version bit = 0,
  @i_anio         smallint,
  @i_tprom        char(1),
  @i_fecha        datetime = null,
  @i_oper         char(1) = null,

  /*** Para generar una nueva operacion que solo devuelva la alicuota para un dia ****/
  @o_alic         float = null OUT
)
as
  declare
    @w_incper_m     tinyint,
    @w_incper_b     tinyint,
    @w_incper_t     tinyint,
    @w_incper_s     tinyint,
    @w_incper_x     tinyint,
    @w_anio         char(4),
    @w_fecha_inicio varchar(10),
    @w_fecha_ini    datetime,
    @w_fecha_fin    datetime,
    @w_fecha_tmp    datetime,
    @w_alicuota     float,
    @w_contador     smallint,
    @w_cont         smallint,
    @w_numero       smallint,
    @w_dias_periodo smallint,
    @w_dias_faltan  smallint,
    @w_sp_name      varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_gen_aliprom'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Define incrementos de periodo */
  select
    @w_incper_m = 1,
    @w_incper_b = 2,
    @w_incper_t = 3,
    @w_incper_s = 6

  select
    @w_anio = convert(varchar(4), @i_anio)
  select
    @w_fecha_inicio = '01/01/' + @w_anio
  select
    @w_fecha_ini = convert(datetime, @w_fecha_inicio)
  select
    @w_fecha_tmp = @w_fecha_ini
  select
    @w_fecha_fin = @w_fecha_ini
  select
    @w_contador = 0,
    @w_cont = 1

  /*** Se crea los datos en una tabla temporal ****/
  select
    *
  into   #ah_fecha_promedio
  from   cob_ahorros..ah_fecha_promedio
  where  1 = 2

  if @i_tprom = 'M'
  begin
    select
      @w_incper_x = @w_incper_m
    select
      @w_numero = 13
  end
  else if @i_tprom = 'B'
  begin
    select
      @w_incper_x = @w_incper_b
    select
      @w_numero = 7
  end
  else if @i_tprom = 'T'
  begin
    select
      @w_incper_x = @w_incper_t
    select
      @w_numero = 5
  end
  else if @i_tprom = 'S'
  begin
    select
      @w_incper_x = @w_incper_s
    select
      @w_numero = 3
  end
  else
  begin
    select
      'Error en tipo promedio'
    return 1
  end

  while @w_contador < @w_numero
  begin
    if @w_fecha_tmp = @w_fecha_fin
    begin
      select
        @w_fecha_ini = @w_fecha_tmp
      select
        @w_fecha_fin = dateadd(mm,
                               @w_incper_x,
                               @w_fecha_ini)
      select
        @w_dias_periodo = datediff(dd,
                                   @w_fecha_ini,
                                   @w_fecha_fin)
      select
        @w_contador = @w_contador + 1
      if @w_contador = @w_numero
        break
    end

    select
      @w_dias_faltan = datediff (dd,
                                 @w_fecha_tmp,
                                 @w_fecha_fin)
    select
      @w_alicuota = convert(float, @w_dias_faltan) /
                    convert(float, @w_dias_periodo)

    insert into #ah_fecha_promedio
    values      ('M',@w_cont,@w_fecha_tmp,@w_alicuota)

    select
      @w_cont = @w_cont + 1
    select
      @w_fecha_tmp = dateadd(dd,
                             1,
                             @w_fecha_tmp)
  end

  if @i_oper is null
  begin
    begin tran
    insert into cob_ahorros..ah_fecha_promedio
      select
        *
      from   #ah_fecha_promedio
    commit tran
  end
  else
  begin /*** Para devolver la alicuota de un solo dia ****/
    select
      @o_alic = fp_alicuota
    from   #ah_fecha_promedio
    where  fp_fecha_inicio = @i_fecha

    select
      @o_alic
  end
  return 0

go

