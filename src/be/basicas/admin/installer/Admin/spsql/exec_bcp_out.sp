use cobis
go

if object_id('sp_exec_bcp_out') is not null
begin
  drop procedure sp_exec_bcp_out
  if object_id('sp_exec_bcp_out') is not null
  begin
    print 'FALLO BORRADO DE PROCEDIMIENTO sp_exec_bcp_out'
  end
end
go

create proc sp_exec_bcp_out
/********************************************************************************/
/*      Archivo:                exec_bcp_out.sp                                  */
/*      Stored procedure:       sp_exec_bcp_out                                 */
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
/*      Ejecuta bcp incluido los .out                                           */
/*      Es una copia del programa original sp_exec_bcp_ej                       */
/********************************************************************************/
/*                              MODIFICACIONES                                  */
/*      FECHA           AUTOR           RAZON                                   */
/*      JUL/05/2012  Jorge Salazar    Emision Inicial del sp_exec_bcp_ej        */
/*      ENE/16/2013  Jairo Reyes      Cambio para control S.O.                  */
/*      ENE/17/2013  E. Corrales      Cambio que se genere .bcp y .out          */
/*      ABR/19/2016  BBO              Migracion Sybase-SQL FAL                  */
/********************************************************************************/ 
(
   @t_show_version   bit         = 0,   -- Mostrar la version del programa
   @i_bcp_cmdfile    varchar(255)  = null ,   --Ruta y nombre archivo .cmd
   @i_bcp_cmdpath    varchar(255)   ,   --Ruta archivo .cmd
   @i_bcp_table      varchar(255)   ,   --Nombre de tabla con BDD
   @i_bcp_type       varchar(3)     ,   --Tipo de bcp in/out
   @i_bcp_path       varchar(255)   ,   --Ruta archivo externo
   @i_bcp_file       varchar(255)   ,   --Nombre archivo externo sin .bcp sin .txt sin .lis
   @i_file_extension  varchar(4)    = null ,   --extension archivo externo cuando es bcp out ese parametro no va
   @i_bcp_separator  varchar(10) = ''   --Separador bcp 
)
as
declare
   @w_sp_name   varchar(32),  /* nombre stored proc*/
   @w_error     int,
   @w_count     int,
   @w_aux       int,
   @w_cmd       varchar(255),
   @w_query     varchar(255),
   @w_path_bcp  varchar(255),
   @w_path_out  varchar(255),
   @w_path_in   varchar(255),
   @w_caracter  char(1),
   @w_long_ej   int
   
select @w_sp_name = 'sp_exec_bcp_out',	   
   @w_path_bcp  = null,
   @w_path_out  = null,
   @w_path_in   = null
	   

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_exec_bcp_out, Version 4.0.0.3'
    return 0
end

--select @i_bcp_cmdfile = 'cd ' + @i_bcp_cmdfile + ' && s_app bcp '
select @i_bcp_cmdfile = 'cd ' + @i_bcp_cmdpath + ' && s_app bcp'

if @i_file_extension is null
   select @i_file_extension = '.bcp'
   
/*** Carga del archivo externo a la tabla temporal  ***/
if patindex ('%Windows%', @@version) <> 0 --Si la version del Sistema Operativo es Windows
begin
   select @w_caracter = '\'
   
   if len(@i_bcp_separator) = 0   
      select @i_bcp_separator = '\t'
   
   select @w_long_ej = datalength(@i_bcp_path)

   if substring (@i_bcp_path,@w_long_ej,1) <> @w_caracter
      --select @i_bcp_path = @i_bcp_path || @w_caracter --migracion syb-sql 19042016
      select @i_bcp_path = @i_bcp_path + @w_caracter  --migracion syb-sql 19042016
	  
   if @i_bcp_type = 'out'
   begin
      if @i_file_extension is null
         select @i_file_extension = '.bcp'
         
      select @w_path_bcp = @i_bcp_path + @i_bcp_file + @i_file_extension,
             @w_path_out = @i_bcp_path + @i_bcp_file + '.out'

      select @w_cmd =  @i_bcp_cmdfile + ' -auto -login ' + @i_bcp_table + ' ' + @i_bcp_type + ' ' + @w_path_bcp + ' -t' + @i_bcp_separator + ' -c >' + @w_path_out
   end
   if @i_bcp_type = 'in'
   begin
      if @i_file_extension is null
      begin
         print 'Extension de archivo no definido'
         return 1
      end   	
      select @w_path_in  = @i_bcp_path + @i_bcp_file + @i_file_extension,
             @w_path_out = @i_bcp_path + @i_bcp_file + '.out'
      select @w_cmd =  @i_bcp_cmdfile + ' -auto -login ' + @i_bcp_table + ' ' + @i_bcp_type + ' ' + @w_path_in + ' -t' + @i_bcp_separator + ' -c >' + @w_path_out                     
   end                             
end
else
begin
 
   if len(@i_bcp_separator) = 2                       
       select @i_bcp_separator = '\' + @i_bcp_separator
                                                    
   if len(@i_bcp_separator) = 0                       
      select @i_bcp_separator = '\\t'             

   select @w_caracter = '/',
          --@i_bcp_cmdfile = str_replace(@i_bcp_cmdfile,'\','/'),   --migracion syb-sql 19042016
          --@i_bcp_cmdpath = str_replace(@i_bcp_cmdpath,'\','/'),   --migracion syb-sql 19042016
          --@i_bcp_file = str_replace(@i_bcp_file,'\','/')          --migracion syb-sql 19042016
          @i_bcp_cmdfile = replace(@i_bcp_cmdfile,'\','/'),         --migracion syb-sql 19042016
          @i_bcp_cmdpath = replace(@i_bcp_cmdpath,'\','/'),         --migracion syb-sql 19042016
          @i_bcp_file = replace(@i_bcp_file,'\','/')                --migracion syb-sql 19042016
          
   select @w_long_ej = datalength(@i_bcp_path)
   
   if substring (@i_bcp_path,@w_long_ej,1) <> @w_caracter
      --select @i_bcp_path = @i_bcp_path || @w_caracter     --migracion syb-sql 19042016
      --select @i_bcp_path = @i_bcp_path + @w_caracter     --migracion syb-sql 19042016

   if @i_bcp_type = 'out'
   begin
      if @i_file_extension is null
         select @i_file_extension = '.bcp'
            	
      select @w_path_bcp = @i_bcp_path + @i_bcp_file + @i_file_extension,
             @w_path_out = @i_bcp_path + @i_bcp_file + '.out'
               		
      select @w_cmd =  @i_bcp_cmdfile + ' -auto ' + @i_bcp_table + ' ' + @i_bcp_type + ' ' + @w_path_bcp +  ' -t' + @i_bcp_separator + ' -c >' + @w_path_out 
   end
   if @i_bcp_type = 'in'
   begin
      if @i_file_extension is null
      begin
         print 'Extension de archivo no definido'
         return 1
      end
            	
      select @w_path_in = @i_bcp_path  + @i_bcp_file + @i_file_extension,
             @w_path_out = @i_bcp_path + @i_bcp_file + '.out'
               		
      select @w_cmd =  @i_bcp_cmdfile + ' -auto ' + @i_bcp_table + ' ' + @i_bcp_type + ' ' + @w_path_in +  ' -t' + @i_bcp_separator + ' -c >'  + @w_path_out     
   end  
end


--print 'Ejecutando: ' + @w_cmd      

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

if object_id('sp_exec_bcp_out') is null
begin
  print 'FALLO CREACION DE PROCEDIMIENTO sp_exec_bcp_out'
end
go
