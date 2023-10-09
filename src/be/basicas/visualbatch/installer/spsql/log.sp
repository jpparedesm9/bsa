/************************************************************************/
/* Archivo:                log.sp                                       */
/* Stored procedure:       sp_log                                       */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     22-Abril-1994                                */
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
/*    Este programa procesa las transacciones de:                       */
/*    El log de ejecucion de procesos batch                             */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    22-Abr-1994    R. Garces       Emision Inicial                    */
/*    29-Jun-1994    G. Jaramillo    Modificacion opcion 'S'            */
/*    25-Ago-1997    D. Guerrero     Control de fechas                  */ 
/*    07-Jul-1999    D. Guerrero     CY2K BATB101                       */
/*    07-Sep-2007    S. Soto         Se anade nombre del proceso opc 'S'*/		 
/*    26-Sep-2008    S. Soto         Uso de caracter @, compatibil. CTS */
/*    29-Jul-2011    S. Soto         uso de formatos 113 y 100          */
/*    04-Jul-2012  J. Giler Se añade dos nuevos campos en las consultas */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_log')
   drop proc sp_log

go
create proc sp_log   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = 804,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1),
   @i_modo       smallint = null,
   @i_sarta   int = null,
   @i_batch   int = null,
   @i_secuencial    smallint = null,
   @i_corrida    smallint = null,
   @i_fecha1     datetime = null,
   @i_fecha2     datetime = null,
   @i_sarta1     int = null,
   @i_batch1         int = null,  /*DGU-07-01-1999*/
   @i_secuencial1    smallint = null
)
as 
SET NOCOUNT ON
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 no existe = 0 */
   @w_flag_sarta     tinyint,      /* Bandera para busqueda */ 
   @w_flag_batch     tinyint,
   @w_flag_secuencial tinyint,
   @w_flag_fecha     tinyint,
   @w_sarta   int,
   @w_batch      int,  /*DGU-07-01-1999*/
   @w_secuencial    smallint,
   @w_corrida    smallint,
   @w_fecha_inicio   datetime,
   @w_fecha_terminacion datetime,
   @w_num_reg_proc   int,
   @w_estatus    char(1)

select @w_today = getdate()
select @w_sp_name = 'sp_log'


if (@t_trn <> 8045 and @i_operacion = 'S') or
   (@t_trn <> 8046 and @i_operacion = 'Q') or
   (@t_trn <> 8050 and @i_operacion = 'F') 
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 801077
   return 1
end


/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A' 
begin
   select  @w_fecha_inicio      = lo_fecha_inicio,
      @w_fecha_terminacion = lo_fecha_terminacion,
      @w_num_reg_proc        = lo_num_reg_proc, 
      @w_estatus       = lo_estatus
   from    ba_log
   where    lo_sarta      = @i_sarta
     and   lo_batch      = @i_batch
     and   lo_secuencial = @i_secuencial
     and   lo_corrida in (select max(lo_corrida) from ba_log
                where  lo_sarta      = @i_sarta
                  and  lo_batch      = @i_batch
             and  lo_secuencial = @i_secuencial)

   if @@rowcount = 0
      select @w_existe = 0
   else
      select @w_existe = 1
end

/* Busqueda de registros */

if @i_operacion = 'S'
begin
   if @i_sarta is NULL
      select @w_flag_sarta = 1
   else
      select @w_flag_sarta = 0
   if @i_batch is NULL 
      select @w_flag_batch = 1
   else
      select @w_flag_batch = 0
   if @i_secuencial is NULL
      select @w_flag_secuencial = 1
   else
      select @w_flag_secuencial = 0
   if @i_fecha1 is null or @i_fecha2 is null
      select @w_flag_fecha = 1
   else
      select @w_flag_fecha = 0   
   
   --select @i_fecha2 = dateadd(ms, -3, dateadd(dd, 1, @i_fecha2))

   set rowcount 20
   if @i_modo = 0
   begin
      select   'Lote'               = lo_sarta,
               'Batch'              = lo_batch,
               'Nombre del Proceso' = convert(varchar(60), ba_nombre), 
               'Programa'     = convert(varchar(20), ba_arch_fuente),  
               'Dur (s)'      = convert(varchar, datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)),
               'Corrida'      = lo_corrida,
               'Sec.'         = lo_secuencial,
               'Fecha Ini.'   = convert(varchar, lo_fecha_inicio, 113),
               'Fecha Fin'    = convert(varchar, lo_fecha_terminacion, 113),
               'Fecha Proc.'  = convert(varchar(11), lo_num_reg_proc, 100),
               'Estado'       = lo_estatus,
               'Razon'        = '@' + substring(lo_razon,1,40),
               'Parametros'   = substring(lo_parametro,1,60),
               'Intento'    = lo_intento,
               'Servidor'   = ba_serv_destino
        from cobis..ba_log, cobis..ba_batch
       where lo_batch = ba_batch
         and (lo_sarta = @i_sarta or @w_flag_sarta = 1)
         and (lo_batch = @i_batch or @w_flag_batch = 1)
         and (lo_secuencial = @i_secuencial or @w_flag_secuencial = 1)
