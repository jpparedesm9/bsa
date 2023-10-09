/*      Archivo:                b2c_sms_notif.sp                        */
/*      Stored procedure:       sp_b2c_sms_notif                        */
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
/*  05/02/2022                  Sonia Rojas        Emisión Inicial      */
/************************************************************************/
use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_sms_notif')
        drop proc sp_b2c_sms_notif
go
create proc sp_b2c_sms_notif (
    @t_from            varchar(32)  = null,
    @t_rty             char(1)      = 'N',
    @i_operacion       char(2)      = null,                -- I 'INSERCION'
    @i_banco           varchar(255) = null,
    @i_canal           int          = null,
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
select  @w_sp_name      = 'sp_b2c_sms_notif'

--------------------------------------------------------------------------------------------------------
--  Version Stored Procedure
--------------------------------------------------------------------------------------------------------
print 'Stored procedure = ' + @w_sp_name + ' 1.0.0.1'

select @w_plantilla = pa_int
from cobis..cl_parametro
where pa_nemonico = 'OTPTPL'
and   pa_producto = 'BVI'    
	   
select @w_bloque = codigo 
from cobis..cl_catalogo 
where valor = 'OTP'
and   tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')
    
if @i_operacion = 'N'  --Notificación
begin
   if @i_cliente is null
   begin
      select @i_cliente = lo_ente
      from bv_login
      where lo_login = @i_login
   end
      
   if @i_num_telf = null or rtrim(ltrim(@i_num_telf)) = '' begin
      select @i_num_telf = me_num_dir
      from cob_bvirtual..bv_medio_envio
      where me_ente=@i_cliente
      and  me_tipo='SMS'
      and me_login=@i_login
      and me_default = 'S'
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

   if @i_num_telf <> ''
   begin

      print '@i_cliente: '+convert(varchar, @i_cliente)
	  print '@i_token: '+convert(varchar, @i_token)
      delete bv_b2c_token_tmp where tt_ente = @i_cliente
      insert into bv_b2c_token_tmp (tt_token, tt_ente) values ( @i_token, @i_cliente )
	  
      exec @w_return        = @w_rpc
      @i_cliente            = @i_cliente,
      @i_servicio           = @i_canal,
      @i_estado             = 'P',
      @i_tipo               = 'SMS',
      @i_tipo_mensaje       = 'I',
      @i_prioridad          = 1,
      @i_from               = @i_num_telf,
      @i_to                 = null,
      @i_cc                 = '',
      @i_bcc                = '',
      @i_subject            = 'Notificación generación OTP SMS',
      @i_body               = '',
      @i_content_manager    = 'TEXT',
      @i_retry              = 'N',
      @i_tries              = 0,
      @i_max_tries          = 0,
      @i_template			 = '',
      @i_var1               = @w_bloque, -- bloque
      @i_var2               = @w_plantilla, -- plantilla
      @i_var3               = @i_cliente, -- cliente
      @i_var4               = 'S' -- Si valida el buc o no
	   
      if @w_return != 0
      begin
         select @w_mensaje_error  = 'ERROR: NOTIFICACION ' + convert(varchar,@w_te_id) + ' NO ENVIADA (sms)'
         print @w_mensaje_error
         return 0
      end

   end else begin
      print 'No se encuentra número de teléfono celular del cliente ' + @i_cliente + ' para envio de notificación sms'
   end
   
  
end --fin operación N
return 0
go
