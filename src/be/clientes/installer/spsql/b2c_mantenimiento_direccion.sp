/* ********************************************************************* */
/*   Archivo:              sp_b2c_mantenimiento_direccion.sp             */
/*   Stored procedure:     sp_b2c_mantenimiento_direccion                */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   20/Agosto/2020                                */
/* ********************************************************************* */
/*            IMPORTANTE                                                 */
/* ********************************************************************* */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/* ********************************************************************* */
/*            PROPOSITO                                                  */
/* ********************************************************************* */
/*   Este stored procedure inserta personas con datos incompletos        */
/*            MODIFICACIONES                                             */
/*   FECHA      AUTOR      RAZON      NEMONICO                           */
/* ********************************************************************* */
/*  18/Febrero/2022    S. Rojas       Emision inicial                    */
/* ********************************************************************* */

use cobis
go

IF OBJECT_ID ('dbo.sp_b2c_mantenimiento_direccion') IS NOT NULL
	DROP PROCEDURE dbo.sp_b2c_mantenimiento_direccion
GO

create proc sp_b2c_mantenimiento_direccion (
   @s_ssn                int,
   @s_user               login        = null,
   @s_sesn               int          = null,
   @s_culture            varchar(10)  = null,
   @s_term               varchar(32)  = null,
   @s_date               datetime,
   @s_srv                varchar(30)   = null,
   @s_lsrv               varchar(30)   = null,
   @s_ofi                smallint      = null,
   @s_rol                smallint      = null,
   @s_org_err            char(1)       = null,
   @s_error              int           = null,
   @s_sev                tinyint       = null,
   @s_msg                descripcion   = null,
   @s_org                char(1)       = null,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(10)   = null,
   @t_from               varchar(32)   = null,
   @t_trn                smallint      = null,
   @t_show_version       bit           = 0,     -- Mostrar la version del programa
   @i_operacion          char(1)       = 'I',  -- Opcion con la que se ejecuta el programa
   @i_ente               int           = null, -- Codigo secuencial del cliente
   @i_direccion          tinyint       = null, -- Numero de la direccion que se asigna al Cliente
   @i_descripcion        varchar(254)  = null, -- Descripcion de la direccion
   @i_tipo               catalogo      = null, -- Tipo de direccion
   @i_parroquia          int           = null,
   @i_ciudad             int           = null,
   @i_provincia          int           = null,
   @i_calle              varchar(70)   = null,
   @i_codbarrio          int           = null,
   @i_barrio             int           = null,
   @i_canton             int           = null,
   @i_distrito           int           = null,
   @i_ci_poblacion       varchar(30)   = null,
   @i_pais               int           = null,
   @i_numero_ext_dom     int           = null,  
   @i_numero_int_dom     int           = null,  
   @i_codpostal          varchar(30)   = null,
   @i_referencia         varchar(50)   = null,
   @i_oficina            int           = null,
   @i_rural_urbano       char(1)       = null,
   @i_principal          char(1)       = null,
   @i_correspondencia    char(1)       = null,
   @i_lat_coord          char(1)       = null,
   @i_lat_grados         tinyint       = null,
   @i_lat_minutos        tinyint       = null,
   @i_lat_segundos       float         = null,
   @i_lon_coord          char(1)       = null,
   @i_lon_grados         tinyint       = null,
   @i_lon_minutos        tinyint       = null,
   @i_lon_segundos       float         = null,
   @i_path_croquis       varchar(50)   = null,
   @i_canal              varchar(4)    = null,
   @o_direccion          int           = null out
)
as
declare
@w_commit              char(1) = 'N',
@w_transaccion         int,
@w_sp_name             varchar(32),
@w_error               int,
@w_return              int,
@w_descripcion         varchar(254),
@w_tipo                catalogo,
@w_sector              catalogo, 
@w_zona_ant            catalogo,
@w_zona                catalogo,
@w_parroquia           int,
@w_barrio              char(40),
@w_ciudad              int, -- de int a smallint
@w_oficina             smallint,
@w_verificado          char(1),
@w_vigencia            char(1),
@w_principal           char(1),             
@w_casa                varchar(40),  
@w_calle               varchar(70),
@v_descripcion         varchar(254),
@v_tipo                catalogo,
@v_sector              catalogo,
@v_zona                catalogo,
@v_parroquia           int,
@v_barrio              char(40),
@v_ciudad              int, -- de int a smallint
@v_oficina             smallint,
@v_verificado          char(1),
@v_vigencia            char(1),
@v_principal           char(1),      
@v_casa                varchar(40),  
@v_calle               varchar(70),
@v_tiempo_reside       int,
@o_ente                int,
@o_ennombre            descripcion,
@o_cedruc              numero,
@o_descripcion         varchar(254),
@o_cinombre            descripcion,
@o_parroquia           int,
@o_barrio              char(40),
@o_pqnombre            descripcion,
@o_tipo                catalogo,
@o_tinombre            descripcion,
@o_sector              catalogo,
@o_sector_nombre       descripcion,
@o_zona                catalogo,
@o_zona_nombre         descripcion,
@o_telefono            tinyint,
@o_valor               varchar(12),
@o_siguiente           int,
@o_oficina             smallint,
@o_ofinombre           descripcion,
@o_verificado          char(1),
@o_vigencia            char(1),
@o_principal           char(1),      
@o_fecha_registro      datetime,
@o_fecha_modificacion  datetime,
@o_casa                varchar(40),  
@o_calle               varchar(70),
@o_co_igual_so         char(1),
@o_ciudad             int,
@w_provincia           int,
@v_provincia           int,
@w_direccion           varchar(3),
@w_codpostal           char(5),
@v_codpostal           char(5),
@w_direccion1          tinyint,
@w_pais                smallint, 
@w_canton              int,
@w_codbarrio           int,
@w_distrito            int,
@w_correspondencia     char(1),
@w_alquilada           char(1),
@w_cobro               char(1),
@w_otrasenas           varchar(254),
@w_montoalquiler       money,
@w_edificio            varchar(40),
@v_pais                smallint,
@v_canton              int,
@v_codbarrio           int,
@v_distrito            int,
@v_correspondencia     char(1),
@v_alquilada           char(1),
@v_cobro               char(1),
@v_otrasenas           varchar(254),
@v_montoalquiler       money,
@v_edificio            varchar(40),
@v_co_igual_so         char(1),
@w_doble_aut           char(1),
@w_autorizacion        int,
@w_estado_campo        char(1),      --Miguel Aldaz  06/26/2012 Doble autorizaciï¿½n CLI-0565 HSBC
@w_co_igual_so         char(1),
@w_iguales             char(1),
@w_iguales2             char(1),
@w_subtipo             char(1),
@w_co_igual_so_ant     char(1),
@w_co_igual_so_ant_co  char(1),
@w_co_igual_so_ant_so  char(1),
@w_cambio_direccion    char(1),
@w_co_igual_so_so      char(1),      
@w_co_igual_so_co      char(1),
@w_cambio_campo        char(1),
@w_cambio_campo_co_so  char(1),
@w_tipo_dir_so_co      char(2),
-- CAMPOS NUEVOS
@w_rural_urbano        char(1),
@w_departamento        varchar(10),
@w_fact_serv_pu        char(1),
@w_tipo_prop           char(10),
@v_rural_urbano        char(1),
@v_departamento        varchar(10),
@v_fact_serv_pu        char(1),
@v_tipo_prop           char(10),
@v_nombre_agencia      varchar(20),
@w_nombre_agencia      varchar(20),
@w_fuente_verif        varchar(10),
@v_fuente_verif        varchar(10),
@w_direccion_dc        tinyint,
@w_descripcion_aux     varchar(254),
@w_parroquia_aux       int,
@w_barrio_aux          char(40),
@w_canton_aux          int,
@w_provincia_aux       int,
@w_calle_aux           varchar(70),
@w_casa_aux            varchar(40),
@w_pais_aux            smallint,                    
@w_codbarrio_aux       int,                
@w_otrasenas_aux       varchar(254),
@w_distrito_aux        int,
@w_edificio_aux        varchar(40),
@w_co_igual_so_aux     char(1),
@w_descripcion1        varchar(254),
@w_parroquia1          int,
@w_barrio1             char(40),
@w_canton1             int,
@w_provincia1           int,
@w_calle1               varchar(70),
@w_casa1                varchar(40),
@w_pais1                smallint,               
@w_codbarrio1           int,                   
@w_otrasenas1           varchar(254),
@w_distrito1            int,
@w_edificio1            varchar(40),
@w_co_igual_so1         char(1),
@w_descripcion11        varchar(254),
@w_parroquia11          int,
@w_barrio11             char(40),
@w_canton11             int,
@w_provincia11          int,
@w_calle11              varchar(70),
@w_casa11               varchar(40),
@w_pais11               smallint,              
@w_codbarrio11          int,                  
@w_otrasenas11          varchar(254),
@w_distrito11           int,
@w_edificio11           varchar(40),
@w_co_igual_so11        char(1),
@w_tipo2                catalogo, 
@w_tipo3                catalogo,
@w_co_igual_so2         char(1),  
@w_co_igual_so3         char(1),
@w_fecha_ver            datetime,
@v_fecha_ver            datetime,
@w_tiempo_reside        int,
@w_negocio	            int,
@v_negocio	            int,
@w_ci_poblacion         varchar(30),
@v_ci_poblacion         varchar(30),
@v_referencia           varchar(250),
@w_referencia           varchar(250)  ,
@w_count		        int,
@w_email                varchar(254),
-- TRABAJO DATOS GEOREFERENCIACION
@w_lat_coord            char(1),
@w_lat_grados           tinyint,
@w_lat_minutos          tinyint,
@w_lat_segundos         float,
@w_lon_coord            char(1),
@w_lon_grados           tinyint,
@w_lon_minutos          tinyint,
@w_lon_segundos         float,
@w_path_croquis         varchar(50),
@w_direccion_geo        int,
@w_telefono             varchar(16)

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_b2c_mantenimiento_direccion, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

