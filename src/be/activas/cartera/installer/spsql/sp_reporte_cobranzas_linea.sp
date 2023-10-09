/********************************************************************/
/*   ARCHIVO:         sp_reporte_cobranzas_linea.sp                 */
/*   NOMBRE LOGICO:   sp_reporte_cobranzas_linea                    */
/*   PRODUCTO:        COBIS CARTERA                                 */
/********************************************************************/
/*                       IMPORTANTE                                 */
/*   Esta aplicacion es parte de los  paquetes bancarios propiedad  */
/*   de MACOSA S.A.                                                 */
/*   Su uso no autorizado queda  expresamente  prohibido asi como   */
/*   cualquier alteracion o agregado hecho  por  alguno de sus      */
/*   usuarios sin el debido consentimiento por escrito de MACOSA.   */
/*   Este programa esta protegido por la ley de derechos de autor   */
/*   y por las convenciones  internacionales de propiedad           */
/*   intelectual.  Su uso  no  autorizado dara derecho a MACOSA     */
/*   para obtener ordenes  de secuestro o  retencion  y  para       */
/*   perseguir  penalmente a  los autores de cualquier infraccion.  */
/********************************************************************/
/*                        PROPOSITO                                 */
/*  Reporte de cobraza en linea caso#193431 Reporte                 */ 
/*  cobranzas línea                                                 */
/********************************************************************/
/*                     MODIFICACIONES                               */
/*   FECHA         AUTOR               RAZON                        */
/********************************************************************/

use cob_cartera
go

IF OBJECT_ID ('dbo.sp_reporte_cobranzas_linea') IS NOT NULL
	DROP PROCEDURE dbo.sp_reporte_cobranzas_linea
GO

CREATE PROC dbo.sp_reporte_cobranzas_linea(
    @i_fecha_proceso datetime
) 
as 
declare 
@w_fecha_proceso    datetime,
@w_fecha            datetime,
@w_ffecha           int,
@w_hora             varchar(6),
@w_path             varchar(256),
@w_sp_name          varchar(32),          
@w_path_destino     varchar(200), 
@w_s_app            varchar(40),
@w_cmd              varchar(5000),
@w_destino          varchar(255),
@w_errores          varchar(255),
@w_comando          varchar(6000),
@w_error            int, 
@w_mensaje          varchar(100),
@w_fecha_ini        datetime,
@w_fecha_fin        datetime,
@w_hora_ini         varchar(8),
@w_ffecha_103       int,
@w_ffecha_108       int


select @w_ffecha = 111, @w_ffecha_103 = 103, @w_ffecha_108 = 108

select @w_path = pa_char from cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'RRCBLI' --ruta
select @w_hora_ini = pa_char from cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HRCBLI' -- hora


select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if (@i_fecha_proceso is null)
    select @w_fecha = getdate()
else 
    select @w_fecha = @i_fecha_proceso

select @w_fecha_ini = CONVERT(datetime, CONVERT(varchar(20), dateadd(dd, -1, @w_fecha), @w_ffecha) + ' ' + @w_hora_ini, @w_ffecha)
select @w_fecha_fin = @w_fecha

print '@w_fecha_ini: ' + convert(varchar, @w_fecha_ini)
print '@w_fecha_fin: ' + convert(varchar, @w_fecha_fin)

select --top 200 -- borrar 200
'oficina' = convert(varchar(100),null),
cod_oficina = convert(int,null),
'cc'      = convert(varchar(100),null),
'region'  = convert(varchar(100),null),
'id_contrato_grupo'     = convert(varchar(20),null),
'nombre_grupo_cliente'  = convert(varchar(100),null),
co_secuencial,
co_corresponsal,
co_tipo,  
co_fecha_proceso,
co_fecha_valor,
co_referencia,
co_monto,
co_estado,
co_archivo_ref,
co_login,
co_fecha_real,
co_codigo_interno
into #pagos_corresponsal
from cob_cartera..ca_corresponsal_trn
where co_fecha_real between @w_fecha_ini and @w_fecha_fin
--order by co_secuencial desc  -- borrar

--PI -- co_codigo_interno es la operacion
--PG -- co_codigo_interno es el grupo 
--GL -- co_codigo_interno es el grupo	
--GI -- co_codigo_interno es el cliente		

update #pagos_corresponsal set
id_contrato_grupo = convert(varchar(20),co_codigo_interno),
cod_oficina = gr_sucursal ,
nombre_grupo_cliente = gr_nombre
from cobis..cl_grupo
where co_tipo = 'GL' 
and   co_codigo_interno = gr_grupo

update #pagos_corresponsal set
id_contrato_grupo = convert(varchar(20),co_codigo_interno),
cod_oficina = en_oficina,
nombre_grupo_cliente = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') +' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') 
from cobis..cl_ente
where co_tipo = 'GI' 
and   en_ente = co_codigo_interno

--XQ debe aparecer el numero de banco  -- en las GI el co_codigo_interno es el cliente
select op_banco, op_cliente
into #clientes_ind
from #pagos_corresponsal, cob_cartera..ca_operacion
where co_tipo = 'GI' 
and co_codigo_interno = op_cliente
and op_toperacion in ('INDIVIDUAL')
and op_operacion = (select max(op_operacion) from cob_cartera..ca_operacion where co_codigo_interno = op_cliente and op_toperacion in ('INDIVIDUAL'))

