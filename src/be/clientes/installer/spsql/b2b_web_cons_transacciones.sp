use cobis
go

if exists (select 1 from sysobjects where name = 'sp_b2b_web_cons_transacciones')
   drop proc sp_b2b_web_cons_transacciones
go

create proc [dbo].[sp_b2b_web_cons_transacciones]   (
    @i_param1             login           = null,
    @i_param2             datetime        = null,
    @i_param3             datetime        = null,
    @i_flag_test          char(1)         = 'N' 
)
as  
declare
@w_error                int             ,
@w_msg                  varchar(300)    ,
@w_fecha_proceso        datetime        ,
@w_sp_name              varchar(32)     ,
@w_fecha_desde          datetime        ,
@w_fecha_hasta          datetime        ,
@w_nombre_reporte       varchar(64)     ,
@w_errores              varchar(255)    ,
@w_cmd                  varchar(5000)   ,
@w_batch                int             ,
@w_buc                  int             ,
@w_comando              varchar(6000)   ,
@w_s_app                varchar(255)    ,
@w_path                 varchar(255)    ,
@w_destino              varchar(255)    ,
@w_destino2             varchar(255)    ,
@w_fecha                datetime        ,
@w_cabecera             varchar(5000)   ,
@w_lineas               varchar(10),
@w_tipo_aux             char(1),
@w_clase                char(1),
@w_canal                varchar(4),
@w_pais                 int,
@w_municipio            int,
@w_ciudad               int,
@w_estado               int,
@w_colonia              int,
@w_codpostal            varchar(10),
@w_calle                varchar(255),
@w_tipo_prop            varchar(20),
@w_rural_urbano         char(2),
@w_usuario              login,
@w_nro                  int,
@w_nro_interno          int,
@w_tiempo_reside        int,
@w_poblacion            varchar(50),
@w_referencia           varchar(255),
@w_nro_residentes       int,
@w_descripcion          varchar(255),
@w_latitud_seg          float,
@w_longitud_seg         float,
@w_valor                varchar(20),
@w_tipo                 char(1),
@w_codarea              varchar(20),
@w_pais_1               int,
@w_municipio_1          int,
@w_ciudad_1             int,
@w_estado_1             int,
@w_colonia_1            int,
@w_codpostal_1          varchar(10),
@w_calle_1              varchar(255),
@w_tipo_prop_1          varchar(20),
@w_rural_urbano_1       char(2),
@w_nro_1                int,
@w_nro_interno_1        int,
@w_tiempo_reside_1      int,
@w_poblacion_1          varchar(50),
@w_referencia_1         varchar(255),
@w_nro_residentes_1     int,
@w_descripcion_1        varchar(255),
@w_latitud_seg_1        float,
@w_longitud_seg_1       float,
@w_valor_1              varchar(20),
@w_tipo_1               char(1),
@w_codarea_1            varchar(20),
@w_nombre               varchar(255),
@w_fecha_apertura       datetime,
@w_actividad_ec         varchar(10),
@w_tipo_local           int,
@w_tiempo_actividad     int,
@w_tiempo_dom_neg       int,
@w_emprendedor          char(1),
@w_recurso              varchar(2),
@w_ingreso_mensual      money,
@w_destino_credito      varchar(2),
@w_operacion            char(1),
@w_estado_reg           char(1),
@w_secuencial           int = 0,
@w_id                   int = 0,
@w_ente                 int = 0,
@w_hora                 datetime,
@w_nombre_1             varchar(255),
@w_fecha_apertura_1     datetime,
@w_actividad_ec_1       varchar(10),
@w_tipo_local_1         int,
@w_tiempo_actividad_1   int,
@w_tiempo_dom_neg_1     int,
@w_emprendedor_1        char(1),
@w_recurso_1            varchar(2),
@w_ingreso_mensual_1    money,
@w_destino_credito_1    varchar(2),
@w_counter              int,
@w_num_dir              int,
@w_num_correo           int,
@w_num_dir_geo          int,
@w_num_neg              int,
@w_num_tel              int,
@w_ffecha               int


