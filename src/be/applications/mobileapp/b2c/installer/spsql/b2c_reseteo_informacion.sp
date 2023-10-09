/************************************************************************/
/*      Archivo:                b2c_reseteo_informacion.sp              */
/*      Stored procedure:       sp_reseteo_informacion                  */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           AINCA                                   */
/*      Fecha de escritura:     Enero/2019                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Recibe un código de registro B2C y devuelve datos del cliente.  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    27/06/2019           AINCA              Emision Inicial           */
/************************************************************************/


use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_reseteo_informacion')
    drop proc sp_reseteo_informacion
go

create proc sp_reseteo_informacion(
@s_ssn              int         = null,
@s_sesn             int         = null,
@s_date             datetime    = null,
@s_user             varchar(14) = null,
@s_term             varchar(30) = null,
@s_ofi              smallint    = null,
@s_srv              varchar(30) = null,
@s_lsrv             varchar(30) = null,
@s_rol              smallint    = null,
@s_org              varchar(15) = null,
@s_culture          varchar(15) = null,
@t_rty              char(1)     = null,
@t_debug            char(1)     = 'N',
@t_file             varchar(14) = null,
@t_trn              int    = null,
@i_codCliente       int
)
as
declare
@w_sp_name          varchar(25),
@w_error            int,
@w_cod_ente_b2c     int,
@w_msg              varchar(200),
@w_lologin          varchar(64),
@w_mailCliente      varchar(250),
@w_id               int,
@w_subject          varchar(100),
@w_body             varchar(500),
@w_nombreC          varchar(250),
@w_anio             varchar(4),	
@w_mes_in			varchar(15),
@w_mes_es			varchar(15),
@w_dia 				varchar(2),
@w_fecha_b          varchar(25)



select @w_cod_ente_b2c = en_ente 
from cob_bvirtual..bv_ente
where en_ente_mis = @i_codCliente

if @w_cod_ente_b2c is null
begin
   select 
   @w_error = 1850119, 
   @w_msg   = 'ERROR: EL CÓDIGO DEL CLIENTE ' + convert(varchar, @i_codCliente) + ' NO TIENE INFORMACION' 
   goto ERROR
end

select @w_lologin = lo_login 
from cob_bvirtual..bv_login
where lo_ente = @w_cod_ente_b2c

select @w_lologin

delete from cob_bvirtual..bv_login_imagen 
where li_login = @w_lologin

if @@rowcount = 0
begin
   select 
   @w_error = 1850119, 
   @w_msg   = 'ERROR: EL CLIENTE ' + convert(varchar(200),@i_codCliente) + ' NO TIENE IMAGEN Y FRASE DE BIENVENIDA' 
   goto ERROR
   
end

-- Consulta del nombre del cliente
select @w_nombreC = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' '+isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'')
from cobis..cl_ente
where en_ente = @i_codCliente

-- Consulta datos de correo y datos de envio
select @w_mailCliente = di_descripcion 
from cobis..cl_direccion 
where di_ente = @i_codCliente
and di_tipo = 'CE'

-- Seleccionar template si existiera
select @w_id = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'

-- Obtener fecha para body del correo
select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))

select @w_mes_es = (case @w_mes_in when 'January' then 'Enero' 
                          when 'February' then 'Febrero' when 'March' then 'Marzo' 
                          when 'April' then 'Abril' when 'May' then 'Mayo' 
                          when 'June' then 'Junio' when 'July' then 'Julio' 
                          when 'August' then 'Agosto'
                          when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                          when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)

select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio


-- Creacion de un subject

select @w_subject = 'Reseteo del mensaje e imagen de Bienvenida.'

-- Creacion del body del correo
--select @w_body = 'El cliente ' + convert(varchar(255),@w_cod_ente_b2c) + ' reseteo la frase e imagen de bienvenida'
select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>Se cambió la imagen de bienvenida de tu aplicación Tuiio móvil.</parrafoDoc></data>'

-- Ejecucion del sp para las notificaciones y envio de mail
  exec @w_error =  cobis..sp_despacho_ins
       @i_cliente          = @i_codCliente,
       @i_template         = @w_id,
       @i_servicio         = 1,
       @i_estado           = 'P',
       @i_tipo             = 'MAIL',
       @i_tipo_mensaje     = 'I',
       @i_prioridad        = 1,
       @i_from             = null,
       @i_to               = @w_mailCliente,
       @i_cc               = null,
       @i_bcc              = null,
       @i_subject          = @w_subject,
       @i_body             = @w_body,
       @i_content_manager  = 'HTML',
       @i_retry            = 'S',
       @i_fecha_envio      = null,
       @i_hora_ini         = null,
       @i_hora_fin         = null,
       @i_tries            = 0,
       @i_max_tries        = 2,
       @i_var1             = null
	   
if @w_error <> 0
begin
   select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@w_cod_ente_b2c)
   select @w_error = 5000
   
end

return 0

ERROR:
exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
        @i_msg    = @w_msg
        
return @w_error
go