/*************************************************************/
/*   ARCHIVO:         	desplazamiento_carga.sp              */
/*   NOMBRE LOGICO:   	sp_desplazamiento_carga.sp           */
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
/*   Cargar datos de archivo para desplazamiento de coutas   */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   31-Marzo-2020  PXSG                Emision Inicial.     */
/*   29-Junio-2020  DCU                 Req. 141555          */
/*************************************************************/
use cob_cartera
go

IF OBJECT_ID ('dbo.sp_desplazamiento_carga') IS NOT NULL
	DROP PROCEDURE dbo.sp_desplazamiento_carga
GO

create proc sp_desplazamiento_carga (	
	@i_param1		      datetime    = null, -- Fecha
	@i_param2             varchar(255) = null,-- Nombre del archivo
	@i_param3             char(1)      = 'N', -- Fecha Valor Vencimiento
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
@w_archivo_format  varchar(255)

if @t_show_version = 1
begin
    print 'Stored procedure sp_carga_archivo_dsp, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_desplazamiento_carga'

select 
@w_archivo      = ba_path_destino+@i_param2,
@w_archivo_ruta = ba_path_destino
from cobis..ba_batch 
where ba_batch = 7093
if @@rowcount=0 begin

   select @w_error = 720332,
	      @w_msg   = 'NO EXISTE LA RUTA DEL ARCHIVO'  
   goto ERROR_PROCESO
   
end

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso
select @w_archivo_format=@w_archivo_ruta+'desplazamiento_format.xml'

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
	      @w_msg   = 'NO SE ENCONTRO EL ARCHIVO DE FORMATO '+'desplazamiento_format.xml'    
   goto ERROR_PROCESO

end

if exists(select 1 from ca_desplazamiento where de_archivo=@i_param2 )begin
	
   select @w_error = 720331,
	      @w_msg   = 'ARCHIVO '+@i_param2+' YA FUE PROCESADO ANTERIORMENTE'    
   goto ERROR_PROCESO
                     
end

truncate table cob_cartera..ca_desplazamiento_archivo
truncate table cob_cartera..ca_desplazamiento_archivo_tmp


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

/*select @w_command = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_desplazamiento_archivo in'+@w_archivo +' -T -c b1000 t"|"'

select @w_command

*/

SELECT @w_command =
'INSERT INTO cob_cartera..ca_desplazamiento_archivo(
	da_banco,  	da_cliente,	da_cuotas)
SELECT
	da_banco,  	da_cliente,	da_cuotas	
FROM  OPENROWSET (BULK ''' + @w_archivo + ''',
FORMATFILE = ''' + @w_archivo_ruta + 'desplazamiento_format.xml''
 ) AS ln;'
exec sp_executesql @w_command;

set @w_banco=0 

while(1=1)begin

	select top 1
	@w_banco   = da_banco,   
	@w_cliente = da_cliente, 
	@w_cuotas  = da_cuotas
	from ca_desplazamiento_archivo 
	where da_banco>@w_banco
	order by da_banco asc
	if @@rowcount=0 break
	
   exec @w_error=sp_desplazamiento	
   @i_banco          = @w_banco  ,
   @i_cliente        = @w_cliente,
   @i_fecha_valor    = @i_param1 ,--fecha de proceso
   @i_cuotas         = @w_cuotas ,
   @i_archivo        = @i_param2 ,--nombre del archivo
   @i_cuota_vencida  = @i_param3 ,
   @i_genera_int_esp = 'N'       ,
   @o_msg            = @w_msg   out
   
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
      
      Update ca_desplazamiento_archivo
      set da_mensaje = @w_msg
      where da_banco = @w_banco

   end
	
end--fin while 

/*INSERCION DE CABECERAS*/

insert into  cob_cartera..ca_desplazamiento_archivo_tmp(
da_banco_tmp,	 da_cliente_tmp,	 da_cuotas_tmp,	da_mensaje_tmp  
)
select 
'OPERACION',
'CLIENTE'  ,
'CUOTAS'   ,
'MENSAJE'
/*INSERTO LA DATA*/
insert into  cob_cartera..ca_desplazamiento_archivo_tmp(
da_banco_tmp,	 da_cliente_tmp,	 da_cuotas_tmp,	da_mensaje_tmp  
)
select
da_banco,
da_cliente,
da_cuotas,
da_mensaje 
from
cob_cartera..ca_desplazamiento_archivo
where da_mensaje is not null


select @w_archivo= replace(@w_archivo,'.txt','.err')
print '@w_archivo 1'+@w_archivo

select @w_query='select * from cob_cartera..ca_desplazamiento_archivo_tmp'

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