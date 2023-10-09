/*      Archivo:                b2c_mail_notif.sp                       */
/*      Stored procedure:       sp_b2c_mail_notif                       */
/************************************************************************/
/*      Base de datos:          cobis                                   */
/*      Producto:               BANCAMOVIL                              */
/*      Disenado por:           Sonia Rojas                             */
/*      Fecha de escritura:     05/02/2022                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Genera la inserción en BV para que se realice la notificacion   */
/*      de generacion de OTP                                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA       VERSION         AUTOR                      RAZON        */
/*  05/02/2022                  Sonia Rojas           Emisión Inicial   */
/************************************************************************/
use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_mail_notif')
        drop proc sp_b2c_mail_notif
go
create proc sp_b2c_mail_notif (
    @t_from            varchar(32)  = null,
    @t_rty             char(1)      = 'N',
    @i_operacion       char(2)      = 'N',                -- N
    @i_banco           varchar(255) = null,
    @i_canal           int          = null,
	@i_correo_dest     varchar(255) = null,
    @i_correo_orig     varchar(255) = null,
    @i_token           varchar(256) = null,
    @i_cliente         int,
    @i_login           varchar(64)  = null,
    @i_num_telf        varchar(15)  = null,
    @o_correo_orig     varchar(256)  = 'N' out,
    @o_num_telf        varchar(256)  = 'N' out
)
as
--------------------------------------------------------------------------------------------------------
-- Variables de trabajo
--------------------------------------------------------------------------------------------------------
declare
@w_return          int,
@w_sp_name         varchar(30),
@w_msg             varchar(100),
@w_te_id           int,
@w_rpc             descripcion,
@w_body            nvarchar(2000),
@w_canal           varchar(50),
@w_mensaje_error   varchar(255),
@w_cliente_from    varchar(30),
@w_mail_orig       varchar(255),
@w_reg_id          varchar(256),
@w_emailbco        varchar(64),
@w_plantilla       int,
@w_bloque          varchar(2)
--------------------------------------------------------------------------------------------------------
-- Carga de variables de trabajo
--------------------------------------------------------------------------------------------------------
select  @w_sp_name      = 'sp_b2c_mail_notif'

--------------------------------------------------------------------------------------------------------
--  Version Stored Procedure
--------------------------------------------------------------------------------------------------------
print 'Stored procedure = ' + @w_sp_name + ' 1.0.0.1'

select @w_emailbco = pa_char
from cobis..cl_parametro
where pa_nemonico = 'IBFROM'
and pa_producto = 'BVI'
    
if @i_operacion = 'N'  --Notificación
begin
   if @i_cliente is null
   begin
      select @i_cliente = lo_ente
      from bv_login
      where lo_login = @i_login
   end

   select @i_correo_orig = me_num_dir
   from cob_bvirtual..bv_medio_envio
   where me_ente  = @i_cliente
   and  me_tipo   = 'MAIL'
   and me_login   = @i_login
   and me_default = 'S'  -- JTO incidencia #89489
   
   if @@rowcount = 0
   BEGIN
       -- Si no encuentra correo en medio de envio lo toma de cl_direccion
       -- se usa para enviar notificacion a clientes que aun no se han registrado 
        select top 1 @i_correo_orig = di_descripcion from cobis..cl_direccion where di_tipo = 'CE' and di_ente = @i_cliente
   END
   
   select @i_num_telf =me_num_dir
   from cob_bvirtual..bv_medio_envio
   where me_ente=@i_cliente
   and  me_tipo='SMS'
   and me_login=@i_login
   and me_default = 'S'  -- JTO incidencia #89489   

   select  @w_reg_id = rtrim(ltrim(me_num_dir))
   from cob_bvirtual..bv_medio_envio
   where me_login = @i_login
   and me_tipo = 'PUSH'
   and me_default = 'S'  -- JTO incidencia #89489  
      
end

if @i_operacion = 'V'  --Verificación correo onboarding
begin
	select @i_correo_orig = @i_correo_dest
end