select @w_sp_name = 'sp_b2c_mantenimiento_direccion'
select @w_estado_campo = null
select @w_iguales = 'S'

select @i_calle = replace(replace(replace(@i_calle,' ','<>'),'><',''),'<>',' ') --MTA

-- MTA INICIO 
--PARA LA VERSION BASE DE PRODUCTO SE SETEA VALORES POR DEFECTO
if (@i_oficina is null) 
   select @i_oficina = @s_ofi 

if (@i_rural_urbano is null)
   select @i_rural_urbano = 'N'


--INSERT
if @i_operacion = 'I'
begin

   if @t_trn = 1723 begin
   
      /* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
      if @@trancount = 0 begin
        select @w_commit = 'S'
        begin tran
      end

      if @i_principal = 'S' begin
         if exists (select di_ente from cobis..cl_direccion 
                     where  di_ente      = @i_ente 
                     and    di_principal = 'S')
         begin   
            select @w_error = 101187
			goto ERROR
         end
      end     
	    
      -- VERIFICAR SI ES PERSONA NATURAL O JURIDICA
      select @w_subtipo = en_subtipo from cobis..cl_ente where en_ente = @i_ente
      if @i_correspondencia ='S' 
      begin
         if exists(select 1 from cobis..cl_direccion where di_ente=@i_ente and di_correspondencia='S') begin
            select @w_error = 107268
			goto ERROR
         end
      end     

      -- VALIDA QUE NO EXISTA OTRO CORREO ELECTRONICO
	  /*if exists(select 1 from cobis..cl_direccion where di_tipo = 'CE' and ltrim(rtrim(di_descripcion)) = @i_descripcion) begin
            select @w_error = 101269
			goto ERROR
      end */
      
	  select @w_pais = pa_smallint from cobis..cl_parametro where pa_nemonico = 'PAIS'
	  
	  set rowcount 1
	  
      select @w_direccion = (select top 1 di_direccion from cobis..cl_direccion where di_ente = @i_ente order by di_direccion desc)                         

	  set rowcount 0 	
	  
      if @w_direccion is null begin
         select @w_direccion = 1
      end else begin
         select @w_direccion = @w_direccion + 1
      end
	  		  
      insert into cobis..cl_direccion(
      di_ente,            di_direccion,          di_descripcion,    di_parroquia,
      di_ciudad,          di_tipo,               di_telefono,       di_oficina,       
	  di_fecha_registro,  di_fecha_modificacion, di_vigencia,       di_verificado,    
	  di_funcionario,     di_fecha_ver,          di_principal,      di_barrio,       
	  di_provincia,       di_codpostal,          di_calle,          di_pais,           
	  di_codbarrio,       di_canton,             di_distrito,       di_nro,                
	  di_nro_interno,     di_poblacion,          di_referencia,     di_rural_urbano,
      di_correspondencia )
      values( 
      @i_ente,            @w_direccion,          @i_descripcion,    @i_parroquia,
      @i_ciudad ,         @i_tipo,               '0',               @i_oficina,       
	  @s_date,            @s_date,               'S',               'N',              
	  @s_user,            null,                  @i_principal,      @i_barrio,             
	  @i_provincia,       @i_codpostal,          @i_calle,          @w_pais,           
	  @i_codbarrio,       @i_canton,             @i_distrito,       @i_numero_ext_dom,
      @i_numero_int_dom,  @i_ci_poblacion,       @i_referencia,     @i_rural_urbano,
	  @i_correspondencia)  
       
      if @@error <> 0 begin
         select @w_error = 103007
		 goto ERROR
      end
         
      --VERIFICAR SI EL CLIENTE TIENE TELEFONOS POR ASOCIAR A DIRECCION PRINCIPAL (PROCESO DE BURO)
      if @i_principal = 'S' begin
         update cobis..cl_telefono
         set   te_direccion = @i_direccion
         where te_ente      = @i_ente
         and   te_direccion = 0          --PROCESO BURO DEJA TELEFONOS CON DIRECCION 0
      
         if @@error <> 0 begin
            select @w_error = 105034
			goto ERROR
         end
      end	  
	  
	  --TRANSACCION SERVICIOS - cobis..cl_direccion
      insert into  cobis..ts_direccion(
      secuencial,         tipo_transaccion, clase,           fecha,
      usuario,            terminal,         srv,             lsrv,
      ente,               direccion,        descripcion,     parroquia,        
	  ciudad,             tipo,             vigencia,        oficina,          
	  verificado,         barrio,           provincia,       calle,          
	  pais,               hora,            poblacion,        nro,                
	  nro_interno,      referencia,      canal)
      values(
      @s_ssn,             @t_trn,           'N',             @s_date,
      @s_user,            @s_term,          @s_srv,          @s_lsrv,
      @i_ente,            @w_direccion,     @i_descripcion,  @i_parroquia,     
	  @i_ciudad,          @i_tipo,          'S',             @s_ofi,           
	  'N',                @i_barrio,        @i_provincia,    @i_calle,        
	  @w_pais,            getdate(),        @i_ci_poblacion, @i_numero_ext_dom,             
	  @i_numero_int_dom,  @i_referencia,    @i_canal)
			   
      if @@error <> 0 begin
         select @w_error = 103005
		 GOTO ERROR
      end           
	  
	  exec sp_cseqnos
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_tabla      = 'cl_direccion_geo',
      @o_siguiente  = @w_direccion_geo out

      insert into cl_direccion_geo (
	  dg_ente,        dg_direccion,    dg_lat_coord,    dg_lat_grad, 
      dg_lat_min,     dg_lat_seg,      dg_long_coord,   dg_long_grad,
      dg_long_min,    dg_long_seg,     dg_path_croquis, dg_secuencial)
      values(
	  @i_ente,        @w_direccion,    @i_lat_coord,    @i_lat_grados, 
      @i_lat_minutos, @i_lat_segundos, @i_lon_coord,    @i_lon_grados,
      @i_lon_minutos, @i_lon_segundos, @i_path_croquis, @w_direccion_geo)
	  
	  if @@error <> 0 begin
         select @w_error = 103043
         GOTO ERROR
      end           

      -- TRANSACCION DE SERVICIO     
      -- VERIFICAR QUE EXISTA DIRECCION
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
               
      if @@error <> 0 begin
         select @w_error = 103005
         GOTO ERROR
      end
	  
	  update cobis..cl_ente
      set en_direccion = @w_direccion
      where en_ente = @i_ente
      
      if @@error <> 0
      begin
         select @w_error = 105034
		 goto ERROR
      end
	  
	  update cobis..cl_telefono
	  set te_direccion       = @w_direccion
	  where te_ente          = @i_ente
	  and   te_tipo_telefono = 'C'
	  
	  select @o_direccion = @w_direccion
	  
      if @w_commit = 'S' begin
         commit tran
         select @w_commit = 'N'
      end

      return 0
   end else begin
      select @w_error = 151051
	  goto ERROR
   end
end

return 0

ERROR:

if @@trancount <> 0 AND @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

exec sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_num   = @w_error

return @w_error

go

