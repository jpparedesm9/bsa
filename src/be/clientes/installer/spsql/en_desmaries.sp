/*********************************************************************/
/*  Archivo:            en_desmaries.sp                              */
/*  Stored procedure:   sp_desmarca_riesgo                           */
/*  Base de datos:      cobis                                        */
/*  Producto:           MIS                                          */
/*  Disenado por:       Andrés Muñoz                                 */
/*  Fecha de escritura: 11/JUL/2014                                  */
/*********************************************************************/
/*                      IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad     */
/*  de COBISCorp.                                                    */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de   derechos de autor   */
/*  y por las    convenciones  internacionales   de  propiedad inte- */
/*  lectual.   Su uso no  autorizado dara  derecho a  COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir     */
/*  penalmente a los autores de cualquier   infraccion.              */
/*********************************************************************/
/*                      PROPOSITO                                    */
/*   Realiza las desmarcacion a los clientes en alto riesgo          */
/*   en caso de haber cumplido el tiempo de marcacion                */
/*********************************************************************/
/*                      MODIFICACIONES                               */
/*  FECHA               AUTOR            RAZON                       */
/*  11/JUL/2014         Andrés Muñoz     Emision Inicial Req 423     */
/*                                       Nueva Instancia Riesgos     */
/*  04/May/2016         T. Baidal        Migracion a CEN             */
/*********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_desmarca_riesgo')
           drop proc sp_desmarca_riesgo
go

create proc sp_desmarca_riesgo
(
  @t_show_version  bit = 0
)
as
  declare
    @w_permanencia_riesgo int,
    @w_fecha_proceso      datetime,
    @w_fecha_riesgo       datetime,
    @w_ente               int,
    @w_sp_name            varchar(30)

  select
    @w_sp_name = 'sp_desmarca_riesgo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set nocount on

  select
    @w_fecha_proceso = fp_fecha
  from   ba_fecha_proceso

  select
    @w_permanencia_riesgo = pa_int
  from   cl_parametro
  where  pa_nemonico = 'PEALRI'
     and pa_producto = 'CRE'

  select
    *
  into   #entes_riesgo
  from   cobis..cl_ente with(nolock)
  where  en_alto_riesgo = 'S'
  order  by en_ente

  if @@rowcount > 0
  begin
    insert into cl_actualiza
                (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                 ac_valor_nue,ac_transaccion)
      select
        e.en_ente,getdate(),'cl_ente','en_alto_riesgo-en_fecha_riesgo',
        e.en_alto_riesgo + '-' + convert(varchar(10), e.en_fecha_riesgo, 101),
        null,'U'
      from   #entes_riesgo t,
             cobis..cl_ente e
      where  e.en_ente                                       = t.en_ente
         and datediff(DD,
                      e.en_fecha_riesgo,
                      @w_fecha_proceso) >= @w_permanencia_riesgo

    if @@error <> 0
    begin
      print 'ERROR AL IGRESAR LOG DE DESMARCACION ALTO RIESGO'
      return 1
    end

    update cl_ente
    set    en_alto_riesgo = null,
           en_fecha_riesgo = null
    from   #entes_riesgo t,
           cobis..cl_ente e
    where  e.en_ente                                       = t.en_ente
       and datediff(DD,
                    e.en_fecha_riesgo,
                    @w_fecha_proceso) >= @w_permanencia_riesgo

    if @@error <> 0
    begin
      print 'ERROR AL ACTUALIZAR MARCA ALTO RIESGO'
      return 1
    end
  end

  set nocount off
  return 0

go

