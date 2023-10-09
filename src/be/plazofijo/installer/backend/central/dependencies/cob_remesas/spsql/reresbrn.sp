/****************************************************************************/
/*     Archivo:            resultados_branch_caja.sp                        */
/*     Stored procedure:   sp_resultados_branch_caja                        */
/*     Base de datos:      cob_remesas                                      */
/*     Producto:           Personalizacion                                  */
/*     Disenado por:       Jorge Baque                                      */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA           AUTOR           RAZON                                 */
/*    13/May/2016     Jorge Baque     Migracion a CEN                       */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_resultados_branch_caja')
  drop proc sp_resultados_branch_caja
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE proc sp_resultados_branch_caja (
    @i_sldcaja      money,
    @i_idcierre     tinyint,
    @i_ssn_host     int,
    @i_alerta       char(1) = 'N',
    @i_alerta_cli   varchar(40) = ''
)
as
declare @w_return       int,
        @w_sp_name      varchar(30),
        @w_fecha_host   datetime

/*  Captura nombre del stored procedure   */
select    @w_sp_name = 'sp_resultados_branch_caja'

select @w_fecha_host = getdate()

select "results_submit_rpc",
   r_sldcaja       = @i_sldcaja,
   r_idcierre      = @i_idcierre,
   r_ssn_host      = @i_ssn_host,
   r_fecha_host    = @w_fecha_host,
   r_alerta        = @i_alerta,
   r_alerta_cli    = @i_alerta_cli

return 0


go
