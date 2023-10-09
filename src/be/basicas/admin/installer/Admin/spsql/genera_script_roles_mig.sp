use cobis
go

if object_id('sp_genera_script_roles_mig') is not null
begin
  drop procedure sp_genera_script_roles_mig
  if object_id('sp_genera_script_roles_mig') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_genera_script_roles_mig'
  end
end
go
create procedure sp_genera_script_roles_mig
/************************************************************************/
/*      Archivo:                genera_script_roles_mig.sp              */
/*      Stored procedure:       sp_genera_script_roles_mig              */
/*      Base de datos:          cobis                                   */
/*      Producto:               Admin                                   */
/*      Disenado por:           Jaime Hidalgo                           */
/*      Fecha de escritura:     16-junio-2013                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*         Generar masivamente el script de migracion de relacion       */
/*         roles - componentes - transacciones autorizadas              */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      16/Junio/2013   J.Hidalgo       Emision Inicial                 */
/*      11-04-2016      BBO             Migracion Sybase-Sqlserver FAL  */
/************************************************************************/
(
  @t_show_version  bit               = 0,    -- show the version of the stored procedure  
  @i_rol_desde     int               = 0,
  @i_rol_hasta     int               = 255,
  @i_opcion        char(1), -- G = Genera script para roles en ambiente origen 
                            -- P = Procesa script para roles en ambiente destino
  -- parametros para registro de log de ejecucion
  @i_sarta         int               = null,
  @i_batch         int               = null,
  @i_secuencial    int               = null,
  @i_corrida       int               = null,
  @i_intento       int               = null
)
as
declare @w_sp_name          varchar(30),
        @w_retorno          int,
        @w_retorno_ej       int,
        @w_error            int,
        @w_detalle          varchar(255),
        @w_sentencia        varchar(255),
        @w_maxrol           int,
        @w_rol              int,
        @w_descripcion      varchar(255),
        @w_print            varchar(255)

select @w_sp_name = 'sp_genera_script_roles_mig'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_genera_script_roles_mig, Version 4.0.0.1'
    return 0
end
-------------------------------------

select @w_maxrol = max(ro_rol)
from cobis..ad_rol
where ro_descripcion <> 'DISPONIBLE'
and ro_rol between @i_rol_desde and @i_rol_hasta

select @w_rol = ro_rol,
       @w_descripcion = ro_descripcion
from cobis..ad_rol
where ro_rol = @i_rol_desde

while 1=1
begin
   
   if @i_opcion = 'G'
   begin
      set @w_print = '----  GENERANDO SCRIPT PARA ROL ' + convert(varchar, @w_rol) + ' - ' + @w_descripcion + ' -----'
      print 'print '' + @w_print + '''
      print 'go'
      print ''
   end
   else
   begin
      print '---- PROCESANDO SCRIPT PARA ROL ' + convert(varchar, @w_rol) + ' - ' + @w_descripcion + ' -----'
   end
   
   exec sp_mig_rol_definition
      @i_rol = @w_rol,
      @i_operation = @i_opcion

   if @@error > 0
   begin
      select @w_detalle = 'Error en ejecucion de sp para rol: ' + convert(varchar,@w_rol)
      GOTO ERROR
   end
   
   if @w_rol = @w_maxrol
      break
   
   set rowcount 1
      select @w_rol = ro_rol,
             @w_descripcion = ro_descripcion
      from cobis..ad_rol
      where ro_rol > @w_rol
      and ro_descripcion <> 'DISPONIBLE'
      and ro_rol between @i_rol_desde and @i_rol_hasta
      order by ro_rol asc
   set rowcount 0

end

set rowcount 0
return 0
ERROR:    /* Rutina que dispara sp_ba_error_log dado el codigo de error */

     exec  @w_retorno_ej   = cobis..sp_ba_error_log
           @i_sarta        = @i_sarta,
           @i_batch        = @i_batch,
           @i_secuencial   = @i_secuencial,
           @i_corrida      = @i_corrida,
           @i_intento      = @i_intento,
           @i_error        = @@error,
           @i_detalle      = @w_detalle
        
     if @w_retorno_ej > 0
     begin
           set rowcount 0
           return @w_retorno_ej
     end  
     else
     begin
           set rowcount 0
           return 808076
     end
go

if object_id('sp_genera_script_roles_mig') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_genera_script_roles_mig'
end
go
