/************************************************************************/
/* Archivo:                sp_ba_error_log.sp                           */
/* Stored procedure:       sp_ba_error_log                              */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     12-MAY-2011                                  */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa realiza la consulta de los errores de procesamiento */
/*    batch que registran los distintos modulos Cobis                   */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    12-MAY-2011    PJARRIN         Emision Inicial                    */
/*    22-NOV-2013    Jairo Reyes     Buscar en historico y actual       */
/*                            Incorporacion de variable          */
/*                                   t_show_version                     */
/*                                   Incorporacion de variable          */
/*                                   i_fecha_formato                    */
/*    11-04-2016     BBO             Migracion Sybase-Sqlserver FAL     */
/*    22-04-2016     ELO             Migracion Sybase-Sqlserver FAL     */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ba_error_log')
   drop proc sp_ba_error_log
go

create proc sp_ba_error_log(
    @s_ssn           int               = null,
    @s_date          datetime          = null,
    @s_user          login             = null,
    @s_term          descripcion       = null,
    @s_corr          char(1)           = null,
    @s_ssn_corr      int               = null,
    @s_ofi           smallint          = null,
    @t_rty           char(1)           = null,
    @t_trn           smallint          = null,
    @t_debug         char(1)           = 'N',
    @t_file          varchar(14)       = null,
    @t_from          varchar(30)       = null,
    @t_show_version  bit               = 0,
    @i_operacion     char(1)           = 'I',
    @i_modo          tinyint           = null,
    @i_fecha_proceso datetime          = null,
    @i_sarta         int               = null,
    @i_batch         int               = null,
    @i_secuencial    int               = null,
    @i_corrida       int               = null,
    @i_intento       int               = null,
    @i_error         int               = null,
    @i_tran          int               = null,
    @i_num_operacion varchar(25)       = null,
    @i_detalle        varchar(255)      = null,
    @i_sec_error     int               = null,
    @i_fecha_formato int               = 101
)
as
declare
    @w_today         datetime,
    @w_return        int,
    @w_sp_name       varchar(32),
    @w_sec_error     int,
    @w_fecha_proceso datetime,
    @w_modo_query    char(1)

select @w_today = getdate()
select @w_sp_name = 'sp_ba_error_log'

---- VERSIONAMIENTO DEL PROGRAMA --------------------------------

if @t_show_version = 1
begin
   print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
   return 0
end
-----------------------------------------------------------------
if (@t_trn <> 8205 and @i_operacion = 'S' ) 
begin
   --Tipo de transaccion no corresponde
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 801077
   return 801077

end

-- Busqueda de registros
if @i_operacion = 'S'
begin
   --Validacion de Datos
   if exists (select 1 from cobis..ba_error_batch
              where er_fecha_proceso = @i_fecha_proceso and 
              er_sarta = isnull(@i_sarta, er_sarta) and   --JRE -29575 -22/Nov/2013
             er_batch = isnull(@i_batch,er_batch )       --JRE -29575 -22/Nov/2013
             )

   begin
        -- Registros Tabla Diaria
        select @w_modo_query = 'D'
        if exists (select 1 from cobis..ba_error_batch_his
               where er_fecha_proceso = @i_fecha_proceso and 
              er_sarta = isnull(@i_sarta, er_sarta) and   --JRE -29575 -22/Nov/2013
             er_batch = isnull(@i_batch,er_batch )       --JRE -29575 -22/Nov/2013
             )
        begin
            -- Registros Tabla Historica
            select @w_modo_query = 'B'
        end

   end
   else
   begin
        if exists (select 1 from cobis..ba_error_batch_his
               where er_fecha_proceso = @i_fecha_proceso and 
              er_sarta = isnull(@i_sarta, er_sarta) and   --JRE -29575 -22/Nov/2013                           
             er_batch = isnull(@i_batch,er_batch )       --JRE -29575 -22/Nov/2013                           
             )         
        begin
            -- Registros Tabla Historica
            select @w_modo_query = 'H'
        end
        else
        begin
            if @@rowcount = 0
            begin
             -- No existen registros
             exec cobis..sp_cerror   
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808074
             return 808074
            end        
        end
   end

-- Consulta Registros Tabla Diaria
   if @w_modo_query = 'D'
   begin   
       set rowcount 20
       if @i_modo = 0
       begin   
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso = @i_fecha_proceso
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            from cobis..ba_error_batch, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_error  *= numero
             and er_fecha_proceso = @i_fecha_proceso
           order by er_secuencial_error       
           ******/

            if @@rowcount = 0
            begin
                 -- No existen registros
                 exec cobis..sp_cerror   
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808074
                 return 808074
            end           

            set rowcount 0
            return 0
       end

       if @i_modo = 1
       begin
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso = @i_fecha_proceso
             and er_secuencial_error  > @i_sec_error
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            from cobis..ba_error_batch, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_error  *= numero 
             and er_fecha_proceso     = @i_fecha_proceso 
             and er_secuencial_error  > @i_sec_error
         order by er_secuencial_error    
            *******/
            
            if @@rowcount = 0
            begin
                 -- No existen registros
                 exec cobis..sp_cerror  
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808074
                 return 808074
            end

            set rowcount 0
            return 0
       end
   end

