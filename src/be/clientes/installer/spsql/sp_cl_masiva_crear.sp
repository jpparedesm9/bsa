
USE cobis
GO
/* ********************************************************************* */
/*      Archivo:                sp_cl_masiva_crear.sp                    */
/*      Stored procedure:       sp_cl_masiva_crear                       */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           Luis Guachamin                           */
/*      Fecha de escritura:     12-Sep-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*   Creacion masivas de Clientes/Direcciones/negocio/referencias        */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Sep/2017     LGU                  Version Inicial             */
/*                                                                       */
/* ********************************************************************* */

if exists (select 1 from sysobjects where name = 'sp_cl_masiva_crear')
   drop proc sp_cl_masiva_crear
go


create proc sp_cl_masiva_crear
    @i_param1       varchar(255) = NULL, -- fecha proceso
    @s_user         login        = 'admuser',
    @s_term         varchar(32)  = 'consola',
    @s_srv          varchar(30)  = 'SRV',
    @s_lsrv         varchar(30)  = 'LSRV'


as
DECLARE
 @w_ente_std        VARCHAR(20)
,@w_estado_cli      VARCHAR(10)
,@w_estado_dir      VARCHAR(10)
,@w_estado_telf     VARCHAR(10)
,@w_estado_neg      VARCHAR(10)
,@w_estado_ref      VARCHAR(10)
,@w_nombre_aux      VARCHAR(200)
,@w_error_ref       INT
,@w_error_tot       INT
,@s_date         	DATETIME
,@w_entidad         VARCHAR(62)
,@w_msg             VARCHAR(255)
,@w_error           INT
,@w_num_ref         SMALLINT
,@w_total 			int
,@w_total_err 		int
,@w_total_ok        int


DECLARE
@w_file_rpt     varchar(40),
@w_file_rpt_1   varchar(140),
@w_file_rpt_1_out varchar(140),
@w_bcp          varchar(2000),
@w_path_destino varchar(200),
@w_origen       VARCHAR(32),
@w_s_app        varchar(40),
@w_fecha_r      varchar(10),
@w_mes          varchar(2),
@w_dia          varchar(2),
@w_anio         varchar(4),

@w_ssn              INT,
@w_sesn  		    INT,
@w_login            VARCHAR(20),
@w_rol              SMALLINT,
@w_sec_direccion    INT,
@w_return           INT,
@w_dire	            INT ,
@w_dir_virtual      VARCHAR(64),
--///////////////////////////////////////////////////////////////////////////////////////////////
@w_ente_cobis_c     int           ,-- Codigo del ente
@w_ente_cobis       int           ,-- Codigo del ente
@w_filial           tinyint       ,-- Codigo de la filial
@w_oficina          smallint      ,-- Codigo de la oficina
@w_oficial          smallint      ,-- Codigo del oficial del ente
@w_fecha_expira     datetime      ,-- Fecha de expiracion del pasaporte del ente
@w_c_apellido       varchar(30)   ,-- Apellido casada del ente
--////////////////  --//////////////
@w_nombre           varchar(64)   ,-- Primer nombre del ente
@w_segnombre        varchar(50)   ,-- Segundo nombre del ente
@w_papellido        varchar(64)   ,-- Primer apellido del ente
@w_sapellido        varchar(64)   ,-- Segundo apellido del ente
@w_tipo_ced         char(4)       ,-- Tipo de identificacion del ente
@w_curp             VARCHAR(30)   ,-- Numero de identificacion del ente
@w_rfc              varchar(30)   ,-- NIT del ente
@w_sexo             varchar(10)   ,-- Codigo del sexo del ente
@w_fecha_nac        datetime      ,-- Fecha de nacimiento del ente
@w_nac_aux          SMALLINT      ,-- 1 si es mexicano, 2 en caso contrario
@w_nacionalidad     int           ,-- Codigo del pais de la nacionalidad del cliente
@w_cod_pais         smallint      ,-- Pais de nacimiento
@w_ciudad_nac       SMALLINT      ,-- Provincia de nacimiento
@w_est_civil        varchar(10)   ,-- Codigo  del estado civil de la persona
@w_pep              char(1)       ,
@w_carg_pub         varchar(10)   ,
@w_persona_pub      varchar(1)    ,--Función que desempeña o ha desempeñado
@w_rel_carg_pub     varchar(10)   ,
@w_partner          char(1)       ,
@w_nro_ciclo_oi     INT           ,

@w_curp_c             VARCHAR(30)   ,-- Numero de identificacion del ente
@w_rfc_c              varchar(30)   ,-- NIT del ente

--////////////////  --//////////////
@w_nivel_estudio    varchar(10)   ,-- Nivel de estudio de la persona
@w_profesion        varchar(10)   ,-- Codigo de la profesion de la persona
@w_num_cargas       tinyint       ,-- Numero de hijos
--////////////////  --//////////////
@w_vinculacion      char(1)       ,
@w_tipo_vinculacion varchar(10)   ,-- Codigo del tipo de vinculacion de quien presento al cliente
@w_ant_nego         int           ,
@w_total_activos    money         ,-- Total de activos
@w_mnt_pasivo       money         ,
@w_ing_SN           char(1)       ,--Tiene otros Ingresos?
@w_otringr          VARCHAR(10)   , --Otras fuentes de Ingresos
@w_ventas           money         ,
@w_ct_ventas        money         ,
@w_ct_operativos    money         ,
@w_otros_ingresos   money         ,
--////////////////  --//////////////
@w_lista_negra      char(1)       ,
@w_ea_cta_banco  varchar(45)   ,
@w_ea_estado        VARCHAR(10)   ,
@w_ea_cod_risk      varchar(20)   ,
@w_ea_estado2       varchar(10)


-- datos de direccion
declare
 @w_d_descripcion     VARCHAR(254)
,@w_d_tipo            VARCHAR(10)
,@w_d_parroquia       smallint
,@w_d_ciudad          smallint
,@w_d_principal       CHAR(1)
,@w_d_provincia       smallint
,@w_d_codpostal       VARCHAR(10)
,@w_d_calle 	      varchar(70)
,@w_d_tiempo_reside   SMALLINT
,@w_d_pais 			  smallint
,@w_d_correspondencia CHAR(1)
,@w_d_tipo_prop 	  varchar(10)
,@w_d_nro 			  int
,@w_d_nro_residentes  int
,@w_d_nro_interno     int
,@w_d_ci_poblacion    varchar(30)


