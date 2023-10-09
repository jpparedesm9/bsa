use cob_bvirtual
go
if object_id('sp_inicia_sesion') is not null
                drop proc sp_inicia_sesion
go

/*****************************************************************************/
/*   ARCHIVO:         bv_inicia_sesion.sp                                    */
/*   NOMBRE LOGICO:   sp_inicia_sesion                                       */
/*   PRODUCTO:        COBIS INTERNET BANKING                                 */
/*****************************************************************************/
/*                             IMPORTANTE                                    */
/*****************************************************************************/
/*   Esta aplicacion es parte de los  paquetes bancarios propiedad de        */
/*   COBISCORP                                                               */
/*   Su uso no autorizado queda  expresamente  prohibido asi como cualquier  */
/*   alteracion o agregado hecho por alguno de sus usuarios sin el debido    */
/*   consentimiento por escrito de COBISCORP.                                */
/*   Este programa esta protegido por la ley de derechos de autor y por las  */
/*   convenciones  internacionales de propiedad intelectual.                 */
/*   Su uso  no  autorizado dara derecho a COBISCORP para obtener ordenes de */
/*   secuestro o retencion  y  para  perseguir  penalmente a  los autores de */
/*   cualquier infraccion.                                                   */
/*****************************************************************************/
/*                           PROPOSITO                                       */
/*   Stored Procedure de inicio de sesion                                    */
/*****************************************************************************/
/*                        MODIFICACIONES                                     */
/*****************************************************************************/
/*  FECHA        VERSION       AUTOR              RAZON                      */
/*****************************************************************************/
/*  26/Ene/2005               Lenin F. Ponton    Person Global Bank          */
/*  26/Oct/2005               Jack "The Ripper"  Control estado B,I          */
/*                                               C error 1875066             */
/*  29-Ago-2006               gagm1050       No calculaba bien el numero prod*/
/*  13-Sep-2006               gamg1050       se hace un solo select por prod */
/*  21-Oct-2009               CEC            Consulta Logines asociados      */
/*  15-Dic-2009               CEC            Descripcion Pefil               */
/*  21-Ene-2010               CEC            Retorna Ente Mis                */
/*  10-Feb-2010               CEC            Graba Session SMS               */
/*  15-Mar-2010               CEC            Retorna Intentos                */
/*  02-Jun-2010               CEC            Ajustes Incio Sesion            */
/*                                           para smarthphones               */
/*  23-Sep-2010               CEC            Retorna Cultura y tema          */
/*  26-Jul-2011  4.0.0.0      DBR            Quitar tiempo transcurrido      */
/*                                           validación clave temporal       */
/*  28-Jul-2011  4.0.0.1      PCL            Control de acceso misma maquina */
/*  10-Nov-2011  4.0.0.2 D    NES            Notificaciones y ultimo acceso  */
/*  16-Nov-2011  4.0.0.2 P    CAG            Pin Temporal                    */
/*  29-Nov-2011  4.0.0.3      PCL            Integracion Produccion-Desarro. */
/*  07-Dic-2011  4.0.0.4      PCL            INC_5979 : Cultura              */
/*  23-Dic-2011  4.0.0.5      NES            Notificaciones                  */
/*  05-ENE-2012  4.0.0.6      FJI            Consulta ultima Conexión        */
/*  06-ENE-2012  4.0.0.7      NES            Cambio de server x webserver    */
/*  01-Mar-2012  4.0.0.8      GQU            Formato fecha ult. conexion     */
/*  05-Mar-2012  4.0.0.9      FJI            Consulta tipo cliente           */
/*  03-Abr-2012  4.0.0.10     GQU            Internacionalizacion(CIB4.1.0.5)*/
/*  17-Mar-2012  4.0.0.11     FJI            Aumentar Campo Login            */
/*  27-Jun-2012  4.0.0.12     GQU            Campo @i_culture para Internac. */
/*  03-Nov-2012  4.4.0.0      JDP            Aumentar campos                 */
/*  20-Dic-2012  4.4.0.1      TGU            Ajustes desarrollo TCS          */
/*  05-Abr-2013  4.4.0.2      XHU            Valida si requiere token        */
/*  15-May-2013  4.4.0.3      MES            Devolver cedula el contexto     */
/*  01-Abr-2014  4.4.0.4      FES            Soporte Banca Movil             */
/*  10-May-2017  4.4.0.5      GQU            Autenticacion biométrica MB     */
/*  01-Ago-2017  4.4.0.6      AFE            Validacion de Imagen            */
/*  28-Sep-2017  4.4.0.7      ERA            Aumento notificacion al ingreso */
/*  11-Oct-2017  4.4.0.8      DBA            Autenticacion fingerprint MB    */
/*  23-Nov-2018  4.4.0.8      ERA            Cambios B2C                     */
/*  18-Oct-2019               JSR            Agrega registro log B2C         */
/*****************************************************************************/
create Procedure sp_inicia_sesion(
   @t_show_version        bit           = 0,             -- PCL 2011.07.28
   @s_date                datetime      = null,
   @s_ssn                 int           = null,          --cmeg 10-Feb-2010
   @s_culture             varchar(20)   = 'NEUTRAL',     -- GQU 03-Abr-2012
   @i_operacion           char(1)       = null,
   @i_login               varchar(128)  = null,
   @i_clave               varchar(64)   = null,
   @i_clave_atm           varchar(64)   = null,
   @i_servicio            tinyint       = null,
   @i_server              varchar(30)   = null,
   @i_webserver           varchar(30)   = null,
   @i_terminal_ip         varchar(128)  = null,
   @i_dir_origen		     varchar(128)  = null,
   @i_kiosco              varchar(30)   = 'kiosco32',
   @i_formato_fecha       int           = 120,           -- GQU 01-Mar-2012
   @i_culture             varchar(20)   = 'NEUTRAL',      --GQU 27-Jun-2012
   @i_validate_token      char(1)       = 'N',             --XHU 05-Abr-2013
   @i_phone_number        varchar(20)   = null,
   @i_phone_udid          varchar(60)   = null,
   @i_biometric_id        int           = null,     --Id del Servidor Biometrico Banca Movil
   @i_biometric_state     char(1)       = 'S',  --Estado del Biometrico Banca Movil
   @i_modo                int           = 1,            --Modo del Biometrico Banca Movil
   @i_fingerprint_state	  char(1)       = 'N', -- DBA: Estado de la autenticacion con huella
   @i_fingerprint_key	  varchar(255)  = null, -- DBA: llave publica de la autenticacion con huella
   @i_fingerprint_name	  varchar(30) 	= null, -- DBA: nombre de la keystore en el dispositivo
   @o_vez                 tinyint       = null      out,
   @o_perfil              int           = null      out,
   @o_cliente             int           = null      out,
   @o_cliente_mis         int           = null      out, --cmeg 21-Ene-2010
   @o_login               varchar(64)   = null      out, --Login(lo_login) del cliente Biometrico Banca Movil
   @o_des_login           varchar(60)   = null      out,
   @o_ofi_kiosco          int           = null      out,
   @o_nombre_kiosco       varchar(30)   = null      out,
   @o_des_perfil          varchar(32)   = null      out, --cmeg 15-Dic-2009
   @o_sessionid           varchar(40)   = null      out, --cmeg 10-Feb-2010
   @o_intentos            smallint      = null      out, --cmeg 15-Mar-2010
   @o_id_autenticacion    varchar(64)   = null      out, --cmeg 3-Jun-2010
   @o_token               varchar(64)   = null      out, --cmeg 3-Jun-2010
   @o_cultura             varchar(10)   = 'NEUTRAL' out, --cmeg 23-Sep-2010
   @o_tema                varchar(40)   = 'default' out, --cmeg 23-Sep-2010
   @o_fecha_ult_acceso    varchar(20)   = null      out,
   @o_terminal_ip         varchar(32)   = null      out,
   @o_tipo_ente           varchar(10)   = null      out,
   @o_tipo_persona        char(1)       = null      out,  --JDP 03-Nov-2012
   @o_estado_token        char(1)       = null      out,  --JDP 03-Nov-2012
   @o_cedula              varchar(20)   = null      out,  --MES 15-May-2013
   @o_biometric_login     char(1)       = null      out, --GQU Biometrico Banca Movil
   @o_biometric_devices   char(1)       = null      out, --GQU Biometrico Banca Movil
   @o_biometric_id        int           = null      out, --GQU: ID Biometrico Banca Movil
   @o_biometric_password  varchar(64)   = null      out, --GQU: PASSWORD Biometrico Banca Movil
   @o_valida_imagen       tinyint       = null      out,   --AFE: Validacion de cambio de imagen
   @o_fingerprint_key  	  varchar(255)  = null      out, --DBA: llave publica autenticacion por huella
   @o_fingerprint_key_name varchar(30)  = null      out, --DBA: nombre keystore autenticacion por huella
   @o_fingerprint_state   char(1)  		= null      out  --DBA: estado autenticacion por huella
)
as
declare
   @w_login                      varchar(64),
   @w_clave_temp                 varchar(64),
   @w_clave_def                  varchar(64),
   @w_dias_vig                   smallint,
   @w_parametro                  varchar(10),
   @w_tipo_vig                   char(1),
   @w_renovable                  char(1),
   @w_dias                       int,
   @w_fecha_ult_pwd              datetime,
   @w_dias_param                 int,
   @w_sp_name                    varchar(64),
   @w_fax                        varchar(64),
   @w_email                      varchar(64),
   @w_estado                     char(1),
   @w_intento_1                  smallint,
   @w_intento_2                  smallint,
   @w_intento_5                  smallint,
   @w_intento_6                  smallint,
   @w_total                      smallint,
   @w_max_intent                 smallint,
   @w_msg                        varchar(132),
   @w_servicio                   int,
   @w_return                     int,
   @w_perfil_alterno             varchar(10),    --LPO: 20050708
   @w_activar                    char(1),        --LPO: 20050708
   @w_num_prods                  int,            --LPO: 20050708
   @w_num_ctas                   int,            --LPO: 20050708
   @w_num_prod_cte               tinyint,        --LPO: 20050708
   @w_num_prod_aho               tinyint,        --LPO: 20050708
   @w_num_prod_vis               tinyint,        --LPO: 20050708
   @w_num_prod_tdb               tinyint,        --gagm1050 29/ago/2006
   @w_tipo_per                   char(1),        --LPO: 20050708
   @w_c_cuenta                   varchar(30),
   @w_c_prod                     int,
   @w_c_prod_ant                 int,
   @w_c_cant                     int,
   @w_num_prod_dpf               int,
   @w_num_prod_cre               int,
   @w_serv_publ                  int,
   @w_nlogin                     varchar(64),  --cmeg 7-Jun-2010
   @w_npassword                  varchar(64),   --cmeg 7-Jun-2010
   --ini cag 16-Nov-2011 CADUCIDAD DE PIN TEMPORAL
   @w_tipo_caducidad_pin_tmp     varchar(2),
   @w_frec_caducidad_pin_tmp     int,
   @w_factor                     int,
   @w_dif_tiempo_pin_tmp         int,
   @w_emailbco                   varchar(30),
   @w_email_cliente              varchar(128),
   @w_body                       varchar(255),
   @w_template                   smallint,
   --Fin cag 16-Nov-2011 CADUCIDAD DE PIN TEMPORAL
   @w_usuario_c_i18n             varchar(255), -- GQU 02-Abr-2012
   @w_usuario_b_i18n             varchar(255),  -- GQU 02-Abr-2012
   @w_clave_t_c_i18n             varchar(255), -- GQU 02-Abr-2012
   @w_phone_number               varchar(20),
   @w_phone_udid                 varchar(60),
   @w_lo_ente                    int,       --Biometrico Banca Movil
   @w_param_idem                 tinyint,
   @w_time_idem                  datetime,
   @w_idem_diff                  int,
   @w_tipo_envio                 varchar(10),
   @w_banco                      varchar(100),
   @w_canal                      varchar(100),
   @w_dir_web					 varchar(100),
   @w_telf_soporte				 varchar(60),
   @w_title						 varchar(100)

   

