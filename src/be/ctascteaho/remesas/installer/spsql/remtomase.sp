/****************************************************************************/
/*     Archivo:          remtomase.sp                                       */
/*     Stored procedure: sp_acuse_remesas                                   */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Ahorros                                            */
/*     Disenado por:     Karen Meza                                         */
/*     Fecha de escritura: 29/06/2016                                       */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     29/06/2016     Roxana Sánchez      Migracion a CEN                   */
/****************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_mto_marca_servicio')
        drop proc sp_mto_marca_servicio
go

CREATE proc sp_mto_marca_servicio (
@s_ssn           int,
@s_ssn_branch    int               = null,
@s_srv	         varchar(30),
@s_lsrv          varchar(30),
@s_user          varchar(30)       = 'sa',
@s_term          varchar(10)       = 'consola',
@s_date          datetime,
@s_ofi           smallint,
@s_org_err       char(1)           = null,        /* Origen de error: [A], [S] */
@s_error         int               = null,
@s_sev           tinyint           = null,
@s_msg           mensaje           = null,
@s_org           char(1)           = 'U',
@s_rol           int               = null,
@t_corr          char(1)           = 'N',
@t_ssn_corr      int               = null,        /* Trans a ser reversada */
@t_debug         char(1)           = 'N',
@t_file          varchar(14)       = null,
@t_from          varchar(32)       = null,
@t_rty           char(1)           = 'N',
@t_trn           smallint,
@i_producto      tinyint,
@i_cuenta        varchar(24)       = null, 
@i_servicio      catalogo          = null,
@i_operacion     char(1),
@i_habilitado    char(1)           = null,
@i_observacion   varchar(32)       = null,
@i_comercio      varchar(15)       = null, --E.Ochoa Cambio en la longitud del codigo de comercio de 12 a 15 RQ502
@i_celular       varchar(12)       = null,
@i_cliente       int               = null,
@i_cuenta_nueva  varchar(24)       = null
)

as
declare	
@w_return        int,
@w_sp_name       varchar(30),
@w_mensaje       varchar(120),
@w_filial        tinyint,
@w_fecha         datetime,
@w_producto      tinyint,
@w_tipo          varchar(3),
@w_nombre        varchar(30),
@w_secuencial	 int,
@w_existe        char(1),
@w_fecha_mod     datetime,
@w_habilitado    char(1),
@w_ente          int,
@w_operador      char(3),
@w_cuenta        int,
@w_msg           varchar(255),
@w_cliente       int,
@w_commit        char(1),
/********  INFORMACION PARA GENERACION DE OTP  **************/
@w_estado        char(1),
@w_error         int,
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
/********  MIGRACION CTS  **************/
@w_version_cts_trn  varchar(30),
@w_version_cts_base varchar(30),
@w_genera_otp       char(1)

if @i_servicio = 'COM'
begin

--Parametro de version base cts
select @w_version_cts_base = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'VCTSB'

if @w_version_cts_base is null begin
  exec cobis..sp_cerror
  @t_debug = @t_debug,
  @t_file  = @t_file,
  @t_from  = @w_sp_name,
  @i_num   = 2600023,
  @i_msg   = 'PARAMETRO VCTSB NO EXISTE'

  return 2600023
end

select @w_genera_otp = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'GOTP'

select @w_version_cts_trn = valor 
from   cobis..cl_catalogo c, cobis..cl_tabla t
where  c.tabla  = t.codigo
and    t.tabla  = 'ws_version_cts'
and    c.codigo = 26521
and    c.estado = 'V'

if @@rowcount = 0
   select @w_version_cts_trn = @w_version_cts_base --Valor por defecto

end -- Si es comercio

-- Captura nombre de Stored Procedure 
select	@w_sp_name = 'sp_mto_marca_servicio', @w_commit = 'N'

select @w_fecha = @s_date

-- Consulta Servicio
if @i_operacion = 'H'
begin
   select @w_ente = en_ente
   from cobis..cl_ente,
        cob_ahorros..ah_cuenta
   where ah_cliente = en_ente
   and   ah_cta_banco = @i_cuenta

   select rtrim(ltrim(te_prefijo)) + rtrim(ltrim(te_valor)), (select c.valor from 
                                  cobis..cl_tabla t,
                                  cobis..cl_catalogo c
                                  where t.codigo = c.tabla
                                  and   t.tabla  = 'cl_tipo_operador' 
                                  and   c.codigo = te_tipo_operador
                                  and   c.estado = 'V')
   from cobis..cl_telefono 
   where te_ente          = @w_ente
   and   te_tipo_telefono = 'C'
