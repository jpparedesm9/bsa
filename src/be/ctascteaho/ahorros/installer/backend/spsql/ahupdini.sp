/****************************************************************************/
/*      Archivo           :  ahupdini.sp                                    */
/*      Stored procedure  :  sp_ahupdini                                    */
/*      Base de datos     :  cob_ahorros                                    */
/*      Producto          :  Cuentas de Ahorros                             */
/*      Disenado por      :  Boris Mosquera                                 */
/*      Fecha de escritura:  08/Feb/95                                      */
/****************************************************************************/
/*                              IMPORTANTE                                  */
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
/*                              PROPOSITO                                   */
/*      Corrimiento de saldos en cuentas de ahorros                         */
/****************************************************************************/
/*                            MODIFICACIONES                                */
/*      FECHA           AUTOR                   RAZON                       */
/*      26/06/2016      Ignacio Yupa            Migracion SQR a SP          */   
/****************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahupdini')
  drop proc sp_ahupdini
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahupdini
(
    @s_srv              varchar(30) = null,
    @t_show_version     bit         = 0,
    @i_param1           int         = null,--@w_filial           int = null,
    @i_param2           datetime    = null--@w_fecha_proceso    datetime =null,  
)
as
DECLARE
    @w_retorno          int,    
    @w_sp_name          varchar(30),    
    @w_filial           int = null,
    @w_fecha_proceso    datetime =null,
    @w_procesadas       int  = null,
    @w_error            int,
    @w_msg              varchar(100)
    
select @w_filial        = @i_param1
select @w_fecha_proceso = @i_param2
select @w_sp_name = 'sp_ahupdini'

    if @t_show_version = 1
    begin
         print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
        return 0
    end
if not exists(select 1 
                from cobis..cl_filial 
                        where fi_filial=@w_filial)
begin
      select @w_error = 1,
           @w_msg = 'No Existe Filial'
    goto ERRORFIN
end

  execute @w_retorno  = cob_ahorros..sp_update_to_date_inicio_ah
        @i_filial   =   @w_filial,
        @i_fecha    =   @w_fecha_proceso,
        @s_srv      =   @s_srv,
        @o_procesadas = @w_procesadas out
    if @w_retorno <> 0
       begin
            select @w_error = @w_retorno,
                    @w_msg = 'Error en el sp cob_ahorros..sp_update_to_date_inicio_ah'
            goto ERRORFIN 
        end            
    
     truncate table cob_ahorros..re_error_batch
     if @@error <> 0
       begin
            select @w_error = @@error,
                   @w_msg = 'Error al eliminar la tabla cob_ahorros..re_error_batch'
            goto ERRORFIN    
       end

return 0

ERRORFIN:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 4204,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error
  
go



