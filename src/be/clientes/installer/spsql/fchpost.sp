/************************************************************************/
/*  Archivo:            fchpost.sp                                      */
/*  Stored procedure:   sp_fecha_posterior                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 04-May-1993                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                           PROPOSITO                                  */
/*  Este programa determina la fecha habil dada una                     */
/*  fecha y los dias posteriores a esta                                 */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR          RAZON                                    */
/*  04-May-1993 J Navarrete    Emision inicial                          */
/*  19-Sep-2008 A Correa       Festivos por ciudad de oficina           */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_fecha_posterior')
  drop proc sp_fecha_posterior
go

create proc sp_fecha_posterior
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @i_dias         tinyint,
  @i_ofi          smallint = null,
  @o_fecha_efec   datetime out
)
as
  declare
    @w_cont_dias tinyint,
    @w_fecha     datetime,
    @w_sp_name   varchar(30),
    @w_ciudad    int

  /*  Captura nombre de stored procedure  */
  select
    @w_sp_name = 'sp_fecha_posterior'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Inicializa variables  */
  select
    @w_cont_dias = 0,
    @w_fecha = @i_fecha

  if @i_ofi is null
  begin
    select
      @w_ciudad = pa_int
    from   cobis..cl_parametro
    where  pa_producto = 'CTE'
       and pa_nemonico = 'CMA'
  end
  else
  begin
    select
      @w_ciudad = of_ciudad
    from   cobis..cl_oficina
    where  of_oficina = @i_ofi
  end

  /*  Calcula fecha de dias posteriores  */
  while @w_cont_dias < @i_dias
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
                   where  df_fecha  = @w_fecha
                      and df_ciudad = @w_ciudad)
      select
        @w_cont_dias = @w_cont_dias + 1

  end
  select
    @o_fecha_efec = @w_fecha
  return 0

go

