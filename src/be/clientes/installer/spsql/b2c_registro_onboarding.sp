/* ***************************************************************************/
/*   Archivo:              b2c_registro_onboarding.sp                        */
/*   Stored procedure:     sp_b2c_registro_onboarding                        */
/*   Base de datos:        cobis                                             */
/*   Producto:             CLIENTES                                          */
/*   Disenado por:         Sonia Rojas                                       */
/*   Fecha de escritura:   16/Febrero/2022                                   */
/* ***************************************************************************/
/*                              IMPORTANTE                                   */
/* ***************************************************************************/
/*   Este programa es parte de los paquetes bancarios propiedad de           */
/*   "MACOSA", representantes exclusivos para el Ecuador de la               */
/*   "NCR CORPORATION".                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como              */
/*   cualquier alteracion o agregado hecho por alguno de sus                 */
/*   usuarios sin el debido consentimiento por escrito de la                 */
/*   Presidencia Ejecutiva de MACOSA o su representante.                     */
/* ***************************************************************************/
/*                              PROPOSITO                                    */
/* ***************************************************************************/
/*   Este stored procedure inserta personas con datos incompletos            */
/* ***************************************************************************/
/*                            MODIFICACIONES                                 */
/*   FECHA         AUTOR      RAZON                                          */
/*   16-Feb-2022   S. Rojas   Emisión inicial                                */
/*   08-May-2022   ACH        Se agrega la oficina para onboarding 168293F2  */
/*   30-Ago-2022   AIN        Se guardar toda la información del cliente     */ 
/*   30-Sep-2022   ACH        REQ#193221 B2B Grupal, se agrega opc. para b2b */
/*   06-Abr-2023   SRO        REQ#203621                                     */
/* ***************************************************************************/

use cobis
go

IF OBJECT_ID ('dbo.sp_b2c_registro_onboarding') IS NOT null
    DROP PROCEDURE dbo.sp_b2c_registro_onboarding
GO


create proc sp_b2c_registro_onboarding(
   @s_ssn                        int,
   @s_sesn                       int,
   @s_user                       login,
   @s_term                       varchar (32),
   @s_date                       datetime,
   @s_srv                        varchar(30),
   @s_lsrv                       varchar(30)   = null,
   @s_ofi                        smallint      = null,
   @s_rol                        smallint      = null,
   @s_org_err                    char(1)       = null,
   @s_error                      int           = null,
   @s_sev                        tinyint       = null,
   @s_msg                        descripcion   = null,
   @s_org                        char(1)       = null,
   @s_culture                    varchar(15)   = null,
   @t_rty                        char(1)       = null,
   @t_debug                      char(1)       ='N',
   @t_file                       varchar(14)   = null,
   @t_from                       descripcion   = null,
   @t_trn                        int,
   @t_show_version               bit           = 0,     -- Mostrar la version del programa
   @i_celular                    varchar(16)   ,   
   @i_correo                     varchar(254)  = null,
   @i_nombre                     varchar(64)   ,                -- Primer nombre del cliente
   @i_segnombre                  varchar(30)   = null,          -- Segundo nombre
   @i_papellido                  varchar(30)   ,                -- Primer apellido del cliente
   @i_sapellido                  varchar(30)   = null,          -- Segundo apellido del cliente
   @i_fecha_nac                  datetime      = null,          -- Fecha de nacimiento JLI,
   @i_fecha_nac_str              varchar(30)   ,
   @i_entidad_fed_nac            varchar(4)    ,                -- Lugar de naciemiento
   @i_sexo                       varchar(10)   ,                -- Operación I: D - Default
   @i_cedula                     varchar(30)   ,                -- Numero del documento de identificacion (CURP)// corrige el error del instalador de la cob_pac
   @i_ident_tipo                 varchar(10)   = 'CURP',   
   @i_ocr                        varchar(13)   = null,
   @i_numero_emisor              varchar(2)    = null,
   @i_cic                        varchar(9)    = null,
   @i_bio_clave_lector           varchar(18)   = null,
   @i_bio_huella_dactilar        char(1)       = null,
   @i_bio_emission_date          varchar(4)    = null,
   @i_bio_register_date          varchar(4)    = null,
   ---------------------------------------------------------------------------------------------------------------------------------------------------------------
   @i_id_expediente              varchar(30)   = null,
   @i_latitud_pws                varchar(20)   = null,
   @i_longitud_pws               varchar(20)   = null,
   @i_fecha_long_lat             datetime      = null,
   --------------------------------------------------------------------------------------
   @i_consent_state              char(1) = 'S' ,
   --------------------------------------------------------------------------------------
   @i_cod_cliente                int = 0       ,
   @i_modo                       int = 0       ,
   --------------------------------------------------------------------------------------
   @i_filial                     tinyint       = 1,           -- Codigo de la filial
   @i_oficina                    smallint      = null,        -- Codigo de la oficina
   @i_tipo_ced                   char(4)       = 'CURP',      -- Tipo del documento de identificacion   
   @i_oficial                    smallint      = 0,           -- Codigo del oficial asignado al cliente
   @i_estado                     char(1)       = 'P',         -- Prospecto  
   @i_cliente_casual             char(2)       = 'GC',        -- GC Cliente Casual
   --------------------------------------------------------------------------------------
   --Caso: 193221   
   @i_fecha_simulacion           datetime      = null,    
   @i_canal                      int           = null,
   @i_monto_sol                  money         = null,
   @i_monto_cuota                money         = null,
   @i_plazo                      int		   = null,
   @i_tplazo                     varchar(10)   = null, -- frecuencia
   @i_toperacion			     varchar(10)   = null, 
   @i_moneda                     smallint      = null,
   @i_tasa                       float         = null,
   @i_promocion                  char(1)       = null, 
   @i_subtipo                    varchar(50)   = null,

   ---------------------------------------------------------------------------------------------------------------------------------------------------------------
   @i_tipo_autorizacion          varchar(1)    = null,
   @i_descripcion_aut            varchar(100)  = null,
   @i_fecha_auto                 datetime      = null,

   ---------------------------------------------------------------------------------------------------------------------------------------------------------------
   @o_ente                       int           = null  out,   -- Codigo secuencial asignado al cliente
   @o_direccion                  int           = null  out,  
   @o_telefono                   int           = null  out,
   @o_li_negra                   char(1)       = 'N'   out,
   @o_neg_file                   char(1)       = 'N'   out,
   @o_enrol_estatus              char(1)       = 'S'   out,
   @o_rfc                        varchar(30)   = 'N'   out,
   @o_nomlar                     varchar(254)  = 'N'   out
)
as
declare 
@w_sp_name             descripcion,
@w_return              int,
@w_nacionalidad        int,
@w_mala_referencia     char(1),
@w_tipo                char(2),
@w_error               int,-- = 103414,
@w_secuencial          int = 3,
@w_tipo_vinculacion    varchar(10),
@w_commit              char(1) = 'S',
@w_ofi                 int,
@w_nac_aux             varchar(10),
@w_en_banco            varchar(20),
@w_tam_banco           int,
@w_ciudad_nac          descripcion,
@w_edad_min            tinyint,
@w_edad_max            tinyint,
@w_anios_edad          smallint,
@w_nombre_completo     varchar (254),
@w_nombres             varchar(255),
@w_msg                 varchar(1000),
@w_rfc                 varchar(30),
@w_resultado_ng        int,
@w_resultado_ln        int,
@w_cod_geo             varchar(5),
@w_fecha_proceso       datetime,
@w_tipo_servicio       varchar(5),
@w_status              varchar(10),
@w_ente_virtual        int,
@w_canal               int,
@w_direccion           int,
@w_canal_desc          varchar(256)


