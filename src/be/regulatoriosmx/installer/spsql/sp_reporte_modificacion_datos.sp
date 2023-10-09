/************************************************************************/
/*   Archivo:                 sp_reporte_modificacion_datos.sp          */
/*   Stored procedure:        sp_reporte_modificacion_datos             */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Clientes                                  */
/*   Disenado por:            Karina Vizcaino                           */
/*   Fecha de Documentacion:  Septiembre 09 de 2021                     */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Generar reporte de modificacion de datos y archivo plano respectivo*/
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   Fecha      Nombre          Proposito                               */
/*   09/09/2021 KVI         Version Inicial                             */   
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_reporte_modificacion_datos') is null
   drop proc sp_reporte_modificacion_datos
go

create proc sp_reporte_modificacion_datos
   @i_param1            varchar(10),   --FECHA
   @i_param2            varchar(10),   --BATCH 28799
   @i_param3            varchar(10)    --FORMATO FECHA
as
declare 
   @w_s_app                varchar(255),
   @w_path                 varchar(255),
   @w_destino              varchar(255),
   @w_destino2             varchar(255),
   @w_errores              varchar(255),
   @w_cmd                  varchar(5000),
   @w_error                int,
   @w_comando              varchar(6000),
   @w_fecha                datetime,
   @w_batch                int,
   @w_columna              varchar(50),
   @w_col_id               int,
   @w_cabecera             varchar(5000),
   @w_anio                 char(4), 
   @w_fecha2               char(10),
   @w_fecha_desde          datetime,
   @w_lineas               varchar(10),
   @w_garhip               varchar(10),
   @w_garpre               varchar(10),
   @w_fp_usaid             varchar(30),
   @w_tabla                int,
   @w_estado_nota          char(1),
   @w_empresa              tinyint,
   @w_formato_fecha        int,
   @w_est_vencido          int,
   @w_est_vigente          int,
   @w_est_castigado        int,
   @w_grupo_act            int,
   @w_num_ciclo_ant        int,
   @w_resultado            int,
   @w_return               int,
   @w_fecha_provision      datetime,
   @w_codigo_act_apr       int ,
   @w_est_suspenso         int ,
   @w_ente_aux             int,
   @w_exp_credit           char(1),
   @w_referencia           varchar(20),
   @w_operacion            int,
   @w_fecha_vencimiento    datetime,
   @w_ciudad_nacional      int,
   @w_dia                  varchar(2),
   @w_mes                  varchar(2),
   @w_ano                  varchar(4),
   @w_ext_arch             varchar(6),
   @w_nom_arch             varchar(50),
   @w_nom_log              varchar(50),
   @w_fecha_default        datetime,
   @w_member_code          varchar(20),
   @w_dia_uno              varchar(10),
   @w_ultimo_dia           varchar(10),
   @w_fecha_diff           int, 
   @w_fecha_inicio         datetime,
   --Parametros Tabla #mod_datos_direccion
   @w_secuencial           int, 
   @w_tipo_transaccion     smallint, 
   @w_clase                char(1), 
   @w_fecha_mod            datetime, 
   @w_hora                 datetime, 
   @w_usuario              varchar(14),                 
   @w_ente                 int, 
   @w_direccion            int,
   @w_descripcion          varchar(64),
   @w_tipo                 varchar(10),
   @w_parroquia            int,
   @w_barrio               char(40),
   @w_principal            char(1),
   @w_canton               int,---
   @w_sector               varchar(10), 
   @w_vigencia             varchar(10),
   @w_oficina              smallint,
   @w_verificado           char(1), 
   @w_zona_ant             varchar(10),---
   @w_provincia            int,     
   @w_codpostal            varchar(24),
   @w_calle                varchar(20),        
   @w_casa                 varchar(20),
   @w_pais                 smallint,   
   @w_codbarrio            int,--
   @w_correspondencia      char(1),
   @w_alquilada            char(1),
   @w_cobro                char(1),
   @w_otrasenas            varchar(254),---
   @w_distrito             int,---
   @w_montoalquiler        money,---
   @w_edificio             varchar(254),
   @w_co_igual_so          char(1),---
   @w_rural_urbano         char(1),
   @w_departamento         varchar(10),
   @w_fact_serv_pu         char(1),
   @w_tipo_prop            char(10),    
   @w_ciudad               int,  
   @w_nombre_agencia       varchar(35),
   @w_fuente_verif         varchar(64), 
   @w_fecha_ver            datetime,
   @w_reside               int,
   @w_negocio	           int,---
   @w_poblacion            varchar(10), 
   @w_referencia_dir       varchar(255),
   @w_nro                  int,
   @w_nro_interno          int,   
   @w_nro_residentes       int,
   @w_canal                varchar(32),
   @w_zona                 varchar(10),
   @w_rol_user             smallint,
   @w_canal_web            varchar(32),
   --Parametros datos modificados direccion
   @w_tipo2                varchar(10),
   @w_tipo_prop2           char(10),
   @w_pais2                smallint,
   @w_codpostal2           varchar(24),
   @w_provincia2           int, 
   @w_ciudad2              int,
   @w_parroquia2           int,
   @w_poblacion2           varchar(10), 
   @w_calle2               varchar(20), 
   @w_nro2                 int,
   @w_nro_interno2         int, 
   @w_referencia_dir2      varchar(255),
   @w_reside2              int,  
   @w_nro_residentes2      int,   
   @w_descripcion2         varchar(64),
   @w_principal2           char(1),
   @w_correspondencia2     char(1),
   @w_tipo_des             varchar(64),
   @w_tipo2_des            varchar(64),
   @w_tipo_prop_des        varchar(64),
   @w_tipo_prop2_des       varchar(64),
   @w_pais_des             varchar(64),
   @w_pais2_des            varchar(64),
   @w_provincia_des        varchar(64),
   @w_provincia2_des       varchar(64), 
   @w_ciudad_des           varchar(64), 
   @w_ciudad2_des          varchar(64), 
   @w_parroquia_des        varchar(64), 
   @w_parroquia2_des       varchar(64), 
   @w_reside_des           varchar(64), 
   @w_reside2_des          varchar(64), 
   @w_nro_residentes_des   varchar(64), 
   @w_nro_residentes2_des  varchar(64), 
   @w_principal_des        varchar(64), 
   @w_principal2_des       varchar(64),          
   @w_correspondencia_des  varchar(64),    
   @w_correspondencia2_des varchar(64),    
   --Parametros Tabla #mod_datos_direccion_geo
   @w_secuencia            int,
   @w_tipo_tran            smallint,
   @w_clase_geo            char(1),
   @w_fecha_geo            datetime,
   @w_oficina_s            smallint,
   @w_usuario_geo          varchar(14), 
   @w_hora_geo             datetime,
   @w_ente_geo             int,
   @w_direccion_geo        int,
   @w_lat_segundos         float,
   @w_lon_segundos         float,
   @w_canal_geo            varchar(32),
   @w_rol_user_geo         smallint,
   @w_canal_geo_web        varchar(32),
   --Parametros datos modificados direccion geo
   @w_lat_segundos2        float,
   @w_lon_segundos2        float,
   @w_tipo_aux             varchar(10),
   --Parametros Tabla #mod_datos_telefono
   @w_secuencial_tel       int,
   @w_tipo_trans           smallint,
   @w_clase_tel            char(1),
   @w_fecha_tel            datetime,
   @w_hora_tel             datetime,
   @w_usuario_tel          varchar(14),
   @w_ente_tel             int, 
   @w_direccion_tel        int,
   @w_telefono             int,
   @w_valor                varchar(64),
   @w_tipo_tel             varchar(10),
   @w_cobro_tel            char(1),
   @w_codarea              char(10),
   @w_oficina_tel          smallint,
   @w_canal_tel            varchar(32),
   @w_rol_user_tel         smallint,
   @w_canal_tel_web        varchar(32),
   --Parametros datos modificados telefono
   @w_valor2               varchar(64),
   @w_tipo_tel2            varchar(10),
   @w_codarea2             char(10),
   @w_tipo_aux_tel         varchar(10),
   @w_tipo_tel_des         varchar(64),
   @w_tipo_tel2_des        varchar(64)
   

