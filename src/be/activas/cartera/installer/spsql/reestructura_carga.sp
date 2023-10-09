/*************************************************************/
/*   ARCHIVO:         	reestructura_carga.sp                */
/*   NOMBRE LOGICO:   	sp_reestructuracion_carga.sp         */
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
/*   Cargar datos de archivo para Reestructuracion de        */
/*   operacones desplazadas.                                 */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   14-Mayo-2020  WTOLEDO             Emision Inicial.      */
/*************************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.sp_reestructuracion_carga') IS NOT NULL
	DROP PROCEDURE dbo.sp_reestructuracion_carga
GO

create proc sp_reestructuracion_carga (	
	@i_param1		   datetime     = null,--Fecha
	@i_param2         varchar(255) = null,--Nombre del archivo
	@t_show_version   bit	       = 0,
	@t_debug          char(1)      = 'N',
   @t_file           varchar(14)  = null

)
as

declare 
@w_s_app           varchar(255),
@w_sp_name         varchar(32),
@w_archivo         varchar(255),
@w_archivo_ruta    varchar(255),
@w_error           int,
@w_o_error         int,
@w_existe_arch     int,
@w_msg             varchar(255),
@w_existe_arch_xml int,
@w_archivo_format  varchar(255),
@w_comando         varchar(6000),
@w_command         nvarchar(MAX),
@w_fecha_proceso   datetime,
@w_banco           varchar(24),
@w_cliente         int,
@w_cuotas          int,
@w_query           varchar(6000),
@w_estado          char(1)

if @t_show_version = 1
begin
    print 'Stored procedure sp_reestructuracion_carga, Version 1.0.0'
    return 0
end

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_reestructuracion_carga'

select 
@w_archivo      = ba_path_destino+@i_param2,
@w_archivo_ruta = ba_path_destino
from cobis..ba_batch 
where ba_batch = 7094
if @@rowcount=0 begin

   select @w_error = 720332,
         @w_msg   = 'NO EXISTE LA RUTA DEL ARCHIVO'  
   goto ERROR_PROCESO
   
end

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso
select @w_archivo_format=@w_archivo_ruta+'reestructuracion_format.xml'

-- VALIDA SI EXISTE EL ARCHIVO A PROCESAR
exec master..xp_fileexist @w_archivo , @w_existe_arch OUT
if @w_existe_arch = 0 begin

   select @w_error = 720330,
	      @w_msg   = 'NO SE ENCONTRO EL ARCHIVO '+@i_param2    
   goto ERROR_PROCESO

end

-- VALIDA SI EXISTE EL ARCHIVO DE FORMATO
exec master..xp_fileexist @w_archivo_format , @w_existe_arch_xml OUT
if @w_existe_arch_xml = 0 begin
   select @w_error = 720330,
	      @w_msg   = 'NO SE ENCONTRO EL ARCHIVO DE FORMATO '+'reestructuracion_format.xml'    
   goto ERROR_PROCESO

end

-- VALIDA SI EL ARCHIVO FUE PROCESADO
if exists(select 1 from ca_reestructuracion_archivo where ra_archivo = @i_param2) 
begin	
   select @w_error = 720331,
	      @w_msg   = 'ARCHIVO '+@i_param2+' YA FUE PROCESADO ANTERIORMENTE'    
   goto ERROR_PROCESO
end

truncate table cob_cartera..ca_reestructuracion_archivo
truncate table cob_cartera..ca_reestructuracion_archivo_tmp

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

SELECT @w_command =
'INSERT INTO cob_cartera..ca_reestructuracion_archivo(
ra_banco,  	ra_cliente,	ra_cuotas, ra_seguro)
SELECT
ra_banco,  	ra_cliente,	ra_cuotas, ra_seguro 
FROM OPENROWSET (BULK ''' + @w_archivo + ''',
FORMATFILE = ''' + @w_archivo_ruta + 'reestructuracion_format.xml''
 ) AS ln;'
exec sp_executesql @w_command;

set @w_banco=0 

while(1=1)begin

	select @w_error=null, @w_o_error=null, @w_msg=null
   
   select top 1
   @w_banco   = ra_banco,   
   @w_cliente = ra_cliente, 
   @w_cuotas  = ra_cuotas
   from ca_reestructuracion_archivo 
   where ra_banco > @w_banco
   order by ra_banco asc
   if @@rowcount=0 break

   exec  @w_error = cob_cartera..sp_reestructuracion_covid19
   @i_banco              = @w_banco,
   @i_cuotas_adicionales = @w_cuotas,
   @o_error              = @w_o_error out,
   @o_msg                = @w_msg out
   
   if @w_o_error is not null or @w_o_error != 0
   begin
      select @w_error = @w_o_error
   end
   
   if @w_error!=0 begin
      exec sp_errorlog 
      @i_fecha       = @w_fecha_proceso,
      @i_error       = @w_error, 
      @i_usuario     = 'usrbatch', 
      @i_tran        = 7999,
      @i_tran_name   = @w_sp_name,
      @i_cuenta      = @w_banco,
      @i_rollback    = 'N',
      @i_descripcion = @w_msg

      select @w_estado = 'E' --ERROR
   end
   else
   begin
      select @w_estado = 'P' --PROCESADO
   end
   
   update ca_reestructuracion_archivo
      set ra_mensaje = @w_msg, 
          ra_estado  = @w_estado,
          ra_fecha   = @w_fecha_proceso,
          ra_archivo = @i_param2
    where ra_banco   = @w_banco
	
end--fin while 

/*INSERCION DE CABECERAS*/
insert into cob_cartera..ca_reestructuracion_archivo_tmp(
ra_banco_tmp, ra_cliente_tmp, ra_cuotas_tmp, ra_seguro_tmp, ra_mensaje_tmp  
)
select 
'OPERACION', 'CLIENTE', 'CUOTAS', 'SEGURO', 'MENSAJE'

/*INSERTO LA DATA*/
insert into  cob_cartera..ca_reestructuracion_archivo_tmp(
ra_banco_tmp, ra_cliente_tmp, ra_cuotas_tmp, ra_seguro_tmp, ra_mensaje_tmp  
)
select
ra_banco, ra_cliente, ra_cuotas, replace(replace(ra_seguro,char(13),''),char(10),''), ra_mensaje 
from
cob_cartera..ca_reestructuracion_archivo
where ra_mensaje is not null or ra_estado = 'E'


select @w_archivo = replace(@w_archivo,'.txt','_reestr.err')

select @w_query='select * from cob_cartera..ca_reestructuracion_archivo_tmp'

select @w_comando = 'bcp "' + @w_query + '" queryout "'
select @w_comando = @w_comando + @w_archivo + '" -b5000 -c -C RAW'+ @w_s_app + 's_app.ini -T -t"|"'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 357023,
	       @w_msg   = 'ERROR AL EJECUTAR BCP'    
   goto ERROR_PROCESO
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

