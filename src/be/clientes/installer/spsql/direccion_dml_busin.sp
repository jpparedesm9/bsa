/*************************************************************************/
/*   Archivo:            direccion_dml_busin.sp                          */
/*   Stored procedure:   sp_direccion_dml_busin                          */
/*   Base de datos:      cobis                                           */
/*   Producto: Clientes                                                  */
/*   Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*   Fecha de escritura: 07-Nov-1992                                     */
/*************************************************************************/
/*               IMPORTANTE                                              */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*               PROPOSITO                                               */
/*   Este programa procesa las transacciones                             */
/*   DML de direcciones                                                  */
/*               MODIFICACIONES                                          */
/*   FECHA       AUTOR                   RAZON                           */
/*   07/Nov/92   M. Davila               Emision Inicial                 */
/*   03/mar/05   Dalvarez                Inclusion de nuevos campos      */
/*   07/Sep/05   R Garcia                Separacion entre Upd. y Verif.  */
/*   15/07/2008  Ing. J. Luis Alprado F. Adicion del campo ac_hora como  */
/*                                       criterio de ordenamiento        */
/*   15/06/2011  T. Vinueza              Cambio tamaño campos dir.       */
/*   23/10/2012  F.Lopez                 Asociacion Tels a Direccion Ppal*/
/*   12/03/2015  L.Maldonado             Datos Georef. Direccion         */
/*   05/04/2015  J.Guamani               Mod. en actualizacion de datos  */
/*   25/06/2015  M. Taco                 Agregar catalogo de fuente de   */
/*                                       verificacion                    */
/*   10/07/2015  C. Cueva                Cliente Casual                  */
/*   21/01/2017  M. Taco                 Quitar obligatoriedad campos    */
/*                                       para version base para la el    */
/*                                       ingreso rapido de clientes      */
/*   29/03/2017  M.Custode               Ingreso de nuevos campos para   */
/*                                       demo CAME MX                    */
/*   14/06/2017  P.Ortiz                 Nuevo campo Numero Interno      */
/*   27/07/2017  P.Ortiz                 Nuevo campo Negocio(Ligar a Dir)*/
/*   03/08/2017  P.Ortiz                 Duplicar Domiciolio a Negocio   */
/*   17/08/2017  P.Ortiz                 Actualización a Clientes        */
/*   30/11/2018  M. Taco                 Elimina espacios en direccion   */
/*   23/09/2019  A.Ortiz                 Nuevo campo de referencia       */
/*   05/12/2019  A.Ortiz                 Validar correo electronico       */
/*   13/09/2021  KVI                     Req. 123670 reporte mod. datos  */
/*   17/01/2023  KVI                     R.193221 Verificar.Correo B2B.Gr*/
/*************************************************************************/
use cob_pac
go
if exists (select 1 from sysobjects where name = 'sp_direccion_dml_busin')
   drop proc sp_direccion_dml_busin
go

create proc sp_direccion_dml_busin (
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
   @i_codpostal          char(5)      = null, -- Codigo Postal
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
   @t_show_version       bit          = 0,    -- Mostrar la versión del programa
   @i_co_igual_so        char(1)      = null,
   @i_nombre_agencia     varchar(20)  = null,
   @i_fuente_verif       varchar(10)  = null,
   @i_nro                int          = null, 		--numero de la calle
   @i_nro_residentes     int          = null, 		--Numero de residentes en el domicilio
   @i_nro_interno        int          = null, 		--numero de la calle
   @i_negocio            int          = null, 		--Negocio
   @i_batch              char(1)      = 'N',  -- LGU: sp que se dispara desde FE o BATCH
   @i_ci_poblacion       varchar(30)  = null, 		--ciudad Poblacion
   @i_referencia         varchar(250) = null,
   @i_canal              varchar(30)  = null,
   @i_verificacion       char(1)      = null   -- R.193221
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
   @w_estado_campo        char(1),      --Miguel Aldaz  06/26/2012 Doble autorización CLI-0565 HSBC
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
   @w_email                varchar(254),
   @w_nro                  int,
   @w_nro_interno          int,
   @v_nro                  int,
   @v_nro_interno          int,
   @w_nro_residentes       int,
   @v_nro_residentes       int,
   @w_canal                int,  -- R.193221
   @w_pcanal               int   -- R.193221
   
   
-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_direccion_dml_busin, Version 4.0.0.30'
    return 0
end
--------------------------------------------------------------------------------------

select @w_sp_name = 'sp_direccion_dml_busin'
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
      if @t_trn = 109
         begin
            --EL CAMPO PARROQUIA(BARRIO) AHORA ES DESCRIPTIVO
            --SE CREO EL CAMPO BARRIO DESCRIPTIVO PARA BARRIO EN CLIENTES
            --EL CAMPO PARROQUIA CONTINUA SNALLINT PARA MANEJO EN CTACTESY AHORROS
            if @i_define = 'S' and @i_cliente_casual <> 'S'
               begin
         if not exists(select pv_provincia
                     from   cobis..cl_provincia
                     where   pv_provincia = @i_provincia)
                     BEGIN
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 101038 
	                          --NO EXISTE DEPARTAMENTO O PROVINCIA
                        return 101038 
                        end 
                        else
	                        return 101038 
    end 

                  --VALIDA SI EXISTE PAIS
                  if not exists (select 1 from cobis..cl_pais where pa_pais = @i_pais)
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 101018 
	                           --NO EXISTE PAIS
	                        return 101018
	                    END
	                    else
	                        return 101018
                     end
         
                  -- VALIDA SI EXISTE CIUDAD-PROVINCIA --
                  if not exists (select 1 from cobis..cl_ciudad, cobis..cl_provincia
                                    where ci_provincia = pv_provincia
                                    and   ci_ciudad    = @i_ciudad
                                    and   pv_provincia = @i_provincia)
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 901019 
	                           -- NO EXISTE LA CIUDAD
	                        return 901019
	                    END
	                    else
	                        return 901019
                     end
                  -- FIN VALIDA CIUDAD-PROVINCIA
         
                  -- VALIDA SI EXISTE DEPARTAMENTO PARA PAIS --
                  if not exists (select 1 from cobis..cl_depart_pais
                                   where dp_departamento = @i_departamento)
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 101038 
	                           -- NO EXISTE DEPARTAMENTO
	                        return 101038
	                    END
	                    ELSE 
 	                        return 101038
                     end
                  -- FIN VALIDA DEPARTAMENTO

                  -- VALIDA TIPO DE PROPIEDAD --                  
                  if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
                                    where t.codigo = c.tabla
                                    and   t.tabla = 'cl_tpropiedad'
                                    and   c.codigo in ('PRO', 'ALQ', 'ANT', 'FAM'))
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 107157 
	                           -- NO EXISTE TIPO DE PROPIEDAD
	                        return 107157
	                    END
	                    ELSE 
	                        return 107157
                     end
                  -- FIN VALIDA TIPO DE PROPIEDAD
        
                  -- VALIDA TIPO DE AREA RURAL/URBANO
                  if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
                                    where t.codigo = c.tabla
                                    and   t.tabla = 'cl_sector'
                                    and   c.codigo in ('U', 'R'))
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                           @i_num    = 107158 
	                           -- EL AREA DEBE SER RURAL O URBANO'
	                        return 107158
	                    END
	                    ELSE 
 	                        return 107158
                     end
                  -- FIN VALIDA TIPO AREA RURAL/URBANO
         
                  -- VALIDA SI EXISTE DE CANTON
                  if not exists (select 1 from cobis..cl_ciudad   
                                    where ci_ciudad = @i_ciudad 
                                    and   ci_pais   = @i_pais)
                     begin
                     	IF @i_batch = 'N'
                     	begin
	                        exec cobis..sp_cerror
	                           @t_debug  = @t_debug,
	                           @t_file   = @t_file,
	                           @t_from   = @w_sp_name,
	                        @i_num    = 107146 
	                           --NO EXISTE CANTON
						    return 107146
						 END
						 ELSE 
						  return 107146
                     end         
               end
      
      if not exists (select of_oficina from cobis..cl_oficina
                           where   of_oficina = @i_oficina) and @i_oficina <> null
               begin
	             	IF @i_batch = 'N'
	             	begin
		                  exec cobis..sp_cerror  @t_debug  = @t_debug,
		                     @t_file   = @t_file,
		                     @t_from   = @w_sp_name,
		                     @i_num    = 101016
		                     --NO EXISTE OFICINA
		                  return 101016
		             END
		             ELSE 
		                  return 101016
               end