create table #datos_modificados (
  dm_fecha_mod        datetime     null,
  dm_hora_mod         datetime     null,
  dm_region_cli       varchar(64)  null,
  dm_sucursal_cli     varchar(64)  null,
  dm_ente             int          null,
  dm_nombre_cli       varchar(255) null,
  dm_cred_act         varchar(64)  null,
  dm_user_mod         varchar(14)  null,
  dm_dat_mod          varchar(64)  null,
  dm_dat_p            varchar(255) null,
  dm_dat_a            varchar(255) null,
  dm_canal            varchar(32)  null,
  dm_rol_user         smallint     null,
  dm_rol_user_desc    varchar(64)  null
)


select
@w_batch         = convert(int,@i_param2),
@w_formato_fecha = convert(int,@i_param3),
@w_fecha         = @i_param1


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_fecha = dateadd(day,-1, @w_fecha)         
while exists(select 1 from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_nacional
             and   df_fecha  = @w_fecha) 
begin
        select @w_fecha = dateadd(day,-1,@w_fecha)                                    
end


/* GENERAR LA TABLA TEMPORAL DE DIRECCION EN BASE A LOS DATOS DE LA VISTA TS_DIRECCION */
select 
mdd_secuencial               = secuencial,          
mdd_tipo_transaccion         = tipo_transaccion,          
mdd_clase                    = clase,                     
mdd_fecha                    = fecha,	
mdd_hora                     = hora,  
mdd_usuario                  = usuario,             
mdd_terminal                 = terminal,                  
mdd_srv                      = srv,                       
mdd_lsrv                     = lsrv,    
mdd_ente                     = ente,                
mdd_direccion                = direccion,                 
mdd_descripcion              = descripcion,               
mdd_vigencia                 = vigencia,
mdd_sector                   = sector,              
mdd_zona                     = zona,                      
mdd_parroquia                = parroquia,                 
mdd_ciudad                   = ciudad,    
mdd_tipo                     = tipo,                
mdd_oficina                  = oficina,                   
mdd_verificado               = verificado,                
mdd_barrio                   = barrio,
mdd_provincia                = provincia,           
mdd_codpostal                = codpostal,                 
mdd_casa                     = casa,                      
mdd_calle                    = calle,
mdd_pais                     = pais,                
mdd_correspondencia          = correspondencia,           
mdd_alquilada                = alquilada,                 
mdd_cobro                    = cobro,
mdd_edificio                 = edificio,            
mdd_departamento             = departamento,              
mdd_rural_urbano             = rural_urbano,              
mdd_fact_serv_pu             = fact_serv_pu,
mdd_tipo_prop                = tipo_prop,           
mdd_nombre_agencia           = nombre_agencia,            
mdd_fuente_verif             = fuente_verif,              
mdd_fecha_ver                = fecha_ver,
mdd_reside                   = reside,              
mdd_negocio                  = negocio,                   
mdd_poblacion                = poblacion,                 
mdd_nro                      = nro,                       
mdd_nro_interno              = nro_interno,         
mdd_referencia               = referencia,                
mdd_nro_residentes           = nro_residentes,            
mdd_canal                    = canal,
mdd_principal                = principal,  
mdd_rol                      = rol  
into #mod_datos_direccion
from cobis..ts_direccion, cobis..cl_ente_aux
where fecha    = @w_fecha
and ea_estado = 'A'
and ente      = ea_ente
and clase   in ('P','A') 

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx0 on #mod_datos_direccion(mdd_secuencial)
create index idx1 on #mod_datos_direccion(mdd_fecha)
create index idx2 on #mod_datos_direccion(mdd_ente)
create index idx3 on #mod_datos_direccion(mdd_clase)


