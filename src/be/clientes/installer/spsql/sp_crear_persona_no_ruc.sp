/*************************************************************************/
/*   Archivo:            sp_crear_persona_no_ruc.sp                      */
/*   Stored procedure:   sp_crear_persona_no_ruc                         */
/*   Base de datos:      cob_pac                                         */
/*   Producto: Clientes                                                  */
/*   Disenado por:  Sonia Rojas                                          */
/*   Fecha de escritura: 13-Feb-2017                                     */
/*************************************************************************/
/*               IMPORTANTE                                              */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*               PROPOSITO                                               */
/*   Este programa procesa las transacciones                             */
/*   DML de direcciones                                                  */
/*************************************************************************/
/*               MODIFICACIONES                                          */
/*   FECHA          AUTOR       RAZON                                    */
/*   13/Feb/2017    S.Rojas     Emision Inicial                          */
/*   29/Mar/2017    LGU	        Aumentar nuevos campos S105462           */
/*   28/Jun/2017    P. Ortiz    Aumentar nuevo campo Banco San           */
/*   13/Sep/2017    P. Ortiz    Agregar Creacion de Conyuge              */
/*   25/Sep/2019    ALD         Agregar validacion para correo           */
/*                              electronico unico                        */
/*   28-03-2019	    FSL         Agrega operacion conyuge                 */
/*   09/Dic/2019    SRO         Modificaciones Colectivos                */
/*   11/Feb/2019    S. Rojas    129027. Biometricos                      */
/*   24/Dic/2020    S. Rojas    151529 Error Negative File               */
/*   19/Jul/2021    S. Rojas    161141 LCR V2.0                          */
/*   11/May/2023    KVI         R.193221-Eliminar Tildes                 */
/*   23/Jun/2023    ACH         Por error #193221 se envia en #209990    */
/*************************************************************************/


use cob_pac
go

if exists (select 1 from sysobjects where name = 'sp_crear_persona_no_ruc')
   drop proc sp_crear_persona_no_ruc
go