update #pagos_corresponsal set
id_contrato_grupo = op_banco
from #clientes_ind
where co_codigo_interno = op_cliente

update #pagos_corresponsal set
id_contrato_grupo = op_banco,
cod_oficina = op_oficina,
nombre_grupo_cliente = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') +' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') 
from cob_cartera..ca_operacion,
cobis..cl_ente
where co_codigo_interno = op_operacion
and   co_tipo = 'PI'
and op_cliente = en_ente

update #pagos_corresponsal set
id_contrato_grupo = gr_grupo, --op_banco,
cod_oficina = op_oficina,
nombre_grupo_cliente = gr_nombre
from cob_cartera..ca_operacion,
cobis..cl_grupo
where co_codigo_interno = op_operacion
and    co_tipo = 'PG'
and op_cliente = gr_grupo

update #pagos_corresponsal set
oficina = of_nombre
from cobis..cl_oficina
where of_oficina = cod_oficina

update #pagos_corresponsal
set region = (select A.of_nombre
                  from cobis..cl_oficina A, cobis..cl_oficina B
                  where A.of_oficina = B.of_regional
                  and   B.of_oficina = P.cod_oficina)
from  #pagos_corresponsal P

update #pagos_corresponsal set
cc = of_descripcion
from cob_conta..cb_relofi,
cob_conta..cb_oficina
where re_ofadmin = cod_oficina
and   of_oficina = re_ofconta

truncate table ca_reporte_cobranza_linea

insert into ca_reporte_cobranza_linea(
rc_oficina,                 rc_oficina_id,     rc_region,          rc_contrado_grupo,
rc_nombre_grupo_cliente,    rc_secuencial,     rc_corresponsal,    rc_tipo,
rc_fecha_proceso,           rc_fecha_valor,    rc_referencia,      rc_monto,
rc_estado,                  rc_archivo_ref,    rc_login,           rc_fecha_real
)
select 
'oficina',                  'cc',               'región' ,            'id-contrato_grupo',
'nombre_grupo_cliente',     'co_secuencial',    'co_corresponsal',    'co_tipo',
'co_fecha_proceso',         'co_fecha_valor',   'co_referencia',      'co_monto',
'co_estado',                'co_archivo_ref',   'co_login',           'co_fecha_real'

insert into ca_reporte_cobranza_linea(
rc_oficina,                                   rc_oficina_id,                       rc_region,          rc_contrado_grupo, -- 1
rc_nombre_grupo_cliente,                      rc_secuencial,                       rc_corresponsal,    rc_tipo,           -- 2
rc_fecha_proceso,                                                                                                         -- 3
rc_fecha_valor,                                                                                                           -- 4
rc_referencia,                                rc_monto,                            rc_estado,          rc_archivo_ref,    -- 5
rc_login,                                     rc_fecha_real                                                               -- 6
)                                                                                  
select                                                                             
oficina,                                      convert(varchar, cod_oficina),       region ,            id_contrato_grupo, -- 1
nombre_grupo_cliente,                         convert(varchar, co_secuencial),     co_corresponsal,    co_tipo,           -- 2
convert(varchar, co_fecha_proceso, @w_ffecha_103) + ' '+ convert(varchar, co_fecha_proceso, @w_ffecha_108),               -- 3
convert(varchar, co_fecha_valor, @w_ffecha_103) + ' '+ convert(varchar, co_fecha_valor, @w_ffecha_108),                   -- 4
co_referencia,                               convert(varchar, co_monto),           co_estado,          co_archivo_ref,    -- 5    
co_login,                                    convert(varchar, co_fecha_real, @w_ffecha_103) + ' '+convert(varchar, co_fecha_real, @w_ffecha_108)  -- 6
from #pagos_corresponsal

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_reporte_cobranza_linea out '

select @w_hora = case when cast(datepart(hour, getdate()) as char(2)) < 10 then +'0'+ cast(datepart(hour, getdate()) as char(1)) 
				      else cast(datepart(hour, getdate()) as char(2)) end + 
				case when cast(datepart(minute, getdate()) as char(2)) < 10 then +'0'+ cast(datepart(minute, getdate()) as char(1)) 
				     else cast(datepart(minute, getdate()) as char(2)) end + 
				case when cast(datepart(second, getdate()) as char(2)) < 10 then +'0'+ cast(datepart(second, getdate())  as char(1)) 
				     else cast(datepart(second, getdate()) as char(2)) end

select
@w_destino  = @w_path + 'COB_LINEA_' +  replace(CONVERT(varchar(10), @w_fecha, @w_ffecha),'/', '')+ @w_hora + '.txt',
@w_errores  = @w_path + 'COB_LINEA_' +  replace(CONVERT(varchar(10), @w_fecha, @w_ffecha),'/', '')+ @w_hora + '.err'

select @w_comando = @w_cmd + @w_destino+ ' -b5000 -w -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

PRINT ' CMD_COBRANZA_LINEA: ' + @w_comando 

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error generando Archivo de COBRANZA EN LINEA'
   goto ERROR
end


return 0  
 
ERROR:
exec cobis..sp_errorlog 
@i_fecha        = @w_fecha_proceso,
@i_error        = @w_error,
@i_usuario      = 'usrbatch',
@i_tran         = 26004,
@i_descripcion  = @w_mensaje,
@i_tran_name    =null,
@i_rollback     ='S'
return @w_error

go