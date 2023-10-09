/************************************************************************/
/*      Archivo:             ah_caldias.sp                              */
/*      Stored procedure:    sp_calcula_dias                            */
/*      Base de datos:       cob_ahorros                                */
/*      Producto:           Cuentas Ahorros                             */
/*      Disenado por:       Julio Navarrete/Xavier Bucheli              */
/*      Fecha de escritura: 12-Ene-1993                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*      Pobla la tabla de dias laborables ah_dias_laborables por        */
/*      oficina y diariamente                                           */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*      FECHA         AUTOR               RAZON                         */
/*      25/Jul/1995     J Navarrete V.  Emision inicial                 */
/*      17/Feb/2010     J. Loyo     Manejo de la fecha de efectivizacion*/
/*                                  teniendo el sabado como habil       */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_calcula_dias')
  drop proc sp_calcula_dias
go

create proc sp_calcula_dias
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @i_ciudad       int
)
as
  declare
    @w_max_dias      tinyint,
    @w_cont_dias     tinyint,
    @w_fecha         datetime,
    @w_secuencial    smallint,
    @w_ciudad_matriz int,
    @w_sp_name       varchar(30)

  /*  Captura nombre de stored procedure  */
  select
    @w_sp_name = 'sp_calcula_dias'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /*  Inicializa variables  */
  select
    @w_max_dias = 100,
    @w_cont_dias = 0,
    @w_fecha = @i_fecha

  -- Determinar el codigo de la ciudad de feriados nacionales
  select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    -- Error: no se han definido ciudad de feriados nacionales
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR NO SE HA DEFINIDO CIUDAD DE FERIADOS NACIONALES'
    return 205031
  end

  /*  Inserta el registro correspondiente a la fecha de input */
  insert into cob_ahorros..ah_dias_laborables
              (dl_ciudad,dl_fecha,dl_num_dias)
  values      (@i_ciudad,@w_fecha,0)
  if @@error <> 0
  begin
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 103051
    return 1
  end

  /*  Calcula numero de dias transcurridos  */
  while @w_max_dias <> 0
  begin
    /*  Resta dias  */
    select
      @w_fecha = dateadd(dd,
                         -1,
                         @w_fecha)
    /*  Determina si @w_fecha es feriado  */
    if not exists (select
                     df_fecha
                   from   cobis..cl_dias_feriados
                   where  df_ciudad = @i_ciudad
                      and df_fecha  = @w_fecha
                       or df_ciudad = @w_ciudad_matriz
                          and df_fecha  = @w_fecha)
      select
        @w_cont_dias = @w_cont_dias + 1

    /*  Inserta el registro correspondiente  */
    insert into cob_ahorros..ah_dias_laborables
                (dl_ciudad,dl_fecha,dl_num_dias)
    values      (@i_ciudad,@w_fecha,@w_cont_dias * -1)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103051
      return 1
    end
    select
      @w_max_dias = @w_max_dias - 1
  end

  /*  Inicializa variables  */
  select
    @w_max_dias = 100,
    @w_cont_dias = 0,
    @w_fecha = @i_fecha

  /*  Calcula numero de dias posteriores  */
  while @w_max_dias <> 0
  begin
    /*  Suma dias  */
    select
      @w_fecha = dateadd(dd,
                         1,
                         @w_fecha)
    /*  Determina si @w_fecha es feriado  */
    if not exists (select
                     df_fecha
                   from   cobis..cl_dias_feriados
                   where  df_ciudad = @i_ciudad
                      and df_fecha  = @w_fecha
                       or df_ciudad = @w_ciudad_matriz
                          and df_fecha  = @w_fecha)
      select
        @w_cont_dias = @w_cont_dias + 1

    /*  Inserta el registro correspondiente  */
    insert into cob_ahorros..ah_dias_laborables
                (dl_ciudad,dl_fecha,dl_num_dias)
    values      (@i_ciudad,@w_fecha,@w_cont_dias)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103051
      return 1
    end
    select
      @w_max_dias = @w_max_dias - 1
  end

go

