/**********************************************************************/
/*  Archivo:            b2c_sp_registro_opt.sp                        */
/*  Stored procedure:   sp_registro_opt                               */
/*  Base de datos:      cob_bvirtual                                  */
/*  Producto:           Mobil                                         */
/*  Disenado por:       Alexander Llandan                             */
/*  Fecha de escritura: 21-Ago-2022                                   */
/**********************************************************************/
/*                        IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  'COBISCORP SA',representantes exclusivos para el Ecuador de la    */
/*  AT&T                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como        */
/*  cualquier autorizacion o agregado hecho por alguno de sus         */
/*  usuario sin el debido consentimiento por escrito de la            */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante          */
/**********************************************************************/
/*                          PROPOSITO                                 */
/* - Almacenar los datos de geolocalización por cada operación        */
/* que realice el cliente a través de la App Tuiio M?vil.             */
/**********************************************************************/
/*                    MODIFICACIONES                                  */
/*  FECHA          AUTOR            RAZON                             */
/*  21-Ago-2022    A.Llandan      191122 Versión Inicial              */
/*  21-Ago-2022    A.Inca         191122 Envío de SMS y Correo        */
/*  25-Ene-2023    W.Toledo       193221 B2B Grupal - Prospeccion     */
/*  24-Feb-2023    A. Llandan     193221 Validación cliente con #tel  */
/**********************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_registro_opt')
        drop proc sp_registro_opt
go

CREATE PROCEDURE sp_registro_opt(
  @t_show_version bit              = 0,
  @s_user         login            =null,
  @s_date         datetime         =null,
  @s_srv          varchar(30)      =null,
  @s_ofi          smallint         =null,
  @s_term         varchar(30)      =null,
  @i_operacion    char(1)          =null,
  @i_tipo         varchar(10)      =null,
  @i_canal        varchar(10)      =null,
  @i_num_mail     varchar(50)      =null,
  @i_otp          varchar(6)       =null,
  @i_fecha        datetime         =null,
  @i_ente         int              =null,
  @o_ente         int              =0 output,
  @o_proceso      int              =0 output
)
As
declare
    @w_sp_name              varchar(30),
    @w_return               int,
    @w_tiempo_sms           int,
    @w_tiempo_mail          int,
    @w_fecha_vencimiento    datetime,
    @w_fecha_inicio         datetime,
    @w_plantilla            varchar(10),
    @w_bloque               varchar(2),
	@w_error                int,
	@w_body                 nvarchar(2000),
    @w_ente                 int,
    @w_msg                  varchar(1000) ,
	@w_id_cobis 			varchar(20),
	@w_nom_cli 				varchar(90), -- 81
	@w_oficina 				varchar(14),
	@w_nom_asesor 			varchar(64),
	@w_msg_err				varchar(1000)

select @w_sp_name      = 'sp_registro_opt'
print 'Nombre sp: ' + convert(varchar(20),@w_sp_name)

-- Se obtiene parametro para vigencia de sms y de correo
select @w_tiempo_sms = pa_smallint from cobis..cl_parametro where pa_nemonico = 'TOVSM'
select @w_tiempo_mail = pa_smallint from cobis..cl_parametro where pa_nemonico = 'TOVCO'
select @w_fecha_inicio = getdate()

if   @i_operacion = 'I'
begin
	
	select top 1
		@w_msg_err    = (select mensaje from cobis..cl_errores where numero = 70011019),
		@w_id_cobis   = 'Id Cobis: ' + convert(varchar, en_ente),
		@w_nom_cli    = 'Nombre del Cliente: ' + substring(en_nombre, 1, 1) + replicate('*', len(en_nombre)-1) + ' ' +
					    substring(isnull(p_p_apellido,''), 1, 1) + replicate('*', len(isnull(p_p_apellido,''))-1) + ' ' +
					    substring(isnull(p_s_apellido,''), 1, 1) + replicate('*', len(isnull(p_s_apellido,''))-1),
		@w_oficina    = 'Oficina: ' + convert(varchar, en_oficina),
		@w_nom_asesor = 'Asesor: ' + (select fu_nombre from cobis..cl_funcionario where fu_funcionario=en_oficial)
	from cobis..cl_ente
	where en_ente in (select te_ente from cobis..cl_telefono where te_valor = @i_num_mail )
	order by en_ente desc


   if @i_tipo='SMS'
   begin
       -- Se elimina código generado para ese numero de telefono y se crea un nuevo codigo
       if exists(select 1 from cob_bvirtual..bv_otp_seguridad where se_num_mail=@i_num_mail)
       begin
           delete from cob_bvirtual..bv_otp_seguridad where se_num_mail=@i_num_mail
       end
       
       if exists(Select 1 from cobis..cl_telefono where te_valor=@i_num_mail and te_ente <> @i_ente)
       begin
            select @w_ente = te_ente from cobis..cl_telefono where te_valor=@i_num_mail
            if exists (Select 1 from cob_bvirtual..bv_trans_procesos where tp_id_cliente = @w_ente)
            begin
                 select top 1 @o_ente = @w_ente, @o_proceso = tp_id from cob_bvirtual..bv_trans_procesos where tp_id_cliente = @w_ente order by tp_id desc
            end
            else
            begin
				select @w_error = 70011019,
				   @w_msg = @w_msg_err + '\n' + @w_id_cobis + '\n' + @w_nom_cli + '\n' + @w_oficina + '\n' + @w_nom_asesor
				goto ERROR
               /* Error longitud del token incorrecto */
			end
       end

       select @w_fecha_vencimiento = dateadd(second, @w_tiempo_sms, @w_fecha_inicio)
   
       insert into bv_otp_seguridad (se_tipo,se_fecha_ingreso,se_codigo,se_canal,se_num_mail,se_fecha_vencimiento)
       values (@i_tipo, getdate(),@i_otp,@i_canal,@i_num_mail,@w_fecha_vencimiento)
	   
	   if @@error <> 0
	   begin
	     select @w_error = 70011019,
				   @w_msg = @w_msg_err + '\n' + @w_id_cobis + '\n' + @w_nom_cli + '\n' + @w_oficina + '\n' + @w_nom_asesor
		 goto ERROR
	   end
	   	   
	   select @w_plantilla = codigo 
       from cobis..cl_catalogo 
       where tabla = (select codigo 
                      from cobis..cl_tabla 
                     where tabla = 'ns_plantilla_sms') 
       and   valor = 'TUIIO_Clave_de_ingreso_Tuiio_Movil'    
   
       select @w_bloque = codigo 
       from cobis..cl_catalogo 
       where valor = 'OTP-GENERICO'
       and   tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')
   
       --LLAMADO AL SP_DESPACHO_INS
        exec @w_return        = cobis..sp_despacho_ins
         @i_cliente            = @i_otp,
         @i_servicio           = 8,
         @i_estado             = 'P',
         @i_tipo               = 'SMS',
         @i_tipo_mensaje       = 'I',
         @i_prioridad          = 1,
         @i_from               = @i_num_mail,
         @i_to                 = null,
         @i_cc                 = '',
         @i_bcc                = '',
         @i_subject            = 'Notificación generación OTP Generica',
         @i_body               = '',
         @i_content_manager    = 'TEXT',
         @i_retry              = 'N',
         @i_tries              = 0,
         @i_max_tries          = 0,
         @i_template			 = '',
         @i_var1               = @w_bloque, -- bloque
         @i_var2               = @w_plantilla, -- plantilla
         @i_var3               = @i_num_mail, -- cliente
         @i_var4               = 'N' -- Si valida el buc o no
		 
		 if @w_return <> 0
		 begin
		    select @w_error = 70011019,
				   @w_msg = @w_msg_err + '\n' + @w_id_cobis + '\n' + @w_nom_cli + '\n' + @w_oficina + '\n' + @w_nom_asesor
		    goto ERROR
		 end
   end
   else if @i_tipo = 'MAIL'
   begin
      -- Se elimina código generado para ese numero de telefono y se crea un nuevo codigo
      if exists(select 1 from cob_bvirtual..bv_otp_seguridad where se_num_mail=@i_num_mail)
      begin
         delete from cob_bvirtual..bv_otp_seguridad where se_num_mail=@i_num_mail
      end
	  
	  select @w_fecha_vencimiento = dateadd(second, @w_tiempo_mail, @w_fecha_inicio)
   
      insert into bv_otp_seguridad (se_tipo,se_fecha_ingreso,se_codigo,se_canal,se_num_mail,se_fecha_vencimiento)
      values (@i_tipo, getdate(),@i_otp,@i_canal,@i_num_mail,@w_fecha_vencimiento)
	   
	  if @@error <> 0
	  begin
	    select @w_error = 70011019,
				@w_msg = @w_msg_err + '\n' + @w_id_cobis + '\n' + @w_nom_cli + '\n' + @w_oficina + '\n' + @w_nom_asesor
		goto ERROR
	  end
	  
	  select @w_body = 'Estimado Cliente, su clave temporal es: ' + @i_otp
	  
	  exec @w_return        = cobis..sp_despacho_ins
      @i_cliente            = @i_otp,
      @i_servicio           = 8,
      @i_estado             = 'P',
      @i_tipo               = 'MAIL',
      @i_tipo_mensaje       = '',
      @i_prioridad          = 1,
      @i_num_dir            = '', 
      @i_from               = 'prueba@cobiscorp.com',
      @i_to                 = @i_num_mail,--correo destinatario,
      @i_cc                 = '',
      @i_bcc                = '',
      @i_subject            = 'Notificación generación OTP',
      @i_body               = @w_body,
      @i_content_manager    = 'TEXT',
      @i_retry              = 'N',
      @i_tries              = 0,
      @i_max_tries          = 0,
      @i_template           = 0

      if @w_return <> 0
      begin
         select @w_error = 70011019,
				@w_msg = @w_msg_err + '\n' + @w_id_cobis + '\n' + @w_nom_cli + '\n' + @w_oficina + '\n' + @w_nom_asesor
         goto ERROR
      end
	  
   end
   else
   begin
      select @w_error = 1890023
      goto ERROR
   end
   
end

return 0

ERROR:
exec cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg

return @w_error

go