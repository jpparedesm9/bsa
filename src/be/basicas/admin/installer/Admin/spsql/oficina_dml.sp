/************************************************************************/
/*  Archivo           : oficidml.sp                                     */
/*  Stored procedure  : sp_oficina_dml                                  */
/*  Base de datos     : cobis                                           */
/*  Producto          : Clientes                                        */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 12-Nov-1992                                     */
/************************************************************************/
/*                   IMPORTANTE                                         */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones del stored procedure        */
/*      Insercion de oficina                                            */
/*      Modificacion de oficina                                         */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  12/Nov/92   M. Davila     Emision Inicial                           */
/*  14/Ene/93   L. Carvajal   Tabla de errores, variables  debug        */
/*  11/Jun/93   S. Ortiz      Mantenimiento de datos redundants ad_ruta */
/*  23/Nov/93   R. Minga V.   Documentacion, param @s_, verif y validaac*/
/*  26/Abr/94   F.Espinosa    Parametros tipo 'S', Transacc de servc    */
/*  02/May/95   S. Vinces     Cambios para Admin Distribuido            */
/*  20/Feb/15   J. Guamani    Cambios tabla cl_oficina                  */
/*  24/Feb/15   L. Maldonado  Operacion G - Georeferenciacion           */
/*  30/Jun/15   O. Garcia     Inclusion de la Subregional               */
/*  11-04-2016  BBO           Migracion Sybase-Sqlserver FAL            */
/*  02/Jun/2016 R. Altamirano Cambios para oficina version BMI          */
/*  22/Jun/2016 J. Hernandez  Version Fal.                              */
/*  21-Mar-18   ALFNSI        Correcciones migracion                    */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_oficina_dml')
   drop proc sp_oficina_dml
go
create proc sp_oficina_dml (
       @s_ssn                      int         = null,
       @s_user                     login       = null,
       @s_sesn                     int         = null,
       @s_term                     varchar(32) = null,
       @s_date                     datetime    = null,
       @s_srv                      varchar(30) = null,
       @s_lsrv                     varchar(30) = null, 
       @s_rol                      smallint    = null,
       @s_ofi                      smallint    = null,
       @s_org_err                  char(1)     = null,
       @s_error                    int         = null,
       @s_sev                      tinyint     = null,
       @s_msg                      descripcion = null,
       @s_org                      char(1)     = null,
       @t_debug                    char(1)     = 'N',
       @t_file                     varchar(14) = null,
       @t_from                     varchar(32) = null,
       @t_trn                      smallint    = null,
       @t_show_version             bit         = 0, -- Mostrar la version del programa
       @i_operacion                varchar(1),
       @i_modo                     tinyint     = null,
       @i_tipo                     varchar(2)  = null,
       @i_oficina                  smallint    = null,
       @i_filial                   tinyint     = null,
       @i_nombre                   descripcion = null,
       @i_direccion                direccion   = null,
       @i_ciudad                   int         = null, /* PES version Colombia */
       @i_subtipo                  varchar (1) = null,
       @i_sucursal                 smallint    = null, /*CNA version Colombia*/
       @i_central_transmit         varchar(1)  = null,
       @i_area                     char(10)    = null,
       --                          
       @i_regional                 smallint    = null, --RAL 01.06.2016 modificaciones en oficina version BMI
       @i_subregional              varchar(10) = null, --SUBREGIONAL DE LA OFICINA
       @i_tip_punt_at              varchar(10) = null,
       @i_obs_horario              varchar(255)= null,
       @i_cir_comunic              varchar(20) = null,
       @i_nombre_encarg            varchar(64) = null,
       @i_ci_encarg                varchar(20) = null,
       --
       @i_horario                  tinyint     = null,
       @i_tipo_horario             varchar(10) = null,
       @i_jefe_agencia             int         = null,
       @i_codigo_fie_asfi          varchar(10) = null,
       @i_fecha_autorizacion_asfi  datetime    = null,
       @i_sector                   varchar(10) = null,
       @i_depart_pais              catalogo    = null,
       @i_provincia                int         = null,
       @i_relac_ofic               smallint    = null,
       -- georeferenciacion
       @i_lat_coord                char(1)     = null,
       @i_lat_grados               float       = null,
       @i_lat_minutos              float       = null,
       @i_lat_segundos             float       = null,
       @i_lon_coord                char(1)     = null,
       @i_lon_grados               float       = null,
       @i_lon_minutos              float       = null,
       @i_lon_segundos             float       = null,
       @i_barrio                   int         = null, --ADMIN CC0009
       --RAL 02.06.2016 modificaciones en oficina version BMI
       @i_zona                     int         = null,
       @i_cob                      int         = null,
       @i_bloqueada                char(1)     = 'N'     
   
   ) 