--       and ((lo_fecha_proceso between @i_fecha1 and @i_fecha2) or @w_flag_fecha = 1)
        and (lo_fecha_proceso >= @i_fecha1 or @i_fecha1 is null)
        and (lo_fecha_proceso <= @i_fecha2 or @i_fecha2 is null)
      order by lo_sarta,lo_corrida,lo_secuencial
      
      if @@rowcount = 0
      begin
         /* No existen logs */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801080
         return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
       select   'Lote'               = lo_sarta,
               'Batch'              = lo_batch,
               'Nombre del Proceso' = convert(varchar(60), ba_nombre), 
               'Programa'     = convert(varchar(20), ba_arch_fuente),  
               'Dur (s)'      = convert(varchar, datediff(ss, lo_fecha_inicio, lo_fecha_terminacion)),
               'Corrida'      = lo_corrida,
               'Sec.'         = lo_secuencial,
--               'Operador'   = substring(lo_operador,1,8),
               'Fecha Ini.'    = convert(varchar, lo_fecha_inicio, 113),
               'Fecha Fin'    = convert(varchar, lo_fecha_terminacion, 113),
               'Fecha Proc.'  = convert(varchar(11), lo_num_reg_proc, 100),
               'Estado'       = lo_estatus,
               'Razon'        = '@' + substring(lo_razon,1,40),
               'Parametros'   = substring(lo_parametro,1,60),
              'Intento'    = lo_intento,
              'Servidor'   = ba_serv_destino
      from cobis..ba_log, cobis..ba_batch
      where lo_batch = ba_batch
        and (lo_sarta = @i_sarta or @w_flag_sarta = 1)
        and (lo_batch = @i_batch or @w_flag_batch = 1)

        and (lo_secuencial = @i_secuencial or @w_flag_secuencial = 1)
        and (lo_fecha_proceso >= @i_fecha1 or @i_fecha1 is null)
        and (lo_fecha_proceso <= @i_fecha2 or @i_fecha2 is null)

        and ((lo_sarta   = @i_sarta1 and
              lo_corrida = @i_corrida and
              lo_secuencial > @i_secuencial1) or
             (lo_sarta = @i_sarta1 and
              lo_corrida > @i_corrida) or
             (lo_sarta > @i_sarta1))
        order by lo_sarta,lo_corrida,lo_secuencial
      if @@rowcount = 0
      begin
         /* No existen logs */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801080
         return 1
      end
      set rowcount 0
      return 0
   end
   
   if @i_modo = 3 /*Consulta la menor hora de inicio y la mayor hora de fin de ejecución*/
   begin
      select datediff(ss, min(lo_fecha_inicio), max (lo_fecha_terminacion))
        from cobis..ba_log, cobis..ba_batch
       where lo_batch = ba_batch
         and (lo_sarta = @i_sarta or @i_sarta is null)
         and (lo_batch = @i_batch or @i_batch is null)
         and (lo_secuencial = @i_secuencial or @w_flag_secuencial = 1)
         and (lo_fecha_proceso >= @i_fecha1 or @i_fecha1 is null)
         and (lo_fecha_proceso <= @i_fecha2 or @i_fecha2 is null)
      if @@rowcount = 0
      begin
         /* No existen logs */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801080
         return 1
      end
   end
end

/* Busqueda por Query */

if @i_operacion = 'Q'
begin
   if @w_existe = 0
   begin
      /* No existe el log */
      exec cobis..sp_cerror   
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801081
      return 1
   end
   select @w_fecha_inicio,@w_fecha_terminacion,@w_num_reg_proc,@w_estatus
end

/* Busqueda de las ultimas 20 corridas */ 
if @i_operacion = 'F'
begin
   set rowcount 20   
   select  lo_sarta,
      lo_batch,
      lo_secuencial,
      lo_corrida,
      convert(varchar, lo_fecha_inicio, 113)
   from ba_log    
   where lo_batch = @i_batch
          and lo_estatus = 'F'
   order by lo_fecha_inicio desc
   set rowcount 0
end
go
