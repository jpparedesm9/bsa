/*************************************************************************/
/*   Archivo:            sp_sinc_arch_xml.sp                             */
/*   Stored procedure:   sp_sinc_arch_xml                                */
/*   Base de datos:      cob_sincroniza                                  */
/*   Producto:           Cliente                                         */
/*   Disenado por:       MBA                                             */
/*   Fecha de escritura: 12-07-2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP"                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa se encarga de ejecutar la conversión al formato xml   */
/*                                                                       */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*   FECHA         AUTOR      RAZON                                      */
/*   12-07-2017    MBA        Se encarga de ejecutar la conversión al    */
/*                            formato xml                                */
/*   19-09-2017    Patricio    Refactor en xml de clientes               */
/*                 Samueza                                               */
/*   11-10-2017    P. Ortiz   Agregar filtro para clientes de oficial    */
/*   17-10-2017    P. Samueza Agregar Direcciones en negocios  clientes  */
/*   10-11-2017    P. Ortiz   Agregar campo riskBureau                   */
/*   10-11-2017    P. Ortiz   enviar sólo documentos requeridos          */
/*   15-03-2019    SRO        Correcci?n esquema secuenciales            */
/*                            en si_sincroniza                           */
/*	 28-03-2019	   FSL		  Cambio de estructura conyuge				 */
/*   30-08-2019    N. Mejia   Agregar campos collective y                */
/*                            collectiveClientLevel                      */
/*   27-03-2020   S. Rojas    Biometricos                                */
/*   30/06/2021   S. Rojas    Error #161777                              */
/*   19/01/2023   WTO         Req#193221 - B2B Grupal Digital-Sincroniza */
/*   13/06/2023   ACH         209581-Ajustes nueva prospecciOn           */
/*************************************************************************/
USE cob_sincroniza
go

IF OBJECT_ID ('dbo.sp_sinc_arch_xml') IS NOT NULL
    DROP PROCEDURE dbo.sp_sinc_arch_xml
GO

create proc sp_sinc_arch_xml (
   -----------------------------------------
   --Variables de la info del cliente
   -----------------------------------------
   @i_param1                      VARCHAR(255) = null,
   @i_param2                      VARCHAR(255) = null,
   @i_param3                      VARCHAR(255) = null,
   @i_param4                      VARCHAR(255) = null,
   @i_operacion                   char(1)       = null,
   @i_sub_tipo                    char(1)       = null,  -- Consulta un tipo de consulta por el codigo actual
   @i_modo                        char(1)       = null,  -- modo en la que quiero que se llena la tabla temporal de clientes
   @i_codigo_cliente              int           = NULL,  -- Codigo para identificar al cliente
   
   @s_ssn                         int           = null,
   @s_user                        login         = null,
   @s_sesn                        int           = null,
   @s_term                        varchar(30)   = null,
   @s_date                        datetime      = null,
   @s_srv                         varchar(30)   = null,
   @s_lsrv                        varchar(30)   = null,
   @s_rol                         smallint      = null,
   @s_ofi                         smallint      = null,
   @s_org                         char(1)       = null,
   @t_debug                       char(1)       = 'N',
   @t_file                        varchar(14)   = null,
   @t_from                        varchar(32)   = null,
   @t_trn                         int           = null,
   @i_transaccion                 char(1)       = 'S',   -- Transaccion que se va a aplicar
   @i_oficial                     int           = null 
)
as
declare
-----------------------------------------
--Variables de info del cliente
-----------------------------------------
@w_codigo                        int,                  -- Codigo Secuencial si_sincroniza
@w_sp_name                       varchar(32),          -- Nombre del store procedure de la info del cliente
@w_datetime                      datetime,             -- Variable para insertar la fecha
@w_num_error                     int,                  -- Numero de error que se envia al store procedure sp_cerror
@w_parametro_tipo                varchar(50),          -- Parametro del tipo de direccion para factura
@w_parametro_relacion            int,                  -- Parametro de la persona relacionada con el cliente
@w_fechaproceso                  datetime,             -- Variable para insertar la fecha
@w_parametro_meses_v             int,                  -- Obtiene los meses vigentes de informaci?n
@w_cadena_cliente_xml            varchar(2000),        -- Cadena xml
@w_num_cliente_xml               varchar(10),          -- Número Cliente extraido cadena xml
@w_oficial_xml                   varchar(50),          -- Oficial
@w_oficial_xml_1_i               int,                  -- Oficial_1
@w_oficial_xml_2_i               int,                  -- Oficial_2
@w_en_ente                       int,                  -- Ente        
@w_en_nombre                     varchar(64),          -- Nombre
@w_p_p_apellido                  varchar(16),          -- Apellido Paterno
@w_p_s_apellido                  varchar(16),          -- Apellido Materno
@w_p_edad                        int,                  -- Edad
@w_p_sexo                        char(1),              -- Sexo
@w_p_fecha_nac                   datetime,              -- Fecha de nacimiento
@w_p_depa_nac                    smallint,              -- Entidad de Nacimiento
@w_en_pais                       smallint,              -- Pais de Nacimiento
@w_p_estado_civil                varchar(10),          -- Estado Civil
@w_en_nacionalidad               int,                  -- Nacionalidad
@w_p_nivel_estudio               varchar(10),          -- Escolaridad
@w_p_profesion                   varchar(10),          -- Ocupacion
@w_p_num_cargas                  tinyint,              -- Dependientes Economicamente
@w_curp                          varchar(4),              -- CURP
@w_en_nit                        varchar(30),          -- RFC
@w_tiene_otr_ing                 varchar(2),              -- Tiene Otros Ingresos
@w_en_otros_ingresos             money,                  -- OtrosIngresos
@w_en_ingre                      varchar(10),          -- Monto Otros Ingresos
@w_en_nro_ciclo                  int,                  -- Nro de Cliclos en Otras Instituciones
@w_en_persona_pep                char(1),              -- ?Usted es o ha sido una persona políticamente expuesta (PEP)?
@w_en_persona_pub                char(1),              -- ?Qué función desempeña o ha desempeñado?
@w_p_rel_carg_pub                varchar(10),          -- ?Tiene relación con alguien que es o ha sido PEP?
@w_en_ced_ruc                    varchar(30),          -- ?Qué parentesco?
@w_fu_login                      varchar(14),          -- Oficial
@w_fu_login_actual               varchar(14),          -- Oficial actual
@w_fu_login_anterior             varchar(14),          -- Oficial anterior
@w_sid_usuario                   varchar(14),          -- Usuario
@w_registro_cliente              varchar(max),          -- Registro del cliente xml
@w_cadena_completa_cliente_xml   varchar(max),         -- Cadena completa cliente xml
@NextString                      nvarchar(4000),
@Pos                             int,
@NextPos                         int,
@CommaCheck                      nvarchar(1),
@w_gr_grupo                      int,                   -- Grupo
@w_registro_grupo                varchar(8000),          -- Registro del grupo
@w_fu_login_grupo                varchar(14),           -- Oficial
@w_nro_registros                 INT,                  -- Numero de registros
@w_sid_id                        VARCHAR(50),
@w_direccion                     INT ,                 -- codigo de la direccion del cliente
@w_direccion_conyugue            INT,                  -- codigo de la direccion del conyugue del cliente
@w_di_nro_interno                int,  
@w_di_nro                        int,       
@w_di_ciudad                     int,      
@w_di_pais                       smallint,      
@w_di_parroquia                  int,       
@w_di_tipo_prop                  VARCHAR(10),
@w_di_codpostal                  VARCHAR(30),       
@w_di_provincia                  smallint,       
@w_di_calle                      VARCHAR(70),          
@w_di_tiempo_reside              int,   
@w_di_nro_residentes             int , 
@w_di_poblacion                  VARCHAR(30),
@w_areaCode_D                    VARCHAR(10),
@w_number_D                      VARCHAR(16),
@w_phoneId_D                     INT,
@w_areaCode_C                    VARCHAR(10),
@w_number_C                      VARCHAR(16),
@w_phoneId_C                     INT,
@w_dg_direccion                  INT,
@w_dg_lat_seg                    FLOAT,
@w_dg_long_seg                   Float,
@w_business_phoneId              varchar(3),
@w_business_phone                varchar(20),
@w_landline_one                  varchar(20),
@w_business_number_cycles        varchar(3),
@w_business_other_income         varchar(20),
@w_business_bank_account         varchar(30),
@w_ingreso                       char(1),
@w_di_referencia				 varchar(250),
@w_sin_huella_digital            char(1),
@w_msg                           varchar(1000),
@w_di_direccion                  tinyint,
@w_fecha_actualizacion           datetime
   
