/************************************************************************/
/* Archivo:                sec_ejec.sp                                  */
/* Stored procedure:       sp_secuencia_ejecucion                       */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     15-Abril-2002                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes exclusivos para el Ecuador de la         */
/*    'NCR CORPORATION'.                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Contiene los pasos que se siguen para la secuencia de ejecucion   */
/*    de lotes desde el front end en modo grafico                       */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    15-Abr-2002    S. Soto         Emision Inicial                    */
/*    10-Oct-2002    D. Ayala        Ajustes en fase de pruebas         */
/*    25-Abr-2007    S. Soto         Correcciones a las estadisticas    */
/*    05-Ene-2008    S. Soto         Se corrige condiciones en opcion Q */ 
/*    30-Oct-2008    S. Soto         Archivo y Path Destino por defecto */  
/*    27-MAR-2009    F. Lopez        Manejo Ciclico de Procesos         */
/*    25-AGO-2009    F. Lopez        Sincronizar Fin EJE Proc Ciclicos  */
/*    18-ABR-2011    S. Soto         Comentar Fix Ciclico               */
/*    15-Ago-2011    S. Soto         Evitar mensajes de error           */
/*    09-Sep-2011    S. Soto         Cambio en 'N' con @@servername     */
/*    13-Mar-2012    S. Soto         Homologacion FNA                   */ 
/*    22-Abr-2016    BBO             Migracion Syb-SQL FAL              */
/************************************************************************/

use cobis 
go

if exists (select * from sysobjects where name = 'sp_secuencia_ejecucion')
   drop proc sp_secuencia_ejecucion
go

create proc sp_secuencia_ejecucion    (
   @s_ssn                  int = null,
   @s_date                 datetime = null,
   @s_user                 login = null,
   @s_term                 descripcion = null,
   @s_corr                 char(1) = null,
   @s_ssn_corr             int = null,
   @s_ofi                  smallint = null,
   @t_rty                  char(1) = null,
   @t_trn                  smallint = 601,
   @t_debug                char(1) = 'N',
   @t_file                 varchar(14) = null,
   @t_from                 varchar(30) = null,
   @i_operacion            char(1),
   @i_modo                 tinyint = 0,
   @i_sarta                int = null, 
   @i_batch                int = null,
   @i_secuencial           smallint = null,
   @i_corrida              smallint = 0, 
   @i_intento              smallint = 1, 
   @i_fecha_proceso        datetime = null,
   @i_producto             tinyint = 0,
   @i_formato_fecha        tinyint = 103, 
   @i_secuencial_inicio    smallint = null,
   @i_secuencial_fin       smallint = null,
   @i_aut_forzada          char(1) = null
)
as 
declare
   @w_sp_name                   varchar(30),
   @w_today                     datetime,
   @w_fecha_proceso             datetime, 
   @w_autoriza                  smallint, 
   @w_lote_dependencia          smallint,
   @w_repeticion                char(1),
   @w_ultimo_proceso            smallint, 
   @w_ultimo_status             varchar(1),
   @w_diff                      integer,
   --Tiempos de ejecucion y escala
   @w_max_tiempo                integer, 
   @w_media_tiempo              integer, 
   @w_min_tiempo                integer, 
   @w_escala_tiempo             char(2),
   --Numero de registros procesados
   @w_media_reg_proc            integer, 
   @w_max_reg_proc              integer,
   @w_min_reg_proc              integer, 
   @w_num_ejecuciones           integer,
   @w_corrida                   smallint,
   @w_intento                   smallint, 
   --Estatus de procesos previos
   @w_batch_inicio              integer, 
   @w_secuencial_inicio         smallint,
   @w_tipo_enlace               char(1), 
   @w_habilitado                char(1), 
   @w_status                    char(1), 
   @w_msg                       varchar(255),
   --Variables para opcion K
   @w_id_proceso                integer, 
   @w_transerver                varchar(64), 
   --Seleccion de parametros en shells
   @w_pa_nombre                 varchar(64), 
   @w_pa_tipo                   char(1), 
   @w_pa_valor                  varchar(64), 
   @w_pa_parametro              smallint, 
   @w_lista_log                 varchar(255), 
   @w_lista_par                 varchar(255),
   @w_reproceso                 char(1),
   @w_cont                      int,
   @w_estatus                   char(1),
   @w_ejecutar                  char(1), 
   @w_msgerror                  varchar(255),
   @w_arch_resultado            varchar(255),
   @w_path_destino              varchar(255)

    
select @w_sp_name = 'sp_secuencia_ejecucion'
select @w_today = getdate()
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_autoriza = 0