create table #b2b_web_tran_servicio (
   id               int identity(1,1),
   secuencial       int,
   cliente          int,
   fecha            datetime,
   hora             datetime,
   tipo             varchar(30)
)

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select  
@w_sp_name = 'sp_b2b_web_cons_transacciones', 
@w_batch   = 3,
@w_ffecha  = 103
		
print  @w_sp_name

select @w_fecha_hasta = isnull(@i_param3, convert(varchar(10), @w_fecha_proceso, 23))
select @w_fecha_desde = isnull(@i_param2, convert(DATE, dateadd(mm,-1, convert(datetime, @w_fecha_hasta))))
select @w_usuario     = case when @i_param1 is null or ltrim(rtrim(@i_param1)) = '' then null when upper(@i_param1) = 'NULL' then null else @i_param1 end

print '@w_fecha_hasta:'+convert(varchar, @w_fecha_hasta)
print '@w_fecha_desde:'+convert(varchar, @w_fecha_desde)
print '@w_usuario:'+@w_usuario

if exists(select 1 from cl_temp_tran_servicio) truncate table cl_temp_tran_servicio

insert into cl_temp_tran_servicio
values('SECUENCIAL','ID CLIENTE','BUC',
'FECHA','HORA','TIPO DE TRANSACCION',
'USUARIO','CAMPO MODIFICADO', 'CANAL')

--Se define universo de transacciones en tablas temporales
select identity(int) as id, * into #ts_direccion
from  ts_direccion
where (@w_usuario is null or (@w_usuario is not null and usuario = @w_usuario))
and   fecha between @w_fecha_desde and @w_fecha_hasta
and   (tipo is null or tipo  <> 'CE')

select identity(int) as id, * into #ts_correo
from  ts_direccion
where (@w_usuario is null or (@w_usuario is not null and usuario = @w_usuario))
and   fecha between @w_fecha_desde and @w_fecha_hasta
and    tipo  = 'CE'

select identity(int) as id,* into #ts_direccion_geo
from  ts_direccion_geo
where (@w_usuario is null or (@w_usuario is not null and usuario = @w_usuario))
and   fecha between @w_fecha_desde and @w_fecha_hasta

select identity(int) as id,* into #ts_telefono
from ts_telefono
where (@w_usuario is null or (@w_usuario is not null and usuario = @w_usuario)) 
and   fecha between @w_fecha_desde and @w_fecha_hasta

select identity(int) as id,* into #ts_negocio_cliente
from  ts_negocio_cliente
where (@w_usuario is null or (@w_usuario is not null and ts_usuario = @w_usuario))
and   ts_fecha_proceso between @w_fecha_desde and @w_fecha_hasta

create index ix_ts_direccion_1 on #ts_direccion (secuencial, ente, fecha, hora, clase )
create index ix_ts_direccion_2 on #ts_direccion (id)
create index ix_ts_correo_1 on #ts_correo (secuencial, ente, fecha, hora, clase)
create index ix_ts_correo_2 on #ts_correo (id)
create index ix_ts_direccion_geo_1 on #ts_direccion_geo (secuencia, ente, fecha, hora, clase)
create index ix_ts_direccion_geo_2 on #ts_direccion_geo (id)
create index ix_ts_telefono_1 on #ts_telefono (secuencial, ente, fecha, hora, clase)
create index ix_ts_telefono_2 on #ts_telefono (id)
create index ix_ts_negocio_cliente_1 on #ts_negocio_cliente ( ts_secuencial, ts_ente, ts_fecha_proceso, ts_hora, ts_operacion)   
create index ix_ts_negocio_cliente_2 on #ts_negocio_cliente ( id)  

