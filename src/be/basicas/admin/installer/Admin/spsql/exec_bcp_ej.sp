use cobis
go

if object_id('sp_exec_bcp_ej') is not null
begin
  drop procedure sp_exec_bcp_ej
  if object_id('sp_exec_bcp_ej') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_exec_bcp_ej'
  end
end
go

create proc sp_exec_bcp_ej
/********************************************************************************/
/*      Archivo:                exec_bcp_ej.sp                                  */
/*      Stored procedure:       sp_exec_bcp_ej                                  */
/*      Base de datos:          cobis                                           */ 
/*      Producto:                                                               */
/*      Disenado por:                                                           */
/*      Fecha de escritura:     Julio-2012                                      */
/********************************************************************************/
/*                              IMPORTANTE                                      */
/*      Este programa es parte de los paquetes bancarios propiedad de           */
/*      "MACOSA", representantes exclusivos para el Ecuador de la               */
/*      "NCR CORPORATION".                                                      */
/*      Su uso no autorizado queda expresamente prohibido asi como              */
/*      cualquier alteracion o agregado hecho por alguno de sus                 */
/*      usuarios sin el debido consentimiento por escrito de la                 */
/*      Presidencia Ejecutiva de MACOSA o su representante.                     */
/********************************************************************************/
/*                              PROPOSITO                                       */
/*      Este programa procesa las transacciones de:                             */
/*      Ejecuta bcp                                                             */
/********************************************************************************/
/*                              MODIFICACIONES                                  */
/*      FECHA           AUTOR           RAZON                                   */
/*      JUL/05/2012  Jorge Salazar    Emision Inicial                           */
/*      JUL/06/2012  Jorge Salazar    Control de separador bcp                  */
/*      OCT/04/2012  Jorge Salazar    Cambio comando xp_cmdshell                */
/********************************************************************************/ 
(
   @t_show_version   bit         = 0,   -- Mostrar la version del programa
   @i_bcp_cmdfile    varchar(255)   ,   --Ruta y nombre archivo .cmd
   @i_bcp_cmdpath    varchar(255)   ,   --Ruta archivo .cmd
   @i_bcp_table      varchar(255)   ,   --Nombre de tabla
   @i_bcp_type       varchar(3)     ,   --Tipo de bcp in/out
   @i_bcp_file       varchar(255)   ,   --Ruta y nombre archivo externo 
   @i_bcp_separator  varchar(10) = ''   --Separador bcp 
)
as
declare
   @w_sp_name   varchar(32),  /* nombre stored proc*/
   @w_error     int,
   @w_count     int,
   @w_aux       int,
   @w_cmd       varchar(255),
   @w_query     varchar(255)   
   
select @w_sp_name = 'sp_exec_bcp_ej'	   

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_exec_bcp_ej, Version 4.0.0.3'
    return 0
end

/*** Carga del archivo externo a la tabla temporal  ***/
select @w_cmd =  @i_bcp_cmdfile + ' ' + @i_bcp_table + ' ' + @i_bcp_type + ' ' + @i_bcp_file + ' ' +  @i_bcp_cmdpath + ' ' + @i_bcp_separator 

/*** Ejecucion bcp ***/
begin tran
exec @w_error = xp_cmdshell @w_cmd
if @w_error > 0
begin
   rollback tran
   return 1
end
commit tran

return 0

if object_id('sp_exec_bcp_ej') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_exec_bcp_ej'
end
go

