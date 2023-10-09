/* ********************************************************************* */
/*   Archivo:              sp_bsa_crear_direccion.sp                     */
/*   Stored procedure:     sp_bsa_crear_direccion                        */
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
/*   21/Agosto/2020    S. Rojas          Créditos de Gobierno            */
/* ********************************************************************* */

use cobis
go

IF OBJECT_ID ('dbo.sp_bsa_crear_direccion') IS NOT NULL
	DROP PROCEDURE dbo.sp_bsa_crear_direccion
GO

create proc sp_bsa_crear_direccion (
   @s_ssn                int,
   @s_user               login        = null,
   @s_sesn               int          = null,
   @s_culture            varchar(10)  = null,
   @s_term               varchar(32)  = null,
   @s_date               datetime,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @s_ofi                smallint     = null,
   @s_rol                smallint     = null,
   @s_org_err            char(1)      = null,
   @s_error              int          = null,
   @s_sev                tinyint      = null,
   @s_msg                descripcion  = null,
   @s_org                char(1)      = null,
   @t_debug              char(1)      = 'N',
   @t_file               varchar(10)  = null,
   @t_from               varchar(32)  = null,
   @t_trn                smallint     = null,
   @i_operacion          char(1),             -- Opcion con la que se ejecuta el programa
   @i_ente               int          = null, -- Codigo secuencial del cliente
   @i_direccion          tinyint      = null, -- Numero de la direccion que se asigna al Cliente
   @i_descripcion        varchar(254) = null, -- Descripcion de la direccion
   @i_tipo               catalogo     = null, -- Tipo de direccion
   @i_sector             catalogo     = null, -- En el caso de direccion extranjera, se almacena el pais
   @i_parroquia          int          = null, -- Codigo de la parroquia de la direccion
   @i_barrio             char(40)     = null, -- Codigo del barrio
   @i_zona               catalogo     = null, -- Codigo de la zona postal 
   @i_ciudad             int           = null,-- Codigo del municipio / ito de int a smallint
   @i_oficina            smallint     = null, -- Codigo de la oficina
   @i_verificado         char(1)      = 'N', -- Indicador si esta verificado
   @i_fecha_ver          datetime      = null,-- Fecha de verificacion
   @i_principal          char(1)      = 'N',  -- Indicador si la direccion es principal
   @i_provincia          int          = null, -- Codigo del departamento
   @i_codpostal          varchar(30)      = null, -- Codigo Postal
   @i_define             char(1)      = 'N',  -- Indicador de validacion cuando las direcciones no son ni mail,web, extranjera
   @i_casa               varchar(40)  = null, -- Casa del cliente
   @i_calle              varchar(70)  = null, -- Indica la Calle      -- TVI 05/31/2011   INC 2124
   @i_cliente_casual     char(1)      = null, -- GC Cliente Casual
   @i_tiempo_reside      int          = null, -- Tiempo de residencia
   @o_dire               int          = null out,
   @i_pais               smallint     = null,
   @i_canton             int          = null,
   @i_codbarrio          int          = null,
   @i_distrito           int          = null,
   @i_correspondencia    char(1)      = null,
   @i_alquilada          char(1)      = null,
   @i_cobro              char(1)      = null,
   @i_otrasenas          varchar(254) = null,
   @i_montoalquiler      money        = null,
   @i_edificio           varchar(40)  = null,
   -- nuevos campos
   @i_rural_urbano       char(1)      = null,
   @i_departamento       varchar(10)  = null,
   @i_fact_serv_pu       char(1)      = 'N',
   @i_tipo_prop          char(10)     = null,
   --
   @o_pais               smallint     = null out,
   @o_canton             int          = null out,
   @o_codbarrio          int          = null out,
   @o_correspondencia    char(1)      = null out,
   @o_alquilada          char(1)      = null out,
   @o_cobro              char(1)      = null out,
   @i_ejecutar           char(1)      ='N',        --MALDAZ 06/25/2012 HSBC CLI-0565
   @t_show_version       bit          = 0,    -- Mostrar la versiï¿½n del programa
   @i_co_igual_so        char(1)      = null,
   @i_nombre_agencia     varchar(20)  = null,
   @i_fuente_verif       varchar(10)  = null,
   @i_nro                varchar(30)  = null, 		--numero de la calle
   @i_nro_residentes     int          = null, 		--Numero de residentes en el domicilio
   @i_nro_interno        varchar(30)  = null, 		--numero de la calle
   @i_negocio            int          = null, 		--Negocio
   @i_batch              char(1)      = 'N',  -- LGU: sp que se dispara desde FE o BATCH
   @i_ci_poblacion       varchar(100)   = null, 		--ciudad Poblacion
   @i_referencia         varchar(250) = null
)
as
declare
@w_transaccion         int,
@w_sp_name             varchar(32),
@w_codigo              int,
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
@o_direccion           tinyint,
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
@w_negocio	           int,
@v_negocio	           int,
@w_ci_poblacion         varchar(30),
@v_ci_poblacion         varchar(30),
@v_referencia           varchar(250),
@w_referencia           varchar(250)  ,
@w_count		           int,
@w_email                varchar(254)   

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_bsa_crear_direccion, Version 4.0.0.30'
    return 0
end
--------------------------------------------------------------------------------------

