/****************************************************************************/
/*  Archivo:                ejejar.sp                           */
/*  Stored procedure:       sp_ejecuta_jar                                  */ 
/*  Base de datos:          cob_ahorros                                     */
/*  Producto:               Cuentas de Ahorros                              */
/****************************************************************************/
/*              IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*  Este programa realiza la actualizacion de estados en cuenta de ahorros  */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*  FECHA           AUTOR           RAZON                                   */
/*  16/09/2016      I. Yupa         Emision inicial                         */
/****************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ejecuta_jar')
   drop proc sp_ejecuta_jar
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ejecuta_jar (
@i_param1      datetime = null --Fecha de proceso
)
as
declare
@w_return        int,
@w_mensaje       varchar(255),
@w_fecha         datetime,
@w_ciudad_matriz int,
@w_comando       varchar(255),
@w_ofi           smallint,
@w_fecha_despues datetime,
@w_path          varchar(100)




select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA' 
     
select
    @w_ofi = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'OMAT'  

SELECT @w_path = ba_path_fuente 
FROM cobis..ba_batch 
WHERE ba_batch = '4260'     

exec @w_return = cob_remesas..sp_fecha_habil
    @i_val_dif       = 'N',
    @i_efec_dia      = 'S',
    @i_fecha         = @i_param1,
    @i_oficina       = @w_ofi,
    @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
    @i_finsemana     = 'N',
    @w_dias_ret      = 1,/*** Dia Siguiente habil          ***/
    @o_ciudad_matriz = @w_ciudad_matriz out,
    @o_fecha_sig     = @w_fecha_despues out 
    
select
    @w_comando = @w_path + 'actest.bat ' + CONVERT(char(10), @i_param1,126) + ' ' + CONVERT(char(10), @w_fecha_despues,126)
				 --print  @w_comando

  /* EJECUTAR CON CMDSHELL */
  exec @w_return = xp_cmdshell
    @w_comando
	
if @w_return  <> 0
  begin
    select
      @w_mensaje = 'ERROR ACTUALIZANDO ESTADOS JAR',
      @w_return = 4000003      
    goto ERRORFIN
  end


return 0

ERRORFIN:
  select @w_fecha = getdate() 
    exec cobis..sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @w_return,
   @i_usuario     = 'admuser',     
   @i_descripcion = @w_mensaje,
   @i_rollback    = 'N',
   @i_tran        = 4000,
   @i_tran_name   = 'sp_ejecuta_jar'
  
  return @w_return

GO