if (@t_trn <> 8090 and @i_operacion = 'G') or  --Datos para Graficar el lote
   (@t_trn <> 8090 and @i_operacion = 'Q') or  --Query del proceso
   (@t_trn <> 8090 and @i_operacion = 'P') or  --Determinar estatus de procesos Previos dentro del mismo lote
   (@t_trn <> 8090 and @i_operacion = 'S') or  --Siguientes procesos a ejecutar
   (@t_trn <> 8090 and @i_operacion = 'I') or  --Procesos de Inicio de ejecucion
   (@t_trn <> 8090 and @i_operacion = 'V') or  --Validaciones del lote
   (@t_trn <> 8090 and @i_operacion = 'C') or  --Determinar el Numero de corrida
   (@t_trn <> 8090 and @i_operacion = 'E') or  --Datos para generar las Estadisticas
   (@t_trn <> 8090 and @i_operacion = 'L') or  --Log del estado de ejecucion
   (@t_trn <> 8090 and @i_operacion = 'T') or  --Copia de registros a las tablas de log (procesos y enlaces)
   (@t_trn <> 8090 and @i_operacion = 'K') or  --Opciones para terminar un proceso (Kill)
   (@t_trn <> 8090 and @i_operacion = 'N') or  --Nombre del Servidor de base de datos
   (@t_trn <> 8090 and @i_operacion = 'H')     --Paso de parametros al programa shell 

   begin
     /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
          @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 601077
     return 1
   end


/* Seleccion de los parametros que se pasaran al programa sHell */

if @t_trn = 8090 and @i_operacion = 'H'   
   begin
     --Cursor para determinar los parametros del programa
     declare cur_parametros cursor for
      select pa_nombre, pa_tipo, pa_valor, pa_parametro
        from cobis..ba_parametro
       where pa_sarta     = @i_sarta
         and pa_batch     = @i_batch
         and pa_ejecucion = @i_secuencial
       order by pa_parametro

      open cur_parametros
      fetch cur_parametros into @w_pa_nombre, @w_pa_tipo, @w_pa_valor, @w_pa_parametro

      while @@fetch_status != -1
        begin
          if @@fetch_status = -2
             begin
               close cur_parametros
               deallocate  cur_parametros
               select @w_msg = 'Error en cursor para bloqueos'
               --raiserror 21000 @w_msg
               raiserror('%d %s', 16, 1, 21000, @w_msg)  --migracion sybase-sql 22042016
               return 1
             end

             --Conformacion de la cadena de parametros segun el tipo de dato
             if @w_pa_tipo = 'D' --or @w_pa_tipo = 'C' 
                select @w_lista_par = @w_lista_par + '"' + @w_pa_valor + '" '   
             else
                select @w_lista_par = @w_lista_par + @w_pa_valor + ' '   

             --Esta cadena se registra en la tabla ba_log
             select @w_lista_log = @w_lista_log + @w_pa_valor + ';'

          fetch cur_parametros into @w_pa_nombre, @w_pa_tipo, @w_pa_valor, @w_pa_parametro            
        end

       close cur_parametros
       deallocate  cur_parametros

     select @w_lista_par, @w_lista_log 
     return 0
   end

/* Nombre del servidor de base de datos */

if @t_trn = 8090 and @i_operacion = 'N'   
   begin
   select @@servername  --SSO 09-09-2011, en lugar de consultar a sysservers

      if @@rowcount = 0 
         begin
           /* No se ha encontrado el servidor de la base de datos */
           exec cobis..sp_cerror   
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808006
           return 1
         end         
   end

/* Opciones necesarias para matar un proceso (Kill) */

if @t_trn = 8090 and @i_operacion = 'K'   
   begin
     if @i_modo = 0  
        begin
          select @w_id_proceso = 0, @w_transerver = '', @w_intento = 0
          --Numero de intento
          select @w_intento = max(lo_intento)
            from cobis..ba_log
           where lo_sarta      = @i_sarta 
             and lo_batch      = @i_batch
             and lo_secuencial = @i_secuencial 
             and lo_corrida    = @i_corrida   

          --Determinar ID de proceso y servidor COBIS
          select @w_id_proceso = isnull(sb_id_proceso, 0), 
                 @w_transerver = isnull(ba_serv_destino, '')
            from cobis..ba_sarta_batch_exec, cobis..ba_batch          
           where sb_batch = ba_batch
             and sb_sarta      = @i_sarta 
             and sb_batch      = @i_batch
             and sb_secuencial = @i_secuencial

          if @w_id_proceso = 0 or @w_intento = 0 
             begin
               /* No existen condiciones necesarias para matar el proceso */
               exec cobis..sp_cerror   
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 808021
               return 1 
             end  
          else
             select @w_id_proceso, @w_transerver, @w_intento 
        end   
        
     return 0      
   end 

/* Copia a las Tablas de log de procesos y enlaces de los datos de una corrida especifica */

