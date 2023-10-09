/************************************************************************/
/* Archivo:                consultas.sp                                 */
/* Stored procedure:       sp_consultas                                 */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     02-Mayo-2002                                 */
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
/*    Este programa realiza varias consultas segun el tipo de infor-    */
/*    macion que se desea mostrar                                       */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    02-May-2002    G. Landazuri    Emision Inicial                    */
/*    14-Sep-2004    J. Umana        Se incluye columna                 */
/*                                   sb_habilitado                      */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_consultas')
   drop proc sp_consultas

go

create proc sp_consultas   (
   @s_ssn                  int          = null,
   @s_date                 datetime     = null,
   @s_user                 login        = null,
   @s_term                 descripcion  = null,
   @s_corr                 char(1)      = null,
   @s_ssn_corr             int          = null,
   @s_ofi                  smallint     = null,
   @t_rty                  char(1)      = null,
   @t_trn                  smallint     = 802,
   @t_debug                char(1)      = 'N',
   @t_file                 varchar(14)  = null,
   @t_from                 varchar(30)  = null,
   @i_operacion            char(1),
   @i_historico            char(1)      = 'H',   
   @i_sarta                int          = null,
   @i_lote_inicio          int          = null,
   @i_batch                int          = null,
   @i_secuencial           smallint     = null,
   @i_fecha1               datetime     = null,
   @i_fecha2               datetime     = null,
   @i_porcentaje_desde     integer      = null,
   @i_porcentaje_hasta     integer      = null,
   @i_lote                 char(1)      = null,
   @i_modo                 smallint     = null,
   @i_msg                  varchar(132) = null
)
as 
declare
   @w_today                datetime,   /* fecha del dia */
   @w_return               int,     /* valor que retorna */
   @w_sp_name              varchar(32),   /* descripcion del stored procedure*/
   @w_existe               int,     /* codigo existe = 1 no existe = 0 */
   @w_sarta                int,
   @w_tiempo               integer,
   @w_tiempo_exc           integer,
   @w_batch                int,
   @w_nombre               varchar(64),
   @w_secuencial           int,
   @w_flag_fecha           tinyint,
   @w_flag_sarta           tinyint,
   @w_porcentaje           integer,
   @w_diferencia           integer, 
   @w_fecha_inicio         datetime,
   @w_fecha_terminacion    datetime,
   @w_pertenece            char(1)  
    
select @w_today = getdate()
select @w_sp_name = 'sp_consultas'

select @w_porcentaje = 0

if (@t_trn <> 8099)
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801077
   return 1
end

/*Tablas temporales insercion
Tabla              Operacion
-------            ---------- 
ba_sarta_batch       V
ba_log               L
ba_log - corrida     C
ba_log - tiempos excedentes  T
ba_log - errores     E
*/

/***Consulta a la tabla ba_sarta_batch***/
if @i_operacion = 'M'  --Para maximizacion
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select ba_batch,ba_nombre,sb_dependencia,sb_repeticion,sb_left,sb_top,sb_lote_inicio,sb_secuencial,
      reverse(substring(reverse(ba_arch_fuente),1,12)),sb_habilitado    -- JUM 14-09-04
      from cobis..ba_batch,cobis..ba_sarta_batch
      where sb_sarta = @i_sarta 
        and sb_batch = ba_batch
        and sb_lote_inicio = @i_lote_inicio
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

   if @i_modo = 1
   begin
      select ba_batch,ba_nombre,sb_dependencia,sb_repeticion,sb_left,sb_top,sb_lote_inicio,sb_secuencial,
      reverse(substring(reverse(ba_arch_fuente),1,12)),sb_habilitado   -- JUM 14-09-04
      from cobis..ba_batch,cobis..ba_sarta_batch
      where sb_batch = ba_batch
        and sb_sarta = @i_sarta
        and sb_lote_inicio = @i_lote_inicio
        and sb_secuencial > @i_secuencial
      order by sb_secuencial
      
      if @@rowcount = 0
      begin
         /* No existen mas batch asociados a esta sarta */
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
end

if @i_operacion = 'V' 
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select   ba_batch,
               ba_nombre,
               sb_dependencia,
               sb_repeticion,
               sb_left,
               sb_top,
               sb_lote_inicio,
               sb_secuencial,
               reverse(substring(reverse(ba_arch_fuente),1,12)),
               sb_habilitado    -- JUM 14-09-04
      from cobis..ba_batch,cobis..ba_sarta_batch
      where sb_sarta = @i_sarta 
        and sb_batch = ba_batch
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
      
   if @i_modo = 1
   begin
      select   ba_batch,
               ba_nombre,
               sb_dependencia,
               sb_repeticion,
               sb_left,
               sb_top,
               sb_lote_inicio,
               sb_secuencial,
               reverse(substring(reverse(ba_arch_fuente),1,12)),
               sb_habilitado    -- JUM 14-09-04
      from cobis..ba_batch,cobis..ba_sarta_batch
      where sb_batch = ba_batch
        and sb_sarta = @i_sarta
        and sb_secuencial > @i_secuencial
      order by sb_secuencial
      
      if @@rowcount = 0
         begin
            /* No existen mas batch asociados a esta sarta */