if @i_tipo = 'CE' 
      and exists(select 1 from cobis..cl_direccion where di_descripcion = ltrim(rtrim(@i_descripcion)) and di_tipo = 'CE')
      begin
         if @i_batch = 'N'
       	begin
            exec cobis..sp_cerror  @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 101269
            --El correo electrónico ingresado ya fue registrado
            return 101269
         end
         else 
            return 721909
      end
              
		 IF(@i_tipo<>'CE') --SAN SE QUITA DEL CATALOGO
		  BEGIN
            exec @w_return = cobis..sp_catalogo
               @t_debug       = @t_debug,
               @t_file        = @t_file,
               @t_from        = @w_sp_name,
               @i_tabla       = 'cl_tdireccion',
               @i_operacion   = 'E',
               @i_codigo      = @i_tipo
          
            if @w_return <> 0
               begin
	             	IF @i_batch = 'N'
	             	begin
		                  exec cobis..sp_cerror
		                     @t_debug  = @t_debug,
		                     @t_file   = @t_file,
		                     @t_from   = @w_sp_name,
		                     @i_num    = 101025
		                  --NO EXISTE TIPO DE DIRECCION
		                  return 101025
		            END
		            ELSE 
		                  return 101025
               end
		  END
                  --VERIFICAR QUE NO EXISTA MAS DE UNA DIRECCION COMO PRINCIPAL NVR
      if @i_principal = 'S'
      begin
         if exists (select di_ente from cobis..cl_direccion 
                     where  di_ente      = @i_ente 
                     and    di_principal = 'S')
         begin
          	if @i_batch = 'N'
          	begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 101187
               --YA EXISTE UNA DIRECCION COMO PRINCIPAL
               return 101187
            end
            else
            	return 101187
         end
      end

            -- VERIFICAR SI ES PERSONA NATURAL O JURIDICA
            select @w_subtipo = en_subtipo from cobis..cl_ente where en_ente = @i_ente
            if @i_correspondencia ='S' 
               begin
                  if exists(select 1 from cobis..cl_direccion where di_ente=@i_ente and di_correspondencia='S')
                     begin
		             	IF @i_batch = 'N'
		             	begin
	                        exec cobis..sp_cerror
	                           @t_debug = @t_debug,
	                           @t_file  = @t_file,
	                           @t_from  = @w_sp_name,
	                           @i_num   = 107268
	                           --SOLO PUEDE EXISTIR UNA DIRECCION DE CORRESPONDENCIA
	                        return 107268
	                   END
	                   ELSE
	                   		RETURN 107268
                     end
               end
                 
            begin tran
               update cobis..cl_ente
                  set en_direccion = isnull(en_direccion,0) + 1
                  where en_ente = @i_ente
      
               if @@error <> 0
               begin
	             	IF @i_batch = 'N'
	             	begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 105034
                        --ERROR EN INCREMENTO DE DIRECCION
                     return 105034
                    END
                    ELSE
	                    RETURN 105034
end
      select @o_siguiente = (select max(di_direccion) from cobis..cl_direccion where di_ente = @i_ente)
                    
               if @o_siguiente is null
                  begin
                     select @o_siguiente = 1
                  end
           else
                  begin
                     select @o_siguiente = @o_siguiente + 1
                  end
				
				if @i_negocio = 0
				begin
					select @i_negocio = null
				end
				print '1'
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
			   
               if @@error <> 0
                  begin
	             	IF @i_batch = 'N'
	             	begin
	                     exec cobis..sp_cerror
	                        @t_debug   = @t_debug,
	                        @t_file    = @t_file,
	                        @t_from    = @w_sp_name,
	                        @i_num     = 103007
	                        --ERROR EN CREACION DE DIRECCION
	                     return 103007
	                 END
	                 ELSE
	                 	RETURN 103007
                  end

               --TRANSACCION SERVICIOS - cobis..cl_direccion
               insert into  cobis..ts_direccion(
               secuencial,         tipo_transaccion, clase,           fecha,
               usuario,            terminal,         srv,             lsrv,
               ente,               direccion,        descripcion,     sector, 
               zona,               parroquia,        ciudad,          tipo,
               vigencia,           oficina,          verificado,      barrio,
               provincia,          calle,            casa,            pais, 
               correspondencia,    alquilada,        cobro,           edificio,
               departamento,       rural_urbano,     fact_serv_pu,    tipo_prop,
               nombre_agencia,     fuente_verif,     hora,            reside,
               negocio,            poblacion,        nro,             nro_interno,     
			   referencia,         nro_residentes,   canal)
               values(
               @s_ssn,             @t_trn,           'N',             @s_date,
               @s_user,            @s_term,          @s_srv,          @s_lsrv,
               @i_ente,            @o_siguiente,     @i_descripcion,  @i_sector, 
               @i_zona,            @i_parroquia,     @i_ciudad,       @i_tipo,--@i_parroquia cambio x @i_distrito
               'S',                @s_ofi,           'N',             @i_barrio,
               @i_provincia,       @i_calle,         @i_casa,         @i_pais, 
               @i_correspondencia, @i_alquilada,     @i_cobro,        @i_edificio,
               @i_departamento,    @i_rural_urbano,  @i_fact_serv_pu, @i_tipo_prop,
               @i_nombre_agencia,  null,             getdate(),       @i_tiempo_reside,
               @i_negocio,         @i_ci_poblacion,  @i_nro,          @i_nro_interno,  
			   @i_referencia,      @i_nro_residentes,@i_canal)
			   
               if @@error <> 0
                  begin
                --ERROR EN CREACION DE TRANSACCION DE SERVICIO
	             	IF @i_batch = 'N'
	             	begin
	                     exec cobis..sp_cerror
	                        @t_debug  = @t_debug,
	                        @t_file   = @t_file,
	                        @t_from   = @w_sp_name,
	                        @i_num    = 103005
	                     return  103005
	                END
	                ELSE
	                	RETURN 103005
                  end

				  -- Actualizacion Automatica de Prospecto a Cliente
				exec cobis..sp_seccion_validar
					@i_ente			= @i_ente,
					@i_operacion 	= 'V',
					@i_seccion 		= '2', --2 es Direcciones
					@i_completado 	= 'S'
               
               
               --VERIFICAR SI EL CLIENTE TIENE TELEFONOS POR ASOCIAR A DIRECCION PRINCIPAL (PROCESO DE BURO)
               if @i_principal = 'S'
                  begin
                     update cobis..cl_telefono
                        set   te_direccion = @i_direccion
                        where te_ente      = @i_ente
                        and   te_direccion = 0          --PROCESO BURO DEJA TELEFONOS CON DIRECCION 0

                     if @@error <> 0
                        begin
                           exec cobis..sp_cerror
                              @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 105035
                              --ERROR EN ACTUALIZACION DE DIRECCION
                           return 105034
                        end
                  end
            commit tran

            select @o_dire = @o_siguiente
            select @o_siguiente
            return 0
         end
      else
         begin
            exec cobis..sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
              --NO CORRESPONDE CODIGO DE TRANSACCION
            return 151051
         end
