/************************************************************************/
/*  Archivo:            rerelctacan.sp                                  */
/*  Stored procedure:   sp_relacion_cta_canal                           */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Canales                                         */
/*  Disenado por:       Igmar Berganza                                  */
/*  Fecha de escritura: 09-Ago-2013                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Stored Procedure para realizar el mantenimiento de la relacion      */
/*  entre cuentas corrientes y ahorros con canales                      */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR                        RAZON                  */
/*  Dic 02/2015    luisa Bernal   Actualización celular REQ-543          */
/************************************************************************/
USE cob_remesas
go
if exists (select 1 from sysobjects where name = 'sp_relacion_cta_canal')
   drop proc sp_relacion_cta_canal
go
create proc sp_relacion_cta_canal (
   @s_ssn	             int             = null,
   @s_date	             datetime        = null,
   @s_ofi	             smallint        = null,
   @s_srv	             varchar(30)     = null,
   @s_user	             varchar(30)     = null,
   @s_term	             varchar(10)     = null,
   @s_rol	             int             = null,      
   @t_corr               char(1)         = 'N',
   @t_ssn_corr           varchar(12)     = null,  -- Secuencia de transaccion a reversar
   @t_trn    		     int 		     = null,  
   @t_show_version bit    = 0,
   @i_producto           int             = 4,
   @i_operacion  	     char(1)		 = null,
   @i_cta                varchar(16)     = null,
   @i_cliente            int             = null,
   @i_ced_ruc            numero          = null,
   @i_tel_celular        varchar(15)     = null,
   @i_tel_celular_old    varchar(15)     = null,
   @i_tipo_operador_old  varchar(10)     = null,
   @i_tarj_debito        varchar(30)     = null,
   @i_confir_tarj_debito varchar(30)     = null,
   @i_canal              varchar(6)      = null,
   @i_motivo             varchar(50)     = null,
   @i_estado             char(1)         = null,
   @i_costo              money           = 0,     -- Costo transaccion
   @i_tipo_id            varchar(10)     = null,  -- Tipo de identificacion
   @i_identificacion     varchar(16)     = null,  -- Numero de identificacion
   @i_num_producto       varchar(16)     = null,  -- Numero de producto
   @i_adquiriente        int             = null,  -- Código de la entidad adquiriente
   @i_establecimiento    smallint        = null,  -- Establecimiento - Cod Corresponsal
   @i_es_batch           char(1)         = 'N',
   @i_valor              int             = null,
   @i_rbm_user           varchar(20)     = null,
   @i_prd_orig           varchar(20)     = null,
   @i_codigo		     varchar(10)     = null,   -- Req. 371 Codigo para manejar el catalogo de exclusion Prod Banc
   @i_subtipo            char(3)         = null,   -- Req. 443 Subtipos de Tarjetas
   @i_tipo_operador      varchar(10)     = null    -- Req. 453 Tipo de Operador Celular
   )
as
declare

@w_sp_name          varchar(32),
@w_commit		    char(1),
@w_error		    int,
@w_mensaje          varchar(254),
@w_error_ws         char(1),
@w_estado           char(1),
@w_return			int,
@w_secuencial       int,
@w_moneda         	tinyint,
@w_transaccion	    int,
@w_en_ced_ruc       varchar(13),
@w_tipo_ced         varchar(10),
@w_codigo           int = 0,
@w_codigo_enrol     varchar(10) = 'ERROR',
@w_ced_ruc          varchar(30)  = null,
@w_nomlar           varchar(150) = null,
@w_apellidos        varchar(150) = null,
@w_num_ref          varchar(10)  = null,
@w_num_autoriza     varchar(10)  = null,
@w_nombres          varchar(20)  = null,
@w_nomcorto         varchar(20)  = null,
@w_direccion        varchar(80)  = null,
@w_dpto             smallint     = null,
@w_ind_ciudad       char(1)      = null,
@w_telefono         varchar(16)  = null,
@w_email            varchar(80)  = null,
@w_actividad        varchar(10)  = null, 
@w_origen_ing       varchar(10)  = null,
@w_ciudad           int          = null, 
@w_p_apellido       varchar(20)  = null, 
@w_s_apellido       varchar(20)  = null,
@w_motivo           varchar(50)  = null,
@w_motivo_bloq      varchar(3)   = null, -- Req. 371 Motivo de bloqueo reexpedicion IB 29/01/2014
@w_canal            varchar(6)   = null,
@w_tipo_identi      varchar(10)  = null,
@w_binbmi           varchar(10)  = null,
@w_cliente          int          = null,
@w_num_prod         varchar(16)  = null,
@w_valor            varchar(30)  = null,  -- Req. 371 Codigo para manejar el catalogo de exclusion Prod Banc
@w_subtipo          char(3)      = null,   -- Req. 443 Subtipo tarjeta debito
@w_act_cel          char(1)      = 'N',    --Req  543- Bandera actualizacion celular TD
/********  MIGRACION CTS  **************/
@w_version_cts_trn  varchar(30),
@w_version_cts_base varchar(30)  

--Parametro de version base cts
select @w_version_cts_base = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'VCTSB'

if @w_version_cts_base is null begin
  select @w_error = 2600023,
         @w_mensaje = 'PARAMETRO VCTSB NO EXISTE'
  goto ERROR
end

select @w_version_cts_trn = valor 
from   cobis..cl_catalogo c, cobis..cl_tabla t
where  c.tabla  = t.codigo
and    t.tabla  = 'ws_version_cts'
and    c.codigo = 26521
and    c.estado = 'V'

if @@rowcount = 0
   select @w_version_cts_trn = @w_version_cts_base --Valor por defecto
   
select
@w_sp_name         ='sp_relacion_cta_canal',
@w_commit          = 'N',
@w_error           = 0,
@i_tel_celular     = replace(ltrim(rtrim(@i_tel_celular)),' ',''),
@i_tel_celular_old = replace(ltrim(rtrim(@i_tel_celular_old)),' ','')
       
       if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
       