as
declare @w_sp_name             varchar(32),
        @w_aux                      int,
        @w_filial                   tinyint,
        @w_nombre                   descripcion,
        @w_direccion                direccion,
        @w_ciudad                   int, /* PES version Colombia */
        @w_subtipo                  char(1),
        @w_sucursal                 smallint, /*CNA version Colombia*/
        @w_siguiente                int,
        @w_return                   int,
        @v_filial                   tinyint,
        @v_nombre                   descripcion,
        @v_direccion                direccion,
        @v_ciudad                   int, /* PES version Colombia */
        @v_subtipo                  char(1),
        @v_sucursal                 smallint, /*CNA versioolombia*/
        @v_area                     char(10),
        @v_regional                 varchar(10),
        @v_subregional                 varchar(10),
        @v_barrio                   int,--ADMIN CC0009
        @v_tip_punt_at              varchar(10),
        @v_obs_horario              varchar(255),
        @v_cir_comunic              varchar(20),
        @v_nombre_encarg            varchar(64),
        @v_ci_encarg                varchar(20),
        @v_horario                  tinyint,
        @v_tipo_horario             varchar(10),
        @v_jefe_agencia             int,
        @v_codigo_fie_asfi          varchar(10),
        @v_fecha_autorizacion_asfi  datetime,
        @v_sector                   varchar(10),
        @v_depart_pais              catalogo,
        @v_provincia                int,
        @v_relac_ofic               smallint,
        -- georeferenciacion vista
        @v_lat_coord                char(1),
        @v_lat_grados               tinyint,
        @v_lat_minutos              tinyint,
        @v_lat_segundos             tinyint,
        @v_lon_coord                char(1),
        @v_lon_grados               tinyint,
        @v_lon_minutos              tinyint,
        @v_lon_segundos             tinyint,
        @w_codigo                   catalogo,  
        @w_bandera                  char(1) ,
        @w_cmdtransrv               varchar(60),
        @w_nt_nombre                varchar(30),
        @w_server_logico            varchar(10),
        @w_num_nodos                smallint,    
        @w_contador                 smallint,
        @w_clave                    int,
        @w_area                     char(10),
        @w_regional                 varchar(10),
        @w_subregional                 varchar(10),
        @w_barrio                    int,--ADMIN CC0009
        @w_tip_punt_at              varchar(10),
        @w_obs_horario              varchar(255),
        @w_cir_comunic              varchar(20),
        @w_nombre_encarg            varchar(64),
        @w_ci_encarg                varchar(20),
        @w_horario                  tinyint,
        @w_tipo_horario             varchar(10),
        @w_jefe_agencia             int,
        @w_codigo_fie_asfi          varchar(10),
        @w_fecha_autorizacion_asfi  datetime,
        @w_sector                   varchar(10),
        @w_depart_pais              catalogo,
        @w_provincia                int,
        @w_relac_ofic               smallint,
        -- georeferenciacion        
        @w_lat_coord                char(1),
        @w_lat_grados               float,
        @w_lat_minutos              float,
        @w_lat_segundos             float,
        @w_lon_coord                char(1),
        @w_lon_grados               float,
        @w_lon_minutos              float,
        @w_lon_segundos             float,
        --RAL 02.06.2016 modificaciones en oficina version BMI
        @w_subtipo_opcion           char(1),
        @w_cod_aux_ofi              int,
        @w_zona                     smallint,
        @w_cob                      smallint,
        @w_bloqueada                char(1),
        @v_zona                     smallint,
        @v_cob                      smallint,
        @v_bloqueada                char(1)
  

select @w_sp_name = 'sp_oficina_dml'
/***************VERSIONAMIENTO******************/
if @t_show_version = 1
begin
    print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.5'
    return 0
end


-- Valida codigo de transaccion
if  (@t_trn !=  1513   or @i_operacion != 'I')
and (@t_trn !=  1514   or @i_operacion != 'U')
and (@t_trn !=  15391  or @i_operacion != 'G')
begin
   select @w_return  = 151051
   goto ERROR
end

select @w_bandera = 'N'


--CREACION DE TABLA TEMPORAL DE NODOS A DISTRIBUIR 
--SI ESTA EN AMBIENTE UNIX SYBASE                 
if (@i_operacion = 'I' or @i_operacion = 'U') and (@i_central_transmit is null)  
   create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char (1) )

if @i_operacion in ('I','U')
begin
   --VERIFICAR SI EXISTE LE AREA
   select @w_aux = null
   from   cl_tabla a, 
          cl_catalogo b
   where  a.tabla  = 'cl_area_oficina'
   and    a.codigo = b.tabla
   and    b.codigo = @i_area
   
   if @@rowcount != 1
   begin
      select @w_return  = 101000
      goto ERROR
   end
end