if  not exists (select 1 from #ts_direccion) and not exists(select 1 from #ts_direccion_geo) 
and not exists (select 1 from #ts_telefono)  and not exists (select 1 from #ts_negocio_cliente)  
and not exists (select 1 from #ts_correo) begin
   print 'ADVERTENCIA: NO EXISTEN REGISTROS PARA REALIZAR LA TRANSACCION.'
   return 0
end

print 'INICIA TRANSACCIONES DIRECCIÓN'

select 
@w_id             = 0, 
@w_secuencial     = 0,
@w_ente           = 0,  
@w_fecha          = null,
@w_hora           = null,
@w_counter        = 1

select @w_num_dir = count(1) from #ts_direccion

print 'NÚMERO REGISTROS DIRECCIÓN: '+convert(varchar, @w_num_dir)
while @w_counter <= @w_num_dir begin
   
   select 
   @w_pais           = null,
   @w_municipio      = null,
   @w_ciudad         = null,
   @w_estado         = null,
   @w_colonia        = null,
   @w_codpostal      = null,
   @w_calle          = null,
   @w_clase          = null,
   @w_tipo_prop      = null,
   @w_rural_urbano   = null,
   @w_usuario        = null,
   @w_canal          = null,
   @w_nro            = null,
   @w_nro_interno    = null,
   @w_tiempo_reside  = null,
   @w_poblacion      = null,
   @w_referencia     = null,
   @w_nro_residentes = null,
   @w_descripcion    = null
   
   select 
   @w_id             = id,
   @w_secuencial     = secuencial,
   @w_ente           = ente,
   @w_fecha          = fecha, 
   @w_hora           = hora,
   @w_pais           = pais,
   @w_municipio      = ciudad,   
   @w_estado         = provincia,
   @w_colonia        = parroquia,
   @w_codpostal      = codpostal,
   @w_calle          = calle,   
   @w_clase          = clase, 
   @w_tipo_prop      = tipo_prop,
   @w_rural_urbano   = rural_urbano,
   @w_usuario        = usuario,
   @w_canal          = canal,
   @w_nro            = nro,
   @w_nro_interno    = nro_interno,
   @w_tiempo_reside  = reside,
   @w_poblacion      = poblacion,
   @w_referencia     = referencia,
   @w_nro_residentes = nro_residentes,
   @w_descripcion    = descripcion,
   @w_canal          = canal
   from #ts_direccion
   where id          = @w_counter 
   
   if @w_clase = 'N' begin
      insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'I', @w_usuario, 'TODOS DIRECCIÓN', @w_canal)
   end else if @w_clase = 'A' begin
   
      select 
	  @w_pais_1           = pais,
      @w_municipio_1      = ciudad,   
      @w_estado_1         = provincia,
      @w_colonia_1        = parroquia,
      @w_codpostal_1      = codpostal,
      @w_calle_1          = calle,  
      @w_tipo_prop_1      = tipo_prop,
      @w_rural_urbano_1   = rural_urbano,
      @w_nro_1            = nro,
      @w_nro_interno_1    = nro_interno,
      @w_tiempo_reside_1  = reside,
      @w_poblacion_1      = poblacion,
      @w_referencia_1     = referencia,
      @w_nro_residentes_1 = nro_residentes,
      @w_descripcion_1    = descripcion
      from #ts_direccion
      where secuencial    = @w_secuencial
	  and   ente          = @w_ente
	  and   fecha         = @w_fecha
	  and   datediff(dd, hora, @w_hora ) = 0
	  and   clase         =  'P'
   
      if @w_pais <> @w_pais_1 begin
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'PAÍS', @w_canal)
	  end
	  if @w_estado <> @w_estado_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'ESTADO', @w_canal)
	  end
	  if @w_municipio <> @w_municipio_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'MUNICIPIO', @w_canal)
	  end
	  if @w_colonia <> @w_colonia_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'COLONIA', @w_canal)
	  end
      if @w_calle <> @w_calle_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'CALLE', @w_canal)
	  end
      if @w_tipo_prop <> @w_tipo_prop_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'TIPO DE VIVIENDA', @w_canal)
	  end
      if @w_codpostal <> @w_codpostal_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'CÓDIGO POSTAL', @w_canal)
	  end
      if @w_nro <> @w_nro_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'NÚMERO', @w_canal)
	  end
      if @w_nro_interno <> @w_nro_interno_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'NÚMERO INTERNO', @w_canal)
	  end
      if @w_tiempo_reside <> @w_tiempo_reside_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'AÑOS EN DOMICILIO ACTUAL', @w_canal)
	  end
	  if @w_poblacion <> @w_poblacion_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'CIUDAD/POBLACIÓN', @w_canal)
      end
	  if @w_referencia <> @w_referencia_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'REFERENCIA', @w_canal)
	  end
	  if @w_nro_residentes <> @w_nro_residentes_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'NO. DE PERSONAS VIVIENDO EN ESTE DOMICILIO', @w_canal)
	  end
	  if @w_descripcion <> @w_descripcion_1 begin
		 insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'DATOS COMPLEMENTARIOS DE LA DIRECCIÓN', @w_canal)
	  end
   end else if @w_clase = 'B' begin
	  insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'D', @w_usuario, 'TODOS DIRECCIÓN', @w_canal)
   end
   
   select @w_counter = @w_counter + 1