if @t_trn = 8090 and @i_operacion = 'T'   
   begin
    begin tran
       --Si existen datos del log para la corrida los elimina
         if (select count(*)
               from cobis..ba_sarta_batch_exec
              where sb_sarta = @i_sarta) > 0
     begin
            delete cobis..ba_sarta_batch_log 
             where sb_corrida = @i_corrida
               and sb_sarta = @i_sarta

        if @@error <> 0 
         begin
               /* 'Error en la copia a la tablas ba_sarta_batch_log y ba_enlace_log' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808019
            rollback tran
            return 1
         end       

          -- Inserta los datos de procesos
             insert into cobis..ba_sarta_batch_log 
             select *, @i_corrida
               from cobis..ba_sarta_batch_exec
              where sb_sarta = @i_sarta

        if @@error <> 0 
         begin
               /* 'Error en la copia a la tablas ba_sarta_batch_log y ba_enlace_log' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808019
            rollback tran
            return 1
         end       
    end
    else
    begin
      /* 'NO existen definiciones de ejecucion para actualizar en estructuras de log (sarta_batch)' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808052
            rollback tran
            return 1
    end

         if (select count(*)
               from cobis..ba_enlace_exec
              where en_sarta = @i_sarta) > 0
    begin
            delete cobis..ba_enlace_log 
             where en_corrida = @i_corrida
               and en_sarta = @i_sarta
        
        if @@error <> 0 
         begin
               /* 'Error en la copia a la tablas ba_sarta_batch_log y ba_enlace_log' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808019
            rollback tran
            return 1
         end       

          -- Inserta los datos de enlaces
             insert into cobis..ba_enlace_log 
             select *, @i_corrida
               from cobis..ba_enlace_exec
              where en_sarta = @i_sarta
        if @@error <> 0 
         begin
               /* 'Error en la copia a la tablas ba_sarta_batch_log y ba_enlace_log' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808019
            rollback tran
            return 1
         end       
         end
    else
    begin
      /* 'NO existen definiciones de ejecucion para actualizar en estructuras de log (enlace)' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 808053
            rollback tran
            return 1
    end

    commit tran
    return 0      
   end 

/* Log del estado de ejecuci¢n de procesos */

if @t_trn = 8090 and @i_operacion = 'L'
   begin
     if @i_modo = 0
        begin
          if @i_corrida = 0 --Consulta la ultima corrida
             begin
                select @w_corrida = isnull(max(lo_corrida),0)
                  from cobis..ba_log
                 where lo_sarta = @i_sarta
                   and lo_batch = @i_batch
             end
          else
              select @w_corrida = @i_corrida

      --Promedio de ejecucion del proceso
          select @w_media_tiempo = isnull(avg(datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)), 0)
            from cobis..ba_log
           where lo_sarta = @i_sarta
             and lo_batch = @i_batch
             and lo_estatus = 'F'            --Solo se toman las estadisticas de las ejecuciones finalizadas OK

          set rowcount 1
     select 'Lote'      = lo_sarta,
            'Batch'     = lo_batch,
            'Secuencial'= lo_secuencial,
            'Corrida'   = lo_corrida, 
            'Operador'  = substring(lo_operador,1,8),
            'Inicio'    = lo_fecha_inicio,
            'Fin'       = lo_fecha_terminacion,
            'Registros' = isnull(lo_num_reg_proc, 0),
            'Estatus'   = lo_estatus,
            'Razon'     = lo_razon,
            'Tiempo'    = datediff(ms, lo_fecha_inicio, isnull(lo_fecha_terminacion, getdate())),
            'Avance'    = @w_media_tiempo   
       from cobis..ba_log
      where (lo_sarta = @i_sarta or @i_sarta is null)  --Para obtener log de proceso
        and lo_batch = @i_batch
        and lo_secuencial = @i_secuencial
        and lo_corrida = @w_corrida 
--             and convert(char(8),lo_fecha_proceso,101) = convert(char(8),@i_fecha_proceso,101) --OJO: probar esta condicion
      order by lo_intento desc
     set rowcount 0
      select sb_id_proceso
        from cobis..ba_sarta_batch_exec
       where sb_sarta       =  @i_sarta
         and sb_batch       = @i_batch
         and sb_secuencial  = @i_secuencial
     end 

     --Log de todos los procesos del lote correspondientes a una ejecucion especifica
     if @i_modo = 1
        begin
        select 'Proceso'   = lo_batch,
               'Sec'       = lo_secuencial,
               'Intento'   = lo_intento, 
               'Status'    = lo_estatus,
               'Inicio'    = lo_fecha_inicio,
               'Fin'       = lo_fecha_terminacion,
               'Tiempo'    = datediff(ss, lo_fecha_inicio, isnull(lo_fecha_terminacion, getdate())),
               'Reg'       = isnull(lo_num_reg_proc, 0),
               'Operador'  = substring(lo_operador,1,8),
               'Razon'     = lo_razon
          from cobis..ba_log
         where lo_sarta = @i_sarta 
           and lo_corrida = @i_corrida