select @w_sp_name = 'sp_inicia_sesion'
-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + ' 4.4.0.8'
   return 0
end

---- INTERNACIONALIZACION ----
exec cobis..sp_ad_establece_cultura
    @o_culture = @s_culture out
------------------------------

------ GQU Campo @i_culture para i18n ------------
if @i_culture <> 'NEUTRAL'
   select @s_culture=upper(@i_culture)
--------------------------------------------------
select @w_activar = 'S'

if @i_operacion = 'D'
begin
   delete bv_in_login with (HOLDLOCK)
   where il_server_name = @i_webserver

   if @@error <> 0
   begin
      -- ERROR EN LA ELIMINACION DE LA TABLA bv_in_login
      exec cobis..sp_cerror
      @t_from       = @w_sp_name,
      @i_num        = 1875024
      return 1
   end
   return 0
end

if @i_operacion = 'R' --Biometrico Banca Movil
begin
   if @i_servicio = 8 -- Insercion de los campos para el reconocimiento facial
   begin
      if @i_modo = 0 --afiliar bv_login biometrico
      begin
         if exists (select 1 from bv_login_devices
                    where ls_login    = @i_login
                    and ls_channel_id = @i_servicio
                    and ls_phone_udid = @i_phone_udid)
         begin
            update bv_login_devices
            set ls_biometric_state = @i_biometric_state
            where ls_login    = @i_login
            and ls_channel_id   = @i_servicio
            and ls_phone_udid    = @i_phone_udid
            if @@error <> 0
            begin
               -- ERROR EN EL UPDATE DE LA TABLA bv_login devices
               exec cobis..sp_cerror
               @t_from       = @w_sp_name,
               @i_num        = 17042
               return 17042
            end
         end
         else
         begin
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 17046
            --No hay registros en tabla bv_login_devices
            return 17046
         end

         if exists (select 1 from bv_login where lo_login    = @i_login
                                           and lo_servicio   = @i_servicio
                                           and lo_ente       = @w_lo_ente)
         begin
            update bv_login
            set lo_biometric_id    = @i_biometric_id,
                lo_biometric_state = @i_biometric_state
            where lo_login    = @i_login
            and lo_servicio   = @i_servicio
            and lo_ente       = @w_lo_ente
            if @@error <> 0
            begin
               -- ERROR EN EL UPDATE DE LA TABLA bv_login
               exec cobis..sp_cerror
               @t_from       = @w_sp_name,
               @i_num        = 17041
               return 17041
            end
         end
         else
         begin
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 17020
            --Error no hay un registro en bv_login con esas credenciales para canal Banca Móvil
            return 17020
         end
      end

      if @i_modo = 1 -- desafiliar bv_login de reconociminto facial
      begin
         if exists (select 1 from bv_login where lo_login = @i_login
                                           and lo_servicio   = @i_servicio
                                           and lo_ente       = @w_lo_ente)
         begin
            update bv_login
            set lo_biometric_id    = null,
                lo_biometric_state = @i_biometric_state
            where lo_login    = @i_login
            and lo_servicio   = @i_servicio
            and lo_ente       = @w_lo_ente
            if @@error <> 0
            begin
               -- ERROR EN EL UPDATE DE LA TABLA bv_login
               exec cobis..sp_cerror
               @t_from       = @w_sp_name,
               @i_num        = 17041
               return 17041
            end
        end
        else
        begin
           exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_num        = 17020
           --Error no hay un registro en bv_login con esas credenciales para canal Banca Móvil
           return 17020
        end

        if exists (select 1 from bv_login_devices where ls_login      = @i_login
                                               and ls_channel_id   = @i_servicio)
        begin
           update bv_login_devices
           set ls_biometric_state = @i_biometric_state
           where ls_login    = @i_login
           and ls_channel_id   = @i_servicio
           --and ls_phone_udid    = @i_phone_udid
           if @@error <> 0
           begin
              -- ERROR EN EL UPDATE DE LA TABLA bv_login_devices
              exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 17042
              return 17042
           end
        end
        else
        begin
           --No hay registros en tabla bv_login_devices
           exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_num        = 17046
           return 17046
        end
     end

     if @i_modo = 2 -- Ingreso Biométrico
     begin
        if @i_biometric_id = -1
        begin
           if exists (select 1 from bv_login_devices 
                               where ls_phone_udid = @i_phone_udid 
                               and ls_biometric_state = 'S')
           begin
              select @w_login = ls_login
              from bv_login_devices
              where ls_phone_udid    = @i_phone_udid
              and ls_biometric_state = 'S'
           end
           else
           begin  -- ERROR NO HAY DISPOSITIVOS
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17044
              return 17044
           end

           if exists (select 1 from bv_login 
                               where lo_login  = @w_login
                               and lo_servicio = @i_servicio)
           begin
              select @o_biometric_id = lo_biometric_id
              from bv_login
              where lo_login = @w_login
              and lo_servicio = @i_servicio
           end
           else
           begin     -- ERROR NO ESTA HABILITADO INGRESO BIOMETRICO
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17043
              return 17043
           end
        end
        else
        begin
           if exists (select 1 from bv_login_devices 
                               where ls_phone_udid    = @i_phone_udid 
                               and ls_biometric_state = 'S')
           begin
              select @w_login = ls_login
              from bv_login_devices
              where ls_phone_udid = @i_phone_udid
              and ls_biometric_state = 'S'
           end
           else
           begin  -- ERROR NO HAY DISPOSITIVOS
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17044
              return 17044
           end

           if exists (select 1 from bv_login 
                               where lo_login      = @w_login
                               and lo_servicio     = @i_servicio 
                               and lo_biometric_id = @i_biometric_id)
           begin
              select @o_biometric_password = lo_clave_def, @o_login = lo_login_personal, @o_cedula = lo_login
              from bv_login
              where lo_login = @w_login
              and lo_servicio = @i_servicio
              and lo_biometric_id = @i_biometric_id
           end
           else
           begin     -- ERROR NO ESTA HABILITADO INGRESO BIOMETRICO
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17043
              return 17043
           end
        end
     end

     if @i_modo = 3 -- Consulta del estado biometrico
     begin
        select @o_biometric_devices = D.ls_biometric_state,
               @o_biometric_login   = L.lo_biometric_state
        from bv_login L, bv_login_devices D
        where L.lo_login = D.ls_login
        and D.ls_phone_udid =  @i_phone_udid
        and D.ls_channel_id   = @i_servicio
        and L.lo_servicio = @i_servicio
     end
  end