end

print 'TERMINA TRANSACCIONES DIRECCION'
print 'INICIA TRANSACCIONES GEOLOCALIZACION'

select 
@w_id         = 0, 
@w_secuencial = 0,
@w_ente       = 0,  
@w_fecha      = null,
@w_hora       = null,
@w_counter    = 1

select @w_num_dir_geo = count(1) from #ts_direccion_geo
 
print 'NÚMERO REGISTROS GEOLOCALIZACION:'+ convert(varchar, @w_num_dir_geo) 

while @w_counter <= @w_num_dir_geo begin
   
   select 
   @w_latitud_seg   = null, 
   @w_longitud_seg  = null,
   @w_canal         = null,
   @w_clase         = null,
   @w_usuario       = null
   
   select 
   @w_id            = id,
   @w_secuencial    = secuencia,
   @w_ente          = ente,
   @w_fecha         = fecha, 
   @w_hora          = hora,
   @w_latitud_seg   = latitud_segundos,
   @w_longitud_seg  = longitud_segundos,
   @w_canal         = canal,
   @w_clase         = clase,
   @w_usuario       = usuario  
   from #ts_direccion_geo
   where id         = @w_counter
        
       
   if @w_clase = 'N'  begin
	  insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'I', @w_usuario, 'TODOS GEOLOCALIZACIÓN', @w_canal)
   end 
   else if @w_clase = 'A' begin
      
	  select
	  @w_latitud_seg_1    = null,
	  @w_longitud_seg_1   = null
	  
      select
      @w_latitud_seg_1    = latitud_segundos,
      @w_longitud_seg_1   = longitud_segundos
      from #ts_direccion_geo
      where secuencia     = @w_secuencial
	  and   ente          = @w_ente
	  and   fecha         = @w_fecha
	  and   datediff(dd, hora, @w_hora ) = 0
	  and   clase         =  'P'
	  
      if @w_latitud_seg <> @w_latitud_seg_1 begin
         insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'LATITUD', @w_canal)
	  end
	  if @w_longitud_seg <> @w_longitud_seg_1 begin
         insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'LONGITUD', @w_canal)
	  end
   end 
   else if @w_clase = 'B' begin
      insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'D', @w_usuario, 'TODOS GEOLOCALIZACIÓN', @w_canal)
   end 
   
   select @w_counter = @w_counter + 1
   
end

print 'TERMINA TRANSACCIONES GEOLOCALIZACION'
print 'INICIA TRANSACCIONES CORREO'
select 
@w_id         = 0, 
@w_secuencial = 0,
@w_ente       = 0,  
@w_fecha      = null,
@w_hora       = null,
@w_counter    = 1

select @w_num_correo = count(1) from #ts_correo

print 'NÚMERO REGISTROS CORREO: '+convert(varchar, @w_num_correo)