if @t_show_version = 1
begin
      print 'Stored procedure sp_b2c_registro_onboarding, Version 4.0.0.25'
      return 0
end

select @w_sp_name = 'sp_b2c_registro_onboarding'

--Inicio Guardado de Nombres sin tildes
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
--Fin 

----* PorCaso#193221 -- por defecto el canal-->>b2c_digital(onboarding): 3 -->> b2b: 20 -->> b2c: 8
select @w_canal = ca_canal from cl_canal where ca_nombre = 'b2b' and ca_estado = 'V'

-- Fecha de nacimiento datetime de varchar 
if @i_canal = @w_canal  
begin
    select @i_fecha_nac = convert(datetime, @i_fecha_nac_str, 103)	
end

if (@i_promocion = 'S') 
    select @i_tasa = pa_float from cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico in ('VTSPRO')
else if (@i_promocion = 'N') 
    select @i_tasa = pa_float from cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico in ('VTNPRO')

select @w_tam_banco = isnull(pa_int,8) --Longitud máxima de buc onboarding
from cobis..cl_parametro
where pa_nemonico = 'TMBUCO'

if @w_tam_banco is null
begin
    select @w_tam_banco = 8
end

select  @w_nacionalidad = pa_smallint --Código País
from 	cl_parametro
where pa_nemonico = 'PAIS'

select @w_tipo = pa_char  -- Tipo de persona natural
from cl_parametro
where pa_producto ='CLI'
and pa_nemonico ='VGTPNA'

select @w_edad_min = pa_tinyint  --Edad minima
from cl_parametro 
where pa_nemonico = 'MDE'
and   pa_producto = 'ADM'

select @w_edad_max = pa_tinyint --Edad maxima
from   cl_parametro 
where pa_nemonico ='EMAX'
and   pa_producto = 'ADM'

select @w_tipo_vinculacion = codigo 
from cobis..cl_catalogo
where valor = 'CLIENTE'
and tabla in (select codigo from cobis..cl_tabla where tabla = 'cl_relacion_banco')

