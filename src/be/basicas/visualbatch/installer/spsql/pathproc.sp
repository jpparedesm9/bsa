/************************************************************************/
/* Archivo:                pathproc.sp                                  */
/* Stored procedure:       sp_pathproc                                  */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     17-Octubre-2002                              */
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
/*    Mantenimiento de la tabla ba_path_pro                             */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    17-Oct-2002    D. Ayala        Emision Inicial                    */
/*    20-Ago-2005    J. Hidalgo      Actualizacion ba_path_fuente,	*/
/*                                   ba_path_destino, ba_serv_destino	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_pathproc')
   drop proc sp_pathproc

go
create proc sp_pathproc (
   @s_ssn      int = null,
   @s_date     datetime = null,
   @s_user     login = null,
   @s_term     descripcion = null,
   @s_corr     char(1) = null,
   @s_ssn_corr    int = null, 
   @s_ofi      smallint = null, 
   @s_srv      varchar(30) = null,
   @t_rty            char(1) = null, 
   @t_trn      smallint = 800,
   @t_debug    char(1) = 'N',
   @t_file     varchar(14) = null,
   @t_from     varchar(30) = null,
   @i_operacion   char(1),
   @i_producto    tinyint = null,
   @i_path_fuente varchar(255) = null,
   @i_path_destino   varchar(255) = null
)
as 
declare
   @w_today    datetime,      /* fecha del dia */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_producto tinyint,
   @w_path_fuente varchar(255),
   @w_path_destino   varchar(255)


select   @w_today = getdate(),
   @w_sp_name = 'sp_pathproc'

if (@t_trn <> 8101 and @i_operacion = 'S') or
   (@t_trn <> 8101 and @i_operacion = 'A') or
   (@t_trn <> 8102 and @i_operacion = 'U')
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
   -- Validar si existen registros en cl_producto
   -- que no estan en ba_path_pro
   select   pd_producto
   into  #producto
   from  cl_producto
   where    pd_producto not in (select pp_producto
                  from ba_path_pro)

   DECLARE cur_producto CURSOR FOR
   select   pd_producto
   from  #producto

   OPEN cur_producto
   FETCH cur_producto INTO
   @w_producto
   
   WHILE @@fetch_status != -1
   begin
      if (@@fetch_status = -2)
         begin
                /* Error en recuperacion de datos del cursor */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 2101015
          CLOSE cur_producto
          deallocate  cur_producto
                return 1
         end
      
      -- Insertar en tabla ba_path_pro el nuevo registro de producto
      insert into ba_path_pro values (@w_producto, null, null)

      if (@@fetch_status = -2)
         begin
            /* Error en inserción de registro */
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                     @t_file  = @t_file,
                  @t_from  = @w_sp_name,
         @i_msg   = 'Error en el registro de un nuevo producto en definición de paths por defecto',
                  @i_num   = 805016
         CLOSE cur_producto
         deallocate  cur_producto
            return 1
         end

      FETCH cur_producto INTO
      @w_producto    

   end   /* FIN WHILE */

   CLOSE cur_producto
   deallocate  cur_producto

   -- Retornar al Front End contenido de ba_path_pro
   select   'PRODUCTO'  = pp_producto,
      'DESCRIPCION'  = pd_descripcion,
      'PATH EJECUCION'= pp_path_fuente,
      'PATH DESTINO' = pp_path_destino
   from  ba_path_pro,
      cl_producto
   where pp_producto = pd_producto
   
end

if @i_operacion = 'U'
begin
   /*  Actulizar path fuente y path destino */
   update ba_path_pro
   set   pp_path_fuente = @i_path_fuente,
      pp_path_destino = @i_path_destino
   where pp_producto = @i_producto  

   if (@@fetch_status = -2)
      begin
      /* Error en recuperacion de datos del cursor */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 805016
         return 1
      end

   /*  Actulizar path fuente y servidor */
   /*  de todos los batch del producto */
   update ba_batch
   set ba_path_fuente = @i_path_fuente,
	ba_serv_destino = @s_srv
	where ba_producto = @i_producto

   if (@@fetch_status = -2)
      begin
      /* Error en la actualizacion del path fuente */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 807048
         return 1
      end

   /*  Actulizar path destino */
   /*  de los reportes del producto */
   update ba_batch
   set ba_path_destino = @i_path_destino
	where ba_producto = @i_producto
	and ba_tipo_batch = 'R'

   if (@@fetch_status = -2)
      begin
      /* Error en la actualizacion del path destino */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 807049
         return 1
      end
end

if @i_operacion = 'V'
begin
   /* Validar path del producto */
   select   pp_path_fuente,
      pp_path_destino 
   from  ba_path_pro
   where pp_producto = @i_producto
   
   if (@@rowcount = 0)
      begin
      /* Error en recuperacion de datos del cursor */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 805016
         return 1
      end
end

return 0
go