while @w_counter <= @w_num_correo begin

   select 
   @w_descripcion  = null, 
   @w_canal        = null,
   @w_clase        = null,
   @w_usuario      = null

   select 
   @w_id            = id,
   @w_secuencial    = secuencial,
   @w_ente          = ente,
   @w_fecha         = fecha, 
   @w_hora          = hora,
   @w_descripcion   = descripcion,
   @w_canal         = canal,
   @w_clase         = clase,
   @w_usuario       = usuario    
   from #ts_correo
   where id         = @w_counter
         
   if @w_clase = 'N'  begin
       insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'I', @w_usuario, 'DIRECCIÓN VIRTUAL', @w_canal)
   end else if @w_clase = 'A' begin
   
      select @w_descripcion_1 = null
   
      select
      @w_descripcion_1    = descripcion   
      from #ts_correo
	  where secuencial    = @w_secuencial
	  and   ente          = @w_ente
	  and   fecha         = @w_fecha
	  and   datediff(dd, hora, @w_hora ) = 0
	  and   clase         =  'P'
	  
	  if @w_descripcion <> @w_descripcion_1 begin
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'DIRECCIÓN VIRTUAL', @w_canal)
      end 
	  
   end else if @w_clase = 'B' begin
      insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'D', @w_usuario, 'DIRECCIÓN VIRTUAL', @w_canal)
   end  
   
   select @w_counter = @w_counter + 1
end 

print 'TERMINA TRANSACCIONES CORREO'

print 'INICIA TRANSACCIONES TELEFONO'

print 5
select 
@w_id         = 0, 
@w_secuencial = 0,
@w_ente       = 0,  
@w_fecha      = null,
@w_hora       = null,
@w_counter    = 1

select @w_num_tel = count(1) from #ts_telefono
print 'NUMERO REGISTROS TELÉFONO: '+convert(varchar, @w_num_tel)

while @w_counter <= @w_num_tel begin

   select
   @w_valor         = null,
   @w_tipo          = null,
   @w_codarea       = null,
   @w_canal         = null,
   @w_clase         = null,
   @w_usuario       = null

   select
   @w_id            = id,
   @w_secuencial    = secuencial,
   @w_ente          = ente,
   @w_fecha         = fecha, 
   @w_hora          = hora,
   @w_valor         = valor,
   @w_tipo          = tipo,
   @w_codarea       = codarea,
   @w_canal         = canal,
   @w_clase         = clase,
   @w_usuario       = usuario    
   from #ts_telefono
   where id         = @w_counter
   
   --print 'TEL:'+convert(varchar, @w_id)
         
   if @w_clase = 'N'  begin
	  insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23) , convert(varchar(10),@w_hora, 108), 'I', @w_usuario, 'TODOS TELÉFONO', @w_canal)
   end else if @w_clase = 'A' begin
      
	  select 
	  @w_valor_1          = null,
	  @w_tipo_1           = null,
	  @w_codarea_1        = null
	  
      select 
	  @w_valor_1          = valor,
      @w_tipo_1           = tipo,
      @w_codarea_1        = codarea
      from #ts_telefono
	  where secuencial    = @w_secuencial
	  and   ente          = @w_ente
	  and   fecha         = @w_fecha
	  and   datediff(dd, hora, @w_hora ) = 0
	  and   clase         =  'P'
	  
      if @w_valor <> @w_valor_1 begin
         insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'NÚMERO DE TELÉFONO', @w_canal)
	  end
	  if @w_tipo <> @w_tipo_1 begin
         insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'TIPO TELÉFONO', @w_canal)
	  end
	  if @w_codarea <> @w_codarea_1 begin
         insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'CÓDIGO DE ÁREA', @w_canal)
	  end
   end else if @w_clase = 'B' begin
      insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'D', @w_usuario, 'TODOS TELÉFONO', @w_canal)
   end
   
   select @w_counter = @w_counter + 1
   
end

print 'TERMINA TRANSACCIONES TELÉFONO'

print 'INICIA TRANSACCIONES NEGOCIO'

select 
@w_id         = 0, 
@w_secuencial = 0,
@w_ente       = 0,  
@w_fecha      = null,
@w_hora       = null,
@w_counter    = 1

select @w_num_neg = count(1) from #ts_negocio_cliente
print 'NÚMERO REGISTROS NEGOCIO: '+convert(varchar, @w_num_neg)