end

if @i_operacion = 'V'
begin
   select @w_ente = en_ente
   from cobis..cl_ente,
        cob_ahorros..ah_cuenta
   where ah_cliente = en_ente
   and   ah_cta_banco = @i_cuenta

   select (select c.valor from 
          cobis..cl_tabla t,
          cobis..cl_catalogo c
          where t.codigo = c.tabla
          and   t.tabla  = 'cl_tipo_operador' 
          and   c.codigo = te_tipo_operador)
   from cobis..cl_telefono 
   where te_ente = @w_ente
   and   te_tipo_telefono = 'C'
   and   te_prefijo + te_valor = @i_celular
end

if @i_operacion = 'S'
begin
   select  'PRODUCTO'         = case mc_producto when 3 then 'CORRIENTES' else 'AHORROS' end,
           'CUENTA'           = mc_cuenta,
           'SERVICIO'         = mc_servicio,
           'DESC. SERVICIO'   = (select substring(valor,1,30) from cobis..cl_catalogo
                                 where tabla = (select codigo from cobis..cl_tabla
                                                where tabla = 're_marca_servicio')
                                 and codigo  = a.mc_servicio),
           'COMERCIO'         = mc_comercio, 
           'CELULAR'          = mc_num_celular,
           'OPERADOR'         = (select valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                 where t.codigo = c.tabla
                                 and   t.tabla  = 'cl_tipo_operador' 
                                 and   c.codigo = a.mc_tipo_operador),
           'ESTADO'           = mc_habilitado,
           'FECHA REG'        = convert(varchar,mc_fecha_ing,103),
           'USUARIO'          = mc_login,
           'FECHA MOD'        = convert(varchar,mc_fecha_mod,103)
   from cob_remesas..re_marcacion_cuentas a
   where mc_producto = @i_producto
   and mc_cuenta     = @i_cuenta
   
   if (@@rowcount = 0) 
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105506

      return 105506
   end   
end

