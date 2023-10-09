/************************************************************************/
/*      Archivo:                        notificagrupo.sp                */
/*      Stored procedure:               sp_notifica_grupo               */
/*      Base de Datos:                  cob_cartera                     */
/*      Producto:                       Cartera                         */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/* Realiza el envio de notificacion a los gerentes y coordinadores      */
/* responsables de los grupos de credito                                */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 21/Jul/2019    PRO           Se agrega tipo NPDTD notifica           */ 
/*                              de descuento de tasa                    */ 
/* 15/07/2019     PXSG          Requerimiento #115931                   */ 
/* 20/07/2019     ACH/DCU/AIN   Requerimiento #162882                   */
/* 03/09/2021     ACH           ERR#168179, Mes en ingles en correos    */
/* 04/01/2022     AIN           Mejora# 122730 - Proveedor de correos   */
/* 14/03/2022     ACH           R#168293 Doc para onboarding GRAOB      */
/* 17/06/2022     ACH           R#185234 Se agrega PFGLQI               */
/* 09/08/2022     ACH           R#174670 cambio de columna para no act y*/ 
/*                              se agrega el tipo ETCIN                 */
/* 10/11/2022     ACH           R#196073 Envio de documentos digitales  */ 
/************************************************************************/
use cob_cartera
go

if exists(select * from sysobjects where name = 'sp_notifica_grupo')
   drop proc sp_notifica_grupo
go

create proc sp_notifica_grupo(   
@i_to            varchar(255),       --1 --mail
@i_cc            varchar(255) = null,--2
@i_bcc           varchar(255) = null,--3
@i_subject       varchar(510) = null,--4
@i_funcionario   int,                --5 --codigo funcionario / cliente
@i_nombre        varchar(255) = null,--6 --nombre de funcionario
@i_attachment    varchar(65)  = null,--7 --nombre del archivo adjunto
@i_tipo_notific  varchar(10),        --8 
@i_banco         varchar(20)  = null --9 --numero banco
)
as declare 
@w_body          varchar(2000),
@w_error         int,
@w_text_mail     varchar(255),
@w_from          varchar(60),
@w_id            int,
@w_fecha_hoy     varchar(10),
@w_fecha         datetime,
@w_mensaje       varchar(255),
@w_content       varchar(255),
@w_codigo        int,
@w_particion     varchar(20),
@w_cortar        int,
@w_origen        char(1),
@w_tramite       int, 
@w_nombre        varchar(64),
@w_dividendo     varchar(10),
@w_des_dividendo varchar(64),
@w_operacion     int,
@w_dia_venc      int,
@w_dia_desc      varchar(64),
@w_registro      varchar(24),
@w_inter_anio    varchar(5),
@w_inter_mes     varchar(10),
@w_inter_nom_mes varchar(10),
@w_fecha_etcue   datetime,
@w_monto		 money,
@w_tasa_op		 float,
@w_tasa_desc	 float,
@w_apellido		 varchar(50),
@w_nombre_grupo	 varchar(30),
@w_grupo		 int,
@w_secretario	 int,
@w_tesorero		 int,
@w_mail_sec 	 varchar(255),
@w_mail_tes 	 varchar(255),
@w_contar_prov   int,
@w_nombre_prov   varchar(10),
@w_nombre_tplat  varchar(50),
@w_tipo_correo   varchar(10),
@w_canal_banco   int,
@w_canal_onb     int,
@w_top_desc      varchar(256),
@w_toperacion    varchar(20)

select @w_fecha = getdate()

if @i_to is null or @i_to = ''
begin
    select  @w_mensaje = 'ERROR: FUNCIONARIO NO TIENE CORREO DE NOTIFICACION',
            @w_error = 724622
    goto ERROR  
end

set @w_content = 'TEXT'

-- Seteo de valor por defecto de correos mail - smtp / rest - por servicio rest
select @w_tipo_correo = 'MAIL'

select @w_from = isnull(pa_char,50) 
from cobis..cl_parametro 
where pa_nemonico = 'MANO' 
and pa_producto = 'REC'

-- Cambio del from por proveedor se inicia en NULL
select @w_from = null

select @w_id = te_id 
from cobis..ns_template
where te_nombre = 'NotificacionGruposVenci.xslt'

if @i_tipo_notific = 'PFGVG' or @i_tipo_notific = 'PFGVC' 
begin
    select @w_body = 'Adjunto el archivo con la lista de préstamos grupales vencidos.' +  char(13) + char(13) + 'Saludos.'
