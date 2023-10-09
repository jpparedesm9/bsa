/************************************************************************/
/* Archivo:                fcierre.sp                                   */
/* Stored procedure:       sp_fecha_cierre                              */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     09-julio-1996                                */
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
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento a las fechas de cierre de cada producto             */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*    FECHA          AUTOR            RAZON                             */
/*    09-Jul-1996    J. Arthos        Emision Inicial                   */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_fecha_cierre')
   drop proc sp_fecha_cierre

go
create proc sp_fecha_cierre   (
   @s_ssn               int = null,
   @s_date              datetime = null,
   @s_user              login = null,
   @s_term              descripcion = null,
   @s_corr              char(1) = null,
   @s_ssn_corr          int = null,
   @s_ofi               smallint = null,
   @t_rty               char(1) = null,
   @t_trn               smallint = 800,
   @t_debug             char(1) = 'N',
   @t_file              varchar(14) = null,
   @t_from              varchar(30) = null,
   @i_operacion         char(1),
   @i_producto          tinyint = null,
   @i_formato_fecha     tinyint = null,
   @i_fecha_cierre      datetime = null
)
as 
declare
   @w_today             datetime,      /* fecha del dia */
   @w_return            int,           /* valor que retorna */
   @w_sp_name           varchar(32),   /* descripcion del stored procedure*/
   @w_fecha_cierre      datetime,
   @w_fecha_proceso     datetime    
   
select @w_today = getdate()
select @w_sp_name = 'sp_fecha_cierre'

if (@t_trn <> 8081 and @t_trn <> 8082)
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801077
   return 1
end


if @i_operacion = 'S'
begin
   select   'No.'       = pd_producto,
            'Producto'  = substring(pd_descripcion,1,50),
            'Fecha'     = convert(varchar(10),fc_fecha_cierre,@i_formato_fecha)
     from cobis..cl_producto, cobis..ba_fecha_cierre
   where pd_producto = fc_producto
   order by pd_producto 
   return 0
end

if @i_operacion = 'U'
begin
   if (@i_producto is null)
   begin
      /* Codigo de Producto no enviado*/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 807047
      return 1
   end
   if exists (select 1
         from  ba_sarta,
               ba_corrida
         where sa_producto = @i_producto
         and   co_sarta = sa_sarta
         and   co_estado in ('E', 'G', 'P', 'R', 'F'))
   begin
   /* Existen lotes activos */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 808051
      return 1      
   end
   
   select @w_fecha_proceso = fp_fecha
     from cobis..ba_fecha_proceso
   
   if @i_fecha_cierre < @w_fecha_proceso
   begin
   /* Fecha de Cierre inferior a la Fecha de Proceso Actual */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 808073
      return 1       
   end
   
   select @w_fecha_cierre = @i_fecha_cierre
   
   update cobis..ba_fecha_cierre
      set fc_fecha_cierre = @w_fecha_cierre
    where fc_producto = @i_producto
   return 0
end

if @i_operacion = 'A'
begin
   if exists (select 1
         from  ba_sarta,
               ba_corrida
         where co_sarta = sa_sarta
         and   co_estado in ('E', 'G', 'P', 'R', 'F'))
   begin
   /* Existen lotes activos */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 808051
      return 1      
   end
   
   select @w_fecha_proceso = fp_fecha
     from cobis..ba_fecha_proceso
   
   if @i_fecha_cierre < @w_fecha_proceso
   begin
   /* Fecha de Cierre inferior a la Fecha de Proceso Actual */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 808073
      return 1       
   end
   
   select @w_fecha_cierre = @i_fecha_cierre
   
   update cobis..ba_fecha_cierre
      set fc_fecha_cierre = @w_fecha_cierre
   return 0
end

return 1
go