if @i_operacion = 'I'
begin
   if exists (select 1 from cob_remesas..re_marcacion_cuentas where mc_cuenta = @i_cuenta and mc_servicio = @i_servicio)
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101186,
      @i_msg   = 'REGISTRO A INGRESAR YA EXISTE'      

      return 101186
   end
   else
   begin
  
      if @i_servicio = 'COM'
      begin
         if exists (select 1 from cob_remesas..re_marcacion_cuentas where mc_servicio = @i_servicio and mc_comercio = @i_comercio and mc_habilitado = 'S')
         begin
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_msg    = 'COMERCIO YA TIENE CUENTA CON EL SERVICIO ACTIVO',
            @i_num	   = 101186
 
            return 101186
         end
     
         select @w_cuenta = ah_cuenta,
       @w_ente   = ah_cliente,
                @w_ced_ruc = ah_ced_ruc
         from cob_ahorros..ah_cuenta 
         where ah_estado       = 'A' 
         and   ah_cta_banco    = @i_cuenta
         and   ah_ctitularidad in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                                   where c.tabla = t.codigo
                                   and   t.tabla = 'ah_titularidad'
                                   and   c.estado = 'V')
         and   ah_cuenta       not in (select cb_cuenta 
                                       from cob_ahorros..ah_ctabloqueada 
                                       where cb_estado       = 'V'
                                       and   cb_tipo_bloqueo = 3)
         and   ah_prod_banc    <> (select pa_smallint 
                                from cobis..cl_parametro     
                                where pa_producto = 'AHO' 
                                and pa_nemonico = 'PBCB')

         if isnull(@w_cuenta, 0) = 0
         begin
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 2609874
    
            return 2609874

         end
         
         if @w_genera_otp = 'S' begin
         --Obteniendo canal para WS       
         select @w_canal = convert(varchar(2),cl_catalogo.codigo)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_canal_enroll'
	           and cl_catalogo.estado = 'V'
               and cl_catalogo.valor  = 'BMOVIL'

	     
         exec @w_return = cobis..sp_datos_cliente
              @i_cedruc       = @w_ced_ruc,
			  @i_ente         = @w_ente,
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
		    exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num	  = 357537

            return 357537
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
		 		    
		 --Origen de ingresos
		 select @w_origen_ing = convert(varchar(10),cl_catalogo.valor)
         from cobis..cl_catalogo, cobis..cl_tabla
	     where cl_catalogo.tabla = cl_tabla.codigo and 
               cl_tabla.tabla         = 're_orgfon_enroll'
	           and cl_catalogo.estado = 'V'
               and cl_catalogo.codigo = @w_origen_ing
		 
         -- Se inicializa como exitosa la variable de estado      
         select @w_estado = 'A', @w_error = 0
               
         --CONSULTAR COMO INVOCAR AL SERVIDOR DE MIDDLEWARE
		 if @w_version_cts_trn = @w_version_cts_base begin	
			 exec @w_return = CTSXPSERVER.cob_procesador..sp_act_relacion_canal
				  @t_trn          = 26521,
				  @s_ofi          = @s_ofi,
				  @s_user         = @s_user,
				  @s_rol          = @s_rol, 
				  @i_bin          = '0',       -- Parametro General 371
				  @i_tipo_cta     = '11',
				  @i_num_cuenta   = @i_cuenta,
				  @i_tipo_identi  = @w_tipo_identi,
				  @i_num_identi   = @w_ced_ruc,
				  @i_nom_tarj     = @w_nombres,
				  @i_ape_tarj     = @w_apellidos,
				  @i_nom_corto    = @w_nomcorto,
				  @i_cta_prin     = 'P', 
				  @i_dir          = @w_direccion,
				  @i_cod_depar    = @w_dpto,
				  @i_id_ciudad    = @w_ind_ciudad,
				  @i_telefono     = @i_celular,
				  @i_email        = @w_email,
				  @i_acti_eco     = @w_actividad,
				  @i_ori_ingre    = @w_origen_ing,
				  @i_cod_ofi      = @s_ofi,
				  @i_cod_muni     = @w_ciudad,
				  @i_tipo_novedad = '01',           -- GENERACION DE OTP CUANDO EL CANAL ES BANCAMOVIL
				  @i_num_prod     = '0',    -- Parametro General 371
				  @i_num_prod_new = '0',
				  @i_canal        = @w_canal,           -- CANAL BANCAMOVIL
				  @i_motivo_bloq  = null,
				  @i_num_celular  = @i_celular,
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
				  @i_bin          = '0',       -- Parametro General 371
				  @i_tipo_cta     = '11',
				  @i_num_cuenta   = @i_cuenta,
				  @i_tipo_identi  = @w_tipo_identi,
				  @i_num_identi   = @w_ced_ruc,
				  @i_nom_tarj     = @w_nombres,
				  @i_ape_tarj     = @w_apellidos,
				  @i_nom_corto    = @w_nomcorto,
				  @i_cta_prin     = 'P', 
				  @i_dir          = @w_direccion,
				  @i_cod_depar    = @w_dpto,
				  @i_id_ciudad    = @w_ind_ciudad,
				  @i_telefono     = @i_celular,
				  @i_email        = @w_email,
				  @i_acti_eco     = @w_actividad,
				  @i_ori_ingre    = @w_origen_ing,
				  @i_cod_ofi      = @s_ofi,
				  @i_cod_muni     = @w_ciudad,
				  @i_tipo_novedad = '01',           -- GENERACION DE OTP CUANDO EL CANAL ES BANCAMOVIL
				  @i_num_prod     = '0',    -- Parametro General 371
				  @i_num_prod_new = '0',
				  @i_canal        = '03',           -- CANAL BANCAMOVIL
				  @i_motivo_bloq  = null,
				  @i_num_celular  = @i_celular,
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
		    select @w_mensaje = 'ERROR SOLICITANDO GENERACION DE OTP PARA COMERCIO',
		           @w_error = 357536, @w_estado = 'X'
		    goto ERRORWS
         end
		

         if @w_codigo_enrol <> 'OK000'
         begin
		    select @w_mensaje = isnull(@w_mensaje,'RESPUESTA FALLIDA PARA GENERACION DE OTP COMERCIO'),
		           @w_error = 357536, @w_estado = 'X'
		    goto ERRORWS
         end
         
         
         ERRORWS:
         
         --Insertando en la tran servicio del webservice de middleware
         insert into cobis..ws_tran_servicio 
         ( ts_ssn, ts_usuario, ts_terminal, 
           ts_fecha, ts_hora, ts_tipo_tran, 
           ts_estado, ts_correccion, ts_sec_ext,
           ts_hora_est, ts_campo1, ts_campo2,
           ts_prod_orig, 
           ts_banco_orig, ts_campo3, ts_campo4, 
           ts_campo5, ts_campo6, 
           ts_campo10, ts_retorno, ts_campo8, ts_conciliado, 
           ts_oficina, ts_cod_alterno )
         values (@s_ssn, @s_user, @s_term, 
           @s_date, getdate(), @t_trn, 
           isnull(@w_estado,'_'), 'N', @w_num_ref, 
           @s_date, @w_tipo_identi, @w_ced_ruc,
           4, 
           @i_cuenta, @w_nombres, @w_apellidos, 
           @i_celular, @w_num_autoriza, 
           @w_mensaje, isnull(@w_error,@w_return), @w_codigo_enrol, 'N', 
           @s_ofi, 1 )
                      
         if @@error <> 0 or @w_error <> 0
         begin                     
            
            if @@error <> 0
            begin   
               select @w_mensaje = 'ERROR INSERTANDO TRANSACCION SERVICIO GENERACION OTP',
                      @w_error = 357536
            end
                       
		    exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num	  = @w_error,
            @i_msg   = @w_mensaje

            return @w_error
         end
         end--Parametro generacion OTP
         select @w_operador = (select c.codigo from cobis..cl_tabla t, cobis..cl_catalogo c
                               where t.codigo = c.tabla
                               and   t.tabla  = 'cl_tipo_operador' 
                               and   c.codigo = te_tipo_operador
                               and   c.estado = 'V')
         from cobis..cl_telefono 
         where te_ente               = @w_ente
         and   te_tipo_telefono      = 'C'
         and   te_prefijo + te_valor = @i_celular
       
      end   -- FIN SI ES COMERCIO
   
      begin tran
      select @w_commit = 'S'
      
      insert into cob_remesas..re_marcacion_cuentas
      (mc_producto,    mc_cuenta,     mc_servicio,
       mc_habilitado,  mc_fecha_ing,  mc_observacion,
       mc_login,       mc_comercio,   mc_tipo_operador,
       mc_num_celular)
      values
      (@i_producto,    @i_cuenta,     @i_servicio,
       @i_habilitado,  getdate(),     @i_observacion,
       @s_user,        @i_comercio,   @w_operador,
       @i_celular)   
 
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num	  = 357508

         return 357508
      end
   end
