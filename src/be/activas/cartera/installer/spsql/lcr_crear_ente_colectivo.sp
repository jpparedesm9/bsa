/************************************************************************/
/*  Archivo:              lcr_ente_colectivo.sp                         */
/*  Stored procedure:     sp_lcr_ente_colectivo                          */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         Andy Gonzalez         .                       */
/*  Fecha de escritura:   17/Diciembre/2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA        AUTOR                    RAZON                     */
/*   27/Jun/2023     ACH     #210163 Error en CURP-no debemos generar   */
/************************************************************************/

USE cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_lcr_crear_ente_colectivo')
   drop proc sp_lcr_crear_ente_colectivo
go


create proc sp_lcr_crear_ente_colectivo (
@s_date                datetime,
@s_user                login        = null,
@s_ofi                 INT          = null,
@s_term                descripcion  = null,
@s_srv                 descripcion  = null,
@s_lsrv                descripcion  = null,
@s_ssn                 int          = null,
@s_rol                 int          = null, 
@s_sesn                int          = null,
@s_org                 descripcion  = null,
@s_culture             descripcion  = null,        
@i_operacion           char(2)      = null,
@i_crear_persona       char(1)      = 'N',
@i_crear_tramite       char(1)      = 'N',
@t_trn                 int          = 0,
@i_apellido_1          varchar(264) = null,		-- Apellido Paterno
@i_apellido_2          varchar(264) = null,     -- Apellido Materno
@i_nombre_1            varchar(264) = null,     -- Primer Nombre
@i_nombre_2            varchar(264) = null,     -- Segundo Nombre
@i_fecha_nac           varchar(264) = null,     -- Fecha de Nacimiento
@i_entidad_fed_nac     varchar(264) = null,     -- Entidad Federal de Nacimiento
@i_genero              varchar(1)   = null,     -- Genero
@i_calle_dom           varchar(600) = null,
@i_numero_int_dom      varchar(255) = null,
@i_numero_ext_dom      varchar(255) = null, 
@i_colonia_dom         varchar(255) = null,
@i_cp_domicilio        varchar(255) = null,
@i_correo_elec         varchar(255)  = null,    -- Correo Electrónico
@i_celular             varchar(255)  = null,    -- Número Celular
@i_colectivo           varchar(120) = null,     -- Tipo de Mercado
@i_nivel_colectivo     varchar(120) = null,		-- Nivel Cliente
@i_rfc                 varchar(120) = null,     -- RFC
@i_curp                varchar(120) = null,     -- CURP
@i_actividad_eco       varchar(120) = null,
@i_ventas_mensuales    varchar(264) = null,
@i_numero_hijos        varchar(10)  = null,
@i_periodicidad        varchar(120) = null,
@i_oficina             varchar(10)     = null,     -- Oficina Cliente
@i_oficial			   varchar(20)  = null,	    -- Oficial del Cliente
@i_archivo			   varchar(255)  = null,
@i_reg_exito           int = null,
@i_total               int = null,
@i_estado              char(1) = null,
@o_msg                 varchar(3000) = null out ,
@o_sev                 int          = 0    out,
@o_ente                int          = 0    out 
) as 
declare 
@w_msg                   varchar(3000),
@w_curp_cob              varchar(255),
@w_curp_ext              varchar(255),
@w_rfc_cobis             varchar(255),
@w_homoclave_cobis       varchar(255),
@w_homoclave_ext         varchar(255),
@w_ente                  int,
@w_error                 int,
@w_commit                char(1),
@w_sp_name               varchar(255),
@w_tramite_out           int,
@w_subtipo               varchar(10),
@w_nem_flujo             varchar(10),
@w_en_linea              char(1),
@w_id_flujo              int,
@w_flujo_version         int,
@w_oficina               int,
@w_ofi_str               varchar(10),
@w_sev                   int,
@w_nombres               varchar(255), 
@w_nombre_completo       varchar(255),
@w_curp_cobis            varchar(255),
@w_rfc                   varchar(255) ,
@w_curp                  varchar(255),
@w_rfc_ext_sh            varchar(255),
@w_rfc_cobis_sh          varchar(255),
@w_rfc_cob_sh            varchar(255),
@w_homoclave_cob         varchar(10),
@w_tipo                  varchar(10) ,
@w_toperacion            catalogo,
@w_ciudad                int,
@w_moneda                int,
@w_monto                 money,
@w_destino               varchar(10),
@w_oficina_virtual       int,
@w_direccion             varchar(600),
@w_secuencial            int  ,
@w_fecha_proceso         datetime ,  
@w_oficial               int,
@w_inst_proc             int ,
@w_periodicidad          varchar(2),
@w_asesor                int,
@w_entidad               int, 
@w_fecha_nac             datetime,
@w_colectivo             catalogo,
@w_nivel_colectivo       catalogo,
@w_colonia               int,
@w_estado                int,
@w_municipio             int,
@w_pais                  int,
@w_colonia_reg           int, 
@w_codigo_negocio        int,
@w_negocio               varchar(255),
@w_dir_elect             int,
@w_nacionalidad          int,
@w_tipo_p                char(1),
@w_edad_min              int,
@w_edad_max              int,
@w_nemocda               char(3),
@w_nemomed               char(3)

