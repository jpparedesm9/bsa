/* ********************************************************************* */
/*      Archivo:                sp_direccion_geo.sp                      */
/*      Stored procedure:       sp_direccion_geo                         */
/*      Base de datos:          cob_pac                                  */
/*      Producto:               Credito                                  */
/*      Disenado por:           Adriana Chiluisa                         */
/*      Fecha de escritura:     30-May-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Este programa procesa las transacciones del stored procedure     */
/*      Inserta actualiza y consulta información para verificación       */
/*      datos                                                            */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      30/05/2017                           Version Inicial             */
/*      24/07/2019      ACHP                 Valid para geo ref-cabecera */
/*      13/09/2021      KVI              Req. 123670 reporte mod. datos  */
/* ********************************************************************* */
use cobis
go
if not object_id('sp_direccion_geo') is null
   drop proc sp_direccion_geo
go
create procedure sp_direccion_geo (
   @s_ssn                int           = NULL,
   @s_user               login         = NULL,
   @s_sesn               int           = NULL,
   @s_culture            varchar(10)   = null,
   @s_term               varchar(32)   = NULL,
   @s_date               datetime      = NULL,
   @s_srv                varchar(30)   = NULL,
   @s_lsrv               varchar(30)   = NULL, 
   @s_rol                smallint      = NULL,
   @s_ofi                smallint      = NULL,
   @s_org_err            char(1)       = NULL,
   @s_error              int           = NULL,
   @s_sev                tinyint       = NULL,
   @s_msg                descripcion   = NULL,
   @s_org                char(1)       = NULL,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(32)   = null,
   @t_trn                smallint      = NULL,
   @t_show_version       bit           = 0,
   @i_operacion          varchar(2),
   @i_ente               int           = null, -- Codigo cliente
   @i_direccion          tinyint       = null, -- Codigo de la direccion que se asigna al Cliente
   -- DATOS GEOREFERENCIACION
   @i_lat_coord          char(1)       = null,
   @i_lat_grados         tinyint       = null,
   @i_lat_minutos        tinyint       = null,
   @i_lat_segundos       float         = null,
   @i_lon_coord          char(1)       = null,
   @i_lon_grados         tinyint       = null,
   @i_lon_minutos        tinyint       = null,
   @i_lon_segundos       float         = null,
   @i_path_croquis       varchar(50)   = null,
   @o_secuencial         int           = null out,
   @i_canal              varchar(4)    = null
)
as
declare @w_today    datetime,
   @w_sp_name            varchar(32),
   @w_codigo             int,
   @w_ente               int,
   @w_direccion          tinyint,
   @v_ente               int,
   @v_direccion          tinyint, 
   -- TRABAJO DATOS GEOREFERENCIACION
   @w_lat_coord          char(1),
   @w_lat_grados         tinyint,
   @w_lat_minutos        tinyint,
   @w_lat_segundos       float,
   @w_lon_coord          char(1),
   @w_lon_grados         tinyint,
   @w_lon_minutos        tinyint,
   @w_lon_segundos       float,
   @w_path_croquis       varchar(50),
   -- VISTA DATOS GEOREFERENCIACION
   @v_lat_coord          char(1),
   @v_lat_grados         tinyint,
   @v_lat_minutos        tinyint,
   @v_lat_segundos       float,
   @v_lon_coord          char(1),
   @v_lon_grados         tinyint,
   @v_lon_minutos        tinyint,
   @v_lon_segundos       float,
   @v_path_croquis       varchar(50)
   -- FIN VISTA
 
select   
   @w_today   = @s_date,
   @w_sp_name = 'sp_direccion_geo_dml'

if @t_show_version = 1
begin
    print 'Stored procedure %1! Version 1.0.0.2'
    return 0
end