--         and convert(char(8),lo_fecha_proceso,101) = convert(char(8),@i_fecha_proceso,101) --OJO: probar esta condicion
         order by lo_secuencial, lo_intento 
        end
   end 



/* Estadisticas de Ejecucion Historica del proceso */

if @t_trn = 8090 and @i_operacion = 'E'   
   begin
     select @w_media_tiempo = isnull(avg(datediff(ms, lo_fecha_inicio, lo_fecha_terminacion)), 0), 
            @w_max_tiempo = isnull(max(datediff(ms, lo_fecha_inicio, lo_fecha_terminacion)), 0), 
            @w_min_tiempo = isnull(min(datediff(ms, lo_fecha_inicio, lo_fecha_terminacion)), 0), 
            @w_media_reg_proc = isnull(avg(lo_num_reg_proc), 0), 
            @w_max_reg_proc = isnull(max(lo_num_reg_proc), 0),
            @w_min_reg_proc = isnull(min(lo_num_reg_proc), 0),
	    @w_num_ejecuciones = count(*)  
       from cobis..ba_log
      where lo_sarta = @i_sarta --Determinar si es necesario
        and lo_batch = @i_batch
        and lo_estatus = 'F'            --Solo se toman las ejecuciones finalizadas OK

     if @w_num_ejecuciones = 0
	begin
	  /* No existen logs */
	  exec cobis..sp_cerror   
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 808011
	  return 1
        end
     else 
        begin
          select @w_num_ejecuciones, 
                 @w_min_tiempo, 
                 @w_media_tiempo, 
                 @w_max_tiempo, 
                 @w_min_reg_proc,  
                 @w_media_reg_proc, 
                 @w_max_reg_proc 
        end
   end


/* Determinar el ultimo numero de Corrida y Numero de Intento */

if @t_trn = 8090 and @i_operacion = 'C'   
   begin
      if @i_modo = 0 --Numero de corrida para el lote
        begin

/* =============================
 SE COMENTA MIENTRAS EL CONTROL DE CONCURRENCIA POR CORRIDA SE HABILITA

          select @w_corrida = isnull(max(co_corrida_id),0)
            from cobis..ba_corrida
           where co_sarta = @i_sarta
        and co_fecha_proceso = @i_fecha_proceso

============================= */

          select @w_corrida = isnull(max(lo_corrida),0)
            from cobis..ba_log
           where lo_sarta = @i_sarta
--           and lo_fecha_proceso  = @i_fecha_proceso

          select @w_corrida
        end

     if @i_modo = 1 --Numero de corrida para el proceso
        begin
          select @w_corrida = isnull(max(co_corrida_id),0)
            from cobis..ba_corrida
           where co_sarta = @i_sarta
--           and co_fecha_proceso = @i_fecha_proceso

          select @w_corrida
        end

     if @i_modo = 2 --Numero de intento de ejecucion para el proceso en la corrida
        begin
          select @w_intento = isnull(max(lo_intento),0)
            from cobis..ba_log
           where lo_sarta      = @i_sarta 
             and lo_batch      = @i_batch
             and lo_secuencial = @i_secuencial 
             and lo_corrida    = @i_corrida           

          select @w_intento
       end
  
   end



/* Validaciones sobre el lote a ejecutar */ 