declare @w_codigo_postal table(
   cp_estado      int,
   cp_municipio   int,
   cp_colonia     int,
   cp_pais        int
)

declare @w_colonias table(
   codigo         int
)


--CARGAR VALORES INICIALES
select 
@w_sp_name   = 'sp_lcr_crear_ente_colectivo',
@w_nem_flujo = 'SOLCRECOL', -- LGU: FLUJO DEFINITIVO
@w_en_linea  = 'N',
@w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso 

if @i_operacion = 'C'
begin
	select 
	@w_id_flujo      = pr_codigo_proceso,
	@w_flujo_version = pr_version_prd
	from cob_workflow..wf_proceso
	where pr_nemonico = @w_nem_flujo


	select 
	@w_sev = 0, 
	@w_msg = '', 
	@o_sev = 0, 
	@o_msg = ''


	--QUITAR ESPACIOS
	select 
	@i_apellido_1      = rtrim(ltrim(@i_apellido_1)),      
	@i_apellido_2      = rtrim(ltrim(@i_apellido_2)),      
	@i_nombre_1        = rtrim(ltrim(@i_nombre_1)),        
	@i_nombre_2        = rtrim(ltrim(@i_nombre_2)),        
	@i_fecha_nac       = rtrim(ltrim(@i_fecha_nac)),       
	@i_entidad_fed_nac = rtrim(ltrim(upper(@i_entidad_fed_nac))), 
	@i_genero          = rtrim(ltrim(upper(@i_genero))),          
	@i_calle_dom       = rtrim(ltrim(@i_calle_dom)),       
	@i_numero_int_dom  = rtrim(ltrim(@i_numero_int_dom)),  
	@i_numero_ext_dom  = rtrim(ltrim(@i_numero_ext_dom)),  
	@i_colonia_dom     = rtrim(ltrim(@i_colonia_dom)),     
	@i_cp_domicilio    = rtrim(ltrim(@i_cp_domicilio)),    
	@i_correo_elec     = rtrim(ltrim(@i_correo_elec)),     
	@i_celular         = rtrim(ltrim(@i_celular)),         
	@i_colectivo       = rtrim(ltrim(upper(@i_colectivo))),       
	@i_nivel_colectivo = rtrim(ltrim(upper(@i_nivel_colectivo))), 
	@i_rfc             = rtrim(ltrim(upper(@i_rfc))),             
	@i_curp            = rtrim(ltrim(upper(@i_curp))),            
	@i_actividad_eco   = rtrim(ltrim(@i_actividad_eco)),   
	@i_ventas_mensuales= rtrim(ltrim(@i_ventas_mensuales)),
	@i_numero_hijos    = rtrim(ltrim(@i_numero_hijos)),    
	@i_periodicidad    = rtrim(ltrim(upper(@i_periodicidad))),
	@i_oficina         = rtrim(ltrim(upper(@i_oficina))),
	@i_oficial         = rtrim(ltrim(upper(@i_oficial)))

	--Se transforma vocales con tildes, si llegan, en vocales sin tilde
	select @i_entidad_fed_nac = replace(@i_entidad_fed_nac,'Á','A')
	select @i_entidad_fed_nac = replace(@i_entidad_fed_nac,'É','E')
	select @i_entidad_fed_nac = replace(@i_entidad_fed_nac,'Í','I')
	select @i_entidad_fed_nac = replace(@i_entidad_fed_nac,'Ó','O')
	select @i_entidad_fed_nac = replace(@i_entidad_fed_nac,'Ú','U')

	--Entidad de nacimiento obligatorio
	--oficina obligatorio
	--oficial obligatorio

	--VALIDACION OBLIGATORIEDAD DE CAMPOS 
	if @i_nombre_1         is null or @i_nombre_1 = ''        select @o_msg = @o_msg + '| ERROR: EL CAMPO PRIMER NOMBRE ES OBLIGATORIO'   
	if @i_apellido_1       is null or @i_apellido_1 = ''      select @o_msg = @o_msg + '| ERROR: EL CAMPO APELLIDO PATERNO ES OBLIGATORIO'    
	if @i_fecha_nac        is null or @i_fecha_nac = ''       select @o_msg = @o_msg + '| ERROR: EL CAMPO FECHA NACIMIENTO ES OBLIGATORIO'   
	if @i_entidad_fed_nac  is null or @i_entidad_fed_nac = '' select @o_msg = @o_msg + '| ERROR: EL CAMPO ENTIDAD FEDERAL DE NACIMIENTO ES OBLIGATORIO'   
	if @i_genero           is null or @i_genero = ''          select @o_msg = @o_msg + '| ERROR: EL CAMPO GENERO ES OBLIGATORIO'   
	if @i_correo_elec      is null or @i_correo_elec = ''     select @o_msg = @o_msg + '| ERROR: EL CAMPO CORREO ELECTRONICO ES OBLIGATORIO'   
	if @i_celular          is null or @i_celular = ''         select @o_msg = @o_msg + '| ERROR: EL CAMPO NUMERO CELULAR ES OBLIGATORIO'   
	if @i_oficina          is null or @i_oficina = ''         select @o_msg = @o_msg + '| ERROR: EL CAMPO OFICINA ES OBLIGATORIO'   
	if @i_colectivo        is null or @i_colectivo = ''       select @o_msg = @o_msg + '| ERROR: EL CAMPO NOMBRE COLECTIVO ES OBLIGATORIO'   
	if @i_nivel_colectivo  is null or @i_nivel_colectivo = '' select @o_msg = @o_msg + '| ERROR: EL CAMPO NIVEL COLECTIVO ES OBLIGATORIO'
	if @i_oficial          is null or @i_oficial = ''         select @o_msg = @o_msg + '| ERROR: EL CAMPO OFICIAL ES OBLIGATORIO'   
	 
	if @i_nombre_1         is null or @i_nombre_1 = ''        select @o_sev = @o_sev + 1  
	if @i_apellido_1       is null or @i_apellido_1 = ''      select @o_sev = @o_sev + 1  
	if @i_fecha_nac        is null or @i_fecha_nac = ''       select @o_sev = @o_sev + 1  
	if @i_genero           is null or @i_genero = ''          select @o_sev = @o_sev + 1  
	if @i_entidad_fed_nac  is null or @i_entidad_fed_nac = '' select @o_sev = @o_sev + 1  
	if @i_correo_elec      is null or @i_correo_elec = ''     select @o_sev = @o_sev + 1  
	if @i_celular          is null or @i_celular = ''         select @o_sev = @o_sev + 1  
	if @i_oficina          is null or @i_oficina = ''         select @o_sev = @o_sev + 1  
	if @i_colectivo        is null or @i_colectivo = ''       select @o_sev = @o_sev + 1  
	if @i_nivel_colectivo  is null or @i_nivel_colectivo = '' select @o_sev = @o_sev + 1 
	if @i_oficial          is null or @i_oficial = ''         select @o_sev = @o_sev + 1 

	if @i_oficina is not null and @i_oficina <> ''
	begin
		select @w_oficina = convert(int,@i_oficina)
	end

	--VALIDACION DE EXISTENCIA DE LA PERSONA EN COBIS

	--GENERACION RFC

	select 
	@w_nombres         = @i_nombre_1 + ' ' + @i_nombre_2,
	@w_nombre_completo = @i_nombre_1 + ' ' + @i_nombre_2 +' ' + @i_apellido_1 + ' ' + @i_apellido_2

	set DATEFORMAT ymd
	if isdate(@i_fecha_nac) = 1 begin
		select @w_fecha_nac       = convert(DATETIME, @i_fecha_nac, 111)
	end else begin
	   select 
	   @o_sev   = @o_sev + 1,
	   @o_msg   = @o_msg +'| EL FORMATO DE LA FECHA DE NACIMIENTO ES INCORRECTO.' 
	end 
	set DATEFORMAT mdy

	select top 1 @w_entidad  =  pv_provincia
	from cobis..cl_provincia pv
	where pv_provincia  =  convert(int,@i_entidad_fed_nac)

	if @@rowcount = 0 and @i_entidad_fed_nac is not null begin
	   select 
	   @o_sev   = @o_sev + 1,
	   @o_msg   = @o_msg +'| NO EXISTE ENTIDAD FEDERAL DE NACIMIENTO'  
	end 

	--SE COLOCA POR DEFAULT OFICINA AGUAS CALIENTES PARA sp_generar_curp
	select @w_entidad = isnull(@w_entidad, 1)

	exec @w_error            = cobis..sp_generar_curp
	@i_primer_apellido       = @i_apellido_1,
	@i_segundo_apellido      = @i_apellido_2,
	@i_nombres               = @w_nombres,
	@i_sexo                  = @i_genero,
	@i_fecha_nacimiento      = @w_fecha_nac,
	@i_entidad_nacimiento    = @w_entidad,
	@o_mensaje               = @w_msg  out,
	@o_curp                  = @w_curp_cobis out,
	@o_rfc                   = @w_rfc_cobis  out    --RFC CON HOMOCLAVE

	if @w_error <> 0 begin 
	   
	   if @w_error = 70011007 begin --VALIDAR SI EXISTE UN RFC EN COBIS
		  select 
		  @o_msg  = @o_msg +' | ERROR: YA EXISTE UNA PERSONA CON ESTE CURP', 
		  @o_sev  = @o_sev + 1
	   end else if @w_error = 70011008 begin --VALIDAR SI EXISTE UN CURP EN COBIS
		  select 
		  @o_msg  = @o_msg +' | ERROR: YA EXISTE UNA PERSONA CON ESTE RFC', 
		  @o_sev  = @o_sev + 1
	   end else begin
		  select 
		  @o_sev   = @o_sev + 1,
		  @o_msg   = @o_msg +'| ERROR EN LA GENERACION DEL RFC/CURP' 
	   end	  

	end 

    --No debe generar el curp #210163, pero se deja si el dato no viene de las pantallas , parametro ACRXCR = 'N'---
	if @i_curp is not null and rtrim(ltrim(@i_curp)) != '' begin
	    select @w_curp_cobis = @i_curp
	end

	if @i_rfc is null or rtrim(ltrim(@i_rfc)) = '' begin
	   select @w_rfc  = @w_rfc_cobis 
	end

	if @i_curp is null or rtrim(ltrim(@i_curp)) = '' begin   
	   if @i_entidad_fed_nac is null or @i_entidad_fed_nac = ''
		  select @w_curp_cobis = @w_rfc_cobis
	   select @w_curp = @w_curp_cobis 
	end
	else if (@i_curp is not null and rtrim(ltrim(@i_curp)) <> '') and (@w_curp_cobis is not null and rtrim(ltrim(@w_curp_cobis)) <> '')
			 and (@w_curp_cobis <> @i_curp) begin --VALIDAR DIFERENCIAS DE CURP
	   select 
	   @o_msg  = @o_msg +' | '+'ERROR: CURP NO SE CORRESPONDE CON LOS DATOS DE LA PERSONA' ,
	   @o_sev  = @o_sev + 1
	end
	---VALIDAR SI EL RFC  VIENE SIN HOMOCLAVE Y COMPARARLO CON EL GENERADO SIN HOMOCLAVE

	if @i_rfc is not null and @i_rfc <> '' and len(@i_rfc) <=10  select @o_msg  = 'ERROR: RFC NO SE CORRESPONDE CON LA LONGITUD'


	select 
	@w_rfc_ext_sh     = case when len(@i_rfc) >= 10 then  substring ( @i_rfc, 1, len(@i_rfc)-3) else @i_rfc end ,
	@w_rfc_cob_sh     = substring (@w_rfc_cobis, 1, len(@w_rfc_cobis)-3), 
	@w_homoclave_ext  = case when len(@i_rfc) >= 10 then  substring ( @i_rfc, len(@i_rfc)-2,3) else '' end ,
	@w_homoclave_cob  = substring (@w_rfc_cobis , len(@w_rfc_cobis)-2, 3) 


	--VALIDACION DE REF CON SIN HOMOCLAVE  
	if @w_rfc_ext_sh    <> @w_rfc_cobis_sh     
	   select 
	   @o_msg  = @o_msg +' | '+ 'ERROR: RFC NO SE CORRESPONDE CON EL NOMBRE DE LA PERSONA' , 
	   @o_sev  = @o_sev + 1 

	--VALIDAR  HOMOCLAVE 
	if @w_homoclave_ext <> @w_homoclave_cobis and @w_homoclave_ext = '' 
	   select @o_msg  = @o_msg +' | '+'ALERTA: RFC DEL CLIENTE CON HOMOCLAVE DISTINTA A LA CALCULADA, PREVALECERÍA LA QUE LLEGA EN EL ARCHIVO PLANO'

	select 
	@w_curp = @w_curp_cobis,
	@w_rfc  = @w_rfc_cobis


	--VALIDACION DE NOMBRES MAYUSCULAS, TILDES, QUITA CARACTERES ESPECIALES 
	--PRIMER NOMBRE 


	exec cobis..sp_validar_persona
	@i_valor_txt = @i_nombre_1,
	@i_opcion    = 'NOMBRE1',
	@o_msg       = @w_msg     out ,
	@o_sev       = @w_sev     out  

	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev


	--SEGUNDO NOMBRE 
	exec cobis..sp_validar_persona
	@i_valor_txt = @i_nombre_2,
	@i_opcion    = 'NOMBRE2',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 
	 
	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--PRIMER APELLIDO 
	exec cobis..sp_validar_persona
	@i_valor_txt = @i_apellido_1,
	@i_opcion    = 'APELLIDO1',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 

	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--SEGUNDO APELLIDO 
	exec  cobis..sp_validar_persona
	@i_valor_txt = @i_apellido_2,
	@i_opcion    = 'APELLIDO2',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 

	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev


	--FECHA NACIMIENTO
	exec cobis..sp_validar_persona
	@i_valor_txt = @w_fecha_nac,
	@i_opcion    = 'FECHA',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 

	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--ENTIDAD NACIMIENTO

	if @i_entidad_fed_nac <> null begin 

	   exec  cobis..sp_validar_persona
	   @i_valor_txt = @i_entidad_fed_nac,
	   @i_opcion    = 'ENTIDAD',
	   @o_msg       = @w_msg    out ,
	   @o_sev       = @w_sev    out 
	   
	   select 
	   @o_msg  = @o_msg + @w_msg,
	   @o_sev  = @o_sev + @w_sev

	end 
	--GENERO
	exec  cobis..sp_validar_persona
	@i_valor_txt = @i_genero,
	@i_opcion    = 'GENERO',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 

	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--CORREO ELECTRONICO
	exec  cobis..sp_validar_persona
	@i_valor_txt = @i_correo_elec,
	@i_opcion    = 'EMAIL',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 
	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--NUMERO DE CELULAR 
	exec cobis..sp_validar_persona
	@i_valor_txt = @i_celular,
	@i_opcion    = 'CELULAR',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 
	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev

	--NOMOBRE COLECTIVO
	exec cobis..sp_validar_persona
	@i_valor_txt = @i_colectivo,
	@i_opcion    = 'COLECTIVO',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 
	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev


	--NIVEL CLIENTE EN COLECTIVO
	exec cobis..sp_validar_persona
	@i_valor_txt = @i_nivel_colectivo,
	@i_opcion   = 'NIVEL',
	@o_msg       = @w_msg    out ,
	@o_sev       = @w_sev    out 
	select 
	@o_msg  = @o_msg + @w_msg,
	@o_sev  = @o_sev + @w_sev


	if @i_numero_hijos is not null begin 
	   --NUMERO HIJOS
	   exec  cobis..sp_validar_persona
	   @i_valor_txt = @i_numero_hijos,
	   @i_opcion    = 'HIJOS',	
	   @o_msg       = @w_msg    out ,
	   @o_sev       = @w_sev    out 
	   select 
	   @o_msg  = @o_msg + @w_msg,
	   @o_sev  = @o_sev + @w_sev
	end
	
	select @w_oficial = oc_oficial
	from  cobis..cc_oficial,cobis..cl_funcionario,cobis..cl_catalogo
	where oc_funcionario   = fu_funcionario 
	and   codigo           = oc_tipo_oficial
	and   tabla = (select codigo from cobis..cl_tabla
	               where tabla = 'cc_tipo_oficial')
	and  fu_funcionario   = oc_funcionario
	and upper(fu_login) = upper(@i_oficial)
	if @@rowcount = 0
	begin
		select 
		@o_sev = @o_sev + 1,
        @o_msg  = @o_msg + ' | '+'ERROR: OFICIAL NO VALIDO'
	end

	SELECT @w_ofi_str = cl_catalogo.codigo
    FROM cobis..cl_catalogo INNER JOIN cobis..cl_tabla 
	ON cl_catalogo.tabla = cl_tabla.codigo
    WHERE cl_tabla.tabla = 'cl_oficina'
	AND cl_catalogo.codigo = @i_oficina
	AND cl_catalogo.estado = 'V'
	if @@rowcount = 0
	begin
		select 
		@o_sev = @o_sev + 1,
        @o_msg  = @o_msg + ' | '+'ERROR: OFICINA NO VALIDA' 
	end


	--VALIDACIONES ADICIONALES
	--Moneda
	select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC'

	if @o_sev = 0 begin 
		 
	   ---LECTURA DEL CATALOGO 
	   select 
	   @w_tipo = 'O',
	   @w_toperacion = 'REVOLVENTE',
	   @w_monto = 0.0,
	   @w_destino = '01'       
		 
	   select top 1 
	   @w_oficina_virtual = of_oficina , 
	   @w_ciudad          = of_ciudad  
	   from cobis..cl_oficina 
	   where upper(of_nombre) = upper(@i_colectivo)

	   if @@rowcount = 0 begin
		  select 
		  @w_error = 101016,
		  @w_msg   = 'NO EXISTE COLECTIVO INGRESADO'
	   end   

		/* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
		if @@trancount = 0 begin
			select @w_commit = 'S'
			begin tran
		end

		
		--si es null se setea el tipo de persona
		if @w_tipo_p is null
		begin
			select @w_tipo_p = pa_char from cobis..cl_parametro
			where pa_producto ='CLI'
			and pa_nemonico ='VGTPNA'
		end

		select  @w_nacionalidad = pa_smallint
		from 	cobis..cl_parametro
		where pa_nemonico = 'PAIS'
		
		select @w_edad_min = pa_tinyint  --Edad minima
		from cobis..cl_parametro 
		where pa_nemonico = 'MDE'
		and   pa_producto = 'ADM'

		select @w_edad_max = pa_tinyint --Edad maxima
		from   cobis..cl_parametro 
		where pa_nemonico ='EMAX'
		and   pa_producto = 'ADM'

		select @w_nemocda = pa_char
		from cobis..cl_parametro
		where pa_nemonico = 'CDA'
		and pa_producto = 'CLI'

		select @w_nemomed = pa_char
		from cobis..cl_parametro
		where pa_nemonico = 'MED'
		and   pa_producto = 'CLI'
	   
		 
	   if @i_crear_persona  = 'S' begin 
	   
	   
		  --SACAR SECUENCIALES SESIONES
		  exec @s_ssn = sp_gen_sec
			   @i_operacion = -1
		  
		  exec @s_sesn = sp_gen_sec
			   @i_operacion = -1
		 
		  PRINT '@w_curp:'+@w_curp
		  PRINT '@w_rfc:'+@w_rfc
		  
		  --Ajustar con gobierno y agregar creación de correo electronico
		  --CREAR PROSPECTO
		exec @w_error    = cobis..sp_bsa_persona_no_ruc_busin 
		@i_nombre        = @i_nombre_1,
		@i_segnombre     = @i_nombre_2,
		@i_papellido     = @i_apellido_1,
		@i_sapellido     = @i_apellido_2,
		@i_filial        = 1,
		@i_oficina       = @w_oficina,               
		@i_tipo_ced      = 'CURP',
		@i_tipo          = @w_tipo_p, 
		@i_cedula        = @w_curp,
		@i_rfc           = @w_rfc,
		@i_sexo          = @i_genero,
		@i_nacionalidad  = @w_nacionalidad,
		@i_est_civil     = 'SO',
		@i_fecha_expira  = null,
		@i_fecha_nac     = @w_fecha_nac,
		@i_ciudad_nac    = @w_entidad,                  
		@i_ea_estado     = 'P',
		@i_operacion     = 'I',
		@i_batch         = 'N', -- S si es por batch o N si no lo es????
		@i_num_cargas    = @i_numero_hijos,
		@i_modo          = 1,
		@i_oficial       = @w_oficial,
		--P @i_cuenta        = @i_cuenta,
		--P @i_banco         = @i_buc,
		@o_ente          = @w_ente      output,
		@s_ofi           = @s_ofi,
		@s_user          = @s_user,
		@s_ssn           = @s_ssn,
		@s_date          = @w_fecha_proceso,
		@s_term          = '0',
		@s_srv           = 'CTSSRV',
		@s_lsrv          = 'CTSSRV',
		@s_rol           = 1,
		@t_trn			 = 1288,
		@i_edad_min      = @w_edad_min, --P 
		@i_edad_max      = @w_edad_max, --P 
		@i_nemocda       = @w_nemocda,  --P 
		@i_nemomed       = @w_nemomed   --P 

		if @w_error <> 0 or @@error <> 0 begin
			select 
				@w_error = 219000, 
				@w_msg   = 'ERROR EN LA CREACION DEL PROSPECTO'
			goto ERROR_FIN
		end
		
		select @o_ente = @w_ente

		  select @w_subtipo = en_subtipo 
		  from cobis..cl_ente 
		  where en_ente = @w_ente
		  
		  select @w_colectivo       = c.codigo  
		  from cobis..cl_catalogo c , cobis..cl_tabla t 
		  where  c.tabla = t.codigo 
		  and upper(c.codigo) in (upper(@i_colectivo)) 
		  and t.tabla = 'cl_tipo_mercado' 
		  
		  
		  select @w_nivel_colectivo = c.codigo  
		  from cobis..cl_catalogo c , cobis..cl_tabla t 
		  where  c.tabla = t.codigo 
		  and upper(c.codigo) in (upper(@i_nivel_colectivo)) 
		  and t.tabla  = 'cl_nivel_cliente_colectivo' 

		  update cobis..cl_ente_aux set 
		  ea_colectivo       = rtrim(ltrim(@w_colectivo)),
		  ea_nivel_colectivo = rtrim(ltrim(@w_nivel_colectivo)),
		  ea_estado_std      = 'CLI'  
		  where ea_ente = @w_ente
		  
		  if @@error <> 0 or @@error <> 0 begin
			 select 
			 @w_error = 219002, 
			 @w_msg   = 'ERROR EN LA ACTUALIZACION DE LA INFORMACION DEL COLECTIVO DEL CLIENTE'
			 goto ERROR_FIN
		  end
		  
		-- ===================================================
		
		SELECT @w_pais = pa_smallint FROM cobis..cl_parametro 
		WHERE pa_nemonico = 'CP' AND pa_producto = 'ADM'
		if (@w_pais is null)
		begin
			select 
			 @w_error = 101077, 
			 @w_msg   = 'ERROR: NO EXISTE PARAMETRO PAIS (CP)'
			 goto ERROR_FIN
		end
		
		exec @w_error     = cobis..sp_bsa_crear_direccion 
		@i_ente           = @w_ente,  
		@i_tipo           = 'RE',
		@i_operacion      = 'I', 
		@i_parroquia      = '',
		@i_ciudad         = '',
		@i_provincia      = '',
		@i_calle          = '', 
		@i_codpostal      = '',
		@i_nro            = '',
		@i_nro_interno    = '',
		@i_pais           = @w_pais,
		@i_principal      = 'S',
		@i_tipo_prop      = 'REN',
		@i_ci_poblacion   = '',
		@s_srv            = 'CTSSRV', 
		@s_user           = @i_oficial, 
		@s_term           = '0', 
		@s_ofi            = @w_oficina, 
		@s_rol            = 1 ,
		@s_ssn            = @s_ssn, 
		@s_lsrv           = 'CTSSRV', 
		@s_date           = @w_fecha_proceso, 
		@s_org            = 'U', 
		@t_trn            = 109,
		@o_dire           = @w_direccion out

		if @w_error <> 0 or @@error <> 0 begin
		   select 
		   @w_msg   = case when @w_error is null then 'ERROR EN LA CREACION DE LA DIRECCION DEL CLIENTE' else null end,
		   @w_error = isnull(@w_error, 219000)   
		   goto ERROR_FIN
		end 
		-- ===================================================
			  
		if @i_correo_elec is not null or rtrim(ltrim(@i_correo_elec)) <> '' begin

		   exec @w_error = cobis..sp_bsa_crear_direccion
		   @i_ente 			    = @w_ente,
		   @i_descripcion 		= @i_correo_elec,
		   @i_tipo 			    = 'CE',
		   @i_operacion 		= 'I',
		   @i_tiempo_reside     = 0,
		   @s_srv 				= 'CTSSRV',
		   @s_user 			    = @i_oficial,
		   @s_term 			    = '0',
		   @s_ofi 				= @w_oficina_virtual,
		   @s_rol 				= 1,
		   @s_ssn 				= @s_ssn,
		   @s_lsrv 			    = 'CTSSRV',
		   @s_date 			    = @w_fecha_proceso,
		   @s_org 				= 'U',
		   @t_trn				= 109,
		   @o_dire				= @w_dir_elect out
		   if @w_error <> 0 or @@error <> 0 or @w_dir_elect = 0 or @w_dir_elect is null begin

			  select 
			  @w_msg   = case when @w_error is null then 'ERROR EN LA CREACION DEL PROSPECTO' else null end,
			  @w_error = isnull(@w_error, 219000)      
			  goto ERROR_FIN
		   end 
		end

		-- ===================================================
		  
		  ---reemplazar con sp gob
		if (@i_celular is not null or @i_celular <> '') and (@w_direccion is not null or @w_direccion <> '') begin
		   exec @w_error          = cobis..sp_bsa_crear_telefono
		   @s_ssn                 = @s_ssn,
		   @s_user                = @i_oficial,
		   @s_term                = '0',
		   @s_sesn                = @s_ssn,
		   @s_culture             = 'EC',
		   @s_date                = @w_fecha_proceso,
		   @s_srv                 = '0',
		   @s_lsrv                = 'CTSSRV',
		   @s_ofi                 = @w_oficina,
		   @s_rol                 = 1,
		   @s_org                 = 'U',
		   @t_trn                 = 111,
		   @i_operacion           = 'I',
		   @i_ente                = @w_ente,
		   @i_direccion           = @w_direccion,
		   @i_valor               = @i_celular,
		   @i_tipo_telefono       = 'C',
		   @i_tipo_telefono_gob   = 'C'
		   
		   if @w_error <> 0 or @@error <> 0 begin
			  select 
			  @w_msg   = case when @w_error is null then 'ERROR EN LA CREACION DEL TELEFONO CELULAR DEL CLIENTE' else null end,
			  @w_error = isnull(@w_error, 219000)   
			  goto ERROR_FIN
		   end

		end
	  
	   end 

		if @w_commit = 'S' begin
			if(@o_msg is null or ltrim(rtrim(@o_msg)) = '' or rtrim(ltrim(@o_msg)) = '|')
			begin
				select @w_fecha_proceso = getdate()
				UPDATE ca_alta_masiva_prosp
				SET am_fecha_carga=@w_fecha_proceso, am_cant_reg_exito = isnull(am_cant_reg_exito,0) + 1
				WHERE am_nombre_archivo = @i_archivo
			end

			commit tran
			select @w_commit = 'N'
		end


	end 

	print 'MENSAJE:'+@o_msg
	select @o_msg = case 
					   when @o_msg is null or ltrim(rtrim(@o_msg)) = '' or rtrim(ltrim(@o_msg)) = '|' then 'REGISTRO PROCESADO CON EXITO.'
					   else @o_msg 
					end
					
	UPDATE ca_alta_masiva_prosp	SET am_estado = 'P'	WHERE am_nombre_archivo = @i_archivo

end
if @i_operacion = 'V'
begin
	select @w_fecha_proceso = getdate()
	if not exists (select 1 from ca_alta_masiva_prosp
		where am_nombre_archivo = @i_archivo and am_estado='P')
	begin
		delete from ca_alta_masiva_prosp where am_nombre_archivo = @i_archivo and am_estado='C' --C:Pendiente
		INSERT INTO ca_alta_masiva_prosp(am_nombre_archivo,am_fecha_carga,am_login,am_total,am_estado,am_cant_reg_exito)
		VALUES (@i_archivo,@w_fecha_proceso,@s_user,@i_total,'C',0) -- C:Pendiente; P:Procesado
	end

	select am_nombre_archivo,am_fecha_carga,am_login,am_cant_reg_exito,am_total
	from ca_alta_masiva_prosp
	where am_nombre_archivo = @i_archivo and am_estado='P'

end

return 0

ERROR_FIN:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
return @w_error

go