create proc sp_crear_persona_no_ruc (
    @s_ssn          int,
    @s_sesn         int         = null,
    @s_culture      varchar(10) = null,
    @s_user         login       = null,
    @s_term         varchar(32) = null,
    @s_date         datetime,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_ofi          smallint    = NULL,
    @s_rol          smallint    = NULL,
    @s_org_err      char(1)     = NULL,
    @s_error        int         = NULL,
    @s_sev          tinyint     = NULL,
    @s_msg          descripcion = NULL,
    @s_org          char(1)     = NULL,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(10) = null,
    @t_from         varchar(32) = null,
    @t_trn          int    = null,
    @t_show_version bit         = 0,    -- Versionamiento
	@i_nombre                     descripcion   = null,  -- Primer nombre del cliente
	@i_papellido                  descripcion   = null,  -- Primer apellido del cliente
	@i_sapellido                  descripcion   = null,  -- Segundo apellido del cliente
	@i_filial                     tinyint       = null,  -- Codigo de la filial
	@i_oficina                    smallint      = null,  -- Codigo de la oficina
	@i_tipo_ced                   char(4)       = null,  -- Tipo del documento de identificacion
	@i_cedula                     numero        = null,  -- Numero del documento de identificacion
	@i_login_oficial              varchar(20)   = null,  -- Codigo del oficial asignado al cliente
	@i_c_apellido                 varchar(30)   = null,  -- Apellido casada
	@i_segnombre                  varchar(50)   = null,  -- Segundo nombre
	@i_sexo                       varchar(10)   = null,  -- codigo del sexo del cliente
	@i_est_civil                  varchar(10)   = null,  -- estado civil del cliente
	@i_ea_estado                  catalogo      = null,  -- estado cliente
	@i_dir_virtual				  varchar(50)   = null,	 -- email del cliente
	@i_fecha_expira				  datetime		= null,
	@i_fecha_nac				  datetime 		= null,
	@i_nombre_c                   descripcion   = null,  -- Primer nombre del c=nyuge
	@i_papellido_c                descripcion   = null,  -- Primer apellido del c=nyuge
	@i_sapellido_c                descripcion   = null,  -- Segundo apellido del c=nyuge
	@i_tipo_ced_c                 char(4)       = null,  -- Tipo del documento de identificacion c=nyuge
	@i_cedula_c                   numero        = null,  -- Numero del documento de identificacion c=nyuge
	@i_segnombre_c                varchar(50)   = null,  -- Segundo nombre c=nyuge
	@i_sexo_c                     varchar(10)   = null,  -- codigo del sexo del c=nyuge
	@i_est_civil_c                varchar(10)   = null,	 -- estado civil del c=nyuge
	@i_ea_estado_c                catalogo      = null,	 -- estado del c=nyuge
	@i_c_apellido_c				  varchar(30)   = null,
	@i_fecha_expira_c			  datetime		= null,
	@i_fecha_nac_c				  datetime 		= null,
	-- LGU-INI 27/mar/2017 nuevos campos
	@i_vinculacion                char(1)       = null,
	@i_tipo_vinculacion           varchar(10)   = null,
    @i_emproblemado               char(1)       = null, -- manejo de emproblemados
    @i_dinero_transac             money         = null, -- mnt de dinero transacciona mensualmente
    @i_manejo_doc                 varchar(25)   = null, -- manejo de documentos
    @i_pep                        char(1)       = null, -- s/n persona expuesta politicamente
    @i_mnt_activo                 money         = null, -- monto de los activos del cliente
    @i_mnt_pasivo                 money         = null, -- monto de los pasivos del cliente
    @i_tiempo_reside              int           = null, -- tiempo de residencia (meses)
    @i_ant_nego                   int           = null, -- antiguedad del negicio (meses)
    @i_ventas                     money         = null, -- ventas
    @i_ot_ingresos                money         = null, -- otros ingresos
    @i_ct_ventas                  money         = null, -- costos ventas
    @i_ct_operativos              money         = null, -- costos operativos
	-- LGU-FIN 27/mar/2017 nuevos campos
    @i_ciudad_nac                 int           = null, -- LGU santander: calculo de curp y rfc
    @i_ciudad_nac_c               int           = null, -- LGU santander: calculo de curp y rfc
    @i_operacion				  char(1),
    @i_ea_nro_ciclo_oi            int           = null, -- LPO Santander --numero de ciclos en otras entidades
    @o_ente						  int           = null  out,
    @o_dire						  int           = null  out,
    @o_ente_c					  int           = null  OUT,
    @o_curp                       varchar(32)   = null  out, -- LGU: calculo de rfc y curp
    @o_rfc                        varchar(32)   = null  out, -- LGU: calculo de rfc y curp
    @o_curp_c                     varchar(32)   = null  out, -- LGU: calculo de rfc y curp
    @o_rfc_c                      varchar(32)   = null  out, -- LGU: calculo de rfc y curp
	@i_batch                      char(1)       = 'N'      , -- LGU: sp que se dispara desde FE o BATCH
    --nuevo campo
    @i_num_ciclos				  INT			= null,
    @i_banco                      VARCHAR(20)   = null,
    @i_ea_telefono                varchar(10)   = null,
    @i_num_cargas                 int           = null,
    @i_rfc                        numero        = null,   
    @i_modo                       smallint      = 0,
    @i_bio_tipo_identificacion    varchar(10)   = null,
    @i_bio_cic                    varchar(9)    = null,
    @i_bio_ocr                    varchar(13)   = null,
    @i_bio_numero_emision         varchar(2)    = null,
    @i_bio_clave_lector           varchar(18)   = null,
    @i_bio_huella_dactilar        char(1)       = null,
    @i_canal                      varchar(4)    = null,
    @o_lista_negra                char(1)       = null out,
    @i_colectivo                  varchar(4)    = null,
    @i_nivel_colectivo            varchar(4)    = null,
    @i_register_year              varchar(4)    = null,
    @i_emission_year              varchar(4)    = null,
    @i_respuesta_renapo           char(1)       = null

)
as

declare 
@w_sp_name              varchar(30),
@w_relacion             int,
@w_pais                 int,
@w_oficial              int,
@w_tipo_direccion       char(2),
@w_estado_prospecto     char(1),
@w_lado_relacion        char(1),
@w_error                int

select @w_sp_name = 'cob_pac..sp_crear_persona_no_ruc'

--Inicio R.193221
select
    @i_nombre     = upper(rtrim(ltrim(isnull(@i_nombre,'')))),
    @i_segnombre  = upper(rtrim(ltrim(isnull(@i_segnombre,'')))),
    @i_papellido  = upper(rtrim(ltrim(isnull(@i_papellido,'')))),
	@i_sapellido  = upper(rtrim(ltrim(isnull(@i_sapellido,''))))