-- datos de GEOLOCALIZACION
declare
 @w_g_lat_segundos float
,@w_g_lon_segundos float


-- datos del telefono
declare
 @w_t_valor         varchar(16)
,@w_t_tipo_telefono char(2)
,@w_t_cod_area      varchar(10)

-- negocio del cliente
declare
 @w_n_nombre          varchar(60)
,@w_n_fecha_apertura  datetime
,@w_n_actividad_ec    varchar(10)
,@w_n_tiempo_activida int
,@w_n_tiempo_dom_neg  int
,@w_n_emprendedor     CHAR(1)
,@w_n_recurso         VARCHAR(10)
,@w_n_ingreso_mensual money
,@w_n_tipo_local      VARCHAR(10)
,@w_n_destino_credito VARCHAR(10)

-- DATOS DE REFRENCIAS, MIN 2
declare
 @w_r_nombre          varchar(20)
,@w_r_p_apellido      varchar(20)
,@w_r_direccion       direccion
,@w_r_telefono_d      char(12)
,@w_r_telefono_e      char(12)
,@w_r_telefono_o      char(12)
,@w_r_parentesco      varchar(10)
,@w_r_descripcion     varchar(64)
,@w_r_tiempo_conocido int
,@w_r_direccion_e     varchar(30)

-- DATOS DEL CONYUGE
DECLARE
 @w_p_calif_cliente    varchar(10)
,@w_calificacion       varchar(10)
,@w_nombre_c           varchar(64)
,@w_papellido_c        varchar(64)
,@w_sapellido_c        varchar(64)
,@w_tipo_ced_c         varchar( 4)
,@w_segnombre_c        varchar(50)
,@w_sexo_c             varchar(10)
,@w_est_civil_c        varchar(10)
,@w_c_apellido_c       varchar(30)
,@w_fecha_expira_c     DATETIME
,@w_fecha_nac_c        DATETIME
,@w_ciudad_nac_c       SMALLINT
,@w_estado_cre_c       varchar(10) -- estado para la creacion

select @s_date = convert(datetime, isnull(@i_param1, getdate()),101)

	select @w_s_app = pa_char
	from   cobis..cl_parametro
	where  pa_producto = 'ADM'
	and    pa_nemonico = 'S_APP'

	select
	   @w_path_destino = pp_path_destino
	from cobis..ba_path_pro
	where pp_producto = 2

	select @w_mes         = substring(convert(varchar,@s_date, 101),1,2)
	select @w_dia         = substring(convert(varchar,@s_date, 101),4,2)
	select @w_anio        = substring(convert(varchar,@s_date, 101),7,4)

	select @w_fecha_r = @w_mes + @w_dia + @w_anio

	select @w_file_rpt = 'rpt_creacion'
	select @w_file_rpt_1     = @w_path_destino + 'in\' + @w_file_rpt + @w_fecha_r + '.txt'
	select @w_file_rpt_1_out = @w_path_destino + 'in\' + @w_file_rpt + '_1.log'


-- datos default para crear el cliente
SELECT
@w_rol     = 3,
@w_filial  = 1

TRUNCATE TABLE cl_reporte_tmp

INSERT INTO cl_reporte_tmp	select 'CREACION MASIVA DE CLIENTES'
INSERT INTO cl_reporte_tmp	select 'FECHA : ' + CONVERT(VARCHAR,@s_date, 101) + ' (MM/DD/YYYY)'
INSERT INTO cl_reporte_tmp	select ''
INSERT INTO cl_reporte_tmp	select 'LISTADO DE ERRORES:'
INSERT INTO cl_reporte_tmp	select 'CODIGO ERROR|DESCRIPCION:'