if @i_operacion = 'N' or  @i_operacion = 'V' --Notificación
begin

   --------------------------------------------------------------------------------------------------------
   -- Obtener el codigo  de la plantilla
   --------------------------------------------------------------------------------------------------------
   select @w_te_id = te_id from bv_template
   where te_nombre = 'Notif_otp.xslt'
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1890005
      return 1890005
   end

   --------------------------------------------------------------------------------------------------------
   -- Cadena para ejecución del SP de BV   ***preguntar si se va utilizar el gateway
   --------------------------------------------------------------------------------------------------------
   select @w_rpc = '.cobis..sp_despacho_ins'

   --------------------------------------------------------------------------------------------------------
   -- Concatenar el cuerpo del correo XML que se cruza con el XSLT del template
   --------------------------------------------------------------------------------------------------------
   if @i_canal = 1
      select @w_canal = 'Electronica'
   else
      select @w_canal = 'Movil'
   
   if @i_banco is null
   begin
      select @i_banco = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'CLINAM'
      and pa_producto = 'BVI'
   end

   select @w_body = 'Estimado Cliente, su clave temporal es: ' + @i_token

   if @i_correo_orig <> ''
   begin
      exec @w_return             = @w_rpc
      @i_cliente            = @i_cliente,
      @i_servicio           = @i_canal,
      @i_estado             = 'P',
      @i_tipo               = 'MAIL',
      @i_tipo_mensaje       = '',
      @i_prioridad          = 1,
      @i_num_dir            = @i_login, 
      @i_from               = @w_emailbco,
      @i_to                 = @i_correo_orig,--@i_correo_dest,
      @i_cc                 = '',
      @i_bcc                = '',
      @i_subject            = 'Notificación generación OTP',
      @i_body               = @w_body,
      @i_content_manager    = 'TEXT',
      @i_retry              = 'N',
      @i_tries              = 0,
      @i_max_tries          = 0,
      @i_template           = @w_te_id
	  
      if @w_return != 0
      begin
         select @w_mensaje_error  = 'ERROR: NOTIFICACION ' + convert(varchar,@w_te_id) + ' NO ENVIADA (Buzon)'
         print @w_mensaje_error
         return 0
      end
   end

   if @i_num_telf <> '' and @i_correo_orig = ''
   begin
      select @w_body         = 'Estimado Cliente, El codigo temporal para Banca '+ @w_canal + ' es: ' + @i_token
      select @w_cliente_from = convert(varchar,@i_cliente)

      exec @w_return        = @w_rpc
      @i_cliente            = @i_cliente,
      @i_servicio           = @i_canal,
      @i_estado             = 'P',
      @i_tipo               = 'SMS',
      @i_tipo_mensaje       = 'N',
      @i_prioridad          = 1,
      @i_from               = @w_emailbco,
      @i_cc                 = '',
      @i_bcc                = '',
      @i_subject            = 'Notificación generación OTP',
      @i_body               = @w_body,
      @i_content_manager    = 'TEXT',
      @i_retry              = 'N',
      @i_tries              = 0,
      @i_max_tries          = 0,
      @i_template          = @w_te_id
	  
      if @w_return != 0
      begin
         select @w_mensaje_error  = 'ERROR: NOTIFICACION ' + convert(varchar,@w_te_id) + ' NO ENVIADA (sms)'
         print @w_mensaje_error
         return 0
      end
   end
   
   if @w_reg_id <> ''  
   begin  
      select @w_body         = ltrim(rtrim(@i_token))
      select @w_cliente_from = convert(varchar,@i_cliente) 

      exec @w_return        = @w_rpc  
      @i_cliente            = @i_cliente,  
      @i_servicio           = @i_canal,  
      @i_estado             = 'P',  
      @i_tipo               = 'PUSH',  
      @i_tipo_mensaje       = 'I',  
      @i_prioridad          = 1,  
      @i_num_dir            = @i_login,  
      @i_from               = '',  
      @i_to                 = @w_reg_id,  
      @i_cc                 = '',  
      @i_bcc                = '',  
      @i_subject            = 'Notificación generación OTP PUSH',  
      @i_body               = @w_body,  
      @i_content_manager    = 'TEXT',  
      @i_retry              = 'N',  
      @i_tries              = 0,  
      @i_max_tries          = 0,  
      @i_template           = @w_te_id
	  
      if @w_return != 0  
      begin  
         select @w_mensaje_error  = 'ERROR: NOTIFICACION ' + convert(varchar,@w_te_id) + ' NO ENVIADA (push)'  
         print @w_mensaje_error  
         return 0  
      end        
   end
   
end --fin operación N
return 0
go