-- INSERCION
if @i_operacion='I'
begin
   --VERIFICAR QUE LA OFICINA NO EXISTA ANTERIORMENTE
   select @w_aux=null
   from   cl_oficina
   where  of_oficina = @i_oficina    
   
   if @@rowcount != 0
   begin
      select @w_return  = 151053
      goto ERROR
   end 

   -- VERIFICAR SI EXISTE LA FILIAL 
   select @w_aux=null
   from   cl_filial
   where  fi_filial = @i_filial
   
   if @@rowcount != 1
   begin
      select @w_return  = 101002
      goto ERROR
   end

   -- VERIFICAR SI EXISTE LA CIUDAD 
   select @w_aux = null
   from   cl_ciudad
   where  ci_ciudad = @i_ciudad
   
   if @@rowcount != 1
   begin
      select @w_return  = 101024
      goto ERROR
   end

   -- VERIFICAR QUE SE TRATE DE AGENCIA O SUCURSAL
   if @i_subtipo not in ('O', 'Z', 'C', 'R')
   begin
      select @w_return  = 101046
      goto ERROR
   end
    

   --SI SE TRATA DE UNA AGENCIA, VERIFICAR QUE EXISTA LA SUCURSAL PROPIETARIA
   if @i_subtipo = 'A'
   begin
      select @w_aux=null
      from  cl_oficina
      where of_oficina = @i_sucursal
      and   of_subtipo = 'S'

      if @@rowcount != 1
      begin
         select @w_return  = 101028
         goto ERROR
      end
         
      if exists (select 1 from cl_oficina
                 where  of_oficina = @i_relac_ofic
                 and    of_subtipo = 'S')
      begin
         select @w_return  = 157223
         goto ERROR
      end
   end
    
   select @w_aux = 0
    
   if @i_subtipo = 'O'                                           
      select @w_subtipo_opcion = 'Z',                                           
             @w_cod_aux_ofi    = @i_zona                                                
   else if @i_subtipo = 'Z'                                                
        select @w_subtipo_opcion = 'R',                                                
               @w_cod_aux_ofi    = @i_regional
        
   if exists (select 1 from cl_oficina
              where  of_oficina = @w_cod_aux_ofi
               and   of_subtipo = @w_subtipo_opcion)
      select @w_aux = 1
      
   if @i_subtipo in ('O', 'Z', 'C')
   begin
      if @w_aux = 0
      begin
         select @w_return  = 101028
         goto ERROR   
      end
   end
    
    
   -- SI SE TRATA DE UNA SUCURSAL, NO TIENE SUCURSAL PROPIETARIA
   begin tran
      -- INSERTAR LOS DATOS DE ENTRADA 
    
      insert into cl_oficina 
             (of_filial,          of_oficina,                 of_nombre,
              of_direccion,       of_ciudad,                  of_telefono,
              of_subtipo,         of_sucursal,                of_area,     --RAL 02.06.2016 modificaciones en oficina version BMI
              of_regional,        of_tip_punt_at,             of_obs_horario,
              of_cir_comunic,     of_nomb_encarg,             of_ci_encarg,
              of_horario,         of_tipo_horar,              of_jefe_agenc,
              of_cod_fie_asf,     of_fec_aut_asf,             of_sector,
              of_depart_pais,     of_provincia,               of_relac_ofic,
              of_subregional,     of_barrio,                  of_zona,     
              of_cob,             of_bloqueada)         
      values (@i_filial,          @i_oficina,                 @i_nombre,
              @i_direccion,       @i_ciudad,                  0,
              @i_subtipo,         @i_sucursal,                @i_area,
              @i_regional,        @i_tip_punt_at,             @i_obs_horario,
              @i_cir_comunic,     @i_nombre_encarg,           @i_ci_encarg,
              @i_horario,         @i_tipo_horario,            @i_jefe_agencia,
              @i_codigo_fie_asfi, @i_fecha_autorizacion_asfi, @i_sector,
              @i_depart_pais,     @i_provincia,               @i_relac_ofic,
              @i_subregional,     @i_barrio,                  @i_zona,     
              @i_cob,             @i_bloqueada)           

      -- SI NO SE PUEDE INSERTAR, ERROR 
      if @@error != 0
      begin
         select @w_return  = 103049
         goto ERROR 
      end

      --TRANSACCION DE SERVICIO - OFICINA 
      insert into ts_oficina 
            (secuencia,    tipo_transaccion, clase,          fecha,          oficina_s,   
             usuario,      terminal_s,       srv,            lsrv,           hora,
             filial,       oficina,          nombre,         direccion,      ciudad,
             telefono,     subtipo,          sucursal,       area,           regional,
             tipo_punto,   obs_horario,      circular_comun, nombre_enc,     ci_encargado,
             horario,      tipo_horario,     jefe_agencia,   cod_fie_asfi,   fecha_aut_asfi, 
             sector,       depart_pais,      provincia,      relacion_ofic,  sub_regional,
             barrio,       zona,             of_cob)    
      values (@s_ssn,        1513,            'N',             @s_date,            @s_ofi, 
              @s_user,       @s_term,         @s_srv,          @s_lsrv,            getdate(),
              @i_filial,     @i_oficina,      @i_nombre,       @i_direccion,       @i_ciudad, 
              0,             @i_subtipo,      @i_sucursal,     @i_area,            @i_regional,
              @i_tip_punt_at,@i_obs_horario,  @i_cir_comunic,  @i_nombre_encarg,   @i_ci_encarg,
              @i_horario,    @i_tipo_horario, @i_jefe_agencia, @i_codigo_fie_asfi, @i_fecha_autorizacion_asfi,
              @i_sector,     @i_depart_pais,  @i_provincia,    @i_relac_ofic,      @i_subregional, 
              @i_barrio,     @i_zona,         @i_cob)  

      -- SI NO SE PUEDE INSERTAR, ERROR 
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      select @w_bandera = 'S'
   commit tran
   if @w_bandera = 'S'
   begin
   
      -- ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO 
      select @w_codigo = convert(varchar(10), @i_oficina)
      exec @w_return      = sp_catalogo
           @s_ssn         = @s_ssn,
           @s_user        = @s_user,
           @s_sesn        = @s_sesn,
           @s_term        = @s_term,   
           @s_date        = @s_date,   
           @s_srv         = @s_srv,   
           @s_lsrv        = @s_lsrv,   
           @s_rol         = @s_rol,
           @s_ofi         = @s_ofi,
           @s_org_err     = @s_org_err,
           @s_error       = @s_error,
           @s_sev         = @s_sev,
           @s_msg         = @s_msg,
           @s_org         = @s_org,
           @t_debug       = @t_debug,   
           @t_file        = @t_file,
           @t_from        = @w_sp_name,
           @t_trn         = 584,
           @i_operacion   = 'I',
           @i_tabla       = 'cl_oficina',
           @i_codigo      = @w_codigo,
           @i_descripcion = @i_nombre,
           @i_estado      = 'V'   
           
      if @w_return != 0
         return @w_return
   end       -- Para unix termina la validacion

   insert into #ad_nodo_reentry_tmp
   select nl_nombre,'N'
   from   ad_nodo_oficina,
          ad_server_logico
   where  nl_nombre  != @s_lsrv          
   and    nl_filial   = sg_filial_i   
   and    nl_oficina  = sg_oficina_i 
   and    nl_nodo     = sg_nodo_i    
   and    sg_producto = 1             
   and    sg_tipo     = 'R'           
   and    sg_moneda   = 0             

   select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

   select @w_contador = 1
   while @w_contador <= @w_num_nodos
   begin
      set rowcount 1
      select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
      from   #ad_nodo_reentry_tmp
      where  nt_bandera = 'N'
      
      set rowcount 0

      update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
      where nt_nombre = @w_nt_nombre

      exec @w_return           = @w_cmdtransrv  
           @t_trn              = @t_trn,           
           @i_operacion        = @i_operacion,
           @i_oficina          = @i_oficina,
           @i_filial           = @i_filial,
           @i_nombre           = @i_nombre,
           @i_direccion        = @i_direccion,
           @i_ciudad           = @i_ciudad,
           @i_subtipo          = @i_subtipo,
           @i_sucursal         = @i_sucursal,
           @i_central_transmit = 'S',
           @o_clave            = @w_clave out

      if @w_return != 0
         return @w_return
      
      exec @w_return = cobis..sp_reentry
         @i_key = @w_clave,
         @i_tipo = 'I'
      
      if @w_return != 0
         return @w_return
      
      select @w_contador = @w_contador + 1
      continue
   end
   delete #ad_nodo_reentry_tmp