select @w_ente_std = ''
WHILE 1= 1 -- lazo de CLIENTES
BEGIN
	SELECT @w_error_tot = 0 --- FLAG DE ERRORES DEL CLIENTE

	select top 1
		 @w_entidad           = ens_entidad
	    ,@w_ente_std          = ens_ente_std
	    ,@w_estado_cli        = ens_estado_cre
	    ,@w_ente_cobis        = ens_ente_cobis
	    ,@w_oficina           = ens_oficina
	    ,@w_login             = lower(ens_login)
	    ,@w_fecha_expira      = ens_fecha_expira
	    ,@w_c_apellido        = substring(ens_c_apellido ,1,20)
	    ,@w_nombre            = ens_nombre
	    ,@w_segnombre         = substring(ens_segnombre ,1,20 )
	    ,@w_papellido         = substring(ens_papellido ,1,16 )
	    ,@w_sapellido         = substring(ens_sapellido ,1,16 )
	    ,@w_tipo_ced          = ens_tipo_ced
	    ,@w_sexo              = ens_sexo
	    ,@w_fecha_nac         = ens_fecha_nac
	    ,@w_nacionalidad      = ens_nacionalidad
	    ,@w_cod_pais          = ens_cod_pais
	    ,@w_ciudad_nac        = ens_ciudad_nac
	    ,@w_est_civil         = ens_est_civil
	    ,@w_dir_virtual       = lower(ens_dir_virtual)
	    ,@w_pep               = ens_pep
	    ,@w_carg_pub          = ens_carg_pub
	    ,@w_persona_pub       = ens_persona_pub
	    ,@w_rel_carg_pub      = ens_rel_carg_pub
	    ,@w_partner           = ens_partner
	    ,@w_nro_ciclo_oi      = ens_nro_ciclo_oi
	    ,@w_nivel_estudio     = ens_nivel_estudio
	    ,@w_profesion         = ens_profesion
	    ,@w_num_cargas        = ens_num_cargas
	    ,@w_vinculacion       = ens_vinculacion
	    ,@w_tipo_vinculacion  = ens_tipo_vinculacion
	    ,@w_ant_nego          = ens_ant_nego
	    ,@w_total_activos     = ens_total_activos
	    ,@w_mnt_pasivo        = ens_mnt_pasivo
	    ,@w_ing_SN            = ens_ing_SN
	    ,@w_otringr           = ens_otringr
	    ,@w_ventas            = ens_ventas
	    ,@w_ct_ventas         = ens_ct_ventas
	    ,@w_ct_operativos     = ens_ct_operativos
	    ,@w_otros_ingresos    = ens_otros_ingresos
	    ,@w_lista_negra       = ens_lista_negra
	    ,@w_ea_cta_banco      = ens_ea_cta_banco
	    ,@w_ea_cod_risk       = ens_ea_cod_risk

        ,@w_p_calif_cliente   = ens_p_calif_cliente
        ,@w_calificacion      = ens_calificacion
	from cobis..cl_ente_std
	where ens_estado_cre  NOT IN ('E', 'F')  -- no este creado ni actualizado
	AND ens_fecha    = @s_date
	and ens_ente_std > @w_ente_std
	order by ens_ente_std


	IF @@ROWCOUNT = 0 BREAK

	--SACAR SECUENCIALES SESIONES
	exec @w_ssn = cob_cartera..sp_gen_sec
	@i_operacion  = -1

	exec @w_sesn = cob_cartera..sp_gen_sec
	@i_operacion  = -1

	-- datos para crear el cliente
	select
	@w_ea_estado    = 'P'   -- ESTADO DEL CLIENTE P = PROSPECTO

	IF @w_nacionalidad = '484' -- MEXICANA
		SELECT @w_nac_aux      = 1  ------- 1 si es mexico, 2 caso contrario
	ELSE
		SELECT @w_nac_aux      = 2  ------- 1 si es mexico, 2 caso contrario

	SELECT
	    @w_oficial = fu_funcionario
	FROM cobis..cl_funcionario
	WHERE fu_login = @w_login
	IF @@ROWCOUNT = 0
	BEGIN
		SELECT @w_error = 1
		SELECT @w_msg = 'NO existe funcionario: ' + @w_login
		GOTO SIGUIENTE
	END

	select @s_user = @w_login
	--///////////////////////////////////////
	-- datos para completar la info del cliente
	--///////////////////////////////////////
	IF @w_estado_cli = 'I'
	begin
		BEGIN TRY

			EXEC @w_return = cob_pac..sp_crear_persona_no_ruc
			    @i_batch           = 'S',
			    @s_ssn             = @w_ssn,
			    @s_sesn            = @w_sesn,
			    @s_user            = @s_user,
			    @s_term            = @s_term,
			    @s_date            = @s_date,
			    @s_srv             = @s_srv,
			    @s_lsrv            = @s_lsrv,
			    @s_ofi             = @w_oficina,
			    @s_rol             = @w_rol,
				@i_nombre          = @w_nombre,
				@i_papellido       = @w_papellido,
				@i_sapellido       = @w_sapellido,
				@i_filial          = @w_filial,
				@i_oficina         = @w_oficina,
				@i_tipo_ced        = @w_tipo_ced,
				@i_login_oficial   = @w_login,
				@i_c_apellido      = @w_c_apellido,
				@i_segnombre       = @w_segnombre,
				@i_sexo            = @w_sexo,
				@i_est_civil       = @w_est_civil,
				@i_ea_estado       = 'P', -- prospecto
				@i_dir_virtual	   = @w_dir_virtual,
				@i_fecha_nac	   = @w_fecha_nac,
			    @i_ciudad_nac      = @w_ciudad_nac,
			    @i_operacion	   = 'I',
			    @i_ea_nro_ciclo_oi = @w_nro_ciclo_oi,
			    @i_banco           = @w_ente_std,
			    @o_ente			   = @w_ente_cobis out,
			    @o_dire			   = @w_dire out,
			    @o_curp            = @w_curp out, -- LGU: calculo de rfc y curp
			    @o_rfc             = @w_rfc  OUT  -- LGU: calculo de rfc y curp

			IF @w_return <> 0
			BEGIN
				SELECT @w_error_tot = @w_error_tot + 1
				 update cobis..cl_ente_std set
					ens_estado_cre = 'E' -- ERROR al crear
				 where ens_ente_std = @w_ente_std
			 	 AND ens_fecha      = @s_date
			 	 AND ens_entidad    = @w_entidad

		        select @w_error = isnull(@w_return ,2)
		        select @w_msg = 'Error al crear Prospecto CL : ' + @w_ente_std

				GOTO SIGUIENTE
			end
		END TRY
		BEGIN CATCH
			BEGIN
				SELECT @w_error_tot = @w_error_tot + 1
				 update cobis..cl_ente_std set
					ens_estado_cre = 'E' -- ERROR al crear
				 where ens_ente_std = @w_ente_std
			 	 AND ens_fecha      = @s_date
			 	 AND ens_entidad    = @w_entidad

		        select @w_error = isnull(@w_return ,2)
		        select @w_msg = 'Error 2 al crear Prospecto CL ' + @w_ente_std

				GOTO SIGUIENTE
			END
	    END CATCH

		 update cobis..cl_ente_std set
			ens_ente_cobis = @w_ente_cobis,
			ens_estado_cre = 'C'
		 where ens_ente_std = @w_ente_std
		 AND ens_fecha      = @s_date
		 AND ens_entidad    = @w_entidad

		 SELECT @w_estado_cli = 'C'
	END
	ELSE
	BEGIN
		SELECT
		    @w_dire = 1,
		    @w_curp = en_ced_ruc,
		    @w_rfc  = en_rfc
		FROM cobis..cl_ente
		WHERE en_ente = @w_ente_cobis


	END -- creacion del cliente

	SELECT
	    '@o_ente'  = @w_ente_cobis ,
	    '@o_dire'  = @w_dire ,
	    '@o_curp'  = @w_curp , -- LGU: calculo de rfc y curp
	    '@o_rfc '  = @w_rfc  -- LGU: calculo de rfc y curp

	--///////////////////////////////////////
	--ACTUALIZACION DE LOS DEMAS DATOS DEL CLIENTE
	--///////////////////////////////////////
	IF @w_estado_cli = 'C'
	BEGIN
		UPDATE cobis..cl_ente SET
			p_calif_cliente = isnull(@w_p_calif_cliente, p_calif_cliente),  -- riesgo individual
			en_calificacion = isnull(@w_calificacion, en_calificacion)      -- riesgo grupal
		WHERE en_ente = @w_ente_cobis

		BEGIN TRY
			EXEC @w_return = cobis..sp_persona_upd
			      @s_ssn                     = @w_ssn,
			      @s_user                    = @s_user,
			      @s_term                    = @s_term,
			      @s_date                    = @s_date,
			      @s_srv                     = @s_srv,
			      @s_lsrv                    = @s_lsrv,
			      @s_ofi                     = @w_oficina,
			      @s_rol                     = @w_rol,
			      @t_trn                     = 104,
			      @i_operacion               = 'U',
			      @i_persona                 = @w_ente_cobis, -- Codigo del ente
			      @i_filial                  = @w_filial, -- Codigo de la filial
			      @i_oficina                 = @w_oficina, -- Codigo de la oficina
			      @i_oficial                 = @w_oficial, -- Codigo del oficial del ente
			      @i_fecha_expira            = @w_fecha_expira, -- Fecha de expiracion del pasaporte del ente
			      @i_c_apellido              = @w_c_apellido,  -- Apellido casada del ente
			    --//////////////////////////////
			      @i_nombre                  = @w_nombre, -- Primer nombre del ente
			      @i_segnombre               = @w_segnombre,  -- Segundo nombre del ente
			      @i_p_apellido              = @w_papellido, -- Primer apellido del ente
			      @i_s_apellido              = @w_sapellido, -- Segundo apellido del ente
			      @i_tipo_ced                = @w_tipo_ced, -- Tipo de identificacion del ente
			      @i_cedula                  = @w_curp, -- Numero de identificacion del ente
			      @i_nit                     = @w_rfc,  -- NIT del ente
			      @i_nit_id                  = @w_rfc,
			      @i_ea_indefinido           = 'S',  --MTA nuevo campo no mapeado
			      @i_sexo                    = @w_sexo, -- Codigo del sexo del ente
			      @i_fecha_nac               = @w_fecha_nac, -- Fecha de nacimiento del ente
			      @i_nac_aux                 = @w_nac_aux, --- trabaja con la nacionalidad
			      @i_nacionalidad            = @w_nacionalidad,  -- Codigo del pais de la nacionalidad del cliente
			      @i_pais_emi                = @w_cod_pais ,    --Pais de nacimiento
			      @i_depa_nac                = @w_ciudad_nac,    --Provincia de nacimiento
			      @i_estado_civil            = @w_est_civil, -- Codigo  del estado civil de la persona
			      @i_pep                     = @w_pep,
			      @i_carg_pub                = @w_carg_pub,
			      @i_persona_pub             = @w_persona_pub,  --Función que desempeña o ha desempeñado
			      @i_rel_carg_pub            = @w_rel_carg_pub,
			      @i_partner                 = @w_partner,
			      @i_ea_nro_ciclo_oi         = @w_nro_ciclo_oi,
			      @i_pais                    = @w_cod_pais, -- Codigo del pais
			    --//////////////////////////////
			      @i_ciudad_nac              = @w_cod_pais, -- Codigo del municipio o pais de nacimiento
			      @i_nivel_estudio           = @w_nivel_estudio, -- Nivel de estudio de la persona
			      @i_profesion               = @w_profesion, -- Codigo de la profesion de la persona
			      @i_num_cargas              = @w_num_cargas, -- Numero de hijos
			    --//////////////////////////////
			      @i_vinculacion             = @w_vinculacion,
			      @i_tipo_vinculacion        = @w_tipo_vinculacion, -- Codigo del tipo de vinculacion de quien presento al cliente
			      @i_ant_nego                = @w_ant_nego,
			      @i_total_activos           = @w_total_activos, -- Total de activos
			      @i_mnt_pasivo              = @w_mnt_pasivo,
			      @i_ing_SN                  = @w_ing_SN,  --Tiene otros Ingresos?
			      @i_otringr                 = @w_otringr,   --Otras fuentes de Ingresos
			      @i_ventas                  = @w_ventas,
			      @i_ct_ventas               = @w_ct_ventas,
			      @i_ct_operativos           = @w_ct_operativos,
			      @i_otros_ingresos          = @w_otros_ingresos,
			    --//////////////////////////////
			      @i_lista_negra             = @w_lista_negra,
			      @i_ea_cta_banco            = @w_ea_cta_banco,
			      @i_ea_estado               = @w_ea_estado,
			      @i_estado_std              = @w_ea_estado,
			      @i_ea_cod_risk             = @w_ea_cod_risk,
			      @o_estado                  = @w_ea_estado2  output
			IF @w_return = 0
			BEGIN
			PRINT ' luego de actualizar PERSONA ok'
				 update cobis..cl_ente_std set
					ens_estado_cre = 'U'
				 where ens_ente_std = @w_ente_std
				 AND ens_fecha      = @s_date
				 AND ens_entidad    = @w_entidad
			END
			ELSE
			BEGIN
				PRINT ' luego de actualizar PERSONA  ERROR'
				SELECT @w_error_tot = @w_error_tot + 1
		        select @w_error = isnull(@w_return ,3)
		        select @w_msg = 'Error al actualizar PERSONA: sp_persona_upd CL: ' + @w_ente_std
		        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
				SELECT @w_error = 0
			END
		END TRY
		BEGIN CATCH
			SELECT @w_error = 4
			SELECT @w_msg   =  'Error al actualizar PERSONA: sp_persona_upd CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
	        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END CATCH


	END -- estado = C


	--///////////////////////////////////////
	-- CREAR CONYUGE DEL PROSPECTO
	--///////////////////////////////////////
	SELECT
         @w_nombre_c          = cos_nombre_c
        ,@w_papellido_c       = substring(cos_papellido_c    ,1,16)
        ,@w_sapellido_c       = substring(cos_sapellido_c    ,1,16)
        ,@w_segnombre_c       = substring(cos_segnombre_c    ,1,20)
        ,@w_sexo_c            = cos_sexo_c
        ,@w_est_civil_c       = cos_est_civil_c
        ,@w_c_apellido_c      = substring(cos_c_apellido_c   ,1,20)
        ,@w_fecha_expira_c    = cos_fecha_expira_c
        ,@w_fecha_nac_c       = cos_fecha_nac_c
        ,@w_ciudad_nac_c      = cos_ciudad_nac_c
        ,@w_estado_cre_c      = cos_estado_cre_c
	from cobis..cl_conyuge_std
	where  cos_ente_std_c = @w_ente_std
	and  cos_estado_cre_c <> 'F'
    AND  cos_fecha_c      = @s_date
    AND  cos_entidad_c    = @w_entidad

	IF @@ROWCOUNT > 0
	BEGIN
	    if @w_est_civil in ( 'CA', 'UN')
		begin
			PRINT 'ENTRA a  CONYUGE -------------'
			BEGIN TRY
				EXEC @w_return = cob_pac..sp_crear_persona_no_ruc
					@i_batch           = 'S',
					@s_ssn             = @w_ssn,
					@s_sesn            = @w_sesn,
					@s_user            = @s_user,
					@s_term            = @s_term,
					@s_date            = @s_date,
					@s_srv             = @s_srv,
					@s_lsrv            = @s_lsrv,
					@s_ofi             = @w_oficina,
					@s_rol             = @w_rol,
					@t_trn             = 73935,
					@i_filial          = @w_filial,
					@i_oficina         = @w_oficina,
					@i_login_oficial   = @w_login,
					@i_ea_estado       = 'P', -- prospecto
					@i_operacion	   = 'C',
					@i_nombre_c        = @w_nombre_c,
					@i_papellido_c     = @w_papellido_c,
					@i_sapellido_c     = @w_sapellido_c,
					@i_tipo_ced_c      = 'CURP',
					@i_segnombre_c     = @w_segnombre_c,
					@i_sexo_c          = @w_sexo_c,
					@i_est_civil_c     = @w_est_civil_c,
					@i_c_apellido_c    = @w_c_apellido_c,
					@i_fecha_expira_c  = @w_fecha_expira_c,
					@i_fecha_nac_c     = @w_fecha_nac_c,
					@i_ciudad_nac_c    = @w_ciudad_nac_c,
					@o_ente			   = @w_ente_cobis ,
					@o_ente_c		   = @w_ente_cobis_c out,
					@o_curp_c          = @w_curp_c out, -- LGU: calculo de rfc y curp
					@o_rfc_c           = @w_rfc_c  OUT  -- LGU: calculo de rfc y curp

				PRINT ' termina CONYUGE  return '+ CONVERT(VARCHAR, @w_return)
				IF @w_return = 0
				BEGIN
				PRINT ' CREO CONYUGE  ok'
					UPDATE cobis..cl_conyuge_std    set
						cos_estado_cre_c = 'F',
						cos_ente_cobis  = @w_ente_cobis_c
					where  cos_ente_std_c = @w_ente_std
					AND  cos_fecha_c      = @s_date
					AND  cos_entidad_c    = @w_entidad
				END
				ELSE
				BEGIN
					PRINT ' CREO CONYUGE  ERRORR  ' + convert(varchar, @@error) + '-'
					SELECT @w_error_tot = @w_error_tot + 1
				END
		   	END TRY

			BEGIN CATCH
				PRINT ' CREO CONYUGE  ERRORR  ' + convert(varchar, @@error) + '-'

				SELECT @w_error = 5
				SELECT @w_msg   =  'Error al crear conyuge CL: ' + @w_ente_std
				SELECT @w_error_tot = @w_error_tot + 1
				INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
				SELECT @w_error = 0
			END CATCH
		end -- si es casado o union libre
		else -- si no es casado ni union libre
		begin
			PRINT ' NO CREA CONYUGE  ERRORR'
			SELECT @w_error = 5
			SELECT @w_msg   =  'No crea conyuge porque no es CA ni UN. CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
			INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END
	END
	ELSE -- no viene conyuge, pero si es casado
	BEGIN
	    if @w_est_civil in ( 'CA', 'UN')
		BEGIN

			IF NOT EXISTS(SELECT 1 from cobis..cl_conyuge_std
			where  cos_ente_std_c = @w_ente_std
			and  cos_estado_cre_c = 'F'
			AND  cos_fecha_c      = @s_date
			AND  cos_entidad_c    = @w_entidad		)
			BEGIN
				PRINT ' NO EXISTE CONYUGE PARA CLIENTE CASADO'
				SELECT @w_error = 51
				SELECT @w_msg   =  'No existe conyuge para cliente CA o UN. CL: ' + @w_ente_std
				SELECT @w_error_tot = @w_error_tot + 1
				INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
				SELECT @w_error = 0
			END
		END
	END


	--/////////////////////////////////////////
	-- DATOS DE LA DIRECCION
	--/////////////////////////////////////////
	select
	 @w_d_descripcion     = dis_d_descripcion
	,@w_estado_dir        = dis_estado_cre
	,@w_d_tipo            = dis_d_tipo
	,@w_d_parroquia       = dis_d_parroquia
	,@w_d_ciudad          = dis_d_ciudad
	,@w_d_principal       = dis_d_principal
	,@w_d_provincia       = dis_d_provincia
	,@w_d_codpostal       = dis_d_codpostal
	,@w_d_calle           = dis_d_calle
	,@w_d_tiempo_reside   = dis_d_tiempo_reside
	,@w_d_pais            = dis_d_pais
	,@w_d_correspondencia = dis_d_correspondencia
	,@w_d_tipo_prop       = dis_d_tipo_prop
	,@w_d_nro             = dis_d_nro
	,@w_d_nro_residentes  = dis_d_nro_residentes
	,@w_d_nro_interno     = dis_d_nro_interno
	,@w_d_ci_poblacion    = dis_d_ci_poblacion
	,@w_g_lat_segundos    = dis_g_lat_segundos
	,@w_g_lon_segundos    = dis_g_lon_segundos
	from cobis..cl_direccion_std
	where  dis_ente_std = @w_ente_std
	and  dis_estado_cre <> 'F'
    AND  dis_fecha      = @s_date
    AND  dis_entidad    = @w_entidad

	IF @@ROWCOUNT > 0
	BEGIN
  		BEGIN TRY
  			exec @w_return = cob_pac..sp_direccion_dml_busin
			 @i_ente            = @w_ente_cobis
			,@i_barrio          = null
			,@i_negocio         = 0
			,@t_trn             = 109
			,@i_operacion       = 'I'
			,@i_rural_urbano    = 'N'
			--///////////////////////////////////////////
			,@i_descripcion     = @w_d_descripcion
			,@i_tipo            = @w_d_tipo
			,@i_parroquia       = @w_d_parroquia
			,@i_ciudad          = @w_d_ciudad
			,@i_principal       = @w_d_principal
			,@i_provincia       = @w_d_provincia
			,@i_codpostal       = @w_d_codpostal
			,@i_calle           = @w_d_calle
			,@i_tiempo_reside   = @w_d_tiempo_reside
			,@i_pais            = @w_d_pais
			,@i_correspondencia = @w_d_correspondencia
			,@i_tipo_prop       = @w_d_tipo_prop
			,@i_nro             = @w_d_nro
			,@i_nro_residentes  = @w_d_nro_residentes
			,@i_nro_interno     = @w_d_nro_interno
			,@i_ci_poblacion    = @w_d_ci_poblacion
			--/////////////////////////////////////////
			,@s_srv             = @s_srv
			,@s_user            = @s_user
			,@s_term            = @s_term
			,@s_ofi             = @w_oficina
			,@s_rol             = @w_rol
			,@s_ssn             = @w_ssn
			,@s_lsrv            = @s_lsrv
			,@s_date            = @s_date
			,@s_sesn            = @w_sesn
			,@s_org             = 'U'
			,@s_culture         = 'es_EC'

			IF @w_return = 0
			BEGIN
				update cobis..cl_direccion_std set
					dis_estado_cre = 'F'
				where dis_ente_std = @w_ente_std
				 AND dis_fecha      = @s_date
				 AND dis_entidad    = @w_entidad

				-- datos de GEOLOCALIZACION
				select @w_sec_direccion = max(di_direccion)
				from cobis..cl_direccion
				where di_ente = @w_ente_cobis
				and di_tipo <> 'CE'

				EXEC @w_return = cobis..sp_direccion_geo
				 @i_ente         = @w_ente_cobis
				,@i_direccion    = @w_sec_direccion
				,@t_trn          = 1608
				,@i_operacion    = 'I'
				--/////////////////////////////////////////
				,@i_lat_segundos = @w_g_lat_segundos
				,@i_lon_segundos = @w_g_lon_segundos
				--/////////////////////////////////////////
				,@s_srv          = @s_srv
				,@s_user         = @s_user
				,@s_term         = @s_term
				,@s_ofi          = @w_oficina
				,@s_rol          = @w_rol
				,@s_ssn          = @w_ssn
				,@s_lsrv         = @s_lsrv
				,@s_date         = @s_date
				,@s_sesn         = @w_sesn
				,@s_org          = 'U'
				,@s_culture      = 'es_EC'
			END
			ELSE
				SELECT @w_error_tot = @w_error_tot + 1
		END TRY
	    BEGIN CATCH
			PRINT ' CREAR DIRECCION ' + convert(VARCHAR,@w_return)
			SELECT @w_error = 6
			SELECT @w_msg   =  'Error al crear direccion CL: ' + @w_ente_std
	        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END CATCH

	END -- existen direcciones aprocesar
	ELSE -- no hay direccion
	BEGIN
		IF NOT EXISTS (SELECT 1
			from cobis..cl_direccion_std
			where  dis_ente_std = @w_ente_std
			and  dis_estado_cre = 'F'
		    AND  dis_fecha      = @s_date
		    AND  dis_entidad    = @w_entidad)
    	BEGIN
			SELECT @w_error = 61
			SELECT @w_msg   =  'Cliente sin direccion. CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
			INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END

	END

	--/////////////////////////////////////
	-- datos del telefono
	--/////////////////////////////////////
	select
	 @w_estado_telf     = tes_estado_cre
	,@w_t_valor         = tes_t_valor
	,@w_t_tipo_telefono = tes_t_tipo_telefono
	,@w_t_cod_area      = tes_t_cod_area
	from cobis..cl_telefono_std
	where tes_ente_std = @w_ente_std
	and tes_estado_cre <> 'F'
 	AND tes_fecha      = @s_date
 	AND tes_entidad    = @w_entidad

	IF @@ROWCOUNT > 0
	BEGIN
			select @w_sec_direccion = max(di_direccion)
			from cobis..cl_direccion
			where di_ente = @w_ente_cobis
			and di_tipo <> 'CE'
					BEGIN TRY
			EXEC @w_return = cobis..sp_telefono
			 @i_ente          = @w_ente_cobis
			,@i_direccion     = @w_sec_direccion
			,@t_trn           = 111
			,@i_operacion     = 'I'
			--/////////////////////////////////////////
			,@i_valor         = @w_t_valor
			,@i_tipo_telefono = @w_t_tipo_telefono
			,@i_cod_area      = @w_t_cod_area
			--/////////////////////////////////////////
			,@s_srv           = @s_srv
			,@s_user          = @s_user
			,@s_term          = @s_term
			,@s_ofi           = @w_oficina
			,@s_rol           = @w_rol
			,@s_ssn           = @w_ssn
			,@s_lsrv          = @s_lsrv
			,@s_date          = @s_date
			,@s_sesn          = @w_sesn
			,@s_org           = 'U'
			,@s_culture       = 'es_EC'

			IF @w_return = 0
			BEGIN
				UPDATE cobis..cl_telefono_std  set
					tes_estado_cre   = 'F'
				where tes_ente_std = @w_ente_std
			 	AND tes_fecha      = @s_date
			 	AND tes_entidad    = @w_entidad
			 END
			 ELSE
				SELECT @w_error_tot = @w_error_tot + 1
		END TRY
	    BEGIN CATCH
			PRINT ' CREAR TELEFONO'
			SELECT @w_error = 7
			SELECT @w_msg   =  'Error al crear telefono CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
	        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END CATCH
	END
	ELSE -- no hay telefono
	BEGIN
		IF NOT EXISTS(select 1 from cobis..cl_telefono_std
			where tes_ente_std = @w_ente_std
			and tes_estado_cre = 'F'
		 	AND tes_fecha      = @s_date
		 	AND tes_entidad    = @w_entidad)
		begin
			SELECT @w_error = 71
			SELECT @w_msg   =  'Cliente sin telefono. CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
			INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		end
	END


	--///////////////////////////
	-- negocio del cliente
	--///////////////////////////
	select
	 @w_estado_neg        = nes_estado_cre
	,@w_n_nombre          = nes_n_nombre
	,@w_n_fecha_apertura  = nes_n_fecha_apertura
	,@w_n_actividad_ec    = nes_n_actividad_ec
	,@w_n_tiempo_activida = nes_n_tiempo_activida
	,@w_n_tiempo_dom_neg  = nes_n_tiempo_dom_neg
	,@w_n_emprendedor     = nes_n_emprendedor
	,@w_n_recurso         = nes_n_recurso
	,@w_n_ingreso_mensual = nes_n_ingreso_mensual
	,@w_n_tipo_local      = nes_n_tipo_local
	,@w_n_destino_credito = nes_n_destino_credito
	from cobis..cl_negocio_std
	where nes_ente_std = @w_ente_std
	and nes_estado_cre <> 'F'
	AND nes_fecha      = @s_date
	AND nes_entidad    = @w_entidad

	IF @@ROWCOUNT > 0
	BEGIN

		PRINT '------------- 5 ----------'
		BEGIN TRY
			EXEC @w_return = cobis..sp_negocio_cliente
			 @i_ente            = @w_ente_cobis
			,@t_trn             = 1709
			,@i_operacion       = 'I'
			--/////////////////////////////////////////
			,@i_nombre          = @w_n_nombre
			,@i_fecha_apertura  = @w_n_fecha_apertura
			,@i_actividad_ec    = @w_n_actividad_ec
			,@i_tiempo_activida = @w_n_tiempo_activida
			,@i_tiempo_dom_neg  = @w_n_tiempo_dom_neg
			,@i_emprendedor     = @w_n_emprendedor
			,@i_recurso         = @w_n_recurso
			,@i_ingreso_mensual = @w_n_ingreso_mensual
			,@i_tipo_local      = @w_n_tipo_local
			,@i_destino_credito = @w_n_destino_credito
			--/////////////////////////////////////////
			,@s_srv             = @s_srv
			,@s_user            = @s_user
			,@s_term            = @s_term
			,@s_ofi             = @w_oficina
			,@s_rol             = @w_rol
			,@s_ssn             = @w_ssn
			,@s_lsrv            = @s_lsrv
			,@s_date            = @s_date
			,@s_sesn            = @w_sesn
			,@s_org             = 'U'
			,@s_culture         = 'es_EC'

			IF @w_return = 0
			BEGIN
				UPDATE cobis..cl_negocio_std set
					nes_estado_cre = 'F'
				where nes_ente_std = @w_ente_std
			 	AND nes_fecha      = @s_date
			 	AND nes_entidad    = @w_entidad
			 END
			 ELSE
				SELECT @w_error_tot = @w_error_tot + 1
		END TRY
	    BEGIN CATCH
			PRINT ' CREAR NEGOCIO'
			SELECT @w_error = 8
			SELECT @w_msg   =  'Error al crear negocio CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
	        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END CATCH

	END
	ELSE -- no hay negocio
	BEGIN
		IF NOT EXISTS(SELECT 1 from cobis..cl_negocio_std
		where nes_ente_std = @w_ente_std
		and nes_estado_cre = 'F'
		AND nes_fecha      = @s_date
		AND nes_entidad    = @w_entidad)
		begin
			SELECT @w_error = 81
			SELECT @w_msg   =  'Cliente sin negocio. CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
			INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END
	END

	PRINT '------------- 6 ----------'
	--/////////////////////////////////////////
	-- DATOS DE REFRENCIAS, MIN 2
	--/////////////////////////////////////////
	SELECT @w_nombre_aux = ''
	SELECT @w_error_ref = 0
	SELECT @w_num_ref = 0
	WHILE 1=1
	BEGIN
		SELECT TOP 1
		 @w_estado_ref        = rfs_estado_cre
		,@w_r_nombre          = substring(rfs_r_nombre    , 1, 20)
		,@w_r_p_apellido      = substring(rfs_r_p_apellido, 1, 20)
		,@w_r_direccion       = substring(rfs_r_direccion , 1, 20)
		,@w_r_telefono_d      = substring(rfs_r_telefono_d, 1, 12)
		,@w_r_telefono_e      = substring(rfs_r_telefono_e, 1, 12)
		,@w_r_telefono_o      = substring(rfs_r_telefono_o, 1, 12)
		,@w_r_parentesco      = rfs_r_parentesco
		,@w_r_descripcion     = rfs_r_descripcion
		,@w_r_tiempo_conocido = rfs_r_tiempo_conocido
		,@w_r_direccion_e     = rfs_r_direccion_e
		,@w_nombre_aux        = rfs_r_nombre + rfs_r_p_apellido
		from cobis..cl_referencia_std
		where rfs_ente_std = @w_ente_std
		and rfs_estado_cre <> 'F'
		AND rfs_r_nombre + rfs_r_p_apellido > @w_nombre_aux
		AND rfs_fecha      = @s_date
		AND rfs_entidad    = @w_entidad
		ORDER BY rfs_r_nombre + rfs_r_p_apellido

		IF @@rowcount = 0 BREAK

		PRINT '------------- 7 ----------'	+ @w_nombre_aux

		BEGIN TRY
			EXEC @w_return = cobis..sp_refpersonal
			 @i_ente            = @w_ente_cobis
			,@t_trn             = 177
			,@i_operacion       = 'I'
			--/////////////////////////////////////////
			,@i_nombre          =  @w_r_nombre
			,@i_p_apellido      =  @w_r_p_apellido
			,@i_direccion       =  @w_r_direccion
			,@i_telefono_d      =  @w_r_telefono_d
			,@i_telefono_e      =  @w_r_telefono_e
			,@i_telefono_o      =  @w_r_telefono_o
			,@i_parentesco      =  @w_r_parentesco
			,@i_descripcion     =  @w_r_descripcion
			,@i_tiempo_conocido =  @w_r_tiempo_conocido
			,@i_direccion_e     =  @w_r_direccion_e
			--/////////////////////////////////////////
			,@s_srv             = @s_srv
			,@s_user            = @s_user
			,@s_term            = @s_term
			,@s_ofi             = @w_oficina
			,@s_ssn             = @w_ssn

			IF @w_return <> 0
			BEGIN
				SELECT @w_error_ref = 1
				SELECT @w_error_tot = @w_error_tot + 1
				GOTO SIGUIENTE1
			end

			UPDATE cobis..cl_referencia_std   set
				rfs_estado_cre = 'F'
			where rfs_ente_std = @w_ente_std
			AND rfs_r_nombre + rfs_r_p_apellido = @w_nombre_aux
			AND rfs_fecha      = @s_date
			AND rfs_entidad    = @w_entidad

			SELECT @w_num_ref = @w_num_ref + 1

		END TRY
	    BEGIN CATCH
			PRINT ' CREAR REFERENCIA'
			SELECT @w_error = 9
			SELECT @w_msg   =  'Error al crear referencia CL: ' + @w_ente_std
			SELECT @w_error_tot = @w_error_tot + 1
	        INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
			SELECT @w_error = 0
		END CATCH