while @w_counter <= @w_num_neg  begin

   select
   @w_nombre              = null,
   @w_fecha_apertura      = null,
   @w_actividad_ec        = null,
   @w_tipo_local          = null,
   @w_tiempo_actividad    = null,
   @w_tiempo_dom_neg      = null,
   @w_emprendedor         = null,
   @w_recurso             = null,
   @w_ingreso_mensual     = null,
   @w_destino_credito     = null,
   @w_operacion           = null,
   @w_usuario             = null,
   @w_canal               = null

   select 
   @w_id                  = id,
   @w_secuencial          = ts_secuencial,
   @w_ente                = ts_ente,
   @w_fecha               = ts_fecha_proceso, 
   @w_hora                = ts_hora,
   @w_nombre              = ts_nombre,
   @w_fecha_apertura      = ts_fecha_apertura,
   @w_actividad_ec        = ts_actividad_ec,
   @w_tipo_local          = ts_tipo_local,
   @w_tiempo_actividad    = ts_tiempo_actividad,
   @w_tiempo_dom_neg      = ts_tiempo_dom_neg,
   @w_emprendedor         = ts_emprendedor,
   @w_recurso             = ts_recurso,
   @w_ingreso_mensual     = ts_ingreso_mensual,   
   @w_destino_credito     = ts_destino_credito,
   @w_operacion           = ts_operacion,
   @w_estado_reg          = ts_estado_reg,
   @w_usuario             = ts_usuario,
   @w_canal               = ts_canal
   from #ts_negocio_cliente 
   where id               = @w_counter

   --print 'NEG:'+convert(varchar, @w_id) 
      
   if @w_operacion = 'I'  begin
	  insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'I', @w_usuario, 'TODOS NEGOCIO', @w_canal)
   end else if @w_operacion = 'A' begin
      
	  select
	  @w_nombre_1              = null,
	  @w_fecha_apertura_1      = null,
      @w_actividad_ec_1        = null,
      @w_tipo_local_1          = null,
      @w_tiempo_actividad_1    = null,
      @w_tiempo_dom_neg_1      = null,
      @w_emprendedor_1         = null,
      @w_recurso_1             = null,
      @w_ingreso_mensual_1     = null,
      @w_destino_credito_1     = null     
	  
	  select
	  @w_nombre_1                          = ts_nombre,
	  @w_fecha_apertura_1                  = ts_fecha_apertura,
	  @w_actividad_ec_1                    = ts_actividad_ec,
	  @w_tipo_local_1                      = ts_tipo_local,
      @w_tiempo_actividad_1                = ts_tiempo_actividad,
      @w_tiempo_dom_neg_1                  = ts_tiempo_dom_neg,
      @w_emprendedor_1                     = ts_emprendedor,
      @w_recurso_1                         = ts_recurso,
      @w_ingreso_mensual_1                 = ts_ingreso_mensual, 
      @w_destino_credito_1                 = ts_destino_credito
      from #ts_negocio_cliente 
	  where ts_secuencial                  = @w_secuencial
      and   ts_ente                        = @w_ente
      and   ts_fecha_proceso               = @w_fecha
      and   datediff(dd, ts_hora, @w_hora) = 0
	  and   ts_operacion                   = 'D'
	  and   ts_estado_reg                  = 'V'
	  
	  if @w_nombre <> @w_nombre_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'NOMBRE DEL NEGOCIO', @w_canal)
	  end	
	  if datediff(dd, @w_fecha_apertura,  @w_fecha_apertura_1) <> 0 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'FECHA DE APERTURA', @w_canal)
	  end
	  if @w_actividad_ec <> @w_actividad_ec_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'ACTIVIDAD ECONÓMICA', @w_canal)
	  end
	  if @w_tipo_local <> @w_tipo_local_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'TIPO DE LOCAL', @w_canal)
	  end
	  if @w_tiempo_actividad <> @w_tiempo_actividad_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'TIEMPO DESEMPEÑANDO LA ACTIVIDAD (AÑOS)', @w_canal)
	  end
	  if @w_tiempo_dom_neg <> @w_tiempo_dom_neg_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'TIEMPO DE ARRAIGO DEL NEGOCIO (AÑOS)', @w_canal)
	  end
	  if @w_emprendedor <> @w_emprendedor_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, '¿ES EMPRENDEDOR?', @w_canal)
	  end
	  if @w_recurso <> @w_recurso_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, '¿CON QUE RECURSOS PAGARÁ EL CRÉDITO?', @w_canal)
	  end
	  if @w_destino_credito <> @w_destino_credito_1 begin 
	     insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'U', @w_usuario, 'DESTINO DEL CRÉDITO', @w_canal)
	  end
	  
   end else if @w_operacion = 'D' and @w_estado_reg = 'E' begin
      insert into cl_temp_tran_servicio values (@w_secuencial, convert(varchar, @w_ente), null, convert(varchar(10), @w_fecha, 23), convert(varchar(10),@w_hora,108), 'D', @w_usuario, 'TODOS NEGOCIO', @w_canal)
   end
   
   select @w_counter = @w_counter + 1
   