/*            exec cobis..sp_cerror   
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 808009
*/
            return 1
         end
      set rowcount 0
      return 0
   end

   if @i_modo = 2
   begin
      select ba_batch,ba_nombre,reverse(substring(reverse(ba_arch_fuente),1,12))
      from cobis..ba_batch
      where ba_batch = @i_batch
      
      if @@rowcount = 0
      begin
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
end

if @i_operacion = 'X' /* Devuelve (0) si un proceso indicado pertenece a una sarta x, q a su vez hace parte de un lote de inicio y */
begin
   select @w_pertenece= 'N'
      if exists (select    
         ba_batch
      from 
         cobis..ba_batch,
         cobis..ba_sarta_batch
      where 
            sb_sarta = @i_sarta
               and sb_batch = ba_batch
            and sb_lote_inicio = @i_lote_inicio
            and ba_batch = @i_batch
   )                                                        
         select @w_pertenece= 'S' 
        
   select @w_pertenece
   return 0   
end

/***Consulta a la tabla ba_log***/
if @i_operacion = 'L'
begin
   if @i_fecha1 is null or @i_fecha2 is null
      select @w_flag_fecha = 1
   else
      select @w_flag_fecha = 0   

   select @i_fecha2 = dateadd(ms, -3,dateadd(dd, 1, @i_fecha2))
   select lo_sarta,
          sb_lote_inicio,
          lo_batch,
          lo_secuencial
   from cobis..ba_sarta_batch, cobis..ba_log
   where sb_sarta = @i_sarta
     and sb_sarta = lo_sarta
     and sb_batch = lo_batch
     and sb_secuencial = lo_secuencial
     and (lo_fecha_inicio between @i_fecha1 and @i_fecha2) --or @w_flag_fecha = 1)
   --and lo_fecha_inicio < convert(varchar(10),getdate(),101)
     and lo_estatus in ('F','E')  
   order by sb_lote_inicio,lo_batch  

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801029--,
       -- @i_msg   = "No existen registros que cumplan esa condicion" 
      return 1
   end
return 0
end

/***Calculo de tiempos promedios de los procesos***/
if @i_operacion = 'C'
begin
   if @i_historico = 'H'
          
      select @w_tiempo = isnull(avg(datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)), 0)
      from cobis..ba_log
      where lo_sarta = @i_sarta
        and lo_batch = @i_batch
        and lo_secuencial = @i_secuencial
        and lo_fecha_inicio >= @i_fecha1
        and lo_fecha_inicio <= dateadd(ms, -3, dateadd(dd, 1, @i_fecha2))
        and lo_estatus = 'F'  
   else  --@i_historico = 'D'
        select @w_tiempo = isnull(avg(datediff(ss, lo_fecha_inicio, isnull(lo_fecha_terminacion, getdate()))), 0)
         from cobis..ba_log
         where lo_sarta = @i_sarta
           and lo_batch = @i_batch
           and lo_secuencial = @i_secuencial
           and lo_fecha_inicio >= convert(varchar(10),getdate(),101)
           and lo_estatus in ('F','E')

   select @w_tiempo
   
   return 0
end

/***Calculo de tiempos excedentes***/
if @i_operacion = 'T'
begin
   select @i_fecha2 = dateadd(hh, 23, @i_fecha2)
   select @i_fecha2 = dateadd(mi, 59, @i_fecha2)
   select @i_fecha2 = dateadd(ss, 59, @i_fecha2)
   select @i_fecha2 = dateadd(ms, 998, @i_fecha2)
   
   create table #tabla_temporal (
      tmp_sarta         int NULL,
      tmp_batch         int NULL,
      tmp_nombre        varchar(64) NULL,
      tmp_tiempo        int NULL,
      tmp_tiempo_exc    int NULL,
      tmp_porcentaje    int NULL
      )

   if @i_sarta is null
   begin
      select @w_flag_sarta = 1
      select @w_fecha_inicio = min(lo_fecha_inicio),
             @w_fecha_terminacion = max(lo_fecha_terminacion)
        from cobis..ba_log
       where lo_fecha_proceso between @i_fecha1 and @i_fecha2

      select @i_fecha1 = @w_fecha_inicio
      select @i_fecha2 = @w_fecha_terminacion 
      select @i_fecha2 = dateadd(hh, 23, @i_fecha2)
      select @i_fecha2 = dateadd(mi, 59, @i_fecha2)
      select @i_fecha2 = dateadd(ss, 59, @i_fecha2)
      select @i_fecha2 = dateadd(ms, 998, @i_fecha2)    
   end
   else
   begin
      select @w_flag_sarta = 0
      select @w_fecha_inicio = min(lo_fecha_inicio),
             @w_fecha_terminacion = max(lo_fecha_terminacion)
        from cobis..ba_log
       where lo_fecha_proceso between @i_fecha1 and @i_fecha2
         and lo_sarta = @i_sarta

      select @i_fecha1 = @w_fecha_inicio
      select @i_fecha2 = @w_fecha_terminacion 
      select @i_fecha2 = dateadd(hh, 23, @i_fecha2)
      select @i_fecha2 = dateadd(mi, 59, @i_fecha2)
      select @i_fecha2 = dateadd(ss, 59, @i_fecha2)
      select @i_fecha2 = dateadd(ms, 998, @i_fecha2)
   end

   declare cursor_tiempo cursor for
   select distinct
          lo_sarta,
          lo_batch, 
          ba_nombre, 
          lo_secuencial  
   from cobis..ba_batch,
        cobis..ba_log
   where lo_batch = ba_batch
   and ((lo_sarta = @i_sarta) or (@w_flag_sarta = 1))
   
   open cursor_tiempo
   
   fetch cursor_tiempo 
    into @w_sarta,    
         @w_batch,
         @w_nombre,
         @w_secuencial

   while (@@fetch_status = 0)
   begin
      select @w_tiempo = isnull(avg(datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)), 0)
        from cobis..ba_log
       where lo_sarta = @w_sarta
         and lo_batch = @w_batch
         and lo_secuencial = @w_secuencial
         and lo_fecha_inicio >= @i_fecha1
         and lo_fecha_terminacion <= @i_fecha2