end 

if @i_operacion = 'U'
begin   
   if exists (select 1 from cob_remesas..re_marcacion_cuentas where mc_cuenta = @i_cuenta)
   begin
      select @w_habilitado = mc_habilitado,
             @w_fecha_mod  = mc_fecha_mod
      from cob_remesas..re_marcacion_cuentas
      where mc_producto = @i_producto
      and mc_cuenta     = @i_cuenta
      and mc_servicio   = @i_servicio
  
      --2. Si el @i_habilitado es N entonces ejecutar del conector nuevo (ejecucion de SP con linkedServer)
      -- SE COMENTA CODIGO DADO QUE LA HISTORIA FUE DESPLAZADA A SIGUIENTE SPRINT.
      --if @i_habilitado = 'N'
      --begin
      --
      --   exec @w_return = CTSXPSERVER2.cob_procesador..sp_desactiva_comercio
      --   @t_trn        = 26516,
      --   @s_user       = @s_user,
      --   @s_ofi        = @s_ofi,
      --   @o_msg        = @w_msg out
      --
      --   if @w_return <> 0
      --   begin
      --      exec cobis..sp_cerror
      --      @t_debug = @t_debug,
      --      @t_file  = @t_file,
      --      @t_from  = @w_sp_name,
      --      @i_msg   = @w_msg,
      --      @i_num   = 357006
      --
      --      return 357006
      --   end
      --end
      
      begin tran
      select @w_commit = 'S'
      
      update cob_remesas..re_marcacion_cuentas
      set mc_fecha_mod  = getdate(),
          mc_habilitado = @i_habilitado
      where mc_producto = @i_producto
      and   mc_cuenta   = @i_cuenta
      and   mc_servicio = @i_servicio
      
      if @@rowcount <> 1
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 357006
  
         return 357006
      end
   end
   else
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 701156

      return 701156
   end

   --1. Actualizar el numero de cuenta que proviene del FE solo para el servicio de comercio (@i_servicio= 'COM')
   if @i_servicio = 'COM'
   begin
      if exists (select 1 from cob_remesas..re_marcacion_cuentas where mc_cuenta = @i_cuenta_nueva)
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 357006,
         @i_msg   = 'CUENTA NUEVA YA TIENE MARCA DE SERVICIO COMERCIO',
         @i_sev   = 1                
  
         return 357006         
      end

      update cob_remesas..re_marcacion_cuentas
      set mc_fecha_mod    = getdate(),
          mc_habilitado   = isnull(@i_habilitado, mc_habilitado),
          mc_cuenta       = isnull(@i_cuenta_nueva, mc_cuenta),
		  mc_num_celular  = isnull(@i_celular, mc_num_celular)
      where mc_producto   = @i_producto
      and mc_cuenta       = @i_cuenta
      and   mc_servicio   = @i_servicio

      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 357006
  
         return 357006
      end
   end