SIGUIENTE1:
	END -- while 1=1 REFERENCIAS

	IF (SELECT count(1)
		from cobis..cl_referencia_std
		where rfs_ente_std = @w_ente_std
		and rfs_estado_cre = 'F'
		) < 2
	BEGIN
		SELECT @w_error = 92
		SELECT @w_msg   =  'Cliente no tiene completas las referencias. CL: ' + @w_ente_std
		SELECT @w_error_tot = @w_error_tot + 1
		INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
		SELECT @w_error = 0
	END

	SELECT @w_num_ref = 0

	IF @w_error_tot = 0
	BEGIN
		update cobis..cl_ente_std set
			ens_estado_cre = 'F'
		where ens_ente_std = @w_ente_std
		AND ens_fecha      = @s_date
		AND ens_entidad    = @w_entidad
		IF @@ERROR <> 0 GOTO SIGUIENTE

		UPDATE cobis..cl_ente_aux SET  -- se activa el cliente SIN tener cargado documentos
			ea_estado = 'A'
		WHERE ea_ente = @w_ente_cobis
		IF @@ERROR <> 0 GOTO SIGUIENTE
	end


SIGUIENTE:
	IF @w_error <> 0
	    INSERT INTO cl_reporte_tmp VALUES (convert(VARCHAR, @w_error) +'|'+@w_msg)