--Comparacion de campos por secuencial de modificacion
declare cur_registros_dir cursor for  
   select mdd_secuencial, mdd_tipo_transaccion, mdd_clase, mdd_fecha, mdd_hora, mdd_usuario, mdd_ente, mdd_direccion, mdd_descripcion, mdd_vigencia, mdd_sector,  
          mdd_zona, mdd_parroquia, mdd_ciudad, mdd_tipo, mdd_oficina, mdd_verificado, mdd_barrio, mdd_provincia, mdd_codpostal, mdd_casa, mdd_calle, mdd_pais, mdd_correspondencia,  
		  mdd_alquilada, mdd_cobro, mdd_edificio, mdd_departamento, mdd_rural_urbano, mdd_fact_serv_pu, mdd_tipo_prop, mdd_nombre_agencia, mdd_fuente_verif, mdd_reside, mdd_negocio, 
		  mdd_poblacion, mdd_nro, mdd_nro_interno, mdd_referencia, mdd_nro_residentes, mdd_canal, mdd_principal, mdd_rol                    
   from  #mod_datos_direccion
   where mdd_clase = 'A'

open cur_registros_dir  

fetch cur_registros_dir into
          @w_secuencial, @w_tipo_transaccion, @w_clase, @w_fecha_mod, @w_hora, @w_usuario, @w_ente, @w_direccion, @w_descripcion, @w_vigencia, @w_sector, 
		  @w_zona, @w_parroquia, @w_ciudad, @w_tipo, @w_oficina, @w_verificado, @w_barrio, @w_provincia, @w_codpostal, @w_casa, @w_calle, @w_pais, @w_correspondencia,
		  @w_alquilada, @w_cobro, @w_edificio, @w_departamento, @w_rural_urbano, @w_fact_serv_pu, @w_tipo_prop, @w_nombre_agencia, @w_fuente_verif, @w_reside, @w_negocio,
		  @w_poblacion, @w_nro, @w_nro_interno, @w_referencia_dir, @w_nro_residentes, @w_canal, @w_principal, @w_rol_user
		      