-- Consulta Registros Tabla Historica
   if @w_modo_query = 'H'
   begin

       set rowcount 20
       if @i_modo = 0
       begin
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch_his
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso = @i_fecha_proceso             
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            from cobis..ba_error_batch_his, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null) 
             and er_error  *= numero 
             and er_fecha_proceso = @i_fecha_proceso   
           order by er_secuencial_error
            *******/
         

            if @@rowcount = 0
            begin
             -- No existen registros
             exec cobis..sp_cerror   
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808074
             return 808074
            end            

            set rowcount 0
            return 0

       end

       if @i_modo = 1
       begin
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch_his
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso    = @i_fecha_proceso        
             and er_secuencial_error  > @i_sec_error                   
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            from cobis..ba_error_batch_his, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null) 
             and er_error  *= numero 
             and er_fecha_proceso     = @i_fecha_proceso 
             and er_secuencial_error  > @i_sec_error    
           order by er_secuencial_error
            *****/
         

            if @@rowcount = 0

            begin
             -- No existen registros
             exec cobis..sp_cerror   
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 808074
             return 808074

            end

            set rowcount 0
            return 0
       end
   end       


-- Consulta Registros En ambas tablas Actual he historica
-- JRE -29575 -22/Nov/2013                           
   if @w_modo_query = 'B'
   begin      

       set rowcount 20
       if @i_modo = 0
       begin  
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso    = @i_fecha_proceso        
           --order by er_secuencial_error  
           --fin mig syb-sql 18042016 
          /****** MIGRACION SYB-SQL 
         --from cobis..ba_error_batch, cobis..cl_errores
           --where (er_sarta = @i_sarta or @i_sarta is null)
             --and (er_batch = @i_batch or @i_batch is null) 
             --and er_error  *= numero 
             --and er_fecha_proceso = @i_fecha_proceso
            ********/
         union
            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch_his
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso    = @i_fecha_proceso        
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
          /****** MIGRACION SYB-SQL 
         from cobis..ba_error_batch_his, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null) 
             and er_error  *= numero 
             and er_fecha_proceso = @i_fecha_proceso
           order by er_secuencial_error
            *******/            

            if @@rowcount = 0
            begin
                 -- No existen registros
                 exec cobis..sp_cerror   
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808074
                 return 808074
            end            

            set rowcount 0
            return 0

       end

       if @i_modo = 1
       begin
            select
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso    = @i_fecha_proceso        
             and er_secuencial_error  > @i_sec_error                   
          -- order by er_secuencial_error  
          --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            --from cobis..ba_error_batch, cobis..cl_errores
           --where (er_sarta = @i_sarta or @i_sarta is null)
             --and (er_batch = @i_batch or @i_batch is null) 
             --and er_error  *= numero 
             --and er_fecha_proceso     = @i_fecha_proceso 
             --and er_secuencial_error  > @i_sec_error
             ******/

           union           

            select 
                'SEC.'         = er_secuencial_error,
                'FECHA PROCESO'= convert(varchar(10), er_fecha_proceso, @i_fecha_formato),
                'FECHA ERROR'  = convert(varchar(10), er_fecha_error, @i_fecha_formato) + ' ' + convert(varchar(10), er_fecha_error, 108),
                'SARTA'        = er_sarta,
                'PROGRAMA'     = er_batch,
                'COD.ERROR'    = er_error,
                'TRAN.'        = er_tran,
                'OPERACION'    = er_operacion,
                'DETALLE'      = er_detalle,
                'MENSAJE'      = mensaje
            --inicio mig syb-sql 18042016    
            from ba_error_batch_his
                left outer join cl_errores on er_error  = numero
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null)
             and er_fecha_proceso    = @i_fecha_proceso        
             and er_secuencial_error  > @i_sec_error                   
           order by er_secuencial_error  
           --fin mig syb-sql 18042016             
            
            /****** MIGRACION SYB-SQL 
            from cobis..ba_error_batch_his, cobis..cl_errores
           where (er_sarta = @i_sarta or @i_sarta is null)
             and (er_batch = @i_batch or @i_batch is null) 
             and er_error  *= numero 
             and er_fecha_proceso     = @i_fecha_proceso 
             and er_secuencial_error  > @i_sec_error
           order by er_secuencial_error
           ********/
         

            if @@rowcount = 0
            begin
                 -- No existen registros
                 exec cobis..sp_cerror   
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808074
                 return 808074
            end
            set rowcount 0
            return 0
       end
   end   

--JRE -29575 -22/Nov/2013                                

end

-- INSERTAR REGISTROS

if @i_operacion = 'I'

begin
    if (@i_sarta is null and @i_batch is null and @i_secuencial is null)     

    begin
       return 801029
    end

    --Determinar fecha de proceso    

    select @w_fecha_proceso = fp_fecha 
      from cobis..ba_fecha_proceso

    --Determinar secuencial de error dentro de la fecha de proceso    
    select @w_sec_error =  isnull(max(er_secuencial_error), 0) + 1
      from cobis..ba_error_batch 
      where er_fecha_proceso = @w_fecha_proceso



    -- Insertar registros
    insert into cobis..ba_error_batch 
    (er_secuencial_error, er_fecha_proceso,er_sarta,er_batch,er_secuencial,er_corrida,er_intento,er_fecha_error,er_error,er_tran,er_operacion,er_detalle)
    values
    (@w_sec_error,@w_fecha_proceso,@i_sarta,@i_batch,@i_secuencial,@i_corrida,@i_intento,getdate(),@i_error,@i_tran,@i_num_operacion,@i_detalle)


    if @@error  <> 0
    begin
         return 808070
    end        

    return 0

end



return 0

                                                                                                                                                                         

go