END -- while 1=1 de CLIENTES

	WHILE @@TRANCOUNT > 0
	BEGIN
        PRINT '------------- ' + convert(varchar, @@trancount)
        COMMIT
    end

	select
		@w_total = count(1)
	from cobis..cl_ente_std
	WHERE ens_fecha   = @s_date

	select
		@w_total_err = count(1)
	from cobis..cl_ente_std
	WHERE ens_estado_cre <> 'F'
	AND ens_fecha   = @s_date

	select
		@w_total_ok = count(1)
	from cobis..cl_ente_std
	WHERE ens_estado_cre = 'F'
	AND ens_fecha   = @s_date

	select
		@w_total = isnull(@w_total,0),
		@w_total_err = isnull(@w_total_err,0),
		@w_total_ok = isnull(@w_total_ok,0)

	INSERT INTO cl_reporte_tmp	select ''
--	INSERT INTO cl_reporte_tmp	select '------------------------------------------------------------------------------'
	INSERT INTO cl_reporte_tmp	select 'PROSPECTOS QUE NO FUERON ACTIVADOS : ' + convert(VARCHAR, @w_total_err) + ' de ' + convert(VARCHAR, @w_total)
--	INSERT INTO cl_reporte_tmp	select '------------------------------------------------------------------------------'
	INSERT INTO cl_reporte_tmp	select ''
    INSERT INTO cl_reporte_tmp	select 'ENTIDAD |CODIGO SANTANDER|CODIGO COBIS|ESTADO REGISTRO|APELLIDOS|NOMBRES|OFICIAL|OFICINA'
	INSERT INTO cl_reporte_tmp
	select
		ens_entidad            +'|'+
		ens_ente_std           +'|'+
		convert(VARCHAR,ens_ente_cobis)         +'|'+
		ens_estado_cre         +'|'+
		ens_papellido  + ' ' + ens_sapellido +'|'+
		ens_nombre     + ' ' + ens_segnombre +'|'+
		ens_login              +'|'+
		CONVERT(VARCHAR,ens_oficina)
	from cobis..cl_ente_std
	WHERE ens_estado_cre <> 'F'
	AND ens_fecha   = @s_date
	ORDER BY ens_entidad, ens_estado_cre,ens_papellido  , ens_sapellido , ens_nombre , ens_segnombre

	INSERT INTO cl_reporte_tmp	select ''
	INSERT INTO cl_reporte_tmp	select ''