while @@FETCH_STATUS = 0 
  begin
    if @w_tipo = 'RE' -- tipo domicilio
	begin
      -- inicio tipo de direccion
	  select @w_tipo2 = mdd_tipo
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if ((@w_tipo is not null and @w_tipo2 is not null) or (@w_tipo is not null and @w_tipo2 is null) or (@w_tipo is null and @w_tipo2 is not null)) and (@w_tipo <> @w_tipo2)
	  begin
	    select @w_tipo_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_tdireccion' 
		and   c.codigo = @w_tipo
		
		select @w_tipo2_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_tdireccion' 
		and   c.codigo = @w_tipo2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod,dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Tipo de Dirección', @w_tipo2_des, @w_tipo_des, @w_canal_web, @w_rol_user)
	  end
      -- fin tipo de direccion
	  
	  -- inicio tipo de vivienda
	  select @w_tipo_prop2 = mdd_tipo_prop
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_tipo_prop is not null and @w_tipo_prop2 is not null) or (@w_tipo_prop is not null and @w_tipo_prop2 is null) or (@w_tipo_prop is null and @w_tipo_prop2 is not null)
	  begin
	    select @w_tipo_prop_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_tpropiedad' 
		and   c.codigo = @w_tipo_prop
		
		select @w_tipo_prop2_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_tpropiedad' 
		and   c.codigo = @w_tipo_prop2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Tipo de Vivienda', @w_tipo_prop2_des, @w_tipo_prop_des, @w_canal_web, @w_rol_user)
	  end
      -- fin tipo de vivienda
	  
	  -- inicio pais
	  select @w_pais2 = mdd_pais
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_pais is not null and @w_pais2 is not null) or (@w_pais is not null and @w_pais2 is null) or (@w_pais is null and @w_pais2 is not null)
	  begin
	  	select @w_pais_des = pa_descripcion                                                                                
		from cobis..cl_pais                                               
		where pa_pais = @w_pais
		
		select @w_pais2_des = pa_descripcion                                                                                
		from cobis..cl_pais                                               
		where pa_pais = @w_pais2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'País', @w_pais2_des, @w_pais_des, @w_canal_web, @w_rol_user)
	  end
      -- fin pais
	  
      -- inicio codigo postal
	  select @w_codpostal2 = mdd_codpostal
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_codpostal is not null and @w_codpostal2 is not null) or (@w_codpostal is not null and @w_codpostal2 is null) or (@w_codpostal is null and @w_codpostal2 is not null)
	  begin
	  
	    select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
	  
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Código Postal', @w_codpostal2, @w_codpostal, @w_canal_web, @w_rol_user)
	  end
      -- fin codigo postal
	  
	  -- inicio estado
	  select @w_provincia2 = mdd_provincia
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_provincia is not null and @w_provincia2 is not null) or (@w_provincia is not null and @w_provincia2 is null) or (@w_provincia is null and @w_provincia2 is not null)
	  begin
	    select @w_provincia_des = pv_descripcion                                                                                
		from cobis..cl_provincia                                               
		where pv_provincia = @w_provincia
		
		select @w_provincia2_des = pv_descripcion                                                                                
		from cobis..cl_provincia                                               
		where pv_provincia = @w_provincia2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Estado', @w_provincia2_des, @w_provincia_des, @w_canal_web, @w_rol_user)
	  end
      -- fin estado
	  
	  -- inicio delegacion / municipio
	  select @w_ciudad2 = mdd_ciudad
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_ciudad is not null and @w_ciudad2 is not null) or (@w_ciudad is not null and @w_ciudad2 is null) or (@w_ciudad is null and @w_ciudad2 is not null)
	  begin
	    select @w_ciudad_des = ci_descripcion                                                                                
		from cobis..cl_ciudad                                               
		where ci_ciudad = @w_ciudad
		
		select @w_ciudad2_des = ci_descripcion                                                                                
		from cobis..cl_ciudad                                               
		where ci_ciudad = @w_ciudad2 
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Delegación/Municipio', @w_ciudad2_des, @w_ciudad_des, @w_canal_web, @w_rol_user)
	  end
      -- fin delegacion / municipio
	  
	  -- inicio colonia
	  select @w_parroquia2 = mdd_parroquia
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_parroquia is not null and @w_parroquia2 is not null) or (@w_parroquia is not null and @w_parroquia2 is null) or (@w_parroquia is null and @w_parroquia2 is not null)
	  begin
	    select @w_parroquia_des = pq_descripcion                                                                                
		from cobis..cl_parroquia                                               
		where pq_parroquia = @w_parroquia
		
		select @w_parroquia2_des = pq_descripcion                                                                                
		from cobis..cl_parroquia                                               
		where pq_parroquia = @w_parroquia2 
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Colonia', @w_parroquia2_des, @w_parroquia_des, @w_canal_web, @w_rol_user)
	  end
      -- fin colonia
	  
	  -- inicio ciudad / poblacion
	  select @w_poblacion2 = mdd_poblacion
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_poblacion is not null and @w_poblacion2 is not null) or (@w_poblacion is not null and @w_poblacion2 is null) or (@w_poblacion is null and @w_poblacion2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Ciudad/Población', @w_poblacion2, @w_poblacion, @w_canal_web, @w_rol_user)
	  end
      -- fin ciudad /poblacion
	  
	  -- inicio calle
	  select @w_calle2 = mdd_calle
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_calle is not null and @w_calle2 is not null) or (@w_calle is not null and @w_calle2 is null) or (@w_calle is null and @w_calle2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end 
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Calle', @w_calle2, @w_calle, @w_canal_web, @w_rol_user)
	  end
      -- fin calle
	  
	  -- inicio numero
	  select @w_nro2 = mdd_nro
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_nro is not null and @w_nro2 is not null) or (@w_nro is not null and @w_nro2 is null) or (@w_nro is null and @w_nro2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Número', @w_nro2, @w_nro, @w_canal_web, @w_rol_user)
	  end
      -- fin numero
	  
	  -- inicio numero interno
	  select @w_nro_interno2 = mdd_nro_interno
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_nro_interno is not null and @w_nro_interno2 is not null) or (@w_nro_interno is not null and @w_nro_interno2 is null) or (@w_nro_interno is null and @w_nro_interno2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Número Interno', @w_nro_interno2, @w_nro_interno, @w_canal_web, @w_rol_user)
	  end
      -- fin numero interno
	  
	  -- inicio referencia
	  select @w_referencia_dir2 = mdd_referencia
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_referencia_dir is not null and @w_referencia_dir2 is not null) or (@w_referencia_dir is not null and @w_referencia_dir2 is null) or (@w_referencia_dir is null and @w_referencia_dir2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Referencia', @w_referencia_dir2, @w_referencia_dir, @w_canal_web, @w_rol_user)
	  end
      -- fin referencia
	  
	  -- años en domicilio actual
	  select @w_reside2 = mdd_reside
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_reside is not null and @w_reside2 is not null) or (@w_reside is not null and @w_reside2 is null) or (@w_reside is null and @w_reside2 is not null)
	  begin
	    select @w_reside_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_referencia_tiempo' 
		and   c.codigo = @w_reside
		
		select @w_reside2_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_referencia_tiempo' 
		and   c.codigo = @w_reside2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Años en Domicilio Actual', @w_reside2_des, @w_reside_des, @w_canal_web, @w_rol_user)
	  end
      -- fin años en domicilio actual
	  
	  -- inicio no de personas viviendo en este domicilio
	  select @w_nro_residentes2 = mdd_nro_residentes
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_nro_residentes is not null and @w_nro_residentes2 is not null) or (@w_nro_residentes is not null and @w_nro_residentes2 is null) or (@w_nro_residentes is null and @w_nro_residentes2 is not null)
	  begin
	    select @w_nro_residentes_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_referencia_tiempo' 
		and   c.codigo = @w_nro_residentes
		
		select @w_nro_residentes2_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_referencia_tiempo' 
		and   c.codigo = @w_nro_residentes2
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'No. de Personas Viviendo en este Domicilio', @w_nro_residentes2_des, @w_nro_residentes_des, @w_canal_web, @w_rol_user)
	  end
      -- fin no de personas viviendo en este domicilio
	  
	  -- inicio datos complementarios de la direccion
	  select @w_descripcion2 = mdd_descripcion
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_descripcion is not null and @w_descripcion2 is not null) or (@w_descripcion is not null and @w_descripcion2 is null) or (@w_descripcion is null and @w_descripcion2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Datos Complementarios de la Dirección', @w_descripcion2, @w_descripcion, @w_canal_web, @w_rol_user)
	  end
      -- fin datos complementarios de la direccion
	  
	  	-- inicio direccion principal
	  select @w_principal2 = mdd_principal
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_principal is not null and @w_principal2 is not null) or (@w_principal is not null and @w_principal2 is null) or (@w_principal is null and @w_principal2 is not null)
	  begin
	    if @w_principal = 'S'
		begin
		  select @w_principal_des = 'SI'
		end
		else
		begin
		  select @w_principal_des = 'NO'
		end
		
		if @w_principal2 = 'S'
		begin
		  select @w_principal2_des = 'SI'
		end
		else
		begin
		  select @w_principal2_des = 'NO'
		end
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		  
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Dirección Principal', @w_principal2_des, @w_principal_des, @w_canal_web, @w_rol_user)
	  end
      -- fin direccion principal
	  
	  -- inicio direccion de correspondencia
	  select @w_correspondencia2 = mdd_correspondencia
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_correspondencia is not null and @w_correspondencia2 is not null) or (@w_correspondencia is not null and @w_correspondencia2 is null) or (@w_correspondencia is null and @w_correspondencia2 is not null)
	  begin
	    if @w_correspondencia = 'S'
		begin
		  select @w_correspondencia_des = 'SI'
		end
		else
		begin
		  select @w_correspondencia_des = 'NO'
		end
		  
		if @w_correspondencia2 = 'S'
		  select @w_correspondencia2_des = 'SI'
		else
		  select @w_correspondencia2_des = 'NO'
		
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Dirección de Correspondencia', @w_correspondencia2_des, @w_correspondencia_des, @w_canal_web, @w_rol_user)
	  end
      -- fin direccion de correspondencia
	end
	else
	if @w_tipo = 'CE' -- tipo correo
	begin
	  -- inicio direccion virtual
	  select @w_descripcion2 = mdd_descripcion
      from   #mod_datos_direccion
      where  mdd_secuencial  =  @w_secuencial
      and    mdd_clase = 'P'
	  
	  if (@w_descripcion is not null and @w_descripcion2 is not null) or (@w_descripcion is not null and @w_descripcion2 is null) or (@w_descripcion is null and @w_descripcion2 is not null)
	  begin
	    
		select @w_canal_web = case @w_canal when 'CWC' then 'WEB' else @w_canal end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha, @w_hora, @w_ente, @w_usuario, 'Dirección Virtual', @w_descripcion2, @w_descripcion, @w_canal_web, @w_rol_user)
	  end
      -- fin direccion virtual
	end
	
    fetch cur_registros_dir into
          @w_secuencial, @w_tipo_transaccion, @w_clase, @w_fecha_mod, @w_hora, @w_usuario, @w_ente, @w_direccion, @w_descripcion, @w_vigencia, @w_sector, 
		  @w_zona, @w_parroquia, @w_ciudad, @w_tipo, @w_oficina, @w_verificado, @w_barrio, @w_provincia, @w_codpostal, @w_casa, @w_calle, @w_pais, @w_correspondencia,
		  @w_alquilada, @w_cobro, @w_edificio, @w_departamento, @w_rural_urbano, @w_fact_serv_pu, @w_tipo_prop, @w_nombre_agencia, @w_fuente_verif, @w_reside, @w_negocio,
		  @w_poblacion, @w_nro, @w_nro_interno, @w_referencia_dir, @w_nro_residentes, @w_canal, @w_principal, @w_rol_user
  end

