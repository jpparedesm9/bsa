/*      Archivo:                sp_se_generar_notif.sp                  */
/*      Stored procedure:       sp_se_generar_notif                     */
/************************************************************************/
/*      Base de datos:          cobis                                   */
/*      Producto:               BANCAMOVIL                              */
/*      Disenado por:           Gelen Romero                            */
/*      Fecha de escritura:     28/10/2016                              */
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
/*  28/10/2016                  Gelen Romero        Emisión Inicial     */
/*  30/01/2017                  Galo Quisigña     Consulta ente       */
/*  07/11/2017   1.0.0.1        GQU                 Act. codigos error  */
/*  29/01/2018   1.0.0.2        ETA                 Merge Push          */
/*  27/08/2018   1.0.0.3        Erica Ortega        Cuenta from         */
/*  26/11/2019   1.0.0.4        Pablo Lopez         Tomar mail de tabla */
/*                      cl_direccion si usuario no tiene medio de envio */
/*  19/08/2019   1.0.0.5        Santiago Mosquera  encoding in ANSI     */
/*  18/05/2022   1.0.0.6        Sonia Rojas        168293: Onboarding   */
/************************************************************************/
use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_se_generar_notif')
        drop proc sp_se_generar_notif
go
create proc sp_se_generar_notif (
    @s_ssn             int          = null,
    @s_srv             varchar(30)  = null,
    @s_lsrv            varchar(30)  = null,
    @s_user            varchar(30)  = null,
    @s_sesn            int          = null,
    @s_term            varchar(10)  = null,
    @s_date            datetime     = null,
    @s_ofi             smallint     = null,    -- Localidad origen transaccion
    @s_rol             smallint     = null,
    @s_org_err         char(1)      = null,    -- Origen de error: [A], [S]
    @s_error           int          = null,
    @s_sev             tinyint      = null,
    @s_msg             mensaje      = null,
    @s_org             char(1)      = null,
    @t_corr            char(1)      = 'N',
    @t_ssn_corr        int          = null,    -- Trans a ser reversada
    @t_debug           char(1)      = 'N',
    @t_file            varchar(14)  = null,
    @t_from            varchar(32)  = null,
    @t_rty             char(1)      = 'N',
    @t_trn             int,
    @i_operacion       char(2)      = null,                -- I 'INSERCION'
    @i_banco           varchar(255) = null,
    @i_canal           int          = null,
    @i_correo_orig     varchar(255) = null,
    @i_correo_dest     varchar(255) = null,
    @i_token           varchar(256) = null,
    @i_cliente         int,
    @i_login           varchar(64)  = null,
    @i_bandera_sms     char(1)      = null,
    @i_num_telf        varchar(15)  = null,
    @o_correo_orig     varchar(256)  = 'N' out,
    @o_num_telf        varchar(256)  = 'N' out,
    @i_bandera_push    char(1)       = 'S',
	@i_tipo_env        varchar(10)   = null
)
as
--------------------------------------------------------------------------------------------------------
-- Variables de trabajo
--------------------------------------------------------------------------------------------------------
declare
@w_return          int,
@w_sp_name         varchar(30),
@w_msg             varchar(100),
@w_error           int
--------------------------------------------------------------------------------------------------------
-- Carga de variables de trabajo
--------------------------------------------------------------------------------------------------------
select  @w_sp_name      = 'sp_se_generar_notif'

--------------------------------------------------------------------------------------------------------
--  Version Stored Procedure
--------------------------------------------------------------------------------------------------------
print 'Stored procedure = ' + @w_sp_name + ' 1.0.0.1'

--------------------------------------------------------------------------------------------------------
-- Validacion de transaccion
--------------------------------------------------------------------------------------------------------
if @t_trn <> 1875901
begin
   exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1890003
   return 1890003
end


if @i_tipo_env = null or rtrim(ltrim(@i_tipo_env)) = '' begin
   select @i_tipo_env = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'B2CMEN'
   and pa_producto = 'BVI'
end 

print 'Tipo de envío : ' + @i_tipo_env

if @i_tipo_env = 'SMS'
begin 
   print 'SMS>>'
   exec @w_return   = sp_b2c_sms_notif
   @i_operacion     = 'N',
   @i_canal         = @i_canal,
   @i_token         = @i_token,
   @i_cliente       = @i_cliente,
   @i_login         = @i_login,
   @i_num_telf      = @i_num_telf
    
   if @w_return <> 0 begin
      select @w_error =  @w_return
      goto ERROR
   end
end
    
else if @i_tipo_env = 'MAIL'
begin 

   exec @w_return      = sp_b2c_mail_notif
   @i_banco            = @i_banco, 
   @i_operacion        = @i_operacion,
   @i_canal            = @i_canal,
   @i_correo_orig      = @i_correo_orig,
   @i_correo_dest      = @i_correo_dest, 
   @i_token            = @i_token,
   @i_cliente          = @i_cliente,
   @i_login            = @i_login
   
   if @w_return <> 0 begin
      select @w_error =  @w_return
      goto ERROR
   end
end


else if @i_tipo_env = 'TODOS'
begin 

   exec @w_return      = sp_b2c_mail_notif
   @i_banco            = @i_banco, 
   @i_operacion        = @i_operacion,
   @i_canal            = @i_canal,
   @i_correo_orig      = @i_correo_orig,
   @i_correo_dest      = @i_correo_dest, 
   @i_token            = @i_token,
   @i_cliente          = @i_cliente,
   @i_login            = @i_login
		   
   if @w_return <> 0 begin
      select @w_error =  @w_return
      goto ERROR
   end
	
   exec @w_return   = sp_b2c_sms_notif
   @i_operacion     = 'N',
   @i_canal         = @i_canal,
   @i_token         = @i_token,
   @i_cliente       = @i_cliente,
   @i_login         = @i_login,
   @i_num_telf      = @i_num_telf
		   
   if @w_return <> 0 begin
      select @w_error =  @w_return
      goto ERROR
   end
end

return 0

ERROR:
begin   
   exec cobis..sp_cerror 
   @t_debug = 'N',
   @t_file  = null,
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
     
   return @w_error
end

go