--	INSERT INTO cl_reporte_tmp	select '------------------------------------------------------------------------------'
	INSERT INTO cl_reporte_tmp	select 'PROSPECTOS QUE *SI* FUERON ACTIVADOS : ' + convert(VARCHAR, @w_total_ok) + ' de ' + convert(VARCHAR, @w_total)
--	INSERT INTO cl_reporte_tmp	select '------------------------------------------------------------------------------'
	INSERT INTO cl_reporte_tmp	select ''

    INSERT INTO cl_reporte_tmp	select 'ENTIDAD |CODIGO SANTANDER|CODIGO COBIS|ESTADO REGISTRO|APELLIDOS|NOMBRES|OFICIAL|OFICINA'
	INSERT INTO cl_reporte_tmp
	select
		ens_entidad            +'|'+
		ens_ente_std           +'|'+
		convert(VARCHAR,ens_ente_cobis)         +'|'+
		ens_estado_cre         +'|'+
		ens_papellido  + ' ' + ens_sapellido +'|'+
		ens_nombre     + ' ' + ens_segnombre +'|'+
		ens_login              +'|'+
		CONVERT(VARCHAR,ens_oficina)
	from cobis..cl_ente_std
	WHERE ens_estado_cre = 'F'
	AND ens_fecha   = @s_date
	ORDER BY ens_entidad, ens_estado_cre,ens_papellido  , ens_sapellido , ens_nombre , ens_segnombre



RETURN 0




GO

