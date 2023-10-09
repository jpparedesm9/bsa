/*************************************************************/
/*   ARCHIVO:         sp_gen_xml_refacturacion.sp            */
/*   NOMBRE LOGICO:   sp_gen_xml_refacturacion.sp            */
/*   PRODUCTO:        		                                 */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento permite generar archivos xml, para   */
/*   refacturacion caso #150202-Generacion de XML para       */
/*	 refacturacion 2018 y 2019, se anade a los instaladores  */
/*	 por posible peticion de otros reprocesos                */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   03-Dic-2020   ACH                 Req. 150202           */
/*************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_gen_xml_refacturacion')
    drop proc sp_gen_xml_refacturacion
go

create proc sp_gen_xml_refacturacion (
    @i_param1           datetime   =   null -- FECHA DE PROCESO
)as

declare @w_msg varchar(200), 
        @w_s_app varchar(255), @w_fecha_reporte datetime, @w_cmd varchar(5000), @w_path varchar(255),
        @w_destino varchar(255), @w_error INT, @w_comando varchar(6000), @w_errores varchar(255), @w_query VARCHAR (255),
        @w_xml nVARCHAR(max), @w_siguiente int, @w_id int,
        @w_buc nVARCHAR(max),
		@w_idExterno varchar(255),
        @w_fecha  varchar(255),
        @w_subTotal  varchar(255),
        @w_total varchar(255),
        @w_bucs nVARCHAR(max),
        @w_pUnitario varchar(255),
        @w_importe varchar(255),
        @w_codigo varchar(255),
        @w_cfdiBase varchar(255),
        @w_cfdiImporte varchar(255),
        @w_totalImpuestosTrasladados varchar(255),
        --@w_cfdiImporte varchar(255),
        @w_cfdiUUID varchar(255),
		@w_fecha_actual datetime,
		@w_t_interes_devengado_exigible MONEY,
		@w_t_cfdiImporte money,
		@w_anio_facturacion varchar(4),
		@w_mes_facturacion varchar(2),
		@w_nombre_archivo varchar(255)

----------------------------------------------------OBTENER FECHA PARA PROCESAR 
select @w_anio_facturacion = convert(varchar(4),year(@i_param1)),
       @w_mes_facturacion  = case when convert(varchar(2),month(@i_param1)) < 10
	                          then '0' + convert(varchar(2),month(@i_param1))
							  else convert(varchar(2),month(@i_param1)) end
print 'Inicio proceso sp_gen_xml_refacturacion para: Anio:' + @w_anio_facturacion + '---Mes:' + @w_mes_facturacion

if (@i_param1 is null)
    return 1
	
print 'Continua sp_gen_xml_refacturacion'

select @w_s_app = pa_char from cobis..cl_parametro where pa_producto = 'ADM' and   pa_nemonico = 'S_APP'
select @w_path = pa_char from cobis..cl_parametro where pa_nemonico = 'RREFX1'  and pa_producto = 'REC'

----------------------------------------------------INICIALIZAR PARA GENERAR
update sb_info_gen_xml_refacturacion
set procesado = 'N',
    nombre_archivo = ''
where ltrim(rtrim(anio_facturacion)) = ltrim(rtrim(@w_anio_facturacion))
and   ltrim(rtrim(mes_facturacion)) = ltrim(rtrim(@w_mes_facturacion))

----------------------------------------------------UNIVERSO A TRABAJAR
select *
into #consulta_procesar_tmp
from sb_info_gen_xml_refacturacion
where ltrim(rtrim(anio_facturacion)) = ltrim(rtrim(@w_anio_facturacion))
and   ltrim(rtrim(mes_facturacion)) = ltrim(rtrim(@w_mes_facturacion))
order by id

----------------------------------------------------EMPIEZA A PROCESAR POR PARTES SEGUN EL TOP
select @w_id = 0, @w_siguiente = 0
while exists (select 1 from #consulta_procesar_tmp where id >  @w_id and procesado = 'N')
begin
    select TOP 100
        t_id = id,
        t_clienteId = cliente_id,
        t_buc = buc,
        t_banco = banco,
        t_interes_devengado_exigible = interes_devengado_exigible,
        t_monto_iva = monto_iva,
        t_anio_facturacion = anio_facturacion,
        t_mes_facturacion = mes_facturacion,
        t_nombre_archivo = nombre_archivo,
        t_procesado = procesado,
		t_fecha_generacion_archivo = fecha_generacion_archivo
    into #consulta
    from #consulta_procesar_tmp
    where id >  @w_id order by id
    
	----------------------------------------------------ASIGNACION DE DATOS
    select @w_id = max(t_id) from #consulta
	--BUCS
    select @w_buc = stuff(( select b.t_buc + ','
    			             from #consulta b
    			             for XML path('')
    			             ), 1, 0, '')
    from #consulta a            
    
	select @w_buc = left(@w_buc, len(@w_buc) - 1)

    select @w_t_interes_devengado_exigible = sum(t_interes_devengado_exigible)
    from #consulta a 
	
	select @w_t_interes_devengado_exigible = CEILING(@w_t_interes_devengado_exigible * 100)/100
	
    select @w_fecha_actual = getdate()
	
           --IdExterno = "20180400" --- Es un identificador por cada XML el cual no se debe repetir, se conforma por yyyymm00, los ultimos digitos son consecutivos.
	select @w_idExterno = t_anio_facturacion + t_mes_facturacion + 
	                      case when @w_siguiente < 10 then '0'+ convert(VARCHAR(255), @w_siguiente) 
						  else convert(VARCHAR(255), @w_siguiente) end
    from #consulta
	
           --Fecha="2020-11-02T23:59:59" --- Fecha de facturacion, de esta fecha solo se tienen 72 horas para timbrar el XML por lo que una vez generado el paquete por mes se deben timbrar.
	select @w_fecha  = convert(varchar,@w_fecha_actual,23) +'T'+ convert(varchar,@w_fecha_actual,108)     
		   
		   --SubTotal="13454.39" --Sumatoria de intereses devengados no exigibles de los 100 BUCS que integran el XML.
	select @w_subTotal= @w_t_interes_devengado_exigible
		   
		   --Concepto="INTERESES ORDINARIOS --Se deben agregar los 100 BUCS que integraran el XML separados por ,
    select @w_bucs = @w_buc
		   
		   --PUnitario="13454.39" --- Sumatoria de intereses devengados no exigibles de los 100 BUCS que integran el XML.
    select @w_pUnitario = @w_t_interes_devengado_exigible
		   
		   --Importe="13454.39" --- Sumatoria de intereses devengados no exigibles de los 100 BUCS que integran el XML.
    select @w_importe = @w_t_interes_devengado_exigible
		   
		   --Codigo="20180400" --- Mismo que se indica en el campo IdExterno.
    select @w_codigo = @w_idExterno		   
		   
		   --cfdiBase="13454.39" --- Sumatoria de intereses devengados no exigibles de los 100 BUCS que integran el XML.
    select @w_cfdiBase = @w_t_interes_devengado_exigible
		   
		   --cfdiImporte="2152.71" --- Monto del campo subtotal * .16 redondeado a dos décimas siempre hacia arriba.
    select @w_t_cfdiImporte = @w_t_interes_devengado_exigible * 0.16
    select @w_cfdiImporte = CEILING(@w_t_cfdiImporte * 100) / 100
		   
		   --totalImpuestosTrasladados="2152.71" --- Mismo valor que cdiImporte
    select @w_totalImpuestosTrasladados = @w_cfdiImporte
		   
		   --cfdiImporte="2152.71" --- Mismo valor que cdiImporte anterior.
           --@w_cfdiImporte = '2152.71',
		   
		   --cfdiUUID="B6845D8A-B1D6-4C77-9060-092F21EA8089" --- Se debe indicar el valor de acuerdo al mes que se está facturando.
    select @w_cfdiUUID = case when (t_anio_facturacion + t_mes_facturacion) = '201805' then 'ACE278C6-11FF-4F35-9775-074D70D8732B'
	                          when (t_anio_facturacion + t_mes_facturacion) = '201806' then '245F4374-3333-4E31-B7B9-3B3C3F2A41B1'
                              when (t_anio_facturacion + t_mes_facturacion) = '201807' then 'CD790A91-823A-4704-96C8-CDD77F9D218B'
                              when (t_anio_facturacion + t_mes_facturacion) = '201808' then '00A7F818-0A99-4BDB-95C3-637CE94D244D'
                              when (t_anio_facturacion + t_mes_facturacion) = '201809' then 'FBF2178C-6B4C-4409-B3B8-F81D70C06A73'
                              when (t_anio_facturacion + t_mes_facturacion) = '201810' then 'BD449138-AC4B-4A25-AA7C-D2D79A98B4BE'
                              when (t_anio_facturacion + t_mes_facturacion) = '201811' then 'A6BC9D25-F23B-4763-B40F-A6AD47BBDBFA'
                              when (t_anio_facturacion + t_mes_facturacion) = '201812' then 'A30B62C4-176C-4542-9A64-63E9AF3AC397'
                              when (t_anio_facturacion + t_mes_facturacion) = '201901' then '89042655-9F05-44AC-8AD7-DBA4372C02F7'
                              when (t_anio_facturacion + t_mes_facturacion) = '201902' then 'C0A7DCBF-B487-4461-B943-98C4E4C01B1F'
                              when (t_anio_facturacion + t_mes_facturacion) = '201903' then '520DD98E-DC45-40C5-91BD-99AC4C7D9479'
                              when (t_anio_facturacion + t_mes_facturacion) = '201904' then 'EB90F423-311C-44B9-9BD3-84BE512A09F9'
                              when (t_anio_facturacion + t_mes_facturacion) = '201905' then '793BA5F3-0A9D-419F-9232-32F917BE46B1'
							  else 'SIN_cfdiUUID' end
    from #consulta
		   --Total="15607.10" --- suma de los valores SubTotal + cfdiImporte
    select @w_total= convert(money,@w_subTotal) + convert(money,@w_cfdiImporte)
    
    select @w_xml =  '<?xml version="1.0" encoding="UTF-8"?>'+
                     '<FacturaInterfactura>'+
                     '<Emisor RI="0156454"/>'+
                     '<Receptor RFC="XAXX010101000" cfdiUsoCFDI="P01" IdExterno="'+@w_idExterno+'" />'+
                     '<Encabezado TipoDocumento="I" LugarExpedicion="01219" Fecha="'+@w_fecha+'" cfdiMetodoPago="PUE" RegimenFiscalEmisor="601" Moneda="MXN" SubTotal="'+@w_subTotal+'" Total="'+@w_total+'" cfdiFormaPago="03" cfdiTipoRelacion="04">'+
                     '<Cuerpo Renglon="1" Cantidad="1" U_x0020_de_x0020_M="ACT" Concepto="INTERESES ORDINARIOS '+@w_bucs+'" PUnitario="'+@w_pUnitario+'" Importe="'+@w_importe+'" cfdiClaveProdServ="01010101" cfdiClaveUnidad="ACT" Codigo="'+@w_codigo+'">'+
                     '<Traslado CodigoMultiple="TrasladoConcepto" cfdiBase="'+@w_cfdiBase+'" cfdiImpuesto="002" cfdiTipoFactor="Tasa" cfdiTasaOCuota="0.160000" cfdiImporte="'+@w_cfdiImporte+'"/>'+
                     '</Cuerpo>'+
                     '<Impuestos CodigoMultiple="cfdiImpuestos" totalImpuestosTrasladados="'+@w_totalImpuestosTrasladados+'">'+
                     '<Traslado CodigoMultiple="cfdiImpuestos" cfdiImpuesto="002" cfdiTipoFactor="Tasa" cfdiTasaOCuota="0.160000" cfdiImporte="'+@w_cfdiImporte+'"/>'+
                     '</Impuestos>'+
                     '<CfdiRelacionado CodigoMultiple="CfdiRelacionado" cfdiUUID="'+@w_cfdiUUID+'"/>'+
                     '</Encabezado>'+
                     '</FacturaInterfactura>'  
	  
	----------------------------------------------------GENERACION DE ARCHIVO
	truncate table sb_gen_xml_refacturacion
	
    insert into sb_gen_xml_refacturacion values (@w_xml)
    
    select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_gen_xml_refacturacion out '
    
    select @w_nombre_archivo = @w_idExterno + '.xml'
    
    select @w_destino  = @w_path + @w_nombre_archivo,
           @w_errores  = @w_path + @w_idExterno + '.err'
    
    select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
	
    print 'Generado: ' + @w_destino
    exec @w_error = xp_cmdshell @w_comando

    if @w_error <> 0 
    begin
      select @w_error = 70146,
             @w_msg = 'Fallo el BCP: '+@w_destino
      goto ERROR_PROCESO
    end
      
	select @w_siguiente = @w_siguiente + 1

	----------------------------------------------------UPDATE PARA SEGUIR PROCESANDO	
	update #consulta
	set t_nombre_archivo = @w_nombre_archivo
	from #consulta_procesar_tmp
	where t_id = id
	
	update sb_info_gen_xml_refacturacion
    set procesado = 'S',
        nombre_archivo = t_nombre_archivo,
		fecha_generacion_archivo = getdate()
    from #consulta
    where t_id = id

	----------------------------------------------------BORRAR TABLA TEMPORAR CREADA PARA EL TOP
	drop table #consulta
end

return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fecha         = @i_param1,
     @i_error         = @w_error,
     @i_usuario       = 'usrbatch',
     @i_tran          = 26004,
     @i_tran_name     = null,
     @i_rollback      = 'S'
go
  