return 0
end

if @i_operacion = 'F' --Fingerprint Banca Movil
begin
   if @i_servicio = 8 -- modos de operacion fingerprint para banca movil
   begin
      if @i_modo = 0 --enrroll bv_login fingerprint
      begin
         
		 select @w_lo_ente = lo_ente from cob_bvirtual..bv_login where lo_login = @i_login
         
		 if exists (select 1 from bv_login where lo_login    = @i_login
                                           and lo_servicio   = @i_servicio
                                           and lo_ente       = @w_lo_ente
										   and lo_estado	 = 'A')
         begin
			if exists (select 1 from bv_login_devices
                    where ls_login    = @i_login
                    and ls_channel_id = @i_servicio
                    and ls_phone_udid = @i_phone_udid)
			 begin
				if (@i_fingerprint_key is not null and @i_fingerprint_state = 'S')
				begin
					update bv_login_devices
					set ls_fingerprint_state = @i_fingerprint_state,
					ls_fingerprint_key    = @i_fingerprint_key,
					ls_fingerprint_key_name = @i_fingerprint_name
					where ls_login    = @i_login
					and ls_channel_id   = @i_servicio
					and ls_phone_udid    = @i_phone_udid
					if @@error <> 0
					begin
					   -- ERROR EN EL UPDATE DE LA TABLA bv_login devices
					   exec cobis..sp_cerror
					   @t_from       = @w_sp_name,
					   @i_num        = 17042
					   return 17042
					end
				end
				else
				begin
					exec cobis..sp_cerror
					@t_from       = @w_sp_name,
					@i_msg        = 'Parametros insuficientes',
					@i_sev        = 1,
					@i_num        = 17000--DBA Definir codigo de error					
					return 17000
				end
			 end
			 else
			 begin
				exec cobis..sp_cerror
				@t_from       = @w_sp_name,
				@i_num        = 17046
				--No hay registros en tabla bv_login_devices
				return 17046
			 end
         end
         else
         begin
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 17020
            --Error no hay un registro en bv_login con esas credenciales para canal Banca Móvil
            return 17020
         end
      end

      if @i_modo = 1 -- desafiliar bv_login fingerprint
      begin
        if exists (select 1 from bv_login_devices where ls_login      = @i_login
                                               and ls_channel_id   = @i_servicio)
        begin
           update bv_login_devices
           set ls_fingerprint_state = 'N',
		   ls_fingerprint_key    = '',
		   ls_fingerprint_key_name = ''
           where ls_login    = @i_login
           and ls_channel_id   = @i_servicio
		   and ls_phone_udid  = @i_phone_udid
           if @@error <> 0
           begin
              -- ERROR EN EL UPDATE DE LA TABLA bv_login_devices
              exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 17042
              return 17042
           end
        end
        else
        begin
           --No hay registros en tabla bv_login_devices
           exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_num        = 17046
           return 17046
        end
     end

     if @i_modo = 2 -- Obtener llave publica fingerprint
     begin
		if exists (select 1 from bv_login 
								   where lo_login      = @i_login
								   and lo_servicio     = @i_servicio 
								   and lo_estado	   = 'A')
		begin
			   if exists (select 1 from bv_login_devices 
								   where ls_phone_udid    = @i_phone_udid 
								   and ls_login			  = @i_login
								   and ls_fingerprint_state = 'S')
			   begin
				  select @o_fingerprint_key= ls_fingerprint_key
				  from bv_login_devices
				  where ls_phone_udid 	   = @i_phone_udid
				  and ls_fingerprint_state = 'S'
				  and ls_login			   = @i_login
			   end
			   else
			   begin  -- ERROR NO HAY DISPOSITIVOS O NO ESTA HABILITADO FINGERPRINT
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17044
				  return 17044
			   end
		end
		else
			   begin     -- ERROR NO ESTA HABILITADO INGRESO MOVIL -- Definir codigo de error
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17043
				  return 17043
			   end
     end

     if @i_modo = 3 -- Consulta del nombre de la keystore
     begin
		if exists (select 1 from bv_login 
								   where lo_login      = @i_login
								   and lo_servicio     = @i_servicio 
								   and lo_estado	   = 'A')
		begin
			if exists (select 1 from bv_login_devices 
								   where ls_phone_udid    = @i_phone_udid 
								   and ls_login			  = @i_login
								   and ls_fingerprint_state = 'S')
			   begin
				  select @o_fingerprint_key_name = ls_fingerprint_key_name
				  from bv_login_devices
				  where ls_phone_udid 	   = @i_phone_udid
				  and ls_fingerprint_state = 'S'
				  and ls_login			   = @i_login
			   end
			   else
			   begin  -- ERROR NO HAY DISPOSITIVOS O NO ESTA HABILITADO FINGERPRINT
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17044
				  return 17044
			   end
		end
		else
			   begin     -- ERROR NO ESTA HABILITADO INGRESO MOVIL -- Definir codigo de error
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17043
				  return 17043
		end
     end
	 if @i_modo = 4 -- Consulta el estado de la autenticacion por huella
     begin
		if exists (select 1 from bv_login 
								   where lo_login      = @i_login
								   and lo_servicio     = @i_servicio 
								   and lo_estado	   = 'A')
		begin
			if exists (select 1 from bv_login_devices 
								   where ls_phone_udid    = @i_phone_udid 
								   and ls_login			  = @i_login)
			   begin
				  select @o_fingerprint_state = ls_fingerprint_state
				  from bv_login_devices
				  where ls_phone_udid 	   = @i_phone_udid
				  and ls_login			   = @i_login
			   end
			   else
			   begin  -- ERROR NO HAY DISPOSITIVOS O NO ESTA HABILITADO FINGERPRINT
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17044
				  return 17044
			   end
		end
		else
			   begin     -- ERROR NO ESTA HABILITADO INGRESO MOVIL -- Definir codigo de error
				  exec cobis..sp_cerror
				  @t_from = @w_sp_name,
				  @i_num  = 17043
				  return 17043
		end
     end
	 
	 if @i_modo = 5 -- Ingreso fingerprint
     begin
           if exists (select 1 from bv_login_devices 
                               where ls_phone_udid    = @i_phone_udid 
                               and ls_fingerprint_state = 'S'
							   and ls_login = @i_login)
           begin
              select @w_login = ls_login
              from bv_login_devices
              where ls_phone_udid = @i_phone_udid
              and ls_fingerprint_state = 'S'
           end
           else
           begin  -- ERROR NO HAY DISPOSITIVOS
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17044
              return 17044
           end

           if exists (select 1 from bv_login 
                               where lo_login  = @w_login
                               and lo_servicio = @i_servicio)
           begin
              select @o_token = lo_clave_def, @o_login = lo_login_personal, @o_cedula = lo_login
              from bv_login
              where lo_login = @w_login
              and lo_servicio = @i_servicio
           end
           else
           begin     -- ERROR NO ESTA HABILITADO INGRESO HUELLA
              exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num  = 17043
              return 17043
           end
     end
  end
