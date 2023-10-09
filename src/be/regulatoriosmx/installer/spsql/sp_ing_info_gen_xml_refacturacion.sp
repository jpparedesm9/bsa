/**************************************************************/
/*   ARCHIVO:       sp_ing_info_gen_xml_refacturacion.sp      */
/*   NOMBRE LOGICO: sp_ing_info_gen_xml_refacturacion.sp      */
/*   PRODUCTO:        		                                  */
/**************************************************************/
/*                     IMPORTANTE                             */
/*   Esta aplicacion es parte de los  paquetes bancarios      */
/*   propiedad de MACOSA S.A.                                 */
/*   Su uso no autorizado queda  expresamente  prohibido      */
/*   asi como cualquier alteracion o agregado hecho  por      */
/*   alguno de sus usuarios sin el debido consentimiento      */
/*   por escrito de MACOSA.                                   */
/*   Este programa esta protegido por la ley de derechos      */
/*   de autor y por las convenciones  internacionales de      */
/*   propiedad intelectual.  Su uso  no  autorizado dara      */
/*   derecho a MACOSA para obtener ordenes  de secuestro      */
/*   o  retencion  y  para  perseguir  penalmente a  los      */
/*   autores de cualquier infraccion.                         */
/**************************************************************/
/*                     PROPOSITO                              */
/*   Este procedimiento permite insertar informacion necesaria*/
/*   refacturacion caso #150202-Generación de XML para        */
/*	 refacturación 2018 y 2019, se añade a los instaladores   */
/*	 por posible peticion de otros reprocesos                 */
/**************************************************************/
/*                     MODIFICACIONES                         */
/*   FECHA         AUTOR               RAZON                  */
/*   03-Dic-2020   ACH                 Req. 150202            */
/**************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ing_info_gen_xml_refacturacion')
    drop proc sp_ing_info_gen_xml_refacturacion
go

create proc sp_ing_info_gen_xml_refacturacion (
    @i_param1 datetime = null
)as

declare @w_ciudad_nacional int,  
        @w_fecha_ing datetime, 
        @w_fecha_fin_mes datetime,
        @w_fecha_fin_mes_aux VARCHAR(30), 
        @w_fecha_fin_mes_habil datetime,
		@w_fecha_ini_mes datetime

print 'Inicio proceso sp_ing_info_gen_xml_refacturacion para: Anio:' + convert(varchar(4), year(@i_param1)) 
                                                              + '----Mes:' + case when convert(varchar(2),month(@i_param1)) < 10
	                                                                        then '0' + convert(varchar(2),month(@i_param1))
							                                                else convert(varchar(2),month(@i_param1)) end
if (@i_param1 is null)
    return 1

print 'Continua-sp_ing_info_gen_xml_refacturacion'

select  @w_fecha_ing = @i_param1
----------------------------------------------------OBTENER FECHA FIN DE MES HABIL
select @w_ciudad_nacional = pa_int
  from cobis..cl_parametro with (nolock)
 where pa_nemonico = 'CIUN'
   and pa_producto = 'ADM'

select @w_fecha_ini_mes = dateadd(mm, datediff(mm, 0, @w_fecha_ing), 0)
select @w_fecha_fin_mes = convert(datetime,dateadd(s,-1,dateadd(mm, datediff(m,0,@w_fecha_ing)+1,0)),103)
select @w_fecha_fin_mes_aux = convert(varchar,@w_fecha_fin_mes,103)
select @w_fecha_fin_mes_habil = convert(datetime, @w_fecha_fin_mes_aux,103)

while exists(select 1 from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_nacional
               and df_fecha  = @w_fecha_fin_mes_habil ) 
begin          
    select @w_fecha_fin_mes_habil = dateadd(day,-1,@w_fecha_fin_mes_habil)
end

print 'ini_mes: '+ convert(VARCHAR(30),@w_fecha_ini_mes) + 
      '---fin_mes_habil: ' + convert(VARCHAR(30), @w_fecha_fin_mes_habil) + 
      '---fin_mes: ' + convert(VARCHAR(30), @w_fecha_fin_mes)

----------------------------------------------------PRIMERA VALIDACION
select banco = do_banco
  into #dato_operacion
  from cob_conta_super..sb_dato_operacion
 where do_fecha = @w_fecha_fin_mes_habil

----------------------------------------------------CONSULTA
select t_clienteId = 0, 
       t_buc = convert(varchar (30), ''),
       t_banco = dc_banco, 
       t_interes_devengado_exigible = sum(dc_int_acum), 
       t_monto_iva = sum(dc_iva_int_acum), 
       t_anio_facturacion = convert(varchar(4),year(dc_fecha)),
       t_mes_facturacion = case when convert(varchar(2),month(dc_fecha)) < 10--convert(VARCHAR,dc_fecha,103) 
	                          then '0' + convert(varchar(2),month(dc_fecha))
							  else convert(varchar(2),month(dc_fecha)) END,
	   t_nombre_archivo = convert(varchar (255), ''),
	   t_procesado = 'N',
	   t_fecha_generacion_archivo = '01/01/1900'
 into #rubros	   
 from cob_conta_super..sb_dato_cuota_pry, #dato_operacion
where dc_fecha = @w_fecha_fin_mes_habil--'12/31/2018' -- dia ultimo hbail de fin de mes
  and dc_fecha_vto between @w_fecha_ini_mes and @w_fecha_fin_mes--between '12/01/2018' and '12/31/2018'
  and dc_banco = banco
group by dc_banco, dc_fecha

update #rubros
   set t_clienteId = op_cliente
  from cob_cartera..ca_operacion
 where t_banco = op_banco

update #rubros
   set t_buc = en_banco
  from cobis..cl_ente
 where t_clienteId = en_ente

delete sb_info_gen_xml_refacturacion 
  from #rubros
 where anio_facturacion = t_anio_facturacion
   and mes_facturacion = t_mes_facturacion

----------------------------------------------------INSERTAR A TABLA DEFINITIVA
insert into sb_info_gen_xml_refacturacion
select *
from #rubros ORDER BY t_clienteId, t_banco, t_buc

drop table #rubros
return 0
go