declare @w_documentos_digitalizados table(
   codigo          varchar(10)
)

insert into @w_documentos_digitalizados
values ('001')
insert into @w_documentos_digitalizados
values ('002')
insert into @w_documentos_digitalizados
values ('003')
insert into @w_documentos_digitalizados
values ('004')
insert into @w_documentos_digitalizados
values ('005')
insert into @w_documentos_digitalizados
values ('008')

declare @w_sincroniza_det table (
   sid_id_entidad    int,
   sid_id_1          int,
   sid_id_2          int,
   sid_xml           ntext,
   sid_accion        varchar(255),
   sid_observacion   varchar(5000),
   sid_descargado    bit
)
-----------------------------------------
--Inicializacion de Variables
-----------------------------------------
select @w_sp_name               = 'sp_sinc_arch_xml',
       @w_datetime              = convert(varchar,@s_date,101) + ' ' + convert(varchar,getdate(),108)
       
       
select 
   @i_operacion                   = @i_param1,
   @i_sub_tipo                    = @i_param2,
   @i_modo                        = @i_param3,
   @i_codigo_cliente              = convert(INT,@i_param4)


--Obtiene la fecha de proceso
select @w_fechaproceso = fp_fecha
  from cobis..ba_fecha_proceso
if @@rowcount = 0
begin
   select @w_num_error = 71412 -- 'No existe el parametro especificado - fecha de proceso 
   goto errores
end

--Obtiene el parametro de la persona en relación con el cliente
select @w_parametro_relacion = pa_int
  from cobis..cl_parametro
 where pa_nemonico = 'RCONY'
if @@rowcount = 0
begin
   select @w_num_error = 71412 -- 'No existe el parametro especificado - persona en relación con el cliente
   goto errores
end

--Obtiene los meses vigentes de información
select @w_parametro_meses_v = pa_int
  from cobis..cl_parametro
 where pa_producto  = 'CLI'
   and pa_nemonico  = 'MV'     
   and pa_parametro = 'MESES VIGENTES INFORMACION'
if @@rowcount = 0
begin
   select @w_num_error = 71412 -- 'No existe el parametro especificado - moneda local
   goto errores
end

select @w_fu_login_anterior = ' '
select @w_nro_registros = 0