close      cur_registros_dir 
deallocate cur_registros_dir 


/* GENERAR LA TABLA TEMPORAL DE DIRECCION GEO EN BASE A LOS DATOS DE LA VISTA TS_DIRECCION_GEO */
select 
mdg_secuencia                = secuencia,          
mdg_tipo_transaccion         = tipo_transaccion,          
mdg_clase                    = clase,                     
mdg_fecha                    = fecha,	
mdg_oficina_s                = oficina_s,  
mdg_usuario                  = usuario,             
mdg_terminal_s               = terminal_s,                  
mdg_srv                      = srv,                       
mdg_lsrv                     = lsrv,    
mdg_hora                     = hora,                
mdg_ente                     = ente,                 
mdg_direccion                = direccion,               
mdg_latitud_coord            = latitud_coord,
mdg_latitud_grados           = latitud_grados,              
mdg_latitud_minutos          = latitud_minutos,                      
mdg_latitud_segundos         = latitud_segundos,                 
mdg_longitud_coord           = longitud_coord,    
mdg_longitud_grados          = longitud_grados,                
mdg_longitud_minutos         = longitud_minutos,                   
mdg_longitud_segundos        = longitud_segundos,                
mdg_path_croquis             = path_croquis,
mdg_canal                    = canal,
mdg_rol                      = rol
into #mod_datos_direccion_geo
from cobis..ts_direccion_geo, cobis..cl_ente_aux
where fecha    = @w_fecha
and ea_estado = 'A'
and ente      = ea_ente
and clase   in ('P','A') 

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx0 on #mod_datos_direccion_geo(mdg_secuencia)
create index idx1 on #mod_datos_direccion_geo(mdg_fecha)
create index idx2 on #mod_datos_direccion_geo(mdg_ente)
create index idx3 on #mod_datos_direccion_geo(mdg_clase)