return 0
end

-- validacion de canal electr=nico
select @w_estado = se_habilitado
from bv_servicio
where se_servicio = @i_servicio

if @w_estado <> 'H'
begin
   -- Canal no habilitado al momento
   exec cobis..sp_cerror
   @t_from    = @w_sp_name,
   @i_num     = 1850125
   return 1850125
end

if @i_login = 'initerm'
   return 55

if @i_servicio = 2 and @i_login = 'ivr'
begin
   select @o_vez       = 1
   select @o_perfil    = 0
   select @o_cliente   = 0
   select @o_tipo_ente = ''
   return 55
end

--ini cag 16-Nov-2011 CADUCIDAD DE PIN TEMPORAL
select @w_tipo_caducidad_pin_tmp = pa_char
from cobis..cl_parametro
where pa_nemonico = 'TFCPBV'
and   pa_producto = 'BVI'

select @w_frec_caducidad_pin_tmp = pa_int
from  cobis..cl_parametro
where pa_nemonico = 'FCPTBV'
and   pa_producto = 'BVI'
--fin cag 16-Nov-2011

-- Valida login para canal especifico
select @w_login         = lo_login,
       @w_clave_temp    = lo_clave_temp,
       @w_clave_def     = lo_clave_def,
       @w_dias_vig      = lo_dias_vigencia,
       @w_parametro     = lo_parametro,
       @w_tipo_vig      = lo_tipo_vigencia,
       @w_renovable     = lo_renovable,
       @w_fecha_ult_pwd = lo_fecha_ult_pwd,
       @o_cliente       = lo_ente,
       @o_cliente_mis   = en_ente_mis,
       @o_des_login     = lo_descripcion,
       @w_servicio      = lo_servicio,
       @w_estado        = lo_estado,
       @w_intento_1     = isnull(lo_intento_1,0),
       @w_intento_2     = isnull(lo_intento_2,0),
       @w_intento_5     = isnull(lo_intento_5,0),
       @w_intento_6     = isnull(lo_intento_6,0),
       @o_cultura       = RTRIM(ISNULL(lo_cultura, 'NEUTRAL')),
       @o_tema          = isnull(lo_tema, 'default'),
       @o_tipo_persona  = en_tipo,                --/*** <03/11/2012> <JDP> <IB010A> ***/
       @o_token         = la_trx_auth_type,
       @o_estado_token  = la_trx_state,            --/*** <03/11/2012> <JDP> <IB010A> ***/
       @o_cedula        = en_ced_ruc,      -- MES 20130515
       @w_phone_number  = (select ls_phone_number from bv_login_devices where ls_login=@i_login and ls_channel_id=@i_servicio and ls_phone_udid = @i_phone_udid ),
       @w_phone_udid    = (select ls_phone_udid from bv_login_devices where ls_login=@i_login and ls_channel_id=@i_servicio and ls_phone_udid = @i_phone_udid )
  from bv_login
       left join bv_login_authentication on lo_login = la_login and la_trx_state  = 'A' and la_authorized = 'S',
       bv_ente with(index=1,nolock)--, cob_workflow..wf_inst_proceso, cob_credito..cr_b2c_registro
