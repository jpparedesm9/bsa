/************************************************************************/
/*      Archivo           :  sp_genera_bcp.sp                           */
/*      Base de datos     :  cobis                                      */
/*      Producto          :  COBIS                                      */
/*      Disenado por      :  Aldo Benavides                             */
/*      Fecha de escritura:  23/Ago/2011                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP S.A".                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP S.A o su representante.      */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Generar archivos Bcp's de una tabla                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*       FECHA           AUTOR                     RAZON                */
/*      11-03-2016       BBO             Migracion Sybase-Sqlserver FAL */
/************************************************************************/

/************************************************************************/
/* Se modifica el contexto de xp_cmdshell a 0 para evitar problemas de  */
/* usuario no autorizados                                               */
/*                                                                      */
/*  use  sybsystemprocs                                                 */
/*  go                                                                  */
/*  sp_configure "xp_cmdshell context", 0                               */
/*  go                                                                  */
/*                                                                      */
/* Opcion bcp:                                                          */
/*  use master                                                          */
/*  go                                                                  */ 
/*  sp_dboption [bdd], "select into/bulkcopy", true                     */ 
/*  go                                                                  */
/*  use [bdd]                                                           */
/*  go                                                                  */
/*  checkpoint                                                          */
/*  go                                                                  */
/*                                                                      */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = "sp_genera_bcp" )
  drop proc sp_genera_bcp
go

create proc sp_genera_bcp (
   @t_show_version     bit = 0,    -- show the version of the stored procedure
   @i_sarta      int       = null,
   @i_batch      int       = null,
   @i_secuencial int       = null,
   @i_corrida    int       = null,
   @i_intento    int       = null,  
   @i_module     int,  
   @i_table      varchar(255) = null,
   @i_path_sapp  varchar(255),
   @i_base       varchar(64) = null,
   @i_mostrar_msj char(1)  = 'N'
)
as
declare
   @w_sp_name    varchar(30),
   @w_retorno    int,
   @w_retorno_ej int,
   @w_tabla_bcp  varchar(255),
   @w_tabla_out  varchar(255),
   @w_path_bcp   varchar(255),
   @w_path_out   varchar(255),
   @w_path_dst   varchar(255),
   @w_cmd        varchar(255),   
   @w_tabla      varchar(255),
   @w_base       varchar(64),
   @w_msg        varchar(255),
   @w_status     int,
   @w_return     int,
   @w_caracter   char(1)

select @w_sp_name = 'sp_genera_bcp' 
select @i_path_sapp = ltrim(rtrim(@i_path_sapp))
---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.3'
   return 0
end
-----------------------------------------------------------------
/*
if @i_path_sapp is null  -- NO SE RECIBE PARAMETRO DE ENTRADA
begin
   select @i_path_sapp = isnull(pa_char,'')
   from cobis..cl_parametro
   where pa_nemonico = 'DIRAPP'
   and pa_producto = 'ADM'
   if @@rowcount = 0   -- SI NO SE TIENE DEFINIDO PARAMETRO EN cobis..cl_parametro 
   begin
      select @i_path_sapp = ''   -- SE MARCA CON PATH EN BLANCO
   end
end
*/
if patindex ('%Windows%', @@version) <> 0 --Si la version del Sistema Operativo es Windows
--begin
   select @w_caracter = '\'
/*
   if @i_path_sapp <> '' and @i_path_sapp is not null   -- NO SE RECIBE PARAMETRO DE ENTRADA, NI SE TIENE DEFINIDO PARAMETRO EN cobis..cl_parametro
      select @i_path_sapp = 'cd ' + @i_path_sapp + ' && '
   else
      select @i_path_sapp = ltrim(@i_path_sapp)
end
*/
else
   select @w_caracter = '/'