--Comparacion de campos por secuencial de modificacion
declare cur_registros_dir_geo cursor for  
   select mdg_secuencia, mdg_tipo_transaccion, mdg_clase, mdg_fecha, mdg_oficina_s, mdg_usuario, mdg_hora, mdg_ente, mdg_direccion, mdg_latitud_segundos, mdg_longitud_segundos,
          mdg_canal, mdg_rol
   from  #mod_datos_direccion_geo
   where mdg_clase = 'A'

open cur_registros_dir_geo  

fetch cur_registros_dir_geo into
          @w_secuencia, @w_tipo_tran, @w_clase_geo, @w_fecha_geo, @w_oficina_s, @w_usuario_geo, @w_hora_geo, @w_ente_geo, @w_direccion_geo, @w_lat_segundos, @w_lon_segundos, 
		  @w_canal_geo, @w_rol_user_geo      
			  
while @@FETCH_STATUS = 0 
  begin
    select @w_tipo_aux = di_tipo
	from cobis..cl_direccion
	where di_ente = @w_ente_geo
	and di_direccion = @w_direccion_geo
	
    if @w_tipo_aux = 'RE' -- tipo domicilio
	begin
      -- inicio latitud 
	  select @w_lat_segundos2 = mdg_latitud_segundos
      from   #mod_datos_direccion_geo
      where  mdg_secuencia  =  @w_secuencia
      and    mdg_clase = 'P'
	  
	  if (@w_lat_segundos is not null and @w_lat_segundos2 is not null) or (@w_lat_segundos is not null and @w_lat_segundos2 is null) or (@w_lat_segundos is null and @w_lat_segundos2 is not null) 
	  begin
	    
		select @w_canal_geo_web = case @w_canal_geo when 'CWC' then 'WEB' else @w_canal_geo end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha_geo, @w_hora_geo, @w_ente_geo, @w_usuario_geo, 'Latitud', @w_lat_segundos2, @w_lat_segundos, @w_canal_geo_web, @w_rol_user_geo)
	  end
      -- fin latitud
	  
      -- inicio longitud
	  select @w_lon_segundos2 = mdg_longitud_segundos
      from   #mod_datos_direccion_geo
      where  mdg_secuencia  =  @w_secuencia
      and    mdg_clase = 'P'
	  
	  if (@w_lon_segundos is not null and @w_lon_segundos2 is not null) or (@w_lon_segundos is not null and @w_lon_segundos2 is null) or (@w_lon_segundos is null and @w_lon_segundos2 is not null) 
	  begin
	    
		select @w_canal_geo_web = case @w_canal_geo when 'CWC' then 'WEB' else @w_canal_geo end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha_geo, @w_hora_geo, @w_ente_geo, @w_usuario_geo, 'Longitud', @w_lon_segundos2, @w_lon_segundos, @w_canal_geo_web, @w_rol_user_geo)
	  end
      -- fin longitud
	end
	
    fetch cur_registros_dir_geo into
          @w_secuencia, @w_tipo_tran, @w_clase_geo, @w_fecha_geo, @w_oficina_s, @w_usuario_geo, @w_hora_geo, @w_ente_geo, @w_direccion_geo, @w_lat_segundos, @w_lon_segundos, 
		  @w_canal_geo, @w_rol_user_geo
  end

close      cur_registros_dir_geo 
deallocate cur_registros_dir_geo 


/* GENERAR LA TABLA TEMPORAL DE TELEFONO EN BASE A LOS DATOS DE LA VISTA TS_TELEFONO */
select 
mdt_secuencial               = secuencial,    
mdt_alterno                  = alterno,       
mdt_tipo_transaccion         = tipo_transaccion,          
mdt_clase                    = clase,                     
mdt_fecha                    = fecha, 
mdt_hora                     = hora,   
mdt_usuario                  = usuario,           
mdt_terminal                 = terminal,               
mdt_srv                      = srv,                            
mdt_lsrv                     = lsrv,                  
mdt_ente                     = ente,                
mdt_direccion                = direccion,            
mdt_telefono                 = telefono,
mdt_valor                    = valor,            
mdt_tipo                     = tipo,	                
mdt_cobro                    = cobro,                     
mdt_codarea                  = codarea,
mdt_oficina                  = oficina,   
mdt_canal                    = canal,
mdt_rol                      = rol
into #mod_datos_telefono
from cobis..ts_telefono, cobis..cl_ente_aux
where fecha    = @w_fecha
and ea_estado = 'A'
and ente      = ea_ente
and clase   in ('P','A') 

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end

create index idx0 on #mod_datos_telefono(mdt_secuencial)
create index idx1 on #mod_datos_telefono(mdt_fecha)
create index idx2 on #mod_datos_telefono(mdt_ente)
create index idx3 on #mod_datos_telefono(mdt_clase)


--Comparacion de campos por secuencial de modificacion
declare cur_registros_tel cursor for  
   select mdt_secuencial, mdt_tipo_transaccion, mdt_clase, mdt_fecha, mdt_hora, mdt_usuario, mdt_ente, mdt_direccion, mdt_telefono, mdt_valor, mdt_tipo, mdt_cobro, 
          mdt_codarea, mdt_oficina, mdt_canal, mdt_rol
   from  #mod_datos_telefono
   where mdt_clase = 'A'

open cur_registros_tel 

fetch cur_registros_tel into
          @w_secuencial_tel, @w_tipo_trans, @w_clase_tel, @w_fecha_tel, @w_hora_tel, @w_usuario_tel, @w_ente_tel, @w_direccion_tel, @w_telefono, @w_valor, @w_tipo_tel, @w_cobro_tel,    
          @w_codarea, @w_oficina_tel, @w_canal_tel, @w_rol_user_tel  
 