if @t_trn = 8090 and @i_operacion = 'V'   
   begin
      --Validacion a nivel de lote
      if @i_modo = 0 
         begin       
           --1. Valida que la fecha de proceso para el lote sea igual a la fecha de cierre del producto 
           if @i_producto > 0
              begin
                select @w_diff = datediff(day, @i_fecha_proceso, fc_fecha_cierre)
                  from ba_fecha_cierre
                 where fc_producto = @i_producto 
     
                if @w_diff != 0 
                   begin
                     /* 'Fecha de proceso no coincide con la fecha de cierre del producto' */
                     exec cobis..sp_cerror   
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 808004
                     return 1
                   end
              end

           --2. Valida que se haya aprobado la autorizacion de ejecucion sobre un lote 
           select @w_autoriza = count(*) from cobis..ba_aprobacion 
            where ap_sarta = @i_sarta 
              and ap_fecha = @i_fecha_proceso

           if @w_autoriza = 0 
              begin
                /* Lote no autorizado para su ejecucion */
                exec cobis..sp_cerror   
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 808005
                return 1
              end

           --Encuentra lote de dependencia
           select @w_lote_dependencia = sa_dependencia   
             from cobis..ba_sarta
            where sa_sarta = @i_sarta


           --3. Valida que haya terminado el ultimo proceso del lote del cual depende 
           if @w_lote_dependencia is not null            
              begin 
                --Estado de ejecucion de ultimo proceso secuencial del lote del cual depende
                select @w_ultimo_status = lo_estatus 
                  from cobis..ba_log
                 where lo_sarta = @w_lote_dependencia 
                   and lo_secuencial = (select max(sb_secuencial) from cobis..ba_sarta_batch
                                         where sb_sarta = @w_lote_dependencia) 
                   and convert(char(10), lo_fecha_proceso, 101) = convert(char(10), @i_fecha_proceso, 101)  

                if (@w_ultimo_status <> 'F')
                   begin
                     /* Existen procesos de dependencia que no finalizaron correctamente */
                     exec cobis..sp_cerror   
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 808002
                     return 1
                   end
              end
              return 0
         end  --Modo 0
 
      --Validacion a nivel de proceso (antes de ser ejecutado)
      if @i_modo = 1 and @i_secuencial is not null
         begin       
           select @w_repeticion = sb_repeticion
             from cobis..ba_sarta_batch_exec 
            where sb_sarta      = @i_sarta
              and sb_secuencial = @i_secuencial
 
           --Analiza repeticion unica
           if @w_repeticion = 'N'
              begin
                select lo_estatus 
                  from cobis..ba_log, cobis..ba_fecha_cierre, cobis..ba_sarta
                 where lo_sarta      = sa_sarta
                   and sa_producto   = fc_producto
                   and convert(char(8),lo_fecha_proceso,1) = convert(char(8),fc_fecha_cierre,1)
                   and sa_sarta      = @i_sarta
                   and lo_secuencial = @i_secuencial
                   and lo_corrida    < @i_corrida
 
                if @@rowcount > 0 
                   begin
                   /* Este programa ya ha sido ejecutado y solo se puede ejecutar una vez en el dia */
                     select @w_msg = 'El programa ' + convert(varchar,@i_batch) + ' ya ha sido ejecutado y solo se puede ejecutar una vez en el dia' 
                     exec cobis..sp_cerror   
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 808023,
                          @i_msg   = @w_msg
                       return 1                                     
                   end
              end

           --Analizar_Una_Repeticion
           if @w_repeticion = 'U'
              begin              
                select lo_estatus
                  from cobis..ba_log, cobis..ba_fecha_cierre, cobis..ba_sarta
                 where lo_sarta      = sa_sarta
                   and sa_producto   = fc_producto
                   and convert(char(8),lo_fecha_proceso,1) = convert(char(8),fc_fecha_cierre,1)
                   and sa_sarta      = @i_sarta
                   and lo_secuencial = @i_secuencial
                   and lo_estatus    = 'F' 

                if @@rowcount > 0 
                   begin
                     /* Este programa ya ha sido ejecutado exitosamente y solo se puede ejecutar una vez en el dia */
                     select @w_msg = 'El programa ' + convert(varchar,@i_batch) + ' ya ha sido ejecutado exitosamente y solo se puede ejecutar una vez en el dia'
                     exec cobis..sp_cerror   
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 808024
                       return 1                
                   end
              end
              return 0
         end  --Modo 1
   end

/* Consulta para determinar los procesos con los que Inicia la ejecucion de un lote */

if @t_trn = 8090 and @i_operacion = 'I'   
   begin
     select sb_batch, 
            sb_secuencial, 
            ba_tipo_batch, 
            ba_arch_fuente, 
            ba_arch_resultado, 
            ba_producto, 
            sb_lote_inicio, 
            sb_habilitado,
            'AUTORIZADO' = isnull((select 'S' from cobis..ba_login_batch lb 
                                    where lb.lb_login = @s_user 
                                      and lb.lb_batch = b.sb_batch
                                      and lb.lb_sarta = b.sb_sarta
                                      and lb.lb_estado = 'V'),'N')   --,  ba_nombre, ba_descripcion
       from cobis..ba_sarta_batch_exec b, cobis..ba_batch a 
      where sb_batch = ba_batch
        and sb_sarta = @i_sarta 
        and sb_secuencial in (select en_secuencial_inicio
                                from ba_enlace_exec
                               where en_sarta = @i_sarta
        and en_secuencial_inicio not in (select en_secuencial_fin
                                           from ba_enlace_exec
                                          where en_sarta = @i_sarta))
      order by sb_secuencial

      if @@rowcount = 0
         begin
           /* No existen procesos para iniciar la ejecucion del lote */
           exec cobis..sp_cerror   
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808001
           return 1
    end
   end

/* A partir de un proceso finalizado, encontrar el(los) Siguiente(s) proceso(s) a ejecutar */

if @t_trn = 8090 and @i_operacion = 'S'
   begin
      select en_batch_fin, en_secuencial_fin, ba_tipo_batch, 
             ba_arch_fuente, ba_arch_resultado, ba_producto, 
             sb_lote_inicio, sb_habilitado 
        from cobis..ba_sarta_batch_exec, cobis..ba_enlace_exec, cobis..ba_batch 
       where sb_sarta = en_sarta
         and sb_batch = en_batch_fin 
         and sb_secuencial = en_secuencial_fin
         and en_batch_fin = ba_batch
         and en_sarta = @i_sarta
         and en_batch_inicio = @i_batch
   end