where lo_login          = @i_login
  and lo_servicio       = @i_servicio
  and lo_ente           = en_ente
  and en_autorizado = 'S'
  and lo_autorizado = 'S'
--  and lo_login      = la_login                    --/*** <02/11/2012> <JDP> <IB010A> ***/
--  and la_trx_state  = 'A'                         --/*** <02/11/2012> <JDP> <IB010A> ***/

-- Valida para todos los canales
if @@rowcount = 0
begin
   select top 1 @w_login         = lo_login,
                @w_clave_temp    = lo_clave_temp,
                @w_clave_def     = lo_clave_def,
                @w_dias_vig      = lo_dias_vigencia,
                @w_parametro     = lo_parametro,
                @w_tipo_vig      = lo_tipo_vigencia,
                @w_renovable     = lo_renovable,
                @w_fecha_ult_pwd = lo_fecha_ult_pwd,
                @o_cliente       = lo_ente,
                @o_des_login     = lo_descripcion,
                @w_servicio      = lo_servicio,
                @w_estado        = lo_estado,
                @w_intento_1     = isnull(lo_intento_1,0),
                @w_intento_2     = isnull(lo_intento_2,0),
                @w_intento_5     = isnull(lo_intento_5,0),
                @w_intento_6     = isnull(lo_intento_6,0),
                @o_cultura       = RTRIM(ISNULL(lo_cultura, 'NEUTRAL')),
                @o_tema          = isnull(lo_tema, 'default'),
                @o_tipo_persona  = en_tipo,                    --/*** <03/11/2012> <JDP> <IB010A> ***/
                @o_estado_token  = la_trx_state,                --/*** <03/11/2012> <JDP> <IB010A> ***/
                @o_cedula        = en_ced_ruc,        -- MES 20130515
                @w_phone_number  = '', --(select ls_phone_number from bv_login_devices where ls_login=lo_login ),
                @w_phone_udid    = '' --(select ls_phone_udid from bv_login_devices where ls_login=lo_login )
   --from bv_login with(index=1,nolock),
   --     bv_ente   with(index=1,nolock),
   --     bv_login_authentication with(index=1,nolock)    --/*** <02/11/2012> <JDP> <IB010A> ***/
    from bv_login
         left join bv_login_authentication on lo_login = la_login and la_trx_state  = 'A' and la_authorized = 'S',
         bv_ente with(index=1,nolock)
   where lo_login        = @i_login
     and lo_servicio     = 0
     and lo_ente         = en_ente
     and en_autorizado   = 'S'
     and lo_autorizado   = 'S'
     --and lo_login        = la_login                    --/*** <02/11/2012> <JDP> <IB010A> ***/
     --and la_trx_state    = 'A'                         --/*** <02/11/2012> <JDP> <IB010A> ***/
   if @@rowcount = 0
   begin
      -- Login no existe
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 1875000
     return 1875000
   end
end

--Validamos Autenticacion Banca Movil
if @i_servicio=8
begin
   --if ((@i_phone_number <> 'X' and @i_phone_number <> @w_phone_number) or (@i_phone_udid <> @w_phone_udid))
   if (@i_phone_udid <> @w_phone_udid)
   begin
      -- Numero telefonico o udid es incorrecto
      exec cobis..sp_cerror
      @t_from       = @w_sp_name,
      @i_msg        = @w_msg,
      @i_sev        = 1,
      @i_num        = 17000--MCH Definir codigo de error
      return 1875001
   end
end

--Valida que la autenticación sea por token cuando esté habilitado
if (@i_servicio = 1 and upper(@i_validate_token) <> 'N')
begin
		
   if exists (select *
              from   bv_login_authentication
              where  la_login = @i_login and la_authorized = 'N')
   begin
      -- El cliente no tiene autorizado el metodo de autenticacion.
      exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 1875268
      return 1875268
   end

   if exists (select *
              from   bv_login_authentication
              where  la_login = @i_login and
                     upper(la_trx_auth_type) = 'VASCO')
   begin
      -- Debe iniciar sesión utilizando el método de autenticación por token
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 1875228

      return 1875228
   end
end

--Tipo de Cliente BV
select @o_tipo_ente=en_tipo  
from cob_bvirtual..bv_ente
where en_ente=@o_cliente

if @i_servicio in (1,8)
   select @o_intentos = @w_intento_1 + 1
   select @o_login = @w_login
/*
--Determina Perfil para canal especifico
select @o_perfil         = es_perfil,
       @w_perfil_alterno = pe_cod_alterno,
       @o_des_perfil     = pe_nombre         --cmeg 15-Dic-2009
from bv_ente_servicio_perfil with(index=1,nolock),
bv_perfil with(index=1,nolock)
where es_ente            = @o_cliente
  and es_servicio        = @i_servicio
  and es_login           = @i_login
  and es_autorizado      = 'S'
  and es_perfil          = pe_perfil
if @@rowcount = 0
begin
   -- Determina Perfil para todos los canales
   select @o_perfil         = es_perfil,
          @w_perfil_alterno = pe_cod_alterno
     ,@o_des_perfil         = pe_nombre --cmeg 15-Dic-2009
   from bv_ente_servicio_perfil with(index=1,nolock), bv_perfil  with(index=1,nolock)
   where es_ente            = @o_cliente
     and es_servicio        = 0
     and es_login           = @i_login
     and es_autorizado      = 'S'
     and es_perfil          = pe_perfil
   if @@rowcount = 0
   begin
      -- Perfil no existe
      exec cobis..sp_cerror
         @t_from = @w_sp_name,
         @i_num  = 1850209
      return 1850209
   end
end

if not exists (select 1
               from bv_ente_servicio with (INDEX = 1,nolock), bv_login with (index=1,nolock)
               where es_ente = lo_ente
                  and ( es_servicio = @i_servicio or es_servicio = 0)
                  and es_estado = 'V')
begin
   -- Canal no asociado al cliente
   exec cobis..sp_cerror
       @t_from       = @w_sp_name,
       @i_num        = 1850111
   return 1850111
end
*/

if @i_servicio = 6
begin
   goto no_valida_passwd
end

-- Validar estado del cliente
if @w_estado in ('A')
begin
   -- Control de numero de intentos
   exec @w_return = sp_calcula_intentos
        @i_nom_cliente  = @o_des_login,
        @i_ente         = @o_cliente,
        @i_cultura      = @o_cultura,
        @i_login        = @i_login,
        @i_servicio     = @i_servicio,
        @i_canal        = @w_servicio,
        @i_estado       = @w_estado,
        @i_intento_1    = @w_intento_1,
        @i_intento_2    = @w_intento_2,
        @i_intento_5    = @w_intento_5,
        @i_intento_6    = @w_intento_6,
        @i_tipo         = '1',   -- Clave OK
        @s_culture      = @s_culture, --GQU 27-Jun-2012
        @o_msg          = @w_msg output,
        @o_activar      = @w_activar output

   if @w_return > 0
      return @w_return

   select @w_estado          = lo_estado
   from bv_login with(index=1,nolock) , bv_ente with(index=1,nolock)
   where   lo_login          = @i_login
           and lo_servicio   = @i_servicio
           and lo_ente       = en_ente
           and en_autorizado = 'S'
           and lo_autorizado = 'S'

   -- Valida para todos los canales
   if @@rowcount = 0
   begin
      select @w_estado        = lo_estado
      from bv_login with(index=1,nolock), bv_ente  with(index=1,nolock)
      where lo_login        = @i_login
         and lo_servicio     = 0
         and lo_ente         = en_ente
         and en_autorizado   = 'S'
         and lo_autorizado   = 'S'
   end