while @@FETCH_STATUS = 0 
  begin
    select @w_tipo_aux_tel = di_tipo
	from cobis..cl_direccion
	where di_ente = @w_ente_tel
	and di_direccion = @w_direccion_tel
	
    if @w_tipo_aux_tel = 'RE' -- tipo domicilio
	begin
      -- inicio tipo telefono 
	  select @w_tipo_tel2 = mdt_tipo
      from   #mod_datos_telefono
      where  mdt_secuencial =  @w_secuencial_tel
      and    mdt_clase = 'P'
	  
	  if (@w_tipo_tel is not null and @w_tipo_tel2 is not null) or (@w_tipo_tel is not null and @w_tipo_tel2 is null) or (@w_tipo_tel is null and @w_tipo_tel2 is not null) 
	  begin		
		
	    select @w_tipo_tel_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_ttelefono' 
		and   c.codigo = @w_tipo_tel
		
		select @w_tipo_tel2_des = valor                                                                                
		from cobis..cl_tabla t, cobis..cl_catalogo c                                                
		where t.codigo = c.tabla and t.tabla = 'cl_ttelefono' 
		and   c.codigo = @w_tipo_tel2
		
		select @w_canal_tel_web = case @w_canal_tel when 'CWC' then 'WEB' else @w_canal_tel end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha_tel, @w_hora_tel, @w_ente_tel, @w_usuario_tel, 'Tipo Teléfono', @w_tipo_tel2_des, @w_tipo_tel_des, @w_canal_tel_web, @w_rol_user_tel)
	  end
      -- fin tipo telefono
	  
      -- inicio codigo de area 
	  select @w_codarea2 = mdt_codarea
      from   #mod_datos_telefono
      where  mdt_secuencial =  @w_secuencial_tel
      and    mdt_clase = 'P'
	  
	  if (@w_codarea is not null and @w_codarea2 is not null) or (@w_codarea is not null and @w_codarea2 is null) or (@w_codarea is null and @w_codarea2 is not null) 
	  begin
	    
		select @w_canal_tel_web = case @w_canal_tel when 'CWC' then 'WEB' else @w_canal_tel end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha_tel, @w_hora_tel, @w_ente_tel, @w_usuario_tel, 'Código de Área', @w_codarea2, @w_codarea, @w_canal_tel_web, @w_rol_user_tel)
	  end
      -- fin codigo de area 
	  
	   -- inicio numero de telefono 
	  select @w_valor2 = mdt_valor
      from   #mod_datos_telefono
      where  mdt_secuencial =  @w_secuencial_tel
      and    mdt_clase = 'P'
	  
	  if (@w_valor is not null and @w_valor2 is not null) or (@w_valor is not null and @w_valor2 is null) or (@w_valor is null and @w_valor2 is not null) 
	  begin
	    
		select @w_canal_tel_web = case @w_canal_tel when 'CWC' then 'WEB' else @w_canal_tel end
		
	    insert into #datos_modificados (dm_fecha_mod, dm_hora_mod, dm_ente, dm_user_mod, dm_dat_mod, dm_dat_p, dm_dat_a, dm_canal, dm_rol_user)
        values (@w_fecha_tel, @w_hora_tel, @w_ente_tel, @w_usuario_tel, 'Número De Teléfono', @w_valor2, @w_valor, @w_canal_tel_web, @w_rol_user_tel)
	  end
      -- fin numero de telefono 
	end
	
    fetch cur_registros_tel into
          @w_secuencial_tel, @w_tipo_trans, @w_clase_tel, @w_fecha_tel, @w_hora_tel, @w_usuario_tel, @w_ente_tel, @w_direccion_tel, @w_telefono, @w_valor, @w_tipo_tel, @w_cobro_tel,    
          @w_codarea, @w_oficina_tel, @w_canal_tel, @w_rol_user_tel 
  end

close      cur_registros_tel
deallocate cur_registros_tel 


--Region
update #datos_modificados
set dm_region_cli = (select A.of_nombre
                     from cobis..cl_oficina A, cobis..cl_oficina B, cobis..cl_ente
                     where A.of_oficina = B.of_regional
                     and   B.of_oficina = en_oficina
					 and   dm_ente = en_ente)

if @@error <> 0 begin
   print 'Error Actualizando Datos Regional'
   return 1
end

                  
--Sucursal
update #datos_modificados
set dm_sucursal_cli = upper(of_nombre)
from cobis..cl_oficina
where of_oficina = (select a.en_oficina 
                    from  cobis..cl_ente as a
                    inner join cobis..cl_ente_aux b on (a.en_ente = b.ea_ente)
                    where a.en_subtipo = 'P'
                    and a.en_ente      = dm_ente)
					
if @@error <> 0 begin
   print 'Error Actualizando Datos Sucursal'
   return 1
end


--Nombre cliente
update #datos_modificados 
set dm_nombre_cli = UPPER(isnull(p_p_apellido,'')) + ' ' + UPPER(isnull(p_s_apellido,'')) + ' ' + UPPER(isnull(en_nombre,'')) + ' ' + UPPER(isnull(p_s_nombre,''))
from cobis..cl_ente,
     cobis..cl_ente_aux
where en_ente = dm_ente
and   en_ente = ea_ente 

if @@error <> 0 begin
   print 'Error Actualizando Nombre'
   return 1
end


--Credito
update #datos_modificados 
set dm_cred_act = op_banco
from cob_cartera..ca_operacion
where op_cliente = dm_ente
and   @w_fecha between op_fecha_ini and op_fecha_fin
and   op_estado = 1

if @@error <> 0 begin
   print 'Error Actualizando Credito'
   return 1
end


