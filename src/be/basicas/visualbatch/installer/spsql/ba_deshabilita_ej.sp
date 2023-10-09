use cobis
go

if object_id('sp_ba_deshabilita_ej') is not null
begin
  drop procedure sp_ba_deshabilita_ej
  if object_id('sp_ba_deshabilita_ej') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_ba_deshabilita_ej'
  end
end
go
create procedure sp_ba_deshabilita_ej
/************************************************************************/
/*      Archivo              :  ba_deshabilita_ej.sp                    */
/*      Base de datos        :  cobis                                   */
/*      Producto             :  Visual Batch                            */
/*      Disenado por         :  Alfonso Duque                           */
/*      Fecha de escritura   :  11/Jul/2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "Cobiscorp", representantes exclusivos para el Ecuador de la    */
/*      "Cobiscorp CORPORATION".                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de Cobiscorp o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      DesHabilitacion de Productos                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      11/Jul/2005     Alfonso Duque   Emision inicial                 */
/*      10/Oct/2012     J. Hidalgo      Reescritura SQR's por SP's      */
/************************************************************************/
(
  @t_show_version     bit            = 0,    -- show the version of the stored procedure  
  -- parametros para registro de log de ejecucion
  @i_sarta         int               = null,
  @i_batch         int               = null,
  @i_secuencial    int               = null,
  @i_corrida       int               = null,
  @i_intento       int               = null
)
as
begin
declare @w_sp_name          varchar(30),
        @w_retorno          int,
        @w_retorno_ej       int

select @w_sp_name = 'sp_ba_deshabilita_ej'


---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure=%1! Version=%2!', @w_sp_name, '4.0.0.0'
   return 0
end
-----------------------------------------------------------------

update cobis..cl_pro_moneda
set pm_estado='B'
where pm_producto not in (select ha_producto from cobis..ba_habilita)

if @@error <> 0
begin
   exec @w_retorno_ej = cobis..sp_ba_error_log
        @i_sarta      = @i_sarta,
        @i_batch      = @i_batch,
        @i_secuencial = @i_secuencial,
        @i_corrida    = @i_corrida,
        @i_intento    = @i_intento,
        @i_error      = @@error,
        @i_detalle    = 'ERROR EN DESHABILITACION DE PRODUCTOS'
   if @w_retorno_ej > 0
   begin
     return @w_retorno_ej 
   end
   else
   begin
     return @w_retorno
   end
end

return 0
end
go

if object_id('sp_ba_deshabilita_ej') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_ba_deshabilita_ej'
end
go
