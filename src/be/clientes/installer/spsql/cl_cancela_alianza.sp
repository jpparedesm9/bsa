/* ***********************************************************************/
/*      Archivo:                cl_cancela_alianza.sp                    */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           j.molano                                 */
/*      Fecha de escritura:     Abril-2013                               */
/* ***********************************************************************/
/*                          IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*                           PROPOSITO                                   */
/*  Permite validar las fechas de vencimiento de las alianzas            */
/*  comerciales y marcarlas como canceladas.                             */
/* ***********************************************************************/
/*                         MODIFICACIONES                                */
/*  FECHA          AUTOR            RAZON                                */
/*  May/02/2016    DFu              Migracion CEN                        */
/*************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_validacan_alianza')
  drop proc sp_validacan_alianza
go

create proc sp_validacan_alianza
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name    char(30),
    @w_fecha_proc datetime,
    @w_alianza    int,
    @w_fecha_fin  datetime,
    @w_errores    int,
    @w_dias_vig   int

  select
    @w_sp_name = 'sp_validacan_alianza'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_errores = 0
  select
    @w_alianza = 0

  select
    @w_fecha_proc = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_dias_vig = pa_int
  from   cl_parametro
  where  pa_nemonico = 'VIGERR'
     and pa_producto = 'MIS'

  if @@rowcount = 0
  begin
    print 'NO EXISTE PARAMETRO VIGERR'
    return 1
  end

  select
    al_alianza,
    al_fecha_fin
  into   #alianzas
  from   cobis..cl_alianza
  where  al_estado = 'V'
  order  by al_alianza

  delete cobis..cl_alianza_linea_tmp

  /* ELIMINA LOS REGISTROS DE ERROR VENCIDOS*/

  delete from ca_msv_error
  where  datediff(dd,
                  me_fecha,
                  getdate()) >= @w_dias_vig

  while 1 = 1
  begin
    select
      @w_alianza = al_alianza,
      @w_fecha_fin = al_fecha_fin
    from   #alianzas
    if @@rowcount = 0
      break

    delete #alianzas
    where  al_alianza = @w_alianza

    if @w_fecha_fin <= @w_fecha_proc
    begin
      update cobis..cl_alianza
      set    al_estado = 'C',
             al_fecha_cancelacion = getdate()
      where  al_alianza = @w_alianza
         and al_estado  <> 'C'
      if @@error <> 0
      begin
        print 'ERROR EN CANCELACIËN DE ALIANZA: ' + convert(varchar(10),
              @w_alianza)
        select
          @w_errores = @w_errores + 1
        goto SIGUIENTE
      end
    end
    SIGUIENTE:
  end
  if @w_errores > 0
    return 1
  return 0

go