--Rol descripcion
update #datos_modificados 
set dm_rol_user_desc = ro_descripcion
from cobis..ad_rol
where ro_rol = dm_rol_user

if @@error <> 0 begin
   print 'Error Actualizando Descripcion de Rol'
   return 1
end

--borrado de datos anteriores a estar activo
delete from #datos_modificados 
where dm_hora_mod < (select ea_fecha_activacion from cobis..cl_ente_aux 
                     where ea_ente = dm_ente) 
 

--borrado cuando se repite la ejecucion de un dia
delete from cob_conta_super..sb_reporte_mod_datos
where [FECHA DE MODIFICACION] = @w_fecha


insert into sb_reporte_mod_datos
(
[FECHA DE MODIFICACION],       
REGION,                        
SUCURSAL,                      
[ID CLIENTE],                  
[NOMBRE COMPLETO CLIENTE],    
[NO. DE CREDITO],              
[USUARIO QUE MODIFICO],        
[CAMPO QUE FUE MODIFICADO],    
[DATO ANTERIOR],               
[DATO NUEVO],                  
[CANAL DE MODIFICACION],        
[ROL DE USUARIO QUE MODIFICO] 	 
)
select
isnull(dm_fecha_mod,' '),
isnull(dm_region_cli,' '),   
isnull(dm_sucursal_cli, ' '),
isnull(dm_ente,0),
isnull(dm_nombre_cli,' '),      
isnull(dm_cred_act, ' '),
isnull(dm_user_mod, ' '),
isnull(dm_dat_mod, ' '),
isnull(dm_dat_p,' '),                             
isnull(dm_dat_a,' '),                               
isnull(dm_canal, ' '),
isnull(dm_rol_user_desc, ' ')	
from #datos_modificados


select @w_fecha_diff = datediff(month, @w_fecha, @i_param1)

if @w_fecha_diff > = 1
begin

  select @w_fecha_inicio = dateadd(month, -1, @i_param1) 
  
  if not exists (select * from sb_reporte_mod_datos_linea) -- si tabla vacia inserta cabecera
  begin 
    insert into sb_reporte_mod_datos_linea(rm_cadena)
    select 
    'FECHA DE MODIFICACION'        + '|' +
    'REGION'                       + '|' +
    'SUCURSAL'                     + '|' +
    'ID CLIENTE'                   + '|' +
    'NOMBRE COMPLETO CLIENTE'      + '|' +
    'NO. DE CREDITO'               + '|' +
    'USUARIO QUE MODIFICO'         + '|' +
    'CAMPO QUE FUE MODIFICADO'     + '|' +
    'DATO ANTERIOR'                + '|' +
    'DATO NUEVO'                   + '|' +
    'CANAL DE MODIFICACION'        + '|' +
    'ROL DE USUARIO QUE MODIFICO'
  end  
  
  insert into sb_reporte_mod_datos_linea(rm_cadena)
  select 
  isnull(convert(varchar,[FECHA DE MODIFICACION],@w_formato_fecha),' ') + '|' + 
  isnull(REGION,' ') + '|' +  
  isnull(SUCURSAL, ' ') + '|' +
  convert(varchar(10),isnull([ID CLIENTE],0)) + '|' +
  isnull([NOMBRE COMPLETO CLIENTE],' ') + '|' +   
  isnull([NO. DE CREDITO], ' ') + '|' +
  isnull([USUARIO QUE MODIFICO], ' ') + '|' +
  isnull([CAMPO QUE FUE MODIFICADO], ' ') + '|' +
  isnull([DATO ANTERIOR],' ') + '|' +                             
  isnull([DATO NUEVO],' ') + '|' +                              
  isnull([CANAL DE MODIFICACION], ' ') + '|' +
  isnull([ROL DE USUARIO QUE MODIFICO] , ' ')	
  from sb_reporte_mod_datos
  where [FECHA DE MODIFICACION] between @w_fecha_inicio and @w_fecha -- se inserta solo lo del mes


  ----------------------------------------
  --Generar Archivo Plano
  ----------------------------------------
  select @w_s_app = pa_char
  from cobis..cl_parametro
  where pa_producto = 'ADM'
  and   pa_nemonico = 'S_APP'
  
  select @w_path = ba_path_destino
  from cobis..ba_batch
  where ba_batch = @w_batch
  
  select @w_dia = right('00'+convert(varchar(2),datepart(dd, @i_param1)  ),2)
  select @w_mes = right('00'+convert(varchar(2),datepart(mm, @i_param1)  ),2)
  select @w_ano = substring(convert(varchar(4),datepart(yyyy, @i_param1)),1,4)
  
  select @w_member_code='MODIFICACION_DATOS'
  select @w_nom_arch = @w_member_code + '_' + @w_dia + @w_mes + @w_ano + '.txt'  
  select @w_nom_log  = @w_member_code + '_' + @w_ano + @w_mes + @w_dia + '.err'
  
  select @w_comando = 'bcp "select rm_cadena from cob_conta_super..sb_reporte_mod_datos_linea" queryout '
  
  select @w_destino  = @w_path + @w_nom_arch, 
         @w_errores  = @w_path + @w_nom_log   
  
  select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -T -e' + @w_errores
  
  exec @w_error = xp_cmdshell @w_comando
  
  if @w_error <> 0 begin
     print 'Error generando Reporte de Modificacion de Datos'
     print @w_comando
     return 1
  end
  
  truncate table cob_conta_super..sb_reporte_mod_datos_linea
  
  delete from cob_conta_super..sb_reporte_mod_datos
  where [FECHA DE MODIFICACION] < @w_fecha_inicio
  
end

return 0

go