end
else if (@i_tipo_notific = 'PFPCO')
begin
   
   	SELECT @w_dividendo		= op_tdividendo,
   	       @w_operacion		= op_operacion
   	FROM cob_cartera..ca_operacion 
	WHERE op_tramite = (SELECT max(tg_tramite) 
	FROM cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
	WHERE tg_grupo = @i_funcionario --1724
	AND op_banco = tg_referencia_grupal
	AND tg_tramite = op_tramite
	AND op_estado = 3)
   	
   	SELECT @w_des_dividendo = td_descripcion FROM cob_cartera..ca_tdividendo
	WHERE td_tdividendo = @w_dividendo
   	
   	SELECT  @w_dia_venc = datepart(dw,di_fecha_ven) FROM ca_dividendo
	WHERE di_operacion = @w_operacion --45988
	AND di_dividendo = 1
   	
   	select @w_dia_desc = (case @w_dia_venc when 1 then 'DOMINGO' 
   	                       when 2 then 'LUNES' when 3 then 'MARTES' 
   	                        when 4 then 'MIÉRCOLES' when 5 then 'JUEVES' 
   	                         when 6 then 'VIERNES' when 7 then 'SÁBADO' end)
   	
   	select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><cab><dividendo>' + @w_des_dividendo +'</dividendo><dia>' + @w_dia_desc +'</dia></cab></data>'
	set @w_content = 'HTML'
	select @w_id = te_id 
	from cobis..ns_template
	where te_nombre = 'PagoCorresponsal.xslt'
	
	set @i_subject = 'Te informamos tu fecha de pago y monto'
   
end
else if (@i_tipo_notific = 'PFCVE')
begin
   select @w_body = 'Estimado señor(a).' + char(13) 
   select @w_body = @w_body + replace(isnull(@i_nombre, ''), '|', '</br>') + char(13) + char(13) 

   select @w_body = @w_body + 'Enviamos adjunto en este correo el  estado de cuenta del préstamo otorgado a usted, '
   select @w_body = @w_body + 'el archivo contiene el código de referencia para pago en cualquiera de las oficinas de los corresponsales autorizados. '
   select @w_body = @w_body + char(13) + char(13) + char(13) + 'Saludos.'
end
else if (@i_tipo_notific = 'PPCVE')
begin
   select @w_body = 'Estimado señor(a).' + char(13) 
   select @w_body = @w_body + replace(isnull(@i_nombre, ''), '|', '</br>') + char(13) + char(13) 

   select @w_body = @w_body + 'Enviamos adjunto en este correo el  estado de cuenta del préstamo otorgado a usted, '
   select @w_body = @w_body + 'el archivo contiene el código de referencia para pago en cualquiera de las oficinas de los corresponsales autorizados. '
   select @w_body = @w_body + char(13) + char(13) + char(13) + 'Saludos.'
end
else if (@i_tipo_notific = 'PFIAV')
begin
   select @w_body = 'Estimado señor(a).' + char(13) 
   select @w_body = @w_body + replace(isnull(@i_nombre, ''), '|', '</br>') + char(13) + char(13) 

   select @w_body = @w_body + 'Le informamos lo siguiente: '
   select @w_body = @w_body + char(13) + 'Saludos.'
end
else if (@i_tipo_notific in ('PFGLQ', 'PFGLI'))
begin
   select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data></data>'
   set @w_content = 'HTML'
   select @w_id = te_id 
   from cobis..ns_template
   where te_nombre = 'GarantiaLiquida.xslt'
   
   set @i_subject = 'Realiza el depósito de tu aportación y alcanza tu meta'
   
end
else if (@i_tipo_notific = 'NTGNR')
begin
   
   select @w_particion = substring(@i_attachment,21,len(@i_attachment))
   select @w_cortar = CHARINDEX('.pdf', @w_particion)
   select @w_particion = substring(@w_particion,1,@w_cortar-1)
   select @w_codigo = convert(int, @w_particion)
   
   select @w_origen = ng_origen,
          @w_tramite = ng_tramite
   from cobis..cl_notificacion_general 
   WHERE ng_codigo =  @w_codigo
   
   SELECT @w_nombre = gr_nombre 
   FROM cobis..cl_grupo, cob_workflow..wf_inst_proceso
   WHERE io_campo_3 = @w_tramite
   AND io_campo_1 = gr_grupo
   
   
   if(@w_origen = 'D') --D es desembolso
   begin
	   
	   select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><cab><name>' + @w_nombre +'</name></cab></data>'
	   set @w_content = 'HTML'
	   select @w_id = te_id 
	   from cobis..ns_template
	   where te_nombre = 'NotificacionGeneral.xslt'
	   
	   set @i_subject = 'Tu crédito ya está disponible'
	   
   end
   else
   begin
       select @w_body = ''
   end