end


-- UPDATE
if @i_operacion ='U'
begin
   -- VERIFICAR QUE EXISTA LA OFICINA
   select @w_nombre          = of_nombre,
          @w_direccion       = of_direccion,
          @w_ciudad          = of_ciudad,
          @w_sucursal        = of_sucursal, --RAL 02.06.2016 modificaciones en oficina version BMI
          @w_subtipo         = of_subtipo,
          @w_area            = of_area,
          @w_regional        = of_regional,
          @w_tip_punt_at     = of_tip_punt_at,
          @w_obs_horario     = of_obs_horario,
          @w_cir_comunic     = of_cir_comunic,
          @w_nombre_encarg   = of_nomb_encarg,
          @w_ci_encarg       = of_ci_encarg,
          @w_horario         = of_horario,
          @w_tipo_horario    = of_tipo_horar,
          @w_jefe_agencia    = of_jefe_agenc,
          @w_codigo_fie_asfi = of_cod_fie_asf,
          @w_fecha_autorizacion_asfi = of_fec_aut_asf,
          @w_sector          = of_sector,
          @w_depart_pais     = of_depart_pais,
          @w_provincia       = of_provincia,
          @w_relac_ofic      = of_relac_ofic,
          @w_subregional     = of_subregional,
          @w_barrio          = of_barrio,--ADMIN CC0009
          @w_zona            = of_zona,    --RAL 02.06.2016 modificaciones en oficina version BMI
          @w_cob             = of_cob,      --RAL 02.06.2016 modificaciones en oficina version BMI
          @w_bloqueada       = of_bloqueada -- JGHL version fal        
   from   cl_oficina
   where  of_oficina = @i_oficina
   
   if @@rowcount != 1
   begin
      select @w_return  = 101016
      goto ERROR
   end
   
   -- VERIFICAR QUE EXISTA LA CIUDAD
   select @w_aux=null
   from cl_ciudad
   where ci_ciudad = @i_ciudad
   
   
   if @@rowcount != 1
   begin
      select @w_return  = 101024
      goto ERROR
   end
   
   -- VERIFICAR QUE EXISTA LA SUCURSAL PROPIETARIA DE LA AGENCIA
   -- SI SE TRATA DE UNA AGENCIA
   if @i_subtipo = 'A'
   begin
     select @w_aux=null
     from  cl_oficina
     where of_oficina = @i_sucursal
     and   of_subtipo = 'S'
     
      if @@rowcount != 1
      begin
         select @w_return  = 101028
         goto ERROR
      end

      if exists (select 1 from cl_oficina
                 where  of_oficina = @i_relac_ofic
                 and    of_subtipo = 'S')
      begin
        select @w_return  = 157223
        goto ERROR
      end
   end
  
   -- SI NO ES AGENCIA, SE TRATA DE SUCURSAL QUE NO TIENE SUCURSAL 
   -- PROPIETARIA
   -- VERIFICAR QUE SI ERA SUCURSAL Y SE VA A CONVERTIR EN AGENCIA
   -- NO DEBE TENER AGENCIAS DEPENDIENDO DE ELLA   
   if @i_subtipo = 'A' and @w_subtipo='S'
   begin      
      if exists (select of_oficina
                 from  cl_oficina
                 where a_sucursal = @i_oficina
                 and   of_subtipo = 'A')
      begin        
         select @w_return  = 151062
         goto ERROR
      end
   end
   
   -- VERIFICAR QUE SI ERA AGENCIA Y SE VA A CONVERTIR EN PUNTO DE ATENCION
   -- NO DEBE TENER AGENCIAS DEPENDIENTES
   if @i_subtipo = 'A' and @i_tip_punt_at !='AG' and @i_tip_punt_at !='SUC'
   begin         
      if exists (select of_oficina
                 from  cl_oficina
                 where of_relac_ofic = @i_oficina
                 and   of_subtipo = 'A')
      begin
         select @w_return  = 157949
         goto ERROR  
      end
   end
   
   select @w_aux = 0
    
   if @i_subtipo = 'O'                                           
      select @w_subtipo_opcion = 'Z',                                            
             @w_cod_aux_ofi    = @i_zona                                           
   else if @i_subtipo = 'Z'                                           
      select @w_subtipo_opcion = 'R',                                            
             @w_cod_aux_ofi    = @i_regional
      
   if exists (select 1 from cl_oficina
              where  of_oficina = @w_cod_aux_ofi
              and    of_subtipo = @w_subtipo_opcion)
      select @w_aux = 1
     
   if @i_subtipo in ('O', 'Z', 'C')
   begin
      if @w_aux = 0
      begin
         select @w_return  = 101028
         goto ERROR
      end
   end
   
   -- GUARDAR LOS DATOS ANTERIORES
   select @v_nombre                  = @w_nombre,
          @v_direccion               = @w_direccion,
          @v_ciudad                  = @w_ciudad,
          @v_sucursal                = @w_sucursal,
          @v_area                    = @w_area,
          @v_regional                = @w_regional,
          @v_tip_punt_at             = @w_tip_punt_at,
          @v_obs_horario             = @w_obs_horario,
          @v_cir_comunic             = @w_cir_comunic,
          @v_nombre_encarg           = @w_nombre_encarg,
          @v_ci_encarg               = @w_ci_encarg,
          @v_horario                 = @w_horario,
          @v_tipo_horario            = @w_tipo_horario,
          @v_jefe_agencia            = @w_jefe_agencia,
          @v_codigo_fie_asfi         = @w_codigo_fie_asfi,
          @v_fecha_autorizacion_asfi = @w_fecha_autorizacion_asfi,
          @v_sector                  = @w_sector,
          @v_depart_pais             = @w_depart_pais,
          @v_provincia               = @w_provincia,
          @v_relac_ofic              = @w_relac_ofic,
          @v_subregional             = @w_subregional,
          @v_barrio                  = @w_barrio,     --ADMIN CC 0009
          @v_zona                    = @w_zona,      
          @v_cob                     = @w_cob,       
          @v_bloqueada               = @w_bloqueada
      
   if @w_nombre = @i_nombre
      select @w_nombre = null, @v_nombre = null
   else
      select @w_nombre = @i_nombre
      
   if @w_direccion = @i_direccion
      select @w_direccion= null, @v_direccion= null
   else
      select @w_direccion= @i_direccion
   
   if @w_ciudad = @i_ciudad
      select @w_ciudad= null, @v_ciudad= null
   else
      select @w_ciudad= @i_ciudad
   
   if @w_sucursal = @i_sucursal
      select @w_sucursal= null, @v_sucursal= null
   else
      select @w_sucursal= @i_sucursal
   
   if @w_area = @i_area
      select @w_area= null, @v_area= null
   else
      select @w_area= @i_area
   
   if @w_regional = @i_regional
      select @w_regional= null, @v_regional= null
   else
      select @w_regional= @i_regional
   
   if @w_tip_punt_at = @i_tip_punt_at
      select @w_tip_punt_at= null, @v_tip_punt_at= null
   else
      select @w_tip_punt_at= @i_tip_punt_at        --RAL 01.06.2016 modificaciones en oficina version BMI
   
   if @w_obs_horario = @i_obs_horario
      select @w_obs_horario = null, @v_obs_horario= null
   else
      select @w_obs_horario= @i_obs_horario
   
   if @w_cir_comunic = @i_cir_comunic
      select @w_cir_comunic = null, @v_cir_comunic= null
   else
      select @w_cir_comunic= @i_cir_comunic
   
   if @w_nombre_encarg = @i_nombre_encarg
      select @w_nombre_encarg = null, @v_nombre_encarg= null
   else
      select @w_nombre_encarg = @i_nombre_encarg
   
   if @w_ci_encarg = @i_ci_encarg
      select @w_ci_encarg = null, @v_ci_encarg= null
   else
      select @w_ci_encarg = @i_ci_encarg
      
   if @w_horario = @i_horario
      select @w_horario = null, @v_horario= null
   else
      select @w_horario = @i_horario
   
   if @w_tipo_horario = @i_tipo_horario
      select @w_tipo_horario = null, @v_tipo_horario= null
   else
      select @w_tipo_horario = @i_tipo_horario
   
   if @w_jefe_agencia = @i_jefe_agencia
      select @w_jefe_agencia = null, @v_jefe_agencia= null
   else
      select @w_jefe_agencia = @i_jefe_agencia 
     
   if @w_codigo_fie_asfi = @i_codigo_fie_asfi
      select @w_codigo_fie_asfi = null, @v_codigo_fie_asfi= null
   else
      select @w_codigo_fie_asfi = @i_codigo_fie_asfi
   
   if @w_fecha_autorizacion_asfi = @i_fecha_autorizacion_asfi
      select @w_fecha_autorizacion_asfi = null, @v_fecha_autorizacion_asfi= null
   else
      select @w_fecha_autorizacion_asfi = @i_fecha_autorizacion_asfi  
   
   if @w_sector = @i_sector
      select @w_sector = null, @v_sector= null
   else
      select @w_sector = @i_sector
    
   if @w_depart_pais = @i_depart_pais
      select @w_depart_pais = null, @v_depart_pais = null
   else
      select @w_depart_pais = @i_depart_pais
    
   if @w_provincia = @i_provincia
      select @w_provincia = null, @v_provincia = null
   else
      select @w_provincia = @i_provincia

   if @w_relac_ofic = @i_relac_ofic
      select @w_relac_ofic = null, @v_relac_ofic = null
   else
      select @w_relac_ofic = @i_relac_ofic

   if @w_subregional = @i_subregional
      select @w_subregional = null, @v_subregional = null
   else
      select @w_subregional = @i_subregional
   
   --ADMIN CC 0009
   if @w_barrio = @i_barrio
      select @w_barrio = null, @v_barrio = null
   else
      select @w_barrio = @i_barrio
   
   --RAL 02.06.2016 modificaciones en oficina version BMI   
   if @w_zona = @i_zona
      select @w_zona = null, @v_zona = null
   else
      select @w_zona = @i_zona

   if @w_cob = @i_cob
       select @w_cob = null, @v_cob = null
   else
       select @w_cob = @i_cob    
       
   begin tran

      -- MODIFICAR LOS DATOS
      update cl_oficina 
      set    of_nombre      = @i_nombre,
             of_direccion   = @i_direccion,
             of_ciudad      = @i_ciudad,
             of_sucursal    = @i_sucursal,  --RAL 02.06.2016 modificaciones en oficina version BMI
             of_subtipo     = @i_subtipo,
             of_area        = @i_area,
             of_regional    = @i_regional,
             of_tip_punt_at = @i_tip_punt_at,
             of_obs_horario = @i_obs_horario,
             of_cir_comunic = @i_cir_comunic,
             of_nomb_encarg = @i_nombre_encarg,
             of_ci_encarg   = @i_ci_encarg,
             of_horario     = @i_horario,
             of_tipo_horar  = @i_tipo_horario,
             of_jefe_agenc  = @i_jefe_agencia,
             of_cod_fie_asf = @i_codigo_fie_asfi,
             of_fec_aut_asf = @i_fecha_autorizacion_asfi,
             of_sector      = @i_sector,
             of_depart_pais = @i_depart_pais,
             of_provincia   = @i_provincia,
             of_relac_ofic  = @i_relac_ofic,
             of_subregional = @i_subregional,
             of_barrio      = @i_barrio, --ADMIN CC0009
             of_zona        = @i_zona,
             of_cob         = @i_cob,
             of_bloqueada   = @i_bloqueada
      where  of_oficina     = @i_oficina

      -- SI NO SE PUEDE MODIFICAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 105049
         goto ERROR
      end
   
      if @i_subtipo = 'Z' --Actualizo Oficina Tipo Z debe actualizar los datos de las oficinas tipo O segun la Zona
      begin
         update cl_oficina 
         set    of_regional = @i_regional
         where  of_zona     = @i_oficina
         
         if @@error != 0
         begin
            select @w_return  = 105049
            goto ERROR
         end
      end

      --  MANTIENTE ACTUALIZADOS LOS DATOS REDUNDATES DE AD_RUTA
      if @w_nombre is not null
      begin
         update ad_ruta
         set   ru_nombre_o_d = @i_nombre
         where ru_oficina_d  = @i_oficina

         if @@error != 0
         begin
            select @w_return  = 155018
            goto ERROR
         end

         update   ad_ruta
         set   ru_nombre_o_h = @i_nombre
         where   ru_oficina_h = @i_oficina

         if @@error != 0
         begin
            select @w_return  = 155018
            goto ERROR
         end
      end

      -- TRANSACCION DE SERVICIO - OFICINA */
      insert into ts_oficina 
             (secuencia,          tipo_transaccion,           clase,           fecha,           oficina_s, 
              usuario,            terminal_s,                 srv,             lsrv,            hora,    
              oficina,            nombre,                     direccion,       ciudad,          sucursal,  
              area,               regional,                   tipo_punto,      obs_horario,     circular_comun,
              nombre_enc,         ci_encargado,               horario,         tipo_horario,    jefe_agencia,  
              cod_fie_asfi,       fecha_aut_asfi,             sector,          depart_pais,     provincia,
              relacion_ofic,      sub_regional,               barrio,          zona,            of_cob)  
      values (@s_ssn,             1514,                       'P',             @s_date,         @s_ofi, 
              @s_user,            @s_term,                    @s_srv,          @s_lsrv,         getdate(),
              @i_oficina,         @v_nombre,                  @v_direccion,    @v_ciudad,       @v_sucursal,
              @v_area,            @v_regional,                @v_tip_punt_at,  @v_obs_horario,  @v_cir_comunic,
              @v_nombre_encarg,   @v_ci_encarg,               @v_horario,      @v_tipo_horario, @v_jefe_agencia,
              @v_codigo_fie_asfi, @v_fecha_autorizacion_asfi, @v_sector,       @v_depart_pais,  @v_provincia,
              @v_relac_ofic,      @v_subregional,             @v_barrio,       @v_zona,         @v_cob)  
      
      -- SI NO SE PUEDE INSERTAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      -- TRANSACCION DE SERVICIO - OFICINA
      insert into ts_oficina 
             (secuencia,            tipo_transaccion,             clase,            fecha,              oficina_s, 
              usuario,              terminal_s,                   srv,              lsrv,               hora,
              oficina,              nombre,                       direccion,        ciudad,             sucursal,
              area,                 regional,                     tipo_punto,       obs_horario,        circular_comun,
              nombre_enc,           ci_encargado,                 horario,          tipo_horario,       jefe_agencia,
              cod_fie_asfi,         fecha_aut_asfi,               sector,           depart_pais,        provincia,
              relacion_ofic,        sub_regional,                 barrio,           zona,               of_cob)                 
      values (@s_ssn,               1514,                         'A',              @s_date,            @s_ofi, 
              @s_user,              @s_term,                      @s_srv,           @s_lsrv,            getdate(),
              @i_oficina,           @w_nombre,                    @w_direccion,     @w_ciudad,          @w_sucursal, 
              @w_area,              @w_regional,                  @w_tip_punt_at,   @w_obs_horario,     @w_cir_comunic,
              @w_nombre_encarg,     @w_ci_encarg,                 @w_horario,       @w_tipo_horario,    @v_jefe_agencia,
              @w_codigo_fie_asfi,   @w_fecha_autorizacion_asfi,   @w_sector,        @w_depart_pais,     @w_provincia,
              @w_relac_ofic,        @w_subregional,               @w_barrio,        @w_zona,            @w_cob)  
      
      -- SI NO SE PUEDE INSERTAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      select @w_bandera = 'S'
   commit tran
   
   if @w_bandera = 'S'
   begin
      
      -- ACTUALIZACION DE LA LOS DATOS EN EL CATALOGO
             
      select @w_codigo = convert(varchar(10), @i_oficina)
      exec @w_return = sp_catalogo
           @s_ssn          = @s_ssn,
           @s_user         = @s_user,
           @s_sesn         = @s_sesn,
           @s_term         = @s_term,   
           @s_date         = @s_date,   
           @s_srv          = @s_srv,   
           @s_lsrv         = @s_lsrv,   
           @s_rol          = @s_rol,
           @s_ofi          = @s_ofi,
           @s_org_err      = @s_org_err,
           @s_error        = @s_error,
           @s_sev          = @s_sev,
           @s_msg          = @s_msg,
           @s_org          = @s_org,
           @t_debug        = @t_debug,   
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @t_trn          = 585,
           @i_operacion    = 'U',
           @i_tabla        = 'cl_oficina',
           @i_codigo       = @w_codigo,
           @i_descripcion  = @i_nombre,
           @i_estado       = 'V'   
      if @w_return != 0
         return @w_return
   end
      
   /********************   Para   Unix     ***************************/

   insert into #ad_nodo_reentry_tmp
   select nl_nombre,'N'
   from   ad_nodo_oficina,ad_server_logico
   where  nl_nombre  != @s_lsrv          
   and    nl_filial   = sg_filial_i   
   and    nl_oficina  = sg_oficina_i 
   and    nl_nodo     = sg_nodo_i    
   and    sg_producto = 1             
   and    sg_tipo     = 'R'           
   and    sg_moneda   = 0             

   select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

   select @w_contador = 1
   while @w_contador <= @w_num_nodos
   begin
      set rowcount 1
      select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
      from   #ad_nodo_reentry_tmp
      where nt_bandera = 'N'
      
      set rowcount 0

      update #ad_nodo_reentry_tmp  
      set    nt_bandera = 'S'
      where  nt_nombre  = @w_nt_nombre

      exec @w_return = @w_cmdtransrv  
           @t_trn         = @t_trn,           
           @i_operacion   = @i_operacion,
           @i_oficina     = @i_oficina,
           @i_filial      = @i_filial,
           @i_nombre      = @i_nombre,
           @i_direccion   = @i_direccion,
           @i_ciudad      = @i_ciudad,
           @i_subtipo     = @i_subtipo,
           @i_sucursal    = @i_sucursal,
           @i_central_transmit = 'S',
           @o_clave        = @w_clave out

      if @w_return != 0
         return @w_return

      exec @w_return = cobis..sp_reentry
         @i_key = @w_clave,
         @i_tipo = 'I'

      if @w_return != 0
         return @w_return

      select @w_contador = @w_contador + 1
      continue
   end
   delete #ad_nodo_reentry_tmp