--         and lo_fecha_inicio < convert(varchar(10),getdate(),101)
         and lo_estatus = 'F'  
         
      select @w_tiempo_exc = isnull(avg(datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)), 0)
        from cobis..ba_log
       where lo_sarta = @w_sarta
         and lo_batch = @w_batch
         and lo_secuencial = @w_secuencial
         and lo_fecha_inicio >= convert(varchar(10),getdate(),101)
         and lo_estatus in ('F','E')
         
      if @w_tiempo <> 0  
      begin 
         select @w_diferencia = @w_tiempo_exc - @w_tiempo 
         select @w_porcentaje = (@w_diferencia * 100) / @w_tiempo
         
         if @w_porcentaje >= @i_porcentaje_desde and @w_porcentaje <= @i_porcentaje_hasta --@w_tiempo_exc > @w_tiempo
         begin      
--          insert into #tabla_temporal values (@w_sarta, @w_batch, @w_nombre, @w_tiempo, @w_tiempo_exc, @w_porcentaje)  
            insert into #tabla_temporal values (@w_sarta, @w_batch, @w_nombre, @w_tiempo, @w_diferencia, @w_porcentaje)  
         end
      end
    
   fetch cursor_tiempo into
         @w_sarta, 
         @w_batch,
         @w_nombre,
         @w_secuencial

   end  --end de while

   close cursor_tiempo
   deallocate  cursor_tiempo

   select 'LOTE' = tmp_sarta,
          'BATCH' = tmp_batch,
          'NOMBRE' = tmp_nombre,
          'T. PROM.(Seg)' = tmp_tiempo,
          'T. EXCED.(Seg)' = tmp_tiempo_exc,
          'PORCENTAJE %' = tmp_porcentaje     
    from #tabla_temporal  

   return 0
end

if @i_operacion = 'E'
begin

   select @i_fecha2 = dateadd(hh, 23, @i_fecha2)
   select @i_fecha2 = dateadd(mi, 59, @i_fecha2)
   select @i_fecha2 = dateadd(ss, 59, @i_fecha2)
   select @i_fecha2 = dateadd(ms, 998, @i_fecha2)
    
   if @i_fecha1 is null or @i_fecha2 is null
      select @w_flag_fecha = 1
   else
      select @w_flag_fecha = 0   

   if @i_lote = 'S'
   begin
      select 
         'SARTA' = lo_sarta,
         'BATCH' = lo_batch,
         'CORRIDA' = lo_corrida,
         'OPERADOR' = lo_operador,
         'FECHA INICIO' = convert(varchar(15), lo_fecha_inicio, 101),
         'REG. PROCESADOS' = lo_num_reg_proc,
         'RAZON' = lo_razon
        from ba_log
       where lo_estatus in ('A', 'K')
         and lo_sarta = @i_sarta
         and ((lo_fecha_inicio between @i_fecha1 and @i_fecha2) or @w_flag_fecha = 1)
      order by lo_sarta, lo_batch

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801031,
         @i_msg   = 'No existen registros que cumplan estas condiciones' 
      return 1
   end
end
 
if @i_lote = 'N'  
begin
   select 
      'SARTA' = lo_sarta,
      'BATCH' = lo_batch,
      'CORRIDA' = lo_corrida,
      'OPERADOR' = lo_operador,
      'FECHA INICIO' = convert(varchar(15), lo_fecha_inicio, 101),
      'REG. PROCESADOS' = lo_num_reg_proc,
      'RAZON' = lo_razon
     from ba_log
    where lo_estatus in ('A', 'K')
      and lo_batch = @i_batch
      and ((lo_fecha_inicio between @i_fecha1 and @i_fecha2) or @w_flag_fecha = 1)
    order by lo_sarta, lo_batch

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801031,
         @i_msg   = 'No existen registros que cumplan estas condiciones' 
      return 1
   end
end

return 0

end

go

/* fin */