end
else if (@i_tipo_notific = 'CRLCR')
begin
   select @w_particion = substring(@i_attachment,13,len(@i_attachment))
   select @w_cortar = CHARINDEX('.pdf', @w_particion)
   select @w_particion = substring(@w_particion,1,@w_cortar-1)
   select @w_tramite = convert(int, @w_particion)
   
   select top 1 @w_registro = rb_registro_id 
   from cob_credito..cr_b2c_registro , cob_workflow..wf_inst_proceso
   where io_campo_3 = @w_tramite
   and io_id_inst_proc = rb_id_inst_proc
   
   select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><codigo>' + @w_registro +'</codigo></data>'
   set @w_content = 'HTML'
   select @w_id = te_id 
   from cobis..ns_template
   where te_nombre = 'CreacionLCR.xslt'
   
   set @i_subject = 'Tu crédito ya está disponible'
end

--GRUPALES / RENOVACACION -- caso#174670
else if(@i_tipo_notific = 'ETCUE' or @i_tipo_notific = 'ETPCG')
begin
   print 'ingreso a ETCUE or ETPCG'
   
   select top 1 @w_fecha_etcue=in_fecha_fin_mes from  cob_conta_super..sb_ns_estado_cuenta
   
   select @w_inter_anio = LTRIM(RTRIM(convert(varchar(5),DATENAME(yyyy,@w_fecha_etcue))))
   select @w_inter_mes  = LTRIM(RTRIM(convert(varchar(10),DATENAME(mm,@w_fecha_etcue))))
   
   select @w_inter_nom_mes = (case @w_inter_mes 
                              when 'January'    then 'Enero' 
                              when 'February'   then 'Febrero'
						      when 'March'      then 'Marzo'
                              when 'April'      then 'Abril'
						      when 'May'        then 'Mayo'
                              when 'June'       then 'Junio'
						      when 'July'       then 'Julio'
                              when 'August'     then 'Agosto'
                              when 'September'  then 'Septiembre'
						      when 'October'    then 'Octubre'
                              when 'November'   then 'Noviembre'
						      when 'December'   then 'Diciembre' end)
  
   set @w_content = 'HTML'
   
   -- Proveedor para envío de correos
   select @w_contar_prov = count(1) from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_proveedor_correo') and estado = 'V'
   
   if @w_contar_prov = 1  
   BEGIN
      select @w_nombre_prov = codigo,
             @w_from        = valor
	  from cobis..cl_catalogo 
	  where tabla = (SELECT codigo 
	                 FROM cobis..cl_tabla 
					 WHERE tabla = 'cl_proveedor_correo') 
	  and estado = 'V'
	  
	  if @w_nombre_prov = 'INFOBIP'
	  begin
	     select @w_nombre_tplat = 'NotifInterfacturaEstadoCuentaRest.xslt'
		 select @w_tipo_correo = 'REST'
	  end
	  else
	  begin 
	     select @w_nombre_tplat = 'NotifInterfacturaEstadoCuenta.xslt'
		 select @w_from = null
		 select @w_tipo_correo = 'MAIL'
	  end	  
   end
   else
   begin 
   -- Valores por defecto de no encontrar un destinatario activo o solo uno activo, no pueden estar 2 activos
      select @w_nombre_tplat = 'NotifInterfacturaEstadoCuenta.xslt'
	  select @w_from = null
	  select @w_tipo_correo = 'MAIL'
   end
   
   select @w_id = te_id 
   from cobis..ns_template 
   where te_nombre = @w_nombre_tplat
   
   select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><mesEnvio>' + convert(varchar(10),@w_inter_nom_mes) +'</mesEnvio><anioEnvio>' +convert(varchar(10),@w_inter_anio)+ '</anioEnvio></data>'
      
end

