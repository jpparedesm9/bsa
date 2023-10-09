/*******************************************************************/
/* ARCHIVO:         genperprom.sp                                  */
/* NOMBRE LOGICO:   sp_gen_per_prom                                */
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
/* Genera la fecha del periodo                                     */
/*******************************************************************/
/*                      MODIFICACIONES                             */
/* FECHA         AUTOR             RAZON                           */
/* 10/01/2002    CMO               Emision Inicial                 */
/* 04/May/2016   J. Salazar        Migracion COBIS CLOUD MEXICO    */
/*******************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_gen_per_prom')
  drop proc sp_gen_per_prom
go

/****** Object:  StoredProcedure [dbo].[sp_gen_per_prom]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_gen_per_prom
(
  @t_show_version bit = 0,
  @i_tprom        char(1)
)
as
  declare
    @w_incper_m      smallint,
    @w_incper_b      smallint,
    @w_incper_t      smallint,
    @w_incper_s      smallint,
    @w_incper_x      smallint,
    @w_mes           char(2),
    @w_anio          varchar(4),
    @w_fecha_inicio  varchar(10),
    @w_fecha_ini     datetime,
    @w_fecha_tmp     datetime,
    @w_contador      smallint,
    @w_fecha_proceso datetime,
    @w_sp_name       varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_gen_per_prom'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* Define incrementos de periodo */
  select
    @w_incper_m = -1,
    @w_incper_b = -2,
    @w_incper_t = -3,
    @w_incper_s = -6

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_mes = convert(char(2), datepart(mm,
                                       @w_fecha_proceso))
  select
    @w_anio = convert(varchar(4), datepart(yy,
                                           @w_fecha_proceso))
  select
    @w_fecha_inicio = @w_mes + '/01/' + @w_anio
  select
    @w_fecha_ini = convert(datetime, @w_fecha_inicio)
  select
    @w_fecha_tmp = @w_fecha_ini

  if @i_tprom = 'M'
    select
      @w_incper_x = @w_incper_m
  else if @i_tprom = 'B'
    select
      @w_incper_x = @w_incper_b
  else if @i_tprom = 'T'
    select
      @w_incper_x = @w_incper_t
  else if @i_tprom = 'S'
    select
      @w_incper_x = @w_incper_s
  else
  begin
    select
      'Error en tipo promedio'
    return 1
  end

  begin tran
  delete ah_fecha_periodo
  where  fp_tipo_promedio = @i_tprom
  select
    @w_contador = 1
  while @w_contador < 7
  begin
    insert into ah_fecha_periodo
    values      (@i_tprom,@w_contador,@w_fecha_tmp)

    select
      @w_contador = @w_contador + 1
    select
      @w_fecha_tmp = dateadd(mm,
                             @w_incper_x,
                             @w_fecha_tmp)
  end
  commit tran
  return 0

go