SELECT @w_nac_aux = b.codigo FROM 
cobis..cl_tabla a,cobis..cl_catalogo b
WHERE a.codigo = b.tabla
AND a.tabla = 'cl_nacionalidad'
AND b.valor = 'MEXICANA'

if @t_trn <> 1721 begin
   /* Codigo de transaccion invalido */
   select @w_error = 101147
   goto ERROR
end

select @o_enrol_estatus = 'S'

if @i_modo  = 0
begin

    /* INICIO DE LA ATOMICIDAD DE LA TRANSACCION */
    if @@trancount = 0 begin
      select @w_commit = 'S'
      begin tran
    end
   
    select @w_mala_referencia = 'N'       
	
	-------------------------------------------------------------------------------------------
    -- OFICIAL Y OFICINA B2B - REQ#193221
    -------------------------------------------------------------------------------------------
    if @i_canal = @w_canal  
    begin
	    select @i_oficial = oc_oficial,       
               @i_oficina = fu_oficina
        from   cc_oficial, cl_funcionario 
        where  oc_funcionario = fu_funcionario 
        and    fu_login   = @s_user	
	end
	else
	begin 
	    /*Oficial onboarding*/
        select @i_oficial = oc_oficial,       
               @i_oficina = fu_oficina
        from   cc_oficial, cl_funcionario 
        where  oc_funcionario = fu_funcionario 
        and    fu_login   = 'onboarding'
	end 
	    
    --select @i_oficina = of_oficina from cl_oficina where of_nombre = 'Oficina Virtual'
    
    /* Verificar que exista el oficial indicado */
    if @i_oficial <> 0
    begin
       if not exists (select oc_oficial from cc_oficial where oc_oficial = @i_oficial) begin
         select @w_error = 101036
         goto ERROR
       end
    end       

    exec sp_cseqnos
    @t_debug      = @t_debug,
    @t_file       = @t_file,
    @t_from       = @w_sp_name,
    @i_tabla      = 'cl_ente',
    @o_siguiente  = @o_ente out
        
    if exists(SELECT 1 from cobis..cl_ente_aux, cobis..cl_telefono where ea_ente = te_ente and ea_onboarding= 'S' and te_valor = @i_celular)
    begin
        select @w_error = 70011019 -- El número de celular ingresado ya existe, por favor ingrese un nuevo número
        goto ERROR
    end
    
    --LGU-fin 2017-06-15 creacion del CURP y RFC
    if exists (select 1 from cl_ente where en_ced_ruc = @i_cedula ) begin
		select @w_msg = en_ente from cl_ente where en_ced_ruc = @i_cedula
       select @w_error = 70011007, -- Ya existe una persona con esta identificación. CURP
			  @w_msg = 'Esta CURP ya esta registrada, favor de capturar una nueva.' + ' ID Cobis: ' + @w_msg
       goto ERROR
    end
    
    if ( @i_nombre = null or @i_papellido = null or @i_fecha_nac = null or @i_sexo = null or @i_cedula = null ) begin
       select @w_error = 101113
       goto ERROR
    end
    
    if @i_cliente_casual <> 'S' begin
       select @w_anios_edad = datediff(yy, @i_fecha_nac, fp_fecha) from ba_fecha_proceso
      if ((@w_anios_edad < @w_edad_min) or (@w_anios_edad > @w_edad_max)) begin
         select @w_error = 70011021
    	 goto ERROR/* 'Falta fecha de nacimiento'*/      
       end
    end
   
    select @w_en_banco = convert(varchar,@o_ente)
    
    select @w_en_banco = convert(varchar(50),replicate ('0',(@w_tam_banco - len(ltrim(rtrim(@w_en_banco))))) + convert(varchar,ltrim(rtrim(@w_en_banco))))
    
    if( @w_en_banco is null)
    begin
        select @w_en_banco = convert(varchar,@o_ente)
    end

   if @i_canal != 20 -- b2b=20(cobis..cl_canal)
   begin
	   select @w_ciudad_nac =  eq_valor_cat
	   from cob_conta_super..sb_equivalencias 
	   where eq_catalogo    = 'ENT_FED' 
	   and eq_valor_arch    = (select eq_valor_cat 
							   from cob_conta_super..sb_equivalencias
							   where eq_catalogo = 'ENT_CURP' 
							  and eq_valor_arch = @i_entidad_fed_nac)
	end
	else
	begin
		select @w_ciudad_nac =  @i_entidad_fed_nac
	end
	
   -- Genero
   if @i_canal != @w_canal -- b2b = 20(cobis..cl_canal)
   begin 
       select @i_sexo = case when @i_sexo = 'H' then 'M' else 'F' end 
   end
   
   select @w_nombre_completo = @i_nombre + isnull(' '+@i_segnombre,'') + ' ' + @i_papellido + ' ' + isnull(@i_sapellido, '')
   select @w_nombres         = @i_nombre + isnull(' '+@i_segnombre,'')

   -- select @w_rfc =  substring(@i_cedula, 1, 10)
   exec @w_return = cobis..sp_generar_curp
   @i_primer_apellido 	= @i_papellido,
   @i_segundo_apellido = @i_sapellido,
   @i_nombres 			= @w_nombres,
   @i_sexo 			= @i_sexo,
   @i_fecha_nacimiento = @i_fecha_nac, --'01/21/1987',
   @i_entidad_nacimiento = @w_ciudad_nac, --'30',
   @o_mensaje 			= @w_msg out,
   @o_rfc 				= @w_rfc OUT
   
   if @w_return <> 0 begin 
   	select @w_error = @w_return
   	goto ERROR 
   end
   
    insert into cl_ente (
    en_ente,      en_nombre,          en_subtipo,           p_tipo_persona,
    en_filial,    en_oficina,         en_ced_ruc,           en_fecha_crea,        
    en_fecha_mod, en_oficial,         en_retencion,         en_mala_referencia,   
    en_tipo_ced,  p_s_nombre,         p_p_apellido,         p_s_apellido,         
    p_sexo,       p_fecha_nac,        en_nomlar,            p_estado_civil,       
    en_rfc,       en_nit,             en_nacionalidad,      en_tipo_vinculacion,
   en_nac_aux,   p_pais_emi,         en_banco, p_depa_nac)
    values  
    (@o_ente,     @i_nombre,          'P',                  @w_tipo,
    @i_filial,    @i_oficina,         @i_cedula,            @s_date,              
    @s_date,      @i_oficial,         'N',                  @w_mala_referencia,   
    @i_tipo_ced,  @i_segnombre,       @i_papellido,         @i_sapellido,         
   @i_sexo,      @i_fecha_nac,       @w_nombre_completo,                 'SO',                  
   @w_rfc,       @w_rfc,             @w_nacionalidad,      @w_tipo_vinculacion,
   @w_nac_aux,   @w_nacionalidad,    null , @w_ciudad_nac)
    
    /* si no se pudo insertar, error */
    if @@error <> 0
    begin
       select @w_error = 7300004 --Error en la creación del cliente
       goto ERROR
    end
    
    insert into cl_ente_aux( 
    ea_ente, ea_estado, ea_ced_ruc, ea_nit, ea_onboarding,  ea_consulto_renapo )
    values(   
    @o_ente, @i_estado, @i_cedula,  @w_rfc, 'S',           'S')
    
    if @@error <> 0
    begin
       select @w_error = 7300004 --Error en la creación del cliente
       goto ERROR
    end
    
    insert into ts_persona_prin ( 
    secuencia,                  tipo_transaccion,      clase,               fecha,               usuario,
    terminal,                   srv,                   lsrv,                persona,             nombre,
    p_apellido,                 s_apellido,            sexo,                cedula,              tipo_ced,                   
    pais,                       estado_civil,          tipo,                filial,              oficina,                    
    fecha_nac,                  grupo,                 oficial,             fecha_mod,           
    secuen_alterno,             tipo_vinculacion)
    values (
    @s_ssn,                     @t_trn,                'N',                   @s_date,           @s_user,
    @s_term,                    @s_srv,                @s_lsrv,               @o_ente,           @i_nombre,
    @i_papellido,               @i_sapellido,          @i_sexo,               @i_cedula,         @i_tipo_ced,                
    null,                       'S',                   @w_tipo,               @i_filial,         @i_oficina,                 
    @i_fecha_nac,               null,                  @i_oficial,            @s_date,
    @w_secuencial,              @w_tipo_vinculacion)
    
    if @@error <> 0 begin
       select @w_error = 103005 -- Error en creación de transacción de servicio
       goto ERROR
    end
    
   ----*-----------------------------------------------------------------------------------*--
   ----* PorCaso#193221 -- por defecto el canal-->>b2c_digital(onboarding): 3 -->> b2b: 20 -->> b2c: 8 -->>   
   ----*-----------------------------------------------------------------------------------*--	
    if (@i_canal = @w_canal ) begin
        insert into cob_cartera..ca_datos_simulacion ( 
         ds_ente,                 ds_fecha,                  ds_canal,                     ds_monto_sol,
         ds_tplazo,               ds_plazo,                  ds_cuota,                     ds_moneda, 
         ds_tasa,                 ds_toperacion,             ds_fecha_simul,               ds_login,
         ds_subtipo)
        
        values (
         @o_ente,                 getdate(),                 @i_canal,                     @i_monto_sol,           
         @i_tplazo,               @i_plazo,                  @i_monto_cuota,               @i_moneda,           
         @i_tasa,                 @i_toperacion,             @i_fecha_simulacion,          @s_user,
         @i_subtipo)                
         
	 	if @@error <> 0 
         begin
            select @w_error = 70076 -- Error al registrar información de la simulación
            goto ERROR
         end         
    end

   ----*-----------------------------------------------------------------------------------*--
   ----* REALIZA EL REGISTRO DEL HISTORICO DE IDENTIFICACIONES
   ----* GDE -- CONTROL DE CAMBIOS CLIENTES
   ----*-----------------------------------------------------------------------------------*--
   
   if not exists (select 1 from cl_registro_identificacion where ri_ente = @o_ente) 
   begin
      exec @w_return    = sp_b2c_registra_ident
      @s_user           = @s_user,
      @t_trn            = 1037,
      @i_operacion      = 'I',
      @i_ente           = @o_ente,
      @i_tipo_iden      = 'CURP',
      @i_identificacion = @i_cedula
      
      if @w_return <> 0 
      begin
         select @w_error = @w_return
         goto ERROR 
      end
   end
   
   if @w_commit = 'S' 
   begin
      commit tran
      select @w_commit = 'N'
   end
   
   if exists (select 1 from cl_ente_bio where eb_ente = @o_ente) 
   begin
   
   
      if @i_ident_tipo = 'INE' and @i_cic is null begin
	     select @w_error = 103400
         goto ERROR
	  end
	  else if @i_ident_tipo = 'IFE' and (@i_ocr is null or @i_numero_emisor is null or @i_bio_clave_lector is null) begin
         select @w_error = 103401
         goto ERROR
      end

      update cl_ente_bio set 
      eb_tipo_identificacion = @i_ident_tipo,
      eb_cic                 = @i_cic,      
      eb_ocr                 = @i_ocr,      
      eb_nro_emision         = @i_numero_emisor,
      eb_clave_elector       = @i_bio_clave_lector,      
      eb_sin_huella_dactilar = @i_bio_huella_dactilar,
      eb_anio_registro       = isnull(@i_bio_register_date, (Select eb_anio_registro from cl_ente_bio where eb_ente = @o_ente)), 
      eb_anio_emision        = isnull(@i_bio_emission_date,(Select eb_anio_emision from cl_ente_bio where eb_ente = @o_ente))
      where eb_ente          = @o_ente 
      
      if @@error <> 0 
      begin
          select @w_error = 103402
          goto ERROR
      end
      
	  print 'llego'
	  
      insert into cl_ente_bio_his
      (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
      ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
      ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
      ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
      ebh_srv,                             ebh_lsrv)
      values                               
      (@s_ssn,                             @o_ente,               @i_ident_tipo,  @i_cic, 	         
      @i_ocr,                          @i_numero_emisor, @i_bio_clave_lector, 	    isnull(@i_bio_huella_dactilar,'N'),  
      getdate(),                           null,                  null,                        null,
      getdate(),                           'I',                   @s_user,                     @s_term,
      @s_srv,                              @s_lsrv)
      	
      if @@error <> 0 
      begin
        select @w_error = 103402
        goto ERROR
      end
      
   end else 
   begin
       if @i_ident_tipo is not null and @i_ident_tipo  in ('INE', 'IFE') 
   	begin
          --Secuencial
           exec 
           @w_error     = sp_cseqnos
           @t_debug     = 'N',
           @t_file      = null,
           @t_from      = @w_sp_name,
           @i_tabla     = 'cl_ente_bio',
           @o_siguiente = @w_secuencial out
           
           if @w_error <> 0 
   		begin
              goto ERROR
           end
          
          insert into cl_ente_bio
          (eb_secuencial, eb_ente, eb_tipo_identificacion,     eb_cic,      eb_ocr,      eb_nro_emision,        eb_clave_elector,      eb_sin_huella_dactilar,             eb_fecha_registro,
		   eb_anio_registro, eb_anio_emision)
          values  
          (@w_secuencial, @o_ente, @i_ident_tipo, @i_cic,  @i_ocr,  @i_numero_emisor, @i_bio_clave_lector,  isnull(@i_bio_huella_dactilar,'N'), getdate(),
            isnull(@i_bio_register_date, year(getdate())),   isnull(@i_bio_emission_date,year(getdate())))
   	   
          if @@error <> 0 
   	   begin
              select @w_error = 103402
              goto ERROR
          end
          
          insert into cl_ente_bio_his
          (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
          ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
          ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
          ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
          ebh_srv,                             ebh_lsrv)
          values                               
          (@s_ssn,                             @o_ente,               @i_ident_tipo,  @i_cic, 	         
          @i_ocr,                          @i_numero_emisor, @i_bio_clave_lector, 	    isnull(@i_bio_huella_dactilar,'N'),  
          getdate(),                           null,                  null,                        null,
          getdate(),                           'I',                   @s_user,                     @s_term,
          @s_srv,                              @s_lsrv)
   	   
          if @@error <> 0 
   	   begin
            select @w_error = 103402
            goto ERROR
          end      
      end       
   end
   
   -- Guardado del expediente Id con el que se dio de alta al cliente
   if @i_canal != @w_canal  
   begin
     if not exists (select 1 from cobis..cl_onboard_id_ext where oi_ente = @o_ente )
     begin
        insert into cobis..cl_onboard_id_ext 
        ( oi_ente, oi_id_expediente,oi_fecha_registro)
        values
        ( @o_ente , @i_id_expediente, getdate())
        
        if @@error <> 0 begin
           select @w_error = 103415
           goto ERROR
        end 
     end else 
     begin
        update cobis..cl_onboard_id_ext 
        set oi_id_expediente  = @i_id_expediente,
            oi_fecha_registro = getdate()
        where oi_ente = @o_ente
     end
   end
   
   -------------------------------------------------------------------------------------------
   -- GUARDAR GEOLOCALIZACIÓN DE PANTALLA TOMA DE CONTRASEÑA
   -------------------------------------------------------------------------------------------
   if @i_canal != @w_canal  
   begin
     select @w_cod_geo = 'GENIP'
     select @w_tipo_servicio = 'POST'
     select @w_status = 'Aceptada'
     
     insert into cob_bvirtual..bv_geolocaliza_operacion(
                 go_login,         go_fecha,     go_tipo_tran,   go_ente,    go_tipo_serv,
                 go_aplicativo,    go_longitud,  go_latitud,     go_ssn ,    go_estado ,    go_fecha_proceso )
                 values(
                 @o_ente,        getdate(),         @w_cod_geo,       @o_ente  ,   @w_tipo_servicio,
                 'TUIIOMOVIL',   @i_longitud_pws,   @i_latitud_pws,   @s_ssn,      @w_status ,       @i_fecha_long_lat
                 )
     if @@error <> 0 
     begin
        select @w_error = 1802147
        goto ERROR
     end
   end
   
   -------------------------------------------------------------------------------------------
   -- GUARDAR CORREO ELECTRONICO
   -------------------------------------------------------------------------------------------
   if @i_canal != @w_canal  
   begin
     EXEC @w_return = sp_b2c_mantenimiento_direccion
     @s_ssn             = @s_ssn,
     @s_date            = @s_date,
     @t_trn             = 1723,
     @i_ente            = @o_ente,
     @i_descripcion     = @i_correo,
     @i_tipo            = 'CE'
     
     if @w_return <> 0
     begin
        select @w_error = @w_return
     goto ERROR
     end
   end
   
   -------------------------------------------------------------------------------------------
   -- GUARDAR DIRECCION  Y CELULAR B2B - REQ#193221
   -------------------------------------------------------------------------------------------
   if @i_canal = @w_canal  
   begin
     select @w_canal_desc = upper(ca_nombre) from cobis..cl_canal where ca_canal = @i_canal and ca_estado = 'V' 
	 
	 if not exists (select 1 from cobis..cl_direccion where di_ente = @o_ente and di_tipo = 'RE')
	 begin
        exec @w_return = sp_b2c_mantenimiento_direccion
        @s_ssn             = @s_ssn,
        @s_date            = @s_date,
	    @s_ofi             = @s_ofi,
	    @s_user            = @s_user,
	    @s_term            = @s_term,
	    @s_srv             = @s_srv,
	    @s_lsrv            = @s_lsrv,
        @t_trn             = 1723,
        @i_ente            = @o_ente,
        @i_tipo            = 'RE',
	    @i_canal           = @w_canal_desc,
	    @i_operacion       = 'I',
	    @i_principal       = 'S',
	    @o_direccion       = @w_direccion out
        
        if @w_return <> 0
        begin
           select @w_error = @w_return
           goto ERROR
        end  
     end
     else
     begin 
	    if exists (select 1 from cobis..cl_direccion where di_ente = @o_ente and di_tipo = 'RE' and di_principal = 'S')
		begin 
		  select @w_direccion = di_direccion 
		  from cobis..cl_direccion 
	      where di_ente = @o_ente 
		  and di_tipo = 'RE'
		  and di_principal = 'S'
		end
		else
		begin 
		  select top 1 @w_direccion = di_direccion 
		  from cobis..cl_direccion 
	      where di_ente = @o_ente 
		  and di_tipo = 'RE'
		  order by di_direccion asc
		end	    
     end
	 
	 print '@w_direccion: ' + convert(varchar, @w_direccion)
	 
	 exec @w_return = cobis..sp_telefono
     @s_ssn             = @s_ssn,
     @s_date            = @s_date,
	 @s_user            = @s_user,
	 @s_term            = @s_term,
	 @s_srv             = @s_srv,
	 @s_lsrv            = @s_lsrv,
	 @s_ofi             = @s_ofi,
     @t_trn             = 111,
     @i_ente            = @o_ente,
	 @i_direccion       = @w_direccion,
	 @i_valor           = @i_celular,
     @i_tipo_telefono   = 'C',
	 @i_canal           = @w_canal_desc,
	 @i_operacion       = 'I'
     
     if @w_return <> 0
     begin
        select @w_error = @w_return
     goto ERROR
     end
	 
	 select @o_direccion = @w_direccion
	 
	 select @o_telefono = te_secuencial
     from cobis..cl_telefono 
     where te_ente = @o_ente
     and te_direccion = @w_direccion
     and te_valor = @i_celular
     and te_tipo_telefono = 'C' 
	 
	 print '@o_direccion: ' + convert(varchar, @o_direccion)	
	 print '@o_telefono: ' + convert(varchar, @o_telefono)	
   end
   
   
   -------------------------------------------------------------------------------------------
   -- GUARDAR CELULAR VERIFICADO - REQ#193221
   -------------------------------------------------------------------------------------------
   if @i_canal = @w_canal  
   begin
        if not exists (select 1 from cobis..cl_verif_co_tel 
                       where ct_valor = ltrim(rtrim(@i_celular)) 
                       and   ct_tipo  = 'C' 
                       and   ct_ente  = @o_ente
			           and   ct_verificacion = 'S') 
		begin
			print 'sp_b2c_registro_onboarding -->> Ingresa Verificacion'
		    insert into cobis..cl_verif_co_tel
		           (ct_ente, ct_direccion, ct_valor,   ct_tipo,              ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
            values (@o_ente, @o_direccion, @i_celular, @i_tipo_autorizacion, 'S',             @w_canal, @i_fecha_auto, getdate()) 
		end
   end
   
   -------------------------------------------------------------------------------------------
   -- VERIFICACIóN DE ENROLAMIENTO DEL CLIENTE
   -------------------------------------------------------------------------------------------
   select @w_ente_virtual =en_ente from cob_bvirtual..bv_ente where en_ente_mis =  @o_ente

   if exists (select 1 from cob_bvirtual..bv_ente where en_ente_mis =  @o_ente)
   begin
      select @o_enrol_estatus = 'N' 
   end
   
   if exists (select 1 from cob_bvirtual..bv_login where lo_ente = @w_ente_virtual)
   begin
      select @o_enrol_estatus = 'N' 
   end
   
   if exists (select 1 from cob_bvirtual..bv_info_device where in_ente_cli = @w_ente_virtual)
   begin
      select @o_enrol_estatus = 'N' 
   end   
   -------------------------------------------------------------------------------------------
   -- EVALUACIóN DEL PROSPECTO EN LISTAS NEGRAS Y NEGATIVE FILE
   -------------------------------------------------------------------------------------------
   -- Listas Negras
   -- 1 no esta en listas negras / 3 esta en listas negras
   EXEC cob_credito..sp_li_negra_cliente
   @i_ente      = @o_ente ,
   @o_resultado = @w_resultado_ln OUT
   
   if @w_resultado_ln = 3
   begin 
      select @o_li_negra = 'S'
   end else
   begin
      -- 1 no esta en negative file / 3 esta en negative file   
      -- Negative File
      EXEC cob_credito..sp_negative_file
      @i_ente      = @o_ente ,
      @o_resultado = @w_resultado_ng OUT
      
      if @w_resultado_ng = 3
      begin 
         select @o_neg_file = 'S'  
      end
   end
   
   --Inicio Valores por Defecto cuando esta en listas negras o negative file
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	
   if @o_li_negra = 'S' or @o_neg_file = 'S' 
   begin 
       update cobis..cl_ente_aux 
   	   set ea_nivel_riesgo_cg      = 'F',
   	       ea_puntaje_riesgo_cg    = 'S/C',
   	       ea_fecha_evaluacion     = @w_fecha_proceso,
   	       ea_nivel_riesgo_1       = 'F',
           ea_nivel_riesgo_2       = 'LN',
           ea_tipo_calif_eva_cli   = null
   	   where ea_ente = @o_ente
   	
   	   update cobis..cl_ente 
   	   set p_calif_cliente = 'ROJO'          
   	   where en_ente = @o_ente
   	   and en_subtipo = 'P'
   end
   --Fin Valores por Defecto cuando esta en listas negras o negative file
   
   select @o_rfc = @w_rfc, @o_nomlar = @w_nombre_completo
   
end else if @i_modo = 1 and @i_cod_cliente <> 0
begin
   --Se ejecuta el sp de actualización
   EXEC @w_return = sp_b2c_mantenimiento_persona
   @s_ssn                         = @s_ssn,  
   @s_user                        = @s_user, 
   @s_term                        = @s_term ,
   @s_date                        = @s_date ,
   @t_trn                         = 1722,
   @s_srv                         = @s_srv   , 
   @i_ente                        = @i_cod_cliente,
   @i_nombre                      = @i_nombre,
   @i_papellido                   = @i_papellido,
   @i_sapellido                   = @i_sapellido,
   @i_segnombre                   = @i_segnombre,
   @i_filial                      = @i_filial,
   @i_oficina                     = @i_oficina,
   @i_cedula                      = @i_oficina,
   @i_oficial                     = @i_oficina,
   @i_fecha_nac                   = @i_oficina,
   @i_cliente_casual              = @i_oficina,
   @i_sexo                        = @i_sexo,
   @i_entidad_fed_nac             = @i_entidad_fed_nac,
   @i_bio_tipo_identificacion     = @i_ident_tipo,
   @i_bio_cic                     = @i_cic,
   @i_bio_ocr                     = @i_ocr,
   @i_bio_numero_emision          = @i_numero_emisor,
   @i_bio_clave_lector            = @i_bio_huella_dactilar,
   @i_bio_huella_dactilar         = @i_bio_huella_dactilar,
   @i_id_expediente               = @i_id_expediente,
   @i_latitud_pws                 = @i_latitud_pws,   
   @i_longitud_pws                = @i_longitud_pws,  
   @i_fecha_long_lat              = @i_fecha_long_lat,
   @i_operacion                   = 'U'
   
   if @w_return <> 0
   begin
      select @w_error = @w_return
	  goto ERROR
   end
   
   -------------------------------------------------------------------------------------------
   -- ACTUALIZACION CORREO ELECTRONICO
   -------------------------------------------------------------------------------------------
   if @i_canal != @w_canal  
   begin
     EXEC @w_return = sp_b2c_mantenimiento_direccion
     @s_ssn             = @s_ssn,
     @s_date            = @s_date,
     @t_trn             = 1723,
     @i_ente            = @i_cod_cliente,
     @i_descripcion     = @i_correo,
     @i_tipo            = 'CE',
     @i_operacion       = 'U'
     
     if @w_return <> 0
     begin
        select @w_error = @w_return
	    goto ERROR
     end
   end
   
   -------------------------------------------------------------------------------------------
   -- VERIFICACIóN DE ENROLAMIENTO DEL CLIENTE
   -------------------------------------------------------------------------------------------
   select @w_ente_virtual =en_ente from cob_bvirtual..bv_ente where en_ente_mis =  @o_ente

   if exists (select 1 from cob_bvirtual..bv_ente where en_ente_mis =  @i_cod_cliente)
   begin
      select @o_enrol_estatus = 'N' 
   end
   
   if exists (select 1 from cob_bvirtual..bv_login where lo_ente = @w_ente_virtual)
   begin
      select @o_enrol_estatus = 'N' 
   end
   
   if exists (select 1 from cob_bvirtual..bv_info_device where in_ente_cli = @w_ente_virtual)
   begin
      select @o_enrol_estatus = 'N' 
   end
   -------------------------------------------------------------------------------------------
   -- EVALUACIóN DEL PROSPECTO EN LISTAS NEGRAS Y NEGATIVE FILE
   -------------------------------------------------------------------------------------------
   -- Listas Negras
   -- 1 no esta en listas negras / 3 esta en listas negras
   EXEC cob_credito..sp_li_negra_cliente
   @i_ente      = @o_ente ,
   @o_resultado = @w_resultado_ln OUT
   
   if @w_resultado_ln = 3
   begin 
      select @o_li_negra = 'S'
   end else
   begin
      -- 1 no esta en negative file / 3 esta en negative file   
      -- Negative File
      EXEC cob_credito..sp_negative_file
      @i_ente      = @o_ente ,
      @o_resultado = @w_resultado_ng OUT
      
      if @w_resultado_ng = 3
      begin 
         select @o_neg_file = 'S'  
      end
   end
   
   --Inicio Valores por Defecto cuando esta en listas negras o negative file
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
	
   if @o_li_negra = 'S' or @o_neg_file = 'S' 
   begin 
       update cobis..cl_ente_aux 
   	   set ea_nivel_riesgo_cg      = 'F',
   	       ea_puntaje_riesgo_cg    = 'S/C',
   	       ea_fecha_evaluacion     = @w_fecha_proceso,
   	       ea_nivel_riesgo_1       = 'F',
           ea_nivel_riesgo_2       = 'LN',
           ea_tipo_calif_eva_cli   = null
   	   where ea_ente = @i_cod_cliente
   	
   	   update cobis..cl_ente 
   	   set p_calif_cliente = 'ROJO'          
   	   where en_ente = @i_cod_cliente
   	   and en_subtipo = 'P'
   end
   --Fin Valores por Defecto cuando esta en listas negras o negative file

	select @o_rfc = en_rfc, @o_nomlar = en_nomlar from cobis..cl_ente where en_ente = @i_cod_cliente
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
@i_num   = @w_error,
@i_msg   = @w_msg


return @w_error

go