else if(@i_tipo_notific = 'NPDTD')
begin
	set @w_content = 'HTML'
	select @w_id = te_id 
	from cobis..ns_template 
	where te_nombre = 'NotificacionDescuento.xslt'	
	
	select 	@w_monto		= 	dd_monto,
			@w_nombre_grupo	=	(select gr_nombre
								from cobis..cl_grupo
								where gr_grupo = dd_grupo),		   
			@w_nombre		=	(select en_nombre +' '+ isnull(p_s_nombre,'')+' '+p_p_apellido+' '+isnull(p_s_apellido,'')
								from cobis..cl_ente
								where en_ente = (select cg_ente
									from cobis..cl_cliente_grupo
									where cg_grupo = dd_grupo
									and cg_rol = 'P')),
			@w_tasa_op		=	(select ro_porcentaje
								from cob_cartera..ca_rubro_op
								where ro_concepto = 'INT'
								and ro_operacion = dd_operacion
								),
			@w_tasa_desc	=	dd_tasa_descuento,
			@w_grupo		= 	dd_grupo
	from cob_cartera..ca_devolucion_descuento
	where dd_operacion = @i_funcionario	
	
	select @i_funcionario 	= @w_grupo,
		   @i_subject		= ' ¡Tenemos una gran noticia para ti y tu grupo! Por su participación en el programa Digitalízate y Gana $$'
	
	select @w_body	='<?xml version="1.0" encoding="ISO-8859-1"?><data><nombres>'+@w_nombre+'</nombres><grupo>'+@w_nombre_grupo+'</grupo>'+
					'<descuento>'+convert(varchar(10),@w_monto)+'</descuento><tasa>'+convert(varchar(10),@w_tasa_op)+'</tasa><tasaDescuento>'+convert(varchar(10),@w_tasa_desc)+'</tasaDescuento></data>'
	
	select @w_tesorero = cg_ente
	from cobis..cl_cliente_grupo
	where 	cg_grupo	=	@w_grupo
	and 	cg_rol		= 	'T'
	
	select @w_mail_sec = di_descripcion
	from cobis..cl_direccion
	where 	di_ente 	= @w_tesorero
	and 	di_tipo 	= 'CE'
	
	select @w_secretario = cg_ente
	from cobis..cl_cliente_grupo
	where 	cg_grupo	=	@w_grupo
	and 	cg_rol		= 	'S'
	
	select @w_mail_tes = di_descripcion
	from cobis..cl_direccion
	where 	di_ente 	= @w_secretario
	and 	di_tipo 	= 'CE'
	
	select @i_cc = @w_mail_sec +';'+@w_mail_tes
	
end

--REVOLVENTE / INDIVIDUAL
else if(@i_tipo_notific = 'ETLCR' or @i_tipo_notific = 'ETCIN')
begin
   print 'ingreso a ' + @i_tipo_notific
   
   select top 1 @w_fecha_etcue=in_fecha_fin_mes from  cob_conta_super..sb_ns_estado_cuenta
   
   select @w_inter_anio = LTRIM(RTRIM(convert(varchar(5),DATENAME(yyyy,@w_fecha_etcue))))
   select @w_inter_mes  = LTRIM(RTRIM(convert(varchar(10),DATENAME(mm,@w_fecha_etcue))))
   
   select @w_inter_nom_mes = (case @w_inter_mes 
                              when 'January'   then 'Enero' 
                              when 'February'  then 'Febrero' 
							  when 'March'     then 'Marzo' 
                              when 'April'     then 'Abril' 
							  when 'May'       then 'Mayo' 
                              when 'June'      then 'Junio' 
							  when 'July'      then 'Julio' 
                              when 'August'    then 'Agosto'
                              when 'September' then 'Septiembre' 
							  when 'October'   then 'Octubre' 
                              when 'November'  then 'Noviembre' 
							  when 'December'  then 'Diciembre' end)
  
   set @w_content = 'HTML'
   
   -- Proveedor para envío de correos
   select @w_contar_prov = count(1) from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_proveedor_correo') and estado = 'V'
   
   if @w_contar_prov = 1  
   BEGIN
      select @w_nombre_prov = codigo,
             @w_from        = valor
	  from cobis..cl_catalogo 
	  where tabla = (SELECT codigo 
	                 FROM cobis..cl_tabla 
					 WHERE tabla = 'cl_proveedor_correo') 
	  and estado = 'V'
	  
	  if @w_nombre_prov = 'INFOBIP'
	  begin
	     select @w_nombre_tplat = 'NotifInterfacturaEstadoCuentaRest.xslt'
		 select @w_tipo_correo = 'REST'
	  end
	  else
	  begin 
	     select @w_nombre_tplat = 'NotifInterfacturaEstadoCuenta.xslt'
		 select @w_from = null
		 select @w_tipo_correo = 'MAIL'
	  end	  
   end
   else
   begin 
   -- Valores por defecto de no encontrar un destinatario activo o solo uno activo, no pueden estar 2 activos
      select @w_nombre_tplat = 'NotifInterfacturaEstadoCuenta.xslt'
	  select @w_from = null
	  select @w_tipo_correo = 'MAIL'
   end
   
   select @w_id = te_id 
   from cobis..ns_template 
   where te_nombre = @w_nombre_tplat
   
   select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><mesEnvio>' + convert(varchar(10),@w_inter_nom_mes) +'</mesEnvio><anioEnvio>' +convert(varchar(10),@w_inter_anio)+ '</anioEnvio></data>'
      