select @w_sp_name = 'sp_bsa_crear_direccion'
select @w_estado_campo = null
select @w_iguales = 'S'

select @i_calle = replace(replace(replace(@i_calle,' ','<>'),'><',''),'<>',' ') --MTA

-- MTA INICIO 
--PARA LA VERSION BASE DE PRODUCTO SE SETEA VALORES POR DEFECTO
if (@i_oficina is null) 
   select @i_oficina = @s_ofi 
   
/*if (@i_departamento is null)
   select @i_departamento = 'NE'*/
if (@i_rural_urbano is null)
   select @i_rural_urbano = 'N'
/*if (@i_tipo_prop is null)
   select @i_tipo_prop = 'NE'   */
--MTA FIN

--INSERT
if @i_operacion = 'I'
begin

   if @t_trn = 109 begin

      --NO SE REALIZA VALIDACION DE PREEXISTENCIA DE CORREO PARA CREDITOS DE GOBIERNO
      --if @i_tipo = 'CE' and exists(select 1 from cobis..cl_direccion where di_descripcion = ltrim(rtrim(@i_descripcion)) and di_tipo = 'CE') begin
      --   return 721909
      --end
                    
      --VERIFICAR QUE NO EXISTA MAS DE UNA DIRECCION COMO PRINCIPAL NVR
      if @i_principal = 'S' begin
         if exists (select di_ente from cobis..cl_direccion 
                     where  di_ente      = @i_ente 
                     and    di_principal = 'S')
         begin   
            return 101187
         end
      end
      
      -- VERIFICAR SI ES PERSONA NATURAL O JURIDICA
      select @w_subtipo = en_subtipo from cobis..cl_ente where en_ente = @i_ente
      if @i_correspondencia ='S' 
      begin
         if exists(select 1 from cobis..cl_direccion where di_ente=@i_ente and di_correspondencia='S') begin
            return 107268
         end
      end

      update cobis..cl_ente
      set en_direccion = isnull(en_direccion,0) + 1
      where en_ente = @i_ente
      
      if @@error <> 0
      begin
         return 105034
      end
      
	  set rowcount 1
	  
      select @o_siguiente = (select top 1 di_direccion from cobis..cl_direccion where di_ente = @i_ente order by di_direccion desc)                         
      
	  set rowcount 0 	
	  
      if @o_siguiente is null begin
         select @o_siguiente = 1
      end else begin
         select @o_siguiente = @o_siguiente + 1
      end
      				
      if @i_negocio = 0
      begin
      	select @i_negocio = null
      end
      				
      insert into cobis..cl_direccion(
      di_ente,            di_direccion,     di_descripcion,    di_parroquia,
      di_ciudad,          di_tipo,          di_telefono,       di_sector,
      di_zona,            di_oficina,       di_fecha_registro, di_fecha_modificacion,
      di_vigencia,        di_verificado,    di_funcionario,    di_fecha_ver,
      di_principal,       di_barrio,        di_provincia,      di_codpostal, 
      di_casa,            di_calle,         di_pais,           di_codbarrio,
      di_correspondencia, di_alquilada,     di_cobro,          di_otrasenas, 
      di_canton,          di_distrito,      di_montoalquiler,  di_edificio, 
      di_so_igu_co,       di_rural_urbano,  di_departamento,   di_fact_serv_pu,
      di_tipo_prop,       di_nombre_agencia,di_tiempo_reside,  di_nro,
      di_nro_residentes,  di_nro_interno,   di_negocio,        di_poblacion,
      di_referencia	  )
      values( 
      @i_ente,            @o_siguiente,     @i_descripcion,    @i_parroquia,
      @i_ciudad ,         @i_tipo,          0,                 @i_sector,
      @i_zona,            @i_oficina,       @s_date,           @s_date,
      'S',                'N',              @s_user,           null,
      @i_principal,       @i_barrio,        @i_provincia,      @i_codpostal, 
      @i_casa,            @i_calle,         @i_pais,           @i_codbarrio,
      @i_correspondencia, @i_alquilada,     @i_cobro,          @i_otrasenas, 
      @i_canton,          @i_distrito,      @i_montoalquiler,  @i_edificio, 
      @i_co_igual_so,     @i_rural_urbano,  @i_departamento,   @i_fact_serv_pu,
      @i_tipo_prop,       @i_nombre_agencia,@i_tiempo_reside,  @i_nro,
      @i_nro_residentes,  @i_nro_interno,   @i_negocio,        @i_ci_poblacion,
      @i_referencia	  )   --agregado campo di_ciudad = @i_canton
       
      if @@error <> 0 begin
         RETURN 103007
      end
      
                                   
      --VERIFICAR SI EL CLIENTE TIENE TELEFONOS POR ASOCIAR A DIRECCION PRINCIPAL (PROCESO DE BURO)
      if @i_principal = 'S' begin
         update cobis..cl_telefono
         set   te_direccion = @i_direccion
         where te_ente      = @i_ente
         and   te_direccion = 0          --PROCESO BURO DEJA TELEFONOS CON DIRECCION 0
      
         if @@error <> 0 begin
            return 105034
         end
      end
                  
      select @o_dire = @o_siguiente

      return 0
   end else begin
      return 151051
   end
end

return 0

GO