end

-- GEOREFERENCIACION
if @i_operacion ='G'
begin

   -- VERIFICAR QUE EXISTA LA OFICINA
   select @w_lat_coord    = of_lat_coord,
          @w_lat_grados   = of_lat_grad,
          @w_lat_minutos  = of_lat_min,
          @w_lat_segundos = of_lat_seg,
          @w_lon_coord    = of_long_coord,
          @w_lon_grados   = of_long_grad,
          @w_lon_minutos  = of_long_min,
          @w_lon_segundos = of_long_seg
   from   cl_oficina, 
          cl_filial
   where  of_oficina = @i_oficina
   and    of_filial  = @i_filial
   and    of_filial  = fi_filial
      
   -- GUARDAR LOS DATOS ANTERIORES 
   select @v_lat_coord    = @w_lat_coord,
          @v_lat_grados   = @w_lat_grados,
          @v_lat_minutos  = @w_lat_minutos,
          @v_lat_segundos = @w_lat_segundos,
          @v_lon_coord    = @w_lon_coord,
          @v_lon_grados   = @w_lon_grados,
          @v_lon_minutos  = @w_lon_minutos,
          @v_lon_segundos = @w_lon_segundos
   
   if @w_lat_coord = @i_lat_coord
      select @w_lat_coord = null, @v_lat_coord = null
   else
      select @w_lat_coord = @i_lat_coord
   
   if @w_lat_grados = @i_lat_grados
      select @w_lat_grados= null, @v_lat_grados= null
   else
      select @w_lat_grados= @i_lat_grados
   
   if @w_lat_minutos = @i_lat_minutos
      select @w_lat_minutos= null, @v_lat_minutos= null
   else
      select @w_lat_minutos= @i_lat_minutos
   
   if @w_lat_segundos = @i_lat_segundos
      select @w_lat_segundos= null, @v_lat_segundos= null
   else
      select @w_lat_segundos= @i_lat_segundos
   
   if @w_lon_coord = @i_lon_coord
      select @w_lon_coord= null, @v_lon_coord= null
   else
      select @w_lon_coord= @i_lon_coord
   
   if @w_lon_grados = @i_lon_grados
      select @w_lon_grados= null, @v_lon_grados= null
   else
      select @w_lon_grados= @i_lon_grados
   
   if @w_lon_minutos = @i_lon_minutos
      select @w_lon_minutos= null, @v_lon_minutos= null
   else
      select @w_lon_minutos= @i_lon_minutos
   
   if @w_lon_segundos = @i_lon_segundos
      select @w_lon_segundos= null, @v_lon_segundos= null
   else
      select @w_lon_segundos= @i_lon_segundos 
   
   begin tran
    
      -- MODIFICAR LOS DATOS
      update cl_oficina 
      set    of_lat_coord  = @i_lat_coord,
             of_lat_grad   = @i_lat_grados,
             of_lat_min    = @i_lat_minutos,
             of_lat_seg    = @i_lat_segundos,
             of_long_coord = @i_lon_coord,
             of_long_grad  = @i_lon_grados,
             of_long_min   = @i_lon_minutos,
             of_long_seg   = @i_lon_segundos
      where  of_oficina  = @i_oficina
    
      -- SI NO SE PUEDE MODIFICAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 105049
         goto ERROR
      end
      
      -- TRANSACCION DE SERVICIO - OFICINA
      insert into ts_oficina_geo 
             (secuencia,       tipo_transaccion, clase,            fecha,
              oficina_s,       usuario,          terminal_s,       srv, 
              lsrv,            hora,             oficina,          filial,
              latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
              longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos)
      values (@s_ssn,          15391,            'P',              @s_date,
              @s_ofi,          @s_user,          @s_term,          @s_srv, 
              @s_lsrv,         getdate(),        @i_oficina,       @i_filial,  
              @v_lat_coord,    @v_lat_grados,    @v_lat_minutos,   @v_lat_segundos,
              @v_lon_coord,    @v_lon_grados,    @v_lon_minutos,   @v_lon_segundos)
        
      -- SI NO SE PUEDE INSERTAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      -- TRANSACCION DE SERVICIO - OFICINA
      
      insert into ts_oficina_geo 
             (secuencia,       tipo_transaccion, clase,            fecha,
              oficina_s,       usuario,          terminal_s,       srv, 
              lsrv,            hora,             oficina,          filial,
              latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
              longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos)
      values (@s_ssn,          15391,            'A',              @s_date,
              @s_ofi,          @s_user,          @s_term,          @s_srv, 
              @s_lsrv,         getdate(),        @i_oficina,       @i_filial,  
              @w_lat_coord,    @w_lat_grados,    @w_lat_minutos,   @w_lat_segundos,
              @w_lon_coord,    @w_lon_grados,    @w_lon_minutos,   @w_lon_segundos)
      
      -- SI NO SE PUEDE INSERTAR, ERROR
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
         
   commit tran
end

return 0

ERROR:
   exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
   /*  'No corresponde codigo de transaccion' */
   return @w_return
go