end
else if(@i_tipo_notific = 'GRAOB')
begin
    print 'ingreso a GRAOB'
    select @w_toperacion = op_toperacion from cob_cartera..ca_operacion where op_banco = @i_banco
    select @w_canal_banco = cod_canal from cob_credito..cr_cli_reporte_on_boarding_det where cod_banco = @i_banco
    select @w_canal_onb = ca_canal from cobis..cl_canal where ca_nombre = 'b2c_digital' and ca_estado = 'V'
    
    set @w_content = 'HTML' 
	
    if (@w_canal_banco = @w_canal_onb) 
	begin
	    select @i_subject = nr_subjet_doc,
		       @w_top_desc = nr_tproducto_descp
		from ca_notificacion_reporte where nr_tproducto = 'ONBOARDING' and nr_job = @i_tipo_notific
		
        -- Proveedor para envío de correos
        select @w_nombre_tplat = 'NotifOnboardingDocumento.xslt'
        select @w_from = null
        select @w_tipo_correo = 'MAIL'
        
        select @w_id = te_id 
        from cobis..ns_template
        where te_nombre = @w_nombre_tplat
        
        select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><numBanco>' + @i_banco +'</numBanco><tproductoDesc>' +@w_top_desc+ '</tproductoDesc></data>'
		
    end 
	else 
	begin
	    select @i_subject = nr_subjet_doc,
		       @w_top_desc = nr_tproducto_descp
		from ca_notificacion_reporte where nr_tproducto = @w_toperacion and nr_job = @i_tipo_notific
			   
		-- Selecion de plantilla si es grupal cambia la plantilla
		if @w_toperacion = 'GRUPAL'		
        select @w_nombre_tplat = 'NotifGeneracionReporteDocUnificado.xslt'
		else
		select @w_nombre_tplat = 'NotifGeneracionReporteDocumento.xslt'
		
		
        select @w_from = null
        select @w_tipo_correo = 'MAIL'
        
        select @w_id = te_id
        from cobis..ns_template
        where te_nombre = @w_nombre_tplat
        
        select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><numBanco>' + @i_banco +'</numBanco><tproductoDesc>' +@w_top_desc+ '</tproductoDesc></data>'
	end		  
end
else
begin
   select @w_body = ''
end

select @w_id       = isnull(@w_id, 0)

print @w_body 
exec @w_error =  cobis..sp_despacho_ins
        @i_cliente          = @i_funcionario,
        @i_template         = @w_id,
        @i_servicio         = 1,
        @i_estado           = 'P',
        @i_tipo             = @w_tipo_correo,
        @i_tipo_mensaje     = 'I',
        @i_prioridad        = 1,
        @i_from             = null,
        @i_to               = @i_to,
        @i_cc               = @i_cc,
        @i_bcc              = @i_bcc,
        @i_subject          = @i_subject,
        @i_body             = @w_body,
        @i_content_manager  = @w_content,
        @i_retry            = 'S',
        @i_fecha_envio      = null,
        @i_hora_ini         = null,
        @i_hora_fin         = null,
        @i_tries            = 0,
        @i_max_tries        = 2,
        @i_var1             = @i_attachment

if @w_error <> 0
begin
    select @w_mensaje = 'ERROR AL ENVIAR NOTIFICACION'
    goto ERROR
end

return 0

ERROR:
exec cobis..sp_ba_error_log
            @t_trn           = 8205,
            @i_operacion     = 'I',
            @i_sarta         = 9999, 
            @i_batch         = 7072,
            @i_fecha_proceso = @w_fecha,
            @i_error         = @w_error,
            @i_detalle       = @w_mensaje

return @w_error 

go