end  -- Validar estado del cliente

if @w_estado in ('B','I','C')
begin
   select  @w_usuario_c_i18n = re_valor -- GQU 03-Abr-2012
   from    cobis..ad_etiqueta_i18n
   where   pc_identificador    = 'b-cob_bvirtual'
   and     pc_codigo           = 'USUARIO_C'
   and     re_cultura          = @s_culture

   select  @w_usuario_b_i18n = re_valor   -- GQU 03-Abr-2012
   from    cobis..ad_etiqueta_i18n
   where   pc_identificador    = 'b-cob_bvirtual'
   and     pc_codigo           = 'USUARIO_B'
   and     re_cultura          = @s_culture

   -- Clave Bloqueada o Inactiva o Cancelada
   if @w_estado = 'C'
        exec cobis..sp_cerror
        @t_from       = @w_sp_name,
        @i_sev        = 1,
        @i_num        = 1802154
   else
       exec cobis..sp_cerror
        @t_from       = @w_sp_name,
        @i_sev        = 1,
        @i_num        = 1875066
   return 1875066
end
else if @w_estado in ('T')
begin
	exec cobis..sp_cerror
        @t_from       = @w_sp_name,
        @i_sev        = 1,
        @i_num        = 1890011
	return 1890011
end
else
begin
   -- Clave Activa
   if @w_clave_def is null
   begin
      if @w_clave_temp is null
      begin
        -- Clave incorrecta
         exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_msg        = @w_msg,
           @i_sev        = 1,
           @i_num        = 1875001
         return 1875001
      end
      -- Ingreso primera vez
      if @w_clave_temp <> @i_clave
      begin
         -- Control de numero de intentos
         exec @w_return     = sp_calcula_intentos
              @i_nom_cliente= @o_des_login,
              @i_ente       = @o_cliente,
              @i_cultura    = @o_cultura,
              @i_login      = @i_login,
              @i_servicio   = @i_servicio,
              @i_canal      = @w_servicio,
              @i_estado     = @w_estado,
              @i_intento_1  = @w_intento_1,
              @i_intento_2  = @w_intento_2,
              @i_intento_5  = @w_intento_5,
              @i_intento_6  = @w_intento_6,
              @i_tipo       = '0',   -- Clave NOK
              @s_culture    = @s_culture, --GQU 27-Jun-2012
              @o_msg        = @w_msg output
         if @w_return > 0
            return @w_return

         -- Clave incorrecta
         exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_msg        = @w_msg,
           @i_sev        = 1,
           @i_num        = 1875001
         return 1875001
      end


      --INI cag 21-Nov-2011
      --CONTROL DE TIEMPO DE CADUCIDAD DE PIN TEMPORAL
      select @w_dif_tiempo_pin_tmp = datediff(mi, @w_fecha_ult_pwd, getdate())

      if @w_tipo_caducidad_pin_tmp <> 'N'
      begin
         select @w_factor = @w_frec_caducidad_pin_tmp

         if @w_tipo_caducidad_pin_tmp = 'MI'
            select @w_factor = @w_factor * 1
         if @w_tipo_caducidad_pin_tmp = 'H'
            select @w_factor = @w_factor *60
         if @w_tipo_caducidad_pin_tmp = 'D'
            select @w_factor = @w_factor *24*60

         if @w_tipo_caducidad_pin_tmp = 'M'
            select @w_factor = @w_factor *(365*24*60)/12

         if @w_tipo_caducidad_pin_tmp = 'A'
            select @w_factor = @w_factor *365*24*60

         if @w_dif_tiempo_pin_tmp > @w_factor
         begin
            select  @w_clave_t_c_i18n = re_valor   -- GQU 03-Abr-2012
            from    cobis..ad_etiqueta_i18n
            where   pc_identificador    = 'b-cob_bvirtual'
            and     pc_codigo           = 'CLAVE_T_C'
            and     re_cultura          = @s_culture
            -- Clave temporal caducada
            exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 1875145 -- GQU 03-Abr-2012
            return 1875145     -- GQU 03-Abr-2012
         end
      end
      --FIN Cag 16-Nov-2011
      select @o_vez = 1
/*
      --ini cmeg 2-Jun-2010
      if @i_servicio = 7
      begin
         --AQUI SE DEBE DE INVOCAR AL SP QUE DEVUELVE EL TOKEN
         exec @w_return = sp_smart_phones_key_generator
         @i_login    = @i_login ,
         @i_password = @i_clave,
         @o_userKey  = @o_id_autenticacion out
      end
	  */
      --fin cmeg 2-Jun-2010
      select @o_cliente
      select 1
      return 55
   end -- Ingreso primera vez
   else
   begin
      -- Cliente ya registrado anteriormente
      select @o_vez = 0
	  if exists(select 1 from bv_login_imagen 
                         where li_login = @i_login
		    			 and li_imagen is null)
      begin
         select @o_valida_imagen = 1                       
      end 
      if @w_clave_def <> @i_clave
      begin	                            
         -- Control de numero de intentos
         exec @w_return = sp_calcula_intentos
            @i_nom_cliente = @o_des_login,
            @i_ente        = @o_cliente,
            @i_cultura     = @o_cultura,
            @i_login       = @i_login,
            @i_servicio    = @i_servicio,
            @i_canal       = @w_servicio,
            @i_estado      = @w_estado,
            @i_intento_1   = @w_intento_1,
            @i_intento_2   = @w_intento_2,
            @i_intento_5   = @w_intento_5,
            @i_intento_6   = @w_intento_6,
            @i_tipo        = '0',   -- Clave NOK
            @s_culture     = @s_culture, --GQU 27-Jun-2012
            @o_msg         = @w_msg output
         if @w_return > 0
            return @w_return

         -- Clave incorrecta
         exec cobis..sp_cerror
           @t_from       = @w_sp_name,
           @i_msg        = @w_msg,
           @i_sev        = 1,
           @i_num        = 1875001
         return 1875001
      end
   end

   select @w_dias = datediff(dd, @w_fecha_ult_pwd, getdate())

   if @w_dias <> 0
   begin-- si el mismo dia (w_fecha_ult_pwd) intenta ingresar
      if @w_tipo_vig = 'E' and @w_dias > @w_dias_vig
      begin
         if  @w_renovable = 'S'
         begin
            select @o_vez = 1
            select @o_cliente
            select 1
            return 55
         end
         else
         begin
            -- Clave expirada
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 1875005
            return 1875005
         end
      end

      if @w_tipo_vig = 'G'
      begin
         select @w_dias_param = pa_smallint
         from cobis..cl_parametro  with(index=1,nolock)
         where pa_nemonico = 'DVLO'
         if @w_dias > @w_dias_param
         begin
            if  @w_renovable = 'S'
            begin  -- control de cambio de clave para Excelsys - Globalbank
               select @o_vez = 1
               select @o_cliente
               select 1
               return 55
            end
            else
            begin
               -- Clave expirada
               exec cobis..sp_cerror
               @t_from       = @w_sp_name,
               @i_num        = 1875005
               return 1875005
            end
         end
      end
   end--mismo dia