select
    @i_nombre     = cobis.dbo.fn_filtra_diacriticos(@i_nombre), 
    @i_segnombre  = cobis.dbo.fn_filtra_diacriticos(@i_segnombre),
    @i_papellido  = cobis.dbo.fn_filtra_diacriticos(@i_papellido),
	@i_sapellido  = cobis.dbo.fn_filtra_diacriticos(@i_sapellido)
--Fin R.193221

	if @i_operacion = 'I'
	begin
		begin tran

		select @w_tipo_direccion = 'CE' 	--Correo Electr=nico
		select @w_estado_prospecto = 'P'	--Tipo Persona: Prospecto

		-- Consulta pafs por defecto
		select  @w_pais = pa_smallint
		from 	cobis..cl_parametro
		where pa_nemonico = 'PAIS'

		if @w_pais is null
		begin
			exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 7300003
			return 1
		end

		select  @w_oficial  = oc_oficial
		from  cobis..cc_oficial,
			   cobis..cl_funcionario
		where  fu_login         = @i_login_oficial
		and  fu_funcionario   = oc_funcionario

		if @w_oficial is null
		BEGIN
			IF @i_batch = 'N'
                begin
				exec cobis..sp_cerror
					@t_debug     = @t_debug,
					@t_file      = @t_file,
					@t_from      = @w_sp_name,
					@i_num       = 2011212
				WHILE @@TRANCOUNT > 0 ROLLBACK
				return 2011212
                end
			ELSE
               begin
				return 1
               end
		end
		
	
		exec @w_error = cob_pac..sp_persona_no_ruc_busin
            @i_batch                        = @i_batch, -- LGU: se dispara desde FE o BATCH
			@i_nombre 			            = @i_nombre,
			@i_papellido 		            = @i_papellido,
			@i_sapellido 		            = @i_sapellido,
			@i_filial 			            = @i_filial,
			@i_oficina 			            = @i_oficina,
			@i_tipo_ced 		            = @i_tipo_ced,
			@i_cedula 			            = @i_cedula,
			@i_oficial 			            = @w_oficial,
			@i_segnombre		            = @i_segnombre,
			@i_fecha_expira		            = @i_fecha_expira,
			@i_fecha_nac		            = @i_fecha_nac,
			@i_sexo				            = @i_sexo,
			@i_est_civil		            = @i_est_civil,
			@i_c_apellido		            = @i_c_apellido,
			@t_trn				            = 1288,
			@i_operacion		            = @i_operacion,
			@i_estado			            = @w_estado_prospecto,
			@i_nacionalidad		            = @w_pais,
			@i_secuencial                   = 1,
            -- LGU-INI 27/mar/2017 nuevos campos
            @i_vinculacion                  = @i_vinculacion     ,
            @i_tipo_vinculacion             = @i_tipo_vinculacion,
            @i_emproblemado                 = @i_emproblemado     ,
            @i_dinero_transac               = @i_dinero_transac   ,
            @i_manejo_doc                   = @i_manejo_doc       ,
            @i_pep                          = @i_pep              ,
            @i_mnt_activo                   = @i_mnt_activo       ,
            @i_mnt_pasivo                   = @i_mnt_pasivo       ,
            @i_ant_nego                     = @i_ant_nego         ,
            @i_ventas                       = @i_ventas           ,
            @i_ot_ingresos                  = @i_ot_ingresos      ,
            @i_ct_ventas                    = @i_ct_ventas        ,
            @i_ct_operativos                = @i_ct_operativos    ,
            -- LGU-FIN 27/mar/2017 nuevos campos
            @i_ciudad_nac                   = @i_ciudad_nac       , -- LGU santander: calculo de curp y rfc
            @i_ea_nro_ciclo_oi              = @i_ea_nro_ciclo_oi  , -- LPO Santander --numero de ciclos en otras entidades
			@s_srv 				            = @s_srv,
			@s_user 			            = @s_user,
			@s_term 			            = @s_term,
			@s_ofi 				            = @s_ofi,
			@s_rol 				            = @s_rol,
			@s_ssn 				            = @s_ssn,
			@s_lsrv 			            = @s_lsrv,
			@s_date 			            = @s_date,
			@s_org 				            = @s_org,
            @o_curp                         = @o_curp out, -- LGU: calculo de nuevos campos
            @o_rfc                          = @o_rfc  out, -- LGU: calculo de nuevos campos
			@o_ente				            = @o_ente out,
			@i_banco			            = @i_banco,
            @i_num_cargas                   = @i_num_cargas,
            @i_rfc                          = @i_rfc,
            @i_modo                         = @i_modo,
            @i_bio_tipo_identificacion      = @i_bio_tipo_identificacion,
            @i_bio_cic                      = @i_bio_cic,             
			@i_bio_ocr                      = @i_bio_ocr,             
			@i_bio_numero_emision           = @i_bio_numero_emision,  
			@i_bio_clave_lector             = @i_bio_clave_lector,    
			@i_bio_huella_dactilar          = @i_bio_huella_dactilar,
			@o_lista_negra                  = @o_lista_negra out,
			@i_colectivo                    = @i_colectivo,
			@i_nivel_colectivo              = @i_nivel_colectivo,
			@i_register_year                = @i_register_year,
			@i_emission_year                = @i_emission_year,
			@i_respuesta_renapo             = @i_respuesta_renapo

            if @w_error <> 0 begin
		    WHILE @@TRANCOUNT > 0 ROLLBACK
			return @w_error
		end

		if @o_ente is null
		BEGIN
		     		
			-- LGU: se dispara desde FE o BATCH
			IF @i_batch = 'N'  
			BEGIN
				exec cobis..sp_cerror
						@t_debug     = @t_debug,
						@t_file      = @t_file,
						@t_from      = @w_sp_name,
						@i_num       = 7300004
			END
			ELSE -- LGU: para creacion masiva de clientes
			BEGIN
			
				WHILE @@TRANCOUNT > 0 ROLLBACK
				return 7300004
			end
		end
		commit tran
		
		if @i_dir_virtual is not null
		BEGIN
			exec cob_pac..sp_direccion_dml_busin
				@i_ente 			= @o_ente,
				@i_descripcion 		= @i_dir_virtual,
				@i_tipo 			= @w_tipo_direccion,
				@i_operacion 		= @i_operacion,
				-- LGU-INI 27/mar/2017 nuevos campos
				@i_tiempo_reside    = @i_tiempo_reside,
				-- LGU-FIN 27/mar/2017 nuevos campos
				@s_srv 				= @s_srv,
				@s_user 			= @s_user,
				@s_term 			= @s_term,
				@s_ofi 				= @s_ofi,
				@s_rol 				= @s_rol,
				@s_ssn 				= @s_ssn,
				@s_lsrv 			= @s_lsrv,
				@s_date 			= @s_date,
				@s_org 				= @s_org,
				@t_trn				= 109,
				@i_canal            = @i_canal,
				@o_dire				= @o_dire out

			if @o_dire is null
			BEGIN 
				IF @i_batch = 'N'
					exec cobis..sp_cerror
						@t_debug     = @t_debug,
						@t_file      = @t_file,
						@t_from      = @w_sp_name,
						@i_num       = 7300006
				ELSE
					return 1
			END
			--actualizacion tabla
			IF(@o_ente IS NOT NULL)
			BEGIN
				UPDATE cobis..cl_ente_aux   SET ea_nro_ciclo_oi=@i_num_ciclos,
				ea_fiel='No Aplica'
				WHERE ea_ente=@o_ente
			END
		END 
		
	
	return 0
	end
	--////////////////////////////////////////////
	if @i_operacion = 'C'
	begin
		begin tran
		
		select @w_lado_relacion = 'I'
		select @w_relacion = pa_tinyint
			from cobis..cl_parametro
			where pa_nemonico = 'COU' --relaci=n c=nyuge
			and pa_producto = 'CRE'
		
		select  @w_oficial  = oc_oficial
		from  cobis..cc_oficial,
			   cobis..cl_funcionario
		where  fu_login         = @s_user
		and  fu_funcionario   = oc_funcionario
		
		select @w_estado_prospecto = 'P'	--Tipo Persona: Prospecto

		--Se asigna el estado civil del conyuge
		IF NOT EXISTS (SELECT 1 FROM cobis..cl_ente 
						WHERE en_ente = @o_ente 
						AND ((p_estado_civil = 'CA') OR (p_estado_civil = 'UN')))
		begin
			IF @i_batch = 'N'
			BEGIN
				exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 103154
				return 103154
			END
			ELSE
				return 103154
		end
		
		if @w_relacion is null
		begin
			IF @i_batch = 'N'
			BEGIN
				exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 7300007
				return 1
			END
			ELSE
				RETURN 1
		end
		
		SELECT @i_operacion = 'I'
		exec cob_pac..sp_persona_no_ruc_busin
            @i_batch            = @i_batch, -- LGU: se dispara desde FE o BATCH
			@i_nombre 			= @i_nombre_c,
			@i_papellido 		= @i_papellido_c,
			@i_sapellido 		= @i_sapellido_c,
			@i_filial 			= @i_filial,
			@i_oficina 			= @i_oficina,
			@i_tipo_ced 		= @i_tipo_ced_c,
			@i_cedula 			= @i_cedula_c,
			@i_oficial 			= @w_oficial,
			@i_segnombre		= @i_segnombre_c,
			@i_fecha_expira		= @i_fecha_expira_c,
			@i_fecha_nac		= @i_fecha_nac_c,
			@i_sexo				= @i_sexo_c,
			@i_est_civil		= @i_est_civil_c,
			@i_c_apellido		= @i_c_apellido_c,
			@t_trn				= 1288,
			@i_operacion		= @i_operacion,
			@i_estado			= @w_estado_prospecto,
			@i_nacionalidad		= @w_pais,
			@i_secuencial       = 3,
			@s_srv 				= @s_srv,
			@s_user 			= @s_user,
			@s_term 			= @s_term,
			@s_ofi 				= @s_ofi,
			@s_rol 				= @s_rol,
			@s_ssn 				= @s_ssn,
			@s_lsrv 			= @s_lsrv,
			@s_date 			= @s_date,
			@s_org 				= @s_org,
      			@i_ciudad_nac       = @i_ciudad_nac_c , -- LGU santander: calculo de curp y rfc
			@o_curp             = @o_curp_c out,    -- LGU: calculo de nuevos campos
			@o_rfc              = @o_rfc_c  out,    -- LGU: calculo de nuevos campos
			@o_ente             = @o_ente_c	OUT,
			@i_banco            = @i_banco,
			@i_ea_estado        = @i_ea_estado,
			@i_rfc              = @i_rfc,
			@i_modo             = @i_modo,
			@i_respuesta_renapo = @i_respuesta_renapo

		if @o_ente_c is null
		BEGIN
			IF @i_batch = 'N'
			BEGIN
				exec cobis..sp_cerror
						@t_debug     = @t_debug,
						@t_file      = @t_file,
						@t_from      = @w_sp_name,
						@i_num       = 7300005
				return 1
			END
			ELSE
			begin
				WHILE @@TRANCOUNT > 0 ROLLBACK
				RETURN 1
			end
		END 

		exec cobis..sp_instancia
			@i_relacion 	= @w_relacion,
			@i_derecha 		= @o_ente,
			@i_izquierda	= @o_ente_c,
			@i_lado			= @w_lado_relacion,
			@i_operacion 	= @i_operacion,
			@t_trn			= 1367,
			@s_srv 			= @s_srv,
			@s_user 		= @s_user,
			@s_term 		= @s_term,
			@s_ofi 			= @s_ofi,
			@s_rol 			= @s_rol,
			@s_ssn 			= @s_ssn,
			@s_lsrv 		= @s_lsrv,
			@s_date 		= @s_date,
			@s_org 			= @s_org
	
		commit tran
		return 0
	end


	if @i_operacion = 'E'
	begin
		begin tran

	select @w_lado_relacion = 'I'
		select @w_relacion = pa_tinyint
			from cobis..cl_parametro
			where pa_nemonico = 'COU' --relaci=n c=nyuge
			and pa_producto = 'CRE'
		
		select  @w_oficial  = oc_oficial
		from  cobis..cc_oficial,
			   cobis..cl_funcionario
		where  fu_login         = @s_user
		and  fu_funcionario   = oc_funcionario
		
		
		if exists(select 1 from cobis..cl_conyuge where co_ente = @o_ente)
			begin
                update cobis..cl_conyuge 
                set co_nombre = @i_nombre_c,
                    co_snombre = @i_segnombre_c,
                    co_p_apellido = @i_papellido_c,
                    co_s_apellido = @i_sapellido_c,
                    co_telefono = @i_ea_telefono, 
                    co_fecha_nacimiento = @i_fecha_nac_c 
                where co_ente = @o_ente
            end 
		else
            begin 
               exec cobis..sp_cseqnos
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_tabla    = 'cl_conyuge',
               @o_siguiente  = @o_ente_c out
		
 
            insert into cobis..cl_conyuge 
            (co_secuencia,co_ente,co_nombre,co_snombre,co_p_apellido ,co_s_apellido,co_telefono ,co_fecha_nacimiento ,co_fecha_crea  )
        	values
        	(@o_ente_c, @o_ente,@i_nombre_c,@i_segnombre_c,@i_papellido_c,@i_sapellido_c,@i_ea_telefono,@i_fecha_nac_c,GETDATE())
            end
        commit tran
		return 0
	end