/* Determinar el estado de ejecucion de la corrida actual de los procesos Previos del proceso a ejecutar */

if @t_trn = 8090 and @i_operacion = 'P'
begin
   -- Validacion de Autorizacion forzada
   if @i_aut_forzada = 'X' 
      select 'S'
   else
   begin  
      --Se obtienen los procesos previos
      declare cur_procesos cursor
      for select en_batch_inicio, en_secuencial_inicio, en_tipo_enlace, sb_habilitado 
            from cobis..ba_enlace_exec, cobis..ba_sarta_batch_exec
        where en_sarta = sb_sarta
            and en_batch_inicio      = sb_batch 
            and en_secuencial_inicio = sb_secuencial
            and en_sarta             = @i_sarta
            and en_batch_fin         = @i_batch
            and en_secuencial_fin    = @i_secuencial
        for read only

         open cur_procesos 
         fetch cur_procesos 
         into  @w_batch_inicio, 
               @w_secuencial_inicio, 
               @w_tipo_enlace, 
               @w_habilitado 

         while @@fetch_status != -1
         begin
            if @@fetch_status = -2
            begin
               close cur_procesos 
               deallocate  cur_procesos 
               select @w_msg = 'Error en cursor para bloqueos'
               --raiserror 21000 @w_msg
               raiserror('%d %s', 16, 1, 21000, @w_msg)  --migracion sybase-sql 22042016
               return 1
            end

            --Consulta Status de proceso previo 
            set rowcount 1
            select @w_status = lo_estatus
              from cobis..ba_log
             where lo_sarta      = @i_sarta
               and lo_batch      = @w_batch_inicio
               and lo_secuencial = @w_secuencial_inicio
               and lo_corrida    = @i_corrida
               and convert(char(10), lo_fecha_proceso, 101) = convert(char(10), @i_fecha_proceso, 101) 
             order by lo_intento desc
         
            if @@rowcount = 0 
            begin
               select @w_status = 'N'
            end

            -- SI NO ES REPROCESABLE Y YA FINALIZO SATISFACTORIAMENTE EN ESTA
            -- U OTRA CORRIDA, @w_status = 'S'
            if exists (select 1 
                         from ba_batch, ba_log
                        where ba_batch = @w_batch_inicio
                          and lo_batch = @w_batch_inicio
                          and lo_sarta = @i_sarta
                          and lo_batch = ba_batch
                          and ba_reproceso = 'N'
                          and lo_estatus = 'F'
                          and convert(varchar(10), @i_fecha_proceso, 101) = convert(varchar(10), lo_fecha_proceso, 101) 
                          and lo_corrida  = @i_corrida )
            begin
               select @w_status = 'F'
            end
 
            --Si el proceso previo que no ha terminado -> No continuar
            if    @w_status != 'F' and 
                  @w_status != 'A' and 
                  @w_status != 'K' and 
                  @w_tipo_enlace = 'S' 
                  and @w_habilitado = 'S' 
            begin
               close cur_procesos 
               deallocate  cur_procesos
               select 'N'
               return 0
            end
            
            --Si existe algun proceso previo que no finalizo correctamente y depende de este -> No continuar
            if @w_status != 'F' and @w_tipo_enlace = 'D' --and @w_habilitado = 'S' 
            begin  
               close cur_procesos 
               deallocate  cur_procesos 
               select 'N'
               return 0
            end
         
            set rowcount 0
            fetch cur_procesos 
            into  @w_batch_inicio, 
                  @w_secuencial_inicio, 
                  @w_tipo_enlace, 
                  @w_habilitado 
         end
         close cur_procesos 
         deallocate  cur_procesos 
         
         --Todos los procesos previos terminaron -> Continuar
         select 'S'
   end
end