end    -- Clave Activa

no_valida_passwd:

if @i_servicio in (1,5,6,7,8)
begin
   -- Verificar existencia de otros usuarios conectados desde el computador CRI 06/01/2000
   if (exists (select 1
              from bv_in_login with(index=0,nolock)
              where il_login       = @i_login
                and il_server_name = @i_webserver
                and il_terminal_ip = @i_terminal_ip) and @i_servicio <> 8)
   begin
      select @w_param_idem = pa_tinyint
      from cobis..cl_parametro
      where pa_nemonico = 'TIMIDE'
      and pa_producto   = 'BVI'
      
      select @w_time_idem = bv_timestamp
      from bv_session
      where bv_usuario = @i_login
      if (@w_time_idem is null)
      begin
         select @w_time_idem = il_fecha_in
         from bv_in_login with(index=0,nolock)
         where il_login      = @i_login
      end
      
      select @w_idem_diff = datediff(n, @w_time_idem, getdate())
      
      if(@w_idem_diff > @w_param_idem)
      begin
         delete bv_session
         where bv_usuario   = @i_login
         
         delete bv_in_login
         where il_login     = @i_login
         if @@error <> 0
         begin
            -- ERROR EN EL REGISTRO DE USUARIO
            exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 1875022
            return 1875022
         end
         
         insert into bv_in_login with (HOLDLOCK)
         (il_login,    il_terminal_ip, il_server_name,
          il_sesiones, il_fecha_in)
         values
         (@i_login, @i_terminal_ip, @i_webserver,
          1, getdate())
         if @@error <> 0
         begin
            -- ERROR EN EL REGISTRO DE USUARIO
            exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 1875022
            return 1875022
         end
         
         select top 1 @o_terminal_ip      = il_terminal_ip,
                      @o_fecha_ult_acceso = convert(char(20),il_fecha_in, @i_formato_fecha) -- GQU 01-Mar-2012
         from  cob_bvirtual..bv_in_login_his
         where il_cliente = @o_cliente
          and  il_login   = @i_login
         order by il_fecha_in desc
         
         --VTO 21/Ago/2003 Log de conexiones realizadas
         insert into bv_in_login_his with (HOLDLOCK)
         (il_cliente,     il_login,   il_terminal_ip,
          il_server_name, il_fecha_in)
         values
           (@o_cliente,   @i_login,   @i_terminal_ip,
            @i_webserver,    getdate())
         if @@error <> 0
         begin
           -- ERROR EN EL REGISTRO DE USUARIO
           exec cobis..sp_cerror
             @t_from       = @w_sp_name,
             @i_num        = 1875022
           return 1875022
         end

         if @i_servicio in (1,8)
         begin
            update bv_login with (HOLDLOCK)
            set lo_fecha_ult_ing = getdate(),
                lo_intento_1     = @w_intento_1,
                lo_intento_2     = @w_intento_2,
                lo_intento_5     = @w_intento_6,
                lo_intento_6     = @w_intento_6
            from bv_login, bv_ente
            where    lo_login      = @i_login
                 and lo_servicio   = @i_servicio
                 and lo_ente       = en_ente
                 and en_autorizado = 'S'
                 and lo_autorizado = 'S'
                 and lo_estado = 'A'

            if @@rowcount != 1
            begin
            -- Error en actualizacion de login
                exec cobis..sp_cerror
                   @t_from       = @w_sp_name,
                   @i_num        = 1850067
                return 1850067
            end
         end           
      end
      else
      begin   
         -- YA EXISTE UN USUARIO CONECTADO DESDE SU COMPUTADOR. POR FAVOR CIERRE LAS SESIONES ABIERTAS ANTES DE CONTINUAR
         exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 1875125   -- PCL - 2011.07.25 - Solamente se revisa conexion de maquina
         return 1875125
      end
   end      
   else
   begin
   
    select @w_param_idem = pa_tinyint
	from cobis..cl_parametro
	where pa_nemonico= 'MTDS'
	and pa_producto = 'BVI'	
	
	
	select @w_idem_diff =datediff(MINUTE,il_fecha_in,getDate()) 
	from cob_bvirtual..bv_in_login with(index=0,nolock)
	where il_login =@i_login
	and il_server_name = @i_webserver
	
	if(@w_idem_diff>= @w_param_idem)
	begin
		delete bv_session
        where bv_usuario   = @i_login
         
        delete bv_in_login
        where il_login     = @i_login
	end
	  
      -- Verificar existencia de usuario conectado CRI 03/03/2000
      if exists (select 1
                 from bv_in_login with(index=0,nolock)
                where il_login       = @i_login
                  and il_server_name = @i_webserver
                  and il_terminal_ip <> @i_terminal_ip)
      begin
         -- USUARIO YA SE ENCUENTRA CONECTADO DESDE OTRO COMPUTADOR
         exec cobis..sp_cerror
            @t_from       = @w_sp_name,
			   @i_msg		  = 'Se detectó que ya existe una sesión abierta, solo se permite un acceso a la vez',
            @i_num        = 1875023
         return 1875023
      end
      else
      begin
         begin tran
         if @w_activar = 'S'
         begin
            select  @w_intento_1 = 0,
                    @w_intento_2 = 0,
                    @w_intento_5 = 0,
                    @w_intento_6 = 0
         end

         -- Para servicio 8 se borra porque si se ingresa desde el mismo terminal
         -- es incorrecto impedir el inicio de sesion
         if @i_servicio = 8
         begin
            delete bv_in_login
            where il_login     = @i_login
            and il_server_name = @i_webserver
            and il_terminal_ip = @i_terminal_ip
         end

         insert into bv_in_login with (HOLDLOCK)
         (il_login,    il_terminal_ip, il_server_name,
          il_sesiones, il_fecha_in)
         values
         (@i_login, @i_terminal_ip, @i_webserver,
          1, getdate())

         if @@error <> 0
         begin
            -- ERROR EN EL REGISTRO DE USUARIO
            exec cobis..sp_cerror
              @t_from       = @w_sp_name,
              @i_num        = 1875022
            return 1875022
         end
         select top 1 @o_terminal_ip      = il_terminal_ip,
                      @o_fecha_ult_acceso = convert(char(20),il_fecha_in, @i_formato_fecha) -- GQU 01-Mar-2012
         from  cob_bvirtual..bv_in_login_his
         where il_cliente = @o_cliente
          and  il_login   = @i_login
         order by il_fecha_in desc
         --VTO 21/Ago/2003 Log de conexiones realizadas
         insert into bv_in_login_his with (HOLDLOCK)
         (il_cliente,     il_login,   il_terminal_ip,
          il_server_name, il_fecha_in)
         values
           (@o_cliente,   @i_login,   @i_terminal_ip,
            @i_webserver,    getdate())
         if @@error <> 0
         begin
           -- ERROR EN EL REGISTRO DE USUARIO
           exec cobis..sp_cerror
             @t_from       = @w_sp_name,
             @i_num        = 1875022
           return 1875022
         end

         if @i_servicio in (1,8)
         begin
            update bv_login with (HOLDLOCK)
            set lo_fecha_ult_ing = getdate(),
                lo_intento_1     = @w_intento_1,
                lo_intento_2     = @w_intento_2,
                lo_intento_5     = @w_intento_6,
                lo_intento_6     = @w_intento_6
            from bv_login, bv_ente
            where    lo_login      = @i_login
                 and lo_servicio   = @i_servicio
                 and lo_ente       = en_ente
                 and en_autorizado = 'S'
                 and lo_autorizado = 'S'
                 and lo_estado = 'A'

            if @@rowcount != 1
            begin
            -- Error en actualizacion de login
                exec cobis..sp_cerror
                   @t_from       = @w_sp_name,
                   @i_num        = 1850067
                return 1850067
            end

         end

         if @i_servicio = 2
         begin
            update bv_login with (HOLDLOCK)
            set lo_fecha_ult_ing2 = getdate(),
                lo_intento_1      = @w_intento_1,
                lo_intento_2      = @w_intento_2,
                lo_intento_5      = @w_intento_6,
                lo_intento_6      = @w_intento_6
            from bv_login, bv_ente
            where    lo_login      = @i_login
                 and lo_servicio   = @i_servicio
                 and lo_ente       = en_ente
                 and en_autorizado = 'S'
                 and lo_autorizado = 'S'
            if @@rowcount != 1
            begin
            -- Error en actualizacion de login
                exec cobis..sp_cerror
                   @t_from       = @w_sp_name,
                   @i_num        = 1850067
                return 1
            end
         end
         select @o_sessionid = @s_ssn
         COMMIT TRAN

         select @w_emailbco = isnull(pa_char,'usuario1@capital.com.pa')
         from cobis..cl_parametro
         where pa_nemonico = 'IBFROM'
         and pa_producto = 'BVI'

         select @w_email_cliente = me_num_dir
         from bv_medio_envio
         where me_ente  = @o_cliente
         and me_login   = @i_login
         and me_tipo    = 'MAIL'
         and me_default ='S'

         /*
         if not (@w_email_cliente is null)
         begin

            select @w_template = me_template
            from bv_mensaje
            where me_nemonico = 'USERLOGIN'
            and me_cultura  = @o_cultura

            if @@rowcount <> 1
            begin
               -- Error al obtener template
               exec cobis..sp_cerror
                   @t_from       = @w_sp_name,
                   @i_num        = 1850340
                 return 1850340
            end

            select @w_body = '<?xml version="1.0" encoding="UTF-8"?><data><cliente>' +ltrim(rtrim(@o_des_login))
            select @w_body = @w_body + '</cliente><ip>' + @i_terminal_ip + '</ip></data>'

            exec @w_return = cob_bvirtual..sp_despacho_ins
               @i_cliente         = @o_cliente,
               @i_servicio        = @i_servicio,
               @i_estado          = 'P',
               @i_tipo            = 'MAIL',
               @i_tipo_mensaje    = '',
               @i_prioridad       = '',
               @i_num_dir         = '',
               @i_from            = @w_emailbco,
               @i_to              = @w_email_cliente,
               @i_cc              = ' ',
               @i_bcc             = ' ',
               @i_subject         = 'BIENVENIDO A INTERNET BANKING',
               @i_body            = @w_body,
               @i_content_manager = 'HTML',
               @i_retry           = 'N',
               @i_te_id           = @w_template,
               @i_producto        = 18,
               @i_login           = @i_login,
               @i_notif           = 'N13'
            if @w_return <> 0
            begin
               -- Error al obtener template
               exec cobis..sp_cerror
                   @t_from       = @w_sp_name,
                   @i_num        = 999999
                 return 999999
            end
         end*/
      end
   end

   -- REGISTRO LOG B2C
	exec cob_bvirtual..sp_b2c_registro_transacciones
		@s_ssn = @s_ssn,
		@s_lsrv = @i_webserver,
		@s_date = @s_date,
		@i_tipo_tran = 1500,
		@i_login = @i_login,
		@i_ip_origen = @i_dir_origen
      