if @t_trn = 744
begin 
   /* -- INSERCION -- */

   if @i_operacion = 'I'
   begin   
      -- Req. 371 Validacion para canal CB si existe la relacion
      if @i_canal = 'CB'
      begin
         if exists (select 1 from cob_remesas..re_relacion_cta_canal  
			     where rc_cuenta 	  = @i_cta and
				       rc_tel_celular = @i_tel_celular and
				       rc_estado 	  = 'V' and
					   rc_canal       = @i_canal)
         begin
            select @w_error   = 351047,
     	           @w_mensaje = 'CUENTA YA TIENE UNA RELACION A CANALES'
     	    goto ERROR
         end
         if exists (select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tel_celular = @i_tel_celular and 
                       rc_estado      = 'V' and
					   rc_canal       = @i_canal)
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE CELULAR YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
      end

	  --REQ: 453
      if @i_canal = 'BMOVIL'
      begin
         if exists (select 1 from cob_remesas..re_relacion_cta_canal
			     where rc_cuenta 	    = @i_cta and
				   rc_tel_celular   = @i_tel_celular    and
				   rc_tipo_operador = @i_tipo_operador  and
				   rc_estado        = 'V'               and
                                   rc_canal         = @i_canal)
         begin
            select @w_error   = 351047,
     	           @w_mensaje = 'CLIENTE YA TIENE UNA RELACION A CANALES'
     	    goto ERROR
         end
         if exists (select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tel_celular    = @i_tel_celular     and 
                       rc_tipo_operador  = @i_tipo_operador   and
                       rc_estado         = 'V'                and
                       rc_canal          = @i_canal)
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE CELULAR YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
      end
	  
      -- Req. 371 Validacion para canal TAR si ya existe la relacion con la tarjeta
      if @i_canal = 'TAR'
      begin
         if exists (select 1 from cob_remesas..re_relacion_cta_canal 
                    where rc_tarj_debito = @i_tarj_debito and 
                          rc_estado      = 'V' and
					      rc_canal       = @i_canal) 
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE TARJETA YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
		 
		 if exists (select 1 from cob_remesas..re_relacion_cta_canal 
                    where rc_cuenta = @i_cta 
                         and rc_estado = 'V'
                         and rc_canal  = @i_canal) 
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'CUENTA YA TIENE UNA RELACION A CANALES'
     	    goto ERROR
         end
         
         -- Req. 443 Subtipo Tarjeta Debito
         if @i_subtipo is null
		 begin
		   select @w_error = 351577,
                  @w_mensaje = 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO'
           goto ERROR   
         end
      end
      
      begin tran 
	     select @w_commit = 'S'
	     
         if @i_canal <> 'BMOVIL'
         begin

			 --CONSULTAR LOS DATOS DEL CLIENTE
			 select @w_ced_ruc = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
			 
			 exec @w_return = cobis..sp_datos_cliente
				  @i_cedruc       = @i_ced_ruc,
				  @i_ente         = @i_cliente,
				  @o_tipoced      = @w_tipo_ced out,
				  @o_cedruc       = @w_ced_ruc out,
				  @o_descripcion  = @w_direccion out,
				  @o_provincia    = @w_dpto out,
				  @o_ind_ciudad   = @w_ind_ciudad out,
				  @o_telefono     = @w_telefono out,
				  @o_email        = @w_email out,
				  @o_actividad    = @w_actividad out,
				  @o_ocupacion    = @w_origen_ing out,
				  @o_ciudad       = @w_ciudad out,
				  @o_nombre       = @w_nombres out,
				  @o_papellido    = @w_p_apellido out,
				  @o_sapellido    = @w_s_apellido out
			 
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR OBTENIENDO DATOS DE CLIENTE',
					   @w_error_ws = 'S'
				goto ERROR
			 end
			 
			 if @w_email is null
				select @w_email = pa_char
				from cobis..cl_parametro 
				where pa_producto = 'MIS' 
				and   pa_nemonico = 'RBMCE'
				
			 if @w_ind_ciudad is null
				select @w_ind_ciudad = 1
				
			 -- Req. 371 Conversion de caracteres especiales
			 select @w_direccion = replace(@w_direccion, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_telefono = replace(@w_telefono, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_ciudad = replace(@w_ciudad, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_actividad = substring(@w_actividad, 1, 4)
			 
			 -- Req. 317 Tarjetas de debito
			 select @w_binbmi = pa_char from cobis..cl_parametro
			 where  pa_nemonico = 'BINMI'
			 and    pa_producto = 'REM'
			 
			 if @w_binbmi is null
			 begin
				select @w_error = 2600023,
					   @w_mensaje = 'PARAMETRO BIN DE BANCAMIA NO EXISTE'
				goto ERROR
			 end
			 
			 if @i_motivo = '03'
			 begin 
				select @w_motivo = '03'
			 end
			 else
			 begin
				--Extraer del catalogo re_novedades_enroll Asociacion Usuario
				select @w_motivo = rtrim(cl_catalogo.codigo)
				from cobis..cl_catalogo, cobis..cl_tabla
				where cl_catalogo.tabla = cl_tabla.codigo and 
					  cl_tabla.tabla         = 're_novedades_enroll'
					  --and cl_catalogo.estado = 'V'
					  and cl_catalogo.codigo = '01'
			 end
			 
			 --Obteniendo canal para WS       
			 select @w_canal = convert(varchar(2),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_canal_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @i_canal
			 
			 --Obteniendo tipo de identificacion para WS       
			 select @w_tipo_identi = convert(varchar(10),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_id_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @w_tipo_ced

			 select @w_nombres = replace(@w_nombres, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_p_apellido = replace(@w_p_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_s_apellido = replace(@w_s_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 --Concatenando nombre corto
			 Select @w_nomcorto = @w_nombres + ' ' + @w_p_apellido
			 
			 --Concatenando apellidos
			 Select @w_apellidos = @w_p_apellido + ' ' + @w_s_apellido
			 
			 -- Req. 443 SubTipo Tarjeta
			 if @w_canal = '01'
			 begin
				select @w_num_prod = @i_cta,
					   @w_subtipo  = NULL
			 end
			 else
			 begin
				select @w_num_prod = @i_tarj_debito,
					   @w_subtipo  = @i_subtipo
			 end
				
			 --Origen de ingresos
			 select @w_origen_ing = convert(varchar(10),cl_catalogo.valor)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_orgfon_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.codigo = @w_origen_ing
			 
			 --CONSULTAR COMO INVOCAR AL SERVIDOR DE MIDDLEWARE
			 if @w_version_cts_trn = @w_version_cts_base begin	
				 exec @w_return = CTSXPSERVER.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nomcorto,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,    -- Parametro General 371
					  @i_num_prod_new = null,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = null,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,     -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out
			 end
			 else begin
				 exec @w_return = CTSXPSERVER2.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nomcorto,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,    -- Parametro General 371
					  @i_num_prod_new = null,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = null,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,     -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out		 
			 end
			 
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR INSERTANDO RELACION CUENTA EN EL MIDDLEWARE',
					   @w_error_ws = 'S'
				goto ERROR
			 end
			
			 if @w_codigo_enrol <> 'OK000'
			 begin
				select @w_mensaje = 'MENSAJE PROVEEDOR EXTERNO - ' + isnull(@w_mensaje,'ERROR INSERTANDO RELACION CUENTA EN EL MIDDLEWARE'),
					   @w_error_ws = 'S'
				goto ERROR
			 end
			 
        end --fin BMOVIL
         
		 if @i_canal = 'BMOVIL'
            select @w_motivo = '01', @i_ced_ruc = @i_cta
			
	     /*Insertar nuevo registro */
		 insert into cob_remesas..re_relacion_cta_canal 
		        ( rc_cuenta, rc_cliente,	rc_tel_celular, 
		 		  rc_tarj_debito, rc_canal, rc_motivo,
		 		  rc_estado, rc_fecha, rc_fecha_mod, 
		 		  rc_usuario, rc_subtipo, rc_tipo_operador)
         values ( @i_cta, @i_cliente, @i_tel_celular,
		          @i_tarj_debito, @i_canal, @w_motivo,
		          'V', @s_date, NULL, 
		          @s_user, @w_subtipo, @i_tipo_operador)
		    
		 /* error en la insercion */
         if @@error <> 0
         begin
            select @w_error = 357508, 
     	           @w_mensaje = 'ERROR AL INSERTAR RELACION CUENTA CANAL'
     	    goto ERROR
         end
        
        insert into cob_remesas..re_tran_servicio 
               ( ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
                 ts_login, ts_terminal, ts_oficina, 
                 ts_datetime1, ts_char1, ts_char2, 
                 ts_char5, ts_varchar4, ts_varchar2, 
                 ts_varchar3, ts_varchar5, ts_varchar6,
				 ts_clase )
        values ( @s_ssn, @t_trn, @s_date, 
                 @s_user, @s_term, @s_ofi, 
                 getdate(), @i_operacion, 'V', 
                 @w_subtipo, @i_cta, @i_tel_celular, 
                 @i_ced_ruc, @i_tarj_debito, @i_tipo_operador,
				 'N' )
              
        /* error en la insercion de la transaccion de servicio */
        if @@error <> 0
        begin
           select @w_error = 357508, 
     	          @w_mensaje = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
     	   goto ERROR
        end
        
        --Insertando en la tran servicio del webservice de middleware
        insert into cobis..ws_tran_servicio 
               ( ts_ssn, ts_usuario, ts_terminal, 
                 ts_fecha, ts_hora, ts_tipo_tran, 
                 ts_estado, ts_correccion, ts_sec_ext,
                 ts_hora_est, ts_campo1, ts_campo2,
                 ts_monto, ts_num_tarjeta, ts_prod_orig, 
                 ts_banco_orig, ts_campo3, ts_campo4, 
                 ts_campo5, ts_campo6, ts_campo7, 
                 ts_campo10, ts_retorno, ts_campo8, 
                 ts_campo9, ts_conciliado, ts_oficina, 
                 ts_adquiriente, ts_cod_alterno )
        values ( @s_ssn, @s_user, @s_term, 
                 @s_date, getdate(), @t_trn, 
                 'V', 'N', @w_num_ref, 
                 @s_date, @w_tipo_identi, @w_ced_ruc,
                 @i_valor, @i_tarj_debito, @i_prd_orig, 
                 @i_cta, @w_nombres, @w_apellidos, 
                 @i_tel_celular, @w_binbmi, @w_num_autoriza, 
                 @w_mensaje, isnull(isnull(@w_return,@w_error),1), @w_codigo_enrol,
                 @w_subtipo, 'N', @s_ofi, 
                 @i_adquiriente, 3 )
        
        if @@error <> 0
        begin
           select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE', @w_error = @@error,
                  @w_error_ws = 'S'
     	   goto ERROR
        end

        if @w_commit = 'S'	   	   		 
        begin
           commit tran
           select @w_commit = 'N'
           return 0
        end
   end ---fin de operacion I
end--fin transaccion 744

if @t_trn = 745
begin 
   /****************   ACTUALIZACION   ************************/
   if @i_operacion = 'U'
   begin
      
      if @i_canal = 'BMOVIL'
      begin
         select @w_motivo = '02', @i_ced_ruc = @i_cta
      end

      if not exists(select 1 from cob_remesas..re_relacion_cta_canal  
			         where rc_cuenta 	  = @i_cta and
				           rc_tel_celular = @i_tel_celular_old and
				           rc_estado 	  = isnull(@i_estado,'V'))

      begin
         select @w_error   = 208106, 
     	        @w_mensaje = 'CUENTA NO TIENE UNA RELACION A CANALES'
     	 goto ERROR
      end
      
      if @i_canal = 'CB'
      begin
         select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tel_celular = @i_tel_celular and 
                       rc_estado      = 'V' and
					   rc_canal       = @i_canal
         if @@ROWCOUNT = 1
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE CELULAR YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
      end
      
	  --REQ: 453      
      if @i_canal = 'BMOVIL'
      begin
         if exists(select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tel_celular   = @i_tel_celular    and 
                       rc_tipo_operador = @i_tipo_operador  and
                       rc_estado        = 'V' )
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE CELULAR YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
      end
	  
	  --REQ: 543  

      if @i_canal = 'TAR' and @i_motivo = '15'
      begin
	   
	     select @w_subtipo  = @i_subtipo
       
	     if exists(select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tel_celular   = @i_tel_celular    and 
                       rc_tarj_debito   = @i_tarj_debito  and
                       rc_estado        = 'V' )
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'TELEFONO CELULAR YA ASOCIADO A TARJETA DEBITO'
     	    goto ERROR
         end


      end

      if @i_canal = 'TAR' and @i_motivo = '03'
      begin
         select 1 from cob_remesas..re_relacion_cta_canal 
                 where rc_tarj_debito = @i_confir_tarj_debito and 
                       rc_estado      = 'V' and
					   rc_canal       = @i_canal
         if @@ROWCOUNT = 1
         begin
	        select @w_error = 351047,
     	           @w_mensaje = 'NRO. DE TARJETA YA FUE REGISTRADO ANTERIORMENTE'
     	    goto ERROR
         end
         
         -- Req. 443 Subtipo Tarjeta Debito
         if @i_subtipo is null
		 begin
		   select @w_error = 351577,
                  @w_mensaje = 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO'
           goto ERROR   
         end
      end

      begin tran   
      select @w_commit = 'S'
         
      if @i_canal <> 'BMOVIL'
      begin
            
		  --Se valida que el canal para realizar la actualización del enrolamiento este vigente
		  select 1 
		  from cobis..cl_tabla t, 
			   cobis..cl_catalogo c 
		  where c.tabla  = t.codigo 
		  and   t.tabla  = 're_canal_act' 
		  and   c.estado = 'V'
		  and   c.valor  = @i_canal
		  
		  if @@rowcount = 0
		  begin
			 select @w_error = 351047,
					@w_mensaje = 'CANAL NO HABILITADO PARA ACTUALIZAR ENROLAMIENTO'
			 goto ERROR
		  end
		  
			 --CONSULTAR LOS DATOS DEL CLIENTE
			 select @w_ced_ruc = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
			 
			 exec @w_return = cobis..sp_datos_cliente
				  @i_cedruc       = @i_ced_ruc,
				  @i_ente         = @i_cliente,
				  @o_tipoced      = @w_tipo_ced out,
				  @o_cedruc       = @w_ced_ruc out,
				  @o_descripcion  = @w_direccion out,
				  @o_provincia    = @w_dpto out,
				  @o_ind_ciudad   = @w_ind_ciudad out,
				  @o_telefono     = @w_telefono out,
				  @o_email        = @w_email out,
				  @o_actividad    = @w_actividad out,
				  @o_ocupacion    = @w_origen_ing out,
				  @o_ciudad       = @w_ciudad out,
				  @o_nombre       = @w_nombres out,
      			  @o_papellido    = @w_p_apellido out,
				  @o_sapellido    = @w_s_apellido out
			 
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR OBTENIENDO DATOS DE CLIENTE',
					   @w_error_ws = 'S'
				goto ERROR
			 end
			 
			 -- Req. 371 Conversion de caracteres especiales
			 select @w_direccion = replace(@w_direccion, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_telefono = replace(@w_telefono, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_ciudad = replace(@w_ciudad, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 --Concatenando nombre corto
			 Select @w_nombres = @w_nombres + ' ' + @w_p_apellido
			 
			 -- Req. 317 Tarjetas de debito
			 select @w_binbmi = pa_char from cobis..cl_parametro
			 where  pa_nemonico = 'BINMI'
			 and    pa_producto = 'REM'
			 
			 if @w_binbmi is null
			 begin
				select @w_error = 2600023,
					   @w_mensaje = 'PARAMETRO BIN DE BANCAMIA NO EXISTE'
				goto ERROR
			 end
			 
			 --Obteniendo canal para WS       
			 select @w_canal = convert(varchar(2),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_canal_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @i_canal
			 
			 -- Req. 443 Subtipo Tarjeta Debito
			 if @w_canal = '01'
			 begin
				select @w_num_prod = @i_cta,
					   @w_subtipo  = NULL
			 end
			 else
			 begin
				select @w_num_prod = @i_tarj_debito,
					   @w_subtipo  = @i_subtipo
			 end
			 
		
			 --Obteniendo tipo de identificacion para WS       
			 select @w_tipo_identi = convert(varchar(2),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_id_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @w_tipo_ced
			 
			 --Extraer del catalogo re_novedades_enroll Actualización Datos Usuario
			 select @w_motivo = rtrim(cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_novedades_enroll'
				   --and cl_catalogo.estado = 'V'
				   and cl_catalogo.codigo = @i_motivo
			 
			 if @w_email is null
				select @w_email = pa_char
				from cobis..cl_parametro 
				where pa_producto = 'MIS' 
				and   pa_nemonico = 'RBMCE'
				
			if @w_ind_ciudad is null
				select @w_ind_ciudad = 1
				
			 -- Actividad economica solo envia los primeros cuatro digitos   
			 select @w_actividad = substring(@w_actividad, 1, 4)
			 
			 --Origen de ingresos
			 select @w_origen_ing = convert(varchar(10),cl_catalogo.valor)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_orgfon_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.codigo = @w_origen_ing
				   
			 select @w_nombres = replace(@w_nombres, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_p_apellido = replace(@w_p_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_s_apellido = replace(@w_s_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'               
			 
			 --Concatenando apellidos
			 Select @w_apellidos = @w_p_apellido + ' ' + @w_s_apellido
			 
			 -- Req. 371 Reexpedicion
			 if @i_motivo = '03'
				select @w_motivo_bloq = '01'
			 
			 -- Req. 543 TD-Actualizacion de celular
			 if @i_canal = 'TAR' and @i_motivo = '15'  --REQ 543
			    select @w_act_cel = 'S'

			 if  @w_act_cel <> 'S'  --REQ 543
			 begin		  
			 --CONSULTAR COMO INVOCAR AL SERVIDOR DE MIDDLEWARE
			    if @w_version_cts_trn = @w_version_cts_base begin		 
				 exec @w_return = CTSXPSERVER.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,      -- primer nombre y primer apellido
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = @i_confir_tarj_debito,    -- Parametro General 371,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = @w_motivo_bloq,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,            -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out
			    end
			    else begin
				 exec @w_return = CTSXPSERVER2.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,      -- primer nombre y primer apellido
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = @i_confir_tarj_debito,    -- Parametro General 371,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = @w_motivo_bloq,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,            -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out		 
			    end		 
			   
			    if @w_return <> 0
			    begin
				   select @w_mensaje  = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE',
					   @w_error_ws = 'S'
				   goto ERROR
			    end
			
			    if @w_codigo_enrol <> 'OK000'
			    begin
				   select @w_mensaje = 'MENSAJE PROVEEDOR EXTERNO - ' + isnull(@w_mensaje,'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE'),
					   @w_error_ws = 'S'
				   goto ERROR
			    end
            end  --final REQ 543
            
			
      end --fin bmovil
	

	      -- transacciones de servicio antes de actualizacion-- REQ 543       
         insert into cob_remesas..re_tran_servicio 
               ( ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
                 ts_login, ts_terminal, ts_oficina, 
                 ts_datetime1, ts_char1, ts_char2, 
                 ts_char5, ts_varchar4, ts_varchar2, 
                 ts_varchar3, ts_varchar5, ts_varchar6,
				 ts_clase)
         values ( @s_ssn, @t_trn, @s_date, 
                  @s_user, @s_term, @s_ofi, 
                  getdate(), @i_operacion, @i_estado, 
                  @w_subtipo, @i_cta, @i_tel_celular_old, 
                  @i_ced_ruc, @i_tarj_debito, @i_tipo_operador,
				  'P' )

         if @@error <> 0
         begin
	        select @w_error = 357508,  
     	           @w_mensaje = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
     	    goto ERROR
         end
         
	    if @w_act_cel = 'S' or @i_canal = 'TAR' --REQ 543
         begin
		    
            update cob_remesas..re_relacion_cta_canal
            set    rc_estado      = 'E',
                   rc_fecha_mod   = @s_date,
                   rc_usuario     = @s_user
                   
            where  rc_estado      = 'V' and
                   rc_cuenta        = @i_cta and
                   rc_tel_celular   = @i_tel_celular_old   and
                   rc_canal         = @i_canal   and
				   rc_subtipo       = @w_subtipo
				   
            if @@error <> 0
            begin
               select @w_error = 357522,  
     	              @w_mensaje = 'ERROR AL ACTUALIZAR REGISTRO ELIMINADO'
     	       goto ERROR
            end
         end   
		 else
		 begin
		 
			 -- Req. 371 Agregada condicion para la reexpedicion IB 28/01/2014 
             update cob_remesas..re_relacion_cta_canal
             set    rc_estado      = 'E',
                    rc_fecha_mod   = @s_date,
                    rc_usuario     = @s_user,
                    rc_motivo      = @w_motivo
              where rc_estado     = 'V' and
                    rc_cuenta        = @i_cta and
                    rc_tel_celular   = @i_tel_celular_old   and
                    rc_tipo_operador = @i_tipo_operador_old and
                    rc_canal         = @i_canal
				   
               if @@error <> 0
               begin
                  select @w_error = 357522,  
     	              @w_mensaje = 'ERROR AL ACTUALIZAR RELACION CUENTA CANAL'
     	          goto ERROR
               end
		  end
            -- Req. 371 Condicion para validar si es reexpedicion de tarjeta o cambio num celular
            if @i_motivo = '03'
               select @i_tarj_debito = @i_confir_tarj_debito
            
            /*Insertar nuevo registro */
		    insert into cob_remesas..re_relacion_cta_canal 
		        ( rc_cuenta, rc_cliente,	rc_tel_celular, 
		 		  rc_tarj_debito, rc_canal, rc_motivo,
		 		  rc_estado, rc_fecha, rc_fecha_mod, 
		 		  rc_usuario, rc_subtipo, rc_tipo_operador)
            values ( @i_cta, @i_cliente, @i_tel_celular,
		             @i_tarj_debito, @i_canal, @w_motivo,
		             'V', @s_date, NULL, 
		             @s_user, @w_subtipo, @i_tipo_operador)
		    
		    /* error en la insercion */
            if @@error <> 0
            begin
               select @w_error = 357508, 
     	              @w_mensaje = 'ERROR AL INSERTAR RELACION CUENTA CANAL'
     	       goto ERROR
            end
            
		 /* -- transacciones de servicio -- */       
         insert into cob_remesas..re_tran_servicio 
               ( ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
                 ts_login, ts_terminal, ts_oficina, 
                 ts_datetime1, ts_char1, ts_char2, 
                 ts_char5, ts_varchar4, ts_varchar2, 
                 ts_varchar3, ts_varchar5, ts_varchar6,
				 ts_clase )
         values ( @s_ssn, @t_trn, @s_date, 
                  @s_user, @s_term, @s_ofi, 
                  getdate(), @i_operacion, @i_estado, 
                  @w_subtipo, @i_cta, @i_tel_celular, 
                  @i_ced_ruc, @i_tarj_debito, @i_tipo_operador,
				  'N')

         if @@error <> 0
         begin
	        select @w_error = 357508,  
     	           @w_mensaje = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
     	    goto ERROR
         end
              
        --Insertando en la tran servicio del webservice de middleware
        insert into cobis..ws_tran_servicio 
               ( ts_ssn, ts_usuario, ts_terminal, 
                 ts_fecha, ts_hora, ts_tipo_tran, 
                 ts_estado, ts_correccion, ts_sec_ext,
                 ts_hora_est, ts_campo1, ts_campo2,
                 ts_monto, ts_num_tarjeta, ts_prod_orig, 
                 ts_banco_orig, ts_campo3, ts_campo4, 
                 ts_campo5, ts_campo6, ts_campo7, 
                 ts_campo10, ts_retorno, ts_campo8, 
                 ts_campo9, ts_conciliado, ts_oficina, 
                 ts_adquiriente, ts_cod_alterno )
        values ( @s_ssn, @s_user, @s_term, 
                 @s_date, getdate(), @t_trn, 
                 isnull(@i_estado,'_'), 'N', @w_num_ref, 
                 @s_date, @w_tipo_identi, @w_ced_ruc,
                 @i_valor, @i_tarj_debito, @i_prd_orig, 
                 @i_cta, @w_nombres, @w_apellidos, 
                 @i_tel_celular_old, @w_binbmi, @w_num_autoriza, 
                 @w_mensaje, isnull(isnull(@w_return,@w_error),1), @w_codigo_enrol, 
                 @w_subtipo, 'N', @s_ofi, 
                 @i_adquiriente, 4 )
                 
        if @@error <> 0
        begin
           select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE', @w_error = @@error,
                  @w_error_ws = 'S'
     	   goto ERROR
        end

         if @w_commit = 'S'	   	   		 
         begin
            commit tran
            select @w_commit = 'N'	
            return 0
         end
   end --- fin de operacion U
end--fin transaccion 745

if @t_trn = 746
begin 
   /****************   ELIMINACION  ************************/
   if @i_operacion = 'D'
   begin
      if @i_canal = 'BMOVIL'
         select @i_ced_ruc = @i_cta, @w_motivo = '03'

      if not exists (select 1 from cob_remesas..re_relacion_cta_canal  
			         where rc_cuenta 	  = @i_cta and
				           rc_tel_celular = @i_tel_celular and
				           rc_estado 	  = 'V' and
					       rc_canal       = @i_canal)
      begin
         select @w_error   = 208106,  
     	        @w_mensaje = 'RELACION DE CUENTA Y CELULAR NO EXISTE O NO ESTA VIGENTE'
     	 goto ERROR
      end
      
      begin tran   
         select @w_commit = 'S'
         
         if @i_canal <> 'BMOVIL'
         begin
		 
			 --CONSULTAR LOS DATOS DEL CLIENTE
			 select @w_ced_ruc = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
			 
			 exec @w_return = cobis..sp_datos_cliente
				  @i_cedruc       = @i_ced_ruc,
				  @i_ente         = @i_cliente,
				  @o_tipoced      = @w_tipo_ced out,
				  @o_cedruc       = @w_ced_ruc out,
				  @o_descripcion  = @w_direccion out,
				  @o_provincia    = @w_dpto out,
				  @o_ind_ciudad   = @w_ind_ciudad out,
				  @o_telefono     = @w_telefono out,
				  @o_email        = @w_email out,
				  @o_actividad    = @w_actividad out,
				  @o_ocupacion    = @w_origen_ing out,
				  @o_ciudad       = @w_ciudad out,
				  @o_nombre       = @w_nombres out,
				  @o_papellido    = @w_p_apellido out,
				  @o_sapellido    = @w_s_apellido out
			 
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR OBTENIENDO DATOS DE CLIENTE',
					   @w_error_ws = 'S'
				goto ERROR
			 end
			 
			 -- Req. 371 Conversion de caracteres especiales
			 select @w_direccion = replace(@w_direccion, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_telefono = replace(@w_telefono, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_ciudad = replace(@w_ciudad, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_nombres = replace(@w_nombres, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_p_apellido = replace(@w_p_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 select @w_s_apellido = replace(@w_s_apellido, char(c.codigo), char(c.valor)) 
			 from cobis..cl_catalogo c, cobis..cl_tabla t 
			 where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
			 
			 --Concatenando nombre corto
			 Select @w_nombres = @w_nombres + ' ' + @w_p_apellido
			 
			 -- Req. 317 Tarjetas de debito
			 select @w_binbmi = pa_char from cobis..cl_parametro
			 where  pa_nemonico = 'BINMI'
			 and    pa_producto = 'REM'
			 
			 if @w_binbmi is null
			 begin
				select @w_error = 2600023,
					   @w_mensaje = 'PARAMETRO BIN DE BANCAMIA NO EXISTE'
				goto ERROR
			 end
			 
			 --Concatenando apellidos
			 Select @w_apellidos = @w_p_apellido + ' ' + @w_s_apellido
					  
			 --Extraer del catalogo re_novedades_enroll Eliminacion Usuario
			 if @i_canal = 'CB'
			 begin
				select @w_motivo = rtrim(cl_catalogo.codigo)
				from cobis..cl_catalogo, cobis..cl_tabla
				where cl_catalogo.tabla = cl_tabla.codigo and 
					  cl_tabla.tabla         = 're_novedades_enroll'
					  --and cl_catalogo.estado = 'V'
					  and cl_catalogo.codigo = '02'
			 end
			 else
			 begin
				if @i_canal = 'TAR'
				begin
				   -- Req. 443 Subtipo Tarjeta
				   if @i_subtipo is null
				   begin
					  select @w_error = 351577,
							 @w_mensaje = 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO'
					  goto ERROR   
				   end
				   select @w_motivo = '04'
				   select @w_motivo_bloq = '01'
				end
			 end   
			 
			 --Obteniendo canal para WS       
			 select @w_canal = convert(varchar(2),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_canal_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @i_canal
				   
			 -- Req. 443 Subtipo Tarjeta
			 if @w_canal = '01'
			 begin
				select @w_num_prod = @i_cta,
					   @w_subtipo  = NULL
			 end
			 else
			 begin
				select @w_num_prod = @i_tarj_debito,
					   @w_subtipo  = @i_subtipo
			 end
			 --Obteniendo tipo de identificacion para WS       
			 select @w_tipo_identi = convert(varchar(10),cl_catalogo.codigo)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_id_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.valor  = @w_tipo_ced
			 
			 --Origen de ingresos
			 select @w_origen_ing = convert(varchar(10),cl_catalogo.valor)
			 from cobis..cl_catalogo, cobis..cl_tabla
			 where cl_catalogo.tabla = cl_tabla.codigo and 
				   cl_tabla.tabla         = 're_orgfon_enroll'
				   and cl_catalogo.estado = 'V'
				   and cl_catalogo.codigo = @w_origen_ing
			 
			 -- Obteniendo el email
			 if @w_email is null
				select @w_email = pa_char
				from cobis..cl_parametro 
				where pa_producto = 'MIS' 
				and   pa_nemonico = 'RBMCE'
				
			if @w_ind_ciudad is null
				select @w_ind_ciudad = 1
				
			 -- Actividad economica solo envia los primeros cuatro digitos   
			 select @w_actividad = substring(@w_actividad, 1, 4)
			 
			 --CONSULTAR COMO INVOCAR AL SERVIDOR DE MIDDLEWARE
			 if @w_version_cts_trn = @w_version_cts_base begin		 
				 exec @w_return = CTSXPSERVER.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = null,    -- Parametro General 371,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = @w_motivo_bloq,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = null,
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out
			 end
			 else begin
				 exec @w_return = CTSXPSERVER2.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,       -- Parametro General 371
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = null,    -- Parametro General 371,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = @w_motivo_bloq,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = null,
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out		 
			 end
			
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE',
					   @w_error_ws = 'S'
				goto ERROR
			 end
	 
			 if @w_codigo_enrol <> 'OK000'
			 begin
				select @w_mensaje = 'MENSAJE PROVEEDOR EXTERNO - ' + isnull(@w_mensaje,'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE'),
					   @w_error_ws = 'S'
				goto ERROR
			 end
         end --fin bmovil  

         update cob_remesas..re_relacion_cta_canal
         set    rc_estado      = 'E',
                rc_fecha_mod   = @s_date,
                rc_usuario     = @s_user,
                rc_motivo      = @w_motivo
         where  rc_estado      = 'V' and
                rc_cuenta      = @i_cta and
                rc_tel_celular = @i_tel_celular and
				    rc_tipo_operador = @i_tipo_operador and
                rc_canal       = @i_canal -- Cambio para eliminar la relacion por canal
                
         if @@error <> 0
         begin
            select @w_error = 357522,   
     	           @w_mensaje = 'ERROR AL ACTUALIZAR RELACION CUENTA CANAL'
     	    goto ERROR
         end
            
         /* -- transacciones de servicio -- */       
         insert into cob_remesas..re_tran_servicio 
               ( ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
                 ts_login, ts_terminal, ts_oficina, 
                 ts_datetime1, ts_char1, ts_char2, 
                 ts_char5, ts_varchar4, ts_varchar2, 
                 ts_varchar3, ts_varchar5, ts_varchar6 )
         values ( @s_ssn, @t_trn, @s_date, 
                  @s_user, @s_term, @s_ofi, 
                  getdate(), @i_operacion, 'E', 
                  @w_subtipo, @i_cta, @i_tel_celular, 
                  @i_ced_ruc, @i_tarj_debito, @i_tipo_operador )

         if @@error <> 0
         begin
	        select @w_error = 357508,  
     	           @w_mensaje = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
     	    goto ERROR
         end
        if @i_canal <> 'BMOVIL'
        begin              
			--Insertando en la tran servicio del webservice de middleware
			insert into cobis..ws_tran_servicio 
				   ( ts_ssn, ts_usuario, ts_terminal, 
					 ts_fecha, ts_hora, ts_tipo_tran, 
					 ts_estado, ts_correccion, ts_sec_ext,
					 ts_hora_est, ts_campo1, ts_campo2,
					 ts_monto, ts_num_tarjeta, ts_prod_orig, 
					 ts_banco_orig, ts_campo3, ts_campo4, 
					 ts_campo5, ts_campo6, ts_campo7, 
					 ts_campo10, ts_retorno, ts_campo8, 
					 ts_campo9, ts_conciliado, ts_oficina, 
					 ts_adquiriente, ts_cod_alterno )
			values ( @s_ssn, @s_user, @s_term, 
					 @s_date, getdate(), @t_trn, 
					 'E', 'N', @w_num_ref, 
					 @s_date, @w_tipo_identi, @w_ced_ruc,
					 @i_valor, @i_tarj_debito, @i_prd_orig, 
					 @i_cta, @w_nombres, @w_apellidos, 
					 @i_tel_celular, @w_binbmi, @w_num_autoriza, 
					 @w_mensaje, isnull(isnull(@w_return,@w_error),1), @w_codigo_enrol, 
					 @w_subtipo, 'N', @s_ofi, 
					 @i_adquiriente, 3 )
					 
			if @@error <> 0
			begin
			   select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE', @w_error = @@error,
					  @w_error_ws = 'S'
			   goto ERROR
			end
        end --fin bmovil
		
         if @w_commit = 'S'	   	   		 
         begin
            commit tran
            select @w_commit = 'N'	
            return 0
         end
   end --- fin de operacion D
end--fin transaccion 746

if @t_trn = 747
begin 
   /*************** SEARCH ********************/

   if @i_operacion = 'S'
   begin
   
      select 
      estado    = (select C.valor from cobis..cl_catalogo C with (nolock),      
                   cobis..cl_tabla T with (nolock)
                   where T.codigo = C.tabla
                   and T.tabla like 'cl_estado_ser'
                   and C.codigo   = rc_estado),
      canal     = rc_canal,
      ente      = en_ente,
      tipo_doc  = en_tipo_ced, 
      id        = en_ced_ruc,
      nombre    = en_nomlar, 
      cuenta    = rc_cuenta,
      celular   = rc_tel_celular,
      tarjeta   = rc_tarj_debito,
      motivo    = rc_motivo,
      SEC       = 0,--te_secuencial
      fecha_ing = rc_fecha,
      fecha_mod = rc_fecha_mod,
	  usuario   = rc_usuario,
	  tipo_ope  = rc_tipo_operador,
      subtipo   = rc_subtipo,    -- Req. 443 Subtipo de Tarjeta
      descripcion = (select C.valor 
                     from cobis..cl_catalogo C with (nolock), cobis..cl_tabla T with (nolock)
                     where T.codigo = C.tabla
                     and   T.tabla like 'pe_subtipo_%'
                     and   C.codigo = rc_subtipo)    -- Req. 443 Subtipo de Tarjeta
      into #relacion_cta_canal
      from cobis..cl_ente with (nolock), cobis..cl_catalogo with (nolock),      
           cobis..cl_tabla with (nolock), cob_remesas..re_relacion_cta_canal with (nolock)
      where rc_cuenta              = @i_cta 
            and rc_cliente         = en_ente  
            and cl_catalogo.codigo = en_tipo_ced 
            and cl_catalogo.tabla  = cl_tabla.codigo   
            and cl_tabla.tabla     = 'cl_tipo_documento'
       order by rc_fecha_mod
       
       update #relacion_cta_canal set
       SEC = isnull(te_secuencial,0)
       from cobis..cl_telefono with (nolock)
       where ente = te_ente
       and   celular = te_prefijo+te_valor
       
       select
       'CANAL'              = canal,
	   'ESTADO RELACION'    = estado,
       'TIPO DOCUMENTO'     = tipo_doc, 
       'IDENTIFICACION'     = id,
       'NOMBRE'             = nombre, 
       'CUENTA'             = cuenta,
       'T. CELULAR'         = celular,
       'TARJETA DEBITO'     = tarjeta,
       'MOTIVO'             = motivo,
       'SEC.'               = SEC,
       'FECHA INGRESO'      = convert(varchar,fecha_ing,103),
       'FECHA MODIFICACION' = convert(varchar,fecha_mod,103),
	   'USUARIO'            = usuario,
	   'TIPO OPERADOR'      = tipo_ope,
       'SUBTIPO'            = subtipo,
       'DESCRIPCION'        = descripcion
       from #relacion_cta_canal
       order by fecha_mod
       
       return 0
   end  -- fin operacion S
   
   /*************** HELP ********************/
   if @i_operacion = 'H' begin
      -- Obteniendo el ID del cliente
      select @w_cliente  = en_ente
	  from   cobis..cl_ente
	  where  en_ced_ruc  = @i_ced_ruc
	  and    en_tipo_ced = @i_tipo_id
      
      if @w_cliente <> '' begin
	     select 'SEC.'            = te_secuencial,
		        'NUMERO'          = replace(rtrim(ltrim(te_prefijo)),' ','') + replace(rtrim(ltrim(te_valor)),' ','')
         from  cobis..cl_telefono with (nolock),
		       cobis..cl_catalogo with (nolock), 
               cobis..cl_tabla    with (nolock)
         where te_ente            = @w_cliente
		 and   te_tipo_telefono   = 'C'
		 and   cl_catalogo.codigo = te_tipo_telefono
		 and   cl_catalogo.tabla  = cl_tabla.codigo
		 and   cl_tabla.tabla     = 'cl_ttelefono'
         order by te_ente, te_direccion, te_secuencial
      end

      return 0
   end  -- fin operacion H
   
   /*************** R ********************/
   if @i_operacion = 'R'
   begin 
      select rtrim(cl_catalogo.codigo), convert(varchar(48),valor)
      from cobis..cl_catalogo, cobis..cl_tabla
	  where cl_catalogo.tabla = cl_tabla.codigo and 
            cl_tabla.tabla         = 'cl_canal'
	        and cl_catalogo.estado = 'V'
            and cl_catalogo.codigo = 'CB'
      
      return 0
   end  -- fin operacion R
   
   /*************** Q ********************/
   if @i_operacion = 'Q'
   begin 
       if exists (select 1 from cob_remesas..re_relacion_cta_canal
                  where rc_cuenta = @i_cta and
                        rc_estado = 'V'    and
                        rc_tarj_debito <> '')
          select @w_estado = 'S'
       else
          select @w_estado = 'N'

       select @w_estado       
      
      return 0
   end  -- fin operacion Q
   
   /*************** Operacion V Req. 371 Operacion para consultar el 
   catalogo de exclusion de productos bancarios ********************/
   if @i_operacion = 'V'
   begin 
       select @w_valor = valor 
       from cobis..cl_catalogo, cobis..cl_tabla
	   where cl_catalogo.tabla = cl_tabla.codigo
       and cl_tabla.tabla = 'ah_prodbanc_blq'
	   and cl_catalogo.codigo = @i_codigo
	   and cl_catalogo.estado = 'V'
	   
	   select @w_valor

       return 0
   end  -- fin operacion V
   
end  -- fin transaccion 747

if @t_trn = 749
begin 
   /* -- P -- */

   if @i_operacion = 'P'
   begin  
   
         --CONSULTAR LOS DATOS DEL CLIENTE
	     select @w_ced_ruc = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
	     
         exec @w_return = cobis..sp_datos_cliente
              @i_cedruc       = @i_ced_ruc,
			  @i_ente         = @i_cliente,
			  @o_tipoced      = @w_tipo_ced out,
              @o_cedruc       = @w_ced_ruc out,
              @o_descripcion  = @w_direccion out,
              @o_provincia    = @w_dpto out,
              @o_ind_ciudad   = @w_ind_ciudad out,
              @o_telefono     = @w_telefono out,
              @o_email        = @w_email out,
              @o_actividad    = @w_actividad out,
              @o_ocupacion    = @w_origen_ing out,
              @o_ciudad       = @w_ciudad out,
              @o_nombre       = @w_nombres out,
              @o_papellido    = @w_p_apellido out,
              @o_sapellido    = @w_s_apellido out
		 
         if @w_return <> 0
         begin
		    select @w_mensaje = 'ERROR OBTENIENDO DATOS DE CLIENTE',
		           @w_error_ws = 'S'
		    goto ERROR
         end
         
         -- Obteniendo el email
         if @w_email is null
		    select @w_email = pa_char
			from cobis..cl_parametro 
			where pa_producto = 'MIS' 
			and   pa_nemonico = 'RBMCE'
		
		if @w_ind_ciudad is null
		    select @w_ind_ciudad = 1
         
         --Tipo de Novedad Extraer del catalogo re_novedades_enroll Olvido de Clave
         select @w_motivo = rtrim(cl_catalogo.codigo)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_novedades_enroll'
	           --and cl_catalogo.estado = 'V'
               and cl_catalogo.codigo = '07'
         
         --Obteniendo canal para WS       
         select @w_canal = convert(varchar(10),cl_catalogo.codigo)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_canal_enroll'
	           and cl_catalogo.estado = 'V'
               and cl_catalogo.valor  = @i_canal
         
         -- Req. 371 Conversion de caracteres especiales
         select @w_direccion = replace(@w_direccion, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
         
         select @w_telefono = replace(@w_telefono, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
         
         select @w_ciudad = replace(@w_ciudad, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
         
         select @w_nombres = replace(@w_nombres, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
		 
		 select @w_p_apellido = replace(@w_p_apellido, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
		 
		 select @w_s_apellido = replace(@w_s_apellido, char(c.codigo), char(c.valor)) 
         from cobis..cl_catalogo c, cobis..cl_tabla t 
         where t.codigo = c.tabla and t.tabla = 'cl_conv_ascii'
         
         --Concatenando nombre corto
         Select @w_nombres = @w_nombres + ' ' + @w_p_apellido
         
         select @w_actividad = substring(@w_actividad, 1, 4)
         
         -- Req. 317 Tarjetas de debito
         select @w_binbmi = pa_char from cobis..cl_parametro
         where  pa_nemonico = 'BINMI'
		 and    pa_producto = 'REM'
         
         if @w_binbmi is null
         begin
            select @w_error = 2600023,
                   @w_mensaje = 'PARAMETRO BIN DE BANCAMIA NO EXISTE'
            goto ERROR
         end
         
         --Origen de ingresos
		 select @w_origen_ing = convert(varchar(10),cl_catalogo.valor)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_orgfon_enroll'
	           and cl_catalogo.estado = 'V'
               and cl_catalogo.codigo = @w_origen_ing
               
         --Concatenando apellidos
         Select @w_apellidos = @w_p_apellido + ' ' + @w_s_apellido      
         
		 -- Req. 443 Subtipo Tarjeta
         if @i_canal = 'TAR'
         begin
            if @i_subtipo is null
		    begin
		       select @w_error = 351577,
                      @w_mensaje = 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO'
               goto ERROR   
            end
         end
		 
         -- Numero de producto depende del canal		 
         if @w_canal = '01'
         begin
		    select @w_num_prod = @i_cta,
		           @w_subtipo  = NULL
		 end
		 else
		 begin
		    select @w_num_prod = @i_tarj_debito,
		           @w_subtipo  = @i_subtipo
		 end
		    
         --Obteniendo tipo de identificacion para WS       
         select @w_tipo_identi = convert(varchar(10),cl_catalogo.codigo)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_id_enroll'
	           and cl_catalogo.estado = 'V'
               and cl_catalogo.valor  = @w_tipo_ced
         
		 if @i_canal <> 'BMOVIL'
         begin            
		 
			 --CONSULTAR COMO INVOCAR AL SERVIDOR DE MIDDLEWARE
			 if @w_version_cts_trn = @w_version_cts_base begin		 
				 exec @w_return = CTSXPSERVER.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = null,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = null,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,            -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out
			 end
			 else begin
				 exec @w_return = CTSXPSERVER2.cob_procesador..sp_act_relacion_canal
					  @t_trn          = 26521,
					  @s_ofi          = @s_ofi,
					  @s_user         = @s_user,
					  @s_rol          = @s_rol, 
					  @i_bin          = @w_binbmi,
					  @i_tipo_cta     = '11',
					  @i_num_cuenta   = @i_cta,
					  @i_tipo_identi  = @w_tipo_identi,
					  @i_num_identi   = @w_ced_ruc,
					  @i_nom_tarj     = @w_nombres,
					  @i_ape_tarj     = @w_apellidos,
					  @i_nom_corto    = @w_nombres,
					  @i_cta_prin     = 'P', 
					  @i_dir          = @w_direccion,
					  @i_cod_depar    = @w_dpto,
					  @i_id_ciudad    = @w_ind_ciudad,
					  @i_telefono     = @i_tel_celular,
					  @i_email        = @w_email,
					  @i_acti_eco     = @w_actividad,
					  @i_ori_ingre    = @w_origen_ing,
					  @i_cod_ofi      = @s_ofi,
					  @i_cod_muni     = @w_ciudad,
					  @i_tipo_novedad = @w_motivo,
					  @i_num_prod     = @w_num_prod,
					  @i_num_prod_new = null,
					  @i_canal        = @w_canal,
					  @i_motivo_bloq  = null,
					  @i_num_celular  = @i_tel_celular,
					  @i_filler_1     = @w_subtipo,            -- Req. 443 Enviando Subtipo de Tarjeta
					  @i_filler_2     = null,
					  @i_filler_3     = null,
					  @i_filler_4     = null,
					  @i_filler_5     = null,
					  @i_filler_6     = null,
					  @o_msj          = @w_mensaje out,
					  @o_cod_error    = @w_codigo_enrol out,
					  @o_num_ref      = @w_num_ref out,
					  @o_num_autoriza = @w_num_autoriza out		 
			 end
				  
			 if @w_return <> 0
			 begin
				select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE',
					   @w_error_ws = 'S',
					   @w_estado = 'X'
				goto ERROR
			 end 
			 else
			 begin
				select @w_estado = 'A'
			 end
         
		 end -- fin bmovil
         
		 if @w_codigo_enrol <> 'OK000'
         begin
		    select @w_mensaje = 'MENSAJE PROVEEDOR EXTERNO - ' + isnull(@w_mensaje,'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE'),
		           @w_error_ws = 'S'
		    goto ERROR
         end
          
        --Insertando en la tran servicio del webservice de middleware
        insert into cobis..ws_tran_servicio 
               ( ts_ssn, ts_usuario, ts_terminal, 
                 ts_fecha, ts_hora, ts_tipo_tran, 
                 ts_estado, ts_correccion, ts_sec_ext,
                 ts_hora_est, ts_campo1, ts_campo2,
                 ts_monto, ts_num_tarjeta, ts_prod_orig, 
                 ts_banco_orig, ts_campo3, ts_campo4, 
                 ts_campo5, ts_campo6, ts_campo10,
                 ts_retorno, ts_campo8, ts_campo9, 
                 ts_conciliado, ts_oficina, ts_adquiriente, 
                 ts_cod_alterno  )
        values ( @s_ssn, @s_user, @s_term, 
                 @s_date, getdate(), 26521, 
                 isnull(@w_estado,'_'), 'N', @w_num_ref, 
                 @s_date, @w_tipo_identi, @w_ced_ruc,
                 NULL, NULL, 4, 
                 @i_cta, NULL, NULL, 
                 @i_tel_celular, NULL, @w_mensaje, 
                 isnull(isnull(@w_return,@w_error),1), @w_codigo_enrol, @w_subtipo,
                 'NA', @s_ofi, NULL, 
                 4  )
        
        if @@error <> 0
        begin
           select @w_mensaje = 'ERROR RESTABLECIENDO CLAVEMIA', @w_error = @@error,
                  @w_error_ws = 'S'
     	   goto ERROR
        end

        if @w_commit = 'S'	   	   		 
        begin
           commit tran
           select @w_commit = 'N'
           return 0
        end
   end ---fin de operacion P
end--fin transaccion 749

return 0

ERROR: 

if @w_commit = 'S'
   rollback tran

--Insertando en la tran servicio del webservice de middleware
insert into cobis..ws_tran_servicio 
          (ts_ssn, ts_usuario, ts_terminal, 
           ts_fecha, ts_hora, ts_tipo_tran, 
           ts_estado, ts_correccion, ts_sec_ext,
           ts_hora_est, ts_campo1, ts_campo2,
           ts_monto, ts_num_tarjeta, ts_prod_orig, 
           ts_banco_orig, ts_campo3, ts_campo4, 
           ts_campo5, ts_campo6, ts_campo7, 
           ts_campo10, ts_retorno, ts_campo8, 
           ts_campo9, ts_conciliado, ts_oficina, 
           ts_adquiriente, ts_cod_alterno )
values ( @s_ssn, @s_user, @s_term, 
           @s_date, getdate(), @t_trn, 
           isnull(@i_estado,'_'), 'N', @w_num_ref, 
           @s_date, @w_tipo_ced, @w_ced_ruc,
           @i_valor, @i_tarj_debito, @i_prd_orig, 
           @i_cta, @w_nomlar, @w_apellidos, 
           @i_tel_celular, @i_rbm_user, @w_num_autoriza, 
           @w_mensaje, isnull(isnull(@w_return,@w_error),1), @w_codigo_enrol, 
           @w_subtipo, 'N', @s_ofi, 
           @i_adquiriente, 3  )
  
if @@error <> 0
begin
   select @w_mensaje = 'ERROR ACTUALIZANDO RELACION CUENTA EN EL MIDDLEWARE', @w_error = @@error,
          @w_error_ws = 'S'
   exec cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = @w_error,
     @i_msg   = @w_mensaje
   return @w_error
end
 

if @i_es_batch = 'N'
begin 
   exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error,
        @i_msg   = @w_mensaje
   return @w_error
end 
return @w_error
go