/* Consulta informacion del proceso */
if @t_trn = 8090 and @i_operacion = 'Q'
   begin
      --Numero de intento de ejecucion 
      select @w_intento = isnull(max(lo_intento),0) + 1
        from cobis..ba_log
       where lo_sarta      = @i_sarta 
         and lo_batch      = @i_batch
         and lo_secuencial = @i_secuencial 
         and lo_corrida    = @i_corrida           

      --Consulta de atributo de reproceso
      select @w_reproceso = ba_reproceso
        from ba_batch
       where ba_batch = @i_batch

   
      if @w_reproceso = 'N'
         begin
            select @w_cont = count(1)
              from ba_log, ba_fecha_proceso
             where lo_sarta = @i_sarta
               and lo_batch = @i_batch
               and lo_secuencial = @i_secuencial
               and convert(varchar(10), fp_fecha, 101) = convert(varchar(10), lo_fecha_proceso, 101)  
               and lo_corrida <= @i_corrida
      
            if exists (select 1 from ba_log, ba_fecha_proceso
                        where lo_sarta = @i_sarta
                          and lo_batch = @i_batch 
                          and lo_secuencial = @i_secuencial
                          and convert(varchar(10), fp_fecha, 101) = convert(varchar(10), lo_fecha_proceso, 101)
                          and lo_estatus = 'X'
                          and lo_corrida <= @i_corrida)
               begin
                  if @w_cont > 1
                     select @w_ejecutar = 'P'  -- Consulta a supervisor (mensaje de advertencia)   
                  else
                     select @w_ejecutar = 'S'  -- Autorizacion Forzada
               end
            else
               begin /* 05-Ene-2008, SSO: Se adiciona esta condicion */ 
                  if exists (select 1 from ba_log, ba_fecha_proceso
                              where lo_sarta = @i_sarta
                                and lo_batch = @i_batch 
                                and lo_secuencial = @i_secuencial
                                and convert(varchar(10), fp_fecha, 101) = convert(varchar(10), lo_fecha_proceso, 101)

                                and lo_estatus = 'E'
                                and lo_corrida <= @i_corrida)
                      select @w_ejecutar = 'E'   -- En Ejecucion
                  else
                  begin
                      if exists (select 1 from ba_log, ba_fecha_proceso
                                  where lo_sarta = @i_sarta
                                    and lo_batch = @i_batch 
                                    and lo_secuencial = @i_secuencial
                                    and convert(varchar(10), fp_fecha, 101) = convert(varchar(10), lo_fecha_proceso, 101)
                                    and lo_estatus = 'F'
                                    and lo_corrida <= @i_corrida)
                          select @w_ejecutar = 'N'   -- No reprocesar
                      else

                         begin 
                            if @w_cont > 0    
                               select @w_ejecutar = 'P'  -- Consulta a supervisor (mensaje de advertencia)
                            else
                               select @w_ejecutar = 'S'  -- Se ejecuta por 1ra vez            
                         end
                  end 
               end
         end
      else
        if @w_reproceso = 'S'
           begin 
              if exists --SSO 13-03-2012, Ajustes en FNA para evitar duplicidad
                (select 1 from   ba_log, ba_fecha_proceso
                 where  lo_sarta           = @i_sarta
                 and    lo_batch           = @i_batch
                 and    lo_secuencial      = @i_secuencial
                 and    lo_fecha_proceso   = convert(varchar(10), fp_fecha, 101)
                 and    lo_estatus         = 'E')
                  select @w_ejecutar = 'D'   -- No permitir (evitar ejecucion duplicada)
              else
                  select @w_ejecutar = 'S'   -- Si puede reprocesar
           end    
        else
           begin 
              --SSO 19-01-2010 Inicio Ajustes Batch Ciclico 
              --Evaluar en estructura auxiliar si el proceso se debe seguir ejecutando o NO          
              if (@w_reproceso = 'C' and isnull( (select ctc_procesar 
                                               from cobis..ba_ctrl_ciclico 
                                              where ctc_sarta      = @i_sarta
                                                and ctc_batch      = @i_batch
                                                and ctc_secuencial = @i_secuencial),'N') = 'S') 
                  select @w_ejecutar = 'S'   -- Si puede reprocesar
              else
                  select @w_ejecutar = 'N'   -- Detener Ejecucion Ciclica
              --SSO 19-01-2010 Fin Ajustes Batch Ciclico 
           end    


      /* Se coloca el path de destino y archivo de listado por defecto cuando es Reporte y no los tiene definidos */

      select @w_arch_resultado = isnull(ba_arch_resultado, substring(ba_arch_fuente, 1, charindex('.', ba_arch_fuente )) +  'lis'), 
             @w_path_destino   = isnull(ba_path_destino, pp_path_destino)
        from cobis..ba_batch, cobis..ba_path_pro 
       where ba_producto = pp_producto
         and ba_batch = @i_batch
         and ba_tipo_batch = 'R' 

      select ba_batch, 
             ba_nombre, 
             ba_descripcion, 
             ba_lenguaje, 
             valor,
             convert(char(10),ba_fecha_creacion,@i_formato_fecha), 
             ba_producto, 
             pd_descripcion, 
             ba_tipo_batch, 
             ba_ente_procesado,
             'ARCH. RESUL.' = @w_arch_resultado, 
             ba_arch_fuente, 
             ba_frec_reg_proc,
             ba_impresora, 
             convert(varchar(10),fc_fecha_cierre, @i_formato_fecha), 
             ba_serv_destino, 
             'INTENTO' = @w_intento, 
             'EJECUTAR' = @w_ejecutar,
             'PATH FUENTE' = ba_path_fuente, 
             'PATH DESTINO' = @w_path_destino,
             'AUTORIZADO' = isnull((select 'S' from cobis..ba_login_batch lb 
                                     where lb.lb_login = @s_user 
                                       and lb.lb_batch = @i_batch 
                                       and lb.lb_sarta = @i_sarta
                                       and lb.lb_estado = 'V'),'N')   
        from cobis..ba_batch,cobis..cl_tabla,cobis..cl_catalogo,
             cobis..cl_producto, cobis..ba_fecha_cierre
       where pd_producto = ba_producto
         and fc_producto = ba_producto
         and cobis..cl_catalogo.codigo = ba_lenguaje
         and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
         and ba_batch = @i_batch
         and cobis..cl_tabla.tabla = 'ba_lenguaje'
      
      if @@rowcount = 0
         begin
            /* No existen datos del proceso */
            exec cobis..sp_cerror   
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 801029
            return 1
         end
   return 0
