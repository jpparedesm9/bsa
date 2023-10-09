/*******************************************************************/
/* Archivo:                ahfecfper.sp                            */
/* Stored procedure:       sp_fecha_fin_periodo                    */
/* Base de datos:          cob_ahorros                             */
/* Producto:               Ahorros                                 */
/* Disenado por:           Andres Diab                             */
/* Fecha de escritura:     07/05/2012                              */
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
/*                         PROPOSITO                               */
/* Hallar fecha de fin de periodo mas cercana a la fecha de ingreso*/
/*                                                                 */
/*******************************************************************/
/*                      MODIFICACIONES                             */
/* FECHA          AUTOR               RAZON                        */
/* 07/05/2012     Andres Diab         Emision Inicial              */
/* 04/May/2016    J. Salazar          Migracion COBIS CLOUD MEXICO */
/*******************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_fecha_fin_periodo')
  drop proc sp_fecha_fin_periodo
go

/****** Object:  StoredProcedure [dbo].[sp_fecha_fin_periodo]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_fecha_fin_periodo
(
  @t_show_version bit = 0,
  @i_fecha        datetime,-- Fecha Original
  @i_periodo      smallint,-- Periodo 2-Bimestre; 3-Trimestre; 6-Semestre
  @i_finsemana    char(1) = 'S',-- S para excluir sabados.
  @o_fecha_fin    datetime = null out
-- Fecha Fin de Periodo mas cercana a la fecha dada
)
as
  declare
    @w_ciudad  int,
    @w_msg     varchar(64),
    @w_sp_name varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_fecha_fin_periodo'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* PARAMETRO CIUDAD MATRIZ */
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'
  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO PARAMETRO DE CIUDAD MATRIZ DE REINTEGRO'
    goto ERROR
  end

  /* Hallar fin de trimestre mas cercano a la fecha dada */
  while (datepart(mm,
                  @i_fecha) % @i_periodo) <> 0
  begin
    select
      @i_fecha = dateadd(mm,
                         1,
                         @i_fecha)
  end

  select
    @i_fecha = dateadd(mm,
                       1,
                       @i_fecha)
  select
    @i_fecha = dateadd(dd,
                       (datepart(dd,
                                 @i_fecha)) * -1,
                       @i_fecha)

  if (datediff(day,
               0,
               @i_fecha)%7 + 1) = 6
     and @i_finsemana = 'S'
    select
      @i_fecha = dateadd(dd,
                         -1,
                         @i_fecha)

  while exists(select
                 1
               from   cobis..cl_dias_feriados
               where  df_ciudad = @w_ciudad
                  and df_fecha  = @i_fecha)
  begin
    select
      @i_fecha = dateadd(dd,
                         -1,
                         @i_fecha)
    if (datediff(day,
                 0,
                 @i_fecha)%7 + 1) = 6
       and @i_finsemana = 'S' -- Cambio por manejo de sabado como habil
      select
        @i_fecha = dateadd(dd,
                           -1,
                           @i_fecha)
  end

  select
    @o_fecha_fin = @i_fecha

  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg

  return 1

go