-- OPERACION G
-- QUERY ESPECIFICO DE DATOS DE GEOREFERENCIACION
if @i_operacion='G'
   begin
      if @t_trn = 1607 
         begin
            select 
               'LAT. COORD'  = dg_lat_coord,
               'LAT. GRADOS' = dg_lat_grad,
               'LAT. MINUT'  = dg_lat_min,
               'LAT. SEG'    = dg_lat_seg,
               'LON. COORD'  = dg_long_coord,
               'LON. GRAD'   = dg_long_grad,
               'LON. MIN'    = dg_long_min,
               'LON. SEG'    = dg_long_seg,
               'CROQUIS'     = dg_path_croquis
            from cl_direccion_geo
            where dg_ente      = @i_ente
            and   dg_direccion = @i_direccion 

            if @@rowcount = 0
               begin
                 --NO EXISTE DATO SOLICITADO
                 exec sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 101001
                 return 1
               end
         end
      else
         begin
            exec sp_cerror
               --NO CORRESPONDE CODIGO DE TRANSACCION
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 151051
            return 1
         end
   end
else
-- INSERT Y UPDATE
if @i_operacion = 'I'
   begin
      if @t_trn = 1608 -- PENDIENTE
         begin
            -- VERIFICACION DE CLAVES FORANEAS       
            -- VERIFICACION SI EXISTE YA DATOS GEOR PARA LA DIRECCION ESPECIFICADA
            if exists(select 1 from cl_direccion_geo
                         where @i_ente      = dg_ente
                         and   @i_direccion = dg_direccion)
               begin

                  -- CARGANDO LOS DATOS ANTERIORES DE LA GEOREFERENCIACION
                  select 
                     @w_lat_coord    = dg_lat_coord,
                     @w_lat_grados   = dg_lat_grad,
                     @w_lat_minutos  = dg_lat_min,
                     @w_lat_segundos = dg_lat_seg,
                     @w_lon_coord    = dg_long_coord,
                     @w_lon_grados   = dg_long_grad,
                     @w_lon_minutos  = dg_long_min,
                     @w_lon_segundos = dg_long_seg,
                     @w_path_croquis = dg_path_croquis
                  from  cl_direccion_geo
                  where dg_ente      = @i_ente
                  and   dg_direccion = @i_direccion

                  --GUARDANDO LOS DATOS ANTERIORES
                  select 
                     @v_lat_coord    = @w_lat_coord,
                     @v_lat_grados   = @w_lat_grados,
                     @v_lat_minutos  = @w_lat_minutos,
                     @v_lat_segundos = @w_lat_segundos,
                     @v_lon_coord    = @w_lon_coord,
                     @v_lon_grados   = @w_lon_grados,
                     @v_lon_minutos  = @w_lon_minutos,
                     @v_lon_segundos = @w_lon_segundos,
                     @v_path_croquis = @w_path_croquis

                  -- VERIFICANDO CAMBIOS EN LOS CAMPOS
                  if @w_lat_coord = @i_lat_coord
                    select @w_lat_coord = null, @v_lat_coord = null
                  else
                    select @w_lat_coord = @i_lat_coord

                  if @w_lat_grados = @i_lat_grados
                    select @w_lat_grados = null, @v_lat_grados = null
                  else
                    select @w_lat_grados = @i_lat_grados

                  if @w_lat_minutos = @i_lat_minutos
                    select @w_lat_minutos = null, @v_lat_minutos = null
                  else
                    select @w_lat_minutos = @i_lat_minutos

                  if @w_lat_segundos = @i_lat_segundos
                    select @w_lat_segundos = null, @v_lat_segundos = null
                  else
                    select @w_lat_segundos = @i_lat_segundos

                  if @w_lon_coord = @i_lon_coord
                    select @w_lon_coord = null, @v_lon_coord = null
                  else
                    select @w_lon_coord = @i_lon_coord

                  if @w_lon_grados = @i_lon_grados
                    select @w_lon_grados = null, @v_lon_grados = null
                  else
                    select @w_lon_grados = @i_lon_grados

                  if @w_lon_minutos = @i_lon_minutos
                    select @w_lon_minutos = null, @v_lon_minutos = null
                  else
                    select @w_lon_minutos = @i_lon_minutos

                  if @w_lon_segundos = @i_lon_segundos
                    select @w_lon_segundos = null, @v_lon_segundos = null
                  else
                    select @w_lon_segundos = @i_lon_segundos

                  if @w_path_croquis = @i_path_croquis
                    select @w_path_croquis = null, @v_path_croquis = null
                  else
                    select @w_path_croquis = @i_path_croquis

                  begin tran
                     --SE ACTUALIZAN LOS DATOS
                     update  cl_direccion_geo 
                        set dg_ente           = @i_ente,
                            dg_direccion      = @i_direccion,
                            dg_lat_coord      = @i_lat_coord,
                            dg_lat_grad       = @i_lat_grados, 
                            dg_lat_min        = @i_lat_minutos,   
                            dg_lat_seg        = isnull(@i_lat_segundos, dg_lat_seg),
                            dg_long_coord     = @i_lon_coord,
                            dg_long_grad      = @i_lon_grados,
                            dg_long_min       = @i_lon_minutos,
                            dg_long_seg       = isnull(@i_lon_segundos, dg_long_seg),
                            dg_path_croquis   = isnull(@i_path_croquis, dg_path_croquis)
                        where dg_ente       = @i_ente
                        and   dg_direccion  = @i_direccion
                        
                       if @@error != 0
                          begin
                             exec sp_cerror
                                -- ERROR EN INGRESO DE DATOS DE GEOREFERENCIACION
                                @t_debug   = @t_debug,
                                @t_file      = @t_file,
                                @t_from      = @w_sp_name,
                                @i_num      = 107159
                             return 1
                           end

                    -- TRANSACCION DE SERVICIOS DATOS PREVIOS
                    insert into ts_direccion_geo (
                       secuencia,       tipo_transaccion, clase,            fecha,
                       oficina_s,       usuario,          terminal_s,       srv, 
                       lsrv,            hora,             ente,             direccion,
                       latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                       longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                       path_croquis,    canal,            rol)
                    values (
                       @s_ssn,          1608,            'P',               @s_date,
                       @s_ofi,          @s_user,          @s_term,          @s_srv, 
                       @s_lsrv,         getdate(),        @i_ente,          @i_direccion,
                       @v_lat_coord,    @v_lat_grados,    @v_lat_minutos,   @v_lat_segundos,
                       @v_lon_coord,    @v_lon_grados,    @v_lon_minutos,   @v_lon_segundos,
                       @v_path_croquis, @i_canal,         @s_rol)
               
                    if @@error <> 0
                       begin
                          -- 'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
                          exec sp_cerror
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 103005
                       return 1
                    end

                    -- TRANSACCION DE SERVICIOS DATOS ACTUALIZADOS
                    insert into ts_direccion_geo (
                       secuencia,       tipo_transaccion, clase,            fecha,
                       oficina_s,       usuario,          terminal_s,       srv, 
                       lsrv,            hora,             ente,             direccion,
                       latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                       longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                       path_croquis,    canal,            rol)
                    values (
                       @s_ssn,          1608,            'A',               @s_date,
                       @s_ofi,          @s_user,          @s_term,          @s_srv, 
                       @s_lsrv,         getdate(),        @i_ente,          @i_direccion,
                       @w_lat_coord,    @w_lat_grados,    @w_lat_minutos,   @w_lat_segundos,
                       @w_lon_coord,    @w_lon_grados,    @w_lon_minutos,   @w_lon_segundos,
                       @w_path_croquis, @i_canal,         @s_rol)
               
                    if @@error <> 0
                       begin
                          -- 'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
                          exec sp_cerror
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 103005
                       return 1
                    end

                       
                  commit tran
                  return 0
               end
            else
               begin
                  begin tran
                     -- INSERT cl_direccion_geo
                     --secuencial
                     exec sp_cseqnos
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_tabla    = 'cl_direccion_geo',
                          @o_siguiente= @o_secuencial out

                     insert into cl_direccion_geo 
                        (dg_ente,        dg_direccion,    dg_lat_coord,  dg_lat_grad, 
                        dg_lat_min,     dg_lat_seg,      dg_long_coord, dg_long_grad,
                        dg_long_min,    dg_long_seg,     dg_path_croquis, dg_secuencial)
                     values(@i_ente,        @i_direccion,    @i_lat_coord,  @i_lat_grados, 
                        @i_lat_minutos, @i_lat_segundos, @i_lon_coord,  @i_lon_grados,
                        @i_lon_minutos, @i_lon_segundos, @i_path_croquis,@o_secuencial)

                     if @@error != 0
                        begin
                           -- PENDIENTE
                           exec sp_cerror
                              -- 'ERROR EN CREACION DE PROVINCIA'
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_num   = 103043
                           return 1
                        end           

                     -- TRANSACCION DE SERVICIO     
                     -- VERIFICAR QUE EXISTA DIRECCION
                     select @w_lat_coord    = dg_lat_coord,
                        @w_lat_grados   = dg_lat_grad,
                        @w_lat_minutos  = dg_lat_min,
                        @w_lat_segundos = dg_lat_seg,
                        @w_lon_coord    = dg_long_coord,
                        @w_lon_grados   = dg_long_grad,
                        @w_lon_minutos  = dg_long_min,
                        @w_lon_segundos = dg_long_seg,
                        @w_path_croquis = dg_path_croquis
                     from  cl_direccion_geo
                     where dg_ente         = @i_ente
                     and   dg_direccion    = @i_direccion        

                     -- TRANSACCION DE SERVICIO CON DATOS NUEVOS
                    insert into ts_direccion_geo (
                       secuencia,       tipo_transaccion, clase,            fecha,
                       oficina_s,       usuario,          terminal_s,       srv, 
                       lsrv,            hora,             ente,             direccion,
                       latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                       longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                       path_croquis,    canal)
                    values (
                       @s_ssn,          1608,            'N',               @s_date,
                       @s_ofi,          @s_user,          @s_term,          @s_srv, 
                       @s_lsrv,         getdate(),        @i_ente,          @i_direccion,
                       @i_lat_coord,    @i_lat_grados,    @i_lat_minutos,   @i_lat_segundos,
                       @i_lon_coord,    @i_lon_grados,    @i_lon_minutos,   @i_lon_segundos,
                       @i_path_croquis, @i_canal)
               
                    if @@error <> 0
                       begin
                          -- 'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
                          exec sp_cerror
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = 103005
                       return 1
                    end
                  commit tran
                  return 0
               end
         end
      else
         begin
            exec sp_cerror
               -- 'NO CORRESPONDE CODIGO DE TRANSACCION'
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 151051
            return 1
         end
   end