end

if @t_trn = 8090 and @i_operacion = 'U'
begin
   update cobis..ba_sarta_batch_exec
      set sb_repeticion = 'U'
    where sb_sarta = @i_sarta
      and sb_batch = @i_batch
      and sb_secuencial = @i_secuencial
   
   return 0
end
    

/* Consulta para la Graficacion de nodos y enlaces */
if @t_trn = 8090 and @i_operacion = 'G'    
   begin
      set rowcount 20
      if @i_modo = 0  --Consulta los primeros 20 procesos que componen la sarta
    begin
      select ba_batch, ba_nombre, sb_left, sb_top, 
             sb_lote_inicio, sb_secuencial, sb_lote_inicio, 
             sb_habilitado, sb_adicionado, sb_imprimir,
             'AUTORIZADO' = isnull(( select 'S' from cobis..ba_login_batch lb 
                                      where lb.lb_login = @s_user 
                                        and lb.lb_batch = b.sb_batch 
                                        and lb.lb_sarta = b.sb_sarta
                                        and lb.lb_estado = 'V'            
                                   ),'N'), ba_reproceso --FLO 27-MAR-2009
        from cobis..ba_batch a, cobis..ba_sarta_batch_exec b
       where sb_batch = ba_batch
         and sb_sarta = @i_sarta
       order by sb_secuencial
      
           if @@rowcount = 0
         begin
                /* No existen batch asociados a esta sarta */
                exec cobis..sp_cerror   
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808009
                return 1
         end
       set rowcount 0
       return 0
         end
 
      if @i_modo = 1  --Consulta los siguientes 20 procesos que componen la sarta
    begin
      select ba_batch, ba_nombre, sb_left, sb_top, 
                  sb_lote_inicio, sb_secuencial, sb_lote_inicio, 
                  sb_habilitado, sb_adicionado, sb_imprimir,
                  'AUTORIZADO' = isnull((select 'S' from cobis..ba_login_batch lb 
                                          where lb.lb_login = @s_user 
                                            and lb.lb_batch = b.sb_batch 
                                            and lb.lb_sarta = b.sb_sarta
                                            and lb.lb_estado = 'V'           
                                       ),'N'), ba_reproceso -- FLO 27-MAR-2009
        from cobis..ba_batch a, cobis..ba_sarta_batch_exec b
       where sb_batch = ba_batch
         and sb_sarta = @i_sarta
         and sb_secuencial > @i_secuencial
       order by sb_secuencial
      
           if @@rowcount = 0
         begin
                /* No existen mas batch asociados a esta sarta */
/*                exec cobis..sp_cerror   
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808009*/
                set rowcount 0
                return 1
         end
       set rowcount 0
       return 0
   end

      if @i_modo = 2   --Consulta los primeros 20 enlaces 
         begin
           select en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, 
                  en_tipo_enlace, en_puntos, sb_lote_inicio
             from cobis..ba_enlace_exec, cobis..ba_sarta_batch_exec 
            where en_sarta = sb_sarta
              and en_batch_inicio = sb_batch  
              and en_secuencial_inicio = sb_secuencial 
              and en_sarta = @i_sarta
            order by en_secuencial_inicio, en_secuencial_fin 

           set rowcount 0
           return 0
         end

      if @i_modo = 3   --Consulta los siguientes 20 enlaces 
         begin
           select en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, 
                  en_tipo_enlace, en_puntos, sb_lote_inicio
             from cobis..ba_enlace_exec, cobis..ba_sarta_batch_exec 
            where en_sarta = sb_sarta
              and en_batch_inicio = sb_batch  
              and en_secuencial_inicio = sb_secuencial 
              and en_sarta = @i_sarta
              and ((    en_secuencial_inicio >= @i_secuencial_inicio
                    and en_secuencial_fin    >  @i_secuencial_fin)
                   or en_secuencial_inicio >= @i_secuencial_inicio + 1 )
            order by en_secuencial_inicio, en_secuencial_fin 

           set rowcount 0
           return 0
         end


   end

go