if @i_table = 'cobis' and @i_base = 'cobis'
   begin
      declare cursor_bcp cursor for
      select et_path_dst,
         et_base,
         et_table 
      from cat_ex_table
      where et_module = @i_module 
      for read only

      open cursor_bcp
      fetch cursor_bcp into 
         @w_path_dst,
         @w_base,
         @w_tabla 

      if @@fetch_status = -1  --sqlstatus: mig syb-sqls 11032016
       begin
          close cursor_bcp
          deallocate cursor_bcp
          --raiserror 200001 'Fallo lectura del cursor '
          RAISERROR ('%d %s', 16, 1, 200001, 'Fallo lectura del cursor ')          --migracion syb-sql 15042016
          return 1
       end     
         
      while @@fetch_status =0  --sqlstatus: mig syb-sqls 11032016
         begin
     
            if @w_tabla = 'etl_cuadre_extraccion_cobis'
               begin
                  select  @w_tabla_bcp  = @w_tabla
                  select  @w_tabla_out  = @w_tabla
               end
            else
               begin
                if (charindex ('_ex',@w_tabla) >= 1)
					begin
						select  @w_tabla_bcp  = substring(@w_tabla, 1, charindex ('_ex',@w_tabla))  +  
						substring(@w_tabla, charindex ('_ex',@w_tabla) + 4,  datalength(@w_tabla))     
					    select  @w_tabla_out  = substring(@w_tabla, charindex ('_ex_',@w_tabla) + 4, datalength(@w_tabla))
					end                 
				else
					begin
						select  @w_tabla_bcp  = @w_tabla
						select  @w_tabla_out  = @w_tabla
					end
               end
     
            select  @w_path_bcp   = @w_path_dst + 'bcp' + @w_caracter + @w_tabla_bcp + '.bcp',              
               @w_path_out   = @w_path_dst + 'out' + @w_caracter + @w_tabla_out + '.out'          

            if patindex ('%Windows%', @@version) <> 0 --Si la version del Sistema Operativo es Windows
               select @w_cmd  = @i_path_sapp + @w_caracter + 's_app bcp -auto -login ' + @w_base + '..' + @w_tabla + ' out ' + @w_path_bcp +  ' -c -config ' + @i_path_sapp + @w_caracter +'s_app.ini'+ '> ' + @w_path_out 
            else
               select @w_cmd  = @i_path_sapp + 's_app bcp -auto ' + @w_base + '..' + @w_tabla + ' out ' + @w_path_bcp +  ' -c > ' + @w_path_out 
			   
			if @i_mostrar_msj = 'S'
            print 'Ejecutando: ' + @w_cmd      
			
            exec @w_status = master..xp_cmdshell @w_cmd
       
            if @w_status != 0
               begin 
                  select @w_msg = 'Error en ejecucion de bcp tabla:' + @w_tabla
                     exec @w_return     = cobis..sp_ba_error_log
                        @i_sarta      = @i_sarta,
                        @i_batch      = @i_batch,
                        @i_secuencial = @i_secuencial,
                        @i_corrida    = @i_corrida,
                        @i_intento    = @i_intento,
                        @i_error      = 808070,
                        @i_detalle    = @w_msg                   
               end                 
         
            fetch cursor_bcp into 
               @w_path_dst,
               @w_base,    
               @w_tabla    
         end 

         close cursor_bcp
         deallocate cursor_bcp                
   end
else
   begin
      select @w_path_dst = et_path_dst
      from cat_ex_table
      where et_module = @i_module
      and et_base  = @i_base
      and et_table = @i_table
      
      select  @w_tabla_bcp  = substring(@i_table, 1, charindex ('_ex',@i_table))  +  
         substring(@i_table, charindex ('_ex',@i_table) + 4,  datalength(@i_table))
      select  @w_tabla_out  = substring(@i_table, charindex ('_ex_',@i_table) + 4, datalength(@i_table))
      select  @w_path_bcp   = @w_path_dst + 'bcp' + @w_caracter + @w_tabla_bcp + '.bcp',              
         @w_path_out   = @w_path_dst + 'out' + @w_caracter + @w_tabla_out + '.out'          
      
      if patindex ('%Windows%', @@version) <> 0 --Si la version del Sistema Operativo es Windows
         select @w_cmd  = @i_path_sapp + @w_caracter + 's_app bcp -auto -login ' + @i_base + '..' + @i_table + ' out ' + @w_path_bcp +  ' -c -config ' + @i_path_sapp + 's_app.ini'+ '> ' + @w_path_out 
      else
         select @w_cmd  = @i_path_sapp + 's_app bcp -auto ' + @i_base + '..' + @i_table + ' out ' + @w_path_bcp + ' -c > ' + @w_path_out 

	  if @i_mostrar_msj = 'S'
      print 'Ejecutando: ' + @w_cmd
	  
      exec @w_status = master..xp_cmdshell @w_cmd
  
      if @w_status != 0
         begin  
            select @w_msg = 'Error en ejecucion de bcp tabla:' + @i_table       
            exec @w_return     = cobis..sp_ba_error_log
               @i_sarta      = @i_sarta,
               @i_batch      = @i_batch,
               @i_secuencial = @i_secuencial,
               @i_corrida    = @i_corrida,
               @i_intento    = @i_intento,
               @i_error      = 808070,
               @i_detalle    = @w_msg
         end
   end

return 0
go