else
 -- DELETE
if @i_operacion = 'D'
   begin
      if @t_trn = 1606 -- PENDIENTE
         begin
            -- VERIFICACION DE CLAVES FORANEAS     
            begin tran
               delete from cl_direccion_geo
               where @i_ente      = dg_ente
               and   @i_direccion = dg_direccion
            
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror 
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 107056  
                     return 1
                  end
               
               -- VERIFICAR QUE EXISTA DIRECCION
               select @w_lat_coord    = dg_lat_coord,
                  @w_lat_grados   = dg_lat_grad,
                  @w_lat_minutos  = dg_lat_min,
                  @w_lat_segundos = dg_lat_seg,
                  @w_lon_coord    = dg_long_coord,
                  @w_lon_grados   = dg_long_grad,
                  @w_lon_minutos  = dg_long_min,
                  @w_lon_segundos = dg_long_seg,
                  @w_path_croquis = dg_path_croquis
               from  cl_direccion_geo, cl_direccion, cl_ente
               where dg_ente         = di_ente
               and   dg_direccion    = di_direccion
               and   di_ente         = en_ente
                              
               -- TRANSACCION DE SERVICIO - DIRECCION                
               insert into ts_direccion_geo (
                  secuencia,       tipo_transaccion, clase,            fecha,
                  oficina_s,       usuario,          terminal_s,       srv, 
                  lsrv,            hora,             ente,             direccion,
                  latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                  longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                  path_croquis,    canal)
               values (
                  @s_ssn,          1606,            'B',               @s_date,
                  @s_ofi,          @s_user,          @s_term,          @s_srv, 
                  @s_lsrv,         getdate(),        @i_ente,          @i_direccion,
                  @w_lat_coord,    @w_lat_grados,    @w_lat_minutos,   @w_lat_segundos,
                  @w_lon_coord,    @w_lon_grados,    @w_lon_minutos,   @w_lon_segundos,
                  @w_path_croquis, @i_canal)
               
               if @@error <> 0
                  begin
                     -- 'ERROR EN CREACION DE TRANSACCION DE SERVICIO'
                     exec sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 103005
                     return 1
                  end
            commit tran         
            return 0
         end
   end
else
   begin
      exec sp_cerror
         -- 'NO CORRESPONDE CODIGO DE TRANSACCION'
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 151051
      return 1
   end

return 0

GO
--sp_procxmode 'dbo.sp_direccion_geo', 'Unchained'
--GO