end

--UPDATE
if @i_operacion = 'U'
begin
      if @t_trn in (110, 1347) -- 110[ACtualizacion], 1347[Verificacion]
         begin
            if @i_ejecutar = 'N'
               begin
                  if @i_define='S'
                     begin      
                        -- VALIDA SI EXISTE PAIS
                           if not exists (select 1 from cobis..cl_pais where pa_pais = @i_pais)
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 101018 
                                    --NO EXISTE PAIS
                                 return 101018
                              end

            if not exists(select pv_provincia from cobis..cl_provincia where pv_provincia = @i_provincia)
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 101038 
                                    --NO EXISTE DEPARTAMENTO O PROVINCIA
                                 return 101038 
                              end 

                           -- VALIDA SI EXISTE CIUDAD-PROVINCIA --
                           if not exists (select 1 from cobis..cl_ciudad, cobis..cl_provincia
                                       where ci_provincia = pv_provincia
                                       and   ci_ciudad    = @i_ciudad
                                       and   pv_provincia = @i_provincia)
                              begin
                                 exec cobis..sp_cerror
               @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 901019 
                                    --NO EXISTE LA CIUDAD
                                 return 901019
                              end
                           -- FIN VALIDA CIUDAD-PROVINCIA

                           -- VALIDA SI EXISTE DEPARTAMENTO PARA PAIS --
                           if not exists (select 1 from cobis..cl_depart_pais
                                       where dp_departamento = @i_departamento)
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 101038 
                                    -- NO EXISTE DEPARTAMENTO
                                 return 101038
                              end
                           -- FIN VALIDA DEPARTAMENTO

                           -- VALIDA TIPO DE PROPIEDAD --
                           if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and   t.tabla = 'cl_tpropiedad'
                                       and   c.codigo in ('PRO', 'ALQ', 'ANT', 'FAM'))
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 107157 
                                    -- 'NO EXISTE TIPO DE PROPIEDAD'
                                 return 107157
                              end
                           -- FIN VALIDA TIPO DE PROPIEDAD

                           -- VALIDA TIPO DE AREA RURAL/URBANO
                           if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c
                                             where t.codigo = c.tabla
                                             and   t.tabla = 'cl_sector'
                                             and   c.codigo in ('U', 'R'))
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 107158 
                                    -- 'EL AREA DEBE SER RURAL O URBANO'
                                 return 107158
                              end
                              -- FIN VALIDA TIPO AREA RURAL/URBANO
                
                           -- VALIDA SI EXISTE DE CANTON
                           if not exists (select 1 from cobis..cl_ciudad   
                                             where ci_ciudad = @i_ciudad 
                                             and   ci_pais   = @i_pais)
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 107146 
                                 --NO EXISTE CANTON
                                 return 107146
                          end
                     end

                     if not exists (select   of_oficina
                                 from   cobis..cl_oficina
                                 where   of_oficina = @i_oficina) and @i_oficina <> null
                        begin
                           exec cobis..sp_cerror
                              @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 101016
                              --NO EXISTE OFICINA
                           return 101016
                        end

				IF(@i_tipo<>'CE') --SAN SE QUITA DEL CATALOGO
				BEGIN
                     exec @w_return = cobis..sp_catalogo
                        @t_debug       = @t_debug,
                        @t_file        = @t_file,
                        @t_from        = @w_sp_name,
                        @i_tabla       = 'cl_tdireccion',
                        @i_operacion   = 'E',
                        @i_codigo      = @i_tipo

                     if @w_return <> 0
                        begin
                           exec cobis..sp_cerror
                              @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 101025
                              --NO EXISTE TIPO DE DIRECCION
                           return 101025
                        end
				END

                     --VERIFICAR QUE NO EXISTA MAS DE UNA DIRECCION COMO PRINCIPAL NVR
                     if @i_principal = 'S'
                        begin
                           if not exists (select 1 from cobis..cl_ciudad   
                                       where ci_ciudad = @i_ciudad 
                                       and   ci_provincia   = @i_provincia)
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 107146 
                                    --NO EXISTE CANTON
                                 return 107146
                              end
                        end

                     if not exists (select of_oficina
                                 from   cobis..cl_oficina
                                 where  of_oficina = @i_oficina) 
                                 and    @i_oficina <> null
                        begin
                           exec cobis..sp_cerror  @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 101016 
                              --NO EXISTE OFICINA
                           return 101016 
                        end

                     if @i_oficina is null
                        select @i_oficina = @s_ofi

					IF(@i_tipo<>'CE') --SAN SE QUITA DEL CATALOGO
					BEGIN
                     if not exists (select codigo from  cobis..cl_catalogo
                                 where tabla  = ( select codigo from cobis..cl_tabla
                                                where  tabla = 'cl_tdireccion')
                                                and   codigo = @i_tipo)
                        begin
                           exec cobis..sp_cerror
                              @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 101025
                              --NO EXISTE TIPO DE DIRECCION
                           return 101025
                        end
				   END
                     if @i_correspondencia ='S'
                        begin
                           select @w_direccion_dc = di_direccion from cobis..cl_direccion where di_ente=@i_ente and di_correspondencia='S'
                           if @@rowcount <>0
                              if @w_direccion_dc <> @i_direccion
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug = @t_debug,
                                    @t_file  = @t_file,
                                    @t_from  = @w_sp_name,
           @i_num   = 107268
                                    --SOLO PUEDE EXISTIR UNA DIRECCION DE CORRESPONDENCIA
                                 return 107268
           end
                        end

                     --VALIDA QUE EXISTA SOLO UNA DIRECCION PRINCIPAL
                     if @i_principal = 'S'
                        begin
                            if exists (select di_ente from cobis..cl_direccion 
									   where  di_ente      = @i_ente 
									   and    di_principal = 'S'
									   and    di_direccion != @i_direccion)
                                begin
                                    exec cobis..sp_cerror
                                    @t_debug = @t_debug,
                                    @t_file  = @t_file,
                                    @t_from  = @w_sp_name,
                                    @i_num   = 101187
								   --YA EXISTE UNA DIRECCION COMO PRINCIPAL
                                    return 101187
                                end
                        end
          

                     if @t_trn = 1347
                        begin
                           if @i_verificado <> 'S' and isnull(@i_verificado, 'N') <> 'N'
                              begin
                                 exec cobis..sp_cerror
                                    @t_debug  = @t_debug,
                                    @t_file   = @t_file,
                                    @t_from   = @w_sp_name,
                                    @i_num    = 101114
                                    --PARAMETRO INVALIDO
                                 return 101114
                              end
                        end      
               end         
        
        print '3'
            --CHEQUEO DE CAMPOS A ACTUALIZAR
            select  
			@w_descripcion     = di_descripcion,
            @w_tipo              = di_tipo,
            @w_parroquia         = di_parroquia,
            @w_barrio            = di_barrio,
            @w_principal         = di_principal,
            @w_canton            = di_canton,
            @w_sector            = di_sector,
            @w_vigencia          = di_vigencia,
            @w_oficina           = di_oficina,
            @w_verificado        = di_verificado,
            @w_zona_ant          = di_zona,
            @w_provincia         = di_provincia,
            @w_codpostal         = di_codpostal,
            @w_calle             = di_calle,----******
            @w_casa              = di_casa,-----******
            @w_pais              = di_pais,
            @w_codbarrio         = di_codbarrio,
            @w_correspondencia   = di_correspondencia,
            @w_alquilada         = di_alquilada,
            @w_cobro             = di_cobro,
            @w_otrasenas         = di_otrasenas,---******323
            @w_distrito          = di_distrito,
            @w_montoalquiler     = di_montoalquiler,
            @w_edificio          = di_edificio,-----*****23232
            @w_co_igual_so       = di_so_igu_co,
            @w_rural_urbano      = di_rural_urbano,
            @w_departamento      = di_departamento,
            @w_fact_serv_pu      = di_fact_serv_pu,
            @w_tipo_prop         = di_tipo_prop,
            @w_ciudad            = di_ciudad,
            @w_nombre_agencia    = di_nombre_agencia,
            @w_fuente_verif      = di_fuente_verif,
            @w_fecha_ver         = di_fecha_ver,
            @w_tiempo_reside     = di_tiempo_reside,
            @w_negocio			 = di_negocio,
            @w_ci_poblacion      = di_poblacion,
		    @w_referencia		 = di_referencia,
			@w_nro               = di_nro,
			@w_nro_interno       = di_nro_interno,
			@w_nro_residentes    = di_nro_residentes
            from  cobis..cl_direccion
            where di_ente      = @i_ente
            and   di_direccion = @i_direccion

            if @@rowcount <> 1
               begin
                  exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 101059
         --NO EXISTE DIRECCION
                  return 101059
               end
            print '4'
            select  
			@v_descripcion     = @w_descripcion,
            @v_tipo            = @w_tipo,
            @v_parroquia       = @w_parroquia,
            @v_barrio          = @w_barrio,
            @v_principal       = @w_principal,
            @v_canton          = @w_canton,
            @v_sector          = @w_sector,
            @v_vigencia        = @w_vigencia,
            @v_oficina         = @w_oficina,
            @v_verificado      = @w_verificado,
            @v_zona            = @w_zona_ant,
            @w_zona            = @w_zona_ant,
            @v_provincia       = @w_provincia,
            @v_codpostal       = @w_codpostal,
            @v_calle           = @w_calle,
            @v_casa            = @w_casa,
            @v_pais            = @w_pais,
            @v_canton          = @w_canton,
            @v_codbarrio       = @w_codbarrio,
            @v_correspondencia = @w_correspondencia,
            @v_alquilada       = @w_alquilada,
            @v_cobro           = @w_cobro,
            @v_otrasenas       = @w_otrasenas,
            @v_distrito        = @w_distrito,
            @v_montoalquiler   = @w_montoalquiler,
            @v_edificio        = @w_edificio,
            @v_co_igual_so     = @w_co_igual_so, 
            @v_rural_urbano    = @w_rural_urbano, 
            @v_departamento    = @w_departamento, 
            @v_fact_serv_pu    = @w_fact_serv_pu, 
            @v_tipo_prop       = @w_tipo_prop,
            @v_ciudad          = @w_ciudad,
            @v_nombre_agencia  = @w_nombre_agencia,
            @v_fuente_verif    = @w_fuente_verif,
            @v_fecha_ver       = @w_fecha_ver,
			@v_tiempo_reside   = @w_tiempo_reside,
            @v_negocio         = @w_negocio,
            @v_ci_poblacion	   = @w_ci_poblacion,
		    @v_referencia      = @w_referencia,
			@v_nro             = @w_nro,
			@v_nro_interno     = @w_nro_interno,
			@v_nro_residentes  = @w_nro_residentes
            select @w_cambio_campo = 'N'  
            select @w_cambio_campo_co_so = 'N'            

            if @w_descripcion = @i_descripcion
               select @w_descripcion = null, @v_descripcion = null
            else
               begin
                  select @w_descripcion = @i_descripcion
                  select @w_cambio_campo = 'S'
               end             

            if @w_oficina = @i_oficina
               select @w_oficina = null, @v_oficina = null
            else
               begin
                  select @w_oficina = @i_oficina
               end

            if @w_verificado = @i_verificado
               select @w_verificado = 'N', @v_verificado = 'N'
            else
               select @w_verificado = @i_verificado

            if @w_tipo = @i_tipo begin
			   select @w_tipo = case when @w_tipo in ('CE','RE') then @w_tipo else null end
               select @v_tipo = case when @v_tipo in ('CE','RE') then @v_tipo else null end   
            end else
            begin
               select @w_tipo = @i_tipo
            end

            if @w_sector = @i_sector
               select @w_sector = null, @v_sector = null
            else
               begin
                  select @w_sector = @i_sector
               end

            if @w_provincia = @i_provincia 
               select @w_provincia = null, @v_provincia = null
            else
               begin
                  select @w_provincia = @i_provincia
                  select @w_cambio_campo = 'S'
               end

            --ACTUALIZA DIRECCION PRINCIPAL
            if @w_principal = @i_principal
               begin
                  select @w_principal = null, @v_principal = null
                  select  @w_cambio_direccion  = 'N'              
               end
            else
               begin
         select @w_principal = @i_principal
                  select  @w_cambio_direccion  = 'S'
            end

            if @w_codpostal = @i_codpostal
               select @w_codpostal = null, @v_codpostal = null
            else
               begin
                  select @w_codpostal = @i_codpostal
               end

            if @w_casa = @i_casa             --------************
               select @w_casa = null, @v_casa = null
            else
               begin
               select @w_casa = @i_casa
                  select @w_cambio_campo = 'S'
             end

            if @w_calle = @i_calle          --------***************
               select @w_calle = null, @v_calle = null
            else
               begin
                  select @w_calle = @i_calle
                  select @w_cambio_campo = 'S'
             end

            select @w_zona = @i_zona

            if @w_pais = @i_pais
               select @w_pais = null, @v_pais = null
            else
               begin
                  select @w_pais = @i_pais
                  select @w_cambio_campo = 'S'
               end              

            if @w_canton = @i_canton
               select @w_canton = null, @v_canton = null
            else
               begin
                  select @w_canton = @i_canton
                  select @w_cambio_campo = 'S'
             end

            if @w_ciudad = @i_ciudad
               select @w_ciudad = null, @v_ciudad = null
            else
               begin
                  select @w_ciudad = @i_ciudad
                  select @w_cambio_campo = 'S'
             end

            if @w_codbarrio = @i_codbarrio
               select @w_codbarrio = null, @v_codbarrio = null
            else
               begin
                  select @w_codbarrio = @i_codbarrio
                  select @w_cambio_campo = 'S'
             end

            if @w_correspondencia = @i_correspondencia
               select @w_correspondencia = null, @v_correspondencia = null
            else
               begin
                  select @w_correspondencia = @i_correspondencia
            end             

            if @w_alquilada = @i_alquilada
               select @w_alquilada = null, @v_alquilada = null
            else
               begin
                  select @w_alquilada = @i_alquilada
               end             

            if @w_cobro = @i_cobro
               select @w_cobro = null, @v_cobro = null
            else
               begin
                  select @w_cobro = @i_cobro
               end 

            if @w_otrasenas = @i_otrasenas  ------------------------**********
               select @w_otrasenas = null, @v_otrasenas = null
            else
               begin
                  select @w_otrasenas = @i_otrasenas
                  select @w_cambio_campo = 'S'
               end

            if @w_distrito = @i_distrito
               select @w_distrito = null, @v_distrito = null
            else
               begin
                  select @w_distrito = @i_distrito
                  select @w_cambio_campo = 'S'
               end

            if @w_montoalquiler = @i_montoalquiler
               select @w_montoalquiler = null, @v_montoalquiler = null
            else
               begin
                  select @w_montoalquiler = @i_montoalquiler         
               end             

            if @w_edificio = @i_edificio
               select @w_edificio = null, @v_edificio = null
            else
               begin
                  select @w_edificio = @i_edificio
                  select @w_cambio_campo = 'S'
               end
            -- CAMPOS NUEVOS
            if @w_rural_urbano = @i_rural_urbano
               select @w_rural_urbano = null, @v_rural_urbano = null
            else
               begin
                  select @w_rural_urbano = @i_rural_urbano         
               end

            if @w_departamento = @i_departamento
  select @w_departamento = null, @v_departamento = null
            else
               begin
                  select @w_departamento = @i_departamento         
               end

            if @w_fact_serv_pu = @i_fact_serv_pu
               select @w_fact_serv_pu = null, @v_fact_serv_pu = null
            else
               begin
              select @w_fact_serv_pu = @i_fact_serv_pu         
               end

            if @w_tipo_prop = @i_tipo_prop
               select @w_tipo_prop = null, @v_tipo_prop = null
            else
               begin
                  select @w_tipo_prop = @i_tipo_prop         
               end
            -- FIN CAMPOS NUEVOS
            
            if @w_co_igual_so  = @i_co_igual_so
               begin
                  select @w_co_igual_so  = null, @v_co_igual_so  = null
               end
            else
               begin
                  select @w_co_igual_so  = @i_co_igual_so
                  select @w_cambio_campo_co_so = 'S'              
               end

            if @w_nombre_agencia  = @i_nombre_agencia
                  select @w_nombre_agencia  = null, @v_nombre_agencia  = null
            else
                  select @w_nombre_agencia  = @i_nombre_agencia
            
            if @w_fuente_verif  = @i_fuente_verif
                  select @w_fuente_verif  = null, @v_fuente_verif  = null
            else
                  select @w_fuente_verif  = @i_fuente_verif

            if @w_barrio = @i_barrio
               select @w_barrio = null, @v_barrio = null
            else
               begin
                  select @w_barrio = @i_barrio
               end
            
            if @w_tiempo_reside = @i_tiempo_reside
               select @w_tiempo_reside = null, @v_tiempo_reside = null
            else
               begin
                  select @w_tiempo_reside = @i_tiempo_reside
               end
      --ciudad poblacion--  
               if @w_ci_poblacion = @i_ci_poblacion
               select @w_ci_poblacion = null, @v_ci_poblacion = null
            else
               begin
                  select @w_ci_poblacion = @i_ci_poblacion
               end
            
            --negocio
            if @w_negocio = @i_negocio
               select @w_negocio = null, @v_negocio = null
            else
               begin
                  select @w_negocio = @i_negocio
               end
            
			--referencia
			if @w_referencia = @i_referencia
               select @w_referencia = null, @v_referencia = null
            else
               begin
                  select @w_referencia = @i_referencia
               end 
			   
			--parroquia
			if @w_parroquia = @i_parroquia
               select @w_parroquia = null, @v_parroquia = null
            else
               begin
                  select @w_parroquia = @i_parroquia
               end 
			   
			--numero
			if @w_nro = @i_nro
               select @w_nro = null, @v_nro = null
            else
               begin
                  select @w_nro = @i_nro
               end 
			   
			--numero interno
			if @w_nro_interno = @i_nro_interno
               select @w_nro_interno = null, @v_nro_interno = null
            else
               begin
                  select @w_nro_interno = @i_nro_interno
               end 
			   
			--numero residentes
			if @w_nro_residentes = @i_nro_residentes
               select @w_nro_residentes = null, @v_nro_residentes = null
            else
               begin
                  select @w_nro_residentes = @i_nro_residentes
               end 
            
      if ((@i_tipo = 'RE') and ((@i_negocio is not null) or (@i_negocio = 0)))
   	begin
   		select @i_negocio = null
   	end
		
	 --VALIDA QUE EL CLIENTE NO TENGA CORREOS DUPLICADOS
		if @i_tipo = 'CE' and 
         (select count(*) from cobis..cl_direccion 
         where di_descripcion = ltrim(rtrim(@i_descripcion)) 
         and di_tipo = 'CE' 
         and di_ente  = @i_ente ) > 1
		begin
		   exec cobis..sp_cerror  @t_debug  = @t_debug,
			@t_file   = @t_file,
			@t_from   = @w_sp_name,
			@i_num    = 101269
			--El correo electrónico ingresado ya fue registrado
		   
			return 101269
		end
		
		 --VALIDA QUE EL CLIENTE NO TENGA EL CORREO DE OTRO CLIENTE
		if @i_tipo = 'CE' and exists
         (select 1 from cobis..cl_direccion 
         where di_descripcion = ltrim(rtrim(@i_descripcion)) 
         and di_tipo = 'CE' 
         and di_ente  <> @i_ente ) 
		begin
		   exec cobis..sp_cerror  @t_debug  = @t_debug,
			@t_file   = @t_file,
			@t_from   = @w_sp_name,
			@i_num    = 101269
			--El correo electrónico ingresado ya fue registrado
		   
			return 101269
		end
		
		--Inicio R.193221
		select @w_pcanal = ca_canal from cobis..cl_canal where ca_nombre = 'b2b' and ca_estado = 'V'
		select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = lower(@i_canal) and ca_estado = 'V' 
		print 'sp_direccion_dml_busin -->> pcanal: ' + convert(varchar,@w_pcanal)
		print 'sp_direccion_dml_busin -->> canal: ' + convert(varchar,@w_canal)
		
		--REGISTRO VERIFICACION CORREO B2B 
		if @i_tipo = 'CE' and @w_canal = @w_pcanal 
		begin
		    if @i_verificacion = 'N' 
		    begin
			    print 'sp_direccion_dml_busin -->> Ingresa Verificacion N'
		        if not exists (select 1 from cobis..cl_verif_co_tel 
                               where ct_valor = ltrim(rtrim(@i_descripcion)) 
                               and   ct_tipo  = 'CE' 
                               and   ct_ente  = @i_ente
							   and   ct_verificacion = 'N') 
		        begin
		            insert into cobis..cl_verif_co_tel
		                   (ct_ente, ct_direccion, ct_valor,       ct_tipo, ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
                    values (@i_ente, @i_direccion, @i_descripcion, @i_tipo, @i_verificacion, @w_canal, @s_date,       getdate()) 
		        end
				else
				begin
				    update cobis..cl_verif_co_tel
					set ct_fecha_proc = @s_date,
					    ct_fecha = getdate()
				    where ct_valor = ltrim(rtrim(@i_descripcion)) 
                    and   ct_tipo  = 'CE' 
                    and   ct_ente  = @i_ente
					and   ct_verificacion = 'N'
				end
		        
				exec cobis..sp_cerror  
		          @t_debug  = @t_debug,
			      @t_file   = @t_file,
			      @t_from   = @w_sp_name,
			      @i_num    = 103199
			      --'NECESITA VERIFICAR SU CORREO'		   
			      return 103199
		    end
			else if @i_verificacion = 'S' and not exists (select 1 from cobis..cl_verif_co_tel 
                                                          where ct_valor = ltrim(rtrim(@i_descripcion)) 
                                                          and   ct_tipo  = 'CE' 
                                                          and   ct_ente  = @i_ente
														  and   ct_verificacion = 'S') 
		    begin
			    print 'sp_direccion_dml_busin -->> Ingresa Verificacion S'
		        insert into cobis..cl_verif_co_tel
		               (ct_ente, ct_direccion, ct_valor,       ct_tipo, ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
                values (@i_ente, @i_direccion, @i_descripcion, @i_tipo, @i_verificacion, @w_canal, @s_date,       getdate()) 
		    end
		end		
		--Fin R.193221
			
            begin tran
			print '5'
               update  cobis..cl_direccion
               set   di_verificado      = isnull(@i_verificado, 'N' ),
                  di_fecha_ver       = case @i_verificado when 'S' then @s_date else null end,  
                  di_funcionario     = @s_user, 
                  di_descripcion     = isnull(@i_descripcion, di_descripcion),
                  di_tipo            = isnull(@i_tipo, di_tipo),
                  di_parroquia       = isnull(@i_parroquia,  di_parroquia),
                  di_barrio          = isnull(@i_barrio, di_barrio),
                  di_canton          = isnull(@i_canton,di_canton ),
                  di_sector          = isnull(@i_sector,di_sector),
                  di_principal       = isnull(@i_principal,di_principal ),
                  di_vigencia        = 'S',
                  di_oficina         = isnull(@i_oficina, di_oficina),
                  di_zona            = isnull(@w_zona, di_zona),
                  di_provincia       = isnull(@i_provincia, di_provincia),
                  di_codpostal       = isnull(@i_codpostal, di_codpostal),
                  di_calle           = isnull(@i_calle, di_calle),----------*******
                  di_casa            = isnull(@i_casa,di_casa ),--------******
                  di_pais            = isnull(@i_pais,  di_pais),
                  di_codbarrio       = isnull(@i_codbarrio, di_codbarrio),
                  di_correspondencia = isnull(@i_correspondencia,  di_correspondencia),
                  di_alquilada       = isnull(@i_alquilada, di_alquilada ),
                  di_cobro           = isnull(@i_cobro, di_cobro),
                  di_otrasenas       = isnull(@i_otrasenas, di_otrasenas),-----******
                  di_distrito        = isnull(@i_distrito, di_distrito),
                  di_montoalquiler   = isnull(@i_montoalquiler, di_montoalquiler),
                  di_edificio        = isnull(@i_edificio, di_edificio),-----******
                  di_ciudad          = isnull(@i_ciudad, di_ciudad),
                  di_so_igu_co       = isnull(@i_co_igual_so, di_so_igu_co),
                  di_rural_urbano    = isnull(@i_rural_urbano, di_rural_urbano),
                  di_departamento    = isnull(@i_departamento, di_departamento),
                  di_fact_serv_pu    = isnull(@i_fact_serv_pu, di_fact_serv_pu),
                  di_tipo_prop       = isnull(@i_tipo_prop, di_tipo_prop),
                  di_nombre_agencia  = isnull(@i_nombre_agencia,di_nombre_agencia),
                  di_fuente_verif    = @i_fuente_verif,
                  di_fecha_modificacion =@s_date,
                  di_tiempo_reside   = isnull(@i_tiempo_reside,di_tiempo_reside),
                  di_nro             = isnull(@i_nro,di_nro),
                  di_nro_residentes  = isnull(@i_nro_residentes,di_nro_residentes),
                  di_nro_interno     = isnull(@i_nro_interno,di_nro_interno),
                  di_negocio         = isnull(@i_negocio,di_negocio),
                  di_poblacion       = isnull(@i_ci_poblacion,di_poblacion),
		          di_referencia		 = isnull(@i_referencia,di_referencia)
               where di_ente = @i_ente
               and   di_direccion = @i_direccion
      
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 105034
                        --ERROR EN ACTUALIZACION DE DIRECCION
                     return 105034
                  end
                                                                
      select @o_dire = @i_direccion
                                                       
               --VERIFICAR SI EL CLIENTE TIENE TELEFONOS POR ASOCIAR A DIRECCION PRINCIPAL (PROCESO DE BURO)
               if @i_principal = 'S'
                  begin
                     update cobis..cl_telefono
                     set   te_direccion = @i_direccion
                     where te_ente      = @i_ente
                     and   te_direccion = 0              --Proceso BURO deja telefonos con direccion 0

                     if @@error <> 0
                        begin
                           exec cobis..sp_cerror
                              @t_debug  = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 105035
                              --ERROR EN ACTUALIZACION DE DIRECCION
                           return 105034
                        end               
                  end
print '6'
               insert into cobis..ts_direccion (
                  secuencial,    tipo_transaccion,  clase,          fecha,
                  usuario,       terminal,          srv,            lsrv,
                  ente,          direccion,         descripcion,    sector,  
                  zona,          vigencia,          parroquia,      ciudad,
                  tipo,          oficina,           verificado,     barrio, 
                  provincia,     codpostal,         casa,           calle,
                  pais,          correspondencia,   alquilada,      cobro,
                  edificio,      departamento,      rural_urbano ,  fact_serv_pu,
                  tipo_prop,     nombre_agencia,    fuente_verif,   fecha_ver,    
				  hora,          reside,            negocio,        poblacion,        
				  nro,           nro_interno,       referencia,     nro_residentes,
				  canal,         principal,         rol)
               values(
                  @s_ssn,           @t_trn,            'P',             @s_date,
                  @s_user,          @s_term,            @s_srv,         @s_lsrv,   
                  @i_ente,          @i_direccion,       @v_descripcion, @v_sector, 
                  @v_zona,          @v_vigencia,        @v_parroquia,    @v_ciudad, --@v_parroquia,    @v_ciudad
                  @v_tipo,          @s_ofi,             @v_verificado,  @v_barrio,
                  @v_provincia,     @v_codpostal,       @v_casa,        @v_calle,
                  @v_pais,          @v_correspondencia, @v_alquilada,   @v_cobro,
                  @v_edificio,      @v_departamento,    @v_rural_urbano,@v_fact_serv_pu,
                  @v_tipo_prop,     @v_nombre_agencia,  @v_fuente_verif, case @v_verificado when 'S' then @s_date else null end,    
				  getdate(),        @v_tiempo_reside,   @v_negocio,     @v_ci_poblacion,
				  @v_nro,           @v_nro_interno,     @v_referencia,  @v_nro_residentes,
				  @i_canal,         @v_principal,       @s_rol)  

               if @@error <> 0
                  begin
                     --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 103005
                     return  103005
                  end
print '7'
               insert into cobis..ts_direccion (
               secuencial,    tipo_transaccion, clase,          fecha,
               usuario,       terminal,         srv,            lsrv,
               ente,          direccion,        descripcion,    sector, 
               vigencia,      zona,             parroquia,      ciudad, 
               tipo,          oficina,          verificado,     barrio,
               provincia,     codpostal,        casa,           calle,
               pais,          correspondencia,  alquilada,      cobro,
               edificio,      departamento,     rural_urbano ,  fact_serv_pu,
               tipo_prop,     nombre_agencia,   fuente_verif,   fecha_ver,    hora,
               reside,        negocio,          poblacion,      nro,          
			   nro_interno,   referencia,       nro_residentes, canal,
			   principal,     rol)                 
               values( 
			   @s_ssn,           @t_trn,            'A',                @s_date,
               @s_user,          @s_term,            @s_srv,            @s_lsrv,
               @i_ente,          @i_direccion,       @w_descripcion,    @w_sector, 
               'S',              @w_zona,            @w_parroquia,       @w_ciudad, --@w_parroquia,    @w_ciudad,
               @w_tipo,          @s_ofi,             @w_verificado,     @w_barrio,
               @w_provincia,     @w_codpostal,       @w_casa,           @w_calle,
               @w_pais,          @w_correspondencia, @w_alquilada,      @w_cobro,
               @w_edificio,      @w_departamento,    @w_rural_urbano,   @w_fact_serv_pu,
               @w_tipo_prop,     @w_nombre_agencia,  @w_fuente_verif,   case @w_verificado when 'S' then @s_date else null end,    getdate(),
               @w_tiempo_reside, @w_negocio,         @w_ci_poblacion,   @w_nro,           
			   @w_nro_interno,   @w_referencia,      @w_nro_residentes, @i_canal,
			   @w_principal,     @s_rol)   
			   
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 103005
                        --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                     return  103005
                  end
               
               if @v_descripcion <> @w_descripcion
                  begin
                     insert into cobis..cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                        ac_campo, ac_valor_ant, ac_valor_nue,
                        ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
                     values(@i_ente, @s_date,'cobis..cl_direccion',
                        'di_descripcion', @v_descripcion, @w_descripcion,
                        'U', @i_direccion, null, getdate())
                     if @@error <> 0
                        begin
                           exec cobis..sp_cerror
                              @t_debug    = @t_debug,
                              @t_file     = @t_file,
                              @t_from     = @w_sp_name,
                              @i_num      = 103001
                              --ERROR EN CREACION DE CLIENTE
                           return 103001 
 end
                  end

               if @v_zona <> @w_zona
                  begin
                     insert into cobis..cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                        ac_campo, ac_valor_ant, ac_valor_nue,
                        ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
                     values(@i_ente, @s_date,'cobis..cl_direccion',
                        'di_zona', @v_zona, @w_zona,
                        'U', @i_direccion, null, getdate())
                     if @@error <> 0
                        begin
                           exec cobis..sp_cerror
                              @t_debug    = @t_debug,
                              @t_file     = @t_file,
                              @t_from     = @w_sp_name,
                              @i_num      = 103001
                              --ERROR EN CREACION DE CLIENTE
                           return 103001 
                        end
                  end 
            
            commit tran
            
            -- Actualizacion Automatica de Prospecto a Cliente
			   exec cobis..sp_seccion_validar
				@i_ente			= @i_ente,
				@i_operacion 	= 'V',
				@i_seccion 		= '2', --2 es Direcciones
				@i_completado 	= 'S'
            
            return 0
         end
      else
        begin
           exec cobis..sp_cerror
              @t_debug      = @t_debug,
    @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 151051
              --NO CORRESPONDE CODIGO DE TRANSACCION
           return 151051
        end
		print '8'
   
end

--DELETE
if @i_operacion = 'D'
begin
      if @t_trn = 1226
         begin
            --VERIFICACION DE CLAVES FORANEAS
            if not exists (select en_ente from cobis..cl_ente
                        where en_ente = @i_ente)
               begin
                  exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @i_num    = 101042
                     --NO EXISTE ENTE
                  return 1
               end

            --CAMPOS PARA TRANSACCION DE  SERVICIOS
            select  @w_descripcion   = di_descripcion,
               @w_tipo            = di_tipo,
               @w_principal       = di_principal,
               @w_parroquia       = di_parroquia,
               @w_barrio          = di_barrio,
               @w_canton          = di_canton,
               @w_sector          = di_sector,
               @w_zona            = di_zona,
               @w_oficina         = di_oficina,
               @w_verificado      = di_verificado,
               @w_provincia       = di_provincia,
               @w_codpostal       = di_codpostal,
               @w_casa            = di_casa,
               @w_calle           = di_calle,
               @w_pais            = di_pais,
               @w_codbarrio       = di_codbarrio,
               @w_correspondencia = di_correspondencia,
               @w_alquilada       = di_alquilada,
               @w_cobro           = di_cobro,
               @w_otrasenas       = di_otrasenas,
               @w_montoalquiler   = di_montoalquiler,
               @w_edificio        = di_edificio,
               @w_co_igual_so     = di_so_igu_co,
               @w_rural_urbano    = di_rural_urbano,
               @w_departamento    = di_departamento,
               @w_fact_serv_pu    = di_fact_serv_pu,
               @w_tipo_prop       = di_tipo_prop,
               @w_ciudad          = di_ciudad,
               @w_nombre_agencia  = di_nombre_agencia,
               @w_fuente_verif    = di_fuente_verif,
               @w_fecha_ver       = di_fecha_ver,
               @w_tiempo_reside   = di_tiempo_reside,
               @w_negocio         = di_negocio,
               @w_ci_poblacion    = di_poblacion,
			   @w_nro             = di_nro,
			   @w_nro_interno     = di_nro_interno,
			   @w_referencia      = di_referencia
            from  cobis..cl_direccion
            where di_ente = @i_ente
            and   di_direccion = @i_direccion

            if @@rowcount = 0
               begin
                  exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 101001
    --NO EXISTE DATO SOLICITADO
                  return 1
               end

      if (select count (dp_direccion_ec) from  cobis..cl_cliente, cobis..cl_det_producto  
               where cl_cliente      = @i_ente 
               and   cl_det_producto = dp_det_producto  
               and   dp_direccion_ec = @i_direccion) > 0
               begin
                  print 'NO SE PUEDE ELIMINAR DIRECCION YA QUE SE ENCUENTRA REFERENCIADA POR UN PRODUCTO'
                  return 1
               end

            begin tran
               update cobis..cl_ente
                  set   en_direccion = en_direccion - 1
                  where en_ente      = @i_ente
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 107007
                        --ERROR EN DISMINUCION DE DIRECCIONES
                     return 1
                  end

               --SI SE QUIERE BORRAR TODAS LAS DIRECCIONES
               select @w_codigo = en_direccion from cobis..cl_ente
               where en_ente = @i_ente

        if @w_codigo = 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 101053
                        --NO SE PUEDE ELIMINAR TODAS LAS DIRECCIONES
                     return 1
                  end

               select * from  cobis..cl_direccion
                  where di_ente = @i_ente     

               if @@rowcount = 1
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 101053
                        --ERROR EN DISMINUCION DE DIRECCIONES
                     return 1
                  end

               --EVITAR ELIMINAR LAS DIRECCIONES PRINCIPALES NVR
               select @w_principal = di_principal from cobis..cl_direccion
               where  di_ente      = @i_ente
               and    di_direccion = @i_direccion

               if @w_principal ='S'
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 107252
                        --NO SE PUEDE ELIMINAR TODAS LAS DIRECCIONES
                     return 1
                  end

               select @w_codigo = di_telefono from cobis..cl_direccion
                  where di_ente = @i_ente
                  and di_direccion = @i_direccion

               --ELIMINACION DE TODOS LOS TELEFONOS DE LA DIRECCION
               while @w_codigo > 0
                  begin
                     exec @w_return = cobis..sp_telefono 
                        @s_ssn       = @s_ssn, 
                        @s_user      = @s_user,
                        @s_term      = @s_term,
                        @s_date      = @s_date,
                        @s_srv       = @s_srv,
                        @s_lsrv      = @s_lsrv,
                        @s_ofi       = @s_ofi,
                        @s_rol       = @s_rol,
                        @s_org_err   = @s_org_err,
                        @s_error     = @s_error,
                        @s_sev       = @s_sev,
                        @s_msg       = @s_msg,
                        @s_org       = @s_org,
                        @t_debug     = @t_debug,
                        @t_file      = @t_file,
                        @t_from      = @t_from,
                        @t_trn       = 148,
                        @p_alterno   = @w_codigo,
                        @i_operacion = 'D', 
                        @i_ente      = @i_ente, 
                        @i_direccion = @i_direccion, 
                        @i_secuencial= @w_codigo,
                        @i_tborrado  = 'T',      -- SIGNIFICA QUE SE VAN A BORRAR TODOS LOS TELEFONOS ASOCIADOS A LA DIR.
						@i_canal     = @i_canal

                     if @w_return <> 0 
            return @w_return
         
                        select @w_codigo = @w_codigo - 1
                  end

               if exists(select 1 from cobis..cl_direccion_geo
                        where dg_ente      = @i_ente
                        and   dg_direccion = @i_direccion)
                  begin
         --ELIMINAR REGISTROS GEOREFERENCIACION
         if @@error <> 0
                           exec @w_return = cobis..sp_direccion_geo
                           @s_ssn          = @s_ssn,
                           @s_date         = @s_date,
                           @i_operacion    = 'D',
                           @t_trn          = 1606,
                           @i_ente         = @i_ente,
                           @i_direccion    = @i_direccion
                        if @w_return <> 0
                           begin
                           --SI NO SE PUEDE BORRAR, ERROR
                              exec cobis..sp_cerror 
                                 @t_debug= @t_debug,
                                 @t_file = @t_file,
                                 @t_from = @w_sp_name,
                                 @i_num  = 107056  
                              return 1
                           end
                  end

               --ELIMINACION DE LA DIRECCION
               delete from cobis..cl_direccion
                  where di_ente      = @i_ente
                  and   di_direccion = @i_direccion

               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 107007
                        --ERROR EN ELIMINACION DE DIRECCION
                     return 1
                  end
      
               select @w_direccion = convert(varchar(3),@i_direccion)
      
               insert into cobis..cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                  ac_campo, ac_valor_ant, ac_valor_nue,
                  ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
               values
                  (@i_ente, @s_date,'cobis..cl_direccion',
                  'di_direccion', @w_direccion, null,
                  'D', @i_direccion, null, getdate())
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 103001
                        --ERROR EN CREACION DE CLIENTE
                     return 1 
                  end                                                                       
      
               --TRANSACCION SERVICIOS - cobis..cl_direccion
               insert into cobis..ts_direccion (
               secuencial,     tipo_transaccion,   clase,          fecha,
               usuario,        terminal,           srv,            lsrv,
               ente,           direccion,          descripcion,    sector, 
               zona,           parroquia,          ciudad,         tipo, vigencia,
               oficina,        verificado,         barrio,         provincia,
               casa,           calle,              pais,           correspondencia, 
               alquilada,      cobro,              edificio,       departamento,
               rural_urbano ,  fact_serv_pu,       tipo_prop,      nombre_agencia,
               fuente_verif,   fecha_ver,          hora,           reside,
               negocio,        poblacion,          nro,            nro_interno,     
			   referencia,     nro_residentes,     canal)                 
               values( 
               @s_ssn,          @t_trn,            'B',            @s_date,
               @s_user,         @s_term,           @s_srv,         @s_lsrv,
               @i_ente,         @i_direccion,      @w_descripcion, @w_sector, 
               @w_zona,         @w_distrito,       @w_ciudad,      @w_tipo, 'S',--@w_parroquia,       @w_ciudad,
               @s_ofi,          @w_verificado,     @w_barrio,      @w_provincia,
               @w_casa,         @w_calle,          @w_pais,        @w_correspondencia, 
               @w_alquilada,    @w_cobro,          @w_edificio,    @w_departamento, 
               @w_rural_urbano, @w_fact_serv_pu,   @w_tipo_prop,   @w_nombre_agencia,
               @w_fuente_verif, @w_fecha_ver,      getdate(),      @w_tiempo_reside,
               @w_negocio,      @w_ci_poblacion,   @w_nro,         @w_nro_interno, 
			   @w_referencia,   @w_nro_residentes, @i_canal)
			   
               if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 103005
                --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                     return  1
                  end    
            commit tran
            return 0
         end
      else
         begin
            exec cobis..sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 151051
         end
end

return 0
GO