if @i_operacion = 'Q'
begin
   if @i_sub_tipo = '0'    
   begin
      ------------------------------------------
      --cl_sincroniza_cliente y Domicilio
      ------------------------------------------
      --Tabla temporal para los clientes   
      create table #tabla_cliente_info_orig(
      w_en_ente         INT,
      w_fu_login         login
      )
      ---Por el id del ente
      IF(@i_modo ='1')
      BEGIN
         insert into #tabla_cliente_info_orig
         select 'NumeroCliente' = en_ente,                 
                'Funcionario'   = fu_login
         from cobis..cc_oficial o, 
              cobis..cl_funcionario f, 
              cobis..cl_ente e
         where e.en_oficial     = o.oc_oficial
         and   o.oc_funcionario = f.fu_funcionario
         and   e.en_ente        = @i_codigo_cliente 
         order by e.en_oficial
         --print 'Codigo Cliente: '+convert(varchar,@i_codigo_cliente)
         --PRINT'Entra modo 1 Ente'
      END
      --Por el la fecha de desactualizacion    
      IF(@i_modo ='2')
      BEGIN
         insert into #tabla_cliente_info_orig
         select 'NumeroCliente' = en_ente,
                'Funcionario'   = fu_login
         from cobis..cc_oficial o, 
              cobis..cl_funcionario f, 
              cobis..cl_ente e
         where e.en_oficial     = o.oc_oficial
         and   o.oc_funcionario = f.fu_funcionario
         and   datediff(mm,e.en_fecha_mod,@w_fechaproceso) > @w_parametro_meses_v --
         order by e.en_oficial  
         ----print'Entra modo 2'
      END    
      --Todos los clientes        
      IF(@i_modo ='3')
      BEGIN
         insert into #tabla_cliente_info_orig
         select 'NumeroCliente' = en_ente,
                'Funcionario'   = fu_login
         from cobis..cc_oficial o, 
              cobis..cl_funcionario f, 
              cobis..cl_ente e
         where e.en_oficial     = o.oc_oficial
         and   o.oc_funcionario = f.fu_funcionario
         order by e.en_oficial
      END
      --Todos los clientes de un oficial determinado
      IF(@i_modo ='4')
      BEGIN
        insert into #tabla_cliente_info_orig
        select  'NumeroCliente' = en_ente,
                'Funcionario'   = fu_login
        from cobis..cc_oficial o, 
             cobis..cl_funcionario f, 
             cobis..cl_ente e
        where e.en_oficial     = o.oc_oficial
        AND   o.oc_oficial     = @i_oficial
        and   o.oc_funcionario = f.fu_funcionario
        order by e.en_oficial
      END
	  
      --Por la fecha y el oficial
      IF(@i_modo ='5')
      BEGIN
         select @w_fecha_actualizacion = dateadd(m, -1*@w_parametro_meses_v, @w_fechaproceso)
		 insert into #tabla_cliente_info_orig
         select 'NumeroCliente' = en_ente,
                'Funcionario'   = fu_login
         from cobis..cc_oficial o, 
              cobis..cl_funcionario f, 
              cobis..cl_ente e
         where e.en_oficial     = o.oc_oficial
         and   o.oc_funcionario = f.fu_funcionario
		 AND   o.oc_oficial     = @i_oficial
		 and e.en_fecha_mod >= @w_fecha_actualizacion
         order by e.en_oficial

      END
	  
      declare Cursor_Oficiales cursor FOR
      SELECT DISTINCT w_fu_login 
      from #tabla_cliente_info_orig
      group by w_fu_login    
             
      open Cursor_Oficiales
      fetch next from Cursor_Oficiales into @w_sid_usuario  
       
      while @@fetch_status = 0
      begin
         /*SELECT @w_nro_registros = count(*) 
         FROM   #tabla_cliente_info_orig
         WHERE  w_fu_login = @w_sid_usuario */
         --print'NUMERO DE REGISTROS: '+CONVERT(VARCHAR(50),@w_nro_registros)
         
                    
                               
         declare Cursor_Clientes cursor for
         select w_en_ente
         from   #tabla_cliente_info_orig
         WHERE  w_fu_login= @w_sid_usuario
         order by w_en_ente
         
         open Cursor_Clientes
         fetch next from Cursor_Clientes into @w_en_ente
         select @w_ingreso = 'N'  
         while @@fetch_status = 0 begin      
            --PRINT'@w_sid_usuario'+convert(VARCHAR(50),@w_sid_usuario)
            -- BEGIN
            --PRINT'ENTE'+convert(VARCHAR(50),@w_en_ente)
               select
                  @w_direccion                     = 99,
                  @w_direccion_conyugue            = 99,
                  @w_di_nro_interno                = 0,
                  @w_di_nro                        = 0,
                  @w_di_ciudad                     = 1,
                  @w_di_pais                       = 484,
                  @w_di_parroquia                  = 1,
                  @w_di_tipo_prop                  = 'PRO',
                  @w_di_codpostal                  = 20000,
                  @w_di_provincia                  = 1,
                  @w_di_calle                      = 0,
                  @w_di_tiempo_reside              = 1,
                  @w_di_nro_residentes             = 1,
                  @w_di_poblacion                  = 'NA',
                  @w_areaCode_D                    = null,
                  @w_number_D                      = null,
                  @w_phoneId_D                     = null,
                  @w_areaCode_C                    = '52',
                  @w_number_C                      = '9999999999',
                  @w_phoneId_C                     = 99,
                  @w_dg_direccion                  = null,
                  @w_dg_lat_seg                    = null,
                  @w_dg_long_seg                   = null,
                  @w_business_phoneId              = 99,
                  @w_business_phone                = '9999999999',
                  @w_landline_one                  = null,
                  @w_business_number_cycles        = 99,
                  @w_business_other_income         = null,
                  @w_business_bank_account         = null
               --MTA Fin
                IF EXISTS( SELECT 1 
                           FROM   cobis..cl_direccion d, 
                                  cobis..cl_ente e
                           where  d.di_tipo in ('RE') 
                           and    d.di_ente = e.en_ente 
                           and    di_principal='S' 
                           and    e.en_ente = @w_en_ente)
                BEGIN
                   --PRINT'La Direccion de Domicilio es Principal'
                   --Obtengo datos de la direccion de Domicilio cuando es princincipal
                   SELECT  @w_direccion         = di_direccion,    
                           @w_di_nro_interno    = di_nro_interno,  
                           @w_di_nro            = di_nro,          
                           @w_di_ciudad         = di_ciudad,      
                           @w_di_pais           = di_pais,         
                           @w_di_parroquia      = di_parroquia,       
                           @w_di_tipo_prop      = rtrim(di_tipo_prop),
                           @w_di_codpostal      = di_codpostal,      
                           @w_di_provincia      = di_provincia,      
                           @w_di_calle          = di_calle,          
                           @w_di_tiempo_reside  = di_tiempo_reside,  
                           @w_di_nro_residentes = di_nro_residentes , 
                           @w_di_poblacion      = rtrim(di_poblacion),
						   @w_di_referencia		= di_referencia
                   FROM    cobis..cl_direccion d, 
                           cobis..cl_ente e
                   where   d.di_tipo in ('RE') 
                   and d.di_ente = e.en_ente 
                   and di_principal='S' 
                   and e.en_ente = @w_en_ente
                   
                   --Obtengo datos del telefono Celular de Domicilio cuando es principal
                   SELECT TOP 1
                          @w_areaCode_C = t.te_area,      
                          @w_number_C   = isnull(t.te_valor, '9999999999'), --valor por defecto
                          @w_phoneId_C  = t.te_secuencial  
                   FROM   cobis..cl_telefono t,
                          cobis..cl_direccion d,
                          cobis..cl_ente e
                   WHERE te_ente      = di_ente
                   and   di_ente      = e.en_ente
                   and   te_direccion = di_direccion
                   and   di_principal = 'S' 
                   and   d.di_tipo    in ('RE') 
                   and   t.te_tipo_telefono = 'C'
                   and   e.en_ente    = @w_en_ente
             
                   --Obtengo los datos georferenciales de la direccion de Domicilio cuando es principal    
                   SELECT TOP 1   
                          @w_dg_direccion = dg_direccion,
                          @w_dg_lat_seg   = dg_lat_seg,  
                          @w_dg_long_seg  = dg_long_seg        
                   FROM   cobis..cl_direccion d,
                          cobis..cl_direccion_geo geo
                   where  d.di_tipo in ('RE')  
                   and    d.di_ente    = geo.dg_ente
                   and    dg_direccion = di_direccion
                   and    di_principal = 'S'
                   and    d.di_ente    = @w_en_ente
                
                   -- Obtengo los datos del telefono directo de la direccion de Domicilio cuando es principal  
                   SELECT TOP 1
                          @w_areaCode_D = t.te_area,
                          @w_number_D   = isnull(t.te_valor, '9999999999'), --valor por defecto 
                          @w_phoneId_D  = t.te_secuencial
                   FROM   cobis..cl_telefono t,
                          cobis..cl_direccion d,
                          cobis..cl_ente e
                   WHERE  te_ente      = di_ente
                   and    di_ente      = e.en_ente
                   and    te_direccion = di_direccion
                   and    d.di_tipo   in ('RE')
                   and    di_principal = 'S' 
                   and    t.te_tipo_telefono = 'D'
                   and    e.en_ente    = @w_en_ente   
                   --PRINT'@w_direccion domiciolio principal'+convert(VARCHAR(50),@w_direccion)
                END
                ELSE
                BEGIN
                   --PRINT'La Direccion de Domicilio no es Principal'   
                   --Obtengo datos de la direccion de Domicilio cuando no es princincipal
                   SELECT TOP 1 @w_direccion         = di_direccion,    
                               @w_di_nro_interno     = di_nro_interno,  
                               @w_di_nro             = di_nro,          
                               @w_di_ciudad          = di_ciudad,      
                               @w_di_pais            = di_pais,         
                               @w_di_parroquia       = di_parroquia,       
                               @w_di_tipo_prop       = rtrim(di_tipo_prop),
                               @w_di_codpostal       = di_codpostal,       
                               @w_di_provincia       = di_provincia,       
                               @w_di_calle           = di_calle,           
                               @w_di_tiempo_reside   = di_tiempo_reside,   
                               @w_di_nro_residentes  = di_nro_residentes , 
                               @w_di_poblacion       = rtrim(di_poblacion),
							   @w_di_referencia		 = di_referencia
                   FROM   cobis..cl_direccion d, 
                          cobis..cl_ente e
                   where  d.di_tipo in ('RE')
                   and    d.di_ente = e.en_ente 
                   and    e.en_ente = @w_en_ente
       
                   if @w_direccion is NULL OR @w_direccion = 99
                      goto SIGUIENTE_CL
                 
                   --Obtengo datos del telefono Celular de Domicilio cuando no es principal
                   SELECT TOP 1 
                          @w_areaCode_C = t.te_area,      
                          @w_number_C   = isnull(t.te_valor, '9999999999'), --valor por defecto 
                          @w_phoneId_C  = t.te_secuencial  
                   FROM   cobis..cl_telefono t,
                          cobis..cl_direccion d,
                          cobis..cl_ente e
                   WHERE  te_ente      = di_ente
                   and    di_ente      = e.en_ente
                   and    te_direccion = di_direccion
                   and    d.di_tipo    in ('RE') 
                   and    t.te_tipo_telefono = 'C'
                   and    e.en_ente   = @w_en_ente
       
                   --Obtengo los datos georferenciales de la direccion de Domicilio cuando no es principal    
                   SELECT TOP 1  
                          @w_dg_direccion = dg_direccion,
                          @w_dg_lat_seg   = dg_lat_seg,  
                          @w_dg_long_seg  = dg_long_seg        
                   FROM   cobis..cl_direccion d,
                          cobis..cl_direccion_geo geo
                   where  d.di_tipo in ('RE')  
                   and    d.di_ente    = geo.dg_ente
                   and    dg_direccion = di_direccion
                   and    d.di_ente    = @w_en_ente
       
                   -- Obtengo los datos del telefono directo de la direccion de Domicilio cuando no es principal  
                   SELECT TOP 1 
                          @w_areaCode_D = t.te_area,
                          @w_number_D   = isnull(t.te_valor, '9999999999'), --valor por defecto
                          @w_phoneId_D  = t.te_secuencial
                   FROM   cobis..cl_telefono t,
                          cobis..cl_direccion d,
                          cobis..cl_ente e
                   WHERE  te_ente    = di_ente
                   and    di_ente      = e.en_ente
                   and    te_direccion = di_direccion
                   and    d.di_tipo   in ('RE') 
                   and    t.te_tipo_telefono = 'D'
                   and    e.en_ente    = @w_en_ente  
                END
                  
                SELECT @w_direccion_conyugue = di_direccion
                FROM   cobis..cl_instancia, 
                       cobis..cl_direccion
                WHERE  in_relacion = @w_parametro_relacion 
                AND    in_ente_i   = @w_en_ente -- CONYUGE
                AND    in_ente_d   = di_ente
                AND    di_tipo     IN ('RE')
               --print '@w_direccion_conyugue: '+convert(varchar,@w_direccion_conyugue)
                
                SELECT @w_business_phoneId = CAST(t.te_secuencial as varchar),
                       @w_business_phone   = isnull(CAST(t.te_valor as varchar), '9999999999') --valor por defecto 
                FROM   cobis..cl_direccion d,
                       cobis..cl_ente e,
                       cobis..cl_telefono t
                WHERE  di_ente        = e.en_ente
                AND    t.te_direccion = d.di_direccion
                AND    te_ente        = di_ente 
                AND    d.di_tipo      in ('AE') 
                AND    t.te_tipo_telefono = 'D'
                AND    e.en_ente      = @w_en_ente
                   
			   --print '@w_business_phoneId: '+convert(varchar,@w_business_phoneId)
			   --print '@w_business_phone: '+convert(varchar,@w_business_phone)
			   
                select @w_landline_one = rtrim(rp_telefono_d)
                from   cobis..cl_ref_personal r
                where  rp_persona = @w_en_ente
                and    rp_referencia = (select min(rp_referencia) from cobis..cl_ref_personal where rp_persona = r.rp_persona)
                   
			   --print '@w_landline_one: '+convert(varchar,@w_landline_one)
			   
                select @w_business_number_cycles = convert(varchar,en_nro_ciclo),
                       @w_business_other_income = convert(varchar, ea_ventas),
                       @w_business_bank_account = convert(varchar,ea_cta_banco)
                FROM cobis..cl_ente, cobis..cl_ente_aux
                where en_ente = ea_ente
                and ea_ente = @w_en_ente
               --print '@w_business_number_cycles: '+convert(varchar,@w_business_number_cycles)   
               --print '@w_business_other_income: '+convert(varchar,@w_business_other_income) 
			   --print '@w_business_bank_account: '+convert(varchar,@w_business_bank_account) 
                  
                select @w_registro_cliente = '<customerSynchronizedData>'
                
                select @w_registro_cliente = @w_registro_cliente + '<address>' --primera direccion inicio
                if @w_direccion is not null
                BEGIN             
                    select @w_registro_cliente = @w_registro_cliente + '<addressId>' + CONVERT(varchar, @w_direccion) + '</addressId>'

                    select @w_registro_cliente = @w_registro_cliente + '<address>'
                    IF @w_di_nro_interno is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<addressInternalNumber>' + convert(varchar, @w_di_nro_interno) + '</addressInternalNumber>'
                    END
                    IF @w_di_nro is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<addressNumber>' + convert(varchar, @w_di_nro) + '</addressNumber>'
                    END
                    IF @w_di_ciudad is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<cityCode>' + convert(varchar, @w_di_ciudad) + '</cityCode>'
                    END                 
                    IF @w_di_pais is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<countryCode>' + convert(varchar, @w_di_pais) + '</countryCode>'
                    END                 
                    IF @w_di_parroquia is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<neighborhoodCode>' + convert(varchar, @w_di_parroquia) + '</neighborhoodCode>'
                    END                 
                    IF @w_di_tipo_prop is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<ownershipType>' + @w_di_tipo_prop + '</ownershipType>'
                    END
                    IF @w_di_codpostal is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<postalCode>' + convert(varchar, @w_di_codpostal) + '</postalCode>'
                    END                 
                    IF @w_di_provincia is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<stateCode>' + convert(varchar, @w_di_provincia) + '</stateCode>'
                    END                 
                    IF @w_di_calle is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<street>' + @w_di_calle + '</street>'
                    END                 
                    IF @w_di_tiempo_reside is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<yearsAtAddress>' + convert(varchar, @w_di_tiempo_reside) + '</yearsAtAddress>'
                    END                 
                    IF @w_di_nro_residentes is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<numberOfResidents>' + convert(varchar, @w_di_nro_residentes) + '</numberOfResidents>'
                    END                 
                    IF @w_di_poblacion is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<referenceLandmark>' + @w_di_poblacion + '</referenceLandmark>'
                    END
					IF @w_di_referencia is not NULL
                    BEGIN
                       select @w_registro_cliente = @w_registro_cliente + '<reference>' + @w_di_referencia + '</reference>'
                    END
                    select @w_registro_cliente = @w_registro_cliente + '</address>'
                END
                             
                select @w_registro_cliente = @w_registro_cliente + '<cellphone>'                
                IF @w_areaCode_C is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<areaCode>' + convert(varchar, @w_areaCode_C) + '</areaCode>'
                END             
                IF @w_number_C is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<number>' + convert(varchar, @w_number_C) + '</number>'
                END             
                IF @w_phoneId_C is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<phoneId>' + convert(varchar, @w_phoneId_C) + '</phoneId>'
                END
				
				select top 1 @w_registro_cliente = @w_registro_cliente + 
					CASE WHEN ct_verificacion is not null
					THEN '<verifyPhone>' + ct_verificacion + '</verifyPhone>'
						ELSE ''
					END
				from cobis..cl_verif_co_tel
				where ct_ente = @w_en_ente
				and ct_tipo = 'C'
				and ct_verificacion = 'S'
				order by ct_fecha desc

                select @w_registro_cliente = @w_registro_cliente + '</cellphone>'

                select @w_registro_cliente = @w_registro_cliente + '<emailAddress>'
				select @w_di_direccion = di_direccion
				FROM   cobis..cl_direccion d
				where  d.di_tipo in ('CE')
				and    di_ente = @w_en_ente
				order by d.di_direccion

                if @w_di_direccion is not null
                begin                
                   select @w_registro_cliente = @w_registro_cliente + 
                          '<addressId>' + convert(varchar, di_direccion) + '</addressId>' +
                          '<email>' + isnull(di_descripcion, 'pruebas.santander@santander.com') + '</email>' --correo por defecto
                   FROM   cobis..cl_direccion d, 
                          cobis..cl_ente e
                   where  d.di_tipo in ('CE')
                   and    d.di_ente = e.en_ente
                   and    e.en_ente = @w_en_ente
				   
				   select top 1 @w_registro_cliente = @w_registro_cliente + 
						CASE WHEN ct_verificacion is not null
						THEN '<verifyEmail>' + ct_verificacion + '</verifyEmail>'
							ELSE ''
						END						
					from cobis..cl_verif_co_tel
					where ct_ente = @w_en_ente
					and ct_tipo = 'CE'
					--and ct_verificacion = 'S'
					and ct_direccion = @w_di_direccion
					order by ct_fecha desc
				   
                end
                else begin
                   select @w_registro_cliente = @w_registro_cliente + '' + '' --cuando no tiene correo electronico
                end
				select @w_registro_cliente = @w_registro_cliente + '</emailAddress>'

                select @w_registro_cliente = @w_registro_cliente + '<geoReference>'             
                IF @w_dg_direccion is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<addressId>' + convert(varchar, @w_dg_direccion) + '</addressId>'
                END             
                IF @w_dg_lat_seg is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<latitude>' + LTRIM(str(@w_dg_lat_seg, 20, 10)) + '</latitude>'
                END             
                IF @w_dg_long_seg is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<longitude>' + LTRIM(str(@w_dg_long_seg, 20, 10)) + '</longitude>'
                END             
                select @w_registro_cliente = @w_registro_cliente + '</geoReference>'
                
                select @w_registro_cliente = @w_registro_cliente + '<phone>'
                IF @w_areaCode_D is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<areaCode>' + convert(varchar, @w_areaCode_D) + '</areaCode>'
                END             
                IF @w_number_D is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<number>' + convert(varchar, @w_number_D) + '</number>'
                END             
                IF @w_phoneId_D is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<phoneId>' + convert(varchar, @w_phoneId_D) + '</phoneId>'
                END
				
				select top 1 @w_registro_cliente = @w_registro_cliente + 
					CASE WHEN ct_verificacion is not null
					THEN '<verifyPhone>' + ct_verificacion + '</verifyPhone>'
						ELSE ''
					END
				from cobis..cl_verif_co_tel
				where ct_ente = @w_en_ente
				and ct_tipo = 'D'
				and ct_verificacion = 'S'
				order by ct_fecha desc

				
                select @w_registro_cliente = @w_registro_cliente + '</phone>'
                
                select @w_registro_cliente = @w_registro_cliente + '</address>' --primera direccion fin
                
                select @w_registro_cliente = @w_registro_cliente + '<business>'             
                select @w_registro_cliente = @w_registro_cliente + '<business>' + 
                       '<businessId>' + convert(varchar, nc_codigo) + '</businessId>' +
                       CASE WHEN nc_destino_credito is not null
                           THEN '<creditPurpose>' + nc_destino_credito + '</creditPurpose>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_actividad_ec is not null
                           THEN '<industry>' + convert(varchar, nc_actividad_ec) + '</industry>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_ingreso_mensual is not null
                           THEN '<monthlyRevenue>' + convert(varchar, (SELECT round (nc_ingreso_mensual,2))) + '</monthlyRevenue>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_nombre is not null
                           THEN '<name>' + nc_nombre + '</name>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_fecha_apertura is not null
                           THEN '<openDate>' + (SELECT format(nc_fecha_apertura,'yyyy-MM-ddTHH:mm:ss.fffZ')) + '</openDate>'
                           ELSE ''
                       END
                       +
                       CASE WHEN @w_business_phoneId is not null
                           THEN '<phoneId>' + @w_business_phoneId + '</phoneId>'
                           ELSE ''
                       END
                       +
                       CASE WHEN @w_business_phone is not null
                           THEN '<phone>' + @w_business_phone + '</phone>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_giro is not null
                           THEN '<transfer>' + nc_giro + '</transfer>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_recurso is not null
                           THEN '<withWhatResourceWillPayForCredit>' + nc_recurso + '</withWhatResourceWillPayForCredit>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_tiempo_dom_neg is not null
                           THEN '<yearsInBusiness>' + convert(varchar, nc_tiempo_dom_neg) + '</yearsInBusiness>'
                           ELSE ''
                       END
                       +
                       CASE WHEN nc_tipo_local is not null
                           THEN '<ownershipType>' + convert(varchar, nc_tipo_local) + '</ownershipType>'
                           ELSE ''
                       END
					   +
                       CASE WHEN nc_otro_recurso is not null
                           THEN '<otherWithWhatResourceWillPayForCredit>' + convert(varchar, nc_otro_recurso) + '</otherWithWhatResourceWillPayForCredit>'
                           ELSE ''
                       END
                       +
                       '</business>'
                from  cobis..cl_negocio_cliente, 
                      cobis..cl_ente e
                where nc_ente       = en_ente
                and   nc_estado_reg = 'V'
                and   e.en_ente     = @w_en_ente
                
                select @w_registro_cliente = @w_registro_cliente + '<address>' +
                       '<addressId>' + convert(varchar, d.di_direccion) + '</addressId>' +
                       CASE WHEN d.di_nro_interno is not null
                           THEN '<addressInternalNumber>' + convert(varchar, d.di_nro_interno) + '</addressInternalNumber>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_nro is not null
                           THEN '<addressNumber>' + convert(varchar, d.di_nro) + '</addressNumber>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_ciudad is not null
                           THEN '<cityCode>' + convert(varchar, d.di_ciudad) + '</cityCode>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_pais is not null
                           THEN '<countryCode>' + convert(varchar, d.di_pais) + '</countryCode>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_parroquia is not null
                           THEN '<neighborhoodCode>' + convert(varchar, d.di_parroquia) + '</neighborhoodCode>'
                           ELSE ''
                       END
                       +
                       CASE WHEN di_tipo_prop is not null
                           THEN '<ownershipType>' + LTRIM(RTRIM(di_tipo_prop)) + '</ownershipType>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_codpostal is not null
                           THEN '<postalCode>' + convert(varchar, d.di_codpostal) + '</postalCode>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_provincia is not null
                           THEN '<stateCode>' + convert(varchar, d.di_provincia) + '</stateCode>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_calle is not null
                           THEN '<street>' + convert(varchar, d.di_calle) + '</street>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_tiempo_reside is not null
                           THEN '<yearsAtAddress>' + convert(varchar, d.di_tiempo_reside) + '</yearsAtAddress>'
                           ELSE ''
                       END
                       +
                       CASE WHEN d.di_nro_residentes is not null
                           THEN '<numberOfResidents>' + convert(varchar, d.di_nro_residentes) + '</numberOfResidents>'
                           ELSE ''
                       END
                       +
                       CASE WHEN di_poblacion is not null
                           THEN '<referenceLandmark>' + rtrim(di_poblacion) + '</referenceLandmark>'
                           ELSE ''
                       END
					   +
                       CASE WHEN di_referencia is not null
                           THEN '<reference>' + rtrim(di_referencia) + '</reference>'
                           ELSE ''
                       END
                       +
                       '</address>'
                from cobis..cl_direccion d, 
                     cobis..cl_ente e
                where d.di_tipo in ('AE')
                and d.di_ente = e.en_ente                                       
                and e.en_ente = @w_en_ente
                       
                select @w_registro_cliente = @w_registro_cliente + '<geoReference>' +
                       CASE WHEN geo.dg_direccion is not null
                           THEN '<addressId>' + convert(varchar, geo.dg_direccion) +  '</addressId>'
                           ELSE ''
                       END
                       + 
                       CASE WHEN geo.dg_lat_seg is not null
                           THEN '<latitude>' + LTRIM(str(geo.dg_lat_seg, 20, 10)) + '</latitude>'
                           ELSE ''
                       END
                       +
                       CASE WHEN geo.dg_long_seg is not null
                           THEN '<longitude>' + LTRIM(str(geo.dg_long_seg, 20, 10)) + '</longitude>'
                           ELSE ''
                       END
                       +
                       '</geoReference>'
                FROM   cobis..cl_direccion d, 
                       cobis..cl_direccion_geo geo
                where  d.di_tipo in ('AE')  
                AND    d.di_ente     = geo.dg_ente
                AND    dg_direccion  = di_direccion
                and    d.di_ente     = @w_en_ente                    
                select @w_registro_cliente = @w_registro_cliente + '</business>'
                
				--print 'Customer'
				--print @w_registro_cliente
				
                select @w_registro_cliente = @w_registro_cliente + '<customer>'
                
                select @w_registro_cliente = @w_registro_cliente + 
                '<customer>' +
                CASE WHEN p_fecha_nac is not null
                    THEN '<birthDate>' + (SELECT format(p_fecha_nac,'yyyy-MM-ddTHH:mm:ss.fffZ')) + '</birthDate>'
                    ELSE ''
                END
                +
                CASE WHEN p_depa_nac is not null
                    THEN '<cityBirth>' + convert(varchar, p_depa_nac) + '</cityBirth>'
                    ELSE ''
                END
                +
                CASE WHEN en_ente is not null
                    THEN '<customerId>' + convert(varchar, en_ente) + '</customerId>'
                    ELSE ''
                END
                +
                CASE WHEN en_ced_ruc is not null
                    THEN '<documentNumber>' + en_ced_ruc + '</documentNumber>'
                    ELSE ''
                END
                +
                CASE WHEN en_tipo_ced is not null
                    THEN '<documentType>' + en_tipo_ced + '</documentType>'
                    ELSE ''
                END
                +
                CASE WHEN en_nombre is not null
                    THEN '<firstName>' + en_nombre + '</firstName>'
                    ELSE ''
                END
                +
                CASE WHEN p_sexo is not null
                    THEN '<gender>' + p_sexo + '</gender>'
                    ELSE ''
                END
                +
                CASE WHEN p_estado_civil is not null
                    THEN '<maritalStatus>' + p_estado_civil + '</maritalStatus>'
                    ELSE ''
                END
                +
                CASE WHEN p_s_nombre is not null
                    THEN '<secondName>' + p_s_nombre + '</secondName>'
                    ELSE ''
                END
                +
                CASE WHEN p_p_apellido is not null
                    THEN '<surname>' + p_p_apellido + '</surname>'
                    ELSE ''
                END
                +
                CASE WHEN p_s_apellido is not null
                    THEN '<secondSurname>' + p_s_apellido + '</secondSurname>'
                    ELSE ''
                END
                +
                CASE WHEN p_pais_emi is not null
                    THEN '<countryOfBirth>' + convert(varchar, p_pais_emi) + '</countryOfBirth>'
                    ELSE ''
                END
                +
                CASE WHEN p_nivel_estudio is not null
                    THEN '<education>' + convert(varchar, p_nivel_estudio) + '</education>'
                    ELSE ''
                END
                +
                CASE   
                    WHEN en_ing_SN ='S' THEN '<hasOtherIncome>true</hasOtherIncome>'   
                    WHEN en_ing_SN ='N' THEN '<hasOtherIncome>false</hasOtherIncome>'   
                    WHEN en_ing_SN is null THEN ''
                END
                +
                CASE WHEN en_nac_aux is not null
                    THEN '<nationality>' + convert(varchar, en_nac_aux) + '</nationality>'
                    ELSE ''
                END
                +
                CASE WHEN @w_business_number_cycles is not null
                    THEN '<numberOfCycles>' + @w_business_number_cycles + '</numberOfCycles>'
                    ELSE ''
                END
                +
                CASE WHEN p_num_cargas is not null
                    THEN '<numberOfDependents>' + convert(varchar, p_num_cargas) + '</numberOfDependents>'
                    ELSE ''
                END
                +
                CASE WHEN @w_business_other_income is not null
                    THEN '<otherIncome>' + @w_business_other_income + '</otherIncome>'
                    ELSE ''
                END
                +
                CASE WHEN en_otringr is not null
                    THEN '<otherIncomeSource>' + en_otringr + '</otherIncomeSource>'
                    ELSE ''
                END
                +
                CASE
                    WHEN en_persona_pub ='S' THEN '<personPep>true</personPep>'
                    WHEN en_persona_pub ='N' THEN '<personPep>false</personPep>'
                    WHEN en_persona_pub is null THEN ''
                END
                +
                CASE WHEN p_rel_carg_pub is not null
                    THEN '<pepRelationship>' + rtrim(p_rel_carg_pub) + '</pepRelationship>'
                    ELSE ''
                END
                +
                CASE WHEN p_profesion is not null
                    THEN '<profession>' + convert(varchar,p_profesion) + '</profession>'
                    ELSE ''
                END
                +
                CASE WHEN en_nit is not null
                    THEN '<rfc>' + convert(varchar,en_nit) + '</rfc>'
                    ELSE ''
                END
                +
                CASE WHEN en_banco is not null
                    THEN '<bankCode>' + convert(varchar, en_banco) + '</bankCode>'
                    ELSE ''
                END
                +
                CASE WHEN @w_business_bank_account is not null
                    THEN '<bankAccount>' + @w_business_bank_account + '</bankAccount>'
                    ELSE ''
                END
                +
                CASE WHEN p_calif_cliente is not null
                    THEN '<riskBureau>' + p_calif_cliente + '</riskBureau>'
                    ELSE ''
                END
				+
                CASE WHEN (select top 1 di_descripcion from cobis..cl_direccion where di_ente=@w_en_ente and di_tipo='CE') is not null
                    THEN '<emailAddress>' + (select top 1 di_descripcion from cobis..cl_direccion where di_ente=@w_en_ente and di_tipo='CE') + '</emailAddress>'
                    ELSE ''
                              END
                +
                CASE WHEN ea_colectivo is not null
                    THEN '<collective>' + ea_colectivo + '</collective>'
                    ELSE ''
                END
                +
                CASE WHEN ea_nivel_colectivo is not null
                    THEN '<collectiveClientLevel>' + ea_nivel_colectivo + '</collectiveClientLevel>'
                    ELSE ''
                END
				+
                CASE WHEN p_otro_profesion is not null
                    THEN '<whichProfession>' + p_otro_profesion + '</whichProfession>'
                    ELSE ''
                END
                from cobis..cl_ente , cobis..cl_ente_aux  
                where en_ente = @w_en_ente
                 and  en_ente = ea_ente
                
                if exists (select 1 from cobis..cl_ente_bio where eb_ente = @w_en_ente) begin
				   select @w_registro_cliente = @w_registro_cliente + 
                   CASE WHEN eb_tipo_identificacion is not null
                       THEN '<bioIdentificationType>' + eb_tipo_identificacion + '</bioIdentificationType>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_cic is not null
                       THEN '<bioCIC>' + eb_cic + '</bioCIC>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_ocr is not null
                       THEN '<bioOCR>' + eb_ocr + '</bioOCR>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_nro_emision is not null
                       THEN '<bioEmissionNumber>' + eb_nro_emision + '</bioEmissionNumber>'
                       ELSE ''
                   END				
				   +
                   CASE WHEN eb_clave_elector is not null
                       THEN '<bioReaderKey>' + eb_clave_elector + '</bioReaderKey>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_sin_huella_dactilar is not null
                       THEN '<bioHasFingerprint>' + eb_sin_huella_dactilar + '</bioHasFingerprint>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_anio_emision is not null
                       THEN '<emissionYear>' + eb_anio_emision + '</emissionYear>'
                       ELSE ''
                   END
				   +
                   CASE WHEN eb_anio_registro is not null
                       THEN '<registerYear>' + eb_anio_registro + '</registerYear>'
                       ELSE ''
                   END
				   from cobis..cl_ente_bio where eb_ente = @w_en_ente				   
			   
                end
				else begin
				   select @w_registro_cliente = @w_registro_cliente +
				   '<bioIdentificationType></bioIdentificationType>'+
				   '<bioCIC></bioCIC>'+
				   '<bioOCR></bioOCR>'+
				   '<bioEmissionNumber></bioEmissionNumber>'+
				   '<bioReaderKey></bioReaderKey>'+
				   '<bioHasFingerprint></bioHasFingerprint>'+
				   '<emissionYear></emissionYear>'+
				   '<registerYear></registerYear>'
				end
				
				select @w_registro_cliente = @w_registro_cliente + 
				CASE WHEN ea_consulto_renapo is not null
                    THEN '<bioRenapoResult>' + ltrim(rtrim(ea_consulto_renapo)) + '</bioRenapoResult>'
                    ELSE '<bioRenapoResult>N</bioRenapoResult>'
                END
				+ '</customer>'
				from cobis..cl_ente_aux where ea_ente = @w_en_ente
                select @w_registro_cliente = @w_registro_cliente + '</customer>'                
                
				--print 'Customer 2'
				--print @w_registro_cliente
				
                select @w_registro_cliente = @w_registro_cliente + '<paymentCapacity>'
                select @w_registro_cliente = @w_registro_cliente + '<paymentCapacity>' +
                       CASE WHEN ea_ct_operativo is not null
                           THEN '<monthlyBusinessExpenses>'  + convert(varchar,round(ea_ct_operativo,2)) + '</monthlyBusinessExpenses>'
                           ELSE ''
                       END
                       +
                       CASE WHEN ea_ct_ventas is not null
                           THEN '<monthlyFamilyExpense>'  + convert(varchar,round(ea_ct_ventas,2)) + '</monthlyFamilyExpense>'
                           ELSE ''
                       END
                       +
                       CASE WHEN en_otros_ingresos is not null
                           THEN '<monthlyIncome>'  + convert(varchar,round(en_otros_ingresos,2)) + '</monthlyIncome>'
                           ELSE ''
                       END
                       +
		       CASE WHEN ea_ventas is not null
                           THEN '<monthlyOtherIncome>'  + convert(varchar,round(ea_ventas,2)) + '</monthlyOtherIncome>'
                           ELSE ''
                       END
                       +
		       CASE WHEN en_otringr is not null
                           THEN '<monthlyOtherIncomeSource>'  + convert(varchar,en_otringr) + '</monthlyOtherIncomeSource>'
                           ELSE ''
                       END
                       +
		       CASE WHEN en_ing_SN is not null
                           THEN '<hasOtherIncome>'  + convert(varchar,en_ing_SN,2) + '</hasOtherIncome>'
                           ELSE ''
                       END
                       +
                       '</paymentCapacity>'
                from   cobis..cl_ente_aux,
                       cobis..cl_ente
                where  ea_ente = @w_en_ente
                and    ea_ente = en_ente                    
                select @w_registro_cliente = @w_registro_cliente + '</paymentCapacity>'
                        
                select @w_registro_cliente = @w_registro_cliente + '<referenceList>'
                select @w_registro_cliente = @w_registro_cliente + '<reference>' +
                       CASE WHEN rp_referencia is not null
                           THEN '<referenceId>' + convert(varchar, rp_referencia) + '</referenceId>'
                           ELSE ''
                       END
                       +
                       CASE WHEN rp_nombre is not null
                           THEN '<firstName>' + rp_nombre + '</firstName>'
                           ELSE ''
                       END
                       +
                       CASE WHEN rp_p_apellido is not null
                           THEN '<surname>' + rp_p_apellido + '</surname>'
                           ELSE ''
                       END
                       +
                       CASE WHEN rp_telefono_d is not null
                           THEN '<phone>' + rtrim(rp_telefono_d) + '</phone>'
                           ELSE ''
                       END
                       +
                       CASE WHEN rp_direccion_e is not null
                           THEN '<emailAddress>' + rtrim(rp_direccion_e) + '</emailAddress>'
                           ELSE ''
                       END
                       +
                       CASE WHEN rp_tiempo_conocido is not null
                           THEN '<timeOfRelationship>' + convert(varchar, rp_tiempo_conocido) + '</timeOfRelationship>'
                           ELSE ''
                       END
                       +
                       '</reference>'
                from  cobis..cl_ente e, 
                      cobis..cl_ref_personal rp
                where e.en_ente = rp.rp_persona
                and   e.en_ente = @w_en_ente
                select @w_registro_cliente = @w_registro_cliente + '</referenceList>'
                       
                select @w_registro_cliente = @w_registro_cliente + '<spouse>'                    
                select @w_registro_cliente = @w_registro_cliente + '<additional>' +
                              CASE WHEN in_ente_d is not null
                                  THEN '<spouseId>' + convert(varchar, in_ente_d) + '</spouseId>'
                                  ELSE ''
                              END
                              +
                              CASE WHEN en_nacionalidad is not null
                                  THEN '<countryOfBirth>' + convert(varchar, en_nacionalidad) +  '</countryOfBirth>'
                                  ELSE ''
                              END
                              +
                              CASE WHEN p_nivel_estudio is not null
                                  THEN '<education>' + convert(varchar, p_nivel_estudio) + '</education>'
                                  ELSE ''
                              END
                              +
                              CASE WHEN en_nac_aux is not null
                                  THEN '<nationality>' + convert(varchar, en_nac_aux) + '</nationality>'
                                  ELSE ''
                              END
                              +
                              CASE WHEN p_profesion is not null
                              THEN '<profession>' + convert(varchar, p_profesion) + '</profession>'
                              ELSE ''
                       END
                       +
                       '</additional>'
                from   cobis..cl_instancia, 
                       cobis..cl_ente EN
                where  in_relacion = @w_parametro_relacion
                and    in_ente_i     = @w_en_ente 
                and    in_ente_d     = en_ente
                       
                 select @w_registro_cliente = @w_registro_cliente + '<spouse>' +
                       CASE WHEN co_secuencia is not null
                           THEN '<spouseId>' + convert(varchar, co_secuencia) + '</spouseId>'
                           ELSE ''
                       END
                       +
                       CASE WHEN co_nombre is not null
                           THEN '<firstName>' + co_nombre + '</firstName>'
                           ELSE ''
                       END
                       +
                       CASE WHEN co_p_apellido is not null
                           THEN '<surname>' + co_p_apellido + '</surname>'
                           ELSE ''
                       END
                       +
                       CASE WHEN co_fecha_nacimiento is not null
                           THEN '<birthDate>' + (SELECT format(co_fecha_nacimiento,'yyyy-MM-ddTHH:mm:ss.fffZ')) + '</birthDate>'
                           ELSE ''
                       END
                                             +
                       CASE WHEN co_snombre is not null
                           THEN '<secondName>' + co_snombre + '</secondName>'
                           ELSE ''
                       END
                       +
                       CASE WHEN co_s_apellido is not null
                           THEN '<secondSurname>' + co_s_apellido + '</secondSurname>'
                           ELSE ''
                       END
                       +
                       CASE WHEN co_telefono is not null
                           THEN '<phone>' + co_telefono + '</phone>'
                           ELSE ''
                       END
                       +               
                       '</spouse>'
                from   cobis..cl_conyuge
                where  co_ente   = @w_en_ente                                
                select @w_registro_cliente = @w_registro_cliente + '</spouse>'
                       
                select @w_registro_cliente = @w_registro_cliente + '<spouseAddressData>'
                if @w_direccion_conyugue is not NULL
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + '<addressId>'  + convert(varchar, @w_direccion_conyugue) + '</addressId>'
                   select @w_registro_cliente = @w_registro_cliente + '<address>' +
                          CASE WHEN di_direccion is not null
                              THEN '<addressId>' + convert(varchar, di_direccion) + '</addressId>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_nro_interno is not null
                              THEN '<addressInternalNumber>' + convert(varchar, di_nro_interno) + '</addressInternalNumber>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_nro is not null
                              THEN '<addressNumber>' + convert(varchar, di_nro) + '</addressNumber>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_ciudad is not null
                              THEN '<cityCode>' + convert(varchar, di_ciudad) + '</cityCode>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_pais is not null
                              THEN '<countryCode>' + convert(varchar, di_pais) + '</countryCode>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_parroquia is not null
                              THEN '<neighborhoodCode>' + convert(varchar, di_parroquia) + '</neighborhoodCode>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_tipo_prop is not null
                              THEN '<ownershipType>' + rtrim(di_tipo_prop) + '</ownershipType>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_codpostal is not null
                              THEN '<postalCode>' + convert(varchar, di_codpostal) + '</postalCode>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_provincia is not null
                              THEN '<stateCode>' + convert(varchar, di_provincia) + '</stateCode>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_calle is not null
                              THEN '<street>' + di_calle + '</street>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_tiempo_reside is not null
                              THEN '<yearsAtAddress>' + convert(varchar, di_tiempo_reside) + '</yearsAtAddress>'
                              ELSE ''
                          END
                          +
                          CASE WHEN di_poblacion is not null
                              THEN '<referenceLandmark>' + rtrim(di_poblacion) + '</referenceLandmark>'
                              ELSE ''
                          END
                          +
                          '</address>'
                   from   cobis..cl_instancia, 
                          cobis..cl_direccion
                   where  in_relacion = @w_parametro_relacion
                   and    in_ente_i   = @w_en_ente
                   and    in_ente_d   = di_ente
                   and    di_tipo     IN ('AE')
                END
                   
                if exists (select 1                                            --Validar si existe telefono
                           from   cobis..cl_instancia, cobis..cl_telefono
                           where  in_relacion      = @w_parametro_relacion
                           and    in_ente_i        = @w_en_ente
                           and    te_ente          = in_ente_d
                           and    te_tipo_telefono in ('C','D'))
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + 
                          CASE
                              WHEN te_tipo_telefono = 'D' THEN '<workphone>'
                              WHEN te_tipo_telefono = 'C' THEN '<cellphone>'
                          END
                          +
                          '<phoneId>' + convert(varchar, te_secuencial) + '</phoneId>'
                          --CASE WHEN te_secuencial is not null
                          --    THEN '<phoneId>' + convert(varchar, te_secuencial) + '</phoneId>'
                          --    ELSE ''
                          --END
                          +
                          CASE WHEN te_area is not null
                              THEN '<areaCode>' + convert(varchar, te_area) + '</areaCode>'
                              ELSE '99'  --valor por defecto
                          END
                          +
                          CASE WHEN te_valor is not null
                              THEN '<number>' + convert(varchar, te_valor) + '</number>'   
                              ELSE '9999999999' --valor por defecto
                          END
                          +
                              CASE
                              WHEN te_tipo_telefono = 'D' THEN '</workphone>'
                              WHEN te_tipo_telefono = 'C' THEN '</cellphone>'
                          END
                   from   cobis..cl_instancia, 
                          cobis..cl_telefono
                   where  in_relacion      = @w_parametro_relacion
                   and    in_ente_i        = @w_en_ente
                   and    te_ente          = in_ente_d
                   and    te_tipo_telefono in ('C','D')
                END
                ELSE
                BEGIN
                   select @w_registro_cliente = @w_registro_cliente + 
                          CASE
                             WHEN te_tipo_telefono = 'D' THEN '<workphone>'
                             WHEN te_tipo_telefono = 'C' THEN '<cellphone>'
                          END
                          + ''
                          + ''
                          + ''
                          +
                          CASE
                             WHEN te_tipo_telefono = 'D' THEN '</workphone>'
                             WHEN te_tipo_telefono = 'C' THEN '</cellphone>'
                          END
                   from   cobis..cl_instancia, 
                          cobis..cl_telefono
                   where  in_relacion       = @w_parametro_relacion
                   and    in_ente_i         = @w_en_ente
                   and    te_ente           = in_ente_d
                   and    te_tipo_telefono in ('C','D')
                END
                select @w_registro_cliente = @w_registro_cliente + '</spouseAddressData>'
                  
				select @w_sin_huella_digital = eb_sin_huella_dactilar
				from cobis..cl_ente_bio
				where eb_ente = @w_en_ente
				
                if @w_sin_huella_digital = 'S' begin
                   insert into @w_documentos_digitalizados
				   values ('009')
				end
				
                select @w_registro_cliente = @w_registro_cliente + '<documentList>'
                select @w_registro_cliente = @w_registro_cliente + '<document>' +
                       CASE WHEN dd_tipo_doc is not null
                           THEN '<code>' + rtrim(dd_tipo_doc) + '</code>'
                           ELSE ''
                       END
                       +
                       CASE WHEN dd_extension is not null
                           THEN '<type>' + isnull(rtrim(dd_extension),'null') + '</type>'
                           ELSE ''
                       END
                       +
                       CASE
                           WHEN dd_cargado ='S' THEN '<downloaded>true</downloaded>'   
                           WHEN dd_cargado ='N' THEN '<downloaded>false</downloaded>'   
                           WHEN dd_cargado is null THEN ''
                       END
                       +
                       '</document>'
                from   cob_credito..cr_documento_digitalizado
                where  dd_cliente = @w_en_ente
                and    dd_tipo_doc IN (select codigo from @w_documentos_digitalizados)
                and    dd_inst_proceso = 0                
                select @w_registro_cliente = @w_registro_cliente + '</documentList>'
                   
                select @w_registro_cliente = @w_registro_cliente + '<complementaryRequest>'
                select @w_registro_cliente = @w_registro_cliente +
                       CASE WHEN a.p_pasaporte is not null
                          THEN '<passport>' + a.p_pasaporte +  '</passport>'
                          ELSE ''
                       END
                       +
                       CASE WHEN b.ea_telef_recados is not null
                          THEN '<phoneMessage>' + b.ea_telef_recados + '</phoneMessage>'
                          ELSE ''
                       END
                        +
                       CASE WHEN b.ea_numero_ife is not null
                          THEN '<ifeNumber>' + convert(varchar, b.ea_numero_ife) + '</ifeNumber>'
                          ELSE ''
                       END
                       +
                       CASE WHEN b.ea_num_serie_firma is not null
                          THEN '<serialNumberSignatureElect>' + convert(varchar, b.ea_num_serie_firma) + '</serialNumberSignatureElect>'
                          ELSE ''
                       END
                       +
                       CASE WHEN b.ea_persona_recados is not null
                          THEN '<personMessage>' + b.ea_persona_recados + '</personMessage>'
                          ELSE ''
                       END
                       +
                       CASE
                          WHEN b.ea_antecedente_buro ='S' THEN '<buroAntecedent>true</buroAntecedent>'
                          WHEN b.ea_antecedente_buro ='N' THEN '<buroAntecedent>false</buroAntecedent>'
                          WHEN b.ea_antecedente_buro is null THEN ''
                       END
                       + 
                       CASE WHEN @w_landline_one is not null
                          THEN '<landlineOne>' + @w_landline_one + '</landlineOne>'
                          ELSE ''
                       END
					   +
					   CASE WHEN ea_act_profesional is not null
					   	   THEN '<professionalActivity>' + ea_act_profesional + '</professionalActivity>'
					   	   ELSE ''
					   END
					   +
					   CASE WHEN ea_usa_crypto is not null
					   	   THEN '<isCryptoUsed>' + ea_usa_crypto + '</isCryptoUsed>'
					   	   ELSE ''
					   END
					   
                from  cobis..cl_ente a, 
                      cobis..cl_ente_aux b
                where en_ente = @w_en_ente
                and   en_ente = ea_ente
                select @w_registro_cliente = @w_registro_cliente + '</complementaryRequest>'
                select @w_registro_cliente = @w_registro_cliente + '</customerSynchronizedData>'
                   
                insert into @w_sincroniza_det
				(sid_id_entidad, sid_id_1, sid_id_2, sid_xml, sid_accion, sid_observacion, sid_descargado)
		        values 
				(@w_en_ente, 0, 0, @w_registro_cliente, 'ACTUALIZAR', 'Actualizar la entidad ' + convert(varchar, @w_en_ente),0)
		                   
				select @w_nro_registros = @w_nro_registros + 1
            --END --end while            
            SIGUIENTE_CL:
            fetch next from Cursor_Clientes into @w_en_ente                                
         END --end while     
         close Cursor_Clientes
         deallocate Cursor_Clientes
		 
         if @w_nro_registros > 0 begin	
            
            exec 
            @w_num_error     = cobis..sp_cseqnos
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_tabla         = 'si_sincroniza',
            @o_siguiente     = @w_codigo out
                       
            if @w_num_error <> 0 begin
               goto errores
            end
			
			if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
			
               insert into cob_sincroniza..si_sincroniza
               (si_secuencial,   si_cod_entidad,  si_des_entidad,        
			   si_usuario,       si_estado,       si_fecha_ing, 
			   si_fecha_sin,     si_num_reg)
               values
		       (@w_codigo,                1,       'CLIENTE',         
			   @w_sid_usuario,           'P',       GETDATE(),         
			   null, @w_nro_registros)
			   
			   insert into cob_sincroniza..si_sincroniza_det
			   (sid_secuencial, sid_id_entidad, sid_id_1, sid_id_2, sid_xml, sid_accion, sid_observacion, sid_descargado)
			   select 
			   @w_codigo, sid_id_entidad, sid_id_1, sid_id_2, sid_xml, sid_accion, sid_observacion, sid_descargado
			   from @w_sincroniza_det
			   
			end else begin
			   select @w_num_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
               print @w_msg
               goto errores			
			end
			
         end
         fetch next from Cursor_Oficiales into @w_sid_usuario 
         
      END --END while
           
      close Cursor_Oficiales
      deallocate Cursor_Oficiales
   END  --END @i_sub_tipo

return 0
end --@i_operacion = 'Q'

--Control errores
errores:
-------------------------
   -- Utilizando transaccion
   if @i_transaccion = 'S'
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   end
   return @w_num_error;
go