end

--/*** <02/11/2012> <JDP> <IB0010A> ***/
if @i_servicio = 2
begin
      select  @i_login='S'
      return 0
end



-- Se añade notificacion al momento de ingresar al sistema
select 1 from bv_notificacion where no_estado ='A' and no_id = 'N94'

if @@rowcount != 0
begin
	select @w_template = me_te_id
	from bv_mensaje
	where me_cultura  = @o_cultura
	and me_nemonico = 'SUCCESSACCES'
	and me_medio = 'MAIL'

	select @w_banco = pa_char
	from cobis..cl_parametro
	where pa_nemonico = 'CLINAM'
	and pa_producto = 'BVI'

	select @w_dir_web = pa_char
	from cobis..cl_parametro
	where pa_nemonico = 'IBWWW'
	and pa_producto = 'BVI'

	select @w_telf_soporte = pa_char
	from cobis..cl_parametro
	where pa_nemonico = 'IBTELF'
	and pa_producto = 'BVI'	 

	if @i_servicio = 1
		select @w_canal = 'Electrónica'
	else
		select @w_canal = 'Movil'

	-- Se añade la notificacion al inicio de la session 
	select @w_body = '<?xml version="1.0" encoding="utf-8"?><data><cliente>' +ltrim(rtrim(@o_des_login))
	select @w_body = @w_body + '</cliente><banco>' + @w_banco + '</banco><canal>' + @w_canal 
	select @w_body = @w_body + '</canal><fecha>' + convert(char(20),getdate(), @i_formato_fecha) 
	select @w_body = @w_body + '</fecha><correo_ib>' + @w_emailbco 
	select @w_body = @w_body + '</correo_ib><telef_ib>' + @w_telf_soporte
	select @w_body = @w_body + '</telef_ib></data>'
      
	  
	select @w_email_cliente    = me_num_dir,
			@w_tipo_envio = me_tipo
	from bv_medio_envio
	where me_login = @i_login
	and me_default = 'S'

	select @w_title = 'ACCESO EXITOSO A BANCA '+ upper( @w_canal)

	if @@rowcount > 0
	begin
		execute @w_return             = cob_bvirtual..sp_despacho_ins
				@i_cliente            = @o_cliente,
				@t_trn                = 1875901,
				@i_servicio           = @i_servicio,
				@i_estado             = 'P',
				@i_tipo               = 'MAIL',
				@i_prioridad          = 1,
				@i_from               = @w_email_cliente,
				@i_to                 = @w_email_cliente,
				@i_subject            = @w_title,
				@i_body               = @w_body,
				@i_content_manager    = 'HTML',
				@i_retry              = 'N',
				@i_tries              = 0,
				@i_max_tries          = 0,
				@i_num_dir            = @i_login,
				@i_te_id              = @w_template
		if @w_return != 0
		begin
		/* error al establecer la contraseña  temporal*/
		exec cobis..sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 1802146
		return 1802146
		end
	end
end
--/*** Termina ***/

return 55
GO