end


--   Crear nueva Operacion (X) para consultar las cuentas del mismo cliente y las liste como catalogo para FE (numero de cuenta)
if @i_operacion = 'X'
begin

   select @w_cliente = ah_cliente
   from cob_ahorros..ah_cuenta with (nolock)
   where ah_cta_banco = @i_cuenta

   select 'CUENTAS AHORRO' = ah_cta_banco
   from cob_ahorros..ah_cuenta with (nolock)
   where ah_cliente      = @w_cliente
   and   ah_estado       not in ('C','G','N','I')
   and   ah_ctitularidad in (select c.codigo from cobis..cl_catalogo c, cobis..cl_tabla t
                             where c.tabla = t.codigo
                             and   t.tabla = 'ah_titularidad'
                             and   c.estado = 'V')
   and   ah_cuenta       not in (select cb_cuenta 
                                 from cob_ahorros..ah_ctabloqueada with (nolock)
                                 where cb_estado       = 'V'
                                 and   cb_tipo_bloqueo in ('1','2','3'))
   and   ah_prod_banc    <> (select pa_smallint 
                             from cobis..cl_parametro with (nolock)
                             where pa_producto = 'AHO' 
                             and pa_nemonico   = 'PBCB')

end

-- Creacion de Transaccion de Servicio
if @i_producto = 4 -- CTAS DE AHORROS
begin
  insert into cob_ahorros..ah_tran_servicio
  (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
   ts_usuario,    ts_terminal,         ts_oficina, 
   ts_hora,       ts_estado,           ts_cta_banco,
   ts_fecha,      ts_accion)
  values 
  (@s_ssn,         @t_trn,             @s_date, 
   @s_user,        @s_term,            @s_ofi, 
   getdate(),      @i_habilitado,      @i_cuenta,
   @w_fecha_mod,   @w_habilitado) 
      
  -- Error en creacion de transaccion de servicio 
  if @@error <> 0
  begin
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 353515

     return 353515
  end   
end
else 
begin  -- Transaccion de servicios en Cuentas corrientes 
  insert into cob_cuentas..cc_tran_servicio
    (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
     ts_usuario,    ts_terminal,         ts_oficina, 
     ts_hora,       ts_estado,           ts_cta_banco,
     ts_fecha,      ts_negociada)
  values 
    (@s_ssn,         @t_trn,             @s_date, 
     @s_user,        @s_term,            @s_ofi, 
     getdate(),      @i_habilitado,      @i_cuenta,
     @w_fecha_mod,   @w_habilitado) 
      
  -- Error en creacion de transaccion de servicio 
  if @@error <> 0
  begin
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 353515

     return 353515
  end 
end

select  'PRODUCTO'       = case mc_producto when 3 then 'CORRIENTES' else 'AHORROS' end,
        'CUENTA'         = mc_cuenta,
        'SERVICIO'       = mc_servicio,
        'DESC. SERVICIO' = (select substring(valor,1,30) from cobis..cl_catalogo
                            where tabla = (select codigo from cobis..cl_tabla
                                           where tabla = 're_marca_servicio')
                            and codigo = a.mc_servicio),
        'COMERCIO'       = mc_comercio, 
        'CELULAR'        = mc_num_celular,
        'OPERADOR'       = (select valor from cobis..cl_tabla t, cobis..cl_catalogo c
                            where t.codigo = c.tabla
                            and   t.tabla  = 'cl_tipo_operador' 
                            and   c.codigo = a.mc_tipo_operador),
        'ESTADO'         = mc_habilitado,
        'FECHA REG'      = convert(varchar,mc_fecha_ing,103),
        'USUARIO'        = mc_login,
        'FECHA MOD'      = convert(varchar,mc_fecha_mod,103)
from cob_remesas..re_marcacion_cuentas a
where mc_producto = @i_producto
and mc_cuenta   = @i_cuenta

if @w_commit = 'S'
begin
   commit tran
   select @w_commit = 'N'
end

return 0


GO