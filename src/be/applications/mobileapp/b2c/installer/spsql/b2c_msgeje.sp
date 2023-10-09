/************************************************************************/
/*      Archivo:                b2c_msg_eje.sp                          */
/*      Stored procedure:       sp_b2c_msg_ejecutar                     */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Nov/2018                                */
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
/*      Ejecuta una acción confirmada desde un mensaje                  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    05/Dic/2018           TBA              Emision Inicial            */
/*    03/Jul/2019           AINCA            Envío por correo           */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_msg_ejecutar')
    drop proc sp_b2c_msg_ejecutar
go

create proc sp_b2c_msg_ejecutar(
@s_ssn          int           = null,
@s_sesn         int           = null,
@s_date         datetime      = null,
@s_user         varchar(14)   = null,
@s_term         varchar(30)   = null,
@s_ofi          int           = null,
@s_srv          varchar(30)   = null,
@s_lsrv         varchar(30)   = null,
@s_rol          int           = null,
@s_org          varchar(15)   = null,
@s_culture      varchar(15)   = null,
@t_show_version bit           = 0,
@t_rty          char(1)       = null,
@t_debug        char(1)       = 'N',
@t_file         varchar(14)   = null,
@t_trn          int           = null, 
@i_cliente      int,
@i_msg_id       int,
@i_respuesta    char(2), -- SI=SI, NO=NO, OK=OK
@o_msg          varchar(200)  = null output
)
as
declare
@w_tipo_msg          catalogo,
@w_programa          varchar(60),
@w_error             varchar(200),
@w_cliente           int,
@w_sp_name           varchar(24),
@w_trespuesta        catalogo,
@w_fecha_hoy_tiempo  datetime,
@w_banco             cuenta,
@w_respuesta         varchar(10),
@w_fecha_ven         datetime,
@w_msg               varchar(250),
@w_commit            char(1),
@w_monto_var         varchar(64),
@w_fecha_hoy         datetime,
@w_mail              varchar(255),
@w_id_template       int = 0,
@w_subject           varchar(100),
@w_body              varchar(500),
@w_folio           	varchar(20),
@w_tipo_tran    		varchar(50),
@w_mensaje      		varchar(200),
@w_nombreC            varchar(250),
@w_anio               varchar(4),	
@w_mes_in			  varchar(15),
@w_mes_es			  varchar(15),
@w_dia 				  varchar(2),
@w_fecha_b            varchar(25),
@w_parraf_1           varchar(250),
@w_parraf_2           varchar(250),
@w_base_asociada     varchar(50),
@w_sp_asociado       varchar(50)


select 
@w_sp_name          = 'sp_b2c_msg_ejecutar',
@w_fecha_hoy_tiempo = getdate(),
@w_fecha_hoy        = convert(date, @w_fecha_hoy_tiempo)

-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + '1.0.0.0'
   return 0
end

if @i_respuesta not in ('SI','NO','OK') begin
   select @w_error = 1890014
   select @w_msg   = 'RESPUESTA NO ESTA DENTRO DE LOS VALORES PERMITIDOS'
   goto ERROR
end

select 
@w_tipo_msg   = ms_tipo_msg,
@w_cliente    = ms_cliente,
@w_banco      = ms_banco,
@w_trespuesta = ms_trespuesta,
@w_respuesta  = ms_respuesta,
@w_fecha_ven  = ms_fecha_ven,
@w_monto_var =  ms_var1
from cob_bvirtual..bv_b2c_msg
where ms_msg_id = @i_msg_id

if @i_cliente <> @w_cliente begin
   select @w_error = 1890007
   goto ERROR
end


if @w_trespuesta = 'SN' and @i_respuesta not in ('SI', 'NO') begin
   select @w_error = 1890014
   select @w_msg = 'LA RESPUESTA NO ES VALIDA PARA EL TIPO MENSAJE DE OPCION'
   goto ERROR
end

if @w_trespuesta = 'OK' and @i_respuesta not in ('OK') begin
   select @w_error = 1890014
   select @w_msg = 'LA RESPUESTA NO ES VALIDA PARA EL TIPO MENSAJE DE CONFIRMACION'
   goto ERROR
end

if @w_respuesta is not null and @w_respuesta <> @i_respuesta begin
   select @w_error = 1890013
   select @w_msg   = 'EL MENSAJE FUE RESPONDIDO ANTERIORMENTE CON OTRA RESPUESTA'
   goto ERROR
   
end

if @w_respuesta = @i_respuesta return 0

if @w_fecha_ven < @w_fecha_hoy begin
   select @w_error = 1890012
   goto ERROR
end

--INICIO ATOMICIDAD
if @@trancount = 0 begin  
  select @w_commit = 'S'
  begin tran 
end

update bv_b2c_msg set
ms_respuesta    = @i_respuesta,
ms_fecha_resp   = @w_fecha_hoy_tiempo
where ms_msg_id = @i_msg_id

if @@error <> 0 begin
   select @w_error = 1890006
   select @w_msg = 'ERROR AL ACTUALIZAR LA RESPUESTA AL MENSAJE'
end

