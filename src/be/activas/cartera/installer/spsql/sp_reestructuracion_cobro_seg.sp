/*************************************************************/
/*   ARCHIVO:         	sp_reestructuracion_cobro_seg.sp              */
/*   NOMBRE LOGICO:   	sp_reestructuracion_cobro_seg.sp           */
/*   PRODUCTO:        		CARTERA                           */
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
/*   Cargar datos de archivo para el cobor de seguro de      */
/*   prestamos reestructrados							     */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   18-Mayo-2020  PRO                  Emision Inicial.     */
/*************************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.sp_reestructuracion_cobro_seg') IS NOT NULL
	DROP PROCEDURE dbo.sp_reestructuracion_cobro_seg
GO

create proc sp_reestructuracion_cobro_seg (	
	@i_param1		       datetime    = null,--Fecha
	@i_param2             varchar(255) = null,--Nombre del archivo
	@t_show_version       bit	       = 0,
	@t_debug              char(1)      = 'N',
    @t_file               varchar(14)  = null

)
as


declare 
@w_s_app           varchar(255),
@w_sp_name         varchar(32),
@w_command         nvarchar(MAX),
@w_archivo         varchar(255),
@w_existe_arch     int,
@w_msg             varchar(255),
@w_error           int,
@w_banco           varchar(24),
@w_cliente         int,
@w_cuotas          int,
@w_fecha_proceso   datetime,
@w_comando         varchar(6000),
@w_archivo_ruta    varchar(255),
@w_filas           int,
@w_query           varchar(6000),
@w_existe_arch_xml int,
@w_archivo_format  varchar(255),
@w_oficina			int,
@w_moneda			int,
@w_toperacion		catalogo,
@w_estado		    char(1),
@w_seguro			char(1),
@w_div_inicio		int,
@w_div_fin			int,
@w_operacion		int,
@w_est_vigente      tinyint,
@w_reestructurada	char(1),
@w_tiene_seguro		char(1),
@w_valor_seguro		money,
@w_dividendo		int,
@w_monto_cobrar		money,
@w_num_dec          int,
@w_commit           char(1)
	

if @t_show_version = 1
begin
    print 'Stored procedure sp_reestructuracion_cobro_seg, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_reestructuracion_cobro_seg'

select 
@w_archivo      = ba_path_destino+@i_param2,
@w_archivo_ruta = ba_path_destino
from cobis..ba_batch 
where ba_batch = 7095
if @@rowcount=0 begin

   select @w_error = 720332,
	      @w_msg   = 'NO EXISTE LA RUTA DEL ARCHIVO'  
   goto ERROR_PROCESO
   
end

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso
select @w_archivo_format=@w_archivo_ruta+'reestructuracion_format.xml'

print 'ruta'+@w_archivo
print '@i_param1'+convert(varchar(50),@i_param1)
print '@i_param2'+convert(varchar(50),@i_param2)
print '@w_fecha_proceso'+convert(varchar(50),@w_fecha_proceso)
print '@w_archivo_format'+@w_archivo_format


exec master..xp_fileexist @w_archivo , @w_existe_arch OUT

if @w_existe_arch = 0 begin

   select @w_error = 720330,
	      @w_msg   = 'NO SE ENCONTRO EL ARCHIVO '+@i_param2    
   goto ERROR_PROCESO

end
exec master..xp_fileexist @w_archivo_format , @w_existe_arch_xml OUT

if @w_existe_arch_xml = 0 begin
   select @w_error = 720330,
	      @w_msg   = 'NO SE ENCONTRO EL ARCHIVO DE FORMATO '+'reestructuracion_format.xml'    
   goto ERROR_PROCESO

end

if exists(select 1 from ca_cobro_seg_res_archivo where cs_archivo=@i_param2)begin
	
   select @w_error = 720331,
	      @w_msg   = 'ARCHIVO '+@i_param2+' YA FUE PROCESADO ANTERIORMENTE'    
   goto ERROR_PROCESO
                     
end

truncate table cob_cartera..ca_cobro_seg_res_archivo
truncate table cob_cartera..ca_cobro_seg_res_archivo_tmp


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

SELECT @w_command =
'INSERT INTO cob_cartera..ca_cobro_seg_res_archivo(
	cs_banco, cs_cliente, cs_cuotas,   	cs_seguro)
SELECT
	ra_banco, ra_cliente, ra_cuotas,  	ra_seguro	
FROM  OPENROWSET (BULK ''' + @w_archivo + ''',
FORMATFILE = ''' + @w_archivo_ruta + 'reestructuracion_format.xml''
 ) AS ln;'
 
exec sp_executesql @w_command;

select @w_banco=0 

select @w_valor_seguro = pa_money from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'


while(1=1)begin

	select @w_reestructurada = 'N', @w_tiene_seguro	 = 'N'

	select top 1
	@w_banco   = cs_banco,   
	@w_seguro = cs_seguro,
	@w_cuotas	= cs_cuotas
	from ca_cobro_seg_res_archivo 
	where cs_banco>@w_banco
	order by cs_banco asc
	if @@rowcount=0 break
	
	select @w_oficina 		= op_oficina,
			@w_moneda		= op_moneda,
			@w_toperacion	= op_toperacion,
			@w_operacion	= op_operacion
	from ca_operacion 
	where op_banco = @w_banco
	
	print 'OPERACION: '+ @w_banco
	
	exec sp_decimales
	@i_moneda       = @w_moneda,
	@o_decimales    = @w_num_dec out
	
	if exists(select * from ca_transaccion where tr_tran = 'RES' and tr_operacion = @w_operacion and tr_estado <> 'RV')
	begin
		select @w_reestructurada = 'S'
		print 'REESTRUCTURADA'
	end
	
	if exists(select * from cob_cartera..ca_amortizacion where am_operacion = @w_operacion and am_concepto ='SEGAD')
	begin
		select @w_tiene_seguro = 'S'
		print 'YA TIENE SEGURO ADICIONAL'
	end
	
	select @w_estado = null, @w_msg = null
	
	if @w_seguro = 'S' AND @w_reestructurada = 'S' and @w_tiene_seguro <> 'S'
	begin	
		
		exec @w_error = sp_estados_cca
		@o_est_vigente    = @w_est_vigente   out		
		
		select @w_div_inicio = di_dividendo
		from ca_dividendo
		where di_operacion = @w_operacion
		and di_estado = @w_est_vigente
		
		select @w_div_fin = max(di_dividendo)
		from ca_dividendo
		where di_operacion = @w_operacion
		
		select @w_dividendo = @w_div_inicio
		select @w_monto_cobrar = round(@w_valor_seguro/(@w_div_fin -@w_dividendo+1),@w_num_dec)
		
		print 'DIVIDENDO INI: '+convert(varchar(10),@w_div_inicio)+' DIVIDENDO FIN: '+convert(varchar(10),@w_div_fin)
		print 'MONTO A COBRAR: '+convert(varchar(10),@w_monto_cobrar)
		
		--CICLO PARA PRORRATEAR LA TASA DE SEGURO
		if @@trancount = 0 begin  
		   select @w_commit = 'S'
		   begin tran 
		end
		
		while @w_dividendo <= @w_div_fin
		begin
		
			if (@w_dividendo = @w_div_fin)
			begin
				select @w_monto_cobrar = @w_valor_seguro - (@w_monto_cobrar * (@w_div_fin -@w_div_inicio))
			end
			
			print 'SE AGREGA: '+convert(varchar(10),@w_monto_cobrar) + ' A DIVIDENDO: '+convert(varchar(10),@w_dividendo)
		
			exec @w_error=sp_otros_cargos	
			@s_date         	= @w_fecha_proceso,
			@s_user	 	    = 'segad_covid19',
			@s_term  		= 'consola',
			@s_ofi	       	= @w_oficina,
			@i_banco      	= @w_banco,
			@i_moneda      	= @w_moneda,
			@i_operacion		= 'I',
			@i_toperacion	= @w_toperacion,
			@i_desde_batch	= 'N',
			@i_en_linea		= 'N',
			@i_tipo_rubro	= 'O',
			@i_concepto		= 'SEGAD',
			@i_monto			= @w_monto_cobrar,
			@i_div_desde		= @w_dividendo,
			@i_div_hasta		= @w_dividendo,
			@i_generar_trn	= 'N',
			@i_comentario	= 'Generado por reestructuracion SEGAD'
	   
			if @w_error!=0
			begin
				if @w_commit = 'S'begin 
				   select @w_commit = 'N'
				   rollback tran    
				end 
		   
				select @w_msg =  convert(varchar(10),@w_error) + '-'+mensaje from cobis..cl_errores where numero = @w_error
				exec sp_errorlog 
				@i_fecha       = @w_fecha_proceso,
				@i_error       = @w_error, 
				@i_usuario     = 'usrbatch', 
				@i_tran        = 7999,
				@i_tran_name   = @w_sp_name,
				@i_cuenta      = @w_banco,
				@i_rollback    = 'N',
				@i_descripcion = @w_msg
			  
				select @w_estado = 'E'
				break
			end
			else
			begin
				select @w_estado = 'P'
			end
			select @w_dividendo = @w_dividendo +1
		end
		
		if @w_commit = 'S' begin 
			select @w_commit = 'N'
			commit tran
		end
	end
	else
	begin
		if(@w_seguro = 'S')
		begin
			if(@w_reestructurada <>'S')
				select @w_msg = 'LA OPERACION NO HA SIDO REESTRUCTURADA'
			
			if(@w_tiene_seguro ='S')
				select @w_msg = 'LA OPERACION YA TIENE SEGURO ADICIONAL'
				
			select @w_estado = 'E'
		end
	end
	
	update ca_cobro_seg_res_archivo
	set cs_mensaje 	= @w_msg,
		cs_estado	= @w_estado,
		cs_fecha	= @w_fecha_proceso,
		cs_archivo	= @i_param2
	where cs_banco = @w_banco
end--fin while 


-- SI HAY REGISTROS CON ERROR SE GENERA ARCHIVO DE ERROR
if exists(select * from cob_cartera..ca_cobro_seg_res_archivo where cs_mensaje is not null or cs_estado = 'E')
begin 
    /*INSERCION DE CABECERAS*/
	insert into  cob_cartera..ca_cobro_seg_res_archivo_tmp(
	cs_banco_tmp,	 cs_cliente_tmp,	 cs_estado_tmp,	cs_mensaje_tmp  
	)
	select 
	'OPERACION',
	'CLIENTE'  ,
	'ESTADO'   ,
	'MENSAJE'
	/*INSERTO LA DATA*/
	insert into  cob_cartera..ca_cobro_seg_res_archivo_tmp(
	cs_banco_tmp,	 cs_cliente_tmp,	 cs_estado_tmp,	cs_mensaje_tmp  
	)
	select
	cs_banco,
	cs_cliente,
	cs_estado,
	cs_mensaje 
	from
	cob_cartera..ca_cobro_seg_res_archivo
	where cs_mensaje is not null or cs_estado = 'E'

	select @w_archivo= replace(@w_archivo,'.txt','_SEGAD.err')
	print '@w_archivo 1'+@w_archivo

	select @w_query='select * from cob_cartera..ca_cobro_seg_res_archivo_tmp'

	select @w_comando = 'bcp "' + @w_query + '" queryout "'

	select @w_comando = @w_comando + @w_archivo + '" -b5000 -c -C RAW'+ @w_s_app + 's_app.ini -T -t"|"'

	exec @w_error = xp_cmdshell @w_comando
	if @w_error <> 0 begin
	   select @w_error = 357023,
			   @w_msg   = 'ERROR AL EJECUTAR BCP'    
	   goto ERROR_PROCESO
	end
end

return 0

ERROR_PROCESO:
print'Num error'+ convert(varchar(50),@w_error)
select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg	= @w_msg
return 1
go