end

print 'TERMINA TRANSACCIONES NEGOCIO'


update cl_temp_tran_servicio set
tts_buc = en_banco 
from cobis..cl_ente 
where tts_cliente = en_ente 
and   tts_cliente <> 'ID CLIENTE'

----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'S_APP'

select 
@w_path           = ba_path_destino,
@w_nombre_reporte = ba_arch_resultado 
from cobis..ba_batch
where ba_batch    = 5100

if (@@error <> 0 or @@rowcount = 0) begin
   select   @w_msg = 'NO EXISTE RUTA PATH DESTINO',
            @w_error    = 1
   goto ERROR_FIN
end

PRINT @w_path
PRINT @w_nombre_reporte

if(@i_flag_test = 'N') begin 
   select @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_temp_tran_servicio out '
   
   select 
   @w_destino  = @w_path + @w_nombre_reporte + '_' + replace(CONVERT(varchar(10), @w_fecha_desde, @w_ffecha),'/', '')+ '_a_' + replace(CONVERT(varchar(10), @w_fecha_hasta, @w_ffecha),'/', '')+'.txt',
   @w_errores  = @w_path + @w_nombre_reporte + '_' + replace(CONVERT(varchar(10), @w_fecha_desde, @w_ffecha),'/', '')+ '_a_' + replace(CONVERT(varchar(10), @w_fecha_hasta, @w_ffecha),'/', '')+'.err'
   
   select @w_comando = @w_cmd + @w_destino+ ' -b5000 -w -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
    
   print @w_comando
   exec @w_error = xp_cmdshell @w_comando, no_output

   if @w_error <> 0 begin
       print @w_error
       select  @w_error = 1,
               @w_msg  = 'Error generando Reporte Log B2B WEB'
       goto ERROR_FIN
   end
end
else begin 
   select @w_nombre_reporte = @w_nombre_reporte + '_' + replace(CONVERT(varchar(10), @w_fecha_desde, @w_ffecha),'/', '')+ '_a_' + replace(CONVERT(varchar(10), @w_fecha_hasta, @w_ffecha),'/', '')+'.txt'
   
   select @w_comando = 
   'exec xp_cmdshell ' + CHAR(39)
   + 'bcp "select    
   concat(tts_secuencial      , char(9)),
   concat(tts_cliente         , char(9)),
   concat(tts_buc             , char(9)),
   concat(tts_fecha           , char(9)),
   concat(tts_hora            , char(9)),
   concat(tts_tipo_transaccion, char(9)),
   concat(tts_usuario         , char(9)),
   concat(tts_campo_modificado, char(9)),
   concat(tts_canal           , char(9))  
   from cobis..cl_temp_tran_servicio" queryout "'
   + @w_path
   + 'replogb2bweb_' + @w_nombre_reporte + '.txt"' + ' -b5000 -c -T -e,' 
   + CHAR(39) 
   + ', no_output'
   EXEC (@w_comando)

    if @w_error <> 0 begin
        select  @w_error = 1,
                @w_msg  = 'Error generando Reporte Log B2B WEB'
        goto ERROR_FIN
    end
end
return 0

ERROR_FIN:
    exec cobis..sp_cerror
        @i_num = @w_error,
        @i_msg = @w_msg
    return @w_error
go