if @i_respuesta = 'SI'
begin
   select @w_base_asociada = tm_base_asociada,
   @w_sp_asociado   = tm_sp_asociado
   from cob_bvirtual..bv_b2c_tipo_msg
   where tm_tipo_msg = @w_tipo_msg
   
   if @w_base_asociada  is not null and @w_sp_asociado is not null begin
      select @w_programa = @w_base_asociada+'..'+@w_sp_asociado
      exec @w_error  = @w_programa 
      @i_cliente     = @i_cliente,
      @i_banco       = @w_banco,
	   @i_msg_id      = @i_msg_id,
	  	@o_folio       = @w_folio out,
	  	@o_tipo_tran   = @w_tipo_tran out,
	  	@o_mensaje     = @w_mensaje out,
      @o_msg         = @o_msg out
      
      if @w_error <> 0    goto ERROR
	   

	    select 
		'Institucion'     = 'SANTANDER',
		'Tipo'            = @w_tipo_tran,
		'Fecha_operacion' = getdate(),
		'Hora_operacion'  = getdate(),
		'Folio'           = @w_folio,
		'Estado'          = 'EJECUTADA',
		'Mensaje'         = @w_mensaje

	  -- Busqueda del correo del cliente

	  select @w_mail = di_descripcion 
      from cobis..cl_direccion
      where di_ente = @i_cliente
      and di_tipo = 'CE' 
	  
	  print 'La direccion del cliente es: ' + @w_mail
	  
	  -- Consulta nombre del cliente
	    select @w_nombreC = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' '+isnull(p_p_apellido,'') +' '+ isnull(p_s_apellido,'')
        from cobis..cl_ente
        where en_ente = @i_cliente
	    
	    -- Obtener fecha para body del correo
        select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
        select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
        select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
        
        select @w_mes_es = (case @w_mes_in when 'January' then 'Enero' 
                                  when 'February' then 'Febrero' when 'March' then 'Marzo' 
                                  when 'April' then 'Abril' when 'May' then 'Mayo' 
                                  when 'June' then 'Junio' when 'July' then 'Julio' 
                                  when 'August' then 'August' when 'August' then 'August' 
                                  when 'September' then 'Septiembre' when 'October' then 'Octubre' 
                                  when 'November' then 'Noviembre' when 'December' then 'Diciembre' end)
        
        select @w_fecha_b =  @w_dia+'-'+@w_mes_es+'-'+@w_anio
	    
	    -- Seleccionar template si existiera
        select @w_id_template = te_id from cobis..ns_template where te_nombre = 'NotificacionGenerica.xslt'
	  
	  -- Creacion de un subject
        select @w_subject = 'Autorización del incremento de la línea de crédito'
		
		--Datos primer parrafo del body del correo
	    select @w_parraf_1 = 'Se ha autorizado un incremento en tu línea de crédito por la cantidad de $'+@w_monto_var+'M.N.'
	    
	    --Datos segundo parrafo del body del correo
	    select @w_parraf_2 = 'Contratar créditos que excedan tu capacidad de pago afecta tu historial crediticio.'
        
        -- Creacion del body del correo
        --select @w_body = 'Estimado cliente,'+CHAR(13)+CHAR(10)+'Se realizo la autorización del incremento en su cupo exitosamente'
		select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><fechaDoc>'+@w_fecha_b+'</fechaDoc><nombreC>'+@w_nombreC+'</nombreC><parrafoDoc>'+@w_parraf_1+'</parrafoDoc><parrafoDoc2>'+@w_parraf_2+'</parrafoDoc2></data>'
		
		-- Ejecucion del sp para las notificaciones y envio de mail
          exec @w_error =  cobis..sp_despacho_ins
               @i_cliente          = @i_cliente,
               @i_template         = @w_id_template,
               @i_servicio         = 1,
               @i_estado           = 'P',
               @i_tipo             = 'MAIL',
               @i_tipo_mensaje     = 'I',
               @i_prioridad        = 1,
               @i_from             = null,
               @i_to               = @w_mail,
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
           select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@i_cliente)
           select @w_error = 5000   
        end
   end
end

if @i_respuesta = 'NO'
begin
    select @w_base_asociada = tm_base_asociada,
   @w_sp_asociado   = tm_sp_asociado_al_no
   from cob_bvirtual..bv_b2c_tipo_msg
   where tm_tipo_msg = @w_tipo_msg
   
   if @w_base_asociada  is not null and @w_sp_asociado is not null begin
      select @w_programa = @w_base_asociada+'..'+@w_sp_asociado
      exec @w_error  = @w_programa 
      @i_cliente     = @i_cliente,
      @i_banco       = @w_banco,
	  @i_msg_id      = @i_msg_id,
      @o_msg         = @o_msg out
      
      if @w_error <> 0    goto ERROR
      
      
   end
end

if @w_commit = 'S' begin 
  select @w_commit = 'N'
  commit tran    
end 
   
select @o_msg = ''

return 0		  

ERROR:

select @o_msg = @w_msg

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end

if @w_msg is null 
   select @o_msg = mensaje
   from cobis..cl_errores 
   where numero = @w_error

return @w_error

go

