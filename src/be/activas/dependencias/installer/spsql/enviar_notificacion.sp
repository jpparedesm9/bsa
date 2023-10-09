/************************************************************************/
/*      Archivo:                enviar_notificacion.sp                  */
/*      Stored procedure:       sp_send_notification                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               ADMINISTRACION                          */
/*      Creado por:             Andres Muñoz                            */
/*      Fecha de escritura:     20-Mar-2015                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador de la    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este store procedure es un proceso el cual realizara el envio   */
/*      de correos masivos a travez de un linked server que comunica    */
/*      con el servidor de notificaciones.                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      20-Mar-2015     Andres Muñoz       Emision Inicial              */
/************************************************************************/
use cobis
go

set nocount on

if exists (select 1 from sysobjects where name = 'sp_send_notification' and type = 'P')
   drop proc sp_send_notification
go

create proc sp_send_notification(
@i_to             NVARCHAR(MAX),           -- DESTINATARIOS
@i_from           NVARCHAR(MAX) = null,    -- ENVIO DEL CORREO REMITENTE
@i_cc             NVARCHAR(MAX) = null,    -- CON COPIA A
@i_subject        varchar(255)  = null,    -- ASUNTO
@i_body           NVARCHAR(MAX),           -- CUERPO DEL MENSAJE
@i_send_attach    char(1)       = 'N',     -- INDICADOR DE ENVIO ADJUNTO
@i_attach         varchar(255)  = null,    -- NOMBRE COMPLETO DEL ARCHIVO ADJUNTO
@o_msg            varchar(255)  = null out -- MENSAGE DE RESPUESTA
)
as
declare
@w_cliente        int,
@w_notificador    varchar(255),
@w_banco          varchar(255),
@w_service        tinyint,
@w_srv_not        varchar(25),
@w_linked_srvnot  varchar(25),
@w_comando        varchar(2500),
@w_valida         varchar(2500),
@w_dir_attach     varchar(255),
@w_msg            varchar(255),
@w_existe_arch    int

/*** DECLARACION VARIABLES DE TRABAJO ***/
select @w_service     = 1

/*** OBTENCION PARAMETROS ENTRADA NECESARIOS EN EL PROCESO ***/
-- CODIGO CLIENTE BANCAMIA
select @w_cliente       = pa_int 
from   cl_parametro 
where  pa_nemonico      = 'CCBA'
and    pa_producto      = 'CTE'

if @w_cliente is null
begin
   select @w_msg   = 'CODIGO DE CLIENTE NO PARAMETRIZADO'
   goto ERRORFIN
end

select @w_banco         = pa_char
from   cl_parametro 
where  pa_nemonico      = 'BANCO'
and    pa_producto      = 'CRE'

if @w_banco is null
begin
   select @w_msg   = 'ENTIDAD NO PARAMETRIZADA'
   goto ERRORFIN
end

if @i_from is null or LTRIM(RTRIM(@i_from)) = ''
begin
   -- CORREO DEFECTO DE ENVIO
   select @w_notificador   = @w_banco + ' <' + pa_char + '>'
   from   cl_parametro 
   where  pa_nemonico      = 'RBMCE'
   and    pa_producto      = 'MIS'

   if @w_notificador is null
   begin
      select @w_msg   = 'CORREO DEFAULT NO PARAMETRIZADO'
      goto ERRORFIN
   end
end
else
   select @w_notificador = @i_from

-- SERVIDOR DE NOTIFICACIONES
select @w_srv_not       = pa_char
from   cl_parametro 
where  pa_nemonico      = 'FTPSRV'
and    pa_producto      = 'MIS'

if @w_srv_not is null
begin
   select @w_msg   = 'DIRECCION SERVIDOR DE NOTIFICACIONES NO PARAMETRIZADO'
   goto ERRORFIN
end

-- LINKED SERVER NOTIFICATION
select @w_linked_srvnot = pa_char
from   cl_parametro
where  pa_nemonico      = 'SRVNOT'
and    pa_producto      = 'ADM'

if @w_linked_srvnot is null
begin
   select @w_msg   = 'LINKED A SERVIDOR DE NOTIFICACIONES NO PARAMETRIZADO'
   goto ERRORFIN
end

if @i_subject is null
   select @i_subject = 'SIN ASUNTO'

/*** CADENA DE EJECUCION ***/
select @w_comando = 'exec ' + @w_linked_srvnot + '.cob_bvirtual.dbo.sp_call_despacho_ins @i_cliente = ' + convert(varchar, @w_cliente) +
                    ', @i_servicio = ' + convert(varchar, @w_service) + ', @i_from = ''' + @w_notificador + ''', @i_to = ''' +
                    @i_to + ''', @i_subject = ''' + @i_subject + ''', @i_body = ''' + @i_body + ''''+ ', @i_retry = ''N'''

/*** VALIDACION ARCHIVOS ADJUNTOS ***/
if @i_send_attach = 'S'
begin
   /*** VALIDA NOMBRE DE ARCHIVO ADJUNTO ***/
   if @i_attach is null
   begin
      select @w_msg   = 'NOMBRE DE ARCHIVO ADJUNTO NO ENVIADO, POR FAVOR VALIDAR'
      goto ERRORFIN
   end
   else
   begin
      select @w_dir_attach = '\\' + @w_srv_not + '\NOTIFICATIONSERVER\NS\resources\attachments\' + @i_attach
      
      /*** VALIDA RUTA ARCHIVO ADJUNTO ***/
      exec master.dbo.xp_fileexist @w_dir_attach, @w_existe_arch out
      
      -- SI EXISTE EL ARCHIVO A ADJUNTAR
      if @w_existe_arch = 1
         select @w_comando = @w_comando + ', @i_var1 = ''' + @i_attach + ''''
      else 
      begin
         select @w_msg = 'NO EXISTE ARCHIVO A ADJUNTAR: ' + CAST(@w_dir_attach as varchar(255)) 
         goto ERRORFIN
      end   
   end
end

/*** EJECUCION COMANDO ***/
begin try
   exec (@w_comando)
end try
begin catch
   select @w_msg = 'ERROR: ' + CONVERT(varchar, ERROR_NUMBER()) + ', MENSAJE ERROR: ' + ERROR_MESSAGE()
   goto ERRORFIN   
end catch

select @o_msg = 'PETICION DE MAIL ENVIADA CORRECTAMENTE...'

return 0

ERRORFIN:
   select @o_msg = @w_msg
   return 1

go
